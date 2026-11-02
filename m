Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793603514;
	b=1nqyuP8Lkfmb4DZX7IsSkMNNlHL/32q7sdgMuKXrMBWsTIViBwBd2F5q43T0Zslcrea+
	 olQR39Gp5JYlGAmvy9u3p2P4EMO3hQz5C/o0ACjgGeXT6n4KwBvFHNAq7DoDghNgt0imV
	 hwcjrAqsBr9CI3hmp3FNBXJVMZ7ADVe0hKX9mQt2IenfBuXQkxbf2yTYFjWGR/ldeKRWk
	 Xvo+PZS0j1wLuKQ72XJlsw/aIwPOdMOtyIMFeN75/f+JWT0GQzZpuLQ7e/DbPNdlx6JmE
	 Mo9zjFcW26A7TF74qC7+KMvkEPPISl3qTdJZ8KpV+0nJeokXe0rYJ6VWEyxxHxbnG0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793603514;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=swzQDTPZIeN00KpX50oQKBjJw+xj6Dwfh/YZibjYnBo=;
	b=AoJhAb+2rGTv4eq7F+9mstHOfsigOeGuz4qrM1TpFe4tGe4jIq/uYjouAh7nxwCBMXpc
	 8woJBhPkDiMipYSu25Oj4NBhbtXw9TeKAHEW14IqSWEiRlfNVzy7S3j1Mty4uD+jZuDOQ
	 eBwNhLQZnMu5AId4zUOEtn98U1LaI1PCPurJpZJLX5pGyvx8Bmba6VEPCGTrcFheASVns
	 fwE/ELve+Z7VqP0Et87uRDYVhXquMIzdHfwKNoRuyGp/nbBqPDUWXmlfIVJchA0cIAKlx
	 QDW5SEeG1D1xKC+WNiR24e3qru55PAEl2BG1XB4H3X8SfG9KVvvouEH8xOFwq1jwoJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wXAC7Otr;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA61606A326
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 07:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADA61606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wXAC7Otr
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-89f85edd210so930795b3a.2
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 23:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793603513; x=1794208313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=swzQDTPZIeN00KpX50oQKBjJw+xj6Dwfh/YZibjYnBo=;
        b=wXAC7OtrlblRaVI7i693Z9pM5n12p2nkW536YkGIUZPZ9oF0L75JwccygZKG48nHvl
         ez0oght18JoxbhZ9qMomjbNt/SjGB3VER2WLdVrVyN6HH7/LnVXDkiS7XW2Ey3kbzb8k
         DRIS+xvIXVNipuHQ6iYFA4PMINTE/wypFquDqpU0jZ0VITjRq0qYZ8bO9+mZ3Od4AgyH
         rbX7Ulfxsn+dn3b0cMOycjuaaqNI+lD08Db34nhTU0KAlJdNQGWuNaeJZaTFJV1vfu41
         WL8h4wF2sYxInNTe/cgEMlDwKMvvb+kLabZA+Sbd9WCboExvyhpR+NRFxNs8rmdqdLTp
         UhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793603513; x=1794208313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=swzQDTPZIeN00KpX50oQKBjJw+xj6Dwfh/YZibjYnBo=;
        b=YFuv2j+g2GjzcVYMmnQCNhJvrQ7h4PptQIdlLeNmxakNT5sFEHI0pfI+9vINNbKrFL
         dk5xQKk9BlU73RZIbgXH1DcsAFKWNRMGlV795SbKe0y+yBlwC42bbUa6xYONQLb7YpZU
         sQ3TdBxjyMvGEAryeAOBWn1f9jmSGkYvhdV5i0I6Isxopf6y6WJIWjqeKddRif51akoY
         SytRwMtGgj9nKEZQbRGJdgO3jTkYDIkg9BJpDjOKKa3KSWNZXrQJeYqqGT8XXfcWPUz1
         tAVPUn3bJHlq6BFA2xKZpJ50b01H1cPT6/KcUN+c++2QcWRvyNrSnw8859Hmu51iXC1K
         gwEg==
X-Gm-Message-State: AFq9FYJ4ILgRCzfFdGgqBQZdnBogsACq3iXeZXWunuqRlTgYYsH0f2bW
	xEK9N2LE7HHw/FswSiQKEt2aIC8Zbv/nLZXvgJ50OiZzX8oWlORtXto9352/lH9M
