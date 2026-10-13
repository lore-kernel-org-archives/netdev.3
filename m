Received: from mta1.migadu.com (out-91.mta1.migadu.com [95.215.58.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFA753F69D
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 19:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791920795; cv=none; b=UDVArmA8xG75aJ8cxyn9r65L0OnmPIrr9gAKh1Rdd+10H4ITToTeMvRkTaVxfDcYR31yJwXqfiIzr4D43/r96WnDWZs0c+basS6wGotsWH5bLmD1D4Lolgem5B2S/o0gbBnPj+fdaVCs6avtLRioZqFsMzq04PFDFo8Wn6q4ZEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791920795; c=relaxed/simple;
	bh=rlFTSKfCewl11zJZaS7wBrxYbGFIZ9qTqFBP4vMrQt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pCaEFkcfXyeIVMwRc33nhMRpxA8qHrt0Hs/AU37O77paJ1mmy/+GQNmfsmj+kGos9VOP+2H7cDByzWsFF6hh6jRbQqNakoXxJWxHq9096y9w2Gk2WC+qtVixe2WCEYIhmDVYh5Swu0PB46zstxr0+ep58ZbE6ptW7znXa5RocP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QY8MKAIL; arc=none smtp.client-ip=95.215.58.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QY8MKAIL"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rlFTSKfCewl11zJZaS7wBrxYbGFIZ9qTqFBP4vMrQt4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791920789; v=1; x=1792525589;
 b=QY8MKAILpJ/Zr6OSAgAR8t+xk7T07BEn4dBOnklMijM75DBUHX5lGz2DTL/NXZADH/GLGjdD
 m0sNclbolcYNzakmYqB7y5exUA3jxnq3jwM0DV8A5LL8wLN4hHJP5mDeDtdQL+muiwvi1DfbRB6
 Tsyf4eKDKCSClHO/WKYQwDRM=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ad2fe35b42f504b6;
	Tue, 13 Oct 2026 19:46:28 +0000
X-Mizu-Trace-ID: ad2fe35b42f504b6
X-Migadu-Flow: FLOW_OUT
Message-ID: <d03c6c1e-84e3-46df-b220-daf3a5c96327@linux.dev>
Date: Tue, 13 Oct 2026 20:46:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/5] ptp: drain virtual clock sysfs operations
 before unregistering children
To: James Hilliard <james.hilliard1@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Yangbo Lu <yangbo.lu@nxp.com>,
 Miroslav Lichvar <mlichvar@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, linux-kernel@vger.kernel.org
References: <20261013-ptp-vclock-sampling-v3-0-d3ee4ea62fc6@gmail.com>
 <20261013-ptp-vclock-sampling-v3-1-d3ee4ea62fc6@gmail.com>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20261013-ptp-vclock-sampling-v3-1-d3ee4ea62fc6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/10/2026 20:19, James Hilliard wrote:
> Parent clock removal walks its virtual clocks before removing the
> n_vclocks sysfs attribute. The mutex taken by ptp_vclock_in_use() is
> released before that walk, so a concurrent sysfs deletion can pick the
> same child and unregister and free its ptp_vclock a second time. A
> reference held by the device iterator does not protect that separately
> allocated virtual clock.
> 
> Remove n_vclocks before walking the children. Removing the attribute
> prevents new stores and drains stores already running, without holding
> n_vclocks_mux across a callback that needs that mutex. Skip virtual
> clocks, which do not have this attribute.
> 
> This race was found by code inspection of virtual-clock registration
> failure cleanup and parent removal.
> 
> Fixes: bfcbb76b0f59 ("ptp: unregister virtual clocks when unregistering physical clock.")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>   drivers/ptp/ptp_clock.c   | 5 +++++
>   drivers/ptp/ptp_private.h | 1 +
>   drivers/ptp/ptp_sysfs.c   | 6 ++++++
>   3 files changed, 12 insertions(+)
> 
> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index 4111342d64f0..47ffc773065a 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -508,6 +508,11 @@ static int unregister_vclock(struct device *dev, void *data)
>   
>   int ptp_clock_unregister(struct ptp_clock *ptp)
>   {
> +	/*
> +	 * Stop and drain virtual-clock creation and deletion before walking the
> +	 * children. Do not hold n_vclocks_mux while waiting for sysfs callbacks.
> +	 */
> +	ptp_vclock_remove_sysfs(ptp);
>   	if (ptp_vclock_in_use(ptp)) {
>   		device_for_each_child(&ptp->dev, NULL, unregister_vclock);
>   	}
> diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
> index db4039d642b4..ec8633126d6b 100644
> --- a/drivers/ptp/ptp_private.h
> +++ b/drivers/ptp/ptp_private.h
> @@ -169,6 +169,7 @@ extern const struct attribute_group *ptp_groups[];
>   
>   int ptp_populate_pin_groups(struct ptp_clock *ptp);
>   void ptp_cleanup_pin_groups(struct ptp_clock *ptp);
> +void ptp_vclock_remove_sysfs(struct ptp_clock *ptp);
>   
>   struct ptp_vclock *ptp_vclock_register(struct ptp_clock *pclock);
>   void ptp_vclock_unregister(struct ptp_vclock *vclock);
> diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
> index dc398c6b7528..53388b123198 100644
> --- a/drivers/ptp/ptp_sysfs.c
> +++ b/drivers/ptp/ptp_sysfs.c
> @@ -263,6 +263,12 @@ static ssize_t n_vclocks_store(struct device *dev,
>   }
>   static DEVICE_ATTR_RW(n_vclocks);
>   
> +void ptp_vclock_remove_sysfs(struct ptp_clock *ptp)
> +{
> +	if (!ptp->is_virtual_clock)
> +		device_remove_file(&ptp->dev, &dev_attr_n_vclocks);
> +}
> +
>   static ssize_t max_vclocks_show(struct device *dev,
>   				struct device_attribute *attr, char *page)
>   {
> 

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
