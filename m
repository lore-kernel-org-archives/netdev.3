Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E171436BFB
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025985; cv=none; b=BT19fhL9tI7SsEbVzLIRs6j7JQf9Uza5Nm8dCpwuax82/jblR80fW+qKkuVlWXMNgtllBjX6bdWTdPjVJS3JTTRwI5ptqL1VU84o6q/akrOU3RNFc5H+xcfThegO+LYaxxKxgKQ9yrO2lFDXqPjNb3Q3Ce3O43y2PVvR7XcsqVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025985; c=relaxed/simple;
	bh=z97Qfqex8NpflZjNYVB7Vnn8QTNKwPOMZRuZDYBeTBA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VlIpWl9nafZSeBIMjjLeTNjfe21RkImT+EUn2lTjfaOYBGheqL0RMJTGC6cGEIcGB+unKt7+S0smUMXyAoDPPWiPRxRjirKd9TptNXYMb2WpMh3vvB9XGDp/YAyeI5k5BbDGmvQ8YFL2W2v9fx4wVdcVsHU3ZbpYKZ+82xc5tdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=epc8TWoW; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="epc8TWoW"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-934993d0f39so270393885a.0
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 07:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786025981; x=1786630781; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BIzVNNdIwAy8zwOMLS8zSNTv9isqvZQjc53x2rVVBKg=;
        b=epc8TWoWT7kkmipHv3d6TgY6GqS4DJZjUnvy1Casv1/OdRx7XFVnWuSTS5PHgcUQLJ
         kEqvM4vo25M4GlQD+F+ADArubfNevVFPumPTrnTRnqKhFaLyy7GWdpXnGcsOP+zsfGqB
         yReqVjqbDxBQspnqxN5XegSqJP/E6u/Et0qaG0J35tdxs9IT4yWvOonrTAaJ1BILWnI6
         1CjPWUWjsqK4ygS0uvxN1iGavrL+Q9pZcIv7Q9/mTb73WhAckFylIj9pZsxsBLZrvjdJ
         CudSpUsR2EoxCOEbeUBSc6faWlUNP41DjyQGcBRVaeGZrCU8Z3io4mABOy996iCxSl3B
         OI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786025981; x=1786630781;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BIzVNNdIwAy8zwOMLS8zSNTv9isqvZQjc53x2rVVBKg=;
        b=nBU1TDt5/GSMYfkPLSarN1RhJoYOmForrZuRdFVs9lZ0EJxZRi+E0+HVeuL2wB/P7z
         xYdsndhv0/frP+qh8hm6Yrxb6tlJqXHVK6z1Ejkq/NJFkROd9oDS3AkCuPq0VBjKUxmu
         9/rz0SIp3bW1K6ew0oQqFnkxYuFzg2vdZRUdyW+a+W7mXaiAPO3NMxiBHenjWIvrx8p0
         BzEDZHGGBoNqKoaRJ/Aq27nJ9lDol84VhsVSKSvmI4fVFH2soNCn7G1vuZch3vyrDrue
         XzFyWZWZAtWZ6Uco1zpGvbGph4BrfYOpKKIBZqvxB/txRwEbc6trLxjNfKle7hWyO9vU
         H/sQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro3PwOJMT64E9u9IQojZFYA+DzVxBOnhHu8Y0o82d9mbMqCJ6muxVuLa0WErBGhJXUklj0/YYU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb0aYZKmbg9eLutXkr9giHxkiKs1YvWO53p6NKeFaqCJc1pEmF
	XcIygRmxxGpU0bfjEnrRJDY5eByLzpP8RwX2HKnltfi8/pwO/BXe+K/lLXqW+wmt7ae9HV5uxIE
	3jP9gZOp2CicwqA==
X-Received: from qvxg13.prod.google.com ([2002:ad4:57ad:0:b0:908:6010:82b3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:40c7:b0:930:cb79:ee65 with SMTP id af79cd13be357-936492066fdmr1476667985a.30.1786025980984;
 Thu, 06 Aug 2026 07:19:40 -0700 (PDT)
Date: Thu,  6 Aug 2026 14:19:38 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.629.g250fe7f194-goog
Message-ID: <20260806141938.287660-1-edumazet@google.com>
Subject: [PATCH net] macvlan: inherit needed_headroom and needed_tailroom from lowerdev
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Tangxin Xie <xietangxin@h-partners.com>
Content-Type: text/plain; charset="UTF-8"

macvlan devices inherit hard_header_len from lowerdev during macvlan_init(),
but leave needed_headroom and needed_tailroom set to 0.

When the underlying lowerdev requires extra headroom or tailroom for
headers/trailers (e.g. macsec, ipsec, wireguard, tunnels, or veth with rx
headroom), upper layers calculating packet headroom and tailroom fail to
reserve sufficient space.

This can result in reallocation overhead, skb headroom underflows, or KASAN
slab-use-after-free crashes when dev_hard_header() / macvlan_hard_header()
prepends header data or when lower devices append tailroom.

Fix this by:
1. Inheriting needed_headroom and needed_tailroom from lowerdev in macvlan_init().
2. Propagating needed_headroom and needed_tailroom updates to attached macvlans
   in macvlan_device_event() when receiving NETDEV_FEAT_CHANGE events.

Fixes: b863ceb7ddce ("[NET]: Add macvlan driver")
Reported-by: Tangxin Xie <xietangxin@h-partners.com>
Closes: https://lore.kernel.org/netdev/CANn89i+1EW-sFNK8xoq98gMbPCeLS7e=+rs9gHfLg5Wj+4x0sw@mail.gmail.com/T/#m16adf0ff972cbfd8066c3a8e656e75eaeb12d021
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/macvlan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index c40fa331836bb2395267914807542ae5094e1a3c..ff2f4bb651b74cdb054f245ea0f4e8cfe2297193 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -950,6 +950,8 @@ static int macvlan_init(struct net_device *dev)
 	dev->lltx		= true;
 	netif_inherit_tso_max(dev, lowerdev);
 	dev->hard_header_len	= lowerdev->hard_header_len;
+	dev->needed_headroom	= lowerdev->needed_headroom;
+	dev->needed_tailroom	= lowerdev->needed_tailroom;
 	macvlan_set_lockdep_class(dev);
 
 	vlan->pcpu_stats = netdev_alloc_pcpu_stats(struct vlan_pcpu_stats);
@@ -1824,6 +1826,8 @@ static int macvlan_device_event(struct notifier_block *unused,
 	case NETDEV_FEAT_CHANGE:
 		list_for_each_entry(vlan, &port->vlans, list) {
 			netif_inherit_tso_max(vlan->dev, dev);
+			vlan->dev->needed_headroom = dev->needed_headroom;
+			vlan->dev->needed_tailroom = dev->needed_tailroom;
 			netdev_update_features(vlan->dev);
 		}
 		break;
-- 
2.55.0.629.g250fe7f194-goog

