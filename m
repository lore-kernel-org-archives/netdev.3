Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68721E1DF0;
	Wed,  2 Sep 2026 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353775; cv=none; b=NN7IoOlHAnvjbGD46yKGId8QWf86AiA9nyHJgiGtJuXGjRhY61uYvENA7kr+nlSBrkkgxAhBzQlzpXJuxNw0GaHrXZqGiEi8dfRbCPX6l5n1iqhpBEB8jN5H/OnXpvSgERKkgRmUVOB29rMkIGLQqzoBzTXbJe6VrQQliyhPTqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353775; c=relaxed/simple;
	bh=86cUPysW7JPKGr62XMWRfJZY8hLmKLFxRKshOG830a0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWlzHmGf2pJf6G5kJJCcs1S9B9xvlFg+qobGelQhRK0vTKfzR0LMe7OGdqxMcHIdE5IV1KUn0JCJ1Ktpn/gkQKalzVGEr4Obp0whDqKqGDdwJoYe8u62J5ZWO6hoS0x3HNkQE8l0URn50VtSHzhMQmBJUcu55twQgmfT3VeWHyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mFRk3cZv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mFRk3cZv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=33Kar9Av1Z3ojHO2IUgjoWvKZuxPIv4nGjwBgEqRtao=; b=mFRk3cZvLPgpuw5CDAqSPNU9ET
	u3qfwWpo5EbO+cnKsqIua95OpdKksHY6cFXgy6/C8AQeXqpTU4OBz22P+b6RgESYxV8XmRZmDAjiZ
	gIXq5kG3COsX68b5h9NqHwKI+UTAlL5fAuh2bNCZywYRVeh0msIXZa8o/yXJhmPNadpo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1kVd-002WN2-5P; Wed, 02 Sep 2026 14:56:09 +0200
Date: Wed, 2 Sep 2026 14:56:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chih Kai Hsu <hsu.chih.kai@realtek.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
	nic_swsd@realtek.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, edumazet@google.com, bjorn@mork.no,
	pabeni@redhat.com, andrew+netdev@lunn.ch
Subject: Re: [PATCH net-next 3/8] r8152: refactor rtl8156_enable, rtl8156_up,
 and rtl8156_down
Message-ID: <a9fd2210-0986-4305-b9f5-3c534e4c39da@lunn.ch>
References: <20260902090632.41844-1-nic_swsd@realtek.com>
 <20260902090632.41844-4-nic_swsd@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902090632.41844-4-nic_swsd@realtek.com>

On Wed, Sep 02, 2026 at 05:06:27PM +0800, Chih Kai Hsu wrote:
> Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
> ---

The commit message has to say something. Why are you making this
change?

	Andrew
