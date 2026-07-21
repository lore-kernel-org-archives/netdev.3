Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611A62FD1A5
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 00:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784593736; cv=none; b=lHfJN+qHeyqUd8CFswrLbOk8IkOIhN5sO/D9BRMwExsPzf3KqrGHUVGe6KKmdaRdnEaNCOPrDlLQCz3tJIHp7vR9VQmuqmfB5+eIWfFfsnmmFR/X7FuGANIWAUAlrr/A/m2L8TEs37P9nD2BPQfnxarqv9NkMXAPA6qR+WvRpHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784593736; c=relaxed/simple;
	bh=EjTjANCGyphgofXlmlCMolP5CWXfaH5V4+PEZGRC9Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlI/XceuanRhbOgjKjphiOqWic+MH96NRFfI7gln9uE8mSHy3EWbOAk6wPXSTEhfnFo4Ud00Am0FgEKa9P3gov/nDQhkToqugM+d6Actawj2FsGFSFYNe6dxTuZqQSJ9w35e1MqkR2euwh8KUPWxpDNO/TmbOd8mAvW4IlUiGvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeD63SfL; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeD63SfL"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so100310b3a.1
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 17:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784593735; x=1785198535; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YnhrM7uIvjKhsDFp/QtkP00zu99wnVGEBhtiKwVmfTw=;
        b=jeD63SfLmEJ2UKn3qvV+71ngEhvOVhIgoov4xJHlXYjkQb6S6dPonG0WkNJIJUZhpP
         YPOHkQx6LHo7vR/EfGKwwsxYZYFE5MSn3efriR4wiZm4I5wJEe1RSicXRypN/rhJ49E5
         669fdUfxoYmkct9zaQuWaYJcsM4HhS5t2m15DjyuIOBMqjHVPdgjI+z9ZkfOftq7bLKB
         d2t7XdeGLR0MZ0kT0PDmfFMCsGIBcOJ+n/WhBFflY7vW2ZjdwxDkYHdTyLybaTlUD3Yl
         /he3Guo4fJwwYz8BbWqbLntLDzO1Z3iwU47OzMY77PgWLWmrAIUg0sW1OsroQCbmBix/
         lvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784593735; x=1785198535;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YnhrM7uIvjKhsDFp/QtkP00zu99wnVGEBhtiKwVmfTw=;
        b=cvsUgANsYRsEAs6cYs2YO8Z2oc5oBXR1yHgF3H1vJ0PCtWDD6En/fRFZRfYPKu55zf
         QevmL994zGPe7ZOAhhKTzCHOULiDxb1VE3b1aBonkNzFFG1WEnXp3v0FfZUweeXyw4Hz
         ufxQQvo3UsquyOiiwRtHx/aa4OgSjKujZqZCJr1VSkm7df7UTuP/JHQ9kl49wo0ck5Im
         VL+9wOoEArn8o8Sc1COQSFdZAoX3OfR0rvmDt23PsOG0NfZpTvyRXBHOEAiWpfnP3hYJ
         HLY6icxk/nUyaTwyDQ2hRkAj+PPaeNJgTUolI8mnb4bcDcymFfQrG2Zo+OTPzMDbd/di
         x2mA==
X-Forwarded-Encrypted: i=1; AHgh+RqIewx8qbtRxeis4VL641GbYWtKFfTxlLHo/2E9ZQJZBBZRUGAzkNYkZORR7zT30btbBpsXLs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtsFGNHuKnKn8151X1nQYHjqY0tXKhBgkqho04Wngcro4d7czn
	0TPyoWgXqQL3g0MpbQM58rU0pQfdxA+x20RjmWQU/HvvsLcSWI7CD6jy
X-Gm-Gg: AR+sD10184zT3ZQeFbZGDEqlPwEPMj7NpjHrwfBcPCqA+XLPed8qgOByHETlTdfC59y
	kma663wqT67MnOidG2rdGom9ptzWxiCwQbokwNFn6liB9xuRZTOyTxcYANqxcnJqNHwab3EsqfS
	zQ/lpTzsfL5EeH2x9MkE6R+JK9Q5J+GhC6+aLEU0J59Cg15keQg3tjfuNae/GRaU1paS4n8MqGO
	P7raeR1qbTX/Yf1Ahdd8lMl6W1JE7IAsNxyoMIdSPW8beS5mG4cBvwMluBR6+z69Dvt9GfWvUZT
	uZ2p9bxldN4aNx63fYWW3pGFEIr0/JrG5irgK+jGBEb13223PLgl04WZfFaPalggv4RA2u9JfUj
	9hLqV3DkMOLEcDHV9Qxx/bPPphRjW7bhYdbtOVCr8JjLfjYaxQpHM3mN8J93LZDRvMZAXWnc4YO
	XpvOg+rTlvDueGV8N7qeqlFKWJErv/LCPgNA==
