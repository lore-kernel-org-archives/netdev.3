Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B6840A95F
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 15:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374682; cv=pass; b=OyWlq13WNcREGEgpwiouwtNgxTe9SemLbdWy48bG3ZN1y5SZFh09viYJO7lr35+NavtKifWkZqEbAjI6+dfY0eVO+MAcgPxJsTePWrd3/LrXxiX8MZwQ8yQc6+bzVi2wMKhacj0spHzvyowH/upp34xQXbsCkkzqmUochCpaSnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374682; c=relaxed/simple;
	bh=dvOsuGCRuuFNV19WB7MGPxVxTbqTFJLuplEvwMIpxBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elVdLD54qdjzgR26PbPvK5g+dtu2OrkTjNI1++eYpn0/BPJqRtD8iJrSetHAwQUlwXbqXg6dVYTKlc/u27TsFvBnCTN70Mgy6NtqzCBZF6YH7w2Qvwx8NJqhD44jCMWMeYZ3D2pszhozCtV7WTlzRAlD6+91G7AFBWFIGuM1bOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=o+FKa3VM; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="o+FKa3VM"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso1228767a12.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 08:11:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786374680; cv=none;
        d=google.com; s=arc-20260327;
        b=VS2PalOJGxu562Ot21aVGkpnEevLEqoJtUgfoqnxba5YhEgfw6VylmVmkY5EfWMghp
         oWCAYoy7EgH0QSmsV4lJOTfobsPOd64OjKactlCFBop/W2KxRFwl91A3MdB5soDQ/oFx
         kk6xjriTCxCtZ+oKfG23RwYlv7WLru4AnByUjP76fd6YSI2Jc8diVGGEemPlQFs32Ltm
         IiVNbE1UFxV3ZHEY6XGYWoP8HpY4BiGy79BtLua63aC6HSoHBbco9g8Rd9ANWhW1PGXK
         FNKHvGUo7L93twChl8q4bGdQzfhua6om6MtxxvVtk7s/T2rjjBcq7KnIfxBoF+WXYo3x
         ScvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D8szI0hqUv6+iUnY3aNmAXxizDPZaGWeVWOU8t/ttHs=;
        fh=I8+XpoA6cPYptQ2+bOQZA1J9iM3Ad4x9TJ52+RRaTRw=;
        b=ZzFGeXvmVPuVFPDe75eOJYwCGVr8N7M1QA8dpc9TKKReBL092eHyWzEhd7xqD7Ko9w
         wjI1eXiTE5c+1buaE1uuIDNxpZv3ltRweIzxLVP5zphbnBVf5RPrr6HAuVd9y56NsK23
         briKHQUBDMqfUepPqhbU6GsCivQVbYTXST6w0G82dqRA748zVN70crSwmHT4u28Xq8YW
         sqG6HPwt8CWOvU/VrM/vCJZfcqzY8Xw+oFk+ZYbAFjrV3T4TDKCy9GWAt7kKejkOB+n7
         HZSYw+kRz054KUdl2gTvtbXy7c/TjsIQO0vXrgo46GuUsvMYyE0ZaP5f0o5dGfGCcqiI
         DrNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786374680; x=1786979480; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D8szI0hqUv6+iUnY3aNmAXxizDPZaGWeVWOU8t/ttHs=;
        b=o+FKa3VMYGadiP2S42oQGyIB1OEI5Xxzdmls7uwI/NMYO2bT99jz6RJPjTVjbvtmkx
         ExqWFGgF059Wc2jMCcVUOUizMnW3jpEn7KCmMm15cmeU1VinXVPuiOoPlNIVtUXg8Mjb
         OhOPYBA9C8Cp1eK+hgenZ1IxomNkb/+HuwH3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786374680; x=1786979480;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D8szI0hqUv6+iUnY3aNmAXxizDPZaGWeVWOU8t/ttHs=;
        b=M2COaHvjC0hlVm0fCgj6Hr6VMgyquAJNsXZPulgZNyKNZWqDHCEYgkFE1qbN0RNLc8
         9wjGsvfWAYhPFABNTdZUZuZMg1X3TeX9rdzbev3cVYtXmfzfqbweNERBfKmHDHfjrFAE
         A/V/65WhNeM6Vq9S0S0Z0+N2XsU+WfEWZhobF0BZXKA1p2xSGys7FUAYPyu55l7mbUCr
         XMMNYIAGH3MdUfKO4BAezWCzgT1+8GeuiHFp9Sm7kjXqYDYhxlQAUtYzwn/g+aQs9IsE
         OSAQ4EMUwfEOBumNVkMGiFESRJ8gqUMdWjlnfbr2X96DqL7mfs0HFV8ySxtAvVVjM6Rk
         hu6g==
X-Forwarded-Encrypted: i=1; AHgh+Rq/Xih8Y+Vkemk68b1fimiDVHeUfadQ+GsWTg82UylBm8dg82Vo3yhidsvjHdLJuKgqsaqdwbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZCyqCXJbg/2hbdaZFWb4R+uCbrIz1+U0DCFoj5NnlKyJqzWXM
	iHIAjbf4Fv9bfeZ0IuKB8/v2GyOVPgJZTHo4z0AjUcdKMd/VgZesN/zG6HgOwOMLNaHMtbVCEEV
	5iEQ44pr+K82BSK8aj42TI2yLEHeHbh0mqY5kfGYY
