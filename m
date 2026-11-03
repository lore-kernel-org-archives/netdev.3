Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725781;
	b=Zak97LGQkzewMx6zXeuZtK75DnYMUVoFMs7CkkR0tjtKxbNgJeYqeT1gUj4f4Fv/krFp
	 BY9SfYLwjyL5z9yPRHIdSxAdvjg1XJuxFY7x6COorlkR2KxdzYrJ3uauSE5vwazBC4Tgx
	 fVAL8MVAw9xesm1s8atr4wOSwEKO7nkXGOm1N87A9BYSWzXAmxtLOmco6P24sIzsMKWAy
	 w21LCMA4GvNqUPyWQDQI9EeB0nsHXe1e2I61gbxi8AHjjkdnbzrbHNiQaBJ17ccL1rbdq
	 tlgyuM9EFD/96EtU6Voqnyzo0YhMEcpja0csvVYNiOlmtK/VyFkWMFIpXAz48rpywvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725781;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Subject:From:To:Cc:
	 Date:Message-ID:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=BmASpXXwPNu0Mm15CUdYzIJM1zVTMbWZjlzlptieXNM=;
	b=SycaXcC34tHSyAacmLCsPobM064S6Tl8cnsY4TAFX4vi9s+WaCwsptI0duUHhh6litYh
	 vSFbxkOEueO813RhuqeIP+nlrQTjLvuRnKRJWBlHLnp4K9Z6O7wNqdZL8OyEr/AO5QXbn
	 oLEgjc74OHXuky9zlAKarS+pviAvEUAl1KguXfiBIJSm2fkPLHKXfHBPhu2S+I20QHKTA
	 QZ9J5Rs0ghcyCzGMuF7lIgzcNwokwfGY+3uPlaQqoZXi2xu+AxC6sgn9W9XYNkOGX33xc
	 SBgOFEuTZlhsPopdBfvLSsUIqmG4MJXSedmD6jFEM0eZNs6MkmrsgeDlyafE4LjS+hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kZCKL1lK;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A48606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 17:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7A48606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kZCKL1lK
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36a2551d7b5so1001309eec.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 09:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793725780; x=1794330580; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:cc:to:from:subject:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BmASpXXwPNu0Mm15CUdYzIJM1zVTMbWZjlzlptieXNM=;
        b=kZCKL1lKfOY2G5eS81vdoAZBH3XD6hz3ifxVKcalpGR3YPjO//zoS3QDJPjszMBjhO
         8a+7q+uQvg+n74ZeahZj7YWyk4KjHZiTNeNIKHt53Avaqto7d1W0cO957U8aXwx0m33l
         k0OEh79lcNBNe0Y7tUasWF3eKFW/aQSL3IPXob+X7tpbAgynYZwv7DBpyoB7NSQjqp1q
         NN5nkw0dunHa0QP6hPXIV/OIc2wBej6b4CIQ3ay5JQnBMvyeBTaga38sJAX0O2BLQeRz
         phvihf+X9fRpxxUO1m24wMDhqsZQFvve7TFHpRT5KBaDJNDR3CyM/KD9xe3FPmW0TRWQ
         Nj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793725780; x=1794330580;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:cc:to:from:subject:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BmASpXXwPNu0Mm15CUdYzIJM1zVTMbWZjlzlptieXNM=;
        b=v7UBHqqAfdFLz8a1udZw1xqC5NPp+/l395Tk4+kixzFw4a1LbvCycJeGG9Za6EwOMj
         Zm6ThoXRB/ausF1dLZZFefZyLgXPy+81paULQNlGLj1rL3jl9vuakLs8vrelMClG2Njj
         GdbyDxlCHUGPmwa/tWbtQ+NSzgmH2fZC5faRU8eh+yTW32U7QofusQSe9xtqeG8hmcn4
         hXEfbU94FyWM+W01x/hB9zETKi19pqnyK8imoKDK0I3RwoSAgDtpyw1DR3PkSOtk3w8x
         /u0wKywwMHBEa+Mmlzma5nW2z3MwoPbEtu6oCH9vOwYKSyB31JPeYLctU3BdbNGBInGv
         oDJA==
X-Gm-Message-State: APuU4Z+h9QJvaBuOyyKQl0eSnwCRb9Cbj9JJIoCRRa13X75TYbWfr1W2
	tP3ISJaSpaD09gVF7RpYpLaUw28gzNdPpE+pDIxtOnVY0lo5H1D9ZeCJ
