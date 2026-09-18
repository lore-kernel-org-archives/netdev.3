Received: from mail-wr2-f13.google.com (mail-wr2-f13.google.com [74.125.225.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCFD3BAD9F
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 01:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789696246; cv=none; b=p5oGyO7ryEF+TwbX5T2io/ZoPMnKyrzUEU0tgfGkSBWde8J6CcTPywAKqb96Ipxok/bwa/qGv1bw7PT+ceNF3etw/3OiCpgGVzXCmJbiV0+h/PhDrOHIsq3gs8SG5Zcq9vz2zMYMa3slg2E2TZc0qRC/fm+j652+qUwWH2WCyCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789696246; c=relaxed/simple;
	bh=ie+Fks8qvoH2s91CTwbbOujmR4Ipol0/ojc69WvScig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cd032TcrrYWU2zr95/vqw7IT65+r27NxAoRGXVYDC24MUbNvdLxvhUL2KwRhmixmd3zf5LF2QUk080pTLQw3E0SY0K1FMudB6KXkz3dCr7G9ifvzGiRyFT2oDjpCaw7OS1Tf0ykeiq18ymNw35wTLTkHMwOkKvHZHGD/J4pMpTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=JUA9YVX0; arc=none smtp.client-ip=74.125.225.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="JUA9YVX0"
Received: by mail-wr2-f13.google.com with SMTP id ffacd0b85a97d-4843378fb37so68118f8f.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 18:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1789696233; x=1790301033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R3EdtN6qtnpTbUr6qyK3WOaZ6BRajWizEp8fE4gWzmw=;
        b=JUA9YVX0ffaOhhQIZVaEAVfFRKBtZ25S6uN5vhPH+sqxcWIWvkANdlYmLEPjXqAK0T
         dNcwODf4aZKX7ntsiXVEgvvhP30pA49uSw3CKPZynNXD8CGjxp2nVyRWV8FU9554IKr4
         TH9/W3dyy0WMG0GRObiS4Kqgm8r2QBiZ5fZ57j/oLJT3qg92PpjgeZ/5JhWNkWRXKsAe
         H1EEma+IJeeChISGc9Y2zgqmdqYi8AINgVJkBp2GB0+33qS84A4ccxtdWcpN/J3XHy4p
         HbIjwyyNG/C460Md8itX/ELDN9ehRotAyeUL+ayp+9hXUxu5kIqI9RmQBypW/64kk+/o
         gBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789696233; x=1790301033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R3EdtN6qtnpTbUr6qyK3WOaZ6BRajWizEp8fE4gWzmw=;
        b=oyIJdqjekfb0R2qewjxQP4ahr7A6F6COiGv4L/uwOu+pqlsawZ9zfbftdyMMXK6jZt
         FgMJHjLKrd9HQzamEBDkuFrDVIQAniPY6ZONuMbzmn3dVFfF27Wj+PQCpcIm9l2qALwA
         oqRo56dEZkDzSFYqG65GiKqM99klFs9XE06wSNy3J+ASFK1OjdYWQC01wzAzH3pSpPv8
         29UqAzUlVgjKlEJ0nuj4XA/XpfaVu6mvfHOJqsITD4AW5E1MLiwp+zW7AistflsuorRk
         WyKWweyKgwc77EmciOPG5JiQLG3U+m8HPX2fC2473BWIHnwdvChKDVbBgwrEO2wnOsst
         yjSw==
X-Gm-Message-State: AFuF++nq+WhEz1KuwNTmq8DX6F9ZuWzQMEOVfOnT3V7aPkQ2MOhZZMv+
	zSpPj8G9UfQZsAtq8jLf673w79a2m0P8YgEYLfO33WTXHr5RiP5J4IEpz6qeczmbUvHpQubLrDz
	RurSK+/bUqc9f
X-Gm-Gg: AYBFou1gB0+u29OhtggwybLaqHD6XB1OhF5DXG9VrpSIctfbTIVrJXxE2f8DCtnTem0
	nt1gjvRQuogOwaKltH6aXSVwesXhrqJHEEj7RDXAT8nvfU0aZGmeWWLvofmpUCeYwzfgZP54shK
	yLE8lrheEUpcuJey35yA75tZAsYt89Cscm0KTEOY2TO6iP4nOKJxObgMI3ZmGmE3iTlvqtFk6eF
	h08/Tu5H3IUXCL91Y2urYFfR96piyiYAyaL28bCQbG2NR23HuNsu6yglMMwnLN81sLISr6Cbd0E
	xoqcpT1ADPW+cfXK6SfnyyUDCP4dKiicsLqNGuDt+wyAPBXVhlc4VQQbzshMnML+KdNFIUNpxGE
	j8hDTQXgMtnVyEQdZ4wp3j8VeJzxccN8KopJ0bEaFj1BJk6DNZL4gtR0267Eex7qJ9D0d7fXPbu
	YXBx5DqnIKlvok03vUzLDFujrqp+i5pS2ohLr03YjBwkPMm1zsCw==
X-Received: by 2002:adf:e187:0:b0:486:ed36:b9c with SMTP id ffacd0b85a97d-4871e269f3amr845004f8f.29.1789696233046;
        Thu, 17 Sep 2026 18:50:33 -0700 (PDT)
Received: from remote-01 ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-487200745b5sm64224f8f.26.2026.09.17.18.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 18:50:32 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
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
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH net v8 1/4] net: usb: lan78xx: register the PHY interrupt with the MDIO bus
Date: Fri, 18 Sep 2026 04:50:26 +0300
Message-ID: <20260918015029.2518425-2-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918015029.2518425-1-f@lex.la>
References: <20260918015029.2518425-1-f@lex.la>
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

Put it where the bus keeps it and take phydev->irq from there. What the
PHY is attached with does not change.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---

Notes:
    Compile-tested only; I have no LAN78xx device.
    
    No Fixes: tag on this one. On its own it fixes nothing - nothing reads the
    bus table back until patch 3 - which is also why it sorts ahead of that
    patch rather than after it.
    
    The else branch that forced PHY_POLL is dropped rather than moved to the
    table, for two reasons. It cannot run: lan78xx_setup_irq_domain() returns
    -EINVAL when it cannot create the mapping, lan78xx_bind() gives up on that
    return, and lan78xx_phy_init() only runs afterwards, so phyirq is always
    positive by the time this code is reached. And if it could run it would be
    wrong in the other direction: this bus is registered with
    of_mdiobus_register(), so the table may already hold an interrupt the
    devicetree described, and forcing PHY_POLL over it would invert what
    patches 3 and 4 are for.
    
    Teardown order keeps the number live for as long as it is read:
    lan78xx_disconnect() detaches the PHY through phylink_disconnect_phy(), and
    lan78xx_unbind() calls lan78xx_remove_irq_domain() only afterwards.

 drivers/net/usb/lan78xx.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index cb782d81d84f..d02e4ffcbbc1 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2892,11 +2892,10 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 		return 0;
 	}
 
-	/* if phyirq is not set, use polling mode in phylib */
 	if (dev->domain_data.phyirq > 0)
-		phydev->irq = dev->domain_data.phyirq;
-	else
-		phydev->irq = PHY_POLL;
+		dev->mdiobus->irq[phydev->mdio.addr] = dev->domain_data.phyirq;
+
+	phydev->irq = dev->mdiobus->irq[phydev->mdio.addr];
 	netdev_dbg(dev->net, "phydev->irq = %d\n", phydev->irq);
 
 	ret = phylink_connect_phy(dev->phylink, phydev);
-- 
2.53.0