X-Gm-Gg: AR+sD12Loukjff5VMBpsJBiEftp8F6j2rIyQu65Av9Sshc/c+8Vo7GJjNJyjyiOFZNQ
	/zsWMWAfRqhB6+tgBhY7PvQtrJTomrgQzztTIbQ2efBJjvk9DGf9eokGarTKZmvwjgaQ7jx3z24
	ob9qzy+2OhEcGtk1Gmf/VYTl/bdbbC+n39Smjw7/jmkos2AlYtMfaZnmXggcVqzeCDAdE7yonFF
	lnKraFXkGHiqjmfy6h/0qdLVttsl46ANl7IZF5O7mpjvxQ7PnYCAVh7bObWtKIvEpu4hmRnKfwV
	rpP5jl82M8ZxLtkPuNZBYEp3bdX3wonAGhbUCnxgTfY9e++KMZJjWxGQlg==
X-Received: by 2002:a05:6a00:2d81:b0:845:e9ff:5d97 with SMTP id
 d2e1a72fcca58-84f9c92d8e3mr2179465b3a.12.1786374679851; Mon, 10 Aug 2026
 08:11:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806155253.50252-1-163wangjack@gmail.com>
In-Reply-To: <20260806155253.50252-1-163wangjack@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 10 Aug 2026 11:11:07 -0400
X-Gm-Features: AUfX_myB1sAn4BjBR7SxAWVBKkuSQTY9bAbl7nGn-2WWz--99NqBpjB6WTYt9uQ
Message-ID: <CAM0EoMnaLkyZQZOufdpRZErHpWT9Xd=fNvsN=mQ0nyk+t0iAGQ@mail.gmail.com>
Subject: Re: [PATCH] net/sched: cbs: perform rate conversions in signed 64-bit arithmetic
To: Jack Wang <163wangjack@gmail.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 11:53=E2=80=AFAM Jack Wang <163wangjack@gmail.com> w=
rote:
>
> cbs_set_port_rate() and cbs_change() multiply link rates and slope values
> by BYTES_PER_KBIT, an unsigned long constant.  On 32-bit architectures,
> the multiplications therefore take place in 32-bit unsigned arithmetic
> before the results are assigned to s64 fields.
>
> For port rates above approximately 34.36 Gbit/s this wraps port_rate.
> The same conversion turns a negative sendslope into a large positive
> value, reversing the CBS credit adjustment.  This affects software CBS;
> port_rate is also refreshed on NETDEV_UP and NETDEV_CHANGE notifications.
>
> Cast the first operand of each multiplication to s64 so all intermediate
> operations use signed 64-bit arithmetic and preserve the value's sign on
> every architecture.
>

Check what the sashikos are saying please  - i agree with their view.
I believe we need a v2:
I'd suggest a v2 that addresses both (and optionally validates the
idleslope sign and a negative idleslope can arm the watchdog in the
past and busy-loop).

For completeness, the pre-existing timediff_to_credits() s64 overflow
that gemini sashiko flagged is a separate follow-up, not part of this
patch.

cheers,
jamal

> Fixes: 585d763af09c ("net/sched: Introduce Credit Based Shaper (CBS) qdis=
c")
> Fixes: 397006ba5d918 ("net/sched: cbs: Fix integer overflow in cbs_set_po=
rt_rate()")
>
> Signed-off-by: Jack Wang <163wangjack@gmail.com>
> ---
>  net/sched/sch_cbs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/sched/sch_cbs.c b/net/sched/sch_cbs.c
> index 1c93469c56e3..9ef31ecdaa05 100644
> --- a/net/sched/sch_cbs.c
> +++ b/net/sched/sch_cbs.c
> @@ -335,7 +335,7 @@ static void cbs_set_port_rate(struct net_device *dev,=
 struct cbs_sched_data *q)
>                 speed =3D ecmd.base.speed;
>
>  skip:
> -       port_rate =3D speed * 1000 * BYTES_PER_KBIT;
> +       port_rate =3D (s64)speed * 1000 * BYTES_PER_KBIT;
>
>         atomic64_set(&q->port_rate, port_rate);
>         netdev_dbg(dev, "cbs: set %s's port_rate to: %lld, linkspeed: %d\=
n",
> @@ -405,8 +405,8 @@ static int cbs_change(struct Qdisc *sch, struct nlatt=
r *opt,
>         /* Everything went OK, save the parameters used. */
>         WRITE_ONCE(q->hicredit, qopt->hicredit);
>         WRITE_ONCE(q->locredit, qopt->locredit);
> -       WRITE_ONCE(q->idleslope, qopt->idleslope * BYTES_PER_KBIT);
> -       WRITE_ONCE(q->sendslope, qopt->sendslope * BYTES_PER_KBIT);
> +       WRITE_ONCE(q->idleslope, (s64)qopt->idleslope * BYTES_PER_KBIT);
> +       WRITE_ONCE(q->sendslope, (s64)qopt->sendslope * BYTES_PER_KBIT);
>         WRITE_ONCE(q->offload, qopt->offload);
>
>         return 0;
> --
> 2.53.0
>
