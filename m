Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794465992;
	b=jCy9TowgU2IxZP1Y6AXEz6kTTUKr2XHXyIZqW8DGJKCMT67xr99Sf92D/bYz8ofOEypN
	 mweKpu4kw1pvJPhjyiAqUNIyfXWtjYzpX/3m9cJv7ByjFWpSHKiWqSP4ruCeLRo1q0z/F
	 IYPr96XaGjJx/tdV9yOxAObb5H+r7+PShqtxsbqtc8Tu8Lz0CXYaC4rK8/XfYB2JfbyCA
	 V0gTXdhrG8oWwWYY7q9QsxLJ6d54IKDie0AYe4PJrhHMEsnTFHgagQj+i4seoTZmckHh4
	 oNPjUN34cM7BO0ydF3SkSkczN2yjK0bDcT/3+TqqOY+7K/RM8WX6EPc8F51ZTobzQrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794465992;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ntDd/S6L1RCmt2oOT/IfmwbQKnfoI4o0MqE17OZVDwQ=;
	b=BuLTeddCPTw0UzFRXCbs2Q8AMjzcoSYO+ChG7Vr+qkS6yRshVWymtO6Cq09MEszTvHeO
	 AMM+zvC6vkBjnriUfSnrep/yrEbxa43qlXe3HNzmfLRDLi4nfZybjvc+0jJgsfgWDuuQ6
	 w3g7nfTKoNX9uschXfkDqyHVhFNWYMnv3CL/UBui87nmXsbGYFIdWvqYJiigWD/mEQdMX
	 iobatxyw7ZglVLAL8Rk2KiXPVnSKsNZS4AnRXmrFPm2joHZ6KdOY+6UuVDnzkV6QMOmo6
	 gzxOmlEgWmrpM8+AYeo5DEzklfHVFBhxy/aVlICCSFDtLCvdAXZV7DimDf//e9ukHgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yNBm4s88;
	arc=none smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37067606A323
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 06:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37067606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yNBm4s88
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67be5d0e9cbso2832036d50.3
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 22:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794465991; x=1795070791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ntDd/S6L1RCmt2oOT/IfmwbQKnfoI4o0MqE17OZVDwQ=;
        b=yNBm4s88C2IB7zlunIssuy+UbsDs1TkX1LT/9Hh5TZhuYv60Zj3fmnJq1AoJJ24JgZ
         AfxQTGrYe9+A8dvjyw7mTXTA23j6RrML62LVYxOKiYAZdLhhxlyOmXmqqRYYM0NIbCVP
         qteyyNE3qmAfeCqZOQDx4O1mKifh8jYEFeH2XX+ck7VmBYmuIPLV85J/SVuA7CbEgnzk
         PJPaedCgd0w1yeXIAOqcbyCbiLyvPB9L/R5xV3TBzcgMNeWKY1j0jfvVzae0nOjFmH/s
         Eg4cSvAWCdoi8qXrog36Y8JaCMNfIVrEUu6b8dD16C7h8gA5tH2f+kGxOAA0nt0X8nDt
         JW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794465991; x=1795070791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ntDd/S6L1RCmt2oOT/IfmwbQKnfoI4o0MqE17OZVDwQ=;
        b=toBsDxdA99w/2FUqJDX8FV8l2gM9VIR3GQ+D+MH8nVFnkW32xaSCwSw7Uf1LuEDc03
         gPmXPEsoEHwqWl8forfbgecF+AcrSm1pN1Yu3nqbsGF4sWsPtKIZVme0MdDcd7jClL7L
         /uITJfUe+2w1115RBtt2bzQQwmyv5dLVqMtwO5nDuSQlfxBDKzvv+FFfoY8o6L1WQv9G
         nWa/88dQXDcqhTu9khNO8vqPORolrKv0cHFOQrmkAQ0LZFcslu0pSdOxrjV/6pyvsIxk
         qftR9yl+tX1Osfmk32gJ34B74tsAArhwgJCMqg53kyaeqXCQvLoHdFzZeQHjCV/hNgOz
         7Duw==
X-Gm-Message-State: APuU4Z9x0uw2QVcO9TuKi1tKWC/LPBXa1LhIrGvMrBWsCM/PwQ6/IVsS
	G2Udp4PccnDF8jYqzAGmZipZjixNPtNTaMQsHiAV3z9NjZcKlH7IfJvd
