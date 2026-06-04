Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2EA290DBB;
	Thu,  4 Jun 2026 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780576880; cv=none; b=rk6PC0BrKRQpSETQ59gNpNTtkzGdkC0RY0DMXLjdgk7KWELe3JzRa0nF3Uc7DMFZ3jLPFDFHbrOy6pkIopDpAmhtIcXYbUu1nqYPWnJNKRHzegxcfn9RMSwZrL/S8zpOxx4D7rxwhj/EzPfqlPNSs1ntObmWd702FM5FSImKZD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780576880; c=relaxed/simple;
	bh=vABAeb5yoaxRMbPG08nIjYcYfU74s4T5Cze6J+kjrmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUjEIulqnOcCOIHLixomd+X88+sjGSeXjKtHdc+70F70CBOEytulGNUduf/7xjke4EbQxnqiysmnQMbYWkmuLIvDqRp3vih1ro7F+rHUyX4JShUru3b0He930i8fCyq0mXauAerj26JOcK61qUH1LTIA3lDjELA0By7TZFyFIJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPXQ+2EU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPXQ+2EU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A81B1F00893;
	Thu,  4 Jun 2026 12:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780576879;
	bh=BD+C5VQV3yglYFve12LB8PO4uUYjRkvZHFWVbTESV8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YPXQ+2EUPtBa1bHPxwsJlZGhmIDVJbaGRURndYHAfLF3B3RiqGlyKFIRLWpXHFWGE
	 Rb9ztvhWj2uf+/evCfIQiy9wkOzuc3hxtFiLqxvouTm5NM6S2O9wH3ZCtTjTEG6Dtn
	 pMbT92Jaiyl/aDM71RD8KX3dbfZDItBjrKi3GsxBJ18gsw8efI5zAi1tUwssI2qc21
	 wy+IMjMsSAlYK1FHzj9TShzfno5lj4y2J4uF73awKcvQD6SIbVj/FIGHPK5wQRDLXP
	 cF7zJhGa3EpgFS07JcPSpHn3EbXsclY7WjQ5xUkWKzCQGdeHQgSZp5vaADYxm+xB6h
	 v+wuC3BSVaRew==
Date: Thu, 4 Jun 2026 13:41:14 +0100
From: Simon Horman <horms@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Tim Bird <tim.bird@sony.com>, Amir Goldstein <amir73il@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net/dns_resolver: use kasprintf +
 kmemdup_nul to simplify dns_query
Message-ID: <20260604124114.GA3920875@horms.kernel.org>
References: <20260602071343.962830-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602071343.962830-2-thorsten.blum@linux.dev>

On Tue, Jun 02, 2026 at 09:13:41AM +0200, Thorsten Blum wrote:
> Use kasprintf() for descriptions with a query type and kmemdup_nul()
> otherwise to simplify dns_query().
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v2:
> - Reverse xmas tree (Jakub)
> - v1: https://lore.kernel.org/lkml/20260528222030.1655010-2-thorsten.blum@linux.dev/

Reviewed-by: Simon Horman <horms@kernel.org>

