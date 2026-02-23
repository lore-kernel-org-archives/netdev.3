Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB0737BE83
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 22:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771884310; cv=none; b=kpMPZK3o9+SkLVYFAVM0m2xLSZ/8BotbKLIXSfTF+BsP+ZNtydzkTw9mXmqvZR96z021RZ6aMxkhOW54lTfV7OJVEsegmiDE5xoH8U772JrCkKW2zjxIl3W5NyFMWNMUvLGBzh5q1eKKAL5DHIsw3VohMvzYXklqZuA44zC4mfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771884310; c=relaxed/simple;
	bh=lYSFLw0xah4h/+68xrRS+X6hzYryo1L2cUiMAzxuTP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DeV8alrA4knyfIX7fXazzIzOm4E5OqVInJnorJUHhWhgcYrb6g2YwZk6HLIIjbyQR7LGlA9l7yF60z6HqXDQuvWtKLRT6cZsCv/ULFJuwkPf/PQ9XAxflbWY2taEuMF2WCZ0WH6nLLXGouEHqPgKhFJ9V/NvTQEsgh3G12eo8zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QowjejyR; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QowjejyR"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8876d1a39bso668012366b.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 14:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771884307; x=1772489107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgYaJHOEUtfkRSeV4/ucyw2w3tzEF0ffgSH0n+B20gI=;
        b=QowjejyRTTc9BS6FZeN7E9Y5jwGARU7qjwgy28bIrUw0z4c3MdRo77dMOjApo1nD4u
         PuE+7WdMXXadbLmVAlEskYfZbW5oUTYSbeSzWsF4HPjeZDp9B+Q1DKNBr+cHCZf40CWV
         H+IcDC8xlwbzHhw2YtsmhWag46ZaSoxKJ6o8wUtV8grqiyBSuT132lVUPnv4aA2aQ9sr
         +PhidkZOwx/MTQpvNuy4JfUxyeclUnYH4fvVhLLkZqfcadQa1NQHhewdOifecgnRuMYx
         TFjbTXuyGZDQXx2lEy+F3/IsPHKy6Td2OaHfhAbBLnIpJiq3r651EG3o6T6OuKEX9yM0
         LF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771884307; x=1772489107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GgYaJHOEUtfkRSeV4/ucyw2w3tzEF0ffgSH0n+B20gI=;
        b=ryMiH9jC6lTD/wVM+D+w18lAfQ1EzKv4owMaFvBAq+Xltv9Vy1f+KqiAlISstBvGia
         88d+B1x2CA7pDg51Czf8HgMEnqXBT7HPWsBLXgUZpYnoGV76DFbQ4x8EunPNYrlni3PY
         Ocv7sNBj6KDAzjtCa+WcBDvaSD/Qyvk8l+OxLVYECcT9SBPzWI7nP41qlaaX2rhn/c7d
         etUzlyFqa/4WooBZha2Hthwa0/SuTK4skpU6yd9izLeItAoAkZbSxZKvuI6eldWTU6QN
         uYNus8UKQNrbcJa9wckcTgTVhQq+73oqxKuw8VauNORa4O4JjAcyjBxhlX26D74sHNaq
         LrVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRwbKSqhxipLbgRxssR9SveVi1e3rzrVVjjhvMHHCZF9fqk/g8MUwcTiubU+w7wNVdwFOfiog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcen8wm1pXEUM5pty3vwI9uClcRkBw0tki3gsXj+NjA2CNIZfa
	H+aNOO3KPb46s0ylBI8GphYiy9B5J6KkSt4/zitTtDEIBmdfRC5UngLx
