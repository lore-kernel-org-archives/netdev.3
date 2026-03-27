Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C0B263C8C;
	Fri, 27 Mar 2026 01:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774575593; cv=none; b=c+6y7a34D575ER/jIpVMGw4YoQLUkwx3w4uAX3xZ/B6JpH0iswzqsIb17UaBwL8u0HFeRUMoGQLwLj3jlKXo+a8kguNnsNuME1LrGc5g3aregg5dJ/H5GFBsnUUVPvEuPrEooDQ9dHQ/+pcXgKnLLfbvIaGJmDchhgb38DJFc5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774575593; c=relaxed/simple;
	bh=LvAoOiRn0Xi9xeTMcV41A4DIWHOqkw7B7QG7lwPtr+A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMtk9f4h4HXWVgZM163zGiRadOh7pzs5yhUenCNDHZA2H/43VWZosxLLNAlxV1TUms3X1T3BTMgl3XK2VhJrh2JIGEktOEiC5F/bM0QKMyTTxk6Dze4IbPJ9pPCiwyKLlweBAiSkjegrX3whxrul740tqTelt9KxSjK2M8ievp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2787him; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2787him"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA019C116C6;
	Fri, 27 Mar 2026 01:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774575593;
	bh=LvAoOiRn0Xi9xeTMcV41A4DIWHOqkw7B7QG7lwPtr+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s2787himbVcQp9gZblX5i4aJ4ZkK8/ngPJragxUZWzKP9nktrnqngpvugCtzfDO18
	 PwhWiSCjiZuU0yF6w5KGZpVGy7jFTec88rTvDgYSOPwkILaK4nBl4aKUInKNOgMgFk
	 grFOq311zYq3AXHJKw71uWuSpVfZ+v2/Aa3KBi0b64YAdu4zFDWXJdKKu2An9KvZEB
	 lNsH/Fc6AHzsBjj1SNI/gfpmIJs7VvRjQfec2bxKhBNw1wZ7XU3ItRFjjBGk3SdVJN
	 +lrlbUNIwNA30yAvSXfaMjibkYeJid3haV27D1veBOQ7BrAKBKLqU6TV2TpCL/ZEXY
	 ea631qnkTsjMQ==
Date: Thu, 26 Mar 2026 18:39:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Izabela Bakollari <ibakolla@redhat.com>, Edward Cree
 <ecree.xilinx@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] sfc: add transmit timestamping support
Message-ID: <20260326183951.686a522f@kernel.org>
In-Reply-To: <acOrt0LqV__xh_93@gmail.com>
References: <20260324160823.151472-1-ibakolla@redhat.com>
	<acOrt0LqV__xh_93@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Mar 2026 02:35:12 -0700 Breno Leitao wrote:
> On Tue, Mar 24, 2026 at 05:08:21PM +0100, Izabela Bakollari wrote:
> > Enable software TX Timestamping. The out of tree driver 
> > also implements this.  
> 
> "The out of tree driver also implements this" is not the most technical
> justification.

+1 it's an odd thing to put in the commit msg.
Please fix and repost (keep Ed's tag)

> > diff --git a/drivers/net/ethernet/sfc/ethtool.c b/drivers/net/ethernet/sfc/ethtool.c
> > index 362388754a29..c0038b942913 100644
> > --- a/drivers/net/ethernet/sfc/ethtool.c
> > +++ b/drivers/net/ethernet/sfc/ethtool.c
> > @@ -231,6 +231,8 @@ static int efx_ethtool_get_ts_info(struct net_device *net_dev,
> >  {
> >  	struct efx_nic *efx = efx_netdev_priv(net_dev);
> >  
> > +	ts_info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;  
> 
> Don't you need to append SOF_TIMESTAMPING_TX_SOFTWARE instead of
> assinging it?
> 
> 	ts_info->so_timestamping |= SOF_TIMESTAMPING_TX_SOFTWARE;

Either way is fine IMHO unless you see a specific reason Breno?
-- 
pw-bot: cr
