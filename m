Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE31306746
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 05:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782193873; cv=pass; b=KjZHC2X0+YNhxivpCxzzSeDhyFZdxJeN9m2LBWc0c/eBOlFbj7juEZQANUNEbWYGcf6E931yyv6ZZ9QfTDb4ZddGONjVBBI2V/WBxY1beSKEuQ+52KsFzi0y6O5zrko/OMkZ63sJTkegEEkxaRmqwrN75Iv1LPjAF9Z1KRm+lJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782193873; c=relaxed/simple;
	bh=IUNvuZf91lad4iP980g9ClhMYUALj9mv5VIwYN6g8+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7GtuJf8LfSQDWXiXF7lqhBNIGJN3zOWF9RROw5kJvWdM3wPDffn+AlkExPTCkTRZ/+5ZNwDl+jRAwzkK2LuEATQsG/ggyT3vN1I00YI5zAJFChDj81WAb1XkGTWl81rXO9vP0Rgg0Qj7H05LiOPy806lT4K6RbnMndKaNSvI3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BeuPjRpr; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BeuPjRpr"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-516d0db9372so42390741cf.2
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 22:51:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782193871; cv=none;
        d=google.com; s=arc-20240605;
        b=IbWJPpL1mxl7bT4+Rgw3o7JhWo5S0liz4aJTuJqbaWsiM7DQFw4iPSFgsm1kHkDHOw
         NV1LTffurmLDGB+YVIBjEiWTL9sGig6aP2FXxGY8HLz3So5JkjOUsP5Z3GNwMT87Bjdf
         xK4dHLM1Mw4xeKSPtjt0PZh+0BiGGKo7FRznyfGbavvvWW9TyUhca7xpCM6FeNKDv6O5
         eLdMobpYX+zcgiSSqstmyHqnAzi2DGKqEj69smmO1kDZ31rlOkWqkTVurxtBzrftYafZ
         MDNBavgnhdO8XproLM3RP0WeiA/JnIqVSXT2OPrD7FQwMzqEKUohWtOPm7ARAuLeooGW
         U4Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gz0cOtr+Us+wZSO4QqOuJ9usqoqszN3hmAILauOaBc4=;
        fh=Tq23LtVWppyF3cX4kCWTV2FpFwNzCor3dG6+7DJAcE4=;
        b=NGrMDupyQAyRfe85GCHPPEfKqaW/w4YI8ZepJr7ZrV9SzUkjC/17KBswiBh5yRdh7u
         gZ4IXlOaoDAsOtUi/pJRIyJ35UiQEOVmeaA7wlkZ+GcECbAK6QInW4Pkilu+dMOGiWyZ
         AwqEbHhM1LwMskda2PKdddgiGlcFFR7GuuZGIjGe1S5L5nAYhfPF7NW5Te2rZwl5w/fZ
         RCElP3Dsw/0wveXJmNC7eG8aE3yaOOqEFzRj6RpAN0JPOE4lKiiPXay1LJkK1CK21OwG
         HKO7JdA/IX+eCFpsWYhY4UtqwnvFU73jRxsUf/kf2pVzdVuyYe7juUrl1kXzL2CJeYdA
         iahA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782193871; x=1782798671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gz0cOtr+Us+wZSO4QqOuJ9usqoqszN3hmAILauOaBc4=;
        b=BeuPjRprV3+we41fiMhlx6SLA4cYK3Bz1sGvEIkNmRwvMSfS4HdBt4VjLizfbpTIkI
         s4E2uq+KULS3lmUjs137HMGZ2WTRMPa6cqxM+tPh36KmuzY/I6r/6wbraVE2+XzG7U3O
         64x0dvsVoL61e5HrHWC1sYSMkDUE5ee8QV47xK349PGt5n9qYx0AfZySS8V1td1Gm5IU
         RcIG8+eIU+p6WomrHLCdG/JPMuff4ERr8sVR4u/QNqR/mwPMsuB5RhpYiCg2eL/8mvVF
         uuIQ56ZmLKAZ/7bYVYURm0vKHl+KuGNNFpqiUWspwWyzK49V3zEJkEV1LvhL7gFyQj+K
         0OGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782193871; x=1782798671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gz0cOtr+Us+wZSO4QqOuJ9usqoqszN3hmAILauOaBc4=;
        b=lzjhrf33jQEk/f2Ki248batKvZGovrxBHVT6KWg8ieyz5h84vYKIjP+cCcfkbzHmgS
         1Z03gHYnyLAFeP/nmHtSTnlfrnPy12W7+6JGx7p9frDyZ7PCXIyLfdgBaYfQEg8uRIoQ
         VNWJZMOr7rb0xqi9p3I2wdZDlxmnJPiDaT7Vw1ffvWhsmKtWag6KoGhzD6uxi5kiCpAN
         kCPVtO9QThvCLumeER1IKVvMvFL7sNOz8DrusWIYjZtzSmI8ruJ2bIxdcF8YV0UlNi11
         Rb4AtWTP6BhbkDIoiuntFb1Uj72wxcxeQZC4/MHhekf2qP20cDn6QCVmRwblXLeQ7Ghh
         myow==
