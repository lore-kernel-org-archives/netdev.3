Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687EF3B27FF
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 05:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785216390; cv=none; b=Mf/rEAt5YPvBoXo7GYORCX5emFsVaGxJudGtVb0PhJF4Vci3WvABBZyY5brGgu1ERrNAI7ToFtPGO6h3ZtFMefUMXRWFNl1C2XRnXvg++GanU4jhJ1fpYN6BSXJCdAhjKd2Cedg4THAjFck55hNDJqrkv8Aig6tImLk9ByC/kQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785216390; c=relaxed/simple;
	bh=+jsDXD+CJF6jZBGaHiQSU4RRZEAF2rns1O9DXteUKEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Er0DAD2PO7sd5UPHLQ04G9z4EKFTU/0fgrYit+tBvfb8OER06o5Av4wx81rBMtl02ZXj/t4w4kQ4r10TyT1vUpnemU784kp/CXKekTFwDOyEwSPtCay9uJep1zoE4NmnXpMcsyfHwa8NjyIJSK6aHW/FkJCz8oNMyIx/EWAae+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlJfSDbH; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlJfSDbH"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c9c26a5fb98so411359a12.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 22:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785216389; x=1785821189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wOvqhkG9iTx6EoJ6BYnQkA6CDv3u67pJRtcHT715CtQ=;
        b=NlJfSDbHE2+aP5Kf1j/T1zox0lEvCGbTSye2ufwh03q6ZBYMO4ToBiwAPsBv39azXM
         VOtkQHw9+5eS1dcBULO/uMXK2yhMdX/5AsURfUkntm21NTmJe5WX1xcBBU43WKNnLYSL
         ZDal8+YUVzhsp8GODgeReG8nJW+Z2KNu4UAkVdpm1AmYkJRYBG+zCKjeitZ0FEXoI+u5
         DwQ5Pa610wOMgwy7JE1ribe/rDaohdvj44jxZcrDtp60la+0MHUhDq4MuM5EKucSzbtg
         x2C/SqFviy3tjagDw98xHWc/6F/i9zNpDtQPsJYtpwirz3lVjL+zlAQOdgNVb7ceINnM
         kBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785216389; x=1785821189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wOvqhkG9iTx6EoJ6BYnQkA6CDv3u67pJRtcHT715CtQ=;
        b=W/GjPjqsPU+QJoTD3dgcJx8jfFPhTMoE8FP0Ab+HEyYzJPuFKRGCPwr/fYMh4R4HFo
         FRkayhecgriPeLjvY4CnlT2yXc5BMtgWRD1OvGpGaQLE0793cz+46gsNSUHKvIHQgidk
         kM/OV0WXyE9WaD4irobjfMhUxbTFKp2yFHtt7bThkKbMeEPh2u5q/yduntznBukJbIYq
         6T7anbkzSy81x64BNP7YfN70764dBbGjBZ0EblafWuYeYNKikknY+Coin/C4v1i2XFCQ
         QMaO/4qOY60AZ06mO0jv+FCB28mK3AkrktBT/aOECNqaEVfviO3X7sVg40AA5Cuc1HsJ
         w1IQ==
X-Forwarded-Encrypted: i=1; AHgh+RqlAuAKixBybbiHwdsCe+x7Jy0Bw0PJg63fUxQmYfqHXHE+OwUK7fxTZofBYVQ++AWzCY+Wrks=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaMStwwphsWDbD1cKDq90XxpLuv+9uMtJfBMJg4KwaYVe2Uqom
	vN/9VuUxm9sUZ7ytr/yLPhYWwoirgB2D40OT5M7HkjopgivFLv2hIbeGM6wq6FANmVY=
X-Gm-Gg: AR+sD13qSaaLimR5ewDV/WpYPGxO2/ktk96jAJrOtgrEbFdonuOuybgnLjc47woh4Gt
	coUWag6tqaLLvy1Q7Sl7SKDwvWgYRPoaFqNAthXVRHh292FhrlapvkLWnT6P+pP1fRTX6rKNn8d
	DgUxKc7hgKLNS3dIyP0C7O+gygujquG0vrwuyE62gTL3N0KACdCmjnErONgXPdIKGMBgPy2cAzO
	56rbmC67OLr+NtG8xRZKvP52Rn8DNUCRPvSYAGZ5Mit9ZtzgZ5Wjvlmxy4j5Ke6jLWKn8HbVgms
	Uc5VUSQv+lRC7sJ5Q+zfBfHQiyQ2gVqRpdkbeuh2GY8S6EhEWFUxFXgSn5QKsK+HgEFESzf6PMy
	S5RRGWCB0OBx1M4bWBvbNeYyhI+uw15oIAQwL4HxmEmCG2XSeMUDsY19JjyeW6Jzt5FNm
