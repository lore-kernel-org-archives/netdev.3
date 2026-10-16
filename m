Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229273921ED
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 06:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792131118; cv=none; b=I4EsojRtuPjDgSoLFCXGS+Ci16b40W+t38qRCXqhw5zd5Bwx7UbIWh9dnZo2hUcuNqXSsLAY0Ig0jDwMoyBsBgV+nB46SJ+Po/BpqBnxvb1COps5P89LgKRvV8fnhfjmU0iKrBpmK/Q4uxZE/cmvtF0LcW4aX9m74ZyjmJ88va4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792131118; c=relaxed/simple;
	bh=Z4ApbuOXeZFJ2fusE4nluHa9lroahiFieVjdHR5r3b0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxqVhxwXg5zIzGZsf7GyFLCFN5iUCJpDSkSKDhyJq806uWluzbm6VHcmmOF9sNFne7/kEXs/5XHWIc4V22lgkwG20Gy1KW/Rs2tRM5IjUxMU1spJ80V52m9+vl+wKCZ39DbdrHvQXS/Kjntu6rNNKgdpU3h1/02K/gGjquF84KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdD00T7e; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdD00T7e"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1419d3416ceso4984029c88.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792131116; x=1792735916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z2FM7jcIWlJ4PIwiCNBi2mvobRhODT2uuOupycVzBlw=;
        b=WdD00T7eTXdQ8s2w47F2v4DDeG+Gg47XVcHOwQWpNYhOMG292i8l7ZdEG1lEoDQEEL
         r6RMLdAaDaF50cf9vGxEwHR76xabpOnB9ZVXLECmgkJzyQForDkKTb0StXl8c9hGAGlX
         acj/ctzJSWTTmrQwoSAU46gcwUpHkYVmWKKIb19Ekf1Ykahs8mjXbztJfoH10hPCdvBS
         0dy6JKKn46DAQBV8DinG8/bxUsvukMPjBhx5tXUxzhsGHhckxO9vwqPd9PP61sNsFxMa
         moBCGyx/XwgKzuZ1camU7iaG/rWNhNFbZzqSH5aChYmCWzfJReP0b0aXu70GVJOk6Icf
         oIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792131116; x=1792735916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z2FM7jcIWlJ4PIwiCNBi2mvobRhODT2uuOupycVzBlw=;
        b=eQjqWZCMPbvbzs9/Fb84jM3pIkeQ1DS9jX9Fop1ZATcKgkOxteiIj8Bc+rXn+SjfL1
         /R+VLPR8fejoYTq275a9+oM1MNrTTGBLjIIRZlmUmvQ+7VoVkiAmgjsH0tBjDoXaf353
         2d2ZaEPBwDnzi57y0cmdzx3AJgeij9BYKgsWZHTlhqL19MhXolwoX+quHqG2uWTFwoKw
         2UcXIfCJH1/z2lGpe3SpvXS4mTzX8QV8ZPZyb+zLa1cY+jWyc6l5mVpjK96+oPaMRGHe
         hv0megU8jmU8Q1RBGo8JFhikiEiaPuCRZpdTrycbfx/tBWyrde10Ifn+jm4MaHqDekFj
         DJEQ==
X-Forwarded-Encrypted: i=1; AKwUvBwJlmJKCAcr4qY4pUdHNuDO8dnQFXu3ufPw43IHpgF6USoxkFpgcteTHL0WFLrkMJNRqtw+WSw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+ny6Vmf7BvBK+foWas29TLPj+Vf02wUtzofZx9ykSfymth6+2
	d77pK8Ur3QxrA2ff7EtIiRc9XKEQdh+MXYllv2zqfhcB4tKJHk27Oc0k
X-Gm-Gg: AYBFou0pyLIVBSbeARmUU4bRI2eWI8ILy7+Cspyvu4H4HufH9igOS/DICRg7PEoVJAx
	r+vkmAzmBI4X94Dgn4oyZfy0P9D9jaXfjHc5MtBRQykP0Zw0OzDSLpeGew3J2O3eT4zKOeUPGCU
	0PqdYMiu5FULsWlH8NqsQkB8s3K/37uf5FjTfc87mNHTSEQZnT8d3U3EpSGgByrpeLJGWXBxmGP
	FuCYXMDdtSUZwHr63YPK7lrrkFHjhZeMuR/FwgFhTKkzId1JCzI25KuPgB70KZsFXfAghC2lxOb
	tZ58srp6Zf0e2aVorAZvr2fhUyZDaTwNG6cgthwRaqZYRNVaVtAeRljBEuVXjsZB3238PxjD1Bi
	7CyXvWnUVou2nesHJp+Hiqzk7bl74q/OfeUZYTDpoPFLfHtE4T0FrZvm58kcSfYDyAqoUN0fiWN
	JUjEsSolcN6ilkzt5edQ16cTdDqKC9mgXm7B1Ux7QdO+DkyGjF+/EVNqMzvAP3Xi9hXVYkm0t1x
	WARfo4/Z/BuSaZZCBPfgGvQME6/X0wwAwiozFxvGWKV5jE=
X-Received: by 2002:a05:7022:f512:b0:16e:4723:5f86 with SMTP id a92af1059eb24-16e472365c0mr21571004c88.29.1792131115688;
        Thu, 15 Oct 2026 23:11:55 -0700 (PDT)
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan ([183.242.161.82])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831acba710sm3755480c88.13.2026.10.15.23.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:11:55 -0700 (PDT)
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/4] can: sun4i_can: don't discard the IRQ lookup error in probe
Date: Fri, 16 Oct 2026 14:11:36 +0800
Message-ID: <2a7cb6e4e1b494efd4da512abbf307c19d9d1467.1792118040.git.chaosheng.qu.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792118040.git.chaosheng.qu.linux@gmail.com>
References: <cover.1792118040.git.chaosheng.qu.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sun4ican_probe() collapses every failure of platform_get_irq() into
-ENODEV:

	irq = platform_get_irq(pdev, 0);
	if (irq < 0) {
		err = -ENODEV;
		goto exit_put_clk;
	}

The driver matches through an of_match_table, so of_irq_get() returns
-EPROBE_DEFER while the interrupt controller has not been probed. The
probe overwrites it and the driver core stops retrying, leaving the
device unbound even though the interrupt controller appears later.

Return the lookup error unchanged, which is what the neighbouring CAN
platform drivers do, e.g. commit 057bd6168d98 ("can: cc770: don't
discard the IRQ lookup error in probe").

A device tree without an interrupt now reports -ENXIO rather than
-ENODEV; the driver core treats both as a failed probe.

Build tested on x86_64.

Assisted-by: LLM
Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
---
 drivers/net/can/sun4i_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 76db6d09d1e6..a6c761506244 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -856,7 +856,7 @@ static int sun4ican_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		err = -ENODEV;
+		err = irq;
 		goto exit_put_clk;
 	}
 
-- 
2.43.0

