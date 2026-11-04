Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816095;
	b=kzQPYZDUTccoP7oM7iLJ2VdepZcARZbrX+7wvDn0kMiAhsQ8Vz87cbGUwWI9rDHYvNtF
	 4HgJUZgxDYZf5wfL3CcR0Ff2HiTcO0WajPnlszKLD1mtYaWeVTUWwhl7H78n3EMCdpt0s
	 br42ztEm4feQHdBd6elQ/MPUIGzmWPoh21u5n4F/6/XJuF4Rq+eqWLFzPQ0JY6XwIThSM
	 H3dydflHa20uanLuVMUo3cwtJFP6CF7Fp7s9VEqMBS6pVAmDRCUEQNFcDpawMqEpxOA91
	 Facu2zGpjAFGr1QmliHdA24oT4ILwCJY6gHd2YW6RY3wi7n3RvuZfCKV1IYpq/VXBLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816095;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=8Xk2BhnFQcAvjOS2lpYo+AylAGsPFOuTphs26Y5dcmo=;
	b=YevCXbwzzsZJ7h/qphfxHUOWltIZBWa5fHwPkw6kxhbju5pDteT+CxvApGKHmi3+ipDw
	 8UdDaaO2thgUbU/WjfhjCe+kLgB9mh7bWX/kcD7Uvs40ZWZWqCq0afQ4F05hbkeYD1gvF
	 mlunrf/ChHLhO91Sx+TBwk++LHVFZUGdrQveIU6k8nbG3MJW4ynvJDsyOP93jMzYJkWO5
	 2xX/6iWButwIHn9rQh62+VjIB6BuCq/y0UOlYYTRF20u1QF3wxr3FZHxozYWqKVTzuGXC
	 qDNGu42uHFQgPdqJhWE12gNBzwjOpSZozVHzqbiO52PfXT6hvCtaDF0Qj1ZSVtS4sXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OqaUhg2b;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F1A606A33D
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 18:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67F1A606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OqaUhg2b
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ab41538192so911448a91.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 10:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793816095; x=1794420895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8Xk2BhnFQcAvjOS2lpYo+AylAGsPFOuTphs26Y5dcmo=;
        b=OqaUhg2bPAvTYMFg2a1t4YsDDsxAHaqW0bMqNLPxh2rp53Tj9UZDPlhEjFE28sqXxV
         BXRzcKOJBdPlMMe4wDYFLXw9p/9K4d5mtupQ/RZTBHbluSsbIZdQXR2TOcZqRejXWRH/
         Kimb4ClCLnO777xzP+hK6aKMv0Idu11t4sAzfn7kAHDVlo4k25aLCDhJcL2UQ5sh2Ecj
         oiMyH3IrkYKv74eYdA5L9231S7Iw3z8EzZlQsYd0xjLLbZns2tRtJjdDvVMnCP+MR9WA
         4xoRJ46kux+JbTn+gETLnljndGmG28Y7oCMrJ+FVrWWiSWw2mlwP4bFkIgz1Zi7ek7hf
         z3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793816095; x=1794420895;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Xk2BhnFQcAvjOS2lpYo+AylAGsPFOuTphs26Y5dcmo=;
        b=QWnNPjkHkGS57a6r0UKpSvkDhp8IOGj3BqjiK0yOcgADeLrdaNax6K2Q8dS3ci3uOB
         exXR2s/HCsJceQMmeoeSEhTYlZXyslnDAGpaaAhyZgOQOMnrJHb6skdvWDQf8tjtWyMD
         18IlnmcD03L5esEgeQpz0DbIitxlyYnS5hUX+iLEz3/Yztu8/aDTCm3VjjmWMH6FEpyX
         /jqpkB81vSoqkLaAhGmuekOEyAOwDWGSZEgiqVKYo1/S0MYobwP979bvAWr+7bgC2fyh
         YUXufQCJXWxHQQhNxGzYAJzuc1G74hyNiAbAcISbqcvaDanD1P4VZGU/49K8qnZhbwot
         4+aA==
X-Forwarded-Encrypted: i=1; AKwUvByyRbuTq5nWwc3LNMqTfblOJoWfWh/sJJVV6R/ETsCbuAU50tJRsgrtWekAsuf+eWbJyGSaQR4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/VuiJkYlVA7OTY8y5U38ASZXlfR1+1sI3EyvG7ais506XzSGC4
	HexCeTpEA+yObYV9OvaobeqyOLUR+Q+EfBRh5ThiuZMY+ixQRqLhvavGFA6OvkxXLA==
