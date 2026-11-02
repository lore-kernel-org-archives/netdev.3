Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793579834;
	b=Z7sSY4bFWpg5FeyfCed8LrF+wzyTS0gMRWFr9qF56IVDJUlXQ0NYEn93CGRKJ/YGNaX2
	 847GVAlqzmYzhXwRlelsfWiUf36i6PhlJ41EbuKGMEKLWSRmv+ReVydqUn2Vtd0jsCao5
	 Wf4cdDMV5YrKpK5RJTsMUozm8z/P5xsYibp6vWY51En/786pauTHmiRJoTe5XVJNDyiAW
	 rzVhjQ4mljSiQcZ++FmEVklK2dgZLwqIsGfDtfNs2Hp4iukI79VU+x+T2PWmFiCx91ffh
	 dQBfnoJS+8N6+Zrkw7OBpvJFQyuYzVk1aJCi7+emR6A+2Gr2Ox2gJ776OsSHCHCuFVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793579834;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6KogHPxXZesrjjVkrlJVMb4Eo3ELPLnD2xsloqw8RZM=;
	b=PWc3jjdFgWAySjOtbamm6iW7nA92jeedYW1tmKCHuJdDHqICojqn+DSdVC5HSbdCofOD
	 YeK1RrRnKD6Pfz5BxExaNaxTQoR07KfxchG/S497pGdrgx2PteiSQi0sJabkVcatkED79
	 WJBNlhT0+8MRtue/W3NZuNIhw52uf0mWmnvLtiOur/E0zn1LeZtNImAD2pleTJW8OTMZh
	 ikxFKGo2g4gyB0pLACWm1ElsNLQArJ6rdbGWjOqbqr2WyWu4GXiUAiLPSwcE3UEtrR2rn
	 /kZl1MlCCwuvxfNRySyDcDQXyE7+fSpVIBU9qzLdS7Oj00f7E6x+ElP5p/9l/2ddCrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=cqlHdd19;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BB3606A334
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 00:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6BB3606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=cqlHdd19
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91c79a9a739so40194146d6.1
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 16:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793579833; x=1794184633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6KogHPxXZesrjjVkrlJVMb4Eo3ELPLnD2xsloqw8RZM=;
        b=cqlHdd19IIRGaf3lGxatlIyX1riEouhuFUnPqZYVXG0a3svGrr34ocv1h19tWrNIUB
         myfwN4CY1vhyAkJMLVP13CyAvDx/iAxE8Nu15187ANtPU8WMcOaXhCetV7yvbsoUbuBQ
         YH6svszhVEibUdivohKdUBiPgMInmoAupe6XQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793579833; x=1794184633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6KogHPxXZesrjjVkrlJVMb4Eo3ELPLnD2xsloqw8RZM=;
        b=nebnOIGDQpk2jVoownqdfQyMed9pqDVuucdUUzAhxYzh+BBGhl7sm4A2J1g0t8fzZ9
         2AIWGhVka0seMa52z/yW3ofUtT5ghvdzYHYEHBBHU4iHzRRHSHcBjod1xySJp7n6NT8X
         FjYe8SjCs9YICo9fq3NXevMphsbyoh5qB4abZxGIFPIhCifx/lGPM/zZ3wPKI4S97GJt
         TGEypso7jXbnr5X4xfLzsSExSrZFZ82QcQU9F0Z741nNl1hfC5xJqfDM3FKGJugiGTJh
         G1GHNUu48JmBdWooKlZY/RpcLvTewSKVa5By2Jgvv9hzoWFw0JjhhfTnBQBuoEJY0oW3
         GcvA==
X-Gm-Message-State: APuU4Z/FNFIZejiCFLJPyqCoWfsFTtf+O//KTWHWJ/39143y623xMPFd
	eJ8HWdIEUxrt2uHCdpqVTG1Klh+PH951XqrjdKQ4jwk//eWLHoHg7kmgxwEi6LFGh7UuBadHtZj
	0cZg=
X-Gm-Gg: AYBFou2OiA4TcCQ0kkDzZAQoiS4I7zVfUXNN2l5jIfHN7Ir+/eiv7NnwIJJ3xu/i4W8
	etdREiRklRnGXQZzEjjhOTJ7d7SwV3ACp41a8aTNFwgs9PzTE3hY4xjn5zkWDwtWMTapRbcHfTb
	bxRO2Y5iSXhdyU7GWHq1C+WA2OI8VCMKtYMgeFt+jrLC4MEAI6JKGaTZt2JzC8fVHd7vx0trPPC
	t4SxZ5HaH6hdxPLnELB7s3nKvWZrLNIbCsfKahP79RPlUkdOt8ugKHN9oJL9x6jTCPQQBJJb+Oi
	HNJWVbkf7OLD0XdiwzZmmk8ivj3YmaQzas501E2pTLmApshz60g84Cr7zuQRBNrzr44uBSKZJM8
	+AhBWyILaRZcElaJkCcvgan+ffruTMu8Y7Tlgu2vMwNC7FblnMhASV84/0tNqo7iX7rBivfXcDP
	bxL3ecAvgRMDhS9KmbnF7Pcx/F7Ys6GUhhbTGTKL4/2SwHqKkBC9DvKIAv0SUsHVbxMxBsgnRU1
	aM/N+HQnuLQjky1lJ6ySvY8pzv9bfm70yvGlkKz1+xZEIRAVH5iTFmElcqFt9+PoLIuNt/6npLm
	1TkGkarFLDRmEtFKiTJmJye1eO9tFj9OfumoAS7RJvqcDIQklTueftuSbIBjNAjIG1pnJqSFWYl
	dP7OQXxS4FBNj9++rQoywo0mBPepZZmlZy06Y
X-Received: by 2002:a05:6214:3993:b0:91c:7786:dd4 with SMTP id 6a1803df08f44-91ca4ae17f8mr151929446d6.11.1793579832593;
        Sun, 01 Nov 2026 16:37:12 -0800 (PST)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7f23754sm77043066d6.9.2026.11.01.16.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 16:37:12 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	shaos <shawnq1@163.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Tom Goff <thomas.goff@boeing.com>
Subject: [PATCH net v2 1/4] net/sched: act_ife: encode configured zero metadata values
Date: Sun,  1 Nov 2026 19:37:03 -0500
Message-Id: <SER-NSBD.v2.r0.20261101171325-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <SER-NSBD.v2.r0.20261101171325@mojatatu.com>
References: <SER-NSBD.v2.r0.20261101171325@mojatatu.com>
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

