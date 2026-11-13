Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601342;
	b=2YHJSOF73s+i4HScPZjSexkRVaO8aKYg3ZFNts8oLBrSfUzFJSecf0Wu9bnG6p8n/BCE
	 Hp7d2etBEDZOg3J8dlkAME0/BhFeDhDHolDg0FFQwyaVLYvlo2obOGzpkn2+fnfkTJ/vO
	 3Lj7jWFXvo7TzjVeg/ckTNXQRO+H6Fyff2PfZWN+FGUD2Hrw5s80s/G7hdeqOkyZLzt6Z
	 g4nlTf8b0iJJNiKfHWUJrhH86AOkmgsU6MIMzoYy0UQrYETuqRi6XKaetEWqJStNUUH7v
	 Yy2OS1+N1wP+YW4W6vOiXsNJuQA5LT1d2+4cnvhrxlSKs/wB4bLw+n9QiVw5MEnw9kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=s5HRLWT3GJ5V57HOZzLlKs66p4zza+KZ/ooym+DPD/8=;
	b=JkzHY4q6h0/F+PuV6EXSPSJo/5H1wB2/VdgDhPqfV6J7i8h6OJucMsfBBfCfCrXW8Tkm
	 KDXcZxU8Fcuv3wIpo+xIitxuLWF2rcgW9ULMnGwZxpiLWwXSkPhANXKkmDfiNURPxQjQ8
	 Eua5Si3cjGbtivplX1Z1ATI2mynLdOQM0JdTCkXHsX8IkHHUqv+ST1Rkm7b4NtXn6eZ4h
	 smKmesXhUuf9vqpTFolmRkMs6pc7bVvoLtiCXwBoxEtqOhuOtOIcK5Lstc/7ythJdT1UL
	 kjnKXFuhJxFNR9Zwyb016022EtMVmzYzA40BObNSbP1zJnf88p3nOyiAvjrseleqqWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wL9QWYYa;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C35606A89B
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 20:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4C35606A89B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wL9QWYYa
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-36c9b5c6faaso691374eec.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794601340; x=1795206140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s5HRLWT3GJ5V57HOZzLlKs66p4zza+KZ/ooym+DPD/8=;
        b=wL9QWYYa8TzOJZVMNIyc+YX+4aWHXvMAiO159H51XCo86sRljVLG9cSgH+BOWJZiP2
         6G2le+g8OtX74/MisNw15WdAoAWTDcvYg7tM3VF708EJMOGrOBUYzsjGUNGzc4V9dZto
         EYO9AFg6efIX7i5dit17/pqUx+ghyCOxB1VwYfSjW3FRdQTE0aGgSh6aEwa7oNzFuSpG
         g5wtAjhoE09wyLWJq6rj9H5RFxaTDKm+KXN18OL25Y/hsccmK9amysRVN2Lj8o6Zv/Va
         jsOoobBDuEuXWpHTpjiPTYd4nIgte5zLNnQscwGjiU0QRaiRX4JhfCcH0qT1+lod5ULc
         4HlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794601340; x=1795206140;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s5HRLWT3GJ5V57HOZzLlKs66p4zza+KZ/ooym+DPD/8=;
        b=gKUJLSRCli8oliOcEgB9Ju20JVW4/s5cABeLAyXgXNH+xv2xiQ0UDHfqZGjyOo3qvw
         k2D0XR9cXGvcOgyC8jGc2gD7hu/8iLTnunjJMPnuz5hSoejK1/iZNc7iBo9E6WrKucjd
         UIQ+knmOGsrWHKel8AQmyTw+ruP0wAGEx250+zF7YiqGSigiBU7iaA6GoaUL2BuzM7Vh
         DMKAZE9IYfOb5zOcEH/3cahR8Z8FKKCBC+vXR9GZN5dAFNj2x8JHFczVuILoUjbFcS7d
         wE839Y6/RFyXF7Nj5UFURTGWs9l9F1tV/NY8798v3y37mgVbYJKZwKNvzvcfzo8jCCeE
         Mjkw==
X-Forwarded-Encrypted: i=1; AL+hErH+vU4ocQaRrYnrrhkHnpiDNj3BxGxznPhv1FVzL2VFVuuNbG7Yj1uyC7KUZsbE50M2bBxlSNE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/j1V6vJRMVgKt4vBkyBa4abRIRZxL0oFL1QIXjWb4OYp6WQae2
	xI9byryRy4rcl37LhpJllueWSv6JX1OQ1Lzn7NAympXKP0DeyqT1kbDE
X-Gm-Gg: AYBFou0Rrm9HELzYkmUyObdNprhzFzqpR+S5R4wG6r2treGwmUl4o2ytYMgNmdQ3Tm7
	0tp/E2vVOYXVjeAHU190yDIycWujNtQtTzDX97cwrBxPy9SHBl/8kwzMrhj5Gf9jwPyUqt8OPgU
	zMcdOfLG0tJ046h0YgzvCEd/rPoOJ07SOT+5HU36f4m1yD0zay2/9wl5X05TIkyAJEAb5xlpawV
	EXmwQJWJe50fiDTH0P3TxxPlAn6VLvdONJb1Y9+d4fDd5F/RO779zxz6+vumvU+Q6In79RTti4R
	+unm1qmFyRTHYYCHUh492anMw/vuUKkbdFaIgLWtbKFaellIV2fs8GJUwsBd5dkESJNkAlVioFi
	B/cRze15H6cQJUnFG0LWvhQmMjia8fmaAzYpilN5vNZhNkkMCsnZm4rh7azj76CSnB/pOEb0wgt
	SOUNDgpGd8HlmNVEHlamRZJK0tq/SaZ8y1LkJ2M/46pLXujQuRLDII2l0bc6wFbiCp+lEUU9x1M
	1XwFV39x0H210FlbFV8IPspK/DopS83YHHmW11ba42yDO/6zLcG/ufBkYuWg2L/8Xt/EwGtQxu1
	Z6xFmZ63HOvsyiV/bnyAkQI=
X-Received: by 2002:a05:701b:4594:20b0:1b2:4871:b1f7 with SMTP id a92af1059eb24-1b50313a743mr3055299c88.39.1794601339464;
        Fri, 13 Nov 2026 12:22:19 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:6a::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50313d8f5sm15946929c88.3.2026.11.13.12.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:22:19 -0800 (PST)
Date: Fri, 13 Nov 2026 12:22:12 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next 3/3] selftests: net: getsockopt_iter: cover tcp
Message-ID: <avdxbp3uCMtiO_KT@devvm16445.scu0.facebook.com>
References: <20261112-getsockopt_phase7-v1-0-1eb759dd0929@debian.org>
 <20261112-getsockopt_phase7-v1-3-1eb759dd0929@debian.org>
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
In-Reply-To: <20261112-getsockopt_phase7-v1-3-1eb759dd0929@debian.org>

On 11/12, Breno Leitao wrote:
> Add a fixture for do_tcp_getsockopt(). The setup keeps both ends of a
> loopback connection, with TCP_SAVE_SYN set on the listener, so the
> accepted socket has a saved SYN to report.
> 
> TCP_INFO and TCP_CONGESTION cover clamping the reply down to what fits,
> TCP_ULP covers reporting zero and writing nothing, and TCP_SAVED_SYN
> covers the length-then-EINVAL path, which the second half of that test
> uses to read the SYN back.
> 
> TCP_ZEROCOPY_RECEIVE reads its struct from optval and writes it back.
> With nothing queued it maps nothing and succeeds, so the tests cover
> the 16-byte struct glibc still declares, a larger buffer cut down to
> the kernel's struct, and one whose extra tail is not zero.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
