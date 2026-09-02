Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0DC49C4A5
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 13:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788354243; cv=pass; b=l5/Fx8+OY2r2E8GlBaF/6amHWrpsGE35CMqfm7V+V7bLdttPVlAxTFCf8GZfEAdKdrP3r+1ATioFwY3Yxlu+dsFqN/FQLLZfVhhqcZdtOFstmhs5MwCw1NbyBrt3Jm4drSFCQOwYLtpUB2ihhRaKhkOf17gTrlr73PuHWPRFva0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788354243; c=relaxed/simple;
	bh=d3tednFs93qhVo5hjvRy9y5lXWa9IuFW7vC72+58OmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhBGJvtv6fHTmNOo2Vff2H+zIqoU7q/JeDPzVgYQsUv9NMieoqkK54tqSa4xCsgDTpBUbri+aopzOhd08oEUpN5rvtmj4qxkol6ktn00fvIDzClzDCgnDqBtMov2ja+mjHOi+jOWS2etgQzP6kA6I2phLdjd6LNZBGE1CSwYB8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UtNWwq9K; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UtNWwq9K"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-52fa9c055b5so28829061cf.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 06:04:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788354240; cv=none;
        d=google.com; s=arc-20260327;
        b=lmyJ3OhwjkeMSEKtH380N4nUu0laZSEZd61iOvC9X5K8tuGErel5RiduZx/C91dfVn
         +RHuQQIj89SWXNkJQYjUmdCokVofQd1rGRFgiKOfRhPfFRZuN+xN48R5q/aK+t8kqQr9
         bzUGQVoyg3mdu87GogWOwF7CdbunIlqoL2gbDq7iy13ZCH/pBvbbDUx3aS6erf7QEqY+
         IKB7I+/amtM3uKi4WTrzbIM4OBCzt1dU1yr4Uzu+q/CAORjlEdUwQLG+RP6nbpDAcUK5
         NBkVdBNXfD1BNLhZp0njSZE7PFZQr2UJrswTSSQbmrp8KGan5I3Wb23Dxk0ldGBbJxCd
         /0Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=REC0WBjU6HbnzKlsagTQJMv9INahl8hjQLf2W4ca4pg=;
        fh=AukeYB0QOsqywlJ4iWkAnO6L+/H3Jo4TSzBag9fEpZM=;
        b=qmWeKJsMO+xrXJAmkU+Spu6S8JClUGbcrVQBTH/WW5QXiF0kP6OPvP+hrAEgu8jC3i
         RMjNXsA4816UKT6C3tqsEm4bJGhhEoak2zAWVpnKH9M8Rj5Pcw04BBD3o5j8ociScY2j
         gmSLz5lclENFPO2tZdtmwqASJSgFYlsv3UWzRRL0BLAK/SY1BtM48v3tnvV60VlzwPrb
         N1RBaM3wtfRxpj0P8gTDRiu9RI7nyjNOjGMT0/n/83VphxIIH3dA1Oq8HPmAfUaYQhs4
         i3buzH+akt6cfFK9QwnFpsPcvTF6ViliB6l3vQwzICcLIx8+IjvRbDSuKhfYQfJRvejC
         6u8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788354240; x=1788959040; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=REC0WBjU6HbnzKlsagTQJMv9INahl8hjQLf2W4ca4pg=;
        b=UtNWwq9K1oJmDKrc3zfN1PFB/SI6SfMt5xWZpseDC8kcBaoGSzbOh7ZEVzaCO6mNGW
         oBWnLLXpNH3tAE5JEVnTmOZFl788dNx4CBNZyU3iyUMVHzgGqtnhP99SPmqUl6YhS1mP
         bPf7e3NgA6W2rWLAjVXowAwzc2NwiQDLvmA/FgoghaBnC81M6kSrOqpAqTEDGsIblFB5
         oSycm6Gh+P6tyumbez3eJPrxkOFv2vvbzOweE/zfJPna4fJekWrZY880gQx2fLzdID/k
         QwIHKpyGKnsACz7KCpanOrtAmxlCjRvxydfbksBXJ2tEwKfWURkRBye2BEk73YNQ9lxi
         yx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788354240; x=1788959040;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=REC0WBjU6HbnzKlsagTQJMv9INahl8hjQLf2W4ca4pg=;
        b=J8uXYi2ci39GkEy1O1548rTKq7rZ/D5YHYzevTHmaIHjmGrcmrsR4HAZT0cAmVRR3u
         G3b3/jLUBfmN9lVouu3R9ayiSbbfXDKNSJoOD+xY72J4z81f4xKhtcuyc7isBsf93lp7
         mwmY86AMm/u+pUyfvUNw6Mdk2BfSKTBeC1AmR7yCFLS5lFn0LQAZwcLw8Cf+bMZmyjjR
         qY5ZjjV9Nt+WSMrq+RBdBtxFUr4PA78i22D4EUr0e9bssKMC6Ftabe5hdfxOLRCLWVp6
         PbbrZg8ZjcdtqWMKLUq5S90ci4r5VzJXmIhriGPt2DkL11VSY3GEL2rIvH2Wj/j72U+E
         uong==
