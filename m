Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC3B36897F
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788623363; cv=pass; b=QGY+7dGDhX0jLJrONnJEeO9AyYQpZ/ZN1T1SqeO3c+V6EQjEei+7BI9FidnUTdHQfShqktaJzUeJ0u7+7zUsVz4NULe+V8M+OF2Gu7n1JwAtg/LnhGZ8a4+qGOxHZOzNCHYPHJxtBcihlBkuVlzyh6P9HYCFAOyx3s1nuk5U0lA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788623363; c=relaxed/simple;
	bh=2LwFOMHYcHPNL5fcYnEFfP+h7yQAgL85lT+A0zfsnu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wkhua1rjgcorhQNE/mYixdEEjX7N/W7mjiL0jM1fFnMgih9tq/1iPE72BA+necndzaA5BPMrlRgmwgx2nDfdI+Qw1pIK1QPMJCO4yIt8jtcTDpD7lVFTEKVYYA8zDua3KG12b6huEVM2IQydW+BfN9IZDJ0mIFhzqMTJHwGRudI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=Cc2KkhV1; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="Cc2KkhV1"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39f20d19895so16367481fa.2
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 08:49:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788623360; cv=none;
        d=google.com; s=arc-20260327;
        b=b0XDKmTcNQEIjWLojEaJc/Siu39MZpWGpoWW7K9RvJeLIPHzhrlJw9hcGD5dyjXaGk
         kfxjOx6OQqM4658kxdOXHdxEPa8aV5q0J/VMc8bLPeLQnoKsKWHVLQhS580HQeJqaVxp
         rWC8MI/tYGp3ereyz6CybnvVw+mQGBGENdOeBdRS4k57ocxGZr6OE94Ko3vp1tc1RA+N
         WzbkVSFzzaa2kfWRWpYhiQFAxNa4/GiJV+PywE4awNGhxGCARI3WTaw7hyopbz2cR++O
         U5fxL1aXLWuQmb0HQ6SUHc5FWzbvFAGzwxu1gs5zBniTh7HD3PDy+Z7xnfTAElwaq1Nt
         1TzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7P80H4tHjRKtSyI0SMuxw7P27fwaqKXH5g+cij3jlRc=;
        fh=t4FCq4otXgaZ3pkejIck03b+fW5jvnX5IF1IQXYZG4o=;
        b=VupKzqn7ztMwSQzJaZIgM/I19g7eVV0YLnUiIL2zfnlZshLe6SRjpz2ErjCMYTgsm8
         SKsbiIrEeHPL5taVEYZnhU1PsZ7NFz1CrofByliqWi7GY3daKnc1BvVmTku+qyihFIPo
         VMF9fYuSiN76boA0jdSr41crBv8Mv7QrTN4vHDRoNUoAsaglDsMMRDJ510K/LSfjmt0J
         UzUXzCuPQsb0QYPfBxOXmmMmGfbhur5VWH2Tw0tfSX6+vCluLfB9/wjoNLN2I1AvKzk3
         evRU5CZp9gCLL1Yx7CapSuVFJxc6KvyeL3otBzOeeF8vgKI/wR1JFsEmZowyeS8Tg73c
         s+UQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788623360; x=1789228160; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7P80H4tHjRKtSyI0SMuxw7P27fwaqKXH5g+cij3jlRc=;
        b=Cc2KkhV1j+/18WC5hFEIUMGnWkUluvOifIbnfB/BiExKK1a0NeQB9NP8P1nWLvIRqQ
         T2rfWqbjnNniAmkm2sqnP0aRl9XQx+qxFtXty1LjzrShELKmiELlQmgIn5PsuNsFzXqp
         Av/1e0AOe/tuyKe8apb9iB5ALThFvoPyIy9Go2huNDRTm779l0Nn/NRDVJyXBfHJ1BrP
         7oFSUW1UhMXgx7OFyEAY1PxAPsoL11yEy6CLxxUwZ8EzoDCD3gf6T8qF8j+6JL5dUKWX
         1w4K6nzf+UGqrx0iOQBSgpW5DJq44zfnIigafTokLeFpYrZJEXAbbJdQBSYbjahwZCrl
         7tXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788623360; x=1789228160;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7P80H4tHjRKtSyI0SMuxw7P27fwaqKXH5g+cij3jlRc=;
        b=hYpWwZXoH0Bem1eOZEqGXD1xWHZ0fXwLsc8n/n4qNqCwzhzQyL3pSkOGQIiTRzdb3j
         p0oWtH0YLMVVc4od8vYg1p1aWAiU79rwGBzNqOyTg3g2b8cxBPmWkOmfWhc+RlI6ZeR/
         lWkadzp4ecrugJqQOSq02OVksqlwkpeUlCUeQfKhLy0A4Kg6ISwNfAD0qx9mmEtB/Ufn
         1PrmxEAmuaMrVkNmTovQxtHnN5kPdU70CV6pvp/425gyMKUEvp2mndMn+0Xlv6igqo7z
         dA/dQNzHRlr/7r4Kcl3ilabpZhyKsjfQqj1+4uDgFY9GQe4a7xfNiULrDSx18tUwHOqp
         uRyQ==
