Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627738;
	b=fo0oEJMYI5eOUwUBoRNmqhkBlKrxqRv7LBUii9sr3kOcSKqsBcz8s1o+G8FXe7C6C6Qv
	 +eC2iNlfKDjMVtyGcnPgCpaEd4wSWnZLatN2nn9azkL8R6Iox8dvrwwviS7CLbwtn354d
	 rUPVOCCVXa8YEA+Vl9GSJeex/uwgnkW7R3y8W0K5sB+tS0Ss4Dqk7BUKpw7TAbVQNOXHa
	 BkcuxgLKs0q9zCLaYJxZIzcUx5jXFP1dkVj2uOvVQ4PZG8ynCY99UybGNs9ukWFGwLCng
	 5eFf3ymq/LoKKyFSJUHgnCWJnO/HrAr77zTdzUiofJXfUNs4D/pHvtv7MGZ0QgCHhkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627738;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hHgFhkC5mwTs1gmpMNlDj1TsT3RTcuRQrpWCX6V0XYo=;
	b=NHBDoVNimL9ZOtnlCipX/MuzF6rfgn9DqOJsTnwtVYuZTaXb4rL0Aovt0qOhcNQPU38s
	 tKmJXVt+TwltD90UjKUYihEie9rk7ges4b2mLytTDwhKJlfsSmn5LpZOprEN7q2DXvveK
	 ZLb+kcz6a8GmxFeen6mnxrj5dbGE5V9RvVcI13QGNpqcvuaVetBLfVjX3mL+iuYCixbqF
	 RdmX9cON8N0btFFfm3YwSZ+mLjipbmalXazUBz9GT9rC1kj4mN8xrgD7+xhqBph0m+hqs
	 AMFzsOqJ2mecwkKXPIaXpZRhrQgABjP1ikytoaF8OOb4F8dSRgJpi6Ehu0C/Qhjh6cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CuVx9ZBE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAF8606A319;
	Thu, 22 Oct 2026 00:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CuVx9ZBE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27501F000C1;
	Thu, 22 Oct 2026 00:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792627738;
	bh=hHgFhkC5mwTs1gmpMNlDj1TsT3RTcuRQrpWCX6V0XYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CuVx9ZBEqi/DvK/9kmzVfh6xpIlzsi5DJJI05Z6RBd9914BUP99wQGZP4SyouoSaf
	 bOeK8QUp7I3uRCVMGVGh5O6suK11EWshB3BSAOXh0NsHaHnGNbXFRtHf9fTxUClO/N
	 9cv4dY3nJug9bBZUyo5l7ivijWg7dq9RClpMvbWhY8oas3TIQud+g6cVWtSP9OipU/
	 yIOeW2cBup8NA7uJQKeaT6NXesmlakixu6lyi13sqH4UCXfsVka371KMZXcc2j+nA2
	 V/KAyn0U/CzzlSIUwEnDo1VrXcUNwbhP7DfyJr0FqbMe5fvEwEPT2WrrWwIXEcW349
	 6GKE3HH27sdzA==
Date: Wed, 21 Oct 2026 17:08:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya
 <gakula@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>, Subbaraya
 Sundeep <sbhatta@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] octeontx2-pf: fix skb use-after-free with ipsec
 crypto offload
Message-ID: <20261021170856.15bb09ff@kernel.org>
In-Reply-To: <20261019-nb-otx2-xfrm-unshare-net-v1-1-ee9b24f9e673@tipi-net.de>
References: <20261019-nb-otx2-xfrm-unshare-net-v1-1-ee9b24f9e673@tipi-net.de>
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

On Mon, 19 Oct 2026 17:04:33 +0200 Nicolai Buchwitz wrote:
> +	/* Crypto hardware need write permission for ipsec crypto offload */
> +	if (unlikely(xfrm_offload(skb)) && skb_cloned(skb) &&
> +	    skb_ensure_writable(skb, skb->len)) {
> +		dev_kfree_skb_any(skb);
> +		return true;
> +	}

Why just for cloned packets? Frags themselves may be read only
if they are spliced filesystem pages.
