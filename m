Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C7346AA98
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 09:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426399; cv=none; b=jE7D6M2Ph/P/6t097o9ItGfXthE+qwLYiLPBx3XTxlkeayeC5u4K00XNLQ4WytSgHxhw3PgBxcOxQexBokyxNGf6/oiTKAmA3tDpvVHLrnrCZwkeDQ2asdmKMnsA03SV4IB5m15Dg91DL4EWxnX3EHUMqGF4OnHgJ4Pi3hiH+iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426399; c=relaxed/simple;
	bh=l8KBUmIXxPbS9c0iCMD1zbBiYJzxawY6rVQk2WWCIFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VeN2DMCv8M1S5bqGlVvGU9DL2zfZvmtLmSfBgHroCav8yIUaCIENqkLD3I8o3PtE6vD9bsr1+J6EYx0L6P1vj1f37Ie5QFg7Ryw2uCNbLXeWeJPa5Xu7SBIbkDBrEPYae8k/ZbeQRZYzUSulhkgaHNrsZRf/CD21g5bSg1tDQMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NG/1tmdQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vrvhw0BT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NG/1tmdQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vrvhw0BT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788426396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bOwX+me4lB9EKO0+pZdoRhc4re20aH+MSGIDsmBiCEA=;
	b=NG/1tmdQermYVyTRlCNEq1BohDJ1LtLuHid7Ru9aGhqQVL2pgWq/8XatFAOZlbozJPxMOw
	WKJMldIlXP2mDAHvweGXWifY4yBQiYA2zx+shx5J9SR4vJlgHP3GPMKoo5RjMurHngNR9e
	o4YvyeyxIaJoYJzykDK6OTgR0+eCGXI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-Um4fE4l9N1ay0rDkl61Xzg-1; Thu, 03 Sep 2026 05:06:35 -0400
X-MC-Unique: Um4fE4l9N1ay0rDkl61Xzg-1
X-Mimecast-MFC-AGG-ID: Um4fE4l9N1ay0rDkl61Xzg_1788426394
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4994d67d0e3so12465115e9.2
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 02:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788426394; x=1789031194; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bOwX+me4lB9EKO0+pZdoRhc4re20aH+MSGIDsmBiCEA=;
        b=Vrvhw0BTjAOlbuP8YDdOTJGpdbTwiSYWHLHqBEEeQcLhYdRjp1Lr0IwSjJ2B3xPxHF
         Z9IrUC5TarHInLwxHFJvtnPNhsu5Sxr/eAwle9fem9Vv1cD3Y/as3IvmHF0I8viQUCR2
         4WwL4vY9Oyjzvnf4x+/3xBoORemEDxaoNmykIuec8qZgVG30lj7z3X+zt4SAGig/z0U/
         tsSNSlBlGGm+VlNNGsvbsuiGKdf4xOVDV8HTjVFtA9BjuU+oE/zbjg9r2dPt+rOtvmpD
         kaH2k8FdD7l4BnXJ1EnyTX05/fjAWmZy1/4boQf/tupDc+stWUpsqELcxTfKkNcPH3Rd
         4Ksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788426394; x=1789031194;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bOwX+me4lB9EKO0+pZdoRhc4re20aH+MSGIDsmBiCEA=;
        b=MRGZ2GVCB0TRGZVfoqqwV53YxF88rXQWm42oVrb8DMlaD4ncg/eV5XwOguimuWzmOn
         vvzLvI31z7UwgV3aymSVQOURxuvVhFzHYxSjqobkEBbmQEeWOKAs6sW+RDsxh6FSGxaY
         ebIsOR0qpWm0YL3J5qy2AmK4nQpP6Ozuze3xsmPJXbUJet6x0M/XOXcwMsHjFA+7Us81
         8opi7d36/mO/bCzHE5nJvF8KrWpaFflZP/DhXqzCG8FohrduZ6mjzlMaUTaaZPjpdWZU
         KcQUVyLMntbXK8L67eg5lE1hp3WYM4z+WgotpxBndDBwWawXvsWMUDNRZQ+VahWDqkzB
         cR4g==
