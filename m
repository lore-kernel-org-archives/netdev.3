Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C945A3B9618;
	Fri, 16 Oct 2026 21:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792185325; cv=none; b=SzJO0khOvUsuXU++B1mt+u+LbGz38NvPkITlIJiGfmn2184+EmX6+RNkxRH76APuuvPKINaEyARRHNzDF8pu+eYs0tcRnKIUfmToZNyBvUeu/To+etzpd/hpyh/kg+iqaPQieXbLcBNfg9jQjVj/LYJx9w6L/zXvxYFsbRf838U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792185325; c=relaxed/simple;
	bh=uvOCeyTWk32Oc8I9oURGHXBD8dLhY+Awni9PyG6hjQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkR6Z2b1UluYsaJWC+GVMJCpLgZkolnDg6hytdOxogXNlR0okzekWqMI5EckTIfgY7T7S+JzjNwwmZKnfFR/4MBsi1NwteGWXTvHDpRyttd2gMjaXhTCBpOy5h4F2+FRATA5AUlvzPXKdsyCl8jKlRSD2Cu5KGHe8OFCA3y/x5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LuBokLXw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LuBokLXw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ivDw6bJhoWzzKstC5AO/as3JqfLON/2q0Bd7LFscufs=; b=LuBokLXwYer51MILgIjAoeX9Tm
	uyOPlz0ng01ZNyty1Dq0OKzVMVErhIVNOsdOb2iXOWe7DuZSWfyrNjZPz6XJbJnsVozptFJj+Wrzu
	Jvp+nfZnI7/1KuduKcSwDCPXs9q2Afx+n9le8SOABISZVlROHqMrAZ9JxSvDfvbGVvjo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xHpGn-00BEDd-2K; Fri, 16 Oct 2026 23:15:17 +0200
Date: Fri, 16 Oct 2026 23:15:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Robert Marko <robert.marko@sartura.hr>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, lxu@maxlinear.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, michael@walle.cc,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lrosu@maxlinear.com,
	luka.perkov@sartura.hr
Subject: Re: [PATCH net-next v2 5/5] net: phy: mxl-gpy: support MxL86211C
 lane mapping
Message-ID: <3840f9a8-ef21-4f15-b5f6-3d32251775d4@lunn.ch>
References: <20261016112033.949026-1-robert.marko@sartura.hr>
 <20261016112033.949026-5-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016112033.949026-5-robert.marko@sartura.hr>

On Fri, Oct 16, 2026 at 01:19:36PM +0200, Robert Marko wrote:
> Configure the MxL86211C mapping from physical TPI lanes to analog
> front ends (ASPs) when specified in DTS.
> 
> Leave the hardware reset mapping untouched when the optional property
> is absent.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
