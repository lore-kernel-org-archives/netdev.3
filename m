Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712678;
	b=3nTA/ylWoLipblSj8yn4ixGdHPcVL5n5liQ+etvVEeD1Q5v4BFFBJ8Vd5S1PHlXkRxnw
	 wPaP9z+gRLdUejgnVXT/YJ4GeKTQNu2G18H6f3Y+p/CXjojJB452ksXfAc8sID8cXBAJ3
	 WsQCZpalh8H1ReJqXEicStj7aefkCk/td55/jJy+EAeRfPqsMkqy+Hy7rcGbAUYzQ4dMn
	 4X9HE8tLa7bZeCwmrOdVpemloe8SwCwYwUPADC5B+UdxneNBiQUCJpJWA/qfvx8R+d6Yt
	 kwbcIQk06FIFQvbqKVMmy55k7bE/H0fOz/Aa4JeWTO9C+rWO4OBs6gCkOMWQzKpTMlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712678;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=rhTCd9eZcz8s08knKuHxKhiHDXK0Aw9iFKVIX6Xh6m8=;
	b=jATvvIZIJoV7l2O5ktbkuhECPBM/CRxJGU/CdO/3PEGehUrdFKwX6lJNOHWXy262q6J2
	 Oa9ze9AfOzqkoceJmNoToMGzQVa7NS8rhDoV6yTMQK0esmyM4whmOrFB+iqm8vaHOzsHZ
	 hYto3eMvMlkSbFAnQ8ivTG6/s5EL73g3P28oO6gEYAIcvCQOjTN1hKTU4XCtv45R81pfp
	 D2LZLi7BSVuCHvSWI44JDGDS5qW7lEG7s6nJlumQ6IdpT++mYhjn9QScN0cipmNDzV+1j
	 2LeTAXS3+57+ojSRx9u2ypuPlK1NiOkzTjvnBnA7Qx1PgiQy5wBKRBFaLgMaUa0c1jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=bdN+PHkt;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E67C606D81B
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 13:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E67C606D81B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=bdN+PHkt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rhTCd9eZcz8s08knKuHxKhiHDXK0Aw9iFKVIX6Xh6m8=; b=bdN+PHktcCVcI74jmQOC60gGsz
	1/wduXiR/zq9mgJ+ON74FPhmJYWlJHoL/5dqI+u+/z6Pob0WkTwYalteYTT38zAGGv+bOt079aUqe
	B++PlW2sOuT958IZdElThQ2oLZWMGsD611+vY8JVKgx6Ma0V55Y/tS5J/t58/7qAZGg4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xOEba-00E3xX-UI; Tue, 03 Nov 2026 14:31:14 +0100
Date: Tue, 3 Nov 2026 14:31:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dave Seddon <dave.seddon.ca@gmail.com>
Cc: Michal Kubecek <mkubecek@suse.cz>, netdev@vger.kernel.org,
	Taehee Yoo <ap420073@gmail.com>
Subject: Re: [PATCH ethtool v2 2/2] netlink: cable_test: require a value for
 the TDR parameters
Message-ID: <cc07992d-1ee3-4caf-a4fa-3e8f24787b6e@lunn.ch>
References: <20261102185122.1357927-1-dave.seddon.ca@gmail.com>
 <20261102185122.1357927-3-dave.seddon.ca@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102185122.1357927-3-dave.seddon.ca@gmail.com>

On Mon, Nov 02, 2026 at 10:51:21AM -0800, Dave Seddon wrote:
> first, last, step and pair (--cable-test-tdr) take a value, but their
> parser entries leave min_argc at 0. Given as the last word on the
> line, the value handler reads the NULL that ends argv and the error
> message prints it:
> 
>   # ethtool --cable-test-tdr eth0 first 1 last
>   ethtool (--cable-test-tdr): invalid value '(null)' for parameter 'last'
> 
> Set min_argc to 1, as every other value-taking parameter does, so the
> parser reports the missing value itself:
> 
>   # ethtool --cable-test-tdr eth0 first 1 last
>   ethtool (--cable-test-tdr): no value for parameter 'last'
> 
> Only the message changes: the exit status was already 1 and no request
> was sent.
> 
> Fixes: 9561db9b76f4 ("Add cable test TDR support")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Dave Seddon <dave.seddon.ca@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
