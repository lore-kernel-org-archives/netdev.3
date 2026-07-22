Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BEB353A99;
	Wed, 22 Jul 2026 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728684; cv=none; b=OS2vZRGmrParmYDJ0wy2E0xKVBG1R8u87ySzwPeV2Y3r4e73+NHC5I5PEDSMyXwsbHhDpbnuoa/0OQEFpNkR2Jaak8XNQ9xc7Zav4eUXC4MqVLq+okcW3ExS1pMQSoviybQ3rEBcrEh9Qo0Ic7jzkgbQlruGiah7Zf8UX6mt/UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728684; c=relaxed/simple;
	bh=IakgZwNK8QPyQAEwsGLUvMtNT3nDNT7jQD8moYi+M/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TP7VbTGh8BUvDKvKCpuW7ZfaA5WuMUBkCffy3o1B6E/nPmQ9DYOBKjSPxqEcMHJAyNl03zc4ZIJv/4wflPp+vywt2Pcg1C4BeZMsnpiihiFnK+FgQV0o4pF+SwT1nbK9MXxHIf7NfP1HqC52bF5rz4lIbMK/5h3J9YRleEPnU0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rvk0iY7Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rvk0iY7Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C239F1F00A3A;
	Wed, 22 Jul 2026 13:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784728683;
	bh=mGDAfIsCTOKi0maggEwEHcqKU8ba0BgkQxyxljoRC8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rvk0iY7YLWQv2XKghuoB3kZhbHthjl6a2lfNX2lGmqO28JhiUQSTsArQ1SjB50p89
	 JK0x6vHvIQkJg8P30mI/xoEdvRzj+Zd2rj6hZJkXedU9sUnYLVxmREEBk5Fh0jQ0dz
	 JxZQwLmSOAOYqAMKepbXYYen7FzkFbe/HoEO3q1o5PCqLpjTDG5qUKkUJiPwFSUNjB
	 FWUU1U6IN2s78RbpQmjEOhFytx9B1pN9Qa0YnlisWZVuwHjsbJh8M7fOWupMLFImmm
	 rtgCyXkkRBmhF4JbWoaWoo+7AQ/g0vJ47BMKI0epQY78vL5yMjBfPkQj+/YTLAmMFL
	 AsyUavQpXssog==
Date: Wed, 22 Jul 2026 14:57:58 +0100
From: Simon Horman <horms@kernel.org>
To: nshettyj@marvell.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shijith Thotton <sthotton@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] octeontx2-af: return VWQE timer delay in NIX HW
 info
Message-ID: <20260722135758.GD418547@horms.kernel.org>
References: <20260715073112.622662-1-nshettyj@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715073112.622662-1-nshettyj@marvell.com>

On Wed, Jul 15, 2026 at 01:01:11PM +0530, nshettyj@marvell.com wrote:
> From: Shijith Thotton <sthotton@marvell.com>
> 
> Update the NIX_GET_HW_INFO mailbox message to return the VWQE timer
> delay, which is used for vector packet wait time calculation.
> Repurpose the existing rsvs16 reserved field in struct nix_hw_info
> to vwqe_delay and populate it by reading the NIX_AF_VWQE_TIMER
> register (applicable for non-OTX2 silicon).
> 
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>

