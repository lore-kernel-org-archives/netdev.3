Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792852136;
	b=HespKA0JBSRy5wz78kE7A97lk8Q+6+UXEJl7SE1LCop7yILyGrNP52gLuQUjms52dLdg
	 Hqw9qjxj6KyONdpghjPqxHHq8q3IagBWcvYGbkvb+8PjuUEI09rtIUQawtNf7vZiRqniB
	 bXz7j1DDOGjN9PtK9a58JYFogrSORTpMZdCvEM8+fPD6y+4glCh3oY4o+0Pm/um1qwf2F
	 gNLCRHlWjpRGOvVUy6Zpq7oi0ntfgXuMoXwp9zxn+1M4MIW5+D+O9zqX3bXI4gBiTE5fo
	 FdVkusYWcOwd1m5KeTfWctyc/mzS/+5mARlwPssDX/JrweOXf5LSrnfDnneiYhm3aMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792852136;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Z4o3gUp00unbFHp/dtTEtMrYuS46YAGqlf25OvCWB6I=;
	b=Cc1a3qp2KcFKJNeRQ6GhOUVQwAtcWCzBeWKD/OOZ3C1BQ+8C5goCFk9VH4K3ZKFSXIFN
	 F/4SctnajOaji5PRZ9UqpMD25rOYoXFls2r94LEb82tmEc2Xbh92z1KZAdPdNKIyXWA5P
	 ouuLJJIQ52SMV6FSEAJciVkVZUdI0sA+xV0hdtbPTKrbIOTCI/dxLmkZuoaOPk9hTL6HM
	 3vm5fL5MdF89Z1b8dy4zPx2rj5W7aGpq6OY8CQYF47w0pgNNYW8eoxFFCVojQYQaqIc3L
	 6shCsF6cm8z1LE3n83qcSFQSbwzXkk9DRAh1RhH1vI5WMXAO7j0e741ODrm/bVdhq1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b="O6l5tm/h";
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95698606A320
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 14:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95698606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=O6l5tm/h
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91b8306b9f8so5252866d6.3
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 07:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792852135; x=1793456935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z4o3gUp00unbFHp/dtTEtMrYuS46YAGqlf25OvCWB6I=;
        b=O6l5tm/h2asxEGgIVrye9aRDHQ/BZLggfOdFxKmt97OEQyuw4WKrXpKaJU3Tgb3DsV
         hFo3BJX2ibg4uVAFk+XWdQ+ssbT/ZY5BNJ2bjKMkttIvhDSk3Go6sZjkXKQPz6S2SXaJ
         hY6lqWHaYVUarBYuHCAOd8l7kH2FSNo2Q+bFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792852135; x=1793456935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z4o3gUp00unbFHp/dtTEtMrYuS46YAGqlf25OvCWB6I=;
        b=K80qym8d0WMtZTmDkVKly5FNEXx+5jk71h46s/FRLOGKy5/p7jC3AyjaNNimxVVSYI
         fZAA/0W/gP8ymHkfbgn9swC3BLnHvheK5LzImOJf1wEms3F/Gi6WMEo0iMYDnk/onGq0
         70WVJDE8ZBV0Dc6Fr6xLL/1j/U6UeipeCarTupIE5N/jd+Kvawjif2d9RNTgBNsPxw7r
         lO2JujbxnoOZhEtu7uZ3T+ZwnlinslJv1DeHbm1fS2tAz8BU9hUoWXkydYF4S1rwgRsm
         rRbLHdq+lmbbqHz64KiaHjw2fgXAD3nNP3SmAczcSFzXOp+1gK2xHid2hjVuxBHy/WAv
         TS1Q==
X-Gm-Message-State: AFq9FYJhAivy0EeiSqhHrRxtJipruiXhrQwyO+3IMtVLUpF3xLMt5hgw
	HxitdxANfAPg4dPZ3J3nW/8sOvnbpYT24EJeAMSKdq6f8FpLMMPY3e+7kfqdaBgyCsU0mstMcSo
	ZqbY=
