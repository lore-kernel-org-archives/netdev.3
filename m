Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3344925B2F4
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 00:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778718144; cv=none; b=O4ouj3dUZ9xVKH9gBQZS73tKPQKNHtk8kwkWv2zxcYAHbYhkCPL1fVvRqyiAaUFf4Iyt5TI/0V2OcEGjLsdBI6Cbw1PwToIjIPNcrYWAca7jBfAwM68L03OxWBYIWbkjkMvNSGhi9YBukL1SvAlkddntYpz8s542Teh0pbwSzx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778718144; c=relaxed/simple;
	bh=r/dNhDtuahypA87C1YXJ4TllXHta2MJW4yZ//T4QsQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gI958ZSF0w8/5/bcz9+PSkP1lPf5OkC1a+dCXy+9IElmwYCH2Rzsgm9YhCpQ8wO79SB1EvekeUUdgsU3/2PfNTMeLQuBkk1Gv7UnTDHE1b5+y3unlE79gd6xziWZqY2CGy4XFmmv/MyM5sOQjX3yASJHl0zy7Fw4eDxAqh3Sqls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlfHwn5a; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlfHwn5a"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-90d042fa745so399915185a.1
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 17:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778718142; x=1779322942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=irXLMVW2G6pZT9ipRR8zg24QGfQC3eyv0or3evjGwyA=;
        b=GlfHwn5aFaBo7uk+qB/5vco06qJa/pfRvDUCAL14cFaPS7yA0cfpLRCWcPvMriCX7v
         MhzqE3MEmSwLvh9dUKoXyUmYDeBlvKg20t+HmEYNG5ZcfCtD/Zp0cAsJ+S/aBg9uCkUm
         THHhtwTlu0vOWI9SJZNL8oaXlSrYQwvSV6cPxevdPGwhRrh5sBu5b12iW5gyU3S/V7/r
         YZVlU8lNnI3cjHWbzfJZlBLp07KJ99depG58DStEEugJ3Z7jNEhTAnQXtOhu8E2WYUoJ
         7TLslYZmHB1bpJ1jsabKCNwo7OwegJUgRGLXKkc0osFZbVR1axzvdCyvM2M1gRTJaMi5
         v6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778718142; x=1779322942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irXLMVW2G6pZT9ipRR8zg24QGfQC3eyv0or3evjGwyA=;
        b=iXoLHplqByG/aeygfrGiNpErOe4pmVrN3NXgkk6Yc05gCskknzbq/PlKas28bLFDZA
         rVr8aL7Y5s03Ucr5pG4w3qHo+7CmKrPxC5tvmaE++bRQMHGkLoAS/gIWizsNI/lOd4FL
         +l+U620Y0w7rn5RJh6ydX7gPDqxqqXroRfeXFXjneN4npTKHVISwbQ9kFHL4CF5p6qIi
         PThT8EO50snbbsQP3Is46dfgkrmcriKJqZ8BlgtxuuThhlNg9WV7vZhcm/185j/u/hbD
         VVAWc/+O3JzKT6omqR9IQlut8b2Pt42u2JZLYv8/i3u4dCK7mPOFIp8+oj8P+pSaZ2r0
         c1rw==
X-Forwarded-Encrypted: i=1; AFNElJ+I+gq6nVP+kmBas0czUjA+h00EaQgC2AC25V8DOMBmZYc9PfasLEQaPwtRMY05FdoqNCqQN9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLRz8+Qvy51ilHnXqr7IUBVtV3nGGXrlz5MHx1MQGDX6A5qTAV
	YKH8ZPSQ5ZbGz23+6PP6pObS34C0BSB7KFNQyBy8DqPChX+DCpXHvkjG
X-Gm-Gg: Acq92OHxPTAQTfOZ+yLlNqm/MOSCSOYuGth+w7+8GfNwZFEvrwNPwTkRp/EUzvOUpOC
	09zfc2Yw3/iDb+IYauxMbG8rIhOkGh7sGjmvr2+Dnhmy6SomeC/JaG1mNvm3CPrAGreXXlInaWA
	GSu1nvAsWomXBbBmrEsml1Apj4v1iqrWaDTzgeAnuw8s4ajBQzHvlxHkaHufRxe/WGKU//Ru5v5
	FZ7Tx7KEIPK0UqWYA9ESWTlV1q8CbX6uY7vDZFsFwTBQo1LnOe2YWL4heS6xalG4V3nxpnhc/CX
	bz3HEAqBCIE/Mmcbf7LYB1LzfnbMz2AqODxyM6LAXhBeudycNIZ1CchHj/0zzQvEzXe059Lti0s
	ZDbQzQquOOVvSJ6MobMiKBgdCBcLCTfEjv/FOfTxQtwf8dY/NBCzIzdsiPxbeRsE8pY3Ug2xBhc
	kYvuHQJg8zogzkJQk4yRjUGh91vE25Y3o24UHsU7cY
X-Received: by 2002:a05:620a:4506:b0:90d:3af3:2a62 with SMTP id af79cd13be357-90f8a827302mr897456985a.46.1778718142168;
        Wed, 13 May 2026 17:22:22 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf3776dsm107829585a.39.2026.05.13.17.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 17:22:21 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] ipv6: route: Unregister netdevice notifier on BPF init failure
Date: Wed, 13 May 2026 20:22:18 -0400
Message-ID: <20260514002218.677943-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip6_route_init() registers ip6_route_dev_notifier before registering the
IPv6 route BPF iterator target. If bpf_iter_register() fails, the error
path jumps to out_register_late_subsys and unwinds the RTNL handlers and
late pernet subsystem, but leaves the netdevice notifier registered.

Add a separate unwind label for the BPF iterator failure path so the
netdevice notifier is unregistered before continuing with the existing
cleanup.

Fixes: 138d0be35b14 ("net: bpf: Add netlink and ipv6_route bpf_iter targets")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 net/ipv6/route.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index cb521700cee7..4333e11dc9c5 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6925,7 +6925,7 @@ int __init ip6_route_init(void)
 #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_PROC_FS)
 	ret = bpf_iter_register();
 	if (ret)
-		goto out_register_late_subsys;
+		goto out_register_notifier;
 #endif
 #endif
 
@@ -6939,6 +6939,12 @@ int __init ip6_route_init(void)
 out:
 	return ret;
 
+#if IS_BUILTIN(CONFIG_IPV6)
+#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_PROC_FS)
+out_register_notifier:
+	unregister_netdevice_notifier(&ip6_route_dev_notifier);
+#endif
+#endif
 out_register_late_subsys:
 	rtnl_unregister_all(PF_INET6);
 	unregister_pernet_subsys(&ip6_route_net_late_ops);
-- 
2.43.0

