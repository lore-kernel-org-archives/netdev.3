Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52CC4B7141;
	Tue,  8 Sep 2026 08:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857650; cv=none; b=VblacWo8iahfrAajnqiBymXleIdAsmzaepyxgECsj9vRMqo3QeVjKhlNk+YXFuE9hWTIoOXoztonhYxdRbi9zNLgbqzdhrEFLi42VSiSWIL09pYI4+AN1+L5WIbBXMh/RM9Ubd1olQFHHXJx6nCRMDoMwkwMpj5aNPDbMWus4Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857650; c=relaxed/simple;
	bh=7pZadHPLwSz+ArjxOT1JJHN4HFrYC1/r3lhWPA8nE30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JI2BVc3aEuOpDcfV9Mvx3bX8jB7RMYVFfthXKvO1qbcOTnQl7S49WUvYqgw/X5x96CPE+G4IVjmT3w4FtngcZS9DSkFKU4UcAQrCQ505+1fLka5Sswi8CEpEa07OtYwYEXKL+4jnl9IZyAzoSonMTPfQbvg6t5ntol2RUPetDng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aa6WcIbG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aa6WcIbG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC231F00A3A;
	Tue,  8 Sep 2026 08:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788857634;
	bh=CZS0eCw1w8BM/XakQB0nVflMBPxRXqKAc65X0YwK8M8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aa6WcIbGjgUE2o3TqCJwvsLLcwcS2gKPNI0vcN9CqTEaQdATycT8sFWB40UdueXw2
	 z7FtBTmLL69cpdinZnGdtk2rNj+wDxLlHCsS/dgf9BllKwtDiifCQoD2zKez2JSlNF
	 TfoPlDAZ7sgpa9EjYqultR/cS0pI98jF1hFksPyziN8+vp2bdTbysqavI3CeIFZl3t
	 xcxKDFvjUJfoZZLpDv9dL4rBWwe8cAUWF6DOF/m4kJ+URgNUu8Ra9Ua6UrgufJFYPg
	 +xhsroXJDYTv6Ij0wFMTF9vBOJ4xsSwvOK4fWAJeFz3d68Sd39q+L7TzptusbxNyLW
	 8+sfGWR8o2U4Q==
Date: Tue, 8 Sep 2026 09:53:50 +0100
From: Simon Horman <horms@kernel.org>
To: phucduc.bui@gmail.com
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: mvpp2: simplify IRQ validity check
Message-ID: <20260908085350.GO40544@horms.kernel.org>
References: <20260903075753.346647-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903075753.346647-1-phucduc.bui@gmail.com>

On Thu, Sep 03, 2026 at 02:57:53PM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> irq_of_parse_and_map() returns 0 when parsing or mapping an IRQ fails.
> The current condition also checks for negative values, even though
> irq_of_parse_and_map() does not return negative error codes.
> 
> Check only for a zero return value to match the semantics of
> irq_of_parse_and_map().
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
> 
> Link v1: 
> https://lore.kernel.org/all/20260824100758.31622-1-phucduc.bui@gmail.com/
> 
> Changes in v2:
>  - Drop the Fixes tag and rework the commit message to describe this
>    as a cleanup.
>  - Add net-next to the --subject-prefix.

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>

