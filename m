Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6223B2FC7
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 04:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781583471; cv=pass; b=dDgqV5Alkshaj+xwG3BP6ZE1/kN5Mt93gYE65O99uu1h3RhsQg0jOuKUIe1v5m1M6lSYqVMhIncEuqzIkcrL7OYI4cVbMDbFfBVqGM6JM829xDkJ2f/Q5BBNxWPfp2fjiV7Mj9fZiQfjoTeOH7BEl3O6Rv2M7BXtGvAAuQ06SDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781583471; c=relaxed/simple;
	bh=UDM9Y2Thjnqa8K+lbXnfW8bZvgfvx5z0YeGl85VJOIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lzIqb/KdATNu7/MbGMRWpSKd7jb1821BPw6/XK1iB0OmCHzMaoh+DpgvunAP44SEDWI6v3wX5m6YKAr0KtxaeEgpOz0J0WwZKMHWWAylyu+0TsIyEnxNo6bvtLmiANhVx4Yil59LmnGRoGoPfoe9fZts027uItW+4cL6h3c9gdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wi/gPJIN; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wi/gPJIN"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8ccea53f35cso52313136d6.1
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 21:17:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781583469; cv=none;
        d=google.com; s=arc-20240605;
        b=kvKFea5jlg6a7Lg8l8xrj8QsDsQBlEXbla6EOAxOZBuSP8mltomtgkYUdvHnl6en4V
         Yn3ZBBHhEy1YpGHrR2ZZ1fTLBpJDgW1CTlMJPrVi4nROXw4/jJfnzYvtY/OKQe9ZKtA7
         RdGm7KPvL6TMcm4iNqKt1RcjNLj6C/gVrYEXm0I8E03bdTnqkFK2rdMTG/r+g9opslXK
         bUhePT/zxmKvcGzYAazUjrt1gchLD2zVd5gRTUqdTZZyuL7gahbU0bdvSqcChAKngXL3
         llg082Glb1b4Gde+Ev2tye6BcjJSko/EVvaBDsEiYOsdX8ItVDtEnTqvyppWUqHD4BlY
         kOhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c46bC46uTOFVqkvQFgPWAgxQbVfvX2mDmBYTQGj7PhI=;
        fh=j1Yb9VKL3YYlaaZym6beZyfjf2162eSrhodoPO7+Ok0=;
        b=ENPLE8oyC1yk2JZf32RhezgIL0WAQCI173d0OKTuzyqa6TvhfMeCMVQV9eJY1bF/Tw
         LACzZ0n55PgkdI3K5QMbCHzF5JuFj1gUOA0AJCckdNpXC3SZJJQukCZVuAatuiTubHUh
         6o6DS9wuP3dMAHMijvjhcv8r55iNi1BVMPNULH2mFZxIDqw1cj4mNgaqJXamV/hDg1wI
         Of1XwbFt8MPh0dBb8saL7lIRTHm8FucWTW7C6flyDfrJEEv15Gi14IdU54lk11f8g00M
         XfLasxCKiFoLMqmXXGkaU/dDfr445PT91eHY9qvYPk2RohgAv3z8xG+QqRvNKKdxbK1H
         xs/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781583469; x=1782188269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c46bC46uTOFVqkvQFgPWAgxQbVfvX2mDmBYTQGj7PhI=;
        b=Wi/gPJINUEZynzRG0s8wVE0qlTVMsvjsu16XDuxjNONko5WX2hqUHfVONZPatBsY3N
         hHJ4aN9IQARYICQ2gW6uPSUw7ETsdfPOJy648bUf9WE49CrbJLh4WgCDARLBONx8oRHw
         8IxfL1WmKi22DuNqD/MOhrRNXPpDpDfIYtnTJHnbC28A+v3MUxXqWDFXOhFHA+gNqprv
         m79BMEktbJajRhuxu96mNVgSxu2+xihxuchZ6d8c/NH276QqZ6ClFA8kM1KGYd+aKXT7
         Y5pCgsbZICwdG9mwcJnnyHWqkWRGtGKKuX4W/UREXIFi7tEQV0dLlamyBUGtlx3qKAmt
         ivgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781583469; x=1782188269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c46bC46uTOFVqkvQFgPWAgxQbVfvX2mDmBYTQGj7PhI=;
        b=VmaQxamJJciLhFlLE6buSXQYeZmNK47juqfIxLNDozUaDQt/nYb0Y+eBuEPdoKyR7S
         fRQZziIE5AHU1a/fqM7nR3cAKcxwDd7A/38iBaZveE7ZE7nhlU9rLBoIuu59fppJOmn4
         RyZUq3Eu+cpLXPkLqjvjA3kHBOtC0QndO6wHfOLzVFg3lIBCiAkqRfw4LAeaob8+Tx2D
         F5bXdz9wrcYeY8fhIbTbPIeTgoJD5c7WKZkPNN0wmqkC2fv/fUkiaM1YLZOMDPOIVkxP
         j6aH225nNX3uxdZp+q/nRH4mk9MxLXNXKrF5SFhcW/DELAucPASMG4vCggeksxjNQZRx
         Y6Vw==
