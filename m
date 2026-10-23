Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.126
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792763478;
	b=FmH+f65UC8JJcmya1pG37VtIQXzJavhQDUVSXIfnliXw/zbjV7aL/bcV/dyB25ejz4aI
	 xpHMyfWD+e3afuUGARu6/NxA25WNGDBGLZPM4PnZsLlp/5iu36dFzn5gzT+f3+BPWfNbH
	 rORSCbGNoZjAzPepmRKP10PHDuDFE49pzpRSZkvg57jbPniPUR9ZqtAc7NdkNar6CEV/n
	 DRCcVnSKZaThdFgWG6NnqKM7qXKiWhuBU6txn0bhJd17p43FOeq8TI1+CArc9tm5VOCZl
	 qBYAQaU3KN8Yq2QrdLrm05xddoEVBI0lzQPLUqXbFeVuwZUcNC8gmpDz+gf5OG0k0RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792763478;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=CdsOu3OSEsynQJ6rdHJSUQdyHbmYdl9dN4nnm+613fs=;
	b=ei2tz4wgntBKJcMq1ewVDD27WPF2P90QMkRXd/jvtXjV1mBPkLVt6o1sxTA+6UOIKFxz
	 BFuQGaZ47W/E0FDzz/BGMmyVnEejWEy2SJ8OjG8bboAfHPcn0rHSezNrdq9PyKAWz9/hE
	 lqdfxBxmXc+5rV9pJEiQ8O8e5I35ohrzunoj9TNyrmC5e+nC6G3fhp/9L+MT7ScIg5Hnc
	 halxIP41vasXB5yQUUxuYSHvkZBha1g4WRE1KERXRHz5cWPuuU84884i/3cJm7m8aMEy8
	 ZgagWbfa9MbU2gsHQoqWZbksxp/8HhhLdrnfWiZvXRW5YVxl3AGBMaJvuqnoPGd0qhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=P4XJLwbO;
	arc=none smtp.remote-ip=91.218.175.126
Received: from mta0.migadu.com (out-126.mta0.migadu.com [91.218.175.126])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F618606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 13:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F618606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=P4XJLwbO
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=n/CwR0aupi+SV9gglaQoOTa0JU0PwKkfaExBUVamX4U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792763474; v=1; x=1793368274;
 b=P4XJLwbOe7Nkc3VGr+sPWO9ELMXTjFkVzrP2iBk2r3idn4Kips19yACAacyOCbKNuZ8vnX9O
 yz/am+PXfngvvanvImUSlNEm624i/VXnUNHHrjFYyAfDTU8AlrB/lOdzkJVQW4T6Gh2C6Mv6s6f
 IMXBQxK4siqDC2DehhiOiYaQ=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9ced7062e363dd41;
	Fri, 23 Oct 2026 13:51:14 +0000
X-Mizu-Trace-ID: 9ced7062e363dd41
X-Migadu-Flow: FLOW_OUT
Message-ID: <45128a4d-d92a-4966-b3a9-668de73d3d90@linux.dev>
Date: Fri, 23 Oct 2026 14:51:09 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpts: fix support for
 PTP_EXTTS_REQUEST2 ioctl
To: James Clark <jjc@jclark.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Chintan Vankar <c-vankar@ti.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261020003525.1237742-1-jjc@jclark.com>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20261020003525.1237742-1-jjc@jclark.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/10/2026 01:35, James Clark wrote:
> Commit 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags to
> ptp_clock_info") modified the PTP core to validate the supported flags
> of external timestamp requests, rather than relying on each driver to
> check them.
> 
> am65_cpts_extts_enable() ignores the flags, and am65-cpts was not given
> any .supported_extts_flags. Since PTP_EXTTS_REQUEST2 always implies
> PTP_STRICT_FLAGS, the core now rejects every PTP_EXTTS_REQUEST2 for this
> driver with -EOPNOTSUPP, where before that commit the same requests
> succeeded. Only the PTP_EXTTS_REQUEST ioctl still works.
> 
> Tests on a BeagleY-AI (J722S) show that the CPTS hardware timestamp push
> inputs timestamp just the rising edge. Encode this in
> .supported_extts_flags. A PTP_EXTTS_REQUEST2 for the rising edge then
> succeeds, and one for the falling edge or for both edges fails with
> -EOPNOTSUPP.
> 
> Fixes: 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags to ptp_clock_info")
> Signed-off-by: James Clark <jjc@jclark.com>
> ---
>   drivers/net/ethernet/ti/am65-cpts.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
> index efbf2ef976a..df5659ead72 100644
> --- a/drivers/net/ethernet/ti/am65-cpts.c
> +++ b/drivers/net/ethernet/ti/am65-cpts.c
> @@ -779,6 +779,7 @@ static long am65_cpts_ts_work(struct ptp_clock_info *ptp);
>   static struct ptp_clock_info am65_ptp_info = {
>   	.owner		= THIS_MODULE,
>   	.name		= "CTPS timer",
> +	.supported_extts_flags = PTP_RISING_EDGE | PTP_STRICT_FLAGS,
>   	.adjfine	= am65_cpts_ptp_adjfine,
>   	.adjtime	= am65_cpts_ptp_adjtime,
>   	.gettimex64	= am65_cpts_ptp_gettimex,

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
