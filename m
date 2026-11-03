Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699771;
	b=YdZ7YBoNGzeKBFNB2Orfu1GhEZeG4jGsEBKzXbxTit3hVpmdBzoON1K0WCXrDJmAbxDg
	 d+63WhD2Ywua6BpWlH/1re0aK1ktEs2+QMyo3xgQgniuFfRC1TymhkfPI/EMh+XV8GCNe
	 lojBhmNVdE8CP6G8Pydr+xZBjjeRpnN6LWnjfDey/SrRlmhizHlrWlYmMQajFopDq0Jid
	 ea7VhA99g3AUeQcRnhQpkO/V8z7x7wykZS4OGwcr1QatREPfYGDaa8UqX8UjiCc4HKHd9
	 pB0V+1aDlup0lCXnjxcwZ+98Wepd/CctRQ2XMcQqaQ1+j3PfiMccs8tkqAQdNmbt0UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RKc3AxVEeK3hYucX9TDMZhMBcN9uYGhCCb4Gc7p2Cc4=;
	b=UzAl+ZIGldkIRfSpa7pyUgvDShnd3DNL9jZ2PWb0zNWbl5gUsM2+XbliBy9iu70X872y
	 +gc5YMcbP2vdzXhwlPyM3pVmkWWJRvodB3P4MXTHrgwUID1B/NDFwFu1SmA1r9Gqo9ScS
	 2pA4xzZnV3RB1N56BS5FnXDHT/zJvmrAe+dl6JesciA7/PPaN9L8ghZG9NBWi+yPycj+4
	 HN32f7SNwVqc1iC9SLg3yxTK4FPL6A3Bjj1G7lsYuLcpW1DMdfy5/AmpKNrGtfDv1cKvh
	 a+X/83U7qkkWnf17PBQq9N69DaeuEMDiwZrARhPGYHIV6kb3kdqgk/7rvdPz6tqk6Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QURYRwYR;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3BD606A835
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 09:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D3BD606A835
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QURYRwYR
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc751eddf25so2344568a12.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 01:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793699770; x=1794304570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RKc3AxVEeK3hYucX9TDMZhMBcN9uYGhCCb4Gc7p2Cc4=;
        b=QURYRwYRlzlhJ6/y2zjMSzJSSX3Ty5YMdiiM5u9JPSfocAGyjN+SO315am54GjIY0a
         mSgVYrcz3SWCy6ynvVqts4FmMrzrYg/lYW2hO22I1F4v4FjuE7PkfXKj02TqqEicIqv7
         sNf46RxLTPZd5p1/ligw1cLt+wuNKoMQtX+C77I2od73PZJSxoyTbksXPJZ4D5vM+84Q
         M0nB7PDzL6LDsRe9xOi+Wwt+ob2WbRE9Wi5kz/irs3O+ngj9uQ7/nFPFyQUFBlvp3bW1
         qy0+2PSywCVYgBCvp6waL33ZM+QYndYCUCPM/DSXSQRvx6hD0kpUq4hskF5UuIFXXygy
         9JBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793699770; x=1794304570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RKc3AxVEeK3hYucX9TDMZhMBcN9uYGhCCb4Gc7p2Cc4=;
        b=2iz3LJnxtETLIshpxVtM5SU1axz2tf7FWIWJnDh4ouyXpzF6dF1Q973kCL5KXaH+T6
         Er3iQA9VF3kR7AB/sj0OxLAPet2K2TZS6IphDR89PpqzR5cXX1gl9xcPTTyMKA5E3MW4
         DPATtEDBlzyvPjS2mEVc+oVtqcjbSo5ZYfkbd1J5pktV4Rc+y7ZytRTh+REVRWcDXhxh
         nEA3fBiwVPjPwzh1WnSDNGAIXhKQfVx/6dBmWQYmW5dgcXRb1jsNNlc49ME+d99KvHGB
         BUqABsJAovGsRea1oaDaGRrQyz0hGnj9I/SslVvsmI0KnFh/bxL/5aL1cTQKxTYrXCsz
         I2bA==
X-Gm-Message-State: APuU4Z94PtuIsr9Tb5oNM+P4KWyOiPvHmtim3qFX4VnxDaoiN2DLQ2Zq
	OvP4UjoqdA6qRA0y7TSI57WlR1/vd65hLZDmPDEUo0OvBSZVajB+9a3VO8yFxQ==
