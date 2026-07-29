Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D129648A8BC
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 13:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331195; cv=none; b=bXm1exqsmxZzpFWFFGhEbWd/eLEwSYf2tFbbmAxbUi8faSlOSRKwXE8005IxlAneq9qCBr85l76BLFT/icDL7UgUr1VCX9xSbP2zRBCECW1TrHKo9Q9t3zIcYfSDbBUTR4/HTIIqTnOLT60tB016+VODWqdNFaHQf53NDIsNFNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331195; c=relaxed/simple;
	bh=kdlhdT6qgk713ttnMT/RjwDbI68wlDahWZC3PMz1mLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quBmO2dxGBJQbkb3IzBxh0QW2y9aGCHfbnlqiTDPKUNp0yEwVdjiLoPZhSnpjYVaBEaRSJIbpGx81M/75zL3Ao6UsDNO6XpEmtJ2Y164TOMcTcgETSkvQuIVTWo8w8RV8DqI6tB9zOkklybszmepCcFLZaEYAI3FZiPTt1YihCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=MWB+OZSJ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="MWB+OZSJ"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-80814edb536so15841877b3.2
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 06:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785331191; x=1785935991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KMXrirPZU7fXTxWoE1e8bDQ+DkmRVCXCwha59Dx6pk0=;
        b=MWB+OZSJjDeAYCCmKe27IhSRTrKqz60HJKDZ+e+GZ3O91T3PUqvIlxmgzDYip0PXVj
         XZRhAQd3oWlA+9K8v5vzo5OnHTtNbOs7Ixp53cV8zRNyL1pTvehVoPNMGWgib81KB/1O
         4bAgEoGrPLVX+0YqbPB/m2OXHEqU9LOMGrp/0TygWb14bjqsouaxtOGEklNyzjG7CGIt
         ISVSQKJCR8ROa3fNVdtQVw+/yptlgapMtZZOXmos5MVI5L8ih3WoEkDkwGVK32r8h1Gu
         gIn5IZp7nLVA6+rMT+6QWR3wQq4HFJY05oaPAa+7Oo2G4tWmlepB8EIUaALvTZWQkFj/
         rXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785331191; x=1785935991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KMXrirPZU7fXTxWoE1e8bDQ+DkmRVCXCwha59Dx6pk0=;
        b=i+UcN5GlvqMATljNqYSucpKFnUquf8UrYi/owIi54SslVkqYDE/ycT15yuMqLf9wD5
         mdpDQGUGYBfyXOIE14+b9f6kTLmppZg+oK0SuI+6MLklQPUd93G/qpHsBSHe36W0gsDy
         dzIEDB9ej4H02mOhWedxk8RchPbfdAIhAHxtuzX0l4J7pdhJaBy0MNPz+uozLwLncb/I
         pOM8Ezb5XY+/QWZekOcJE1A8/H1yOMC+oFvG1ydQlLgcyROufCPaG2iHfsR8l4TUivvK
         4rIvpnWXTZm9oyj3L3mOhqIi+gk6oAKSKhFmgtBGz2CUd1yhs6XDbAMF8wE7eyutFVSk
         CarQ==
X-Gm-Message-State: AOJu0YyUpM5tPSkYQlI977I8GhVqQytflbOas1iRcZM+fRakU8kKgAJ+
	FJzsI9+xLfqicA//l/T5RrA9aufxNjrwHktPcBgDc/C6Tqz+E7gIyxlSvIEaVFpgNyo9Uhzm0c+
	bwCcNyLUjyQ==
