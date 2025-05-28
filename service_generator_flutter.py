import os


def convert_to_camel_case(s):
    # Split the string by underscores
    words = s.split('_')
    # Capitalize the first letter of each word and join them
    return ''.join(word.capitalize() for word in words)


def modify_api_url_file(root_folder, name_service):
    upper_case_name = convert_to_camel_case(name_service)
    # التراجع إلى المجلد الأب
    parent_folder = os.path.dirname(root_folder)

    # الدخول إلى مجلد core
    core_folder = os.path.join(parent_folder, "core")

    # الدخول إلى مجلد api_manager
    api_manager_folder = os.path.join(core_folder, "api_manager")

    # البحث عن ملف api_url.dart
    api_url_file_path = os.path.join(api_manager_folder, "api_url.dart")

    # التحقق مما إذا كان الملف موجودًا
    if os.path.isfile(api_url_file_path):
        # قراءة محتويات الملف
        with open(api_url_file_path, "r") as file:
            lines = file.readlines()

        # تعديل الملف بناءً على الشروط المحددة
        for i, line in enumerate(lines):
            if "class GetUrl {" in line:
                lines.insert(i + 1, f"  static const {name_service} = 'NON/Get';\n")
            elif "class PostUrl {" in line:
                lines.insert(i + 1, f"  static const {name_service}s = 'NON/GetAll';\n")
                lines.insert(
                    i + 2, f"  static const create{upper_case_name} = 'NON/Add';\n"
                )
            elif "class PutUrl {" in line:
                lines.insert(
                    i + 1, f"  static const update{upper_case_name} = 'NON/Update';\n"
                )
            elif "class DeleteUrl {" in line:  # Assuming you meant 'class DeleteUrl {'
                lines.insert(
                    i + 1, f"  static const delete{upper_case_name} = 'NON/Delete';\n"
                )

        # كتابة المحتويات المعدلة مرة أخرى إلى الملف
        with open(api_url_file_path, "w") as file:
            file.writelines(lines)

        print("تم تعديل ملف api_url.dart بنجاح.")
    else:
        print("ملف api_url.dart غير موجود.")


def modify_injection_file(root_folder, name_project, name_service):
    upper_case_name = convert_to_camel_case(name_service)

    # التراجع إلى المجلد الأب
    parent_folder = os.path.dirname(root_folder)

    # البحث عن مجلد core
    core_folder = os.path.join(parent_folder, "core")

    # التحقق مما إذا كان مجلد core موجودًا
    if os.path.isdir(core_folder):
        # البحث عن مجلد injection داخل core
        injection_folder = os.path.join(core_folder, "injection")

        # التحقق مما إذا كان مجلد injection موجودًا
        if os.path.isdir(injection_folder):
            # البحث عن ملف injection_container.dart
            injection_file_path = os.path.join(
                injection_folder, "injection_container.dart"
            )

            # التحقق مما إذا كان الملف موجودًا
            if os.path.isfile(injection_file_path):
                # قراءة محتويات الملف
                with open(injection_file_path, "r") as file:
                    lines = file.readlines()

                # إضافة السطر في أول الملف
                import_statements = f"""\
import 'package:{name_project}/features/{name_service}/bloc/create_{name_service}_cubit/create_{name_service}_cubit.dart';
import 'package:{name_project}/features/{name_service}/bloc/delete_{name_service}_cubit/delete_{name_service}_cubit.dart';
import 'package:{name_project}/features/{name_service}/bloc/{name_service}_cubit/{name_service}_cubit.dart';
import 'package:{name_project}/features/{name_service}/bloc/{name_service}s_cubit/{name_service}s_cubit.dart';
"""
                lines.insert(0, import_statements)

                # البحث عن "Future<void> init() async {"
                for i, line in enumerate(lines):
                    if "Future<void> init() async {" in line:
                        # إضافة السطر بعد السطر الذي يحتوي على "Future<void> init() async {"
                        registration_code = f"""\
  //region {upper_case_name}
  sl.registerFactory(() => Create{upper_case_name}Cubit());
  sl.registerFactory(() => Delete{upper_case_name}Cubit());
  sl.registerFactory(() => {upper_case_name}Cubit());
  sl.registerFactory(() => {upper_case_name}sCubit());
  //endregion
"""
                        lines.insert(i + 1, registration_code)
                        break

                # كتابة المحتويات المعدلة مرة أخرى إلى الملف
                with open(injection_file_path, "w") as file:
                    file.writelines(lines)

                print("تم تعديل الملف بنجاح.")
            else:
                print("ملف injection_container.dart غير موجود.")
        else:
            print("مجلد injection غير موجود داخل core.")
    else:
        print("مجلد core غير موجود.")


def find_pubspec_name(root_folder):
    # Go back two levels to the parent folder
    grandparent_folder = os.path.dirname(os.path.dirname(root_folder))

    # Construct the path to pubspec.yaml
    pubspec_path = os.path.join(grandparent_folder, "pubspec.yaml")

    # Check if the file exists
    if os.path.isfile(pubspec_path):
        with open(pubspec_path, "r") as file:
            for line in file:
                # Check if the line starts with 'name:'
                if line.startswith("name:"):
                    # Extract and return the name value
                    name_value = line.split(":", 1)[1].strip()
                    return name_value

    return None  # Return None if not found


