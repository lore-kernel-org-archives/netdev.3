Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793192433;
	b=2w9vaeWjUDqCrRxS+2L7lieYUXABH26Q1geGOhp1aTZBel1HOiDJ6/Q52WXzxE/TVd3K
	 UVyexuMMF4WvmkBgADBu15/1xogoK/0WoIlfax7oK0OMtRUaPjyUAFaHDBJpeBzP5sy1Y
	 fQimJMAkj1TA7L2PWNjed1dbF9N+z8chNgXcYE6lc08pyRZnNUJRgUpdS5PTST44PHKzk
	 1wph2/jdEnYElmyCQxp7ye4r0ZKNO2VCTccR080Ubt+xSCOwyaG6vFzrhHWrk/yufOpSG
	 yNOKDGI5kAcHTCVj9ggW7K/xyr+UAvyCplnxPWd+t2eDAyWO3sN3nldofP34qktynJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793192433;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=6wai+x2L+5SnuO9q4A5CskJjGDIdDDddoXL7xcVNtkM=;
	b=ynNIrDIAzvw3HUvVIWvaeNpYmh8HPHUVUI0OA3DvZkFBG4pF+L8ww8RxQlkHb3wYSYwr
	 8krnJLCRX3ZAH5UB35/8CdUW+ZDkrQtFPevx0KjssaLWrwNzR/tcH7rxuwFmvU1PjSc7k
	 QnqWX5j9cSn/Ugt7Stnhnya0T51mVjTDONjXz3w348ZgwGS/LfPaFyIkq2FBkJpi7y1go
	 Lt7negMFQDBzR0zcnrM4VZnSPC4AicoQdgKMOwK22GTTOyYinc77deobK0oW9ffMQ0wwj
	 16XUMQMFWmdWLAFF06pGR3u6UmbiiRiz7NIYO6zolFhF+C+alpDPE0b63FXWwGOFqlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=u5rn83tC;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A297D606A31C;
	Wed, 28 Oct 2026 13:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A297D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=u5rn83tC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6wai+x2L+5SnuO9q4A5CskJjGDIdDDddoXL7xcVNtkM=; b=u5rn83tCiwrPbuIGKaRvcrUtEk
	EEN+7IZX5ISUcYiAn6noK/65ioRQ6a4gBJAyxWhIfPdNKGHqZi1UH8uKuTqk6XKWWuM+90SUy1hZm
	a+XCfgySnofgjnpLgsMFsLoTASTKOeif2wBodtIDONgZ9i849QSR1ePh2iIeqFb3ifT4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xM3GP-00D6ud-Bm; Wed, 28 Oct 2026 14:00:21 +0100
Date: Wed, 28 Oct 2026 14:00:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kai Kuang <kuangkai@kylinos.cn>
Cc: netdev@vger.kernel.org, olteanv@gmail.com, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux-kernel@vger.kernel.org, kk47yx@gmail.com
Subject: Re: [PATCH net-next 1/2] net: dsa: user: use kernel types in ethtool
 callbacks
Message-ID: <f69cabe3-d835-4fb6-b654-d0e172bde743@lunn.ch>
References: <20261028125616.460636-1-kuangkai@kylinos.cn>
 <20261028125616.460636-2-kuangkai@kylinos.cn>
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
In-Reply-To: <20261028125616.460636-2-kuangkai@kylinos.cn>

On Wed, Oct 28, 2026 at 08:56:15PM +0800, Kai Kuang wrote:
> Use u32/u8/u64 in the ->get_strings() and ->get_ethtool_stats()
> callbacks to match the ethtool_ops method prototypes.
> 
> No functional change.

net-next is closed at the moment:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

The patch itself looks O.K, please repost when net-next re-opens.

    Andrew
