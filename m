Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7C553F6AF;
	Tue, 22 Sep 2026 12:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790078686; cv=none; b=pvESjoRwXNi5lPWe7i3UXCIJjVvFFRkf53e2xKN/sUfk4dQEMKqNAQCxcaachKP8ywRy6H2mTMzmXlvvQCvrotb0UWgWuuZZgvVH9hO1Toy3A9cuPYgcEVXLgvv2Bgr0z9j5bqajFx2Hx+Cg+Knn1Q7Ur5YFZocGAO6FkFedNwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790078686; c=relaxed/simple;
	bh=E/fjISr+4E0w2uPBq0n6JT5YYslL9+STp0mOS8zKuI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXQx+TYkaizR+8ESvWxaJVIfBhJsbntidRtEm7eFqqbgHbL8iAiceqvNPmmfBIs50jqWKc4YxUKX94sXOKOoGvRqHfjturfincn+6S6Dvo2+nEngV9lhcHBKp12UCN/flYhawA+dHiUHgBb/BUVjC6r/2iGawuokRt3VWnRqg0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6E5P8T1x; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6E5P8T1x"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Rui9qcItmfbFo1BprPHgAUp5QoOSa9k4HWq9xrPucB0=; b=6E5P8T1x1rNqp4FamOALfQNhId
	D/J+rwGyno8FqG4lGxyVHDZewFsWzmEWJU6gHh+366l62sEkUR6XuCdihpd2MWTVkxbP5VyURCTmc
	0XPEX8tbaVICZeX+P5/jmheQIn6n77OAguB92Lonm60vMiKkF3duAsfz4RKt47uEHn0g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x8zEj-006ZzM-De; Tue, 22 Sep 2026 14:04:37 +0200
Date: Tue, 22 Sep 2026 14:04:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 8/8] net: dsa: motorcomm: Add SerDes PCS
Message-ID: <1c6096cc-1abb-4b5c-a49b-31623423e6fd@lunn.ch>
References: <20260917185010.3189199-1-mmyangfl@gmail.com>
 <20260917185010.3189199-9-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917185010.3189199-9-mmyangfl@gmail.com>

On Fri, Sep 18, 2026 at 02:49:55AM +0800, David Yang wrote:
> Support in-band negotiation of the SerDes ports.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
