Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EFA376BD9;
	Mon, 27 Jul 2026 21:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785188182; cv=none; b=uDSMpLMj8k8ppLJ5UdG3idtdBeRKtbvzgFEss4eezn+C5brQUElwe4kN+7t/vam75iWDYDAB/eCZry+W5VYuNpqc9zCiaSqnQIQXVC2spy2kNGcvLV6fzvOsY1Q3R8uDtu4i7BiEKEs3hQu8rNkOaYclaCOU2XgcGJr4eExCnnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785188182; c=relaxed/simple;
	bh=NM3RX7o4jjB6Tsa4cDhyfvnVKU3okvkRkIvmQyOrdzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYKb7iHBVbw2+bhBYloN41ldgAdqojNDz0C10fruE/XSWM4XNFvi+m+w7+y+WRN5Q4qm44RkEEc1lm0yYFgGEdeOwBvtnAD514KRXieaA+QROnFqMhdy1zhIn1bc1Mva8bO1aLbLdf69HQCPTBJt5Tdsye244cpHUkd0DxBFqqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hTE9gEUu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hTE9gEUu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=b3T3DzBDuSosg7uIgvoVUhunZVeGVKkGXAucSejUto4=; b=hTE9gEUurB7GHUe58afalRupyz
	2uvPUhUN4L446g8Kpe41HV5Qb0IVZ7Oa/qQdpBJ8cY1PFTB2aLfZ2sh9DWx2/h84E4bTRTWrbiLcL
	41sbqtgrr9A4HnoI19MP5prCAGW9p/RQVLbYmppcwqfiG92/JkXgOZlNCrvIDVOH0Cs0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1woSzX-00EVZZ-EY; Mon, 27 Jul 2026 23:36:07 +0200
Date: Mon, 27 Jul 2026 23:36:07 +0200
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
Message-ID: <cf87c11c-308c-4a3b-a374-6e705a3a1d57@lunn.ch>
References: <d394347a-4162-49ea-b65a-c2e2bd3769aa@lunn.ch>
 <59cc79d4-cccb-4cc8-94d9-60c56e86b598@motor-comm.com>
 <c591a9b0-7fea-4953-93db-23f0f591e6ae@lunn.ch>
 <47d31704-e57b-4828-8c8d-0438ef43e49a@motor-comm.com>
 <ec6fb144-9b38-418c-ab6f-a02d5fb47b2b@lunn.ch>
 <4c4b9a41-cc54-4aa5-b302-631369e3c700@motor-comm.com>
 <87a4548f-ef0d-4ddc-9e87-155786cd5e31@lunn.ch>
 <638fda5b-ee2c-4f3c-94b6-37d689d48721@motor-comm.com>
 <b1f54c52-5719-414b-9bdd-3a0b0bc06252@lunn.ch>
 <42910a0b-52ee-401f-b8f1-69eb0e0858ce@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42910a0b-52ee-401f-b8f1-69eb0e0858ce@motor-comm.com>

> > So, please look at adding phy_package_lock() and
> > phy_package_unlock(). Maybe it is possible to make use of struct
> > mii_bus shared_lock? Please look at how that is currently used and
> > check to see if there might be deadlocks.
> > 
> 
> Ans: From my perspective, although a phy8824 has four UTPs, it uses the same mdio bus. 
>      Wouldn't it be possible to achieve the desired effect without using an extra lock.
> 
>      There are only two scenarios for phy8824 to swap to USXGMII reg space.
>      1. init configuration 
>      2. soft reset and isolate done in USXGMII side during UTP soft reset.

Soft reset is performed in phy_init_hw() which is called in a few
different places, such as phy_attach_direct(), phy_mii_ioctl() etc. So
you have to assume it can be called anytime. As such you need locking.

A big point of phylib is the collection of helpers to deal with
anything defined in 802.3. The PHY driver should be using these
helpers to do things defined in the standard. But if you are holding
the mdio lock, you cannot use the helpers. What i don't want to see is
your driver reimplementing code which we have in helpers because of
your bad hardware design.

Locking is hard, and given how infrequently phylib does operations, it
is going to be difficult to find and fix race conditions which result
in the PHYs becoming miss configured. So you need a simple, robust
solution.

If you think you have a solution to allow the helpers to be used,
which is simple and robust, please post it. Otherwise, i think you
need phy_package_lock()/phy_package_unlock()

	Andrew
