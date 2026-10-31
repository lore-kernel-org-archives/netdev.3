Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793477906;
	b=UC7ccIYzBdwC3EXQnAVszlk+ajHxISFi2ElF/19WNPNolFIcgcfwK4Ew0BHnulyJ2LWf
	 RuLAeEpHCoj5MFfN104APETWme60foqOe4MO3QUEIyWk6IhiE9RrLy6EgeWvRjiGzIpdx
	 xaVO2LyAyBgg451J8/MV3A7SsCzhMDZcWrKKL6v7+DcJRxD2jl3UuDJcxepXGEtO/eWXs
	 89MCpjgkwy1ePVFQM7NFfRIYOVCb17dBMoLvRzPtBhyPPMJQnCABkW3q2oszw4BoZ7K2c
	 1Cw+hFllYNEzp/2xAktcCmjDBpNHUB6f6UtEkHEh5cS0Ts4AOS3LGfMeU2PmXwXvH1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793477906;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3iWVot0KlE9fmub2PT5UvYmJQE3iIWxESCHZEC+AAUE=;
	b=A+AMgb7SM2cDYtJPIKsJkTHSKIr017aviindJDkSlDfgSlCponz2Lc8nFaPDc8yZAz4Z
	 pJlp9gq8NdAHhEjOz5zFyqxPwMrCQo3Bym85XOfRxU/kyXfovVmR2Mo3vi4JbfeX9uz8Q
	 rq4l/Wu3p56NtHWt+DWmL0w3DTVEYpN1D+uLI9X8A+2D+AvcBYOC4m/WeNtp1HYCsM8zA
	 EG1oU01SHT4+NjxQTPRPG9x1TWFVzKnbaqouGh5Xc6O0Q7hedVvkN+5URRq3kY/ml7+eP
	 bQdxG4C4/7bzAOXxD4auXOt8+va61PcbwWDkoEA7fEvb5lFGLGjWKbq8DN2LRX73BEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=UPv7QuWe;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C49F606A31C
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 20:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C49F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=UPv7QuWe
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91b8306b9f8so31620716d6.3
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 13:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793477905; x=1794082705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3iWVot0KlE9fmub2PT5UvYmJQE3iIWxESCHZEC+AAUE=;
        b=UPv7QuWeNJyIW1y8EnKUnceNTlowYWC4Llk0Grj/7BDIs1Xjn7rpsbhbpG5uf/TD5+
         WDMh49hWv+8WFCIIan423zuZ/Eez/F7M6hh2EiigrzVNiVIcVRNDJG7eMyXagC+Qnbu4
         PjpT/Z+5oln1YDgWGQ528HKWJ2hBUgG9ThgjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793477905; x=1794082705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3iWVot0KlE9fmub2PT5UvYmJQE3iIWxESCHZEC+AAUE=;
        b=AJdztnxRgUGAmkhXPgknfFM7dtnjD/31QeGTHx+P+riPEOITAa21aiFu67RiKM46we
         HzBF1KdsTgpWFcSir6WA7YXuCJ1xnGamcmKzOgc/nlDPgxCPhUybOz0ThZeUYgd5rk27
         gKSBlXfHfiqY8D0e8iMZjw1qSbKkRo0kaPAyqPKAsbPluo2wYc/h1OBHa5xKSftZ6vE2
         buckYaD0LimG45jJdqOXHbcWeKJCIOcsRZXSgJsoGsks1LgAmMupfeBLN+W4WJIDQj4E
         h3Cpvs+BxRMz3PL+XBeMtU148OzeoqYnf+goACx1DZFYX/Fcm6YdFswWD8kEaIBRTYrb
         7Vvw==
X-Gm-Message-State: AFq9FYI37huD3e8gRpaijZY50i5VRZ61vOwLK85SPhlG2XqDt97bLWTQ
	pdII/1HPbopkXh6HmNrXT9GpKsdZn5FgNAmqQ5pYJmucPRwAsrSA3fM9m5umoB5cujJGRzpInbQ
	mWmA=
X-Gm-Gg: AYBFou15y1Uvfb6m75efCYnKn5zZWPxnZSrRdjJ7ZhG7BaH2BlkpiNcI12f+uFMbUkx
	gRiXk9Y1I8vhE56LFhZ1Q75h/3V8BknC5J7U+zMJSO8FTnz4oRU2a2VS8fpUJ//ZDujp/uu1zr+
	lnsHjBS8GRV+DTfN+cdBYj7unbJiNANl6+Lsj6Lvtu8ssGEleVUadd4oQhf25MMAF0HUHLorwV3
	8rozLfmoi71h8HrolSSj34PyVXS1WnLO+Tu+Fw6dy2hNihNSdlI26pmuVDYhI2HNhFKUKcJZJh3
	bMjZ7F04UBq5px93nPmHQoDd0BceE9SEaNaXKZTwlqPKHEm72m5l/J0Tdsx0FK27jfV5btWxjoL
	i/P3Q38Ac3T7VW687dLCJX2vfL6irBwt2gOpREQVp1g+IdZI+5qT9sE4LeEquDP/cRDgdMgrfqf
	2kMo31bSv/O6y35e+6jEcyMUiu/zpswEVXpyz/jP7I3LErZid7tCBwsneUryeneonlMIE2ud3HS
	Gkjy5IKlfPoysKzN/SDsgf7lTm2W9ar9HpB2SGXLzM2/UDV8FraVokItJ2xUM8vKXYR9TRjau9y
	kjBD5/UOh6Vh7w6/suc7EA+VsG2jyZr8w3TyKZz5pJiYfEmk/wtSSfnxkhlTAEZKRMUf6Ykhqmw
	UA3XVxbjSIQ9ZSDg=
