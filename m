Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D914C3ACEE3
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 07:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791270632; cv=pass; b=iz2c8pUVMAecSC7CD3EI7SbVMNHtyzrKYftyBmNN5/InwIzAZ0wO7sulmfy020uco2EAjvSHatb5HEcl1BMDXMgHtZBmjo7Fvt6tPV71yx8vTkfXeq3GNAILvUjud3IcBLbLRGHdOAK6XHIpH8RpsTK4ZppxGlN9OCi1ZXqkG/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791270632; c=relaxed/simple;
	bh=swDviEAoNYUebctsfW1H636z6Gg9l4LE75WPX7+y2hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmUurvLOnAzXJjPq9lykcArfcXkenBo2pOds+jhFh2Ys9YbY8i2BrdMjkD81YknLq/fAlNNmpSYzhgNcUdQ0taPyt/dLJDvP63jkHnbUfs9e9dA7WRpJP0WpTR8as8H0rlbMMkK3DRFAW7n1zWU4LgG80Tw+m125UfuyGElgC/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ttOhTZLQ; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ttOhTZLQ"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6aae147ef9dso7968a12.0
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 00:10:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791270629; cv=none;
        d=google.com; s=arc-20260327;
        b=kqytIViulSj3PGnpmzmeh+3P2HiNPs0HgyldaJ+L6u+1W/ZOsPWWy1jVKpAs9IpmOo
         kKLIxA5gJ7fo62ffvbXK9Hm98V5i7N78K6Pofe0SXvGzXJdHyCRsfO9lVMQHghJTaT71
         VR7NyUDpdlglB7kv8PZbYwfb6eJ6o2ZbtPQZsb7ae+PCLabPKbricx32b13tVFzwW87N
         e2F8JKSCH8gHAhpFTg+V2IVciC9uUL6/UK+kCiYprw0M2lB10JqjMvLmBc8nUXfnELLH
         drCkM3tKcGXXPLNTYFVy1z6XzrA+0mvigJUL8QDqcW1xCU7sRiqzZ2w1EC0C/4q1FAsy
         NFbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=swDviEAoNYUebctsfW1H636z6Gg9l4LE75WPX7+y2hs=;
        fh=2gEN+PFKcGlQO5WxDhyk5R6UImFZ+y6+yAv9TgUuB5A=;
        b=RE0kKvXg7muDBQa8lE7Nd6SNWyHTEvImKP6HMl7Ap/gZQ0waZEuNMhoO42ExFXCKHZ
         +k6Ma4zVMxVK7ptvuNR30DVLmEU6ZVuhc1BFGdGY24J4K4z1KtZWvcCMMGBsSUMucGnu
         H49mv9cePIMP0lBDF1DysndL+PhdWhJReN19WbV4g/OtZ4KgnV877qp+vivSVi+NbmMa
         VdgMpAyp39j3RcHL2QO/+fyFfD7Q/HL5JFHVgyKDnEcl1qa7kZ9nNaSpGTGw4Sdh5lhy
         VDHbfuFBZniUWeXzyIsI08UVIOjnLSFBQKImu5z03nS0T8wrnwdgJsDg/9RtmY7ulB/a
         FeCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791270629; x=1791875429; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=swDviEAoNYUebctsfW1H636z6Gg9l4LE75WPX7+y2hs=;
        b=ttOhTZLQEY5uuBpGx7Y4a6pW4fE59EVqjzO55z2aAwvGYzBliFHBkOrS4lVYYRrAIe
         ieKUv9fV5c6eILop3vQE9BxqKJ1WVHwdg+M7ATTQHk8ZEDQ3cOzNFgSJrwVvkbQ8EWNq
         gSTqcbCtYJ1evWJfoTBawiGff8N/URQu6jsUOHBT3h/GT1UIiZCf3yDoCnCODBPwfZT3
         eMiy+5uwmzMhNFlyXdU0M994sQ3U/x//hr87IkrQKqNGCYcjb2MqzpEEGM/A5rHXDLYM
         jHz1IdyQ01P/3GpGZjC2hWZcVbJpffjR8qk1AOL3tIs/3D/AGacSrR/+1e3Jen7PwhHt
         6eow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791270629; x=1791875429;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=swDviEAoNYUebctsfW1H636z6Gg9l4LE75WPX7+y2hs=;
        b=XId0v7CjQYDm96/k3UirRBcq7fLzUGLQ1n6fkvpbOgrhSnSiPabvwsvGbcPwsvwQXZ
         8c3l/iDrvqyHC+/FxK9Ao+NncZBcyLkAlvSqwXcpgLuyDppcZpdOtnCIzOcucOqfFYPG
         LOtRsaWck+XCJ5u/jgrA52iRpIsKAN81PjXqtsJWHgtPXwINrM0r+3qBbWOdXS1pc/T6
         BvLim3xrIc1zKQUXLGfSM+twNdw32yYHKPT6gRkw5EKWogYOz7w5Je0UFqRoB+VKrqSc
         ht++m4vq9B6s1xNR+vjA/LiuQYVa/GjDjr+uCZOnKiO3RoGYqPWarkQA2aJER5TrAP6u
         4qwg==