X-Gm-Gg: AR+sD13hRkR/zd/OkScfIVdx7hTWZker0KxyWhrYppWnuvUaF9Eu/kEBLwODxs5GHoK
	+RmTydR6ZlyZ97qdBT2z9dYS7emm1QdJuJxoJIk/PbupJiujk4wc/rOPM19vdT9hdUjhZvmMKn2
	p8D0Mkk3HMOyAh9iuw9AZL1A4MfqryPXPhYRfWrZm299A4Un1FGNsfaWQtX1JpsSHr9yDFIgS9A
	hCUjZoeESsoedmYBSvOX3GttcPvw7p73AeTA+oj6tkGxxEEgibJi1SiQxFecptZznSRsedtMOKo
	Kv+VUG1wL9CIJhZ0niYO9pyCiI3L1FlT4H1wg2PdrlHPgs0ehZemgZV+ZdCY0vtI1EeB0btZ3Gn
	7HAIOQJSqppUh/N7WAskZQ5HesfS0Y0pwAb0bXG+GHVIAxYYc6EQqBGYLIR3NHsJ7tbv6PpFdFl
	7q5B924ecr5QM2IJLERJ5xql3HFY5F87ff5xAcLh7CkoDiRcLT6UUWXwuTsmpVwXlNc7A19g49+
	qsSSK6zuPCBWmkPO5gVOStOV8ebd64XpVowvUL71YiU4N2k9tE6fiarpNA0hE44yLZsKWEGaCWX
	ndCyvIJvcpi8CqLfgA9QRMuasgNrrw==
X-Received: by 2002:a05:690c:62c7:b0:814:5312:47bb with SMTP id 00721157ae682-81f993f145fmr33494437b3.69.1785331190331;
        Wed, 29 Jul 2026 06:19:50 -0700 (PDT)
Received: from buildmachine.tailf331da.ts.net (ec2-3-14-143-233.us-east-2.compute.amazonaws.com. [3.14.143.233])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fa275691asm17653907b3.4.2026.07.29.06.19.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Jul 2026 06:19:50 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	Baul Lee <baul.lee@xbow.com>
Subject: [PATCH net v2] net: bridge: mrp: fix uninitialised bytes on the wire
Date: Wed, 29 Jul 2026 22:19:41 +0900
Message-ID: <20260729131941.10254-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260726062518.43774-1-baul.lee@xbow.com>
References: <20260726062518.43774-1-baul.lee@xbow.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

br_mrp_alloc_test_skb() builds MRP test frames on an skb from
dev_alloc_skb(), which does not clear the linear data area.  On the MRA
ring-role branch the sub-option TLV header is appended with

	sub_tlv = skb_put(skb, sizeof(*sub_tlv));
	sub_tlv->type = BR_MRP_SUB_TLV_HEADER_TEST_AUTO_MGR;

so sub_tlv->length is never written, and the two trailing alignment bytes
are appended with a bare skb_put() that does not clear them either.  The
neighbouring oui and sub_opt regions are explicitly zeroed, so three
uninitialised bytes are left in every MRA MRP_Test frame that goes out.

Put the sub-option TLV header and the alignment padding in a single
skb_put_zero(), which clears both.  The AUTO_MGR sub-TLV carries no
payload, so the zeroed length field is already the value it should have.

Fixes: f7458934b079 ("net: bridge: mrp: Update the Test frames for MRA")
Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
v2:
 - fold the alignment padding into a single skb_put_zero() for the
   sub-option TLV header, dropping the explicit length assignment and the
   second skb_put() (Nikolay Aleksandrov)
 - drop the paragraph about observing the leak, and the Reported-by tags

Link to v1: https://lore.kernel.org/netdev/20260726062518.43774-1-baul.lee@xbow.com/

 net/bridge/br_mrp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
index 179d2470b..ef16d0703 100644
--- a/net/bridge/br_mrp.c
+++ b/net/bridge/br_mrp.c
@@ -224,11 +224,9 @@ static struct sk_buff *br_mrp_alloc_test_skb(struct br_mrp *mrp,
 		sub_opt = skb_put(skb, sizeof(*sub_opt));
 		memset(sub_opt, 0x0, sizeof(*sub_opt));
 
-		sub_tlv = skb_put(skb, sizeof(*sub_tlv));
-		sub_tlv->type = BR_MRP_SUB_TLV_HEADER_TEST_AUTO_MGR;
-
 		/* 32 bit alligment shall be ensured therefore add 2 bytes */
-		skb_put(skb, MRP_OPT_PADDING);
+		sub_tlv = skb_put_zero(skb, sizeof(*sub_tlv) + MRP_OPT_PADDING);
+		sub_tlv->type = BR_MRP_SUB_TLV_HEADER_TEST_AUTO_MGR;
 	}
 
 	br_mrp_skb_tlv(skb, BR_MRP_TLV_HEADER_END, 0x0);
-- 
2.53.0

