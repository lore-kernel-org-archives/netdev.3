Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1664AEBE3
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 22:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387892; cv=none; b=Gk+buoXei6wLeuEncVOU8E6v6UMHJyyKnWhhOt9GJAwBH1YdWedpnf2/kCAkNTjS8bVkJ5SQGpaAvdUdbDU9Gi1aeWjE5FmJa+Cm3vJtbDNgHISI0EqitsqWmKPyrhsMIzQMuTKw/XtY7kSURkDjrYe4GNA6j+znMqrxa0hJ/Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387892; c=relaxed/simple;
	bh=2+xvpsSLAnGLVs/p2neoZdpd1irchwRpTrO6e27974s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KL8r72mGupCeRX6dW7UqQmtEiSgfai8LvopEpunKX56mit5LQy+DSHwJ2rTJoxPaTuRp01o5v1dd9A7GGzXeX5pJ6rV9WYPavwW85ZbpG99NoatXlLFxIeN92P5NyCxJHHu5yWnSbDZzGqJ9FdII4+qs4ZvDU4LsZilkxzL+bWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIoFxNV6; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIoFxNV6"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7f57db8b5a4so1260914a34.2
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 15:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788387885; x=1788992685; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=n5rCfQVWj8V00nMIMl18yNILIGrHQT/mE2GeDtDPrJI=;
        b=MIoFxNV6f1KUWzXGGhk7IED9+0sytyb0wgeWfIb7sM2Ert7RSnYWlfIy2YymqykMP3
         eJRpr4uzqse+DOzMfBrZ9Pm9Ckzd86PXpmx4QCy+0oi0r/brGMszSvfjbsyT22TnNiYh
         m+YsnDnn8q+w8EgSmF44hdOI/rTrUcJC5q1kHyjqd+QHAFj1fuivPbx0ID2HeZFctMP/
         l0jyqEjBs47MRojgWNPQfcFB/ZapbeZSOjnRKyqcEJsoWDlb5boYxX+jxsQRqFrJWY4B
         9HkjEbX+pe5QGrjznTvWap8PsDLyXpOr0HNh16VTlyCnDkMJstj9tFEXhc2Syt/lObdS
         /6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788387885; x=1788992685;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=n5rCfQVWj8V00nMIMl18yNILIGrHQT/mE2GeDtDPrJI=;
        b=hEzajIyAgP3Ea3PbbZzazbjbkfjlYcuHB0Sep5oOVR2nmWSLGYXe5AawJkAKpHxtu/
         N0S2vX1DBQtbw1kxGXitLH7gxwekT9U983dpuWGmr5/GocOT7C2U11y0z7MTXTHAmNFI
         tP5Vwl7YhSAEIOi0hDpXk4vvSLUQYZb9K19dA59SEKf4MWwGanNJiZMHUqd+J3K6O6mA
         lDCmsz2oq1SLrRmJxulKZAIViPxMsbuQiYuNEsgNQiRZjDnrIpgXXmGLhxUsv+B1ml8R
         PuHW5HHlddZ+jA5f/862Tafycs4PvWLUM7Wtp53RcvnA03ML7oO+zmnxuaT+Zh+Aa9vR
         91Cg==
X-Gm-Message-State: AFuF++mfX2MAuhnB11q6aWN+BlFE/ymL37J//TvL4Dfuq21Re1psPURd
	kkIPk4Khkg0eKWaru+NxqfEMDR9ucl0akZfVtA9N4ZZZPXIqZXPKXyoy
X-Gm-Gg: AYBFou16XFYym3CzxGKmhjzsFFJasydaO+e2DHGI+iwFstJ0JGn9YhJTF/T+I9nfa54
	7K32IhHvn/wgI0u+c/kyQucuZ6nkQ07IQ9aXnog5JK1/yoFYZwaMNsmJWaTqcGAcbijIYEM1nfF
	psi3iT/Y3iOCC/AvqoLYJZGaJ7GyW2yGArZGmC9458ZvD7xpIpUcpbgI1oJJLm7JwVqOsZWR0Ov
	lhLAH8/0asqtnSbBUsFUUQZt5K6QQsAB+XlIuMMO806q0exm3X8SJH2QdfLz1NsxWC4ZU+lpPtB
	bDZ5E0UVtIx88pfXVUiVzOfViCXsMR97j2VwuO6uukVc8Zu+PDDeB2SqsSQo7kcuwa3FFgPEqpn
	etwo1A1P3EI3suk/vP4YZxr0UAADp56HFZ2fzRgYILD+YpkjNFpeatRN3M3VMzORGjZo58Xng57
	R06Axl5nv4J6PNyzYofFQF6zFX1BNZC0PF2a8bc4URXfDsWefgjbJrufk=
X-Received: by 2002:a05:6830:6b0a:b0:7f4:e011:6b3f with SMTP id 46e09a7af769-7f781cb30e3mr7433643a34.14.1788387885153;
        Wed, 02 Sep 2026 15:24:45 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f74d1b206dsm3206049a34.10.2026.09.02.15.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 15:24:43 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 02 Sep 2026 15:24:19 -0700
