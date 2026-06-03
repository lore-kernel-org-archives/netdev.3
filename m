Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC07E3A0EB8
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 07:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472535; cv=none; b=gILwk73optgBLYKZhQuq1hh1GpmDoPD3ipuXEf83NtIH+CR9vu5hdoWPsTUUiVSV3hHejjZHx+3du8PFuSS2Rb9yotdlNajv8+ul9EFdZ+CaFeQ1MgojPW+5yCMjb6R7EGXtwukegjzhuuemx6lkaa+1fe7M4CKcVlWNnn9spOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472535; c=relaxed/simple;
	bh=FhGRWE+AGbAUWKmyW1iB09fqat6FEr1KLUfol22Skbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IYxpCNX1jGEpRTMlZRhxs0NyTv0rDs/uCdgDtVcI0R+bzvjSiymYajY3BaxgFv0lLTVuRwGcE53GzfdTqHLtETafLGpD8gYnuPI1KWPEyphdDooXO5ZESuwqsitM0ifZD3XuvbVRAqNGInQzg7eHO/9n2hqwjHBZkrM5R1oBX4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=i2cs3JE1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="i2cs3JE1"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b64c8311so6488205e9.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 00:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1780472533; x=1781077333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iQ/G5AyzRXc5A3Q0LWE67cuFLv2AuQIyFo9jzZD11KQ=;
        b=i2cs3JE1cZsk+1UfMrDmn7IJYt+f6lvhiXKysAcve6ICsOyncJ/XVLm7DpOHJUJc1x
         foNb0PsKTqBnPXG3CsSFRiokNMdK6gsKRJlaqAthfBaWTi1YAEI+iIvFBJhatqkGYURg
         isabYFOzv0ShvYciskXgV/grft5O9EY/JqF6jTu9TW2SIlRmDmKa0ymtfl+nKewqxQrE
         lSgfOafgxyywxWF2myCmtlJjHsX/qjPyTcodj/FNM9PrqViorWegUwy3R83CsVOwvF2t
         /HL+4NpclZK+i3Ipwx1jT/Q5DxiKDXTjhrNBlPxBmL36Y6bn0S4Lnt4cwBj6n8LqgU/C
         N2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780472533; x=1781077333;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQ/G5AyzRXc5A3Q0LWE67cuFLv2AuQIyFo9jzZD11KQ=;
        b=NHTOY8Od6xMUHma5pzI90c34KIX4xn5oluqMBl+h5EzO0DS28duIBNvdHYDsonJD23
         irfHNj28Zpf82L1CfWPgJ7wgDGOqAoPHxuSRnPHRyV4Tv9Xmhyg7LA+CaAWVowjHbSBK
         +ZE2iVpNCazrDErnOTfscswz56itvbTqHFlmODBaBsSNRVQmItkX5gg32kMOl673JG0e
         8csj8EGj6YocehU5Oe+0y5HPeCgGZQRazyPOCT649Jvu6pKV7AOcWihSwGvr1kBe9bZV
         wMqWiqMHqrcxBz2hJzUt2Ys/k9ybbfuPL0Nfu4aDa9gx9xmAGJfgw5KWblnuiGxE4xsq
         h14Q==
X-Forwarded-Encrypted: i=1; AFNElJ93qB89EqBlMTfCYVYo7M/OAkDOowJwgs5APA9BWHTr3lNid1ymq4ydhosCiRlPlkQUeMdGcmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjLzDYXDX701iqy5vHBXqPUxN1yZ/MgrLcber9yeogIfhr57+1
	0/HSoLwQFq5oQB5l9tN7XXlDXr1oaFzEj27j7J6B6yrpCGHAAw6shDlKTxJjT0mu0m0=
X-Gm-Gg: Acq92OF0yGtySC7RCX60a7nXDHP1zfg8ashJf6XbCWmZhop3HsKvj2xptAK2g1ael/I
	G1QEcp+bI4IU9WcxjBzOWj/hkRFjrg2itxz7GctluiSkf0LHEfdzUjhi7ptcgKapPGms1hASV7F
	At3EyTbJZA+25P8TKJCuWcatYRZj0LWN1TRDieixNfOwphmmB86/0T9qiOSLKW+REPriuJqx2gn
	7dolu0Xd5PVploghBJLKDm3S72eb2X5rNSl0WcWGxmt+8c119qcxJsGiEUHosVz790nrq9vtvxB
	gnH5CIpCOnNT01Cy+v0H5QUXislU+ucPNQKCXPljnz151fC6PZ8HIDJp4weDxEn6dZLaASho8TH
	kH+RojOmG5YENpGZFTb9AhqxnzPJDaAIEInmpTztCNRWvZEx3hyjaM6XzEioZ2JLdq+VfYkKzam
	wdCPhv//+cpWUwzVzwSyaHbRBS5jxhHjJ93KXhCC2PEtX9tqi76UrsLbDkv/nzYkVW
X-Received: by 2002:a05:600c:4e87:b0:490:9d1b:f05c with SMTP id 5b1f17b1804b1-490b60e3f91mr37403445e9.33.1780472532903;
        Wed, 03 Jun 2026 00:42:12 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3529e0sm5614447f8f.28.2026.06.03.00.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 00:42:12 -0700 (PDT)
Message-ID: <74eaaf87-de88-4657-abe5-b69df6fbe53f@blackwall.org>
Date: Wed, 3 Jun 2026 10:42:11 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 01/11] bridge: add a READ_ONCE() in
 br_timer_value()
Content-Language: en-US, bg
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260603062043.3911278-1-edumazet@google.com>
 <20260603062043.3911278-2-edumazet@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260603062043.3911278-2-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/06/2026 09:20, Eric Dumazet wrote:
> br_timer_value() can be called locklessly, the expires field
> could be changed concurrently.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/bridge/br_stp_timer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_stp_timer.c b/net/bridge/br_stp_timer.c
> index e5d453305381baa34225a144ac99e98f2a62d810..83cc9c6a3943508eb94d20ddc1b7e737a58d7abb 100644
> --- a/net/bridge/br_stp_timer.c
> +++ b/net/bridge/br_stp_timer.c
> @@ -160,5 +160,5 @@ void br_stp_port_timer_init(struct net_bridge_port *p)
>   unsigned long br_timer_value(const struct timer_list *timer)
>   {
>   	return timer_pending(timer)
> -		? jiffies_delta_to_clock_t(timer->expires - jiffies) : 0;
> +		? jiffies_delta_to_clock_t(READ_ONCE(timer->expires) - jiffies) : 0;
>   }

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

