Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D1C230264;
	Sun,  4 Oct 2026 14:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791122826; cv=none; b=uNUvqreSNJ0XCWPlKjd9DZy8rjYGnJIue+u4goYHh7GcXDQ/N2aVr0RAYQJIckVG0hTL75ra4wRbqkinfQ7l5IEs7NT85Cl6A3v2KGQrgvJGpcZSzggEWHDYT9aalxy640BchPCM8tHumOpC6n3Kvc7WkjbUJqPdm2hz0+4yQ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791122826; c=relaxed/simple;
	bh=MV3DfV4G9Byod1mk/ICy+aIRGXKxdXF95gt85t3U71A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTABFsqW6vtTKmMHFLU/S2YRj65EQIJn4czLgQBTn517foLhOdRti4+wXETgQsdwwzek1HGhRO0ByHDKXqW/NxEb+UTHCzg9e1nK2y34aCnF94rz64n9byCqcz/SWOF0DYFjnhqCA62NPknGX2LZdE7+SKlRRxy8FJ/Tk+l/RVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GpUaWPF2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GpUaWPF2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7HtzoByryiP1yIA1114N+WgdnIC+7vLxeXm+HNYANVo=; b=GpUaWPF2knjHzqwikXxanxXWU8
	a0BHnGyk1kguXLeyRyyCRZfwdih7ttruMc/qeQd1JcqXXglmgn9AzWja70bDD0uemAX04a84Ce9i+
	7hAdsAdOzV9zUNPjq6YxfZ2iPMCY/Ny8seDpN2T0lU7QfGebSnEoVR/wqA5ifEqMkvwA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xDMrg-008t36-VJ; Sun, 04 Oct 2026 16:06:56 +0200
Date: Sun, 4 Oct 2026 16:06:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/5] net: dsa: motorcomm: Enable ACL on demand
Message-ID: <9cbb96d4-ec76-417c-a30a-33bf0027551b@lunn.ch>
References: <20261001204851.2576101-1-mmyangfl@gmail.com>
 <20261001204851.2576101-5-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001204851.2576101-5-mmyangfl@gmail.com>

On Fri, Oct 02, 2026 at 04:48:47AM +0800, David Yang wrote:
> Track the usage of ACL rules and enable it per port only when it is
> actually used.

Does having it activated when not needed actually matter?

You are missing the answer to the question 'why?'

     Andrew
