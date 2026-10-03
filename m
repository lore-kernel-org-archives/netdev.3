Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31B92737FC
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 00:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790988863; cv=pass; b=imCZQd416EBNcxmaYWgLplMFCiaupjieeqKKF8B9uxHy7+gFZwiDd2jC+0fOLXyB6KgQTQHy4j7z/xwLbOzcRYmjZr90eTH3DY9pahGKdHW93Gr9Qy23ZjaIxnvrek2GJn+CyZjjBQyz1wccXgbjDzjhWud8kFd2QYer4rL/o4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790988863; c=relaxed/simple;
	bh=ZVQBnQo/eFh06vorGcqF1KC/7SENgnUf6N9nm8JGWSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BnBJGkbefk6SQEGupx7iLiyj5iJeJICHt2ad2CzsMfxP1wnH8TT81pbHv1h6zHnvs1sD1VhBIh4ZFmukBWiiMwyHwCx5Vub/aiT5UaTtWJY1o1qJDUeEohbNL7ebxOc5pUlYhPiRd+3/v3WvHfqBdzObk70ZD7wZApm9cYuvff4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aconHeI3; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aconHeI3"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d8fd7a3f38so13035ad.1
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 17:54:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790988859; cv=none;
        d=google.com; s=arc-20260327;
        b=QTSnDSZQEJFAwrtEw6tGKtYqUkD5Od9iFVX5lFRRZSO/fGrLLuWKGl2zAKId8H2BYv
         p3zas57472in3tqbsEMQfRrE7aS7HPo/YoxRqPcOeD0eCMZes9zFgVhy8b09lGTXwfoH
         r/tmUog2XNtCCkXX02Q35jjIG6LXB8eN/LHYiVO/EILAKeFEb28yyfmoFrDK3P5kAJcZ
         cTmS1KVdjy2+f/YF3fCSTkvu/gC8MfVzy8AmmEolYTu2a4QzyeytKIjKq23gniRMX4Ay
         shS1HQh4Iyqc73RtSMjPanqBhmrq1+kdNgrXlljG6UgnR4pQnmUSG5VmTXvbnoYtVYNY
         WsDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WEp8X+PRKs7nUSCeaHUChoo386upLZKNHaOGRHgrf60=;
        fh=0llUh96Eej4QEzdzNMp789GuVHjGkHCWtxOm0CXxNAc=;
        b=skhV6B/eino8c/85xYYMC/eicD5L2/Fj7EwmPXoqYlKg80HcvScl43cCDO7+A3rxJm
         eWNyLKzkEkZwZYbNX7eicHg8Sq450SE2BUxWO1ByRJ5zaA7/x1ioORJbhuQ8ckZchcRb
         2O3djz6W99AnEHtixL2T+RHd0nv5lYBUygIgELNHQ9N/9DDgCbSn48UXzBcSJ7tt0MTa
         JEY21l4xBBrr2kjSgFRL7rNzjV3/gKV9VfTdwri4cdxrSWg1UAMNGFgJFPLwMewhDs4m
         kTfmlHnMvt4kj8bXjrLTJ/fBq5/MNJIsJ/WTBmBrrnbBbEGHdPK8eu1IcLbtoDsRhKWG
         l5Gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790988859; x=1791593659; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WEp8X+PRKs7nUSCeaHUChoo386upLZKNHaOGRHgrf60=;
        b=aconHeI3/hgLgqEsabadPOGMQikGcMYgxzJo1eATfENUCkwfHRnL5saJJvuJ8Xvq+6
         GID3ZNFQScvFV0X7+n8DFVt1Gs5KQBN0gUPWVfR45sL3+PFD9Ywmllkxb+zmyewUdFZZ
         ufR/10yGa6vWq67h+akc5q+Zl5joYXKbzB/Kl2cOCwZDAF1Y2iRGHOg4hfWJPEsL4IAG
         /Vje/YmSiBrbdnI2T4qyNTFKN5YkUOGLRXFDY5yQnbmc/wr5mnqScgCMjOMWzD8XxZ+f
         b5drWA1L8SbnUzA2UiYQQZWVUWx8NuYC/qmmbyME+NQMrlMRr362H02TuglD+bHF3ulD
         jXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790988859; x=1791593659;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WEp8X+PRKs7nUSCeaHUChoo386upLZKNHaOGRHgrf60=;
        b=sMVfJxjV6ttJAk4j45UfBCacynEGULKarX3BhWUcOK0v5fRKV7W5cz9hyq+J6RCV/v
         08bBMKk922JyU8nKinGiAAAozdbJuzv+lMWYQ5AzcGCK8eywfxpec92QL3j8o446Ri9e
         PTRUCbKu45BOQJlYAwi63NloB3ysTe/7RVx2zgwAaKMXSof0CH07hgsmvfHfH4bFSUHO
         KTtIW7TE71sWwSEHY2LJHLnCmwoi55HA6SRS/RnDAHFgdR2gqUNZKRPVZ700+X2Wm8qu
         6NC72hsV8hcFe1JlGp1AVedakHCU71khS1s4feA/h8PM470u7xMx0jMtAMKTB0yvCcGu
         lgCQ==
