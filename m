Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746733C456F
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 08:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786955892; cv=pass; b=nMeiZlJpzmr9Y+mARPEZoaDJBU61kvBTSuVgfOQOb6g370ayHm3TNmSDu6rCviCVWzFvUnbiJjlEn6tYggtrFtZk9GocJVfYH+JGiSLgt1b0rTvzf9VGtCPXzq3ciVZKz/N6o6ASAhv4J6xqOTqADoEejI5vXSFV5m7L5p/aH9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786955892; c=relaxed/simple;
	bh=O/XhqaCKsiemBXFRL2OQw4tPWjlSYk+HCWCHQ/FhTHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XYaSopIeYMDpuGVKqF/DlXvJvwILqjTydVRFYMWIaiufapSWP8qxDXcgx84zX84kSKuUwCkHadC1BulJAucFug0vfWrItbCXkWaY8yA9gkLR3BWp80uRBc92GkDb977eQhMQodWIpdUZblWtNSyqtHlFAo05MS2tSQhFV43/g+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eJcIVO7M; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eJcIVO7M"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c0cea8883so23236811cf.1
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 01:38:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786955889; cv=none;
        d=google.com; s=arc-20260327;
        b=KLO7QwaJH8bE36nOoe8IUSLykc9jZXarhA5F8hMkyP7TIUf/bBEY8ftiKw2pzkfYOZ
         B06QhN3/bV0xHYm4hSbGcsXt/yx1lcsCO8yP3YYWQQr4DiujtcJuWzH37S46r8VcNbGQ
         i3gKqQ3+EfWcoYKoyR3BHFdachXBE4CaZ5NNdq2OEBNiL4yd8WET6ZT1vmeGk7JxRpMT
         nzIfctulrMq2iNTfIyhOLed36GyF7ZWxmDjdG8WpE4/vfvU1IycXhoa9rTH5i6lzq9j3
         w3yAYRkUSRh3FpXJVjJLTGrBgxKFRmu7hUk5pb/Wk3GIsRQlk2/SU4nnBVKBKlGWkxH1
         lh0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0EULgvHktSYv21bTY+ANYkQSlQ0oTpYwcUqQk4gtVCs=;
        fh=focxpuHkokiTL1kuC5hvyZw6PNLnSkhNR8gOpQlFAAU=;
        b=YqyZOlYT1gb1P9XN+wZh/6JJg/5uA1K640uzSpSLx6vQmLXTJCa4ovzR/XTerRSMOu
         uRANbYO7kQfDjE3H50MdCOIQ/UGzTTGaLHmx7wN++koRJRXHH1muktCXe1mZJcZSCAde
         6g0WAh17zP6GelqMLVhy/K6GIxLQ5bipXI4WRtUmyvHW5oIIZ/2jhA14n9ZYagJFQsXT
         hz5whT8AA5cVSqmb0gHVYcwpoRmf7/6oNyMA9hixGPgbFvp8z1YnCb97A6LOJuoP4wMJ
         fKxJS74r92+Wp1boa3vEALA9SiBaRLRiSPGvNTisIwCHuuzemmzENu+qzAjnHu0g3JyH
         laKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786955889; x=1787560689; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0EULgvHktSYv21bTY+ANYkQSlQ0oTpYwcUqQk4gtVCs=;
        b=eJcIVO7MMfwQGhRwuFTSy6CPOC5D5hJzd558fkZDJhBtevUOrWuAsc4S8FJnQkcbVf
         416a5HQ+THYmws02wy8bVzFIHuNpt5kVmcDE9XnjBNEYuh5jymDTLBG1t6qpSgXu3dnk
         EHFYhaz+5goVtVJ0ZULvGiPoYze2vq8bRha8FSAVp+T3+kns9E17p8i+zj2WYE1UDpxv
         AbKaBqV0iyK6L3N8zPROTikx+RU4YysKtCerJdCDzWwXI+XDFiP06a2dHgn2kgaXISfU
         n/vDXoqWFnJdEWF1bCw6Mw58xmh9NKLt0je1bKM0QonCYiETSoSt2JKzTyENg876dIB3
         oLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786955889; x=1787560689;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0EULgvHktSYv21bTY+ANYkQSlQ0oTpYwcUqQk4gtVCs=;
        b=m28TEFJIAHWC/76Mu4LIZWn022Ax75D/i9ukvuops4+TG8l+qILoxmh8YoTvy/0Puz
         oVRRjT5su4XQqrm+KshBnhM2QnHhE59FacmtwXojgQvimfbC5CYWcGd3+NLdVgyXLQtx
         tR11Czcefcf12O/j46JwtqclY5qB+9lkgobDc3gg7xvapognQB6HducqiRITa2KzI1V1
         0gfPbP3wPlpqf2oKhxini2m4nCXwBR1sXOUeDcM+m55qV58V/JnEroRvQjgJ0FYCN/Id
         r9fjbOh6oZvfdWhlZNTA0ueZY7YoSbADPsHc5unjNBHk4n/aTF1o0iL+v4MZqLA8TdUi
         p73w==
