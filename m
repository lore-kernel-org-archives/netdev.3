Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C9F38E8CA
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 01:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789782819; cv=none; b=LdZTooTK3eWMiX49d28IDNYIOjwdYhR9BYcFXS0+elDJ1g3FkQIerfDepXgsW4ro45IhMNwOWC3dv+D7Ug8hD8sW47xxKUQgSreblGUukb8cGsh6I7WUTZ9iYrp+4ttfuoVnI0+N9O9nI6ZPrU4Vg/ILb5plpeFBgx23vQKHdVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789782819; c=relaxed/simple;
	bh=cCaBU7oEJUaSgKv3AOoHWTBLx5bHifxGBgLHeTeXwSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ughQ5v+ceKg1nveZM86Vm+PtIqOMcnAQYtb/Vj7KJH62l28evirwzU7uiXMPTSNEeBZLSf3sfHkpSJ/zwRD8oyiSaWz0K2Flwl8tf4bO9LdPZEQw5co3yaPt9jOP3qPCbizgi3j507n9rDbGaZTxeQ4RJfEWkUIWR5ZGChz3UHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=kznNOsWo; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="kznNOsWo"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e2406so6233505e9.1
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 18:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1789782815; x=1790387615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WyDXo9kpQFW91Gkc4DaNkWVfPcMyJLvq7pf7bCVAvb0=;
        b=kznNOsWoe6Kw40jttGlOSLPJ6vM/CTk3H/m+kMl7qOBA2wEeHN3LJbUKqHzK3DrdWH
         UxBVdknJCGvjTNZx4uULQMdrrVjdzYvebQparKkbY+jU0TqWFr5s7rvm5LvCXQiQqSUR
         WkNeW75WIDKs7RUBG3HmewoVm8RV8I/Umh6BQ/CRVkZDxJH7prMl/frkTvVLuVei/Yrs
         DzC4h6OhsZqe6ic8lH78COFYA+N3qnHR1GaHoPxHc0hWKb4sUe3xnu0vD7+VEfT6E2e3
         iC1T3AsSzoXjES/uZBtNciuIKoCOLwG0rkL6EmNZ8TRIpBn5B2LhrNjtmwjaIapgc7pI
         8b8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789782815; x=1790387615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WyDXo9kpQFW91Gkc4DaNkWVfPcMyJLvq7pf7bCVAvb0=;
        b=rB5zcJGeBdZ5NoeSVJzIKOy86GJi938OxKg5uTKLEbR90jMJP6sIfq6JiIW3eiJxaM
         rWlG/9c/Zv574chs1Ww3Tm0zusAp99izrTDbLNdSg1wYROywSAGIWU9A45HAvhCblOWf
         obnJbVkOduGEmSYytTP3tb9n2xQZYdhVqi+4DpsDIAg5ZQKnHfwq7xRkKxMciW6QMXWD
         ficrV298eu0To3c/kCg4LjdG1XK68I5I/z1ynb51i5CGU7+UtzM1o0CBmBo2EAqrIYWw
         D42da/tsOtKl3/olkQ6waDAyphoATeL17rxypDexlp7844yeaKJrEU32m5bzpLK6rCgE
         u2Jg==
X-Gm-Message-State: AFuF++lvK4wwdwn114+fZUv6ngSOmVZIRsbYVHxylwGUstRknkMuIRBW
	yoFnucqwOrTZGYO+fcRuhL7mUz8sAbniXUpj5KwFptVsK7Iex6edWhqjy7Ui6fToIXzrsoi1IdN
	SqaxZVh8I+lWE