X-Forwarded-Encrypted: i=1; AKwUvBw1z9WHgyxYfjk1zwAL0x2/yyiwuGiHJMwNTDnWM7BmhEc6HJvhfxkhd96v14DjXpbDeO9OOM0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIWQPi015ipJdda2KFWb68Ymsx4DQJWndhl+ntcbN6vqWKL6/ej
	saA+zFLZP0qXU8lDZxIyZdA1dvEIYeoiwirazL2DiYfKofBsraKDQ73CAvj+Ne7pq+H7P+m19VQ
	hevBkwtEs4zmw9iYLhNXd8mb4d8dteKZnUWSAdCJ0
X-Gm-Gg: AYBFou3XBxGSq1EA30Vad5y/w3X3MOVJ874Pmkl2nO4UtdyVsljdQNiXFj+REc/NfBe
	A8XmOgCALNE+FXVwq1UnXt+NEX5meIoqTuMeGSNsdLGmibBw9KYxkTa7roNfwIrf2eLz1Er7h60
	Olo/qhXNs0vktaCnsqXpDmQtDWWafoExjNvhk27ZZvWFuK5gCN7A2dgaLgSEgVwisKj82FnxvYs
	y7p5ZfSWQfRncAJCr2a9aG27BOaDm4pKucoRropYybb12BaaKrVXxXStqoHPeaJn2qNso6RSEIv
	XMnZwe5anj/oxTyXl2um/kKX9AAKpuhjBFBmbrr+v6Y55YY8Dm2lSS+t90sKkybVrYU0nJP5uk1
	k6PqKSw7/FxPMrZJmGagq9alDONSkDdkk1ADBuHYnsfmsodauSZAwxg==
X-Received: by 2002:a17:902:ce8e:b0:2dd:3a08:d47b with SMTP id
 d9443c01a7336-2e5339f93a4mr1143425ad.13.1790988858220; Fri, 02 Oct 2026
 17:54:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001-linux-mpnic-v1-0-6422ee74233a@gmail.com>
In-Reply-To: <20261001-linux-mpnic-v1-0-6422ee74233a@gmail.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Fri, 2 Oct 2026 17:54:06 -0700
X-Gm-Features: AclHuK8ouJgcRlucOdN3eH5_YugyE8t5pnHL2laHJr6qeoqr1Ko3b7rLVQ6y5Y4
Message-ID: <CAEAWyHfyamEKdRa6PAjEfffq2Xw1ByF_g_jpmr=Kup8UJQY7sg@mail.gmail.com>
Subject: Re: [PATCH net-next 0/4] mpnic: add NAPI buffer depletion check
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Alexander Duyck <alexanderduyck@fb.com>, Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 10:35=E2=80=AFAM Daniel Zahka <daniel.zahka@gmail.co=
m> wrote:
>
> This series provides a buffer depletion check to unwedge Rx processing
> when page pool allocations have failed. Patch 4 has a more detailed
> description of the events that lead to the wedge, but the high level
> idea is that when page pool allocations fail, the buffer descriptor ring
> can run low, and when that happens the device will drop Rx packets and
> not raise interrupts, which causes the NAPI event loop not to be
> scheduled, so new buffers are not posted.
>
> There are three setup patches for the depletion check:
>
> Patch 1: convert writes to BDQ ring head and tail to WRITE_ONCE(), so
> the depletion check, which is not synchronized with the NAPI event loop,
> can READ_ONCE() those same fields.
>
> Patch 2: introduce the driver level service task that runs once per
> second while the netif is running.
>
> Patch 3: set the minimum Rx buffers needed per packet based on page size
> and max MTU.
>
> With those in place, we have everything we need to watch the buffer ring
> head and tail positions from the service task, compare posted buffers to
> programmed Rx drop thresholds, and then force mpnic_poll() to run if
> needed.
>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> ---
> Daniel Zahka (4):
>       eth: mpnic: use WRITE_ONCE() for BDQ head and tail updates
>       eth: mpnic: add a service task
>       eth: mpnic: set Rx buffer minimums using page size and mtu
>       eth: mpnic: add a NAPI depletion check

For the series:
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>

>
>  drivers/net/ethernet/meta/mpnic/mpnic.h        |  3 +++
>  drivers/net/ethernet/meta/mpnic/mpnic_init.c   | 13 ++++++---
>  drivers/net/ethernet/meta/mpnic/mpnic_netdev.c |  3 +++
>  drivers/net/ethernet/meta/mpnic/mpnic_pci.c    | 21 +++++++++++++++
>  drivers/net/ethernet/meta/mpnic/mpnic_txrx.c   | 37 ++++++++++++++++++++=
+++---
>  drivers/net/ethernet/meta/mpnic/mpnic_txrx.h   |  7 +++++
>  6 files changed, 77 insertions(+), 7 deletions(-)
> ---
> base-commit: eb0c18404c8943356f4aa164e5db9067b79ea93c
> change-id: 20260929-linux-mpnic-428998421ffc
>
> Best regards,
> --
> Daniel Zahka <daniel.zahka@gmail.com>
>
>
