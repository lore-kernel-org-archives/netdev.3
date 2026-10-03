Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097EF4915A0
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 21:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062628; cv=none; b=RKhkc+kT2LnFO7gXWf6BUat25JepNwHk8b1SJjKJus3korjE/LJO0YMIX6o9To5e3yWHu9VeDREclqcdeBZoUggVnswt8gS33K6AWM8b+9rc17rwwwWBhqNO/89o2VrZkt61Jp0KwV87BtNAvg7EBD9UCrKtQsEJQmR8KykvaRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062628; c=relaxed/simple;
	bh=P9yNaSRFw6ONfkYB/KFuvnl5DbYIe+uxAeeecMtVkok=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FmB6bQHyDdp9IG/+9WVOR6Be/KTYTKwLgkp2iJep9XKev96DSVK+YRDjpkrIOy9nXZCkziZadQrPRAo4PmWoUZ9L+ndPdSVaXZ9f/30SVO6+yMpt2Rsov6gjbj8cPvT2oNYRM64Ziip0nVnBqUDt8WGLmw4dBEhjG8wIRHdSOrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JHI6kjvG; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JHI6kjvG"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc4922b7c31so326170a12.1
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 14:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791062626; x=1791667426; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kl/+9o+vqH+ggoXnQi5qXo6haYFflVOEKmtyvgF2KK8=;
        b=JHI6kjvGbCys8ugQHeY4d6GIBw8coQ/C27BCdGu6lIFiNrenmRzkZeFO0QsNIoPqeA
         rHzBzipFhnbsLJhkUxjRXwb38RsxG1l1QqWctu115RNn8b0KqLtfsAfo+zapgSEvWsDW
         IRqglR+IN7C39Xn8R96g/YKh7kyUthY/LBVCJmzdhMekjhYJni4C+1yNtmKbGPzIsdo7
         /6lWd28jYHWEo7iBhQWvRmumiz52eq/TD8v9IjSamWa5X3guS78P4Qz0Mt5205jIpskD
         xJPkA6Y95sghNebVVJxEq8HNGTp0dQaNk401qXAowTeRjUkUyPv2YyeyQfl5uvNGGkB1
         nP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791062626; x=1791667426;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kl/+9o+vqH+ggoXnQi5qXo6haYFflVOEKmtyvgF2KK8=;
        b=FMCUYn4EGBF3Un1kRLmtrzUHjIxzJfSH4DG0/aRYu+IGORmcuIqFJkdC99PBTpnXNn
         kJRzW1ZfNnozWPq1BefdvQMixBjZ1zVcWdQZ+/pQZLOkB/GCYiq1N+k/5TXpwdAVGCIk
         d2tO1vGM2VlfdvvO4osAOkogewwtWIHxh2BE5KCjJ67mA9oXF6rAL5euLtIEPjdwAs2I
         zikc5mfwuDpOYdxrLsTm2jFy4cviIypqjx/U84k8Wcrf6wiMQ2UTmJScBeqS+AWiZlIZ
         5NwKNc7vt6texYXV5fz0Vi392SYjiJ1Ddt2/y8esci88+5E8k54kJTHfS6emdTKxGL9b
         s3kA==
X-Forwarded-Encrypted: i=1; AKwUvBw3OioJN9P5FcBO6ZDjlBH2rh5xaz4VjP9d1Khza94uQR1w8OOV/tyfZkJjkvjxv8hW/Bd6jaI=@vger.kernel.org
X-Gm-Message-State: AFuF++mcEcE3NozxF9HZeRYKJ2A1BLPbgEbPfRANlIqINVpzegg5BcxO
	CIw/37cwDRGIX9uNpb61E4B1rRZhNn0S0SWNx9bMFQO0EeoUPIwk3noxsdrPmIOKe2CazLyBRMN
	HihJhiw==
X-Received: from pgba18-n1.prod.google.com ([2002:a05:6a02:6452:10b0:cc7:e8ee:9777])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d10:b0:3dd:a196:30a4
 with SMTP id adf61e73a8af0-3e0bd4bbb09mr6778292637.84.1791062626158; Sat, 03
 Oct 2026 14:23:46 -0700 (PDT)
Date: Sat,  3 Oct 2026 21:23:16 +0000
In-Reply-To: <20261003212336.1304988-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261003212336.1304988-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003212336.1304988-4-kuniyu@google.com>
Subject: [PATCH v2 net-next 3/9] ipv4: Add wrappers for neigh_lookup() and neigh_create().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

neigh_lookup() accepts struct neigh_table *tbl and struct
net_device *dev, and both of them must exist in the same
netns.

It is error-prone to require callers to fetch a netns and
get neigh_table, which might belong to a different netns
than dev_net(dev).

Let's add IPv4-specific wrappers for neigh_lookup() and
neigh_create() that always fetch netns from dev.

Note that we do not add wrappers for __neigh_lookup() and
__neigh_lookup_errno(), which we will remove later.

__neigh_lookup_errno() is a simple combo of neigh_lookup()
and neigh_create().  __neigh_lookup() is almost the same
but converts errno from neigh_create() to NULL.

So both names are confusing.

For IPv4, __neigh_lookup_errno() is only used in arp_req_set()
and is not worth a new wrapper.  Instead, it should be inlined.

arp_process() uses __neigh_lookup(create=0) but it should
simply be neigh_lookup(), and then __neigh_lookup(create=1)
is only used in arp_process(), so this should be inlined too.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/arp.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/net/arp.h b/include/net/arp.h
index e932def63d62..329a5456987a 100644
--- a/include/net/arp.h
+++ b/include/net/arp.h
@@ -51,6 +51,22 @@ static inline struct neighbour *__ipv4_neigh_lookup(struct net_device *dev, u32
 	return n;
 }
 
+static inline struct neighbour *ipv4_neigh_lookup(struct net_device *dev,
+						  const void *pkey)
+{
+	struct neigh_table *tbl = arp_table(dev_net(dev));
+
+	return neigh_lookup(tbl, pkey, dev);
+}
+
+static inline struct neighbour *ipv4_neigh_create(struct net_device *dev,
+						  const void *pkey)
+{
+	struct neigh_table *tbl = arp_table(dev_net(dev));
+
+	return neigh_create(tbl, pkey, dev);
+}
+
 static inline void __ipv4_confirm_neigh(struct net_device *dev, u32 key)
 {
 	struct neighbour *n;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

