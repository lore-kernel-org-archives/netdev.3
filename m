Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206251;
	b=Q8z+BMePsDAm32OPslA+MDUnIMLyyDHptn4ht0UT5pKSHveUtefKPekyhGYJI3TgeXwf
	 eDRz+zhR1fWFFlBH6bmDao7y2JCtS/iCuRLACf5j+Jjfo3iiOBH13otuOtEzq4HAVqSYO
	 y/jpUp2EhgE/t19JOWFTY2DiireUQl9K21zbv5MWZRDr42LI/nr47+A6KtocWnsV22KIU
	 2w0Pazd2RjX3K7kIoaVVJAFcg7f20MdEsuy08VKIh5vJSVpsN+jmq8LiSXMxrHGKyfohl
	 s2wqkNvVvdt8jB23koQzbUHq6YH6TBqRt1kR5Dz74ue5emyAjs6pkN+y2T9jBn2ukHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206251;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Lf9pN3NSTDncbChFIaA1CziT+h/fl1PzcuS355jZpQ0=;
	b=C2CylflARRhi1DmJ8Rzn7UIFguszmTDUZ5R7pW1BuY6/xfIj8bTq/+OJyuO5VITaVy/v
	 SVrepMm3hdwEmhgfQiMRxtEa+YhCRUhFqnBf2YNP/56YiLdzyjT9uFraKCmJH1gXMnpck
	 7lLNvhaXxAaA3CBF05GqST3uK8oIPAP84wwhsofKOG6em7QXIr3QK6AlpNBK+JMSaPv7W
	 Qwl/33rTA4jc7+jotQ8tTo7DpvuI8yKNB/HRPyyu5DV06wxR8869U7YXw5VxdbnK+ITM3
	 ACaMUhj4nAvWG+9FI2+I1oeQTLL0ilfhvrLi+9f9RC0uHzC/q0xHaF8JWDXDN/Y1JCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ieee.org;
	spf=pass smtp.mailfrom=ieee.org;
	dkim=pass header.d=ieee.org header.i=@ieee.org header.a=rsa-sha256 header.s=google header.b=JyiBaDZc;
	arc=none smtp.remote-ip=209.85.167.176
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4CD606A31F
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 16:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF4CD606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ieee.org header.i=@ieee.org header.a=rsa-sha256 header.s=google header.b=JyiBaDZc
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-53ec2cc397aso796615b6e.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 09:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1793206249; x=1793811049; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lf9pN3NSTDncbChFIaA1CziT+h/fl1PzcuS355jZpQ0=;
        b=JyiBaDZcdBn3+lmaSpdcsZF6lxVbYeELGVLjKmrkU242phXf4EOrD6UfetUJj3UGkD
         9IllrbESu1lxYeeDmC5szgXoH+FgPPyXthKrhN4txz5sBPq+r+FyZRxXP0wj5LFCj5ch
         LCryPPkOU+LvQs2d0dVHynxL1peLPVJb9I76I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206249; x=1793811049;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lf9pN3NSTDncbChFIaA1CziT+h/fl1PzcuS355jZpQ0=;
        b=VS/7TQ7iWFkM7XZ/S/sYqWRz1ooEUsXhOnc/MM2lEpYZOzOKPob3nxn4dHi0mz136m
         dE99m9QFlVAe/Rq07RNFpabffST+NQfIsxS2H+63/gPHoRloT07sCrAl1w5wHtIBxcji
         8i+CkfZc77laKiexnKvOtghP3ufUCmJbbCwnjxfDeA2ZVAm0Kr9Z9EWgrBP2f9pIZ5YM
         O8FvIc7kdWiL/35ra7nYMSC6do762DI/GGUv2rBysvD5askMLESl4zXLnGOkmYC/wayI
         8pJqIc/Nuon1GERlBEhTRZ0cCo3/NgK4a9CQe9QOPUGxge8UB4bFZIKqeauo/xj37URc
         tFVw==
X-Forwarded-Encrypted: i=1; AKwUvBxQtAkPnoscnHEr7Lsl3y5ES9uJipYohWLJ/0jnKunAt/1JIxY5CZP4k7YZSsL98ynM61WSg50=@vger.kernel.org
X-Gm-Message-State: AFq9FYKnt7I69iUJcaJABeUnodizcEExGd4/vNTxe8ORObAJrXChAW7e
	kK95XYUx2FntQcLapBIIt2OsjX2AlS83B2ZhNvcKu+y7pANQOy6ppfuiJmgIYMej1A==
