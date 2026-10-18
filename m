Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E444D4A2A5F
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 12:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792328347; cv=none; b=ZJMyPL9MC4cB2tlpVXmDYeIpmZ40n3FLqJGZWpXqKiXrFoQNhjJhgTpIljLSSJcR2fyZ+nZM3h6XQIrn94yVXH69ros5G30bHZIRuZXbHQgmpu12ZU320058rtDSOuxrhg2wqPhqyfIMCqY+nee7y8vVft8nx2OojeoEMY6jMJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792328347; c=relaxed/simple;
	bh=8AgZcyfplCfNaQ9wKxTOpfCs8+Fbgo88uxJRdzeoefk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fiWxAmIRjK1wDL5i9VC3tIw98pJ8ppyi4zXQ4nS6EkGh5GuCba8Kx6TEIHZJQgqM7amRiQcneGgu6c4uURH6tLxLhgzwHrS4BpNRB3uc0j/ojXunp0vvXfp01J+LZKf1mKSUWyYYan23fm+l1CLFT9gGY/K2oUifmxWe4KnFCow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=sHlh1FYI; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="sHlh1FYI"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c4086e892a4so149162466b.2
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 05:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1792328341; x=1792933141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iAVGT6mmXXV7gd2pst8rSD4EZFUw8guUet3I0hNK1I4=;
        b=sHlh1FYIG/V6Ift3HSOK5bTe1vOeZ+SKY7PXg6r5znC7pf6Z30mDk6hp3Y3KNnzSI2
         AgzZc4bRJa8FwQFyFsZVWFrJPXnalfUvyaHIJvAhxKcvLpwaSVSv3zrC2rzDV3EjJaX5
         /0Jw5QgsBWwGSvbRbjkrZ4VAiMZXJL59qP+hrYRUZWTlzHJPiFvX+OtdEKr16OKbK9Ts
         boBHFBJeuGiNIhgF4/tHMrH25xg1apSAKLGeAUgvtgYeifiA8BSF4b8raz8rk9hc0U23
         uOU1tIfTAmjd/kL59+R5vSQxvfH1EjEs3WazLW9MDkyo7D7FRSRWydMTquaQHp8TXl3Z
         6qpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792328341; x=1792933141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iAVGT6mmXXV7gd2pst8rSD4EZFUw8guUet3I0hNK1I4=;
        b=CHdT4MSw8OLg8SbH60f0Sn/3dM1gLyqYE+CuejrQlZVmq05TARHYFGdo/UPnBJeMMs
         suNe+BLByxnWEQOyNRUzm3fiPWwD78KttahyhmZg/Qp4wKfvC7U4Lw3jwi/RoEK0YieS
         5RqTfYYd8jwG2vdrTRZsCZHPvXziunh4Tc1gg8WurbwBmIrgaE6Z5uLB2HTFrtQnaqbk
         r0EpDaUWsntOHqLX1o0D6n5IE5Ean4lsd2/gpg5Lt8HFq/8Y+vFYU9gkPSU5SJZ/pkp0
         0KUgnSiJdm2J0ueXV02MqU0UQa4EmcWf4IrKH+estQMg3tUGxCX3hhRGhbiF4HeeHXDz
         Ec2A==
X-Gm-Message-State: AFq9FYLi2GM3vktV2Nikh/HehkhzkSSRVSKWoarLqeUEmPqgYB+LgcTO
	2ISFqJqQxlyUihXrNhAB7xgawgPAVDLgG+fsvkh+PTDs0AVOACa4vke16DoNgSbRifMeMMK9qaj
	zSS9gZwhISCo=
