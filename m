Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105B135B631;
	Mon, 16 Mar 2026 23:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773702769; cv=none; b=suIJB0+iJn3FFYMzb3jp+QFyItHFW/NveCDure1YCLPgnaavjkPvGWol/GHixHRJqdReKx0DJ2m+S3/e2X7zzk2OPHMZ6nHzHhbqqUQEDPXGrJ8CMeVglq5ddwvxOyoLT7IpJtxgmLYfL5fxmna7cle98qJDDppmKkR1o9y80T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773702769; c=relaxed/simple;
	bh=UuCWu1E+X+c4UbX8LIGSxoyafVIzX2+eDRO3RObJsNc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SSRhWbtKmagTqJnTt+V9lnRqp7ONuRGZ8+KnkfDbAfQ4GxlCqoG0XxbTXTt7XMPXVSttU/G0o+abncqwUbbr0X4I9Ht1tM80xLROcKy3StYdQ372mF2877ot9WmY25BoII9MQf01YBj0+Czeo3JPuv1yIm1yRxnC5i4t/TjIN24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iiu7P0K0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iiu7P0K0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C484C19421;
	Mon, 16 Mar 2026 23:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773702768;
	bh=UuCWu1E+X+c4UbX8LIGSxoyafVIzX2+eDRO3RObJsNc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iiu7P0K0IFnFPgl6l5xw20aBCTKvwZKuYBAV3CaOeRvV19JdM7run4z7kKZPz5dHN
	 aALM6dkffsD9rn05Is3E5rxodIb4dnyJlAEm77ocZZ2SofsxEZX+pR/FLZSM3W7kNc
	 DZV8v1utnkzWcLj4tBFN2iaWpk2i7KY4P28CkqQRlsH5Jk42PRtEI4o9j4x2CPGlrH
	 PMLWPHdXc2dwCaYPPgwQtEWtMqHE2DNgW17INvTVgPOFb8c2PhMf71hiqj8IRdQhD1
	 mrKyDUKApD/BuhluZvVeFunxmG+T60sD++vlWmRtuoGijeKskM8pvzAp0eEpMh0rBU
	 NEAPd9bRqmFjg==
Date: Mon, 16 Mar 2026 16:12:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paul Moses <p@1g4.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, jiri@resnulli.us, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] net-shapers: clear hierarchy pointer and defer
 flush frees with RCU
Message-ID: <20260316161247.1f472be5@kernel.org>
In-Reply-To: <hHYLQqDrBCcK_2x6uSbGsBott3QuXe8o-R9tj4vNmw8UUEFxpzoD_PCMiHMyyOnySAtQbJtCAB8yVoCmWxzO07C02Q5o0J6fHu4NLEa-ggY=@1g4.org>
References: <20260309173450.538026-1-p@1g4.org>
	<20260310192842.3c3b2070@kernel.org>
	<hHYLQqDrBCcK_2x6uSbGsBott3QuXe8o-R9tj4vNmw8UUEFxpzoD_PCMiHMyyOnySAtQbJtCAB8yVoCmWxzO07C02Q5o0J6fHu4NLEa-ggY=@1g4.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 18:45:48 +0000 Paul Moses wrote:
> > This is not the right fix. The shaper hierarchy as a while is not under
> > RCU. The problem is that we take a ref on netdev and then lock it,
> > assuming that it's still alive. But it may have gotten unregistered in
> > the meantime. The correct fix is to check that the netdev is still
> > alive after we lock the binding or take RCU from the Netlink side.  
> 
> Ok I see it now, I didn't care about anything except queue because it's the only 
> path that affected both drivers. This is an entirely different issue.

Did you write any of this email or am I just talking to an LLM?
