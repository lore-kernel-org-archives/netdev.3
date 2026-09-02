Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263251FC110
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 04:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788323477; cv=pass; b=QJvZYhMSzDZQmxUJyU8t7wRAO0XtjNy5DJKkYekl4Gad6utNUb0uzf0GwAzf0+k5VqFPNzRnuYvytkqDReFZT+Xn5v0B2ORqsntdSeyWpV6tvGWaRZogm9Vy2p0xiZ5rwE+VZnsNJ8bmQuiZp7OYGJ5xYFcd/f0Wdcy8zJtdUkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788323477; c=relaxed/simple;
	bh=OAPlCfRou+I8iHAkd6NTAxqB5OJwBkgP5BUJDerN+qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oaClguEjb/0NOM1lct1a+J+b32aWyd1WM/PPgliBIYOHlbUlzpvb4g5vc/AoJbjLJE2QkHx2Yq7BqJ4BXSuCqBRWLvj0Aedv10L3Gnyebu7CgZlNGuZ8728zUPRTW3dUGTkyaI0zBF8fP/qG/UfUeTWkwIGAh8bW5/SzotWzUo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSEm0yQ2; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSEm0yQ2"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c250c6a6a9aso81185666b.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 21:31:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788323474; cv=none;
        d=google.com; s=arc-20260327;
        b=OyZpivVywN75nVlR9XiblZnOtI8RFNnyYfpC6Kjv8fwcchvNjKAScUzQR+VaUWvQem
         iZZXQLycTzRDLa3nkXF7mJ1j4D/qoIFwPDGMrcTcNUGWy2+LF5S1krAatmVhhZXQkVhX
         pBaMkvDKNobsyhJAEjbZO2L7JcjAr931+2aV+iD02tEV+vcyvrb5Wn3vqddhwmcA1ycV
         D92mv6nlw1c3eiLvP9xNeoGZ4YlTte5lY/vE/5r/TyadkV0lqfscVcFGygA61eCLT/Q5
         TPEJqpNCg2n8agCpJGWR7AikDKyc7KRucGN0+DaFETD3d2kHyhrulh2xogrUB8fMGLSf
         cIMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OAPlCfRou+I8iHAkd6NTAxqB5OJwBkgP5BUJDerN+qk=;
        fh=MtNgM0AfpRSABdqDbrb4h4Tr329YbQFy53v8S8Toqc4=;
        b=Rii3B39sbUOdXslYHX9UG8yFCAwCYfRJEDl61kU5vkEN0SDxgGGUAf3Q06Po/+R+eP
         7ALq2eg7+ljXOYrOMe3h8Ev45OzXlqGakAr6VMHi2/oYtTMF5ur7d6D8fRGpDvvqvWoK
         hShFllp2U5ooNJS969t4fuTWCaB8wJu0XfxfP/h90xTFzcDnufk7Eb5oNIFHfh/gdkta
         vWbus7g9fDwb8CoYtkCTtR3VTvXqYErjfh6RejHXihhXxlZym8Bawe1nceOySnCc/Ea0
         iHFYi9I/i1pIxInUHNmDnarG8xdRhJFmMliP8JB6yhP5pCYvazp3gfvums4DIsH2x2eJ
         mcSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788323474; x=1788928274; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OAPlCfRou+I8iHAkd6NTAxqB5OJwBkgP5BUJDerN+qk=;
        b=PSEm0yQ2gAPtjRiczG/bTxkLqTkwupCZnQpIbHQDOF/Hpunlzs2I3Q43a3q7kJDz6i
         7xX0957rYt0vOayQZagJfzUbaXLt+Frf/aN+N2/KPHayyInoxCXuBOVb6R6CugFqGS2c
         pBKUpTE6wn6XbeSimiOWzFGNIxiAI6oECj4IC/dGKBeTmID+Dn1+R3bV2hqjA0Z0tpAA
         oh7sYQckRim+TpxRaZKnrYFD9EWZW+Gj6YGbb7Qec6PfJV8d3IjYXz9pvHXv+ffSbTBC
         zgddjky1njFxlOlRBXGzh78Wa0gGyWmwWMh545FRHZdoW+kpEFdcRdkvQXGO0DmX4fAu
         g//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788323474; x=1788928274;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OAPlCfRou+I8iHAkd6NTAxqB5OJwBkgP5BUJDerN+qk=;
        b=dNNpZOaUGtdbZaikByNkRG12/H0m2JpxTN1ftw6q7uC/qbyitn3ohYleXDJO2LQvy0
         w7/FJ4B67qDxihgy8Y6eDrIWJJgtTz0ajf0bnnwu8FTCQkfF6uhaoI9ZxHu+MI+m4Mr8
         3fsnNbYJ3m4edYIzqImWLT7pvIcrNQJYIetPiTTOTC8aWch9E6wsYhI6kbd8mbJG7O2Z
         JJ+JLRdJnss59VbTHK+8lVxGy1dejjWo6kW4OV+TMs1KPiKDZ9o4fg1382m3oue7HG1U
         4WmDmpoLtSLd7n6maXN1EQpdIQLjdqU8zYb+lUvhu+ucIuMWSiyapljm4fhsi2BPLe5o
         UjPQ==
