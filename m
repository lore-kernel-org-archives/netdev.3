Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56103328FC
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 05:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791091589; cv=none; b=pyJ6Mzr1LkhC3asduyQ22fb9mbRMm9V6Q4abKXlLNmJ/I52SESdy6543aL/0wuJxKWHaq05x3Qiac8zSDy97FfxiR3GtfnjzISIp8E3V/S72rbBH4jx/VjqteMuz4M8EjeMizbmE0UlRO02v+AS59Mg6adWCXdtgD3aJecUQy4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791091589; c=relaxed/simple;
	bh=eZ2p6zXDNQHbt4Zn0SxItyBiCh80mtsGPEzghGsZle4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGPrkbO6t6OrcdGLyDR6vGZUg4U56AXe0cWFvSo6Aeufay4Pdv4i05UzwtWES1BKHSkDjR224C+l/AobrE6Wo4tH/wMEpUr139+8AwWmXCOuiEtWAwqqnDoWUu/jucsz3JSssqCaKRSttQZbZT4ZskmwUO8rETvIVtj9x9L4O3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIb3lKV7; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIb3lKV7"
Received: by mail-pz2-f37.google.com with SMTP id d2e1a72fcca58-88826f3ff80so207563b3a.3
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 22:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791091587; x=1791696387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yrSoyR0XDRjfdCWPMbPLnbv5pHqYkj4I5sTbgAVqzyc=;
        b=FIb3lKV7MByZxb4XzPygVdbnbUKGURPvWz0CLQVjEykLKvFNWY2UPJgmFBG/tWzx7s
         aCjLtD6dUtezPsSUHtkHE5aKMQLneLezmvYNC31zMSjya8dhVerODNC7D3t1DZ+HGYuE
         UDLa3vvGdBIX/fRKnfyiiNJDSOERacE6rHT/q5byCefBcWAJ1tqblkXM0BxBveStojm0
         fqt7k+EmIKlYBaSq816ZS7mx3/LMHxeHZa3jIlahppKrNzrzrOjlsDFpKndCNPsCF69w
         HI44TLkMhhAqO/y5kX/6875Udz3cZiIaEQLuEgokNhrmjROkpr4ymE1qGuS9NjQlrf1G
         ZNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791091587; x=1791696387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yrSoyR0XDRjfdCWPMbPLnbv5pHqYkj4I5sTbgAVqzyc=;
        b=Rv0vWPp0OeKSpG0PFmkrSxXrhRfF5b/tttkBaZqaAtU9Pqx00+XGePew3YlLnOmYde
         PO4On9dasB8+TMs1lbocIYiNgl1MqpvSLbYD1qIlLo5S4BKyEsm5z5fXmoKd39FEyEc7
         OHjYhr3467fcOb5m6q+k8w6HU4+LVaQnt3ONRIAQrQoBGXz0hO/5rQGfrmoabTpBvgJW
         DfA2DgvjXjI9g+Q/Z1AZKXzsCiulkY/rv6FSA4GtGe7sM8AEbZ3fX4dRoAiG49hYhJ+/
         spPkJPXVTcBXa/xUNTTxvRppeHajAUohfWcrRNgHSEnoMegNmovWn1h8kwUt4k1G9uHD
         JRiw==
X-Forwarded-Encrypted: i=1; AKwUvByr0pR8XvReO9ckAoZIc8WCf+6JEIvCCuoisxofuwzs1mkWAKJkslczNH8Hg18wg5OfcIwBkxQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nIh+1WVfRj/Wk/eXxy4h1Uzp6drmH+xoXYCgu518SKYHAcnDaa
	DZ6NyOCVG92JXvayQKThknF6LEsR/XH/Fwf08GE7FR6Q97ZjqBD8a9UN
