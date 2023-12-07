#!/bin/sh
# The project ShellNote primarily focuses on being a simple notepad application that allows the user to create notes and store them as text files in various folders. 

echo "Welcome to ShellNote an all in one notepad"

# Function to create a folder/directory
create_folder() {
    read -p "Enter folder name: " folder_name

    if [ -d "$folder_name" ]; then
        echo "Folder '$folder_name' already exists."
    else
        mkdir "$folder_name"
        echo "Folder '$folder_name' created successfully."
        cd "$folder_name" || exit  # Change directory to the newly created folder
        echo "Entered folder: $folder_name"
    fi
}

# Function to display a specific note in your current folder
view_note() {
    current_folder=$(pwd)
    echo "Current folder: $current_folder"
    echo "List of notes:"
    ls *.txt  # Display available notes for selection
    read -p "Enter the note you want to view: " note_name
    if [ -f "$note_name.txt" ]; then
	    echo "-------------'$note_name.txt' Context's--------------"
	    cat "$note_name.txt" 
    else
	    echo "Note '$note_name.txt' not found."
    fi
    
}

# Function to create a new note in the current folder
create_note() {
    current_folder=$(pwd)
    echo "Current folder: $current_folder"

    read -p "Enter note name: " note_name

    if [ -d "$current_folder" ]; then
	    timestamp=$(date)
	    echo "Note created on: $timestamp" > "$note_name.txt"
	    echo "---------Enter your note for '$note_name' (Ctrl+D to save):-----"
	    cat >> "$note_name.txt" 
        echo "Note '$note_name.txt' created successfully in '$current_folder'."
    else
        echo "Error: Unable to create note. Invalid or inaccessible folder."
    fi
}

# Function to rename a note in the current folder
rename_note() {
    current_folder=$(pwd)
    echo "Current folder: $current_folder"

    echo "List of notes:"
    ls *.txt  # Display available notes for selection

    read -p "Enter note to rename: " old_name

    if [ -f "$old_name.txt" ]; then
        read -p "Enter new name: " new_name

        mv "$old_name.txt" "$new_name.txt"
        echo "Note '$old_name.txt' renamed to '$new_name.txt' successfully."
    else
        echo "Note '$old_name.txt' not found."
    fi
}

# Function to delete a note in the current folder
delete_note() {
    current_folder=$(pwd)
    echo "Current folder: $current_folder"

    echo "List of notes:"
    ls *.txt  # Displays all notes in current folder

    read -p "Enter note to delete: " note_name

    if [ -f "$note_name.txt" ]; then
        rm "$note_name.txt"
        echo "Note '$note_name.txt' deleted successfully."
    else
        echo "Note '$note_name.txt' not found."
    fi
}

# Function for updating existing note in current folder
update_note() {
    current_folder=$(pwd)
    echo "Current folder: $current_folder"

    echo "List of notes:"
    ls *.txt #Displays all notes in current folder

    read -p "Enter the note you want to update: " note_name
    
    if [ -f "$note_name.txt" ]; then
	    timestamp=$(date)
            echo "Note updated on: $timestamp" > "$note_name.txt"
	    echo "-------Updating '$note_name.txt' (Ctrl+D to save changes):------"
	    cat >> "$note_name.txt" 
	    echo "Note '$note_name.txt' updated sucessfully."
    else
	    echo "Note '$note_name.txt' not found."
    fi
}

# Function to move a note to a different folder
move_note() {
    current_folder=$(pwd)
    echo "Current folder: $current_folder"

    echo "List of notes:"
    ls *.txt  # Display available notes for selection

    read -p "Enter note to move: " note_name

    echo "List of folders:"
    ls -d *

    if [ -f "$note_name.txt" ]; then
        
	     read -p "Enter destination folder: " destination_folder

        if [ -d "$destination_folder" ]; then
            mv "$note_name.txt" "$destination_folder/$note_name.txt"
            echo "Note '$note_name.txt' moved to '$destination_folder' successfully."
        else
            echo "Destination folder '$destination_folder' not found."
        fi
    else
	    echo "Note '$note_name.txt' not found."
    fi
}

# Function to switch to a different folder
switch_folder() {
    echo "List of folders:"
    ls -d *  # Display all folders
    read -p "Enter folder name: " folder_name

    if [ -d "$folder_name" ]; then
        cd "$folder_name" || exit  # Change directory to the entered folder
        echo "Entered folder: $folder_name"
    else
        echo "Folder '$folder_name' not found."
    fi
}


# Function to rename a folder in the current directory
rename_folder() {
    current_folder=$(pwd)
    echo "Current folder: $current_folder"

    echo "List of folders:"
    ls -d *  # Display available folders for selection

    read -p "Enter folder to rename: " old_folder

    if [ -d "$old_folder" ]; then
        read -p "Enter new folder name: " new_folder

        mv "$old_folder" "$new_folder"
        echo "Folder '$old_folder' renamed to '$new_folder' successfully."
    else
        echo "Folder '$old_folder' not found."
    fi
}

# Function for viewing all the folders in the current directory
view_folders() {
    echo "List of folders:"
    ls -d */  # Display all folders
}

# Function for deleting a folder 
delete_folder() {
    echo "List of folders:"
    ls -d * # Display all the folders

    read -p "Enter the folder you want to delete: " folder_name

    if [ -d "$folder_name" ]; then
	    rm -r "$folder_name"
	    echo "Folder '$folder_name' deleted successfully."
    else
	    echo "Folder '$folder_name' not found."
    fi

}


while true; do
    echo "Menu:"
    echo "1. Create Folder"
    echo "2. Switch Folder"
    echo "3. Create Note"
    echo "4. View Notes"
    echo "5. Update Note"
    echo "6. Rename Note"
    echo "7. Delete Note"
    echo "8. Move Note"
    echo "9. Rename Folder"
    echo "10. View All Folders"
    echo "11. Delete Folder"
    echo "12. Exit"

    read -p "Enter your choice: " choice

    case $choice in
        1) create_folder ;;
        2) switch_folder ;;
        3) create_note ;;
        4) view_note ;;
        5) update_note ;;
        6) rename_note ;;
        7) delete_note ;;
        8) move_note ;;
        9) rename_folder ;;
        10) view_folders ;;
        11) delete_folder ;;
        12) echo "Exiting the ShellNote. Goodbye!"; exit 0 ;;
        *) echo "Invalid choice. Please enter a number from the menu." ;;
    esac
done
