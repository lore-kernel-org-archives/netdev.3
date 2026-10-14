Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D0D4908D1;
	Wed, 14 Oct 2026 20:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009356; cv=none; b=Y0epeAhQ0f/k0VO+30JgxprnXTO436mPDCM1jRVKTVVGYL4gF2LElKzUDCcI6shd6QLPnPrat1iihB64Rnp/s7zTEHdl4UKw9RqPRVJN4gk2vEUDYktPubyYqc4AQsaOtB/AK7FJWEQSWN+cjOYcGguWCske+bsIxD7xEXo+biA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009356; c=relaxed/simple;
	bh=BJDKwYhbf/Rxj9+ETlHtwMw02Pzq6j+a0uHsAVmHeQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3+JBEpNuVz+tI+YJ61n/CVk8rg3UX2x4bRIGopDV8qtx9WdTMUDDiSv0eE0e5xRvahwMqsuZXLkwaYJ7MFspyD2PolW2+xsdBrVOz0L7z3UD2SDK6xqSmWld9uwGRF6hVAe41M+hUMuGmgZqUKEps28BdpFEUV4dHWXzgUgNfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hyROOirC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hyROOirC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+lgOL2ulPahwJN6jZRnnLS6q11epqQte8G2+w9DfD1w=; b=hyROOirCFWWpVPs3cviThT1aL5
	YVlYU9IZMqemL6WZfbqsGvT3O9fxuIEsOzEmreyuoeg9XF2/naMFNlNvf/24ed/5g72vuS6817zeF
	zCSPv7lT8H2iHkI93KxtRBqoHdgEOYJX02FAmT4t3mZLwRChsF22X7bc+lgIApb93eg8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xH5US-00AoHx-E2; Wed, 14 Oct 2026 22:22:20 +0200
Date: Wed, 14 Oct 2026 22:22:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kohei Enju <kohei@enjuk.jp>
Cc: Ayush Yaduvanshi <ayush37735@gmail.com>, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: intel: ice: Modernize ice_vsi_free() with
 scope-based guard(mutex)
Message-ID: <0079adea-1e94-4fa7-8956-a4b4a32805b5@lunn.ch>
References: <20261014110552.56976-1-ayush37735@gmail.com>
 <as-tT0nDrchWa96T@x1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as-tT0nDrchWa96T@x1>

On Thu, Oct 15, 2026 at 01:36:35AM +0900, Kohei Enju wrote:
> On 10/14 16:35, Ayush Yaduvanshi wrote:
> > Signed-off-by: Ayush Yaduvanshi <ayush37735@gmail.com>
> 
> The commit message is missing, and this patch seems to be a clean-up
> patch, which is discouraged in
> Documentation/process/maintainer-netdev.rst. Also, this document says:
>     Use of ``guard()`` is discouraged within any function longer than 20 lines
> 
> > ---
> >  drivers/net/ethernet/intel/ice/ice_lib.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> > index 9e08db376d3d..c695df442822 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> > @@ -457,7 +457,7 @@ void ice_vsi_free(struct ice_vsi *vsi)
> >  		return;
> >  	}
> >  
> > -	mutex_lock(&pf->sw_mutex);
> > +	guard(mutex)(&pf->sw_mutex);
> >  	/* updates the PF for this cleared VSI */
> >  
> >  	pf->vsi[vsi->idx] = NULL;
> > @@ -466,7 +466,6 @@ void ice_vsi_free(struct ice_vsi *vsi)
> >  	ice_vsi_free_stats(vsi);
> >  	ice_vsi_free_arrays(vsi);
> >  	mutex_destroy(&vsi->xdp_state_lock);
> > -	mutex_unlock(&pf->sw_mutex);
> >  	devm_kfree(dev, vsi);
> 
> This also extends the critical section, as devm_kfree() is now called
> while holding pf->sw_mutex.

This is exactly why guard() is bad and should not be used.

     Andrew
