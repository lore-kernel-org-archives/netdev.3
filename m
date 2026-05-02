Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263F2E54B
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 01:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777684190; cv=none; b=Bb3hHzBfECkocT6E+barWLvnPt97qjsSWQkM4riTNpMQoAFsp5Ya8P78TSYw1Qt9qWjrJ51SJxkureyWgiIFDcPJyzsIUA4qKW+jHTzaWPPf0uNJAFFO5wIlBGxCM0TfuEjCfWPah4V/R80NtCQWLk4Q9flITrN07c3iLsIJx6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777684190; c=relaxed/simple;
	bh=+uxaFvdex+e3+56ac6g4HSluQVhRZkqLACfF588s5OY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HpChsdc1RsiPnMayrW6aFWLITeE9kJKsEq8LGum1m32GtFK6Ds9T/KmfgW8n2CTGpHw16JWupsB++peXAnxUSlWihKBTS80/6nS6P29uEKMisZnKGJclF+dP2jOf2q6fUSFXUZps/qYotELfpM+6Zu4LAN3eLNDJwNJFFC6ohUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeiksudE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeiksudE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB15BC2BCB4;
	Sat,  2 May 2026 01:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777684190;
	bh=+uxaFvdex+e3+56ac6g4HSluQVhRZkqLACfF588s5OY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XeiksudES23vSeUw1dTSwhhSKUah4/2xwelqtNM3V++rymMP90qu2XzrABTi0i3Th
	 62wncL7qXu9hVXjUxZ8OdT8t5I3k3tKvovcygNIpvemkDtMO7rzrD3155T0W+A/rwZ
	 /78nwE7P1MThz4NSSXJ8zCIYK4sSwzj+GAeEezkEl4EU4eK0B3iXqQcfCng1fAmjdX
	 SAtSZQMiYKqz0jrf1Tbn+D/PJPNniut4HNAmpbF9huoUn2oQ5CKjoxyWd5eFuYQuVh
	 319EoLBR9CNESfFGUOTp41geaV8voCLPQ2ZbNorjo9ucC8shhRpbWlnQxekaNDUoPI
	 kL0y1xNGGReEQ==
Date: Fri, 1 May 2026 18:09:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
 petrm@nvidia.com
Subject: Re: [PATCH net-next 2/3] macvlan: Do not transfer operational state
 when protodown is enabled
Message-ID: <20260501180948.1f68c43f@kernel.org>
In-Reply-To: <20260429124624.835335-3-idosch@nvidia.com>
References: <20260429124624.835335-1-idosch@nvidia.com>
	<20260429124624.835335-3-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Apr 2026 15:46:23 +0300 Ido Schimmel wrote:
> -		list_for_each_entry(vlan, &port->vlans, list)
> +		list_for_each_entry(vlan, &port->vlans, list) {
> +			if (vlan->dev->proto_down)
> +				continue;
>  			netif_stacked_transfer_operstate(vlan->lowerdev,
>  							 vlan->dev);

Doesn't feel particularly macvlan-specific?
Other simple upper devs don't support protodown
but when they do presumably they'll have to add
this exact condition, too, so why not add it in
netif_stacked_transfer_operstate()?
