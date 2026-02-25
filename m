Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F44F3B8BDD;
	Wed, 25 Feb 2026 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772030081; cv=none; b=nCaZ47lUOCfbQbbpLVTmWc+mH9nzDZlLoDN/9kJNR5CPztjazrme1qJ1UeaZMeIgo0D4+NHYfcc6Zmw0w1xqtTuUTvHxhaLSfeRlouYZvu4xzL5BkMx7oQJV9w6Gd9iESLm9QsgTxNA9i7OGE6kADdS44PW+xxXpELE3aZsvvTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772030081; c=relaxed/simple;
	bh=OnmwfZhwLzI4cx9LLrDiMynGlQDZG1nL9sgqzjtoiwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6+opF9wfmGtRlTn6VjS9RHYPrnDIzkGk1WcQCDzYSmpdhchRabkbXtFYLQmL7spTvzoubvJwH2/m0tvcZLYairAcVF3kSQJfGmnjk5mYxCVjzQHttKoX5sZ42jnWnP7jr/TnnMgwCNY4UoqLqABI49HwWD5AEQU2HUkkKCVGzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FoFbnCdA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FoFbnCdA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69D2C116D0;
	Wed, 25 Feb 2026 14:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772030080;
	bh=OnmwfZhwLzI4cx9LLrDiMynGlQDZG1nL9sgqzjtoiwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FoFbnCdAuO3p3VevkTW9D2mPoJgElr5tg6TdkyvLHWI4kxpMN8LgMS1BnLzFZWml0
	 6tR1eMTrt5oDDRQrSipgljBhPZS3FfR6IEU+T9d0qSIE6L+Z24jzVIHbDUCqnNi/MK
	 o0gq8Ml0kkipeBU3dRAiUA+qYcdwGsxdOymgttus=
Date: Wed, 25 Feb 2026 06:34:33 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable <stable@kernel.org>
Subject: Re: [PATCH] net: usb: kalmia: validate USB endpoints
Message-ID: <2026022502-exodus-moonlit-fb81@gregkh>
References: <2026022326-shack-headstone-ef6f@gregkh>
 <aZ1wUS9hs9WZTb-o@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ1wUS9hs9WZTb-o@horms.kernel.org>

On Tue, Feb 24, 2026 at 09:33:05AM +0000, Simon Horman wrote:
> On Mon, Feb 23, 2026 at 01:59:26PM +0100, Greg Kroah-Hartman wrote:
> > The kalmia driver should validate that the device it is probing has the
> > proper number and types of USB endpoints it is expecting before it binds
> > to it.  If a malicious device were to not have the same urbs the driver
> > will crash later on when it blindly accesses these endpoints.
> > 
> > Cc: stable <stable@kernel.org>
> > Assisted-by: gkh_clanker_2000
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Hi Greg,
> 
> As a fix I think this warrants a fixes tag.
> As this seems problem to go back to when this driver was added,
> perhaps this one:
> 
> Fixes: d40261236e8e ("net/usb: Add Samsung Kalmia driver for Samsung GT-B3730")
> 
> Regardless, this looks good to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> ...
> 

Thanks for the review for this and the kaweth patch.  And yes, I should
have put a fixes tag there, but for stuff that's always been around,
that's not really a big deal.

greg k-h
