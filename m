Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793796916;
	b=Qv+qYPX7UMdIL6QN6zdePZWE1gb+84I2ZqliRT/bvnDcucrwbGDWNw3wscbkYzfYgxJs
	 t2lGzBH+RrQgnl7DWyedxdoxbA7eXbdxAyVlUdq+4UGhU8UQTpYBnIm9AjIS/Y9Tq42hZ
	 JxHEg0Eva1LNNvtxCkY07iWOBBsvX6hZqUUgKOXWdFxp5EVcAS4msbPIaKaZgEvdAQSl+
	 r9JaKmy/vaBnPJqWqFi5h30gy55M24Uzc2O2fkpDqxyycA03hJRXCOzLMpmtMKZfpZL3u
	 ONh7LiNqmg2GB3kSRTH4KEaS/Wlo0ZHc8FTHLQwTVGMWeUxqrOpCeL8KPl+g7qpUI0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793796916;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Ullk1gSUOjFiId8wM/hEAChuzery1r2M6GlvL+3ThyA=;
	b=jy6fWaomqU4dfnYtWOY3HkHn69hFahhsGBH0Ssuu5NbvpRyxUU+5xZeLduScs9JzxcwI
	 Gx41FgtKPMaEwkhoU9uywcD302YzEEwHNlrNrr8I7XtUNI1fvtu4cJu3RCRsAcX+iAq//
	 G4QnRP4U5vIsC7j+WpLcapkx1mhWldgJjfV3M8vwAnTKB28bwzNLl+XOp2+k8KFSnlPvL
	 Zkkm5dbwHO2nvB1Zl36mdNNr+4dymN0oD+/i7FLfcgaBgXpJBxYeS7zMvW8zDDlyXUuba
	 SvSu7FJOrg3IcsnoUgXeFOkSRAIbbp1Z14YmIYMCK2qxR3e0+sesjm2nLU0+wwucb9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xUI0ybbz;
	arc=none smtp.remote-ip=74.125.225.134
Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B646A606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 12:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B646A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xUI0ybbz
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-4a1bc9520fdso1419355e9.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 04:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793796914; x=1794401714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ullk1gSUOjFiId8wM/hEAChuzery1r2M6GlvL+3ThyA=;
        b=xUI0ybbzYTbhInu8D379Df79kDfFwdSiP1liu3jX+MNCdSouhd5sSWeTGARNfXArr5
         srUmwsaIaT5AaQu9XGYB+8RufGFwt/n/JiPr6uObTcqeZP3IYw5Fo0nJ7VJNCcxrqOL/
         pVEB2623OjThdGbgr/0KY0EgcofWgoaSXXBcdHVM2GZt6DrUiwXuj269zRntaDHOfzt3
         qpkTEw3xYn6HNgLIOi/pFQsi0VcGftFTa1Qs5S8gJYWFRmsdZx3UwPiU7a3xFMBrRLf1
         34sHs9iU2CkSt2/HClvLpO13tPWw61n+zDYJ+R1WbXXLRSNZHhDCJ4i6XjY3Hb0dASYu
         Derw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793796914; x=1794401714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ullk1gSUOjFiId8wM/hEAChuzery1r2M6GlvL+3ThyA=;
        b=QNVfL45/EY+wqRMgHu7A3dhRMjSBID40PSNDrFTnySkmjtfeCMmXvZRkdHcyapu2TB
         sFdLNtjTm1j8ecWE8dwouT4eBPdR/NheV6MJ+XAA+2KnCMKfDVLOjwyxBePOzLlUy3VH
         03Tc/Cqe1bAe/96T65JFyga93yYCRHfegYc8jNjqxRQ28X6OCOKxWOEhVNDFxbbSOYi2
         WaZYhSZBY2EV97XUVwXhhSAOF9cZ8dJ4VaEOQVwJxVErd3dVG3cNVqwzh0UyHTpiTxGk
         l5WYBsf3xcVJkvn3sDig+OU9JM0I9lpi/psLu41JIrdeRDSt6LgI9YzKdv1be6y+365V
         I8iQ==
X-Gm-Message-State: APuU4Z8AYEjfW2sKuSh3ft20BZAxVN75OW3w4lL+Fhf5GF1DfFsTivMg
	sWHeo3pAfHP5wqImocSMndCBVBJV9Td0Xl5DeTt/nnMsExjBSYq4Kn8s
