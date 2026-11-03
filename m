Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793682397;
	b=CuVrExSebf5z5lH3yUXy7DbyaMfW3qHf80Dz/9e9eTfQmk35oZsk5FDm2a2K7+wWgOHh
	 T/Gf5W+/Qr8uuiq3aOIH96fZAIJl1tQtmEdPTnqQoz8oIcGg7PJEEiQOfZA10HCu9fy/Y
	 WWOpby6exNKQAW6v0+zzR8q3VdwMWk+ytwkrP5uvGuU5aFwAsxTcsUfQcNUNg1G5w9tn6
	 HiXx146vwsLvi08b1/a+WAFbh2yUwDwUC4M6IR43Ar/TUv3il3Gbjethw+oIbB26wo5E5
	 Jwn9aK2fm45VPXk3TMf+8lum3NXQyAfJPCCWBWMR73i3h1QCOO8nk0ykRUJrGxXOGOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793682397;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=GTsITmuHAIv/+kE0SNUbfba2LqBOd8VdgHoEhQmFbug=;
	b=wyTo4VBxBTSfm+MvP19RcVDwpwbhK8oNIykXZ4lNPGNjJQsSm6LKlQgjkr+M75u3KVMS
	 ug9X1ORCeus1Emlfor8fP5WoGJI45YoMsPAW13d3S+iP9bKm1nNMNx0kyTr3DsQVxEv1L
	 G8kYXmZ5tV2nEQQNnS6LhTtjjArAdPUEt1SOkTCaB6EoYfl14K8WC6qvwgtqSo0GV6I3q
	 eESMtmz6rbZCQJvoP9n63pIIai6rissuYfiiED4GoZPP09WcsndAgeP92+UhjGgowl9J1
	 44FDgu1rxUdjTlebgsszm7t5QKDuB2ES7ajDkotMJJi5LbdWeGGSq+GOLxaXWCrLBXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JevUa+0r;
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677C2606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 05:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 677C2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JevUa+0r
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd67466211bso2030051a12.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 21:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793682396; x=1794287196; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GTsITmuHAIv/+kE0SNUbfba2LqBOd8VdgHoEhQmFbug=;
        b=JevUa+0rLo0+2qi+ZpdzYN+Raq34ZNdypKmtdYwDLEuoGeQ/QiGik15xaPvHO3MmgM
         EY12ne4qJaY8Exy3MWxfX3WTHQJhO1W7jlOlluR4sPK2qBW3RZlvxjxN2JMw1GEZXYRi
         1PMrfu2G8L3UDoB54sPaf0cabbWyLMX8BBbMYzeVZr9ktwU2ixVHOS4ZPdaxShtWbzJS
         GqdCFWFAFAFvPmqawEwjQW8pnXwQSsz/fKJM/KTKoFcNukDZSYTk66joKdbKP3yy1lUR
         IfK4M6Pz5Scp6Kco6lfGNCOJ0hFf6TMh8DfyW76yoAqF5H2rmyG7PO2csMl5cBZ1E97f
         SkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793682396; x=1794287196;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GTsITmuHAIv/+kE0SNUbfba2LqBOd8VdgHoEhQmFbug=;
        b=dGaMiqP6188vKsBQInW5e0CKyK1z5VYZUyT5c19mbB7wjbMhOCyW90fDZHLWKjNJo+
         8FcUvwid5JVdYTJhAK5ZH8tlKrwS1hf3iMsl4FbqPgZNtd1xNIAzjeoRmbkxLxpWnMNG
         w9NGpo/4NC8B/pF5adt2EJEVWEpA0X14jnfsDsO2cbUFTA6a0FSpEgKyVV3VjkxOA1BK
         qaq1CJlUvWvVJdgZgutlEPxiNW09GvYo+xmHkQA4rrJfVnZgLUpNamd8UHnA2xk20NGo
         CSZF7bzwbZhF89KKsxhP3wO9DfHKbz8B4JFSigBIy3DoTmuL1IsZJO6vZKzPwZqSpCra
         GWkg==
X-Forwarded-Encrypted: i=1; AKwUvByPY7fj0vqtTyd0bo4xTkrHLfbfo9GGry+kW5hZrMspvHCb3+IDjgLc3JJo34PmF+fVUAkKDnw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9t11bwxKe9ZrvBaloBwrj3aar+N+sv2dVb9xK+KH56gJWgdWZy
	nVYs0GTMCWj4JeK9lSBJ+OqV2zWQGOdDQF7+FDOba+EumZ5SVvfxzz6sNoBzBZTiErFFqREOGnb
	GPESRsg==
X-Received: from pjbjo10.prod.google.com ([2002:a17:90b:140a:b0:3ad:647f:c1bc])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b8a:b0:3a7:8350:3f7e
 with SMTP id 98e67ed59e1d1-3ae89771679mr9375963a91.44.1793682395471; Mon, 02
 Nov 2026 21:06:35 -0800 (PST)
Date: Tue, 3 Nov 2026 05:06:34 +0000
In-Reply-To: <20261102035943.9700-1-qingfang.deng@linux.dev>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261102035943.9700-1-qingfang.deng@linux.dev>
Message-ID: <aulr0Da_4s4WOp5k@google.com>
Subject: Re: [PATCH net] tcp: initialize send sequence numbers before
 deferring TFO
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Yuchung Cheng <ycheng@google.com>, Wei Wang <weiwan@google.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, 02 Nov 2026 11:59:43 +0800, Qingfang Deng wrote:
> TCP_FASTOPEN_CONNECT can return from connect() before tcp_connect_init()
> when a cached cookie or cookieless Fast Open allows deferring the SYN.
> At this point write_seq contains the initial sequence number, while
> snd_una and snd_nxt have not been initialized to that sequence number.
> 
> Consequently, inet_diag and /proc/net/tcp{,6} report the initial
> sequence number as the send queue length despite no SYN or payload being
> queued.
> 
> Initialize snd_una and snd_nxt to write_seq before marking the
> connection as deferred. Both sequence-based queue lengths then remain
> zero until the first write starts the connection and runs
> tcp_connect_init().
> 
> Fixes: 19f6d3f3c842 ("net/tcp-fastopen: Add new API support")
> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
