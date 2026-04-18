Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1251EB5C2
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776525569; cv=none; b=Op7ECY7lGAAXI8K3vi1dVTVsCfLd6EYm5VFEuCXAexneLqzN4uVrAONcWUQWLVI3k22893iSoN90MvUIz0WKq/NHbZwRjzzTGPwvKN0LO+1kUJ0bBIvAZGM0B+OpHdl27cv29ZmBUAHyhsapZPebuBsphd0ploNl6uUuNdm4kUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776525569; c=relaxed/simple;
	bh=P8E15VCdTNIBX1BOMvNb+PldnL6YcssvUuh4J1WaKyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFQhF51E9RpsW5KrVnx4tL1KKaSnWaWmbmpgRSAuCp68aprU0bnoFHYpQk+rTrxz15/gdiRFxhALFv0d4qb0E8nhWulIC9G+HPCkWG0NhsLpnQ66dEmbZbTFm4b6lmyQQuU4H73rwqJY48UUcXPvouktLncGkkknM8SDvATfUKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWf6sF3H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWf6sF3H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0B2C2BCB4;
	Sat, 18 Apr 2026 15:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776525569;
	bh=P8E15VCdTNIBX1BOMvNb+PldnL6YcssvUuh4J1WaKyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WWf6sF3H9fANgV5eMOyJr+acBTXVd6Yni6c5IW0E2faAaFwyTZwolrHM+W2SmeYCa
	 +W8svoWkjKzXlsvRht6CYbtHPu6w5zZLniCaKapMr021k5mfdJhwjUE33pm0XO4gO/
	 55RbDcZxmtOACwOTdCeP7yjQpiMq06CKhoIyo1GHXcmGjsUO63zPpTTbK6rSlb3kWW
	 y/h5Kckn+zNxyjpWnGqwV42eb4lumzHJg34g905CHPq5bAVrSZNnVbXAVRvC0YFXAY
	 AIkm3tnkqEqJscB0tYthHnGIMaXALrukfNjFzeH5EflsXO58eh1AatLNtkYyt9JRdf
	 R/U8o0rCiWCZA==
Date: Sat, 18 Apr 2026 16:19:25 +0100
From: Simon Horman <horms@kernel.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net v2] slip: reject VJ receive packets on instances with
 no rstate array
Message-ID: <20260418151925.GF280379@horms.kernel.org>
References: <20260415204130.258866-2-bestswngs@gmail.com>
 <20260418123929.GE280379@horms.kernel.org>
 <aeOXJoeq6VkCnqAH@SLSGDTSWING002>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeOXJoeq6VkCnqAH@SLSGDTSWING002>

On Sat, Apr 18, 2026 at 10:37:26PM +0800, Weiming Shi wrote:
> On 26-04-18 13:39, Simon Horman wrote:
> > On Thu, Apr 16, 2026 at 04:41:31AM +0800, Weiming Shi wrote:

...

> > I do note that Sashiko flags some other problems in this code.
> > I do not think that needs to delay progress of this patch.
> > But you may wish to look into them as follow-up work.
> 
> Thanks for your review. 
> 
> I've already sent two follow-up patches for the decode()/pull16() 
> bounds-checking issues:
> 
>     [PATCH net] slip: fix slab-out-of-bounds write in slhc_uncompress()
>     https://lore.kernel.org/netdev/20260415213359.335657-2-bestswngs@gmail.com/
> 
>     [PATCH net] slip: bound decode() reads against the compressed packet length
>     https://lore.kernel.org/netdev/20260416100147.531855-5-bestswngs@gmail.com/

Great, thanks!
