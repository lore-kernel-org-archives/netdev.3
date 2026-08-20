Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81E23921E9;
	Thu, 20 Aug 2026 18:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787250203; cv=none; b=gkOKa+ZGLTepd+ajsW5lioaab+0rjQ9WMnqEvox59tOFwiWjbww9MPRkrczXK/N7iwhs8/StbHkQ9SGJrEs1cnIyu8QaHjWIFPyPX/+ad+qOhmNDTykN2EIUFMqjZ3pRcUybBguMoKSvFMYpS7/v5TXFb0LmCQQcOsbUkrCfW0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787250203; c=relaxed/simple;
	bh=JgR/zlLWHsEVlCiMZWWa0GaPfs74HrUHNVL0RoK0XFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqQJAC0JWaBTxypAmFJUpBrPho9MsiUSNuzCv2IrA2uXK4oc82ubC3cMsTsF5l9irDRMQ4my/UdP/PcHf3gr0IZhEH3BVHQn3mMJ5RIYpVI10GQLP4X87M0jXWqaqUaLlmgBWhTgpis/wN6CEBAC18uafGgYX/T6LL5TKxHpS+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXlxtZGJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXlxtZGJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C161F00A3F;
	Thu, 20 Aug 2026 18:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787250202;
	bh=55Ia629opH1ky9riVJUQXRKQOxN8b4RqzQrFac7YHnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iXlxtZGJTRrP+Rlf+S4zRJLjpQNThb6MsmgXX5o626LXYbxXmiIDAiOpbFz72UKeS
	 xa6AVHQcBO/EPnGg85DUB+6mVi7SmjBFo9e0NeSCt77JZieu36OKUNxhHk3Om9v7/l
	 lG6D491hoIpueSLgKwDEiXcm55QF6E3CPu03qsxP9BObpvOsGTwEbv4V9M6GPuaExg
	 Y+FOiJKW/JnbI/xoH3W0o9QkXYbqG1NAkpHfnbtumCs1jJedZToQ+Hj6LUxJSZY91s
	 JLOx8B836NoB+AYS4Zs/g0CgMoYMvb3zZElSThI1M8Tn0+775wH5R8E2yGONRQAxzG
	 lGEdDDD8JxTqA==
Date: Thu, 20 Aug 2026 19:23:17 +0100
From: Simon Horman <horms@kernel.org>
To: Subrat Pandey <subratp@marvell.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	andrew+netdev@lunn.ch, sbhatta@marvell.com, rkannoth@marvell.com,
	gakula@marvell.com, sgoutham@marvell.com
Subject: Re: [PATCH net v4 1/2] octeontx2-pf: Fix aura BPID assignment when
 CONFIG_DCB is enabled
Message-ID: <20260820182317.GB265046@horms.kernel.org>
References: <20260818091124.1832237-1-subratp@marvell.com>
 <20260818091124.1832237-2-subratp@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818091124.1832237-2-subratp@marvell.com>

On Tue, Aug 18, 2026 at 02:41:22PM +0530, Subrat Pandey wrote:

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> index eecee612b7b2..f39b293cc837 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> @@ -1029,6 +1029,14 @@ static inline int otx2_tc_flower_rule_cnt(struct otx2_nic *pfvf)
>  	return pfvf->flow_cfg->nr_flows;
>  }
>  
> +static inline u8 otx2_get_bpid_idx(struct otx2_nic *pfvf, int qidx)
> +{
> +	if (IS_ENABLED(CONFIG_DCB))
> +		return pfvf->queue_to_pfc_map[qidx];
> +
> +	return 0;
> +}
> +

Hi,

As pointed out by sashiko.dev [1], this will not compile if
CONFIG_DCB is not defined because the compiler will
evaluate pfvf->queue_to_pfc_map, and that field doesn't exist
without CONFIG_DCB set.

[1] https://sashiko.dev/#/patchset/20260818091124.1832237-1-subratp%40marvell.com

-- 
pw-bot: changes-requested
