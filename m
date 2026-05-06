Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB2F3E121F
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 16:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778084762; cv=none; b=M+O/mH1L5+k7bripKR3giNw7X+nnQnTBfmsiKliRiTNnIvuWhAQtsnTgZkKk6btY2+55OG9SkbaJYqfaEhha2KEEImMwSJvVYqOEYxqHznh3olyLud4SCpSAoSB2A/vH5Xrg3g533RGouCca0aNuVzCp7u9cMly4ZEvso8NES/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778084762; c=relaxed/simple;
	bh=YqyMalZi5DSTtksJkRVfptq2Zozm+Kferg/NhNg2mNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qak+4aU4d9e7ARuKcPJ4grLKgQUNXHL7uQgsL0CliyUe0soT0c5iCyjXNONUEjWXEy6dEIo0ASaOOd73Vw04MpFN/+I9tFMKMojV7uiyX7K010EcQ9e/gALOc/lWgvS2Y9EvAULiXld7NUjel+c00UBKzUKaeRIpANRojfXtcIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tewpDFka; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tewpDFka"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E2AC2BCB0;
	Wed,  6 May 2026 16:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778084761;
	bh=YqyMalZi5DSTtksJkRVfptq2Zozm+Kferg/NhNg2mNY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tewpDFkaPGCI8qCVd3jAeNSewmC4I9+yUeYg9ZgMjFjDo+CNodYVKpRyB969lz47y
	 cJdXduk6tSM330GDGOHplVWjO+cYjiRpjkjfpL/ygBRqL+jS3xd8nb/9fhi9wuu9kp
	 4HJuOp2LB2Qj8VuqeOBrSI4kaIJXo6Sa4uC1uII92+BZOuP/d4YtnnXioiCoCioZoW
	 WbfCWfDC0nXq4RYG6s/2ewSFYwAzaMcnD49wxsyT1VlSCjxxQYsoLCu03lKTZJpxn2
	 1HdAI6YjIV8bq6gu7xYctQWZUQQl8fqpbtgjGNmVAsCKLH0cWfDoYhT/Yqr8q5oGye
	 IHMzg3NAnUvHw==
Message-ID: <8fea4084-c9ec-472a-b8ab-ecc87e537216@kernel.org>
Date: Wed, 6 May 2026 10:26:00 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] ipv4: Flush the FIB once per dev nexthop
 removal
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20260506092704.150349-1-cratiu@nvidia.com>
 <20260506130129.GA665477@shredder>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260506130129.GA665477@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/26 7:01 AM, Ido Schimmel wrote:
> ... it would have been easier to review if split into
> multiple patches (not saying you should do it). Something like:
> 
> 1. Change the various nexthop remove functions to return an indication if
> flushing is required, but keep doing the flushing in
> __remove_nexthop_fib(). Referring to these functions:
> 
> remove_nexthop()
> __remove_nexthop()
> __remove_nexthop_fib()
> remove_nexthop_from_groups()
> remove_nh_grp_entry()
> 
> 2. Act upon the flushing indication in the various callers of
> remove_nexthop() and remove the flushing from __remove_nexthop_fib().
> 
> 3. Add __must_check annotations.
> 

+1. Always send the smallest patches possible to evolve the code. Make
it easy for reviewers - and yourself should you introduce an intended
side effect.