X-Received: by 2002:a05:6214:240a:b0:91c:450d:8f34 with SMTP id 6a1803df08f44-91ca4bce34emr101975466d6.46.1793477905258;
        Sat, 31 Oct 2026 13:18:25 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7e23441sm49148926d6.4.2026.10.31.13.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 13:18:24 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	shaos <shawnq1@163.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net 1/3 repost2] net/sched: act_ife: encode configured zero metadata values
Date: Sat, 31 Oct 2026 16:18:18 -0400
Message-Id: <SER-NSBD.v1.r2.20261031160050-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <SER-NSBD.v1.r2.20261031160050@mojatatu.com>
References: <SER-NSBD.v1.r2.20261031160050@mojatatu.com>
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

Reported by shaos <shawnq1@163.com> with a reproducer for the 32-bit
case, which was reproduced and verified in our test environment.

The issue:
ife_check_meta_u32() and ife_check_meta_u16() both reserve eight bytes
of metadata for a configured value even when that value is zero, but the
matching encoder returns without calling ife_tlv_meta_encode(). The
encoder therefore writes neither the TLV header nor its value, while the
enclosing IFE length still includes the reserved bytes, exposing stale
skb headroom contents to the peer.

The 32-bit helper has been present since the IFE action was introduced
(v4.6); the 16-bit helper was added with the 16-bit metadata helpers used
by the skbtcindex callback (v4.9). Both defects predate the oldest
supported stable kernel (5.10), so they are fixed together in this patch.
Each hunk keeps its own Fixes: tag for provenance.

The fix:
Encode any configured value, including zero; skip the TLV only when
there is neither a configured nor a runtime value. The runtime fallback
is unchanged.

A raw TCA_IFE_METALST netlink request is needed to express the
configured zero: the IFE_META_SKBMARK attribute carries four zero
payload bytes for the u32 helper, and IFE_META_TCINDEX two zero payload
bytes for the 16-bit helper (not an absent or zero-length attribute).
Stock tc cannot build these requests; "use mark 0x0" emits no mark
attribute and "allow mark" emits a zero-length one.

Conditions to recreate the bug:
CONFIG_NET_ACT_IFE=y, CONFIG_NET_IFE_SKBMARK=y,
CONFIG_NET_IFE_SKBTCINDEX=y, CONFIG_NET_CLS_MATCHALL=y,
CONFIG_NET_SCH_INGRESS=y, CONFIG_USER_NS=y, CONFIG_NET_NS=y,
CONFIG_VETH=y. In a fresh user and network namespace create a veth pair
and attach clsact to the egress side. Install a matchall filter whose
ife encode action carries a zero skb mark (or a zero tcindex) in
TCA_IFE_METALST. Send a frame through the veth and inspect the IFE
metadata in the received frame. The metadata region is eight bytes but
holds neither a valid TLV header nor a value; it exposes prior headroom
contents. Setting the value to a nonzero one does not trigger the leak.
The namespace needs CAP_NET_ADMIN; no additional privilege is required.
With the fix the zero TLVs are 0001000800000000 (u32) and
0005000600000000 (u16).

Fixes: ef6980b6becb ("introduce IFE action")
Fixes: 6a5d58b67e20 ("net sched ife action: add 16 bit helpers")
Reported-by: shaos <shawnq1@163.com>
Link: https://lore.kernel.org/netdev/20261022144739.61342-1-shawnq1@163.com/
Cc: stable@vger.kernel.org
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

---

repost1 -> repost2: rebased onto the current net tip.  The repost1
posting was recalled because 3/3 no longer applied; this patch is
unchanged.
---
 net/sched/act_ife.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 3946a9589bb8..6b23a3965121 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -50,8 +50,7 @@ int ife_encode_meta_u16(u16 metaval, void *skbdata, struct tcf_meta_info *mi)
 		edata = *(u16 *)mi->metaval;
 	else if (metaval)
 		edata = metaval;
-
-	if (!edata) /* will not encode */
+	else
 		return 0;
 
 	edata = htons(edata);
@@ -94,8 +93,7 @@ int ife_encode_meta_u32(u32 metaval, void *skbdata, struct tcf_meta_info *mi)
 		edata = *(u32 *)mi->metaval;
 	else if (metaval)
 		edata = metaval;
-
-	if (!edata) /* will not encode */
+	else
 		return 0;
 
 	edata = htonl(edata);
-- 
2.43.0

