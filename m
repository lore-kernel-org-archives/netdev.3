Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478A0534454
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 18:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793589; cv=none; b=Q6VPySi86Mk7q52NQG2QL/6xzM6beap45G0XG19fv/xWfYtMjMSfH57vps/Y0Q/scnq1LFrThPEeS/8lfQXj+2Ig+lLdUTEN09fsIW+CV+9RH43bZHLx2zUvhkObiDGJV5Lm1TnZ8APqFcv6JV3AwkwKdbJlCxqgVN1YGiXLjnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793589; c=relaxed/simple;
	bh=WmojZX7NIQZ4bKwgYfjEYA6u/H5MCNneuKe2H/Wr+nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2txnmscmELC/5ccsOLSSFMNYY6y0ZxJJrhgkSgWxlse+B/VHrnwDlACJEaPnXsFxhSemZ6LNkPcJuSnCJD1Z3oMpTO5Q49aTWi9Z3v4lJfELzmDgvRgg0/cXoBc1Y/zIHzZOjzgtD475GhEgR/S1LXwpLMfz3uw5CIGLYv6bho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0CgT2E9; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0CgT2E9"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b76694fb7aso76952e87.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 11:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790793585; x=1791398385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UJ5fYEtVagCgzeX5DZQ2/ZY0rZBUHHKaKAAihUWn64U=;
        b=N0CgT2E9i1klCmAMSzFBYy833ow9kI+YFYIAehyLibvZMPrrM2wFBsUGMhCKfD6yk1
         QX9Ev1tuIO294fNd3KGmWcr2KA/BqCy0Sq1X6mTialxn6me4KJbRMktgSfGmi02BpwtS
         F2L+m+6mWtQCsKrgcaC60vwn+Q6p4FF5S4l9hAio3dMN992iZfPLczkM20QJABIzWBED
         p4mGmDaS0OeLW8gh3/QGSaKRxIo8pdEr9dNIDJ/kU+/Nz2jBGc0rloSKZ3D37JwCbuZ2
         PShULLlxmMtyYvcm69mSapcnS+2cCXY6dbU05Dakq/dkh7azBV2tFrLCJcdYasf5RMCI
         Julw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790793585; x=1791398385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UJ5fYEtVagCgzeX5DZQ2/ZY0rZBUHHKaKAAihUWn64U=;
        b=IlLUn9UeK4zc1qhQPvJ3hI36ALEXXCKz4Fuh/uDz2G1VX7LeyGnwl0p29Ai7ZzWZZw
         3nMAfKiwfqcD0/sFIHjMqz2N+WKu+QClGWQzJW5HH6BHSqBECHpPWxu+cZ0UfdjpM/r1
         2WiYQOPWEV+QFNElhF/oRdfHpTYIBn+ZeIpz2QiDUb0ucekZ1l3cIGIcD77z8ciXFs/T
         kB0BiTS79h3w4qrhRFCzoTGcuLlBP2XjguQcY636k8VOkobW+2REnNxey5vu91o0b0YB
         yzHfGQ8BgLkox7OnebsLZSF5x7jCm8gDoEDb+cDMYpfiZjB6L288OxpLmcrGPGzZjYUp
         jHqg==
X-Gm-Message-State: AFq9FYLI6+kaLJqGMQZWG9jCHlaCZmyWFhdTgMbn4KTLtPRCvRL3mrO8
	GwI17MVio8/jL/hwekVwT9/DCSVkIrYm5Dib5vf7kNgYiI7eMT5Vr7HWRmaCT0zP
X-Gm-Gg: AYBFou3YGFEIqOEm3sCGRLu9zzT+PWExxBD1e/1RCNxfaw8Xv8Jx3ooOLwj8ixlTbiJ
	msmAlUnzXnXO6Mr+ewmEb/pTynCQm68dFxuXT6Uh/Z+q8soYiMjYkc+PgN03lno5dR6IoSSzUKd
	sw2M+JzwW6gCCw65rz1JFlvfx4uA9F5vNMJRGATvPQgWIxnMEx1oi31cdE1p19P/d+UNB52X61T
	C8QlM0cV+cMxZfIrLYcKcEhrkGqlTv5fJuJuP2g0P7fBk3YH7Hs3kqaGEBsAQ0DO6kTaXCWi3tB
	YjVEl+tsmJZ7HMJYHL/dy2OrLVMz5QNN8WZB59N0yJO1f1kX4CuZ9uaN4x3pX+KE8qM+VVCV90Y
	Pl4PeVjFb2ucxByQ22xMMqFBa8dbG+HmgVUAB3eAPeCFJYWCmz4FdN9AM+Ug168RM9GhMpYQ48y
	iGM+dLda53nqFMS+qqYOKm4Foweea/fy5AUTNYevdcz7VvjdBXQvU+RLZQUVjG4HDAIOFkL00fH
	9R61wJdDowEEAsAYa2qmbgkM/t4L9a7Nt8W928mG5Zq
X-Received: by 2002:a05:6512:1287:b0:5b8:c311:88e8 with SMTP id 2adb3069b0e04-5ba433ef5e1mr158262e87.26.1790793585152;
        Wed, 30 Sep 2026 11:39:45 -0700 (PDT)
Received: from dau-home-pc.. ([212.35.169.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ba42fbb999sm156593e87.62.2026.09.30.11.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 11:39:44 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 14/14] vxlan: report a circular route as SKB_DROP_REASON_RECURSION_LIMIT
Date: Wed, 30 Sep 2026 21:39:10 +0300
Message-ID: <20260930183910.3151873-15-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930183910.3151873-1-littlesmilingcloud@gmail.com>
References: <20260930183910.3151873-1-littlesmilingcloud@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

udp_tunnel_dst_lookup() and udp_tunnel6_dst_lookup() return -ELOOP
when the route to the remote end goes out of the vxlan device itself,
and vxlan_xmit_one() counts that in collisions, apart from the
-ENETUNREACH of a failed lookup. The drop reason does not tell them
apart: both are reported as SKB_DROP_REASON_IP_OUTNOROUTES, which
describes a failed route lookup.

ip_tunnel and ip6_tunnel make the same check, rt->dst.dev == dev in
ip_tunnel_xmit() and ip_md_tunnel_xmit() and tdev == dev in
ip6_tnl_xmit(), and report it as SKB_DROP_REASON_RECURSION_LIMIT since
earlier in this series. Report the vxlan case the same way, so that
vxlan and these tunnels name this misconfiguration with one reason.

Assisted-by: LLM
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 drivers/net/vxlan/vxlan_core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 0d98e29e2d72..7c94a630d184 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2547,7 +2547,10 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 					   tos, use_cache ? dst_cache : NULL);
 		if (IS_ERR(rt)) {
 			err = PTR_ERR(rt);
-			reason = SKB_DROP_REASON_IP_OUTNOROUTES;
+			if (err == -ELOOP)
+				reason = SKB_DROP_REASON_RECURSION_LIMIT;
+			else
+				reason = SKB_DROP_REASON_IP_OUTNOROUTES;
 			goto tx_error;
 		}
 
@@ -2633,7 +2636,10 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		if (IS_ERR(ndst)) {
 			err = PTR_ERR(ndst);
 			ndst = NULL;
-			reason = SKB_DROP_REASON_IP_OUTNOROUTES;
+			if (err == -ELOOP)
+				reason = SKB_DROP_REASON_RECURSION_LIMIT;
+			else
+				reason = SKB_DROP_REASON_IP_OUTNOROUTES;
 			goto tx_error;
 		}
 
-- 
2.47.3

