Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577991;
	b=b47zStQsgYEwwAzHiLNUK0vat7RtqG76umk8FkhZTnf7npj/IKCX+zK6+IOB7LqmJO/8
	 +AO3ho2y9ZNyXXOQiWefQj0h5L91ksZaJ6z7+P5pB4fehjLhww8VuIPPByPGwM5o93xn0
	 PrOBjVE/h//+gUUBVmayc+c+1wKz4NlHymJ7S3S6NWsYc080TDyfbAzEz77rdBYnNmpJQ
	 u0ItQ4Tzcjbc8FR+E/boknA3Qw/1hgT77uSqMWKMHcGD3O/3uXLWtfaOvMdb0BqVxdnDE
	 fimEK2nQL4F2A3kdywqar7o3IDZa4e1zqqLHof1+WcBIiCN+RILcAs29+DcYM5HL1zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577991;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=eNPXoMZBdbQ6lsSA3xFnPDYFpW0633UT58mBQMobSHc=;
	b=GfqBZ0VetK1lQlmCfMpxu7/OMT9/XFsTyGdTVoSjVF6e3wVdkfN9ACintQOjibMHv294
	 LgLgP+pe02y8sfjGFKN9mLbuQRjJPua34uzG3mlsjqy0J6WV8YWg0piQCSIESmzlOzUqG
	 /1qeiG/3KtrP8fT4yMH4kyp51fyc5YQlEb0lPN4H5vgFNG8urTRE0h169BzBavTj5So6Q
	 NEKoOoUCm5SS7kvzkmqJcLbIIyFiCnPfwxGyYAFIseNXRuVH6/8yN5fvGCfBYFhIaSgn2
	 Bw1LfJ3heqYycNd2DtZ8hOm248rb78M3eazT1A9HcxFBjCXmEVkgLvsXaIV7SubmjFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=WoNtbOXO;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE7B606A335;
	Fri, 13 Nov 2026 13:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DE7B606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=WoNtbOXO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eNPXoMZBdbQ6lsSA3xFnPDYFpW0633UT58mBQMobSHc=; b=WoNtbOXOnGqJlexXVOkQz5G56N
	75k0eWrP4gezA7BNoAk8Ow4hdtnLXtaJmV2MAA73VICqfqRg8R46zjq87m0m8curZTQDQ4bfdr2qZ
	gzQ8AABjdC0CQR0zp7i/u4rLiRQebdECCZ0tzLnW0UddXCtlxrqNAe2lWQ6MYa7wef5Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xRriD-00GHpT-A6; Fri, 13 Nov 2026 14:53:05 +0100
Date: Fri, 13 Nov 2026 14:53:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: phy: use const char * const for
 phylink_an_mode_str
Message-ID: <86b2767e-c2a6-4bc1-ab30-c69069edf253@lunn.ch>
References: <20261112131358.106442-1-ansuelsmth@gmail.com>
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
In-Reply-To: <20261112131358.106442-1-ansuelsmth@gmail.com>

On Thu, Nov 12, 2026 at 02:13:56PM +0100, Christian Marangi wrote:
> The local string array should use const char * const as reported by
> checkpatch.pl. Use the correct type as to mute checkpatch warning.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
