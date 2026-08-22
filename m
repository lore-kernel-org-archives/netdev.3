Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED89D331EC1
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 03:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787370837; cv=pass; b=YWhJWppcx3Y5RfZxxVpFIxLuByL05HuT9FscEQ/QcZ6Iz116UN4sm5WbLTu7vHwuyRfb0XAC9Gjua2s8MyXi/lyj7VbZX00G5LtrdNabzQtdZYTdaODTM5NqX7yzjVN3791I/8sEvPVm5i2YOYcHcciuuW0ZO963U1UJa/n49oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787370837; c=relaxed/simple;
	bh=FBLlXD3nW2JnUX368mUZaO+/9xbIDSHvG6hWmeMOSIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i84TsbENiPxOGbTmcgedgx40fBAN42K6zZ7Ft4f0G+OPTOeBwSoX1AoyQ2MhSVCoK6GXxpxM70mT/6j8xsGc3bEEa7gypKRGsx1zYBhk7wrhxOQ+mgdy4DRj54bFmrG8CfqOxfJ1H+Uqngwh/egB9LwtWRCPMUzp6No03vcchsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4i7LYqJ; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4i7LYqJ"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso1866982a12.1
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 20:53:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787370835; cv=none;
        d=google.com; s=arc-20260327;
        b=b+sF12KEOUoLfUyokPLb1HNFFb/soYqpupqbczlFJ/Ol+77f0Fyoyo+GgxJTYh0T4M
         0xkWHLtBBcueN7XRXA7GB4GEUH+ac0/ZeFL802WhUWrbWoEjKBAbj2e4Eo32lqhaR6zY
         mMxqSYTmFEGgeqgd83iB2CL7fZ7a/h3Uv4QcQa+R7z4yM/GRbkJFs2M9Qh8HOj4lMtel
         BoDTH7RwMQw+fSFElxgxPehxH4x4FWE6m2HM4bbm/tQD6hrvpEjqse+RbgRDKyb5Hhfb
         bcngxmneVkUxALuP4a1mi7/e3WUG2xyH52LoDvI+NR3ukuiTGPJQsm1IikBP4zLGBkCo
         VVHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kG+MMYz+aA1z8JSTD2QnV706OsWOXs65jjB0XOhH9kw=;
        fh=H0dJ7pDTPwiULtstRFsEM1jOiMA3huKWr35xGexDRUg=;
        b=IcL14Zj3iXaDdoyqCmVbI/OURDPS3loK/giEp+/JqgoQ66/DnSnEmA2BqX746llKCO
         NDwN/KhMHCZrF6n10Q4hBfhd045tNsVw0ErLXozdQiJEzIuwtbApsPWcQ+8TYlQW6nzz
         R6VA6+5lEzc5eMaX9AYK4THuIdebC+cdHEWVlYKARrgq0we//NsF8mhpwdiJMxyL/YUS
         eeBWhnfEjr35SiG37NLL/p+heO9vD47OAILezpBqrvk74MA6pQgKsLJKWr+B44+E2L8+
         qbnhWNmnK2MSG3bIlOA3tqFzW0ZnerOc8yQZAgfZLCu3s/tRyhIANL3kZz2w1POsg+kG
         hUaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787370835; x=1787975635; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kG+MMYz+aA1z8JSTD2QnV706OsWOXs65jjB0XOhH9kw=;
        b=e4i7LYqJ6v4sP1QiqCWyq/bI785E2ChslQ7U0a2Eeigsv3Rm3V7TqG4waG/0fJceRv
         Repd6kzS+GYiFVO7JCKkf64QDcNpoHbH3H/8NEAXuPJoQxb3oreD4exM4/5AvMqGWue/
         z/uPm2hp3uKu9EfxxzkMVhHv99j0aALIcjQc8lE2HXKhNRqMIAoJLzw5080hz01IoDG9
         eJqt5AnR0nHkOKtkLdEqmd6PKry7oC1kFJr5EssvUuE2ut9qu6pi+rKLUW4oY1wmX480
         yUkP+XId6P1QqbLaUIo2lrtxs+lera94VXnsLFkGosY4Cz9glp7z93/OP81Nnlzu+SjN
         CuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787370835; x=1787975635;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kG+MMYz+aA1z8JSTD2QnV706OsWOXs65jjB0XOhH9kw=;
        b=UXQf3NlcQEq/OAxJR671AyhAKoAginjjaQrqY6jLZIQI2vnQUniP2+0ZSrY+UJX/PF
         eBSodsQzDgoxDMpHPICOozS9pUDR0CRkCfLHky9kF5IWKkhGMG9wQANp+L4OwoTcS57z
         VmtGlQAIaJWxg4Fb3tO5dv41IvIRqSbNBO9BXufZs0QM9AMl/iMCTRYAxfK/D9/iP4p+
         pVa0hZR2oNWqIiYj5doS6lkEFz3ppjQSq0RYz+z1uOtztxHcqx4N7dgLeVkyvivthi1a
         j9ZXAe0JX+FD0soOCk8o8/GsvceS3/uY57xIBzgjevJ/K1xnavSeEqiA9iyXpqRWZz6e
         rjaw==
