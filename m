Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E12343885
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 00:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789865271; cv=none; b=rbflbRg5t2S1BTpzgRsoAoQ9aaAgxAmKXvHEQtVvketZovxz4EReLpanQ13TFNysPvNg7UkpmpUgKKj5DtOj9v22NbCOA024AN9/n6uBzqW+R07jyhPO+hQ5vC5CyMy5WM48EX5o4Fr32MBuO8dbyKcaw4lrU3rfJ/mj8tP6/Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789865271; c=relaxed/simple;
	bh=wZF2qGAioUkITwtAve0FSWVizpc8AkxtsGOY0RjV8bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8xhj9+BdlT903dC5rbm4JsIitx3L8QuHsiJ9hhTx+onbQKA1i84a+BJU4qJPYn4i73GGMOp+zcII3grgieVyEDGPY+IJJ9oyWii81i9uuvwJ2hxpHCmmg7ZCzZ8tM06vv5dBAZOTAMXZp8ekzENu5BHaW1NG85lk68NcsGo4mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVPHD8BS; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVPHD8BS"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93a2a8c29c4so209041585a.3
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 17:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789865269; x=1790470069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=spIPE+evKRjnl976ChlZC7wECJM7DIX26kp/xsswnVs=;
        b=dVPHD8BSr5KzXjpJnfHK55PdQG/+ZXxp2Oxvd4CO8pg3l8PO21irhpRFEYKndeAfmD
         O12JHfVwGkwtHpm3dYl4ZgJ+k8GYsUFI2XmQ/40UIMSajJI1RoulB6lnqeWweu1gcJey
         UVt4JeL0phtSzEkbhCnWSLk+Z2XLEWkhD4Rfap6eLXAn7HvbLMk4jNwQoJyMgPAQQBzS
         MExho8VqwgF5/FCit7aJiwwrfBMs6Qb013mXxhspNP+yRI4KGuafOIZy/1xwUAI24oXw
         xKRuS4xZl5Aw9Kt2D6dhJnjOJBig1c8a2FU09WfdFksrZXYJoI6Jr/EjjJCWrk0wAolV
         ZT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789865269; x=1790470069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=spIPE+evKRjnl976ChlZC7wECJM7DIX26kp/xsswnVs=;
        b=ZeXb2DxTR+ZeecSCKoTa3QR5nHt52B9aAPI4zqwh6hqWikSpKSpj5q+v28oAd+OOYs
         KpXwqYRn2kqDteovhEICOZP3OEagixEwKE265t49N80BSuf/9UoMe07SUrnCYo3oUOQH
         FPi4HUikjn3S3bMT7RQ1xVMd7IdKTvBA2UewXzJ9O/mn5BLKiepJPr00hAf+koa8H9Fj
         WzS5ZyCCe0QbMBQotEVYo2ggLcyj1NEzRx65y/R6z+ci7C6N6v4kbZKqddee4DaX/aJ9
         66BqCUkSABeu01Ri6QzsWBOVOFykANv2AP0mU5zKU+21bYBlgQa6gXYXP4enMiFDlFRh
         Yzpw==
X-Gm-Message-State: AFuF++nz2RSwq4QB4Tkc10b0ul2mJZYIAoDkkJwiiVatNSdxHpuzjljW
	B1IfFf0WlkgqZ1s1ybhbo7odnhcLW8kgo6Xbq4jwVPw2nXLzEYU6gsXt81IXPWf/fRc=
X-Gm-Gg: AYBFou33Suq+kJpcHC9QkIu3KxxpXR9ZtnSIolpe4DEdr6vMenPsnoZXMK/OOPeG8jb
	Eh3MWq1blFz0umwYzdlx8pRl17wJQo/DRFG9pkeM7I/7rz2fxczhwlztuHbgaZBVMc6at40QO3G
	QqINsdn+ATrAhtgHpgyzggQKkjbjUzkbZiu8BYiZpeqxM+FBpE588GsFyT5JbPdoBIzlX2zZCag
	aIy48H0qjQEp4U8MbHL5jGiOKCf1ELvwiZDUmXUWbOeQvIf5CJl1124BHoRPiwxQEitINBM431L
	+UxDCje17UENpGQ3fx3wPfB68u6vwxLophxjRQFwwN6YkzXyPGntbPYLVcbK+yuPBIqdZfbqQeP
	TnlMcjhdnkFYKp8mh7mFVbajAbXPNHNETxBHzs3iGod/8oRKwee3K8gm8CRdpdXcuw9f8Go8MhC
	kYwNBftnrEou9n8MWBFwe41jV7N7pbWBxGDAi6YACeU30HOtU9+vq1KV80xG/fMEXREx92gpwDS
	SpdNHvDYut9tkd+24Ms/i44DYLh23I9oeEoXAyv70bU+JaU1arW2CehRJDtYcEeOOK3Ff9g
