Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793316466;
	b=Hhy0x6hXyG77PZCNgzyU3k6zzDhfCY2o1KGi0PnHJJDGDuE+l79LN9rKq5s/z5UeDwUw
	 4f+cWLBCGIandq0ue3brT73p/GcRBOKD0TvUSqeYBnTqATXR8ziQc1i5qAYxsDd9O85YX
	 Nf5JEfg9jvf7u9oKhjdeFT0ytAT+fp46qwg1A/yPD+aNc4JyIcZJogEzAR+WyeCk6D9Wa
	 Toh4+opUltuCZOWHDFGGBreRI/CeI1F9EIVogphDE1VqYsyRt9jNzRjwu1a63NDy22sre
	 iY7PEWWWxGxl0JKO28uzVNjXPBPaYmHSdzU+CGT99AU2g+fv2ZXyFGfIPlcdkAwAu9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793316466;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AlMMKxFjFmgo4xA9KOQX+hBrUwig6pdgmm/mOHyMOq4=;
	b=nSO9qlLHAdqSUc+W+oYvdL1OUYzk2dkX2l3mV8o3P2BKfpYTLCiQaF3efZKJ1WW2v0D7
	 yseLDQRGvqBi4zBxxbseX4way+CcpKLD9hUyrYjOS7s0Sa9kd/a+axiYOXTDU/XIrqhcI
	 FNSyJWR+tlMUvJU+c8dNH0dKl+vQrER+S18dRgkopEZg4W5wTgQyFIfR1rcnbUedHvLYe
	 /TifCbjIITAaRpgn4JSJMgl6dUT+nzo3caWIBUXydfK1zEpih16Oc+NQ60FqnE7VXKW8X
	 HecdTP7rxkXhvSsbePZTvfuzvX0D1Z7YnqdXAKfPO3ghD8K4PPlYyogNvx/Ja28oIMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Kzyg0Hlj;
	arc=none smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12F7606A326
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 23:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D12F7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Kzyg0Hlj
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-917aca1aee5so1676386d6.2
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 16:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793316465; x=1793921265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AlMMKxFjFmgo4xA9KOQX+hBrUwig6pdgmm/mOHyMOq4=;
        b=Kzyg0Hlj8a8YIkwjP2dUbAFX5M3Ac/IbvOLgmVwBCdqwuxZ6KnSmsGVFIBoxh5Y6hI
         4zFXRfLIifkYMaBU8iyR4lWBpbn11/hrkZ9WssTBJ/fPLDpfHO1GT8kIjAV72/7n2Jfz
         va8YZm1ynVIu4go6+DccVlJwrolgS5nKI/I4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793316465; x=1793921265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AlMMKxFjFmgo4xA9KOQX+hBrUwig6pdgmm/mOHyMOq4=;
        b=hgiT6GC+qcnz67DXQvnFvQ5prhV+KMXSPMgvDLZLTupGCeOH2I1QLjVmijIY1N0CT9
         eR7yne45moZrcglRy0HuFb5reFeX6zpPVR68poBgF1aCe/shE2rufBZhvdMscM9vYDJ5
         lAkuxEfQtlfRXlBAiIPeSKMCJf4oyn9Idn9l1Cws8HyLHHY5ixjcqHDjIPoC/1YG/QE9
         jhFYJmlqT0Io05rZaBOtX5IzO2scBYQkML17gnbnA5pzvOtVLQ0B0wf3zn4xhh25RQ7S
         wvyzyRRtV3dC07vJexVrPdOw/e4swo/PoAiq+6Vcrmln+IzaPN47X63zka9QfBV1p+3x
         eT1w==
X-Gm-Message-State: AFq9FYLrRDNTJCtRLn7cog6lOC8UA6S0YK6MIjtPJuPdrCCmGENF2YD1
	UpoSgay+si63YowI+g0rOfOQ39inw/5J/sUH4OBOhJviPqS7lgqJeyxMGIhnKWn7OWljXyNlYOu
	eoSQ=
X-Gm-Gg: AYBFou2vQaWOUKrGaK59Vcn5g6RMoPBjrZpdujqcSernC/+l4zl7bMZtFjNeVBoASfc
	HYAJfuA+JIVZ4axP2KYT27ZrNug0hB6Q0t+w20jzgO2j6CYNoupR6WTTfNAreFoqwm3aKyiH9+b
	p36SD1PVqH4gSgxDg1MZfU7dp+BzCHYTDIC+PHQTKQ80jCDzRx1yKPeSYPfUzeIBhBFQoKJd4T1
	8vj2JlvSVkd+h7BXhf5VSGG2SIknuoM8bNCHZRCJfsGLvXmsv/zsDEcg5muF9SMbEE/Usnxrqlk
	VeF4bBBwl2g5lAZrWsqfslWLopea4Yh4sLrGM3C7udWeiNKT9KgqdtK2ZBn17Ijb3Hzo3jon1zX
	RGRu3oOqwHrt8qSFcbACT8mFjzvJ4zTzc0d7/66RmL8+j6sS+1HqSguGW14yJfvufwHQjIlTVHn
	pQ0bZ+VmMTh3fc4CsNDCSwC/yf49fb9JUHynEA6H4DO2DQwT6ywNYH4m7j5txayFbI4tdpZSfRM
	DC9YPuH05rpxO/9SCNcFqZTTEJ1z3X5kta3BXQLwLlQO+HmLe0FH59r2LNEYpFY+Sxm1BZOWJAY
	wKSrApa6bNWvsuXJQnWMguW0UMJgc753DIsZVY6rKchLdW1+OchbHdIjC33h3kqqmjqjByG7Vpc
	=
X-Received: by 2002:a05:620a:3190:b0:939:761c:4f59 with SMTP id af79cd13be357-944216f2a8dmr128857985a.16.1793316464807;
        Thu, 29 Oct 2026 16:27:44 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94424243823sm5384385a.21.2026.10.29.16.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 16:27:44 -0700 (PDT)
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
Subject: [PATCH net 1/3] net/sched: act_ife: encode configured zero metadata values
Date: Thu, 29 Oct 2026 19:27:37 -0400
Message-Id: <SER-NSBD.v1.r0.20261029191634-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <SER-NSBD.v1.r0.20261029191634@mojatatu.com>
References: <SER-NSBD.v1.r0.20261029191634@mojatatu.com>
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
 net/sched/act_ife.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 2afd68983ece..0e6aba9aeff1 100644
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

