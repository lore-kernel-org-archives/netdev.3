Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FFC3E9F92
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 10:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772189594; cv=none; b=PeUsGDoyiQ615pZbYIipAo/Ycm9dzYLgcBNTXi+nKlZukJZSyH5K9BAzLuH6g41p/MYkVrukYCzFu+O1JrOkf3+zV74AV2oFdCK4pG5cglM8c7SNXTLeQ77ESJKvN8ES+FnWih+KKX5W9OAk+QQhGNX3krfeDkfXurdetTp8mSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772189594; c=relaxed/simple;
	bh=eGrM0jDl+frkNNYvyMhzBflmvuBVGMudEcwWiLqV+r4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fkxkHYj1H9Vp66yWm8LndWvbPTNiiscZgAkas/ybkumWXW9kVbPaluBYTPxP6VJPtKNGEB+MgN4y4wt75VxPDbqqgqYaXkyhgoaPObXyuW49YKvuqL54zWpELj1GVdT3PX85dWBFrF6WloZIQL0q3yQ8ZkPwmf+gGTNcy7lBltE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HJlFgcnE; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HJlFgcnE"
Message-ID: <328c9b1b-43f0-4926-9ea4-12ea97036472@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772189591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xnrXoUnmccJNYRxxY7invs6d6S59ar9ZX0PftI7XRnI=;
	b=HJlFgcnE1yMwpxclJocw80gvZkcnHWh3Jk0PTk8PBEGpms6/ni1nmsVgV++F7JJ7T7XnWp
	kATI+EUrCCBI/pb9SaOemjbXTKsBM5jakNcw3uxLC6VMXrkqFIpWArRL8Z1ayDLEr4Xw9p
	dkBNDd6J09l8iNN0w4XtShOxqu18FGk=
Date: Fri, 27 Feb 2026 10:53:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] net: mana: Ring doorbell at 4 CQ wraparounds
To: Long Li <longli@microsoft.com>, "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
 Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260226192833.1050807-1-longli@microsoft.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260226192833.1050807-1-longli@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 26/02/2026 19:28, Long Li wrote:
> MANA hardware requires at least one doorbell ring every 8 wraparounds
> of the CQ. The driver rings the doorbell as a form of flow control to
> inform hardware that CQEs have been consumed.
> 
> The NAPI poll functions mana_poll_tx_cq() and mana_poll_rx_cq() can
> poll up to CQE_POLLING_BUFFER (512) completions per call. If the CQ
> has fewer than 512 entries, a single poll call can process more than
> 4 wraparounds without ringing the doorbell. The doorbell threshold
> check also uses ">" instead of ">=", delaying the ring by one extra
> CQE beyond 4 wraparounds. Combined, these issues can cause the driver
> to exceed the 8-wraparound hardware limit, leading to missed
> completions and stalled queues.
> 
> Fix this by capping the number of CQEs polled per call to 4 wraparounds
> of the CQ in both TX and RX paths. Also change the doorbell threshold
> from ">" to ">=" so the doorbell is rung as soon as 4 wraparounds are
> reached.
> 
> Cc: stable@vger.kernel.org
> Fixes: 58a63729c957 ("net: mana: Fix doorbell out of order violation and avoid unnecessary doorbell rings")
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
> v2: Use min() instead of min_t(u32, ...) since queue_size is already u32
>   drivers/net/ethernet/microsoft/mana/mana_en.c | 23 +++++++++++++++----
>   1 file changed, 18 insertions(+), 5 deletions(-)

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
