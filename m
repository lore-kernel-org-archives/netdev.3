Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793950739;
	b=vl6da2/aIIRWYM1O9BiKH8fsmXyL4N5en4FSQx9s3dGx8m9WEEphv/0x3by9qsUYC9vD
	 m7LcfqpqeGB9y1WCLL4Hu+0Vc2FPaXxhfnM7kIhHcUc92tSYhy3UTXVv1uY+Vv7sJ5AK1
	 bcNtKyrj1PJiEk/dEXUtLGRGjGe8m5D6BLDm5k5q+v8HoQiOtobKrMpKo07/nVxH3CwCq
	 XmPWcoq2IspRXhGwqM41pQZyzzXw1SrQH9mUNp4Mn0CF+Qx07lyBKddKNDGpzOu1QN0NO
	 zjeBSqTvhFdpbmmTNdxYlDVjTGYTvYEutQ+TLI4YQtzUdgzcECJhDh5/FjU0+d1vCgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793950739;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8gASDMr3+aiXaCSJjYAmL3vSarYyK9/zWHfxGyG7lYc=;
	b=qK4JcQQZimhubTX6TUJHWYTOfIhGx79FCYhY4bkglkQGoFQ4/n1jF2bC60RBvqeEGfNv
	 5SK5AwFwHR8ld3Ofy8OVfH0n/3oTF5WYqthP8hOUaFHQXaCQ579jtkRtkI9NaYSR0OzW9
	 b/7tnuTA+QOn6WCeyq8tstvnaO0ba3ysvdCWs8ZN4rve1waVWp+0ASO3KCMSzEoRrOFlP
	 WCC7U0eXVuu2+reb+JgDnvcY399sVjMo+ePNuMhXPuqnH2/mfuLOoSdmAIudKHMKWKFN5
	 L46qK+jIg+Ej+J0XEbURILhXVffijn7ugNekioQOgzIC9CF12MhVLyT/bqtKcPUzO8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JaegnGB3;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE14606D80C
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 07:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDE14606D80C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JaegnGB3
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a06c60065fso136556b3a.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 23:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793950738; x=1794555538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8gASDMr3+aiXaCSJjYAmL3vSarYyK9/zWHfxGyG7lYc=;
        b=JaegnGB3mHQIvxJOuQCfPVoM8jxNUknxlsCKaFPbBoFXH+DU7+2HgmVOpRKX6oHc35
         dhimufJT16sMmybzbin8ZTG8pC+vXMwqRTmh1KAATEa8dkhCoDGD11jFqi6Ug/kUhhgf
         zjY+o8o+wi+8lTZhaODjy7nAsEMbe0n+7T/5s6VNd6Z3vctAq3KpNG8rb+jnT7wKikqM
         h1J+/rABXM9SQc3kLzixZGcOkn8l49WOT3aYwOjY0KQ0fW7hz/84oRs3g6Z8wuxQAPhh
         cBb9gG/ALn5O9Qd6GEvPdoVBkRt1eNc+uROPEeZZ+QpltXUloEwsN9Sp3y/KFua1i0E5
         D27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793950738; x=1794555538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8gASDMr3+aiXaCSJjYAmL3vSarYyK9/zWHfxGyG7lYc=;
        b=iihA9HQ3EJcFXTCGE3TVH5yBHeF+wTtiYs00qU34VZhvCDaXyrq/DIiRRENKpXIfYE
         oNgHfeX0OshmnjZiUNnERehxo1DpVNHF4hwtLMWjGxVopzpA1ctsTCfmTzmI44JJM3m1
         egCB+pchTNJReleFU+RCzvvjRIfLeyVXN0T4x/0zQXDq3lTcvmxkR8vaLc5IbEzwHNii
         5+aZmIvIetbDF+6QzC5jiPUm4+xrkB25x1TWQd7dgojfYFp0jzm3SORs3zMJCvNEJiQw
         YbBaFmyeixaIFQiLFgG2eMdf1VZhZD1pFr9S6x03QEOlKQk9YHuKDk5l57zrY0n9tQXI
         eBAQ==
X-Gm-Message-State: APuU4Z8SMjoHcyrP+97uUycl+YHFPhB+OCodQ2sYkdU0jdv5LoapCCvQ
	JbtUFZgkBR28uSf6RNj5BnYOQax1dCpiAF4m6a4HglHd7vo2koDKjKmh+jyb99xq
