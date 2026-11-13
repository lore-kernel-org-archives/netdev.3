Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591563;
	b=TI9PjuGsth/y42TrczgPNtE34gsyVpVkVrjnDMRjR6DWChiTnrlB7DUM+N8J41YLyhAz
	 VFa8D0u4FkOhQYKyHwTRMQ6gkwxoq3kyTSYNhgVepr9cVt+ccWnKuitt1WgZbN0sqHMiW
	 Kp55tA98yUuOW+uWtjdxiN1V7X7jQ6wP5nlnVlpOGiq6aZ4PeRq/gunC4xOdmd/CYnI00
	 DiXU9ofrT9FBfNphsllTQXzbsQdnZrknMTm1bUocJCwGlBz0RyTKpusw4En+XX7xXCcAX
	 gBV4wcm1Vh5XTyaWcA1gOyb2cMDws6e0l38s1pQqh0jva2mqpzGyUKyCd7O4+60DnYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591563;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qet1+ThG1P/Wozz+/ZzqbXynxO2kuenGFq7eGBPkYwE=;
	b=1XM/2FpZTzcF+ZMWw992EYLdn8fmGXZLFGRvAvkq6tvHb07/fBbS9JHr0Irr6uORYoeg
	 WHNTWGoWXt5NhvJrViYP9ZeRO4JD4oGkRSbq3QvpdOfGcPWYcrdGwJk23NO+Mz7Uc98Tz
	 qVbve6kxakiY4h4Sgy8VSeq2BhFeeTw+LshUDy40YBOjHRHjAJ4tvuFClIC5e8MRm3o4Q
	 mQ8573cR4cQ1agQFww4WeO/VJsUABhcAehuO7b2AeTTLnbPrjN4JNy0Bv0Saw2rZcF9BM
	 //8xcWkAkjhEWh/Z/gCbj7Fffp2zBv6Ad9MmBQpKZEf4kqN26g7FiL5yIltQM3CV+Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZQUE+VSO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4A0606E239;
	Fri, 13 Nov 2026 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZQUE+VSO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E49C1F000C5;
	Fri, 13 Nov 2026 17:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591563;
	bh=qet1+ThG1P/Wozz+/ZzqbXynxO2kuenGFq7eGBPkYwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZQUE+VSO4NIzMHJBIpV29NpixQLAxm/H+4K+3ayGixcLDE6QyzHXkWi3ybDJVKjwZ
	 ysguOHuT3oAaYRU0nCSiCZnf6Lyt5WT4kuVNERKKn3lz3fBUAesiyFEqsr6YLSXSgg
	 1wBybrVgdjKIwVS4MbPBoRdi+JyvXq/2m1M+u71NWsbd63EgvFU5qUlmf2VdFMWEKk
	 IZVSow2eD3YwJi5YDHixWLgFMrcmyphHp/UqFlrnsj62LQdYBu891KyzaeNJeItGyR
	 XDQqOHYqV5+6EWEqWyv9u4BIjLrM6kLFi4E41ta8dMeLwoLBAnEQy8k5wv1S7OIJjl
	 0gUxnxVeseSHQ==
Date: Fri, 13 Nov 2026 17:39:19 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: David Heidelberg <david@ixit.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>, oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sdf.kernel@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH RESEND v2 2/2] nfc: llcp: convert to getsockopt_iter
Message-ID: <20261113173919.GZ18859@horms.kernel.org>
References: <20261109-getsockopt_phase3-v2-0-d0f74c6e0f37@debian.org>
 <20261109-getsockopt_phase3-v2-2-d0f74c6e0f37@debian.org>
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
In-Reply-To: <20261109-getsockopt_phase3-v2-2-d0f74c6e0f37@debian.org>

On Mon, Nov 09, 2026 at 05:50:38AM -0800, Breno Leitao wrote:
> Convert nfc_llcp_getsockopt() to the getsockopt_iter proto_ops callback.
> It takes a sockopt_t and writes each value with copy_to_iter() instead of
> a put_user() into optval; the socket layer builds the sockopt_t and copies
> the length back. The socket lock and optlen validation are unchanged.
> 
> No functional change.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>

