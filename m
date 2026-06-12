Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5A23F8ED8
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781281927; cv=pass; b=YQ8VUhgm1BOV5u2gFr2sjXmsGfbvAgCS9PEr4Psaf7Qrzk97YqznpWfwai+ucUpmgICdp6ihjd7FJrMQ17FkK7dqqUmd/mUlPHThcb2Eo86SUmMcdXUxCFqnRFnxKCBbvJ5CdlZpp+PFj1alfKdhkkHcoq4Ya4uJCy/boaYl9XM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781281927; c=relaxed/simple;
	bh=+qmqcCRl5uyZLH6PlzbuyrV/GICV7dzb6vHcxUzgEo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kdGdR2wn+8+d4AzbdPOYmeGm+W9FT8+7NPQXPESCXQC6EmJH7jUAhSKuSslJO2bXLs61y+1wiLpstRSJM5u7DZh3DZGsrNTAp1yd9ah/00LVYmSn1Ii1Dg69MenDvA/NtX0251cNTfPJ+04i8JLl92puefi3d/HuyK65ljqh3ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fSg0rgcb; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fSg0rgcb"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7dc93d02916so11572547b3.3
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 09:32:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781281923; cv=none;
        d=google.com; s=arc-20240605;
        b=hQCgqxJy00uf5m2kmZ5Z9pjN9LN0yeZe+irTMe+m9dJ7Rz8U33QQsnmJA4b5CFT6y8
         MNerfDY/rdcLFNGcBew7+HrV2feTQU2swfnfHer58KVexXwWrunE6SzXuXMbmy8mprIL
         S7tO0lWmLPf4UU6h1YjeKmppDzX093ysxOCmB7JwBG3sIMQD3gWIrL6mebm20yBSLXm/
         tMhh12xiJIyxyzgYFqMzNrrFOd3SMaK8w3rVVqul4O8pw+yPU6kcwzFZ33wKnaBPop4n
         bGgcmZPbmjHG4qTolxtX69lSbbH6Rr/AmjSuHMs73og+QxNkz2+LuiMzbr2x7DauDzj5
         mniw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+qmqcCRl5uyZLH6PlzbuyrV/GICV7dzb6vHcxUzgEo4=;
        fh=g8Xknp3xC+XBQv1vKY7M9bZC0sPo6KJANjxqVp9E8Tk=;
        b=T2mZU6PtRc0ekXiuGgm07FqAZ/gX4IRqXiWthHJiN2yetCWOs6fl4ETGFqvUqoV9gX
         fu6m8vAKL1rkfyVKScB5h+E0If8MchHjnm3DanX7i8ejKIKoiixW8Tm2O8LlR5twpqeJ
         xHLAi+9iOm7WQHlzE4wsIYPPaDc7vA9EtxKcDoCuW1+gTyJr35WSTlyMQw7lw5gLn2pV
         RAXpZat5/iZLUVkIKPE9nwzGprYhL+NMzM6qLhzhDgCWEj5bWnTOiaysn6Rv17OxLDpA
         phShwkriaO0YpiOLATKrO7HdbYYNAd7nfhmiRC8zBdsze0HSXGbBAur7umd2yQxoNcgw
         gihw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781281923; x=1781886723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qmqcCRl5uyZLH6PlzbuyrV/GICV7dzb6vHcxUzgEo4=;
        b=fSg0rgcbwN0GAiJ8REtJqC1jUPOuWoppN/0KRMrVeVTSTGGcJlfaVUNYvRLWD9I01M
         MvOas2Uv6XecofRglDodbRP3oRDYgTrP84haSvI8r/XckApcFR50Plprh60GLGsi77TX
         UJRX+KQIcnr8Z3ejfZX11Bs8VEjducl3sW6RLY5RTqWINfQCkpt/yH9VRFFogjDkhRgi
         ftUTpmT0/OoQ2wGb464zyjNAjxu8EpSp1dU6jBXpfID3Nr/YfeDL/bhnwrb3pOMGMMym
         qq1Y/z1YkAegva7H25jtEQUJpLxKYlv2DkRO7FzFeJ5Aq0J9sDB0/H5/aQYjv/BnqIA0
         gdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781281923; x=1781886723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+qmqcCRl5uyZLH6PlzbuyrV/GICV7dzb6vHcxUzgEo4=;
        b=G/mKhliCYG9RJoBmETexTk4gT32PVuRSWNUWwavflYTDwgN2HKTAOyh77kcNCfKiiq
         5/gpMUBSeYhoBogbBCMJR3Rz5OaAQEe8jVfltIxwCqn0Odi+n2azpVhd0kRZS7GmZ2ks
         PervogHJvBElL1Ah2zacwhdMNiX83o8Z/S8Z7jZqe66wYMh9WDvy+qDp65ly78MRmOoS
         LROeJ6UkU/UhPTtZDjsGeeMTU8qvHbHbXVMwJAt5h1Gc/EM9MMmidsmyxqxBv6bJaIDl
         b5hL2Oz+xeDwHi1QGuwsIaX9bmyVJJ4vZ+tXQUECRI6qRyEdHWZol5A+4SDZtiKr+slb
         QIBQ==
