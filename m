Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDBB488207
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 13:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207789; cv=none; b=jTFB1I56jCQmHMyCFQjDPgy/Dnnp1UYXzu4BgPfXmeWqdCXjgIK6MNQgavEGAwoV9gFQO59V0QgUdVZ/U+hWPrcP3T3Rc97itI/DoqMYCsO3KTki4uQOnptzFUvAzrZkAWIUsVpbMhX8uUbegzgej4ugqoynsbnyc0T+rzkhyJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207789; c=relaxed/simple;
	bh=H65N3EOGMV7IHiGWKvhQ27YhYB4AOiCq/TAT8IfBklw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5o1fpHjcniisutkrGSSy/gypz2iqKOBzS64TzsxRHSD6aF/Ax7FMqMHE9Rj3C3J53V0zUNXzUA0gjSTDdFQgih91DhA28LKA9QGBQWgVgUCdr/9Jk1WQBwdYR+MlhqNdUSN5182QbmIUKZR1abWs0tfkSUpDBskagB88WkHado=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Bm+4CLJy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Bm+4CLJy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=L8cSsMAhLZXTeMe/OI/jHXOBM/Y0pT1Kn/XunsfD/Fc=; b=Bm+4CLJySck6byde2fyVmq4mP7
	eEGrxU7XVq3shqEo1gx3fh8fX43C5fRCJh7leCL7pRzoNVD5xRxx2Ffno9Ff1Mty3ve/oeiBI+5r4
	7XDfUWTluJAz+HkGchvJ9kueZvIiOOi7ySGeWxe38LMl0pLXQwlcSjm4SkPevexEORr4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xDiy5-00934n-SV; Mon, 05 Oct 2026 15:43:01 +0200
Date: Mon, 5 Oct 2026 15:43:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Das, Shubham" <shubham.das@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>,
	"lee@trager.us" <lee@trager.us>,
	"D H, Siddaraju" <siddaraju.dh@intel.com>,
	"Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>,
	"dasshubhamk@gmail.com" <dasshubhamk@gmail.com>,
	"Lindberg, Magnus" <magnus.k.lindberg@ericsson.com>,
	"Wirandi, Jonas" <jonas.wirandi@ericsson.com>
Subject: Re: [RFC net-next 0/2] ethtool: add interface caps and PHY tests
Message-ID: <a35f3ff2-6e57-4e97-a453-a7a9c725f723@lunn.ch>
References: <20260930132151.932792-1-shubham.das@intel.com>
 <fdabe2a5-d198-423a-a9f6-1bb842b8d372@lunn.ch>
 <SN7PR11MB8109460641FC15211D8E7708FF962@SN7PR11MB8109.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR11MB8109460641FC15211D8E7708FF962@SN7PR11MB8109.namprd11.prod.outlook.com>

> I can share ethtool command output and test logs demonstrating the API in use
> (PHY capability reporting, PHY test execution, etc.) if that would help validate the
> interface until the remaining dependencies and driver changes are posted upstream.

The code is not going to be merged until the driver side is ready. So
there is no rush.

      Andrew
