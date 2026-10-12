Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46BE48F85C
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823343; cv=none; b=VtGcIZYtVYn/vxzJ0afgtvUEmLq6PBa3DzC2LKS9IXAnFDv2Tpv+SYnPxaXkSZqD7WXaCVYo/cYnxmd8xHIfMkY91AaVpmX3+3C4ymXZ3jyeOe675VJPUOgDepkGQh8S11o52NONfbfAwzVw3I1aVAnLmEMrJFMKu3ERWFBFcjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823343; c=relaxed/simple;
	bh=EXC48ns2jWgAZUb2XLn2yHi+H3UJwk46qcn+bKkeKxM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BMOLkQw11vH3aN+dvsInF7KojBMcS1XCauXaPBsvd8MDcqMdznqPMLsLBqHJc9j+npWR8ES7GrVwAOx5xo+KMsWCZ29Xrl4UOBy9pj91w5lGGmBmSSb7CWM18pfCWkTieuGhI6VtulWWB1e04FSZ2hUM3MpYmj17SoGO3zgIbAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bj8ZEyF7; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bj8ZEyF7"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48c5b7d5865so167712f8f.2
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 09:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791823340; x=1792428140; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DbH0x+1VGrxmmG/67GKpm0AlwDDsWm6hJsBQAAEfQEQ=;
        b=Bj8ZEyF7mlJrBzYLeQpdXMfcbdhO/zeAYnHsrwj3wFPp46ekmGdCF3CxZXonS1GgM5
         NXZN54NTi/8KZupzxcialHuP7zDXpMafHwGI6q1qHjRu7XMyUeWRPtCqQYSKZzCEaEi2
         tjJoTDe/EI3VqB0dG8mQdIfm9f4eqy9LI/kY7iz+jWp19vQUEG7saVQzbA0cw82ICW8Q
         dJvwAinHrLB6YB9TV5bxDXe59vn3fZtZai+GzDUM+xpdUPifwAv7LcOUfVwpbCP3fuvf
         fThxrplRJtHcO40A1O19PiaSeVN+c6aYh3T2PXswW5qAB/5U+NFpu0YjPsUW1zggeffT
         vxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791823340; x=1792428140;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DbH0x+1VGrxmmG/67GKpm0AlwDDsWm6hJsBQAAEfQEQ=;
        b=HiyijmjMWwW/2QI0TNTVB4vrdjcbWFyoUHhfN7TJTa+j0cDm+KhfsPYt7hPxZj32bS
         cveqi1P43QrBHz2NhS7nZwaJndMiFo8GVFMtkSBiKAgCzCflObI9GUOgDiHdc8gKmGo0
         47mgN1A1Ad53H8NFUA/wwwhH5q6EWf9J0bmlL+hciQziTfJP/P/ZtlolvsjF12Ii10b2
         58msxkQuDJFSHeZwdPicw4KpYIzbPyGCx/ui321CCMZFjQ9klt8xGS4pASWqmX424CuE
         6FoDwnqwC0BrWJ3hey2Z5I1lHr7ZcexYVp8/Yq/d17lUlnw1Bk95yXHnc+IxA+SX90eT
         nKbQ==
X-Forwarded-Encrypted: i=1; AKwUvBwr6IzayMOJzb3o5+01dpJV+XDEes85qnOkoGpso8B5dCiUngPZglwGuRv4Y/1PUTerD4mJPsY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLeMuk235Ihn/4p6up2LXh9gFntat8PoGLy4KlvzPGDmY5QtM0q
	jgP4k7zblzeaEpr0u5h5nYctZeGJn/4AaMqaBnYQoZ+BS7KG/OxdErwh
