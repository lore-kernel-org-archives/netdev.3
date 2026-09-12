Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837CB38423B
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 07:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789197711; cv=none; b=dbU0pk/xxrY9+2h9ihtjOBiz6aCcOjaxmWhqP2dmA3LkINXG545gjuTitH+wOkbYkj0QqInplkxq809JCP1a8Tyng+S+DquMkyv3LBkPmu4oo5RRw/L5b6V9LBpGLUwg33iGOR7r54tbdSSEJQUuXw5fYgm0z5adEiPNiXt/HRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789197711; c=relaxed/simple;
	bh=jW6DHewTV5Iuz02zyTooBDmtkJN0q02fQNJ9kMUp56U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jjU98XD/NPztHxrMZkb5LZfu3UC6R0DxNOP+ACAyFoCbWtmtsxOBkTdohWrfwLQdWfEk5/MAueNngyD9ksfhxY866oDdJp1JIFB12h0iJVKStyvJ77aJiF/zObD8uNKI6a+Koe8rrJcZq/Sb2nZHuVuNPHshKjhnUi43fuh5uac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYdCtGPz; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYdCtGPz"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49b965570d7so20801305e9.0
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 00:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789197708; x=1789802508; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vQoExyqpI1OF/5KNZtaEOZhfxUGnySYAtcYjoRnUz0o=;
        b=ZYdCtGPzcnJSI91Z93tbVXZaX/0I820KyhUn8fVIQVPzE6dB5ybpm7qEFkqTF80EyH
         8jgN8Nxm6BN4stAlim/ykr2j05tBLKQ/txLkf6S5HlUE9KV2q2MoUuXWRjphooxXX3mS
         ah9BaEQLCGymwQavmv1FN77hSz4p1u884rPGtfv8EGz9k+3fp809sX3ghnAjMFNGrIc6
         ih7GgXHVTwzt5zP5BDmlA1cqDrzMx+Cv92vosMGsvdvrH5MmzFoA5KVhAwzUW1s6j7W/
         /Xjwhi+/m9MOQbQ6DIAmCv0UQzeBuqQl2/WgMcvaa7oZLT1DGWW0wa/Guub2H1N08p6D
         kppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789197708; x=1789802508;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vQoExyqpI1OF/5KNZtaEOZhfxUGnySYAtcYjoRnUz0o=;
        b=gaJOpLAgp5nRotxvxbTI76ghNNL19yvBuhT9Ktj+iKiIhlUiIWLUyyQz8HnEsCanfn
         pq0qbwc6nv3UupQzSHWN6N9WzN6XoHheRIJmMsPqqtoNU1YBZiSVFTBuLxEkUjWQnivy
         eh/mOuqGEZu5jsmeayB9xolvmerq+UJ9G9kknksd6pXOJvWbcC1DiX559HXlhKUXFHUr
         bOs4ZCiVg+1RCQfwNz0Ic9nNM/b94wzdLcKMN+nbuyEZeSe6GB3CFeCpVwNChi+Hb4zu
         NcnXBr5QKVJr7ZTyagrOvUmQ3xz5/L+nFQAcHlIwHszq9hBmx/nF5ExFF7hIIX/EypWV
         q4kg==
X-Gm-Message-State: AFuF++l7LW/L0CJtzvohJ/fzr6LP2cR+5JBaONK26Oem2S05wGXZGmBF
	Cu+HspgAkEpMtKRJVpZn9sJc5hzBFkABHbBxnLBAENQr2hm1LcYmah10
X-Gm-Gg: AYBFou2jr4bJou40p7Db7DBZoS0TyM7zeYsbsByvwwLMlJEFGMVHcMr4cwV7mfcCakb
	EQ8FE7mluCx4oV7nsEavgGMLCUIhLZTQT/UXiHy/nbvCFZK4eZSGFZaEaatkWAgzSfaiDdgYHNH
	Ve4L132HZ8ESQaoqF+95LAYjLhTXvI2K5CA85Lk7AwR4eay5q6JowO90RYH5dhIesSXUu9vOJ08
	ls/LTUmxBVUqeXl1aXCdezHkNfRYjTv/gHlUXvG1/hdJ1N5dGTNG4TzRO8Qv3OJ82QV9XDQ6NuK
	T6G7mvX1B3wRxcBILruQ7EpAFINWTY/izhNn72AvNaYovbKTN2tdmU7L7Lq8y4SWT97nknOA4MC
	0Ci0Q4Rc1BK2NouP05Z0oYBlFeeH2ewfX/aBDcFokMdIMLmAeodJWiDRXttn/7Zxpu/0KySJX7L
	vgwlWWBbxrYPR5JVMfY7nJlI4pm8HS9jRujypjZBzOs0o2hOmnkysAi3piDJKWfPujCkQ=
X-Received: by 2002:a05:600c:1385:b0:49c:fc6e:8cbd with SMTP id 5b1f17b1804b1-49e619e86c6mr74779865e9.33.1789197707260;
        Sat, 12 Sep 2026 00:21:47 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32d5f1sm11844392f8f.12.2026.09.12.00.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 00:21:46 -0700 (PDT)