def create_folders_and_files(root_folder, name_service, replacement_word):
    project_name_parm = find_pubspec_name(root_folder)
    modify_api_url_file(root_folder, name_service)
    modify_injection_file(root_folder, project_name_parm, name_service)
    # Create the main service folder
    service_folder = os.path.join(root_folder, name_service)
    os.makedirs(service_folder, exist_ok=True)

    # Create subfolders: bloc, data, and ui
    bloc_folder = os.path.join(service_folder, "bloc")
    data_folder = os.path.join(service_folder, "data")
    ui_folder = os.path.join(service_folder, "ui")

    os.makedirs(bloc_folder, exist_ok=True)
    os.makedirs(data_folder, exist_ok=True)
    os.makedirs(ui_folder, exist_ok=True)

    # Define templates
    upper_case_name = convert_to_camel_case(replacement_word)

    # 1. Create {upper_case_name} Cubit and State {upper_case_name}lates
    create_cubit_template =""

    create_state_template =""

    # 2. Delete {upper_case_name} Cubit and State {upper_case_name}lates
    delete_cubit_template =""

    delete_state_template =""

    # 3. {upper_case_name} Cubit and State {upper_case_name}lates
    temp_cubit_template =""

    temp_state_template =""

    # 4. {upper_case_name}s Cubit and State {upper_case_name}lates
    temps_cubit_template =""

    temps_state_template =""

    # Create folders in bloc
    bloc_sub_folders = [
        f"create_{name_service}_cubit",
        f"delete_{name_service}_cubit",
        f"{name_service}_cubit",
        f"{name_service}s_cubit",
    ]

    for sub_folder in bloc_sub_folders:
        sub_folder_path = os.path.join(bloc_folder, sub_folder)
        os.makedirs(sub_folder_path, exist_ok=True)

        # Create Dart files in each bloc folder with respective templates
        base_name = sub_folder.replace("_cubit", "")

        # Create _cubit.dart files
        if "create" in sub_folder:
            dart_content_cubit = (
                create_cubit_template  # .replace('{name_service}', name_service)
            )
            with open(
                    os.path.join(sub_folder_path, f"{base_name}_cubit.dart"), "w"
            ) as f:
                f.write(dart_content_cubit)

            dart_content_state = (
                create_state_template  # .replace('{name_service}', name_service)
            )
            with open(
                    os.path.join(sub_folder_path, f"{base_name}_state.dart"), "w"
            ) as f:
                f.write(dart_content_state)

        if "delete" in sub_folder:
            dart_content_cubit = (
                delete_cubit_template  # .replace('{name_service}', name_service)
            )
            with open(
                    os.path.join(sub_folder_path, f"{base_name}_cubit.dart"), "w"
            ) as f:
                f.write(dart_content_cubit)

            dart_content_state = (
                delete_state_template  # .replace('{name_service}', name_service)
            )
            with open(
                    os.path.join(sub_folder_path, f"{base_name}_state.dart"), "w"
            ) as f:
                f.write(dart_content_state)

        if f"{name_service}_cubit" == sub_folder:
            dart_content_cubit = (
                temp_cubit_template  # .replace('{name_service}', name_service)
            )
            with open(
                    os.path.join(sub_folder_path, f"{base_name}_cubit.dart"), "w"
            ) as f:
                f.write(dart_content_cubit)

            dart_content_state = (
                temp_state_template  # .replace('{name_service}', name_service)
            )
            with open(
                    os.path.join(sub_folder_path, f"{base_name}_state.dart"), "w"
            ) as f:
                f.write(dart_content_state)

        if f"{name_service}s_cubit" == sub_folder:
            dart_content_cubit = (
                temps_cubit_template  # .replace('{name_service}', name_service)
            )
            with open(
                    os.path.join(sub_folder_path, f"{base_name}_cubit.dart"), "w"
            ) as f:
                f.write(dart_content_cubit)

            dart_content_state = (
                temps_state_template  # .replace('{name_service}', name_service)
            )
            with open(
                    os.path.join(sub_folder_path, f"{base_name}_state.dart"), "w"
            ) as f:
                f.write(dart_content_state)

    # Create folders in data
    data_sub_folders = ["request", "response"]
    for sub_folder in data_sub_folders:
        os.makedirs(os.path.join(data_folder, sub_folder), exist_ok=True)

    response_file_path = os.path.join(
        data_folder, "response", f"{name_service}_response.dart"
    )

    response_template = ""

    with open(response_file_path, "w") as response_file:
        response_file.write(response_template)

    request_file_path = os.path.join(
        data_folder, "request", f"create_{name_service}_request.dart"
    )

    request_template = ""

    with open(request_file_path, "w") as request_file:
        request_file.write(request_template)

    # Create folders in ui
    ui_sub_folders = ["pages", "widgets"]
    for sub_folder in ui_sub_folders:
        os.makedirs(os.path.join(ui_folder, sub_folder), exist_ok=True)

    print(f"Folder structure created successfully under: {service_folder}")


if __name__ == "__main__":
    # Get user input for root folder and service name
    root_folder = input("Enter the root folder path: ")
    name_service = input("Enter the name of the service: ")

    create_folders_and_files(root_folder, name_service, name_service)
