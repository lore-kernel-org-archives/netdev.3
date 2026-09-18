Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7EE30D3F8
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745773; cv=none; b=fjhJ3pTRcLgGzTXTHY+YzEa3Ul39hZnCecYXPkUEgVd+N6XtK+Y8dpqzVtDQWn4zCwZiKNZiadQx6P+B0+OIm2AM/1OA7+YKp9mIF+bwCAZnyUzsW/uQUg/FDdgO+3+adle8Y5cZGfvln5qpyq2defzcrVn/RaRVztsTzBVKUh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745773; c=relaxed/simple;
	bh=4frnw4AJIHyHABYm5pg5pXRmS9EbYLGkBKG0nfplNyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vhu9JVzldIqZnIrvCscRLRDdm5HIscKsADtuQ1GdrkCNhtnxyIBDxsqCjqrktgFBpx76M1iKX9dY7u8MJpVNoF+NJKb0eJXubCesNP5EKlKA2ce0nfHJQRdtKPzJTQURWG6qyzLP8i6JsgVVtXnR9fTnxKOR4t2AY7gs/RbxO/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pHjEjspL; arc=none smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pHjEjspL"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-895eaf31683so7818427b3.0
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 08:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789745770; x=1790350570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H9QJBIVHpp1T8EOCutwoOsBtVXRjP2JjVf/HAZ5Y8Gs=;
        b=pHjEjspL8J9MXJJtnYbN2InVL3K29MGi7RdhmlAI/9Jd2i3x9vIq+azdsKzS1of2ZF
         X1sdh1bVsmetRbapyzEM6zwRBilXTQ2VVurPmJcdAEd3/ZpODLBjIKa0y5NLKZbn4z0Y
         EjiBWHvJMNIkO7syr6Hbn3D1Z0nwO06yBheegWro481R3k7jNoazhuBn14w6cSwRDt+b
         5ow4DQLK6YOysFl0wjo1MSVZnlbzDdj9k2QbS5oVn+8nNj+N40oGebzHuZ7ECKd5aaek
         3yz1J0osti/JrZ8UC4eRiPFL/59oj9e51fauh/VpgxVPesIfnUaCdC56ZS4uBPQotZJD
         a4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789745770; x=1790350570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H9QJBIVHpp1T8EOCutwoOsBtVXRjP2JjVf/HAZ5Y8Gs=;
        b=DvkxZeokopXWo3CSoNU866ttyY3SjPE5ir6NeGR3YdK7kxXuQA5Aepu6iP2HaQzbjQ
         bRkZMjzfy9Wq42SnUVbDhRUIKVeCi0N1/wexGyDxJkIPGpl2k5p1NK3tT+TeKT2i9TQ1
         eFvrVW9ocRvHFDFeDOq0x1GZzvGBcsPtmwfKUWI58ZY5H+6hJh6d3hl1gvj6eNYHJpqN
         NtkAr68XlGFE/EBU2ZLDQZg2dby3INPAG8Dv9VkQyHVvAqpskYKrtmMqlT5ZD0o0J7ss
         2RSMHsHO0kpGJz0M0TX+zUHmGa6k7mWr/bI+aNcsgFSyalhqEGFihLn1oPwxmgHzwqOS
         e3oA==
X-Forwarded-Encrypted: i=1; AKwUvBzvVnTZ5GQmBHaicJ2ICvjPm135PMJzLp8Sz/vxa6WNmjj3jPO3EcByQOlYVi7sfOG79ARAA9I=@vger.kernel.org
X-Gm-Message-State: AFuF++nVCbUK9oAU57EQGNedkfBsnB2rH+UskDrvxE4Sg90FXMCK8VIs
	14L/C4bvZKBCMnHL5wZSq3YQfxL3XHmZ1loeA02iA2wNTeQCLscfKJ5O
X-Gm-Gg: AYBFou1x3cl5X+OF6ctmk5N22+oBBxOawSu2ApFxMdfihiXilmSxQOPYsPmNzuZQ/Td
	+GJvHE4iHH+PUAJ8FJ0FuOZXqB7vLi8hrd73pLgnUMsGT5jiouLqcd4rA2sNgfaDS4bT83FtnZ6
	ndcuWzlqqnVkuYgPyRrZiiyO3GeKab3ayWKoGFZYn2TBrxgPq8Kocog4acF6rgtrinfqSeYFrCU
	FlHnjxGTFAfRX/Jrf2wbgkgpzswUX+n3QFQpTM6fvWOF63KQMQLNBKpNxGi38VCaywe0jC8GNH8
	WDItiutXlZg4WgmqLiJIhzk+7waJy438hye8ysFg+bAawifwbwfGGB6/UfYpkuiS3LyE8RH5LsX
	rzZywLFle90L233O2Xi0iw9z5Xuh92HIr6JDcLZayRu1UjBkPM0KGODxSotSUcnZk+M+Wn5CIW1
	lPVsXoACwR0zxYRFufs50Qka1bGCAm/FGGUl8uFP40axEJhblAlLyHR50755BGpsLlhntj0sSpE
	XopeOiCz5ZlaYR6B0cEQB93l4yt4LDfQcg7hZ8LPW/d+U/Ufaz3tly0Zk+9M3f/6g==
X-Received: by 2002:a05:690c:4ac7:b0:87f:e953:f6fe with SMTP id 00721157ae682-89733c1f4damr7920667b3.27.1789745770490;
        Fri, 18 Sep 2026 08:36:10 -0700 (PDT)
Received: from customer.bnssarg1.isp.starlink.com ([2803:9810:8266:bb08:24a9:9eba:f922:f56a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a46e4dd4fsm469007b3.25.2026.09.18.08.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 08:36:09 -0700 (PDT)
Sender: Mariano Baragiola <mariano.ignacio.baragiola@gmail.com>
From: Mariano Baragiola <mbaragiola@linux.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Anton Danilov <littlesmilingcloud@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mariano Baragiola <mbaragiola@linux.com>
Subject: [PATCH net] udp: resubmit encap packets for secondary mcast sockets
Date: Fri, 18 Sep 2026 12:36:04 -0300
Message-ID: <20260918153604.579277-1-mbaragiola@linux.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Multicast delivery clones packets for listeners after the first one.
Commit 3cb8d4b9bfeb ("udp: fix encapsulation packet resubmit in multicast
deliver") fixed encapsulation packet resubmission for the primary
listener by propagating positive return values from udp_queue_rcv_skb()
to the outer IP layer. However, it left the loop over secondary matching
sockets unchanged.

When an encapsulation receive handler requests protocol resubmission for
a clone (ret > 0), the secondary delivery loop currently calls
consume_skb(nskb), silently dropping the packet.

Resubmit cloned IPv4 and IPv6 packets directly to the returned protocol
via ip_protocol_deliver_rcu() and ip6_protocol_deliver_rcu(..., true),
matching the ownership and resubmission conventions used in the
segmented GSO paths.

Fixes: 3cb8d4b9bfeb ("udp: fix encapsulation packet resubmit in multicast deliver")
Signed-off-by: Mariano Baragiola <mbaragiola@linux.com>
---
 net/ipv4/udp.c | 5 +++--
 net/ipv6/udp.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index bb8cfc62cb00..d79be57854e3 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2522,8 +2522,9 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 			__UDP_INC_STATS(net, UDP_MIB_INERRORS);
 			continue;
 		}
-		if (udp_queue_rcv_skb(sk, nskb) > 0)
-			consume_skb(nskb);
+		ret = udp_queue_rcv_skb(sk, nskb);
+		if (ret > 0)
+			ip_protocol_deliver_rcu(net, nskb, ret);
 	}
 
 	/* Also lookup *:port if we are using hash2 and haven't done so yet. */
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 93478d1ad576..ca8d0a1844d2 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1001,8 +1001,9 @@ static int __udp6_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 			continue;
 		}
 
-		if (udpv6_queue_rcv_skb(sk, nskb) > 0)
-			consume_skb(nskb);
+		ret = udpv6_queue_rcv_skb(sk, nskb);
+		if (ret > 0)
+			ip6_protocol_deliver_rcu(net, nskb, ret, true);
 	}
 
 	/* Also lookup *:port if we are using hash2 and haven't done so yet. */
-- 
2.55.0

