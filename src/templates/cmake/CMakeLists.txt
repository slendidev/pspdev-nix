cmake_minimum_required(VERSION 3.11)

project(hello LANGUAGES CXX)

add_executable(${PROJECT_NAME} src/main.cpp)

target_link_libraries(${PROJECT_NAME} PRIVATE
	pspdebug
	pspdisplay
	pspge
)

create_pbp_file(
	TARGET ${PROJECT_NAME}
	ICON_PATH NULL
	BACKGROUND_PATH NULL
	PREVIEW_PATH NULL
	TITLE ${PROJECT_NAME}
	VERSION 01.00
)
