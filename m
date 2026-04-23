Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D59D3E63B6;
	Thu, 23 Apr 2026 11:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776942788; cv=none; b=NdfNccNXIRBWiorjlbNd69DIeH+NxPX+C9jUU6Z8mtd8l02S/3zi9N94w0jkl87gBBFOAQwdbItRYmaOXFLN85Nf66s7ud5Gjiy7AAk8SiMQjpiw95kiAz0F10UPrpWG2winMVaen8ZIq5DRo29RxJtwURRCXzphtnWvn27AaI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776942788; c=relaxed/simple;
	bh=cmM0w61J04+PEJxb+HlVlwAfMod8VR6dUIfGH1oByf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZ0Vj9r7auJmxLLNAAtBlczxMB7HPX4Dt1VUjmbXYcMzoIXzoaMiSudSxgHraN4taDNbHxKAGDhYM44Khicf64FwMm1R8c4eKSYnLebGdWlBWsJTuUcDwL/zrFlCelWXtLnHvLF97ji8Z9kg1rKXIJtD1nBoo3sr7wge+8RuIQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuMobCwl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuMobCwl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE72FC2BCAF;
	Thu, 23 Apr 2026 11:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776942788;
	bh=cmM0w61J04+PEJxb+HlVlwAfMod8VR6dUIfGH1oByf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PuMobCwlOXQzNWG03LmIUTDv7U9t0QOa1dHiBDM3ayTGuji+OWx5K6sQisdSXqCW0
	 QvcGZCuDIObpA8PKeqbcoBKSdpWbC7ZXBBi5ymEug1xHUTPUjMneoCgIzM6CKh/Dxw
	 Kpzd0Ftgd07/7QKvmZlSnv13ADRs4+o9vi1d3mArzVUzMRnqgMO/wtvLaX7WrsLANL
	 Z3naXlbdz34FHYlM3Sjn25qwQ67Q41F+lcJllihkVpHbOVb4jC3Ykfl7c4QSGV1gDh
	 dGIeAswhkGslfmEwYxaLcgNYo6PlGjMVMiAic0FNXw6nOJvsoh2xugSWvb+JQKoCYu
	 +SKlaTMQ2aKVQ==
Date: Thu, 23 Apr 2026 12:13:03 +0100
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	dan.carpenter@linaro.org, Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v2 net 03/11] octeontx2-af: npc: cn20k: Propagate errors
 in defrag MCAM alloc rollback
Message-ID: <20260423111303.GA900403@horms.kernel.org>
References: <20260420023442.3295891-1-rkannoth@marvell.com>
 <20260420023442.3295891-4-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420023442.3295891-4-rkannoth@marvell.com>

On Mon, Apr 20, 2026 at 08:04:34AM +0530, Ratheesh Kannoth wrote:
> npc_defrag_alloc_free_slots() allocates MCAM indexes in up to two passes
> on bank0 then bank1.  On failure it rolls back by freeing entries already
> placed in save[].
> 
> __npc_subbank_alloc() can return a negative errno while only part of the
> indexes are valid.  The rollback loop used rc for
> npc_mcam_idx_2_subbank_idx() as well, so a successful lookup stored zero
> in rc and a later __npc_subbank_free() failure could still end with
> return 0 when the allocation path had also left rc at zero
> (for example shortfall after zero return values from the alloc helpers).
> 
> Jump to the rollback path immediately when either __npc_subbank_alloc()
> call fails, preserving its errno.  If both calls succeed but the total
> allocated count is still less than cnt, set rc to -ENOSPC before rollback.
> Use a separate err variable for npc_mcam_idx_2_subbank_idx() so a
> successful lookup no longer clears a non-zero rc from the allocation
> phase.
> 
> Cc: Dan Carpenter <error27@gmail.com>
> Fixes: 645c6e3c1999 ("octeontx2-af: npc: cn20k: virtual index support")
> Link: https://lore.kernel.org/netdev/adjNJEpILRZATB2N@stanley.mountain/
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>

Sashiko has generated a review of this patch. I believe that the concerns
raised there are all pre-existing issues that can be looked at in the
context of potential follow-up; I do not believe they should block
progress of this patchset.

...