X-Gm-Gg: AYBFou3zjRJL5cvsUL8su6cFszHuKUzo57QgisRrwzLvgxsLbpAhE2XMYwF1JcQSpfu
	pGmd8pKWzUTsgBdQISZtL+xHlz7XbplskMsVdvuobIV9S8Z3Mu5q7LkalnWtZ5Z1xh/Y3yRyd14
	e9FF+SDsvk+RF/ZelGHj2ocQXuxoZMSnURru0oPP58hHg18k1PLaKZp5v+50i8LAoueKnZL1Vcp
	ayw4DEp465ABDsxjXLuSO6dCAJvK/JElkkcUE1PB6sh0NY6KFbidGcc3GBMJ4gL7XGc7T7bawPm
	gsKWR2jUJy0crey/qeNJrqcZlwNc6uiSFc2rIv8b4NK8RvoFdw86d9M0KFsQFJxriFg6k7N9OES
	XMq0tL6zqlaK88EUvhNWdo44sB1zhhGF5BmEndlSAPgB70gtkrTfJe9BrTBAyAkxeeizVGpqDKX
	TxNIztB/N8uzZGjmbqdC8xaLTHMqyrIMtkbN+E/6B3dqv8KoPHxeepuE4BWb8ucM8rnfTyeQpF8
	sCq7ZsriaxKvq2wdbtbYdoWXjkZ8EYUdlzpw926mIXFb58m8Fnt9BhDwOhilMXCC5i4O8OM7vB7
	aVqStF4G0aVHtaCh1dBjXe8kP5J1ri8PUHPgFuz4bRr38jzdhdbGhw==
X-Received: by 2002:a05:690e:140d:b0:67c:2350:5b8c with SMTP id 956f58d0204a3-67c67fd76acmr2791998d50.26.1794465989718;
        Wed, 11 Nov 2026 22:46:29 -0800 (PST)
Received: from VPN-156-197.vpn.usf.edu ([2607:fe50:0:f802::4046])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c589a3450sm6629012d50.4.2026.11.11.22.46.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 22:46:28 -0800 (PST)
From: Juan Agustin Niccolini <juanagusnicco@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] tcp_metrics: hash the destination address with SipHash
Date: Thu, 12 Nov 2026 01:46:24 -0500
Message-ID: <20261112064624.15245-1-juanagusnicco@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tcp_metrics bucket is derived from a fold of the peer address.
For IPv4 the fold is ipv4_addr_hash(), which returns the address
unchanged. For IPv6 it is ipv6_addr_hash(), which XORs the four
32-bit words of the address. net_hash_mix() is only XORed in after
that fold, so two addresses of either family with the same fold share
a bucket in every netns.

A host owning an IPv6 /64 can thus compute, without knowing
net_hash_mix(), addresses that collide with a chosen IPv4 or IPv6 peer:

  w3 = w2 ^ p0 ^ p1 ^ target    /* p0, p1: prefix, w2: free */

A bucket holds six entries and the seventh insert replaces the oldest.
An off-path host can fill a peer's bucket with its own entries and
later tell whether one was evicted, because tcp_init_metrics() seeds
the initial RTO from the cached RTT. This reveals whether that peer,
or another address in the same bucket, connected in the meantime.
XOR and multiply is not a PRF, so net_hash_mix() can be recovered the
same way, after which evictions leak about 14 bits of any client's
address, depending on the number of buckets.

Hash the address with SipHash and a random key instead, as commit
2ee66e948717 ("inetpeer: randomize RB-tree node comparison using SipHash")
did for inet_peer. net_hash_mix() and hash_32() are kept, to separate
namespaces and to reduce the result to the table size.

Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cache.")
Cc: stable@vger.kernel.org
Signed-off-by: Juan Agustin Niccolini <juanagusnicco@gmail.com>
---
This can be exploited remotely to recover a client's IPv4 address.
A single host narrows the address to about 262 thousand candidates,
and because each netns keys the hash differently, intersecting buckets
extracted from multiple hosts converges quickly into one candidate;
3-5 are enough. The net_hash_mix() value only needs to be extracted
once per boot per host.

Many common cases facilitate this. For instance, a browser loading
one page connects to several hosts within the same second. That
supplies the buckets needed to converge, and the shared timing shows
they belong to the same client.

I reproduced the bug on a QEMU guest running mainline (2a500a04d6f9) and
against Ubuntu 24.04 over the internet. With the patch applied, the
reproducer no longer finds addresses that share a bucket. The
reproducer is available on request.

