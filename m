Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7944A5C23
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 13:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859767; cv=none; b=Lt8uSCpu7WxwLozFYRGhJkSXCEK6Au0yATS6uTUYLRAY0mAFlsnsAdmmVaRT7xcTrmtl80pu0F3XKfiIUSzbWTZZC2tBQJAsJa3VrnUB8DoVA0Gr48rQfKDLi2qOvSq/mTY7w7CcRjY8IqKeMSPVXwo2jBsbybsDomhNQb5HdFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859767; c=relaxed/simple;
	bh=hUC+pzcpmQjHzFf/Nom41aK/9H2XHKqy0HP6NNMiTzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWCqOaYvRQbTeq5FMBGSf2zFTBfHV3mjG2kqsghSNUxt6RgfxwjdhkzOSVImu+HUMpmx9rjpdT430+OaRqXS7wkGb2/0JmHAfyjWOwULVTi/TiUQhA2V8cDg6IbGvI7pCDE3UeZ5a2mKdpW5Vcsr5dxnsMtJ8+NhVf02dh9oJe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=lE8mhbuI; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="lE8mhbuI"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e79a408deso41051065e9.2
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 06:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1790859763; x=1791464563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k20Tt364Wd6rx8/375/z8mNMayOYbaxuxBDWEyWrxyc=;
        b=lE8mhbuIoVA2Fb1T1Y8w4mtZhAWr15cMJQqFv0jKZP608J12ImwXnoB+Yq14kVYj/k
         qE/PI6IoZydp3FMqxMKYHTpEu34PiBbLgIOj1bOWdK69jjXVpo064hbAQoc0J6Ncd8fZ
         8/K/tHfRPNbCDIqx+SKfalU6WvZO5KkyzZYgoeaDz6vgCcE0IDMCicV14ye1Z5LvOC25
         FYWO69sICGgQNJCyPtqarha2EZbe9rkgr6DPvZeiIRzY4awuHDyZMfV6DFC6wSoXoK/S
         H4uJxfFshwYPUZ+zYIn7M3vY8m7k8HqIv8WOUwyo03DbCFRVdsR8sDhQkuW9yVM1Xk6i
         NNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790859763; x=1791464563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k20Tt364Wd6rx8/375/z8mNMayOYbaxuxBDWEyWrxyc=;
        b=Eggnf+d9zpn0HXk/y5xNZpkUhUBRBLESuVXc6cUoRKWNHIV5Rj5pME6vDyJnzD+OV+
         ljlqrKqJh5pkkOniebEa1ndV1KKe4w5+97ovhrcR89jK/hFQ4aaQTJQ0qmA25Iff3Z/9
         aZhfhps6m1+4cKm+Pr6u//4/atQJeVR+EQdqAsMUBcDq+Mg4Fe/v0/bbh2xPx3aXNXBt
         FabXCyQSBQvUH71lnsGdo65/2VLeyj3bXDvAzSjAp1DjIMCqhJUP6LW0zyPohpQ+AE0d
         QkStMRh6SBgSAgDpJrog17B4wHffYFyBcVBF0GQFSjZfkP/HfsBrKQtCtXVOeJIem8YL
         zxJQ==
X-Gm-Message-State: AFuF++kS2aAwjG5wiYbTV61UFFQnq7PNOy5rwTIiLnjatyvqa0Dd4O+n
	2vRlCnrEfmsL0xkM7U/5Fq60yqJAfjL3vbO3VgUE6U0suQsm1gLMQej6QDlNXEuZYdkP2QXOuLo
	ZEF/ya+TWJKuGCiQ=
X-Gm-Gg: AYBFou00DDx0rQUTq2XZ+pjyU2aBapN5XB3LaDVSg1lwpkqIzydaPQsSSW0yUpGnZKK
	Oj8TgkHCL28ao/aMgGkdfkV8UN1B4RXOjZalYBx5aXQJYNqgtG1rD6if+YzdWU2Bx7wkLPt10Vr
	AoJoku9Dhe+bV59JldNeZBUTQJoDhWE1tSlnO1NeblC1KekWHNzOmGf9yRVm2jYcCgL230Q8ku0
	VAdft7jwLTLXO6ndYlV6+VErEUu1xm4W5XOzH9VCYk6CUNesE0I1dIEVa0v7tz6wI/ihMRFDHWw
	4NQnOwuCwh82GHi8VpnRLYbxCrv6bSNIkUTljZ9XAnfHZPqzAy51zh9WGJfOO0pXcLP4VCA95q0
	NgE/riHoNE9zMOQrzZVelg4I8EKje82+1rQZMC7iBpu05JW4bRm36XXvGf2pZrbj7psC6Aqik74
	OGHtU7NFrt3byac3fu+KdpCoio/LcTl7q/C0OY2q4nFHyX3Q==
X-Received: by 2002:a05:600c:c162:b0:4a0:18bc:3b94 with SMTP id 5b1f17b1804b1-4a01affb798mr72771845e9.18.1790859762695;
        Thu, 01 Oct 2026 06:02:42 -0700 (PDT)
Received: from remote-01 ([84.17.55.224])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f913ecesm48051775e9.2.2026.10.01.06.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 06:02:42 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	olteanv@gmail.com,
	Thangaraj.S@microchip.com,
	UNGLinuxDriver@microchip.com,
	steve.glendinning@shawell.net,
	f.fainelli@gmail.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH net v13 1/4] net: usb: lan78xx: register the PHY interrupt with the MDIO bus
Date: Thu,  1 Oct 2026 16:02:33 +0300
Message-ID: <20261001130236.106059-2-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001130236.106059-1-f@lex.la>
References: <20261001130236.106059-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The interrupt this driver maps for its PHY is written only into
phydev->irq, while the bus table mdiobus->irq[] keeps reading PHY_POLL
for the same address. That table is where phylib records what the bus
described - phy_device_create() seeds phydev->irq from it - so the
number lives only as long as nothing else writes that one field.

Copy the number into the table entry of the PHY this driver attaches,
and into no other. The chip has one PHY interrupt, and on 7801
phy_mask is 0, so other PHYs on the bus keep what the bus gave them.
The address is known only after the scan, so the write to phydev->irq
stays.

Found going through the drivers that keep a PHY interrupt outside the
bus table, so that the restore on detach later in this series has a
number to hand back here as well.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---

Notes:
    v13: write only the table entry of the attached PHY, after the scan,
    instead of every entry before registration. The driver's number again
    wins over a devicetree PHY interrupt, as it did before this series.
    Andrew's Reviewed-by is dropped since the code changed.
    
    The PHY_POLL branch is not reached: lan78xx_bind() fails earlier when
    the interrupt mapping cannot be created.
    
    Compile-tested only; I have no LAN78xx device. No Fixes: tag, since
    nothing reads the bus table back until patch 3.

 drivers/net/usb/lan78xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 5655941f1478..babd34cda374 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2897,6 +2897,7 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 		phydev->irq = dev->domain_data.phyirq;
 	else
 		phydev->irq = PHY_POLL;
+	dev->mdiobus->irq[phydev->mdio.addr] = phydev->irq;
 	netdev_dbg(dev->net, "phydev->irq = %d\n", phydev->irq);
 
 	ret = phylink_connect_phy(dev->phylink, phydev);
-- 
2.53.0