X-Gm-Gg: AYBFou0IqJBo6JofSR73AK2620FmmQh8gE33CHYIAEj0INKkm+udKgyzKj8KypsVyQ3
	ElfWv7CKKYnTevxJ50B88YtS+ITaE26dBeThJ78lJuQElznOBIZRywa3yCoAQvctX2gEcunyN3U
	ei9kZ30kE8lzyO6IyfqZql8e9wEYxj6M1vJOrJJ3PY+fRh/WZ/C3eVucCUc3f+Cfd2vuc9q8wRu
	mH3IubGeRmipEZ++eiC3IHZcnhIKR5M1KUQKjxbxfv2YvmWrK5pmDeZOVyR2OAQPmIF3GBm/oKD
	Ih1VLNGfTwh4UyHLlFRzp0w3tvUcT8wFMpKOVTaZIqX7eBdHCBOVVJboilb9B1i1aMjhM+kauh0
	Cm+we1sQjvu3+K2b/11fuFTkQBlJWySg263AuwxwBlX8piKMcJ8Cdk4AqUgT2EA7dC+DcuGG+7M
	t9izsNY4Mdxe5E25E6uaua0sboWJa8k3kH6u9qBR6rdL/dv+NaV4/l1Fzcz0Tv2+WNCEq8q919o
	x0XpNOKYOXM+O+HTAbOZooQGj7C/yEjvqSt2f4AfLKd68NkxnfmZyTD/y1k4aCJjE50GdoDAKn7
	FAYu96pBW7RfaZo52PWdb41A
X-Received: by 2002:a05:6a00:4f86:b0:881:e266:c3e1 with SMTP id d2e1a72fcca58-88af56e732cmr7763772b3a.48.1791091587013;
        Sat, 03 Oct 2026 22:26:27 -0700 (PDT)
Received: from Inspiron5409 (61-228-84-245.dynamic-ip.hinet.net. [61.228.84.245])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0968d44asm2226260b3a.5.2026.10.03.22.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 22:26:26 -0700 (PDT)
From: Jianhui Xu <neuromoments@gmail.com>
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	chenhuacai@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	hkallweit1@gmail.com,
	kernel@xen0n.name,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux@armlinux.org.uk,
	loongarch@lists.linux.dev,
	nb@tipi-net.de,
	netdev@vger.kernel.org,
	neuromoments@gmail.com,
	pabeni@redhat.com
Subject: Re: [PATCH v15 0/13] ax88179_178a: Add support for AX88179A-based chips
Date: Sun,  4 Oct 2026 13:26:19 +0800
Message-ID: <20261004052619.112885-1-neuromoments@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002-ax88179a-v15-0-131d9286fcd7@birger-koblitz.de>
References: <20261002-ax88179a-v15-0-131d9286fcd7@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Birger,

I tested the 13-patch v15 series on an AX88179B adapter (USB 0b95:1790,
bcdDevice 0x0200) on the declared net-next base
071876fd50482a68603a9460d80dd6dd58827ee1.

Builds, cold DHCP, 1000/100/10 Mbit/s link changes, EEE, pause settings,
EEPROM reads, autonegotiation restart, module reload, USB reattach, MII
ioctl reads, and repeated 100/1000 Mbit/s transitions all passed. The build
only showed the pre-existing unused mask warning in
asix_ax88772D_get_features(). Deep-S3 resume also passed with both wol
d and wol g; resume was triggered with QEMU system_wakeup, not a magic
packet. The guest later hit an init-exit panic during poweroff, which
appears separate and has not been investigated further.

However, I did find a reproducible RX VLAN filtering failure. With
rx-vlan-filter enabled, ip link add for VLAN 123 or 124 returned
success, but no VLAN interface was created. With the feature disabled,
VLAN creation worked normally.

The first read in ax88179a_vlan_rx_add_vid() returns the byte count on
success, so:

if (ret)
    return ret;

returns 1 before the VLAN bitmap is programmed.

The patch below fixes both issues and worked correctly when applied
directly on top of v15.

Because unmodified v15 has this VLAN failure, please do not carry my
previous Tested-by for v15.

Thanks,
Jianhui

Signed-off-by: Jianhui Xu <neuromoments@gmail.com>
---
 drivers/net/usb/ax88179a_devices.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
index 16b441fea..f2140e2bb 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -422,7 +422,7 @@ static int ax88179a_vlan_rx_add_vid(struct net_device *net, __be16 proto, u16 vi
 	u8 reg8;
 
 	ret = ax88179_read_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, &reg8);
-	if (ret)
+	if (ret < 0)
 		return ret;
 	vlan_ctrl = reg8;
 
@@ -438,7 +438,7 @@ static int ax88179a_vlan_rx_add_vid(struct net_device *net, __be16 proto, u16 vi
 	if (ret < 0)
 		return ret;
 
-	ax88179_read_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_DATA0, 2, 2, &reg16);
+	ret = ax88179_read_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_DATA0, 2, 2, &reg16);
 	if (ret < 0)
 		return ret;
 	reg16 |= (1 << (vid % 16));
-- 
2.56.0

