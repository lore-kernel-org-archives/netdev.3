Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDC0328B4E;
	Thu, 19 Feb 2026 22:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771539249; cv=none; b=Fz2z2WOGaJX0TZG6Oh28KzQjw/BLlv35NQMVgOE/Zj50QF7ZGz3iYCZUIupUwkPlYrGIX6UTgFre86klIOKzoqXFReAVWSEI8U0t0WV9UdSqCDV4a6RdjoyizrHq3GpIr0OhLLaGdLtG9CRzdd0eMPdJWRwHKV4dG0r+S60T8sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771539249; c=relaxed/simple;
	bh=BWG7i9FteAotwZgv9mf0jsGbtroT6PmHh4rsCMlUZpk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uG0QpwLTwNOJxmT8dOI2wQXCHQp+w5Vx76VKdJgfeZ72PHAeswfe84PL1MZVDFRbglmKWQ0TpqtVbKWfJKp6nYlBl4pNrxlqPYzualBZrQnZPbk0W6Stldns2iNCWB9jyl34U29RmPhMUznT1cNjBooXX4gJijWolhFyalws/R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNjkySNy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNjkySNy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39BFC19424;
	Thu, 19 Feb 2026 22:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771539249;
	bh=BWG7i9FteAotwZgv9mf0jsGbtroT6PmHh4rsCMlUZpk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WNjkySNynndmXVQbKm1LU2TmM9bdSMF+O5493mvWCNIpbEUt08LnGqEkwqSof7wEn
	 3sjJgiyhzWgmMdReyJi+JHhulPvbYLVpOeAHHKV8kAv3vK2xU+SG+OlBGjOrJkMxLN
	 1vjBoFulMb5HpSfvxA56ePHAwLxYv5Yr0GT7M+JwzCIbNCWkgCJmhLYsdBgRf0xs+S
	 Rs1SV5qcORzmBArNW8TdrBsz5F+e+tFAXA1yRu4GQJbfn5fQ8iBR/JD28BTmlNcj5R
	 g6X8zK5gu/YLFaN4xgLrV1EE2auCk4lJJnFNCDOBhyDzuA7reEMG9GRoR0l9HTUvT3
	 vXkPFcZ6Q/KxA==
Date: Thu, 19 Feb 2026 14:14:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Yuhao Jiang
 <danisjiang@gmail.com>
Subject: Re: [PATCH net] dpaa2-switch: validate num_ifs to prevent
 out-of-bounds write
Message-ID: <20260219141407.7fd697c0@kernel.org>
In-Reply-To: <SYBPR01MB788110DFE66BA1A5CE7E594FAF6DA@SYBPR01MB7881.ausprd01.prod.outlook.com>
References: <SYBPR01MB788110DFE66BA1A5CE7E594FAF6DA@SYBPR01MB7881.ausprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Feb 2026 22:42:40 +0800 Junrui Luo wrote:
> The driver obtains sw_attr.num_ifs from firmware via dpsw_get_attributes()
> but never validates it against DPSW_MAX_IF (64). This value controls
> iteration in dpaa2_switch_fdb_get_flood_cfg(), which writes port indices
> into the fixed-size cfg->if_id[DPSW_MAX_IF] array. When firmware reports
> num_ifs >= 64, the loop can write past the array bounds.
> 
> Add a bound check for num_ifs in dpaa2_switch_init().
> 
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Reported-by: Junrui Luo <moonafterrain@outlook.com>

Please remove the self-referential reported-by tags. FWIW:
https://github.com/google/security-research/pull/334

> Fixes: f054e3e217e4 ("dpaa2-switch: refactor the egress flooding domain setup")

This commit looks like refactoring.
Please dig a bit deeper to find the real commit in which the bug was
added.

> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> index 66240c340492..78e21b46a5ba 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> @@ -3034,6 +3034,13 @@ static int dpaa2_switch_init(struct fsl_mc_device *sw_dev)
>  		goto err_close;
>  	}
>  
> +	if (ethsw->sw_attr.num_ifs >= DPSW_MAX_IF) {

Unclear to me from a quick look at the code and the commit message why
we reject num_ifs == DPSW_MAX_IF. I see there are some references to a
control interface in egress flooding, is that why?

Please explain clearly.
-- 
pw-bot: cr
