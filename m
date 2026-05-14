Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0C718872A
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 08:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778748423; cv=none; b=ZqqJHtAwT5mNvZ1Z+C4lLmpHg+MjDZsccAtoM46bJxk78Kq87LQckwjgCNYQ5q7qqzz4J+J7FoQ5ELhxlBxpUSPLbYbS21IjCmQtk24SPDLaIGPcjEb0O6sh3bgpxB9T5xcWfOSqoqsXCJnVjAKMWK3F4xUNkmINyUwGiX2rTxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778748423; c=relaxed/simple;
	bh=Tjk2mgXP8nCLMjxaj84LrGvT2za1jn81Qql0+HH2m60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BvqT9ycbTFoOoGjoW8Gri6bvywx+YPBssf4GKJ5/2XifJ6SKkKvkmCOabjH6kE9d5uXLUwjqJULTRtjGw83FCB+9VrOcWdZipKwh3sNG+NnvoYfOzRBW765HgnL6N/ItpjKAbKUZu/9iJaixae/XX4JhvRg7JSScMSagdSmFM4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CpRpluom; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CpRpluom"
Message-ID: <1707b255-05ac-4d7d-8f06-3c7ac37a23f9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778748418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L+5vhYqOMs+08q5GCwnmHLIY4Q44MOJ70WpVzrtoxJk=;
	b=CpRpluomy60mzT8PZlRIqei7RdDxjZrTBwPkEex8a/yMA/MUUD1TrZgUoHQKbrHC79uiQd
	l38VOplzHlzN+3w8edRGDeuUFFEglJP3F3WP6dWFGgoO3NI0TPOA4hjkx2Xfl0vQ3fhFUF
	qZtB+w3iVhIGX7szMjPg4XSbcvyACwc=
Date: Thu, 14 May 2026 16:46:49 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: skbuff: preserve shared-frag marker during
 coalescing
To: William Bowling <vakzz@zellic.io>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>
References: <20260513041635.1289541-1-vakzz@zellic.io>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260513041635.1289541-1-vakzz@zellic.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 5/13/26 12:16 PM, William Bowling wrote:
> skb_try_coalesce() can attach paged frags from @from to @to.  If @from
> has SKBFL_SHARED_FRAG set, the resulting @to skb can contain the same
> externally-owned or page-cache-backed frags, but the shared-frag marker
> is currently lost.
>
> That breaks the invariant relied on by later in-place writers.  In
> particular, ESP input checks skb_has_shared_frag() before deciding
> whether an uncloned nonlinear skb can skip skb_cow_data().  If TCP
> receive coalescing has moved shared frags into an unmarked skb, ESP can
> see skb_has_shared_frag() as false and decrypt in place over page-cache
> backed frags.
>
> Propagate SKBFL_SHARED_FRAG when skb_try_coalesce() transfers paged
> frags.  The tailroom copy path does not need the marker because it copies
> bytes into @to's linear data rather than transferring frag descriptors.
>
> Fixes: cef401de7be8 ("net: fix possible wrong checksum generation")
> Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb frags")

Tested-by: Jiayuan Chen <jiayuan.chen@linux.dev>

I have reproduced and tesed it in 5.15/6.6/upstream with 
https://github.com/v12-security/pocs/tree/main/fragnesia

This patch fixed the issue.

Thanks

