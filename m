Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793296538;
	b=GCWqBzAAUJ/6HMo/zdVUWlt0Xbi1Tu3WleUFSF5xhDpkTqLeiiV6wBbOAjY3K8h8CBFG
	 VxnehNBmH2f5CfzQZ7ke7fah8HcyaJUHCL+/34CNS2KWorA8nxvaca0NyLCQjGR+N/bXv
	 Rf064iPV26Syx3N+2td0PDDJAsOCpAvua/Lw1rhWUWR+xvk7UXPo4emS2p5QzAfXgG/dV
	 yPL/SKDg7StZk1tcapnrMzsRRXCScgidx3urOVugmcYZymaKTEmqA6H5D8v56CfdYKEuQ
	 YSaJc6C3odBXt77zp2hfcLF5mbXOE6Fji5Tzyz45r+EYx3ekcTR9bSSxPuZ53beMOiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793296538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=W3HdUc2svh2jzPREwBXmGjOMOZkB12N8HCTpy3OSw+g=;
	b=SeNeOla3AgWxgVaFEtqHMUX6x/wtCP9mXZCespdMd/Ss2axyUNM1yRf1ViZBPvXHMJY4
	 Gch5kSYIO6PzeYCw/y2OyD1YiWlLbj8DVFbA+IVVuPRF4noFhZH2EWdXwUW6eFc2bRVuQ
	 cdHlckENj9szuLJsjduxwzDhZXHgsJ9t2LhpOFdwzovJrCvv0zVIQHWH081Pcu/WcM1CU
	 Xwr/SBROCtJDSv0y45y/1IibMhatuCrDD2hZR3BtJo7nkw6gYbg15CWJpEKNQmP8yzN0V
	 Vhg0y8zEWTUfCm5lA169HQXWtBNw1z1cex5sH0yth6NRobGuGcc9NNbLlYjxsTSwGtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ieee.org;
	spf=pass smtp.mailfrom=ieee.org;
	dkim=pass header.d=ieee.org header.i=@ieee.org header.a=rsa-sha256 header.s=google header.b=Y3L2EI6X;
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAC4606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 17:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BAC4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ieee.org header.i=@ieee.org header.a=rsa-sha256 header.s=google header.b=Y3L2EI6X
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-844a8bf7e25so1657886a34.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1793296536; x=1793901336; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W3HdUc2svh2jzPREwBXmGjOMOZkB12N8HCTpy3OSw+g=;
        b=Y3L2EI6XCTJlfv6Um30k1lylo5s5ob0sd1SCNIKTegObqMf0wEvS4A9IGz4HNMAkb8
         FXjRUmOvEYTY5V9fgH75wQ+nqsG6VdEY+XNmbN0/79f1QSutJa9rAqLEnxGfYUSZkWnx
         uHO0/wi0l48alNRz5c7BkH5cB2k1cNbPvsuI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793296536; x=1793901336;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W3HdUc2svh2jzPREwBXmGjOMOZkB12N8HCTpy3OSw+g=;
        b=OS45IEPthctURpCh3yqrsSyomylZmH1R6r4W453Eo10aL+O8eK2hhcYxI825zUAraK
         Oqk/boj17XqEKlNGzcAvyMKH4ZScrZbRIOBUkGAiBsiz8AyJ0QLnTaTGlo9zImS7452M
         wJGiXG8ybPP/IAVue4TwLcgh9FTgQhubgLuzHMI3dGmM6R5abwD99aVmcvmlKf2C31VT
         YZWqYoDA4cfb7QMJGUd9PSKG/suJbeBZxcB9Qzkv+nh35fUTMPbJK9yNqysh/1ilyLAV
         qN+sOWxrWF7xlqYHJNaR7xTmWAIn6aHxhioulJnih8zqe+sGMknOp026ASoe99QsYHFE
         GCMQ==
X-Forwarded-Encrypted: i=1; AKwUvBx5jmPCs6bZFm6QLLZwCQOk4GUaAw+aFzhHpprtSJIqercESwzXTB2yRKIXbr1xwkWdRCN+N7I=@vger.kernel.org
X-Gm-Message-State: AFq9FYI9ynWSUckkQksAWjLgb+/KYref+8yrKTlszZNaEHWj+nnCLz4M
	k3T7yWfj+yFvc/XcfbgMotCQbJxeITfgmpc386I75RfkPkg6zfvxVrW4x5Erj5UcCA==
