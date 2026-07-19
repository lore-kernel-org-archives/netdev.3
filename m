Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FA13BB48
	for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 12:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784465779; cv=none; b=RGhLd7fjt7DgA5dPcL6nAlHglpXKbGgzFHQuPPeAQErCQRuhnQT1dibtJ3sN/bIiCHfTJIrsBzUfDW6eyOczQn1TMjUiZnaD5x0mw+cDXOhDXO+JGi7YjxELChzxrymC07NBEWFM1Ncbj1+OZh2EwG2a659zHfYte0ZGgGM4tgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784465779; c=relaxed/simple;
	bh=n1zAO1jW4yVvRL07k2kgrVmGbmcyj6ikcTfAZVsVbnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T0eh7kgQZOCvceprKfDqxfzGPJONwAmioVaRw7EM+ObwslGND+mAs0mP++ZHNbFk5rhp3bZ2m8NRkdTLrFwA8IpA2QX4NqCKqfdDm/RHt0gypud0LJ7y1SF+qY2wt/T/5DI9DsflSNB7j+/2JNkHYnXul+qrM/yQYT0vy9tgDUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NK8haITe; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NK8haITe"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so8937290a91.0
        for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 05:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784465777; x=1785070577; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cBHTVFHbPFwIbhPoWqS470Iobk9r2Zi67JYQlymcIdw=;
        b=NK8haITeyTtsmJvJcxDsoN7DLfhzpZC79IJtoJETHGS8ELVTGVoCy6jrxypNYFJ9D5
         HgM2BPBKv41ulOYHoWscBL9pstvoLA5IG0jSPS4yBLexBA/MkAv/vGUsi0g9dG7h4tXx
         54KB/JyMXa3iPbqQok89Wo9VQqPIAkhcAD2a6a/ENCFgeayV8UjU3z5O9UOKwBjtVxw4
         ZQ3tRX4M2Rtmy57GUNO6YgjU/l3AndgfjPZyf/so+aT5GPO5HAciLIs/OpaMpaUepWu/
         6xL7lcqTw+dfut1e3gbZ9TpvjntC6DuKvL/oESd/5Qv0m856SzlOl9Qd52WyNBgIB3t8
         NGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784465777; x=1785070577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cBHTVFHbPFwIbhPoWqS470Iobk9r2Zi67JYQlymcIdw=;
        b=A8dg5fYMaR61ICTAnfvCsgj7pJiWzMPp+N94vdJsMfZ+hgcRS5yN3ZWNPxNXaHZON9
         o8aTplY2V+9NcwiRhge/UuwiZGJTXnobT1mCfNejb3EPoxDoGzPmco49jvehvAacYWzX
         9EtmAEeEQNXZ+afsiDYr1l1QKzJP7JgDDaMXCzcTuanZuHj1NKakK39lAosGN0FdFlpC
         Xq3QvT/24ID7YiGAy5TEJiG2hV9woaAU21r9//vTN+k6rcmCE1l1h3YOR7Eo0xwew63L
         upgBQggliVdNcdVshSFmWqTDbM4U1BnDsuLlX3Ywlfo597zqxpCH0UxsCzxFKFoEPfuO
         +qZw==
X-Forwarded-Encrypted: i=1; AHgh+RpKkEAnjJHu60LR+y7Pg4WSPLtKagGwD1oZj767dsqdcWdgWacREgMcS4MU7rsNmxpqjaXOJB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZi96AIyhBdt2GhMnaCEWlxIiRysbWz2zyMZxT8XgzyBJ+i7P5
	naRLS0atznGpR/miFO3Vu3eR0GnECtf7Yr7Q6adBaGMpR6AWCJ6ed7Dd
X-Gm-Gg: AfdE7clfRHPOA3RLTxiz9UPDTjPYcoJurJJ5ktu4SY+NbFwj5ZqhM75SFfXnjO6qLQR
	vMCxwVMWY6AHdk1MhU+r1O9kDON2Hd71QNGStJhlMTy3/szppg8nwLZ3D4umJsWRKavg3cFcbud
	YB+CbFjlIvEZdgmGt3E3BT3At3j8t9P5OpE+m3/frM1xaJxSbuKFOt+Mf+aQ+VuvZ6faE3TofM1
	wMMIVEgqmthaRvz/uzpDclC2rp1VAAQbipsMvsDh5esmV+oJ7kGSNiGNtvFQFVjvYmH8IAdkn39
	LbRti3pQcXI9umDz0C1zfGtdGe/bUWNWpRvIAMlFc1qW+L83absvqZoyd2P8EZrcRYEHM1mk9V4
	XdxUhzqbJ+4NrImdWu6eSwnk2wwjJP5nbNIP7B6zVY7ssYBM75GpoA12oKwJW5g783bIBUqZTPR
	WsIGY=
X-Received: by 2002:a17:90b:5547:b0:38d:fda6:4873 with SMTP id 98e67ed59e1d1-38e4b441269mr10885100a91.10.1784465777270;
        Sun, 19 Jul 2026 05:56:17 -0700 (PDT)
