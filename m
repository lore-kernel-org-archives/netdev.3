Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AF4381EA6
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 14:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951462; cv=none; b=J90HZzQ9qHQ4YrHP61O4UEIzn10u/79su/A3q1t2LUozSP3L/rxmgoJpvmYxm9VL9e4ww2Kfge5k218fGn1zlFcT4v51OQscUXONWJtoZCTMAQnBG6NeFcBWiFNHp2D5z//nMMQ3MiPZKZ2UcH4DvE6sjhFpUPhku4CPjGjBz8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951462; c=relaxed/simple;
	bh=rhLBkBLyavTbrkhr2wKD2LjV1TR+KnkRUBTYwaUrkhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZH9zWim7Kjy+/cPnGH0YW+EsSoerZlSpve5OEAgDzBwUSZl1+n2h9+dpX7WbMr22wtNk8gjtDSs7CFogjc5gIVn5WYljb/YImLSabX29UZ107V1OkASqo0N4KLFiIzan8wdeyXZ9eqzkgT3g2MUdZA8Ca0GzwCWSHp6dFt5wt9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=be6rjXPl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="be6rjXPl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA901F000E9;
	Mon, 13 Jul 2026 14:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783951461;
	bh=iEWBIXSUZSuaWbancgt7Nm/gcjHCwECQpYUbCavS7bc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=be6rjXPlsF12RiytNIWlQ27Kji7tACddBoYG4nIetBtEGnUxE8CnxkGTcAWbkScAY
	 30Dui7DsiuAnpUUfKaNg7r59/5k898DQvNuvTtVlEWH5gxsWP1Ra2+aj/iDCD6Ohys
	 FYNkQtW8FakQ9bXvdaRoXNYG+nMDQC5t4LL0hZk/cSFhQhyNF45hOB/tRFvCjxWIO3
	 9ZvL7LbMygx3jWtOnlJbrWY2vyEmWHGwSVRh7yRpc1jN6nNGYE0mSlV+4eqXiQuN6V
	 p/ldtDbZC4HNRILC30I8NNPWaPXM2e8eI9yni5IRda2kpnOeuMEzEIVH0O6Q4Wvsq6
	 s4qXJhgN6JXSg==
Date: Mon, 13 Jul 2026 15:04:16 +0100
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Michal Schmidt <mschmidt@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: Re: [PATCH iwl-net v2 2/2] ice: fix stats array overflow via proper
 realloc
Message-ID: <20260713140416.GG1364329@horms.kernel.org>
References: <20260706224346.22546-1-przemyslaw.kitszel@intel.com>
 <20260706224346.22546-2-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706224346.22546-2-przemyslaw.kitszel@intel.com>

On Tue, Jul 07, 2026 at 12:43:31AM +0200, Przemek Kitszel wrote:
> Integrate ice_vsi_alloc_stat_arrays() with realloc variant.
> 
> Instead of keeping two functions for stat arrays allocation, change the
> ice_vsi_realloc_stat_arrays() to handle initial condition (no vsi_stat
> entry) and replace ice_vsi_alloc_stat_arrays() by the more generic
> ice_vsi_realloc_stat_arrays().
> 
> Note that VSIs of ICE_VSI_CHNL type are ignored in realloc variant as they
> were in the replaced ice_vsi_alloc_stat_arrays().
> 
> This is a fix for stats array overflow that occurs when VF is given more
> queues (an operation that will be more frequent, and by bigger increase,
> when we will merge my "XLVF" series).
> 
> Splat for increasing number of queues thanks to Michal Schmidt:
> KASAN detects the bug:

...

> Fixes: 2a2cb4c6c181 ("ice: replace ice_vf_recreate_vsi() with ice_vf_reconfig_vsi()")
> Closes: https://redhat.atlassian.net/browse/RHEL-164321
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> This is an alternative to the fix [1] by Michal Schmidt, which were
> blocked due to AI feedback. My fix was already developed before Michal's,
> just not public back then. We have agreed to go on with my version.
> 
> [1] https://lore.kernel.org/netdev/20260520183501.3360810-3-anthony.l.nguyen@intel.com

Reviewed-by: Simon Horman <horms@kernel.org>

...
