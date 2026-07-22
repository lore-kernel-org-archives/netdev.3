Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAC0233D9E;
	Wed, 22 Jul 2026 18:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784745214; cv=none; b=j/PxC4dwS1ahy3KkVSlq6CRHN3W2ie1cV/f5vKYMANzQxgwTl6O2SXOLBz7nVAnEqHxTV8D7MPwCkjXQ2dAumbQc8P7NNpO/otQzcLBVRZathK7M/J1nZ3HCMtT2DATJIkyHXecgSqH6SQIrEinrQiViG9H4fzQteBLR7+aXy+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784745214; c=relaxed/simple;
	bh=fYe94wW8AY6UESQ+WjNp+K8WfocXyemxnR9gcXEKEwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miuvL65xr8ddfvd6thgASXvBem/iJr4fGfuJfUuS1a+jW/EmZr5Ji8KdF+d997MkdUMIKalbqxleB4vCti03XOp98IIW6Vex3nBBjXiQp2s8w77YQLTy6+EIlWsMoRmigN2uAMSHlZ8Vljp9GPLPVoa3lGXCUBipmQ1aRRP0nXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iNXrc1X6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iNXrc1X6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=d4/Js37WpFVWJC6jbeoENaLIZ+JEkGXpzVvZZYIRYLc=; b=iN
	Xrc1X6XU55dxvufd0IfP6UxKfgQAJFX+MwpHzpX9liWbLxWsqfJj9mY9QWvMsFjsEnoV0rALKqnd4
	OVU5dRmJSXqf/x8RfzvS7Rm7FYs9v3dkICVJpKUxqKgDwrUUWj3HNlF1kVh4HD7a8f3zjpo9A6Cjt
	FpboUpBz9KoIMEg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wmbkt-00Dg39-8o; Wed, 22 Jul 2026 20:33:19 +0200
Date: Wed, 22 Jul 2026 20:33:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: microchip: Fix log typo in error path
Message-ID: <019ce6d7-dd61-4acd-a4b4-7ab3df609868@lunn.ch>
References: <20260722174853.2316333-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260722174853.2316333-1-niklas.soderlund+renesas@ragnatech.se>

On Wed, Jul 22, 2026 at 07:48:53PM +0200, Niklas Söderlund wrote:
> All other log messages in the driver prefix hex values with 0x, add it
> in the one missing message. While at it also add the missing opening
> parenthesis in the same log message.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
