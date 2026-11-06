Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793950735;
	b=g27kl9uiKzgJMkiVg6Xn7yjWnncB3bLiDj7UTzCjELbTZqiqtutwrg+6xyGiKlcomZlm
	 gg7cASKq075IBhjcgihBYyBuKthl8LVr1rXo3pamY96WpcM3UA4JNz2Nl+kntBn6K+y/x
	 0qq7Ut5UORQH9TrgZEcqBf/g6EMWvEevaGTiFUZ6ujsPHps0KiEzjthRdh9CupE6JGJed
	 /U+nKPYiouuSeeRAYERaZn+uMJx85jQ+RKM2YBoRVkgmrLn82s60j/noVXw2R/1DBBVMV
	 jJCQtMVSwm5Sp9ailZTKo4/nItGiWwLK0XioNaQHF8BcB5mEHfXhZygD5NJaBgHnAMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793950735;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=45d32jUR4SGIqYEteYzNq9z9Plnu2UNR//Dnq4WK+0g=;
	b=D7Ybu74q+pm/pLnNgLhFvXerRt8556Cj/FKQ74hxIfiCLnsU5011dY5iJq7ckSdyA1Gh
	 jchHMuklmXhoGDUYi25Xe1gOUV2J0cyZB+PsOjfIUFpO3Pl6SNe6tgarbN6beACy6GBbO
	 au5uRgEsahXtowaUO4oGZBHAOSZikPepdJSOx2EjjHj4svpT4GmUZNzZ2BePCLKeshKpI
	 nKkYhEf8ETUPBWmRt3u0CGdYfRS962VoPbAKwBfdm89KeFIZX2i42fILgoqejQ66e8Nrr
	 D+JlMEQHvDYcmJ3HXpAeyW1T7/UqAiLBqlaJbkYXbdRQZEfA0IGQtE+OLGnBNAxeOEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dihod8cw;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F695606A329
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 07:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F695606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dihod8cw
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8b29049d80dso91181b3a.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 23:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793950735; x=1794555535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=45d32jUR4SGIqYEteYzNq9z9Plnu2UNR//Dnq4WK+0g=;
        b=dihod8cwFNzTnuhOXA0JUX/EAIiYARoXqSAiN3GIr2f3Bv6RXnX3y+VT+M9LpJFHLl
         D5mKK8Is2X/h1dkcl/iy5TPtj38oindUDfGpEUWxwKZqolF4w/6NaosItrD7bHtdVld6
         qacfWiUrMOxiHWWzRAY4oLR2azlKk0d4b8oYxE2ZqjnID0jth5iIP7OzWd5B4QQYVkNH
         3kRz6AVkgkReRsgEcayD/NWG1Mnm5BxZipfgNtj3kvqltHSaavf7p8HYWkCclefxYIDL
         kf9yRm8bN9QcPU5Ol+MwLU9rsfvLsfgeglB50wg4mLiojEOlk5J9jekC5T85LCZGycYv
         D7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793950735; x=1794555535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=45d32jUR4SGIqYEteYzNq9z9Plnu2UNR//Dnq4WK+0g=;
        b=ej496PrBQoViI8E5TZp0HosTB4Ab1pHc7DM/H1rccbnnDwP0Q0Ydnz3lK7KEVMVais
         nwyfuUcSo+GlMNvTM8S5O8MrwimoxeBpHIwO+MjUjHV9qPztn8ElnMGRO9IX9i7+EEZb
         VD8IHceU49bKQGkvb7YLmCI/UgNGaeURBKDGrjGdFSFLzm7pCQV2N52bCNJ3AgiY+SUW
         8wR7h5fOaqP+yXce/Zn3zKnpyC0IoQ/WsPqc50lIb9pKRXJO96vRt/CtFgXvwQWdiJae
         n0/JvBid4eOk4RMhwHXInjuDm2IXYiZaReZIdMEwzsd7YpGcHX9/V4cv3LlXf2oU1QYl
         +XGQ==
