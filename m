Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649306;
	b=YcsR7ywapcc3rBiBkKUDosswJsSSfMU8zNTKa+EtctETD/PEjk1BoVpyXV9WJYzVCTNK
	 ZPjmhhVWwz/6p9hMx8GErYPhIdm9RD3kaGEUEubYWNaNhfpyUiWO/lhDxfyZe2uFATu3P
	 ANcJu3S66r3gY/UnRTJWZKNbNHZKwwAvVQusq7MiGG8tapCJyP6qrKHqARBRuOlEJtzo6
	 fcN5FV8tB8OMhwPMsPQimfd2DOyt2zELWEE0NvlzMLongev+XO7wqxQ5cjMo8ksc8+LO3
	 gCeTH1vDkXSdYNzi8+v1DxQ5gnBwErEwZ5zP8a02Aua32c+LpxkCdD3iIhAoZ5bm1Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649306;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=1xDwSEG6VK1NnrwFAzTuvmGkyH9sGfRAJBwxtJWmaDI=;
	b=l/0NwHkI1Jo91LvuJEdp+xQHp9UlCRzni16vXQWp4mV35quutStwjJlW0eCIgAIbbulH
	 Vbtnce+J/Qo/+yXeWv2mqe7h2J6jhX/QJqfI6BArW2/Y5qByirSx+7DSwFd/iZnGqMbUt
	 mMSzglln3Wez/7XBpCPoOoo0zCx3tcc5KA5SafV00AjbAzRW9Mr76n8zV5WrSo2dPip9k
	 TiZLqKv/Chf3L7bSpe68kGEbZG45jYFAfaA2ny9BLBnXzy79Fc8z/6qp+tPjd0wvIflx4
	 5Jw0og0p3zSSbJ+K/PFmaIMmiNwWNxdkqP7rGzfTzZhVnmTQ33L1Xgtn2ol9n57dx9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GjILj0Y6;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAB9606A334
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 19:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EAB9606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GjILj0Y6
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a78ec32fadso8071645e9.3
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 11:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793649305; x=1794254105; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1xDwSEG6VK1NnrwFAzTuvmGkyH9sGfRAJBwxtJWmaDI=;
        b=GjILj0Y64bZZ3tcRYoxsJ/1tq4TMb1TrD0hYCGQo/N/adeAZjcfFWSu1PPzEazgZn8
         ONatlkbgOQb2QBRULQlka5g+JjAqAcD4DbUqV4xz776S1DHoOQW88h6T/1VKYceUrnQj
         uDGR1Jz6enTPVANkxtZ4r+IFfrxspabWr9+cpJo0BMMQbF/E32kilgl3HiQ7FBIWaRx8
         we/gd8YQ1x7CCzsoeYaTYzxOoOCQRyp/v48GPU33R6W/nT/2fNPf/mpQeOWWWtIrQgO3
         2gj5BBzlwBeB8l3RadJeDAHuNfUv0pp/gqTUkLlj69NwQrC8Lt0WTDN0XA4Dsirdimy/
         tC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793649305; x=1794254105;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1xDwSEG6VK1NnrwFAzTuvmGkyH9sGfRAJBwxtJWmaDI=;
        b=V/btN2CtCe+zvYn3l0lWq79u/0YykqWsHsS0thes66W9xHlhXNQtxpsw7c8EYHEGmF
         P6X2BM22NxW26IRDxfvVHksPHJjCAHVTPWDJy+Zh+usmUCXVvM9VvvZY3f3faEgR3wKP
         bKn3qIdQ+CHabyUko36ZZvz5JIUKZxMpwvHpHzooT1eRjrUuF9txs9ShrStN+pssnZ1h
         2snth/lsHHWHRLPg45XkFkx09ZXiAitZTf7LP9JDTTm15lRfxDPMyYJ3pRZbD5ldKE63
         tQSWsnn39+jZVZ7gR3pxufRBYMoU+FME1cW0VmXoUEWqDjIw94O4sCXtzabC83gFHsvZ
         EXQw==
X-Forwarded-Encrypted: i=1; AKwUvBzemapkyKPnhR4XaQ80BcpTeJOtG8qiU7aBIG710srg25+bRyb+zTdKDzh1TNe25Aw6TQn3C8g=@vger.kernel.org
X-Gm-Message-State: AFq9FYIg4viciyzscfL+feR76mTI+mOYFI0E4Cs4UhiYxG+cz+440f3g
	+KWgQyZ7j6n9HmKNZcugx5oC7Jakh3hKK4uQbrntjWKqpN7xCMqWtJF4
X-Gm-Gg: AYBFou3WkkVW9BdZLToUbXCQW4zRKCextD/Cb8UNdgGdhoUz/N3Pd0US6qgjbK+EjcY
	yafBI67e7bc048IUcYVb/xAjrP/OJEXkdUJv4/4BEB7F3y/nSUsrlbUqquUrdaeRJRWBseuf7f0
	1tPny92gi/YEduQduZ6RarsED5eKhMT3fabcdznDmSy3QlkuyCckYS+hMhretNYq+8dofEeQ0U8
	LLGpr3YuyLS8eVNZqCwQroSm0WoI7VZVkGXxm9QHmGirgUwHepwp4Tj5X5RZR5MTKzvFQbHsbUp
	18prvE0hGjVBt4Fu2dfGQfpEE2ei8HwIfBl72G2YblFoA/jmxOlII60gsdZd8clfQHKLAdeRu7T
	j1UzKQvBHo4oP6Ib9RxjnY182aOPn8/PjcPirsUVTMAh47uMMPGdbNgMMsa2R33I7NYjioJRrMi
	C42kgoNlOwGnZjtgZMbjL30QOQdb1X15HVcv2JKlTBLy8BPeqPsf2M0ytQHJffkdFQy2Qd/ycXd
	48Z2i8Ov8eVR5VoP+/+KGgD7QyiOjx4meSE0rXBnDiOjU5HbDGYHmBsJyGgcpS/HhFnq/8VL+S4
	UwABJWGXMZY=
X-Received: by 2002:a05:600c:4897:b0:4ad:5ec2:d3b3 with SMTP id 5b1f17b1804b1-4ad5ec2d3e4mr119187675e9.1.1793649304692;
        Mon, 02 Nov 2026 11:55:04 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::7:f93e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a80e0fe6sm10422775e9.1.2026.11.02.11.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:55:04 -0800 (PST)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 02 Nov 2026 19:54:49 +0000
Subject: [PATCH net v5 1/4] netconsole: finish enabling the target before
 releasing RTNL
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-netcons-fixes-v5-1-bdada2f03563@gmail.com>
References: <20261102-netcons-fixes-v5-0-bdada2f03563@gmail.com>
In-Reply-To: <20261102-netcons-fixes-v5-0-bdada2f03563@gmail.com>
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
index 267254f046de..7dde00eb8e98 100644
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
 
@@ -1079,7 +1081,6 @@ static ssize_t enabled_store(struct config_item *item,
 			goto out_unlock;
 		}
 
-		nt->state = STATE_ENABLED;
 		pr_info("network logging started\n");
 	} else {	/* false */
 		/* We need to disable the netconsole before cleaning it up
@@ -2667,8 +2668,6 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 			 * otherwise, keep the target in the list, but disabled.
 			 */
 			goto fail;
-	} else {
-		nt->state = STATE_ENABLED;
 	}
 	populate_configfs_item(nt, cmdline_count);
 

-- 
2.56.0

