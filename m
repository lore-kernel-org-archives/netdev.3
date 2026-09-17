Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA924EC641;
	Thu, 17 Sep 2026 12:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648716; cv=none; b=m3RUCOwlmjZ+wJKr7vReQHiGIGckS228L/ihrLZX3CQUmLaFIe7ddKRMFE5sSSSCHZ4HhUBLXwwEvHvk7zmYBh1VV4s92O1PfhgePMeXAlz5l/5Nmi9fKKAneQYS0RAWYA74lIrCS9Ey+BCQmL5HTrXUPxArA5hitDCj79HeGzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648716; c=relaxed/simple;
	bh=yDWoB7tXiF0ubQOeiOXGMppsM/Sa3RmZ10YKdCBY+q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5PFM5UJcTUTkeffHW0zKSHzl4vJ2zB47i4cfThKClnAEx/PGbE/2eFDJWAhSuz/LCWWnvTkIF1DgIKDRGmvIVbuw601AG8KZIENIaiw2JWgodkqr+WUxlfl1uShzXi0X75fd5aDespTk1fAmF4dUIMkCZKN9iNMnh978vShMuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2Wqq+MH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2Wqq+MH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500631F000FF;
	Thu, 17 Sep 2026 12:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789648701;
	bh=xiw6JD0mGbruaKRYNthmS3f5yAzK9ERtaAMH4k9HdGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=o2Wqq+MHA4VOMPU24ZCaSfBTukzLme9ZVKB31gBnMPSV7RoCjjNUQKiNwezqjU5Sm
	 tsOg3xImOwPmTXVcv1iLqGjSa4o9yDB54hp9RBmlck6zzcDL3xAg24TmWbkHOH/juO
	 kGtmMERt2h88HcMMItasXlCIJghvMCJAXC98Ceb/u4IeLmzFqQ/UdzdQwsRkOuiFXz
	 0GYbq3voAkaFQdQVnHXfpIgJ3vnN1ClkQH6jAmc42QDDI5EtuXr6MFX2eLu7tHk9Ij
	 PMmpnaMSji3eSqBQTqEqn+HzsrqwlZBHHFtLFRp1TvjoNXuSnV6upH1N/286DRDgUZ
	 VyvqG+4bA7bwQ==
Date: Thu, 17 Sep 2026 13:38:15 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Priyalee Kushwaha <priyalee.kushwaha@intel.com>,
	Kiran Patil <kiran.patil@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-next v2 0/2] ice: fix TC flower filter priority
 violations
Message-ID: <20260917123815.GD51261@horms.kernel.org>
References: <20260916144130.2699902-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916144130.2699902-1-poros@redhat.com>

On Wed, Sep 16, 2026 at 04:41:28PM +0200, Petr Oros wrote:
> Two fixes for TC flower offload in the legacy switch mode. Both
> address the same user visible failure, all traffic on a port silently
> disappears after installing a filter chain that mixes offloadable and
> non offloadable filters.
> 
> The first fix covers filters matching on ip_proto alone. The driver
> never programmed the protocol lookup, so a filter like "ip_proto udp
> action drop" was installed in hardware as a match on eth_type ipv4 and
> dropped every IPv4 packet.
> 
> The second fix covers the interaction between software only filters and
> offloaded drop filters. The E810 switch gives drop rules absolute
> precedence over forwarding rules regardless of recipe priority, so a
> lower priority drop offloaded into hardware overrides any higher
> priority filter that stayed in software. The driver now tracks filters
> it could not offload and refuses to offload a drop filter that would
> bypass one of them, keeping the drop functional in software instead.
> 
> Tested on E810 with the OS default and comms DDP packages, including
> the original reproducer from the report, L2TPv3 pass and drop chains
> with and without session ID matching, and a shared block bound to two
> PF ports.
> 
> ---
> v2:
> - track one entry per cookie and filter_dev pair so a shared block
>   bound to multiple devices is protected on every binding, and the
>   delete path drops one entry per DESTROY invocation (sashiko review
>   via Simon Horman)
> - collect Reviewed-by from Aleksandr Loktionov on patch 1
> 
> v1: https://lore.kernel.org/all/20260910154824.3603687-1-poros@redhat.com/

Thanks for the update.

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>

