Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0853736B05E
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 12:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775219311; cv=none; b=BK83iPXoyfVQE1VnGKPP+m4mL4pcEEgTvymmuawU+KehbmPz/fsgkuT55O6hx5SfObmdPoLgwy8LJGKC81oGzvyClO/z4S6yySXK6lNGOouC6qsQivtGjeyDQYwwzj7NjA75dgTEtKpX/yiZ+SSwH4zK2ua0n6JobrDw6s4Zvqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775219311; c=relaxed/simple;
	bh=F8iAS6pGjjZT/iyWHDVcTqPA4wqEVTbdVw3IDnLF1gY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iN3bx5XlUZ7t35zS75+J2CARduaBG0SOWHYk/JG9aZa11+0291mwd+EYUJoWI4FNGJrr6N+KF3ojtLJmDfgoz/LWcmOfXoCUsOVy21Mop6U0KNrBt9ZD+99Yl6C5YDtkmcIjuh+uHVMMczbM5d2qWu8g+1hnYnHjAQ7b3H/1cP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbmE9LQf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbmE9LQf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB730C4CEF7;
	Fri,  3 Apr 2026 12:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775219310;
	bh=F8iAS6pGjjZT/iyWHDVcTqPA4wqEVTbdVw3IDnLF1gY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sbmE9LQfsSQmlOrk1+mqZopEkGj6UWlRErrTj/zoKIqPbXRnvOVtJoPvk889CM3dW
	 K/I40NZC5kkc2UmIF9hR6uKWDoL2I36noxC86NJnHEPwSMuBOBREPiO6b663fIvvy5
	 r8HyljcB/XAr05GemW855eifOOYWl9z27l/UiHAIzXncPBXJLo2MTDtQWS9WcdBBUK
	 97Z2j1ppg18/H9Te41Kq49R+d4TfhHoaW8AA5e7B97phIsTImSRadc40I65fsXUKQE
	 FcGs2rLBvhDfla91t++y1hfFo1qedsBPU8Sfe6VbRO18aKGI86IdpH2Iest4rJAuiN
	 HE2pocYfAMkkw==
Date: Fri, 3 Apr 2026 13:28:27 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Marcin Szycik <marcin.szycik@intel.com>
Subject: Re: [PATCH net] ice: fix setting promisc mode while adding VID filter
Message-ID: <20260403122827.GA85281@horms.kernel.org>
References: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
 <20260327072332.130320-5-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327072332.130320-5-aleksandr.loktionov@intel.com>

On Fri, Mar 27, 2026 at 08:23:28AM +0100, Aleksandr Loktionov wrote:
> From: Marcin Szycik <marcin.szycik@intel.com>
> 
> There are at least two paths through which VSI promiscuous mode can be
> independently configured via ice_fltr_set_vsi_promisc():
> - ice_vlan_rx_add_vid() (netdev op)
> - ice_service_task() -> ... -> ice_set_promisc()
> 
> Both paths may try to program promiscuous mode concurrently. One such
> scenario is:
> 
> 1. Add ice netdev to bond
> 2. Add the bond netdev to bridge
> 3. ice netdev enters allmulticast mode (IFF_ALLMULTI)
> 4. Service task programs promisc mode filter
> 5. Bridge -> bond calls ice_vlan_rx_add_vid()
> 
> Crucially, ice_vlan_rx_add_vid() fails if ice_fltr_set_vsi_promisc()
> returns any error, including -EEXIST. This causes VLAN filtering setup
> to fail on the bond interface. ice_set_promisc() already handles -EEXIST
> correctly.
> 
> Fix by adding the same -EEXIST check to ice_vlan_rx_add_vid(): if the
> promisc filter is already programmed, continue without returning error.
> 
> Fixes: 1273f89578f2 ("ice: Fix broken IFF_ALLMULTI handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