X-Forwarded-Encrypted: i=1; AFNElJ8ae7gzL00gfUGrrIZ6U1+ynCitlS0IsmS5IozPdIZVHICqmT1sPmiZcUocDj8Uz7H2td5W3I4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBym29B0vt3FIi6Y9xgEjvZOQDrNfgbdi5v0KEPLqDku17V5ho
	fOynjik0mBdwa9aKmKAX5yWHfqEvHAbt4wDHR/mFD45G+yi0YuG3KMgxsnVAUbsJenaqvGECq0H
	N1BPYHqBW0QRj7RHFc2hvAQFIGyJK19R5brvwpQRQ
X-Gm-Gg: Acq92OF1tQX4PH4rGCNuFcNx6iHuy1+hgf6gDwuu2frYsu4PARDWd3Xsep6CFQN6q07
	t0nQDKHGTTtxpIHJaIzsWbB5C8VZyWXvP1rTeEDxImEt1Wgi/7ZGKG0n3AqM/cAG8BH0M1DBB54
	ySHDzTgZF/Z3qRSMTUUa2MyLq6GAEgwunLMnBrbkSILhimEtLaEYwcq+l5ljGkvkX3/qT0ByMAV
	k37komelEadfuS/wPC7efdwzeVBC4MhH5BkFysfDMX6K4uFFtM/+OSNB+3i8hAt2YE5wDYKfqJY
	mujsa+XzkHt7wZoUnB7SGazCwyTeJaw5rMHUtUaNzjZ5ZikTxoa6rAyKKS4gCS+ay576rWVzG0/
	e2dOg3znv3+isZQxy70SgcJXZShKy
X-Received: by 2002:a05:620a:1a07:b0:914:e3dd:17ea with SMTP id
 af79cd13be357-917ee4d8a24mr2288565585a.12.1781583467792; Mon, 15 Jun 2026
 21:17:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615234220.3946885-1-lrizzo@google.com>
In-Reply-To: <20260615234220.3946885-1-lrizzo@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 15 Jun 2026 21:17:36 -0700
X-Gm-Features: AVVi8CfmRRXK2sLRb18EI2J6HVHIs23OmkonKcsJiFmkB68hhvaCXbcTPeeXIKM
Message-ID: <CANn89iJabdK5rDpZ8NEXY=_hF87dpjqksh4SRruGnZ=pReKTiA@mail.gmail.com>
Subject: Re: [PATCH] swiotlb: avoid double copy with swiotlb on tx socket
To: Luigi Rizzo <lrizzo@google.com>
Cc: rizzo.unipi@gmail.com, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	willemb@google.com, kuniyu@google.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	akpm@linux-foundation.org, david@kernel.org, netdev@vger.kernel.org, 
	linux-mm@kvack.org, iommu@lists.linux.dev, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 4:42=E2=80=AFPM Luigi Rizzo <lrizzo@google.com> wro=
te:
>
> The use of swiotlb causes an extra data copy on I/O.  For tx sockets,
> especially with greedy senders, this has a high chance of happening in
> the softirq handler for tx network interrupts, creating a significant
> performance bottleneck.
>
> Allow tx sockets to allocate socket buffers directly from the bounce
> buffers. This avoids the second copy and removes the above bottleneck.
> The fraction of swiotlb buffers allowed for this feature is set with
>    /sys/module/swiotlb/parameters/zerocopy_tx_percent

Strange name, because your patch targets the regular tcp sendmsg()
path (with a user -> kernel copy).

Typical high performance RPC libraries use TCP TX zerocopy these days.
They won't benefit from this idea.
Perhaps you should state this in your changelog or documentation.

Also, what is the typical size of the bounce buffers in your guests?

With standard tcp_wmem settings, each TCP flow can consume 4 MB.


> (0 means disabled, 90 is the maximum, to avoid persistent I/O failures).
>
> Implementation:
> - define a new page type to unambiguously identify bounce buffers used
>   as backing storage for socket buffers
> - modify skb_page_frag_refill to perform the modified allocation
> - modify the destructors __free_frozen_pages(), free_unref_folio() to
>   handle those pages and return them to the pool.
>
> The savings are especially visible with fewer queues. In synthetic
> benchmarks, senders with 1-2 queues would cap around 50Gbps with
> conventional swiotlb, and reach over 170Gbps with the feature enabled.

This patch is too large; please split it into smaller functional
units, so that each domain experts
can focus on their part.

I see you test SOCK_ZEROCOPY, but some applications setting this flag
can mix tcp sendmsg() with or without zero-copy.

I also see your patch missed CONFIG_PREEMPT_RT case.
