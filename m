Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793322321;
	b=3gjaIRZohWpKWfCwiFTJ1iy3vlZjS3wxef90itIuQ7hJz6wTEP9Se64ADabxJz+B36kf
	 mUTtTsGcK1l0NDsAxESOPL65N5GAqx9hyJM9UZuPH6un9Z020ltkoIrqNoQ+6DZhEq9UH
	 vaL7MnTrK1V1JaS7p9IY+MGjwGiTb/+SBehSAaoT+x3xtXgqdMguspU1wVyJiIaftvEXj
	 PL5YCnbhJRlKvVHCyPSEwRyhN0Ayna873pKoJuDeuARlSaj0jre/+HebQR1ctKvl/cbep
	 RrfOoixoX4OOvfHQ3f+zXisaYHhw2jkXgpXFHpVKIMZHWh/fyId/ryD5IwG7s+A+l6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793322321;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=61qcPN07t2TUNYnm91oL81Sx86wLZQKTzOl/nzNJeWE=;
	b=hYcec1nRaqUC0ktOiioUsVPGUWBCyUe/lPruFG6XoovEhIDtrBhHFZpg8t7rQfjdWgfT
	 z9aI+EYJkWXNmm7H89BWAeAOW9cB6vG+YD9prKvvqG6njZQnLDOP6jV8B6PSTmlJ7KY4q
	 kepMdTKeUitzsWYEoEuanizJBbNl+/p5C+HIXMTrdBsCnPl47Oh2SNVyuZ3Fv2tG2OZFL
	 j16g+Red6f45KWdOnopAfK7sA1yM9FWbSsB0M/VbTBL8gIDYmy5YDauOqZvBCWpvASsYP
	 UuVnpg5oLvEh1lVN/l16qXgL/lC8Yw+8hR4f0K2Tma6djCI3VTSOgb4XSIXBilQ+PXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodkind.io;
	spf=pass smtp.mailfrom=goodkind.io;
	dkim=pass header.d=goodkind.io header.i=@goodkind.io header.a=rsa-sha256 header.s=google header.b=O004XT8L;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EC0606A31C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 01:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93EC0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goodkind.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodkind.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=goodkind.io header.i=@goodkind.io header.a=rsa-sha256 header.s=google header.b=O004XT8L
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-33e5ae86ff2so85170eec.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 18:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=goodkind.io; s=google; t=1793322319; x=1793927119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=61qcPN07t2TUNYnm91oL81Sx86wLZQKTzOl/nzNJeWE=;
        b=O004XT8LrV0kOisutmOjeOkAAcgRirG51SVD3eTlxC9uptQxVRMAqYRSNu3zpcLo0l
         b2F3CDZEzhqFsrq+v0UPbW2ga+lFo/WPETrz0pin/65Z3nqRpANzqMkqZcEFxBlx4gAU
         53M+M1jGn9I/cEYSdff4C4G1bcWbURr8WsLGp3nKYiCqgJaMXs2Powc1w18LASFS718w
         3hqR4AbydoLLPCH4px5SMCemEVpZmUlnb8iO3dew9dsKz7Hi6xFHKBdWeH4+sixtwYnW
         NHroCcs+kfS0b0yPpA1ffkAPRaxBSf1dc79SHBGXPY6sNUQQI6hY4lQlnyYqDp+YmQ0x
         vuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793322319; x=1793927119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=61qcPN07t2TUNYnm91oL81Sx86wLZQKTzOl/nzNJeWE=;
        b=UdmgtPReOmML8YBQw3grXfQ8vKXosWwPHWqXL6iVOpUSCTDr8vO++m86Gh18ip59BX
         xRf9KYmGaaR8dJomPlxyNHpDG3fkR5iN1pbKj05wJLMytcMDc2KB+M3/c98Bg6gSrZf3
         Eua3sSwxgon6Ot8guMmVycWx9l4h54Xq1MIvqTkBGoYzJSpm8a1hvctwiIeTHzasvvdf
         C8063L0iaXC6JtPV9zyjNdyLTxVI4s5RshUvq5s+i4LXvxzKQxpO2FOu8sbN1sps8I1M
         ZRF51miW3ZQec7njNnz9ziKx9M2XXGvjg1TwIeAransoWBDkqILnUyfbVPcj96sjZpke
         rKAg==
X-Forwarded-Encrypted: i=1; AKwUvBwuxiVpVjrieyK7iptBKMkmSpGG4pg8QFBO5BSmA09nY90yfkuyNgp33VzO0qUfuN06JGsqlxs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKnooOukKKEphkGtQsStuccWFIA8NZ1b8Tky4kBVAwm6I9Gf+ch
	L+xwlNf7CRdAbSSRu7V6PSZ61pzI1hg/xbD+nmHQlWtMJoFvQdA2ZPduvxb3SoF6Kmo=
