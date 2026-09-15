Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07657372B57
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 13:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789477994; cv=none; b=ayfQwmjo7zyZ/Yh1mPiwmSd59KIFLQCmMQ2tPPL/6mYGQdwRxsqlXrOWIUmuRRGIk1o5raK7whSmvMrQFdmaO3mJBBqhFohmO4880FqqnmArGjtjfHUFhdhP1U/Rr473P6tZqvyFQhAsNNcoJxDoQez17Qprsj09hH2tz5OlZX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789477994; c=relaxed/simple;
	bh=D6Ujsp+RYFGsDctl0fEZSefC6faEPecOAdqLzPQCBqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d0fssO2kQZnL7hUao+WNuWNy7LvRaLUVvX43ViMOauZ2ovckBC0SbrBPEoapUAPqPkXaKzjVQ2/uqR+pjD2hTHj94Q9Rq4vBMxkVL7jSVpuC+wpJ7N+qPe1qERVYDgxzMtXuOGyuZMOYPfTIWZxDlLcLo+K2YaHDix5/hRYX6H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WhrtzQLw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tviUKL+U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WhrtzQLw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tviUKL+U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789477991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I1zwuOYvRtWtKSm0LOwS4fslUz5orahf+nW8Myt/7XI=;
	b=WhrtzQLwpvk+3pkZcCTEfmOBpxTlCR6Ebpiy923K9ZHcXDern4m6jyoqzUjBqc51e2dNWa
	iYR2TKTKEPAMqA2mRpYqiZ6R6A+jWD6791ss9oPpCv0r+LuAmgagmofc8fLT0OpXgUmzmR
	2uvZ9Bw6D4BOJklIbKjxo5uKdDI4Bs4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-458mRTE9NkSysg9ouOyqlg-1; Tue, 15 Sep 2026 09:13:08 -0400
X-MC-Unique: 458mRTE9NkSysg9ouOyqlg-1
X-Mimecast-MFC-AGG-ID: 458mRTE9NkSysg9ouOyqlg_1789477987
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5b5e9181d0eso4863320e87.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 06:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789477986; x=1790082786; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I1zwuOYvRtWtKSm0LOwS4fslUz5orahf+nW8Myt/7XI=;
        b=tviUKL+Ujccd14Yu2JpiObNmNMOXZ02F2a1UpUrQGD36Z7hN+GdbssMEQnWRyYmdNn
         rkK/Bl6GGgWpZMKJ0hA2yRJpJ24fel6Vq4DgLowZz3slnvMMvui4AxVMJwXL4e2VDFKf
         6FQAW/sO6qJj6yGOeRdDT+cTyPQXKJUmyYFUlkEKNjMxJSIi4TL51ZHI0vBpAZ0J+v6f
         ZDRnjCakzCd0ui/0eqiowGAEHMlVMqF28LH3DXL/ptDjkmLaRn5JOpRJgVnONNV23q5l
         djMZlvF3uVSSwHDOFW9QNvYwGn50+0NH/XVgPjjow5aUSxDoL77LeIi0EJnKpyrFgx9X
         2+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789477986; x=1790082786;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I1zwuOYvRtWtKSm0LOwS4fslUz5orahf+nW8Myt/7XI=;
        b=pwYrRp0xLAKZGtjL5S+OkY3atah5I7ZJsLQql5s/i/P0RSn45fZTdBEm4Xos0bZxmb
         9qPe/Hga0LA9WPXfu/KcjuNvKjnmLpAYjHx36oSazllSLjy7YxnJyLsTxXlyhT3HDu4X
         mpMAGhDAqSj/KTKih4378fMYogVHTGI5x46yWgAUJI60NoZdgyYJtEwnu1Vp5gag/1bR
         dVSFscBGpM8pqFyhb5uZazxf46UCNSTKjY23rCRmgvxKfJ+/yF3+mCFO7RnK8wPT3gqb
         fp+nVdPf8Ght0hL5vmF/k1cRH/RbdejRc6akBDYlQDgqhNiqKjj8CphW3x+aDKb/N1xd
         irsA==
X-Forwarded-Encrypted: i=1; AKwUvBzrB/0CQBbUm4xAmzJBtmOoe+4ZnL1WFuLMuZB2G/oVZLdJEX9ymhVvPTF5aXj6NEvUBKoKAVM=@vger.kernel.org
X-Gm-Message-State: AFuF++lhCO/wFieiE7T51Xy6+GanIKYOGSD4Ab3nzto+y86LtpZlp5Ai
	SjFVXQexe3qJ6n+IcZ78U9Z/f2EIxFs1Sc+tn5BKUycJy5TvnM7SSBBOeeXxDvE3KiZPK9BpjV7
	b56fLXdAKa1LhmjwMv1vX4B+A9ga0s4/yKYwpxcUEq7irWy6gaOw4AGL5Gg==
X-Gm-Gg: AYBFou3AXrGvyoz6lmYTlqVIb0MZKImz3S0Mtkq8CPJrU3arwbQO66yxyupHWfgESbn
	kuhCOILQHkHGi5FRv5qU8dkruYHBhekZvRWJoDPCik6afz+1L/GCBvJxanlaDIatCln5trKs+7/
	lKM8LHXK7X2zD/fJTHd/+qiu3gxC2ZsSE2/+pmraXM1NJ5PBFmJbNggTTIXleKTTEHwKZCa9b98
	q2SAKwHqj89GBaS0gnUKE9/o7rmo+0EXJAtNMgLOPJEbONoJ7fA8siduBxQ9ojw28V+TydsfaLs
	cuvyxuDmuf5W7K33W8FXNGfRsP86++2DlX0u+FX8yjvLaT3QNZIY3fW3FDmrsU1MnXhOztsZLBv
	5r3PxjPn7lAtIxbbx84k5Yzjr7FW+gwveGD1e6ukSG361g5sM2AFzxdwvGYYTN/v1DfZlEZCsKQ
	==
X-Received: by 2002:a05:6512:b91:b0:5ae:c8da:6254 with SMTP id 2adb3069b0e04-5b8b4fa7332mr308861e87.22.1789477986549;
        Tue, 15 Sep 2026 06:13:06 -0700 (PDT)
X-Received: by 2002:a05:6512:b91:b0:5ae:c8da:6254 with SMTP id 2adb3069b0e04-5b8b4fa7332mr308858e87.22.1789477986115;
        Tue, 15 Sep 2026 06:13:06 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8a046499bsm3269022e87.44.2026.09.15.06.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 06:13:05 -0700 (PDT)
Message-ID: <d23fca29-243f-4c37-a846-e4c5c1dccd66@redhat.com>
Date: Tue, 15 Sep 2026 15:13:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net] tcp: Don't call skb_clone_and_charge_r() for
 close()d listener in tcp_v6_do_rcv().
To: Kuniyuki Iwashima <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, Taras Madan <tarasmadan@google.com>
References: <20260914011420.115556-1-kuniyu@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260914011420.115556-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/14/26 3:14 AM, Kuniyuki Iwashima wrote:
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index df9c29eb5c1f..7fa4ed2fd4f1 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1604,7 +1604,8 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
>  	   by tcp. Feel free to propose better solution.
>  					       --ANK (980728)
>  	 */
> -	if (np->rxopt.all && sk->sk_state != TCP_LISTEN)
> +	if (np->rxopt.all &&
> +	    !((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)))
>  		opt_skb = skb_clone_and_charge_r(skb, sk);

FTR clashiko thinks/laments that other states could be observed, but that
is a sloop. Apparently it can't digest commit 8cc3aef0cb19

/P