Date: Sat, 12 Sep 2026 10:21:43 +0300
From: Dan Carpenter <error27@gmail.com>
To: Yevhen Orlov <yevhen.orlov@plvision.eu>
Cc: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [bug report] net: marvell: prestera: Add router nexthops ABI
Message-ID: <aqT9h61WBcslE0gJ@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I don't know if anyone still is maintaining this driver.  Let me add
this as a KTODO in case someone wants to address it later.

KTODO: fix potential use after free in prestera_router_init()

Hello Yevhen Orlov,

Commit 0a23ae237171 ("net: marvell: prestera: Add router nexthops
ABI") from Oct 1, 2022 (linux-next), leads to the following Smatch
static checker warning:

	drivers/net/ethernet/marvell/prestera/prestera_router.c:1623 prestera_router_init()
	error: dereferencing freed memory 'sw->router->nexthop_group_ht.tbl' (line 1560)

drivers/net/ethernet/marvell/prestera/prestera_router.c
    1548 int prestera_router_init(struct prestera_switch *sw)
    1549 {
    1550         struct prestera_router *router;
    1551         int err, nhgrp_cache_bytes;
    1552 
    1553         router = kzalloc_obj(*sw->router);
    1554         if (!router)
    1555                 return -ENOMEM;
    1556 
    1557         sw->router = router;
    1558         router->sw = sw;
    1559 
    1560         err = prestera_router_hw_init(sw);
    1561         if (err)
    1562                 goto err_router_lib_init;

prestera_router_hw_init() calls rhashtable_destroy() on error but then
still returns success.

    1563 
    1564         err = rhashtable_init(&router->kern_fib_cache_ht,
    1565                               &__prestera_kern_fib_cache_ht_params);
    1566         if (err)
    1567                 goto err_kern_fib_cache_ht_init;
    1568 
    1569         err = rhashtable_init(&router->kern_neigh_cache_ht,
    1570                               &__prestera_kern_neigh_cache_ht_params);
    1571         if (err)
    1572                 goto err_kern_neigh_cache_ht_init;
    1573 
    1574         nhgrp_cache_bytes = sw->size_tbl_router_nexthop / 8 + 1;
    1575         router->nhgrp_hw_state_cache = kzalloc(nhgrp_cache_bytes, GFP_KERNEL);
    1576         if (!router->nhgrp_hw_state_cache) {
    1577                 err = -ENOMEM;
    1578                 goto err_nh_state_cache_alloc;
    1579         }
    1580 
    1581         err = prestera_neigh_work_init(sw);
    1582         if (err)
    1583                 goto err_neigh_work_init;
    1584 
    1585         router->inetaddr_valid_nb.notifier_call = __prestera_inetaddr_valid_cb;
    1586         err = register_inetaddr_validator_notifier(&router->inetaddr_valid_nb);
    1587         if (err)
    1588                 goto err_register_inetaddr_validator_notifier;
    1589 
    1590         router->inetaddr_nb.notifier_call = __prestera_inetaddr_cb;
    1591         err = register_inetaddr_notifier(&router->inetaddr_nb);
    1592         if (err)
    1593                 goto err_register_inetaddr_notifier;
    1594 
    1595         router->netevent_nb.notifier_call = prestera_router_netevent_event;
    1596         err = register_netevent_notifier(&router->netevent_nb);
    1597         if (err)
    1598                 goto err_register_netevent_notifier;
    1599 
    1600         router->fib_nb.notifier_call = __prestera_router_fib_event;
    1601         err = register_fib_notifier(&init_net, &router->fib_nb,
    1602                                     /* TODO: flush fib entries */ NULL, NULL);
    1603         if (err)
    1604                 goto err_register_fib_notifier;
    1605 
    1606         return 0;
    1607 
    1608 err_register_fib_notifier:
    1609         unregister_netevent_notifier(&router->netevent_nb);
    1610 err_register_netevent_notifier:
    1611         unregister_inetaddr_notifier(&router->inetaddr_nb);
    1612 err_register_inetaddr_notifier:
    1613         unregister_inetaddr_validator_notifier(&router->inetaddr_valid_nb);
    1614 err_register_inetaddr_validator_notifier:
    1615         prestera_neigh_work_fini(sw);
    1616 err_neigh_work_init:
    1617         kfree(router->nhgrp_hw_state_cache);
    1618 err_nh_state_cache_alloc:
    1619         rhashtable_destroy(&router->kern_neigh_cache_ht);
    1620 err_kern_neigh_cache_ht_init:
    1621         rhashtable_destroy(&router->kern_fib_cache_ht);
    1622 err_kern_fib_cache_ht_init:
--> 1623         prestera_router_hw_fini(sw);
    1624 err_router_lib_init:
    1625         kfree(sw->router);
    1626         return err;
    1627 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
