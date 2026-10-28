Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793216738;
	b=fg5NhkP/loQrlurNG20p4C9AZTyZvyH69li2gmDNZV+URO8uQYnjLFes1DxZ25/oa7F1
	 eekvPoJEQoPD/NP0dECzPrZ7IwbtimOhtFqq8hoPNPgXTHQFi0w/VPvWyyjLthKFgTVAy
	 P0quuRAYDyG9O9366rmjxdYSyFITaMTljU0jU5TMBDbxw/fRH+O9TlcwG3RDrHyQX32BP
	 xYSFLTKX8hZ6aGFyNEPb5cTDtPhQ2ELYrD7MQrh6h75ym7nv41lP48BX7gAKtwb9aI+zQ
	 Ma0L9YEJsnN3qPKS1ZVrZgGfjPdFgle0RmnrfYHdGqpndTg9euRynUS5/l0PTPStC+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793216738;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=p7pe2s+MVZswiJuATY2vq7wM8pD0KsopxwWou2VSc+E=;
	b=h8HDC7QvBi4Gxhjr8fnp0LZNzZHb0i0NXUzVM5qnPyCk0bvKhDI3holHFWn3tugVu4h/
	 1ewZJS9ksgikzfiDLzJ+RTwlwnLPCne9SVMge1KYQPCaD9CnEmEHvV7eQmE+OJ9+ewq3C
	 4bg3HAVX8KMF3et1icIhZ6T2C31GFJBkhNDGD/AqX77q5Xuuula37xAWXj5gGN32lLxkG
	 aF3pkMC0LT+GGcN5C5KaPeuaK6WDIobklJkLVFFYgiJGCkBj9hSPpj2iiN+1FwFVJBuiU
	 VtiNpSKpXUT9eKKKrIH/MTJfW99o1RYaaGGuIr5qXt3GI6qei/BxqD5glVu7T+ortGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="px+z80/K";
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CE7606A31D
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 19:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61CE7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=px+z80/K
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2eaf8ea208bso11466725ad.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 12:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793216738; x=1793821538; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p7pe2s+MVZswiJuATY2vq7wM8pD0KsopxwWou2VSc+E=;
        b=px+z80/K+krp6N/39N5HW5UrjlthpSYEmw6RfQaoAJAeKyRB/eTitvuY1TcvpatxId
         m3NYQglv5YOxyQ6XTSKvUtYBpl/z/eRSqBXMetwEsoPoksCsNPkwmPj9xpeQ8wtP0Tul
         yBF5KEAp7dWVScMwwj+AQL5gVpF0/KMEIhiHuyErYI8AILM75P7C7Oha6E3FMAM1nRiR
         zyqbTNU4l9iaj0EG6JNVrHst8PKgHqx/sqiAzJnjJSUsOGgAhJWKbjHC4beTp4iLq8/A
         UcB3HgzRjMAv4ye768PFyUJOrwIFkWEdSPhrqs3yhOzIlcr2M0sEsdoZgNn3SBlIBjcu
         47gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793216738; x=1793821538;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p7pe2s+MVZswiJuATY2vq7wM8pD0KsopxwWou2VSc+E=;
        b=h8eLfixDU+IGHE9LsreGXoqTleQgiiya+k7uRlrt/J+7yShBQcHZLq2KWXy5uP6Um6
         lxoMtl8yDRGh0b0vLW9Zwut47yzf3Ch4r4zr+E8KpAsjxcqKVz3oYQUbqwCekuunmfAQ
         0cRwczIkOH6siUP/+y5zmYFHJz9QNV0cQ1CK/VOAV+Ou2WVN2bF01xq30ckaUncgb5nw
         K2MbIUAkNzflg/fcebEdN26iLTZsRScOHIr2cJYCpj658jgaiNB8njQ4xgkMrSUMBInW
         1LzBVad5SFMolZNBfdPyaMgc9JreqRzB+9GyOBgGMGryBqEzgu8pKpAa6V1hcFShAgh6
         5KDA==
X-Forwarded-Encrypted: i=1; AKwUvBxYc1ayDIzRKT/nDCmZxFpZN2GozykQX6RpGE6ZPsGpHV9DwPetq21sYZlYejKScP3EsJwkDNI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJt1WEmlrDLCrRsrBiiS2nZztH2ml6NNYbff05SDWap54jdV9du
	HDfkEJxnrbRIYYs8J4gMM3t4VuB6IFc1u31+Q6ctU8YMiJ8IXP2DqSdRf4ikb1c6yZEAeLaL2bn
	6yDC3eQ==
X-Received: from plbjf12.prod.google.com ([2002:a17:903:268c:b0:2e8:21ee:f199])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2304:b0:2e9:5eee:e078
 with SMTP id d9443c01a7336-2eb001433a5mr28660565ad.3.1793216737503; Wed, 28
 Oct 2026 12:45:37 -0700 (PDT)
Date: Wed, 28 Oct 2026 19:45:37 +0000
In-Reply-To: <20261028162510.2180528-1-edumazet@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261028162510.2180528-1-edumazet@kernel.org>
Message-ID: <auJQz9OCWPqJimv6@google.com>
Subject: Re: [PATCH net] tcp: wait for TIME_WAIT teardown before freeing
 per-netns ehash
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, Kyle Zeng <kylebot@openai.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, 28 Oct 2026 17:25:10 +0100, Eric Dumazet wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> inet_twsk_kill() removes a TIME_WAIT socket from the established hash
> before it finishes using the ehash lock, hashinfo and bind tables, and
> before it drops the death-row reference. A running timer can therefore
> unhash its socket before inet_twsk_purge() reaches it. The purge cannot
> synchronize with that timer, and tcp_sk_exit_batch() can free the
> private ehash and hashinfo while inet_twsk_kill() is still using them.
> 
> An unprivileged reproducer using user and network namespaces, a private
> TCP ehash and a FIN_WAIT2 timer triggers a KASAN slab-use-after-free in
> inet_twsk_kill(). The allocation and free stacks point to
> inet_pernet_hashinfo_alloc() and inet_pernet_hashinfo_free().
> 
> Wait for an RCU grace period after purging the whole batch.
> TIME_WAIT removal runs with bottom halves disabled, so this also waits
> for removers that were already invisible to the purge. Keep the wait
> under tcp_exit_batch_mutex, before freeing any private hashinfo.
> 
> Fixes: d1e5e6408b30 ("tcp: Introduce optional per-netns ehash.")
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> [edumazet: only call synchronize_net() if one netns in the batch uses a private ehash]
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks !
