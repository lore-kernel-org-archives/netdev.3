Received: from mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDA952F27D
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 19:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791921178; cv=none; b=bVEL/pvh2LYJLLdLHCAYQXnerrdDaIXJ5To/ezLJFn8eBWgCiKpPNztor15f6uymRTdl2BhQ7M+o3VmbuERyE2C1jaavwp+SzW2/4xAqv4hc2E3bK66QNIJddOZGm4wc0n1vKLt9LO/fgrVq8iod8sp1J8RtmGsi6sc00EIxAxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791921178; c=relaxed/simple;
	bh=5HGJb4w8FTtv64Jv0vfwAzYirRvRNpka0SUGJZ7ZDcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A6QH0af+UIXYa8+CUSHWLDo+bKRmZ5fITMufjkgmS7ZzjuBwYTTTk0QPyja9OrSFbeBNr8qU2OxjcpgjSy80ucZgAWTlp1OpszHv7MTVmtYdqRRzHOjtZMG3e5Uvx4dr7AaDF4CKWjQq6sQSwghTZXnsLOBhilt97HsDANI8TM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZN5k5FA2; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZN5k5FA2"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5HGJb4w8FTtv64Jv0vfwAzYirRvRNpka0SUGJZ7ZDcc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791921174; v=1; x=1792525974;
 b=ZN5k5FA2LHQh1GsPwsKgde5Gg6MpLd7ePNaP/Zp2k/CPw6SGcwg1xEEgozApg1GwtNNv4ofN
 5fuvS1BL2oZGmxR2cfVDx2PWchy9WUrFy74MyeMwhu32GZrxhQrNnn8IZTqm301GyTYOhHpi1JP
 oT4LukUUi5GbSquRcaU1+QyU=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 16f521b10fb5bf82;
	Tue, 13 Oct 2026 19:52:54 +0000
X-Mizu-Trace-ID: 16f521b10fb5bf82
X-Migadu-Flow: FLOW_OUT
Message-ID: <28b2c3ac-a128-4625-aab5-274ddcb7ccbf@linux.dev>
Date: Tue, 13 Oct 2026 20:52:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 5/5] ptp: vclock: preserve missing hardware
 timestamps
To: James Hilliard <james.hilliard1@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Yangbo Lu <yangbo.lu@nxp.com>,
 Miroslav Lichvar <mlichvar@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, linux-kernel@vger.kernel.org
References: <20261013-ptp-vclock-sampling-v3-0-d3ee4ea62fc6@gmail.com>
 <20261013-ptp-vclock-sampling-v3-5-d3ee4ea62fc6@gmail.com>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20261013-ptp-vclock-sampling-v3-5-d3ee4ea62fc6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/10/2026 20:19, James Hilliard wrote:
> Socket timestamp delivery converts hardware timestamps to a bound
> virtual clock before checking whether a hardware timestamp is present.
> A zero timestamp means that the packet has no hardware timestamp, but
> timecounter_cyc2time() can turn that zero into a nonzero virtual time.
> The socket then reports a hardware timestamp which was never supplied.
> 
> Return zero without conversion when the input timestamp is absent.
> This also covers skb_get_tx_timestamp(), which checks for an absent
> timestamp after the same conversion.
> 
> This was identified during review of virtual clock sampling changes.
> 
> Fixes: d7c088265588 ("net: socket: support hardware timestamp conversion to PHC bound")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>   drivers/ptp/ptp_vclock.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ptp/ptp_vclock.c b/drivers/ptp/ptp_vclock.c
> index 6675466bc307..4a62047f0ce0 100644
> --- a/drivers/ptp/ptp_vclock.c
> +++ b/drivers/ptp/ptp_vclock.c
> @@ -307,6 +307,8 @@ ktime_t ptp_convert_timestamp(const ktime_t *hwtstamp, int vclock_index)
>   	u64 ns;
>   
>   	ns = ktime_to_ns(*hwtstamp);
> +	if (!ns)
> +		return 0;
>   
>   	srcu_idx = srcu_read_lock(&vclock_srcu);
>   
> 

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
