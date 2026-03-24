Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4A938AC8D
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774368564; cv=none; b=nwp8RktoPiyx5xvF4ku/6zFWuwLg4gWkMp53gXUcPhjnqTAPBqUz6uFmReBAy3TU5WPeT4HrwNaPSM78uTNt3jdM/GR8FeSD3Y+9yG8YmkXmL18j+DJMVTYxMFN7Gg4ElpGA2U1+JJ/LjRYfDgLYqTtrZxlRNCjBrwccnxoKQtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774368564; c=relaxed/simple;
	bh=nWWgxSjMPn8qLERCMk6fKljwUTewCVcHcgRYuXb7X2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xpt1ZQqcLwIL2QO8/xf85l27NgihpTnr1pmv/DXoI2EJ6CrrIST+/5CDHZUNn4sfOxieFjaHrvzTlYpqWDvkFUYLC54jT6d62jnQtMlUSeJIMy7TU5CvmUHSugxjlBRB+STAqTzNX+lBxE5n2BL2YWandBJXinOJGHq3fHi+Sw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jt6wfH+h; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jt6wfH+h"
Message-ID: <2e5451ee-e185-4824-a5a3-99e65e789a06@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774368561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4+QAOWGvbep1Tnu9V/+K+Lu30vG9XZkA8aIFGgqFC18=;
	b=Jt6wfH+hwscFwKQnj9JuCykDau/QyXvDs+W5bhpVZlAXcndZ45osSwi/YVAp/gU1Twiv/6
	hvA+7U6Yj9GRUq+tv0PcfNkYP34yGL2lnn2BW8TndFRfZeOXjFKdxm+ZB4Gsb8hf9vfdFN
	bIADTxvTRtZ3Cngx1UL1B0LgGELolnY=
Date: Tue, 24 Mar 2026 12:09:07 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 1/2] net: xilinx: axienet: Correct BD length masks to
 match AXIDMA IP spec
To: Suraj Gupta <suraj.gupta2@amd.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, michal.simek@amd.com, radhey.shyam.pandey@amd.com,
 horms@kernel.org
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, harini.katakam@amd.com
References: <20260324145353.1899248-1-suraj.gupta2@amd.com>
 <20260324145353.1899248-2-suraj.gupta2@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20260324145353.1899248-2-suraj.gupta2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/24/26 10:53, Suraj Gupta wrote:
> The XAXIDMA_BD_CTRL_LENGTH_MASK and XAXIDMA_BD_STS_ACTUAL_LEN_MASK
> macros were defined as 0x007FFFFF (23 bits), but the AXI DMA IP
> product guide (PG021) specifies the buffer length field as bits 25:0
> (26 bits). Update both masks to 0x03FFFFFF to match the IP
> documentation.
> 
> In practice this had no functional impact, since Ethernet frames are
> far smaller than 2^23 bytes and the extra bits were always zero, but
> the masks should still reflect the hardware specification.
> 
> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> ---
>  drivers/net/ethernet/xilinx/xilinx_axienet.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> index 5ff742103beb..602389843342 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> @@ -105,7 +105,7 @@
>  #define XAXIDMA_BD_HAS_DRE_MASK		0xF00 /* Whether has DRE mask */
>  #define XAXIDMA_BD_WORDLEN_MASK		0xFF /* Whether has DRE mask */
>  
> -#define XAXIDMA_BD_CTRL_LENGTH_MASK	0x007FFFFF /* Requested len */
> +#define XAXIDMA_BD_CTRL_LENGTH_MASK	0x03FFFFFF /* Requested len */
>  #define XAXIDMA_BD_CTRL_TXSOF_MASK	0x08000000 /* First tx packet */
>  #define XAXIDMA_BD_CTRL_TXEOF_MASK	0x04000000 /* Last tx packet */
>  #define XAXIDMA_BD_CTRL_ALL_MASK	0x0C000000 /* All control bits */
> @@ -130,7 +130,7 @@
>  #define XAXIDMA_BD_CTRL_TXEOF_MASK	0x04000000 /* Last tx packet */
>  #define XAXIDMA_BD_CTRL_ALL_MASK	0x0C000000 /* All control bits */
>  
> -#define XAXIDMA_BD_STS_ACTUAL_LEN_MASK	0x007FFFFF /* Actual len */
> +#define XAXIDMA_BD_STS_ACTUAL_LEN_MASK	0x03FFFFFF /* Actual len */

I think

#define XAXIDMA_BD_STS_ACTUAL_LEN_MASK GENMASK(25, 0)

is clearer.

>  #define XAXIDMA_BD_STS_COMPLETE_MASK	0x80000000 /* Completed */
>  #define XAXIDMA_BD_STS_DEC_ERR_MASK	0x40000000 /* Decode error */
>  #define XAXIDMA_BD_STS_SLV_ERR_MASK	0x20000000 /* Slave error */

