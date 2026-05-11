Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC34C175A68
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 01:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778464496; cv=none; b=pwFufPhMnDU2nS1puGoZvr4gbhsGVHQ0Z+XB6nOmDTEO3gRpiUsOEyGq9E7vw1nXfQ5OTMdMUYfVzkyNiott7MIcUjoOdTCR3QuPHn157bapLF3Rfz7d31A8+KjUeHSTcTBMHSyYcy57+EQXddrF5Vs5PwscmzBclmH6bYaarRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778464496; c=relaxed/simple;
	bh=L5+VfFmd4q0nELm8IyWO/MRLcTB5GIHfvdLH8IU4DUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L/rnG0PwFkfJcWDT7f5YEU84e7PJHT71pQcY9nw517z5LkhDF9hAigsGCcburT/m5IDogs2HChnsYcBhGpC6mc65sGF+N+laT4OXzUCO8tYyTpQXds+54ZANUiczSIAx5MVKTgqSn8/whRfhQMwrevczA+TWiFiBlFVa8VfwcwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qKDpFQrd; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qKDpFQrd"
Message-ID: <f7f242c1-5f54-4cf7-ac61-ff6e9c70394f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778464492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TtJTx1y6qo++kH6bgsIbuhUTA+JODMED3RgfOsmy8z8=;
	b=qKDpFQrdYzeLhV6rzhb44PWPIqqtAYufdwqtmobtv6ztEdckB6rCFHQbfQdnYmDxTHcMr5
	PLU/UTxCrkDRSX8HKEhKqctTWZc9JoKy7Y3VIDyFLN4N1QZ/BvFaWDONLMd3o5k1PyoO85
	tFw7hrusKyCNayIozAwR2esUSm2o0jM=
Date: Mon, 11 May 2026 09:54:44 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v3] rxrpc: Also unshare DATA/RESPONSE packets when
 paged frags are present
To: Jakub Kicinski <kuba@kernel.org>, Hyunwoo Kim <imv4bel@gmail.com>
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 qingfang.deng@linux.dev, jiayuan.chen@linux.dev,
 linux-afs@lists.infradead.org, netdev@vger.kernel.org, stable@vger.kernel.org
References: <af2kdW2F1gJ9U-Gg@v4bel> <20260510084520.476745b5@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260510084520.476745b5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 5/10/26 11:45 PM, Jakub Kicinski wrote:
> On Fri, 8 May 2026 17:53:09 +0900 Hyunwoo Kim wrote:
>>   			    sp->hdr.securityIndex != 0 &&
>> -			    skb_cloned(skb)) {
>> +			    (skb_cloned(skb) ||
>> +			     skb_has_frag_list(skb) ||
>> +			     skb_has_shared_frag(skb))) {
> We seem to be getting a lot of fixes for this issue, and this one is
> incorrect :| Writing to _any_ frags is incorrect. You have to copy
> if skb is not linear. skb_ensure_writable()


There is a issue Simon pointed [1] that triggered 
BUG_ON(skb_shared(skb)) which was fixed by commit d0d5c0cd1e71
skb_cow_data -> __pskb_pull_tail -> pskb_expand_head -> 
BUG_ON(skb_shared(skb))

I think skb_ensure_writable will also trigger such code:
skb_ensure_writable -> pskb_may_pull -> __pskb_pull_tail -> 
pskb_expand_head -> BUG_ON(skb_shared(skb))

LPE will become panic.

[1]: 
https://lore.kernel.org/netdev/20260501155806.222592-3-horms@kernel.org/


