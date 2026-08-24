Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7651403B0C
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 10:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787566159; cv=none; b=MdVaozdKXSRdKQJVRJSo3a9uykp66nUgMT5SfoXS/pnh1uetE7Zg2Q1Azxjp0dND/SIC9kjYKsWs42Kwc/MiTGjjNr0wcN94dn5pHI9cgQ9u9PjGrVa6J+hUYGK5OFSeKatUbwC0DFWnDrzi1ZlcCvsghVfeSgdo+EJMuGiMrbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787566159; c=relaxed/simple;
	bh=rt+YiZukszKHGQvjLh5hc6FPjItUlYmWlb0CsbP8AGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UUv1St/pcrcSYlJfqUI8/HxsiM9+fBvhPPWN/ySl/6//DqXw0ld4bQuGj5IL/1TpIUK0bnSjUtsjn5nuys/1FK7E6p19SRRzrrHadtkSsxGb1fIVlmovDT+ycaEOMmOGAGSfug4ZJv8B+ltWtfZWjyEY90yxFrZKjTSqlQTvVpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1i+R6Go; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1i+R6Go"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so39991535ad.0
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 03:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787566157; x=1788170957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g8YaeJXoEsR+KIxdOfRdm9BJRSQRSpPIKEb03BqqpcM=;
        b=e1i+R6GotbIXlUjKFsWLRPtCIoJ/nPvcR8sX5VuiNDY/CZmwATfEeL96K6YUK66VRB
         BgRo0NL11QlJYXk4mNopHLHmiD6RJPOmoIWy5Cttnw/RvwIE1yZwHyWkchSKmG62KSSy
         QVn2Hs6r5W3K4f3zezgfnF5hZjP1zLinbf8U+P6lO0I+jeWHPettWvmVOPrvYVQZYK7+
         K2oNCdopXI99l0qCHypkXok7ZI3H/8KzPKGe2evTCEUKK1bwY9jO1hzzcV7RgEFlIEC5
         lGta5+OfJ0RXU3sKVpfN32ioxTixu7zTSHmppwZSoQtSpDECgK2hX+5lvqNwN3ETvlJa
         RkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787566157; x=1788170957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g8YaeJXoEsR+KIxdOfRdm9BJRSQRSpPIKEb03BqqpcM=;
        b=YS0QM65zJAiZGbfzYGRG6/PNoI9zs1AZ0yvf/SioGB5OL/5ifv3nhESyKJJoGgKKPQ
         JRHUfUttizsPsvVd5vOsHeqi0qUVRwR8jmNgT+WWxcYcQsAAOws/KQh/WakZD3/L1qhq
         zsIT5BDjooy0yt5P7LtHnGXLNVEFoTDKsU/V9zt+fsfrVOW8d0wxNGrwLkZ2dCi10b3O
         qObEbf1+9WM8TTDVbekmCHapObCm3d0ES8g87U7DYosYU1HTXf290HDP/CQxZ4TSDbke
         qVWKZMr53ica/ep4eELIEVw4X06U+atjwmu3GlmiSMXUHg/pdxSvMf/jU94BZ1Ha6tF1
         jdkg==
X-Forwarded-Encrypted: i=1; AHgh+RoXYSx/QnOMnMrbMN4o7p5PTXpnw7lf3j7V67Gwth5aiqZOdLWz+KSdcypHE2HwsDshzhsyQ74=@vger.kernel.org
X-Gm-Message-State: AFuF++ntalzolzIOKjUMJT1r7DX5ttv5KT1GiB9IqFgQeGLaDoK5hiKB
	K4jmROpLI2gf03EMegtjD5XyLX+HZNKKCFe5iV8cEN/mEvEGYz8jTREx
X-Gm-Gg: AR+sD11p4+iVO0aJe3UeorA4a1BkjBIwh/CWuMR3wIEWSv9RZyjFrIyHzcoae5PpvG9
	jI6BQijtkYEXppFeBlAXrSpypnb8Efvz+GM+KFtIlEmJfI0GGOYmDKFMW1yK67pBrcuJZxI1Mal
	yg5IwxOcZHyVX9JbbkLvfUWnw+1vwhiO65d6KfmwgxdYFwj3LKukhFii6vQMg6CXkzWkTosdKHF
	aicCFmrY0sdrZwxSDy7Xj98btd2qZsQFJc/RjDP4P83smeWqRxuIX5Xscx4fcPHI+Z7p6QNohbr
	/+5uyvl9CL4HZRzmXQ5c41bEReJDnLFWLDIXHHrPe/vAS2I7MGRiyqpmC8HF6L7aerzGVNhAgcN
	KKeuGbQMeOKKi0RhKlOqG6Uy1AN1qKxM1WJv6ioj6KhQLcqFutiBLMX/QVlJaFPB1m/oJmj4r+v
	2j2TEBQBOPRT5DWsGlKV3cPsrt4nSkBqocGddBIPRk0/JnbuCuXVJVVkSjWeCj+quBt5YmqwbL3
	ZNX1xN6V73oFfQXjcxnXdgHEQgfQKvHoKkm5GDYSXHSYgURDx+93SIOMQoAqMEXYCQO5g+p5kJn
	Hd08
X-Received: by 2002:a17:902:e802:b0:2ca:d91d:d3a7 with SMTP id d9443c01a7336-2d64b0c8bb5mr447392395ad.10.1787566156947;
        Mon, 24 Aug 2026 03:09:16 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d676761beasm15666115ad.5.2026.08.24.03.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 03:09:16 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>,
	Linus Walleij <linusw@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Stefan Roese <sr@denx.de>,
	Maxime Ripard <mripard@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH net] net: ethernet: sun4i-emac: Fix IRQ error handling
Date: Mon, 24 Aug 2026 17:09:01 +0700
Message-ID: <20260824100901.31675-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

irq_of_parse_and_map() returns 0 when parsing or mapping an IRQ fails.
The current code checks for -ENXIO and therefore does not detect the
failure.

Check for a zero return value and convert it to -ENXIO.

Fixes: 492205050d77 ("net: Add EMAC ethernet driver found on Allwinner A10 SoC's")
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/net/ethernet/allwinner/sun4i-emac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/ethernet/allwinner/sun4i-emac.c
index 42174249ef61..942454e29488 100644
--- a/drivers/net/ethernet/allwinner/sun4i-emac.c
+++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
@@ -996,9 +996,9 @@ static int emac_probe(struct platform_device *pdev)
 	/* fill in parameters for net-dev structure */
 	ndev->base_addr = (unsigned long)db->membase;
 	ndev->irq = irq_of_parse_and_map(np, 0);
-	if (ndev->irq == -ENXIO) {
+	if (!ndev->irq) {
 		netdev_err(ndev, "No irq resource\n");
-		ret = ndev->irq;
+		ret = -ENXIO;
 		goto out_iounmap;
 	}
 
-- 
2.43.0

