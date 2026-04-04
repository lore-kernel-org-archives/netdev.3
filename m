Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DEC264617;
	Sat,  4 Apr 2026 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775325691; cv=none; b=vGXCkaKfz+2n4cfkKIsBLbUZCHB4nkEdr4kuQ0uXGvjkRQooQigMoap2Vqm6Ve4SbCZc45NNFmxd9ABT/hc3v/f7V5IwMxJKxOYNm6Fiv9WzQkoTDZerTZCpsQibnAdAIqv5pVs7VjK4mZBAW+YHZ7kiHFBYvdLzoGtMa7gGL4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775325691; c=relaxed/simple;
	bh=6QnL9jUurZAPYvQY9mmmz+z5pFiIgACtGkO3d2N72XA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+3WcYaQZrNG1N856dQ/KFJAXk7sq9oVJJfvSAvCi9kcXvjCRPzPx/pJ54MYuDT39dIPuVAIES+2iazNMzbHL77ORuLELihJa80Cj/shRZxvjgks+yjlQIBdkY6XOG3e1j6pLKqCZ50Iw9+2xabye2SdPfYenAzfKYQ7uKzxWVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqRVHtaQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqRVHtaQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32903C19421;
	Sat,  4 Apr 2026 18:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775325691;
	bh=6QnL9jUurZAPYvQY9mmmz+z5pFiIgACtGkO3d2N72XA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gqRVHtaQMHNu+RbPz3YU6PWSZK9L3wKRWvT+xV/UFYKwDpXgJu8ZyWy+RDztanaFz
	 TBI/Z4vlXGOyLdZtE2hSVJF0htmSB+krX4eWjsy3fcrt27i+CQSazLpw2z5YV8gK1K
	 4YO3IN+VU2KYL1e55G309Vk7F2ooACh6Dwc3Wsia6keoQfBhFXPIh6dJiNeRm+SURX
	 vQ6S/PjBa4OzBUHPOnp9Wi6eViRJ/NSMDMSX6gF1zhKRQBZARMr5q0bk3u9jZcVs0W
	 6ErwUYyQ69PmrlNQRDj/g/C7F2/w+4KSPqs21vzQk/qIK7h/Kenfa7HctkRx2ozM+U
	 ZGV0GE8kDzQNA==
Date: Sat, 4 Apr 2026 11:01:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>,
 netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] selftests: net: add act_nat ICMP inner checksum
 test
Message-ID: <20260404110130.0407d4cd@kernel.org>
In-Reply-To: <20260404120310.88218-2-devnexen@gmail.com>
References: <20260404120310.88218-1-devnexen@gmail.com>
	<20260404120310.88218-2-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  4 Apr 2026 13:03:10 +0100 David Carlier wrote:
> Verify that act_nat correctly updates the inner IP header
> checksum when rewriting addresses inside ICMP error payloads.
> 
> The test sets up two namespaces with act_nat on a veth pair,
> triggers an ICMP destination unreachable, and validates the
> inner IP header checksum in the received ICMP error.
> 
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  tools/testing/selftests/net/Makefile          |   1 +

you need to add the CONFIG* dependencies to the relevant config file.