X-Forwarded-Encrypted: i=1; AKwUvByh1EFnAfBenb9y1i8mg6t2G7oJk2cfgbgfGV0EOY2+fR6DLt3opyjfbZFrnO2xQrAYa3GZ/so=@vger.kernel.org
X-Gm-Message-State: AFuF++kkO/69aee/pIFxAqJfJlcNPX3aaK6jIEzxDcbyF0Q3ZNtCA3x4
	wf8EXFZ/o4KbmpGpYKa/rzk3ud0RETpMz2I3G7BmVVS8CQSxbAoAVdShWcu0S0mz9ifQsi7e6Ob
	FvcLa+iQYCveSM8GcF9x3c9oBASEHiD6nuOVvzYTz8fsdGpKY4dXXYteYmw==
X-Gm-Gg: AYBFou34+edGes6hWCZgvMxBZ8he+QjfhNht07FY5dyEOIyL9W5g+fA4EMXl+nYqskA
	tGYSrfRC3ZgUZrcOOu7ZjBPuG7dw0Zl7/sPDZx+phWJ9s4yDO5kjcouCQ0S5NAXDeIcmqLBdBSr
	C4+XcOvLWac8Stc1uWsTYJdK1IpX08frfAczuP7zmDAlh4OXzo6W+N+ddEprDOccafPNk9Fxklc
	h9ocXQxWlB+kVLey/+IrJKwLSUEY4NCXrEjQ8kFC4g2dxg1L9irHfpvqopWwU4QV48SEdcSJVTk
	UG3Bv8Bqj1c4kl514/Rj2KcqtUvbTVmeLVGj2XGil6EcTqwGxZ1ibhw3cg9bnkQLkrHwwDhyk9g
	11QxhQBNPw3gc2jgTCiZFlddWbikyQVyPMfkqWp3Pvfi7NsOWA3TfaAESAQTADz2m7BzwdoT68w
	==
X-Received: by 2002:a05:600c:4688:b0:499:726b:7375 with SMTP id 5b1f17b1804b1-49ce5822b73mr182742815e9.14.1788426394175;
        Thu, 03 Sep 2026 02:06:34 -0700 (PDT)
X-Received: by 2002:a05:600c:4688:b0:499:726b:7375 with SMTP id 5b1f17b1804b1-49ce5822b73mr182741785e9.14.1788426393658;
        Thu, 03 Sep 2026 02:06:33 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484492cf550sm12526639f8f.37.2026.09.03.02.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 02:06:32 -0700 (PDT)
Message-ID: <2ba43d6b-f521-415e-a4a1-64b313051c88@redhat.com>
Date: Thu, 3 Sep 2026 11:06:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] tls: fix the open record check in the max payload
 size setsockopt
To: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Wilfred Mallawa <wilfred.mallawa@wdc.com>,
 linux-kernel@vger.kernel.org
References: <20260901072927.128688-1-jiayuan.chen@linux.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260901072927.128688-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/26 9:29 AM, Jiayuan Chen wrote:
> @@ -862,6 +876,7 @@ static int do_tls_setsockopt_tx_payload_len(struct sock *sk, sockptr_t optval,
>  static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
>  			     unsigned int optlen)
>  {
> +	struct tls_context *ctx;
>  	int rc = 0;
>  
>  	switch (optname) {
> @@ -881,9 +896,17 @@ static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
>  		rc = do_tls_setsockopt_no_pad(sk, optval, optlen);
>  		break;
>  	case TLS_TX_MAX_PAYLOAD_LEN:
> +		/* Take tx_lock like the sendmsg paths do, the socket lock is
> +		 * dropped while a sender waits for memory, with no record open.
> +		 */
> +		ctx = tls_get_ctx(sk);
> +		rc = mutex_lock_interruptible(&ctx->tx_lock);
> +		if (rc)

Why using the interruptible variant? the blocking lock just after will
still ignore signals, and this sockopt will now surprisingly fail if a
signal happens at the wrong time.

/P

