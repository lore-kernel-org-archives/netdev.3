Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EFA30E85D;
	Thu, 26 Mar 2026 17:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547254; cv=none; b=uzVO0ElIWU74hQpdT0zsIPVihOMLCThDMcUwX3QLPB80Zf6KJ0Yrvv7dV4Lo3eX/5LhMzMnfCWFmgIdGOyw7Xo1qfxlDrY4aB7B27JZY1gO8+Vr2KTYu8ctYPoI6RwyGPY6ASeVbkyHFLdl53QLxcPmHWqAMZFDGmBx/v6DnI1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547254; c=relaxed/simple;
	bh=nYtQYc4YQoml8hikD/gIU1luWunqBiQ6b9LjT33Werk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7XvmRcx6SFSDEHoeyUlJAcMQ2aI3+fyi8RJFhbfYYiMfjX8z3xQ9hnJrC0yvrtaZXqtZQuLClN74Glknls+mNmoa9Km9qGYT1zRfFnL71CGQciEpB7+bKG/Z3g58h715d9aMnlz0VfJ0A9ppObWt+M7nfyDBTXsO2RZFoRz35g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JU88H1mx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JU88H1mx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEFFC19423;
	Thu, 26 Mar 2026 17:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774547254;
	bh=nYtQYc4YQoml8hikD/gIU1luWunqBiQ6b9LjT33Werk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JU88H1mxfD9Et/sZAEjAgH0CHqEWQzToVDo6w0N30YM9gGyt0NfWHmBz7KQAXlkUh
	 SlJBlBPV53zNwFrCjHJe041DBQPx7Lx4C96//Qsdi15HkMfOSjdAmLItdnbuYX4vuK
	 qBR/+3LjhJq0X/TlhdfQL9y1dKM15QZ3IuQZ7Utzdz0EpfeN5L71I2znNzaP1jHjO2
	 Neyq8/bRkPxp27ppB94DfureqbbM/KQtXYTSP7kBrOAS8egb3lNzxFMQr79ZqrXw7B
	 M3Vn4zxQPEoW8VuA5Apne1+kM5FFQnUZK7xK/D4Fc/9e6035Nxp47Xdjiae9A1EN/f
	 cM7NPsQ6nGoXw==
Date: Thu, 26 Mar 2026 17:47:30 +0000
From: Simon Horman <horms@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qed: iscsi: limit command queue array fill to the ramrod
 array size
Message-ID: <20260326174730.GT111839@horms.kernel.org>
References: <20260324105629.61282-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324105629.61282-1-pengpeng@iscas.ac.cn>

On Tue, Mar 24, 2026 at 06:56:29PM +0800, Pengpeng Hou wrote:
> qed_sp_iscsi_func_start() validates p_params->num_queues against the
> number of command queues exposed by the hardware resource table, but it
> then uses that count to fill q_params.cq_cmdq_sb_num_arr[] in the SCSI
> init ramrod. That array is fixed at SCSI_MAX_NUM_OF_CMDQS entries.
> 
> The in-tree qedi caller derives num_queues from the device's reported
> num_cqs and the online CPU count, so current-tree callers can request
> more queues than fit in the fixed ramrod array on sufficiently large
> systems even though the existing hardware-resource check passes.
> 
> Reject queue counts that exceed the command queue array capacity before
> filling the ramrod.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/net/ethernet/qlogic/qed/qed_iscsi.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/ethernet/qlogic/qed/qed_iscsi.c b/drivers/net/ethernet/qlogic/qed/qed_iscsi.c
> index e16808291338..62cf85f9a042 100644
> --- a/drivers/net/ethernet/qlogic/qed/qed_iscsi.c
> +++ b/drivers/net/ethernet/qlogic/qed/qed_iscsi.c
> @@ -177,6 +177,15 @@ qed_sp_iscsi_func_start(struct qed_hwfn *p_hwfn,
>  		return -EINVAL;
>  	}

Hi,

As per my comment to your similar patch for fcoe.

The code immediately above checks fcoe_pf_params->num_cqs
against p_hwfn->hw_info.feat_num[QED_ISCSI_CQ], which I assume
is derived from hardware.

Is that sufficient to avoid the OOB access you describe?

>  
> +	if (p_params->num_queues > ARRAY_SIZE(p_queue->cq_cmdq_sb_num_arr)) {
> +		DP_ERR(p_hwfn,
> +		       "Cannot fit %u queues in %zu command queue slots. Aborting function start\n",
> +		       p_params->num_queues,
> +		       ARRAY_SIZE(p_queue->cq_cmdq_sb_num_arr));
> +		qed_sp_destroy_request(p_hwfn, p_ent);
> +		return -EINVAL;
> +	}
> +
>  	val = p_params->half_way_close_timeout;
>  	p_init->half_way_close_timeout = cpu_to_le16(val);
>  	p_init->num_sq_pages_in_ring = p_params->num_sq_pages_in_ring;
> -- 
> 2.50.1 (Apple Git-155)
> 
