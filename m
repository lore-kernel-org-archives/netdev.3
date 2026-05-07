Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2CD43D501
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778166887; cv=none; b=tHnV6y3YnCjM9hNrLVGmClI40L0w7WJXAk/5f5ERt40hp4pJIDVXM1wD03uy90TW75yl4BAdX4A1ZKsDnqMm6U2hq5N0onm1pp4NpEvD5awBfNUgKWzTUxeASc+9cMUyL2oggl2NrEarmJ4mg1V+PmJdslboe5uF9GuKYsXUajU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778166887; c=relaxed/simple;
	bh=oySXrSYtbFOtahaO6ajCsXz2ZpbBeZvkAh1wEowghhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C487+yUkziF7hntRo+YSmDUcPaPpehQ8hXX9MxrHjXHGJGZtJL/5GSHXq/btLVEdxpGqAxQw2gKg/7Jq+Y4rDCdX3lRKj2KOLLlp4y57lD3jsijtzcq1bjcX299ier0wVAoosCJmReP8SoMUQEZCY7hJGt07z4T7q3XkQYSeGSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmoDDOHS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmoDDOHS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D93CC2BCB8;
	Thu,  7 May 2026 15:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778166886;
	bh=oySXrSYtbFOtahaO6ajCsXz2ZpbBeZvkAh1wEowghhg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CmoDDOHSAj/qntFkc1bHKd/kSiodEvVGFlOE9DUaN9FxJEgRubtkzwBQ/UzaSgkb5
	 b91+RiF/BL20g2SGYf8mTj1J1ClctYgO+5iT9b+kvUwJvT2At5nEi5LwqJ/xi7fYSM
	 fIqHdQdjdgHD2tHlSmgGZCZFsabzAs9XT2NenEvVzlmfXHaqKYgIyEzEy1qI929UUn
	 AYpkZJ/dUaRHsuRiuyivxNaGLfLb4mYVLrkx83XqIGYGSqteN4x3Z0YhZBOA/OID2f
	 pk0FdipimQ2YsnHogvdfCPSzVrPvQKmCmE0dZAFgqMA8+5sQ/ks3I08n9AeXgr3YGl
	 T+f5iJT1zEckA==
Message-ID: <92000819-e8c1-41ff-aef8-aeb587cb4dae@kernel.org>
Date: Thu, 7 May 2026 09:14:46 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] ipv6: use SKB_DROP_REASON_IP_OUTNOROUTES in
 inet6_csk_xmit()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20260507084305.2506115-1-edumazet@google.com>
 <20260507084305.2506115-4-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260507084305.2506115-4-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/26 2:43 AM, Eric Dumazet wrote:
> Replace a bare kfree_skb() with a modern sk_skb_reason_drop() call,
> and provide IP_OUTNOROUTES drop reason.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv6/inet6_connection_sock.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


