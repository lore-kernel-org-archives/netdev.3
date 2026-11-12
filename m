Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794512151;
	b=uQ2auNY2sWmqNQv1ZsTAghmt9zAbRyWCzsU+ySNrqLJkSphjx6hgzO1G28l7v7TFz7JW
	 66S7oo8TFYBw01UlwTlAs0MHwPSBPjFan9a/s6JJPgk2KZwB5OLXXDzHoIGG5sRsnQI9P
	 dr8YZ5c0zKbyXaG4oXOqv+j4CyMAp8JAkQGrklzgZv32ULyckIUl5oNekAxi3F1pYvssR
	 OQVlbaf3F3thCwhMDzyAGjcfuR7xh1Xg70Mrgv0CSxEDCyBCaDMV9M8jIxSwcCqixxSTi
	 /fS9YaILtNYaMdy32HGGVa0maCnhbvJ/z/xA8JEFqwE/4hdia/p7UboGjfdNL5VRrqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794512151;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=0pR+2UJYSRWXBY+JsM7wm51ZPBa8tWt5k1rdTgbE/xQ=;
	b=dxHH2aJ4BefFRKYkGtE0eF0BY8cC6f8hIHbsde19/TRn3gfu+eq+kBe4+TFtshKaxe74
	 VB1lfYr1gUvGd9zvjOVj0didlTKnS1D3P8s03BizBz/QezWvHSyNyjxg4aH4ymfEHWG6Q
	 2+M0gJ7wyKsRF78ra2p7aRE6XCwK8fka6P2EBi5RytMJsO4e5cdpieys6/j3rkEIUtaE8
	 UnxW9oFMe317BMIqwqbfdCXq9NWdbnRMvX15ElQAyq5VvIJOZ8D84Hs5P4ymk0er9WLCx
	 CNYuSarDyeC3KJd/brWMZQDdBvisNbgAeFYGMXcgqKD8lnQCT0ZG0opCPBqR0VbYuLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ut0Fcfgo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD3E606A31C;
	Thu, 12 Nov 2026 19:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ut0Fcfgo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCAD1F000C4;
	Thu, 12 Nov 2026 19:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794512151;
	bh=0pR+2UJYSRWXBY+JsM7wm51ZPBa8tWt5k1rdTgbE/xQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ut0FcfgouxV577mJYjBqO1L3l5W21Z/uBAa+z5N6a/Yi7ntWpoq07z3DG3Tcns7zE
	 fvez0g4AYMyBHMuOZtEjurIlCKUcfynFvabRQ4T9gjcAPdEvdVBFStQ9r0eL8rBeH8
	 xMLPiAw8s73R7kdKRnDVe7+CIQds3YH+FCGkfcE/vr46OHkwkwjvDP0atv+3hyJbCy
	 3Yb4noJB7QUYdzxeS+SJmDsat9XwKQkb6dUx2OVjsBmazrw4Wm/vpOXwhBvYwvQf+s
	 yjc1v3qnehxbLM1EQtTHgQEyN2qXTpEVDjQy5V6Ihb4Og5pYFGeiTyH1trdUqYGSBF
	 9E2FfLhcBHtPQ==
Date: Thu, 12 Nov 2026 11:35:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Hungyu Lin <dennylin0707@gmail.com>,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
 horms@kernel.org, n05ec@lzu.edu.cn, ylong030@ucr.edu,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vlan: prevent cross-netns MII register writes
Message-ID: <20261112113550.016cdab3@kernel.org>
In-Reply-To: <bc45c1e8-6904-47f7-9c96-512e024c9d71@gmail.com>
References: <20261106124639.12584-1-dennylin0707@gmail.com>
	<20261112075624.23c04230@kernel.org>
	<706b09ea-49cc-4801-a24b-b22d2ea7d257@lunn.ch>
	<bc45c1e8-6904-47f7-9c96-512e024c9d71@gmail.com>
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

On Thu, 12 Nov 2026 09:42:32 -0800 Florian Fainelli wrote:
> >> Andrew, Florian, any idea if we could delete this completely?
> >> Why would anyone want to run MII/PHY commands on a VLAN?  
> > 
> > It does seem questionable.  
> 
> Agreed, it does not quite make sense to me to forward these ioctl() 
> calls. Looks like this predates the import of Linux-2.6.12-rc2 into git, 
> need to do some more history digging to find out why this was done.

Maybe we can just delete it in -next and see if anyone complains?
The "fix" as posted would have to go to -next too, given regression
potential, so if we can't think of a use case let's try the bigger
hammer?