X-Gm-Gg: AYBFou1vm1i/pTtUPowHyzIjeHksjJ8x4TkCdHjl7jQn9rvKgW7KOEzA7ZbRK6OkgxL
	HzFJaHXa9i5u3V93oW5+yIGjrxcxc9k0T7ZxQga15aBrSE9iOnhrZ9Nt0NfVg8CfAvL6hLFYU1F
	PRGOPDkkqbs5iweBVAO+qId9jRuDrUHtusmHJuQ5gMvjl829Gb0pTTc1TvVb5rJwR/YSj8+G0f9
	Cp0gJZf8qwsza6EewZTKX3e9rzC+Oed1umxwqcJpqtHWliKPYu9WNEKJ1wcuMEaBN4Sp/iA+vHI
	xkjEOdseh9GEiMX5uv0CXGT4aCnOPpBX92U1i9wlzrXUbM5nJOc5m/qcyPxDr678gQFNcRPUA9P
	bvxlryeR2wmK7JuB25c4anl5ZYlfn3VIbAvzIMTtRnFV7/E0XcGsYuspkrz4Ln3sofPCAcnmXUV
	oum0V2jAmoXYLHAD0+pdAjuvzKsEXWdZW4UGxd90QoeV4ae8SXaRLwwivntrwGjNFcIL2ByOEr5
	M0iJyt0BCY7zsPbAAy9KBaXCzT6BPpxSuSpjC0b2pmko8OJsmpOyDeWyB0CHb7yL2w3Y42H+m1y
	TBCwJkF19i2dw+EQOS0rb7ObutyuPCTTto0D6Zq8N2l8XHXZA0+z
X-Received: by 2002:a05:6a00:4b13:b0:88d:3f61:20f3 with SMTP id d2e1a72fcca58-8b37c531bd4mr1401050b3a.54.1793950737992;
        Thu, 05 Nov 2026 23:38:57 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:28::4:396])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b3597efd53sm373484b3a.23.2026.11.05.23.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 23:38:57 -0800 (PST)
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
Subject: [PATCH net v3 3/3] net: dsa: motorcomm: Delete the ACL rule of the port being unbound
Date: Fri,  6 Nov 2026 15:38:02 +0800
Message-ID: <20261106073806.112122-4-mmyangfl@gmail.com>
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
index 5c82719e461f..6192aa9f05be 100644
--- a/drivers/net/dsa/motorcomm/tc.c
+++ b/drivers/net/dsa/motorcomm/tc.c
@@ -1228,7 +1228,7 @@ static u16 yt921x_acl_activated_ports(const struct yt921x_priv *priv)
 
 static unsigned int
 yt921x_acl_find(const struct yt921x_priv *priv, enum tc_setup_type type,
-		unsigned long tag)
+		unsigned long tag, u16 ports_mask)
 {
 	for (unsigned int blkid = 0; blkid < YT921X_ACL_BLK_NUM; blkid++) {
 		const struct yt921x_acl_blk *aclblk = priv->acl_blks[blkid];
@@ -1238,7 +1238,10 @@ yt921x_acl_find(const struct yt921x_priv *priv, enum tc_setup_type type,
 
 		for (unsigned int i = 0; i < YT921X_ACL_ENT_PER_BLK; i++)
 			if (aclblk->rules[i] && aclblk->rules[i]->tag == tag &&
-			    aclblk->rules[i]->type == type)
+			    aclblk->rules[i]->type == type &&
+			    FIELD_GET(YT921X_ACL_KEYb_SPORTS_M,
+				      aclblk->rules[i]->entries[0].key[1]) ==
+			    ports_mask)
 				return YT921X_ACL_ENT_PER_BLK * blkid + i;
 	}
 
@@ -1366,7 +1369,7 @@ yt921x_acl_commit(struct yt921x_priv *priv, unsigned int entid, u8 entsmask)
 
 static int
 yt921x_acl_del(struct yt921x_priv *priv, enum tc_setup_type type,
-	       unsigned long tag)
+	       unsigned long tag, u16 ports_mask)
 {
 	struct yt921x_acl_rule *aclrule;
 	struct yt921x_acl_blk *aclblk;
@@ -1380,7 +1383,7 @@ yt921x_acl_del(struct yt921x_priv *priv, enum tc_setup_type type,
 	int res;
 	int ret;
 
-	entid = yt921x_acl_find(priv, type, tag);
+	entid = yt921x_acl_find(priv, type, tag, ports_mask);
 	if (entid == UINT_MAX)
 		return -ENOENT;
 
@@ -1555,7 +1558,7 @@ yt921x_dsa_cls_flower_del(struct dsa_switch *ds, int port,
 	int res;
 
 	mutex_lock(&priv->reg_lock);
-	res = yt921x_acl_del(priv, TC_SETUP_CLSFLOWER, cls->cookie);
+	res = yt921x_acl_del(priv, TC_SETUP_CLSFLOWER, cls->cookie, BIT(port));
 	mutex_unlock(&priv->reg_lock);
 
 	return res;
-- 
2.53.0

