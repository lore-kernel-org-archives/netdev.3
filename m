Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E653429CCA
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 16:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784305795; cv=pass; b=cvRtwWD4XeGBCUCB0NvkX575WS10EZQRconKakKyfw38dqoM5KGOrz8+RdCsu9R0K71rgDQvzAY7pxIgAdcO65QccZUhxxW5A2D/pSYqRJb0U/9FoWoRUOaOZIZas5yJnGk7rmWIoAse0l6d11DXzXqCWfBfAn1ggrPoWVB3lHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784305795; c=relaxed/simple;
	bh=KEIvrRuiVrT7+dBXuaA0uQ4mV0n5hVwt+9ry5LaCeWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YWhuWdBlss0WAnzugK0fjqQHexTLl1w83CZqi6blD/9CAwHDUpbkqOW5lpVq/Y7J0eUM/RQ3lydMt7R7lr5iIAAh3OGL81fll1u7fbgIOQbQKZAeGfZ6pBLd4/OLfasn9RDG1m7kBBRWk0UPVVV+6wWiTWCRpgx+K3fUsCNLeeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=azzd97Uh; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="azzd97Uh"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493be0fbcc5so76115e9.0
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 09:29:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784305793; cv=none;
        d=google.com; s=arc-20260327;
        b=YoWmk5F7iv2O7cHwUSDVmT+y5g3cnQQey/FdoA55emAlClYcjZlEWJyaxuAO9GqBQQ
         y20d+kLQhk1LU6jUHFiVzz6HjmzUbsjNJEPCdEJKMeP3KMyGJ0eLeAZBJA8jLp0XxWTc
         R8zNgZPeZQaUXCgr930BI3TkmGpJwH3jTP2GczAem5Z4mCvEYUZ7UgXc45z6F/Opsy+F
         gPIklPZlVvXenCfF0S7QgGyqiX5IttAGcyg7ShcqN9wQ3vrHmP1wqBqm8j1xddHvyAzE
         bdd0kPnBVxzEofoJM+qoWVYRrtZQtUIQnL5LRmzKVE/hapzl9PZi5G8aA5OUzRf5+KBl
         jhEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J1fiEC3LJWgMWiE+exeLjiuwsjKxQMa3Wx9AO5yvpjU=;
        fh=Jc1f2U+mmTULDgUwN9kastT8sATU9i2EMdtnpcVgz/U=;
        b=fUtz2AMUB/5tVtSG8Nhbcs6D9z8gOvPiQDBnsFNcCEfRWc2Og+ZB4suIbCHQ85XzZ2
         NNVWjeWJdVRW5QWOp39TQwjy0i+d0TdMvOJvn0NZQPdXhIV6g7XmwEUV3uJWp6qAiQiP
         HMWxiKciELJ90yEZfYHmpnS1NiMbJmvwREO6VbvIRJFiO5tmwjFVVSQTLiB7MOrADGNZ
         fgoZL+ZOfypocBqQMqLfmXmAtenKevLy0I1bNDDupYcZrs3/M4r1uPHvjQ1K5fx3wIpZ
         Poh+It+8+3SB14Vog+uKrOVibP8sIZih/7nFWdENP5pMBIF3BiiWivrUFF6TQpie69gU
         k05Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784305793; x=1784910593; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J1fiEC3LJWgMWiE+exeLjiuwsjKxQMa3Wx9AO5yvpjU=;
        b=azzd97UhRk4GDudHUsml6PbuUSQ/8qXtL/v+QsrQ8C+U+JGlD4zoZZ9/EfcXrgPJ3I
         Fs/TE80q6YhRcj3REYloQtH/mRXRX1ifItzF2Ge8OwuZyTti4F3CCDYVv92jhXvXrPhd
         48gLpFL9cxUn5jUtOk+0ocn3a66wjr5R3YcYdMPRaEyzAs2O3Yx5Kx90CuGaH00smq2f
         FaXDxS85tOUL8WuG3FFGeN3OvOl7g7mcBhzMDPSCMnAaEso9hb7vi/oqxx1GvtANZmJp
         rdAzN55SUo7rpwLMW1+L94jYxA+FR6URGmEwloPvZlJunWpdo4AMFpy5Omn8dv1CZQYz
         bZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784305793; x=1784910593;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J1fiEC3LJWgMWiE+exeLjiuwsjKxQMa3Wx9AO5yvpjU=;
        b=ijGhd2VY4IeNpG6FR6y22tu22dMJN7JX/PJwOMEXwWVveQWL6rJzS/lRJRD3MGwjew
         eYBetY6ViLSSEWffB2UAKRdAxI9lbWZR0iFiSM+3q8tQ2UYol9P8AA/C3sqe2InTgiSk
         FLGXnKnw/Pi1GoXuAaYNiRFCQj8Bl9e5q1FD3g45ZYV3w9lqKXPht7h2RMwTA7mh8t5v
         Gr3qJverfZfZw7oQCDXIodOHQLYNxbh1KO0bhjopTTADooY209/WtJdlzkRtgqUEWVrj
         AyyOWzNaYg5ne5Cgzvn4KDQIEiw4RmtTa13tO9KbiXB10OYLUR6B4qZcluuxW1hAP5KK
         fYtQ==
