Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F333AEF3A
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 01:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789696241; cv=none; b=tBoU/PeOYPUuH/wOkr0Z8SKHDG+qs6JNgrnSkzdUFvWYdV4r/56J/Vjw6aQ9LZzmPLogQ939+An8Ot00n1gFh9Pga+ybs2ExjvxJ1mWTguLTtFQ4brYK8lV51jvxfIPfdaE+MsAWgryD9Lyt+4zzzRJkTm1Zu/4l5tJ2VnOz6Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789696241; c=relaxed/simple;
	bh=U6Ifbz5x0kVweq8mt/nG0FzHuV5MzqSu4AL+yPCKtnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFVgLkom5pLtnrZpDQj43z0BOwQtPp49x1xK+luCXdNovuFkufat/Lb0SekfR+WgeaH06jkqAWALpX8O3iFrIh/AdBA2J08MFRpkC0PnixkmHFnHIV73k42saENknWRP0Tx2+M8wcV5dNWmX/peUj2DgvLrF8qMTjUiIwgX9iXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=hSrFgtXA; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="hSrFgtXA"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e66390995so1005605e9.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 18:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1789696234; x=1790301034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O4QKzdzhXx3trVjHguVbL/tPhlBogzEsqfZIRGP8UlI=;
        b=hSrFgtXABYXnSOExmVjFqhtGmU5DyE7hDkypLTvCcKKpqkFJWJnFee+IPpdiSX2+Pb
         UbwMInoJOpbsSc2WxidhFtjuwpeS1OYbFCByRh9O/mIKgPAmEzErQHlUhdDR7exurQu8
         4PsgHOx/tkYaBOMjOfBLkkJzk134djbsJv/uUzwpGo5PKUxNO9ukVUnBiv5DrJkycLnL
         iz20N79ktm0wezPLKPUxz6aRpDg/z+uHyB5BVoVMC1c8MeXay7YXbKYeuXbCs6Bz5wNU
         by9A273MpD2OSkXP1e0ufghFo3JyQjfG1CNS+AVBHT9wFjnD3/GiJjZRvFoNbDBmb6GY
         4rug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789696234; x=1790301034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O4QKzdzhXx3trVjHguVbL/tPhlBogzEsqfZIRGP8UlI=;
        b=IqD/nta54/sgREtQYVZCZsN5AbmLv5oHKq+R4v+v1bVqoJn+WMpKI48LJ/Ixsy+TYW
         7bq6u1HHsqWXIfHrBm/mjlr7oSDf0/pXcRGfowsH8S2l00ymRCQ4o2+cKODTk2/ma280
         mpK21hjBv01M1fkorn1fi9+ELUX/Oa3C1Y1GTKJHTKThS7XttaIEVutKLzwO/8sqiIQA
         2yb6wPmeMSe6md0qu9HlDJXjSqGV3HYSkPz7c/lE16pyFkY9xwNri6U+MBCKJ12uftf/
         B9MjKC3lWL4MB3N9WRgkG4wZLVN+RtgHe3JJKQrIKZ2HEy1Tjyh9TPUr6O6rK04Rpi0U
         xOcQ==
X-Gm-Message-State: AFuF++k97JY/0BhHoLR7NEiratdH5cNFsd30fUkEld4wI+sGsqgjDXWh
	NCFHbDgvs09qG5NYKO9nKg0IPCSJ5tzxqzs6emn26wcsoKSW9/80SzS4qcGoe7h1xkbn+DWowAE
	Jqbi8/36xx2ua
X-Gm-Gg: AYBFou3GMxNTdy9c+vCtt5S6UojU2ET0SAz1wTbeU49bXC/lZylyWBb+Qu2PFOEhYvR
	U3FW66sEqai1AeVYrzm68uYQnrgIBwzNuzeZR+9iwxBC/Jtt1yUdYID0L/1QVcJTfWxAqzStmhz
	f8csLVhtxauRJpWTQEk1abHS7lKHuGqWsTr1eCWeiW7hJtznzvFAJyWRi4BkChBGQLI6wh053pD
	w68zM3N8frC6j/8OT931U+3JDABBdLgnB+Fhcii/UuPcL12p5vXiKZGBcX22dlCH8J/A6cHwbqE
	lmGR7PoTjXm7Oj819Nicy42jlSdh63zMABkmtdt4gA7VLa5fKkrEf7RJ9SUZZSjzXN51oshztoB
	6fxEuSmpRXVDpC1Hlm0sKHkbFGGyixLSzUr+ReQP3JeNsicXO8CFD4Od8agxLtXFH26ZxDsYHuB
	Nb7GQl9mMk6WxSWSx6r96Q7wxlDUZXuMrf+8MVbTtTXvUt06knDjk=
X-Received: by 2002:a05:600c:8b21:b0:49d:16f1:94a5 with SMTP id 5b1f17b1804b1-49fc57542b7mr7295435e9.25.1789696234474;
        Thu, 17 Sep 2026 18:50:34 -0700 (PDT)
Received: from remote-01 ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-487200745b5sm64224f8f.26.2026.09.17.18.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 18:50:34 -0700 (PDT)
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
Subject: [PATCH net v8 2/4] net: usb: smsc95xx: register the PHY interrupt with the MDIO bus
Date: Fri, 18 Sep 2026 04:50:27 +0300
Message-ID: <20260918015029.2518425-3-f@lex.la>
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

The bus is the one this function registered a few lines earlier, so
record the number there as well.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---

Notes:
    Compile-tested only; I have no LAN95xx device.
    
    No Fixes: tag, for the same reason as patch 1: the write has no reader until
    patch 3 lands.
    
    Teardown order keeps the number live for as long as it is read:
    smsc95xx_unbind() disconnects the PHY before it disposes the interrupt
    mapping.

 drivers/net/usb/smsc95xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 42e4048b574b..130a460c1f54 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -1252,6 +1252,7 @@ static int smsc95xx_bind(struct usbnet *dev, struct usb_interface *intf)
 		goto unregister_mdio;
 	}
 
+	pdata->mdiobus->irq[pdata->phydev->mdio.addr] = phy_irq;
 	pdata->phydev->irq = phy_irq;
 	pdata->phydev->is_internal = pdata->is_internal_phy;
 
-- 
2.53.0