X-Gm-Gg: AYBFou0q49dfsMiGGR17iatZ1GfFQe9j05OJdXsbbsK9XPaqpJb/CBEEbwrkSKKy+cd
	9Xe4wNg9SxJwx9NPqozoUPf7gR3SgEf2ylfdJnVlL35266/5KAxk6zpHNq3Sfj6sEUHm9XXInob
	mmyiocfU07Pe19T1FI6H0ys4aLCZWa0oxmJqfBlv5JDiCv83efsKL0yyDj11bODfIVGilz1APEn
	6wX4W2DKO0DyXkSQgeSwluIUi52h11xFyhnRWsQlh3hx8lLU3UrmSmDxRut2Rp3E8sZUzPFF6M0
	PMhMEwtOUQswx4ZwDWLyA/7XEfdiB/McAMW/0Eu8i/bs+dKEUB4QVhThUbIg5e1LHTOZnfihZoy
	4gIBHvepLllm1taxz7tAz2ojrD4NAjrIkKjBVOyWKAH9O1y1GzY4OYYybBQU/xCzR4P3E3c3x/A
	Qr4KMTK6unC5HtjZ5ceZ3jR/yPS+TBWZwWXL4rggtHpBYij2d9NQ==
X-Received: by 2002:a05:600c:83c9:b0:49c:f13e:e4d with SMTP id 5b1f17b1804b1-49fc4ff402cmr64168175e9.10.1789782814756;
        Fri, 18 Sep 2026 18:53:34 -0700 (PDT)
Received: from remote-01 ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd10d174sm34946045e9.11.2026.09.18.18.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 18:53:34 -0700 (PDT)
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
Subject: [PATCH net v9 2/4] net: usb: smsc95xx: register the PHY interrupt with the MDIO bus
Date: Sat, 19 Sep 2026 04:53:24 +0300
Message-ID: <20260919015326.499479-3-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260919015326.499479-1-f@lex.la>
References: <20260919015326.499479-1-f@lex.la>
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

The bus is the one this function is about to register, so put the number
in its table first and let the scan seed the PHY from there. Which
address answers is not known that early, so the whole table gets it.

Found going through the drivers that keep a PHY interrupt outside the
bus table, so that the restore on detach later in this series has a
number to hand back here as well.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---

Notes:
    Compile-tested only; I have no LAN95xx device.
    
    No Fixes: tag, for the same reason as patch 1: the write has no reader until
    patch 3 lands.
    
    The mapping is created well before mdiobus_alloc(), so the number is in hand
    where the table is filled, and mdiobus_alloc_size() is the only thing that
    writes PHY_POLL into that table - a fill placed after the alloc and before
    mdiobus_register() is not undone by the scan. Which address the PHY answers
    on is what phy_find_first() goes looking for afterwards, hence the whole
    table; mdio-moxart.c fills its own the same way.
    
    Teardown order keeps the number live for as long as it is read:
    smsc95xx_unbind() disconnects the PHY before it disposes the interrupt
    mapping.

 drivers/net/usb/smsc95xx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 42e4048b574b..ad65d2b9cec7 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -1148,7 +1148,7 @@ static int smsc95xx_bind(struct usbnet *dev, struct usb_interface *intf)
 {
 	struct smsc95xx_priv *pdata;
 	char usb_path[64];
-	int ret, phy_irq;
+	int ret, phy_irq, i;
 	u32 val;
 
 	ret = usbnet_get_endpoints(dev, intf);
@@ -1239,6 +1239,9 @@ static int smsc95xx_bind(struct usbnet *dev, struct usb_interface *intf)
 	snprintf(pdata->mdiobus->id, ARRAY_SIZE(pdata->mdiobus->id),
 		 "usb-%03d:%03d", dev->udev->bus->busnum, dev->udev->devnum);
 
+	for (i = 0; i < PHY_MAX_ADDR; i++)
+		pdata->mdiobus->irq[i] = phy_irq;
+
 	ret = mdiobus_register(pdata->mdiobus);
 	if (ret) {
 		netdev_err(dev->net, "Could not register MDIO bus\n");
@@ -1252,7 +1255,6 @@ static int smsc95xx_bind(struct usbnet *dev, struct usb_interface *intf)
 		goto unregister_mdio;
 	}
 
-	pdata->phydev->irq = phy_irq;
 	pdata->phydev->is_internal = pdata->is_internal_phy;
 
 	/* detect device revision as different features may be available */
-- 
2.53.0

