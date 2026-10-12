Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EC44B95B3
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 17:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791824644; cv=none; b=Ir9rbSp8o1AV0fN/s8BWek+i/aLmK7fjL1vG7e9ccdNt06AsXpVPEjVfQRr/q5uQvuBgA62e97NcaWxP4UhFHr2daINv0D4RgUbl5A+74J47sahVBn6LjFdq/afqMMFi4sm3SqaTyEWdAZ72HveMIyS6Qrj59oSqC1Af5MwTEcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791824644; c=relaxed/simple;
	bh=wScoK7Zeb+ddAnfyXZ0SLwbxAg0VVSeMqQZ7XRKBFrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cvwviXIdZbScx85/WiYvaBEPTl0tN5RvY8bsxlSKqbLkDIOle7nEwpTm0CNk41IQJvHVdnIf6349r48h/jyxFXKh9yYpJj41NbFOittS2EipNwpRoVmP3AiXXv/IAJ31Cb7lL+hQ2NVw4phW1/hxFqXYnPL50o/MR7CbYgplXfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irC96f/L; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irC96f/L"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49e6b771d06so5190175e9.2
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 10:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791824641; x=1792429441; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GWZnbEyxANyUwQJq6+wlCh4sagVZfQm7Gqv7rIje7bs=;
        b=irC96f/LWcf9kEXQOzCoT2MyCfaE9vI4sIWW4Cfed+qIJEOXEMH/1upIx+eb/2PDQH
         OeTYzTnp7ohCoioo4ch2yeTAF5OQvxoQ3Dssm7WX84ddnFiY72wzekq6je5sA7f/dewY
         zDtMazerPHyHxyWjsY1XKB5qGAMRkKYuv5tEgGB5ob42+xmF1O3zPtW671VGShR7QsmF
         rk3YT/RnJ1M8N1jFlv1M7r8Bi1ok+WvKiF9OThG8iSLOy0CfsL0L9ZTFBWe774YTk+XC
         X76Pdh+p2ifxeYEkPTg5BasQ7Da/YBAwygap5l5xWYdqR1xOicQ6+5ZnGJkIDbxLZ0Ox
         2RAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791824641; x=1792429441;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GWZnbEyxANyUwQJq6+wlCh4sagVZfQm7Gqv7rIje7bs=;
        b=G97thGbOAxcDyknYzLHlsOg2FpcHTcZu7gLnmOKmKi7YkrMvEMLFK53aFgEKKPf/mZ
         uM+9nRy6GmPk6p8Se0wYybcqPIl5vH8+ztMSj8YmbHfIPP7T/t/lvJsmEahgDGDGwlw9
         vzLU2Re/zEaqcsuvpyzyp96Wqq0kZDzVZFrNF5eT+lkCW4WshfJKxCKFF2RGlVkba4Nv
         F0k6AwRLa9kDjNEAE/nn5z2Nct+cr4zSEbE9c5uEyFovjaEYx4ggo+K7pNpycpaei86N
         lMLL2xSMLAejeQwxdhCvESiO5/0oFITZ8pqlHThSYcZcelm01jS19PpjWkRIigiFNQwa
         RElQ==
X-Gm-Message-State: AFq9FYKiPE7QJa4MUnD2gvpDpSahdbMkUKAH2LyY2qT4eznSkAJb6P6k
	BEXuDyOwyNYphCRZ+9A3AFdH5udaV6nsjNIFz/7SFSU+L6ETiHWBU+JQBq9d2bb3
