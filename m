Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76CE4EDCC3
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 16:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791563211; cv=none; b=ikuRlf7dO8TV/iBrnWpQpYPJlJV+BadM7knmmj8dkpyaHkQ+Pr/wzglC6XJoWUxgt30GuUB+eKI1GT4NuKXcL/chrDzQX94bRhjQUEPnPXUrJcyUTpEzE+brOIcqgsBrLMAMM/1vUoB4Xp+o9MZWKRQGwNRppBIQnbdo92Zd84c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791563211; c=relaxed/simple;
	bh=z8LVxDwXNisEDg9XRjD9l5cNR4q4YDySjviXXc/lnQE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A8XP52JRNX1S9oVZsNeQ7I7anGvvl/ZNv9R9TaGYcMGPY+VZnoOaDzwd+wBm6K5HMfZtKjqNi53mgSZP+VHe0YPYshmhegPhwLk20j5Q8uzPE0uhcZyg9QNey6dEaS2Z0MpDmJn98vPXqEDtyBMeFgOZrkOIfkSiIKn71r1//go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxiKyY09; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxiKyY09"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-487048857f6so3902875f8f.3
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 09:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791563189; x=1792167989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ckizy139Yx68MapGfbyuMco76+jqL/TiZ1vLBTM9150=;
        b=bxiKyY09W2A5BA9exft9roeyERw+dW5dIIhz81IwB+W3asI0+rhE80y37a4gw3SpcQ
         ENdSmJ4aM6PA9AwXtxvBE+FoBn+vayBhGDg1J8XKNMt7meK3sogD3RbQf2pVPH3bkHcq
         qoVl3vzsoYgwXRnBgC1sB3eiyqfwd6qlWo6g5WdwnniZt+jW6qGqj66zJS1OA7pi8Ove
         nE5HR/eqwh7U+6lkHjWddTvWDumdoOOsRlH7Ozmch87f+T2/tBAzRRm0jB54zRm02jwE
         j5c1Tnt04BHiDOdQJRSrjXL84+Mtu+/4/fmh2jZdU26Gbnc3DCA3VDp2J/WOj9FrLxNT
         /tPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791563189; x=1792167989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ckizy139Yx68MapGfbyuMco76+jqL/TiZ1vLBTM9150=;
        b=x99/HuDFOgFULN7Mtqb+/phOgM74dTmaLRM0oetHGunCmCP0f8OJuinKnGleIiD05Z
         FUk2qVZGcgy7REiTziXpOFnByh4d1vVIcvKFFMMcc0UrkDM/5XQDv7BgBnXaELF6RerU
         6QnO6xS8WvgAwhXRzshcAmHAlms2ffMmqbMOIRlgrMTjB1y1SZeN16NV7fmruPyQKmkb
         WMM+ztbeiMehaJjbKYpZkQWy1IT0dENOiYoq0E9SbAD22sfEIeaZkw6E276dyjGf3DdT
         pvP7SjJpAU9VJhqaLqTUr21eqAYB8fJPRqbYDmzZMQJVHr5IdyzxN0fkc5OSfb4vtd3G
         0ndA==
X-Forwarded-Encrypted: i=1; AKwUvByzcebbouGYdvnzkISfpBWnbgM8hetYPwfVPkr3vKVuaF2UP3AGKPcutsXFm9dx3dsDqFTkUuk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJm8kATNq9o2TNe/1GdzoaDQe+ijX5zyqijN/kRhryPa5ex5Eht
	GrnycMaO9gesycNThVDz86BZXCKDTJqIe9AEnZerKvutUUkuzonq1YSl
X-Gm-Gg: AYBFou2/163GfvImygRZkABLGkacthTgAhjB/gugFtUuRCXUpmR+8B8h+7tKR70743v
	R5zPOPDTbCPGOVxH/h3rpnDCKlMAGhHD6Jln8JWp7hZ3SDBGIX1WCtzprmkvJ+XiiGX/UzSbV0Y
	8SUXlnwuJvQcsoryTuRfd5488CdLBVd9VUiFT9W+bh8O5fCXhXaVm/UzD46r6Z/nEBI0fqrAHji
	JNxKFjBLgEDWkzZ4DNxlw86HyTxChZUf0rGF1tV9sW+2eefqQRQWZRY2+Ci8V6ZXMRuFLI6PyQ9
	Z4Cv8chaDBHLzF3ZfdSfY8R+AvQyeopbviSrbHF/XcXO3F6DW1cqd0UPLBqPMBnViWcOQd0AsoK
	tRuMJOWPCxn7OQdDXWYIU5RseB0nkbURWbF+g1bYb5WOjoQ2Oj3SMcl+p+31VU+g8vzkELCQxA9
	05sFexTyUWkqr5yNj5Rdj30rjLkWR/5R0zlDYSauBLG6yNeUSFKYVV3MKod7Q7DteXgKcYoqdWC
	Hg6hJwZ1BDjYRKZ0kdLef0pPpbuWnU9m/JY3bck3gEUc/Ol6TLKRkm4AtquZYhR5AU=
X-Received: by 2002:a05:6000:46db:b0:48b:e50:7152 with SMTP id ffacd0b85a97d-48dbaae21dcmr3251605f8f.28.1791563188334;
        Fri, 09 Oct 2026 09:26:28 -0700 (PDT)
