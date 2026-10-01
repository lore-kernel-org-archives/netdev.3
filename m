Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B431E3E44E7
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 20:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790887679; cv=none; b=Cp0Xd+EGBsDijqYi0Kxcff1TJI6fyVO99W2UF6yfdsgdKQPiY6fSHifI4mBnHMrAhgNgeLI32+mGOTr/A0BV8K5fnrbai8yJPhOkHsXE6wrG5YCyL1DkMTQbbLbXRmgz2vT1Yl0J1McUGIV5mQLdghknyixW8xLOCRIad01qTEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790887679; c=relaxed/simple;
	bh=1ltf8VYByK6jZG96JJfPHiV1Ovc0NYvQ81JT53A172I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e1/TTS4/Wde0kPeT24cefxJx5ZwpO9HIDHHKaGO/h7q8uULhPQ51y+K+ic4Zm9SK3suLDqpasEADuqXhSKDHFLvgFhiug93Kkp4RfRxAeVS9v/k0d3fxJbO944vMBNKAt6zIlWz/2atQNAcwqye6lzO4vF+qpYCR1KjmCNCFrfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qiHUKdJ/; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qiHUKdJ/"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8881a7875e5so955633b3a.1
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 13:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790887677; x=1791492477; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1BM24IHofG6Ugi1avwQFkve9/U0pftEULauqCCURMis=;
        b=qiHUKdJ/fmgsOXVT8ij9wOHsXKAqdI020YE5BZTC9HsSAY87x7NzLNlrNzlwKOAfd4
         XR/flEjIpNM0y8QyQjIDl4YZ7i7U+7pIMOoS4RqJ+oztzV29qDyLA5A3Tzr7rVipgdJL
         dEOjw7w4L4OXSeQi/Fww5dBUm6kurHmVRwDA8aJLqlCx9AnQp53cE3/mrWKIDtYrgXcl
         cOR/tjZwcBoS/X8U4RRQdZAGLd0XY7iHkOykGDodQMEEjO/RjehcL+DI/bnBa4lZmMGF
         iQfEooaxi71UlYjT0km2EsuVVgQPHwgP6dzNBy6lyPt5r10PWdn7031h9RIEPpHcSZZd
         Fxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790887677; x=1791492477;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1BM24IHofG6Ugi1avwQFkve9/U0pftEULauqCCURMis=;
        b=ZG0kZ+aAoI4Nbe+nlOI7kUG7VFmxWID0TjeLG4RQPMVk/xgRiuNF1Q1nA1GjIExZOX
         zt2F3BiSpn2YaSZsMrh28vivbgQ8re26TEFFZYFZs9l/3JJTHcN6yfNdrRD6TNKUNlgd
         NzUvuELG2TY2eYVpgAK02BNR31bqmtg8gSufEF53qoFY92DhxjH2E/8nteeTFSm9ZpZF
         eJ4QVAc4Q8JjwidT4hf1P5MevBNo7jZ8lUxWdRucVSCn6pa61yG4DwtjVlyQr5lN00Zs
         Q1Zd+89U6pfFh65arlik7VKRSV40Lmov9Q+pAdIEIuOjzQAEBTQEhGdyzxgwD83pAuQf
         Vdpw==
X-Forwarded-Encrypted: i=1; AKwUvBwthRHpm6P/BaEFC/P/5qqB6HM07NVTsexqUyb0tKuc499lHx4DCm0crx5xLJL+6b5S0XJ1G1s=@vger.kernel.org
X-Gm-Message-State: AFuF++mBtsBwmvSvWfkYWpyWrRf/Af8fyb7ZeZRrzmBNHf4jcuJC1YYo
	cAc5wiRVMDp8yHfNax52flceO5SCeFU68myODItljk2x7m5oFdjq+yG0MYlkM/0Kn6bIos/tgAV
	oSiUWhA==
X-Received: from pfbdn3.prod.google.com ([2002:a05:6a00:4983:b0:886:c063:eb7])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:124f:b0:881:e626:74a0
 with SMTP id d2e1a72fcca58-88af7ba6979mr580725b3a.47.1790887676959; Thu, 01
 Oct 2026 13:47:56 -0700 (PDT)
Date: Thu,  1 Oct 2026 20:47:13 +0000
In-Reply-To: <20261001204752.2572265-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001204752.2572265-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001204752.2572265-2-kuniyu@google.com>
Subject: [PATCH v3 net-next 1/6] net: Order blackhole_netdev_init(),
 inet_init(), and inet6_init().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Chris J Arges <carges@cloudflare.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Fernando Fernandez Mancera <fmancera@suse.de>
Content-Type: text/plain; charset="UTF-8"

Commit 309b905deee5 ("ipv6: convert CONFIG_IPV6 to built-in
only and clean up Kconfigs") started to call inet6_init() as
device_initcall().

It explains the reason as a race condition on IPv6 addrconf,
but this is not accurate.

The change initially used fs_initcall() but switched to
device_initcall() due to the null-ptr-deref stack trace in
the link below.

It happened because blackhole_netdev_init() uses device_initcall()
and blackhole_netdev was NULL when addrconf_init() called
ipv6_add_dev(blackhole_netdev).

Due to the order in Kbuild,

  $ cat -n Kbuild | grep -E "(drivers|net)"
     111	obj-y			+= drivers/
     114	obj-$(CONFIG_NET)	+= net/

using device_initcall() for IPv6 allows built-in drivers to
be initialised earlier, which requires unnecessary NULL checks.

For the same ordering reason, IPv4 uses late_initcall() to
initialise blackhole_netdev.

Given loopback_net_ops is registered in net_dev_init() at
subsys_initcall(), blackhole_netdev_init() can be called
after that.

In addition, some places assume that IPv4 must be initialised
before IPv6.  For example, mptcp_proto_v6_init() copies
mptcp_prot to mptcp_v6_prot, which would otherwise have NULL
mptcp_v6_prot.h.hashinfo.

Let's explicitly order blackhole_netdev_init() -> inet_init()
-> inet6_init() before device_initcall() with 3 different
initcall levels:

  subsys_initcall      : 4  : net_dev_init()
  subsys_initcall_sync : 4s : blackhole_netdev_init()
  fs_initcall          : 5  : inet_init()
  fs_initcall_sync     : 5s : inet6_init()
  device_initcall      : 6  : built-in drivers

Note that both IPv4 and IPv6 can still use fs_initcall() thanks
to the order in net/Makefile, but explicit ordering would be
less error-prone.

  $ cat -n net/Makefile | grep ipv
      17	obj-$(CONFIG_INET)		+= ipv4/
      22	obj-y				+= ipv6/

Link: https://lore.kernel.org/netdev/20260309074758.0ea95a18@kernel.org/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
Cc: Fernando Fernandez Mancera <fmancera@suse.de>
---
 drivers/net/loopback.c | 2 +-
 net/ipv6/af_inet6.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index 1fb6ce6843ad..55ecd5ebac0f 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -289,4 +289,4 @@ static int __init blackhole_netdev_init(void)
 	return 0;
 }
 
-device_initcall(blackhole_netdev_init);
+subsys_initcall_sync(blackhole_netdev_init);
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index f0efdc13baf4..a9b8b4b42a1a 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -1217,4 +1217,4 @@ static int __init inet6_init(void)
 	proto_unregister(&tcpv6_prot);
 	goto out;
 }
-device_initcall(inet6_init);
+fs_initcall_sync(inet6_init);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

