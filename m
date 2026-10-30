Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793327588;
	b=R1LchgUl8dnNNqI0Aa7X9V+JVHMkiLPNj8QTXj/3pXqs2qYI2Rc+4L8cDDGrcCRpHely
	 1d0CJHGdV/oKYlZcETIAOJccGoIz6n8fAsdTa8VoIls98WhzaXNyWuq/GT+mUSNRzTx5r
	 VoBr3GvvbjgeRMuwbg5LbrGVOgrVXh67xvOdcCE+h1AEeBGrJrqggXps4BjPpKxihHYwx
	 0cSL8OtZOOwYCGfiDU9uBX0k1l7ZeTokNx5G+iPYB08xj331rOrCnJhSO9ynKdOV5GZAE
	 LlN5CuiFH6dQQl040kDSuo591mJpi2EnpYp5LY5Nns7f7Q0pWUogEjErMEiDVvxxH9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793327588;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SIKkfA67UvQRqidJv7Hfli6cr7/y7nUfM2Bx1BgiLkE=;
	b=l2/2EOm3GLM/0/fVK4r1FJ4QMWCNLVtfTt67ahoVQcNHc98Y3TgwHANiio08sDZ85437
	 ZEeTDaCKsarYA74MF1k0I8A5GyzWboXzutn2Z+Y6g8QKDY+xYyYjdORtn77uPPmM+SV2X
	 uEb9lN9qZ/YzDLvVnmJuEWqjY8ugfX/oUlrRBPgh4dvUMO+H3UsPzuU5Kn5E/VapnN3r8
	 lSeprlnD17T9G6x1FqSqkeEqwQy2z9RcxzN0uJ+WdKHVnkKx5FoxemCOqBVUX6bNqio+T
	 IgYyEZ74lRIEckUB7JDDdhoyvsF5+1+3Nmn/PCf4m4+r1B1yeQGl8Fmc/WdL7xhJoAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QyXdKLmK;
	arc=none smtp.remote-ip=74.125.228.6