X-Gm-Gg: AYBFou3pDuhK88KD+a1FutUG7MuHtmZThobjNHIjRcdMzK9ozT848I0PXyfDbm9Kc1n
	86/gG+8ef7jMi4TE2JTBU68FwChbjLblVX8kyALZq0PpZUhsjtWmsxevSlByhYwGMYx12AptHGh
	HCcoBVy8wnoEa195x2zcxWNy42oLeY4vyRqXrNcQPoBR6BB/wdC7YYESIh6oZTSJtirDfUq2+kQ
	x/LY97SfOsvOn8WIjbihAwONVs1RuHTUaIdZmiNbriN0bx0yHHrZDdltyPEYt7IlmJzGi5eMCdz
	zZKk76bDRNB+BYrYQVOx4FZFQL8Jb57fwN4CbDbLAaHC5fd5g5jujFafwYyLUZn5HS3wfMMP8ls
	rMxORhxgJV6s3HLKy62n+v8PexTTgs766hYauD/jdg089XR/GBjfRGPq3IQ+zmUrQEnwX4ezTrP
	qnjyXMs8xdXVCTFJprMaJeEirQbDIfuElIVd1Wzhan88oSekaHhq/mmnmuJ0BKAvmYWapfhvzq5
	HIl68hKf4FX2n85dYsS4ws6n2XJrqFkrn/ZGu9oL8klC0PmIdhHev90hU/pV04hlMpaWl2mHzzh
	ZI6aI0Flv6RimQLDbxlcrVVJxwcyuvSSdDTlhh1dl6GxuoM=
X-Received: by 2002:a05:7300:3b0c:b0:36a:238:1485 with SMTP id 5a478bee46e88-36a4244276cmr1870508eec.37.1793322319336;
        Thu, 29 Oct 2026 18:05:19 -0700 (PDT)
Received: from localhost ([2001:5a8:4296:4f00:50b8:8e86:d398:7911])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-36a42a77c0dsm2458500eec.26.2026.10.29.18.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 18:05:18 -0700 (PDT)
From: Alexander Goodkind <alex@goodkind.io>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	Alexander Goodkind <alex@goodkind.io>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Tarick Bedeir <tarick@bedeir.com>
Subject: [PATCH net v2] net: ethernet: mediatek: preserve sibling PPE bindings
Date: Thu, 29 Oct 2026 18:05:17 -0700
Message-ID: <20261030010517.45639-1-alex@goodkind.io>
X-Mailer: git-send-email 2.54.0
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

__mtk_ppe_check_skb() clears entry->hash for flows bound to other
hardware slots in the same software hash bucket. mtk_flow_offload_stats()
then skips their hardware counter updates. L2 cleanup also frees sibling
subflows without invalidating their hardware rules.

Restrict both cleanup paths to entries assigned to the inspected slot.

Two UDP trials reproduced the counter failure on a GL-MT3000/MT7981
running unmodified OpenWrt 25.12.5 with Linux 6.12.94:

1. Start a UDP connection.
2. Add a control connection in a different hash bucket.
3. Add a connection in the first connection's hash bucket.

AI code review of the original patch identified the cleanup problem
in L2 subflows.

Full ARM64 builds with allmodconfig and allyesconfig passed before
and after the patch using GCC 14.2.0 and W=1, without new warnings.
The builds used CONFIG_WERROR=n because the unmodified ARM64 kernel
already emits warnings. Hardware testing has not run for this revision.

Fixes: c4f033d9e03e ("net: ethernet: mtk_eth_soc: rework hardware flow table management")
Fixes: 33fc42de3327 ("net: ethernet: mtk_eth_soc: support creating mac address based offload entries")
Link: https://github.com/openwrt/openwrt/pull/26107
Assisted-by: LLM
Signed-off-by: Alexander Goodkind <alex@goodkind.io>
---
Changes in v2:
- Apply the slot check to L2 subflow cleanup as well.
- Add the Fixes tag for L2 offload support.

V1: https://lore.kernel.org/netdev/20261023012529.5994-1-alex@goodkind.io/

Codex assisted with investigating the counters and preparing the patch.

 drivers/net/ethernet/mediatek/mtk_ppe.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.c b/drivers/net/ethernet/mediatek/mtk_ppe.c
--- a/drivers/net/ethernet/mediatek/mtk_ppe.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe.c
@@ -754,18 +754,17 @@ void __mtk_ppe_check_skb(struct mtk_ppe *ppe, struct sk_buff *skb, u16 hash)
 
 	hlist_for_each_entry_safe(entry, n, head, list) {
 		if (entry->type == MTK_FLOW_TYPE_L2_SUBFLOW) {
-			if (unlikely(FIELD_GET(MTK_FOE_IB1_STATE, hwe->ib1) ==
-				     MTK_FOE_STATE_BIND))
+			if (entry->hash != hash)
 				continue;
 
 			entry->hash = 0xffff;
 			__mtk_foe_entry_clear(ppe, entry);
 			continue;
 		}
 
 		if (found || !mtk_flow_entry_match(ppe->eth, entry, hwe)) {
-			if (entry->hash != 0xffff)
+			if (entry->hash == hash)
 				entry->hash = 0xffff;
 			continue;
 		}
 

base-commit: ffdf678dd16610e3f006dac904bd37c09684673c
