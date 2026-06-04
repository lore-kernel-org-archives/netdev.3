Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1AE1ADFE4;
	Thu,  4 Jun 2026 12:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577637; cv=none; b=lmZHvIFXtlsKdhtUh7SqbytIVKuvuu8/szS/D7UD5CGqqzF/UOD/k8cGxuA3Mo+4wqt03MnsNVmNhDqY0+wCuXamceidrpRIz+FY5ocqOsOfixll8yf5P/hcSmx9L6uBfiWg25zsRKoau+DrNnS5ZGF8IKp5BkCq5RAdstwXXwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577637; c=relaxed/simple;
	bh=6vUqD9r4dFF1EMmpNeRHUUKWwnil/EYuL8gELtHMJqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkrGErYh0ZUW7yGNE1BN9usC8C2leWRJ+Aub9qRZWCH/dyuoksY55qZVrIiahtEQJsi37v0b2FnL4nkh+4uTZIou8fge2SP7nl4Xp0IuWyW+5iAk7d3ZHUF097vHjTuNHHtPy/YA3IcasIVIr8aP94IYno+KztYxRAJZCdVh3UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JL0A8Os+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JL0A8Os+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wl69BemRjS64+/8O1S3AjTCz9jiMA+sY9JfxwXgC6VQ=; b=JL0A8Os+X3zvIzyi5rYTT23gZ8
	h6lNZ7TcHLfXIU4DDztYJW4at2X4u4F1vIAGeHFBbpcrihlVjcTiB8fM0pbsir5jWoCaXULjhYE8M
	mN2KfFSdZmtqr5At9fmqHAGmvfLS9oCbvsDZpcxaTQmhI8dX4twjZylUCAQbsKHQ6jeI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wV7Zt-0062oL-Kp; Thu, 04 Jun 2026 14:53:41 +0200
Date: Thu, 4 Jun 2026 14:53:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chih Kai Hsu <hsu.chih.kai@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
	nic_swsd@realtek.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH net] r8152: handle the return value of usb_reset_device()
Message-ID: <c1ddf8f3-71f7-434c-ad10-64096b65fe51@lunn.ch>
References: <20260604092247.27158-450-nic_swsd@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604092247.27158-450-nic_swsd@realtek.com>

On Thu, Jun 04, 2026 at 05:22:47PM +0800, Chih Kai Hsu wrote:
> If usb_reset_device() returns a negative error code, stop the
> process of probing.
> 
> Fixes: 10c3271712f5 ("r8152: disable the ECM mode")

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

Does this bother people?

	Andrew
