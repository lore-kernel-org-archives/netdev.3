Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D09253FD3B
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 12:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871797; cv=none; b=Clzd5fvzJWY9e0flKfIVTc1/IDbk60Y9APg6SKr+OOJzBu1+gRzEWZK74Os0cAfkrXPHJUjW9KMFytBZvrRrEydFq6j/Q45pXWrkCj6V7adXu7oMoe4me8/0RhpSkMUDZry+0WjoeEjCsQ/Af9cqGbN8QEb8LGIvGbsyo7FGlw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871797; c=relaxed/simple;
	bh=5ztdzR0qcj3BMrOPM9JpN42wnkB04CUdtyTrqYhxwxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R40KrXzQB0SkI6sEINzfNj8GgkP89cc0QEcTfvtb0AqzeIhB9iBNw7F1XUffg2wKGUVAKp9Y5vTxcHj7XdDZuU3ppnIH72DC0DMsBloVH2z1FhOeCCGUB5wsZbi718LaQS52K1pg6rhY+RU4onMKnF0RFIMiIH4CvKlxVIFPgSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLgLaXfC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLgLaXfC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CDA91F00A3A;
	Tue,  8 Sep 2026 12:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788871795;
	bh=a/dXkl+k1T5sp4M7oMMIBNenfy5PzoK5zkzZFOiKRKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YLgLaXfCIIxO2mFrli0MJaPpPpDGt3YYNfUBAPSZUUNb1xTwrdDfheewcOS29tnGg
	 YDZBa5SHPi7/ZWqfuCnlr0+ePIUW7B36uv2ZzmwuTqFHyMowcVrxTTVbMQejG4r+cU
	 jFTCqG9l0ADlUIDIm9r0mIAPq8R9UfRHefSmXkdL4tTcAsP4T0UEiy+RoqRNE6laxX
	 J/DEAalPGqPLT0zgiuI1oOI6u1hLyQSqIeEmNvRYcN3NhJ2DM/bXwG1F4aahzC91lT
	 FWTDSqpSAy4feg0CaOV/1xpoJbga7u1fPTedceyXhhHsl+pK0t93sNDeVmPgdzu8jP
	 yOHY+5YcFcA+A==
Date: Tue, 8 Sep 2026 13:49:52 +0100
From: Simon Horman <horms@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: ipa: Drop the monitor_rx endpoint_id ABI
 entry
Message-ID: <20260908124952.GX40544@horms.kernel.org>
References: <20260905092719.41497-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905092719.41497-1-kmehltretter@gmail.com>

On Sat, Sep 05, 2026 at 11:27:19AM +0200, Karl Mehltretter wrote:
> The ABI file documents .../endpoint_id/monitor_rx, but
> drivers/net/ipa/ipa_sysfs.c has only ever created modem_rx and modem_tx
> in the endpoint_id group. No monitor endpoint attribute exists.
> 
> Drop the entry.
> 
> Fixes: d79e4164d0d5 ("net: ipa: add an endpoint device attribute group")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

