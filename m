Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA2C276038
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 11:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784719065; cv=none; b=G/aQyYHLt5EgFr+aNwS35I74k+xXoon7yMrMWdBTOvT9+rIOEs3OjPHC4qDhVCFHl+ErdFTydMcpPmhyD+O825kwRJPbiTLpDHa4NvtQVnNd7YRe1fWNhqE18bnOnKs/HZVJkVWjDuT3w5p9jSP9ju/VpMpfB1W7dLdWaKSjZ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784719065; c=relaxed/simple;
	bh=KFLx0weyFeuaqhv+jOKb1efGACZ+efDr9NO/LhLEdrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ph8humHeLEDToL8bTzSTTfjihJ+NCm+RV8I4HNeob1ulLeQOBlXVgrwuBFuS05AmIcg/mM6svBLLhp3Ew2wvUhBA1UA9Dubv8yJphx2qnzo2SiovFA0RgMRmAtI4th9N7p9Ml4EKAAozgJEhZcouDV4twsMro3INmFp5pVIfL3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vlNvL3Tm; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vlNvL3Tm"
Message-ID: <2c8655e9-208a-440e-bbeb-d72019e0131e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784719052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MTFYlM5TMHOGxBuJ3oIMVbQVAThzWkHvJw3n8CpzWmc=;
	b=vlNvL3Tm9Kr68ex3dS89EhVubli2c3VWYZ471xZAwC7iC6dPFz1qm0y94OlBuNKHZfSNJw
	RnTHs3FNMN6GnVnw+A4ZE0+u1xoJB3c3SrHhgqOnmWlJdUce+sslQUdnoO0OoQmZCkA395
	A0ZrRXBbgXnerAaikZk+tN2Ry/IBlBo=
Date: Wed, 22 Jul 2026 12:17:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] pppoe: reload header pointer after dev_hard_header()
To: Asim Viladi Oglu Manizada <manizada@pm.me>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20260722093814.3017176-1-manizada@pm.me>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260722093814.3017176-1-manizada@pm.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 22/07/2026 10:38, Asim Viladi Oglu Manizada wrote:
> pppoe_sendmsg() saves a pointer to the PPPoE header before calling
> dev_hard_header(). Device header callbacks are allowed to reallocate the
> skb head, invalidating pointers into it.
> 
> This can happen when a send is blocked in copy_from_user() while the first
> non-Ethernet port is added to an empty team device. The team's delegated
> GRE header callback then expands the skb head. PPPoE subsequently writes
> six bytes through the stale pointer into the freed head.
> 
> Reload the PPPoE header through the skb's network-header offset after
> device header creation. pskb_expand_head() updates that offset when it
> relocates the head.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Assisted-by: avom-custom-harness:gpt-5.5-qwen3.6-mod-mix
> Signed-off-by: Asim Viladi Oglu Manizada <manizada@pm.me>
> ---
>   drivers/net/ppp/pppoe.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
> index 4a018acb5..6874a1a8e 100644
> --- a/drivers/net/ppp/pppoe.c
> +++ b/drivers/net/ppp/pppoe.c
> @@ -825,6 +825,7 @@ static int pppoe_sendmsg(struct socket *sock, struct msghdr *m,
>   	dev_hard_header(skb, dev, ETH_P_PPP_SES,
>   			po->pppoe_pa.remote, NULL, total_len);
>   
> +	ph = pppoe_hdr(skb);
>   	memcpy(ph, &hdr, sizeof(struct pppoe_hdr));
>   
>   	ph->length = htons(total_len);
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
