Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307798;
	b=C2E8vNHUAe1XN6Y4TQimqsBtUS+jknyBjPm5BN5JmVsz5kJCVTGCMkdGWBgGxS3T0ibZ
	 XOWwChGzvLpyps2j22P/D4PqRZvyTpXHHPOcSKOCYs2zw6xT2xmwPp7BLuNPw4hAhj5U6
	 2xjU+kfQDJubiMsQosNjorOjmrD49drPXGR6qyBub/ueO739wignrVFHUH8SrirAORGCG
	 ccDoweuU8F2OY17No7FcQ2ShSJNRX4b5FUYjc0SEliPpqTpXNGK3JW5V3iyrkQbQGMF0r
	 GdBpTO2RQWre8D8/5WKTHKAfQPfjBaVe/CTA0NgjngWlXSgGhX1E+8v79a02/p2XbCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307798;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uBuo3746wle39j4tB4qABMZkgvKNVlkfWjVtPlqyf5s=;
	b=dZmhQa95+Y4iTQw5EOVLh73ilUCbv6WEbHQtiZrodFU+TU+OPZ9s3aPRfegUswxSW6eT
	 77VN23B/UgqiswBt5IqGpSSrFbsv0lNN2saRjd7URGx/Ha00Px9k+Kwyjs3F/50nV2dPb
	 VRJKozxbVMzfwlmkhRsTcQ1SIlgVJULWiUqIU+ChmAXWJUEgBRDhfWcqZPgiBq5EFdaPn
	 1tAccTszZZZxPGtcjWGIpAL6wiKhi0NpyS+rcXJm24slcUQlA+LVnpdPkdjDH6aNhltRl
	 PfEpkt/2esvnLdsx9vVaLEH0D70tlv6ehICKdsNkdslh24tYPaK6wsb1xcxFz5tHtRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="v+/BH2b5";
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D393460A260C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 10:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D393460A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v+/BH2b5
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e96502e447so15400395ad.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 02:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794307797; x=1794912597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uBuo3746wle39j4tB4qABMZkgvKNVlkfWjVtPlqyf5s=;
        b=v+/BH2b54+pvoF1P6F3VrMhIi+jzBpaWE+ckSGRv/1lFtP55O+WAOTzxihP9ulZEoj
         fjjz2tCnTDwNQQSutY7eXih6apzgiyLzikNZgLinD2ov2khIPu7bP0h2Wccc/TF5N0vL
         beWZ132nnimNsHWdu+yTfyeir7JUZHRzSwYG4V1XirlW0YV7PA2+6FXfKM5XM+W0PSBM
         /ynVx2IpOJFZ6nTWoVcYbpjw6hDkPUeSh/XN2uPFz1H3x8dPrua9SA54P2W60DlKltUC
         VbQuRII7/YEMZbvGdeHwJLN6RCGHbYhOCYOHXBJJx65OQK+Oe7YefEmGQJM4cQk5gtoF
         1U2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794307797; x=1794912597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uBuo3746wle39j4tB4qABMZkgvKNVlkfWjVtPlqyf5s=;
        b=bSR81QcWV20kwuivPlCcp692h7E09htVyb061ey/8vBQxcAWCfgdZLIgb0wKNvLjaC
         OES1xwseE7RPRGmYiLrOsIbuq18lNDq0HC1EC0/GuEKs/s3Wvtkb2zOWEZDqCuOTQlXc
         7hh9B+7rHNUt4XjxciL0dFeKXuSi6WhVhDmKOts0DJQQzKFlmkM0fX8x2L7g+3XeNpP5
         zLJjrTbyvnEibfhdm1lCqeH2Gi9uypfpWRLtfSRWrGThRljydj/5WoOQySsffZR6qOEA
         OIa/DFUsZc/UqiGSYK+BTFjHukfdVM3HNtdvERXEWlKvNutaPll7SRajpGVBNXgurCaM
         RJew==
X-Gm-Message-State: APuU4Z/Yeo0bpvaicpORi75+3SrPXZbuUe/0I2jPiyhnsZdwk8/GBx8+
	l+Y3Pf+Pvkmxv9hGIY9E8raYWDErMLR1iREvuJEu1DSyeMWqzE4vGIKK05uTq7wU
X-Gm-Gg: AYBFou3hU7/rwE1BBnKrYuFz+dk6KFRqP6vkj3HSRcPKJOdI4o+3tI0rdfEEgGmgp2v
	+/7jR1vj97bLqFiqXdozyMhA+XGGv0w0zQ9c8OoqdrcHdQm4P9yeHM9dkypt4xWbTbxWz06nrJQ
	G/xoozWPJtApPxhVqlYSx+KZVB7gN9tYsCC+BM9u0fS3G32KwNtFZ8GcYDSWXvDSv054s8Uk+6a
	qvsigyusi9C75GysA6xfFqT6Z2RTa3TLlBfWEf5qvXFx5Z0kV502/I8thnQgMKQCYaqoxr/+prf
	6fa+98l9ACd8quRa1AMM4Z+bpipWZXe/B1JOiihsmkCu8AJWMPutAoqczLbpJ0UeWQTJskro34Q
	FOz3Go3KUFIqD0n+LuHuBfI+KxtkNB6CsRbxk/mZmUGH5HBLLeSLStFy/A9j9VHnRaC5CHrH3oj
	C1ZtDjRKI0V1SSraHMiEUv1bVE6wDXZNlY1yLHnljwv0ppxkEhe6AorJcS1Y6GdLzGBUYCDHlZu
	+qRr6MgybsVzPZ4UHUG8q3X6VHP4IJcYXHWqV6Ihl21BubJCvzLTAS1DghNc5HQgVml6pYtqbuz
	vFYSCwtHgp9qdgoc3aIEIEeqpdl7uhS0C8ewxN6FaTSoHz2qOi1FLdzH
X-Received: by 2002:a17:903:41cc:b0:2e9:776f:66b4 with SMTP id d9443c01a7336-2edb92f0722mr20908875ad.44.1794307797151;
        Tue, 10 Nov 2026 02:49:57 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6214:1250::1d3:d5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d906e4sm7337815ad.40.2026.11.10.02.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 02:49:56 -0800 (PST)
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
Subject: [PATCH net v4 3/3] net: dsa: motorcomm: Delete the ACL rule of the port being unbound
Date: Tue, 10 Nov 2026 18:48:55 +0800
Message-ID: <20261110104930.223598-4-mmyangfl@gmail.com>
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
index 429345ad1eda..e3f057ed580f 100644
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