X-Gm-Gg: AYBFou0p28quOCUNM8xRg1rMnjBqiNRsS4R5mYHUep7v5uwopdnOvYxz6CqbWlo28RP
	yP2RdVtWB64NXddYdRtK094D7+4LlCmtaCpdcGzo4NWiMkQ4cFzApEasL19krooPtZU91V0LNvp
	ENAcdDIBxRSXuzT2+UHGbdJUHXbig/5IUVsxJZZ17qjXGsm+5INjTiqzNMwSoUEMyVNBu+xm3hC
	AwIbZZSYP3oFN6ZoAqz8GmgaUMicwyv23mBQY7fLHm6KF/eiEqphjYlMbLIc5o6sjaWLMJ9jw2d
	Rqupkzb7ulvSKCRwJg9Yb7kZ3pmh5L5j6oh7aSvdMf1okz7MzEqAifDiOZiOdLIiNtuDUVrjYOE
	gnIk+ZFqy0uFO/ArUGBbvrlA6ueSI19SvW1+NOGyyNYsf/jEEPLLVaQ5mUl/qMnBJ8GAjLzmA8w
	p7o5cs/qzZkHeHP7O/gYWMtdztgq5jlRM/5VVi4fSrxJCuQIqoDXWMB+O6r9GpAEGi7q3oHKXhZ
	DwI706HIcdDcU/Sk4I+FNPF+YECk4HcFAEBPUY0MJnGU0s6SbqrmJpUxm316ulAFcQpYXQxtJi7
	8huZbBCaGA08loPlb3Uhkd4S7m5CwVuspHGuJZAnAf6XhgZkZQCZH0XcNw7nOwY=
X-Received: by 2002:a05:6214:5f0d:b0:91b:ffec:f410 with SMTP id 6a1803df08f44-91c48eca9fbmr28755286d6.28.1792852134679;
        Sat, 24 Oct 2026 07:28:54 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47a7cd7esm22349976d6.2.2026.10.24.07.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 07:28:54 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	Yotam Gigi <yotam.gi@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH net v3 4/6] net/sched: act_ife: do not consume the inner header on egress
Date: Sat, 24 Oct 2026 10:28:39 -0400
Message-Id: <ACT-N6N4.v3.r0.20261023200137-4@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-N6N4.v3.r0.20261023200137-3@mojatatu.com>
References: <ACT-N6N4.v3.r0.20261023200137@mojatatu.com> <ACT-N6N4.v3.r0.20261023200137-1@mojatatu.com> <ACT-N6N4.v3.r0.20261023200137-2@mojatatu.com> <ACT-N6N4.v3.r0.20261023200137-3@mojatatu.com>
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

The issue:
tcf_ife_decode() unconditionally calls eth_type_trans(), which pulls
ETH_HLEN.  On egress this consumes the inner Ethernet header; a following
eth_type_trans() from loopback_xmit() then parses L3 data as Ethernet and
can BUG in __skb_pull() when the remaining linear area is short.

The Fix:
Parse the inner Ethernet header with eth_type_trans() in both directions,
then restore the egress data position and MAC length.  On ingress the
existing behavior is unchanged.  On egress, push the inner Ethernet header
back after parsing so the xmit path sees the original frame and later
actions see a consistent network header.

Decode is a receive-side operation; the egress branch keeps the frame
intact for transmit paths such as loopback.  tcf_ife_is_eth_skb() accepts
Ethernet and loopback devices generally.

Conditions to recreate the bug:
- egress tc filter on lo: action ife decode pipe;
- AF_PACKET SOCK_RAW frame: outer Ethernet with ETH_P_IFE, IFE metadata,
  inner Ethernet and an 8192-byte payload;
- the egress pipe re-enters eth_type_trans() via loopback_xmit() after the
  action consumed the inner header.

Fixes: ef6980b6becb ("introduce IFE action")
Cc: stable@vger.kernel.org
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

---
v2 -> v3:
  - no code change; add Eric Dumazet's Reviewed-by.
---
 net/sched/act_ife.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 2afd68983ece..3946a9589bb8 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -769,6 +769,10 @@ static int tcf_ife_decode(struct sk_buff *skb, const struct tc_action *a,
 
 	skb->protocol = eth_type_trans(skb, skb->dev);
 	skb_reset_network_header(skb);
+	if (!skb_at_tc_ingress(skb)) {
+		skb_push(skb, ETH_HLEN);
+		skb_reset_mac_len(skb);
+	}
 
 	return action;
 }
-- 
2.43.0

