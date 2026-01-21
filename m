Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05C24949E0
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769003332; cv=pass; b=ibePCgQRJJ4L6GY7X9xwm7M7w7O3twLGZA2IZ3zMjauBb+nJ1ilPokiOhju4bd8zun2rIwddcgmGX5oaJEyPKsBClpQI+eGoxvmFxVqtFfAamWQK6UXHn9GD20qhfOxp0rRK9N4eCQ4UlT29VC4M6j392ICxyCSIBAgo4EkDki0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769003332; c=relaxed/simple;
	bh=cP7+lodeQJW67tiROuU4iCdrxhUkaMFq+EWtWSOxqhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kBiV0C79OhIqhwrpczl/3/bMFvH0a0t9G5V2UqJaAx+OSDDdfZqI3yQsq5JQVGuIiD9eiOKUK+SVVU8y24SoVD1ofgLc42lqp5owumX6Y9Bflh020U+I/M93ghRc2Qa3Y7PJr01SVI14zSRl+OwEzchAdCDo1B+/pwfXKZ7xPjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jUU72z7Y; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jUU72z7Y"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5013d163e2fso66267701cf.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 05:48:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769003329; cv=none;
        d=google.com; s=arc-20240605;
        b=Zq6OHbKvjVx+js4BDUB6aFi8zhLyj0R746SzfFlnWMAC+diGT1Ixk2oYxGcLv4Svf1
         5X4IaUR/BYI5RLn1LpnLk2f/CWMM4El/bfyud94XqEupTm+RNJ20huxREDLAUllDT6In
         AMv7XjbyeR5eXNl+mtqM8HcqtT1JM5m8hV9zeQfb6xyFnrG/OywCLGLyCtSlpf1b/Bsr
         A+0pw/VKbTuyMuv6ANvBpL5WmVLX3BJVu09uGMJdkd48yqvBT5K8i3HrEWDPXWeuAqd/
         Hfx0ZYaPvgYiUll4ZLyTVXyUu2lrwZiPixV0x1J1tpKeqwFAid9q+WfHcFcN5xBKz6dU
         l1ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cP7+lodeQJW67tiROuU4iCdrxhUkaMFq+EWtWSOxqhs=;
        fh=IpzcrSmtkeKabWHPYZDrW9m2DQN4Y9K54CPvV9TpZ90=;
        b=D0nlMgX4W/PQLzSkJSAozY6mNkERBzNNYaS7Umqnohe7esixemn3xcuuycrWxJeWWG
         tTLIyHpzem8BImEv69Eb52k+8FUUXPFCY+CUjD7slLbKK/0i2/ADgbUmgzY3DeKTn3jA
         K8PhD1XIYtOcawjuKc6R02O24LL6FF+kzgQLIpqw1UIdE0aHJTcXWNHOMyQUIry5me8J
         F6kXgillyO1Oa//1DFGTgZo4U7LFKfe1FQej3LcU8rzsbK6bPHik0Tzkuq6j3ZpIhlN1
         0ud3qRFzFvYodJmhIyo/zNjy9F1l0cijPdFXWtvPOFhwyNN44UimV19KAZ7h5jhykpn5
         /6WA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769003329; x=1769608129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cP7+lodeQJW67tiROuU4iCdrxhUkaMFq+EWtWSOxqhs=;
        b=jUU72z7YCEOCM9xWJ2XbVh3EiIW1784rDdoT76xjfSYFNyP76lTfW01kQ3H+GqW2+5
         /MRW+mdG5xOlvuKlFUyfRvFazbVT4K1Rn9NW/baH7V0kk6Qubc/PtkCJtIu7PYo0WDV8
         WnoCSg3glYDaSlpF8P9ZldT/fKVz98Eas9UBYxVKUQHFVyeso/b8nV9YIIOVrh6d1t+R
         e3ZsdJVipteGdcHEUDUq9u5HtWUQY8vB9CRY2sbGzCiAAHted5GJ+Z9eV2epMzKZTwRq
         tiUtpU6nwEba9hdOmkvm1A0Df+0QoNJQVnEHaChjMUSQXcJVF4DH40z8COSC8ofPDIPr
         6DkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769003329; x=1769608129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cP7+lodeQJW67tiROuU4iCdrxhUkaMFq+EWtWSOxqhs=;
        b=nsPWJoiFXoBVk/tmkneHBqQGTzQCySxYltqTkZU7JxZAmg4Us3aLjMwhKIJXM2tidz
         eeWINEuzEPYDiY8Rw8jfIjky5aThNIClyQzj3dWgFRcwrJG0xDn1oESMYTYMgY2MJ32Y
         qmReLdPKYUqxs0UQhdpNcfxeoMKYYyvWcHzuGgJ2YgxWRnTf/tipAadxKzSceQMMDbNH
         0EBVjLOtRchKhpETbLyi0vtOjI6DIWxINIks4I/uWj8EFIP4uOnUfXeBJwx7yuzwyago
         Nhzt+yx56GxZgErUxq8jWTukFqxLgbebjkgNgdUr8Jf+ZYwtpbLAU7ZrwEF7sp8KfpNd
         5uVA==