X-Gm-Gg: AYBFou0PIonbeSECgWFif1fzKBSjIkBC+WUXvxYzPDxiC7UK3NH/Jiv95L5nFFpE2aY
	pFBKs2mbgwq5T1qKAI2sZ90mIkE+7wFPx4OHoHn2sdN+A9oiK/Ll5reEJdNvvzQjybKT+jqr9jk
	qkOn26l7RjEH9lI4r0AoJ04/wRNHfplm0kGH/Ds6ImnrctazWg1RSrhFWs1+7+qvi1V6EM0/uwf
	q7D9E6qqM91E4JD89epoKXi3OvIf4HYEGXddevJcFwQNCQXkICAPndvSR4zb2KuCOpp0lFYZrrt
	jFP6vyePuYe3krbSQFpGlAAKnrMT0UQJxz6u5ozsuW9AHAngJrT8+Hoq47xI3/ZD38LZwN+kJku
	TMx3RmR7fat7tItcns1p9LYNyycCscZTm1GFdFCYRqotc/sshaSe55Ora/gpv3dXrQXwbsRR6YY
	y1N5FH3YDeHIqrGy7hw4i2b2uTZjbnnNY0Z8VTTjZmnWMDH3sLYYD+UDqLPn2x8Pkrsfot8yY8u
	q8DiyESYotIahWFQoBkEDe4B/uTFcmQqBLBl1WDP1Ls1x5xgfQSW3etSJAnCgwzh4DxXwdNO/3K
	WcJrwC7p8kCk94t/P+bYi2TRC5GXwFDJVooi6yzAPWlUtJFUa6lbI1+wZdu9kL3ijANT0GnSXlg
	G33MmEFbm+yTisweZTYxH0Bzxq/yJzKT2oKdliOoKMsalnTyNp5sNFB7+OGvAVcJ9s1cCFk/YUh
	rWyRaKQ0mmliLUX5XcJs8=
X-Received: by 2002:a17:907:c305:b0:c2d:c739:30e1 with SMTP id a640c23a62f3a-c419f90490cmr308794366b.32.1792328340965;
        Sun, 18 Oct 2026 05:59:00 -0700 (PDT)
Received: from Desktop.fritz.box ([185.181.130.213])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40912ce05csm259032066b.33.2026.10.18.05.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 05:58:59 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	steffen.klassert@secunet.com,
	willemb@google.com,
	jiayuan.chen@linux.dev,
	mfleming@cloudflare.com,
	almasrymina@google.com,
	bigeasy@linutronix.de,
	richardbgobert@gmail.com,
	ecree.xilinx@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 2/4] ip_tunnel: move the TCP fixed-ID flag to the inner header
Date: Sun, 18 Oct 2026 14:58:52 +0200
Message-ID: <44dce02a36429356aa12372bd928fc79d45bb965.1792327155.git.julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1792293419.git.julius@bairaktaris.de>
References: <cover.1792293419.git.julius@bairaktaris.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SKB_GSO_TCP_FIXEDID describes the outer header of an encapsulated GSO
packet and SKB_GSO_TCP_FIXEDID_INNER the inner one. TCP GRO sets
SKB_GSO_TCP_FIXEDID for the header it merged. When such a packet is
forwarded into a tunnel, iptunnel_handle_offloads() makes that header the
inner one but leaves the flag, so software segmentation gives every
segment the outer ID of the first and increments the inner IDs.

Move the flag to SKB_GSO_TCP_FIXEDID_INNER when the packet becomes
encapsulated.

Fixes: 3271f19bf7b9 ("net: gso: restore ids of outer ip headers correctly")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
 net/ipv4/ip_tunnel_core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index bab42b9e277f7..752ddba1298b6 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -174,18 +174,29 @@ EXPORT_SYMBOL_GPL(iptunnel_metadata_reply);
 int iptunnel_handle_offloads(struct sk_buff *skb,
 			     int gso_type_mask)
 {
+	bool inner = false;
 	int err;
 
 	if (likely(!skb->encapsulation)) {
 		skb_reset_inner_headers(skb);
 		skb->encapsulation = 1;
+		inner = true;
 	}
 
 	if (skb_is_gso(skb)) {
+		struct skb_shared_info *shinfo;
+
 		err = skb_header_unclone(skb, GFP_ATOMIC);
 		if (unlikely(err))
 			return err;
-		skb_shinfo(skb)->gso_type |= gso_type_mask;
+
+		shinfo = skb_shinfo(skb);
+		/* The header SKB_GSO_TCP_FIXEDID described is now the inner one */
+		if (inner && (shinfo->gso_type & SKB_GSO_TCP_FIXEDID)) {
+			shinfo->gso_type &= ~SKB_GSO_TCP_FIXEDID;
+			shinfo->gso_type |= SKB_GSO_TCP_FIXEDID_INNER;
+		}
+		shinfo->gso_type |= gso_type_mask;
 		return 0;
 	}
 
-- 
2.53.0