X-Gm-Gg: AYBFou2xcn0OxKWKSlI42LAM0tDQw9dTIQCbWwOalcc8wbhY/JbS3P9uwElyGkB0vpO
	PqcmzF23sOVXsGXp5e8Sz037XmiQB0aPoe+xJgBUR5IfOuJ0RrejayTECJAPlDY7jaSE1hIqS80
	fddEHQ7N4UzfaNOdkveIRYhWDEn+lQL7RRGC7ufXQxmVxWw7kRWrHdttO+4Xg5xVVHe4C8sVvc4
	wynl3aSUBnacKiGvb6DflY+pbl+qUpFMIuO5JSZDxtDjp/l6YN48r3wuRCBp2uakuWFBeM9/pAv
	ieY0AA60EEvQ+TCkUAxTOi4kFXZpGIURMOdteCxprv8BG41qC8WjhZWJezZ8WZS22g4JgV26vxR
	3lKwt0iDkM954T9q8E7/JIVQGfMLgzLyrCYSHaAJOYQaBtsA+4pLDyhvCP8h0b3hky5xdYcFmO4
	AahIuX046hz+86rZNn1KDqVSZgKNqkSCCqGfNqYGjwZehu7aQKOgYB0usSVI59kaU=
X-Received: by 2002:a05:6000:4694:b0:48a:f4c1:4301 with SMTP id ffacd0b85a97d-48ddfb1b623mr910781f8f.6.1791823339056;
        Mon, 12 Oct 2026 09:42:19 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::4:c555])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0967c03sm394228f8f.6.2026.10.12.09.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 09:42:18 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 12 Oct 2026 17:41:57 +0100
Subject: [PATCH net v3 1/2] netconsole: finish enabling the target before
 releasing RTNL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-netcons-fixes-v3-1-1aac85ed7665@gmail.com>
References: <20261012-netcons-fixes-v3-0-1aac85ed7665@gmail.com>
In-Reply-To: <20261012-netcons-fixes-v3-0-1aac85ed7665@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Gustavo Luiz Duarte <gustavold@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2

netcons_netpoll_setup() publishes nt->np.dev inside __netpoll_setup(),
then releases the RTNL and waits for an RCU grace period before
returning. Only after that does its caller store STATE_ENABLED.

A NETDEV_UNREGISTER event landing in that window tears the target down
and we end up storing STATE_ENABLED with a NULL np->dev, leading to a
null-ptr-deref in netconsole_write():

  BUG: KASAN: null-ptr-deref in netconsole_write+0xb9/0x7f0
  Read of size 8 at addr 00000000000000a8 by task pr/netcon_ext0/135
   netconsole_write+0xb9/0x7f0
   nbcon_emit_next_record+0x501/0x550
   nbcon_emit_one+0x10e/0x170
   nbcon_kthread_func+0x2ff/0x3b0
   kthread+0x199/0x1e0

Store STATE_ENABLED before dropping the RTNL lock to avoid racing with
netconsole_netdev_event().

Fixes: 2382b15bcc39 ("netconsole: take care of NETDEV_UNREGISTER event")
Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index b358e5c36735..1fb846ad07d1 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -552,13 +552,16 @@ static int netcons_netpoll_setup(struct netconsole_target *nt)
 	err = __netpoll_setup(np, ndev);
 	if (err)
 		goto put;
-	rtnl_unlock();
 
 	/* Make sure all NAPI polls which started before dev->npinfo
 	 * was visible have exited before we start calling NAPI poll.
 	 * NAPI skips locking if dev->npinfo is NULL.
+	 * Hold RTNL until enable is finished so we don't race with
+	 * netconsole_netdev_event()
 	 */
-	synchronize_rcu();
+	synchronize_net();
+	nt->state = STATE_ENABLED;
+	rtnl_unlock();
 
 	return 0;
 
@@ -589,7 +592,6 @@ static void resume_target(struct netconsole_target *nt)
 		return;
 	}
 
-	nt->state = STATE_ENABLED;
 	pr_info("network logging resumed on interface %s\n", nt->np.dev_name);
 }
 
@@ -1067,7 +1069,6 @@ static ssize_t enabled_store(struct config_item *item,
 			goto out_unlock;
 		}
 
-		nt->state = STATE_ENABLED;
 		pr_info("network logging started\n");
 	} else {	/* false */
 		/* We need to disable the netconsole before cleaning it up
@@ -2669,8 +2670,6 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 			 * otherwise, keep the target in the list, but disabled.
 			 */
 			goto fail;
-	} else {
-		nt->state = STATE_ENABLED;
 	}
 	populate_configfs_item(nt, cmdline_count);
 

-- 
2.56.0

