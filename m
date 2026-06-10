Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F1F4071CA
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 13:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099840; cv=none; b=muKXleNWWweiLJLgOw+0T7KNP9b+swVaNoX2f9WhUftLz+AgVjq769X/Z6Spq4EIc5SaBIiXu/0RwhiCJbmNSkr0a559um+lfdZRvCKNUnSfaP6azMaDRddNtPxK1bqHTTPAimvw8j0r9f1RSYmq/1aBQxdsvKPwYQ6i+jDH7qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099840; c=relaxed/simple;
	bh=fzWB4kxadpLfTCMoiRfgSxMiKNXKfXfcECHeLrOiEPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsISTHUMWSgiz2cjBnuUWdngPGsS+yoHwYxBCShSPGGIihtyXiK527hPsDvD1yx6Gj+pfrAi3IrReGosSqvLh4s4tmCgH6RzetmbugMZJ3aAEhJalxkBG6p7i/h2hRlFILnWxeC/Nkk8zwr/CGN3RJb1biz5g4aLhteGzJi+JcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muv6aSst; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muv6aSst"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D361F00893;
	Wed, 10 Jun 2026 13:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781099839;
	bh=L5C3ussGByA9i7+3Y4M9b5bsaS5ARFq9X8h53aSoPEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=muv6aSstXmClq7TOtm27CPmIBazyJZTdkK02DTfhLUNNvL1po573EcRUqLW5cdJde
	 +7Em78k9lvzqGTfIjmnG42RoS4u+ZyES7+Npz7BeCm8fLyz69F7O8u7GQcrpIIb3wj
	 GukK5mt7HhZ2roOaWEyNQwRp7DVAvQWgf7z4V7vUFBb8CoJBIgorrFFKQfzeVZDNVO
	 goRU0GaCiE3Aqvq6WqrL/l0rQXVOKuUAwlvZkBZdW6jqsvP5qNosxOXSk+tnnpRd+G
	 zjbhyGZm9SV5lylYDRr8zhLjVpodOippCKdBIPuyvIeZBmysfirxu+2u3l6qsSRLr1
	 mG7Zrqcaw6x6w==
Date: Wed, 10 Jun 2026 14:57:15 +0100
From: Simon Horman <horms@kernel.org>
To: Przemyslaw Korba <przemyslaw.korba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	konstantin.ilichev@intel.com, aleksander.lobakin@intel.com
Subject: Re: [PATCH iwl-net v3] ice: fall back to SBQ when LL PHY timer
 interface times out
Message-ID: <20260610135715.GL3920875@horms.kernel.org>
References: <20260605120734.1462847-1-przemyslaw.korba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605120734.1462847-1-przemyslaw.korba@intel.com>

On Fri, Jun 05, 2026 at 02:06:26PM +0200, Przemyslaw Korba wrote:
> The low-latency (LL) PHY timer interface relies on a tight, atomic poll
> of the PF_SB_ATQBAL register with a 2ms timeout. After an NVM update /
> EMPR, FW may need significantly longer than 2ms to start responding to
> ATQBAL commands. The first PHY adjust or incval write issued by
> ice_ptp_rebuild_owner() fails with -ETIMEDOUT.
> 
> Fix this by falling back to the existing SBQ-based PHY register write
> path when LL times out. This makes sure PTP is initialized when FW takes
> longer than expected to come back online.
> 
> Steps to reproduce:
> ./nvmupdate64e -if devlink -f
> Update E810 card with nvmupdate64e, and observe dmesg errors:
>   Failed to write PHC increment value, status -110
>   PTP reset failed, error: -110 (-ETIMEDOUT)
> 
> Fixes: ef9a64c07294 ("ice: implement low latency PHY timer updates")
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> ---
> v3:
> * actually add TIMEDOUT check in ice_prep_phy_adj_e810 (did do it)
> v2:
> * add TIMEDOUT check in ice_prep_phy_adj_e810 (did not do it)
> https://lore.kernel.org/intel-wired-lan/20260603114904.1297713-1-przemyslaw.korba@intel.com/
> v1:
> https://lore.kernel.org/intel-wired-lan/20260511095830.1095984-1-przemyslaw.korba@intel.com/
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 38 +++++++++++----------
>  1 file changed, 20 insertions(+), 18 deletions(-)

Reviewed-by: Simon Horman <horms@kernel.org>