Received: from [127.0.1.1] ([2404:f801:8028:1:edd:423c:25d9:f95a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2cbb6e8sm20990052c88.9.2026.07.19.05.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 05:56:16 -0700 (PDT)
From: Subasri S <subasris1210@gmail.com>
Date: Sun, 19 Jul 2026 18:25:46 +0530
Subject: [PATCH 1/3] usb: chipidea: Use %pe to print error pointers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-usb-ptr_err_patchset-v1-1-85f7f2e4fefb@gmail.com>
References: <20260719-usb-ptr_err_patchset-v1-0-85f7f2e4fefb@gmail.com>
In-Reply-To: <20260719-usb-ptr_err_patchset-v1-0-85f7f2e4fefb@gmail.com>
To: Peter Chen <peter.chen@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Duncan Sands <duncan.sands@free.fr>, 
 Chas Williams <3chas3@gmail.com>, Minas Harutyunyan <hminas@synopsys.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Badhri Jagan Sridharan <badhri@google.com>
Cc: linux-usb@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, 
 Subasri S <subasris1210@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784465765; l=3053;
 i=subasris1210@gmail.com; s=20260709; h=from:subject:message-id;
 bh=n1zAO1jW4yVvRL07k2kgrVmGbmcyj6ikcTfAZVsVbnQ=;
 b=/EAz0qSfa1ZrMbHJH8QpbLX7wPvSeQecXMcU4Gf/i/q6LbRiAJ+x12SC7uRmvXyky0/DKO7rt
 pqai+Ji7fWLBLYYsUDJPeM5oyFKLNgt4Z1de4LkHeqmHlYvJzx6AW9s
X-Developer-Key: i=subasris1210@gmail.com; a=ed25519;
 pk=6C4wavGFy/OsR8yQQKNWuDXoYPHp2L3sfgNfyzTruTk=

Use the %pe format specifier instead of %ld with PTR_ERR() for printing
error pointers in imx_get_clks(), ci_hdrc_imx_probe(), and
ci_get_platdata(). This prints symbolic error names (e.g. -ENOMEM)
instead of errno numbers (e.g. -12), making error logs more readable.

This patch fixes coccinelle reported warnings:
./chipidea/ci_hdrc_imx.c:452:5-12: WARNING: Consider using %pe to print PTR_ERR()
./chipidea/ci_hdrc_imx.c:468:5-12: WARNING: Consider using %pe to print PTR_ERR()
./chipidea/ci_hdrc_imx.c:222:4-11: WARNING: Consider using %pe to print PTR_ERR()
./chipidea/ci_hdrc_imx.c:222:24-31: WARNING: Consider using %pe to print PTR_ERR()
./chipidea/core.c:684:4-11: WARNING: Consider using %pe to print PTR_ERR()

Compile-tested only.

Signed-off-by: Subasri S <subasris1210@gmail.com>
---
 drivers/usb/chipidea/ci_hdrc_imx.c | 12 ++++++------
 drivers/usb/chipidea/core.c        |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 56d2ba824a0b..7bfe37ed68ae 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -218,8 +218,8 @@ static int imx_get_clks(struct device *dev)
 		if (IS_ERR(data->clk)) {
 			ret = PTR_ERR(data->clk);
 			dev_err(dev,
-				"Failed to get clks, err=%ld,%ld\n",
-				PTR_ERR(data->clk), PTR_ERR(data->clk_ipg));
+				"Failed to get clks, err=%pe,%pe\n",
+				data->clk, data->clk_ipg);
 			return ret;
 		}
 		/* Get wakeup clock. Not all of the platforms need to
@@ -448,8 +448,8 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 		pinctrl_hsic_idle = pinctrl_lookup_state(data->pinctrl, "idle");
 		if (IS_ERR(pinctrl_hsic_idle)) {
 			dev_err(dev,
-				"pinctrl_hsic_idle lookup failed, err=%ld\n",
-					PTR_ERR(pinctrl_hsic_idle));
+				"pinctrl_hsic_idle lookup failed, err=%pe\n",
+					pinctrl_hsic_idle);
 			ret = PTR_ERR(pinctrl_hsic_idle);
 			goto err_put;
 		}
@@ -464,8 +464,8 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 								"active");
 		if (IS_ERR(data->pinctrl_hsic_active)) {
 			dev_err(dev,
-				"pinctrl_hsic_active lookup failed, err=%ld\n",
-					PTR_ERR(data->pinctrl_hsic_active));
+				"pinctrl_hsic_active lookup failed, err=%pe\n",
+					data->pinctrl_hsic_active);
 			ret = PTR_ERR(data->pinctrl_hsic_active);
 			goto err_put;
 		}
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 07563be0013f..09db8a4eace2 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -680,8 +680,8 @@ static int ci_get_platdata(struct device *dev,
 			/* no vbus regulator is needed */
 			platdata->reg_vbus = NULL;
 		} else if (IS_ERR(platdata->reg_vbus)) {
-			dev_err(dev, "Getting regulator error: %ld\n",
-				PTR_ERR(platdata->reg_vbus));
+			dev_err(dev, "Getting regulator error: %pe\n",
+				platdata->reg_vbus);
 			return PTR_ERR(platdata->reg_vbus);
 		}
 		/* Get TPL support */

-- 
2.43.0

