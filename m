Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com [74.125.224.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D8B3CB56A
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 19:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790796011; cv=none; b=tazYid08qpWN51B9ke0VYRCtQbF1KGbuGeNfoNwPpzEJAg8YkFOp5BxL497FBF6bq09qfqKlWBpMKOlNXPLu9WpAUZpaI4NWYCCbawbiuQbZ40ExTjOtieBJiyxY1zji+O0eF4SFEJx+el0gLzUlP2TrGBO643ZGQ26IaqQL1zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790796011; c=relaxed/simple;
	bh=3BkDAyE6fccs+PYucXNohDR3mNteBQXtlFDPNI4Bs4c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=MAf147FmFSomoRV3HkLZ2oVWNUfF1eiX9W1yaiYDJZz8SxoDKXdMGM5DEM3K55xNo8TtgURJ1xGvxHH1mM0K26h+LDwyW+Q0hPI0dBuhojHhulokNCFyfUjqLdSR1R1WOgIGqDTcQ1jtPA0Kl/SM7TLaeSkZMN0TWiflCO/g3q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtQVvNYR; arc=none smtp.client-ip=74.125.224.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtQVvNYR"
Received: by mail-yx2-f38.google.com with SMTP id 00721157ae682-8ac4967f1c9so11748007b3.2
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 12:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790796009; x=1791400809; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fNRwU6CcnoU16ZxvOzBdiCoo/f1eJNf9gtpw4MCuhLA=;
        b=EtQVvNYRW4bVbNqisjE5KvgIZpEiC35FmVdtwOt3B2uEel2TaTJuld/JKfMNA3wdKi
         pJ/h1dC5YFY0XOHk59JbYjIRD1q8B8enRK3qVngSfIEk75E6Xxb/uAKYvG4XvPZocrdB
         92xJhKHkeFEjOKie0a7qyU6VCb6COC2AXfRA+anK01/UecYNIBICOcGmRJSv+5DpCBQY
         9Bkd3gDGEF9wqU99KxkcEcGjpMfO+Cr8qJPUu41LomzaynA8sgeiyx8fs6TyfeZosfUy
         1JqDqF3YGqcCc+nueJZGgLkDs6gVFozzRtqOZhHu6xp3vbKE1NSw+pTNSZbWT8B3u3B/
         0B7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790796009; x=1791400809;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fNRwU6CcnoU16ZxvOzBdiCoo/f1eJNf9gtpw4MCuhLA=;
        b=qVR1pEvSeDM+b7P2E5n8o3WTvHQ/XU+z07talzQZA0AoN6ZJYrrumiqYEWtL/VMTUW
         CBZb64E0ox9Fen5JqYWrHQpgkopKQOwB7CvI2tX8rFMzriYyiG5QlT3kn35+Qh9uW51V
         jNgOgkuXqpOXmuxU7LTN9UaHB4kSkdUic45dGIwdbPcA/veawPxAaXntE5+CvqkXBDer
         8IUW2BHtRKfsi9pU2HD9033TPCy8L0F6/RMybgAd/YBWbk7kY8zRUsoyfhgNM6iqVMcZ
         uc8vLzNkK4yZqWyoieF6O0YbIt0CtlMBmFVIOXHvsXL6kmV1EKl4OQBh/piIFhAIqygX
         rozA==
X-Forwarded-Encrypted: i=1; AKwUvBxPt38Q0WpDr4+ssj7AkCAHso0b4FcPuEASAAZ4OJiP3UvY9nuDtQITfTqUMqiIo4yGotQ62cA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKWQe0qzBM1qqgyURchyzCKA5NjcxdXVeKZiz+SdHxHOHhQ0Wms
	hb26UU7yIMizMUbjDEsGWcVNr3HQ2DIW5sFeiU2ZK6XBKu18UMN/eGmU
X-Gm-Gg: AYBFou2SwW+pw5y6sZZMVnnY3D/UZtK3lm5YR0DHfHYB2xKI7M0LnIyC49CvQ0kxHwl
	HEjcn3J4jIb9MIWk862FW2DYt+GlH+B647egwTiQZx6f6FmSMoecdkUW5EtcobcR5d/M4Khte+v
	aG7TGe8n/VspdOTNYWmKFjtdsTWQDRQrbw1KqYN+ITBIjiHnV0Vmf3ldwAjQqaJEfcEeQVhyHHW
	llTvnjiGkkkbnELxiHl4OqLtLqQeuXbGDHFwk7muFgmeo3CoHExRBaIe5XHbIn9+7HuQPDHB0D4
	lNzB7ZVusiVACjXQiQbYrS3oi/fC+UGIJfT7GpZXl4RPN1k9g1UhAmOUlsGGasGVBhcxsmyL/V6
	6KwGSdh5wNaZ8/pd4ZNEUb6oGSebQyUuS69HwrMg2+9Vd2R5ULRI1iPfeSoaUX6FGDUIBE/Xdyc
	7fE0S7x5VvwX2ABUSc4y/tMR8F9osneZ8Ren6GmQuQ06yJPZjWHPxBt6lkkF4oWuPMBmBXDy/04
	BGeyZZtH/dIUHLYafvIZxMTSQLvpLGLSplaSYAmZgb5W9ZZ/OuU
X-Received: by 2002:a05:690c:6e01:b0:8a9:9a2e:e33c with SMTP id 00721157ae682-8ac93bfd24dmr10044627b3.91.1790796008428;
        Wed, 30 Sep 2026 12:20:08 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8acdac9d318sm2782937b3.10.2026.09.30.12.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 12:20:07 -0700 (PDT)
Date: Wed, 30 Sep 2026 15:20:06 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Rongguang Wei <clementwei90@163.com>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 jasowangio@gmail.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 Rongguang Wei <weirongguang@kylinos.cn>
Message-ID: <willemdebruijn.kernel.279db086fa165@gmail.com>
In-Reply-To: <20260930080746.135017-4-clementwei90@163.com>
References: <20260930080746.135017-1-clementwei90@163.com>
 <20260930080746.135017-4-clementwei90@163.com>
Subject: Re: [PATCH net v3 3/3] selftests: net: add TAP socket filter attach
 tests
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Rongguang Wei wrote:
> From: Rongguang Wei <weirongguang@kylinos.cn>
> 
> reattach_filter_without_user_buffer() attaches a filter, makes the buffer
> the program was copied from unreadable and then attaches the queue again,
> which used to fail with -EFAULT.
> 
> attach_filter_bad_len_keeps_program() checks that a rejected
> TUNATTACHFILTER leaves both the saved program and the installed filter
> alone.
> 
> attach_filter_nofilter_flag() and detach_filter_clears_reattach() cover the
> ways to attach a queue without a filter.
> 
> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>

Reviewed-by: Willem de Bruijn <willemb@google.com>


> +TEST_F(tun, reattach_filter_without_user_buffer)
> +{
> +	struct sock_fprog gf = { 0 };
> +	short flags = 0;
> +	void *prog;
> +	int ret;
> +
> +	prog = filter_alloc(filter_accept, ARRAY_SIZE(filter_accept));
> +	ASSERT_NE(prog, NULL);
> +	ASSERT_EQ(filter_attach(self->fd, prog, ARRAY_SIZE(filter_accept)), 0);
> +
> +	EXPECT_EQ(tun_detach(self->fd, self->ifname), 0);
> +
> +	/* The process that called TUNATTACHFILTER no longer maps this memory */
> +	ASSERT_EQ(mprotect(prog, getpagesize(), PROT_NONE), 0);
> +
> +	ret = tun_attach(self->fd, self->ifname);
> +	EXPECT_EQ(ret, 0);
> +
> +	flags = tun_get_iff_flags(self->fd);
> +	EXPECT_GE(flags, 0);
> +	EXPECT_EQ(flags & IFF_NOFILTER, 0);

iff a respin is needed, consider adding the extra test to make sure that
tun_attach did not just succeed without attaching the program, as it does
before patch 2.

EXPECT_EQ(flags & IFF_DETACH_QUEUE, 0);

> +
> +	EXPECT_EQ(filter_get(self->fd, &gf), 0);
> +	EXPECT_EQ(gf.len, ARRAY_SIZE(filter_accept));
> +
> +	ASSERT_EQ(mprotect(prog, getpagesize(), PROT_READ | PROT_WRITE), 0);
> +	ASSERT_EQ(munmap(prog, getpagesize()), 0);
> +}
