Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE08836D506;
	Mon,  8 Jun 2026 18:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780944892; cv=none; b=Dwv95+IXjz0wem6qBevEIOsLcWs0RMlpz3lG4NOUN1jYd058ZFRZc3Vwy9zukYlBu4Tm1KnP06Is0Na+1j03/pH93/oGCb+BovWQ1U9qyq6QA2M+2uRNrgkZQkVN6wVIsDnLnolGn12onlSowCuQunwSm9TBeXxUgh+D5Tffdd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780944892; c=relaxed/simple;
	bh=Hd4oHAwsFcAZTICcTgWsMuF5vVHcdKvwmx/zGGNHQ6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZJyL0GMhhS7jtlgKCbqSHVj0usUwlH90TxyAQiXw7l1y1DcZrX/1OVv845zNESPfZZPh9Dj6Wzbm4VtBVgm9erMJLB9fzOQhxjwDDeGPWLoF3D6aeeQpJePfoM/rN7EX193flrsAgbDsKqUH9C6ptku5TxjHdsc5/R2Tem2X90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmK05VZR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmK05VZR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80B91F00893;
	Mon,  8 Jun 2026 18:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780944891;
	bh=phRNqvMVVX8LoeRX2smHgcW5EkriLOx3STuzQkeF5e0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SmK05VZRDDn+rz+jXU8jmrXdZTteZbMYsv6oHimxHpJ4O73jSfAtiePpm4U4ydihy
	 M3eSm42tl51aqvCd+JJYCieJzqaPe3R0iUkSaV88I+1nY4YsCyt6/xP/rO+hSLl9Zp
	 xejbBY1GyjTvh4+jAhnnb0zdosY0lsp34sYG7d/vqVUzDYw+4hX1+gQHBxkgzkd4o/
	 yK2ywDdoy2BS/vNyRw7uFT3K9OUuw2tshrLz3U1ZgR3sAeIqCcfGPkL3XFrTFtkfc3
	 hCBlyOCM266c5q0laonAZ94sS58Km2hdDxI1aeFLCQ4SpuTtl8BFkXeXiRGdzsXLNR
	 jRFq/wZG747jw==
Date: Mon, 8 Jun 2026 19:54:47 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 net] net: ibm: emac: mal: fix unchecked
 platform_get_irq return values
Message-ID: <20260608185447.GK3920875@horms.kernel.org>
References: <20260603211734.30750-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603211734.30750-1-rosenp@gmail.com>

On Wed, Jun 03, 2026 at 02:17:34PM -0700, Rosen Penev wrote:
> platform_get_irq() returns a negative errno on failure.
> Commit c4f5d0454cab5 moved the platform_get_irq() calls and explicitly
> removed the error checks that were previously present, claiming
> devm_request_irq() can handle it. However, a negative IRQ number
> passed to devm_request_irq() fails with -EINVAL instead of
> propagating the real error from platform_get_irq().
> 
> Restore the missing error checks with proper errno propagation.
> 
> Fixes: c4f5d0454cab5 ("net: ibm: emac: mal: move irq maps down")
> Assisted-by: Opencode:Big-Pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

