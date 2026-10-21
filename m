Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792592388;
	b=Tuj1h7KoIyxgP+GlOkMOIcoLMzOlVIsRObZMY4HCCnL36fbti8gW10Ibu/T1YDHT2Nt3
	 NaItXm1XJG0ZZS7JCDqqQHwe/2PmQogMDcCiQGUiLJkQ242eCGRyZLHPUsOB0JXl7Zjzr
	 ZD1l9ugaBFiKSIWwBtezm/AIi8+9iqibwTL73pAb2Egr6K8TUbW7M+h4U28+IgyEEuiJ1
	 D9Vqn4m6+cyuGd+l1b5FhYIOsVyMO3JOEZ0qLLj93qqRFmvlT9BlN1ssvZU996BAWxikk
	 o8GUkSikGuq+0yPcCKHNIF//ufiv5VWKDzpWkU/H8Z7S6nrsM1rYeVzAkmPKTkLoJLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592388;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=DbH0x+1VGrxmmG/67GKpm0AlwDDsWm6hJsBQAAEfQEQ=;
	b=idLmgXxPQhu39peX1INPu+NUUjt+9lpoc8JAh4wfBMESrgj98JGTdPGauR7zaUiUMLq7
	 K5wsWTFj+cMSoVHdAmNNyqSHVW0f64Z6YlDQBhdqZLtE0XO6VIKZrenfKhmZqGWs401ff
	 aB+pMDBwoq0votvkknFAXV5GG2dJwp/7GPorQFUhOJvp9XuWKuyrlLs5FQX+5oVMiS5eX
	 MwEzz1PrslIJKTM12irjOwLcQk9gir1Nha1YfxQZ8p2QyA4i4M6DTcG4YaHYmubJTS+LF
	 lxo1mCXNm0XQ+evJdZjKWoHeK7TDdpsnTBqGLWxMIvX00p+ppu6vgZYnmrhRafGhHkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CZb7+6fI;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83CA606A33A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 14:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D83CA606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CZb7+6fI
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a1f80b7bf6so1347595e9.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 07:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792592386; x=1793197186; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DbH0x+1VGrxmmG/67GKpm0AlwDDsWm6hJsBQAAEfQEQ=;
        b=CZb7+6fIEChRZkiSFWYjgkGJzq5blxu54QhARlPpVWLVktMgOr9eVaF4vF7mbUobpM
         RX8o/hKDK/AMkmuouoEXj3dJXFHgmJRNhMPTX/HCXJUBrI+aOchA0piV7JNQpf6eV/2Y
         yHBpXM4sbNzZScGYGplSNdYPtYn8DGxkGjaLgJQlW73uObRFZEoQYx1mx2EjbVequSaQ
         nMEBGIhkBUjwXfrkTi19nxXZl7X7G5k9OGIkTNPNqRP6/SsOtI5YUhwQQORusiif+UB5
         kYp9bx4uCEA8bgKxFRABUTE+gKigHanRjI2iaqkFEAgfQspcGr/kvxtyKLm8bRri9HUM
         O4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792592386; x=1793197186;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DbH0x+1VGrxmmG/67GKpm0AlwDDsWm6hJsBQAAEfQEQ=;
        b=swMXIE0gfgFpYbREGlCkwQcIkbvDn8V8wZ8PTCUQojRWx3rf0QruQeSz6nnfbiB9SV
         LZBKS0VZIwJjlwAaLU9QcfrZ1kYD829wfbaLZyxl3C0LgtyILK1GVYHYsVnHngBDF4Kn
         YrqF3KKiDdOdV+Vx9bc8EoY6shlN3+kjgdXWgU1wiQoSVeywynr7im18Of9lB3g0NIvU
         ZeKOLjFVyBYQbhMySCl9BOwBethDMBPbHCaEqQIU4BSGDV5xDLBA4P3ZkKMfnH8mZ1CR
         fMWyr06JgJxMii/x9hPWZe6Ucc4tbqkx9w06jbmoQOPlhsNQm1Aq0VPGPM6E2aoL04fl
         ecHw==
X-Forwarded-Encrypted: i=1; AKwUvByLCjE8VI1Fg3Ouek3XJzm2rFBpNMSyBc449aX31S2mgxdMVtpcS9ko1aq1fr9Wuwfnqx8U0KY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIRNjnnUkWFZjKfj+M8+9SGR64Pq5puQldE7vNhJjSfXNQpee1a
	0NuyJZI7r3fGf1AbxS+ZT+fAUd3E7tnTggDLWs2xjSoFzI/nW1dYe74DurfciI36K0w=
X-Gm-Gg: AYBFou35y3le14JMJzPyY+0agCqxnTNtaxQenNyVrIBKkrlCvpRW64nj2U9n9CjI/yZ
	P/kv14ubi1HIA9hWWRSBUxgSo9qk8ziFqOSxagzNaE+Z14PtyDMZEupSAAIPR7X8hlhL8MXUdMd
	vl03hS+dpnzYwP9GrSHf71SLpABiG+INSyiNJtmcR5Sp2WEZMizJ34F8ECjcIPuXVtV2fVMLZ0E
	VNO5nrmut77pPMWepaNho02Rb9flmBMc7dFUfqoKcoZsnwbkOl2SaiXyZHX3yeEKkLSammVvUBa
	TN4Zkwf1Q6fHrdGcB+oqu1uumzm90DLgLdEjf/J7Bk/qFbKJdK3hfp44KXdrHIwM6REeybNBT+1
	Y2zN9hve5aKYtQzMXxYBunCHUAjCemwoiOMo8G1mX1fQl8kyUyrlijVkxp3T7ee4dzHvaHJqkqV
	R/UTZVsrnqyO26fL+4VL0vkW7Q9BAlDgCtQ48d6kNRhVzmpnUsUMbMgzJQtdpjT0ZKKdLKKrOh7
	3nQuWFjREQKWwo7Wjt89o5wWFwQJ3ASB9gSj08yS7Y3j80rBgFdKhF5
X-Received: by 2002:a05:600c:8707:b0:4a0:13d8:cd0c with SMTP id 5b1f17b1804b1-4a1fdae90ecmr44009445e9.2.1792592385804;
        Wed, 21 Oct 2026 07:19:45 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1d:5d00:1a26:c015:c64b:f840])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d41c8asm153631325e9.8.2026.10.21.07.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 07:19:45 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 21 Oct 2026 15:19:05 +0100
Subject: [PATCH net v4 1/3] netconsole: finish enabling the target before
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
Message-Id: <20261021-netcons-fixes-v4-1-3857120c6340@gmail.com>
References: <20261021-netcons-fixes-v4-0-3857120c6340@gmail.com>
In-Reply-To: <20261021-netcons-fixes-v4-0-3857120c6340@gmail.com>
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