X-Gm-Gg: AZuq6aLrIwzn2sX/dH0hsNVGJzD4n0Xpq0AAoOO7wgpr3wdvd1T53S+hON0J9Qr6w71
	N0USCe/dcKPBwKbzRrsq7JfJYbfXof7MLWkWUjp3Fupivp38dhEA8I2QOwTf5ogFpCpKrvnb/xI
	kWqkX2o3T6Agv4sncPZOiL0yTzH97RgWvlmlR3ZYRs0FX81rBZ72/MGNqnUSF9BhoXAyweTAsyv
	kTG6b3H6wlx9bo2KPLW/kDqsc5/rYWS9ssuu96Pk4ge+h2Af8NOVAik6MnN13mVaHKXgkpgRgpg
	8dWhzDnZd83jVK/CsjKIZC97NAQk+XC8VH7pnprQjM8pp+pc1xrbRKOijQbTjuE76ZQ1QWivHsJ
	2bWKCJB3Sz2jGrlud2TYOK7qED9MVAG0aECAR62fbpPjbwh9eQv5igre6gHKR6toT/y0Eid4HaT
	JskQV2gq48WyQEWo3VspPRZLFdm66ukWn1uEphQPN5dIe6GnQCSnKVsE9PHzCLxrrp5sBUAHTK1
	KVbRAD83YYrkroJZv3J4Fh28QMUiYQSnhqUcXzYI6IQ1M8yvJhZHBSNBCyOXl9mGYsyrAw=
X-Received: by 2002:a17:907:a4e:b0:b88:317a:3f40 with SMTP id a640c23a62f3a-b9081aeef7amr610431266b.38.1771884306860;
        Mon, 23 Feb 2026 14:05:06 -0800 (PST)
Received: from cs-874966990260-default.europe-west4-a.c.i2f7e30109524dc12-tp.internal (230.86.12.34.bc.googleusercontent.com. [34.12.86.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084f191b9sm359394666b.67.2026.02.23.14.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:05:06 -0800 (PST)
From: Artem Lytkin <iprintercanon@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Trevor Gross <tmgross@umich.edu>,
	Russell King <linux@armlinux.org.uk>,
	Miguel Ojeda <ojeda@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Lytkin <iprintercanon@gmail.com>
Subject: [PATCH v2 2/3] staging: most: dim2: use dev_err_probe and proper error codes for clock
Date: Mon, 23 Feb 2026 22:05:03 +0000
Message-ID: <20260223220504.2102-5-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223220504.2102-1-iprintercanon@gmail.com>
References: <20260223220504.2102-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace hardcoded -EFAULT returns with dev_err_probe() and PTR_ERR()
when devm_clk_get() fails in fsl_mx6_enable(). This ensures the
correct error code is propagated (e.g. -EPROBE_DEFER for deferred
probing) and avoids log noise during probe deferral.

Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 drivers/staging/most/dim2/dim2.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
index cea1ba99caf7..e4c8b4995c61 100644
--- a/drivers/staging/most/dim2/dim2.c
+++ b/drivers/staging/most/dim2/dim2.c
@@ -921,10 +921,9 @@ static int fsl_mx6_enable(struct platform_device *pdev)
 	int ret;
 
 	dev->clk = devm_clk_get(&pdev->dev, "mlb");
-	if (IS_ERR(dev->clk)) {
-		dev_err(&pdev->dev, "unable to get mlb clock\n");
-		return -EFAULT;
-	}
+	if (IS_ERR(dev->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(dev->clk),
+				     "unable to get mlb clock\n");
 
 	ret = clk_prepare_enable(dev->clk);
 	if (ret) {
@@ -936,9 +935,9 @@ static int fsl_mx6_enable(struct platform_device *pdev)
 		/* enable pll */
 		dev->clk_pll = devm_clk_get(&pdev->dev, "pll8_mlb");
 		if (IS_ERR(dev->clk_pll)) {
-			dev_err(&pdev->dev, "unable to get mlb pll clock\n");
 			clk_disable_unprepare(dev->clk);
-			return -EFAULT;
+			return dev_err_probe(&pdev->dev, PTR_ERR(dev->clk_pll),
+					     "unable to get mlb pll clock\n");
 		}
 
 		writel(0x888, dev->io_base + 0x38);
-- 
2.43.0

