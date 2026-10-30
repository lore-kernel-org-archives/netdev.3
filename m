Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793342947;
	b=AzaW87jziZl8dzCYaK+Ks85QEE/2QtNwalofa9NJgk9LCBBB9QPAslVBz/6W9oxSqj7Q
	 0Qjis3dlJgbhbaVVfmVUowEo6ceqL3nFl8deXQkXNSXuMUa3fHwoo5lIYtkfxpfNqCBF3
	 Quqx8WztHUKFXvlZnADGZmmzaXFKgzurDqilcvf6F3crkmsaqCGnjjodFUDI3YybxJ5xb
	 LhsV4kBQlcttn8rw5gmegJU0DvpeWd+Dif1wjRm/e0mEkJ6o4k4orPopDfXCuITj/OhJ/
	 eG2Fg8VqSAUTzPWQF7ohnxIPlE+oNNhLrvWrDsODHjQfnVF1V6caGaqQESVqcvVOJJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793342947;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=ihZJvFVo5qA9bHBSjqRZ6mMHlkTfcms3YLDhCt8pbv8=;
	b=Ajn29h6hxu1/DMm6V5GTXb7bnb9XprYDEQuwu5sW4od/e6cIj/NmO4QQ6iEtELK64Jhg
	 mmBHvXFTLONDK92zlMKHEv3CIOd/jj2M0/JbC9pRB0Dl/4DfpzvqGs0xoQdnlGGT7buhB
	 tSP+WZyLZpTDXtbIEe0aGg0kuohE9ytaQbaimaNbAYdY/dxHod+QHAwhGXjGi/VtQa2ie
	 L+BLlGMLX59YWOau6cCNLn0pUUfIQOcn3pZ5u7f0gvgffMd7WUfvOyFYBZ00MqdfNp0KQ
	 +KgmfLrI/c4olgRIMry9XQMDsGRv7sMEfBMnsLI/NJQK8S4EIIMU0RrGEXJw3EctDpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AvSaQaOS;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA34606A321
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 06:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EA34606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AvSaQaOS
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3662e7a9299so1834054eec.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 23:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793342946; x=1793947746; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ihZJvFVo5qA9bHBSjqRZ6mMHlkTfcms3YLDhCt8pbv8=;
        b=AvSaQaOSZCOjDhrd+clfjgDooA4JmUDAyaTu+YgkbqGjrLqMKAA+Q/0E3ZG3iHGl9f
         PoZXL8AVr0fv/+zmZqXGmeqsEV1w2wdF+8h3PyNl4mxKY5L0HdGxRlrUNc9fPWJvFlD1
         VWrnAPcnDY+brHFJNcx2mVEHiECZG3yq8jPPf7omfYSx5RTwDwB0qVzsyYuJvxzwhKUT
         OZJunlFKbZY2NQFgr1S1qf4m3RYm9e0kUrIRzxajcumRL/rrnZdEEc4jl7hJS7VuYgEr
         BDDpFqnIl+KTscZVSvq4r+POHR8C/a1lw7LMnNca3W3jZP3zbGAHFYW5dZup/OEnDw5g
         b5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793342946; x=1793947746;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ihZJvFVo5qA9bHBSjqRZ6mMHlkTfcms3YLDhCt8pbv8=;
        b=eE6E5Bp/qT8aaOJPJNnunVPexGZ+B77cRpvvsLuUou4dKWDgp+DmNfO1rvsguWmGsy
         uGZkoy37yQRNG2SMmboKgflIbmOHDiSiLkYnFNuORpMsxwzPIWtIAItNahAbaJXlzqXR
         BrvO8EjZji+rm9chMh7fr8IzCCZu31h7qZQka8fik8+a5Ul467bxWzat2jfpp4niOJpT
         MAj+8l4vXjknDOrjszGJ2USjyHMGmLvdJDzNVw5whkFjv/jbB9eK7KeLZDcZJcOMyeie
         Ni3l2FoSekmt0MjJopUvVffEfyrUdpMgj10x+L3nNeRL2Ei/mDGziqjuuFWB7rsCLbqg
         PcDQ==
X-Forwarded-Encrypted: i=1; AKwUvByGJKXAbPd183CygCUKV2cDWjl7hIEZqgKhDWKBbSJnr3b8R4Q0Ldo59rgTNB0dEBrvQV/d9Iw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQ+7qJlkD1XlbMpNvSqFpCFj1Rp5EFVoR0XK0pm9UtRCyFzZBY
	qvIFkv2tHwSuGqoyo+2l+xFF7/e6covdTo37p8EtqTqvX51yOIFhRIPGtyFHeXS4ighAbkyscLe
	DWywioYYoPpfzrqTnICJUUiQ/dQ==
X-Received: from dlbrj6.prod.google.com ([2002:a05:7022:f406:b0:1a8:2945:774e])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:2606:b0:13b:4ab5:41d7 with SMTP id a92af1059eb24-1ac55f2d32bmr2370550c88.3.1793342945214;
 Thu, 29 Oct 2026 23:49:05 -0700 (PDT)
Date: Fri, 30 Oct 2026 06:49:04 +0000
In-Reply-To: <179324296598.34505.11070163314749859668@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <179324296598.34505.11070163314749859668@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030064904.4149904-1-almasrymina@google.com>
Subject: Re: [PATCH net] netdevsim: delete ports added after a failed reload
From: Mina Almasry <almasrymina@google.com>
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	syzbot+88435e204734072bf39a@syzkaller.appspotmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 8:02=E2=80=AFPM Joas Antonio dos Santos
<joasantonio108@gmail.com> wrote:
>
> diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
> index feb88cc..a871790 100644
> --- a/drivers/net/netdevsim/dev.c
> +++ b/drivers/net/netdevsim/dev.c
> @@ -1697,8 +1697,13 @@ static void nsim_dev_reload_destroy(struct nsim_de=
v *nsim_dev)
>  {
>         struct devlink *devlink =3D priv_to_devlink(nsim_dev);
>
> -       if (devlink_is_reload_failed(devlink))
> +       if (devlink_is_reload_failed(devlink)) {
> +               /* The failed reload already tore everything down, but po=
rts
> +                * can still be added through new_port after that.
> +                */
> +               nsim_dev_port_del_all(nsim_dev);
>                 return;
> +       }

I prefer =C3=96mer's version for the reasons mentioned here:
https://lore.kernel.org/netdev/20261030064245.4118081-1-almasrymina@google.=
com/

Either way, since this is a non-critical fix in netdevsim, it should
target net-next once it reopens after the merge window:
https://netdev.bots.linux.dev/net-next.html

--=20
Thanks,
Mina
