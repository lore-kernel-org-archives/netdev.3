Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59AE3A3E8B;
	Fri,  9 Oct 2026 06:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526239; cv=none; b=Wg0GOBYQVLPDxSk/l9WX2Doy/CinoLiHJAl8/jDxNIim4CshBsjWE5jIhPPEGHZajwaOBuEgurospBDQyj3AZ8PZk5RCm7PgJXlHHBSY2aXk0BgkOXWuzVjKWFRiPvDTX7n6LmzDYcvFFt+0tesEKwWTiU0bZlWZ6HzkbDWXYUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526239; c=relaxed/simple;
	bh=vOjoPzRFlz1vnUFQYob6r2lAU8rCn7TvrwBi2gqoOHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6JFwVngnwJY8E3bBnrjR5iqH34xuLT5vRFP3AHfK+o8+Js4sRwsnLWpfX0Do5b2RICvFjfQlYQjIb7XlNGPgSAvrWWeKPa6pyaHdgrk6WGitQGouXH2vhgO9Vk6J5DpbEwyRbVCr92DM3AZ9AzxKi7AG7rQEHNV2Rk1pc4yeDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkcYLZPG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkcYLZPG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB871F00893;
	Fri,  9 Oct 2026 06:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791526235;
	bh=bJXTKtqeMFmEbsZpjFNApaJAlaG+gDHLDHTHWW4tZuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZkcYLZPGp2zjpAl2Pn50h/B7h8Su+WKlrjKLsChz7HNnWYOn3uihNmlxiNKA9fa8N
	 xp0MSsIAI8xtyW17VoBnf1HA6ZFy7X1BqKAvJpnvZ2fE79h7o/aJb2RN/VvsTbQXUR
	 GQx53FpcsuBS/Qo+WpEYCanuJd9ys3w2BwUxFt/tp3RLZcoSbZrnqiwNKrUn9vo1LD
	 58fV8QkdP30gTRLdKu0xMmcs8Rg/myiGt6gmzu9JmbYBffWAqxroPSUX/f41Cc9MX4
	 XMnXJWs0BvTObHI/VcOvGUBbrEKLJc3lRgBJVkRY+pCqkmsHBiXS+dOG42M+6iHrHL
	 WcS1tT9PbmOgQ==
Date: Fri, 9 Oct 2026 08:10:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
	Josua Mayer <josua@solid-run.com>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org
Subject: Re: [PATCH] net: mvmdio: fix clk reference leak in orion_mdio_probe()
Message-ID: <20261009-fractal-millipede-of-tempest-5ab9ce@quoll>
References: <20261008165328.2702289-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261008165328.2702289-1-vulab@iscas.ac.cn>


On Fri, 09 Oct 2026 00:53:28 +0800, Haotian Zhang wrote:
> orion_mdio_probe() calls of_clk_get() with index ARRAY_SIZE(dev->clk)
> purely to test whether the device tree declares more clocks than the
> driver supports.  of_clk_get() takes a reference on the returned clk,
> but the return value is only checked with IS_ERR() and never released,
> so both the clk reference and the clk allocated by alloc_clk() are leaked
> whenever the DT node has more than four clocks.
> 
> Store the returned clk in a local variable and release it with clk_put()
> after emitting the warning.
> 
> Fixes: ea664b1bdc19 ("net: mvmdio: print warning when orion-mdio has too many clocks")
> Assisted-by: DeepSeek-V4.1-Flash
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/marvell/mvmdio.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 



Multiple things here:
1. Your team ignored completely previous feedback.

2. You use multiple identities with this email, thus I actually doubt we speak
   with actual person.

3. Finally, same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document usage of LLM and how what you should not do
if this was posted in a good faith.

Best regards,
Krzysztof




