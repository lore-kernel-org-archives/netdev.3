Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793910902;
	b=WLHuitOBOk9GeoTkcbP9cafhkHpsyw8WgB1w/1K8sZ3RhukdRj+JmZUuu8M+2jVqW+F1
	 SdOolzh9R1zLGruiwJzhCWSjfrWyKQUxkInEQJLZwORntd8dhoT26XBla2favrgqRkSNp
	 IX+MFO+HT24gt5736vhb5txXODweuiNBkKQh0kVKGXUIKWc1VkHtF9vcsQjtcq437b+BE
	 11wjAjFO4WcETYW5Ri/q+FqgVyrrnST0d/mCRe9GoRVMKL0qNHNEiXUWRl8gkdhk+O2K6
	 iT3ewSyoWapGG4M6DdS5NZTM5dN2fQ7X1Ols3OddkuL8fa5wSZR7GaPRyT8e6UhHhbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910902;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=wFm6yovLTpC3RHTpEB+hsydxgzpuJhOhv9+sem6w5DM=;
	b=dv/6huA6/a2pGafKQV0l9vvuKMtczXK3lu9jk13HRZiDriduotAF/At1X26jeBca2RVf
	 l9BZIunhdFWKP8UsdVVpr7qXEcUzRR0BuwBOWbPoIpUKhT/WBlOzB3mY8sfOi3vuYpfJC
	 r2seRzozTQw+HG6FVGFp0cUZ9lueSlGOvurDgaU4BVZ4rAoWGTs6aDV0T/MWeJyzfzQZq
	 0vMurf8reAHf0gZA4ORC9OR3HJk8wq342Ilb6rtYZI0c+MzamSv8ujcoumKDqa0iPrxwm
	 FEaGDvpzW0CpVm73X20SRrFWHScJdJefHHuaWPA/0NhtdrV1DAYEaZybxlGgU6Ix0lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iZxgWH3v;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D03606A329
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 20:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9D03606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iZxgWH3v
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ae73921fd1so2134668a91.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 12:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793910901; x=1794515701; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wFm6yovLTpC3RHTpEB+hsydxgzpuJhOhv9+sem6w5DM=;
        b=iZxgWH3vzs3Li7L+xgyBjzdXSAhWNv3oeGW8KE5vuEXB2SxngF5I8tfd1rOP7CjwDW
         KbPADF/FjeMqqyvbDt6B+gtsAmWQatZVEw4PX6BbqGpeP1IYOEsiGLmIuqRg58/omrFQ
         7j6wD1ijuoHPYnC+QKpoVe/UxKLlhvpTibdkAh0QC1ItfGov95sJYyinIRgNSf4f3QBs
         ID9SVagrFkaFHiWSrKXVbOJz08P4j4kae9qwAyMWXdDPHfBbQShu9y+0E+JhSSC/Jbz4
         xGJu0gt5aWZL9+bA4i36Y0rBnMREjNqL2zJu+aKEdx/lGziaVEBoHIzw+auOzMecf9Wk
         N5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793910901; x=1794515701;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wFm6yovLTpC3RHTpEB+hsydxgzpuJhOhv9+sem6w5DM=;
        b=lIiGo5a6zPqttVS0KQPgDmlWt4Iz4YNcx3OiXwWaeXghDewPqXsp8LzhOGcBX2oJjT
         0/sDrrx2+PzHEcbaSV/PygBjeg5B12/46kIQJmmKz2mrCKGovKVE/KSObXelfk+x4o+W
         1SWTNLlZXs5q8hilv/MD8wROHKCTYYvbIHnrKB+uEgmzJnZM+rAaEW5igZH0nX/B/moR
         Pvlt6RQ37WM8vpMv8XjDDlhpqa4bORCEJTWT6rRtL8uj72hnci0qo++nhB/X1lRAyV37
         tfDGMD55MKcoVfowaspVHVAZYWdz7jqV8pdHpg/8blVqbCIVyeDdwnAfRSMY8YoDDGal
         lekg==
X-Forwarded-Encrypted: i=1; AKwUvBziCXVhgptxq8EabcaJb79X+nNubWX3wGuUaGRGB3o4OK2DUCaTg3Cvt+tm3nbf0ZsgjaCL/X8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Kkk45p/id8mROq6RilVDCSJOnmeb53qVlszri5qJ3QbTQscoB
	6jflDOANpxmJxa2QWkFWR61sfLvc0JQkrpEo30SbaqHj5vLJC3XyUyF/yVDNIW1/Gi1y0i1yeuB
	lXWCYxQ==
X-Received: from pjbhc24.prod.google.com ([2002:a17:90b:3198:b0:3a5:f1d:43a6])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:48c6:b0:3ad:47ce:3876
 with SMTP id 98e67ed59e1d1-3b0db71a865mr136795a91.61.1793910900858; Thu, 05
 Nov 2026 12:35:00 -0800 (PST)
Date: Thu, 5 Nov 2026 20:35:00 +0000
In-Reply-To: <20261104131744.1056562-1-edumazet@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261104131744.1056562-1-edumazet@kernel.org>
Message-ID: <auzoPfpxVDZx7Um2@google.com>
Subject: Re: [PATCH net] net: protect negative destination advice with RCU
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, Kyle Zeng <kylebot@openai.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, 04 Nov 2026 14:17:44 +0100, Eric Dumazet wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> SO_CNX_ADVICE calls __dst_negative_advice() while holding the socket
> lock. Connected UDP sends can still invalidate or replace sk_dst_cache
> without that lock. A concurrent sk_dst_check() can drop the final
> destination reference and allow an RCU callback to destroy it while
> __dst_negative_advice() retains only a borrowed pointer. This can cause
> a use-after-free while accessing dst->ops or running the negative_advice
> callback.
> 
> The writer-side ordering fixed by commit 92f1655aa2b2 ("net: fix
> __dst_negative_advice() race") does not protect this reader from an
> independent cache replacement.
> 
> Hold an RCU read-side critical section across the lookup and callback.
> This follows the datagram release callbacks and covers IPv4, IPv6, and
> XFRM advice without changing cache-reset or reference-ownership rules.
> 
> Fixes: a87cb3e48ee8 ("net: Facility to report route quality of connected sockets")
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
