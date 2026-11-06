Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794005650;
	b=AMO2PIsItwWr7juTwFJ+w/Klk4zoW1lM0AGY7tu6nd0D+zi+DTe1M/F+O+zM8RelBZEZ
	 yv9guJAdrL+0xBkOPrXAxMs7vacAP9p3ZhOuECV8lFBej8UBbRqFKa7jsnrpjpwKGflNC
	 683ZsIcwUbllZ5iarA2AthRjHtqvda2n+CzmON0HJVAiM2LE9yoLq62hk0eETiXnaeHU6
	 DHZHzP5AVHnn+91Tl8lU1Fiw9dzrYvoMeKxGytVcciDLeBNkn4zFlZUBD5jU2CtXW4osx
	 NQztTCaNAmF6re0VkY4TcxD3XUZbxbBhKSBrGWLU8oIYNyg4CcZJhwXM6fUYAQSzFdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794005650;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fbPspms2sS3O5/nUsYayzrSPxne2ni7ynNvNA4DD4fo=;
	b=CFMHFfuWeoJMrTtMU36u/DX2VCcnHXuib4WlOLogwDcYHWZKTFZAcbBoMJUf/RyquNH/
	 HMofc8YVrq0I58V9jQnlRVGsToN5HPnhhZ+0wPcMqBMcVuUxBq5BzqLxwrIq8pCCd6ZMC
	 UPALbZbi3qKZs8C0YlZBox3VNTfkmvgRm1NklFFYtDM42jysTJ5ZGNuNpexQutAUboikk
	 3ehFIbuI1jCCP1sIHXJY5o7dcyCBoK0h/elYRQI+K8e7ETql52viUV930ZIYee8TlRm40
	 LpfrcAjTJBnwMkhS2oFNOKu/wLYIR5U6k7kAveZ4P9BDQexvwq2EVWUDmPoCu6pz2+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0M7AHNmA;
	arc=none smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A735D606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 22:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A735D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0M7AHNmA
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b1b13e09ffso1424320a12.3
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 14:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794005648; x=1794610448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fbPspms2sS3O5/nUsYayzrSPxne2ni7ynNvNA4DD4fo=;
        b=0M7AHNmAt0fUBLx8XdzysHSARdvqRt9HK0sAIYFVEZW4+8tfz+wB4r1CWNhp87oKnb
         H8xiX8SNlsxG1iWOQCqbnu12N51XMnkNrw3H2fd9fMY/3HUvpUv/afJ6UnjUP1emVk/f
         HKmLzR6g9vzac1S660i6wJot727gk/SKnPKDLspcMM6+zTNeB01Yhi3N+J84GQLIFGkG
         XCe7A4UY2gW7be/cx/7RQyiaGWZ8cwezd30gp9i03f7lD3mKIEvHq7+owprtxJqH0Zv8
         IHKiw6uNfjUWH1fpmNZC2STvlbv2j90un6HauQeqbzpGfl/S63fT2x5kbXrG8Gbltw1k
         HOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794005648; x=1794610448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fbPspms2sS3O5/nUsYayzrSPxne2ni7ynNvNA4DD4fo=;
        b=Cb2dMi2HN0wjQ8d9SDDyDmvlYilQ9Ejsx7nvVWWQuKhpMEvW1XNE2rnAHJ5dciB95z
         9sOth7v4nEinDNAIBIVqQ0/xxKxjSV1eJfphihVTbpV3qnVnKAGmo86coHUpTMwbiQNW
         +eZvvWfL6n8loUMxwM3abVeqeXulIQjLZVzm9ZQiqelicUt2kf9gkyKni3CJfDhD8vz8
         kxWmGMbm1vCmhOHyOqdZ9lkI3G9wWyX2x8qclsF9d2QmFXQguGFRbmKi2CLmDdHqpHe3
         B1mZU+2ee8m+ZfL43eBFr/GplTiJIfFIgdZSS7jJDUppehLn8vdJd6Sz0aMD48V8R8/N
         a8Jw==
X-Forwarded-Encrypted: i=1; AL+hErFkiwx22pB6Bq5f2nUXyc0kA7gu1B35O76EM4F613a0QMVs4MSFcjSql516w7NvLYV5EvWFvCw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8SCPxF0EufmTHZGzg+PgQYcQjsTV5SnZYWTgPskHi3Nq5ZwHl1
	E6qa8HzOS6+K4mjB2Zof18sQ2Ofpe77sKRNiybA0NhGuIGVmPbiooxZb
