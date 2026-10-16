Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FF43A255F;
	Fri, 16 Oct 2026 21:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792185628; cv=none; b=qqbL41kI9LdpIaKJz1Wb5qPEyVZHP/9qVzQZReZoP6CalckkIG+jSbO4rjOKaPY7W7ThinZZuWAm1tJhbltaX8Y9Mx+cAokZhQlf+YHAHQU3k2wdmBOkoG6S93SNDApI7eA9ltPoiGNjoanq2EnwYyKJ3ykIA+kxF7lNHiIuiBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792185628; c=relaxed/simple;
	bh=3tWgWRurkGM4RcABbyobiv8UywCAr0DWbUZfUFSKFJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbaLSIY4eepEZdCBYTbUihojbo4ae+Ks16p93XkvWjPNNgQCPlXQIyjpGG7dlCZqvMJajIHrd7xZ0d4NDjrDbMRNxM7lT50LFBQ+d6yZRoZC8jSoKnWmO1N2cDi/oD2vtZCu/FQLdgrZBSBCwl1d1n/sw5eekP/DxwlPfkZMHt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CTUTXEos; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CTUTXEos"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZYa51UvLksBCVLWhobeX+7zoR9DCUur+g2uNbn5PXt4=; b=CTUTXEosgjzr4XjI1Aheq1QkTl
	qBmfQCPnymsEuHcfsv2K1sLtl2buzQNU2SmIpE4Fn+jHEKDqyhWXIEMc9k0g61dvVSbwAcOYAOFGF
	P67zPJLPXIaWF9GGaRIXysmwumVuwktZtYp4RMSx9RYaPFdVYwDVDj1knUXcgPgOUI0s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xHpLe-00BEIC-Eq; Fri, 16 Oct 2026 23:20:18 +0200
Date: Fri, 16 Oct 2026 23:20:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] net: phy: aquantia: add get_features()
 for AQR113C
Message-ID: <202c1214-ad73-477c-b74d-d2ca47894c46@lunn.ch>
References: <20261016-net-phy-aqr113c-fix-pma-capability-v3-0-0bbb1b84035d@oss.qualcomm.com>
 <20261016-net-phy-aqr113c-fix-pma-capability-v3-2-0bbb1b84035d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016-net-phy-aqr113c-fix-pma-capability-v3-2-0bbb1b84035d@oss.qualcomm.com>

On Fri, Oct 16, 2026 at 11:23:19AM +0800, Hongmei Xu wrote:
> AQR113c does not correctly report its supported PMA capabilities
> which includes speeds like 10G/5G/2.5G. Add get_features() to
> explicitly declare 10G/5G/2.5G/1G support instead of relying on
> PMA register reads.
> 
> The AQR113 likely has the same issue since it is a closely related
> variant, but this fix is limited to AQR113C as that is the only
> hardware available for testing.
> 
> Signed-off-by: Hongmei Xu <hongmei.xu@oss.qualcomm.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
