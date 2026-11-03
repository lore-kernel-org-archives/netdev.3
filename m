Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705765;
	b=tWKZvy0MYtTynfZqkEGdk3uvejwBq1jJS1dxS2LxIgclhhYdU6cDw4isWI0we1WHmwKh
	 X6fbaQriJgaYeoyLXU2KGkncUBTd3dy2TbLymJCdnfVrn4TCsisOEsoJa+BCz1f0KDVWW
	 wZGbvv9yFTsivYpH6GCob0enLMTkynyr3WeAArjQZPMNKu1iakxkSZFMm29j3WwCnA0hp
	 mUGV/EPYpmE/t+kMKdCcehJKqMDsihcXrcrvql+KsV/qwpFG/tSBEgb5ZlkvoVLHg5qiN
	 v6HRVRz5ZBy8H+9G77pMfdKw2+gITHyveXenZ926hXtn+quzOe0MGJVTPCZn9zjVYhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705765;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GAY7T9NQ/2byBz25PRaY9dnQ/M+bRZtNm/ceVen4yX8=;
	b=r5OMsgQqKW21+EOHJpk/AqECpPudc7joDjElx4DIDCIUy9fcTZJYRGKHCMYpH/XzI4aK
	 Gy3JKHud0xY+TK/tzZ1kzqM/mxRY3InimFfWrfcS5uX2mXkuqb/hqQzivfmlAsGvBEAEf
	 NGneTy9Yt05rSLdvsepNpdfOFN2MV+x4cbtMmUumvwdwstbRvo/d2HS3nc9RxplA3yySa
	 Rjg1EoMmg7f5wJEwwJEM15tUkJFNwHGeWqe2pRhF76LZbx1OItw7XYyijHiZm28xLPmK2
	 Dou24e+AdaeuFpacU4mIWqai3InLsAerS2bnjaTJlS7TsaH78solamqJYJPDhy2OjOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nA3OMBqW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A02606A326;
	Tue,  3 Nov 2026 11:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nA3OMBqW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC561F000C1;
	Tue,  3 Nov 2026 11:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793705764;
	bh=GAY7T9NQ/2byBz25PRaY9dnQ/M+bRZtNm/ceVen4yX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nA3OMBqWR3BQKf86wg06Nkoydxsho4x5uDILtm0Wr4EW2r2fdhXIP5OCdlAW4ZDaq
	 0BJft8wJVNe5odsp9CN31xIr5c8PkYsezfZitLD659jFaV6L6smQxMcklu+aX5lZEO
	 Vb3cUdHRZdLiVVpoqlbqTXZ8h+APFIqpnQdOJ+TfmL8+wpGtKrgBR1osymsimxZCkI
	 QkBLZg9Y+v/+Hvut5kBk0l0a9WTRfC/j5DSnPW5ywu0eCHNv0JnPpAf/Ma6d/otvBo
	 d9LlnSqLIAEx1PLOfF5lKfUFFyv/ejU7ssVijiIBTWOTCrm3VYJxZNPJRnt1SHOJaI
	 GFS1LbeJoZoVw==
Date: Tue, 3 Nov 2026 11:35:59 +0000
From: Simon Horman <horms@kernel.org>
To: Alexander Goodkind <alex@goodkind.io>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Tarick Bedeir <tarick@bedeir.com>
Subject: Re: [PATCH net v2] net: ethernet: mediatek: preserve sibling PPE
 bindings
Message-ID: <20261103113559.GH865646@horms.kernel.org>
References: <20261030010517.45639-1-alex@goodkind.io>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030010517.45639-1-alex@goodkind.io>

On Thu, Oct 29, 2026 at 06:05:17PM -0700, Alexander Goodkind wrote:
> __mtk_ppe_check_skb() clears entry->hash for flows bound to other
> hardware slots in the same software hash bucket. mtk_flow_offload_stats()
> then skips their hardware counter updates. L2 cleanup also frees sibling
> subflows without invalidating their hardware rules.
> 
> Restrict both cleanup paths to entries assigned to the inspected slot.
> 
> Two UDP trials reproduced the counter failure on a GL-MT3000/MT7981
> running unmodified OpenWrt 25.12.5 with Linux 6.12.94:
> 
> 1. Start a UDP connection.
> 2. Add a control connection in a different hash bucket.
> 3. Add a connection in the first connection's hash bucket.
> 
> AI code review of the original patch identified the cleanup problem
> in L2 subflows.
> 
> Full ARM64 builds with allmodconfig and allyesconfig passed before
> and after the patch using GCC 14.2.0 and W=1, without new warnings.
> The builds used CONFIG_WERROR=n because the unmodified ARM64 kernel
> already emits warnings. Hardware testing has not run for this revision.
> 
> Fixes: c4f033d9e03e ("net: ethernet: mtk_eth_soc: rework hardware flow table management")
> Fixes: 33fc42de3327 ("net: ethernet: mtk_eth_soc: support creating mac address based offload entries")
> Link: https://github.com/openwrt/openwrt/pull/26107
> Assisted-by: LLM
> Signed-off-by: Alexander Goodkind <alex@goodkind.io>
> ---
> Changes in v2:
> - Apply the slot check to L2 subflow cleanup as well.
> - Add the Fixes tag for L2 offload support.
> 
> V1: https://lore.kernel.org/netdev/20261023012529.5994-1-alex@goodkind.io/
> 
> Codex assisted with investigating the counters and preparing the patch.

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>