X-Forwarded-Encrypted: i=1; AHgh+RoFR/d6Jo/bXpWHpFbZcHIuGlYSRrB49edjD4/ixRmZ3cZD4uCc5nctFTu6DiYyreSxGnuOgkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvjT2sj2k6dDAk5akqLJkEMDtCmKClfWHi6tEJYYg7S0wKRJJs
	DncwSgHy0yxaTBZjJyOIpDr/K634v6Kn3C+VTTCM3so+k+mcztLHzCleTgLoy4+yWDCSvhI8q1U
	hSKD6EwHNW/RROUR6lr+CY7iwMT6QJ04Bok5uKgs4K1YkhKcdZuTI1PFg
X-Gm-Gg: AfdE7cknDnhCo/x+9BbuBc/GSfrM7uWfZ1X8V+8+GB9OnDFIInVnHHuqDerjEfGBXsM
	DWzA4HcHp5JsChg2rIeBugbDWMYI3jKZI/IA34lK7jTgPqNgIcvkwOvmEVM/kCI1bansV/Fj017
	FE+ND6QumAfnZvE7BcR1nBnvywV/I1FZI+1UOG8/W5GqO5LF7Fo+dq1T6SOJ9qKClmrHMKvq+ta
	qusIHx5gDSstrnTBQH+T2rtBUA9xPDd9s5lt8Sc7CNu7j1F6RO5+8cnsMjLlFvPswQihLF9unCk
	sKpOxZyEcDfHBTbAY6SC9L6rauc=
X-Received: by 2002:a05:600c:41c5:b0:493:aed4:8d03 with SMTP id
 5b1f17b1804b1-4954f623a21mr164335e9.9.1784305792127; Fri, 17 Jul 2026
 09:29:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701192210.2997769-1-tjmercier@google.com> <akbPrI67h5btdI44@devvm29614.prn0.facebook.com>
In-Reply-To: <akbPrI67h5btdI44@devvm29614.prn0.facebook.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 17 Jul 2026 09:29:40 -0700
X-Gm-Features: AUfX_mwkE9srLqf9jV3ClopD-np-tcerODpRpCcyM1eqJKlhjubKKS2HeTkHP3I
Message-ID: <CABdmKX0-tubji_pBiaZbePrxVLA9qkw5ez61wyzjDz8-pko9SQ@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: Open /dev/udmabuf O_RDONLY
To: Shuah Khan <shuah@kernel.org>
Cc: kraxel@redhat.com, vivek.kasireddy@intel.com, kuba@kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Bobby Eshleman <bobbyeshleman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 1:53=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gmail.=
com> wrote:
>
> On Wed, Jul 01, 2026 at 12:22:08PM -0700, T.J. Mercier wrote:
> > Write permissions on the /dev/udmabuf device file are not required to
> > issue ioctls and allocate udmabufs. Applications should be opening this
> > file as O_RDONLY. The BPF dmabuf_iter selftest already does this. [1]
> >
> > Users are pointing to these selftests as examples of how use udmabuf,
> > and encountering permission errors on systems where write permissions
> > are not available on /dev/udmabuf. Apply the principle of least
> > privilege to selftests which use udmabuf by removing the write access
> > mode from drivers/dma-buf/udmabuf.c and drivers/net/hw/ncdevmem.c.
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c?h=3Dv7.1#n49
> >
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > ---
> >  tools/testing/selftests/drivers/dma-buf/udmabuf.c | 2 +-
> >  tools/testing/selftests/drivers/net/hw/ncdevmem.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/drivers/dma-buf/udmabuf.c b/tools/=
testing/selftests/drivers/dma-buf/udmabuf.c
> > index d78aec662586..ced0b95c876c 100644
> > --- a/tools/testing/selftests/drivers/dma-buf/udmabuf.c
> > +++ b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
> > @@ -140,7 +140,7 @@ int main(int argc, char *argv[])
> >       ksft_print_header();
> >       ksft_set_plan(7);
> >
> > -     devfd =3D open("/dev/udmabuf", O_RDWR);
> > +     devfd =3D open("/dev/udmabuf", O_RDONLY);
> >       if (devfd < 0) {
> >               ksft_print_msg(
> >                       "%s: [skip,no-udmabuf: Unable to access DMA buffe=
r device file]\n",
> > diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/=
testing/selftests/drivers/net/hw/ncdevmem.c
> > index e098d6534c3c..8114a29692fd 100644
> > --- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> > +++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> > @@ -149,7 +149,7 @@ static struct memory_buffer *udmabuf_alloc(size_t s=
ize)
> >
> >       ctx->size =3D size;
> >
> > -     ctx->devfd =3D open("/dev/udmabuf", O_RDWR);
> > +     ctx->devfd =3D open("/dev/udmabuf", O_RDONLY);
> >       if (ctx->devfd < 0) {
> >               pr_err("[skip,no-udmabuf: Unable to access DMA buffer dev=
ice file]");
> >               goto err_free_ctx;
> >
> > base-commit: fbb7ad31ab376c5101b2ac7205fad0344fd2de60
> > --
> > 2.55.0.rc0.799.gd6f94ed593-goog
> >
>
> Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

Thanks Bobby.

Shuah, would you mind picking this up?
