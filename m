Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792471467;
	b=xNag/qEmqNTfrC90Lf3Unq96lIwGjd5utjjlzYrssAdEXSLKxAzJAJKi4TFkhI1eFtfH
	 Zyl1g9UEwKCKMtD6JWvlEqJIbpbyhtIbt/kkTxFsuOGckgYyS6wiN2uWJ0VQLVvhWSmSP
	 wJkZI1IDpr1hK2bq+w3Z9qRvaKeNu9bphCi/7oysMmTe9hb2tIds0i3cy5CK2RlnEugRe
	 awuAqx1oL/Stb4xKKb9rYxcZdoRAEb+JI6zWYt3ZbClVvvqRPziAkooxEe1CQJnyO/hJo
	 /DTJZJmxJUrTi49BgFMBZKOePL5N2K9pQp87rsr5Je4ayzCFHvdoZH5uXK/ID0UMc6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792471467;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=UQmGxlGdn3QZ10a+N3kg+/R2AQD+k1cxjSIXOj37hsc=;
	b=Fwpyqg18Kv5DB4lHSKbp+84N95VVDUh1rJHtLSxRafCQbnPUllI6kUmxxxs71pbsVqwn
	 EBxSmovHIE9nb/vSUncvzMMlqaCbndJ68+QcPyT+1t/sdKzxTNPOX224AaE6Ub1LXegvR
	 v/AIQVD5BiZuIToSt92AwanVcVMO8wJ/8/N04bQ17+SqUjS9j2jKbgYkk3yBM6y03YSMj
	 pd3U7rJwsO3k+oojKy6CLsaw2bD0r5zb5536pWRk8qYRq2xxbpOa7NbAtU2u8Dvfi4Dme
	 QlUqULW0jFLtHTqUq48P5mp2g1+wkqZytIFjMjw0qRZZVUNiL8dxk+rqOMy+YTG0Vqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=raISaSLF;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6160606A320
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 04:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6160606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=raISaSLF
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a01e2962a1so2879201b3a.2
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 21:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792471466; x=1793076266; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UQmGxlGdn3QZ10a+N3kg+/R2AQD+k1cxjSIXOj37hsc=;
        b=raISaSLFvpfJhhKXTctmI2ZoD6G3Nx9qTuIBKW3Zmxc2Nkb3Bq+10xSuFAmKT5Nn6y
         My8vC/xbYO9YUAguV6MXmnMZmUuRIBAJAc2qQwmn1r/575pTZVo5M9DBV2xX3SNZeThb
         bB6hng567B6HlxPS8NmajjGC2/4Ga7Dwm01st8cT7eAlOrNoLmtj27dHnRFhWudCTbhs
         8Na0TmqqS8iLzLnyWvOzkwD4iS1/7IrxiRfjMZ+ITHzi99LvWZ88w7sM/sKaXsbuvNzE
         0M0nn37aYaGZawooUIgjAUB7ijvomLgayI6XxUU/G7qjStlREfr4ggzsX85zGMkZ2h1Z
         iHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792471466; x=1793076266;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UQmGxlGdn3QZ10a+N3kg+/R2AQD+k1cxjSIXOj37hsc=;
        b=E2MDM3Xr/OMPvFH6gJapybvob6IFrdTyOpI/Z0EJU/Qd0QAS5z+gvDVK6ZN2cUk0LV
         7b5VDY/lKXUVjsR0asuyM8h1/TwKbIoQXhqJh7ehU0ht+QgeLRTmA34zYePuPDee3yca
         Ct6guhQNTZN7T95of/mMjB4R1uhHxKxHjqzkiaBcfUQudG8N1YvAncozHQOBBUsNmZYp
         bNdu0r6jUMvS7qA6mclAEq7DhBEvXYOHjuhbpE9iOMeQIUitWeS9vh2HPgwQAWiXpYuh
         O0TqR0PhkSUIgoVNM7BsrxT6kUH5gqTzRzpqHJ8MAzFeYEkp/VGZr4LmDaa9b77WnOvd
         dpWg==
X-Forwarded-Encrypted: i=1; AKwUvBwVs2KxkEorWYwgRhkU6/Duug5WvDii5W2ntJDx3nJ59eI37oewTJ6/+jz4ayjKNQrPG0mew+I=@vger.kernel.org
X-Gm-Message-State: AFq9FYLx5yT9NAemYOdp9k/PXnr4n6J0foqlHDx4E+U3dL+lgBD/pDG8
	Hkr/twghFC1rSg6G3moD+ZRoAjtsnpQgCD9b/u6VaU7lLUL7GFUBbdckoWI/TiGnlGMSwgArOh0
	n5qNEFg==
X-Received: from pghy24.prod.google.com ([2002:a63:fa18:0:b0:cc7:d128:5a50])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9d8a:b0:3d3:aee4:66f3
 with SMTP id adf61e73a8af0-3e225fea044mr7912512637.25.1792471465857; Mon, 19
 Oct 2026 21:44:25 -0700 (PDT)
Date: Tue, 20 Oct 2026 04:44:25 +0000
In-Reply-To: <20261019082214.102398-1-dmantipov@yandex.ru>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261019082214.102398-1-dmantipov@yandex.ru>
Message-ID: <atbxndUiT5qkAER3@google.com>
Subject: Re: [PATCH v2] tcp_bpf: propagate error code in tcp_bpf_sendmsg()
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Eric Dumazet <edumazet@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jakub Kicinski <kuba@kernel.org>, Levi Zim <rsworktech@outlook.com>, 
	Denis Yarapov <yarapov_d@mcst.ru>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	lvc-project@linuxtesting.org, Sashiko <shodan.ai@mcst.ru>
Content-Type: text/plain; charset="us-ascii"

On Mon, 19 Oct 2026 11:22:14 +0300, Dmitry Antipov wrote:
> In tcp_bpf_sendmsg(), the value returned by sk_msg_memcopy_from_iter()
> is checked for error but not propagated to 'out_err' label, so error
> handling may not work as expected. Fix this by assigning error value
> to 'err', thus making sure that error won't be silently ignored.
> 
> Reported-by: Sashiko <shodan.ai@mcst.ru>
> Fixes: 5153a75ef34b ("tcp_bpf: Fix copied value in tcp_bpf_sendmsg")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