Received: from Raghu007.. (sgyl-44-b2-v4wan-174108-cust110.vm6.cable.virginm.net. [80.1.81.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9abdaa5sm4745750f8f.35.2026.10.09.09.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:26:27 -0700 (PDT)
From: Palla Raghunath <raghunathpalla.0209@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	raghunathpalla.0209@gmail.com,
	syzbot+5a8667f002726fc59f88@syzkaller.appspotmail.com
Subject: [PATCH nf v2] netfilter: synproxy: check TCP header before verifying checksum
Date: Fri,  9 Oct 2026 17:26:24 +0100
Message-Id: <20261009162624.16294-1-raghunathpalla.0209@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

synproxy_tg6() calls nf_ip6_checksum() with par->thoff before it checks
that there is actually a TCP header at that offset.

par->thoff comes from ipv6_find_hdr(), which ip6_packet_match() calls
with target -1. ipv6_find_hdr() only makes sure the first two bytes of
each extension header are in the skb. It then adds the header's declared
length to the offset and stops at the first non-extension header, so the
offset it returns can be past the end of the packet. For a CHECKSUM_NONE
skb, nf_ip6_checksum() then calls skb_checksum(skb, 0, thoff, 0), and if
thoff is bigger than skb->len we hit the BUG_ON(len) in skb_checksum():

  kernel BUG at net/core/skbuff.c:3606!
  RIP: 0010:skb_checksum+0x8b2/0x8c0
  Call Trace:
   nf_ip6_checksum+0x1bd/0x320 net/netfilter/utils.c:89
   synproxy_tg6+0x1a4/0x6e0 net/ipv6/netfilter/ip6t_SYNPROXY.c:21
   ip6t_do_table+0xd37/0x15b0 net/ipv6/netfilter/ip6_tables.c:366
   ...

syzbot's reproducer sends a 60-byte packet with an AH header followed by
two hop-by-hop headers. The second hop-by-hop header says the next header
is TCP and has hdrlen 167, which gives a thoff of 1400.

nft_synproxy_do_eval() has the same ordering: it calls nf_checksum()
before it fetches the TCP header.

In both places, get the TCP header with skb_header_pointer() first and
only then verify the checksum, the same way nf_reject_ip6_tcphdr_get()
does it. Packets that don't have a full TCP header at thoff are now
dropped before we try to checksum them.

Fixes: 4ad362282cb4 ("netfilter: add IPv6 SYNPROXY target")
Fixes: a311a8981727 ("netfilter: nft_synproxy: use the family-aware checksum helper")
Reported-by: syzbot+5a8667f002726fc59f88@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5a8667f002726fc59f88
Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
Signed-off-by: Palla Raghunath <raghunathpalla.0209@gmail.com>
---
Thanks Fernando for the review, and for spotting the nft_synproxy case
and giving me the chance to fix it in this patch as well.

v2:
- Also fix nft_synproxy_do_eval() and add its Fixes: tag, as Fernando
  suggested
- Drop the comment in synproxy_tg6()
- Add Fernando's Reviewed-by
- Rebase on v7.3-rc7

Testing: I ran syzbot's reproducer on v7.3-rc7 with this patch applied
and ee319bd3a0e9 ("ipv6: do not let ipv6_find_hdr() return an offset
past the packet end") reverted, since that commit already stops the bad
offset from reaching the target on current trees. The BUG doesn't fire
any more. The nft_synproxy change is only build-tested so far; I haven't
managed to get a packet through an nft synproxy rule with the bad offset
yet.

v1: https://lore.kernel.org/all/20260926204519.43402-1-raghunathpalla.0209@gmail.com/

 net/ipv6/netfilter/ip6t_SYNPROXY.c |  6 +++---
 net/netfilter/nft_synproxy.c       | 12 ++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/ipv6/netfilter/ip6t_SYNPROXY.c b/net/ipv6/netfilter/ip6t_SYNPROXY.c
index d51d0c3e5fe9..b3aa4fe67589 100644
--- a/net/ipv6/netfilter/ip6t_SYNPROXY.c
+++ b/net/ipv6/netfilter/ip6t_SYNPROXY.c
@@ -18,13 +18,13 @@ synproxy_tg6(struct sk_buff *skb, const struct xt_action_param *par)
 	struct synproxy_options opts = {};
 	struct tcphdr *th, _th;
 
-	if (nf_ip6_checksum(skb, xt_hooknum(par), par->thoff, IPPROTO_TCP))
-		return NF_DROP;
-
 	th = skb_header_pointer(skb, par->thoff, sizeof(_th), &_th);
 	if (th == NULL)
 		return NF_DROP;
 
+	if (nf_ip6_checksum(skb, xt_hooknum(par), par->thoff, IPPROTO_TCP))
+		return NF_DROP;
+
 	if (!synproxy_parse_options(skb, par->thoff, th, &opts))
 		return NF_DROP;
 
diff --git a/net/netfilter/nft_synproxy.c b/net/netfilter/nft_synproxy.c
index 554a96a000f4..6b290a89886d 100644
--- a/net/netfilter/nft_synproxy.c
+++ b/net/netfilter/nft_synproxy.c
@@ -118,12 +118,6 @@ static void nft_synproxy_do_eval(const struct nft_synproxy *priv,
 		return;
 	}
 
-	if (nf_checksum(skb, nft_hook(pkt), thoff, IPPROTO_TCP,
-			nft_pf(pkt))) {
-		regs->verdict.code = NF_DROP;
-		return;
-	}
-
 	tcp = skb_header_pointer(skb, thoff,
 				 sizeof(struct tcphdr),
 				 &_tcph);
@@ -132,6 +126,12 @@ static void nft_synproxy_do_eval(const struct nft_synproxy *priv,
 		return;
 	}
 
+	if (nf_checksum(skb, nft_hook(pkt), thoff, IPPROTO_TCP,
+			nft_pf(pkt))) {
+		regs->verdict.code = NF_DROP;
+		return;
+	}
+
 	if (!synproxy_parse_options(skb, thoff, tcp, &opts)) {
 		regs->verdict.code = NF_DROP;
 		return;
-- 
2.34.1