X-Forwarded-Encrypted: i=1; AHgh+RqHuyXAxB5bwVftmqfvzEk6mOAm8A6Hr49vGrToM8ILvLshIickMUqJA7W575aFVGw/VM4zVwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJji/1HafR7vqxhc0Lkfl+V1zV0hO+MelXTqMz9KWN5yX7Hdj8
	WJtJa+FfFkqQaQG5d5AHtpqwqd6xHWVyxQ/HT5Ap1DLUTcA81HX8lPH9ndPTSYsfnLiYP24nNby
	qtAqYpk8MKP82MdgZy2c/GUCA7L2153iyB7RyX/f5
X-Gm-Gg: AR+sD10BuUuvBzwrpp5D6usB6Wy/Rikp5SpGuSngsmvekP6FEcVyaCml0AqsOPRsYNA
	nD4NouF6zKdePJK0kaGwVMxC6FTksdps0k3xjKNJdcXgU5+Jh6UdkVd+xFYrY/kxjswMmpHT6vx
	DQqOuzBQwO1am9NYKKz9tnsuGGd9kW2c3zv1YbrhcY5iaz34U0FdO7p6lFoEB87HmTRrYsWdQba
	DqR4XTrgxU/1VeaZMZ+J2toCvbYTwe+3y9cF/9Xv3nWuIDzvJV0gV1BM9qFaQlHhnM17dMgwuwZ
	HvTjJtFhRPe1oD4aZvGLyFiMMBlSBIqA2ssohQE0cyCxF4lGjwT49pqmipQx5j4L2t57WWZMohi
	rNCQ+OdSbWdc94lazi2t/9ocPnH9O5H+f4xFVOvfpIz9vCDiz+2rzXzMPCZYUURYB64xxcH37qd
	DYkyJLyZJPo4MFLoY=
X-Received: by 2002:a05:622a:34f:b0:517:146d:2cb5 with SMTP id
 d75a77b69052e-52d74ba1d1emr291743311cf.20.1786955888710; Mon, 17 Aug 2026
 01:38:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817-bond_rcu-v1-0-acf067cf45fe@kylinos.cn> <20260817-bond_rcu-v1-2-acf067cf45fe@kylinos.cn>
In-Reply-To: <20260817-bond_rcu-v1-2-acf067cf45fe@kylinos.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 17 Aug 2026 10:37:56 +0200
X-Gm-Features: AcwNN1XQe7Euw7Fn4E_y8Cr5hcEKVSG7Moi8yBdN7Upvurwed3MfD4a0VtMHrdM
Message-ID: <CANn89iLyiyRM4K4GnjuukdDhOWFiWWjuS5aVbP-u8iPqPxZtEg@mail.gmail.com>
Subject: Re: [PATCH 2/2] bonding: 3ad: use RCU_INIT_POINTER for rcu pointer initialization
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hangbin Liu <liuhangbin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 10:33=E2=80=AFAM Hangbin Liu <hangbin.liu@linux.dev=
> wrote:
>
> From: Hangbin Liu <liuhangbin@kylinos.cn>
>
> Use RCU_INIT_POINTER() for initializing port->aggregator to NULL.
>
> Fixes: c4f050ce06c5 ("bonding: 3ad: implement proper RCU rules for port->=
aggregator")
> Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
> ---
>  drivers/net/bonding/bond_3ad.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3a=
d.c
> index 196830fca4a4..c4dfcafcff26 100644
> --- a/drivers/net/bonding/bond_3ad.c
> +++ b/drivers/net/bonding/bond_3ad.c
> @@ -2075,7 +2075,7 @@ static void ad_initialize_port(struct port *port, c=
onst struct bond_params *bond
>                 port->sm_mux_state =3D 0;
>                 port->sm_mux_timer_counter =3D 0;
>                 port->sm_tx_state =3D 0;
> -               port->aggregator =3D NULL;
> +               RCU_INIT_POINTER(port->aggregator, NULL);
>                 port->next_port_in_aggregator =3D NULL;
>                 port->transaction_id =3D 0;
>

This is a NOP really, the object is not visible yet.

pw-bot: cr
