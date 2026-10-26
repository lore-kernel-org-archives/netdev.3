Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792975472;
	b=DcwuSsFW3tBcDr6nZa2+6YMzs0qSnk6cPgHaSmHWRXdDW/v0e2K6CfzCxXW0EOX+kXAO
	 RtWaCQPbbLliDhHDAUiygZSYPXfBN7QzzcNPWs+qYgpdEUVdNp0FywXS9FOOpbtLTuN+x
	 +13RRGOH1J9wFrJJKF099sP6cj+DnQC1r5+eU4m5xFJb12w3NFUzAjedjqA4e3cX4pCYw
	 kIzwRUz+Mdn+9DaKZ7o0f63+rzTNY2Jj1i53kQFVwARN43Q+cjWaW9dpMP5JKzCFXMfmS
	 sXPFHLwoYILJbTxOU2eGwJRNCdZFh4vZRZUDG3aAeOolw+3GYe5vohZLf4H4IHUNGfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792975472;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=C4d5uod477JW8uzzMO+XVqs+CNMjzXHMSj+ysCPSvoc=;
	b=fraLFYC7wT4+FPFj/BraOhMJtqG0AkY4vsTzAmluNt9QLCNHnJMLzXhTm8QSeIIKITW/
	 7nNJgFgfVUHqf2utXOhbhbGpdOifvaZOyoEI8IB5Wijr7o7qE320kBkvf0CBnUQQ/hF0/
	 X0mFYZ7I+WGiRBRulYaJW58WuEuSV+IfxvGUjnPdK0z5Hyj8N1a+nRyPF+uItOR5xvfKJ
	 AEb0snx+lwNAuHpSZ4FRxlVLVW/eID5e3x22S0I0wMIUaN4MP+WYytvjezacZtTO2zVZh
	 7wW5GPFHcznCrwyUnCvRqAw/yJX+gvtuJXYYBZUYsV7SGkn/uebNIDknz3q0GkW30zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=UHeYH+Hx;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EC9606A31A;
	Mon, 26 Oct 2026 00:44:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8EC9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=UHeYH+Hx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=C4d5uod477JW8uzzMO+XVqs+CNMjzXHMSj+ysCPSvoc=; b=UHeYH+Hxy/9F9h6RDFNENjdE8w
	zla9/yNV9vzRnL+GSdbRpUirHUwhjm1nTpqU7whEuZ44C8XkUdokuvntNTJWKXtgqnYFQWCYL9gQr
	ZnVRBl90ELm+khLYHClY2iuMobOBB37jz0q8SeuoeuJupUS+KV3wOgI97jcNoqsGko1E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xL8p6-00CjRq-29; Mon, 26 Oct 2026 01:44:24 +0100
Date: Mon, 26 Oct 2026 01:44:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: motorcomm: Report error when FDB fails to
 add
Message-ID: <d841a56b-1ec4-4095-9040-cc67f4f91956@lunn.ch>
References: <20261025024114.1955782-1-mmyangfl@gmail.com>
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
In-Reply-To: <20261025024114.1955782-1-mmyangfl@gmail.com>

On Sun, Oct 25, 2026 at 10:41:11AM +0800, David Yang wrote:
> fdb_add() ignored any errors returned by the hardware (for example,
> table is full). Return error for that case.
> 
> Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")
> Signed-off-by: David Yang <mmyangfl@gmail.com>

I'm not sure this deserves a Fixes tag. How many entries does the
table take before it is full? Typical home networks have what, 10, 20
devices maximum. A small business network may have a couple of
hundred?

What happens if it is full, and you don't return ENOSPC?

      Andrew
