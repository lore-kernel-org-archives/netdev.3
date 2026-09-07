Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4A74483A8
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 09:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773522; cv=none; b=MueWvMdoSBIO1L8g27G4zrbQZyqXGWh22bRtEAS+S90EXpzykZoNERJYeZpZYFMroggZeHp/yPM+kpzpcQI+OhOLKqTK1mg6QQlhL/JGM0Y70TQyodyXlTB6iRNblWxqjAPyogYTfkRiwrY5fB9H42pDamVHoAP8MNZRsdBoFNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773522; c=relaxed/simple;
	bh=LdLKqC7dAURPLybTCRhczbmIb+fvHo2IE0tsoVIELjs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OBE6x1yHSPHtb9QKYd8APCXY/I9X0anpHBvyKdn5CPDfD1SDG/XC/JK1UNUpVgWwwwTqJHygOERaJ3BRTY1yeCP+TPjK9Vk0rfwSs5NPzZq5SXUx31cOpWbTEDQI2d0MSryKmwXy6lWMrHUjA2twvZys1po5DL3Ac3/y9hkav6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Rx7xP8xY; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Rx7xP8xY"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 78880201D5;
	Mon,  7 Sep 2026 11:31:57 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MMFgqljS6HKT; Mon,  7 Sep 2026 11:31:56 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id C714E20704;
	Mon,  7 Sep 2026 11:31:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com C714E20704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1788773516;
	bh=X0nLmZgAUWhCxjgnwBI99b86423YMzwquppoEGrMZHo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=Rx7xP8xYps8FZga8ABbkjj7/hD28FDiKOG6vX/57nUrZlvyzCv2GOvkxRuJUI8Sir
	 93z20UjYD++XK7zITwyAkOwtohNoMIsB3iLHvZQLG0NFSuglaJdc067yxAU1V3gKxS
	 k0+kKLQX9fHgfs6a8oR9LfWemJSnyBMQgo9TVtqKPk5oPoKBfRt6rZHlI08tnarwtt
	 5soI+182WWMxAM2H1Qr8J4wheqB5YNHOemoI7POx/SWFkifQLNL0KOaCbgT2gnNF4b
	 gDEmIPweZKoZi3EBNlCJFmWUXAt1nYPOAM9Sn7bM5P03zco45G8VQuFu6+NMZOvTKh
	 iQEWQc1hOeOog==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 7 Sep
 2026 11:31:55 +0200
Received: (nullmailer pid 2228802 invoked by uid 1000);
	Mon, 07 Sep 2026 09:30:24 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 01/12] xfrm: iptfs: fix stack OOB read in iptfs_skb_reset_frag_walk()
Date: Mon, 7 Sep 2026 11:29:44 +0200
Message-ID: <20260907093020.2228346-2-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907093020.2228346-1-steffen.klassert@secunet.com>
References: <20260907093020.2228346-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

From: Roshan Kumar <roshaen09@gmail.com>

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
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_iptfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 597aedeac26e..2ce15c472cc4 100644
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