Subject: [PATCH net-next] tcp: devmem: only pre-allocate tokens the
 receiver can consume
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-b4-net-next_devmem-token-refill-v1-1-81d8990e5e17@meta.com>
X-B4-Tracking: v=1; b=H4sIABSimGoC/zXN4QqCMBSG4VsZ328PTLNsu5UIme1Uh/QY2xBBv
 Pco6O8LD++GzEk4w5sNiRfJMiu8qSuD2zPog0kivEFjm5N1tqahJeVCymvpIy8TT1TmFyslvss
 4knVhcIeuC/F4RmXw/vb1d7jgL3Hd9w9e4IheewAAAA==
X-Change-ID: 20260901-b4-net-next_devmem-token-refill-09ab9377ad58
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 David Wei <dw@davidwei.uk>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

tcp_recvmsg_dmabuf() derives its token allocation amount directly from
the skb's nr_frags. After filling the user's receive buffer
tcp_xa_pool_commit() erases any tokens that were not used. When the
receive buffer is significantly smaller than the skb size, much of the
token allocation work is wasted.

Bound the token allocation amount by the remaining user receive buffer
size, and consequently reduce wasted xarray work. Introduce the helper
tcp_xa_pool_max_frags() to compute the token amount based on number of
frags and their sizes but capped when the accumulated size exceeds the
user buffer.

Testing on a CX7 w/ GRO and a steady sendmsg() flow of 1MB per send, we
see a typical RX-side skb touch upwards of ~32KB. With a 4KB recvmsg
size, probing shows that ~75% of the allocated tokens are not used.

Mean +- stdev over 5 reps:

    read size    base Gbps        patched Gbps      delta
    ---------    -------------    -------------    ------
    4K             29.7 +- 0.5       42.4 +- 2.7    +42.9%
    8K             47.0 +- 3.1       61.9 +- 4.8    +31.8%
    16K            69.6 +- 3.4       80.2 +- 6.7    +15.3%
    32K            88.3 +- 0.8       87.1 +- 0.8     -1.4%
    64K            87.5 +- 1.2       87.0 +- 0.8     -0.6%
    256K           88.2 +- 0.7       86.5 +- 0.8     -1.9%
    1M             88.5 +- 0.8       87.5 +- 1.9     -1.1%
    4M             88.5 +- 0.8       88.0 +- 0.7     -0.6%
    8M             88.6 +- 0.9       88.7 +- 0.7     +0.1%
    16M            88.7 +- 0.6       88.0 +- 0.7     -0.8%
    32M            88.4 +- 1.1       88.3 +- 0.6     -0.1%

perf over the RX cores, at 4KB reads and 1MB writes (before left, after
right):

    10.94%  xas_store                5.06%  xas_store
     3.74%  xas_find_marked          1.49%  xas_find_marked
     2.33%  __xa_alloc               0.91%  __xa_alloc
     0.96%  __xa_erase               0.25%  __xa_erase
     0.80%  __xas_nomem              0.43%  __xas_nomem
     0.49%  xas_load                 0.74%  xas_load
     0.45%  __xa_cmpxchg_raw         0.74%  __xa_cmpxchg_raw
                                     0.28%  __xa_cmpxchg

The gain is only for reads below the typical GRO receive size for the
system (32KB on this system). Above that the user buffer covers the skb
size, so waste is already minimal.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 net/ipv4/tcp.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b4237d0e994d..c35277439386 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2494,6 +2494,32 @@ static int tcp_xa_pool_refill(struct sock *sk, struct tcp_xa_pool *p,
 	return k ? 0 : err;
 }
 
+/* Return the number of fragments of @skb deliverable from byte @offset, capped
+ * by @remaining_len. Returns 0 only when no fragment holds @offset.
+ */
+static unsigned int tcp_xa_pool_max_frags(const struct sk_buff *skb,
+					  unsigned int offset,
+					  int remaining_len)
+{
+	unsigned int start = skb_headlen(skb);
+	unsigned int max_frags = 0;
+	int i;
+
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+		int end = start + skb_frag_size(&skb_shinfo(skb)->frags[i]);
+		int copy = end - offset;
+
+		if (copy > 0) {
+			max_frags++;
+			if (copy >= remaining_len)
+				break;
+		}
+		start = end;
+	}
+
+	return max_frags;
+}
+
 /* On error, returns the -errno. On success, returns number of bytes sent to the
  * user. May not consume all of @remaining_len.
  */
@@ -2503,6 +2529,7 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 {
 	struct dmabuf_cmsg dmabuf_cmsg = { 0 };
 	struct tcp_xa_pool tcp_xa_pool;
+	unsigned int max_frags;
 	unsigned int start;
 	int i, copy, n;
 	int sent = 0;
@@ -2554,6 +2581,8 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 		/* after that, send information of dmabuf pages through a
 		 * sequence of cmsg
 		 */
+		max_frags = tcp_xa_pool_max_frags(skb, offset, remaining_len);
+
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 			struct net_iov *niov;
@@ -2591,7 +2620,7 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 				dmabuf_cmsg.frag_offset = frag_offset;
 				dmabuf_cmsg.frag_size = copy;
 				err = tcp_xa_pool_refill(sk, &tcp_xa_pool,
-							 skb_shinfo(skb)->nr_frags - i);
+							 max_frags);
 				if (err)
 					goto out;
 

---
base-commit: 1bb784eb6e38fd73143f021608e4ef3095d0c0d7
change-id: 20260901-b4-net-next_devmem-token-refill-09ab9377ad58

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

