Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096AC3A8749;
	Fri, 27 Mar 2026 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774607365; cv=none; b=N44oT3nSc8c/umVtHp/HxmPOVvAZDMi9JYRa+kxbP7zg/H8R+RpA2SnJBkob2EBW5mf0hzwabi0XOz/SffWunOSgL2DX8oU4BBMGHUuuT6TAaDkKnBn3UGsloDZTijgTQk7N9E7ZM36kJ8pfgM7/9PRle/xsTELFTrBMa13KXDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774607365; c=relaxed/simple;
	bh=WJqGWYmeDmj6DndqQTNj4mbNbAGGUzdOvhFGch5/tCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNQeSbjiaCHsVkpZ2l+CqMHEA2STOQCn3sTotf2IY4/LAs/LTJ91Oi4bkn+aIeZ/zAzPwVYEAuxumRuU9Z9swXyJ1RvI+YufHjQg3F65BJNm61Cej40/hTQcbpSqZMT//Xf10Uqzm2MiP+/Uwk9l6R5OW9T59u+scCeh7zWj2Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=fMx0Zt/v; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="fMx0Zt/v"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oibXgPdifelILGEyL8w79vrjqA0vDQgs1l+3Fd7yHAA=; b=fMx0Zt/vGw8yJStmOWeSLDljWs
	CzzcVlJDbuKM3u2+AachILwBxQWZZPcVLtI6hCjyvweCuNk0/YghUYzktKx8e45LDUZHRbLzfPkiY
	uS7hk1jTc6zQUckDc2yAMOH2Q5gaNfUwIDTts+lM2vIqqdNuSw9A5iVrETYa/2phyj6+MuUFajk9Q
	z0q+3ApYj2ONvoh4YplOzv1irSf24JQAFJzO1Tv8tAsCMTBwgGf9041CblEW+dkxuuDKXcGIqFX0W
	IvpKetbdtddJS7Mf5luGhHoOqrsb0LlFzGjW1p17manY3VMoNIhMaSzc8yhTYFkJ2M7h2Sagd3/6Y
	Iowth9JA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w64RG-00AYxq-Lc; Fri, 27 Mar 2026 10:29:14 +0000
Date: Fri, 27 Mar 2026 03:29:10 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Izabela Bakollari <ibakolla@redhat.com>, 
	Edward Cree <ecree.xilinx@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-net-drivers@amd.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] sfc: add transmit timestamping support
Message-ID: <acZasPJqL9un4DVd@gmail.com>
References: <20260324160823.151472-1-ibakolla@redhat.com>
 <acOrt0LqV__xh_93@gmail.com>
 <20260326183951.686a522f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326183951.686a522f@kernel.org>
X-Debian-User: leitao

On Thu, Mar 26, 2026 at 06:39:51PM -0700, Jakub Kicinski wrote:
> On Wed, 25 Mar 2026 02:35:12 -0700 Breno Leitao wrote:
> > On Tue, Mar 24, 2026 at 05:08:21PM +0100, Izabela Bakollari wrote:
> > > Enable software TX Timestamping. The out of tree driver 
> > > also implements this.  
> > 
> > "The out of tree driver also implements this" is not the most technical
> > justification.
> 
> +1 it's an odd thing to put in the commit msg.
> Please fix and repost (keep Ed's tag)
> 
> > > diff --git a/drivers/net/ethernet/sfc/ethtool.c b/drivers/net/ethernet/sfc/ethtool.c
> > > index 362388754a29..c0038b942913 100644
> > > --- a/drivers/net/ethernet/sfc/ethtool.c
> > > +++ b/drivers/net/ethernet/sfc/ethtool.c
> > > @@ -231,6 +231,8 @@ static int efx_ethtool_get_ts_info(struct net_device *net_dev,
> > >  {
> > >  	struct efx_nic *efx = efx_netdev_priv(net_dev);
> > >  
> > > +	ts_info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;  
> > 
> > Don't you need to append SOF_TIMESTAMPING_TX_SOFTWARE instead of
> > assinging it?
> > 
> > 	ts_info->so_timestamping |= SOF_TIMESTAMPING_TX_SOFTWARE;
> 
> Either way is fine IMHO unless you see a specific reason Breno?

No specific reason, it is more a nit.

so_timestamping is always zero-initialized before the callback is called,
meaning = and |= are functionally equivalent today.

That said, I see these callbacks setting fields in so_timestamping, and not
overwriting it, given it does it later with it.

  ts_info->so_timestamping |= (SOF_TIMESTAMPING_TX_HARDWARE |
                               SOF_TIMESTAMPING_RX_HARDWARE |
                               SOF_TIMESTAMPING_RAW_HARDWARE);

But again, it makes no difference in here, given the value is already zero.
