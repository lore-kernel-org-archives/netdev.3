Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FC53A256A
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775219906; cv=none; b=pwFt8XQjYkZCFktoZv8x/rpdtMb1HK6IRV5EH5Tw4djKOhRokvRo2W0zy59tQ7P+4ZoknKsSLQk7QSatUy91Sm8SGGfHDR1huvVs3PlMT8bPF0OULwiVvScfu3Q0+W6/i6wx1g9wrBy8pDb+KIx/EYmVZXs4wdad7RsNMvjI4Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775219906; c=relaxed/simple;
	bh=vtExJUQrc92Ifco2GsA0h+3adAwQZrofJkk/QL8wfVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gx9+EN0KbqSp9D0xzhBqzr7HolgyxWLfYWyrH9KRUnRr8pqL8zosmxAntN3qXcJ/En0notdIIpB0UkPEEe9hfzIjckGqyYAa9MLxd1hHVSQKMrtNJNDXpE1e50xZTxwaU/uX2zJIemqtkx/aERwukmw/khK5Sd9yu7+GbIEtcmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owMD2MNb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owMD2MNb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D3AC4CEF7;
	Fri,  3 Apr 2026 12:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775219906;
	bh=vtExJUQrc92Ifco2GsA0h+3adAwQZrofJkk/QL8wfVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=owMD2MNbB8BomrEpFep2mNuubOTC0ctJo1BvryeYY809AfhdmuyBwgB5UbCkIGZkl
	 qt6vtD9okfVecBI3ffr5iwmbvg7VBOTCnpRB0SGsMFSAcqoVfRlxe2noqkRPqQLviW
	 PNklmfVpi9uQnSNG9yVKY8jLB7cVa3V8POR4n6fAM4oBdp7w7BgD7STTC1F7dVNc/B
	 FXHMu7wpuw+4+unGE5pKAW4qC1hPF1SuAEPjd1gEKjqyj+V5jb4XGyOahaC89mua7N
	 GCtgu3vPqzmreVfJuvDLK0IWn/eoJKxikUWsjjAQx0UcIAjiUm+9uHXnL8CyJam1zD
	 vLMYgvShdYAoA==
Date: Fri, 3 Apr 2026 13:38:22 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Paul Greenwalt <paul.greenwalt@intel.com>
Subject: Re: [PATCH net] ice: fix ice_init_link() error return preventing
 probe
Message-ID: <20260403123822.GA94338@horms.kernel.org>
References: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
 <20260327072332.130320-6-aleksandr.loktionov@intel.com>
 <20260403123610.GA91152@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403123610.GA91152@horms.kernel.org>

On Fri, Apr 03, 2026 at 01:36:14PM +0100, Simon Horman wrote:
> On Fri, Mar 27, 2026 at 08:23:29AM +0100, Aleksandr Loktionov wrote:
> > From: Paul Greenwalt <paul.greenwalt@intel.com>
> > 
> > ice_init_link() can return an error status from ice_update_link_info()
> > or ice_init_phy_user_cfg(), causing probe to fail.
> > 
> > An incorrect NVM update procedure can result in link/PHY errors, and
> > the recommended resolution is to update the NVM using the correct
> > procedure. If the driver fails probe due to link errors, the user
> > cannot update the NVM to recover. The link/PHY errors logged are
> > non-fatal: they are already annotated as 'not a fatal error if this
> > fails'.
> > 
> > Since none of the errors inside ice_init_link() should prevent probe
> > from completing, convert it to void and remove the error check in the
> > caller. All failures are already logged; callers have no meaningful
> > recovery path for link init errors.
> > 
> > Fixes: 5b246e533d01 ("ice: split probe into smaller functions")

Sorry, one more thing.

I don't think this problem pre-dated the cited commit.

> > Cc: stable@vger.kernel.org
> > Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> > Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> The nit below notwithstanding, this looks good to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> > ---
> > 
> >  drivers/net/ethernet/intel/ice/ice_main.c | 12 +++---------
> >  1 file changed, 3 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> 
> ...
> 
> > @@ -5043,9 +5039,7 @@ static int ice_init(struct ice_pf *pf)
> >  
> >  	ice_init_wakeup(pf);
> >  
> > -	err = ice_init_link(pf);
> > -	if (err)
> > -		goto err_init_link;
> 
> I think now would be a good time to rename the err_init_link label,
> after what it does, rather than where it is (no longer) jumped from.
> And perhaps others in this function too
> 
> > +	ice_init_link(pf);
> >  
> >  	err = ice_send_version(pf);
> >  	if (err)
> > -- 
> > 2.52.0
> > 
