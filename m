Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A725E53A886;
	Tue,  8 Sep 2026 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870054; cv=none; b=gHMKjus8fU3DT8tpr27DilKjxNEf3LOar71NvOSDnStGcnrLLVGSPoSAEtO5subJd0aiG1YnrMQaQ4JCXqD4gOK3tfwDnbFe+EXAf9IQHCV0HhmHccN77SjSEPr2ZD05mnjGXGKFl6ZEmX/xXaDnMrmmKpfg+tXAr09xwFMgans=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870054; c=relaxed/simple;
	bh=3fif8XXnfu86Trd6k3leQLNw8UkFq6hVdLqyTdGHB1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jtv9IU7UZzSPXre7kwbwUd5Up6qjJYMlyozNqdSui1nByP1/R5kzNNgVDdsXnFQP3D03cGOdixiey56FVUOagJet9cEolzFAQFnj62j8wyhrVfWZlUNzoDZPeLEbUXvjNU/ak+zGtVeTBp+x5B7h3OpQuexfNMdUtSe+OH5c4zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXZG2LvN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXZG2LvN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3981F00A3D;
	Tue,  8 Sep 2026 12:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788870049;
	bh=cWvpOXyjjZrhIetQiwdMhEUgIE2tbl5vXLToXqUCVRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IXZG2LvNeocHOQVTxDTDAErRRrlRN46C/5PV2WAfWlyj+j9UYwNHXgxJKiCySZNNo
	 O7CrFoUhVsyWJaqaucuMC98xswl6QO8zmMCmPRUv7eqbeggKimmI9KLX0WpYAu1t6L
	 AEjHsU8BOvOi+RBoMnV1dmdtc0PtKvprENYzIR0ojalB3HF8ZtrVXuYRNE8iJaL2MU
	 r9WYetbK8pfI6DJW//4YUJJsEf3j33XoQyrUxe7anWtUBhdVyE5S0Pwb3EaFyCU18k
	 YwnAlCn0QZaqBORJYmKp/xapXUnu/2OuLju/oY+jqhQxvy4A++SyXtun+M00QD9JAC
	 zbv7ilSwlLqmA==
Date: Tue, 8 Sep 2026 13:20:45 +0100
From: Simon Horman <horms@kernel.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ice: drop pf == NULL check in
 ice_pf_state_is_nominal()
Message-ID: <20260908122045.GV40544@horms.kernel.org>
References: <20260903132037.81346-1-ynorov@nvidia.com>
 <20260903132037.81346-3-ynorov@nvidia.com>
 <20260905183245.GD40544@horms.kernel.org>
 <apyrTFlAsrifzqzB@yury>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apyrTFlAsrifzqzB@yury>

On Sat, Sep 05, 2026 at 07:52:44PM -0400, Yury Norov wrote:
> On Sat, Sep 05, 2026 at 07:32:45PM +0100, Simon Horman wrote:
> > On Thu, Sep 03, 2026 at 09:20:36AM -0400, Yury Norov wrote:
> > > The function has 3 callers, all except one explicitly require
> > > pf != NULL. Add the corresponding check to the remaining caller,
> > > and remove it from the ice_pf_state_is_nominal(). It makse the
> > > fun function a one-liner.
> > > 
> > > Signed-off-by: Yury Norov <ynorov@nvidia.com>
> > > ---
> > >  drivers/net/ethernet/intel/ice/ice_lib.c  | 3 ---
> > >  drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
> > >  2 files changed, 1 insertion(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> > > index 73996e3022ef..6d5b8acc4764 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> > > @@ -1705,9 +1705,6 @@ static void ice_vsi_set_rss_flow_fld(struct ice_vsi *vsi)
> > >   */
> > >  bool ice_pf_state_is_nominal(struct ice_pf *pf)
> > >  {
> > > -	if (!pf)
> > > -		return false;
> > > -
> > >  	return bitmap_empty(pf->state, ICE_STATE_NOMINAL_CHECK_BITS);
> > >  }
> > >  
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> > > index d88835482d3a..168d85f9477f 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > > @@ -5521,7 +5521,7 @@ static int ice_suspend(struct device *dev)
> > >  
> > >  	pf = pci_get_drvdata(pdev);
> > >  
> > > -	if (!ice_pf_state_is_nominal(pf)) {
> > > +	if (!pf || !ice_pf_state_is_nominal(pf)) {
> > >  		dev_err(dev, "Device is not ready, no need to suspend it\n");
> > >  		return -EBUSY;
> > >  	}
> > 
> > Is the new condition necessary in ice_suspend?
> 
> IDK. I'm just trying to stay on the safe side. The
> ice_pf_state_is_nominal() was safe against pf == NULL,
> so I'm trying to preserve the invariant.
> 
> If it's impossible, I can do:
> 
>         if (WARN_ON(!pf) || !ice_pf_state_is_nominal(pf)) 
> 
> This would imply unlikely(), and more verbose than an implied
> assumption that pf is never uninitialized.

Let's stick with what you've got.

Reviewed-by: Simon Horman <horms@kernel.org>

