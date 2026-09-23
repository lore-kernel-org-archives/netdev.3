Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E2B35E1CC
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 22:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790204354; cv=none; b=C7qc1nSMYzqaa1zFPJoJawcnFrnG7lLveFjCn5q4lX6D5UzsA0VwT6cFZUou86BK2R3VSHEaH9HQwu+6Abhy0AyEqqjCwoiuIIXloEXxWyEpZsFw1j+o/93pVgY1ouRhIM2gAiRwesFPbFa1CxqVgKK0fVKg+r+AOAs9sICZsLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790204354; c=relaxed/simple;
	bh=DfUQUIpVUezlug9MVd3mXZVAR67C34RFcbn/eGNZN9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fW24RUO3qlwQV7iiPI8MotAUsvBYfuXzARGg8ELEv9lse67a19hicN1Mbvmnf/UdgqSVsaCo/WF1X928/Fz4jrCNfblIBt446IsB8O8J3HdYqb1yBXy52H1dLQQjM3urEdiDiCF1AGHAfOzzXcd5njcagcHKmqhrW8MLM9PIM50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=XTZjHap4; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="XTZjHap4"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4885a1480a2so836509f8f.3
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 15:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1790204351; x=1790809151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FamuVAvtAoLcUm32epRgpyyHoGUlcwlOWDWpUaRNyGk=;
        b=XTZjHap4MY+3Mt9bKG1NSpxuIVvYVDb/jIe2XBxd4/SppWdAZTN9t6thQWqY8SnqLB
         luyWx6h6UgOUpG1quqCSOaArFF6WFo2h/ni7as2NcEj6oez29MCaheb90fJUWZ4sE/uD
         TJs2f+OR5VYeBIbXMIkvJoItr/YKi1gXbLo1YSDLoTGlXUqcHRH0y3uw/m07c/C/y1aL
         /Hb5UVmJalDcVJKhuOb7TKE68KoQQwkMeoAgPDJquJKY/kCLwsji5bGOgj8rtVu6xHIY
         igVbKYCSMxr/PSReed7ThmT3jhJW/jVvVwG0+PBxIcD/dwkW93qKvI9sJuKmFVg9R2QC
         IBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790204351; x=1790809151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FamuVAvtAoLcUm32epRgpyyHoGUlcwlOWDWpUaRNyGk=;
        b=vPDBdb19YDPaf3lH/0KepwVUsTVRaKNKCw3s+dc5BPwh76zAE6rU5a6EWBdZuVGJH8
         3xvvmrNkSKOw7xPNhVyHr0rn1ItgV0wedVDsNM2FgcTiSC+vNtes3bTap9Bw+oCFW435
         OXSwfet1k2A5PO55GJeXBEXUJKAVnDx/IfuQEhpYVl2O7gUxp6LZvSQM+lu6H31hJXmc
         qP/eLMa7grDs8OF2zBXE1m5AZ5Nx6MVMtAjNjMNA+h6WTz7vbGeYkX2xLRSp8dzc2FAX
         M1TQjEFVI+kwGIJS5cRRUL5gfUbDARKiOzxbKSse9ATL0+DrE/68R5hbiZBPOXl7JFmb
         MiPQ==
X-Forwarded-Encrypted: i=1; AKwUvBwQ7tqlx85UiKSQ8xFmNlV9wWEkolfeGh7m4kIV03J2z/NB0pK15agROys/148A+/Jc1NQHPV0=@vger.kernel.org
X-Gm-Message-State: AFuF++lI2gHu6I8BD4SC7TJZhJqlJe0K5oA3USQdbytCp3ukAB8qg/8+
	MVv3dNetDRcnPrlzpiMubJlrGjpY6AneO10XYAbUTTmDibj90B1xJC/67MA0Jsg43KA=
X-Gm-Gg: AYBFou1irzZKbnw7CSpif4sZXBeJ2BuesZdtHjB4CZz8Jssz36E9ugJ4LjG8VmndnB4
	kves2Ve2EHGt99giCHKowLZfAzm4o4LKJwZDDMTmqx00Q3uZeYLFqjU+GBUkuq4PcslGqEvYWIE
	c3igT5MSPnLm5MxfkCg2LoNZykVSLfy/rqLVm04jWvf2HqTBRjDUUYUgfaoPgdiC1KkxAp56LCA
	QbD87ofF7LKNH4R8XQVN4UsdlraUp+zxGhcp0glkjP3mWFuoc5qedjplgIENcnSQ3s3sRCL7kXu
	8GToolMRRM25HUE1iNbzxq0gly9b2fan3a99ZTU2ALDDH4VfdKD66+Xx1cOXdOvGw/AOzrIKquB
	kp05gVyT6+6E/KD1RCvoaVdhchBYEob8XRqWusEmLq6RnQM6dT2KCtjGiA6LmaJUpMbxAbHfhYU
	afs2j40SAljKVbWytfeHeMVK2hv9aEn2Q8SmZSt/BY/ZkKugm4og==
X-Received: by 2002:a05:6000:24c4:b0:487:233d:beff with SMTP id ffacd0b85a97d-488716c0695mr966480f8f.16.1790204350681;
        Wed, 23 Sep 2026 15:59:10 -0700 (PDT)
Received: from remote-01 ([84.17.55.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48868889926sm13567439f8f.36.2026.09.23.15.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:59:10 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Aleksei Sviridkin <f@lex.la>,
	netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: PHY ports: combo port with a MAC-side GPIO mux on a DSA switch?
Date: Thu, 24 Sep 2026 01:59:08 +0300
Message-ID: <20260923225909.1649267-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Maxime,

I have a board where one switch port can use either an SFP cage or a
separate copper PHY, picked by a GPIO mux. I would like to know whether
the PHY ports work is meant to cover it, and how to describe such a
port in devicetree until then.

The board is a Keenetic KN-1012 (MT7981B) with an MT7531 switch. Port 5
is a DSA user port, lan4, in 2500base-x. Its SerDes goes through a mux
on GPIO 27 either to an SFP cage or to an Airoha EN8811H 2.5G copper
PHY, one at a time. SFP presence is on GPIO 23.

OpenWrt handles it downstream with two devicetree overlays. The copper
one gives port 5 a phy-handle to the EN8811H. The SFP one gives it
sfp = <&sfp1> and managed = "in-band-status". The mux is set by an
OpenWrt-only gpio-export node, and a chainloaded U-Boot reads the SFP
presence pin at each boot and picks the overlay. Changing media needs a
reboot.

The PHY ports code in net-next covers an SFP that the PHY drives itself,
with marvell10g as the user. Here the choice sits between the SerDes on
the MAC side and two separate media, a cage and a separate PHY. So my
questions:

1. Is a MAC-side mux like this in scope for the PHY ports work?
2. If it is, what devicetree shape should a board use today so it does
   not have to change later?
3. If it is not, is describing a single medium the accepted way for now?

I can test patches on this board. Writing the framework part is beyond
what I can take on myself.
