Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792673919;
	b=nBQywUb7bd/v0hy0eq/sIqtkrTbGKcBoKHwnjaYc2RhJEDqjS34nwjtxQZczGILVi7SG
	 cr14/WiE6Xxh3PaxIJR8A7poyTyOgxGbHip80o9qTERrD7U1GXHwvqrYYKR3Vzf+aczUR
	 5BqMiqlUQdzdHxiUZ35VwSiMxRK+vfKUfukK5Jd2B8tbmyAwOfhZ5ZyyQiQUXcNwmqKZ3
	 C4foxbDLqmCyxjZ1F2J5dJgcz5eYLUW7Ie45zy9MBIRLjJjtuvyznFA1c2GFzbOCFRKlt
	 bzNllZThLdz+zNnrO6oMTWc8AaAEtIGn90FWi3wUaBxBx1l2rr5926YkLNY8Q4O5AlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673919;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RoXq46hOUYVtm9h0wsMbuC3hWI4oJsS0MfivuhG50CI=;
	b=e8l6IpblQbbrrcNBF4588082FqNDcMJbFI09iU7xUBqgYnfBcAlRlBYMRu5HmZIYMXsw
	 uhKt+MNeyyvUcrB7ovsn+KjW7K2HM0E8h1FNZ41hW92nj/biVNK0U4uBDZCpxpZ0AMYBc
	 Y7db0I1bbJrqZ9uW0AX+2aBE8HBIOKFw3F/Dt4KymMWJ9yXMvL4w92LrbmvEL474XDdBr
	 L3LUw4+ihPwScizGrH2tjGn076BXkIYVuYHh41va2uCHgstJuFDFDLHgeOKUv1eAX5IkP
	 LnQ4F1x0gejuH1OB/a/l9JXZME9dLwfe15e08v5FTTsVYNm0l2ixNi8l5VEOvS2iQcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EwPBl80y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3285660A382C;
	Thu, 22 Oct 2026 12:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EwPBl80y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223E21F000C5;
	Thu, 22 Oct 2026 12:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792673918;
	bh=RoXq46hOUYVtm9h0wsMbuC3hWI4oJsS0MfivuhG50CI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EwPBl80yBVD39MnkOrAXBriAEWH5YsQuSdlGJEE1RqosF4mMo0JEcN4AZX5BC3CCo
	 wUJDPi49CGUHnQW5KpDEjIjivxC09O/2USBoFB9hCW4CYWnw9hhPjqu9PUR6WNfJOZ
	 AwZpwNxEYgxlrUxUgahH5BiwteN3rBrnY3Y64FdtJTjmqePKltH0njadbBK+67RQAH
	 uWwLsvlQQg31GUKoDCc004m7ua+Dpriwps2hAGWH3Cv0anGSEeF3hrktcwX0LQK+k0
	 cPwJLo6IRv8UDPlLT9g+HixI+UnwkGfP/O2hjNF6IIRMR1tgtDPB1VH+HPVuxPpXe1
	 ICD8AiS3/yl5A==
Date: Thu, 22 Oct 2026 13:58:34 +0100
From: Simon Horman <horms@kernel.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Oliver Neukum <oliver@neukum.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sjur =?utf-8?Q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>,
	Alexey Orishko <alexey.orishko@gmail.com>,
	=?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>,
	Greg Suarez <gsuarez@smithmicro.com>,
	Breno Leitao <leitao@debian.org>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net: usb: cdc_mbim: don't enable BHs in
 tx_fixup under netpoll
Message-ID: <20261022125834.GF708417@horms.kernel.org>
References: <20261021-cdc-ncm-netpoll-v2-0-8818965bbb69@tipi-net.de>
 <20261021-cdc-ncm-netpoll-v2-2-8818965bbb69@tipi-net.de>
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
In-Reply-To: <20261021-cdc-ncm-netpoll-v2-2-8818965bbb69@tipi-net.de>

On Wed, Oct 21, 2026 at 09:56:19AM +0200, Nicolai Buchwitz wrote:
> cdc_mbim_tx_fixup() has the same spin_unlock_bh() as cdc_ncm_tx_fixup().
> Under netpoll it runs pending softirqs while the txq lock is held, and
> a transmit from one of them spins on that lock.
> 
> Use spin_lock_irqsave() as in cdc_ncm.
> 
> Fixes: 9bf211a30b3f ("net: cdc_mbim: adding MBIM driver")
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Simon Horman <horms@kernel.org>

