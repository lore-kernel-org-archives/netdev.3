Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793310925;
	b=cYISepd9mlAcJXfU6ZQppxbOuTyxhZM0HVBNWEwca9tZyX71ODaR8X9zz2sWLNTRsd4S
	 ULhaaGz1V79vCprOswg2oyl+SrEZpk6QW8e91GE8ssw8YO2eGvKBIEhZxo3TDudIqjzp8
	 c8jaqMfcaGzqWjfvX6j6CbUMnQrzxUoC1xiDS6sig7c/AgX3Q79a3DcNpZGnxFG74vct1
	 N0UMoWgsVuFDb+fH5qryUdAUV4AVOZDPzal4jr6302O16x4ZJT9n9WGPgtZcJHu6iqAby
	 HPlzJ3Y4Go8UtEzF0RvM/3voH48jA6rgL2+PKwODqBdvPchErQRPakLX8ogBXRVBi0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793310925;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=ftlqZLP89MBtbSltOHsyj/D3xJMjzaj4uqQVSc1oH/Q=;
	b=1a2XXvaWkmCSdkNoOBpfXv77TdQiv+J7P9RdUzhgXGvmQN2wT344Aflf9kRVYSxc5WLj
	 iWYoOChsmuTji++iUk2SpxvVKFDpM6mV9DSms9RjwiPaa33onF4MIPxnZw9DgXrcI+fPS
	 LxbDOfN1hBY/VUQ7rELJ7ACiPklMluDW7tuGpixz9skbMt/qOc/nXdSyfjd6v6ZwEwdQc
	 e5+eExHK7YLI3XMAuPW5eeIV892bBuVTZCstMmKNALloCOpupt6POXji5THTvBUN7xCFV
	 Rin2CVMs8W/g5Hfr+0fQ4xkgieccymIJm+MZrUWKJNA7UCDpR17JgSoa+2k9X4h/Shw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WA7jJW+I;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5A3606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F5A3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WA7jJW+I
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc7e92f36f9so18993a12.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 14:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793310924; x=1793915724; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ftlqZLP89MBtbSltOHsyj/D3xJMjzaj4uqQVSc1oH/Q=;
        b=WA7jJW+I5jF5wu5Zdeb7AVdLfzhelM2Iq6Irm2MN/1udk2BhY/Y8vBAHlESg5eLkvu
         v1LCZllwoYwFtbyfglEcZWxvL1VXuQ0JaaqkCUWz0Iq6uNOC97lr2mS43ZxMMn5MyBcf
         mBTAKhG+texc4RvMh6UMgClhJgdkrsmLCcQBZzMu+8JxOYVoMVtxZmNasWG/i6+a/LGo
         MrOW29iKqAAHibCkAE3ICJIETu+eanUBa7qYNbLZuZnWbOBkw1ifmmGFoXK5xMHv8L+g
         tPPP9tIDvzb7qtHBt9QczljviGWNzTuzzRdPfn8dSKP/y3IW2i7LpWh6xKtUHmgWth9H
         J2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793310924; x=1793915724;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ftlqZLP89MBtbSltOHsyj/D3xJMjzaj4uqQVSc1oH/Q=;
        b=Yuz/ainPiOyMLVCbtISl+qed0kX5OnmogxwKpFrComWlRRLFiwi/aFOIJ98sNcw4Ft
         KDO8nBg8LYq9PdPKyZu25JXNN9h8fILq+/2/H/Z1tDAvXgBYxj6sTNdCeEjAoujUHRwM
         KEu1+6diiFdFKYUrvxBa692GNOeHltgZb9ksTMH+vkQG0L+QdQeFV5uq51qZgrPp3B6d
         cLibvmCeQqZEWwt6sP0Orgj8zXDhsp8Hm7Z+uPwKlSNwu1WohAAZAVB7tB2po50BMeiN
         h/eADUzGcfsmDjSGoMsSX5nK0qW2mwZ0Nc+53Z+RTCUGOhIfu1t8w/vBeppWtE+kSvlf
         uUAw==
X-Forwarded-Encrypted: i=1; AKwUvBxTua8efHBpsJIMCl+EBWt4UHnDI5/Tx6TOUD7WfoYfsTBQ0vs6Dhx5c+QG62Fl5N27FQvUVZ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZTLCGHFcHLyN3lAF8l9ygupHTqHNOai7Ip42eFsAmsKZSw431
	SL7E/3B2WEpOejOzEMiTHPxDWhIb4VbjkPsbNWH4xRLq+HAXHcOxJqGTJb1XHr7EWMzxc2Q6VMF
	2O6pEtg==
X-Received: from pfbgl11.prod.google.com ([2002:a05:6a00:84cb:b0:890:ac21:250c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4d91:b0:3e1:180b:402b
 with SMTP id adf61e73a8af0-3e9289ac4bbmr469413637.39.1793310924447; Thu, 29
 Oct 2026 14:55:24 -0700 (PDT)
Date: Thu, 29 Oct 2026 21:55:23 +0000
In-Reply-To: <20261029214219.1035176-3-imv4bel@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261029214219.1035176-1-imv4bel@gmail.com> <20261029214219.1035176-3-imv4bel@gmail.com>
Message-ID: <auPAvbIZ8XmOHKaE@google.com>
Subject: Re: [PATCH net v5 2/2] net: restore refcount ordering for lockless
 socket access
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: edumazet@kernel.org, ncardwell@google.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, martin.lau@linux.dev, 
	john.fastabend@gmail.com, weiwan@google.com, sd@queasysnail.net, 
	jiayuan.chen@linux.dev, netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, 30 Oct 2026 06:42:17 +0900, Hyunwoo Kim wrote:
> Before commit fb041bb7c0a9 ("locking/refcount: Consolidate implementations
> of refcount_t"), default builds implemented refcount_inc_not_zero() using
> atomic_add_unless(), which provided full memory ordering on success. The
> commit removed that ordering on weakly ordered architectures, allowing
> accesses after a successful reference acquisition to be reordered before
> it.
> 
> Use refcount_inc_not_zero_acquire() in the IPv4 and IPv6 established
> lookups and in inet_twsk_purge(), where the socket is validated again
> after taking a reference.
> 
> bpf_sk_assign() can receive a socket pointer obtained through BTF
> without a reference. Use acquire ordering when it takes its own reference
> for a refcounted socket.
> 
> Use refcount_set_release() when setting refcounts in the SYN cookie,
> TCP Fast Open, request migration, and TIME_WAIT paths. Keep the existing
> TIME_WAIT smp_wmb(), which separately orders the refcount store before
> ehash publication.
> 
> Fixes: fb041bb7c0a9 ("locking/refcount: Consolidate implementations of refcount_t")
> Fixes: 27e5203bd9c5 ("bpf: Change bpf_sk_assign to accept ARG_PTR_TO_BTF_ID_SOCK_COMMON")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks !
