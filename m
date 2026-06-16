Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D959A3DA7C2
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 19:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781638497; cv=none; b=RlNVA9/gEZQKHC1Xe8v471X6LYIIe6eNqXSuHzhwdMn9WIY5TEXqSboKfiyQ/M65Gu/5tQeZgKLjjQD9R5VMO9nAFMpEnAkU/DzEWJdwfJI3GCZGIBEbsz2++m41nLLXBTKJEyD1p40YKltprkAvSoId4W7r2N88h+W21LoTMjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781638497; c=relaxed/simple;
	bh=juXgpAOjxlBKw2vqqUR+X+FlI4/LmoyIW5dMLQuggnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAWzPih9hdGDNTbDH9DN1hiN9TjLmtilXrmlIzaeU0kaZTcyRQNdgO0V5MHXRk80d+HUsTfhjNArV2HyKPjm8VFsbemrEHs4IRjVf1zLz67xA2ikHQQeQDTUay2fSigHhw0ZuiAaN2TJ5UYKav8uFkibbcMDkMRCNOaJX/9XNy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=duRsJWxR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="duRsJWxR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ipZ2eOXmI7/ITECTv5m2nJGPjex1DXsJQzCrxYhD0tQ=; b=duRsJWxRLHM/2gfsJYBVRgd+Sf
	TfZI86xxUAF68kaNC6k3csMBHTfWgALdr0sgHTKJMsNEdEhAUnIR+/ZWTa/bf2WInoHay6SPAI/YT
	Dt9VAHEgP7OgSWZcZSr7UvlBSCNGEssYIP8ltTvZZKOuFF/gfGPa3VEpQW0K4Ng9+IoQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wZZYd-0081W0-Qa; Tue, 16 Jun 2026 21:34:47 +0200
Date: Tue, 16 Jun 2026 21:34:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Philippe Andersson <pan@iba-group.com>
Cc: netdev@vger.kernel.org, Ludovic Calmant <Ludovic.Calmant@iba-group.com>,
	Fabian =?iso-8859-1?Q?No=EBl?= <Fabian.Noel@iba-group.com>
Subject: Re: [Bug] incompatibility between 'e1000e' and Aruba AOS-CX switches
 (too small inter-packet gap)
Message-ID: <bdf0a4b8-e414-4df7-833c-3051987c3f2b@lunn.ch>
References: <457d1617-bd7f-44c5-a9af-7ba8aa9250f4@iba-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457d1617-bd7f-44c5-a9af-7ba8aa9250f4@iba-group.com>

> A support ticket has already been opened with Aruba, but it's unclear at
> this stage that the problem is on their side.

How easy is it to reproduce? Can you run a git bisect from the last
known good kernel version to the first known bad version?

      Andrew
