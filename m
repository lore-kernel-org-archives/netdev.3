Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB383CCA19
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 20:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787688159; cv=none; b=fZzLTjbXl/bwFlXC0sqREfLH3F9sp19QNG3PbcVuHCnxmhCgNpiIpIuMXvMQuyL+ysYBrrqmBWQow+bKbqDSjU6jzvbIfELkyC/SKlIQ89WHFO49GjTEFWbZsGQx7aM4ynm1CGUUcbCBpiNsx3Mf2L09AsiJzyjV48ltDNFFRzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787688159; c=relaxed/simple;
	bh=/YZKVYk/L6dyruLdxfl7WIXz33gjUDcSeoPRd9IwmHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fFNe/FCyuycUMC161pgnRec27HxeVelOzNcqOvQeQ2eGtCl7vgOfyfZb9j8hH8Pc4ZiywYRyyAYaNa+bnq2zQn4FgGlCyTrOhs20ZODR7OSXPMWkQWgG12ZZ25kmpbZV9kihZm0WcJpJUi/RSaYApnIFgLztg12kQboTbbNpLx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=kgqYoNO1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fCu7HnMU; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="kgqYoNO1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fCu7HnMU"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A31247A00D0;
	Tue, 25 Aug 2026 16:02:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 25 Aug 2026 16:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1787688156; x=
	1787774556; bh=SiCj95U5huzbKKQRE4iCRqDxTe2vaNO9s6DJBSD0N5I=; b=k
	gqYoNO1xISolh1sgBtehCLph5Iv6FCdLfMqd9qkQBcL/kGaY/hE3pwRwlnJSAiR8
	JQcPidVTSM/vXH7wKKq8UvaZEYJWQwsJNxbQVLQXZkCulwl40FTCvx7SouwVa2/q
	dilTG8fHET0iYtZnuaLrufZgHaQxSMVMSINCOu8/o3LufpXY1uRN6XLdzSvrJShK
	MKxzBpWf4+DSz1cNb70MeW+4KeXw3oXUj9Kd1RHYRwO661D/aU8MBe/+fPeRswaz
	uadoa241qj9tFDcM88gMj1XG5jwHCYnMGxlx6ESXnY8nxenCow9lQ5K3NQJfhFyv
	yCghShEY2VflQo1mSUmkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1787688156; x=1787774556; bh=S
	iCj95U5huzbKKQRE4iCRqDxTe2vaNO9s6DJBSD0N5I=; b=fCu7HnMU0vMvoa22h
	N2fDt2Ip65YHjmi3sn6ywMZIwOGS7LALeHP3WsqYt9Ra4wWNw++YqIUp1ZUOoeMx
	8rQyWR9Vw2O1FjHRoN3uGdTr6YUDgpjIMKNmS41iVG6/7EySQve5Ag+gSSZnHCla
	BCWfOvYLX5jYIvpakfVvuivjR2iqgYPH8kKmFsHV91YKEpSkZibb7BawM59ie4Er
	oPgEM0s9yIKXxphqcRu0ThIsvHwlNg+0eMy9eBwAEawu4p1+RVMgfm4DTBNSH2rh
	lKpYFfUwERrq/cADDEoboTBNBfRgVCrN+QH2MnnwrbUaSQT/lFmCFbK4g+FYpFEY
	c99Lw==
X-ME-Sender: <xms:2_SNauA87LktovSSX6emdcWQ5FU02AKJA8pj1TBoA09DsNNQecMUqA>
    <xme:2_SNai5A_E0Hw3TM2rJOnjEp179dWPRL5jMHJCpLCmZ7N_5oL6x7dSPsSAOTjNUmz
    pVYCfgNW8HTWU2DOBEI5-6qe3TVt7diTv7ALPg7rYEgw0LIAlihhCk>
