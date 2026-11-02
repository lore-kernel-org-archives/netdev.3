Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637903;
	b=yxqJo9gY+ByNt/k4OuN8cuM9tFwCJ3jVrQtKnv+Y6otsGP1YH7B3nI6h4lV8UuSrJUDc
	 TACd/6A8Nf3UN07LuVr3uoSvDoq0lTRI5g6/NuxEj7hQ7SapYPArZYQt0S+T9qGWi21un
	 Mh3z+334QvUbMGXaV9G191n9uw7klT9mYhgO6rwUtZxK6YAZ616P2r3+EluFG6UBLJV/g
	 G04NRNlaebsiEYHqTLKb57m9rezIdCFg7wPnJLONTsmzxsFYkdv/BbfbvA9H0/SVkTEWC
	 zeibbGHyAR7OK+TD0KOqU2JtljsqWbihVd9E4X3V76n8Gc7p+u45Adkd/SBmeBUFnFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637903;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=VxbPDt7lDug9QhTov+I4tXm/pvU1uHb/QiVJmOdG4c8=;
	b=qf6VDkloBokVyeOsXEspgK3fhNV/RDulATCA+HMxkw+MWhsNUmsoSEPwvuPNIJ1wOybJ
	 hyN5jNU91Yw9uZeO0CUFgXAtf+15Np0isPERq01gysEZjwfqBKE03d2+OWtS28FUlKwL0
	 Mol1OI4Z+Y71yYRpBqg4QbQfPxvPuj6kMg40tqePcY5yy6e3psM0iM7zrqle2+ng5Y1gG
	 KmT7Xa8/Hp4GD7zsC804k19sL7LcubQLtNE+aVQVIMV+d6/4U+WR8xSFU42o/ZsPKdwEh
	 i9mUUhwqCHdxRLqH0IfJIB7PCJbAMieR5wmB+oHHhZri0cJR3ykajSpl/XUgzNoR/xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b="BpdZrA/6";
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D7860A6C3C;
	Mon,  2 Nov 2026 16:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47D7860A6C3C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=BpdZrA/6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VxbPDt7lDug9QhTov+I4tXm/pvU1uHb/QiVJmOdG4c8=; b=BpdZrA/6N3cK4pZgz5cyXdytx3
	MdDN8uvwYz1dyQmZdWkQoYiopNdRK8J7FYDZxAhf7y13BxykWFXFFqys0N9pdvuXj8RLedWqo3ZPa
	EgiHg7iIcW1yMIfQXJqP7T8f9VXpZeXAf8z5iNUzRraqC1BSfOTHGZluulwa7NUGzcyY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xNv9V-00Dpf7-IR; Mon, 02 Nov 2026 17:44:57 +0100
Date: Mon, 2 Nov 2026 17:44:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: motorcomm: Clear the MIB buffer on chip
 reset
Message-ID: <68a1d47b-e3a1-4353-82a0-89fb2d387f2b@lunn.ch>
References: <20261102101125.3523835-1-mmyangfl@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102101125.3523835-1-mmyangfl@gmail.com>

On Mon, Nov 02, 2026 at 06:11:21PM +0800, David Yang wrote:
> .setup() can run again within one registration: removing another switch
> from the tree tears the whole tree down

Is D in DSA supported by the Motorcomm devices? Or is this tree always
a single node?

> Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")

What i'm trying to understand is, is this theoretical, but never
happens? If so, it should be based on net-next. Or is this an issue
which actually bothers somebody and so is justified having a Fixes:
tag and posted to net?

This is also what that automated email is about. We need information
to decided if the correct tree has been picked. It frequently is wrong
in the LLM age.

   Andrew