X-Gm-Gg: AYBFou3MLp4GYylsCKxxDfwAuMbQIk1mo9LkRwNon5AEGT4z8u7xVVw05AUIo6koMHu
	94gqEgHVFRG8MSXZkAfd5ht7quIN0z1E5h9q1Jg2x1bbPDcqVfS1jb0sH7v9rUANJI4ZvAHO663
	VD/B4mAWtFOwk7Y9E/fMwJQ3iqpY/RfLTezR7fvXsXdo6dnvmBF0UGfIlGmPT/VhhaHSAa8J5LB
	iRoe+sid+15Nu8tNiacpk8GWHdt4T3fDlh1o5GBHTd/xnr6esFLQokAryg80tVR2jqZrdri0HgV
	wKVenmSTyqDHzg/fHeTBjwpMVAQ7XEOXotUa82hi67zvya1SkjEujTIyVQm6u0QJSs6AeZysJ7C
	7XSFdrJKEcWHn8Ep2RmflaMEYfZXC9/lbH6CSfiXUnYIFJObe4IpnDBoAlCVVfBvPn7xzhm76fM
	287tK13heLRrNkk4heKU3dgJj27w/CPGmT2kSzhxud/sXJ2g7DNXXZ8UaHJf7PGAZPzhbMrHsil
	g7vekBBjsUA5rGkNDSFMGS15+0b4ywj8apOAjcNMwbMMi4oKglU8VWDVnipJRNaeGagdTb0iHZM
	1nzTWJ9IPM/gbqatqC25PG6485Dm6IwujzRT8AtVjj3BMw==
X-Received: by 2002:a05:6808:f0d:b0:531:3bcd:41a with SMTP id 5614622812f47-563843a31e1mr2172905b6e.59.1793206248735;
        Wed, 28 Oct 2026 09:50:48 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-563c5a4d8b7sm1514936b6e.8.2026.10.28.09.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 09:50:47 -0700 (PDT)
Message-ID: <b999bf45-8e9c-4a49-b39e-f5c68b5e48ed@ieee.org>
Date: Wed, 28 Oct 2026 11:50:46 -0500
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
From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] net: ipa: Fix double free of the interrupt structure on
 config error
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "open list:QCOM IPA DRIVER" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20261028102327.28263-2-fourier.thomas@gmail.com>
Content-Language: en-US
In-Reply-To: <20261028102327.28263-2-fourier.thomas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/26 5:23 AM, Thomas Fourier wrote:
> Since ipa_interrupt_init() allocates struct ipa_interrupt in ipa_probe(),
> the structure is owned by ipa_probe() and released with
> ipa_interrupt_exit() on its error paths and in ipa_remove().  The error
> path of ipa_interrupt_config() still frees it with kfree().  If
> ipa_interrupt_config() fails (called from ipa_config() via ipa_setup()),
> ipa_probe() unwinds through err_interrupt_exit, which frees the same
> structure again.
> 
> Drop the kfree() from ipa_interrupt_config(); it should only undo what it
> set up itself.
> 
> Fixes: ad1be80d7582 ("net: ipa: introduce ipa_interrupt_init()")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>

This is a good catch, something that really should have been caught
when that commit was reviewed (even by me...).

There is another problem I now spotted, and I'd like to have it
corrected when you submit version 2, because it's really related
to the original bug.

At the end of ipa_interrupt_config(), we (still) see this line:

         ipa->interrupt = interrupt;

That now happens in ipa_probe() (which calls ipa_interrupt_init()),
so shouldn't be repeated in ipa_interrupt_config().  Similarly,
ipa_interrupt_deconfig() does this:

         ipa->interrupt = NULL;

That's meant to be the inverse of what was being done in the
config function, but it should no longer be done there.

(There is no corresponding ipa->interrupt = NULL assignment
in ipa_interrupt_exit(), nor in ipa_remove().  There is no
real need, because the ipa structure will never be referenced
again after that.)

Thanks.

					-Alex


> ---
>   drivers/net/ipa/ipa_interrupt.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ipa/ipa_interrupt.c b/drivers/net/ipa/ipa_interrupt.c
> index 131b9cc94201..17cefd6a0b18 100644
> --- a/drivers/net/ipa/ipa_interrupt.c
> +++ b/drivers/net/ipa/ipa_interrupt.c
> @@ -260,10 +260,8 @@ int ipa_interrupt_config(struct ipa *ipa)
>   	interrupt->enabled = 0;
>   	interrupt->suspend_enabled = bitmap_zalloc(ipa->endpoint_count,
>   						   GFP_KERNEL);
> -	if (!interrupt->suspend_enabled) {
> -		ret = -ENOMEM;
> -		goto err_kfree;
> -	}
> +	if (!interrupt->suspend_enabled)
> +		return -ENOMEM;
>   
>   	/* Disable IPA interrupt types */
>   	reg = ipa_reg(ipa, IPA_IRQ_EN);
> @@ -299,8 +297,6 @@ int ipa_interrupt_config(struct ipa *ipa)
>   	free_irq(interrupt->irq, interrupt);
>   err_free_bitmap:
>   	bitmap_free(interrupt->suspend_enabled);
> -err_kfree:
> -	kfree(interrupt);
>   
>   	return ret;
>   }

