Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114BB2D0C92;
	Fri,  2 Oct 2026 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790953202; cv=none; b=az0kzXrLst7bzUAcMB0mOA5sy8KWtOEjo3Wi4NBg7Dj99gByGvV43pph3fqUDunA1GToJ+KCuTIREwdnG1XJrKB24baa7PjG8KsGNtXial7kVCkrA442G0pX7TChBWn9YwIdu9phvxdR3MyIEY0SLTMd20s/9As4DHiZYS6KD8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790953202; c=relaxed/simple;
	bh=gPpfEYoQDXiKMurcBkxxhaoyk9+LOrizdBTSMV0u32s=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Cig+PE8fLnrYc8Bm1ddkhGAXFPvlr9kb8bqfSp+V5NBB0cZ7Mul6r7hrGlT76YngGS54GYD71V2mI8Djp7qLkOykCTKycHc8NxemClkMitP/YIjDtflaQdhuJBfi2GeIXqtdc3H+ViRQbyssbQG9N8rWW+SO7GBGGSS0bnGN7Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=hiYO379a; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="hiYO379a"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 19413A4AB8;
	Fri,  2 Oct 2026 16:59:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790953193; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pXn703aOIjISemvjW7SqSYgESFNqSmJXUCU165M1Fr8=;
	b=hiYO379a2JrVAMN12K+8M4nzv4aoMDawt/E/KmtAWiumBOaJXZ39gvhfuXkRj4zeZBnmdt
	u2P9So1KX+/VmAyvQzURenGsqL+NFRrj9JNGUsmKjx/WSGCh15gvHFnCIRKwA0GNC8tkxq
	796xpxuzYZcJWmjnafK0pynf5N4P/+5f1HkB9s01q4APJwN+IjCSCcVyy3qhkL7uKzTc95
	TQr9NJBdDF9BS4laG+WJiQPNqRlfHcrWluflKz528lsRy+hgCnGzSOJTTvWYsBEJ4tdmf+
	daeBNC1XcB1+Ob0IppU2HipznxklPjF3JQYoEzMgtrzxrhCLUdRxN8TSRraZyA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 02 Oct 2026 16:59:46 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Russell King <linux@armlinux.org.uk>,
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, Jitendra Vegiraju
 <jitendra.vegiraju@broadcom.com>, thomas.petazzoni@bootlin.com,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, Peter Robinson
 <pbrobinson@gmail.com>, Joe Damato <joe@dama.to>
Subject: Re: [PATCH net-next v3 1/3] net: rss: Require indir table size or
 hash key size to support RSS
In-Reply-To: <20261002142806.1299041-2-maxime.chevallier@bootlin.com>
References: <20261002142806.1299041-1-maxime.chevallier@bootlin.com>
 <20261002142806.1299041-2-maxime.chevallier@bootlin.com>
Message-ID: <da1589545fdaf4f3c7ed3b0059366bcf@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Maxime

On 2.10.2026 16:28, Maxime Chevallier wrote:
> A point can be made that devices that report a 0-size indirection table
> and 0-length key size don't really support RSS. Let's return 
> -EOPNOTSUPP
> in that case, and skip these devices during DUMP requests.
> 
> This however also reports -ENOTSUPP for devices that only supports flow
> hash fields ops now.

nit: -EOPNOTSUPP

> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  net/ethtool/ioctl.c | 6 ++++++
>  net/ethtool/rss.c   | 7 +++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index 27b0e2e275dc..d32b403c8d3a 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -1444,6 +1444,9 @@ static noinline_for_stack int 
> ethtool_get_rxfh(struct net_device *dev,
>  	if (ops->get_rxfh_key_size)
>  		rxfh_dev.key_size = ops->get_rxfh_key_size(dev);
> 
> +	if (!rxfh_dev.indir_size && !rxfh_dev.key_size)
> +		return -EOPNOTSUPP;
> +
>  	if (copy_from_user(&rxfh, useraddr, sizeof(rxfh)))
>  		return -EFAULT;
>  	user_indir_size = rxfh.indir_size;
> @@ -1554,6 +1557,9 @@ static noinline_for_stack int 
> ethtool_set_rxfh(struct net_device *dev,
>  	if (ops->get_rxfh_key_size)
>  		dev_key_size = ops->get_rxfh_key_size(dev);
> 
> +	if (!dev_indir_size && !dev_key_size)
> +		return -EOPNOTSUPP;
> +
>  	if (copy_from_user(&rxfh, useraddr, sizeof(rxfh)))
>  		return -EFAULT;
> 
> diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
> index d4a1a4724b67..cb9bead0cedd 100644
> --- a/net/ethtool/rss.c
> +++ b/net/ethtool/rss.c
> @@ -129,6 +129,9 @@ rss_get_data_alloc(struct net_device *dev, struct 
> rss_reply_data *data)
>  	if (ops->get_rxfh_key_size)
>  		data->hkey_size = ops->get_rxfh_key_size(dev);
> 
> +	if (!data->indir_size && !data->hkey_size)
> +		return -EOPNOTSUPP;
> +
>  	indir_bytes = data->indir_size * sizeof(u32);
>  	total_size = indir_bytes + data->hkey_size;
>  	rss_config = kzalloc(total_size, GFP_KERNEL);
> @@ -449,7 +452,7 @@ rss_dump_one_dev(struct sk_buff *skb, struct 
> netlink_callback *cb,
> 
>  	if (!ctx->ctx_idx) {
>  		ret = rss_dump_one_ctx(skb, cb, dev, 0);
> -		if (ret)
> +		if (ret && ret != -EOPNOTSUPP)
>  			return ret;
>  		ctx->ctx_idx++;
>  	}
> @@ -457,7 +460,7 @@ rss_dump_one_dev(struct sk_buff *skb, struct 
> netlink_callback *cb,
>  	for (; xa_find(&dev->ethtool->rss_ctx, &ctx->ctx_idx,
>  		       ULONG_MAX, XA_PRESENT); ctx->ctx_idx++) {
>  		ret = rss_dump_one_ctx(skb, cb, dev, ctx->ctx_idx);
> -		if (ret)
> +		if (ret && ret != -EOPNOTSUPP)
>  			return ret;
>  	}
>  	ctx->ctx_idx = ctx->start_ctx;

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
