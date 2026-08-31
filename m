Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97FD3C1998
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 04:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788151087; cv=none; b=QOymrA+GDh9Luo20+rbxVizgmJy/hTilMZvgS/OZBHOZKmEg1g9LMqyiFOnQO7DxZTFbk4UsLQ4OYW//w6Ved9BXv+QsF+mbhhfSRvmCQBDAhVJKio4p7mDpbITtmSmKSvYGdLyAtRegZv8hUO9wQ5WjdndPrcvNlxRhvpdUlCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788151087; c=relaxed/simple;
	bh=TSPukoHwuGOtlLSCKsfDe7vaSQqehsHcKRp+PP2zfx8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bKvdnK6D6bspskUkNMMcmxq1k+G8KxikFDQDQibAF1sADLzxmf/tsEVUVmSwgd6wJO0ib3wVbZU7eghD6sBUCbzk9RG//3IRxrijku0YZGR2xeYoQhtv9ekkHtdIdmAuXRnPXF7KjozwRRBsj1M4C7agPuVjMpR1VOTSUxzoqjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aq9BLN8k; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aq9BLN8k"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-482e5733a5aso1750015f8f.0
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 21:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788151084; x=1788755884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TGoBedQqRgsKG7wNi45We7BTQ5QQ5aS5jrqdXZyohA0=;
        b=Aq9BLN8k6bsE4sId3E2D0ABNkFXHZiC3HNXKofNT33evMqYLykTK9GFxD2WCWiI2PB
         MHnFmKFT0nIEvxN0kRpImutCmbe8kT9D8wz9uhCUlcwpan0jhcV2LZ7MlbTcB65FLtRt
         vTDA50OwF8Fr7kVXBFAq3Tj8ivdRTENez2zX2YmCF61vg8gwKj23S8Iquvz8PwFZNu77
         A6HoJ/53Krzhi1E9rZVBuDk4IynVtTdWpJaDn8QtB3ymLxzfFZ3dzfkOBx5nnjnEzURk
         Pgkg0MsLA/Cijt1vCz8cvNFdYBf/xSSw76/flw02sS8zEFvlDNC0WCBxgnuHJmhSUxnz
         zQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788151084; x=1788755884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TGoBedQqRgsKG7wNi45We7BTQ5QQ5aS5jrqdXZyohA0=;
        b=RpzQpXQCc0P1Cp54RHHIyn+6LSK3tgj06HSaKF2mhhgAdwJ8/fEkVEjuFck/nApF4f
         p7s/Hfwob1GQYvubwp0JiUHOs2PKZpviPQnFwQynYLjZpZAefigh3lbi0i18nA+08Mfc
         4OkEAVjZ+AyNBK9uCYKeEg1Ml+TRwj5h4Duw+XY6Alk+IOLlGHaiwdK3CJNEPtjLtpkw
         wxCUv0ZQzEkZ0Jt9UL4Ufk0pYNyE6tuyynAhdVu9BFNr6i3Mpd3C5SCVCa5M6FxbC4hM
         /ICJfeivxIET4ihTYk8H/wxPzZBKAEQxhSZdKGvH69OnJ7DIFvCI+Pja1Ksbjed5AX2c
         1/SQ==
X-Forwarded-Encrypted: i=1; AHgh+RrkMXO0OoWqJfBGDMVWu4vJot3RVIKfcmAW6hDfR/7ZHpiyW4vnr3aq8erjiJe7miimCwvnMhs=@vger.kernel.org
X-Gm-Message-State: AFuF++nM0TYJRMv6/PEX9eBlQJXOkmdy+q3/3e+41y79+Tcs/gm2tC0o
	giF6Z9YA3BTDFQ2aSZvqwMMz9K3x8vdpo4vjOalaJ6CT+lYUJjmnGyQb
