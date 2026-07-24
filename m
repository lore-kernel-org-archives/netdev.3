Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F62309EE6;
	Fri, 24 Jul 2026 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784899137; cv=none; b=HhV8z+Z9IC3pH1gkFmlwVP0MrybMEnv99wIRLgS+1/pJmfFh7m2jA/6PslPR/H3mGyMe9hYj54wz2jwLekMY1xNjnpt7a6VRrgxuqzq9Evn6iIYF1MpHtNVIONth1eiMoTu+XU56cUAF/n535i/NOYiBZHh66swV98+kyE6h3TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784899137; c=relaxed/simple;
	bh=nqoA/tt0SpNuCyuIPstl2j1b3aCIuzgcW4emkyNWSjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSU7WCBY4Rf3kx0tlYD6uLUSocw9rYszB6PGpXXcBoMvsNpVK3VgI4i74bnxNtKQcex/MVewLcDEL4SRaqs8ub431zw2rOk6sTEzpsiSkP99QSxAY25urlMc4gqBPP15HUojjlaS5XRHZ6BXFsD4rFkdUyunZUhsxsx3GcyaXnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nJ0wxc6Z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nJ0wxc6Z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BMMj9fIoCRKhbm7WIOvi3EkgBjvFo6alOpypsyskP5Y=; b=nJ0wxc6ZBuuyR3TuyBDTCmxu0p
	rs6Ca9nBxDJ/PZpC3NNIAAebcJFUwpQucwdhhAgvLSfAWgvDpRxnfsNtY1FofdFRL9kBsgH6iUPYK
	AHW0pmjeaVx51Pi18kHEl/URv5r030/8b9ynWMt+9qs1a936IbFUn/IH8EDWoi314Av8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wnFnb-00Dznm-BY; Fri, 24 Jul 2026 15:18:47 +0200
Date: Fri, 24 Jul 2026 15:18:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	jie.han@motor-comm.com
Subject: Re: [PATCH net-next v5] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
Message-ID: <87a4548f-ef0d-4ddc-9e87-155786cd5e31@lunn.ch>
References: <20260721114810.660718-1-kyle.switch@motor-comm.com>
 <d394347a-4162-49ea-b65a-c2e2bd3769aa@lunn.ch>
 <59cc79d4-cccb-4cc8-94d9-60c56e86b598@motor-comm.com>
 <c591a9b0-7fea-4953-93db-23f0f591e6ae@lunn.ch>
 <47d31704-e57b-4828-8c8d-0438ef43e49a@motor-comm.com>
 <ec6fb144-9b38-418c-ab6f-a02d5fb47b2b@lunn.ch>
 <4c4b9a41-cc54-4aa5-b302-631369e3c700@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c4b9a41-cc54-4aa5-b302-631369e3c700@motor-comm.com>

> Ans: It is different from the m88e1111 PHY, which may support UTP, fiber, 
>      or combo mode. However, the PHY8824 is only used with UTPs, and 
>      its structure is as follows, which includes UTP0, UTP1,UTP2,UTP3 and USXGMII.
> 
>      RJ45 <----> UTP0 <------>
>      RJ45 <----> UTP1 <------>   USXGMII  <----->  USXGMII(the side of MAC)
>      RJ45 <----> UTP2 <------>
>      RJ45 <----> UTP3 <------>
> 
>      It is similar to phy8821 driver in motorcomm.c, with the difference 
>      being that one has one UTP port and phy8824 has four UTP ports.
>      YT8824_RSSR_FIBER_SPACE is used to access USXGMII reg space, Perhaps it 
>      would be more accurate to call it YT8824_RSSR_USXGMII_SPACE or 
>      YT8824_RSSR_SERDES_SPACE.

O.K, that completely changes my understanding of this device. Yes,
YT8824_RSSR_FIBER_SPACE should change name. And i would include this
diagram in the driver, and indicate how YT8824_RSSR_*_SPACE map to
this.

For the locking, look thought all the code which is touching the
USXGMII side and see if it can be moved into probe().

	Andrew
