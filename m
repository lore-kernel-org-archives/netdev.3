Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CE847989B
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 10:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787308775; cv=none; b=dXcBbDljTRxaDm5cP8r4YGsZVBIatEefvLMgcwwJH7rKUG23pbzsTBf36Prj3KIsehLw1D/nvAYICqRCKa60J9bVefirsgb45Rurn04imwkd9k/OpWKiq8hjVgMS8h6Hkd9//AgeuOf5dDHGd/sINwzOtErN2zk70jzQuxWL0MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787308775; c=relaxed/simple;
	bh=VpI9zyMrCXCLLBDpLtHgHw/RjiHjnkUGrmAWEX9s2jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Io5dx+HIxT1JIp/5F41nGqvOX+H3YJ4FN31Lf8kCfiySLYDMhw0rjUjYnJU6hgCrk+yX5h6q/dDGG+TiWI504d6WLPqh8BbaWs053RYRTHz1PRKkkwJAUEDPxyi3o3f28QfotgMr4S/1zK2VlPSwEy1zQLduKyaVxOUGUfWf4Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ttd7QdRv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ttd7QdRv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD441F000E9;
	Fri, 21 Aug 2026 10:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787308767;
	bh=qeRDeP9iuB9ZokUo+XkYCwc3Q58UTeL18RhdmDyfYmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ttd7QdRvBD2s/0xY+t/xP6Wd5AMwfKcGRBIgvcQSmQL9rmceiixW9GIJ784NNwfJ4
	 TY1AQfw3pyWRT1RT1iODjE0LvDmgbgGXz6XOfUH0S4sNkRHigDZt4R5A+r4nFXEVdU
	 TQrrYJ5oL3HWkm0E3/YvTsG/i8QnOyInd0tLdc9DbPjjjpUzuqLgTFYqMJDNRhBlPg
	 iiyVzSrF6r6UVAn4Cg5UcLDTvSgud3NoHZY6P4/9eFbnPn4Wr+ODFoYdH3El1/DCdt
	 hZPShMhaul1NEzqvg+cTByNpv4ZGW3JqsMGdCoXTqUhlw2xUjvHrSCFRArD+cm6Q+l
	 bsp2UDR/3CMyQ==
Date: Fri, 21 Aug 2026 11:39:24 +0100
From: Simon Horman <horms@kernel.org>
To: James <aslan.jnn@gmail.com>
Cc: Raju Rangoju <Raju.Rangoju@amd.com>,
	Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>,
	netdev@vger.kernel.org, Thomas.Lendacky@amd.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net v2] net: amd-xgbe: support receiving packets with bad
 FCS
Message-ID: <20260821103924.GH265046@horms.kernel.org>
References: <20260812091616.35811-1-aslan.jnn@gmail.com>
 <20260819091656.23943-1-aslan.jnn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819091656.23943-1-aslan.jnn@gmail.com>

On Wed, Aug 19, 2026 at 07:16:56PM +1000, James wrote:
> amd-xgbe driver currently sets the MAC_RCR.DCRCC bit whenever RX is
> enabled. This disables hardware FCS validation, causing packets with
> bad FCS to be accepted unconditionally.
> 
> This change unsets DCRCC so that packets with bad FCS will be dropped,
> in-line with typical behaviours of many other network controllers.
> 
> Tests:
> - Verified that packets with bad FCS are now dropped.
> - Verified that receiving packets with bad FCS will increment the
>   `rx_crc_errors` counter.
> 

Hi James,

I think this warrants a fixes tag
(no blank line between it and your signed-off-by line).

Fixes: c5aa9e3b8156 ("amd-xgbe: Initial AMD 10GbE platform driver")

> Signed-off-by: James Nugraha <aslan.jnn@gmail.com>

net:amd-xgbe: discard rx packets with bad FCS

> ---
> Changes in v2:
> - Eliminated DCRCC toggling via RXALL: now it simply sets the
>   correct default value on MAC Rx enable
>  drivers/net/ethernet/amd/xgbe/xgbe-dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I think you may have forgotten to update the patch description
as per the suggestion made by David in his review of v1.

	net: amd-xgbe: discard rx packets with bad FCS

And, some points on process:

* Please post updated versions of patches
  as separate threads rather than as respones to earlier versions.

* Please make sure the author of the patch matches the signed off by line.
  You can do this by updating the from address in the email. Or
  if that is not possible add an extra From: line at exactly
  the first line of the body of the email.

Thanks!

-- 
pw-bot: changes-requested

