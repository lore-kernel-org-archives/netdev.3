Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792495727;
	b=J4jyOIh1cfx7cehsn9l+bkPAfPXw3/MFP/r2MLTd4wMDHLvgDfVs21Opfjo49T9FcWQC
	 b0LvR3QNNqIgeM3j/J6Uz+ihruQ4skiD6UvtDgVhyVeRjkH+ZW7exsKLbG8xmLv/1nkYg
	 RY7pQhg5FMQzTmst9Zl3UoCu7jiyWjuX40Sm8DVYV47ihK3wz01HUv63g6PNVm8Up0nS8
	 CtvwnRvIERbEeEdFjbEWuU4l+dU7PML+mEyLY+/9D0OAw1SydY+60lbpJmF5A1l2DLSLO
	 Dir2PXp9zN16rysTKZZ70istdbMxWYe58+5CVdfysFblag3ioskmnKaM5HD+edH3QCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792495727;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PZiLc2FJzquG5xUHmScRfMBdmwa5Roffly8SX1z9Pgs=;
	b=sDOZVEdNyEbUG9FVvBJVN4R6pClplKlN6ZsabNp+lVdY6wwJE0gBJXwIXf3zlzL9UPyy
	 FdWtpX1cSZqhypeHcjixmoKcqh6VoHADofloJnkunQ2UVgyxftE1d88TdutLQV3NSkE0I
	 nz03nwpw+iPJcoRhRP9akAYQFdctXIWIl/qruZONWoDpGtZdMRj4MV4vWLB4siqxCSoc9
	 hmxYsa7h7RAWduGEPNWezLj53hW6GhYxbP51eJxByTA5uzPdzRdjfWnpTotDrCShodBHM
	 e2Xhr4ZyoTDxo0S5d5wLPfI8zk51TzhikixbCXSrErlcHU7jZFdKMupLuY6YLcir2Mg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P2zBV+vR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B327E606A31C
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 11:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B327E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P2zBV+vR
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-677dbe051d4so2740920d50.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 04:28:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792495726; cv=none;
        d=google.com; s=arc-20260327;
        b=qO28BZSfhl12YFyLvhSi11cS8cBWqNPbpePTlMj6dMDjcwA79vJ4Faho0b1iABxaHF
         90V+oNMWh6T2tN//cbHYEpseipErDGMVEmxyVRwpDqvTJWh+I2kjVs2RGS9bIwFnpFtI
         6Bl3cY3llXLAa41KXWzkK/PmtKjrUd0Oju3wxPfUJkQAwlcrsiUAFRqc3UwRUD5sszez
         ZsP0bMmDLE8zf02wvDINuv511p086wAHGYGwVgky+eAGrNvg8pcqugiQmnfgIab8YF/Q
         xQkBKt9W/eVkUWuJxItQiVEw2jfMl+GTLFd6SCTyuX6i0EZxNQc2wZLkGXvZlbSdIKWc
         Tdyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PZiLc2FJzquG5xUHmScRfMBdmwa5Roffly8SX1z9Pgs=;
        fh=hvmhsVN5gVborGQgF53Am6YL4SxFfPHy33uy3+w9zHE=;
        b=k2sGf0ckA14SLbqEUIXcDUKL+VI/HHSnd+ToJ0bkgIqVUJg5B4X7Z45zvaTX5kyXnm
         uPneGG+hRH0fX5dTa48/RnyqsGdeNeNbMSUTP9g6C4Q+0fSfIAdTKoQhm4UgKlaweGKH
         W3G1F/uJJyT0++DWrW065C8pA3rXB2laxR2ObZ3M/jr4VKtvIieS57YR7GobFAD+ZTNw
         Okf7P5kbiTy2Xa3UdVlRNm6LxBSSxLT9VfeHVLeR0vZhW2YKBD46+QMQ0DbzQYoy2bsk
         Wv9dccdnkBGIwc00ynDB1vxCjKmEFwGIxCjvudoSUtZY3qwtH32KDrwroxuuSgo3y8qj
         6ctQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792495726; x=1793100526; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PZiLc2FJzquG5xUHmScRfMBdmwa5Roffly8SX1z9Pgs=;
        b=P2zBV+vRpL7UXpo9kRn0S/qjdwNQ38BibI9CiFXlpxu2uX9sFfuD/pqJeeiFZUDbgb
         aDfQhQBQ7gNQ28P6uvHm/apUrgkFkEnDEi43NIOQNjCIyJ1rljlXGi141sqBFBxLJ/Lf
         tFfIJZU9nI/et1StK2L48asHSBDXN/b9zXxxQRTO1gDOQdNW363J2qj5qgKmUSiGbZTO
         aG8cnwMhPlDTW6RNa2L9qsa7ZNJ0GjDXvrc7Y2SbbuAnKfxRCeZMvcgid2foI/UaIQ70
         BnnkaRNaU039kMxKZTY1v8ApNPXWT4zVNTzOxcOHsILG4Dfynk4FGSZ1yqsPTW+NS7mj
         4lUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792495726; x=1793100526;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PZiLc2FJzquG5xUHmScRfMBdmwa5Roffly8SX1z9Pgs=;
        b=auOtkSLsfjiRBEkU/LDkoYCd2msyQstuzFbf63YOLfO0cPGkWqp9JGFlQS/CXxroKJ
         tdyn1QeVSx7yddvaHwl+25hPsFPLW2s4xZjVV4rnfLM+HptdyOdyyrHnxacqIKfTf+9k
         r16YRYEJIwwXf9tuBW9teGg8/r86SWzboS8Q8Aq1TtuIiS/FcXMH4isxEdT7o48bCZqY
         rMEZ9hbSpJkRVTd/W9Z5JmCIX36cAbqPVxVrJJxLz30U2CeXlLCKby2QSJkB40V1+b6J
         70BQuAwSHpzTr1BrSqa4eRNbkG2wUse5HQjdI+gUpMFSYFGkbxtcpPhvZQjYtObn2flb
         Yixw==
