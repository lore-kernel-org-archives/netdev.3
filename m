Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD9F280330;
	Thu, 26 Mar 2026 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547188; cv=none; b=d6iD4GcSEouB51LUxsQdaX6ycsBxvTN6YXh+/Iu7eZDGszE0Bi5vHwLrOMEMYW2elNJDyHkhaupFvDzOJK/4otp9oVZ0KJs3l3ak2oXdnQo0R3OA10LTAWoWz0HOlF770hD67dnC6+fpQlffZhBbAu0s48XfJSdGl6f4isGIERs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547188; c=relaxed/simple;
	bh=xjm4GKUt6/7LWYUwaSbsNRs8Q/I9UKOobgqP/owDPhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmDvDca3D/PDPgstz6fzdOJxzpeCXWoCZWW1Qwi1pUZhBDjUoHPdxW6yYgfrGmrAxxoV7GVskJ9Toeu5aYu/vtq4GZnjsDYgiqJ0DCU7xiA8n0Z516BreExuW2jq318bWOWUVUqBohMIBBA04oXutBSeGSH2A63M5OU0s2xuKn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlpkwBfJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlpkwBfJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C0BC116C6;
	Thu, 26 Mar 2026 17:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774547188;
	bh=xjm4GKUt6/7LWYUwaSbsNRs8Q/I9UKOobgqP/owDPhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SlpkwBfJwmRh2sDnUjKpV5AdmQxZ+CR+lA+1ReSGMukQWhfFf1AQucAcZ0QWkGFVf
	 GmTSe8MXsSRmcCtejYX/qcMlZIiWCuwv5V7pO03ntbWg715XYcQmyL1NQyGdfQUwcZ
	 kD0mtB/UvSaJTuu1d3lQXrzNHiMvHBYQaLFAh2v687ZJxN+02RifoKkRwXv7YUY4aH
	 yZFpbnvi6RPKjBz9sNGXISjZ+EB3r75t67oKjhjc3HwRoitGRVZ+t92YVaBqW2kJKt
	 nTIjyiYvfHboyk2M0FVjHXouhudhmlWCbPIy6mC9L6JqbzJ7Uu/Pln/yw6yV/v6kNx
	 LCKcHzHAap7ug==
Date: Thu, 26 Mar 2026 17:46:23 +0000
From: Simon Horman <horms@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qed: fcoe: limit command queue array fill to the ramrod
 array size
Message-ID: <20260326174623.GS111839@horms.kernel.org>
References: <20260324105647.92763-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324105647.92763-1-pengpeng@iscas.ac.cn>

On Tue, Mar 24, 2026 at 06:56:47PM +0800, Pengpeng Hou wrote:
> qed_sp_fcoe_func_start() validates fcoe_pf_params->num_cqs against the
> number of command queues exposed by the hardware resource table, but it
> then uses that count to fill q_params.cq_cmdq_sb_num_arr[] in the FCoE
> init ramrod. That array is fixed at SCSI_MAX_NUM_OF_CMDQS entries.
> 
> The in-tree qedf caller derives num_cqs from the device's reported
> num_cqs and the online CPU count, so current-tree callers can request
> more queues than fit in the fixed ramrod array on sufficiently large
> systems even though the existing hardware-resource check passes.
> 
> Reject queue counts that exceed the command queue array capacity before
> filling the ramrod.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/net/ethernet/qlogic/qed/qed_fcoe.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/ethernet/qlogic/qed/qed_fcoe.c b/drivers/net/ethernet/qlogic/qed/qed_fcoe.c
> index 2ae3639d6cf7..5fbf78f6adca 100644
> --- a/drivers/net/ethernet/qlogic/qed/qed_fcoe.c
> +++ b/drivers/net/ethernet/qlogic/qed/qed_fcoe.c
> @@ -126,6 +126,15 @@ qed_sp_fcoe_func_start(struct qed_hwfn *p_hwfn,
>  		goto err;
>  	}
>  

Hi,

The code immediately above checks fcoe_pf_params->num_cqs
against p_hwfn->hw_info.feat_num[QED_FCOE_CQ], which I assume
is derived from hardware.

Is that sufficient to avoid the OOB access you describe?

> +	if (fcoe_pf_params->num_cqs > ARRAY_SIZE(p_data->q_params.cq_cmdq_sb_num_arr)) {
> +		DP_ERR(p_hwfn,
> +		       "Cannot fit %u queues in %zu command queue slots. Aborting function start\n",
> +		       fcoe_pf_params->num_cqs,
> +		       ARRAY_SIZE(p_data->q_params.cq_cmdq_sb_num_arr));
> +		rc = -EINVAL;
> +		goto err;
> +	}
> +
>  	p_data->mtu = cpu_to_le16(fcoe_pf_params->mtu);
>  	tmp = cpu_to_le16(fcoe_pf_params->sq_num_pbl_pages);
>  	p_data->sq_num_pages_in_pbl = tmp;
> -- 
> 2.50.1 (Apple Git-155)
> 
