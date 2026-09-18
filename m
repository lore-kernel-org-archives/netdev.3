Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C9E4A6CF7
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 08:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719638; cv=none; b=e+xnfGSLxaeAh6bNlTzYVwwDiRO7s5BPJw5rH9iBIpAnqKbzCgWJFRYFOvY3WIreD+4LsmbXLDgcXoRMDDOC7YzkfdFiY2FZdEd/y2Hgusay3ECoJXefylZ82GJrMlmV4nzLQkX8fNCYP4It3ReVMMQ/L70LF2+//wRR0u9ZmUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719638; c=relaxed/simple;
	bh=1xmHYRYfu8OtSUWgblAltZ1bFJ3q1HsG+ndUjgkwz9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fObBoQglXTm++5RrE3asLTqKZG8/5RjLYaq2keYV1dbOnTsHD3c2V+AuvjhHC2oOlKuFmmiuqCu+Tv/UZFS6wQNx4nhdVqKCQNdx75esFD5SGWe9QL32IPzn2GBNZd/kl0cWAgtFCfShq2zjNGR0+wg7+UPrlFSd02nHBl3R7KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=MqTlVkAH; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="MqTlVkAH"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7d2bb404so1308415e9.1
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 01:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1789719635; x=1790324435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zyAJTSS0FYPcMnF0dBpTcj4/kVFflzNqQUPg7P0ugms=;
        b=MqTlVkAHV+vcGIyVV/gubrZD5cQb5ZO2NzDRgzd0pZay1bRLCXYHPs+awil6T+tRUX
         Yav2u6bd09J2OEMKwR2FzweIkBEIxg0x6HJxl1plhXk7I4Mu74F3rABYx+TDIFrr1+3N
         79X52T7qVy7lMSBR29GbeN4CY0EEPrUt289vUnrUMBseg3H5ibjhDS/Fk4Oi0Pz9Cuwp
         CsdopwJWmoEEHRqEK1FCf0ni5rV1fsVSPS8OuMok1ynSnR/KhVeYtrNrRlZ4+HjaO6kA
         5KDgwt+1PgUwvWgSod9e94aBTsHVkXHqaRCsfLcjzKTfsc3icyBmsTZ2EdCzy/4gL0aZ
         v3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789719635; x=1790324435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zyAJTSS0FYPcMnF0dBpTcj4/kVFflzNqQUPg7P0ugms=;
        b=Hd/nIZmzhBkOHHnuQMR7SMfUehheAr0cJpeMyFHUIZFKrIWemR4WJmZljyzxHM+3x3
         D1A7FBSVr5JlKL2WXq0lSL8NarRhJC+h6Xt09B4IGzOEgatFogo+5QspOQNeF9U+gXRM
         VL0BvoSO2CDQfcj7wgutxCWGQy5MKEwKvNT/ezB1yzB1AKOaAL84GRdJ5OGWqaABpROI
         gNsy10vRl095gNjaWMSb/ZLPEJCEU/Kkma4qs67ixeQlt4ONd0jxt+PH8BZueJH0RVuB
         zWANDPkFzjDv8qTv6saW2m1be+lTsCZMgyDFiqSpHXcEFO03zPE5Y0xVKJXEdtF+xA5i
         uYcw==
X-Gm-Message-State: AFuF++mG7uKUoil1lWodx84peIdsxr0WHcFsRKgyMeLzl0sB7c7ebAs8
	lnC5glFS/CwDPdyGmDHQntHAZZW0i5f0L9iKKx3d+9cBxDfPpLJq6FvEGsmyzOlfPM8=
X-Gm-Gg: AYBFou0HQHH4kc1IYofM6X6CB7klk1XXPYUIQkz5yEG0pZUfXy2htEdtWxKaFXqJsVM
	OY14MoSoqZ7v6xDd0r3Yg7GiLyEtJIv+z2vXPQiZ61NQ9vcwhW9cn+y0H7CBIDWxVX/jMjruh+S
	Iq9foCvysvyQfqch7IpWwXVet2YzG4PGI/8FSHZwUt3H7I6s5Slz4kpAutchacc2ZcTPV7FT/rO
	kWxVj28GNqgjW/0efv+4sqVMC+xMriY1PfMWzXYBvxaRxraXtzD/Sp+3fQig9N9S2Zqzn+GTv70
	zHPgr1zeSqi0Z50jUHfl4YFMYQbSCQ7Yl8dftEQfATSRfVl/cP/4qwAoIK8Nt7qyIdUEn3VzUzY
	59AVbPaNe1TUJwduuwu8rbRbpMDeGLcHx60og4lFTLihUCLWkmx2a8JAdCcOd3PnvY/siLv7Sla
	ePDxR6oIYvrffQn3/j6gbCAFx8pvLDGMu4Oce9fcKh/5EgHj6rNA==
X-Received: by 2002:a05:600c:1389:b0:49d:2936:8ad1 with SMTP id 5b1f17b1804b1-49fc4f71c7dmr23237335e9.1.1789719634695;
        Fri, 18 Sep 2026 01:20:34 -0700 (PDT)
Received: from remote-01 ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc8dde38fsm21914985e9.1.2026.09.18.01.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 01:20:34 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: andrew@lunn.ch
Cc: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	olteanv@gmail.com,
	Thangaraj.S@microchip.com,
	UNGLinuxDriver@microchip.com,
	steve.glendinning@shawell.net,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v8 2/4] net: usb: smsc95xx: register the PHY interrupt with the MDIO bus
Date: Fri, 18 Sep 2026 11:20:32 +0300
Message-ID: <20260918082032.2697732-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <6e14d6b7-2a5a-40e2-920e-fc69a6e85173@lunn.ch>
References: <20260918015029.2518425-1-f@lex.la> <20260918015029.2518425-3-f@lex.la> <6e14d6b7-2a5a-40e2-920e-fc69a6e85173@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > +	pdata->mdiobus->irq[pdata->phydev->mdio.addr] = phy_irq;
> >  	pdata->phydev->irq = phy_irq;
>
> Looking at just the information here it looks like this line can be
> deleted?

Yes, once the table is filled before mdiobus_register() instead of
after phy_find_first(): phy_device_create() seeds phydev->irq from the
table at scan time, and as written that still happens with PHY_POLL in
it. phy_irq exists before the bus is even allocated, so v9 moves the
fill ahead of the registration, for every address since the PHY's
address is not known until the scan, and deletes this line. Same shape
in 1/4.
