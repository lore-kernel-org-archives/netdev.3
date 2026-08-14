Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939CF46EF9B
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 18:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786733453; cv=none; b=aI/pyeIztIVhfRHzo+9KsVNFvpc/FylZe6Qv8Mz/Qsz1ylUJ5f2Iw/ucZTNxMgVk3S2/QJh77e13BpjLr2Jc9SNBFSwD4I1WiyNdWnchbIyyhYTACJ8o3lvivc4ymsBrUMSZ37Ya+C+LIbeJd7eYpVFAW0GMF1k2qSIt5qiL1mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786733453; c=relaxed/simple;
	bh=SmpFKlN16+iQahIWE3YzdXlCcCwa1Z+rglXJOu99p5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcxQx10WOE2CT7iyP8dPCx5etUIquWi2CKoos+kqNfv+YnUtqX/O5OMs2BXtlsYDWwK3mpa36JF5T/HxHZrGm1SvzVJUTpDGCp+a325nj8Xu5UnL1PF7PsJIx9lIKe13/KFLZrjRTk92PFMQim9951USyphyS1ThVhV0kw0ek+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mIBzU0yo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mIBzU0yo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7105qTIx/tygBopKU6KE39GW9W/dN1hBQtB90MqNR+w=; b=mIBzU0yo80HsOMhyzxM+ShMd/x
	CUfUiIfsprj8b6zSKhXh4BgRoMp0mHgaed4xeGaLtinW3iP2Ef5/5kJp1v3GrogFZVrEFCgy0XeId
	jstU5lJsvhFfqSsIa3xRymheJAsE1Ebr2tHelL3IDHXXF3Ga1C2uqXr8neuConnbDtd8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wuwzQ-0001Sn-BX; Fri, 14 Aug 2026 20:50:48 +0200
Date: Fri, 14 Aug 2026 20:50:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, jonas.jensen@gmail.com
Subject: Re: [PATCH v2] net: moxa: dispose IRQ mappings on probe failure and
 device removal
Message-ID: <0ef6a5c9-da9e-49cd-b474-5b1e48344460@lunn.ch>
References: <20260814175404.1616-1-diegomancera.dev@gmail.com>
 <20260814184216.388-1-diegomancera.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814184216.388-1-diegomancera.dev@gmail.com>

> --- a/drivers/net/ethernet/moxa/moxart_ether.c
> +++ b/drivers/net/ethernet/moxa/moxart_ether.c
> @@ -543,15 +543,18 @@ static int moxart_mac_probe(struct platform_device *pdev)
>  
>  	ret = register_netdev(ndev);
>  	if (ret)
> -		goto init_fail;
> +		goto free_irq_dispose;
>  
>  	netdev_dbg(ndev, "%s: IRQ=%d address=%pM\n",
>  		   __func__, ndev->irq, ndev->dev_addr);
>  
>  	return 0;
>  
> +free_irq_dispose:
> +	devm_free_irq(p_dev, irq, ndev);
>  init_fail:
>  	netdev_err(ndev, "init failed\n");
> +	irq_dispose_mapping(irq);

Calling devm_free_FOO() suggests there are other problems, likely a
bad conversion to devm_FOO().

Please take a look at the whole of probe() and fix all its problems.

Also, please read:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

    Andrew

---
pw-bot: cr
	
