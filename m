Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C801F41A922
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 08:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238606; cv=none; b=gQ6PBPHaWuzpbBVN9ikfL9lT94ZDvBCPv4+uXFveaW2H/vaLtnhv1221gJQk/jl3fxAjlFI9nGYEuyOemhrbT60EwNJGmwnJN+LyoHzfyHSiW/5cvT9kn6m8umuJLn6HiwABr1k18BF7uhDT8OkDzG4Pq3JGWBuYq+4eM+TMZPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238606; c=relaxed/simple;
	bh=AW+qlZdR4Ryi1sPKOcr8ykehXr0uVIF3t0xQw3DxRs8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o4ROHU8U8mkQWGcCOU09rmhC4tgLo9f06sxiHVIeP6/ruyDwBwKgYWvk/FSnnXLA3Dqd6l3ZoJi2jH8761nfl4Gd8PDm0jUQmMgka3y2iXiu+nsnGRJh1ERu9N14Lp1lmkc30AjaAsDHgOLqmFARvDviXNag0eHkhOxAUS5LBEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E9+yJsU4; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E9+yJsU4"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-939062ecda9so279748285a.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 01:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790238600; x=1790843400; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ffoYufaDSfVatt78XpLjVJHKG1hzTad9qkMPdMcjBFs=;
        b=E9+yJsU49YKP9FSyY2ipvsmWWxQrvLegDLUZcwJjIuj6HWa485MqPCWZWepX4bWLB3
         9c8zHwj6UAB7TsAPlNCl3Mwr3fpCvEblo68bgMZSKmvGWBH8TlklA7DMGyXX0tHKRYoh
         Ka3k0Bktf4JMY/WkBa82c5bvriYEkNeBVf5ruiyDG1odI5mi+oiIpd/vsm+sHcJ1puPa
         4rLXO7ObSnrZ+eRGxwJPRh4OMM713LYKBeq/sKVndTHkYRQEDEpgT6knnQb5B6x/f0f2
         rNZlH7w2T6C9190CZp+q5YgrJy+5MzqIS+ovB2kbprht3vDq6AT++F2him/J59xM0NNr
         nXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790238600; x=1790843400;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ffoYufaDSfVatt78XpLjVJHKG1hzTad9qkMPdMcjBFs=;
        b=zz1/eGeAgWU+FLTcgiUCq1aWSZQXcegGBFJ7/JFIteJVYLTqPwXsY1HU2KfW075zgW
         60mhcjjk+K1LVIWJPunoWVHQduddwLEzdw8N2OBinHyDM0gHc7k3FOmK/ipDk6EdbvFY
         WGptQfxVfz2NaHE2F2tIc2c0eSoAuhc3ZlCgxIcD4/uivoprmlMab4Hu55RFqW/fsocc
         G9x86XL7Z1wZWMlkpsEs+3O2TwnkQJPHDKtCbFyTC/9gARLhha/rGQdikoG3/iJoAgLA
         pa4xh/ciJ7bn6TK/v4/BmULY3LwUX0esSyxIC90HD3t2klSEFoK6KVY8Ib90VuvgpyUx
         5qsA==
X-Forwarded-Encrypted: i=1; AKwUvBxf6kklXSj5ToZmJFHG+X9Rw/FaVhb7sWzQ7gKv96LlYiu83qycpBjJCikXiFgYcTA4pfFmCts=@vger.kernel.org
X-Gm-Message-State: AFuF++me3dXLM7SecuSQzRmnQQBdh68B32SW71jC/DcI5HKbatTmVyvK
	Q016lNwooXbosnH0DPekxh1kA4SNEDnMraLRk9FrgPB7UhK3tUxyygIFjms+5FLtt/P+IRFoZ3V
	rhp+2s6ChxVEj0g==
X-Received: from qkjc10.prod.google.com ([2002:a05:620a:cea:b0:93c:2ec8:502c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:6193:b0:93a:7bc2:d75f with SMTP id af79cd13be357-93c364136b4mr175092385a.36.1790238599921;
 Thu, 24 Sep 2026 01:29:59 -0700 (PDT)
Date: Thu, 24 Sep 2026 08:29:51 +0000
In-Reply-To: <20260924082951.1599377-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924082951.1599377-1-edumazet@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924082951.1599377-5-edumazet@google.com>
Subject: [PATCH v2 net 4/4] vlan: ensure sufficient headroom in vlan_dev_hard_header()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, edumazet@kernel.org, 
	Eric Dumazet <edumazet@google.com>, Zixuan Chai <petalzu987@gmail.com>, 
	Hangbin Liu <liuhangbin@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Callers that only reserve ETH_HLEN or less (such as llc_alloc_frame()),
or skbs allocated before dynamic device/headroom changes (e.g. toggling
VLAN_FLAG_REORDER_HDR or bonding/team switching slaves), can reach
vlan_dev_hard_header() with insufficient headroom and trigger
skb_under_panic().

Use skb_cow_head() in vlan_dev_hard_header() when VLAN_FLAG_REORDER_HDR
is not set to ensure sufficient headroom for the VLAN header(s) and the
underlying device hard header.

Use READ_ONCE() to read dev->hard_header_len and dev->needed_headroom as
they can be updated concurrently under RTNL (e.g. in
vlan_transfer_features()) while vlan_dev_hard_header() runs locklessly on
the transmit path. Also avoid LL_RESERVED_SPACE(dev) here so that the
extra HH_DATA_MOD alignment padding does not trigger unnecessary
pskb_expand_head() reallocations on inner stacked VLAN devices after the
outer VLAN header has been pushed.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Zixuan Chai <petalzu987@gmail.com>
Closes: https://lore.kernel.org/netdev/cover.1789987105.git.petalzu987@gmail.com/
Link: https://lore.kernel.org/netdev/179022851638.2160803.1808206741379444999@kernel.org/
Cc: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/8021q/vlan_dev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 2859cbac3f266b7c4e3f44f41280d33ab69c5270..c949c6a829456c2f75d6c514b35a85ff64c493d8 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -55,6 +55,11 @@ static int vlan_dev_hard_header(struct sk_buff *skb, struct net_device *dev,
 	int rc;
 
 	if (!(vlan->flags & VLAN_FLAG_REORDER_HDR)) {
+		unsigned int hlen = READ_ONCE(dev->hard_header_len) +
+				    READ_ONCE(dev->needed_headroom);
+
+		if (skb_cow_head(skb, hlen) < 0)
+			return -ENOMEM;
 		vhdr = skb_push(skb, VLAN_HLEN);
 
 		vlan_tci = vlan->vlan_id;
-- 
2.56.0.rc1.310.g51773c2048-goog