X-Received: by 2002:a05:6a00:2f97:b0:847:8704:1c48 with SMTP id d2e1a72fcca58-84c292ac4d3mr10870603b3a.20.1784593734662;
        Mon, 20 Jul 2026 17:28:54 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:46::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af9f00bsm6429812b3a.56.2026.07.20.17.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 17:28:54 -0700 (PDT)
Date: Mon, 20 Jul 2026 17:28:47 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org, sdf@fomichev.me,
	razor@blackwall.org, daniel@iogearbox.net, matttbe@kernel.org,
	skhawaja@google.com, dw@davidwei.uk, Joe Damato <joe@dama.to>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v5 2/3] selftests/net: ncdevmem: add -b option
 to set rx-buf-size on bind
Message-ID: <al69Pw6/5M8jCM7y@devvm29614.prn0.facebook.com>
References: <20260708-tcpdm-large-niovs-v5-0-34bf6fac941b@meta.com>
 <20260708-tcpdm-large-niovs-v5-2-34bf6fac941b@meta.com>
 <CAHS8izMz_S8K80EXn3oFXiDNkGuPUMzjecaJjAvaZVky-7O40Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMz_S8K80EXn3oFXiDNkGuPUMzjecaJjAvaZVky-7O40Q@mail.gmail.com>

On Mon, Jul 20, 2026 at 02:15:42PM -0700, Mina Almasry wrote:
> On Wed, Jul 8, 2026 at 3:55 PM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> >
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> >
> > Add -b <bytes> to request a non-default niov size via
> > NETDEV_A_DMABUF_RX_BUF_SIZE. When the value exceeds PAGE_SIZE,
> > udmabuf_alloc() switches to an MFD_HUGETLB-backed memfd so each 2 MB
> > hugepage produces one naturally-aligned sg entry.
> >
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> 
> 
> > ---
> >  tools/testing/selftests/drivers/net/hw/ncdevmem.c | 36 +++++++++++++++++++++--
> >  1 file changed, 33 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> > index d96e8a3b5a65..a16e55af51ee 100644
> > --- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> > +++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> > @@ -40,6 +40,7 @@
> >
> >  #include <linux/uio.h>
> >  #include <stdarg.h>
> > +#include <stdint.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  #include <unistd.h>
> > @@ -61,6 +62,7 @@
> >  #include <sys/time.h>
> >
> >  #include <linux/memfd.h>
> > +#include <sys/param.h>
> >  #include <linux/dma-buf.h>
> >  #include <linux/errqueue.h>
> >  #include <linux/udmabuf.h>
> > @@ -79,6 +81,7 @@
> >  #define PAGE_SHIFT 12
> >  #define TEST_PREFIX "ncdevmem"
> >  #define NUM_PAGES 16000
> > +#define MB(x) ((x) << 20)
> >
> >  #ifndef MSG_SOCK_DEVMEM
> >  #define MSG_SOCK_DEVMEM 0x2000000
> > @@ -100,6 +103,7 @@ static unsigned int dmabuf_id;
> >  static uint32_t tx_dmabuf_id;
> >  static int waittime_ms = 500;
> >  static bool fail_on_linear;
> > +static uint32_t rx_buf_size;
> >
> >  /* System state loaded by current_config_load() */
> >  #define MAX_FLOWS      8
> > @@ -142,6 +146,7 @@ static struct memory_buffer *udmabuf_alloc(size_t size)
> >  {
> >         struct udmabuf_create create;
> >         struct memory_buffer *ctx;
> > +       unsigned int memfd_flags;
> >         int ret;
> >
> >         ctx = malloc(sizeof(*ctx));
> > @@ -156,9 +161,14 @@ static struct memory_buffer *udmabuf_alloc(size_t size)
> >                 goto err_free_ctx;
> >         }
> >
> > -       ctx->memfd = memfd_create("udmabuf-test", MFD_ALLOW_SEALING);
> > +       memfd_flags = MFD_ALLOW_SEALING;
> > +       if (rx_buf_size > getpagesize())
> > +               memfd_flags |= MFD_HUGETLB | MFD_HUGE_2MB;
> > +
> 
> The fact that you are using HUGETLM and 2MB mappings here made me
> realize there is a pathological edge case in the code where the netmem
> size you're requesting is greater than the mapping size, so you
> actually get no netmems. So like if you ask for a 64KB netmem size but
> actually you did a normal udambuf mapping and all the maps (sg len
> entries) are 4K or something. IDK if the code already handles this
> well with an error or what not. Worth checking.

If I follow you correctly, in the case of sg len == 4K, and requested
size of 64K, it will fail the !IS_ALIGNED(len=4k, niov_size=64K) check
and return -EINVAL.

> 
> --
> Thanks,
> Mina

Thanks for the review Mina!

Best,
Bobby