X-Received: by 2002:a05:620a:bca:b0:939:1483:55c with SMTP id af79cd13be357-93bf552c2e3mr403046385a.19.1789865269267;
        Sat, 19 Sep 2026 17:47:49 -0700 (PDT)
Received: from localhost.localdomain ([2601:155:4200:2c80:c8b1:39dc:7ddc:dd0c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9126078cab2sm32122436d6.0.2026.09.19.17.47.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 19 Sep 2026 17:47:48 -0700 (PDT)
From: Paulos Yibelo <habte.yibelo@gmail.com>
To: netdev@vger.kernel.org
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	hannes@stressinduktion.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4 2/2] ipv4: reject partial checksums covering the IP header
Date: Sat, 19 Sep 2026 20:47:33 -0400
Message-ID: <20260920004733.6473-3-habte.yibelo@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260920004733.6473-1-habte.yibelo@gmail.com>
References: <20260920004733.6473-1-habte.yibelo@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip_do_fragment() completes a CHECKSUM_PARTIAL skb before reading the IPv4
header length. A virtualization interface can supply a checksum start that
still points inside the IPv4 header after link-layer removal.

This does not require a virtual-machine guest. A TUN device with
virtio-net header support is sufficient to reach this path.

skb_checksum_help() can then change iph->ihl after the packet was parsed
and routed. Fragmentation trusts the changed IHL and can copy beyond the
skb's logical linear head into transmitted IPv4 options.

Read and validate IHL before checksum completion, reject a checksum start
inside that header, retain the validated length, and reacquire iph after
skb_checksum_help().

Fixes: dbd3393c56a8 ("ipv4: add defensive check for CHECKSUM_PARTIAL skbs in ip_fragment")
Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Paulos Yibelo <habte.yibelo@gmail.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
Changes in v4:
- State explicitly that a TUN device is sufficient and no guest is required,
  as noted by Michael S. Tsirkin. No code changes.

Changes in v3:
- No code changes.

Changes in v2:
- No code changes.

 net/ipv4/ip_output.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index a24cc8e..ff902a2 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -770,17 +770,29 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	struct ip_frag_state state;
 	int err = 0;
 
-	/* for offloaded checksums cleanup checksum before fragmentation */
-	if (skb->ip_summed == CHECKSUM_PARTIAL &&
-	    (err = skb_checksum_help(skb)))
-		goto fail;
-
 	/*
 	 *	Point into the IP datagram header.
 	 */
 
 	iph = ip_hdr(skb);
+	hlen = iph->ihl * 4;
+	if (unlikely(hlen < sizeof(*iph) || hlen > skb_headlen(skb))) {
+		err = -EINVAL;
+		goto fail;
+	}
 
+	/* Complete offloaded checksums only after the validated IP header. */
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		if (unlikely(skb_checksum_start_offset(skb) < hlen)) {
+			err = -EINVAL;
+			goto fail;
+		}
+		err = skb_checksum_help(skb);
+		if (err)
+			goto fail;
+		iph = ip_hdr(skb);
+	}
+
 	mtu = ip_skb_dst_mtu(sk, skb);
 	if (IPCB(skb)->frag_max_size && IPCB(skb)->frag_max_size < mtu)
 		mtu = IPCB(skb)->frag_max_size;
@@ -789,7 +801,6 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	 *	Setup starting values.
 	 */
 
-	hlen = iph->ihl * 4;
 	if (mtu < hlen + 8) {
 		err = -EMSGSIZE;
 		goto fail;
