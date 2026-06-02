Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3A43DA5A3
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 19:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780428303; cv=none; b=UUt3E/co5BxkKw2chIQC9H+yOgn2veuAmJHOEimtxzIjBHkMqeXK4MzkMVaJCg+zmFHw8VqpojHEkAIZ29uI/lYQValFRgOVPISIFYVvDsAuR/SDs/gblo0svMfkzrolD0rBahZVklE1B2NgypP5Vu6WkPQnyXrnvyO0odsqrf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780428303; c=relaxed/simple;
	bh=QdymjjW11+B0vxQdaIq0hRUu+ZWQs2nCqlXlNWNVGfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pgf4wt+X4M4v/k3s3Ml7O75MRQmvu4Se5qBBXQxQbNWOYMEih3fCYYQ/QED7K8QeASELEw11Y5z1NJMXO8ULZo2MZa0N/d05S3cfp5w/g3nn+e+lRC2dRtqkvyE/NTWX1kSmfxMr2RuSUhJIBajS0fj2A2uyzeT3X/YqaEWKbno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cb0ZTrCG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cb0ZTrCG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57BE1F00893;
	Tue,  2 Jun 2026 19:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780428302;
	bh=+ujbgvaMsb/X7hcRsr/JpMFayhGLHviBM2WPg8igrY8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Cb0ZTrCGQ7zXMd9viMu34Xr7rK1h/tQ5wvPXs/RZlJREA5wBmf128BC07NxPrcNkj
	 7c3b5mGJ0GYlyzLk5/bgkw2YxXhAgPxGqvqtAAytzQuJIzt2lkn9+4s5Jm+sJt+Z1Z
	 awguTFoXqbayUI/eTkiUsWS7l8j9GbWk/VypKoHGGTo1uZfOvhI7DTEM02f3BFNpi2
	 UMvEh3PbSqK/UDCuxCiTE2FQcup3g9LLp0uIJvm7v9AD/rNKMFDAb74Ad7zNyVSHt4
	 mCPcKtkM1xsKHsapQoFgYN4rcEtDl1UfyjyQnLOxucfP4GmbAzVbJkoUuzaT4igtfM
	 WR1K18DoRUY5w==
Message-ID: <9d951e42-1df1-453e-85d6-a03ade8b4760@kernel.org>
Date: Tue, 2 Jun 2026 13:25:01 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv4: raw: remove six obsolete
 EXPORT_SYMBOL_GPL()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260602165036.2712408-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260602165036.2712408-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/26 10:50 AM, Eric Dumazet wrote:
> IPv6 can not be a module anymore, we no longer need to export:
> 
> - raw_hash_sk()
> - raw_unhash_sk()
> - raw_abort()
> - raw_seq_start()
> - raw_seq_next()
> - raw_seq_stop()
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/raw.c | 6 ------
>  1 file changed, 6 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


