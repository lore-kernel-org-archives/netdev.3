Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BC53C1969;
	Tue, 22 Sep 2026 12:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079387; cv=none; b=KElUWD3RLFMtAsJJLOZ8m5IABOFFHAQk6iULvQVwSofPEQxH93/Ruk185m8byFFjfiJ4W/Zd+sKJrbuij208IC/QbujKowEa6Phlxhg7Tz6ItyfAcKzHxl6DGnGmoZsJXjqtji62m5Var0ZMJp+2jJqOizdLSZQgI8Iwwhi3PI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079387; c=relaxed/simple;
	bh=yuNk9xssY0k6DQGENTHyQhEOoqGJonBD8gWDgo2awSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/YReQbLllwUm/6dgqS9meLSLZp14zMLBDO9QYGgg0mLsbG2aTIr9sWNzVB8uoqfXomFcGcr0NdCBN928wXR0TkCoGJE8o1ict/Lmua9ri38Wt6m44kleeooolBfFqMFAW9Jdu35Xw+WdU8uf9ekVM8YWxbzHMTJG0+2hX9C6gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BrqG22Vq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BrqG22Vq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zZu4JoRx7gv4egN1HTLqNyQyOQxpMsI6qQaF7otSn7o=; b=BrqG22VqpOHV+4o1GvZtFro8jR
	iR6RYiuObEVMWNwA2ceCVIdxakQd9qlXLQsaWM0r6b8NSJntiFmBbgpVU/ApYNBvupn6fBxMRIVGH
	l6dYn8s+Gr3BVy5S6v1IhJnAQ9TXeB6jb38r/iCa7LOpHm8rcZzRJhXCqd5RHs0WCeA0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x8zPy-006aDQ-FR; Tue, 22 Sep 2026 14:16:14 +0200
Date: Tue, 22 Sep 2026 14:16:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/7] net: dsa: motorcomm: Hoist port_to_priv
 helper into chip.h
Message-ID: <0df522bb-9305-4b27-a1cf-fe0e11970751@lunn.ch>
References: <20260921203040.1203911-1-mmyangfl@gmail.com>
 <20260921203040.1203911-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921203040.1203911-2-mmyangfl@gmail.com>

On Tue, Sep 22, 2026 at 04:30:18AM +0800, David Yang wrote:
> yt921x_poll_mib() open-codes the same container_of_const() expression
> that leds.c defines as to_yt921x_priv(). Move the macro to chip.h as
> yt921x_port_to_priv() so both files use one definition.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