X-Gm-Message-State: AFq9FYLoaD/22WQCnd4m6bql6twsqfC/LPA0kPgYNeQsWAJKxJdPy2lt
	vYPumaEWQSv8RI7TwlNPeULvptGHD6FI6XorZF40E1sUrQOrX8bfC+lTJiHRkseHFWCAzxXcO0Y
	/N5bkkT+s4ReKV126l7g48yjvPYS3BjrR2bkWbnFp
X-Gm-Gg: AYBFou1C6pAThPUse8uB+iv9PU/7q8VtSAakugOwQRdvUR3Ekx8Wp2mIY3VApUxfo3q
	fQTWFbfxT+q/WQy6VD/WnR8vlGPODXdrNBw8hn9WhYRB6CdeHK2km8+TySgGF2b/mJRfUyi9QmA
	bar4PO+/JGtUMOzdm1xEx9MzxTSFqbenwTL6Tf5J99pFDNxzAWpQEDW/7uoKgoVfwHiLlxrIfLF
	3steiU+ckYKG5OJVAYrR7xX1i0ObxhhlKsFSLHfxr4Atix7D2wwvgQ96ZmONqdhSsLzr4dc8hKf
	gWWEhgIRyG/hQki0oLBeiOITqmi7bDzN1HPLnUvdHNjr4kiRH7k=
X-Received: by 2002:aa7:da0c:0:b0:6af:97c0:ce51 with SMTP id
 4fb4d7f45d1cf-6afdca58f21mr21854a12.13.1791270628368; Tue, 06 Oct 2026
 00:10:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005201822.3060658-1-sdf@fomichev.me>
In-Reply-To: <20261005201822.3060658-1-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 6 Oct 2026 00:10:16 -0700
X-Gm-Features: AclHuK_9mrwbKj5FPDFBcTTw9EhGUrGWU1Idbrm2E5hqnsi5uMO4--x8cjtJ5pI
Message-ID: <CAHS8izM0FkjNM4rwmTjWZwyvjPBNmWCXGnY9eJogpuPWgmJAQg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: devmem: remove net_iov_area base_virtual
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, edumazet@kernel.org, horms@kernel.org, 
	sdf@fomichev.me, bobbyeshleman@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 1:18=E2=80=AFPM Stanislav Fomichev <sdf.kernel@gmail=
.com> wrote:
>
> Since commit 083e64a3af77 ("net: devmem: replace gen_pool with
> freelist"), a binding has a single net_iov_area covering the whole
> dma-buf, and base_virtual is always 0. Its only reader is
> net_iov_virtual_addr(), where it adds nothing. io_uring zcrx never
> uses it.
>
> Drop the field and the store, and compute the dma-buf offset from the
> net_iov index alone.
>
> No functional change. From review feedback on:
> https://lore.kernel.org/netdev/asPUZ8DPllHd6Yu9@devvm7509.cco0.facebook.c=
om/
>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Acked-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina
