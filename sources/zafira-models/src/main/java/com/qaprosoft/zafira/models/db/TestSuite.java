package com.qaprosoft.zafira.models.db;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

@JsonInclude(Include.NON_NULL)
public class TestSuite extends AbstractEntity
{
	private static final long serialVersionUID = -1847933012610222160L;

	private String name;
	private String fileName;
	private String description;
	private User user = new User();

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public String getFileName()
	{
		return fileName;
	}

	public void setFileName(String fileName)
	{
		this.fileName = fileName;
	}

	public String getDescription()
	{
		return description;
	}

	public void setDescription(String description)
	{
		this.description = description;
	}

	public User getUser()
	{
		return user;
	}

	public void setUser(User user)
	{
		this.user = user;
	}
	
	@Override
	public boolean equals(Object obj)
	{
		return (obj != null && obj instanceof TestSuite && this.hashCode() == ((TestSuite)obj).hashCode());
	}
	
	@Override
	public int hashCode()
	{
		return (name + description + user.getId()).hashCode();
	}
}