X-Gm-Gg: AYBFou237odbNhOTk/EDCGVaGj+KTD83FhXLjt+S9HyLGoKsYOCUt92q24WhAcECHyk
	DLcD90Q2/5OA4hkWfcjLZni992W1W27Rg4sWHkV4xLyLTFQt+Nd9YK8dB6xskakrovKVfjQ55sj
	YV8Cbvk/wBB9KfH2eYE0UiYdhxH6YqVO49ElB8N77HfopnqMCdaBstmfrOINFsyVOEWTj8O31a+
	JlmUB3HjZmPsIXiqMlvwmab6zY8kXk0MBV1OQ9BkVzYTycwwVR3/p3mdB2RXrGZy6rXpQ8p0HVh
	7wVeBDwl2q8DF0nNBskYKQ6hXaeaoWfOMhT9LSZTGDpRkqYgclJjSXnFdb2MVVSDARxd8SH3xMS
	qjoKHj7X/XoKWuXe6HpuxZaDczc9UiMpD67sZjLoQp9F/3aQidqjQHWgCtcMzfRLwjsNeLZq/tD
	djBrziY598DsRWuHjmzIRARr3zjXB8qo6QmUKdiDqBJD03jK6mNVQeA1lbA5PjE0eNmF5IT/Lru
	ak2zfnU1g53ACrwyBOEeULk1HqiEn6GYzegb5XY5JvwopilwMblY6fI/dtq4lbXOK9pXK9+zPU5
	4uCHPNdN7r8h03t89qNFsQdGV6BB4F9ye7nZPLqynULqXhzhrBR7/npfxCj9j2newSgd4g72Tw=
	=
X-Received: by 2002:a05:6a00:bd02:b0:89f:e248:ac38 with SMTP id d2e1a72fcca58-8a9b9a4ecbcmr6706187b3a.6.1793603512935;
        Sun, 01 Nov 2026 23:11:52 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:28::4:396])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8abab0c6c6esm1140566b3a.48.2026.11.01.23.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:11:52 -0800 (PST)
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
Subject: [PATCH net 4/4] net: dsa: motorcomm: Delete the ACL rule of the port being unbound
Date: Mon,  2 Nov 2026 15:11:16 +0800
Message-ID: <20261102071119.3435180-5-mmyangfl@gmail.com>
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
index 87c04f0dd736..235ecc1eedc9 100644
--- a/drivers/net/dsa/motorcomm/tc.c
+++ b/drivers/net/dsa/motorcomm/tc.c
@@ -1223,7 +1223,7 @@ static u16 yt921x_acl_activated_ports(const struct yt921x_priv *priv)
 
 static unsigned int
 yt921x_acl_find(const struct yt921x_priv *priv, enum tc_setup_type type,
-		unsigned long tag)
+		unsigned long tag, u16 ports_mask)
 {
 	for (unsigned int blkid = 0; blkid < YT921X_ACL_BLK_NUM; blkid++) {
 		const struct yt921x_acl_blk *aclblk = priv->acl_blks[blkid];
@@ -1233,7 +1233,10 @@ yt921x_acl_find(const struct yt921x_priv *priv, enum tc_setup_type type,
 
 		for (unsigned int i = 0; i < YT921X_ACL_ENT_PER_BLK; i++)
 			if (aclblk->rules[i] && aclblk->rules[i]->tag == tag &&
-			    aclblk->rules[i]->type == type)
+			    aclblk->rules[i]->type == type &&
+			    FIELD_GET(YT921X_ACL_KEYb_SPORTS_M,
+				      aclblk->rules[i]->entries[0].key[1]) ==
+			    ports_mask)
 				return YT921X_ACL_ENT_PER_BLK * blkid + i;
 	}
 
@@ -1361,7 +1364,7 @@ yt921x_acl_commit(struct yt921x_priv *priv, unsigned int entid, u8 entsmask)
 
 static int
 yt921x_acl_del(struct yt921x_priv *priv, enum tc_setup_type type,
-	       unsigned long tag)
+	       unsigned long tag, u16 ports_mask)
 {
 	struct yt921x_acl_rule *aclrule;
 	struct yt921x_acl_blk *aclblk;
@@ -1375,7 +1378,7 @@ yt921x_acl_del(struct yt921x_priv *priv, enum tc_setup_type type,
 	int res;
 	int ret;
 
-	entid = yt921x_acl_find(priv, type, tag);
+	entid = yt921x_acl_find(priv, type, tag, ports_mask);
 	if (entid == UINT_MAX)
 		return -ENOENT;
 
@@ -1550,7 +1553,7 @@ yt921x_dsa_cls_flower_del(struct dsa_switch *ds, int port,
 	int res;
 
 	mutex_lock(&priv->reg_lock);
-	res = yt921x_acl_del(priv, TC_SETUP_CLSFLOWER, cls->cookie);
+	res = yt921x_acl_del(priv, TC_SETUP_CLSFLOWER, cls->cookie, BIT(port));
 	mutex_unlock(&priv->reg_lock);
 
 	return res;
-- 
2.53.0

