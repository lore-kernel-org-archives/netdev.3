Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9547539E16C;
	Mon, 13 Apr 2026 22:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776119571; cv=none; b=tHFNY1isohcAyCcvLenGXGDO1bZHEiGmg0hz4jmSELFtN+1GyLLCjbVH8nVJ8XAd3T+uDw9wLNj137VpJAkYwBD1PJTnQmebLMY/Q0Garpt4DA6BzrtC9S3WuiogQ03n4lBTVd6PlbZbinUV/cWV9HTQsk/HQ8+00S8PSDmigzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776119571; c=relaxed/simple;
	bh=aq85xQXXX53SpCNdMbdQpz9cHhRCxx2xnUAKfm3kx9E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LgSsOd0ZCk/792IVETL0VJEzWXN3iUEYomI8gABAXx4U/7X4CyBCOad+3goCZhKYrVAvIeLhsTgQcSCsTSUMjT+rQX/zhKAw3pTfDbg5wIfp+2tqK2srNZ6w4lXsqV9WKv5PJru2uXySIlKjVY+jhPthXS8S1b+4tN+Oq5NR3jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmgmDwqr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmgmDwqr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2B8C2BCAF;
	Mon, 13 Apr 2026 22:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776119571;
	bh=aq85xQXXX53SpCNdMbdQpz9cHhRCxx2xnUAKfm3kx9E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NmgmDwqrrH2X3VKe+Iq5qo55WHk/yk7Ypta/yqEJqgxsaep8Tsh2WuSAdWjbs7CX3
	 4OFvBEiC+aKErHqrcH4J1eciX5Ou+XYLHrCJBzxmQ9UmbVH3EFEKUk8Mgc6fWsF1Nx
	 xn4Sq/YPBtLMddeKFcRtpHfQiTXqqvFK2p0agS78RFNSR4VQJDK8WoJtAgrCDby9qI
	 VefNPuOC/7LwMC3JZlsJUEM3jSnJwK86oqwGO8Rmi0DRh5Id736IALHBAE0KuX++AG
	 UGnFUVYDQ5eyN9/1gU3R50q2QUxRMfw6G+Mohe12/+9Zg9Et5g4CRyxSnxe0qB194K
	 Wrwl5apL7rqTQ==
Date: Mon, 13 Apr 2026 15:32:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/4] net: dsa: yt921x: Add port qdisc tbf
 support
Message-ID: <20260413153248.0588690b@kernel.org>
In-Reply-To: <20260409171209.2575583-5-mmyangfl@gmail.com>
References: <20260409171209.2575583-1-mmyangfl@gmail.com>
	<20260409171209.2575583-5-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Apr 2026 01:12:04 +0800 David Yang wrote:
> +static int
> +yt921x_tbf_validate(struct yt921x_priv *priv,
> +		    const struct tc_tbf_qopt_offload *qopt, int *queuep)
> +{
> +	struct device *dev = to_device(priv);
> +	int queue = -1;
> +
> +	/* TODO: queue support */
> +	if (qopt->parent != TC_H_ROOT) {
> +		dev_err(dev, "Parent should be \"root\"\n");

Let's add extack to the offload struct like htb does and report this to
the user instead of the logs?

> +		return -EOPNOTSUPP;
> +	}
> +
> +	switch (qopt->command) {
> +	case TC_TBF_REPLACE: {
> +		const struct tc_tbf_qopt_offload_replace_params *p;
> +
> +		p = &qopt->replace_params;
> +
> +		if (!p->rate.mpu) {
> +			dev_info(dev, "Assuming you want mpu = 64\n");

BTW we can use extack for "warnings" like this, too

> +		} else if (p->rate.mpu != 64) {
> +			dev_err(dev, "mpu other than 64 not supported\n");
> +			return -EINVAL;
> +		}
> +		break;
> +	}
> +	default:
> +		break;
> +	}
> +
> +	*queuep = queue;
> +	return 0;
> +}
> +
> +static int
> +yt921x_dsa_port_setup_tc_tbf_port(struct dsa_switch *ds, int port,
> +				  const struct tc_tbf_qopt_offload *qopt)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	u32 ctrls[2];
> +	int res;
> +
> +	switch (qopt->command) {
> +	case TC_TBF_DESTROY:
> +		ctrls[0] = 0;
> +		ctrls[1] = 0;
> +		break;
> +	case TC_TBF_REPLACE: {
> +		const struct tc_tbf_qopt_offload_replace_params *p;
> +		struct yt921x_marker marker;
> +		u64 burst;
> +
> +		p = &qopt->replace_params;
> +
> +		/* where is burst??? */

Why not add it?

> +		burst = div_u64(priv->port_shape_slot_ns * p->rate.rate_bytes_ps,
> +				1000000000) + 10000;
-- 
pw-bot: cr
