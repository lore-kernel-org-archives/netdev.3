Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6141931E832;
	Thu, 15 Oct 2026 23:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792107511; cv=none; b=Fkb3Vm8r+l6U2t6tAUROr2rqhMdwaekyAraV53bu+E2zJp5QyQqOY/PtDHQ1BVPPMrW2ZOaoq3qrQMht4F7TgQefjlDZH7Qm0sMhA4FkvlnFCle0AKOuVrdul7wRfAUma1aqT1da/oKnSFCYHcR6iiFYdd/B5+eH0g6ARkfZzjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792107511; c=relaxed/simple;
	bh=aIlIO6dta1xaRp04nr9+Es2CtRLYgJHBpNfND+fZ+e0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LVruxcLNr5m4+Z8XGO8XMWO9Jg97mSuGPphR5TWVMuP5YAy6HVd5BogQtEKcovED1QfX2/6OOPeb59S6tQe2Kn47Mlwp5CVdaCNSl/mIxoiM6sg3RKySRGAqINhO17C47u3XhasfV7m6jqwwhHrwn+xXU3Mu+CgHIpaHbOgr+eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvE5N87d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvE5N87d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1D71F000C4;
	Thu, 15 Oct 2026 23:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792107509;
	bh=hqgjptSJYB8M8KjBGqcIQm/2GAUwPEW5qf/45/mQNPs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DvE5N87dZCKhi52NantoYMA7HPg28vsI0ttvJm4dMmjRv6uK4w1WYew2Fd+vYWlgR
	 UHvUgqnW3hfZv0kevvWqeTdV9E00AwU5R3ebP/lqM3v32WqP9qJ3rhMkPFP4xjy4zI
	 p8IvO9yvenBmrVX41PI926WooF5jUhCDVPgoWq8zhsMMRC5ymBGIz0iIlxhSKwG3ew
	 rpp7KOvAZjhUeC49x55xHT7ugflZLWnTr4f9fzStZVD2eKj4bcRhVey7/mrHsyodA6
	 4Ux/NYvy01RZQm0SqU8WFpZBRbswhBakszQW1/YEE4rSolsp/LQVzDQ2Qo6MXJ7sj/
	 nqJ7pAzcGPtwQ==
Date: Thu, 15 Oct 2026 16:38:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Russell King
 <linux@armlinux.org.uk>, Lorenzo Bianconi
 <lorenzo.bianconi@oss.qualcomm.com>, Nicolai Buchwitz <nb@tipi-net.de>,
 Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>,
 thomas.petazzoni@bootlin.com, Alexis =?UTF-8?B?TG90aG9yw6k=?=
 <alexis.lothore@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, Peter Robinson
 <pbrobinson@gmail.com>, Joe Damato <joe@dama.to>
Subject: Re: [PATCH net-next v3 1/3] net: rss: Require indir table size or
 hash key size to support RSS
Message-ID: <20261015163828.619c7a09@kernel.org>
In-Reply-To: <20261002142806.1299041-2-maxime.chevallier@bootlin.com>
References: <20261002142806.1299041-1-maxime.chevallier@bootlin.com>
	<20261002142806.1299041-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 Oct 2026 16:28:01 +0200 Maxime Chevallier wrote:
> @@ -457,7 +460,7 @@ rss_dump_one_dev(struct sk_buff *skb, struct netlink_callback *cb,
>  	for (; xa_find(&dev->ethtool->rss_ctx, &ctx->ctx_idx,
>  		       ULONG_MAX, XA_PRESENT); ctx->ctx_idx++) {
>  		ret = rss_dump_one_ctx(skb, cb, dev, ctx->ctx_idx);
> -		if (ret)
> +		if (ret && ret != -EOPNOTSUPP)
>  			return ret;

nit/btw this change is not needed. The context dumping is entirely
handled in the core, if device let us create one there mustn't be
a EOPNOTSUPP here.