For stable: 5.10 and 5.15 lack siphash_aligned_key_t;
"static siphash_key_t tcpm_hash_key __read_mostly __aligned(16);" can
be used there.

This bug was discovered during an LLM-based code review.

 net/ipv4/tcp_metrics.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -8,6 +8,7 @@
 #include <linux/init.h>
 #include <linux/tcp.h>
 #include <linux/hash.h>
+#include <linux/siphash.h>
 #include <linux/tcp_metrics.h>
 #include <linux/vmalloc.h>
 
@@ -94,6 +95,23 @@
 
 static DEFINE_SPINLOCK(tcp_metrics_lock);
 static DEFINE_SEQLOCK(fastopen_seqlock);
+
+static siphash_aligned_key_t tcpm_hash_key __read_mostly;
+
+static u32 tcpm_addr_hash(const struct inetpeer_addr *a)
+{
+	net_get_random_once(&tcpm_hash_key, sizeof(tcpm_hash_key));
+
+	if (a->family == AF_INET)
+		return siphash_2u32((__force u32)a->a4.addr, a->a4.vif,
+				    &tcpm_hash_key);
+
+	return siphash_4u32((__force u32)a->a6.s6_addr32[0],
+			    (__force u32)a->a6.s6_addr32[1],
+			    (__force u32)a->a6.s6_addr32[2],
+			    (__force u32)a->a6.s6_addr32[3],
+			    &tcpm_hash_key);
+}
 
 static void tcpm_suck_dst(struct tcp_metrics_block *tm,
 			  const struct dst_entry *dst,
@@ -270,13 +288,13 @@
 	case AF_INET:
 		inetpeer_set_addr_v4(&saddr, inet_rsk(req)->ir_loc_addr);
 		inetpeer_set_addr_v4(&daddr, inet_rsk(req)->ir_rmt_addr);
-		hash = ipv4_addr_hash(inet_rsk(req)->ir_rmt_addr);
+		hash = tcpm_addr_hash(&daddr);
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
 		inetpeer_set_addr_v6(&saddr, &inet_rsk(req)->ir_v6_loc_addr);
 		inetpeer_set_addr_v6(&daddr, &inet_rsk(req)->ir_v6_rmt_addr);
-		hash = ipv6_addr_hash(&inet_rsk(req)->ir_v6_rmt_addr);
+		hash = tcpm_addr_hash(&daddr);
 		break;
 #endif
 	default:
@@ -310,18 +328,18 @@
 	if (sk->sk_family == AF_INET) {
 		inetpeer_set_addr_v4(&saddr, inet_sk(sk)->inet_saddr);
 		inetpeer_set_addr_v4(&daddr, inet_sk(sk)->inet_daddr);
-		hash = ipv4_addr_hash(inet_sk(sk)->inet_daddr);
+		hash = tcpm_addr_hash(&daddr);
 	}
 #if IS_ENABLED(CONFIG_IPV6)
 	else if (sk->sk_family == AF_INET6) {
 		if (ipv6_addr_v4mapped(&sk->sk_v6_daddr)) {
 			inetpeer_set_addr_v4(&saddr, inet_sk(sk)->inet_saddr);
 			inetpeer_set_addr_v4(&daddr, inet_sk(sk)->inet_daddr);
-			hash = ipv4_addr_hash(inet_sk(sk)->inet_daddr);
+			hash = tcpm_addr_hash(&daddr);
 		} else {
 			inetpeer_set_addr_v6(&saddr, &sk->sk_v6_rcv_saddr);
 			inetpeer_set_addr_v6(&daddr, &sk->sk_v6_daddr);
-			hash = ipv6_addr_hash(&sk->sk_v6_daddr);
+			hash = tcpm_addr_hash(&daddr);
 		}
 	}
 #endif
@@ -818,7 +836,7 @@
 	if (a) {
 		inetpeer_set_addr_v4(addr, nla_get_in_addr(a));
 		if (hash)
-			*hash = ipv4_addr_hash(inetpeer_get_addr_v4(addr));
+			*hash = tcpm_addr_hash(addr);
 		return 0;
 	}
 	a = info->attrs[v6];
@@ -828,7 +846,7 @@
 		in6 = nla_get_in6_addr(a);
 		inetpeer_set_addr_v6(addr, &in6);
 		if (hash)
-			*hash = ipv6_addr_hash(inetpeer_get_addr_v6(addr));
+			*hash = tcpm_addr_hash(addr);
 		return 0;
 	}
 	return optional ? 1 : -EAFNOSUPPORT;
