Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86C43D6483;
	Mon, 27 Apr 2026 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777301415; cv=none; b=OTaZp2uErPVXt2QmajN/b20wVz6yvHGlitCCyJMLd8UJufNkgsLRa1Nz9ti7jT4ZVfFFX8NbDOk63rJ24lnUFVgIJJ/4xI9Uspc5xHQknEoGErP4+PpLcZiMuS0hUvL9YvA2n6+3NJZrXz/YzFcWLjE2dQog7/vrqPY3uvt3qqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777301415; c=relaxed/simple;
	bh=3f4DN6hiZKdaoRMXc1J6Ht5Eqi3bbto2vwcmKUs5o4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jABuobTYCxxdzT4xzbNCeH/mmySthXqGOfnnjhpp3KvgeDn9mkXQ7S34UOJs88RKV09EDdsSilxLp8hzpoUFzvf02W134pBGtttIoa3cUIZ8eWnR3of7hnYcXcqUA65/mZPFqxy0AlpokPs+8j7Q+1vVB4UOHW16FuvjKXrRQnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4jcv6Yd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4jcv6Yd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86895C19425;
	Mon, 27 Apr 2026 14:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777301412;
	bh=3f4DN6hiZKdaoRMXc1J6Ht5Eqi3bbto2vwcmKUs5o4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I4jcv6YdUBqMu7B6wLn+2KDfuXfPlxGvc/C98vRJVVWe/Raqd/ouq3tab1ijj4Hjn
	 Rx/A1FMQMc3b9r6o1FZgDeACfCp0X6FFSXF7OkQAHoBfbK3bG8rmx9k7G7o4myrmad
	 0mwDzoHAFNJixhjw7lYZ6IOQxbXBoEBaiJuD7sxlpNgGe2oPD8qg4IeYZZqtvltz1T
	 u1Np4y7NiZhJ5oKUWu6Geb2L4yBhROnBjAR0m1pN9vSxKS8RJOpnJvq25FZXHEwnyD
	 BUf6U+1b3WvOdlGURa+AW7eI4/NzwGlXAwfvcLEwTGQ8Y4VF97YJiKHW/muVrwceFT
	 UJ2WeNS4uokdA==
Date: Mon, 27 Apr 2026 09:50:10 -0500
From: Rob Herring <robh@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH] [v4] wiznet: convert to GPIO descriptors
Message-ID: <20260427145010.GA2502144-robh@kernel.org>
References: <20260427142924.2702598-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427142924.2702598-1-arnd@kernel.org>

On Mon, Apr 27, 2026 at 04:28:29PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The w5100/w5300 drivers only support probing with old platform data in
> MMIO mode, or probing with DT in SPI mode. There are no users of this
> platform data in tree, and from the git history it appears that the only
> users of MMIO mode were on the (since removed) blackfin architecture.
> 
> Remove the platform data option, as it's unlikely to still be needed, and
> change the internal operation to GPIO descriptors, making the behavior
> the same for SPI and MMIO mode. The other data in the platform_data
> structure is the MAC address, so make that also handled the same for both.
> 
> It would probably be possible to just remove the MMIO mode driver
> completely, but it seems fine otherwise, and fixing it to use the modern
> interface seems easy enough.
> 
> The CONFIG_WIZNET_BUS_SHIFT value was apparently meant to be set
> at compile time to a machine specific value. This was always broken
> for multiplatform configurations with conflicting requirements, and
> in the mainline kernel it was set to 0 anyway. Leave it defined
> locally as 0 but rename it to something without the CONFIG_ prefix.
> 
> Acked-by: Rob Herring <robh@kernel.org>

Well, 3 years later and I'm a bit grumpier seeing .txt binding 
additions. A new compatible plus new property we generally require 
converting the binding first. But I'm not going to revoke my ack here.

Is there even a known user for this new compatible?

Rob