X-Gm-Message-State: AOJu0YxTwAQ9moyoabCDjKR5YB4C/rmaY5ziVYPxahK91dIOjrvvEf3D
	KbGCGdoQx/FSw9RB1nSJyei9U7BdKB5gU5Q9hOnphkdKEj0EYsmVeEFcuOlbyChcrRrDe6Kgzmh
	nKZ8TR1TErwYw1CTqULPIhhH3G99d2ZgNxovWV68Ts9GeeSAOtVp6JxM189Y=
X-Gm-Gg: AZuq6aLkgcv62hcmrnzTzgU145OSabKLl6q//XhhKvQdNaeGtnuuDejhZNMHCcIEMi4
	3xt1MgmAGdx+YETp1/KSpeQvu3CT6SCdhEnOjlhyU73qkjY+q8giVYA6YFLc2sTxQ0qCeEcsXDd
	KdVu7qw5PsT6/vcABsusNMdzT8J8NoQqYdJmhFhxqtOKqVPJ8ok0I9JMO1hc4LF7waBovs3Sih2
	87Vw6YUnH1Rc1kPEwNIJY2jGLKzjGmmw1xP7xoQngpehAqJEmswBuN4yH3gL46GHMOs2JglJbxw
	Z0EyLA==
X-Received: by 2002:a05:622a:1a9b:b0:4f0:2afc:3b80 with SMTP id
 d75a77b69052e-502a1f32911mr243056121cf.56.1769003329341; Wed, 21 Jan 2026
 05:48:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121131954.2710459-1-p@1g4.org> <20260121131954.2710459-2-p@1g4.org>
 <CANn89i+8_ZDxVGwQmo_44iCRs5Wexwxy1Wfhw4WmYg3qA7_t1A@mail.gmail.com> <BSn2a6IWtM_DnDrcd-qDBm8cXAwXPo3xj1l4Eu4SWy3BS2UW8Aw7-gXW6uo_DaCipnvmSxgDeGEQrnZ-pjqRKSOPPUW0usVN8M1lp1J-soM=@1g4.org>
In-Reply-To: <BSn2a6IWtM_DnDrcd-qDBm8cXAwXPo3xj1l4Eu4SWy3BS2UW8Aw7-gXW6uo_DaCipnvmSxgDeGEQrnZ-pjqRKSOPPUW0usVN8M1lp1J-soM=@1g4.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Jan 2026 14:48:37 +0100
X-Gm-Features: AZwV_QjfkzxcsqX79MNZYV42WjEJav4hyCpBb914c2qgdnj1wjV5tfKlXRSh1Pw
Message-ID: <CANn89iK_VqOThsWX2b-JwvF8suBVmKEmMm9D9SeZJBamDwfPog@mail.gmail.com>
Subject: Re: [PATCH net v3 1/7] net/sched: act_gate: zero-initialize netlink
 dump struct
To: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 2:39=E2=80=AFPM Paul Moses <p@1g4.org> wrote:
>
> Yes, it's not proven so you might be right, I knew it was 4 bytes at best=
. We can do next or toss it, I don't feel strongly either way.
>

These bytes are cleared by C compilers.

https://en.cppreference.com/w/c/language/struct_initialization.html

Only holes might be left uninitialized.

> On Wednesday, January 21st, 2026 at 7:25 AM, Eric Dumazet <edumazet@googl=
e.com> wrote:
>
> >
> >
> > On Wed, Jan 21, 2026 at 2:20=E2=80=AFPM Paul Moses p@1g4.org wrote:
> >
> > > Zero-initialize the dump struct before selective assignment to avoid
> > > leaking stack padding in netlink replies. This matches other actions
> > > (e.g. act_connmark) that zero-init their dump structs.
> > >
> > > Fixes: a51c328df310 ("net: qos: introduce a gate control flow action"=
)
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Paul Moses p@1g4.org
> > > ---
> >
> >
> > I do not see a bug to fix, current code is fine.
> >
> > act_connmark problem was that "struct tc_connmark" had a 16bit hole.
> >
> > No such issue for struct tc_gate.
