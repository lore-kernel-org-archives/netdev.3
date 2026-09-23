Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8589B282F17;
	Wed, 23 Sep 2026 22:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790204078; cv=none; b=EypypDvYfRKw9IKRKoXdtYj0LtZPtmpvtXAxhvNhXxMUeQ360JzeSW1HtXh+EszWR5ywdVqENOkiaNn89yuh0MXykrb7YzA6Kiv7vdEWlEH1bEt6YWU9ZSVPwjXZz5Siu1k3oykt5tA5GRcpX7LUKUYKNzAmT9fGV8TSzW8fXx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790204078; c=relaxed/simple;
	bh=BLoiTVOtwkjTpKLxUH/fCJJp5XbtLMkshSmZF6wBusg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbnadSadKErBt1tNTPRbjhPImU8LZoM+KNIjucgF0SZpeyN29uNtWJmVR0QrnowQYryhfI4eKHIXli/L2swxtsQ+r0GDB+p0B26/HLanD8EJ/sI7f0kUOiz5jK7JXowIPqOel2Itsz89asjewi8d/0RKEuDlj1fgelcuL+G+0Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6brhv5+j; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6brhv5+j"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Hwp3buGvqeazOgPHYWP1T8YE6Ogl+I4cqEaOOWpq5+s=; b=6brhv5+jQUXJmbhNfrSR+yncLD
	sP2c7aOQLeOu6k4XwYNybi9CvKyXp5xwGbPOze9HA0gZial50bMkJiwhkkvmX74rrzJ8ScdddSzg8
	uWD0xeiKH4RWeMBgMPzCygXKCfjSy9HBYkvSulLJYC4MrZ0WFlnsRKaWGUzKQpFDzeHY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9VrA-006tIk-Ll; Thu, 24 Sep 2026 00:54:28 +0200
Date: Thu, 24 Sep 2026 00:54:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: phy: marvell: add support for PHY LEDs
 polarity modes
Message-ID: <c9c0e770-6bea-4acb-aca2-ac56f044ddef@lunn.ch>
References: <20260923204614.471409-1-olek2@wp.pl>
 <ac224909-5f7d-447e-a0f9-be0d1565a700@lunn.ch>
 <a174b2c7-3778-4f8c-be5a-2bd94bfe09ed@wp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a174b2c7-3778-4f8c-be5a-2bd94bfe09ed@wp.pl>

> The number of LEDs depends on the PHY variant:
> 88E1112 -> 4
> 88E1116R -> 3
> 88E1240 -> 4
> 88E1318S -> 3
> 88E1510 -> 3
> 88E1545 -> 4
> 88E1548P -> 4

Ah, i had a quick look at the current code, and all the functions have
a switch statement with case 0, 1, 2. So i assumed that all PHYs have
the same number of LEDs.

So any PHY which does have 4 is currently not supported?

So i agree NB_MAX_LED is not a great idea.

   Andrew