Received: from mail-pz2-f6.google.com (mail-pz2-f6.google.com [74.125.228.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5597606A325
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 02:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5597606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QyXdKLmK
Received: by mail-pz2-f6.google.com with SMTP id 41be03b00d2f7-cd61053473aso2923a12.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 19:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793327587; x=1793932387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SIKkfA67UvQRqidJv7Hfli6cr7/y7nUfM2Bx1BgiLkE=;
        b=QyXdKLmKaR0WHK0cJTyFaUEpfibyyQ5fW3kfeppI+vJOMhX/FDqjeS5UvEkcfOh/Uo
         1Wshvu8W9MHdPi+8huvuLQyvCeClepU067PEo9L6qJSpL3CLideAGORYNP+htWkiex35
         cuuJAzAs60zHbt9J/E0/3obXUk5lF8JFwiBzv/wsVpJ1WGdxrVyuTWIJjTIDNVs2eKAo
         x8+ehuhDeYWrDvVihQjj1onRG9tt+RHuw9H+aoVnYhPozwBhthzYcwLwFNEn889tbE78
         qia9oIKxu6TAi7PmpnL4ocyoXPtmVJtBOpTsYLyaFb6R2iZyosdbH9WnJkpghCJWGGoc
         Mc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793327587; x=1793932387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SIKkfA67UvQRqidJv7Hfli6cr7/y7nUfM2Bx1BgiLkE=;
        b=x72DNFtWPOedvPdMcf+uhLGJRqP4cV6PSWNBbyQLcBtUzuuG99c9EUbkZ7iFVsDS1X
         JUlytC1/AHbgPZEJyG6e1FZrb0mb73zWD1lNWPNV+GKbBNBnGVr3hHFwc3IofjGskCFX
         ob4C1RculAXxavTk6cMRUbqyLhvot8boY3WBBGp1hSeWnoPkt4PVfxxSaTdF+EbOgnM4
         Qjji9MabhXuRAly3k/FE1ZYppmt0dZewSQZr9zCBB4ohEbuWmX3Cxow9vs3JKyHG+RuS
         9TV+AnKxJrUMTuMTm3P8PImF3sXvRAFHrQ6T2eBcWVd6XIzVVNogeh8KzPREUyZsSztL
         OtGA==
X-Gm-Message-State: AFq9FYIqMckR0/Bh+xp3o0zYpm771aUkHWGQwEnwIUjoRcVBi9pYU//l
	8enMO1XWb76SZhLKWsmd72PK3QesZdexPw5DAxyF0agTjt0H0PbWZSxqJIhlVAO/jcPAZdtd
X-Gm-Gg: AYBFou1k5FsSI0KAv9KxMx/HOBkbaYEJvGauvmZ0TtRRGQxzCcqfbYq55bX2R4QDLG5
	pFvG/abwhsYGcbnWu8QALN6kLtwKehtQ32Cp9iB8wOPk0CGL0ITvy9YEb1Qq0pzqDBOW3iwITrl
	TuEdsLP+XnF4MtrzseU/hqHhxsfpnfxZ50hYKsb9VEsWyLi6H3ALm1wT/LAWNcWH/vfklyOo86A
	EeFFhQrHk1lz15A/O82rKkARkxEzl5q+Fg8FlbBpore0BH6Amh7Dq9qCgljPgnkxa/kPv7hGbvC
	K3T8eEuiaKFd2ZI2ikaxTloFGjCAfCpmaxRN8FsSorHBNzVSABSa+pdJoanDXx4g3ECfdHeYPnJ
	HXZQrbSnrNo6cyXHBqQJel87/IEG1HHH88m57jLGygYV7v0m+SHgXsSN6Zbabh/qFuMwSUA9Pa5
	R+toItFodWqf1mm8f/2WQVUbGgomBQmu8DLjH5SlyDAV6oefFkDkI2H5euCMz2+yHJ/4pWBazrT
	Yr8roPPzF1k+SAGH0RLjhq2G+FrlUcHxiOFI0qxomwUEfyjJZyInbvPF4MJUbNVBq6auNcrpL0s
	KbEmkFGspJTs/3Wo0mkgZTLtOHHzgccv9wEDpQnP4vNaRDRQPCMv7PM=
X-Received: by 2002:a05:6a00:a256:b0:882:2195:5a73 with SMTP id d2e1a72fcca58-8a9bfde0494mr516804b3a.29.1793327587137;
        Thu, 29 Oct 2026 19:33:07 -0700 (PDT)
Received: from localhost.localdomain ([58.247.233.220])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a9eef95f2dsm152216b3a.10.2026.10.29.19.33.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 19:33:06 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rongzheng Wang <testwrzwrz@gmail.com>
Subject: [PATCH net v4 1/2] xsk: defer software checksum until the skb is complete
Date: Fri, 30 Oct 2026 10:32:47 +0800
Message-Id: <20261030023248.78802-2-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261030023248.78802-1-testwrzwrz@gmail.com>
References: <20261030023248.78802-1-testwrzwrz@gmail.com>
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

When XDP_UMEM_TX_SW_CSUM is used with multi-buffer TX, xsk_skb_metadata()
calls skb_checksum_help() while only the first descriptor has been added to
the skb. The checksum therefore covers just the first fragment, and
skb_checksum_help() sets ip_summed to CHECKSUM_NONE, so the remaining
fragments are never included in the checksum.

Move the software checksum calculation to the point where the last
descriptor has been added to the skb.

On a checksum failure the packet is now dropped instead of being returned
to the application for a retry. This path is not reachable with the
existing metadata validation, but the behavior change is intentional.

Fixes: 11614723af26 ("xsk: Add option to calculate TX checksum in SW")
Cc: stable@vger.kernel.org
Signed-off-by: Rongzheng Wang <testwrzwrz@gmail.com>
---
 net/xdp/xsk.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 33475b180ea6..aa6b010192ad 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1011,14 +1011,6 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 		skb->csum_start = hr + csum_start;
 		skb->csum_offset = csum_offset;
 		skb->ip_summed = CHECKSUM_PARTIAL;
-
-		if (unlikely(pool->tx_sw_csum)) {
-			int err;
-
-			err = skb_checksum_help(skb);
-			if (err)
-				return err;
-		}
 	}
 
 	if (flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
@@ -1030,6 +1022,15 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 	return 0;
 }
 
+static int xsk_skb_sw_csum(struct sk_buff *skb, struct xsk_buff_pool *pool)
+{
+	if (unlikely(pool->tx_sw_csum &&
+		     skb->ip_summed == CHECKSUM_PARTIAL))
+		return skb_checksum_help(skb);
+
+	return 0;
+}
+
 static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 					      struct xdp_desc *desc)
 {
@@ -1275,6 +1276,12 @@ static int __xsk_generic_xmit(struct sock *sk)
 		if (xp_mb_desc(&desc)) {
 			xs->skb = skb;
 			continue;
+		} else {
+			err = xsk_skb_sw_csum(skb, xs->pool);
+			if (unlikely(err)) {
+				xsk_drop_skb(skb);
+				goto out;
+			}
 		}
 
 		err = __dev_direct_xmit(skb, xs->queue_id);
-- 
2.39.5 (Apple Git-154)