X-Received: by 2002:a05:6a21:6f8b:b0:3ba:d7b0:fcac with SMTP id adf61e73a8af0-3c8ab0d42f8mr1265946637.5.1785216388524;
        Mon, 27 Jul 2026 22:26:28 -0700 (PDT)
Received: from fox.. ([43.242.224.196])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc3e1255sm58198016eec.4.2026.07.27.22.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 22:26:28 -0700 (PDT)
From: Roshan Kumar <roshaen09@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Christian Hopps <chopps@labn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	Roshan Kumar <roshaen09@gmail.com>
Subject: [PATCH] xfrm: iptfs: fix stack OOB read in iptfs_skb_reset_frag_walk()
Date: Tue, 28 Jul 2026 10:56:08 +0530
Message-ID: <20260728052608.2898018-1-roshaen09@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iptfs_skb_reset_frag_walk() advances to the fragment containing @offset
with an unbounded loop:

	while (offset >= walk->past + walk->frags[walk->fragi].len)
		walk->past += walk->frags[walk->fragi++].len;

walk->fragi is advanced and walk->frags[walk->fragi] is dereferenced
without ever checking fragi against walk->nr_frags. When the requested
offset is at or beyond the total length spanned by the walk's fragments,
fragi runs past nr_frags and off the end of the fixed-size on-stack
frags[MAX_SKB_FRAGS + 1] array, reading out-of-bounds stack memory.

The two callers behave differently: iptfs_skb_add_frags() already guards
against this with

	if (!walk->nr_frags ||
	    offset >= walk->total + walk->initial_offset)
		return len;

but iptfs_skb_can_add_frags() has no such guard and calls
iptfs_skb_reset_frag_walk() unconditionally, so it performs the
out-of-range walk. Its own "fragi < walk->nr_frags" bound check runs only
afterwards, too late to prevent the read.

This is reachable from the receive path: a crafted IP-TFS (AGGFRAG)
payload delivered to an IPTFS SA drives iptfs_reassem_cont() ->
iptfs_skb_can_add_frags() with an offset past the fragment total, e.g.:

  BUG: KASAN: stack-out-of-bounds in iptfs_skb_reset_frag_walk+0x235/0x250
  Read of size 4 at addr ffff888008ad7210 by task repro/345
   iptfs_skb_reset_frag_walk+0x235/0x250 net/xfrm/xfrm_iptfs.c:392
   iptfs_skb_can_add_frags+0x155/0x310  net/xfrm/xfrm_iptfs.c:420
   iptfs_reassem_cont+0xcf8/0x1140      net/xfrm/xfrm_iptfs.c:902
   iptfs_input_ordered+0x552/0x670      net/xfrm/xfrm_iptfs.c:1280
   iptfs_input+0x3d6/0xde0              net/xfrm/xfrm_iptfs.c:1741
   xfrm_input+0x282f/0x6140             net/xfrm/xfrm_input.c:700
   xfrm4_esp_rcv+0x93/0x120             net/ipv4/xfrm4_protocol.c:104
   ip_rcv+0x278/0x2d0                   net/ipv4/ip_input.c:612

Give iptfs_skb_can_add_frags() the same up-front guard that
iptfs_skb_add_frags() already has, so the walk is never entered with an
out-of-range offset. When it triggers, the caller falls back to the
existing linearize-and-copy path, which is safe.

Fixes: 5f2b6a909574 ("xfrm: iptfs: add skb-fragment sharing code")
Reported-by: Roshan Kumar <roshaen09@gmail.com>
Signed-off-by: Roshan Kumar <roshaen09@gmail.com>
---
 net/xfrm/xfrm_iptfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 597aedeac..2ce15c472 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -416,6 +416,14 @@ static bool iptfs_skb_can_add_frags(const struct sk_buff *skb,
 	if (skb_has_frag_list(skb) || skb->pp_recycle != walk->pp_recycle)
 		return false;
 
+	/* Reject an @offset that is at or beyond the end of the walk's data
+	 * before calling iptfs_skb_reset_frag_walk(), whose fragment-advance
+	 * loop is otherwise unbounded and would index past walk->frags[].
+	 * This mirrors the guard already present in iptfs_skb_add_frags().
+	 */
+	if (!walk->nr_frags || offset >= walk->total + walk->initial_offset)
+		return false;
+
 	/* Make offset relative to current frag after setting that */
 	offset = iptfs_skb_reset_frag_walk(walk, offset);
 
-- 
2.43.0

