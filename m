Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060BD30C178;
	Fri,  3 Jul 2026 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783100419; cv=none; b=MnZW9PBWY6+1EsoL6RD3nXqyuQMECr1x3NqUqAQqgTAfMOSxHxMSsy4kmw9Dv6rVpcvWjHYp9cV/IiWAeAjX0+x+US5RU0Mehv94Baoyvd7K5WpahzVXezYyo5R3cm1kZkHJAZym0GkbbUvDOGitOlkWAWphWaMtwMRKmDrEzQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783100419; c=relaxed/simple;
	bh=2VkCbWZoankpZ7HfNv2tu8+skzBfWX5VTA9bWfpPfms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORMMXsn6OzF8w0wZQEiMx0mnKAHXcBkjXak2wJWggM8Jc6p/aT0HjUkuCncqcfpFL1/1MMHqFZqjHlvkfTkIzomwi36MuQTfARa2VYVmvQ1lmDjeJZzem/Av1ZujafNwnlTsCiKog8WsbUUL0/JN5ioNG0GETfVmVc4qYrvVV8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=q2L1dD1H; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="q2L1dD1H"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YZbjuyBd3Jq2sGfxDgoqJe0M7TcQCZ/ksEEJkjn8/fo=; b=q2L1dD1H9bitcA5XPo5W2Q6FCT
	/MDwPIp1IURyFUiCHkYho5DykxTGrlYENHhKpLXBTwltIK/vBOvOzM9iNHoCVLjIjiangt8Zo4Kz9
	KeFi5h4Av7t43YGwsSCEAvAAoPIdEjSfOpPCC4Sqv2myB7GVPDLWGJkvM6h7wzR8+3PQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wfhru-00AaDW-Ii; Fri, 03 Jul 2026 19:40:02 +0200
Date: Fri, 3 Jul 2026 19:40:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/3] net: dsa: motorcomm: Add LED support
Message-ID: <784763ad-d0b2-4976-b057-18ec453ef3de@lunn.ch>
References: <20260703165241.542195-1-mmyangfl@gmail.com>
 <20260703165241.542195-4-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703165241.542195-4-mmyangfl@gmail.com>

On Sat, Jul 04, 2026 at 12:51:47AM +0800, David Yang wrote:
> LEDs can be described in the device tree using the same format as qca8k.
> Each port can configure up to 3 LEDs.
> 
> Currently, only parallel mode and strict 1:1 mapping are supported.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
