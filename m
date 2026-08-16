Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57C52DB798
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 03:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786852374; cv=none; b=B4xlOSIVP+ZFMB80zLNUM/BzGKTbDFlxFWSfkqJlef2cXp9OztdMs7cLAJ5UBB8Mliu8nWJex0KPNtwmy3QXH0mJBZp+UVW4RkyI4A9vgXikGnGEPRzdRlDmYJizDm0UaQqulSYSlqCDoWHBvCZF9fQyhpZ8rjeDQQ08pZ6wUps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786852374; c=relaxed/simple;
	bh=8Cvz4eTiI579s3pzrKy1RBfabCztHCQjMvVEIwjAt74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=poisv4ufRFDFCkkUZfFzjUKCW3XDcxMM6/mCW1YhifNR9VKE5aMfAqUGZrQ8L5vPp+4mldvjOJjNlovKa6CFXOK+k2L25r64ueSaXwlyWfR6upGmB4fq35i56rgPhq3R1Ek+n+l3KRwvOGWgAoTwg9zo9mgpSZODc62uHJX9CZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPi2G+iv; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPi2G+iv"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8200b55dc47so31744567b3.3
        for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 20:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786852372; x=1787457172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XgEkc435J86T5Q5eFf1ikI6/hg2tuHj/BT8NQuyczkc=;
        b=XPi2G+ivUpbwQ6ouMd+sv4Y9cgmNeRc37OQdSeQvGZ9s9E6SLwEZCBjHkIj5EcPTbi
         8Qs+WAzTMyK2/PX78M7pTZwD29mVNi7HVZh4DdkIYWxRtoMKxc9q9YvW5ecP1xyh1lES
         gJh/EjdThjBZ/U/7bzNeO54/EbyHDMH/7rmV8BolDSLlijtLtGJeuizvYcFDHTnIu4nP
         e+ztWDX82l3qxPHwXQNZ8n9iszH7xOO95S10ZHUJo9xCYcF1Ftaq1AaPXIHEjXyb/2ND
         veHtPc4BbOLKiOGR9u4pq6ZyPJXk1U58GomW7ZT1GopAMi09DmbuG7LupWlOmV5DAz9N
         D4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786852372; x=1787457172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XgEkc435J86T5Q5eFf1ikI6/hg2tuHj/BT8NQuyczkc=;
        b=HB75HKkQzg5536vJFcCET8X0BpXhjyrb7iGCqDBnDNtQChUIj5Cbs8SIPbpq0VMPGE
         TjGkP7c7/nLiZCV8/t0gTTeLGeJ8LROaoO/Hs5gpkXJikhEBwj9o23LMajRh4ajb0CWO
         UnHuvOk5qgcyhT3F8XZwM0lUsvsKQsl4edmf1XLT0SiI0wahML2cyIWyrAH9cE741/oM
         y3+fcLutSXwRSN4kp58080b88ReRro0j47Lf4S9z5zRY0OSBSqv2aMO4aNzXXRWCwK8l
         Exce/pyK8Om8O0KxTBLA3oQ+nXr1XE+3gBtEvVOUjhmvupIqL+ibK6LAPzFsiJ7Z13ZE
         oL9w==
X-Forwarded-Encrypted: i=1; AHgh+RpIPbjRq2TiP9y/s0iy0/aehFvClM8CTAsiNUDRZyIdJyEMS4WAmfc8da0YSIBisKkvQxZnpVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzMVNuhCy0bCdjIxjnRrSj9GJMKeipaxUmY5bBJoAPP9127mEr
	C9yLE2QQweqzpaxnBZEVKXy9d+QHa8ggGUEQB1ctnDo3jGUlsotJDR2E
X-Gm-Gg: AR+sD10BVMNKa1rXhW8o//fDeR2pFQeEca/Aaw3kyVCtLnxNnHwU49fkMprhm9suWmS
	Hv/cqvWuRkG1FtycJ5UjpsuPc70mLNg6Nrb0oTFgCIh9uD4yfDu40u6obxhJstpeUaNzHSjcS7T
	7g8l0WfwLzRPk/k7/ET0wEqo05QctaLOEZbLxnURBnLseHOFrFDYHdrpiXIcnpkFT0T42naxjRS
	gpsEBuHGLPAQLm4Mp+HjNQuFF8OGTdC4/4kg9xYe11NNEeZS/kHVkfe4bQXDUV/mriFkbWnPkS5
	ramAcWmuIgIO0Ba5ECxTU2zZD+dVDp4WidpyEs5v6pv74jo4maQTV+vCH3bABqF3p7oOrC2P36r
	NM0sQkZSKfG3rm+/cO0fy/eJfD1bJX/uYz1oCC2qClCc8whZbJ97CqEfeOh9fpE+X4zu1T9P0lj
	zs8IZNb44DEyExZvJqhHFH2NwHErihrKn8vqPcpIxkvYoygdxH+0lvS+wUUEaIKDNfrVE=
X-Received: by 2002:a05:690c:e68f:20b0:815:bc6a:2e48 with SMTP id 00721157ae682-8370ea71c6bmr46941407b3.14.1786852371654;
        Sat, 15 Aug 2026 20:52:51 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-836bc49fee2sm32016057b3.16.2026.08.15.20.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 20:52:51 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: pablo@netfilter.org,
	laforge@gnumonks.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>
Subject: [PATCH net] gtp: fix NULL pointer dereference in gtp0_handle_echo_resp()
Date: Sat, 15 Aug 2026 23:52:05 -0400
Message-ID: <20260816035205.57966-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In gtp_create_sockets(), gtp->sk_created is set to true before gtp->sk0
and gtp->sk1u are assigned. A concurrent GTP Echo Response packet on
another CPU observes sk_created == true and dereferences the still-NULL
gtp->sk0 in gtp0_handle_echo_resp(), causing a kernel panic.

  KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
  RIP: 0010:gtp_encap_recv  (drivers/net/gtp.c:542 gtp0_handle_echo_resp)
  Call Trace:
   <IRQ>
   udp_queue_rcv_one_skb
   ip_protocol_deliver_rcu
   ip_local_deliver
  Kernel panic - not syncing: Fatal exception in interrupt

Reorder the assignments so that gtp->sk0 and gtp->sk1u are fully visible
before gtp->sk_created is set to true. This ensures no concurrent packet
path can observe the flag without valid socket pointers.

Fixes: b20dc3c68458 ("gtp: Allow to create GTP device without FDs")
Reported-by: AutonomousCodeSecurity@microsoft.com
Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Reported-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
 drivers/net/gtp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 9a12cc53da00..2b5a8f6d24d0 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1456,9 +1456,9 @@ static int gtp_create_sockets(struct gtp_dev *gtp, const struct nlattr *nla,
 		return PTR_ERR(sk1u);
 	}
 
-	gtp->sk_created = true;
 	gtp->sk0 = sk0;
 	gtp->sk1u = sk1u;
+	gtp->sk_created = true;
 
 	return 0;
 }
-- 
2.52.0