X-Gm-Message-State: AOJu0YyhJcPZXJ5298ruDoIb1DNOnXAiBOB84TeNLfW0RlSpK6sZsQbu
	nHUwkv1eHr1VUGOVwpRAQ7xnnKH932FeubZeQjU1B4W4GyNnRwclp7RABI9Ua/LlkmSKQroZZH1
	1VZYkcVe1kmYSF5gd1NnpXCWMLvkTgO/QD22WucsA
X-Gm-Gg: AfdE7cnleMpODKZDM6c09szhy9IxldRqIbWbcX8lCu8XAGvKC/xFeS3lQRH47LGFi67
	7NjX9TIhksgZaATN1upokImiZ7faWnWaOE6gSwngzgYmf/yRtEqciY8qFGXUEV3IJE/fRadav0B
	s0ACry7MRtImDJEBa2+NiwFzkEgUtm7Q+x/d9DOwCkdnscUBFbU+cglFy5GHc0MDCJCdSF/4/jn
	R3PYzoBYGhiOBNOXKa+v2/dqSs9VQizGl7QI0hqrPhECHmIBuKApD9S30g2hPQKWn9opHsWDCrs
	QpnZSabS7QvS1IvcU70tXdJXghgUZl9YeFpAAyC2XhxCm2wMCIeZsIEWfiQrJSc3mTDVR46CRmZ
	dcs5Y7Gs2
X-Received: by 2002:a05:622a:190e:b0:517:8d24:6500 with SMTP id
 d75a77b69052e-519e4bf7edemr272892601cf.32.1782193870406; Mon, 22 Jun 2026
 22:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623015208.1191687-1-eilaimemedsnaimel@gmail.com>
In-Reply-To: <20260623015208.1191687-1-eilaimemedsnaimel@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Jun 2026 22:50:59 -0700
X-Gm-Features: AVVi8CewAkA60aCmgRFsz_H0_OXUnZNiugJpfNsSgv_GDvrrSksrfmJPKuwaigY
Message-ID: <CANn89iKQmOSJWN0h4uRs1-SLKc8NqfZ=UbbcYjYTsF9D4tV=FQ@mail.gmail.com>
Subject: Re: [PATCH] net/tcp-ao: fix use-after-free of key in del_async path
To: HanQuan <eilaimemedsnaimel@gmail.com>
Cc: netdev@vger.kernel.org, ncardwell@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 6:52=E2=80=AFPM HanQuan <eilaimemedsnaimel@gmail.co=
m> wrote:
>
> In tcp_ao_delete_key(), the del_async path skips the current_key
> and rnext_key validity checks present in the synchronous path,
> assuming these pointers are always NULL on LISTEN sockets.  However,
> if a key was added with set_current=3D1/set_rnext=3D1 while the socket
> was in CLOSE state, current_key and rnext_key will be non-NULL
> after listen() transitions the socket to LISTEN.
>
> When such a key is deleted with del_async=3D1, hlist_del_rcu() and
> call_rcu() free the key without clearing the dangling pointers.
> After the RCU grace period, getsockopt(TCP_AO_INFO) dereferences
> current_key->sndid and rnext_key->rcvid from freed slab memory.
>
> Clear current_key and rnext_key in the del_async path when they
> reference the key being deleted.
>
> Fixes: d6732b95b6fb ("net/tcp: Allow asynchronous delete for TCP-AO keys =
(MKTs)")
> Signed-off-by: HanQuan <eilaimemedsnaimel@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
