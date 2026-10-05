Received: from mail-lr2-f27.google.com (mail-lr2-f27.google.com [74.125.230.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620B736F90F
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 20:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231278; cv=none; b=KSZJ1MJIpiU3M7D8Zzb3mmNDF9ra9Z1xTUkYlZ14mI/Abt4amSzmmsWYFeAeUdZzor9GlV3BlL+6+NZ7q7qQszbuIB0k+avx7M70rnl8f+ihzOyhSgHmSJ4Zq49Y1uvzXW7gvk3dSxnisCAclUtVlbNZ5zaLYtj3Oenfv1aKINM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231278; c=relaxed/simple;
	bh=AKX0VGDDb7hHniNBSadlltPqnJTVaPw4u961bkdC47U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jk6XXlNqin1vka4Fco3gPdXP5VtMmo7K1qXeInqJdjQImgBB0UJvOTevdEghr2/tzgTbE5pgCDHb9S0kD0VqrD9f2IvxHyoB6LzUbHf7u6jlEPDmyxQhJX4Ihon3QmllBSy8dboUIBnQpMh4Drf3RMJUZqQwdBBC0zbPiGuStsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvdBdtrI; arc=none smtp.client-ip=74.125.230.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvdBdtrI"
Received: by mail-lr2-f27.google.com with SMTP id 38308e7fff4ca-3a76a5a5d4cso17267551fa.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 13:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791231268; x=1791836068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VttY61a3a/Ies1XvMZgIWwrQFAm/hAwJAXLrgBAs69g=;
        b=mvdBdtrIb6zt7SInwQ3JgWLoMQOs+Hp6s1sl9Mv7NxZMItUqjgg9ZATpQrWNJPX7Bk
         x7wr5pgztIouWbJ3jnfdeEQn5o7tM3N4J/LqdjNvLRYd851LFiWHnuQa57ZkTPtvDD1Z
         veXmJuAtAo35m22Q2qVLDJ0jndJDAOkCyGDzW/kqjRwjN4SsNlgmVNRNtr04zK/nkX4r
         Z6IEBvqTjXRVt2Vz50UR4TKNNiptVYKXjVNL1TvWWkeeCSLk9ltDTHeRLRTBdy3G9T9/
         R99cE3jnXz5e9NVfWn6DAnSa84+6IdtymiDLgkhfnvZfXM8pxLeiRagsuh3H+tvzXrUI
         uXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791231268; x=1791836068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VttY61a3a/Ies1XvMZgIWwrQFAm/hAwJAXLrgBAs69g=;
        b=utaVngmOfvtDWRDeYnUN2fef7vI6FBtfjmK9Cfz7pD8wIJpMXlGS4NlFJMmFYlDGGa
         7JseUxAIbFKJSrioaJyPHGif1vlRtVY6f5So0opn6NjDB23Z0X5ADJiScc2zoAljPhDr
         Yzh6ydwW0TjwgGZ4bZ97MjVGJEdcsNvQnvS6rEQRGYdD5vpx6XFgBtWr5w6fJpaTZnXe
         S6Xx9Vk2pHF/PRTLMehLz8W8mVh1o8fvKNEHBIGf+w3367veMpKF8obz6aLokV+hDt5x
         k5iTtd1bkrusVYK2IEbYkBPKolsKYqWJQt3U0/v14GUcpyxPCLhG59zlal55J4G3Zt9/
         Qahg==
X-Gm-Message-State: AFq9FYLpbwR7ACbRosMzDSQU06YXiGnOvqqqGBzx3cp8UpnN8KW5D2LK
	juLzLzv/4y3KtLjWd4ME760dFqwkPQmQvK7B7PpgYtqr8P4DIMTH/UowgYaTzljf
X-Gm-Gg: AYBFou0P6U1EKA4+1ux4xLspY1XjaAMqxpiJbcyOWXSyDVtLkwk/lFntBeRetLyAYBb
	prj3vREvoXyWrXsDYacwTuw3rg+wws+NEzLyHxXHxvrNcqfHdscJ4hp/Id5OjsgItVpSLYGVdLv
	hMrOAqjcfvar8bCYGO0o5jgoO9lrtjXEHZB2wjnsGtG/zte5qW3vW4q9y9gfOMCGXNzxKyQkM5v
	wcd7/j8YRGKqsD6l+T/vF2bx5aGNSIXYF/WmnfM/O8WgiMMk2uGlghH1sxLIn1+iSZRW+8IJehY
	UPlt3jlv1VTKeOIK0n9phpuwHRe5cn274vDzZLiGAd+RUkCeH0By2CoJCo2AYaa9joCDvcTWAFE
	ZM3rY2U8KwGu/iS3st8zL05Q751aQQsgTHC/bRS9kWiNxEv3M9ITjMEo6tWtUMbK+XfbR3XqXs1
	8hgkUskI2Zo5l+2xg9lMX/lctIMNDYVucA2e5JRzYEo084jGA+f+38szt3NlVdMfyizqHYA4N0r
	6WASH6FwyJOGqEUVoKoaVpCKg70mLVnXMaWgi+STw==
X-Received: by 2002:a05:651c:19a8:b0:3a8:d34a:dc64 with SMTP id 38308e7fff4ca-3a8d34ade19mr31459901fa.1.1791231268379;
        Mon, 05 Oct 2026 13:14:28 -0700 (PDT)
Received: from dau-home-pc.. ([212.35.161.1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a87e303889sm43114681fa.20.2026.10.05.13.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 13:14:27 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/4] vxlan: report a circular route as SKB_DROP_REASON_RECURSION_LIMIT
Date: Mon,  5 Oct 2026 23:14:17 +0300
Message-ID: <20261005201417.906344-5-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005201417.906344-1-littlesmilingcloud@gmail.com>
References: <20261005201417.906344-1-littlesmilingcloud@gmail.com>
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

Such a route would send the encapsulated packet back into the device
it leaves, which is the dead loop on a virtual device that
SKB_DROP_REASON_RECURSION_LIMIT describes. Report the -ELOOP case with
that reason, and add the tunnel case to the description of the reason
as an example. ip_tunnel and ip6_tunnel make the same check,
rt->dst.dev == dev in ip_tunnel_xmit() and ip_md_tunnel_xmit() and
tdev == dev in ip6_tnl_xmit(), and can report it with the same reason.

Assisted-by: LLM
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 drivers/net/vxlan/vxlan_core.c | 10 ++++++++--
 include/net/dropreason-core.h  |  6 +++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

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
 
diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 40a27d8887af..664249924219 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -613,7 +613,11 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_PSP_INPUT,
 	/** @SKB_DROP_REASON_PSP_OUTPUT: PSP output checks failed */
 	SKB_DROP_REASON_PSP_OUTPUT,
-	/** @SKB_DROP_REASON_RECURSION_LIMIT: Dead loop on virtual device. */
+	/**
+	 * @SKB_DROP_REASON_RECURSION_LIMIT: Dead loop on virtual device, e.g. a
+	 * tunnel whose route to its remote end goes out of the tunnel device
+	 * itself.
+	 */
 	SKB_DROP_REASON_RECURSION_LIMIT,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
-- 
2.47.3