X-Forwarded-Encrypted: i=1; AKwUvBy3kH0uIJepIeT9WZJgP548d9thyBValBo/Fs53VPT878Ozh6rqk5qPTckcYYCKAeRPQ2t0xiQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDK7QT9FJIWPrbbc16oacyfb63OZCfDV8wV2CxXoQa1Pal7z4y
	/oGF+XbU+FV9Sj9nVkLVg0+fIizATMiKLpxYeIEhbkjVqO9PUp/cZk8nvBCIN28JSkg22hhbZbe
	AOtClegND2Fh2t7/E8XB1A5kqnz0HWFw=
X-Gm-Gg: AYBFou29KcowF0wHFeKld+NjHLzl1kgXiTgaHtCYBpaObaOfxDqZUx6l6kWCw/ANf2D
	RRv3SLRhV6bDFqE1bGGe9Ci1uP9ZbU7afmPi1FGJCUJBJBb8NZRwQ35ty21G1TwkriiHIsANKuK
	fJozUAc5DayvsrIx88aDtNKDunVWdW6nOOY4FpyXhk9tX+wNmFmrlRxnBP4xqs0ERE9cIvzDNfg
	h51/afQdDY4AXxOoDxLtTYb5ZwwUwVFfM4OvrZ4SrZoHuU0JnLWHXW7zPevmsaEoM9NgLqKtRx+
	kTjUM8zx0hJwweAV8SCu8VkP8Uw+xyFeUopwDzXqxMmngBByoMp5f4ofmkIIH5JVu1WsuaWFfnu
	IbXfv9ujg
X-Received: by 2002:a05:690c:6604:b0:8b0:dd32:d6ca with SMTP id
 00721157ae682-8b0f21b39ccmr35306147b3.59.1792495725784; Tue, 20 Oct 2026
 04:28:45 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261012150311.555104-1-ekffu200098@gmail.com>
 <20261018151325.GP503057@horms.kernel.org> <327efca9-7df1-437f-8040-a244111d719e@nvidia.com>
In-Reply-To: <327efca9-7df1-437f-8040-a244111d719e@nvidia.com>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Tue, 20 Oct 2026 20:28:35 +0900
X-Gm-Features: AclHuK_T3LY9btY6nnZpWl7lP_oogPcSS-OenmwKtFiMhqPXy3keZX8vw6zZN-o
Message-ID: <CABFDxMEYVzfeVCy-BohLTTSrcuji43o0zd-nr7Nr8zqWcq7BiQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net/mlx5: Remove redundant memset after kvzalloc
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, 
	Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Saeed Mahameed <saeedm@nvidia.com>, linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Simon and Tariq

2026=EB=85=84 10=EC=9B=94 20=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 3:44, =
Tariq Toukan <tariqt@nvidia.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
>
>
> On 18/10/2026 18:13, Simon Horman wrote:
> > On Tue, Oct 13, 2026 at 12:03:10AM +0900, Sang-Heon Jeon wrote:
> >> kvzalloc() returns zeroed memory, so the memset after the allocation i=
n
> >> mlx5e_post_meter_create_mtu_table() and macsec_fs_tx_create() is
> >> redundant.
> >>
> >> So remove the memset.
> >>
> >> No functional change.
> >>
> >> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> >
> > Hi Sang-Heon,
> >
> > I'm not sure if the value this cleanup brings is worth the churn.
>
> Exactly!

Fair enough. I do believe this patch can be helpful to future readers.
But I fully respect the community and other people's resources. So
just let me know if you don't want to see this kind of patch later.
I'll keep that in my mind.

> > But I do believe it is correct.
> >
> > Reviewed-by: Simon Horman <horms@kernel.org>
>
> Anyway,
>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks for the review :)

Best regards
Sang-Heon Jeon
