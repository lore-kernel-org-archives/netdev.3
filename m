Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793475368;
	b=PSQISqn/WZjWqe6yfDu7u8HZatjfiMiVn3Y2IqsfQz9PMYGzDEksljpdXcpgIxic9SaZ
	 ObSaPZzeqGPyCA2RynrKGH3u6l1dA8/g3N2EMABCPCV/ILVj2cjUF7m73rUvfIN3DdJ0+
	 0UphzqaM99qQVypG9Wd8Fut6vdcQx6xFzNDOm1hCLHbLtrXdOBB3LCqoyucA+TjMEyUEo
	 vQa5sOgpyc7a3wpUH/O7xYeAfZa2nbmOE9r6bwKylbB5JW+K3q39LAbCgIDSKVcy7x/h9
	 FByqGqVumAclkB0NToTPjfbWrX85XOtcwhSv1jMPIPIEsGnBj26MABEdeLeIUH1O38w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793475368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AlMMKxFjFmgo4xA9KOQX+hBrUwig6pdgmm/mOHyMOq4=;
	b=N55KSdLZJcocwtwZqijV9viyUzZi6E5WwZ+x6dsTzbgjAVJEfWijEuCFbV2yLUXcaK9E
	 e/gbiRYibhdWm0j4lc6Ms0tCRsXF0ABAt+5co7bEoiAm6D1PMs6Nq8ycydQaDn1453bGV
	 aHjDluTp6VSc/VTNVC1E4zHSgV2P9x/ZsbBux2n4fQwxPFDUIP53FVGXpJ9AAXCaZ4izk
	 C3eZ1bvOyeTuU8Mh4DmNhrnYwWd52BARRuLKDrHABRfgAqoAFyCv6DRNWW4uva28tRDLd
	 c2hBmFtLtXmr41mUPki3XPh3ahmTeoKTNuhUiXU5XWLENyLdObyAhxOMlo3QF420F+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b="d0hQ/Feb";
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49768606A330
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 19:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49768606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=d0hQ/Feb
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93e6eb77f0bso172074385a.3
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 12:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793475367; x=1794080167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AlMMKxFjFmgo4xA9KOQX+hBrUwig6pdgmm/mOHyMOq4=;
        b=d0hQ/Febmr/nIbkqWhqs3plBZGB8DwI12zp+mNMgaeR8/hFG+GhS6Suuuu5hRTDwwh
         jPvXI2Or3et9EJG1vSrW4s5ECw8h5gfYlsDlzcZ1HegSGSfV2/WU4bzgN+LwwrlW0SEu
         F9Nuur6c58FW1j6aXpK0dIKsyo/1IjD025+w0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793475367; x=1794080167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AlMMKxFjFmgo4xA9KOQX+hBrUwig6pdgmm/mOHyMOq4=;
        b=PexeAvMXsY4U0p0yYoWf0hf1hl11S746XTff1zy4LicXuM4Axj12N23Lzoe+gEUjK9
         t9g9DxaTRTmaWjU780XsIlZ9i6A0pqo91RhwD1p+rn8tUKDYRAt8qaE9MvBswoJd3Y9E
         I4iAIs9fveNlBn1t7ABEFioDjReA4kxrlFV80XKpqAifz0xae+lcFeruYfulxtxNgoU6
         pyOc2x2t1drkbgYarkf4svSfjVTrFcGase4Z8y+vHVP58awz8V7rc71maGIqQsUqQGim
         xs2pNw/5fdWXoj3/FTFMaKUg9WZ9Wq0w28D1TJlTiBNQyUlWy2ejm1rhjCBc4oJaiy2m
         w3sQ==
X-Gm-Message-State: AFq9FYKdAdmwsNruLYY98+4mFkMVawmbUzXmCjyd1OPsVPX80Xv7Gv+a
	WeHMk3kD8FavCRBjQaXD821hwjwjqWLM4cQDWOkqNeDsY1kvzD4dLOw14hdOlowI63DVsZMNB8e
	9nnE=
X-Gm-Gg: AYBFou25ORCXajcraP458jcRC+uIv1Q/Pcel8tO0oaRUptSPno35wtJC9kMHuNsiXpr
	d0fswKO7EU0JPZIzK/qUIXwWSsPxFP2DcpxGu9L2Z66YbHMZPaFu5zAfol7Dp9J+Ah8QGilEaC1
	RXQqJMeUFkdjVzLI62ZfSYCdwelWvk/lxHuZnpxHf2KYDUlkCyS10v9ZSHV682+GXCn4QoI8Lm6
	jrjmqeynWtyMrwjllmMD48VIhN2KQmSHzEGzqcbfDG0q9OePcH7Ligz2myvIVwHBYL0Q5DeoN2Z
	cRsCAnplpu5sKvTAytNfM8KHs+VO+oYyn1N+0YdnW1UUuAkcPYJWKnaOE7jLns0uiiw7mvOYWLv
	FaCzgwE4zi/NG2XOkfdllokHmlRpiJuz4/M1vIxeZ0nX5D3DJ7a+MtKp9DGFeMTQ8R6jJSVxfie
	rugLssYUQQzvW1WYeXleo9HeZ8TgM+OYa8nUBEIo8IK2904ohNTmSUFYH+RWk+meXwN7sN4kw5K
	Vec8TLqntPVwuZyrcW7mJGuAB1bWMqg85Ll9hZAaKxXRf3GHzR5QaFFxVtEjPIpc3zb31L16OZo
	m0Vh39mQ3iegz1kDmoO2zZFcZxf65kahtHcUGkc9vRIO5RqdP0VL4zs5rnI7amh0pY62yoPYbuK
	UWiXSbahVApBi83uzh7abVCcI8BysrRhJESC3
X-Received: by 2002:a05:620a:2b89:b0:93f:4d4e:ff6b with SMTP id af79cd13be357-94421585ce2mr951078885a.12.1793475367158;
        Sat, 31 Oct 2026 12:36:07 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425abd317sm446917585a.36.2026.10.31.12.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 12:36:06 -0700 (PDT)
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
Subject: [PATCH net 1/3 repost1] net/sched: act_ife: encode configured zero metadata values
Date: Sat, 31 Oct 2026 15:35:58 -0400
Message-Id: <SER-NSBD.v1.r1.20261030042947-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <SER-NSBD.v1.r1.20261030042947@mojatatu.com>
References: <SER-NSBD.v1.r1.20261030042947@mojatatu.com>
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

