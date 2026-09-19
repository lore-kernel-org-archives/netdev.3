Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11866395D9F
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 01:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789780247; cv=none; b=XYNcPALV6z3btpW4eSzZUsx6xWfN6nK3+uX6P84coFJAtMbjbGwjQZ7qCKY1rbvQuzfPd3ahIkfHgU8UqZMgZxh2KU2hjdVOU7y2yji+QeBovpycLvCBolz3UIgobXTakIgGTofVFmVoIHVUSJWsWveW/7WeSaKMTMB6Otu+NMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789780247; c=relaxed/simple;
	bh=PD17Y3XeERkph6rr6sHZAKy4DsdPrdxQEx/QDmuRqzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFJyasaZzZFo1xwCE61GaG9dUDHEwaVmGNJJITenBj5LsdZTGhPbdLxogSSkrRtJ5eaSosiK6LchcELTdjmmshJinNtDXhBvL2gnMEqChN1HClVLX0RTvahGzmX2hk03Mb+nDf7236gAOaOhH7GxnoxvM+z1l3BdBik+2kuzD6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=ZepgU0e/; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="ZepgU0e/"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc5256c2a4bso931670a12.1
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 18:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1789780241; x=1790385041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a49yaJ/GGjwIg6ibC7aTwVaBRLcdBDhKbI1sakT8d8k=;
        b=ZepgU0e/N1D6q0ctVm6zTa7r3afmQs8d3DOKLGauufQCKMaRNxOwS47dKxRCHL4ExQ
         JWAZJAzsca+tVJWUIzv3Rtdxq6osoiHWf5OQJzsbtP4akf+RLEXaXblEaVDkvCFJBODF
         c4u6nvTmRHajn5SjNfiJbJWBfXyXHKaDNHlU4vMtMBq0Q1efUOIaGTxGsYbIilsQR9YY
         0Ji/x/W4fwOBadlAgMRSuVceYYYvGk9QdqljvRDDtTxTRQYkSoKtrwaM4q1AebkqaMVO
         4DUS0K1nG0rEVJgE/AATkQnmxzG1fOn+W7t8LQ/EzE95h3BfmOq3KZ+bErQWSVHVU+CK
         FgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789780241; x=1790385041;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=a49yaJ/GGjwIg6ibC7aTwVaBRLcdBDhKbI1sakT8d8k=;
        b=G2HNCBPsjsXWIKQgyTqaqTVRpOI4aVhh3RQdICQHO5wTdxW30a5Z+NgKStVKjy2VOP
         sKNAim42g3TR8aHuIYaEzjdGOdxavX14bzciQNCvVqtQUzNjkNQUqLKkOCKq8GJmTM6f
         /vcJE+rmoc7k+xID6C6Q5cVyQ9JGiNzVnRpyU58rY8d2hmyVT88nUmxjbhQ/d4c68mhU
         ec4eRaeCYZCL6a68FZahW7GNjG30QNASxCVG+ZGZZLocMwcAWtM0oK66xLdxXyMbmIoj
         WsIDZJXlTDqXMUuhFhrmgEimXt4XnWLwKV2vgPT3WScCMsw5xSKwnz08/+ocYe+KAkBI
         2EAQ==
X-Forwarded-Encrypted: i=1; AKwUvBz7o28lvD2IoAqcrK/6kHI5RyI2XI3c9SKC/arG73sQ+r6EgOVubwOuqAM3UWDM34N5sEjX7dc=@vger.kernel.org
X-Gm-Message-State: AFuF++kKT0JZIHIYViRKxfz7IUFgxJ9k7LzaAvHZVBFFVuQlyCK8/Omm
	c4If30607FcvXohGBPV18qfVRpF/U+C2mj8/g6C1wV8RaMGTLVmeSaZEZ4D4beRPoFk=
X-Gm-Gg: AYBFou0Ev/vQjffOX1t4OUou5wurHFaHkqlQ2S7JTr+nvGjikbECHBWnYmhiAnzWK3n
	CpDYY5rb8jnxVPXqtXSLaLOaQJH+EcpAjruviVtehrOOWEODCkuQaO74HVqMdzW+aSo9A2aZt67
	t9ka4/wHSvVMVN+B2Q4/fqccsLCjb9uXtgxAbd1DPCtg03pG9DkdQxB/TrL5U7t7fGFguo/Q8aO
	5krXVVt9tLlkWTN9vcevVK8yyv51t20Kk7pqL02CB5PUJGN6wz8OrBUB5NUWXFPrmTGmA2qJAjm
	3+dNxWKYpnVS8lZCvLTH6nzpz3zH+z7F8LWQRX2Z+4mHwImbTT9bh4DKdfqIgSwW+drY1ehQuoW
	+dyKXunU0A8qV+bPh5K9gdX0sUTDY1yJAUDeVARK70xdKi/g1//kUwEVJSKTm8F05ahGx7V4vDJ
	/VXvFR44VI6M1QnshNMwRYZWMNHCRB66euFrf9BPELJeckv3cNGb04
X-Received: by 2002:a17:90b:57d0:b0:39e:6c69:f470 with SMTP id 98e67ed59e1d1-39e6c69f4d2mr1917003a91.47.1789780240973;
        Fri, 18 Sep 2026 18:10:40 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:40::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c6dd585sm1680612a91.0.2026.09.18.18.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 18:10:40 -0700 (PDT)
Date: Fri, 18 Sep 2026 18:10:39 -0700
From: Joe Damato <joe@dama.to>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	ntb@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 03/10] NTB: ntb_transport: Order RX entry
 completion
Message-ID: <aq3hD4D+VfMUd7vq@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	ntb@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20260914084838.2158249-1-den@valinux.co.jp>
 <20260914084838.2158249-4-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914084838.2158249-4-den@valinux.co.jp>

On Mon, Sep 14, 2026 at 05:48:31PM +0900, Koichiro Den wrote:
> RX entries are added to rx_post_q before their fields are filled in.
> The overflow path sets DONE without a write barrier, and
> ntb_complete_rxc() has no read barrier after checking DONE. A concurrent
> completion can therefore consume stale entry fields.
> 
> Publish DONE with release ordering and check it with acquire ordering in
> ntb_complete_rxc(). Use the same publication rule in the copy callback.
> 
> Fixes: da2e5ae56164 ("NTB: Fix ntb_transport out-of-order RX update")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904052134.2970111-1-den%40valinux.co.jp?part=3
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes in v4:
>   - New patch (Sashiko)
> 
>  drivers/ntb/ntb_transport.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 3f497a62673f..b69e8ac8047d 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c

[...]

> -	entry->flags |= DESC_DONE_FLAG;
> +	/* Pair with the acquire load in ntb_complete_rxc(). */
> +	smp_store_release(&entry->flags, entry->flags | DESC_DONE_FLAG);
                                          ^^^^^^^^^^^


>  
>  	ntb_complete_rxc(entry->qp);
>  }
> @@ -1664,7 +1666,8 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
>  		qp->rx_err_oflow++;
>  
>  		entry->len = -EIO;
> -		entry->flags |= DESC_DONE_FLAG;
> +		/* Pair with the acquire load in ntb_complete_rxc(). */
> +		smp_store_release(&entry->flags, entry->flags | DESC_DONE_FLAG);
                                                 ^^^^^^^^^^^^

are these two smp_store_release lines right? i am asking because it looks like
they do a load ? i honestly have no idea if there is a race here but it looks
sus to me
