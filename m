Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E914C10FD;
	Tue, 22 Sep 2026 12:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080898; cv=none; b=d0vFIdm06Wa9Oysx1G+fRLsv/E+RcMvJFO3iKK4AMA6zaZH9Q95ExOnAFQq4ogDceCAd0PylO1CxwpjBJJuYtTgt4UVHiND9Hgv0ERMeqs6Gk1lUY41jZmdTFzidwPXHfNmo4hj2ufD1GPmrfD2K8Y0r3k4cJtVqhaUWc+QCzg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080898; c=relaxed/simple;
	bh=Egx43Gno3efPzXga2XgdbYekvdF6KRF4TAySalGiAmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0LT18iBk5rV6bk5W90NOjuwXMKu9jo9DewvlTVr96aASLUBXtcVm+Ivcc5mvuE1fAMVgKezMo7iAGm7p54GeSnHzDNmkGC70bN2BX4O1jn+5qj9pZtYFDFegN2EXuw0+A4rGYaExqmRtVwH4nMxAa07iadH6nMzdM0RXA0UonI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=n0sx8gIf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="n0sx8gIf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=onCCwKwjx9nM7pyZtVHMnhqG5EFH5EuQYDpzsvOXR2Q=; b=n0sx8gIfc/LdDH6iYFIjSM+LfC
	9082xV7OvGUJpYpeKBLTQ1yXArIylkcsYQZXwHzECYzg8DJgDlNKe41NIklcxeK28ZYZY9rJj0KdJ
	LSnGR9wJ/khQGM7uw29FnysVbWjpc2Mi9Kp56GDyyNdgfIKeQqG6iacNooAH52gSZnwk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x8zoF-006adI-91; Tue, 22 Sep 2026 14:41:19 +0200
Date: Tue, 22 Sep 2026 14:41:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
	horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
Subject: Re: [PATCH net-next v8 1/6] net: dsa: motorcomm: initialize
 dsa_switch based on chipid
Message-ID: <76d77650-ca98-4815-9c6c-d73d5913eb64@lunn.ch>
References: <20260917082236.3427168-1-kyle.switch@motor-comm.com>
 <20260917082236.3427168-2-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917082236.3427168-2-kyle.switch@motor-comm.com>

> +struct yt92xx_series {
> +	enum yt92xx_mode mode;

Is this mode value actually needed?

Other than that:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
