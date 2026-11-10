Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794346468;
	b=x+xzvGa5yQ/6GOaMNP20UYAjQSxsz+9tPuH1MD166DvkjLnxYUSHkmEL3CEtGuz9Hh7N
	 0UdiGDEJBPSOnWH2xpcH4NTiFkY/XYGStdSWrXswAaJbfbusmk8zdeLxhf9gwx3TgK0JQ
	 J3+L/sCsrs01k7CwOfNvOitAmiZB4xIKOhXP3U8RWlSYJSaDMr34mdxlje8cc/bzsB12f
	 wMcTdtCgKgMd9Xf/PYSZj7L6/2X4uYtfeGmMTFoy1kFbZAf8eGRhdaAweavRS9ReTN6mF
	 R19hdXIukXlls5vxozbSxX3WwDksqZTix/G+0PK4dCc0/EeN+9X/SUeUMrBlDYZKWZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794346468;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=V6Tl8jl24zYxlm+57dMLO03BuUESJwgnOTR4Q4o0xNk=;
	b=VJklkY5OrV7IydvYSGf84KSdIIAyHjJCeUVDlHXvWZ6eHdPes+i7N6vI947XNBKPO4o3
	 yCJbPv0M2pLCTV3mjXBWgEB2wPzk78oygOifoFth+xLv3HYvvcOIlsh8/munJNz42yG8p
	 dxynPnhjxwTGaoiANqJ9LWYoJXyXvNeQe/Kx2Zxx+94ek9CfzQQVfwkfH1oPLUSe7z4N0
	 VIjRiofoO8ZAcwZabn084/ovZnMSwBUyDWQxfAJ47O9Rp/Ycby0m9Sq8pvaNKz8nxf/lq
	 MV7dWGXsnH3kawTO8T94naMKuRQRbShjA9DdlLeSpY4cI4qEO0zckkndOd8JrBGHHGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lh2EpddF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E3D606A321;
	Tue, 10 Nov 2026 21:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lh2EpddF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D45B1F0089F;
	Tue, 10 Nov 2026 21:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794346467;
	bh=V6Tl8jl24zYxlm+57dMLO03BuUESJwgnOTR4Q4o0xNk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lh2EpddF3MhewMQKWurH9APt5wthayQpag884l7v2m+j2yVXF7dXyTS67KnaKUaWj
	 gWCgQNj3c9RbJpXYHp9jWw/NIr7GnOaJDScl3MC48H84nKnInTEYjVVC2Kw/ahP2Om
	 1oxYfGir+mEzbGURa9Fo/1DNs8pCmW09cxNC3OqRpkWNoyd1Zj4PPKSmx7sDRsyf7A
	 fQyyoaGZW/TrvE4Nl28JtKGIfXVuShZ8DAt9KoJIChjqibpGY7mWTbNmujmF0V/grU
	 cPXIe5Dh1LU3kXRlFe4WZaRtnDpfyHUsxPtd3hj7+8sg5KfP1Dt2urHsGmLD2jsx/h
	 mzYz8uCA5afMA==
Date: Tue, 10 Nov 2026 13:34:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alice Mikityanska
 <alice.kernel@fastmail.im>, Tariq Toukan <tariqt@nvidia.com>, Boris
 Pismenny <borisp@mellanox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] tls: restrict device-down TX fallback to
 hardware TX sockets
Message-ID: <20261110133425.3bdcd98f@kernel.org>
In-Reply-To: <20261104214853.659378-1-rjethwani@purestorage.com>
References: <20261104214853.659378-1-rjethwani@purestorage.com>
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

On Wed,  4 Nov 2026 14:48:52 -0700 Rishikesh Jethwani wrote:
> +		/* Stop offloaded TX and switch to the fallback.
> +		 * tls_is_skb_tx_device_offloaded will return false.
> +		 * Only HW TX sockets have the context it needs. Do it under
> +		 * tls_device_lock: the reference pins ctx, not ctx->sk.
> +		 */
> +		if (ctx->tx_conf == TLS_HW)
> +			WRITE_ONCE(ctx->sk->sk_validate_xmit_skb,
> +				   tls_validate_xmit_skb_sw);

The locking in this patch looks way too coincidental.
-- 
pw-bot: cr
