Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792528563;
	b=JHUuO8maeBkl7T9ltAN3Es/nxVGGpQs1+FZ/WpAsSbBCS2UL97SEphTZeaTyJinSVh5+
	 yXlE4IgUcxDTxefTvq0zZRVVUvYzCL4AhuafwWQQqKNaJ8Ob1rEhmGclT0hDNZ0YNMR9L
	 to/GAZaexbjsB2LNp4Pqz3MvrLGlE2YK6hPSEOZN5MPOiHf0gmnQF/zcNnpaw02oAPAJB
	 20VE1CMer2Ygr2Z3pIcFzd7oqeO4hMpisgxwIHwgbrsv8Phxkj4tJh3EnTxinq8tlrD6b
	 nPHfr4KNbEHZk9upvc+Y+cS8UmB5chVP9Lwj89ymAlKKwLI7noEftfANBvkGcrZ8d1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792528563;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9D1PBb71/gAByJ4z+WJJSzFWzWkmuaIL2pUlNA0bFLw=;
	b=HTpOSsDVkvvGQniJiOQBMzJGhdZz+6kao9RyNwUVSbMDrVwQCIRo/JQMJqiSAK98MtHx
	 WIGkn6h2WjGIxS+rOvc5cih56NJraUEFJAL4LyNKaum09uANUTm9Wf1m6HFmiLcC0E/1+
	 dUHG4M2lZVXJgYyXLUfAyl4MxYJgbWODrT1EBlQqasdNLkyNXztV/Pur690dm/IGfz892
	 jz89FQ1ZGh61vH7YN57pExdfFYLvPQE5ewTcZvHfCtE1eFJxOlSddreKhx8z9FMRrxzPP
	 P3weYMIfe5WW9bBDg0DFJJ+XRlIDygQkZocMrOIbwIxpKEL++3whTzEsQCKxU47KcVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LiM40T26;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6517606A31E;
	Tue, 20 Oct 2026 20:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LiM40T26
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FA71F000C9;
	Tue, 20 Oct 2026 20:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792528562;
	bh=9D1PBb71/gAByJ4z+WJJSzFWzWkmuaIL2pUlNA0bFLw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LiM40T26FGAR/0Jgm3M8vaoVhptkJyOqUPh564+gfbGb352XSYYs9aN+UALBCfXVk
	 Ak+BNklF0yQjIYywwuEDhiYkqYe9JYPKX/JyDArvhp47Sn8xfFFCzu2NPJY/rvVSm8
	 FtA2K7FdfhrhAx7Au4CQb6pp54FWmAhE2nQD/Sm6jfxNqxoPeXMGL7HveM0VJ0xy9P
	 aE/JIRg6Td4t/47OFNn3rvW+ejFFykqz2PB/bBn89bYvg874S8KTePhqSQ54PEK/oB
	 UJU66lDVc7YV48IsnUzhpQ4Tr+QVKFYDUy5yAFjjxZnNR0eax7yoeMxNNplCfuIBGd
	 gjqbzvbzYWKLA==
Date: Tue, 20 Oct 2026 13:36:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] tls: keep TX and RX hardware offload on the same device
Message-ID: <20261020133601.2081ab1f@kernel.org>
In-Reply-To: <20261013202647.2206263-1-rjethwani@purestorage.com>
References: <20261013202647.2206263-1-rjethwani@purestorage.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2026 14:26:47 -0600 Rishikesh Jethwani wrote:
> +	       rcu_dereference_protected(ctx->netdev,
> +					 lockdep_is_held(&device_offload_lock)) == netdev;

Too ugly, add temp variable, pls
-- 
pw-bot: cr
