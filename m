Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793603510;
	b=d8RRP0GYW6lERtZNW9bNpdyEsjc3nZIngu2Rq9ITBwaU/MoL+6RrxKHKJiy78SeCWgC7
	 RAi100neLwFycXBWNoi2J0MOnOzYe3nbLISyd2RorKZwraLhJUC7UJPuthaahcPy2gkme
	 w0+n3BQGGbX43mDYaRtorDMnVFb4h50JAXadl/FpkVK0kT86omH81jOMmlBCprDNdnBnu
	 CY3o3/Z4aIv93sUdipUTRF0ReFqrkz9iYVLkpBRfh/OqzVHLPaEiuu0xd0W5TYqPU+Bjr
	 2XsqHPxz7OGRcPx/fFA8fLFdLCHhg+tAbqG4uGb+O2YkyMAyyU+T06W4X1SG3AVOGZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793603510;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aFf1QpqkAsJSo149csH6GOuvsyJZoB8FI+XgGaXyANI=;
	b=HYebBBCZwHviHHNXOhDiGjeKlvRSm8vr4IZu1xacq+RoIDa5wJEvmQSGt+FcwPgOmLzR
	 nrXCH8NKSFQ+DwiWNuFNvSvkTH7gcYxeTEu8GGvrOtUcTqAJ1YKWP3ZZc7tqXkyg/E6eS
	 kKIhFVM9hnqv1ec/X/f4tfD8+1oN1HljipP5CFeGi8U/BCu6AdS67WyiDTE/EQVSBAhvX
	 OTA062WlMFMD1FKwpFHN3/8y25/1jYvRy/ZOYBSy6nKMcyUOukb0J9RtqUzUslkV3ywiw
	 9i5jxB2/pUicC5P/ExiswFRqmnl38oz/fNnsDWBaHBQI7YeJDmfnbK1MY2AgbcAlS2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m1GgYHyU;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166FA606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 07:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 166FA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m1GgYHyU
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a052aff9e9so1920303b3a.0
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 23:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793603509; x=1794208309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aFf1QpqkAsJSo149csH6GOuvsyJZoB8FI+XgGaXyANI=;
        b=m1GgYHyUT7wzZIGMaCyigmBfrx3X8UXav8je8ts7399yhc//UOFZq5BRKyYvGCeE7W
         XVbUSG9LKO+nIJSBB2sh0CSECFeyn8af5EaOQsvum/Zovsj59pOS6AhIgHqfxZWISsZz
         amyCD4wsgCIdu5triHnel8qhD3BMZv5mtfc09NOza+lvF1KZpnAR5CqRvf607FeBU9Ge
         p0fvPeWT+z/DsnEu4u+gl/OHGxLibJu/4enIhM72p9MEmJnb4CoTkxZLW7Kzo9z6ZFYq
         lmyTG7c9hn8b9xpAXusGZKcNjWonOn/ASfm9nMvrU3cJ+tNw73XpLKi6gLZL4gYB7G0/
         1+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793603509; x=1794208309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aFf1QpqkAsJSo149csH6GOuvsyJZoB8FI+XgGaXyANI=;
        b=Hy9QVvLwXAcb+AK4HBoW5N51HMWXGk2iDiVjWNxG+aUH8HcKY9j9JO1ejPQ4S3Rf7x
         bGb7/bkS1UQ4Gi52RXxeaBzoXl/g+54j/sixH20fM7veN1x4RtJixO79aNItWtPU/ja/
         5NgUgZb0ZPqnlz/kV+AIWi4q/Tp35WzswblHqeGOW9JFdzsSTyKi60744/76scbozGnS
         XiZ8cPYjXRiY1mAScaUnYAqf2Oe3m1XAO7PMD9F7WRTuMo1OS3BNSmSfQno5uC+K7UUn
         bfqLAzHJpqwLyJEj5bIBLJQ1Wa60Ddf7oo9zcXNXPkzPUHLxI5/F14H/Q4T4zOGhpVmO
         Mc3g==