X-Gm-Gg: AYBFou0+U8zSPQO69G/wwvfgnDsXbRABddtWLPxe3pvEdgrxcv+KFnfJD1EyYh+omCw
	AMale2YNCKUn6iQdgR9Huf17i8fs5N1/qhO0EnAoBDLd4WptJhq2F8JUU6R2TX3n8GePnaHKlqN
	/7GUOIDMelPMN0jbKcgw7aA0MQggfhy5XUr7YeWanE7sgJ0L51r21PnJkuhUMT4+lAMAPvQG/MT
	dlN925GDPpNfJd8qWOFmu2/B+K7RkBghE8ISJyxl+praC9Yn0JPsiUJWWt6maXc5uAn4i4U1G0u
	vp1e8KbZ+FDhsIkArp0gfcWG8b1sVvRsYmJnwwOLS0i6VXPDULh3Eygm+Gh/V6R2PPKX+wemVgs
	/tHSaQK7DmrEp9AqNOb7a6syLqiCVzZjw/BxEeyVUwL862lL9L+A5zF7pyEd0WGz8WJsUXQmk7V
	z6PSllYlx1eI2E1AlT1bIN3boAGegksoziXG4wGsh25W6T5eDhXUEntOFR18wPhhlxaCqz6XboS
	57SY6HzlG3qPy2YTQb+pvmO+pDi8nH/FF8R2xIeZpWvZ4eaFRQBMRV6bQuM2ZdjzdhGMZ5qG+Vx
	b3UO62DHUfOkn261/6DA7Edo
X-Received: by 2002:a05:6808:1694:b0:4f4:3790:6615 with SMTP id 5614622812f47-563a205d732mr3898135b6e.11.1793296536211;
        Thu, 29 Oct 2026 10:55:36 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-563c5437a58sm4414879b6e.5.2026.10.29.10.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 10:55:35 -0700 (PDT)
Message-ID: <9879e94a-6fbe-4158-a21e-64b147a580bc@ieee.org>
Date: Thu, 29 Oct 2026 12:55:33 -0500
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
Subject: Re: [PATCH net,v2] net: ipa: Fix double free of the interrupt
 structure on config error
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "open list:QCOM IPA DRIVER" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20261029082100.17722-2-fourier.thomas@gmail.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20261029082100.17722-2-fourier.thomas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/26 3:20 AM, Thomas Fourier wrote:
> Since ipa_interrupt_init() allocates struct ipa_interrupt in ipa_probe(),
> the structure is owned by ipa_probe() and released with
> ipa_interrupt_exit() on its error paths and in ipa_remove().  The error
> path of ipa_interrupt_config() still frees it with kfree().  If
> ipa_interrupt_config() fails (called from ipa_config() via ipa_setup()),
> ipa_probe() unwinds through err_interrupt_exit, which frees the same
> structure again.
> 
> Drop the kfree() from ipa_interrupt_config(); it should only undo what it
> set up itself. Drop the leftover initialization and cleanup of
> ipa->interrupt now managed in ipa_proble() and ipa_remove() of ipa_main.c.
> 
> Fixes: ad1be80d7582 ("net: ipa: introduce ipa_interrupt_init()")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>

You should respond to the netdev-bot message asking for a better
explanation of how this was found and whether it was observed or
just found by inspection.

However I think this version does look good.

Reviewed-by: Alex Elder <elder@riscstar.com>

> ---
> v1->v2:
>    - Drop ipa->interrupt initialization and cleanup.
> 
>   drivers/net/ipa/ipa_interrupt.c | 12 ++----------
>   1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ipa/ipa_interrupt.c b/drivers/net/ipa/ipa_interrupt.c
> index 131b9cc94201..766b094eb069 100644
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
> @@ -289,8 +287,6 @@ int ipa_interrupt_config(struct ipa *ipa)
>   		goto err_disable_wakeup;
>   	}
>   
> -	ipa->interrupt = interrupt;
> -
>   	return 0;
>   
>   err_disable_wakeup:
> @@ -299,8 +295,6 @@ int ipa_interrupt_config(struct ipa *ipa)
>   	free_irq(interrupt->irq, interrupt);
>   err_free_bitmap:
>   	bitmap_free(interrupt->suspend_enabled);
> -err_kfree:
> -	kfree(interrupt);
>   
>   	return ret;
>   }
> @@ -311,8 +305,6 @@ void ipa_interrupt_deconfig(struct ipa *ipa)
>   	struct ipa_interrupt *interrupt = ipa->interrupt;
>   	struct device *dev = ipa->dev;
>   
> -	ipa->interrupt = NULL;
> -
>   	dev_pm_clear_wake_irq(dev);
>   	(void)device_init_wakeup(dev, false);
>   	free_irq(interrupt->irq, interrupt);

