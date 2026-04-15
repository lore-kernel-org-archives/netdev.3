Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF88F3E3D90;
	Wed, 15 Apr 2026 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776270609; cv=none; b=O8uNfgXQJC1jEaBJjwQznOPDUXa+9UECUBdXe1ZW3iaiD5nzlykDOQ3INqfjRDVCp0NIH7sdmUsuitMd660pv04cg8dVOQZhgw5+p74l/QriBE1TVuOUy6EuD9CU8fJ4ySpio9EX5zk1KuFdkYjemtce7xT1dg543UmACfT5c7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776270609; c=relaxed/simple;
	bh=fniF0iwOu4pkgMWiGbwhBeBWmR/o5IjyUb8gyW4Vgwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SeLv2MotLcNqp9B5gk1F/71t9+cNY47m/kNXQQJMr1YyOBUJqh94vDFlXCpSTjy0HU5vk8Qg43u/0+NaKDTumvb9piU334Eteyf5MLkQ2K26LMQHlCZjccD0ZJbw8/MQYkeSw7oQCZU4uG0xfR/kC2ePcJle6mZb+hnSL2ncnvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9PWKMrZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9PWKMrZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17446C19424;
	Wed, 15 Apr 2026 16:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776270609;
	bh=fniF0iwOu4pkgMWiGbwhBeBWmR/o5IjyUb8gyW4Vgwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g9PWKMrZi+xJ6h43sHHkddcGBm1Iy9E5DBTRIBFEGOR+WHCVpS5B5vj0RrJIdg3iv
	 qzyWhNuvYFH0oCv3WGTyA1gYhd8ZBjKxNf4ieil6zB1s9DH0XxAIjVvIxoei9XZKOo
	 olShtrjMVb29k+8BNnhLP5xlxFl4MNJxF05gG2tlffmF0ezLeZpBsZX3wU4m+pZ4Bi
	 tKMvN5KAbT/apig496Wy0mrM70R14brxktFLHqryduHmfLl81zvPgmv1tPoOTs6EYi
	 F2II7AuwqcrlPtGW4KYV85yLrhE6WbtBLljgzOCJdkou4RuSv8GdOoRib5x4ke5cfa
	 goyP4i4nZ46YQ==
Date: Wed, 15 Apr 2026 17:30:03 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Dave Ertman <david.m.ertman@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	jacob.e.keller@intel.com, intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-net] ice: fix infinite recursion in ice_cfg_tx_topo
 via ice_init_dev_hw
Message-ID: <20260415163003.GP772670@horms.kernel.org>
References: <20260413191420.3524013-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413191420.3524013-1-poros@redhat.com>

On Mon, Apr 13, 2026 at 09:14:20PM +0200, Petr Oros wrote:
> On certain E810 configurations where firmware supports Tx scheduler
> topology switching (tx_sched_topo_comp_mode_en), ice_cfg_tx_topo()
> may need to apply a new 5-layer or 9-layer topology from the DDP
> package. If the AQ command to set the topology fails (e.g. due to
> invalid DDP data or firmware limitations), the global configuration
> lock must still be cleared via a CORER reset.
> 
> Commit 86aae43f21cf ("ice: don't leave device non-functional if Tx
> scheduler config fails") correctly fixed this by refactoring
> ice_cfg_tx_topo() to always trigger CORER after acquiring the global
> lock and re-initialize hardware via ice_init_hw() afterwards.
> 
> However, commit 8a37f9e2ff40 ("ice: move ice_deinit_dev() to the end
> of deinit paths") later moved ice_init_dev_hw() into ice_init_hw(),
> breaking the reinit path introduced by 86aae43f21cf. This creates an
> infinite recursive call chain:
> 
>   ice_init_hw()
>     ice_init_dev_hw()
>       ice_cfg_tx_topo()         # topology change needed
>         ice_deinit_hw()
>         ice_init_hw()           # reinit after CORER
>           ice_init_dev_hw()     # recurse
>             ice_cfg_tx_topo()
>               ...               # stack overflow
> 
> Fix by moving ice_init_dev_hw() back out of ice_init_hw() and calling
> it explicitly from ice_probe() and ice_devlink_reinit_up(). The third
> caller, ice_cfg_tx_topo(), intentionally does not need ice_init_dev_hw()
> during its reinit, it only needs the core HW reinitialization. This
> breaks the recursion cleanly without adding flags or guards.
> 
> The deinit ordering changes from commit 8a37f9e2ff40 ("ice: move
> ice_deinit_dev() to the end of deinit paths") which fixed slow rmmod
> are preserved, only the init-side placement of ice_init_dev_hw() is
> reverted.
> 
> Fixes: 8a37f9e2ff40 ("ice: move ice_deinit_dev() to the end of deinit paths")
> Signed-off-by: Petr Oros <poros@redhat.com>

Hi Petr,

I don't intended to delay this patch.
But could you follow-up by looking over the AI generated
review of this patch on sashiko.dev?

Thanks!
