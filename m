Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794293158;
	b=zokdBgROWPfmZlTa24jKqr6jPp1EKfud0vs8MZ8TgKUAMqvZ2Wg6JkJ0KOMeUQ3skA3u
	 v32wzzcqf7LxWWhLyyMHyiZE85aM4jvSuhdTiC90yIvy1h5FdAgmn+vB+bVHYdQl5SaOu
	 dLjmYK1sBNwSk4bKZhu2Yd+QVCw94CdNgsMLAQQ9NVF68GvdBlj/YGI9x+DCP5oe/dKAp
	 1SIQgYrnFwUp3TJxUcgh7GexQKaxY4lpYrTEqBASXeStS7syD+5A1XVZ4mqbN2JEXzS+8
	 g9Zpi+tHy4KHMDdVve4pZID9VFO+k5dPY6S5VL/56JRJF50QrQCs1jgj913PqIXLsMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794293158;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=zVcHMSsusl1Ej7N/9YmP8osA54hse8QtuF0mZhuFuKE=;
	b=gt7Y9OzSUyOSuQADOc9l+V0juCuJTl+5De46sxW/tbR/zY6e4PSVjWwDCteTzHbA/A7t
	 6GbKdqrOhTyi7fAcmFySUQWt7ZyOEc6OxceCsrPqcUPR9cqcTx4N8m/m3q8Z9b4yo/UNy
	 x1go6rHrl7QT1lypbWmK2SDbIibbC7LaMPvLkl5s+VWzXdC2nsEr+zAhd2WYzMOcUpV4s
	 ONqlsm5+wNUVcm3rLTOfZEn+1UNTRtU+OVhaAtJfAMlinmLY+YJkS3te8z+y1jlj9CiuU
	 X303PvGWpL974P4AdDyERxKUPJ7ubh823x8JCiwjwyTSJx08C3RvhHodeRj1YiGJScA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iKXIWz4f;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3F1606A657
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 06:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B3F1606A657
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iKXIWz4f
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e987ec84afso16690465ad.3
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 22:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794293157; x=1794897957; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zVcHMSsusl1Ej7N/9YmP8osA54hse8QtuF0mZhuFuKE=;
        b=iKXIWz4f5+r9vNjEX1njp1JAE0DkemMvWqkFWMmG3Vjv1ZLOycapavc7kVSFLpv0WA
         PsNPmLRxlONNp21iNG0QisN8PlO++GJPtHshY77ahqCn7ItMwytliqA1DhcAKvE2KmBO
         7Jy+jiQo5Xwnk65oYSNtkD/4sFfJjtqtGqKOHsR8CUrqZ2zBkdQlEQOhZo3Udg9IVxwI
         zc+SfBMN+8P38cESTNHsw6B9J1Epaio6O/ZozoBZ7rKezKKZnGKXVR1qiG3ZiTxWaJI/
         KZ65SnaI23nwOWTRxUVgcparBkJ6QDAVGzXI5IUYZYv9wH1wull3D78cyskKidIRWjy/
         RLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794293157; x=1794897957;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zVcHMSsusl1Ej7N/9YmP8osA54hse8QtuF0mZhuFuKE=;
        b=FSwHsQdgtM0dfe6AO5Xzxb7+heKvXB46Z7Etl5LW976g2N66lxXUinABMh8IjhQVWM
         BDs5hdMj0vdxYRgqdYbQogfF6fuSFcDBn7qDsxmBXzGWu4rqammaXm61KZBEDQV7BIip
         1KC1qsO5YCsMOkd86O9gfD9SpN6EygTBnYdGwaDGSQV0R3IErS+e2qV3LqUyQaIsVIhK
         ZeLwVzxb0OK4RFwUOFfPresFKuKOBu4TVRzcAy9bMgCMFNwT10J0LIlEIKeIXkgpkctz
         SZAdDc7QecZ6aPuVrIZ6N9s6voyMJte/8L3IUGqOq7ZedCbDjzz0vLeF+WvMSv13mBEL
         hnmA==
