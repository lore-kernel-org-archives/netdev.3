Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ACF374E79
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 04:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780548070; cv=none; b=BvgtT3Fx5K3YfD4OaRw6e6xBFRVEHnY9IthD9+Fr3SLszW+a48tBzBQ1dnTjkcRngdQtoZT+LX3jegrG9TmtAbUw68TCBZHeJQqCxyllA6yM/Oer0rehiHJEeXLN9A8c7wxDSDbuhw1JWoiPsEq3RPeGTY0RAY4Eob6iV2Chjr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780548070; c=relaxed/simple;
	bh=0eh0KIQbs1qSSAuQkd0I9L7iFhTklV6ijuBWROey6iE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eg7mB4VKsd1u6OOM+etUq3ubNCjsT/487anoA3YQATOnHSSNqMxgOTt43KxxN5BG6zgL/LbzNt2FKjtcpZToQNu5iifXgEeBtEKp4CbPuhPK56T+tKamSsOdWlSVI2JLC48LFTPsXwdSz3WT8WpgCEGj6U53agSnRy/I892Prx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKkcjl4r; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKkcjl4r"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bf3781ca51so2946085ad.0
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 21:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780548067; x=1781152867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yYdWhysklbTaMq+vmdQBdY8EoKqbkXlWNN3QS92WACE=;
        b=WKkcjl4rEo0R/2bVQHQhF+2KrgYUhQxFwDO0nrd5ggTAnbkaYiuhg7oB92ZKBNjevj
         vfTvgz93bYw0az1N5L1zaR7GkwpSpwBuSS+bkxy+DAowNYnMOXUds9oqW2xS71jtcbJ6
         L+fTYm+SX4fvoqp6wZNgpOQVt598M0AcP6CiOyfPEXOZLzqk6o0oa8R/q1YVo3A1XMUB
         k37fufOQ1OnVAG/sDyyQUS/T8GBJ1AWHu9N4jJGpqWv3AwFTKsZ405s9Ig8LejyR9E/O
         gLrYHXf1qhr2fySrEF2lUZEYGh3UKYDv6cHKE3RxQkEm3n3KJOX/kGUmVuBLiUgswkCZ
         yh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780548067; x=1781152867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYdWhysklbTaMq+vmdQBdY8EoKqbkXlWNN3QS92WACE=;
        b=bdDC95SV06wF/AVv3fSRAODozIoM0iZsWES5E7Ey4yE1hxf45xMdZrHV8v0PWX+HZQ
         +P9C/YfkVs11yA5udrwMTpm82XBp4vkEA68UsGb8cZq+OzVQjTB9Mu6KDmXC6LNvn8K1
         FOiHMrEHI3fvm+xEH4K9+usYjIN12VTcQEje9qtaFK1DJjugw4PgAX/wqNHGGNXdGmAj
         e7zZUutDY6lHXJwrlO2iwSW1WUsHXQHKOQMMqCDI7Q9T4KKnC2k9B5pjC5ZrMHXOFAuE
         LmMVE8A16TwGihU35ZeP7XvAixoSWiygEv8OusLbs/ZUa+VBWN8GZhufK8vGNDbmDtVI
         o36A==
X-Forwarded-Encrypted: i=1; AFNElJ/AVDyyf8IUapXzRRGYZFBrTG7BKE60O/Eh5ZpGbWpUfGQpEi2Ssags8inurnBo1eMJQ4OlzBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRHsrxxjotQq6ruqpx6m/J+7avDgZiIWwHhhvGIaEUy0E7LFo9
	ehRau4fRjBOCnGq7iYSsPiAAbRrg82eu32kvqoFMydmKmX+FDzjkvb8h
X-Gm-Gg: Acq92OHljr5S2wKYnMtvtGJ650a892tjY+V/n14BU89Gus4XUHbpVcdzcM+AIcUnevO
	1hkRD1aVK/ABnfyYG/fCyIF8p3l5oErDO2XqDVzilGmJVYECmWzeUcsVJ3wcvX8pS1zLeX7JSsc
	EX+SbyLkg63Ud/7UO8QDKxrtboe1iDEengyW8pndSBIJKROeSN6UiGSzqTN5WkX9++OoJi2E6SH
	/6WILaKQr6WRYRtlr68mnbwzjk+8cgv6tsIo/J7Fd5qgqvJN57mcqmVpIQVcF4X0lqhtHHlzQxE
	vs2ncDnsfiwbkgnhfW8zqXQQl57/m4e4ERoeWOXk0Omth4fbh9ZyTmP1F+rxGtidmtyJoxG0sto
	5pRMwAS8vkDePY7bXNFfPZo+MPiONN9Ohi0tqn5aBDyX+8k6LUz+y7D848QvsksTKpbLiqMgRBd
	qNVh4eC79kUkoOUnHS
X-Received: by 2002:a17:902:d2c2:b0:2bf:21e6:baee with SMTP id d9443c01a7336-2c1641be20dmr70162455ad.28.1780548067020;
        Wed, 03 Jun 2026 21:41:07 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e096sm42344025ad.44.2026.06.03.21.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 21:41:06 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Kevin Hao <haokexin@gmail.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	linux-omap@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH net-next v2] net: cpsw_new: unregister devlink on port registration failure
Date: Thu,  4 Jun 2026 12:31:15 +0800
Message-ID: <20260604043115.1409134-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpsw_probe() registers devlink before registering the CPSW ports.

If cpsw_register_ports() fails, the error path only unregisters the
notifiers and then releases the lower level resources. It does not undo
the successful cpsw_register_devlink() call, leaving the devlink instance
and its parameters registered after probe has failed.

Add a devlink cleanup label for the path where devlink registration has
already succeeded, and use it when port registration fails.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Updated the subject for net-next.
  - Dropped the Fixes tag.

 drivers/net/ethernet/ti/cpsw_new.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 7f42f58a4b03..95b3b58db6e0 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -2050,7 +2050,7 @@ static int cpsw_probe(struct platform_device *pdev)
 
 	ret = cpsw_register_ports(cpsw);
 	if (ret)
-		goto clean_unregister_notifiers;
+		goto clean_unregister_devlink;
 
 	dev_notice(dev, "initialized (regs %pa, pool size %d) hw_ver:%08X %d.%d (%d)\n",
 		   &ss_res->start, descs_pool_size,
@@ -2062,6 +2062,8 @@ static int cpsw_probe(struct platform_device *pdev)
 
 	return 0;
 
+clean_unregister_devlink:
+	cpsw_unregister_devlink(cpsw);
 clean_unregister_notifiers:
 	cpsw_unregister_notifiers(cpsw);
 clean_cpts:
-- 
2.43.0

