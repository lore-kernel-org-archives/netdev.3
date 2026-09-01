Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87623F4DFC
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 22:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788300010; cv=none; b=K2ZTmUVbH4AFR5NO/nUupyLE+VtPZ0oaNKk8Dn/oX9SNq/dEnx4vaZqUimJpZT6uHWBgFc0ItzMSTe0xnOeyTjbTsZMD8kavLuTGhAbjrViu+bVX0a0mz+1lsNwvq9DjKy68T2SkT5kWBHEFckDv5SpGg84Tqgc84OmZF5R6gko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788300010; c=relaxed/simple;
	bh=bz93MKvmXc0x9RtxVhpSGlzpcdIHkKf+M+gpiD1mez4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDyS7U0oKNMQN/WanBO51hhnOjZ9B2UlJVxMvyQftOMPdwzep5sFNsp5Kra3O9PGHgEQl9Syhl7d+NVgM80MFJg17/a/JHSrDxZ7YN9UAGU0drfdgwxidLmPAcFTBGWyb4wM+KKD6wf7Bs66NlrXfhQqlTmM4VMutkpehOkVCHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=Xh/tuOnJ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="Xh/tuOnJ"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d5cad1a6baso2738605ad.3
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 15:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1788300007; x=1788904807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I7H6VQsz3aXKI+eg4dmH330aPO4Hlz7jL38A0i9jmSs=;
        b=Xh/tuOnJ+Lz38q3GgHFlndUQsfVNozl5aQfzkY3JIYlBXD/ZYrNdJh/dVKvMzjCqmM
         A8pG6ArJqgsoHXl0ulrr29ZKapgla41K5IheYp5JsQL8ODWGWvBSxHFwHOTts9cW95cg
         Kw7c/0vxRidu6HiyHYysJrf7BGVB/E96rHhmsX5fPk3AdP3AdOunE6SYdOus4bBjMHCN
         GzjVLBYoBnUR7Cp53Owd75D29QFjeqgsOPs4yC251nPoCE2p7FVhcRk9Co7ulKJTGh4R
         nEANxknLa10gcDDAbYs4uemaDORPJsRXtbV1kCc7PsDf/l2BAQnWfMTx4vM01BwHE5pz
         0DEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788300007; x=1788904807;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=I7H6VQsz3aXKI+eg4dmH330aPO4Hlz7jL38A0i9jmSs=;
        b=RDS/socLnlgPs32qHLEPMzfHd4S3ksvawxHMlW9SU5zA+muXb2v/BnVUUDDxIomftN
         qjYEkTEfIuJA4YD07+0V4AJ56B8AWSTytUrLLvOOIDYaK5YTpTZPkuiUTX2hkb5OFQDi
         1cBiDVmqyJ8W+DRPCfWAm7wN5gVth5EjCgBJl4Ka1b54VPD2arV0cAWVIF2PQCsa9CnL
         PXuIKOVd5VyCTijTt32hH2W4IhgsjKNU/1ccueuIUvCDiVB73scCMuyNI4cBgQBxSbaB
         3uLbLbReRevnkpkOlebYkiq5AlOCFWasWoQcgVu+JbyvlYb8aDk2UpfVS2q9KsbbRaeK
         RweQ==
X-Forwarded-Encrypted: i=1; AKwUvBy7VL1tPUC2hN4ZzTPgHhgCPZrfbRN1WNxJ17djdBcBtXqjI9bRGCA2FN7cM6GYoyiwz0LoED4=@vger.kernel.org
X-Gm-Message-State: AFuF++l1TLyglbJ41M0DId/Rw/mVMzEzhY5flOO12aR63PzJDSfc16Ni
	96UOj9d9wxxXKqDkl2vZx0TXHM9ogSqCJEq8NEQ9nSu4U4p968jhw4JrRS487vgVsVU=
X-Gm-Gg: AYBFou10B5gDCx6BxoBH5OASvH7HNsp6js8B3qn09FUlemXdHFx4sO1UsDhcaECBv+T
	f/Gz04HzjsVKREVzLNPCbnQWqs1fVz1V+bAYLXpD6tol8zlMT23xXKGNMlOD+eWvzvfkqwe4Uza
	Sy6tHnNgbmGEtEkZ4cgK4ILRKQG5WHPDLQvZf912nHZqUmxHFxTwRYoF14WEd1++GZ+v+JIZJJc
	BhX+GszuGoQcxw55olZCET4paU4QfwnFBaAaWK2CtyCX0K/8T5SrkUnfTFCfqVQwvPY6pzmQrzS
	7r8M+07SNLmPE4opBQipcn0z7cC3NU4UZtv76M6F38rDYsUwDmUUNBaGk9Ignl+r9ahZz73OlZ2
	awl/46cqagi+IJ8YijSsgjNusU5XhHs2X0dX0Zlq8qD25VsGMRCTtrORD2nJvnr5VbIfLB+sms4
	RxwuPQsTDC31OjpwgCMUCUzNonr7r0i9d7jbu2H5Xn+A==
X-Received: by 2002:a17:903:350c:b0:2d8:d4d3:da4d with SMTP id d9443c01a7336-2daec771984mr3273885ad.17.1788300007028;
        Tue, 01 Sep 2026 15:00:07 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:47::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dadd356d03sm3684885ad.6.2026.09.01.15.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 15:00:06 -0700 (PDT)
Date: Tue, 1 Sep 2026 15:00:05 -0700
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
Message-ID: <apdK5aMmvYssz35F@devvm20253.cco0.facebook.com>
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
> 
> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 1d9824d1716c..699354604b93 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -1450,7 +1450,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
>  	unsigned int frame_len, frag_len;
>  	struct gmac_rxdesc *rx = NULL;
>  	struct gmac_queue_page *gpage;
> -	unsigned int received = 0;
> +	unsigned int work_done = 0;
>  	union gmac_rxdesc_0 word0;
>  	union gmac_rxdesc_1 word1;
>  	union gmac_rxdesc_3 word3;
> @@ -1501,7 +1501,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
>  				skb = NULL;
>  				frag_nr = 0;
>  			}
> -			continue;
> +			goto next_desc;
>  		}
>  		page = gpage->page;
>  
> @@ -1523,7 +1523,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
>  
>  		} else if (!skb) {
>  			put_page(page);
> -			continue;
> +			goto next_desc;
>  		}
>  
>  		if (word3.bits32 & EOF_BIT)
> @@ -1546,10 +1546,8 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
>  			napi_gro_frags(&port->napi);
>  			skb = NULL;
>  			frag_nr = 0;
> -			budget--;
> -			received++;
>  		}
> -		continue;
> +		goto next_desc;

if i understand correctly, removing the continue here results in the success
case several blocks above here jumping to next_desc. in that case, is
word3.bits32 & EOF_BIT always true? just asking because it looked like in the
success case the SOF_BIT is set and wanted to check that the budget and
work_done math that is being moved down to next_desc will still be run.

>  
>  err_drop:
>  		if (skb) {
> @@ -1562,12 +1560,18 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
>  			put_page(page);
>  
>  		port->stats.rx_dropped++;
> +
> +next_desc:
> +		if (word3.bits32 & EOF_BIT) {
> +			budget--;
> +			work_done++;
> +		}

idk if it matters but i noted that the commit message says:

  > Move the budget accounting to a common end-of-frame path. This counts
  > each completed frame as NAPI work whether it was delivered or dropped,

but i noted that some of the jumps to next_desc don't seem to increment
port->stats.rx_dropped, but others do.

not sure if that matters for the correctness of the stats