X-Forwarded-Encrypted: i=1; AHgh+RoXBLQkc6pyRmunI4boDtliC4dpVMexDMdrYevYJGc6B8zpPtWXiR5gNmw43zcFM3jlsC/ikv4=@vger.kernel.org
X-Gm-Message-State: AFuF++lOGq/erqIj1h5OeBYXUNIqiaug2jKog1YrCcCP8lB4j6rLcE+q
	9T02cA1N8SSr8bz03X6mo/fwObxgeHh+vRaRvTd+ketyVGVXC0dpxUR2puM9KfKFSh3ulMU11/j
	qhayO0ptpV0F5bZIKB5C2qRoUNC4m7HhdwjsT2Cf9MnQ3
X-Gm-Gg: AYBFou1gMF6ZLTvXt+iH1J6Xdh3+gUtWKTN7G43qmpdna3cKkO84dNcuIzJc9FSR5Ek
	SwbHKwT6YNvtdyqDXqlQxl9yuKDZ+Ybr52mhbRJP10vlNLEt5MGhTthRV8NTBB4wS5zP/K8X6QY
	p+5KSQy0MLheoo215fszm7nrid5oRMFLD1CHUsaFj5NQ3BxN5ALHjwK4bEVEwc/auM7oCADPyLw
	/Ui2sJJLlhMNP0pbRZ6ZvtniRxkvVmtelCGBc6wDWTJBwLjYlJfcC8JLwnKQAwm/lTgDupqkT7o
	yGBDGsI8oeDHXZWQDKLZ7FYvSnq5EJ+0FMqJZyyeDyTY4g==
X-Received: by 2002:a17:907:d21:b0:c12:b2db:873d with SMTP id
 a640c23a62f3a-c25d526e682mr95377266b.5.1788323474104; Tue, 01 Sep 2026
 21:31:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813082247.31499-1-running910@gmail.com> <20260814174212.GS265046@horms.kernel.org>
In-Reply-To: <20260814174212.GS265046@horms.kernel.org>
From: Zhixing Chen <running910@gmail.com>
Date: Wed, 2 Sep 2026 12:31:02 +0800
X-Gm-Features: AcwNN1Vl7pBwgvFpX5wyxczRcTxqW947VlIcoxJ0K_4x4qTM6GrVaJ2eJQl0T4A
Message-ID: <CAMyuFdVDdEC0nwphSS+g6wqDVRASrPb3hT96-RaPxeHwvKxfdQ@mail.gmail.com>
Subject: Re: [PATCH net-next] pptp: validate payload length before parsing PPP fields
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Simon,

Thanks a lot for taking the time to review this, and sorry for the late
reply.

Your concern makes sense. In v1 I used payload_len as the bound, but
pptp_rcv_core() does not trim the skb to headersize + payload_len, so that
can change the handling of packets with an under-reported payload length.

I have sent v2 using the available skb payload length instead, and also
pull the required bytes into the linear area before dereferencing them.

Thanks again,
Zhixing