X-Gm-Gg: AYBFou00axoK7HMu693MGGuwp+kMPnTCku8/vhmcr8EGcsNYWdEOW8GTOdtNtAVt5uW
	+pZ4btXc6+nrpH5wSGExGXCYcZ3B09QXMSpeyeeMh08+y0hBfUtEKjbwcQVNLaERczB2AFx5e0x
	FoUSFJHZiNLHTIdWCxaeilIA0jKHMnITR0Qr9CFyR9wKi50mR5fPDsJfQvM14e1R/sE8B7/wmkP
	XtS6VaC7duNEHMJGaFhE3e5KKpwITXkbeGJeIQ/LbX+PTj2EKvWzBrWf9txTqY2bb6VhEbnTHsz
	6e55tiaWOufXioAdjcevJnskBHZxQ0b3JCxDloe2wEelMrdWC7cjDGF1B7XVMD063FW5eajs/jQ
	Fe7dgTWhjGlgpDH/ZbmGYjYl3ziRHPl6RQCON/RopNfoLnG1SJxVYUDbZryJ71c3LgWHR9L1dyF
	m9yYR/wN+DfHAbEGbJoiNr2McfXwFGVoZryjU02JzTJ3P7G4xnfZQHEF5iJ17FPrFJw8NTZOlIH
	1Ri7kufjQ0Ws+XhPqEuiBHOtubwJSjfWKdZSdF3dN7NASHribPIwNxbGEPpsyJnv3QDzLUYkOGn
	58i4SwZCmP9FY597FCLpgytkgmb6L8ZLUjCaNh+XKY6gGMH/Z+gx
X-Received: by 2002:a17:90b:1188:b0:3ad:b7d1:8631 with SMTP id 98e67ed59e1d1-3ae897eb75bmr7563921a91.17.1793699770359;
        Tue, 03 Nov 2026 01:56:10 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:28::4:396])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c666cdcsm3488954a91.11.2026.11.03.01.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 01:56:10 -0800 (PST)
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
Subject: [PATCH net v2 3/3] net: dsa: motorcomm: Delete the ACL rule of the port being unbound
Date: Tue,  3 Nov 2026 17:55:10 +0800
Message-ID: <20261103095514.338700-4-mmyangfl@gmail.com>
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

A flower filter on a block shared across ports is offloaded as one
hardware rule per port, all carrying the same classifier cookie.
Deletion looked a rule up by cookie alone and could take another
port's copy: with skip_sw, a filter silently stopped being enforced
on a still-bound port, while the detached port kept enforcing it.

Delete the rule matching the port being unbound instead.

Fixes: 8eb9e7520b17 ("net: dsa: yt921x: Add ACL support")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/tc.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/tc.c b/drivers/net/dsa/motorcomm/tc.c
index 5d2db04f3385..159504694158 100644
--- a/drivers/net/dsa/motorcomm/tc.c
+++ b/drivers/net/dsa/motorcomm/tc.c
@@ -1226,7 +1226,7 @@ static u16 yt921x_acl_activated_ports(const struct yt921x_priv *priv)
 
 static unsigned int
 yt921x_acl_find(const struct yt921x_priv *priv, enum tc_setup_type type,
-		unsigned long tag)
+		unsigned long tag, u16 ports_mask)
 {
 	for (unsigned int blkid = 0; blkid < YT921X_ACL_BLK_NUM; blkid++) {
 		const struct yt921x_acl_blk *aclblk = priv->acl_blks[blkid];
@@ -1236,7 +1236,10 @@ yt921x_acl_find(const struct yt921x_priv *priv, enum tc_setup_type type,
 
 		for (unsigned int i = 0; i < YT921X_ACL_ENT_PER_BLK; i++)
 			if (aclblk->rules[i] && aclblk->rules[i]->tag == tag &&
-			    aclblk->rules[i]->type == type)
+			    aclblk->rules[i]->type == type &&
+			    FIELD_GET(YT921X_ACL_KEYb_SPORTS_M,
+				      aclblk->rules[i]->entries[0].key[1]) ==
+			    ports_mask)
 				return YT921X_ACL_ENT_PER_BLK * blkid + i;
 	}
 
@@ -1364,7 +1367,7 @@ yt921x_acl_commit(struct yt921x_priv *priv, unsigned int entid, u8 entsmask)
 
 static int
 yt921x_acl_del(struct yt921x_priv *priv, enum tc_setup_type type,
-	       unsigned long tag)
+	       unsigned long tag, u16 ports_mask)
 {
 	struct yt921x_acl_rule *aclrule;
 	struct yt921x_acl_blk *aclblk;
@@ -1378,7 +1381,7 @@ yt921x_acl_del(struct yt921x_priv *priv, enum tc_setup_type type,
 	int res;
 	int ret;
 
-	entid = yt921x_acl_find(priv, type, tag);
+	entid = yt921x_acl_find(priv, type, tag, ports_mask);
 	if (entid == UINT_MAX)
 		return -ENOENT;
 
@@ -1553,7 +1556,7 @@ yt921x_dsa_cls_flower_del(struct dsa_switch *ds, int port,
 	int res;
 
 	mutex_lock(&priv->reg_lock);
-	res = yt921x_acl_del(priv, TC_SETUP_CLSFLOWER, cls->cookie);
+	res = yt921x_acl_del(priv, TC_SETUP_CLSFLOWER, cls->cookie, BIT(port));
 	mutex_unlock(&priv->reg_lock);
 
 	return res;
-- 
2.53.0

