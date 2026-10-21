Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586938;
	b=a+kTpcaskLGevIejt3MpUMwsz74MLStnP6TCC+nbl15RBRUbBoi7yXwstg6X8oV4HV6o
	 D1b7VWh3GFalTNSPoiihiFEP9MJwTH2PdVS4KO1NDNOmGBU5X5/LEVjmaDSAxe35KaS23
	 bu5Wk5ovVGiLiZLJkWaD/F8v5zYycnL5WXJ6X16f6NeL9IIkvm3hQVLvisZCp/kUsiId/
	 79WcMT0DgoXCGjFzJ9lqjqTcQuu2WRgefDdnrz40Vy2t8fwsetOYyCBaB9ccDfDS783Cb
	 3fqwh7OlcOgwSOycz7PcvXbPUo+74lRsDGnkV2uAjOAzbWpThaRcTSw5tMCOhUq0liw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586938;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=AioZ+ghOsdBNAzerkocRBPRe1ynHbHa22kV464nMvvw=;
	b=eYGKEfhZqQnYl6SVnK51/HqmpDM9RKTOV/wsBRwkuRP55BL0k7BnrB1TSkZ6eSdfWhPc
	 YGzgtLQBRdF4eIzSNTz4rS71q6hMdvubOXDMDvFp2wQITcGqj0rqeQoSRAh1ntYYuL9GP
	 Nf5tcRmfd2+Xs7hghyeyVPWhd7SUrZ8IC8Q46LbiYOerfM4kKrJHjziCg4lW6ZyhOQBqt
	 5RN0dLxK4E31cYin9GnPqzoKH2E2fucpZwa/qJmyKVcLYtHnlf+3zbfto/Qn9YOcxPz29
	 2z9+LYPiDSCr6VkZ0MDx0xBvE6QNrYQbBoAMOQO8BlzEZpv7+yV+CxBompNsXybU8lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=A4Rjc+Mr;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57CD606A31B
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 12:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C57CD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=A4Rjc+Mr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AioZ+ghOsdBNAzerkocRBPRe1ynHbHa22kV464nMvvw=; b=A4Rjc+MrifWpPIwthmG1Lalqaj
	pAhAYrlKNHfKGyHxTz7DKfuIPFv0uEGgvk61wL19fLKhDC0F9lZZ6fPsYAWYy1FQEb/g8rPHZbQ/q
	AuMw6mjphUZWowyrChLs9oVfB9p0l87p/1OLFECsZNleQYxwCWVk9grW6zjahZtemdjQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xJVkU-00C5JD-Tf; Wed, 21 Oct 2026 14:48:54 +0200
Date: Wed, 21 Oct 2026 14:48:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: SAYANTAN NANDY <sayantann11@gmail.com>
Cc: netdev@vger.kernel.org, lorenzo@kernel.org,
	Chad Monroe <chad@monroe.io>
Subject: Re: [PATCH net v4] net: airoha: keep PPE offload when NPU refuses
 flow stats
Message-ID: <05adf618-f608-4c8e-a862-4c1d0779567c@lunn.ch>
References: <20261021100423.9159-1-sayantann11@gmail.com>
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
In-Reply-To: <20261021100423.9159-1-sayantann11@gmail.com>

On Wed, Oct 21, 2026 at 03:34:23PM +0530, SAYANTAN NANDY wrote:
> From: Chad Monroe <chad@monroe.io>
> 
> With flow stats enabled, PPE offload setup requests flow statistics
> from the NPU. If the running NPU firmware does not support flow
> counters, the request fails and the current setup path aborts PPE
> offload.

Since this never worked, it is not a regression fix.

Why not keep it KISS and report the firmware is too old and suggest
the firmware is updated?

Can the driver do the firmware upgrade?

    Andrew
