Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9298B379EF7;
	Wed, 16 Sep 2026 12:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789562955; cv=none; b=O39BC03h61egim2IrqM4sZWwlwrmEc7byTkI9WFUAstRFSbII32EV3Aqpst56YppDJW9KZ+n5cF0KZr3NYLLaH1Q6MlqN0a7mqcf+PSDAPrRPIzG9y97t36cdXnahTtD1tgNciqAHAEIxmCpneDMJv/17MtCdgQ4xLsyJrUyvNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789562955; c=relaxed/simple;
	bh=aXD+aDZjT4W62ZovS6WlHqNRB2tUZg07K2BOjth0IGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qylwHo0rvx30LK9da5+OAYRn3A5J8UPfypg3uN8PGqw8QKXmIFm6iiErQ/vZ/nhoDaNrAfL/hEtbS/h9aCKCeVP/Vhti7DDdottiUtbIx5x15W2pkDI5XBfdsBGD7v1Suyl6KjBijfG3zqx8SyGZADhvW+PTEqifio55MVn/OW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdVOKmpQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdVOKmpQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E3F1F000FF;
	Wed, 16 Sep 2026 12:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789562953;
	bh=Akpf3sVV5hMKrXoprjFhWmMCl1UxJohB43ip4C/fV4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BdVOKmpQMqrTMV6o4Q/J4t3nWmPfkRZQX/rBaZFfPDKBw52V9kbILFD2UPUC0w27o
	 KJ7P22LQzrCF6Y8gWgsjLOPgAw6iU1QYaWNfcgiM0f2mWoynS1t0z25LYQ9o0br8vW
	 quRyC6NXIg9wKzxbNoKl2P5RMA75y4YTTdc0+NvV1GOcSs0zY2p5p55LpgOyix/ZpS
	 INsWmjq+rJBriwPASkCRiB+Fl+MfdVnZHfP8gA7E+GSnsaxNnB7prSEFqjgTnJKS+B
	 xHhwz2ILc/SITxzezVvDvFS2BcMr7a+7msD7O+sZwUgC/KTyqgWue+5hsTvpYlFThu
	 4DMLDOMtmo0ng==
Date: Wed, 16 Sep 2026 13:49:08 +0100
From: Simon Horman <horms@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Tom Parkin <tparkin@katalix.com>,
	LKML <linux-kernel@vger.kernel.org>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 net-next] ppp_synctty: Use common error handling code
 in ppp_sync_txmunge()
Message-ID: <20260916124908.GG51261@horms.kernel.org>
References: <15f151c7-58c8-4116-8a03-e985fd132b0f@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15f151c7-58c8-4116-8a03-e985fd132b0f@web.de>

On Tue, Sep 15, 2026 at 11:23:01AM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 15 Sep 2026 10:48:11 +0200
> 
> Use an additional label so that a bit of exception handling can be better
> reused at the end of this function implementation.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
> 
> v2:
> The application of a known source code transformation pattern could be repeated
> after the commit 8aaeb56aff2a557a88f83ae866da2c91ad247e59 ("ppp_synctty:
> ensure a writeable skb header") was integrated.

I have mixed feelings about this as it seems to be a cleanup
outside of the context of other work [1].

But I believe it is correct and does use the preferred goto label based
cleanup mechanism.

Reviewed-by: Simon Horman <horms@kernel.org>

