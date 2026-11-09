Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.194
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248963;
	b=hb5HrPJ0t3tUtyq56X4HjR8MyiuT7t6CRFHO+9nhpQo7WLPGnHd5Svhu0UjJFAA4TQjy
	 cHnVWIs5JEv3KlgkqqznWfTDSdxTz+SMvnjeMb9Visfh7beblz43ki5HMaQq7BMzBHUKm
	 vYG99OTuPJMrvYj7gXPOy0ZzSrG03KC/rNRnT1WjMLGW2UyVrlwQrD98hOgNHDuyxMbxZ
	 xURLK0tK8VOXCPq47Kj41qM1aBAZ4ByjGzJuifKe1ClPnLxiJ5pBM+DILzbRzV2Ql1dm0
	 8UWNxcmDnDGQbNq5RjmXi2vyRnTDlJe1LTGNKFvrFBEZde3MWJHtnsMWGUMkps1ttXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248963;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:From:
	 To:Cc:In-Reply-To:Subject:Content-Type;
	bh=KcVmoMQgperP1wPlpI/4lZIUWk5pcHjD9u34purQ6ks=;
	b=2ULsRTv9AtcerYMbnT3SsHT7+a6E1seX7t0lnkdXEqNVTvv76FPr1767SHrfnfkHnHCn
	 3aRWcMetMHVQRZ287FWgUEywzquKgzhDMyy6KSYKiEN5OzwshM2K14pQSkbL5NIpKfg/G
	 nczutEhrz6PjAHUsI+XDkJ4gG7RggkL0p8fpaFUJR+SHSMBM5vvUE6aTvQyGejoWDjxei
	 xuZ9eeyAe5qfRu72KVtYUyplc4L0qkhHAbtAtCKqgR6u0fFx7W0CxG4DIk4l6xo9ACsOL
	 jlLuFiaMcORGYU6Ye44siclADTsrLLME4KdJaESzPtsYDksomG9qTW9/Ipr3dZ+0Dnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X7wedxBS;
	arc=none smtp.remote-ip=74.125.82.194
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCF260A5BC2
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 18:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BCF260A5BC2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X7wedxBS
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-37198ed3727so1620881eec.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 10:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794248962; x=1794853762; darn=vger.kernel.org;
        h=content-type:subject:in-reply-to:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KcVmoMQgperP1wPlpI/4lZIUWk5pcHjD9u34purQ6ks=;
        b=X7wedxBSS8iZNbIq3uVV6Lk387o+XeGOfTW6Zk2cySFVKqEWn7Djj69lXsU8s/kpKz
         tJiJ1NC1pNUqxiy43lTvIzQnaR1XWltnvNswRXYTYKvJhMy1Ym9sy/gLTRWhTzeoZy/r
         kf9IurJNAyUB0JwvE50fsKX5uraHf+5WXfCjtNq7xr/i9v+AGqhqYTaRQLpfpje/s44G
         JAaCcBLIk5pgtY0fMS2yln/+byA2YY2Cjh8Vsy4CPhQB/kcoPBKf8PLdF0pQZM0hwa2X
         mCEmy0QrvQXIQcY0xkadgOuk8+FykA/urSyQYxogIANNQn5HVGBPGbcSPTXfDKNUDh9f
         93Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248962; x=1794853762;
        h=content-type:subject:in-reply-to:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KcVmoMQgperP1wPlpI/4lZIUWk5pcHjD9u34purQ6ks=;
        b=AjyiEe+jl5MlMg9rg6w+gX8lCkP7YFyPiyYzLISJigrNMVOqUiIFoSCGF2IWqSdKmf
         pofqyRTgFoeSw/Gvj4iNiaH8BmP60WaUnThKAcEkT4f+jc8fMDDrGmCfOTvJX/ZODhm4
         qJcCEZ9h8OfbRkKNWLbn5aTfcCz7FR0FiZxxhO0wx/BlORd4+kZ/fyUlBiuB6YFo+3WJ
         oZfwTOwWwGaeYAVrpU5aCyZAlKUlqzwZirtCBrX+jOlhRXN7WjISFhSgjTffStJY0H+a
         J9qKwJsddMQ3vHNCylORsGt4oJ8RAY5k1nxRfPSgQjCwkKk61iU9xYMNaIf0O3g2/Gws
         HnIg==
