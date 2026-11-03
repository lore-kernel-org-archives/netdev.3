Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699768;
	b=HvDXYod5+4H98y3SuBEzlpZ9IeyhZCIm0FOpWx8yvnnck06qardAw2vTo73VvUyZHGxW
	 KSpd/k/7zVXiwJBBGQo+wmvD7QB3Weh0Bs0WLkbVgSqYIyFWbyG4QKmgeswlQsEa2u57x
	 beQ/End71ZuYOrLVAVN81EHgcrqQn3OZsOnrB2ighFdymOXDPzze/sa8su+J00hc8YTxj
	 DCmDPtZajAK+SLkzWVQbJmQUDWknTlUQBjZH5wJb4W7NMvUf/YbewVrUPQSRfYGL+zpsD
	 eGdOimyShMdS0y2KzGG5LjqLEcQ/2Qsecnx8VMmNg/Y5xq8ZQpZjNeV2msMnDGhaMdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cAxZRQj15e+Ddsf3pHEBABxNpSu5LqFIC50y6T2NozQ=;
	b=O6aa/l13aA81szooK4HQImYAkxVq9syjJq3Y8xxFqDRO+N4Wd9n7tcpMiQCqGnIghvFG
	 +u/sALspS2Uo6M+w/dPhQVN5MSFlIFhxL1ScimFnMVKxjSee4aT1Jntk5w0+BeFdCY1hO
	 55yH3ygVfUzFe5RXhbIz5BwMZOjNG/ciCBxxujW9BUE8hG0v9tE316U6WqENAg4h2HwXr
	 uTZGKQVZr2+h8AgG0UgIZzgv5qswlbyIj1/12zrCdcmRgEbwp3DyDoMdP06hWAX8yxc+I
	 myKPJLDvYLyejnLT93iGCbaS0LUa6Y3uApWY8VCxpz2V9WgqSmQebxRN5LGx17ql30w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=conFkMNu;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E12B606A80D
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 09:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E12B606A80D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=conFkMNu
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cdb1199bfd8so1228718a12.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 01:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793699768; x=1794304568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cAxZRQj15e+Ddsf3pHEBABxNpSu5LqFIC50y6T2NozQ=;
        b=conFkMNuHqkU6jrU0uS4UY5JImCHRooi2u5Vu1S/6BIL0htgv25CittZSSTVXLFwcV
         5mTp90kQ5eagz3pH9rhYu7rXRaNP8O+GzAadSc4RIbkal7vggZ0IvbCQa9R0jpEJ+8yk
         CAX8wBlYyN1bTXwvQiJlFQQzXvhRkKbtGiKb9CBxNf4IFEzznWXR4+LH7u/PERl4yX33
         5h5/pn6DPOy3rJMi5hZR08UOTAoqSbV0ZR1e5HH6ttMaqWPSDU9Q8tm0s8tAI34HBxc+
         /KdH6x5x1ZzMZWWg+Mql5325K3jLx727449qEW5kVyg2QBd45NiZ3wTAgitbDUmPzTck
         Pb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793699768; x=1794304568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cAxZRQj15e+Ddsf3pHEBABxNpSu5LqFIC50y6T2NozQ=;
        b=Z8qVcJ9OpzzVkX9JQqGL8qM/l48xfGzIWs1kIGaL/fPemdobkNHMwEHcnuyJmeZQtA
         JjNoltAjfW0p2chV/lcvv70jMZ4KP7jWTrS6Tu198X5RhZPioErlY4LQ8fXo7w4ZqWr7
         0vZTu8gsyJcY03y6Qu1PQ2BSRjXTQ+bvGxAOzQCiO4S9cydpeMt00aPb1QIo+RTnz2QO
         UWOEY98r28ARfXrpelDyY+ZCaB5BGPRECJeUCqjjUOcjeTRfzjdbvhwWbVQ1GFqx/lmW
         zUiLxZJ9mqRa9Wp0mgL4DEG1SoKItYglDyEOacW4iLsJbGBPaXoK5304iPsHwP6oonLq
         3KJA==
X-Gm-Message-State: APuU4Z/dq6r2bIErYUNtpkpWx0CHYxIV54ZDeiQz092WdhMOItZztHVc
	53rImvZlTkM6qyoP2muYbCN2mi0NV9XpR2AtCXB3CNAfv/BcWmguHZvEXzD9RQ==
X-Gm-Gg: AYBFou2vSWSMsa60vIRpNolksydx9d59k40iNY474ChsJLyrLn9al8GXqaxGFsVY4xP
	ArtSxsI5/whuAC5pUbO60prYmWqN9wdKRnjVXZ30zvjyd1hI9KpKaEZSavnRMNSc+T2t5H5ezux
	ylztfKn4JjqAg7P84G9IVDIJZDrFw+MR2SKvREf7ZjLA/gYV0RLrr3jYyhUWWHcu8JLywVqqfvv
	aALu1BSY/5XrAjryO/vwYMk+p0IKqKLFPnbFA/nuBzsKUjsTcoSgA61Z+9WWPl4yPVETiAe0B5e
	zASjKoxlKTkUsMzFZum/iBpjdtKc5MoB/nmhuTTTx7PKjeKyQZou57CcVyV2bYwcTyXSMtWFduD
	VZgO6zUtpT2sUFJgF6QEM4aLMP927h7Z1fqNuShwciRVCX2k9ZQj1awkWjeFlWLQDzVzkrJo3rL
	qsL4b6K9OBXsG6Gh5L6ZAzn8bBHiY9lXrygdaAHZrQcK4Ro1qNScyCHoDiSDMmCB4m95E71Lx0C
	gK7VKXMPVNeV0KKZ/jRCYS2VIFnM3BWO3+wehcjzz1oZ4lqP+/qiLQohVNzPbs4NV+U11yTHWbq
	5b/j3jwp56Eb3iSBShfz4NRk69aBAmI9DHsWDyInBMn+qAj9Wb+7
X-Received: by 2002:a17:90b:52cd:b0:3ab:b764:826c with SMTP id 98e67ed59e1d1-3ae897ccacemr9405709a91.12.1793699767640;
        Tue, 03 Nov 2026 01:56:07 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:28::4:396])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c666cdcsm3488954a91.11.2026.11.03.01.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 01:56:07 -0800 (PST)
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
Subject: [PATCH net v2 2/3] net: dsa: motorcomm: Resolve the flower action list to one ACL verdict
Date: Tue,  3 Nov 2026 17:55:09 +0800
Message-ID: <20261103095514.338700-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103095514.338700-1-mmyangfl@gmail.com>
References: <20261103095514.338700-1-mmyangfl@gmail.com>
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

Resolve the list against its first terminal action. Consecutive
redirects merge into the destination port mask, since a flow action
entry carries no mirred control verdict to tell whether software would
have continued; an action asking for a second decision is rejected when
skip_sw is set and left to the software path otherwise.

Fixes: 8eb9e7520b17 ("net: dsa: yt921x: Add ACL support")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/tc.c | 72 +++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 35 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/tc.c b/drivers/net/dsa/motorcomm/tc.c
index 8835907366bf..5d2db04f3385 100644
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
 	const char *reason = NULL;
 	bool seen_police = false;
+	bool terminal = false;
+	bool redir = false;
 	unsigned int i;
 	int res;
 
 	memset(action, 0, 3 * sizeof(*action));
-	flow_action_for_each(i, act, flow_action)
+	flow_action_for_each(i, act, flow_action) {
+		/* Only another redirect, or a drop, can follow a redirect: a
+		 * drop is an empty destination set, so the software verdict is
+		 * the same whichever control the redirect carries.
+		 */
+		if (redir && act->id != FLOW_ACTION_REDIRECT &&
+		    act->id != FLOW_ACTION_DROP) {
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

