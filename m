Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB925423EAE
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 17:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778547; cv=none; b=AYwG9BjQNXmhSjrZZK9fCq/Z3iCxy5RzO+9fLw2vhm2F9V43ev/wP+rBV6caNbPSwJtzjHzzwPixcEH90S6/euYT5LW2NpOUUPalqXr8RUjYbIGDgZYiyZ17YHgE5IWUe4Z/UIoHZxRfBFULh9PLTp8Yj/O3iILNILYfjHHO/OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778547; c=relaxed/simple;
	bh=FiUBM3pyIcZWxYa30PKi/+pHT/nkYBTk3tEfQdUPHco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ioVDNhqbLMg7VezHtEG7lq0k4DLk2XygPbrL3FEO3/KZyAUJQfH4hHCoUQsXdkMLZxcVfM3izckG2oYvzWlFQyFeXtH9MBd6J5S2MFCr/N2YYegZuogAOppDlHsTF53QUONRGICNOpjE5qgTFD4LWkcpl787cUkIvtZ13m+wR6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzfsdrqY; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzfsdrqY"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84a652535dcso2451662b3a.3
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 10:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785778545; x=1786383345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aDzXObStBW/XIcDpadk6T5ga3cktgWOfpSl9mIernRA=;
        b=GzfsdrqYhvtH0N8pUWntDajwlN8/5MHe8AO8R1OY7kPs6P6hfCiUiRsKJpWYJ55r+C
         D/lGTvsO+Oco554wvJ5lnmKv6Efoffw+31TqwjKYeKbt3tGKeeccGJvj/wOKqI4tdMDv
         FYG1qW8T6aEy3TwZV8v5Oy/9sTJOo073moujcKZxO6UuhfwdtreOvLWS9rYH/+TAjonz
         dqk1F0joS9LUfBcihc0R3X2Vk0CeMijkiuz5+kbB1HNJj07xobETUfseQsOmwyHB6Q0v
         4hagTaaXKf1qYljvdH20Qx3F9JTtLsyMFfbDK9F9eD9MAmazcF6p1BcyVOVc6srSbumZ
         TSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785778545; x=1786383345;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aDzXObStBW/XIcDpadk6T5ga3cktgWOfpSl9mIernRA=;
        b=jsUB0NDeXOVUDHeGyDsx9oTQSu4wCqkTotH6Axs/yzqQyXI72CZc3bzMqv6HfGV8rX
         4uUBB9eTUFQdTO51cCGk03X1hjhI6PPGw5bZMsHPYsIBTm6B9zjgKaoOObEXgCP20FeZ
         L7wZ6/6STpvjxAVYlIpF0ftiqlhhx0aTseosmpbCLVXcQJeIXvtqd9cJVMyXaJxMA0KW
         jWb7LDcreYzeiUHAyzcQcTMCVZqoDMkcdEntTRnG9CA/m8KFtseRRlpLp2lhYboYeyaH
         Ie1+yBaLoiB71MlVs4U8D73/1PzBAl9ux2vUv3LVKcrJA2bEtK4eavhb7542z3vDr4tI
         Xncg==
X-Gm-Message-State: AOJu0YxZCHuQyRKIw3/p5uMtl9bSjYwv/obuGWU9R0vddTjB+MHWWT7P
	beO+rrJjNyq1RSH4tySLVlI0dtkkPP/inD/RzbemUSphN9yCy1X/2tAV
X-Gm-Gg: AR+sD13nz9IjsP0LjUaRkaPOKApgI26Fd64WhmnXgl9PFaTf6vaEBv8+4FMkwsJgIgX
	sayDsoW3x1jnxSgKdA9JOY0NP1v7kZamNev/lpaVGXya6evMsJSrJ0cKYoBHuCBGxIFL01RtvFI
	WiiVf/jneQbGeTapT8BdI5xZKXBAKAPQF1tcstcTexkCGme0HKWj8uud2n1FPE3e8npcVHBOydA
	XAz8oQXUtCEr2bDPcScxkeu/GUWxk3HSfE0qaAq5SAZq+uNQ8g8tgMFQ+tMnZ7IRdjV/lcpHdpQ
	c/NNNNoSBbRJGc1NSejwWDMhf+dMohxPORb2DV8T41IN+HAzWM+PtH4WHlloBtQKsm21OFFx3B1
	aOzaXnUiyp5CCnJKyPylHBd0JkZ9sRci+5LLeK0pMC7bqdTyPaZkNUdbQ7wMX6kILMggBO8Ckhb
	h2uPM/iAtwztM5pVwc3lotx5wjAiDHX1w3T0SYgC53WQAF85+IvPG/6T8LJ7VlEDPRizbXwzKFb
	nXnA2B6MQ==
X-Received: by 2002:a05:6a00:180f:b0:845:ebe2:c656 with SMTP id d2e1a72fcca58-84ee49549eemr9286454b3a.47.1785778545099;
        Mon, 03 Aug 2026 10:35:45 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:54::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbd3a4b6sm3994017b3a.4.2026.08.03.10.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 10:35:44 -0700 (PDT)
Date: Mon, 3 Aug 2026 10:35:42 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, kerneljasonxing@gmail.com,
	kuniyu@google.com, bjorn@kernel.org, jiayuan.chen@linux.dev,
	kaiyuanz@google.com, willemb@google.com, asml.silence@gmail.com,
	sdf@fomichev.me, fw@strlen.de, Neal Cardwell <ncardwell@google.com>,
	Ralf Lici <ralf@mandelbit.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH net v2 3/3] net: tcp: block standard payload injection
 into devmem skbs
Message-ID: <anDRbtwxp8vEMORA@devvm29614.prn0.facebook.com>
References: <20260803171441.408014-1-almasrymina@google.com>
 <20260803171441.408014-3-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803171441.408014-3-almasrymina@google.com>

On Mon, Aug 03, 2026 at 05:14:41PM +0000, Mina Almasry wrote:
> Protect tcp_sendmsg_locked() from mistakenly appending non-zerocopy
> page fragments to unreadable devmem skbs. Create a new segment instead.
> 
> Fixes: bd61848900bff ("net: devmem: Implement TX path")
> Cc: Pavel Begunkov <asml.silence@gmail.com>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Bobby Eshleman <bobbyeshleman@gmail.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  net/ipv4/tcp.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 455441f1b6949..186a36c698798 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1278,6 +1278,11 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>  		if (copy > msg_data_left(msg))
>  			copy = msg_data_left(msg);
>  
> +		if (zc != MSG_ZEROCOPY && unlikely(!skb_frags_readable(skb))) {
> +			tcp_mark_push(tp, skb);
> +			goto new_segment;
> +		}
> +
>  		if (zc == 0) {
>  			bool merge = true;
>  			int i = skb_shinfo(skb)->nr_frags;
> -- 
> 2.55.0.571.g244d577d93-goog
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