X-Gm-Gg: AYBFou04lrLfeIPztrrtXi+PUL7S74LrU/E2frnCvln277hEmwZE2SolKOTV1715hKP
	oocuguugu+9ce6PKMxf2Pci5fTnY3uvEAZq39oprgqSTVf54H0jQJNFx1sbWWLSYHiGDwQ+YNtk
	9lNxX99yKNry39Y3sFcq4A/NmEzyAU5+skRKkGjFoeqxcnzGZEX5kvQPD7Z1mbq6bqpzDzyFgso
	ZhYindWlvUBcMUlk8kYpTrGmQUzqDke16R45FUeu03eDH6zPBkdgiVqqbOQzjm7R5/C2ku26nCb
	WkLaYn/LnLMEMx+CQ7el8RIMlPbMZpDeuoi6QpCeCjtfeiOljbISEanWrqWpDdGWH1X3G7z8U1s
	JodZE/GTIIZWsYVdGffKO/oGgXAs+2u2qGcBYPxUMlN+WPDplMwqTElmnUqwD4nKeeyoBIFw8GK
	s2ZkA1zdWy/gSlXDWqbXZUY3ZBl4VyR1uqf+8vwqh2Kow0iSNe1/v7H4wKZOFOTj0b2NY9iNUi7
	oQvZ++5ps/LhzHMoc2dGTOm7ZKPiVIY+tVT1JC4zvCTBTRk+Haw6IYsdAAqXyM6LL9Z8nh1rH+T
	+q4Z4QZqg2656uAvsBdkOFHkG3Ok0tKIJSgHiP9O61qdmXBSoljBsadE+iDZq88e3A==
X-Received: by 2002:a17:90b:2805:b0:3ac:c03a:38b0 with SMTP id 98e67ed59e1d1-3ae89574d99mr14239204a91.8.1793816094083;
        Wed, 04 Nov 2026 10:14:54 -0800 (PST)
Received: from google.com (60.122.127.34.bc.googleusercontent.com. [34.127.122.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b32678ecsm73968a91.9.2026.11.04.10.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:14:53 -0800 (PST)
Date: Wed, 4 Nov 2026 18:14:48 +0000
From: Brian Vazquez <brianvv@google.com>
To: Naman Gulati <namangulati@google.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH iwl-net] idpf: fix Rx payload buffer leak when header
 buffer allocation fails
Message-ID: <aut0VPowjLkQL5Oe@google.com>
References: <20261104013606.1527767-1-namangulati@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104013606.1527767-1-namangulati@google.com>

On Wed, Nov 04, 2026 at 01:36:06AM +0000, Naman Gulati wrote:
> With header split, idpf_rx_update_bufq_desc() allocates the payload
> buffer for a buffer ID first and its header buffer second. If the header
> buffer allocation fails, it returns -ENOMEM and leaves the new payload
> buffer in bufq->buf[buf_id]. idpf_rx_clean_refillq() then stops without
> consuming the refill queue entry, and the next NAPI poll retries the
> same buffer ID, again starting with the payload buffer.
> libeth_rx_alloc() overwrites bufq->buf[buf_id], and the earlier payload
> buffer is never returned to its page_pool.
> 
> Each such failure leaks one payload buffer. The pool's inflight count
> never drops to zero, so when the queues are re-created or the device
> goes away, the pool never finishes shutting down and
> page_pool_release_retry() keeps warning about a stalled pool shutdown.
> 
> This happens when the header buffer pool runs dry while the payload pool
> still has pages, for example under memory pressure: a header page holds
> several header buffers and only goes back to its pool once the skbs
> using all of them have been freed.
> 
> Release the payload buffer when the header buffer cannot be allocated,
> as ice_alloc_rx_bufs() already does, so that the retry starts from an
> empty slot. idpf_rx_page_rel() also clears the slot, so the buffer queue
> teardown cannot release the buffer a second time.
> 
> Fixes: 90912f9f4f2d ("idpf: convert header split mode to libeth + napi_build_skb()")
> Signed-off-by: Naman Gulati <namangulati@google.com>

Tested on an idpf PF (8086:11df), net-queue dev-queue (da74aaf50018),
TCP data split on, 16 TCP flows of Rx traffic:

1. A local debug hook makes the header libeth_rx_alloc() in
   idpf_rx_update_bufq_desc() return DMA_MAPPING_ERROR on every 20th
   call, 2000 times in total.
2. Recreate the Rx queues: ethtool -G eth1 rx 1024; ethtool -G eth1 rx 2048
3. After 120 s, check with tools/net/ynl/ynltool: ynltool page-pool stats

Without the patch:
    eth1[3] page pools: 253 (zombies: 13)
        refs: 150913 bytes: 618139648 (refs: 2000 bytes: 8192000)

With the patch:
    eth1[3] page pools: 240 (zombies: 0)
        refs: 152521 bytes: 624726016 (refs: 0 bytes: 0)

One page stuck per forced failure without the fix (2000), none with it.

Tested-by: Brian Vazquez <brianvv@google.com>

> ---
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index 885df6294ad94..7383d8241ead5 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -3745,8 +3745,10 @@ static int idpf_rx_update_bufq_desc(struct idpf_buf_queue *bufq, u32 buf_id,
>  	fq.truesize = bufq->hdr_truesize;
>  
>  	addr = libeth_rx_alloc(&fq, buf_id);
> -	if (addr == DMA_MAPPING_ERROR)
> +	if (addr == DMA_MAPPING_ERROR) {
> +		idpf_rx_page_rel(&bufq->buf[buf_id]);
>  		return -ENOMEM;
> +	}
>  
>  	buf_desc->hdr_addr = cpu_to_le64(addr);
>  
> -- 
> 2.56.0.398.g882cbad275-goog
> 
