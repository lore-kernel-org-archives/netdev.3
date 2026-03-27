Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06498359A87;
	Fri, 27 Mar 2026 13:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774618453; cv=none; b=ZBib6l8DlmO8g6o0eAqmjcCrWW+04VwGbk19fSLV9nymZxxfH2q9NjXWXKrleVtUVWBCUuwt2voz2BO1H5e4jVt+aUNmlXuK0VdM0pDPkyY8fAZSei6DlyHBCxA9zkS0T37Gs+VJFy1q/CW12DfmbxtLdD76/PmeQq2YpPsFz4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774618453; c=relaxed/simple;
	bh=4uku/2c6kGHrowbXuEweVL7uRl5A+txc8DOFP/RGyb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUNRyUDj/BkuhZq2Ywj2wGM96ulQeqS8No4OwJ6ip0Y4ucKj2+foukuHJqTo71TSyvtKdP3z8eaZlGQifuV6765QFcmg9Ps304GsquTP1UCbSC4cwcnZqUNXd5mVgCFXsmtjCXIciY9h01zpHCeMikZe/EfVEAhugNfIVIYhiDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXp44VSp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXp44VSp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668B0C19423;
	Fri, 27 Mar 2026 13:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774618452;
	bh=4uku/2c6kGHrowbXuEweVL7uRl5A+txc8DOFP/RGyb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QXp44VSpLV1xMs76Ia6U7gP3QbEd/rCCF+iUw4ihO0r30Bi5WNwOjt6ImJsJGzYWa
	 2s21mf3jkIEIgNXXKhvRm7jdDTFOvBXT+W1MnJZaUOGHz+L9hgYsfbmdxAZgAdkiim
	 w2z8aLI/TEJ/JQdqiHHyvmaxc3DVi8pY97daEK0QMX5gNzEbYDVwxr444pcCoIt7u6
	 ZoDns5T6bTihUlf0qze6vhXr/7TCwO/16mOfACEMs55ZU/uZ7X39uHU+951eKXNVBN
	 4ptRRakiu8UuMcGHV3RIUkSdlSOdpuR/CECyxV3l2UItVwAPVxXuzI32Zz1zO4FaON
	 gZeqjjm02vv5Q==
Date: Fri, 27 Mar 2026 13:34:06 +0000
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, donald.hunter@gmail.com,
	jiri@resnulli.us, chuck.lever@oracle.com, matttbe@kernel.org,
	cjubran@nvidia.com, shshitrit@nvidia.com, dtatulea@nvidia.com,
	tariqt@nvidia.com
Subject: Re: [PATCH v8 net-next 5/6] octeontx2-af: npc: cn20k: dynamically
 allocate and free default MCAM entries
Message-ID: <20260327133406.GF567789@horms.kernel.org>
References: <20260325072159.1126964-1-rkannoth@marvell.com>
 <20260325072159.1126964-6-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325072159.1126964-6-rkannoth@marvell.com>

On Wed, Mar 25, 2026 at 12:51:58PM +0530, Ratheesh Kannoth wrote:
> Improve MCAM utilization by tying default (broadcast, multicast,
> promisc, ucast) entry lifetime to NIX LF usage.
> 
> - On NIX LF alloc (e.g. kernel or DPDK), allocate default MCAM entries
>   if missing; on NIX LF free, release them so they return to the pool.
> - Add NIX_LF_DONT_FREE_DFT_IDXS so the kernel PF driver can free the
>   NIX LF without releasing default entries (e.g. across suspend/resume).
> - When NIX LF is used by DPDK, default entries are allocated on first
>   use and freed when the LF is released if NIX_LF_DONT_FREE_DFT_IDXS is
>   not set
> 
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index ef5b081162eb..bd671b553df5 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> @@ -16,6 +16,7 @@
>  #include "cgx.h"
>  #include "lmac_common.h"
>  #include "rvu_npc_hash.h"
> +#include "cn20k/npc.h"
>  
>  static void nix_free_tx_vtag_entries(struct rvu *rvu, u16 pcifunc);
>  static int rvu_nix_get_bpid(struct rvu *rvu, struct nix_bp_cfg_req *req,
> @@ -1684,10 +1685,16 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
>  	if (is_sdp_pfvf(rvu, pcifunc))
>  		intf = NIX_INTF_TYPE_SDP;
>  
> +	if (is_cn20k(rvu->pdev)) {
> +		rc = npc_cn20k_dft_rules_alloc(rvu, pcifunc);
> +		if (rc)
> +			goto free_mem;
> +	}
> +
>  	err = nix_interface_init(rvu, pcifunc, intf, nixlf, rsp,
>  				 !!(req->flags & NIX_LF_LBK_BLK_SEL));
>  	if (err)
> -		goto free_mem;
> +		goto free_dft;
>  
>  	/* Disable NPC entries as NIXLF's contexts are not initialized yet */
>  	rvu_npc_disable_default_entries(rvu, pcifunc, nixlf);

> @@ -1699,6 +1706,10 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
>  
>  	goto exit;
>  
> +free_dft:
> +	if (is_cn20k(rvu->pdev))
> +		npc_cn20k_dft_rules_free(rvu, pcifunc);
> +
>  free_mem:
>  	nix_ctx_free(rvu, pfvf);
>  	rc = -ENOMEM;

It seems like a nit to me. But AI review flags that the rc value will be
overwritten when jumping to the free_mem label.  And thus the error
returned by npc_cn20k_dft_rules_alloc won't be returned to the caller.

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c

...

> @@ -1926,7 +1925,6 @@ int otx2_alloc_queue_mem(struct otx2_nic *pf)
>  	struct otx2_qset *qset = &pf->qset;
>  	struct otx2_cq_poll *cq_poll;
>  
> -
>  	/* RQ and SQs are mapped to different CQs,
>  	 * so find out max CQ IRQs (i.e CINTs) needed.
>  	 */

nit: this hunk seems unrelated to the rest of the patch.
