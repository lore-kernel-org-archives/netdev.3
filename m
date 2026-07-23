Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B9942E8EB
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 09:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800694; cv=none; b=pzC34/qDKU+fPrPjjiKb7Bh1Oi7qmWdHcmN6bUVW1cx+kRS54K6+CmomVjv0nOoj+NMptuf25bM4d/xd+D3BxINWQ8rstoJCOu6qfDkEHShsXG61adS1Uv9Gf9XloRiJaJ5WO/2MMe8upgIuhx5ZsQ9i9TUSlt5HG0dGTiLB/3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800694; c=relaxed/simple;
	bh=JyQ0i5MWICcwd6Ew8dcNJE1TVRfcbZFrQF41FwWqY7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P9/xeS8ykW5ytgMjtOW0txbYxwUcV6mKpJ59Z5T6KGBRLjhay6RAEq4BZ1uwTGmKqafZSNwAk6mQ7vH3i2MqQ4bDmIvLC3Dcv7b5bUjrOCelSqSJv5SGts+e/stAPf31rD3vw4ROkqO8DhudqWQVEf6bcAjdkWGr3wJW6yi4avQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RTX21+ZJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GfTlpSHE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RTX21+ZJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfTlpSHE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784800690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzmqMYz+xqlvZxZzHgPFLcjsI6LqkVkgU9V+iNhdTHw=;
	b=RTX21+ZJgzX4T+zquTAYoJ6tq3vimeVxmmv+/Gq03cSe/HoIEdsswkYQxGn26HnhcTNGpb
	rENMWTzt9LNWlNrXQ4A3R3QqnyHB5oIfxKVkDgtroVcyElwMZz2v2mAT/K1C9Rwci2igIm
	ot5AoTGRzVGRmbQqNfXkvPfrK1/iAk4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-B9m26-mpOrWmsjvKBt4c3Q-1; Thu, 23 Jul 2026 05:58:08 -0400
X-MC-Unique: B9m26-mpOrWmsjvKBt4c3Q-1
X-Mimecast-MFC-AGG-ID: B9m26-mpOrWmsjvKBt4c3Q_1784800688
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4955ecd8a10so4108175e9.3
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 02:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784800687; x=1785405487; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vzmqMYz+xqlvZxZzHgPFLcjsI6LqkVkgU9V+iNhdTHw=;
        b=GfTlpSHENntQp6LKAz8fzM9NlqtDBsF6EvaxnHiRCmcF8Pa783UmcxbBegixhhdu5b
         0wLH80INZQGFBnpXn2HzA89pcvjwOpu/qO4uQlGPA6/hn8svZ75FWpmYg5PR+/gmOG/u
         6TJt3lkGQICZv1iNXF5BO39tewcVlT+6551PxFSsFLghVeq1ofJ5ZpmZ7Ul+SxODgojB
         6mtAg3tRzJTJ0I21lvIg/iXemZbAqNiN1d3xcA57FE5VOL2JGohH/Skz7Mrbtky11wxa
         gOjG7c/SzkNQCc6QKtxF+QN4NqWigqAFIklEjBT5DoQsRZR7thEL7ibzIJFjLaWClyy/
         vGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784800687; x=1785405487;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vzmqMYz+xqlvZxZzHgPFLcjsI6LqkVkgU9V+iNhdTHw=;
        b=FpoqLObxZx7EJWW7NBSatUgeHBeeg9MspsBo0vgktlSIQ9t3nT5qNQfWoJzALzSj64
         kDEsU8h/uWBOe1U4eJwX6k5mHdT6cabYSQBh0SKPAmOf/pXl5TzOYKOIYYi6EFMrJpc5
         bl/reJUILG+pNXYcgHnF3tIgi8Rz/A1Rv8BbURO0lVJ/Lc4Lxj7dJbQ54KzOP3nisznc
         URa7l0IXUMMv6Ypn1J4ArNqXulP5wJTb+iLxn63Lm0eZQgR8Ag0LhwOL1rRXxEriqWtD
         HLWM6U2mcFIfpyhPqI1ic1EE4DxeJH2nR5DVbT+4th8CDR5ZxQ+qZkOcwXB0Bcm64HJq
         qPcg==