X-Forwarded-Encrypted: i=1; AFNElJ/DnNeAxem9fEkZfStWOOvujXxueqCF2aQSJ03Lyui6oZcbKrZQgi0F56PTT1dH9PptPFWlpzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWuY2eBGIt2SslcdJJSSQuylq98CxiByT2YbF/B46M6JzX23Gb
	o/uBYZuoH5+guEaLvuhCFPOtpzrM0VeK+goIhsswb+oV1xPSBZHhX9wwxV7/GxnCJZNWN8GVDhX
	OGblQW+igACmrRd6dctE2JVHUGpB7771GB6v8oIce
X-Gm-Gg: Acq92OFnvvhNYxMNIEh+oNnj5kcAIopOBgVi1g9OZwLyoSoc5hWW50tjgwxhHANUZWU
	g+cIRE5FPH9/S1NDr2Ve3veruk7De+jMEYztejcFaVMJR8L08a5EG2+5GyW7vN0jW4WXaKRP0i7
	yuINfRax9k2Jl2NTivS+ThAn5V15MGSOmoF5YJ/puZJ026mhZIBlHpH16mBoQ/Xdr3pqHVx7kxP
	h5dv1moKYFHmUxjRdEKfFj4WV7ddcsyW+HJbqMVt+5JEUf85mqM/FACZep4NiwqUG+qFAIi3mcM
	c3mx6rT3OpP1QZsKHyiYCXnyTZFVL5M0wFNmHYzW0MFrfqq29/X4he4Ul0Cb0IZKMTojizeKXwL
	NI7znp8Cs/VqHYRdhODUI
X-Received: by 2002:a05:690c:9685:b0:7f8:7e11:d0d8 with SMTP id
 00721157ae682-7f8c47cb667mr2630257b3.51.1781281922812; Fri, 12 Jun 2026
 09:32:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611165247.2710257-1-edumazet@google.com> <20260612162818.GF671640@horms.kernel.org>
In-Reply-To: <20260612162818.GF671640@horms.kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 12 Jun 2026 09:31:51 -0700
X-Gm-Features: AVVi8CdqUJ7B_bXkeXKnE1mHKGseMi8Xe7-3Ad0Pq2TGUIJlZ9mpV7EFsBmyHCs
Message-ID: <CANn89iLw_wT+fqYNixYiTP4y14R5YeyZXXhbOhSTvvtKris_3w@mail.gmail.com>
Subject: Re: [PATCH net] ip_tunnel: annotate data-races around t->err_count
 and t->err_time
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 9:28=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Thu, Jun 11, 2026 at 04:52:47PM +0000, Eric Dumazet wrote:
> > ip_tunnel_xmit() runs locklessly (dev->lltx =3D=3D true).
> >
> > ipgre_err() and ipip_err() also run locklessly.
> >
> > We need to add READ_ONCE() and WRITE_ONCE() annotations
> > around t->err_count and t->err_time.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Maybe this should have a fixes tag?

Ah this was meant for net-next

We just merged into net-next the IPv6 equivalent patch.

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/=
?id=3Df6033078a9e671e3c8b83d387b91591a6f6a54e7

Sorry for the confusion


>
> In any case, this looks good to me.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
>
