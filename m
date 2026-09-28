Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9690B4BCABA;
	Mon, 28 Sep 2026 16:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614787; cv=none; b=WEa8BZaFNwC5UK+T/9jmSB/2Ybg3qpO+y0fie/7hjpQSYUlJdpD1QGMmjlHfHLsapv5sBNYsxq3MbgModU68tDDlOqkVdQAFddQgiPnVIUq2YlzKk37pjL1XjDgKBnbeDikZqAVcgHZSbnML0lAiIBj5blEO+I2K7aE+V7J1oTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614787; c=relaxed/simple;
	bh=iXNlMRRNp435XG9294RKkO9ATkzdWYnA9NfjfLnOQsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/3Vz7Aq7L32hvqcgRwRguuLGx0zVXUigYRQHwnK7XUdB5hYxDz/4cxX2u0N9CQeee+xbD4beWGjjgOwKHZE0ahA2pm7cqI2WkeZ7uAp2USkkspogiC8Nbq/iT3NAV0UumwCublzygEPIYw1lADGAHyKBgVi5fYS16Brl8+nUnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FC8Xr32K; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FC8Xr32K"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fOizyOOmRb+BSJKJzKWbGpHaYLWidCF275ujZpadl4U=; b=FC8Xr32KA60VxBlCgUkCcZzIlx
	vh6DebhdNZTlCIzwJwedLrFqwJJaDFlntJ9fx1yPNImalsYHRf/RNH/09wdhgmok8PyFpUn7geTjF
	tmNWwetV9y1G4gWxu2wyIehPlMdgvZ8W3yqqdkINDCkCEn3CIXIoGgc52sDgJaodAr0U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xBEhV-007l3K-N8; Mon, 28 Sep 2026 18:59:37 +0200
Date: Mon, 28 Sep 2026 18:59:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xinsheng Zhu <xinsheng.zhu.ny@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: usb: ax88172a: improve MAC address read
 error handling
Message-ID: <c17d456a-cf01-41cc-9039-dc17271b1dd2@lunn.ch>
References: <20260928044011.63926-1-xinsheng.zhu.ny@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928044011.63926-1-xinsheng.zhu.ny@gmail.com>

On Mon, Sep 28, 2026 at 12:40:11AM -0400, Xinsheng Zhu wrote:
> When retrieving the MAC address, ax88172a_bind() checks the return
> value of asix_read_cmd() against ETH_ALEN to detect short reads.
> Commit c28d9a285668 ("ax88172a: fix ax88172a_unbind() failures") added
> an -EIO assignment to ensure that this failure path returns a negative
> error code, even when asix_read_cmd() returns a non-negative short-read
> length.
> 
> Short-read handling was subsequently added to asix_read_cmd() by commit
> 920a9fa27e78 ("net: asix: add proper error handling of usb read errors").
> The helper now converts short reads to -ENODATA while preserving
> negative errors from the underlying USB read operation.
> 
> The MAC address short-read check in ax88172a_bind() is therefore
> redundant now, and overwriting the return value with -EIO is no longer
> necessary to ensure that the failure path returns a negative error code.
> 
> Check only for negative return values and remove the -EIO assignment
> to preserve the error returned by asix_read_cmd() through the existing
> cleanup path.
> 
> Signed-off-by: Xinsheng Zhu <xinsheng.zhu.ny@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