X-Gm-Message-State: APuU4Z+saA9/CE7xldRN6d4RVo0asm9k9OmFi+2tJn/pqlHrNBnHxRaQ
	/l8CIT1i5l0H2F9KT1s4oksvYoCywTPE8xOv5DhIR845Pf2y6suKNIW4wppMBo6frkER0DPrIl8
	3LHD4Fg==
X-Received: from plbmm14.prod.google.com ([2002:a17:903:a0e:b0:2ed:5534:d103])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f542:b0:2e9:5714:6087
 with SMTP id d9443c01a7336-2edb8f95ddbmr16875455ad.5.1794293157096; Mon, 09
 Nov 2026 22:45:57 -0800 (PST)
Date: Tue, 10 Nov 2026 06:45:56 +0000
In-Reply-To: <20261106171442.31811-2-baditaflorin@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106171442.31811-1-baditaflorin@gmail.com> <20261106171442.31811-2-baditaflorin@gmail.com>
Message-ID: <avK8iXcNfXSt1_CQ@google.com>
Subject: Re: [PATCH net-next v2 1/2] tcp: avoid false bind exhaustion with
 odd-sized port ranges
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Florin Badita-Nistor <baditaflorin@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@kernel.org, ncardwell@google.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	shuah@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, 06 Nov 2026 19:14:41 +0200, Florin Badita-Nistor wrote:
> inet_csk_find_open_port() rounds the range length down to an even
> number but keeps the original exclusive upper bound for wrapping.
> For an odd-sized range, the two scans can therefore miss a valid port
> and return EADDRINUSE while an eligible port remains free.
> 
> For example, restrict a TCP socket to IP_LOCAL_PORT_RANGE [40000, 40002]
> and hold explicit binds on 40000 and 40001. bind(..., 0) always fails,
> although an explicit bind to 40002 succeeds. Both IPv4 and IPv6 TCP and

This is the reason of warning in set_local_port_range(),
so kind of WAI to me.

The change should be fine, but we should remove the warning.


> MPTCP are affected. A namespace-wide odd-sized ip_local_port_range can
> also trigger the failure without a per-socket range setting.
> 
> Keep the full length for the scan bound and wrapping. The two scans
> then cover every candidate in an odd-sized range, with at most one
> repeated candidate when exhausted. Even-sized candidate sequences
> remain unchanged.
> 
> For odd-sized ranges, subtracting an odd remaining value when wrapping
> flips parity. The first scan can therefore also select offsets of the
> parity preferred by __inet_hash_connect(). Namespace-wide ranges with
> same-parity endpoints already trigger a sysctl warning, while connect()
> uses step 1 for a per-socket IP_LOCAL_PORT_RANGE.
> 
> This only fixes bind() allocation. The rounding in __inet_hash_connect()
> for namespace-wide ranges is unchanged, so connect() can still miss a
> port in an odd-sized namespace range.
> 
> The issue was triggered while developing port-range selftests with
> Codex assistance, then confirmed using userspace reproducers on
> unmodified kernels. No kernel instrumentation or fault injection was
> needed. Booted x86-64 KVM kernels were tested against the regression
> selftest, the full ip_local_port_range suite, and a Go net.Listen
> reproducer. The Go reproducer fails 100/100 times per IP version before
> the fix and 0/100 afterwards with a three-port namespace range and two
> listeners occupying its first two ports.
> 
> Fixes: ea8add2b1903 ("tcp/dccp: better use of ephemeral ports in bind()")
> Signed-off-by: Florin Badita-Nistor <baditaflorin@gmail.com>
> ---
>  net/ipv4/inet_connection_sock.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index e56beec43..755fcea35 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -343,8 +343,6 @@ inet_csk_find_open_port(const struct sock *sk, struct inet_bind_bucket **tb_ret,
>  			low = half;
>  	}
>  	remaining = high - low;
> -	if (likely(remaining > 1))
> -		remaining &= ~1U;
>  
>  	offset = get_random_u32_below(remaining);
>  	/* __inet_hash_connect() favors ports having @low parity
> -- 
> 2.51.0
> 