X-Gm-Gg: AR+sD10raDyBL1NtMpfozI5xoAnYwKRHLur4hQZEUjFc9bBv31PVPBiAeCNW7HSWx5a
	27iigJ9AtcsVaSuRprolbhmWlek7ohoox+rO3QbwbawHvh0RvoiPOAX3hQuWam64VG51XtNiNYP
	EzIWuMqEVrxOdTXnUeqywxux8Mvmu8g1saLjZ/ezTH7mmp6lKxLL9Hgc0HrRx922GRC61hijtU9
	ITzGRddYyUC1RnBGnGmN3PYaX7PufJEFPyY1CY52PoSCOx15IYkS/CsTRpaYdJg86dew6kT76l8
	bKPwvrNlg6H0/z6Np0IVR2xYGTjnY9sIeG03K1qkUKwG6wtpgj0KizCrVXduNLTDKOI+SB0V4d+
	25YffhJnhvp2TUINWA+r0tSkY1LUtuKgAp09rqtkRqkpQhu5yp9DuQZq5UJ/xhttHZZvEUpDCdK
	vwErX8WxaJokV2PgCNpdNH35+gQqx22HtNcBLzPAKnYc3In1ZcGcEhKnaydWnumYCZof8BplGr8
	0Evz25kFCRPRXTcMCxqGBF7lXnGNVVc1VEE6g5S9lzauqBe9QRj81oCNmTpWvLycPpTIWRU5IbG
	78/A2aP9JecLuoa13EHnQ8N0j7s76I5LYMYeY47jRm0tqLXKiM52IP5WQ5uD83ib2Q==
X-Received: by 2002:a05:600c:1c29:b0:499:b65d:1250 with SMTP id 5b1f17b1804b1-49cd940c70emr9007825e9.2.1788151083769;
        Sun, 30 Aug 2026 21:38:03 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-acb9-0201-68d0-34d2-ad1a-175a.310.pool.telefonica.de. [2a02:3100:acb9:201:68d0:34d2:ad1a:175a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cd775dae8sm79057735e9.9.2026.08.30.21.38.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 30 Aug 2026 21:38:02 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bin Lan <lanbincn@139.com>,
	XiaoHua Wang <561399680@139.com>,
	Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH 6.1.y 6.6.y] netfilter: nft_set_pipapo: account mapping table allocation
Date: Mon, 31 Aug 2026 06:37:55 +0200
Message-Id: <20260831043755.29692-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 69e687cea79fc99a17dfb0116c8644b9391b915e ]

The pipapo set backend data structure is one of the ruleset objects
that upstream changed to use GFP_KERNEL_ACCOUNT for memory accounting.

The 6.1.y and 6.6.y adaptations changed the other pipapo allocations,
but omitted the mapping table allocation in pipapo_realloc_mt() because
that helper does not exist in these branches.  The equivalent allocation
is in pipapo_resize() and still uses GFP_KERNEL, so the persistent mapping
table is not charged to the allocating memory cgroup.

Update this allocation to use GFP_KERNEL_ACCOUNT.

Fixes: a0bb39980635 ("netfilter: nf_tables: missing objects with no memcg accounting")
Fixes: 1c4f72fa9699 ("netfilter: nf_tables: missing objects with no memcg accounting")
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
This patch is based on 6.6.155 and applies unchanged to the tested 6.1.y
tip.  The test configurations and full serial logs are retained in the
audit dossier.

A/B tests with a 32,768-element two-field concatenation set left two
262,144-byte mapping tables.  The fixed kernels charged approximately
512 KiB more kernel memory to the child cgroup:
  6.1.186: +524,288 bytes
  6.6.155: +516,096 bytes

The two-page difference on 6.6.y is within memory.stat measurement
variation.  Ruleset loading and element lookup succeeded before and after
the change on both branches.

Tested on:
  6.1.y d64a499eea6b62b5121beceed9e8a1f57b00d863 (Linux 6.1.186)
  6.6.y a4a971135a2ff64382ae4235b3ae60503bb1036a (Linux 6.6.155)

 net/netfilter/nft_set_pipapo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 7c8d28a031ad5..8ba76eea3eb18 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -705,7 +705,7 @@ static int pipapo_resize(struct nft_pipapo_field *f, int old_rules, int rules)
 		return -ENOMEM;
 	}
 
-	new_mt = kvmalloc(rules * sizeof(*new_mt), GFP_KERNEL);
+	new_mt = kvmalloc(rules * sizeof(*new_mt), GFP_KERNEL_ACCOUNT);
 	if (!new_mt) {
 		kvfree(new_lt);
 		return -ENOMEM;
-- 
2.39.5 (Apple Git-154)
