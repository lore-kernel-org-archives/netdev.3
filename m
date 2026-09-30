Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ADA403EA1
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776404; cv=none; b=TiX490ngmXK2xMLWlIgjBsEFyw0eVfpP4AvlCeD8HlR8pN8fM5fHZoYDp6t6T4dZ1iFfzIVkU/OkQ/V0XP3cp8VNFwbdynjMVhUqZLsBYhHaKAdhd2OXkfJVeHd/qRg3sjihYkILlLKXME8JIsvmyPFb+hixeJP4BWI7XmrAG1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776404; c=relaxed/simple;
	bh=zfZK92Vu7VT+WTnYUy0MR+k9vXoZ6JRZirF9jzPnXlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkUBc4bzkjSJQbw+tDwmTsqld0Ku5IlwMG3Ttid7leE05xiECtbt9ow7i4N3zb2ZwtshdKdt/noaLhVbP7GFuGP05/mybHlp8uG2G3bU8g0fiNKpvtAQ5OvwzNq//AMGAIDmWu0PUkx3Jsye9xL3zcpXEBNHogEHfMsYF68FEco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0+095rEV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0+095rEV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ur5sCb2/zPUnxSAqHFSK91EKL2zToDV9kiX5/Wiq76c=; b=0+095rEV/8SQ9eolCTSgRQ0lHp
	4mGLpaKMGw29zzHIOyut0SC6DWDWELNsqj4aMJKa+MFDAuEJ7XeBIREMTiZfJPgW9esvQdSUS8zo/
	dFU4X4qqDhapeBZFzQZAAXv8SuDI5urS64nPsD1HAIjxsJKfhnuRj2pun8XYuivM8CQ0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xBuk3-008AnH-Eu; Wed, 30 Sep 2026 15:53:03 +0200
Date: Wed, 30 Sep 2026 15:53:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shubham Das <shubham.das@intel.com>
Cc: netdev@vger.kernel.org, maxime.chevallier@bootlin.com,
	alexander.duyck@gmail.com, lee@trager.us, siddaraju.dh@intel.com,
	balaji.chintalapalle@intel.com, dasshubhamk@gmail.com,
	magnus.k.lindberg@ericsson.com, jonas.wirandi@ericsson.com
Subject: Re: [RFC net-next 1/2] ethtool: add interface capabilities query
 (intf-caps-get)
Message-ID: <8d44e2b3-532a-4c82-9458-40ddae333593@lunn.ch>
References: <20260930132151.932792-1-shubham.das@intel.com>
 <20260930132151.932792-2-shubham.das@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930132151.932792-2-shubham.das@intel.com>

>  extern const struct nla_policy ethnl_mse_get_policy[ETHTOOL_A_MSE_HEADER + 1];
> +extern const struct nla_policy
> +ethnl_intf_caps_get_policy[ETHTOOL_A_INTF_CAPS_HEADER + 1];

That is odd wrapping. As far as i can see, no other declaration is
wrapped like this. Is this because of the 80 character rules? It is
better to keep with the existing coding style.

    Andrew

---
pw-bot: cr