X-Gm-Message-State: APuU4Z/pIs3dofKK1sM4n6NU1zf0OMMC0I7IuFMG1oDu9T84m2QXdWFF
	jjuHzbRiXgSW6+/9d6HMFswnZvQj2UaveiIewHhzgXBmFq+e4JwQKDPuEmH9TBli
X-Gm-Gg: AYBFou2xXWssazxnPj6ZEGBn1770X5GPxQGvcIilUkWjKG4cD/ZtwJX7g3T4OL1Xd7f
	wwgsBqncIbTy/9/9g3vPvhyURCznb/CldUjOUbCXVifS+alvN62hfysmASSCpZ6PN/2KGGPiEyl
	4U8pVK0jMilByX7wjQ+tmWqfGB3QIIiAn3OsccXd6ooh+x2PXi1JrABSXgvnW0oCAMzlsBzeRZ1
	HgxXQvdd7NXWpAeL9kmoMiaFsFHlMp+HymHm7UzPOSxioakPUCvMrk/syd4t4sPQ5vOcdZiWA41
	yNdiOvNmTt5McfzT8gw6FlzXX2nIVkKlgoPVjtRmH5MkBfOqdRxzjN61oGgcubQfls4P5n5t9XO
	1kth+GpXkPmR5IEl0zZ6bguLgZp00cE+ve91zZhRGeAl2HO2uQCTX8G6zHgQaSxuscv1zTOb6bo
	6kvzyZzwShW97X9FcqnElLkrR6RM3KttGs05EpbvDva0LYPcPAaF0QXeuCPjiWyTzkZNpEsUhQI
	x9uJ7OOGn1D219Vr25S6la0YAGKnBvaQRfe8+qZB73suZsm3dP2bKrAz+0iDnRQh+UzQTI107Bw
	ClhILKoYXoKwOvpBXN++eROgxsgTrBV62WnPaYDswrn7HP3pcH0u
X-Received: by 2002:a05:6a00:22d5:b0:89f:d85a:6c0c with SMTP id d2e1a72fcca58-8a9bf337083mr7415827b3a.43.1793603509425;
        Sun, 01 Nov 2026 23:11:49 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:28::4:396])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8abab0c6c6esm1140566b3a.48.2026.11.01.23.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:11:49 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 3/4] net: dsa: motorcomm: Stop at the first terminal flower action
Date: Mon,  2 Nov 2026 15:11:15 +0800
Message-ID: <20261102071119.3435180-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102071119.3435180-1-mmyangfl@gmail.com>
References: <20261102071119.3435180-1-mmyangfl@gmail.com>
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

tc software stops evaluating a flower action list at the first terminal
action; the hardware translation did not, so a later trap or redirect
silently overwrote the verdict of the actions before it: an `action drop
action trap` filter with skip_sw trapped packets to the CPU instead of
dropping them, and repeated redirects to different ports accumulated
every target in hardware while software only honored the first one.

Fix it by resolving only the first terminal action of the list.

Fixes: 8eb9e7520b17 ("net: dsa: yt921x: Add ACL support")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/tc.c | 61 +++++++++++++++-------------------
 1 file changed, 26 insertions(+), 35 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/tc.c b/drivers/net/dsa/motorcomm/tc.c
