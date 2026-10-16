Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256463AEF5A
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 06:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792131134; cv=none; b=AgwwbxiTL9AdNWD5lFgYY6WGHVUZUkcwlb2o8vjaS8dWus/ZmiW0DqMVmsg2RrnETro1aVQ7pf+iPL7zwyVV9UW7x5ES4xUay1RfOqmKh6y6YokVrWDxg0g8ZluT2/GkX0ln23Hk0D+aNjXkHCGn0w6+0072h+5m8zW7OAh+O8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792131134; c=relaxed/simple;
	bh=+8u8/e19AlhCP7ZcBLcWul/CcxHHWq6yEhKJ5AL0gE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZCYu4lXrcVVYQqz0BU1da2tERBer0icBiWu4z3YoK8hzDN7n6pe0wU+ub+lA78vbDJWUzADyjRGfI8/7bDgugZeRchLnm/QBrFtdaVaLY92yO3U9YFcVAQCC8/u+fFvPjuF0V0VC9ASBCd5UVgmbn5fbYjGxmRZ8wYk1VJm3UYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWcpGR5S; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWcpGR5S"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-15dd124bbe7so326960c88.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792131132; x=1792735932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6X6wzE3wvd9aUwN+DPOs4etEkN6w/QmC2PVX0ZhQI4I=;
        b=JWcpGR5SKJ8KhSGeUEb0cC3WqGM4zdczBxxh2RV3lrn/ETteOzc4qzWeq+RMkVvbnA
         WJupc6/bhRPgNG4ojWqsZfTnjDdloD5mvAA6j96gujlA20IinA23O2IAoW0gNk1Erc0p
         /Ps3gjfJ/iCmwbqLpI/eQ42Jl5olzqMlGfBvQxYpF4sTna7Z5oR66AmqovLobfmuiUcp
         sHOSv1ruyp4YmszNBddBQvVlEq8F+VGfI93D6KNqPAdZx5bvncF+21OL/WtVVynYw+t/
         saal3oWhDyVm4HSJtyAsBKpCWU2XPfKpNP7O4e1oteS1b0GCgbWmjmy10P39ebpCy4OK
         um8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792131132; x=1792735932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6X6wzE3wvd9aUwN+DPOs4etEkN6w/QmC2PVX0ZhQI4I=;
        b=iQLu3qcpa9M73QDOwsmzDHQN9ELYEdKdjkCVR0dJ9kueI8cPa9Ppx6O0dccUwQ4PgJ
         IumQpdC7y8lHWwn2GiQfYtfGwIUIN17QCDovV2IiEsZpCBH5DQiYUeFLTSbuk3FdfhIf
         YGG0D1I4HNYrUZGU7s0rqsX8sZ83po58A8iUX8jwTyTz97r+eJL1M2fi723kpkxJsCIm
         V+6Ns6eq4OWDwxHHpXMXVdWaGvWMEXlBZY7mGP+GWS7aHXMyv1JW0o8G6pDgi511dBYN
         yKdR/6mm9aBwdeCAnlgpR619qzoTx9UHKR0zNB6vfSmqF2Z68Ogq0jsVpZTc0CEJ+4Ct
         5GgQ==
X-Forwarded-Encrypted: i=1; AKwUvBwWBolbqw0hDfBeBe534ISaE8x6i0au2gDSBvEe43b5P/+9kE5ufnuZLFTUGu4YuGUncb+UP4o=@vger.kernel.org
X-Gm-Message-State: AFq9FYKjjC8o/eUO81m6FJRysXvstqsQfR9mE9qX2gUc5mj3SppZKxPQ
	vesyoJkClYcFpCF8Tg5AJtXwIhQtGfdgQyRknTrellSVqH2VFbxhqbXN
X-Gm-Gg: AYBFou0AkjYtikWZe/0I5SQj0zdyBvVA76JOmqqFSspUHbr/mH7LPcZySQbOCw4xYyZ
	IyjMAXwvNQ3iLvM6W6hg+fMqIbdbd2OFFitcHYRZMEI5v4YfkhaAZ84fdf3Vh8JyxbgjCXafEnb
	FLwXzwfNFK1sh9D43sJYSuXSUnjvSSeX/L8DfDMctCzSqp4FCMLzo9vYDxdZN3BFR9g5F+zFFLN
	40+nb8ayxz1teoo6Do2gcPxH1nNfDLN83HgCXkcOLwsxqqsuJv97oeKQGrZL+yo8KDXh+JkP0xm
	1fweuH8Eam9qUF3pSl4VoETw/sPXceYmXp/+M8mCeJlqu+5I8eo+jxX9v/5RkOyiCTj0daEnhrn
	iJp3DkKzJVAivkcBpybLGXlhPoKIC0bzXFrZT6J+2NmDTbaROV303dHerPEc9ACPIlBjKd1/Cu3
	hU4Iaw2G5eTS/KzqYLeku1hu0GheJSA5v02rGfV9VbOAgLorkwvSwyAzjzuG5mbKk42TbPlKXbz
	Nu4OaClmfQ6BqNG/eUeVf3ZekzHX5yIHkXvX5gxFHTyD7E=
X-Received: by 2002:a05:7022:ea8b:b0:16b:fdbf:4a9c with SMTP id a92af1059eb24-16bfdbf4fe6mr23611687c88.23.1792131132120;
        Thu, 15 Oct 2026 23:12:12 -0700 (PDT)
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan ([183.242.161.82])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831acba710sm3755480c88.13.2026.10.15.23.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:12:11 -0700 (PDT)
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
Subject: [PATCH net-next 4/4] can: ifi_canfd: don't discard the IRQ lookup error in probe
Date: Fri, 16 Oct 2026 14:11:39 +0800
Message-ID: <165f3fccb8faf1db65e8f18dbee4694c95266e31.1792118040.git.chaosheng.qu.linux@gmail.com>
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

ifi_canfd_plat_probe() maps every failure of platform_get_irq() to
-EINVAL:

	irq = platform_get_irq(pdev, 0);
	if (irq < 0)
		return -EINVAL;

The driver matches through an of_match_table ("ifi,canfd-1.0"), so
of_irq_get() returns -EPROBE_DEFER while the interrupt controller has not
been probed. The probe overwrites it and the driver core stops retrying,
leaving the device unbound even though the interrupt controller appears
later.

Return the lookup error unchanged, as the neighbouring CAN platform
drivers do, e.g. commit 057bd6168d98 ("can: cc770: don't discard the IRQ
lookup error in probe").

A device tree without an interrupt now reports -ENXIO rather than
-EINVAL; the driver core treats both as a failed probe.

Build tested on x86_64.

Assisted-by: LLM
Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
---
 drivers/net/can/ifi_canfd/ifi_canfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index 9eecfe5a87bd..e0f5abd934fa 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -965,7 +965,7 @@ static int ifi_canfd_plat_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-		return -EINVAL;
+		return irq;
 
 	id = readl(addr + IFI_CANFD_IP_ID);
 	if (id != IFI_CANFD_IP_ID_VALUE) {
-- 
2.43.0