X-Gm-Gg: AYBFou3bA+RO39BZjKfaiH0ae0ifiBLglNTUR2O+PC28/2+7tlKkT+6879XuRleHsBp
	VVXb2EndzRRUQdvxkV7N+6nedGGBK4gYpFsTBjD08G/PBp07DyRFx0hDF2ZClPUL2QwsGuFqu/R
	k1dlTZVYA0hyPAnCy+FsUifvdNQuwRgihCuDot6tS8unlKKqkQJwLz0O6JshU8vJpLakL5uudlN
	2adOUxJjHZ5B7sy+5PYsuVTBBXpSKtRKYaAc4iGdx0EB8y+DNyl6UYqZoNinEeD7Lx1uOAADBSp
	cwHkqTAQWSAD70PL9uqbdJ51m28aYP9vz0nIvyph7lMtNruXdSkVkYzL9XssTQY1+Si6ScJ5pVu
	Y6wDHyJk84FAB1WSulT2rxx1X5LHkjMvS9qU1Uzt+GRNIv2tjPMyAempgTIhPGAOFKbMg92VxrP
	gVYw6+QsmYd3HOJenVJXh/T0HVpqowkHqKHAzL6i7E7qGXl2W5KH9TI95OPkWykjDraJFPrQ98L
	yvN+hwnsHbn8AApQx9J8RPt3KhPsA6lHrLNllLhoSXXQ9S716DFPH3hgPoT63El5kWeCA4u+I9K
	1LBuBRhkiGJ7XZh8zekmOz/D1UY/TXCQu1YOvJ3FtceOLUKrJVEo0i+erIWJ9Dm+6C3q8Q3xKlu
	3W4pDF3OFlYe5osDhM92ugbJqgBXYphJdIKAYz0kOGp76NmAvHzz3K6IL
X-Received: by 2002:a05:600c:8b61:b0:4a2:1398:dd05 with SMTP id 5b1f17b1804b1-4ac17752ee4mr338445795e9.16.1793796913931;
        Wed, 04 Nov 2026 04:55:13 -0800 (PST)
Received: from thi-server.fritz.box (dslb-092-076-089-226.092.076.pools.vodafone-ip.de. [92.76.89.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43cb2360dsm59330345e9.8.2026.11.04.04.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 04:55:13 -0800 (PST)
From: Thilo Zirnstein <thi.zirnstein@gmail.com>
To: linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thilo Zirnstein <thi.zirnstein@gmail.com>
Subject: [PATCH net v1 1/1] net: phylink: keep initial advertising settings
Date: Wed,  4 Nov 2026 13:55:09 +0100
Message-ID: <20261104125509.3221743-1-thi.zirnstein@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the net device is phylink based,
consists of a mac with a phy connected and the
mac driver does add the phy while the ndo_open callback,
initial advertising settings of the link may be overwritten
during phylink_bringup_phy.

The mode of action is as follows:

* The link was not up yet - no phy connected
* the user configures the advertisement of the interface
* the mac driver delegates the call to phylink_ethtool_ksettings_set
    * here we are not configuring the phy - it does not exist yet
* the user set up the interface
* the mac drivers calls phylink_connect_phy
    * calls phylink_bringup_phy
        * overwrites advertisement with
            * linkmode_copy(config.advertising, phy->advertising);
            * linkmode_copy(pl->link_config.advertising,
                config.advertising);

Connecting the phy while ndo_open callback seems to be a common pattern,
affected drivers are:

* macb
* r8169
* stmmac
* tn40xx

The advertising settings can be kept by using the intersection
of the phylink advert bits and the phy advert bits.

This was observed and tested on a
Xilinx Zyqnmp system with builtin macb ethernet interface.

Fixes: 9525ae83959b ("phylink: add phylink infrastructure")
Signed-off-by: Thilo Zirnstein <thi.zirnstein@gmail.com>
---
 drivers/net/phy/phylink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index e885da1c2831..145f181bc9d3 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2320,6 +2320,7 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 	pl->phy_state.duplex = DUPLEX_UNKNOWN;
 	pl->phy_state.rate_matching = RATE_MATCH_NONE;
 	linkmode_copy(pl->supported, supported);
+	linkmode_and(config.advertising, config.advertising, pl->link_config.advertising);
 	linkmode_copy(pl->link_config.advertising, config.advertising);

 	/* Restrict the phy advertisement according to the MAC support. */
--
2.43.0

