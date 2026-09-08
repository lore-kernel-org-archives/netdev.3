Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7C43F8246;
	Tue,  8 Sep 2026 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788855716; cv=none; b=A1TtlyYrXaXTB72pV27qsc+aigNozHLkHubdNCwPdKKijRll4zIeYXLHY/bOs/8qy5xQvclTNwOhFq399HrMYZvcjf1Pp6qjGMImE/M9VwyJ5L4zYMp/j5Zw4A2GCSoniLilTy8IToS6n5Nqrmxo8qzgr5kVylcHVLHbIURAo0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788855716; c=relaxed/simple;
	bh=KS63ifiFAEfPq+/v2ERHsWdr8LLShQlBvZ59n6pPkVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kx1ipsEeqA3V1qfNE8UY9zxLlkjwUwldXqFTAPM9zq42ljwbF6iqUErfU7luTavkzd40owE1VMT+ll3F85gEZ7tzXDCelVKGRdqWgdGwwNtyZCLrpGSZ6ZpfDRxAhevCBsRmek3V9vIw0Yj6aMOw+9aElfGuhc1v1y5VVpeI9Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOskoS0V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOskoS0V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B36C1F00A3A;
	Tue,  8 Sep 2026 08:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788855714;
	bh=lRWBt+3AIQtzGPZVDYXQIrZ+rJ8V5lfNYHkGQlCYY8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HOskoS0VTT+NO7NBUoFulAlybL3JwNRBtTYVP2urCvOdyhsc4UNdgIEm6TG7MVhZr
	 CIhvgcisaFIETD3yjO2XPRoE8PzD/3aZxwQV1jajOTXl8qT1/huqU0+dj6+e0mZFFY
	 RGPMERTBQsNsUxZXXXZRhXkNQ0+cseKw/qGAz7jlAj2C6a4DmVqwGaCPSHvHxL55XT
	 nWfo4+wOdVUjPpdISF7/jycVDZ6AKYfjiLGLPvsCSdGrS4IN34LA3tsn9Ji+k1GBK1
	 WuGN8wkcUgUy9gXjN86+lGC71cIdR8FeZdR4PvHnwtjPLllE9kV/hCeBoTjEPvrBzU
	 iTRzLcp5LfOyQ==
Date: Tue, 8 Sep 2026 09:21:49 +0100
From: Simon Horman <horms@kernel.org>
To: phucduc.bui@gmail.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, u.kleine-koenig@baylibre.com,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: marvell: mvmdio: Handle errors from
 optional IRQ lookup
Message-ID: <20260908082149.GK40544@horms.kernel.org>
References: <20260903074638.345952-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903074638.345952-1-phucduc.bui@gmail.com>

On Thu, Sep 03, 2026 at 02:46:38PM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> platform_get_irq_optional() returns a positive IRQ number on success or
> a negative error code on failure. For an optional IRQ, -ENXIO indicates
> that no optional IRQ is available. Other errors should be propagated so
> that the caller can handle them appropriately.
> 
> The existing code propagates -EPROBE_DEFER, but ignores other negative
> errors. Propagate negative errors other than -ENXIO.
> 
> Found by manual code inspection.
> 
> Fixes: e1f550dc44a4 ("net: mvmdio: avoid error message for optional IRQ")
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
> 
> Changes in v2:
>  - Add a Fixes tag.
>  - Add net-next to the --subject-prefix.

Reviewed-by: Simon Horman <horms@kernel.org>