X-Forwarded-Encrypted: i=1; AHgh+Rolrnt9LQ+QYWUzsRefsuvpN7Wlmg3y96kFikZhP7hep1wuB9GNSwcEEe83Riczxud0Z2YQop0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRjLKHUWbD/aqYnNtkPiquFq4jsbr83pOdNvMEJ1Unq1AMbWXR
	oMpuN/jE+eOvH2m0EQkVRvn6ILcYROrAwM4HtX8lUeKyjZN6kSktFoPQkXW85j+NRh/EUI9hzYi
	xnE+PvTnun4kPTkWoWid3Igp2Sytz0ju+dGEP7UNYehetRs/wUyj6lI15ig==
X-Gm-Gg: AR+sD12u5/W/+nVB1WlaQFjOwktw3lTcXLFq9tpLHvuhGAFf/ZLVDklU7Yh7TTNY0KQ
	sasYmDl+EVqCW+8k8Vjr2dqg5qUO5mfZU77ws23p+4Kllgm5Li09AP4T31mv1U+UJnVjKmZiH9s
	ZGpwYkQQPeWvD+/uu2emBoQyDHpbL9FkLMlXei6T88F1wZG+1QF5NnDNKEO9MH2jCwGe4cuMQgy
	ZfiBiPAKYiyw9qVqSX9yJe4RnFjmD+8YM9P+YESb6RZ7ZvOeBklxBndv/BQ16Efw2tvnmSnBY4C
	E/QeDQOcmEEl10l9U3UhZkBPVVEBzikUexY/EwkqByWEt7GhkmZ7VjfbPF1c4glUNwS/y34oUbw
	iFEfnoNpw0ETF90hhoNOVevI5hRcCo8TFQDdVy7sDVMmiEbJGi07nb8oTYE2EpwFQPlHyouMVOp
	lsGw==
X-Received: by 2002:a7b:ce0b:0:b0:495:6396:8b67 with SMTP id 5b1f17b1804b1-49573cc1a71mr16360105e9.4.1784800687625;
        Thu, 23 Jul 2026 02:58:07 -0700 (PDT)
X-Received: by 2002:a7b:ce0b:0:b0:495:6396:8b67 with SMTP id 5b1f17b1804b1-49573cc1a71mr16359805e9.4.1784800687105;
        Thu, 23 Jul 2026 02:58:07 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495653c8760sm194729325e9.14.2026.07.23.02.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 02:58:06 -0700 (PDT)
Message-ID: <265fc46b-1e33-4283-b94b-7c591a9cf3ba@redhat.com>
Date: Thu, 23 Jul 2026 11:58:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/x25: fix use-after-free in x25_kill_by_neigh()
To: David Lee <david.lee@trailofbits.com>, Martin Schiller <ms@dev.tdt.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>,
 Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
 linux-x25@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260713104752.241175-1-david.lee@trailofbits.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260713104752.241175-1-david.lee@trailofbits.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/13/26 12:47 PM, David Lee wrote:
> diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
> index c31d2af5dd22..8aae9273b7c1 100644
> --- a/net/x25/af_x25.c
> +++ b/net/x25/af_x25.c
> @@ -1768,15 +1768,19 @@ void x25_kill_by_neigh(struct x25_neigh *nb)
>  {
>  	struct sock *s;
>  
> +again:
>  	write_lock_bh(&x25_list_lock);
>  
>  	sk_for_each(s, &x25_list) {
>  		if (x25_sk(s)->neighbour == nb) {
> +			sock_hold(s);
>  			write_unlock_bh(&x25_list_lock);
>  			lock_sock(s);
> -			x25_disconnect(s, ENETUNREACH, 0, 0);
> +			if (x25_sk(s)->neighbour == nb)
> +				x25_disconnect(s, ENETUNREACH, 0, 0);
>  			release_sock(s);
> -			write_lock_bh(&x25_list_lock);
> +			sock_put(s);
> +			goto again;
>  		}
>  	}
>  	write_unlock_bh(&x25_list_lock);

Note that sk will stay on list (with NULL neigh) even after disconnect
and the above introduces a quadratic behavior, but I can't find an easy
way to avoid it.

/P

