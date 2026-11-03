Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706639;
	b=y+R4fA31nFabszXtghzaHdqX+d6EMZILC0spLF1VHoumnTlJjsxqkoRM9Z44HW27vLcV
	 wbMcsmxLvifqM1XUmAXI7Q/UXSQKHFDESEsMtQPe4kCi4snoj2qRA5FFWx5c0uCY5Ddpv
	 LovZUZO6xTx28kgtKEOPyepKdo06yQrik4WIsa9xO/oqq2eNFSxqEZnIvXGNrx/Mt6XbC
	 pmIbcT+J5rKb70RKtw0b1Xx7zuGs9EjFUQtHilShgtLmlmnBD/tAkqi73FfRONb5MbpJZ
	 PEeTv9Bhmc/kv6nqS2/FJyGrNXCZCeJ4N825zvp118Ni/V0UyCsm++ecMz52a9KHzmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706639;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EtG9dhFzpk5oF89fAnaxqWyJNRJtWaVCv5iEyMJHtao=;
	b=1hR6LC1OeUlsqpmuPPCr7UPWO0ZdK2Lu4ymhP97DVl1zfB0y1cr6ZkhKWBQEt2byA811
	 Wug9/t4G7YYKl72LP2YvC5mZbAzfGr+J7BIeOABP9wT1z/8xEKhSL7SV22F5reQ7bbQ62
	 SIamdNYREkbCX73tisKumBusb+EjjjiX+55yW4+P99CIH93q7eCohTQA8KSEv2yIT/ppR
	 lwifB9Jv3RXiGiwmbskwGtrOPPRFRK9B1pILXB8vBGouDc4pM4kTSoLSnppbK+KFfrxKd
	 Tg9lXsWEt0XsoY3/DiLjyDd79L5i4viyE6Qd+0mj55lPrUoj7vNxUlM23iL/bFtwb1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=ZhKq0YTO;
	arc=none smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A28606EEAD
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 11:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87A28606EEAD
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=ZhKq0YTO
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b0e21048f8so33789917b3.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 03:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793706638; x=1794311438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EtG9dhFzpk5oF89fAnaxqWyJNRJtWaVCv5iEyMJHtao=;
        b=ZhKq0YTOYst5OXIjfIseOpJStVSCeld+b/HsVmXwh+rBqD+6+31JgkfoIbgHnHeAWI
         8cqUuI1rTyQzjxie2xAf1JZSHnzJBxwzd4P6nJtlXhwS/7MkvTDFdQIrufIqnxZUbinQ
         4qA+jq9YwSRtIpGT++FYdSkViv78oNbb2UvXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793706638; x=1794311438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EtG9dhFzpk5oF89fAnaxqWyJNRJtWaVCv5iEyMJHtao=;
        b=y+co73IZkyPim+trwQ+l8Sq9PJu352Ll/rMv24LqBWuX0bwCa7GZ82FguzxGhUTLtT
         JgeXmaWNPfInOV7BYQjYkAK6lwCOSokaUHfwD10RUDVPG2r8V1h21bNSdUIn1i6/yC3W
         B6YCwukR84AzA3JoiP34sDueoPLDGe5GmidKn0PAFZ/TTCUg1dJT1OKCY3shkmuI7pdh
         VBmkM8Sv5VdZpeD+W9hrqcPjy0CAi8AM7plKqt4Ng8mrTVOBvh0vwtswSnd2QiyBW+Ty
         czTF45iMRBkunjzKZrvpB8y46sw/38lay/eEUvOUOULeaGJyR3xfiDRCWy00nKUQEXf9
         KWyg==
X-Gm-Message-State: APuU4Z877DxUfK7uvlmrsI8mYDhvnA0mIHwFUtuxqd4QU1xNwApLMFop
	M2OdfvPXJmtfkymu6IuVmtMpYeP6u4siqg0WKSI9DAGs+QGp1vUW/iGmP5sDjjVwMsD7+eEUKsk
	kgZU=
X-Gm-Gg: AYBFou09ZKi9ty1FaDQ0s2U7oISxcD0ebe43vSOJ5C3CR6wgJ4pg/1k+N+XIHqJdJ0z
	CtEFNf81nbhXeCS7qL2JQdSaxU7zX6VSnd5fJjqntvI7eJ8F8C0Rkm09vY9X3VuJ4GRUEahBIZE
	KRQ1x39GxuUYxkni1Sb4R/00atWciuELAyjH1cnE8+vaQTcAFySP6Bjjy4xRO385u3DRj06+/py
	MFxFDjL+6ArQpSs55/aNB/Iyqq0MikHwcQD32i6B3Kjw2QTYqbgTP4MOODdbdTM1tfOe8o2XrIV
	/SGFYSh45ro1rp/90rhLI9Gt/5e5lcDaOl36Cg4Dac2vaPfWTIGRtB1BEhVkiCUSnui86kpn7SW
	mBQkraJpze9+vMaQN6xoxtZDSpABCJFGnSruHBT6GIQr5lyqrsTtuF9GKtyyLdcpHV3ISPKC1Bn
	P4W/WqMkDBGo61wc2tihYmMu03FAfD5oPHDKN8nxWKMbDFzHjW5jp2eOjP3kzmaE1ooymGRJeSI
	4YCvyW1gAwnuIWqxEMaWK1fLZ2yVQUwsu8nJ/+E0rL/UJxyG2cGkl2GqFpAoNlYcv0mElpH8DRQ
	skzwchiDPdrwPRe291TGZbFqAMWky+iQetjGoMbtrGZCe/dP6puLvBNoyDssfFh6dMboAdftzSj
	dy2Qq3zpaDgnaR7TOALrRJuUyuyvwgXm5KX55
X-Received: by 2002:a05:690c:e3e1:b0:8b3:573:b2c with SMTP id 00721157ae682-8b305730e42mr197407b3.23.1793706638338;
        Tue, 03 Nov 2026 03:50:38 -0800 (PST)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b704d699sm70016857b3.5.2026.11.03.03.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 03:50:37 -0800 (PST)
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
Subject: [PATCH net v3 1/4] net/sched: act_ife: encode configured zero metadata values
Date: Tue,  3 Nov 2026 06:50:29 -0500
Message-Id: <SER-NSBD.v3.r0.20261103064310-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <SER-NSBD.v3.r0.20261103064310@mojatatu.com>
References: <SER-NSBD.v3.r0.20261103064310@mojatatu.com>
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
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
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