X-Gm-Gg: AYBFou00hLshxXuV9Axgt9UkRuVi9vHB+/jl/hkdVFlmk69uyurTUBESKtq2kgxV6L6
	Z04xRFDwmFHD1HFgcQlltqcAAVeWWEJKDrJqkyp+ESwRZJfGr16aP43fdfhIAFvMP8175gWm7Ud
	VRiAnwWWKSr+xqBlKs0l4OMuIY88sIW2uQ/AjIEwQxsziki93A1XtAOLpd9AoWymu8iwSoarSNg
	Pe1s+B4Vjooezi2/OumH8WaPjqHGNTZxI2hx0N/kuYqeV3ufYClyj+rShhgHuwl7JLP9AUsgEQl
	m8tNsNBCpA28kvSH+TIxF3lcKf4x3wY4+jGMGV9rvaGnIafoXdWnpdDEhfuiwT+iRVAEWKtPXFo
	DC2Ri9/n/VX4w8/4Q/R4+itlayQT7rqOEzVzGXFbdmld2X+IVIDO5eJz++nTxlZalOiRUul7XUz
	ezq7osjWtipf/AKKwCdpsbVysNjWid2Dhkf1WMxLOMY6cNYFfNptkT79jRukiALGiPgtuvjRwaQ
	74DEMSEVkr/45EVc/e8xjkM14G17IbCX/qwtGE/znX+FM9dHY8oGYsEq/WfIjeRY0h3i06peq64
	9djPDMFndY3k5maxu2rFub4VmQBy27BtEIJFpK2amyAdQMrhhC4FEXOVTVTu8VDPW+JKlPJNkym
	3eaxzUxPTQkCO8tI23Yy32RGLUnrd/DjN7g==
X-Received: by 2002:a05:6402:5514:b0:6b5:8200:5008 with SMTP id 4fb4d7f45d1cf-6b597838b71mr2795992a12.45.1794005647881;
        Fri, 06 Nov 2026 14:54:07 -0800 (PST)
Received: from CCM-PC (83-233-221-133.cust.bredband2.com. [83.233.221.133])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b664b165e9sm1095181a12.29.2026.11.06.14.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 14:54:07 -0800 (PST)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Stanislaw Pal <kuncy7@gmail.com>,
	netdev@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org,
	Ziyang Huang <hzyitc@outlook.com>
Subject: Re: [PATCH net-next v8 1/2] net: dsa: qca8k: let regmap serialize register access
Date: Fri,  6 Nov 2026 23:54:02 +0100
Message-ID: <20261106225403.272212-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <6aee175b.f01aa0c8.37eba4.18ea@mx.google.com>
References: <20261104120130.48455-1-yongzhao.derek@gmail.com>
 <20261104120130.48455-2-yongzhao.derek@gmail.com>
 <6aca850a-ef67-4451-aaf2-977be884d1b0@lunn.ch>
 <6aee175b.f01aa0c8.37eba4.18ea@mx.google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ansuel,=0D
=0D
On Fri, Nov 06, 2026 at 07:07:19PM +0100, Christian Marangi wrote:=0D
> Operation of the LED and on the port have their own dedicated register pe=
r=0D
> port and for shared stuff, there is a dedicated mutex for it.=0D
>=0D
> So I'm not sure what case this patch is fixing...=0D
=0D
Stanislaw has walked through the regmap path. I can add a reproduction=0D
of it in which the two accesses read different registers.=0D
=0D
It is a local KUnit test on UML. It builds qca8k-8xxx.c with the real=0D
regmap_config, register callbacks, PCS and MTU code against the real=0D
regmap core; only the MDIO bus below the driver is a fake register=0D
file. The test stops one access inside its MDIO read and resumes it=0D
once a second access has started and blocked, so the second access runs=0D
between the first one's ->read() callback and its parse_val().=0D
=0D
With two qca8k_pcs_get_state() calls, for port 6 and port 0, each=0D
reading its own PORT_STATUS register, port 6 returns port 0's link=0D
state. Separate registers do not help, because both reads format the=0D
register and return the value through the one map->work_buf.=0D
=0D
A second case runs the MTU code against a PCS poll. The PORT_STATUS=0D
value that 2/2 saves is replaced, and MAX_FRAME_SIZE is written while a=0D
CPU MAC is enabled. 2/2 relies on 1/2 for this, because readers such as=0D
the PCS poll do not take its new mutex.=0D
=0D
On net-next, both cases fail with only 2/2 applied and pass with 1/2=0D
added.=0D
=0D
The limits: the test forces the interleaving (a gate in the fake bus=0D
and a SCHED_FIFO thread on a single-CPU UML kernel), it covers only the=0D
MDIO path, not the management frames, and I have not seen the=0D
corruption on hardware. The test calls qca8k_pcs_get_state() directly,=0D
so it does not show that two PCS polls meet on a given board; the=0D
callers that can meet without rtnl are the ones Stanislaw listed.=0D
=0D
The test is not part of the series. I can post it if that helps.=0D
=0D
If this answers what the patch fixes, I would keep 1/2 as is in v9 and=0D
add the two-reader case to its commit message. Would you rather see a=0D
different fix?=0D
=0D
Thanks,=0D
Yongzhao Chen=0D
