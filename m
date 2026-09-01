Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD63D469832
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 20:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788293346; cv=none; b=ac7bTigaKftsbWNjdLQqEJnI4637E3Hq9o2vqtthwG3uPb7oTBF53KriClTrj76p/so3f8DfK9fEuUmA6KvctGwsqmeJt+p/hB5FWWxhKmp+Gg1WEerKopYh3DbXn6oNxq6MdObwAQAjAk/vG3gLDZTYjaqK7nS2fpAVs7izMsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788293346; c=relaxed/simple;
	bh=HCIZDrxMlJ/DZpkvSCypXwsnsSCn18IbMyI7eXUNoog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbGiI2tdR9s/0/txO7/7pAnqaeP5+nOI3sPwix/rEYotMsCZoJk4Lh/gRUo+VUyszixG9n33K73NiwB+F2WZLn911qY4dZR6TtJc4YRo0NMi+dNqsAMQoIuRqgucuC8Hd7A3UFqjrtnXzcWcb9DhpZL7majbpq5NNEPP9fSQWQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=fxDYV0KU; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="fxDYV0KU"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so384100a12.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 13:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1788293344; x=1788898144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZSCeT8nl12kwIIX7QDxT+qTYp68l/hXoFbD8TSlIdZk=;
        b=fxDYV0KUteqG01Vd/4jywBOma1ZSC4b8zOdzH2ZduDW4ZsTuFtVdP6JnxwlpQTA3+M
         /uoUVUA7SAtL67qAZZQ0jzQFJirni9OaUGwuGv9k8Ax/U0M2ZejKcOT+RmyItnyjcptM
         GFL1C5xeqYhqo18k8uXvMf1sur8kaQycnPIDWEf3Q1vFRT549Ky7T+1CuF/MVzCmMZ1U
         0yfi0zG8wqETLbUqvgmncGv7h0vZV38keode+pcbEtl6rlHr9bFhhYetsHWXW36rpA/q
         tZiAyqw+9yFBiTgCACDeNSO6Ob6XuNrPQTx5KH2OX2S2mVSnkVmW+GSdNZbssgs8i/n9
         zY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788293344; x=1788898144;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZSCeT8nl12kwIIX7QDxT+qTYp68l/hXoFbD8TSlIdZk=;
        b=E6HJrR8+Gd00mhO1+QeaqxAaVcn8xmDzbxmHvl2ww/ud26a31cLlDK7x7yeSAS8/Ed
         ym+1w0JxPJ/0TTMcyh/8Ra3Uz5ipbMKiz97ZiYNrh3JbfWnalaNKKSVDMV6bIwpBTnBh
         i981n08vySlW7eM735+/WL2kU+Id94fJyyCnPCdLO6mLohh8OUL440W5J7f83TEzfbIb
         TMZjJQLDeL1dLh9rBaPxKSoDMu6dZKVjV7Gn1n6Eb+RenQgSh3/arz5bIc3JA9yMxmTP
         VGnRuLI8Z7BzChNA74kB6zSFhv8w8m2bFk8QR1QjYwTYYSRDNe2irmPOSAe48HQlBliS
         DH/Q==
X-Forwarded-Encrypted: i=1; AKwUvByRyqsdx+EUl1i6D00N03LXYMyzk6m6n8zdedp9FLI7t1Gr8spbXar78F1X9h74gNlpmMG4bYA=@vger.kernel.org
X-Gm-Message-State: AFuF++kgI3AA0MZavOD4beBGoLcuk5xRvt6c9SPFcR8sgiVnTWeWtxzU
	4jKbtrIixBRMdgHx7L+SycqbiEe6QbDDwlSx/mlEajPfUAnd1TpVqPa1qotEDK9xJTk=
X-Gm-Gg: AYBFou2R/ka4z9vfx9bsZKnkhklwkbQlqOviRcKleZx4/k5ZVtBOHlhgn6CB3DmDjej
	dJ0L9v9oIF9wFVMNY7SoF+QL+C1oCLgOzfiwau9YpnkWFk2wyv2LrE2fgsuMCCVNHWgqKLF42P4
	uB82jM0gLOWgWP0MThPUikaFPDUCetoqH5wQWgCVfHkIcrDt6lk8W8G2BOex1LEXxGx4eaXl6XA
	mE+lqQEPWRVsGSidFM/fqFUatawY4YSepbTzq53r80hbDvijbXRRRhrDGALvdShm0mDWmmDs/Ui
	owXYG6gyKkP7FEDbVWNbwAStmRR4YH7e20oLrmxZNZ4AgJnkTxAVCO8EE6U4iflRLBwE55efBNg
	Er1Li0SAxzdJTffiQ5GWFdzb84OTubvdWsrIowVtr/YEllHYMl1bvrtT9kG/9Kbg7Vyf46dSSnM
	bo6TkqNHUnS3jpoD1L2lpMWQ005U2s8jNAnRwQhki4wg==
X-Received: by 2002:a17:90b:1e03:b0:398:b88c:2b7b with SMTP id 98e67ed59e1d1-39907cd7808mr15605031a91.8.1788293344036;
        Tue, 01 Sep 2026 13:09:04 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:53::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae0f2a321sm1271958a91.7.2026.09.01.13.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 13:09:03 -0700 (PDT)
Date: Tue, 1 Sep 2026 13:09:02 -0700
From: Joe Damato <joe@dama.to>
To: Linus Walleij <linusw@kernel.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 2/3] net: ethernet: cortina: Count dropped frames as NAPI
 work
Message-ID: <apcw3tpNHStCCCc/@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Linus Walleij <linusw@kernel.org>,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	netdev@vger.kernel.org
References: <20260901-gemini-ethernet-fixes-v1-0-ee6b09675876@kernel.org>
 <20260901-gemini-ethernet-fixes-v1-2-ee6b09675876@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901-gemini-ethernet-fixes-v1-2-ee6b09675876@kernel.org>

On Tue, Sep 01, 2026 at 07:04:56PM +0200, Linus Walleij wrote:
> The RX loop only consumes budget when it successfully delivers a frame.
> Error paths keep consuming descriptors without reducing the budget, so a
> stream of bad frames can process the entire receive ring in one poll.
> 
> Move the budget accounting to a common end-of-frame path. This counts
> each completed frame as NAPI work whether it was delivered or dropped,
> matching the behavior of the vendor driver.
> 
> Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  drivers/net/ethernet/cortina/gemini.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)

[...]

> @@ -1575,27 +1579,27 @@ static int gmac_napi_poll(struct napi_struct *napi, int budget)
>  	struct gemini_ethernet_port *port = netdev_priv(napi->dev);
>  	struct gemini_ethernet *geth = port->geth;
>  	unsigned int freeq_threshold;
> -	unsigned int received;
> +	unsigned int work_done;
>  
>  	freeq_threshold = 1 << (geth->freeq_order - 1);
>  	u64_stats_update_begin(&port->rx_stats_syncp);
>  
> -	received = gmac_rx(napi->dev, budget);
> -	if (received < budget) {
> +	work_done = gmac_rx(napi->dev, budget);
> +	if (work_done < budget) {
>  		napi_gro_flush(napi, false);
> -		napi_complete_done(napi, received);
> +		napi_complete_done(napi, work_done);
>  		gmac_enable_rx_irq(napi->dev, 1);
>  		++port->rx_napi_exits;
>  	}

Hmm. I could be wrong, but I think the above code could be simplified by
calling napi_complete_done and letting it do the gro_flush? You can check the
return value and then optionally enable interrupts. That's what most other
drivers do, IIRC.