X-Gm-Message-State: AFuF++lD9bBt8ALTjfLLLGjPfYsba+lXBFxZG5UN2ZRC5pToJQv+J8AZ
	NJ40HbmHIKTVxck97MMiyzR6r/F1X0YrUzT0JyEGpqFYswLPv9bi6g7OSBpF7CV8eyw2sZYA9i7
	WEYoqJqEudWJLTPnKcpRaZb+8QPxygO4AzLB1SjuIWDw=
X-Gm-Gg: AYBFou07aAKkOV6qAK9fGl+w/Q+xdUFXhX6XBDaHHLf9EWGz71LSQXywt2V7BRUKbFC
	Q97jzRABeRCLtQoM7gdU7Ph46ocAsz7A/LBrEZ6fQn/csJ5CLIhH8G/7nb4ogyssmiLjuyY2GrM
	Bv6W4GX5tA89TgQDur0EchEnwprKHFyNObxoYLxeYRpVM5VLoZVjtB4flyed31dt5qRjz5mHcj7
	hrqwWow+9CLZXBq+uzlqpv86T1bpIRqKWYSa93Wyqtk8xcHK3SVqyeq78Mk62uDTiHdUGXGAcON
	oW0QcppyC2zTl/40EqwF7w4S3Q5B9z1q396BAB+QZ7BeIYol1a+rPhhZbD3JU/AA5stuvV9tAHo
	=
X-Received: by 2002:a05:651c:19a9:b0:3a1:b1e4:419c with SMTP id
 38308e7fff4ca-3a371baf690mr14631721fa.10.1788623360266; Sat, 05 Sep 2026
 08:49:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <133b6aee9e2c908c9da37d5585b3d2cd016906cd.1788187473.git.zihanx@nebusec.ai>
 <20260905151227.75099-1-horms@kernel.org>
In-Reply-To: <20260905151227.75099-1-horms@kernel.org>
From: zihan xi <zihanx@nebusec.ai>
Date: Sat, 5 Sep 2026 23:49:05 +0800
X-Gm-Features: AcwNN1UcU-1X1BFtOnvDk5MJ1fV5cvayGVe7JghclzXcqqZSvXM9lAAOeXUWdos
Message-ID: <CAANe3eRpVGnYpygfiQTsXd2VmBO43P-P1RfREkdDypgXBZB9Uw@mail.gmail.com>
Subject: Re: [PATCH net 1/1] udp: diag: bound bucket lock hold time
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, xemul@parallels.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 11:12=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev/#/patchset/133b6aee9e2c908c9da37d5585=
b3d2cd016906cd.1788187473.git.zihanx@nebusec.ai?part=3D1
> ---
> udp: diag: bound bucket lock hold time
>
> This patch limits the time the UDP hash bucket spinlock is held during
> netlink socket dumps by collecting a bounded batch of matching sockets.
> It takes a reference to each socket, releases the lock, processes the
> batch, and resumes from a preserved cursor.
>
> > diff --git a/net/ipv4/udp_diag.c b/net/ipv4/udp_diag.c
> > index f4b24e628cf8d..18cfe0df654dd 100644
> > --- a/net/ipv4/udp_diag.c
> > +++ b/net/ipv4/udp_diag.c
> [ ... ]
> > +static void udp_diag_dump_done(struct netlink_callback *cb)
> > +{
> > +     struct inet_diag_dump_data *cb_data =3D cb->data;
> > +     struct sock *sk =3D (struct sock *)cb->args[2];
> > +
> > +     if (sk) {
> > +             cb->args[2] =3D 0;
> > +             sock_put(sk);
> > +     }
> > +     cb_data->dump_done =3D NULL;
> > +     module_put(THIS_MODULE);
> > +}
>
> [Severity: High]
> Does this module_put() introduce a race condition with module unloading?
>
> When an active netlink dump for UDP sockets finishes, inet_diag_dump_done=
()
> invokes udp_diag_dump_done(). This function drops its module reference us=
ing
> module_put(THIS_MODULE) as its final step.
>
> If this was the last reference, a concurrent rmmod udp_diag operation can
> proceed and unmap the module's text segment before the thread executing
> udp_diag_dump_done() executes its return instruction to return to inet_di=
ag.
>
> Could this result in a kernel panic due to the CPU attempting to execute
> unmapped memory?

Yes.  If that module_put() drops the last reference, rmmod can unmap
udp_diag while dump_done() is still returning to inet_diag.

I will keep the extra module_get() in udp_diag_dump(), and move the
matching module_put() into inet_diag_dump_done() so it runs after the
callback has returned.

v2 incoming.
