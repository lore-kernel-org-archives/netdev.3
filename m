Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA8C4B1D19
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 08:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719636; cv=none; b=HCElQwBrIa9rUTp4N0nzkEgL4aLCJPCecp3LUef5pHDTjClghuGbWsxrckq8HgaO74sDNHckWGwryN+nYC+h5TYEQq/y3imkE1HzsCasQa6iZBH67VkqO95yFBrEnYve7azj4oNbP+ZV1vBxrektYEfPqW0aMZe8IDujg7679Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719636; c=relaxed/simple;
	bh=WQreecELN5CRsfsxuPNhLWDBHIqw9SnFoDssMj6GbPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLiV7DI5LIF41kAnvCvPEmTD7OrF3bTnW6XKFM2Z4awCaerJMw17henf4po/GIY8gKzQF+9R2F0iOxTZE88WCggqQgRLQMWyFKk/AigCxrhDqUR5BsZbRXWFpWDdxuq5gTiDhn5iVZBG3doS2inq2Bku/SHcyJV4zrLt1lXahps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=QsPeG6S4; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="QsPeG6S4"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d37b5so2839935e9.2
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 01:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1789719632; x=1790324432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vShbw/2lgHNba8hI1FFhUDrshd08XnAEdzVSO/hXIgc=;
        b=QsPeG6S4Twg6OmFvdbow1ntr/c4yqC5lR/MocwqHl6OQoYxkBSOmZNsRmLC+Ki6pew
         5RtSFNQmUTMrr9Qcr+TG6JKtCpJgZRQEWADgX84T4Ys9xYfQ2D8Qe+PS7JGGe8Y63lB0
         dz++BTCaXhdub1mqCu+Y/4RSYBzoJFVqg4tNEgwaBsblhU+oA+flEHycsUy6d9SBx/FE
         /2/mBpoT7iy4ixkHV/koA7qsAkj6VE7FO17BFmOGXyMJ3rAKWebBqvIMyPj5XU7hymgo
         Eppqlh9nlEpl1pCNhnXA9lAoCMpg12HYlnnuC7Y9maRszAWeP0VNo/QYHYCxkm+7VATP
         b+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789719632; x=1790324432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vShbw/2lgHNba8hI1FFhUDrshd08XnAEdzVSO/hXIgc=;
        b=JqLg6FyfzQPlx2KyYWKfLcfOfa0X0zihhZ3q01AN2uq3I97Rc4i3Hw5Qau+o3p1Jq1
         B9lY/spxqz3QEU84+lTCpt3fj3Kfk2du2nlJG5p+KELawpmcqE0PYQ07PF5cTDHiYg4l
         O6ZILdDIoVCjk3J2U6saUeZRchS2ZPK5MLtyiSpuwvvSTKWSrok0OBEJpy3rF6dLqNM4
         oN20kV1tIwNhduXhVSLGpsCaLkCISF8Y8TkzuQZaq+4T7o6fc1Vb0r1eNLAHOMywK/ZH
         hMndbty46kNvKzhk7G7/Y1ywpyIpFLSkMMw0zDl3prc+/+X5p2aGyaeJS5FCMnWCxKCA
         txyg==
X-Gm-Message-State: AFuF++nd0w0mr+UIzu45zElm72VsAWsk7XABXXfi2uhfpeCpGgPzTk76
	qA2ZSqDFVX/AetgMSvPz2YK/lqIMwktcQZaexn7ojsFwdwbuau/yzRGUw4ZEKJ3bzrE=
X-Gm-Gg: AYBFou3Ve8bFuQHjASWprMXaJEM1tc16VSfA1+uA2aEeUelp7e0pz34Zd/8XOmU4/JL
	OlcrkT0Y2MjYHFJv03Yz1Taj6DwHU59vXTOgUAFScicnf6B3kYIZj2a8QL2pkZm1It556y3vvpq
	LB8B7TfQdI1/228RZVpXJAoKx3JdizRMM713nV8tMV8GHU5+UknGswwF2Yc28oyjaYeWdciMMKZ
	dgFVqFQFy/B8lp7hzETPniH0Lvj3hPs3gmbPR7ccXriDypSR2i6AK0/oUamS1xMfK63J4sZUxOE
	PBmh/2KKbgJ7fOOJX7jcupyPQEmo3dbDwPxwZmysmJSkVzaNiIhqL1w5THBJdyVDODMsmQL52vq
	Arwn9UdZPLiVSzfdeH0LB0xjk+No5jGetouvYbwuw3AlrWL+FcMxjWEb6OqWeT/zRRFdv6YO3Jc
	SwaTIbmwbD0R7F6NC3ECvEGMbRnXIyztlnE9vPJWx2bePc/PDkzA==
X-Received: by 2002:a05:600c:4e50:b0:49c:ee20:e787 with SMTP id 5b1f17b1804b1-49fc566443emr45154215e9.1.1789719632274;
        Fri, 18 Sep 2026 01:20:32 -0700 (PDT)
Received: from remote-01 ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd2160c2sm143028025e9.6.2026.09.18.01.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 01:20:31 -0700 (PDT)
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
Subject: Re: [PATCH net v8 1/4] net: usb: lan78xx: register the PHY interrupt with the MDIO bus
Date: Fri, 18 Sep 2026 11:20:29 +0300
Message-ID: <20260918082029.2697643-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <df5d4af1-a86a-4820-9aeb-b1449a60f37e@lunn.ch>
References: <20260918015029.2518425-1-f@lex.la> <20260918015029.2518425-2-f@lex.la> <df5d4af1-a86a-4820-9aeb-b1449a60f37e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > +	phydev->irq = dev->mdiobus->irq[phydev->mdio.addr];
>
> This line is redundant, given how phylib works.

It is once the table is filled before the bus is registered, and here
it is not yet: this patch writes the table in lan78xx_phy_init(), after
the scan, so phy_device_create() had already seeded phydev->irq from a
table that still read PHY_POLL.

The number is known before the bus exists, lan78xx_setup_irq_domain()
runs ahead of lan78xx_mdio_init(), so v9 fills the table there, before
of_mdiobus_register(), and drops this assignment together with the
if/else above it. On a 7801 the PHY address is not known until the scan,
so every entry gets the number, the way mdio-moxart does it. A
devicetree mdio node still wins: fwnode_mdio writes both fields after
the device is created.

> >  	netdev_dbg(dev->net, "phydev->irq = %d\n", phydev->irq);
>
> So maybe change this line?

It goes too. phy_attached_print() reports the irq at connect.
