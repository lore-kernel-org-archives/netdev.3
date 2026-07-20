Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA6F3D413C
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 09:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539634; cv=none; b=LUrfyKCqkXtUh4gUgXYzgw8RqYKBJO5UeB+efjAjWhfumSPlyz4WRm2boiB2Vbdp2t7HrnRNCaz4Q8Xkj8PHQVzn4AtzoOd0jPagUACQKzWkyEYXvd2QOxAoRXnOsR6RDRz5XmyfCjcUXXr+uAWrz2PpOBBnepcwY9IBAT4AdfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539634; c=relaxed/simple;
	bh=HQMQFnSUXuBKeeJ97RIwrfO3zajoT/O4JZOcb4WgBqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qheyg0s8Q+PTGhWdUrn6cGo908E1x9cGU4zX1FLIIN0TE1CERHY1GvTuGvIDOkAM3pMA3BiISX1Yu8MEdyQC9/TNoJgeMuDTnG9kcmIP0iimWe/BI/tHfhwm9j6b541vB7VxhzxjPLqVWw+g5lGCF8p8QVjuIJq0xapZBKG+RRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Tu45MQ7H; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Tu45MQ7H"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47df43bfb07so2553970f8f.1
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 02:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1784539631; x=1785144431; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y5AYMZaEUXhh4z8P8i95ra+KWHKRxofJ1kLmW4+NFQs=;
        b=Tu45MQ7H+5RLnEld7PO9n6qcTenVbJ9h/t36LjHDk0/QrfB7gj+64IbWMdvm3kq0lg
         LkwhsnResq6lsLK3ctmG6LfncGowze6zTaXT5KEc5zSyWGucA6DuMEsAvUTpTt7pG49P
         qsyU/4GxWc6jj17ipuTfsoepF10YbuJqP5riX94kUm7soCS0g6bZWYvOphsQNxoK+pZJ
         39iQOq+2W8k3KFfNgH0zAaTux/SrUwBzfIGLMBzwEGNaiOvBcBVUBBO6eN9JZ620HVjj
         eap5suLEfWd9GvuIFh9KHigYv6F8JL2aveMnWiZjaVuB5DHBsJ/haTozLLsas0OyDj6U
         SMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784539631; x=1785144431;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y5AYMZaEUXhh4z8P8i95ra+KWHKRxofJ1kLmW4+NFQs=;
        b=hXLm76knWdXf5QM2gj5YSoRBb4SC6UURszPe+m/gINW4FjBAdyDASdmnRzmEMC9n3W
         B9Ij6ZEIr2+pc+AntBqn0f6UxciH+exQPikQ16zcQBW9Vj/Scpj1p3rEqTOwrhBxyOke
         XOoD0vyKvn0Rf9K/bC3xqdE5imLAM19nHJy4J2w2zRtzBw28MiLlwY38mJgiYbbnRSUn
         D87i29bP4wKWugaXogj+QWS0uoX2ZGnMAbLqtPYMmzmdBbm5QrYyJb3NN7CAeL5MYNdM
         CaFj7V7482JjojCyB7wom76+45C3v0+qjGmckm2RmCuJGksS/u9QbzFb/WGpntfrjzqn
         9A0A==
X-Forwarded-Encrypted: i=1; AHgh+RpW3CKtTx6FKpcxRSK7I+WDeYzHEaWChN3sx9N0LTdmnPvRXM5nTlU/RRt17GDzztWAAgE02C0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9WJL1oufwgIeNuV9UqqG97ADC/V7QphYSohB+lQLYMx176hI/
	Hk306VeIfgr3as5CtWtFPLev31jk61r3XSa1wPAqXEppoe4LzVFaL/+buhO9GQjm4MY=
X-Gm-Gg: AfdE7cn7bKyuhWl7ppC3paifKRC/C1R1J+dyRFTA+riFfU5h6h9L2srQZtKirxI4ZSx
	xo3lvpV8A2nrHjFJuOlLEo8TtNC8G5Usb0UPFVc8/Ct3lAUFWa9Y7/5Ln3rIaR351SSCM60yf0R
	TeaJJKN67LxxtcYF4MXma6IOL5/Eu7oVRRCalX8qAX+6O53a8yKLZPeuaiyWoqqOkaK9pPTPbpy
	WN2Ey+5dPalq/UTtjeRs23kQhQAa4x94fOEnWX4R66vJPhlDdJAS4Ysc2Gw6rQtwWbEa6eSK1L+
	dzSMaEFqTT5oJh/i5xc0tYNOdqvCae1gs/8I5dNFX/dfbQyDVd8gE37tBlH8N3Nonl99gKYlOXM
	x0lf/qNLqrTgy7TWZ+OFXQAZKz523nBngJT7+8GxYZC1OBZx+p1cmCbNIIRdZWvCtYXzkrITEE6
	BXFuKv6yGleW2aOlUklfjnUdGtH5Hps5Wu
X-Received: by 2002:a05:6000:60f:b0:47f:6d75:7a52 with SMTP id ffacd0b85a97d-47f6d757ac4mr10330530f8f.31.1784539631284;
        Mon, 20 Jul 2026 02:27:11 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eddd27sm28372768f8f.28.2026.07.20.02.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 02:27:10 -0700 (PDT)
Message-ID: <103f04dd-dc48-42e0-83db-46864ca9297b@blackwall.org>
Date: Mon, 20 Jul 2026 12:27:09 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/5] bridge: Use ndisc_parse_options() to parse
 ND options in br_nd_send()
Content-Language: en-US, bg
To: Danielle Ratson <danieller@nvidia.com>, netdev@vger.kernel.org
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ja@ssi.bg, petrm@nvidia.com, fw@strlen.de, kuniyu@google.com,
 bridge@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1784463131.git.danieller@nvidia.com>
 <d75c565729850a2b95c5b19fd5997e94cf55029c.1784463131.git.danieller@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <d75c565729850a2b95c5b19fd5997e94cf55029c.1784463131.git.danieller@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/07/2026 16:34, Danielle Ratson wrote:
> Replace the manual ND option parsing loop in br_nd_send() with
> ndisc_parse_options(), which provides proper validation and avoids the
> class of bugs that were fixed by commit 53fc685243bd ("bridge: Avoid
> infinite loop when suppressing NS messages with invalid options") and
> commit 850837965af1 ("bridge: br_nd_send: validate ND option lengths").
> 
> Use ndisc_opt_addr_data() to extract the source link-layer address
> from the parsed options, which correctly validates the option length
> for the underlying device type.
> 
> Export ndisc_parse_options() so that it can be resolved from the bridge
> when it is built as a module (CONFIG_BRIDGE=m); otherwise modpost fails
> with an undefined symbol.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> ---
>   net/bridge/br_arp_nd_proxy.c | 32 +++++++++++++++++---------------
>   net/ipv6/ndisc.c             |  1 +
>   2 files changed, 18 insertions(+), 15 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

