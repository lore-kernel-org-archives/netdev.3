Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3142C3D6CCF
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474521; cv=pass; b=UmYiIdccTzqeGOxCW9f5yjcMQ7oG0ggT5tGSkgG8kapUbZ8sQXvw9vCchRTw9A7sm3TNu0j8+2md8sYFU+Xa0OtYkrED8yBdp7ytOZ7A/q0H5ADimtaC3g/wE/MXjwKOiMVF8qdzNgRf6aUPJc6ZD2uNcztb9ZlnOBN/rMOrE48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474521; c=relaxed/simple;
	bh=PK5DpGIYIZ4Q5mypA8J7nQL3JpavjxnvYneVp4Wv71c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nawyaCgHYJBQry4V/MANYZ3PGbyBIYWRVG1woJfSYMgM9vZZMoXp9uHI3dID/+NBQS4OiQgLSoLlw2ebJukXoV4407hH8KHzMC5/HgLJ7P9x+rXW+zSQGeWxenF/eC9UBdg9s5CdCtubJk/YDVbRdOtqDP+UThDyUvNVQIGlHYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MvA8cOKC; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MvA8cOKC"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3900e39d935so280135a91.0
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 11:55:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786474519; cv=none;
        d=google.com; s=arc-20260327;
        b=lpPy05tBWVMD3Ncv90V/WEG0EpgxIQ+3DncYjhkIxEqEW4B1HG2VvWGYPnmUknld9L
         e4dKi7vqBFXrmwAEn6DMa/JNY3R1fGXbUJHvYek28KKFYWLRbQhQUQc22EfUFKRzNya7
         ogubG8hlVGz+sbxBKRnPNomNR8HWbwb9zfIhKoW8K3muSHo1+ri1qp7RGjnQ0AD+IA3G
         fkjmuOrRA9iiqgF6wqgAPesKBXesQCojhyGaDNy+6cdZvGR8xl+xQcebWqjMFq/7Xtpc
         5ZoK9TvsF2TC1IwYKTVLn/4U7SZr/niO1kiWXXBG/kc7HAxWdpb+kzi1xdi5iAWGkAld
         0CsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PK5DpGIYIZ4Q5mypA8J7nQL3JpavjxnvYneVp4Wv71c=;
        fh=OrQUNgp4jD1QcsIWHJOdYOC7o7y77eyX1uL6Z5ZXGrc=;
        b=agBagp+IEdkwo0xPZFKHbkl44JEbGLrmnUYwY9MkEL1Z3k94a4HaHja4fzXfDDVq1V
         Q8m40c2V/q7bZjqYAb07TDbjenCE1aji7yygJQHH7cckhpftZTtqWZtJiuF2Y0kxipTW
         6HgMcRB9a37D+/gW3NyTaQHn0Iw9jqA4fYCP2fW6AYt3htRTLCoAeSz40z6ITn4dkmuM
         y3mxM6l0P88k3cGTDyqvQKic7USXhHZb+GwIa8lZtGwBUGrMW5PlzoIKwcxrNMhvMcl1
         l2UWBDpqoGSZIEWHIkXa8SRQAtH1uEjPPfp1rgPUWP1QXmrd9oeSQfB1QHp56nFrWyQu
         xLkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786474519; x=1787079319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PK5DpGIYIZ4Q5mypA8J7nQL3JpavjxnvYneVp4Wv71c=;
        b=MvA8cOKCCXQQlEI5MpSTG7Uni96YcPS5b/rfl+m9QzwZ1k6yGDSnhcD5xe8meOnssX
         Xs0Pr8pUP4mCgH1sBCVHw7bmve95hnxFLe3DncNcFRrJA2JIGbtAVbfry5z0a1Ab+mNI
         IgK8R9sRjwIR1fvw8R9WTX/fWpLuPoVEQZpFQNK+i24csuxgw/43lNUo7K3VmfphX6c5
         x3tVIMLV1Gxw1UdGkArwhiAMJERGpENe+zSp+zEUY2KLf7F1VBCg9VutYYWuBru7qC3+
         qrJ9hWdcklkm0d6YOqad+x6T1VLz5HHA139/xswx5aDGzlj+eybfBSs4kV9otrqwGUeJ
         cwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786474519; x=1787079319;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PK5DpGIYIZ4Q5mypA8J7nQL3JpavjxnvYneVp4Wv71c=;
        b=iDmfiSkGwBg1plmOdSCqOQ04mm42Sns2C1pqZvE6yTMYT4Na0Kd7i2+8oVJ3lN6HId
         syLWBzBNe3clZrPAsnVxbxRUwB4ioN80Jn8ERIQpYRLx2kT0p4Zqv+IS/QNjFBgFtl+I
         JmYZVVju8yehGRzppmHjw2bitkGBtQFEyuHCJ7dMEUKZei7axO9trOigOcv3VCPFeFuo
         indWEZyNaUXKibYIvs8+49uifUbbkY+muZhOlT4vhGnPVULX58Ldx3cA+a6Me+Y9dGAt
         prgM1JdcsAFstqPl1wDCOnp1Bo446p9F3PYy6MX2bV9o45Dkg4qPtunbL3k4OFrD7tco
         5V8Q==
