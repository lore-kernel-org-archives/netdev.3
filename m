Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC6F359A91
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 12:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560984; cv=none; b=ElBFCPWB+Nmaak+voOZNL6CKy3c6gBgRXGj1FJxvQMwnEQcihb0csjXWLMz1CUkujo4FbH5xE4KQIR84eYndyC6NzaNdUjFzaUCswPgxlleSSUpklRrLUQihe1NmNRKG9zy1Q0s7+/69MqJoB+iUpkRmd1w9UPc88EYqs509D7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560984; c=relaxed/simple;
	bh=znzLc+KmXJnCja9bDPTPDh8wNCG0z5YafEtVw33/3mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESDXB50llXL2ZP0wew1RvkWw3wYk9hcQ0FlE2AUzrNBRSqvhGDGvj5f9yHRuhMB04IYlMhSr8Ha6+ZL1mbUTX7pWKdEKxm4WvMYZHTLomWut4fRF0JiwDv0lsWgAtdGN34eoKVxgfSZf2IUAFU5W/X3DmTqZKjGK2I6lR4GNRic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQmbd9uu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQmbd9uu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D2F1F000FF;
	Wed, 16 Sep 2026 12:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789560983;
	bh=PIS9U/18rQl8lBKlViyzQy9Hl++svioDR9nvszokbIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BQmbd9uuSFjAokSp2ZjJVssc8VsmgadTTYCv6wxOXlPms9LPdxOm4A5Yl+2e297GE
	 a9xYeZzZRZhmCGSPGa+3fzKz1NlcSRuXNsKfrSeoRlkAMcvgOa27JoB3eGLA7PQVZs
	 H5eqjo3VgZsO7/4NSaW6QZlwP1bZPtF/sseOdGEe8tALWqc9hAT6+Vicb5xtCSfQZD
	 JtM7Wjk739NboFGWvjZHQgL/0FPc85EL4XAQaiOzKvAfAnO94pYdvSvNIZl8pPYOlW
	 e5DXwCPzaV0o/5VMILrxMHKBH8mMrnDbYtQ5fjo4isD39U8Kihn5KBF3xs81L28dU0
	 uDfGB/oSG8FBg==
Date: Wed, 16 Sep 2026 13:16:19 +0100
From: Simon Horman <horms@kernel.org>
To: Matt Vollrath <tactii@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net v2 0/2] e1000e: fix Rx DMA error handling
Message-ID: <20260916121619.GD51261@horms.kernel.org>
References: <20260913171555.89537-1-tactii@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913171555.89537-1-tactii@gmail.com>

On Sun, Sep 13, 2026 at 01:15:53PM -0400, Matt Vollrath wrote:
> Fix some longstanding bugs in Rx DMA error handling.
> 
> These two patches eliminate some conditions which would result in
> DMA_MAPPING_ERROR being sent to h/w or to dma_unmap_page() or
> dma_unmap_single(). A teardown leak in the packet-splitting path is also
> fixed by a necessary refactor.
> 
> v2:
> * Renamed series from "e1000e: fix Rx bugs"
> * Removed RXALL buffer overrun fix from the series.
>   RXALL bugs will be fixed in a separate series.
> * Reworded patch commit messages.

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>