index 5a4459507582..87c04f0dd736 100644
--- a/drivers/net/dsa/motorcomm/tc.c
+++ b/drivers/net/dsa/motorcomm/tc.c
@@ -1038,55 +1038,43 @@ yt921x_acl_rule_ext_parse_flow_action(struct yt921x_acl_rule_ext *ruleext,
 	const struct flow_rule *rule = flow_cls_offload_flow_rule(cls);
 	const struct flow_action *flow_action = &rule->action;
 	struct netlink_ext_ack *extack = cls->common.extack;
-	enum flow_action_id redir_act = NUM_FLOW_ACTIONS;
 	const struct flow_action_entry *act;
 	u32 *action = ruleext->r.action;
 	bool seen_priority = false;
 	const char *reason = NULL;
 	bool seen_police = false;
+	bool terminal = false;
 	unsigned int i;
 	int res;
 
 	memset(action, 0, 3 * sizeof(*action));
-	flow_action_for_each(i, act, flow_action)
+	flow_action_for_each(i, act, flow_action) {
 		switch (act->id) {
 		case FLOW_ACTION_ACCEPT:
+			action[2] |= YT921X_ACL_ACTc_FWD_EN |
+				     YT921X_ACL_ACTc_FWD_FWD;
+			terminal = true;
+			break;
 		case FLOW_ACTION_DROP:
-		case FLOW_ACTION_REDIRECT:
-			if (redir_act != NUM_FLOW_ACTIONS &&
-			    redir_act != act->id) {
-				reason = "Different redirect actions";
+			action[2] |= YT921X_ACL_ACTc_FWD_EN |
+				     YT921X_ACL_ACTc_FWD_REDIR;
+			terminal = true;
+			break;
+		case FLOW_ACTION_REDIRECT: {
+			struct dsa_port *to_dp;
+
+			to_dp = dsa_port_from_netdev(act->dev);
+			if (IS_ERR(to_dp) || to_dp->ds != &priv->ds) {
+				reason = "Redirect to non-local port";
 				goto fallback;
 			}
-			redir_act = act->id;
-
-			switch (act->id) {
-			case FLOW_ACTION_ACCEPT:
-				action[2] |= YT921X_ACL_ACTc_FWD_EN |
-					     YT921X_ACL_ACTc_FWD_FWD;
-				break;
-			case FLOW_ACTION_DROP:
-				action[2] |= YT921X_ACL_ACTc_FWD_EN |
-					     YT921X_ACL_ACTc_FWD_REDIR;
-				break;
-			case FLOW_ACTION_REDIRECT: {
-				struct dsa_port *to_dp;
-
-				to_dp = dsa_port_from_netdev(act->dev);
-				if (IS_ERR(to_dp) || to_dp->ds != &priv->ds) {
-					reason = "Redirect to non-local port";
-					goto fallback;
-				}
 
-				action[2] |= YT921X_ACL_ACTc_FWD_EN |
-					     YT921X_ACL_ACTc_FWD_REDIR |
-					     YT921X_ACL_ACTc_FWD_REDIR_DPORTn(to_dp->index);
-				break;
-			}
-			default:
-				break;
-			}
+			action[2] |= YT921X_ACL_ACTc_FWD_EN |
+				     YT921X_ACL_ACTc_FWD_REDIR |
+				     YT921X_ACL_ACTc_FWD_REDIR_DPORTn(to_dp->index);
+			terminal = true;
 			break;
+		}
 		case FLOW_ACTION_PRIORITY:
 			if (seen_priority) {
 				action[0] &= ~YT921X_ACL_ACTa_PRIO_EN;
@@ -1140,15 +1128,18 @@ yt921x_acl_rule_ext_parse_flow_action(struct yt921x_acl_rule_ext *ruleext,
 			}
 			fallthrough;
 		case FLOW_ACTION_TRAP:
-			redir_act = FLOW_ACTION_TRAP;
-
 			action[2] &= ~YT921X_ACL_ACTc_FWD_REDIR_DPORTS_M &
 				     ~YT921X_ACL_ACTc_FWD_M;
 			action[2] |= YT921X_ACL_ACTc_FWD_EN |
 				     YT921X_ACL_ACTc_FWD_TRAP;
+			terminal = true;
 			break;
 		}
 
+		if (terminal)
+			break;
+	}
+
 	ruleext->r.sw_assisted = !cls->common.skip_sw;
 	return 0;
 }
-- 
2.53.0

