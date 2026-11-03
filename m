Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745821;
	b=VF3i5+2JOnt6yhdVI9NWROyIloIuEqVeKdq8Wt70Dl1CMoYi1vgNYvjCDejyE/HeIcTp
	 TTCzP2mTspLdB8uqs1P19jEhbzNqicregPu2ydOcxnG1sXt41jdbC96ekDZuT+ueuEkzB
	 q9aTRodMoyJDlIy1x35u8PLaPT0V97hKLDIwUmZLJs+zvI+N8u6rd5BTS+l0FOJdH3Uwy
	 CviJwlIHgbFaoWW0tLzutuLczdTZYV/y9+2ebRL6xOMCZH5Jy3Um1TdtaUhh/imceRwWz
	 xB63O0bxwNGLlDtQXz24aV318/1TvBQ/7Gc1QwpxsCVmvMve59LqFk6M9sva/FWeFUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745821;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=pSX9ZEKMZwAkn/hCnfPGUTygE8W+cQbUvjzhzK///rY=;
	b=AVoOYQmq5QRmIkIys2/SVxAf15/Ap1N3LoW0b4uU86poTDq3z0uidbv31cUkqaMXFkKL
	 oHxMgkdqeW5XVpwnN16xdIEt5DS2k+ikfnSFIPIejun2pSneJA6CfHTj4iwvg63kWW9D1
	 PCly5LuPJF0V7Vl2g0iDS7GCHQw5zk3OjHFtnlBmCwZSgzyZTaL1lT/6ordLPuDkjs6Rz
	 xG9tnqMHS8dTfqZkKu3NWdtA7xck+J9O/tQ4RxfybSbqhYOg7lhzQthqH5mDvMjG7QWAu
	 uJxjlHz5vLoRjVCzVKxIH9+9D0H9B3Z90msq99/zbq4vbLGKbPJvWGAX87lnLqYrVoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UbKXYRVS;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0520606D810
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 22:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0520606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UbKXYRVS
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-3678f64d078so38542eec.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 14:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793745820; x=1794350620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pSX9ZEKMZwAkn/hCnfPGUTygE8W+cQbUvjzhzK///rY=;
        b=UbKXYRVSlINnceEmcBZLntGOFm5h1Y6u19ZCL2iuz461uXDs/lkJ8Ft30u1wsxAckh
         0uArEiGHC5YoyKR6MHxSYmrVtUC4+Mc1jZ1wwXud8JXvPGzW9ZHJ7prEerFWXDG+yIEj
         IBdNNyX9BSdIbvaK2lILsfriI6VNcCRfcQZQuW+Id0c12gRA712+V2iEWSv40j9PRl8z
         exVtEELSOcZTiT1DYYir9r6Jo54p+p+N43N0fl5xjwnpJFMgnpC9ymb694sKrU4cDrJN
         dKKSv2VeDdj7NsDmG6DRrPslPYterr51oKQ8QU1ZkP9VZzA2kvNguuvVNGUjoY49y2dq
         42zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793745820; x=1794350620;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pSX9ZEKMZwAkn/hCnfPGUTygE8W+cQbUvjzhzK///rY=;
        b=1xN/6/CEWGQIVUrnAqdgDkmeBk4cBi6f3zsKAMBXf4UAcCggn9Bz3tXYpUmOt4jQBX
         UNfx4dFLw5Du04dktoJkJWFxIqOB1ApTjYM5JQwKoGf0p8oHtkd09gMKpZ7LI5RoWCLx
         kGGFqbvAZ00AUZAcplhW/mevlZdvfYvpSJZRcSnlFjcAhl8SuEILqbjmOeMH+zqZx2rO
         I9Cz49k90Ze0tt6Bep9G8/G30zDiBPmuzt6qaJJj57InFN//K62XU8ohpw1XQ51uaNWe
         3MSYHw0MUn2LeoX61+GYUPec7r2VxLOILeT2tF1eF7JckrWa6D6R2Kp32C8PySdtYNnl
         fDaw==
X-Gm-Message-State: APuU4Z+LNosFGY+f70WTDBsXixAnq6mBWqYk7w+Q0HOjV1H2UpNArg6s
	+eEpY4lvkdAnv6cPno22wOgneO6FOIzME78Kpu5tWhHtBSeRC/aolNqw
X-Gm-Gg: AYBFou1rj9I1Ph9gn6vu9/HMplPrPssQ6Ki9Y4yBLo0W0jLRwRK0zmf/tv9cksZ4O0A
	2rsRfcSsrSxDG2rAtwdL8nb11vDeW2CF025whJN7TRehrVxUBDIy6NQuVuqHMKyI8LQaLYkNhuJ
	50cVksv+iiuOAT+8ffn39EiUXOUSDwI8pCl8NsF8jhj6L5gJ0kzdiTSiQP8EU4hUrGE+xr4nVYf
	iu/C5YS1vWZTb6AUxNWOoYNWJzQDbwZzowx5/GfBgd8d+gNDDk+Jz43LO6wG23JCXf2T33gaLeI
	Mrr9uMobym3hvu224hs3VO8R7TDMN9LfKS3yzLVMuMeyx2UodYxH4VLJzJTimBSUq3rKWWQBzvB
	o9hbO6OSSXBlRwidAq5ep5a4RF24yZv9q4rGMB/H/cWJTPb/sQpF8U7Ig4QUjXFDZH9SOV9ZPDh
	hAZFZHbtx71dQHekoaELlBVh3mpBJtWUS4nBYUtT9SNwmG4euyxIquqdBQA+5BmJvX75e5jVh/0
	qUQUx/DDbABHCDLUwYzu98ppZqPqypC333v9mJ8SzaOV00TZgTjfelM6LHaBvKV0nL3N5iIQfOU
	/JcPJQ3wT5owWw1EB15DhQ==
X-Received: by 2002:a05:7300:c39f:b0:366:6644:2839 with SMTP id 5a478bee46e88-36a42203e90mr21867108eec.3.1793745819838;
        Tue, 03 Nov 2026 14:43:39 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:6a::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3966daasm1484975eec.23.2026.11.03.14.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:43:39 -0800 (PST)
Date: Tue, 3 Nov 2026 14:43:31 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Eric Dumazet <edumazet@kernel.org>, Kaiyuan Zhang <kaiyuanz@google.com>, io-uring@vger.kernel.org, 
	Stanislav Fomichev <sdf@fomichev.me>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net-next v2 3/4] net: add skb_frags_can_coalesce() helper
Message-ID: <aupjezBugEQe_OSC@devvm16445.scu0.facebook.com>
References: <20261102231827.4088254-1-almasrymina@google.com>
 <20261102231827.4088254-4-almasrymina@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261102231827.4088254-4-almasrymina@google.com>

On 11/02, Mina Almasry wrote:
> Add skb_has_net_iovs(skb), assuming skb->unreadable and net_iov-backed
> frags are equivalent for now (with a comment noting the two can be
> decoupled in the future if readable net_iovs are introduced).
> 
> Also add skb_mem_provider_compat() and skb_frags_can_coalesce() so all
> multi-skb coalescing, shifting, and GRO paths can share a single check
> across pp_recycle, skb_zcopy(), and fragment memory providers:
> - empty 0-length skbs are compatible without mixing readable payload
> - page vs net_iov is rejected via skb_has_net_iovs() (0 pointer chases)
> - page vs page is allowed via !skb_has_net_iovs() (0 pointer chases)
> - net_iov vs net_iov compares mp_priv (walking frag_list if nr_frags is 0)

Maybe squash this and patch #4? Otherwise hard to follow :-(
