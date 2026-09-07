Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE581BC08F;
	Mon,  7 Sep 2026 11:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788780917; cv=none; b=hJufFDm/Tnyu4vDn4WpB+GUyyzU2SA3AGteLJTfsB4DCDyXz5iIO2JW1bviTYQEma9iRRQp5dm7NBK7wBit0eNvYC2vDcV/l5lpfYvn4B3q8BJtnxBPMbcreCA5sqtZT88YoalVG9ygCNv9QRvzijRWg0FUNyNC8jd9cs2qDNs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788780917; c=relaxed/simple;
	bh=ysAidMn7BakQ3UvZ7+fEvqljRALct2F1fLnGzOYpA5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyPY+k8FHD6ju0CXAbQalLK3wWyZXJ9QSyRXYmaxx7fr1vq0ZkkeZlwFCkrKoUu6E1ekd5sy2U/14sGx8KZVDPRwXNYwT86qCS4PPfCbxfk5+D1Mh8Uau9F3l81N1bEByAhAENYI2pUgNnKFWhEzTboXOBh4mQA5+Qf86UXMijg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3CBfD2s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3CBfD2s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4BE1F00A3A;
	Mon,  7 Sep 2026 11:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788780915;
	bh=HRNjnGWDOzF1WHQQlRNgifeUDjlJR2mBMCuSJpabEPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P3CBfD2scFJ6nXiUiRo6sb+GBTSAzFrOwPZexGGTVmsdLDq2HGg4yDGXF9OkWk8B0
	 udV6+geagg2A/4lT00eV6vZJYRyENl6j5DgcWG2g9UE+/Gu161If00eRxiw+0qXtRL
	 i40Z8bi+Cx4mmAwDA+qSEc3AufSrxe05NRlPX+lfRK0/r56dxNiTIqkFFHjkTx1sBw
	 Qjs1UAu5XamA99+2Kl/4ZkgBmwwQW/vP7vZn8tsd3OenLXTHR259ZMvZbodrkWfEtM
	 SWheiA7vZZvzt3MT1nM8kxUx5tf01zPMxB1FNRkMv6S4KYlnX8QzxC0V4WaMztSwCI
	 CDVh3WTDROUpg==
Date: Mon, 7 Sep 2026 14:35:12 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com,
	Hariprasad Kelam <hkelam@marvell.com>
Subject: Re: [PATCH v2 net-next] octeontx2-pf: report port connector type in
 ethtool link ksettings
Message-ID: <20260907113512.GK13683@unreal>
References: <20260907042827.4077114-1-rkannoth@marvell.com>
 <20260907072315.GG13683@unreal>
 <ap6ZmZ4SwFa4Xf4_@rkannoth-OptiPlex-7090>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap6ZmZ4SwFa4Xf4_@rkannoth-OptiPlex-7090>

On Mon, Sep 07, 2026 at 04:31:45PM +0530, Ratheesh Kannoth wrote:
> On 2026-09-07 at 12:53:15, Leon Romanovsky (leon@kernel.org) wrote:
> > On Mon, Sep 07, 2026 at 09:58:27AM +0530, Ratheesh Kannoth wrote:
> > > From: Hariprasad Kelam <hkelam@marvell.com>
> > >
> > > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> > > @@ -1231,6 +1231,8 @@ static int otx2_get_link_ksettings(struct net_device *netdev,
> > >  				OTX2_MODE_SUPPORTED, cmd);
> > >  	otx2_get_fec_info(rsp->fwdata.supported_fec,
> > >  			  OTX2_MODE_SUPPORTED, cmd);
> > > +
> > > +	cmd->base.port = (u8)rsp->fwdata.port;
> >
> > You should declare identical fields with the same type and avoid silently
> > casting variables.
> >
> > Thanks
> You are suggesting to split rsp->fwdata.port to  u8 port + 7-byte pad ?

pad or reserved, something like that.

Thanks

> Currently FW is writing as 64bit.
> 
> >
> > >  	return 0;
> > >  }
> > >
> > > --
> > > 2.43.0
> > >
> > >
