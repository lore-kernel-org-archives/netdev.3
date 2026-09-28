Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4542437A82E
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618474; cv=none; b=no+zEYhDN7ymRzt6DeTx9xKlXpR8gFpkF4MPc9HB6b1LH6eL4DBttBHDUrwPLOZgu2eViGXJkgGANZYCA+VEQhzrvTZqSlihQ2Q2j3oOTf5oHJ/ZBuiLpdqAApur88FVrX54byWhfq+1/Mdq3ITi6NuyfiH9x6YLKfgSIor1w+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618474; c=relaxed/simple;
	bh=VqTYFi/eyWM1jAh10NBafh0lPIMca3wdE3LC8j1ZDIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cx2RSeo31NmNPgx/YOf214C9CSCic7VF7LCQ74dfM2sCsg/jkZd/v4ymr/xMGqQ7FMVxoh6GYabaWmmgDQm/Nh6CP2GPwSkjNxQSAvH8pbPScc9mdBegrnGBXtyw31WcPj2d86CB8Otyxu9zY1gWzow1Km32DyVEeLMWZ15KJiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maDFKOpr; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maDFKOpr"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a00dc9fce3so2315e9.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 11:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790618471; x=1791223271; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xKyohN9e7byeyTbh/uzQgz3AjEcfe1NLsCdKALHGcp4=;
        b=maDFKOprDg/wkoZx5e6IrFQrsete/SvqB+uMsNrzcgIrc1rtBEr3VCk6hWxg9lTZTA
         huuihTb+FepU7OzkC42uvMa12/lRZ8Kfs+FLs0y2bdeFZLMahw4qKFAKT0zh3MohLGn3
         xiDyQWuUA5s+jKLA/iFYkZTW+7e+fG2fkK4aJ8Lbiv91xFtg/6heoL2CaH9SWA6lPSDg
         sPlV+Gq59vkm1bQXMYSlKDP/bYFPhuPTmrgULYflHbd3uThJYkzfzwxOiTYdZTwpFEpg
         17gNr/ELlp2I8UfwHfdmuAmgHZkh6veWV9pTdaEGofARsQfczFaXgCq26Habb8euXNqo
         R/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790618471; x=1791223271;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xKyohN9e7byeyTbh/uzQgz3AjEcfe1NLsCdKALHGcp4=;
        b=EBmMrXiZC6ejHGO9XXwiPyQxtmD5IpbK4OodEgwhs4kYfSBXboZaQJ607A+g85qNv/
         fhTtx/Q5Hz2U1xdeGKKZY1jcM9xzdYHpyNYVkQQlwVsdXwcruB9zn5eOdt2ptGKZt19h
         ht0JVGHWoKAu9N9P5+dARa5gjZJP9U0rNUPfH08ZXpUYR7cyqqEHKUCAe05R65UIT2XV
         cF6tt6WGVGw4QeM+5TEfTWgX5VJ5qAeiSEKVDC/jqWJZijEJXiW6gfcQ9IAGgDBzHHKi
         ZygHWGgKvJU23PbIdfWcvdxZBYoNrfHvQvwiiRQ7fVB1UkgtvlT6vcgiE2QxOi2r/iHv
         31+A==
X-Gm-Message-State: AFuF++kshmhIVdlnKRYjAaKVcfCl3BfCzqnUgRE0xJvFlnWXuLe2LEYr
	gbJ0DGmfF3mtydosQYXb7NGkgVMlOwqgssSJrSsK0LuMxwii/JnO+Hzk
X-Gm-Gg: AYBFou3Cf1rFtov3oeeQcKpQohGeY6XOVn3NNRR7T0YCH9749nL9VErqFEaO8nXUYCV
	QOhVy9DJK7W7MSOSbruESfzsYiKBN4kXoGoy8T7YvSD13mR4DSzzfviQ8lrh1ngUAb5rJn1B+h6
	YLbd840ufgE6qCJC8AEhjVBk8i9drttn8uaoajaRVf/p+QFzY+bbfq/eksb2+ZQGtJha2gMfKPe
	AxJ3yYCQ2VViusGL7CalnbzkVEtCIIrJhX6HJK2jsuifcPggcxwdITiCzuJDIw/e0bZMnfVZik4
	1yBqhapljfAnnle1jpnSxOmD7tV8e3cjfIM6UFHnwiTAuVeysOabDXJt50qNI60VcFtIP6AIVYo
	gySVxOd7OBAAQ9SqOMMUzdPx3igyHaVVQw5qVfolIe7yKWdzwc/JHdEVtDjRvPggQe6vM8OX+I2
	mzTRdhNKnzcGEb6pOJS7r2o8ch5LugRMakt4WUIHyH13Dj++zYcbB/
X-Received: by 2002:a05:600c:3b13:b0:49f:ec10:8ca1 with SMTP id 5b1f17b1804b1-49feddf6bedmr190540545e9.2.1790618471240;
        Mon, 28 Sep 2026 11:01:11 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::5:c231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf8fa5bsm11695985e9.6.2026.09.28.11.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:01:10 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 28 Sep 2026 19:00:04 +0100
Subject: [PATCH net-next 2/4] netconsole: read np.dev under the RTNL in
 local_mac_show()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-netcons-fixes-v1-2-bb5ffe5e698a@gmail.com>
References: <20260928-netcons-fixes-v1-0-bb5ffe5e698a@gmail.com>
In-Reply-To: <20260928-netcons-fixes-v1-0-bb5ffe5e698a@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matt Mackall <mpm@selenic.com>, 
 =?utf-8?q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
 Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.15.2

local_mac_show() loads nt->np.dev and dereferences it with no lock. It
can race with the interface going away and netconsole_netdev_event()
eventually calling netdev_put() and freeing the device before we
dereference it, leading to a UAF.

The window is only a few instructions wide, so I could only reproduce it
with an artificially widened window between the load and the
dereference:

  BUG: KASAN: slab-use-after-free in local_mac_show+0x4e/0x80
  Read of size 8 at addr ffff88800e990458 by task uaf/130
   local_mac_show+0x4e/0x80
   configfs_read_iter+0x187/0x260
   vfs_read+0x453/0x5a0

  Allocated by task 116:
   alloc_netdev_mqs+0x78/0x830
   rtnl_create_link+0x53b/0x5c0

  Freed by task 121:
   kfree+0x159/0x420
   device_release+0x77/0x120
   kobject_put+0xb5/0x160
   netdev_run_todo+0x420/0x850
   rtnl_dellink+0x259/0x5b0

Fixes: 0953864160bd ("[NETPOLL]: no need to store local_mac")
Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 7dde00eb8e98..5f4311726d11 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -900,10 +900,17 @@ static ssize_t remote_ip_show(struct config_item *item, char *buf)
 
 static ssize_t local_mac_show(struct config_item *item, char *buf)
 {
-	struct net_device *dev = to_target(item)->np.dev;
 	static const u8 bcast[ETH_ALEN] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
+	struct netconsole_target *nt = to_target(item);
+	int ret;
 
-	return sysfs_emit(buf, "%pM\n", dev ? dev->dev_addr : bcast);
+	/* Hold RTNL here so netconsole_netdev_event() doesn't tear down np.dev
+	 * from under us.
+	 */
+	rtnl_lock();
+	ret = sysfs_emit(buf, "%pM\n", nt->np.dev ? nt->np.dev->dev_addr : bcast);
+	rtnl_unlock();
+	return ret;
 }
 
 static ssize_t remote_mac_show(struct config_item *item, char *buf)

-- 
2.55.0