X-Gm-Message-State: APuU4Z9QmJoZGcy1ZTnicVhQSqP79vez4zjDM5roaW9Mahi6ufvXqERo
	SywM32vr1Crf1hWRTUGvUJRNW8WCNnrKYwwT1/iggraZUqVIUNW/fvYq5B6S51c8
X-Gm-Gg: AYBFou0rt7CQdraoc4Yw5m3GR0GxgZpmZDhwuVl8eJ5/wEPn6WRzApiFriD5sL4TRMn
	tGZQPC/V1dDBuDKD/6XbhnBODcxO7qGoUkTKU6ZOWp0HfJTvdaD7UxyPnrGJEoq493BIGY4PiSZ
	O6vf/mtEzU+lfIN0shAWTUC3rFfXIPETppVBBpYtICQq19YpdTVBdpixdF/LbaF/mUd450GJamk
	WvwI45kGvynf0TepsWnyeqtQlHawlYIom1SQokqD8kaAmnKpYsyAYjJeUJr6GbPvZTlcu+slOQc
	tcKkofFf70kKR13zOAxcoM3KJXV9/lCG2pzX+hGC4fOhEjo1MB4fuKrU1haMHcLBNxc3EVqYL2e
	iO/2DcMqIu3wSuEp2qP9L9fMp5SsGqZWwKhSoAB+PIC/1l0DS1I1mdZaDGXC+/om2o2DPIjFkcY
	7vn3zKEv342XOf+PHWnP01s/D0AXBM/Rf3xptD3ZyguS6ewV0VlVHt4iGPFkKRkLuzffiNtPKob
	rAUPmhpNE1hp9xY4v8/a1nriuH9swZdErJLn7xiqC9kX288CZF6UMM67cZf+dD9efJDfm3WZU5r
	/QUEdzqIbNVSPDJKVBZ7q4UmgJKHszNKkx3+WfJ/xZmKRgbfHBgk
X-Received: by 2002:a05:6a00:4654:b0:89e:3ff1:920d with SMTP id d2e1a72fcca58-8b37c241144mr1967494b3a.45.1793950734555;
        Thu, 05 Nov 2026 23:38:54 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:28::4:396])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b3597efd53sm373484b3a.23.2026.11.05.23.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 23:38:53 -0800 (PST)
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
Subject: [PATCH net v3 2/3] net: dsa: motorcomm: Resolve the flower action list to one ACL verdict
Date: Fri,  6 Nov 2026 15:38:01 +0800
Message-ID: <20261106073806.112122-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106073806.112122-1-mmyangfl@gmail.com>
References: <20261106073806.112122-1-mmyangfl@gmail.com>
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

Resolve the list against its first terminal action. Only a drop can
follow a redirect: a drop is an empty destination set, so the software
verdict is the same whichever control the redirect carries, while a
second redirect would only extend it if software continued past the
first one, and the flow action entry carries no mirred control verdict
to tell that. An action asking for a second decision is rejected when
skip_sw is set and left to the software path otherwise.

Fixes: 8eb9e7520b17 ("net: dsa: yt921x: Add ACL support")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/tc.c | 74 ++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 35 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/tc.c b/drivers/net/dsa/motorcomm/tc.c
index 90b017a11a1b..5c82719e461f 100644
--- a/drivers/net/dsa/motorcomm/tc.c
+++ b/drivers/net/dsa/motorcomm/tc.c
@@ -1030,55 +1030,56 @@ yt921x_acl_rule_ext_parse_flow_action(struct yt921x_acl_rule_ext *ruleext,
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
+		/* Only a drop can follow a redirect: a drop is an empty
+		 * destination set, so the software verdict is the same
+		 * whichever control the redirect carries. A second redirect
+		 * would only extend it if software continued past the first
+		 * one, and the flow action entry carries no mirred control
+		 * verdict to tell that.
+		 */
+		if (redir && act->id != FLOW_ACTION_DROP) {
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
@@ -1132,15 +1133,18 @@ yt921x_acl_rule_ext_parse_flow_action(struct yt921x_acl_rule_ext *ruleext,
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

