Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF07A3E1696
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 08:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785488087; cv=none; b=S+/gPVRL9KXRbjDuRVK4+Y7Ay02/IvGA/ReQmwE9S1b3q0PmNmBsA6RIqbHHpSjiEDIIH5t6H6C5C0MbA+SPiuQypHE/SxZ9XRinEDUWLtryua5lve4jOU7NoxURq1mhnsLPB7Ca6mPc/BjFksHxJCdIVTndIpCAEoSFnszhE7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785488087; c=relaxed/simple;
	bh=4TIZFCxvQ3lb2o8NlATOsY+GXtdva+IBScZ/iC/IsVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfQ4eLdO5EQWb0N/GOvZrAouRhK2xVsLhTdLpmkAfOxv2ELzFo3PoplgrZsZUtByteEsdjN5ehz28ac4HlK1wK2C93kNx7eWTG+sIuLJCNykv+9MuC2yh5lsLhMb/SvVGTkPwmFC+hBQeJlzqKMBpVUm8EvCHeNcX/hoBDL/U/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=cb6jEdQt; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="cb6jEdQt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XkIAAkZdHWYJXFyYSdFpMyLcf6bEenJ0HnHrSD0oU9A=; b=cb6jEdQtCK+ne/FsEbQA0Sbfv0
	ylUDCCUN9wTlDjF7V2Fmp6pyGx73EsuDUuZxZFO+XU4d7rqpTHysoyN9DWaFuscT2F+06JmOYSqlu
	evoIRheyWsDKC+dK3g8RS4aQIzGPzsQABQv1HinYqNzMVjrSEsIQAmjRIhJfTDdniYdTPm2ZE3kYj
	hwpAjE2blqO4BXaQ2xtHTgZnrjqlwtb4LCIDpcgkzjp9hdgQQQU3NJ5LDJuC41QwcFbLg9HMSt2jl
	X+q+4OxTxLO5SaUtJQVQDaS5JwDoPqamPB6rzzVHB2UAvLJIqB64OEVt43a0jiuI0po2hhmGW5N9r
	3qAcNdWw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wpj0t-009td9-2h;
	Fri, 31 Jul 2026 08:54:44 +0000
Date: Fri, 31 Jul 2026 01:54:39 -0700
From: Breno Leitao <leitao@debian.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com, 
	duanqiangwen@net-swift.com, linglingzhang@net-swift.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next 1/5] net: libwx: fix suspend/resume for wxvf
Message-ID: <amxiccvSvj__32bR@gmail.com>
References: <20260731074958.19333-1-mengyuanlou@net-swift.com>
 <20260731074958.19333-2-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731074958.19333-2-mengyuanlou@net-swift.com>
X-Debian-User: leitao

On Fri, Jul 31, 2026 at 03:49:54PM +0800, Mengyuan Lou wrote:
> Fix the suspend/resume sequence by:
> * protecting the open/close path with RTNL,
> * closing the netdev before releasing interrupt resources,
> * re-enabling the PCI device and restoring bus mastering during resume,
> * rebuilding the interrupt scheme, and
> * reopening the interface when it was running before suspend.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> ---
>  .../net/ethernet/wangxun/libwx/wx_vf_common.c | 21 +++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> index 26de78e9a69e..e8448783df3e 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> @@ -16,9 +16,13 @@ int wxvf_suspend(struct device *dev_d)
>  	struct pci_dev *pdev = to_pci_dev(dev_d);
>  	struct wx *wx = pci_get_drvdata(pdev);
>  
> +	rtnl_lock();
>  	netif_device_detach(wx->netdev);
> +	if (netif_running(wx->netdev))
> +		wxvf_close(wx->netdev);
>  	wx_clear_interrupt_scheme(wx);
>  	pci_disable_device(pdev);
> +	rtnl_unlock();

Why not before pci_disable_device()?

>  	return 0;
>  }
> @@ -34,12 +38,25 @@ int wxvf_resume(struct device *dev_d)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev_d);
>  	struct wx *wx = pci_get_drvdata(pdev);
> +	int err = 0;

Nit: You don't need =0 here.

otherwise looks good.
--breno