X-Gm-Gg: AYBFou0yL8k/NziWxMAk+gtenYh5Sszk6lbHve33Sb9EH/OFoqvCG+mgB4pj/GyGzm9
	ArnjSDYvsHx0U+zdwwm7wE5J2WAqGHeFqacA1mUCwnKgyeStymL6ohtDa7MrMYc9q91zuSTSXqu
	YX36gz2vElXTkMkmGGC7ce4WdC2O3shwlFvyaDUSLHxJ0V6gwfYqhmRwY4Mvu9r7kcO6ocnjcaS
	6zx6D3lCGBfx/7bsyx0tHtt33igdcEvGUGfPaE1feoyR5IZr6Kfq4HZPa3Bq/Jg3R3bnm/u20p+
	uywPyU15gd+Jf/T+1nxBlAEFIhk+0W2ZKKRrrDeWursvQndRabG12YQ3LPTwlm9dmmtD9L+aIGb
	pWy7F9QcK5ka1WZLGEpsC19cx6FBMGWvzGM9F0rXPv9tFK5JJMLC5TBx8MqwTPi0INwgjJoUF0m
	YZRIMvCzu3BJTiCgdsx81wrW41DXidpgGti9skl8iNFi40lBy6lagQ
X-Received: by 2002:a05:600c:3b29:b0:4a1:813f:2a5a with SMTP id 5b1f17b1804b1-4a18e477757mr189549095e9.2.1791824640898;
        Mon, 12 Oct 2026 10:04:00 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::4:c555])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf2e0dbsm319829985e9.11.2026.10.12.10.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 10:04:00 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 12 Oct 2026 18:03:44 +0100
Subject: [PATCH net-next v2 2/2] netconsole: remove unnecessary target
 refcounting from the netdev notifier
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-netcons-fixes-next-v2-2-ac8ec4c62edb@gmail.com>
References: <20261012-netcons-fixes-next-v2-0-ac8ec4c62edb@gmail.com>
In-Reply-To: <20261012-netcons-fixes-next-v2-0-ac8ec4c62edb@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.15.2

Since netconsole_netdev_event() holds target_list_lock, there is no need
to also protect each target with netconsole_target_get/put()
refcounting. There is no way a target reachable from the target_list
would go away while we hold target_list_lock.

This is similar to commit a6d403ac9689 ("netconsole: remove unnecessary
netconsole_target_get/out() from write_msg()").

Since this is the only remaining user of netconsole_target_get/put(),
remove those helpers as well.

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 953a1da07186..e40ef6c4f761 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -262,23 +262,6 @@ static void __exit dynamic_netconsole_exit(void)
 	configfs_unregister_subsystem(&netconsole_subsys);
 }
 
-/*
- * Targets that were created by parsing the boot/module option string
- * do not exist in the configfs hierarchy (and have NULL names) and will
- * never go away, so make these a no-op for them.
- */
-static void netconsole_target_get(struct netconsole_target *nt)
-{
-	if (config_item_name(&nt->group.cg_item))
-		config_group_get(&nt->group);
-}
-
-static void netconsole_target_put(struct netconsole_target *nt)
-{
-	if (config_item_name(&nt->group.cg_item))
-		config_group_put(&nt->group);
-}
-
 static void dynamic_netconsole_mutex_lock(void)
 {
 	mutex_lock(&dynamic_netconsole_mutex);
@@ -300,18 +283,6 @@ static void __exit dynamic_netconsole_exit(void)
 {
 }
 
-/*
- * No danger of targets going away from under us when dynamic
- * reconfigurability is off.
- */
-static void netconsole_target_get(struct netconsole_target *nt)
-{
-}
-
-static void netconsole_target_put(struct netconsole_target *nt)
-{
-}
-
 static void populate_configfs_item(struct netconsole_target *nt,
 				   int cmdline_count)
 {
@@ -1980,7 +1951,6 @@ static int netconsole_netdev_event(struct notifier_block *this,
 	mutex_lock(&target_cleanup_list_lock);
 	spin_lock_irqsave(&target_list_lock, flags);
 	list_for_each_entry_safe(nt, tmp, &target_list, list) {
-		netconsole_target_get(nt);
 		if (nt->np.dev == dev) {
 			switch (event) {
 			case NETDEV_CHANGENAME:
@@ -2010,7 +1980,6 @@ static int netconsole_netdev_event(struct notifier_block *this,
 			 * notifier.
 			 */
 			queue_work(netconsole_wq, &nt->resume_wq);
-		netconsole_target_put(nt);
 	}
 	spin_unlock_irqrestore(&target_list_lock, flags);
 	mutex_unlock(&target_cleanup_list_lock);

-- 
2.56.0

