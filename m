Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179B33A8723
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 10:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197749; cv=none; b=evpwveN0nidjP0N/L2WGoHV8MLcVIFEjT0Nh4JGPVydS6aMS+nifkIt2Fe03UBbnnHPkypSmMJXUFtSokCYKZzKahYC3UQSTS4oDK/l/epOuClkdLG8hWJuClNV6xxcJb1S/JAgePpEb1uKFnfnHFGoHvnt1iXsf1QGoyEk7ul4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197749; c=relaxed/simple;
	bh=BJeRPPe/O7phxK+sL216QBucR/4GioteO7kMWz7CeXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOqKQBva+nd3vkUXnfiqgusgLJ6o/D4ZHh214tzqyPcbk4KBu/vLJMvNhLL5htP9bEIxUh2FrnIIV4EP6DHUPc0YXHN0DqPEtei1MSIzRXoMnT7VqZeGRA6YmOoEW6vk7cXhIhn+Y7ai1/i8wijN+khjdt0ZV1SfMe5lMkKahNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+AcJ929; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+AcJ929"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691BE1F000E9;
	Thu, 16 Jul 2026 10:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784197747;
	bh=GIYU1EVRzWR9/EwQp0oGfc0ZwW46yEVVEaehQewVXLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P+AcJ929OOpJbRAwjcPTwRa36QTgfTMDQKgChHcjN1HU/I0O9VJUqdsCrqVfFdavb
	 pjv3ErYWicYwi28SUFPGvzT+DCySJSUM49S8Ru+GSLJIK+HD6TCy6CqJuxFV55VyzX
	 jof+WDDbf5yFAv4gdz6RLS1+eFD8uBL4uSniuzr8ll1lUFG4pY+UlJz3uJvfR8tOFI
	 PHS9mMRKKqmVLz4Yqop6CXUsbBks4V/HQDMliWol14lxM1xQpuVib1+v20Ol0Zy7oN
	 F68E1M1tRaj5Rre4rBiUTkMxV1CoJt0bkWJJFaSSP26v3iEnIE5ydIvkzSOwqYY2sc
	 7c+S/wAeSmbsA==
Date: Thu, 16 Jul 2026 11:29:02 +0100
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Octavian Purdila <tavip@google.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net 0/2] net: Fix two issues in sk_clone() error path.
Message-ID: <20260716102902.GA260771@horms.kernel.org>
References: <20260709183315.965751-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709183315.965751-1-kuniyu@google.com>

On Thu, Jul 09, 2026 at 06:31:38PM +0000, Kuniyuki Iwashima wrote:
> Sashiko reported issues in the sk_clone() error path.
> 
>   https://lore.kernel.org/bpf/20260709032007.9E4D61F000E9@smtp.kernel.org/
> 
> This series fixes them.
> 
> Note that Sashiko may point out the same issue for sk_bpf_storage,
> but the fix was already merged in the bpf tree:
> 
>   7cbd0c4cebe4 ("bpf: Fix UAF in sock clone early bailouts")
> 
> 
> Kuniyuki Iwashima (2):
>   soreuseport: Clear sk_reuseport_cb before failure in sk_clone().
>   net: Call net_enable_timestamp() before failure in sk_clone().

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>

