Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BF028C5DE
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313640; cv=none; b=cCTV9lxtsbSw7Micoyou3UKYlt3S//hyVPTQkJBPAnF0PGrWlnJMbiOzsPwhudn7CrJH6StFi/vroT6GQduVBuOZd+4PVXa1BFPBY2eippOaTQZJHVwLllIi/FDTqGcP45W6nfrJ3kz0H2yXhn/4fTeZAdMHznAmGWmPN8/7PzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313640; c=relaxed/simple;
	bh=1f0vQMl5PfERXpkK3Qe9wHyLK2W45lfIBX+fqyJQvG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dC2509Kt7pgBpvGdrYQPKlex8xRKMXX+sMX0VeCoEyUue6ztx2Bj1KSAWz6U/ZaqvHN2ej2Br6sBTDZ7CMiCBx64w1LtW8aLfkwSvH2QgI2uzOm0nF6LwiBQtWiuu0nK3FLhcB1LYRIKnmp8gse2nnCOexwccnYQIoAETlm6xpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tv4crYKL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tv4crYKL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE39C4CEEB;
	Wed, 27 Aug 2025 16:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756313639;
	bh=1f0vQMl5PfERXpkK3Qe9wHyLK2W45lfIBX+fqyJQvG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tv4crYKLRtU9QTvUseogChkuEZZbJxNxXnMZNT1yGsljfNKENaHts0wqYJUckgSXe
	 vPD4CCDqQmwZasiXDJ/Y0/c8Dg/1cJU3pog9LXnW6dRXz0ItnJo/H7ifMoVVs2qhli
	 Lht1uWiSqXIjMetnUAQ+OEgCZZvQfv/Pf4O2a0FIkLHdDs8LHca7H0xHYfo3v3WuIE
	 Uje/A57ckGEU8LGHCvEE5qBsBVScJIg6/uu85I2OA9DrV0W8OUnAfABpF65H+9Oy/t
	 B9TDKSrLK7ESDd7HsIcwcpQFpAJTCoyT65yZ+y3U9ppl5gDdQPGLlGcmNQSZWQYK9L
	 lrAZWNMfiXxDw==
Date: Wed, 27 Aug 2025 17:53:56 +0100
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 02/13] macsec: replace custom checks on
 MACSEC_*_ATTR_ACTIVE with NLA_POLICY_MAX
Message-ID: <20250827165356.GD10519@horms.kernel.org>
References: <cover.1756202772.git.sd@queasysnail.net>
 <2b07434304c725c72a7d81a8460d0bbe8af384a2.1756202772.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b07434304c725c72a7d81a8460d0bbe8af384a2.1756202772.git.sd@queasysnail.net>

On Tue, Aug 26, 2025 at 03:16:20PM +0200, Sabrina Dubroca wrote:
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Simon Horman <horms@kernel.org>