X-Forwarded-Encrypted: i=1; AHgh+RpkNKRZwEjHlP9eDABF8JTucL4x9rhneMEA3vu9v0/wehZSxlyZAJXgxObwWvmNL2H8as6erTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6OeM266pSKltuUhtUsExjuLbWHh/DSoflafXSZ3wNEnlltPg4
	gImir8qiD30jfhuvPJ/VLNsCVhZ3Bj+q20WivdQvvO0keoW4HuXj7tNA8xzrcYJvqcbz7dcnE/i
	2Yjri18dWM6mFOXabNxScGtAq6THOlJn5sk2NEgbC
X-Gm-Gg: AR+sD13eG4pCRDypW3aR87dhwKkeyuMhwQ1KO34B1hZie9eSOnVc0evaii3l9i1IA15
	SGfowuwkO25lQlE4Pn287QVbhsTnVpq6ZeJ3zZYUfDYyFvt66d+H+lb3SK4op9E8q77BJ9c1gwc
	YqO6/0kerG0bgZzxM1phmWK0BSE9U0yPNlHGUzcSbjWgezyLysRYL8hMky8gsfqHgNoWLNZvRL9
	rkZBdEKEONLpOaJh0xSp0dzcw9oydr9Oq1mHELm6yR9wIUopmjQ3LxaMBQWwD83C0EufjosesIu
	qX1pteIyLsV52c5OcqC3xeJ2w595DNpRahKGZZDDICNc
X-Received: by 2002:a17:90a:ec90:b0:38e:2860:253f with SMTP id
 98e67ed59e1d1-392ec53e6c1mr6200831a91.12.1786474518666; Tue, 11 Aug 2026
 11:55:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v3-76f117ad04f1+28a90-mlx5st_jgg@nvidia.com> <20260805183702.GA72896@nvidia.com>
In-Reply-To: <20260805183702.GA72896@nvidia.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 11 Aug 2026 11:54:50 -0700
X-Gm-Features: AUfX_mzn4PfVgkS4FrNbhoBz42phR-uhV7z36r-0P3XLSgGGUO-8rzrUFVLpZk0
Message-ID: <CALzav=f5oUW+B9RvOyaRGtG=6CX_4g-2Di+obFZ4O6B-chZtAQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] mlx5 support for VFIO self test
To: jgg@ziepe.ca
Cc: Alex Williamson <alex@shazbot.org>, Justin Stitt <justinstitt@google.com>, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev, 
	Mark Bloch <mbloch@nvidia.com>, Bill Wendling <morbo@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, netdev@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 11:39=E2=80=AFAM <jgg@ziepe.ca> wrote:
>
> On Thu, Jul 16, 2026 at 02:03:16PM -0300, Jason Gunthorpe wrote:
> > Add an mlx5 driver to VFIO self test. This is largely a remix of the
> > existing VFIO mlx5 driver in rdma-core. It uses an RDMA loopback QP
> > to issue RDMA WRITE operations which effectively perform memory
> > copies using DMA. Since mlx5 has a stable programming ABI this
> > should work on devices from CX5 to current HW. The device FW must
> > support the QP loopback configuration.
>
> David I was going to respin this to fix the minor nits, do you have
> any more feedback or are we good to merge it ?

Sorry for the delay. This has been on my to-do list, but it keeps
getting preempted.

I will do a pass through it today and make sure there's nothing else
needed in the respin.