X-Forwarded-Encrypted: i=1; AHgh+Rop/bvBoXJ3WYU/iWflGlvm9xcrl5GGrQhUeYTTNtjNdAnQnDLWTjjG8vCoHDSr75k4f7D0H3o=@vger.kernel.org
X-Gm-Message-State: AFuF++m/ZI9HGSIQdrKVwe4RhS+EPBFGihkSFg1AlGQIR3mymUUPwUOH
	ZatrF6cDOxH+/0mXYkLMxCHCb2caEoykfJKsZbegGCaVoZIMlG4HcLIHHKKPtc+r6yHkR/xCQ7y
	W/2oQVajvu6P/StnSqkZZWj6Aph9kTdYE9Q==
X-Gm-Gg: AR+sD10VSSnA7DHlR9mCx9vxybTRQlOPv+guVS4ezxkSbjcv1MNrZRPR3H0FDcUeqJh
	t4kQZzDiqxpFjpAb4z6m7ZwDYf9VqxKmEXAiRv2K3pvE05pQgx957QaKk1N7LGHCOlp46TYhi/H
	aELEJmZwzZXSH6vwcUKJdzKkN/UPdPAwoYX/dHh6xAm6dMZOhH6C9pd+flTbJKm9z1CIVN/zeqd
	yh6G9hIbEmdiRy8ikzAASF17wmV7tCu+17yf87Wj9T7kj5tNnNR+22+xAU5qNejXrr/oTfYOXDI
	CdbreJ3WdXhA2vVHzanetUmadg9cVxu/it2YA18R6okzoWRM0SZ8aYmo7dpLbQzqRCHlL0PwuC1
	7VzvBu2PrkZKmGz6xz9Xn56Sf+lZaYA4qhjD0dYPpfZ/47wwL2ajMkczzXAuOnzRzgP/3rsph09
	y/AuFaSf26yA==
X-Received: by 2002:a17:90b:268b:b0:38e:42f5:d096 with SMTP id
 98e67ed59e1d1-395c4528324mr9786023a91.0.1787370835140; Fri, 21 Aug 2026
 20:53:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821153823.266343-1-rastislav.szabo@isovalent.com> <17fac875-ce43-43ec-9e9d-329a09d4f3eb@kernel.org>
In-Reply-To: <17fac875-ce43-43ec-9e9d-329a09d4f3eb@kernel.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Sat, 22 Aug 2026 04:53:43 +0100
X-Gm-Features: AcwNN1WLQWXrst0z8n6URjzDOc7pdhpqlp4tZ_xrj6_SYGttebBw04BtAfWe5IE
Message-ID: <CAJwJo6ZBA5heLxJu_xsYFU8Vm-2SY8ONV3AZgDJse9oXAfqB=A@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/tcp: fix TCP-AO key deletion in VRFs
To: David Ahern <dsahern@kernel.org>
Cc: Rastislav Szabo <rastislav.szabo@isovalent.com>, netdev@vger.kernel.org, 
	edumazet@google.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	shuah@kernel.org, dima@arista.com, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Aug 2026 at 19:34, David Ahern <dsahern@kernel.org> wrote:
>
> On 8/21/26 9:38 AM, Rastislav Szabo wrote:
> > TCP-AO keys with TCP_AO_KEYF_IFINDEX store the VRF L3 interface index in
> > l3index. tcp_ao_del_cmd() validates the supplied ifindex, but does not
> > assign it to its local l3index before matching keys.
> >
> > As a result, deleting a key scoped to a non-default VRF always fails with
> > ENOENT because it is matched against l3index 0.
> >
> > Fixes: 248411b8cb89 ("net/tcp: Wire up l3index to TCP-AO")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Rastislav Szabo <rastislav.szabo@isovalent.com>
> > ---
> >  net/ipv4/tcp_ao.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> > index 5094267447ae..26864621e6de 100644
> > --- a/net/ipv4/tcp_ao.c
> > +++ b/net/ipv4/tcp_ao.c
> > @@ -1834,6 +1834,9 @@ static int tcp_ao_del_cmd(struct sock *sk, unsigned short int family,
> >       if (cmd.ifindex && !(cmd.keyflags & TCP_AO_KEYF_IFINDEX))
> >               return -EINVAL;
> >
> > +     if (cmd.keyflags & TCP_AO_KEYF_IFINDEX)
> > +             l3index = cmd.ifindex;
> > +
> >       ao_info = setsockopt_ao_info(sk);
> >       if (IS_ERR(ao_info))
> >               return PTR_ERR(ao_info);
> >
> > base-commit: 746fc0787f616da418ffc04a110296fe95d53491
>
> Looks correct to me. Dmitry?
>
> Reviewed-by: David Ahern <dsahern@kernel.org>
>

Thanks, David,

This is embarrassingly correct!

Acked-by: Dmitry Safonov <0x7f454c46@gmail.com>

Thanks for the fix,
             Dmitry