X-Gm-Message-State: AFuF++ko93NwqbYVxKkBQGTcyuh7BUIxLAkycLGN9JL299FvLskJbbYZ
	LTzPwO0fxCIYegchAlGghZ4FicB+WQWoDzoM3RqdE91bj91cqPoMorviavThZJbcX1kCyMzf3EG
	e3duVlYpNA77e1UtqchTHO8bB69I69yIoipYTEPvh
X-Gm-Gg: AR+sD11m/wB7ZiNJk3h//UIZselNFNxTAiDaj6Y0Qm51582C6WpCBS+80b4mpRJL/3y
	igL4KXCTnqiU/RhgS4CXI6pF6UodIYJL8z576W25SR9rZQ95TlegE0ZDfEQW00Qiu3VHMJM6kLV
	pVzevi5db5QK3huDbE8onHh0mN3GJ/i0RHr2zV7NlKH6z+b8PKGEHfl7yjXeIj4BhA0yKykoY+X
	kyW4Pd7YvdEX4bX/Y37iWug/FJxof5O94ERcJ7BehRtJWfJBPJBPtoMBXsVZnL95aIVT24U2N71
	H4n7Da8uKVhxBgGZ4Pw/CPoK4rpEh+esKCuww4euf/nke9FGh+jUEacbLu4dgW+Slu4GiNwyMU/
	oK5AfzRlApm4fzXpbiq1PzC0V76/QS8Po0Et7Ue/EzSpj3iW3ckNyJz7/sg==
X-Received: by 2002:a05:620a:1714:b0:939:5c17:8c73 with SMTP id
 af79cd13be357-93965763938mr276084685a.0.1788354239348; Wed, 02 Sep 2026
 06:03:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-0CFC.v3.20260901204856@mojatatu.com> <QDISC-0CFC.v3.20260901204856@mojatatu.com.2>
 <CANn89iJCBTSGwKK02xw0XdZRsP=2VGmJny27cdi0bnpz4aBwHg@mail.gmail.com>
 <CANn89iL+o5mdPOvRUy_vSiHxj3Kc9Wzr3HV_dGf2tsKJJNwniA@mail.gmail.com> <CAM0EoMnENJAY7pP9dP6pbbWnW44Ug-Ow3C=sf87pfOTwxjMdaQ@mail.gmail.com>
In-Reply-To: <CAM0EoMnENJAY7pP9dP6pbbWnW44Ug-Ow3C=sf87pfOTwxjMdaQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 2 Sep 2026 15:03:48 +0200
X-Gm-Features: AcwNN1X3f7LD30KD1qZfc49zPIh9rkbs0FiNWJF728EVXHW4XziSK5SvOhwvgEg
Message-ID: <CANn89iLr_3Z1MTa6U9SuooU7q-Yw8nXgRb=heSvoR=uUSTJgzg@mail.gmail.com>
Subject: Re: [PATCH net v3 1/9] net/sched: fq: clamp quantum and
 initial_quantum in change path
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Victor Nogueira <victor@mojatatu.com>, Vega <vega@nebusec.ai>, 
	stable@vger.kernel.org, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Vijay Subramanian <subramanian.vijay@gmail.com>, Petr Machata <petrm@nvidia.com>, 
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 2:40=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:
>
>
> Trying to understand your concern: Are you arguing for
> stylistic/readability improvement or robustness?
> The only place i can see where the multiplies you describe could
> happen is what the 709f34f7c28d patch closed. i.e this part:
>
> -       q->quantum              =3D 2 * psched_mtu(qdisc_dev(sch));
> -       q->initial_quantum      =3D 10 * psched_mtu(qdisc_dev(sch));
>
> IIRC, you are suggesting restoring the original logic (x2 and x10) and
> i am likely missing why that is a must do? Does it break anything?

It does not break anything; it just causes a cascade of various clamps.

After your patch we will have:

       mtu =3D clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
       q->quantum              =3D clamp_t(u32, 2 * mtu, 256, 1 << 20);
       q->initial_quantum      =3D min_t(u32, 10 * mtu, 1 << 20);

So @mtu is no longer the psched mtu anymore.

This is fine.
