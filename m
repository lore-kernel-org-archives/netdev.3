Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7AD3DE450;
	Fri, 20 Mar 2026 18:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774029657; cv=none; b=gF3qjZ1Zebr94gvOrJa4dD426OdGxPadJOVDvwcVrgolaZNsgus+yAo5OTkvwLOCt0O/0EbREF01Rc9orD/GCnsOhJy6f+k4buA/jRSJTa3MGhTSAp8UWUvx8KDnbYUEgozgBemqsUhgN2ilZA80foiL4Cc9wyFT4QG4dC+LSvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774029657; c=relaxed/simple;
	bh=UblSInEiA/mfUiA8e8q0rtmtS/Sqfi8+Dh2007xpxwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9a9NULNI16DSzNYTgNMgLcpur9BAcZFlZQ1DaR+yycCjkUrTFJAlgqwycEEIzJvstFAzQ+7vj+1bIdDyiM5kituzBCt/6MPVBoLVC6IIXFoohXI8gUEWTGqK9/tk6/5ok/pEibwlv4g9VtscgEyt4Qa9ox6nRf9b8GBsoZxP08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcSBAWYz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcSBAWYz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8216EC4CEF7;
	Fri, 20 Mar 2026 18:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774029656;
	bh=UblSInEiA/mfUiA8e8q0rtmtS/Sqfi8+Dh2007xpxwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JcSBAWYzbwb5FwOKfwL5RuCX+bSD9AbMhCF/n4jwvVN1bWeHCpVGP/hiXMsfZbxbe
	 fvRYC2HpUbdIGmx/5RHfXPdEN0BVguYdoM0FQefCaiuZSc0xI8vDLauW+LZD9rWd7R
	 yKNlFjxoAUJWm5Tc7mfB4wg+IDtkslPQmhBLXalsUtk5noQFPH+6dkCsGrZS0NGW/F
	 H/FHy+cfLtEUkanQ+aNdocE0wN1VAncZgvxqNwvlzC5XEZS5gsLrdB4it5SqCtOBfk
	 TimVgqai6n35QuH++Ebyg6jnhb8WF8uPwEXGn15ATT7X9D0oeervL4fvTM9M+xRqcg
	 CsUz9Bc/YnN4A==
Date: Fri, 20 Mar 2026 11:00:56 -0700
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Edward Cree <ecree.xilinx@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Jeff Garzik <jgarzik@redhat.com>,
	Ben Hutchings <bhutchings@solarflare.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Breno Leitao <leitao@debian.org>, netdev@vger.kernel.org,
	linux-net-drivers@amd.com, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] net: sfc: avoid format string warning
Message-ID: <202603201100.210F1C73E0@keescook>
References: <20260320151924.3474821-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320151924.3474821-1-arnd@kernel.org>

On Fri, Mar 20, 2026 at 04:19:16PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Three sfc drivers contain the same *_fill_test() function that takes
> a format string argument that gets passed down to snprintf(), producing
> a warning with clang-22:
> 
> drivers/net/ethernet/sfc/falcon/ethtool.c:227:60: error: diagnostic behavior may be improved by adding
>       the 'format(printf, 7, 8)' attribute to the declaration of 'ef4_fill_test' [-Werror,-Wmissing-format-attribute]
>   210 |                 snprintf(test_str, sizeof(test_str), test_format, test_id);
>       |                                                                          ^
> drivers/net/ethernet/sfc/falcon/ethtool.c:210:13: note: 'ef4_fill_test' declared here
> 
> Rework these to take a varargs based test_format that allows better
> type checking and avoids this warning.
> 
> Fixes: 3273c2e8c66a ("[netdrvr] sfc: sfc: Add self-test support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Nice rework!

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
