Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793087771;
	b=2SHlyp3/+Pmr/mzd/h+Oi9Z8BLY/cieBHG67/Vv7PJxeSQBr8W8IkG7FDKThYoubA413
	 xg6L12F5uOc2T6udUNk7g7HbvhZu8FFvuJInNlrxQIlm3oVJta87Q70hwwn3fsRRgRqvP
	 15x6wjJBIEkq6GWQUPa2WJLlo4RgcPZFoHHMa409/6tBZfgwBgeuYYfhsWON9i06ZIVhs
	 RbGSIbkd9eFUgTZhjlZAETydvF7vC0PXSITttlrLtFDSj05oz4RLmo39zjHG5k4kmkY+M
	 ldyuKQHcmCsa/Y/BlT8H/w3vz4JjUWUtTscBohn25V8kHe99sC+dx6qei11Bm3WFqaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793087771;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=MzNz7BwRthycj+ECJC5wKz1PbH4SrkcjTpqhd1V0uhs=;
	b=Dgh30ArF4g9AArdeFw4Aqyi1hy4WwQ1qlHLB5tJMyBWKcpf7Cx3uAIFa2Grr+Brea13x
	 2lfBR55t+VDCmGAYcFAiKyhlkFko4f3YZZ/WkCuRYlritUHhJSvOu7WuOL5RNGDK3A9Np
	 p3CfuySG2S3LvxWh7emZkAtNuTRTPbqLUS0Qr6qg+fqBVv2ZoVF3mPFPkLhEUlu862ZTU
	 jRmqyjToG74ZuFcXl+N7TrSLzkEdyxBRxb0xwB/+FKdIJmt/B8INaXJXtpXPFE5x+boBa
	 bHaUbDUzecciGNXOeoY/wqLk8SMUAtnUfq+dwiV575ujG6G5ZHeOdzzRWLS7qoktXeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GSUOduEr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11919606A31A;
	Tue, 27 Oct 2026 07:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GSUOduEr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071BB1F01828;
	Tue, 27 Oct 2026 07:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793087770;
	bh=MzNz7BwRthycj+ECJC5wKz1PbH4SrkcjTpqhd1V0uhs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GSUOduErjL4BaN0sV5QA04755U3AOuf/n64JDh+YMKiPKMQmCQP7/vrm1E019V+cF
	 UBDB2P7hTUwND2o6IJDB1hrjYmD46uY5mx+1v+VlVJZpyojoHttNc/eFAbYAjd/o6p
	 FyxCKIoZmwoGw+JlE6kcdmsArsVtfZxTMJi+IxX8n1uP+267LOGH3jCZTDEL94u2UA
	 XuiKEkRvyhKnIwank1CeqRjROFlKRW7lBRtFKON2aKOjO7QT38ssKG7iacNXtS4zfF
	 b51QYoUm9O3DNG9RQvLiRJhqgzR+SlXLjcEfiiXQpBksRkOHakScWJb28+WKD48F6J
	 iEOt/cquD07Yg==
Subject:
 Re: [PATCH net] octeontx2-af: fix inner LC ltype match for RSS flowkey
From: netdev-bot+sashiko@kernel.org
To: kmahammadraf@marvell.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, sgoutham@marvell.com,
 rkannoth@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, kirankumark@marvell.com
Date: Tue, 27 Oct 2026 07:56:09 +0000
Message-ID: <179308776953.3134.4396227527945551102@kernel.org>
In-Reply-To: <20261023071905.2922825-1-kmahammadraf@marvell.com>
References: <20261023071905.2922825-1-kmahammadraf@marvell.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch fixes an RSS regression but has no Fixes: tag.
- [Low] The commit message gets the layer and the failure mode wrong.

--

octeontx2-af: fix inner LC ltype match for RSS flowkey

This commit changes set_flowkey_fields() in rvu_nix.c so that the inner
IPv4 and IPv6 RSS flowkey fields use an exact ltype mask of 0xF instead
of NPC_LT_LC_IP_MATCH_MSK and NPC_LT_LC_IP6_MATCH_MSK. The outer IPv4
and IPv6 masks stay the same.

> octeontx2-af: fix inner LC ltype match for RSS flowkey
>
> Inner LC ltypes differ from outer LC ltypes, but RSS flowkey programming
> was using outer LC IP/IP6 ltype masks for inner IP keys.
>
> For inner IPv4/IPv6, match only the base IP ltype and do not include
> extension-header matches. Keep existing outer LC masks unchanged.

[Severity: Low]
Is this description accurate? In set_flowkey_fields(), the inner IP keys
are on layer LG, not LC:

	if (key_type == NIX_FLOW_KEY_TYPE_INNR_IPV6) {
		field->lid = NPC_LID_LG;
		field->ltype_match = NPC_LT_LG_TU_IP6;

LG also has no extension-header ltypes that could be included:

drivers/net/ethernet/marvell/octeontx2/af/npc.h:
enum npc_kpu_lg_ltype {
	NPC_LT_LG_TU_IP = 1,
	NPC_LT_LG_TU_IP6,
	NPC_LT_LG_TU_ARP,
	NPC_LT_LG_TU_ETHER_IN_NSH,
	NPC_LT_LG_CUSTOM0 = 0xE,
	NPC_LT_LG_CUSTOM1 = 0xF,
};

NPC_LT_LC_IP_MATCH_MSK and NPC_LT_LC_IP6_MATCH_MSK both evaluate to 0xE.

With match 2 and mask 0xE, INNR_IPV6 also matches NPC_LT_LG_TU_ARP (3).
The default KPU profile emits that ltype. As a result, tunnelled inner
ARP packets get 32 bytes at offset 8 of the ARP header hashed as an
IPv6 SIP/DIP.

With match 1 and mask 0xE, INNR_IPV4 either aliases with LG ltype 0 (no
inner layer) or never matches. Which one happens depends on how the
hardware applies the mask to LTYPE_MATCH. The hash code in
rvu_npc_hash.c compares (ltype & ltype_mask) against the match value,
which points to the never-match case.

Could the subject and body name the LG layer and describe these
effects, so it is clear which traffic was mis-hashed?

> This fixes inner-tunnel RSS key calculation and prevents mismatches in
> inner IP flow classification.
>
> Signed-off-by: kmahammadraf <kmahammadraf@marvell.com>
> Signed-off-by: Kiran Kumar K <kirankumark@marvell.com>

[Severity: Medium]
Should this patch carry Fixes: tags?

Before July 2024, set_flowkey_fields() set field->ltype_mask = 0xF after
the INNR_* override. The inner keys therefore matched NPC_LT_LG_TU_IP
and NPC_LT_LG_TU_IP6 exactly.

Two commits then changed that trailing assignment:

  e23ac1095b9e ("octeontx2-af: fix issue with IPv6 ext match for RSS")
  60795bbf0476 ("octeontx2-af: fix issue with IPv4 match for RSS")

They switched it to NPC_LT_LC_IP6_MATCH_MSK and NPC_LT_LC_IP_MATCH_MSK.
The assignment runs after the INNR_* override, so the 0xE mask was also
applied to the LG inner IP keys. This patch puts 0xF back for the inner
keys only, which reverses that regression.

Both commits carry Fixes: 41a7aa7b800d, so they are probably in stable
trees already. Would adding the following tags let this fix reach those
trees?

Fixes: 60795bbf0476 ("octeontx2-af: fix issue with IPv4 match for RSS")
Fixes: e23ac1095b9e ("octeontx2-af: fix issue with IPv6 ext match for RSS")

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023071905.2922825-1-kmahammadraf%40marvell.com
