Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C69C389455
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 06:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792131123; cv=none; b=J5NEEASSts10RSic8I0FuKRPhI+UW6RlceHyeTpe37g744CfSKyM/cAsUyJe28ZMFaPpqHsTh9LZoyis5wenhVRkzYsyBxKaf9S6FOoyc1EzdouK4BX6f5B7P6/vNZ23NaLnlXtEpIUCzl//bXSQgcQtYcPKTqC6T4EJC4PBi8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792131123; c=relaxed/simple;
	bh=uFejgQmnOX+V3F3xwrMuswWF0V3FlwNOnKfSEq74M5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UVkZKxyKTw2L9CEziKuf7PkGmwILAOwOSoqsUh1d4VZ4dgi3AiYyPShMCjjJeHS9RKJAGYME8H6bh2PBcLZMX9aMKp53FKfqownP/vS+3ymaiTZ4DIRRVBPp7UGcE2+g/vYM1gYNd8MnMzNZMBKra8w0ujt+0YWoMmKsfz25a4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVOSaAFl; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVOSaAFl"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-15dd124bbe7so326698c88.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792131121; x=1792735921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2D43pMYuOtH8TaaVXIiUhAZj+VN+PDy6tPFFqTVsR7g=;
        b=nVOSaAFlOy8Qo14Vb41SDIDY5DBys2+UvMB9WK5C6Q4JvA3PUjXnt9gianwq+lED8S
         ALOEef6+HY/ZRhyFYPLtMSQPnPehDmqKBWh7q6pVYzCYcdjUjUSZDlJczhqEXQXtmmPl
         JNFf6//IyTURFop+RRnprZbOoRoV/Ad/abdTHUMszVQ4XfhKWn3wHxYub8APFg9uhHcO
         MpaMI6+CdbvdG0iENitwxv7oGi0qi2oc0No4mxO3e1gJqPvuWa0HFRQZky47rHGeOfSo
         DLD7vsUCT96LFMhdUX/YzM+Hh4bcslZX/VfToI00yzlZ0m6V9DarIUYmELSOk40v2dM7
         HFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792131121; x=1792735921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2D43pMYuOtH8TaaVXIiUhAZj+VN+PDy6tPFFqTVsR7g=;
        b=dOQC/sqi0lSmgSSZt61kEUq3LSeu6/L+92M3FN2/GDL866EmU8a4gzHZcfo3JgIwtA
         9cjg7AKaDone/1tfs+aQvNgyL8lD2NkBJTGlW6q133b5cgTkIgEJFqdslNQnioZHS0n7
         F7rVwHQz9naomHcZemQ3VLaz9WUPl2cFsgAbhT0URNWZVtNf/gnwsQ/ilBgbpn7qx1md
         rlPr9rS+5/rSUC0xR/fMvd0IhIQXPDOGVTMEu1Z/n6i8VVMWlujm9MxxIgv2SkPv/4ON
         nhh9bADCrwog+2JJGoTX6Enkb73zgHbADpAtWWEEZ2keVUaair5BrNEWjnt89c8DiHGh
         AerA==
X-Forwarded-Encrypted: i=1; AKwUvByfp7vRQ9d7mNf7FYkEf4lYEuPPvQysU0+B4/7Myw1YbdrLGfJkUU97/z0eAUbO8khSpXto83o=@vger.kernel.org
X-Gm-Message-State: AFq9FYJWkSAKeeXYrGl4e4Ay0Ea5iX6ZfqhT5FUwjswi/z6MHOCiQGZr
	/jjUDh0PoM8roLneRCFI/wGW8WbgMpx1Jcedt+EB34+0qJXR37/5lXeG
X-Gm-Gg: AYBFou1KeT/kIBS7W5hNLERL2sZ2D3JXMFc3ca0bspeANRkcQNtVUdOtXL7kOTMPTi+
	EyZ7kn6fG/Ylz5dtSj+krTQo4BUD6Qx5wn+GJx+YHxTwb70t0tgQ+QJNDxZgCL1ShWOe8+ATdbs
	nsV1MIbI1WFkfzNtFg1JPH/E+bpY6+KkmPvO4wlr8/jrD8OPKApl5HAUX/EWoQD3BnEYsFrJMyK
	zFwyBelti/sJr2/narXqIFe4iri41/cB6HJ2U/s+yyZuCcTd3BPyuRI3qO7fTaiMEvIMBej5u4F
	ZTZMOd6lp2hxZ+iDdqFTN2vSQPNOmxWmHS1IEN0M9QPXT0ag9RbLluyQmXbYIoJUZYX1sY0qBYI
	1vQ8YNAxFnj0s5JPeykTLt2VZM15iE0uY+iTtowSDqOJuS7+zpSlltoCAbumfr+gmYmbGrubDGk
	fZ4rCqLbt3u+4WvL/bQKQuMr3CNZ2RE3wHLHj0Ychb55tieTrYtwfj0Y8D+xQ7m08hmDZn+Ynp9
	THhoNvBtigX3MVBHDnPcK+EglY6HNiXeiNVIcV2Wyql+AI=
X-Received: by 2002:a05:701b:2088:20b0:151:d6e5:596b with SMTP id a92af1059eb24-16a5c4fddd0mr29746246c88.9.1792131121193;
        Thu, 15 Oct 2026 23:12:01 -0700 (PDT)
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan ([183.242.161.82])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831acba710sm3755480c88.13.2026.10.15.23.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:12:00 -0700 (PDT)
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
Subject: [PATCH net-next 2/4] can: at91_can: don't discard the IRQ lookup error in probe
Date: Fri, 16 Oct 2026 14:11:37 +0800
Message-ID: <303815792800553c34842147941cab083823c212.1792118040.git.chaosheng.qu.linux@gmail.com>
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

at91_can_probe() looks up the memory resource and the interrupt together
and collapses both failures into -ENODEV:

	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	irq = platform_get_irq(pdev, 0);
	if (!res || irq <= 0) {
		err = -ENODEV;
		goto exit_put;
	}

The driver matches through an of_match_table, so of_irq_get() returns
-EPROBE_DEFER while the interrupt controller has not been probed. The
probe overwrites it and the driver core stops retrying, leaving the
device unbound even though the interrupt controller appears later.

The irq <= 0 test also covers a 0 return, which platform_get_irq() never
produces; it warns and returns -EINVAL instead.

Split the two lookups: the memory resource keeps -ENODEV, the interrupt
returns the lookup error unchanged, as the neighbouring CAN platform
drivers do, e.g. commit 057bd6168d98 ("can: cc770: don't discard the IRQ
lookup error in probe"). This also drops an IRQ lookup that cannot
succeed when the memory resource is missing.

A device tree without an interrupt now reports -ENXIO rather than
-ENODEV; the driver core treats both as a failed probe.

Build tested on x86_64.

Assisted-by: LLM
Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
---
 drivers/net/can/at91_can.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 58da323f14d7..3977de761636 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -1069,12 +1069,17 @@ static int at91_can_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	irq = platform_get_irq(pdev, 0);
-	if (!res || irq <= 0) {
+	if (!res) {
 		err = -ENODEV;
 		goto exit_put;
 	}
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		err = irq;
+		goto exit_put;
+	}
+
 	if (!request_mem_region(res->start,
 				resource_size(res),
 				pdev->name)) {
-- 
2.43.0

