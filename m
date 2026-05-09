Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9162F8EBE
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 01:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778290345; cv=none; b=SL+zV1MzG/4j460iduRYUbbGoCE2ksQfpoqIKqXK+hg2tbynfMr8QyvGZSy5WNVAnRDrIiBa5PmMMGoItKLllkyO0VUSXHSuK4JQpODQQJjRFMqAz4k/OfI7CQFBFYSZ29FBG5T5c9HYqJ5U2u9uHRrLVJknKHZlYbzzRXYqOek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778290345; c=relaxed/simple;
	bh=A2CHEnH7HIiJd44A/owsr/VuD+rsw11rRjZ/M0jBzfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dULBTvOKdo60sTMx9Gd+nzdqxahjfX7usjKRas10xdwAIx/ZElad0wfbPlZI4eSGQoO/qsHZZP5aprs+zv60qV4PNl8FcXht6IZDw22QWtF7cVwk/42WZc3yUz+upyZTTmYBXBZPvO77PpIsqdKbH/0JD06cDqLpfXIuOz+ECRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fZ6yQpZI; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fZ6yQpZI"
Message-ID: <85cac832-64f1-4968-abcc-460b8df8918b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778290341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/9sOUkwakbVV7WsZnPUpKNQQ3Ghif9Itez6rShJQHbg=;
	b=fZ6yQpZInDc9XUpWEbt4tmkjAembd2rvPFPemj2+f4eh3H6r+8hD3gQbJ3GUopmZWy36Vz
	W1J+GJpYB8bcmbcw+ZL9CSIGV436hy9npRRfnG2MtikHDE7QtKoJ8SaKh3Wi8A2vMHOPQE
	fHMVkOpyKdK8pTk5uxyFmEECkVxYrbA=
Date: Sat, 9 May 2026 09:32:06 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] rxrpc: Also unshare DATA/RESPONSE packets when paged
 frags are present
To: Jakub Kicinski <kuba@kernel.org>, Hyunwoo Kim <imv4bel@gmail.com>
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, netdev@vger.kernel.org
References: <afKV2zGR6rrelPC7@v4bel>
 <20260508055716.89380-1-qingfang.deng@linux.dev> <af19tf9gX3sxIrWr@v4bel>
 <20260508132532.2008a68f@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <20260508132532.2008a68f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/5/9 4:25, Jakub Kicinski wrote:
> On Fri, 8 May 2026 15:07:49 +0900 Hyunwoo Kim wrote:
>>>> -	if (skb_cloned(skb)) {
>>>> +	if (skb_cloned(skb) || skb->data_len) {
>>> Ditto.
>> Thank you for the review.
> Maybe skb_ensure_writable() ?


This also works, but has a subtle difference that a new buffer is 
allocated with GFP_ATOMIC instead of GFP_NOFS.

