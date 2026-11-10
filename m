Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307794;
	b=il6RYHkrdUCl3KmyARC/TuP/1tzbFEod3Eyhax3c3Ap17mjrOZa2fHwuqKzo36F1H6Cb
	 +cVPliuleUV760WY172ud7PCv93mTtpaeO9qU6f36U3QeAJGu0zMPTx24Ive96QO2gqVK
	 v9zQBvMWxpyr18gl1LKNd6BBh0zLKivsljgdGmr0Vu6R/QXQi7+Z6I1Aud7Nng6TwAdBl
	 +Chb+IMB/ZshMGNs1hiTYz+sWjX0yvkynhZPMK4oZiVyhytcGLsmn+MMMyXG4/ZpMG/MO
	 /n39+1Nv8ItKHbERCSo/DLnQ7IjVGyIJjCUGtwf8mWr+GcGWG4I3i+56wHX1fwAJ4uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307794;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HOuk+lSlUhfEcj8babAxC2dur56U9KiwKgXO7wljHnE=;
	b=zKxZ/tB6qWbhqzRryJ8minhE8VFX26UIig+NIT1ZN5tuyOhvi/vbHo2EYbdN0KL8u7mV
	 lsR9tFBuXoNlaF7l3z/tS327YC5ZQHRERysQIpLe+1M1gu/xq8ikOZtlvuAghr66byGT0
	 5Pw4ej+pBUyDVqe+rhb5GelCX7y8g5OTjDJaPtteroxgRZgp1mEcyJd5uI4lrkt679hPQ
	 ZrqnrqeNIY//5gdBm7mcruYZypJbr0aoLdR79VHUK2m7sC1BRAOiSvSo19z5G1e/TYYNi
	 W7iv0XT3kXP95AD9/ew8cBHCkCLgTdUvJoAiZjVoOG0FdSemobES3fXHS4FSdbKNKyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dWC8ydfN;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E9260A2620
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 10:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3E9260A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dWC8ydfN
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ed408b0d9dso6442045ad.2
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 02:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794307793; x=1794912593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HOuk+lSlUhfEcj8babAxC2dur56U9KiwKgXO7wljHnE=;
        b=dWC8ydfNRVnewo00CLKpPQ95TpZa0arMW0P5Z/9bb9yGVg41sfg/D7mMO8daoSwH40
         jxHJ6Ie+cV57ls74L1Z7XKtlR9sLPtH0Rzmukk0uw4mUvDaNEOvjCKPeNBPWawJ3wK9X
         fEJiDTG5OVZc4D781N0W23jdzvtMIJT1O2s6E3a7vV2iScuruip7a//7UKqz+EOa25+u
         84n0+HudGXidbg8c8k6kzcK8Z1MLQrJ/MGfeb7cLsFPfYLmEktqeSG/Iaqd24fY5lIRr
         4RxaAfa5phb7o/7k018INmoU3LIRUxykC09aK/vw3A9/KRCs8sXCxGp1pHdhnHyNFWvt
         TwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794307793; x=1794912593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HOuk+lSlUhfEcj8babAxC2dur56U9KiwKgXO7wljHnE=;
        b=nItaKRiPZKkPNiy1W3REhglarNi50nRVNn/RZnmAwGUtBazaBS1mo8JCmQyE0OLWIv
         qbulp+qCdxJb1m6ixz8KZZcxjlt1TS9PYcrmyDEVdEmpQzcXL1yLscnBVO0kRzv+IiYE
         jx8dBNwOL+eB0yeTLzXzFeeYKhcaDs5QhbEd2efpNWSeFw4jq1eogU/oEqlsV4ztwRN6
         BmEGoXzoraUwkbItd13S4IMK0zH9ZCoT3pRvLFNz6rw+cG+LvHjRA7F/fsTCDeBg1pJy
         mDP3DO6e3xP+wAfAOnMPw+mq6QVTWpml3jc9j15JaK0T7jc3K6U1b0hdXEjtLPhafz+R
         LRtA==
X-Gm-Message-State: APuU4Z/P0NcMX7Cush/u2ewMRoP8x8LBvRZNnP8yUUKLu7QwXLIpJ09s
	VEYidoUuWUiWMAq4bWQvsjjq5sIwWwjZ4DBbunugui8BjLd1j8qXjupOO7SXcMw2
X-Gm-Gg: AYBFou3qx4AUJKEwH5urhB4tbWN6fNm+lyxjnEdUGzHw2l+bPKL21aAsj8YPTH6luxh
	CQ/2C3xg2WKlM0XokYa6IeX754Vn2Q1ZJR2d8QpSAu4uMmyjOnraRiqz4RcEsX40zBNfcUGzlOL
	AfCUXGF5pIjvtEI4RksZN8Zh6I8pGyME44YLvHcPsELNtzSGRkLhSLJycpGMUC+aZvEUvH8oDYA
	NO4av211W8epr6k+EgY/I8lNSlHLr5F/Mjc2DqZEF7uDlwJmd+V4K/RZkrxgtuJx/vgTc1Q6ChN
	H0QT5/ZwvZWDKQFDXUg3OiLSANUdzXUnYBq/ci/AXuHKQKHdRt1t1A4tK71Bsvv6KXd1s5YWNBF
	f31Myy7TnZLHLQAS2UTT1rGar3TdZL4/EMUCD71p8J9iDeTVqB73X6pRZr1aKKvgBB9uAVMxgLV
	vnh7Y8dTC7RPgkA5mYeHtXapHKy0AvHc2lyLsZtZKfYKiV3tu4/Nt0v3BN6pi1YfgTlYJ1kxGLt
	f4bQvKVVyHJgwy0Up0yGbFNG+E9q73iv3eKshPZYNeeiJQb5RJ4fXlLNyLzkw9v98RxHE/4k4Z4
	WhgOVgZP67jluB1h91xfP4CJQLlKfwRUwIwqBGoInnVaeeFTlr8RuEpj
X-Received: by 2002:a17:903:4683:b0:2e9:61bf:6587 with SMTP id d9443c01a7336-2edb91a0968mr20228075ad.49.1794307792947;
        Tue, 10 Nov 2026 02:49:52 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6214:1250::1d3:d5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d906e4sm7337815ad.40.2026.11.10.02.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 02:49:52 -0800 (PST)
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
Subject: [PATCH net v4 2/3] net: dsa: motorcomm: Resolve the flower action list to one ACL verdict
Date: Tue, 10 Nov 2026 18:48:54 +0800
Message-ID: <20261110104930.223598-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110104930.223598-1-mmyangfl@gmail.com>
References: <20261110104930.223598-1-mmyangfl@gmail.com>
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

The hardware resolves one forward decision per ACL rule, but the
translation accumulated every action, so a later action silently changed
the verdict of the ones before it: an `action drop action trap` filter
with skip_sw trapped packets to the CPU instead of dropping them.

Resolve the list against its first terminal action, and ask for software
assistance if any action follows the redirect action.

Fixes: 8eb9e7520b17 ("net: dsa: yt921x: Add ACL support")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/tc.c | 72 +++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 35 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/tc.c b/drivers/net/dsa/motorcomm/tc.c
index 90b017a11a1b..429345ad1eda 100644
--- a/drivers/net/dsa/motorcomm/tc.c
+++ b/drivers/net/dsa/motorcomm/tc.c
@@ -1030,55 +1030,54 @@ yt921x_acl_rule_ext_parse_flow_action(struct yt921x_acl_rule_ext *ruleext,
 	const struct flow_rule *rule = flow_cls_offload_flow_rule(cls);
 	const struct flow_action *flow_action = &rule->action;
 	struct netlink_ext_ack *extack = cls->common.extack;
-	enum flow_action_id redir_act = NUM_FLOW_ACTIONS;
 	const struct flow_action_entry *act;
 	u32 *action = ruleext->r.action;
 	bool seen_priority = false;
 	bool seen_police = false;
+	bool terminal = false;
+	bool redir = false;
 	const char *reason;
 	unsigned int i;
 	int res;
 
 	memset(action, 0, 3 * sizeof(*action));
-	flow_action_for_each(i, act, flow_action)
+	flow_action_for_each(i, act, flow_action) {
+		/* The flow action entry carries no mirred control, so there
+		 * is no way to tell whether software would continue past a
+		 * redirect and apply the actions after it. Leave the list to
+		 * software instead of guessing a hardware verdict.
+		 */
+		if (redir) {
+			reason = "Action after redirect";
+			goto fallback;
+		}
+
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
 
-				to_dp = dsa_port_from_netdev(act->dev);
-				if (IS_ERR(to_dp) || to_dp->ds != &priv->ds) {
-					reason = "Redirect to non-local port";
-					goto fallback;
-				}
-
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
+			redir = true;
 			break;
+		}
 		case FLOW_ACTION_PRIORITY:
 			if (seen_priority) {
 				action[0] &= ~YT921X_ACL_ACTa_PRIO_EN;
@@ -1132,15 +1131,18 @@ yt921x_acl_rule_ext_parse_flow_action(struct yt921x_acl_rule_ext *ruleext,
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