X-ME-Received: <xmr:2_SNantHP5EOnhcr1WmuAqaqq8IIk9UbWHaIJdTaUDQSCgNc3t6lZh_fY63A3pyIB4zBQfW6erD9WHyTQH8>
X-ME-Proxy-Cause: dmFkZTEh3LepmWUW1p+ocB0D4fsSnptYFl2J+Ty/C8JsINR78t82Yds65Ipdx2xeTo++7H
    Tt8oeWb9/9gbqBvoSi3ceDTptb6mzyZ4Gz60SKKDMNQk2vGqGmxEx2nvVKF0+jbFjxLywC
    k+Fia5L6J0C8THUSj797fqbn1EXAKTj8VUOB25MWKzDWqOzAzvAToKxt2HNt6bFvqbXmLm
    FIRQtbT1k4FNE1r8va/yuf1tKRVoj8phe+EKYmmrdNKGv7fC0tDrCMOnpooQAYIDHTMMYk
    A7iBEeh/fssAC9Oa8cBZPDoMwAjEytKBQ99TrYhEhAI1dAfS3MTq70We3DACRnOw7+C/HK
    hFZtOVXB3sRvkcanQV2Z4dFTRxOiSTipzUHHudpeV/xMjWB5qf036TK0+YjZdPZIFBBXEC
    AQDBfFDGw07RAu2N0krbeC9wqr6mw5a4udHiu71nfD9vQNqZn+hunxtGRM/d3N9cJxRxoD
    HzpROiuwmT7Jr0G27Ta8n02cTIBFcuK/7vH0t9f25MUfsWlAgFApwJFTFVnb+MCctRREyR
    kUqX/rCl0DkUMhpEBaV4aBg7/2GhUu168XLUxBb2WLqU83BBm66eHBR+HnUOaD6whSve/M
    BmvlClo4DX8niIUk204eHmSPvzAP/Cxx0NaxDtem43I+7+Ia198iYVIBOueA
X-ME-Proxy: <xmx:2_SNan4V9VyDY8tqdBbc7sLZ2gveL1gQkJBbODF6qKLV4FSPObombw>
    <xmx:3PSNar1f_G1BwVJNUD6ZtrE2imUQb9TSuWrQWelAe__4D9enim7XSg>
    <xmx:3PSNaqgEX-4n7oy07XjN7zTQVmd7Oy96Bxo73CImpXa0FBuXXMHVpQ>
    <xmx:3PSNarpbZzh85TRMnTMCdRHFMRP0d0TOWzIK3qYdJAiw7AVCt7IaAQ>
    <xmx:3PSNaug-ZPRkT8H40l4D8XNSZbu-zfqgk-nEfn4uZmBNylS_W5caK6nT>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Aug 2026 16:02:35 -0400 (EDT)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>,
	syzbot+ce13c07d96d04716eaa2@syzkaller.appspotmail.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net v4 1/4] net: ipv4: Fix UDP length overflow with PMTU discover and big MTU
Date: Tue, 25 Aug 2026 23:02:12 +0300
Message-ID: <20260825200215.90326-2-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825200215.90326-1-alice.kernel@fastmail.im>
References: <20260825200215.90326-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alice Mikityanska <alice@isovalent.com>

This commit bounds cork->base.fragsize to IP_MAX_MTU to avoid a
possible overflow of UDP length that triggers a WARN in
udp_set_len_short when setsockopt IP_MTU_DISCOVER is set to
IP_PMTUDISC_PROBE, and a large packet is sent over a netdev with an
unusually large MTU.

Steps to reproduce:

1. Set device MTU bigger than IP_MAX_MTU + 20. cork->base.fragsize will
   be set to that MTU in ip_setup_cork.
2. Set IP_MTU_DISCOVER to IP_PMTUDISC_PROBE. It lets maxnonfragsize be
   set to device MTU (cork->fragsize) in __ip_append_data, rather than
   to IP_MAX_MTU.
3. Send 65528 bytes of payload (+8 bytes of UDP header, +20 bytes of
   IPv4 header). Device MTU allows it (it's only one byte bigger than
   IP_MAX_MTU + IPv4 header, and the device MTU is bigger than that).
4. The UDP length in the built packet is 65536, which overflows the
   16-bit length field and triggers the WARN in udp_set_len_short.

Note: IP_PMTUDISC_DO with IPv4 is safe, because ip_dst_mtu_maybe_forward
always clamps at IP_MAX_MTU, unlike ip6_dst_mtu_maybe_forward.

The Fixes tag points at the first commit where I could reproduce the
overflow with IPv4 and IP_PMTUDISC_PROBE.

Fixes: daba287b299e ("ipv4: fix DO and PROBE pmtu mode regarding local fragmentation with UFO/CORK")
Reported-by: syzbot+ce13c07d96d04716eaa2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a6a966c.86abc875.e5c3d.0054.GAE@google.com/
Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Assisted-by: Claude:claude-sonnet-4.6
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv4/ip_output.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 74e095b6b7ca..a24cc8ee11d3 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1303,6 +1303,7 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
 
 	cork->fragsize = ip_sk_use_pmtu(sk) ?
 			 dst4_mtu(&rt->dst) : READ_ONCE(rt->dst.dev->mtu);
+	cork->fragsize = min(cork->fragsize, IP_MAX_MTU);
 
 	if (!inetdev_valid_mtu(cork->fragsize))
 		return -ENETUNREACH;
-- 
2.55.0