X-Gm-Message-State: APuU4Z+RZ5PBja4yOus6BfzfsRrt5DgoecBHAu4bGuFpgCN/42KOUe1u
	AFpfkplf3jSFC4GcpwuOwY5n9i2CJ4U0QVDCIwRw2fcRnsiZ1bYOW99L
X-Gm-Gg: AYBFou0DGyw4MziRyUbJ9D5I7PUBUtnruJot+OUkcBCyAtyisNBgLgMy0W2SSrmAfzl
	uBgklzAOv0NFT1oFoUqkxt6RIyKO2h2Hsp+s214eFu74EF9TK/tqpuqpkyPPts7wRxCmsbCTNt3
	4q+VHvigQW57XIgGNBzxCphWsRtIfe8sdqC7YrXaEQAZgALGf5M1pe5ERqQQSq8KFlzU7L/zYwr
	Zz/cnF1yEEPZM7rPA19Cuohn+4GaxCN9/1U25lOiuBadxaHYQgCCwIyZjcrX+FIe+jpid6VE+u9
	n6nqXwR+TWtrsp+0Xl1PufBLS5rE5DVl5Fabg/QPTbrqm2z4L4vbmbLNf9d4BJoqtZtm3rGOJb+
	04lGSKRRvhmqO/Pc3OMSrcQ+xagQ5JU+l6CPRqvunCzRAMAcrglD1MGuuqcKm5xyPWWc2V5bCNC
	nv8ifJaavUJoQJ+sweR5CDd0foonhHIZ+i59DODeOJxrEMstdqtjAtyN4Vy0MknXPA6JG+go6Re
	GmaVh85bj3HnG3n36GAtN87bvP6blU5piGfNten6MfEjrsYn46/73o2KXDDk8LS6xvQv2kpCcws
	Zc7D8auq5qoVTKF00312t9o=
X-Received: by 2002:a05:693c:8312:b0:36a:2473:9b2f with SMTP id 5a478bee46e88-3750a20b93bmr299470eec.23.1794248962308;
        Mon, 09 Nov 2026 10:29:22 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:73::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060c4b6sm117168eec.15.2026.11.09.10.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 10:29:21 -0800 (PST)
Date: Mon, 09 Nov 2026 10:29:21 -0800
Message-ID: <86219505a92ebc720950d87dc76662f3@gmail.com>
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 edumazet@kernel.org, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, alexanderduyck@fb.com, kernel-team@meta.com,
 sdf@fomichev.me, dimitri.daskalakis1@gmail.com, almasrymina@google.com,
 dtatulea@nvidia.com, bobbyeshleman@meta.com, asml.silence@gmail.com,
 daniel@iogearbox.net, razor@blackwall.org, leitao@debian.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org, leon@kernel.org
In-Reply-To: <179418737701.994134.5100743053640770189@kernel.org>
Subject: Re: [PATCH net-next v3 4/9] net: devmem: add a per-device netmem TX
 frag size limit
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list

> > @@ -734,6 +734,7 @@ zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
> >  
> >  		size = min_t(size_t, size, length);
> >  		size = min_t(size_t, size, iter_iov_len(from));
> > +		size = min_t(size_t, size, binding->tx_max_frag_size);
> 
> [Severity: Medium]
> Is this the only place the new cap is enforced? The netmem.rst text added
> by this patch says "Devmem TX frags are capped at
> netdev->netmem_tx_max_frag_size". TCP MTU probing looks like it can merge
> the capped frags back together later.

[..]

> Could tcp_clone_payload() compare skb_frag_netmem() and stop merging once
> the binding cap is reached? Another option is to skip MTU probe
> coalescing for unreadable skbs.

Hmm, let me comment on Mina's patches, might be easier not to merge
netmems in tcp_clone_payload at all?

> [Severity: High]
> This isn't a bug introduced by this patch, but the same merge check in
> tcp_clone_payload() looks like it can also combine frags from different
> net_iovs. skb_frag_page() returns NULL for both frags, so the page
> comparison always passes and only the offsets are compared.

[..]

> Should the merge test compare skb_frag_netmem(), the way
> skb_can_coalesce_netmem() does? Nothing later in the series changes
> tcp_output.c.

Mina is gonna take care of this:
https://lore.kernel.org/netdev/20261108013838.1454450-3-almasrymina@google.com/