X-Gm-Gg: AYBFou37D5ybMzveYTeNEaeEfmPD9hjN3N3Q09ErJxRlKTIwVvOSM32k07EW/CS5oXR
	HrTYmfISDhZm4BQcma6WBPA9Mb+ypdGDDWa7K1sbMWrR/Pi4vzJRTCIaQpvoZ4ANdhLAfKzP34H
	RXlD/n3lWlhazsgtqF8qs7sO7Av4Sjg0Mf+R3n0hSDdeVXOvAoPAC8/EAEeR3A8PkrKmriw4d4D
	L8ppucJspKp03Dg8J2bPxl580s4zJ83/7MKBlzxc13liLaXUx4wTK0vGgOmutk7PldVqPCr3qEu
	KIqTBcDYTRo5l688NwOk31Rqz3RevvurvfD6uSBUKTYcjTnm44B6vEGuL1EYSurJtlxWhbL6UC5
	98tz2kBiONyn4+VtmZU3IJ+Uj5kbaqIUgL1XP0IPP9PwimnODelwHUEI8KSFPR/EVxJlNiMerZb
	orZAn8+ykFWdfkszKehBzPfUG/pjE4lOcTJBqEM49CSUVix3ikMsGq5B7YDM+FY8Y+YIUWzgSez
	TW9XnxO03oJQAWkun2blsdlZdBN1TPumpQSs2gBx4cKq70TKZHxSCDVXD70cBlDKz4+o3Uwyy64
	d7Pvh21qfnYYg5+B64X4BYrBJHprRd2h5gDHnuIIvXC0HlCYa1fLVGOzWcOL5EcIyphwGSp7thW
	vIa+XYIvC36wCc5+6QmH1eoPoNJe4osFbRDGQZmDgTqI0eg==
X-Received: by 2002:a05:693c:4152:20b0:358:c5c9:2661 with SMTP id 5a478bee46e88-36a423c6383mr22043436eec.10.1793725779615;
        Tue, 03 Nov 2026 09:09:39 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c1:38c:400:22f5:2de:b9c3:f27c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4291e38fsm57059650eec.15.2026.11.03.09.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 09:09:39 -0800 (PST)
Subject: [net PATCH] net: Segment CHECKSUM_UNNECESSARY GSO skbs other than
 fraglist
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, pabeni@redhat.com,
 tactii@gmail.com
Date: Tue, 03 Nov 2026 09:09:36 -0800
Message-ID: 
 <179372577673.49909.11253315483074546903.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
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

From: Alexander Duyck <alexanderduyck@fb.com>

The netif_needs_gso function lets a GSO skb reach the device unsegmented
when it is CHECKSUM_PARTIAL or CHECKSUM_UNNECESSARY. The second case was
added for FCoE, whose transmit path marked CRC offload that way at the
time. Commit 253aab0597d9 ("fcoe: Use CHECKSUM_PARTIAL to indicate CRC
offload") moved FCoE back to CHECKSUM_PARTIAL but left the exemption in
place, with nothing left that needed it. Fraglist GSO, added later, is
its only user today, as its segments already carry valid checksums.

A TCP GSO skb can still arrive as CHECKSUM_UNNECESSARY without being
fraglist. Hardware LRO builds its aggregates that way, for example mlx5
sets SKB_GSO_TCPV4 or SKB_GSO_TCPV6 and CHECKSUM_UNNECESSARY, without
SKB_GSO_DODGY. IP forwarding and bridging turn LRO off, but a tc mirred
redirect does not, so such an skb can be sent out another device. It
has no csum_start and its TCP checksum field is whatever the aggregate
left there. Drivers that only set up TSO for CHECKSUM_PARTIAL, such as
fbnic, i40e and ice, then send the whole skb as one oversized frame
with a bad checksum.

Have the validate_xmit_skb function mark any CHECKSUM_UNNECESSARY GSO
skb other than fraglist as CHECKSUM_NONE, which means the same on
transmit. The netif_needs_gso function then segments it in software,
and the __skb_gso_segment function unshares the header before the
protocol code rewrites the L4 checksum field. The callers of the
netif_needs_gso function that decide on segmentation for themselves,
such as tap, are left as they are.

Found by code inspection. In QEMU with an emulated fbnic, TCPv4 and
TCPv6 GSO skbs built this way each went out as a single 11 KB frame
with a bad TCP checksum. With this change they are segmented into
MSS-sized frames with valid checksums.

Fixes: 253aab0597d9 ("fcoe: Use CHECKSUM_PARTIAL to indicate CRC offload")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 net/core/dev.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index f32353b0467c..28b4a652d037 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4207,6 +4207,17 @@ static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device
 	if (unlikely(!skb))
 		goto out_null;
 
+	/* Only fraglist GSO, whose segments already carry valid checksums,
+	 * can be handed to a device as CHECKSUM_UNNECESSARY. Any other GSO
+	 * skb has no csum_start for the device to segment from. NONE means
+	 * the same on transmit, and has netif_needs_gso() segment it in
+	 * software.
+	 */
+	if (unlikely(skb->ip_summed == CHECKSUM_UNNECESSARY &&
+		     skb_is_gso(skb) &&
+		     !(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST)))
+		skb->ip_summed = CHECKSUM_NONE;
+
 	features = netif_skb_features(skb);
 	skb = validate_xmit_vlan(skb, features);
 	if (unlikely(!skb))


