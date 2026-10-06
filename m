Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882ED37F312
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 23:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791328212; cv=pass; b=jv0bHDBZ5zO6q9w5oBMGsbJaNB099UkZX/mZm+9PU+xXvLRHNjH4HVvLLFAvsYSbq476ZmEWpvWjY97U9/RxpycXxmUj0Gd5RP2YtIBI+JtfMZh9h0PD6H9GnLjedEaYI1sqJl7wlX+yBpVSFGaaVlNMIQ37svP2L9uRuGzT5Xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791328212; c=relaxed/simple;
	bh=ibmYYYozCbtMLN39HWQw3hos6Pppwape+/pVJp+rgBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPlGi0eVH25s/7Era9TPEutoh+bHZ8sseGEGW4/H2GhEo9aq8+3canWYdKnonxsI7vkvZlp9wkDW4sXUjqkhEW+v2QDoDGrgHSY5xyy4kR8PH8u4cL+zj+VkwDERenR1ZC1n5FzGBEWPLCFAkcUh7yIWHrxm++HhTJ82YgkOYXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deH1s8cr; arc=pass smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deH1s8cr"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4ed6d69bdfaso1804043b6e.3
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 16:10:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791328210; cv=none;
        d=google.com; s=arc-20260327;
        b=jyp0NZ6LOO64iY4qFWIE6FgpIsJuYmwQ/bK6t6kq/lqGeHbTOJ7ZCDJ6femqwPVMl5
         OGdoP20q79dlMavgQ1ytJJ0EMFCnbi/KB0neucPmRMWeZHGrqboJLm3r2qq08OpqZR3L
         skKyEz5C6Jut25rOsf5J6VXVQkMJj/u34UjpxLhjZReKtRb13n8UvrbYC2g8snFQjdn4
         5b0G1T6DYDX3iHw92S/u+VdbOUytZ3jKVj8pxUcIunUsGMpIAS4fDpRVKE/MeG3SSwSS
         3HFQAhf1j4+b5ny6dpuTIL5gbbQJYR61FtwH1lYlg/nsRpSCWqBFo41ah2xyJdo1MQQx
         hW0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ibmYYYozCbtMLN39HWQw3hos6Pppwape+/pVJp+rgBY=;
        fh=hMcEnT8QG/5q+qoUCEgyk6gAnbw7oF2fv9l2Q4q92EM=;
        b=V2U0LKj8Y1jdjBkKfEViWw8gkjO+4TGz0JEyc4w+35ZMMDG1RySMzjKLZHtdJvF16z
         i9xj5vBvaz5QjXUN83r5S4N3TScC5T/+YtLGGjjhVq3C0UvX8u3SFFwEom1RTHObnqbY
         TXT/xlujZlxaFA1lUKbqPm2hnzneeMZPh7Wg8340PzNcHX/R7ixG7hG9DT8b+QFQ29tQ
         Lq+g8oce7NWRsLLZkTRLRZEme53tibwF46SyfR6SsSbqDUrFT2TCmEzJDwg9kntDwfBS
         4ELQJlzzYtaAfreg0uomde+CTaCbQJqzRYSHkkijCze40Sa+EmounHV1tqqq0ZY4bO7l
         cliA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791328210; x=1791933010; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ibmYYYozCbtMLN39HWQw3hos6Pppwape+/pVJp+rgBY=;
        b=deH1s8crQXnQgolX7TgpfqOz6ebUlY+QmZUxEzdP0M/GUajzCnkgvBwdgy0jpoq4kQ
         cL/5BBQ1Rmou/izfL6NF4EJcRKupVouDv1z+0rrVtPvuvCXnDkcfyVHFXGwWPDUHECL0
         EUdMk1hGiiCb+lxhcmRdApEiFgQSK1m/tpqqRnh+EMtrw+n6BGVSlgliLG3F+RAZZinZ
         TGdHrw30HI2sN3tezoEP6Ftw2uA7+DF6LT4Ddklk8a6E9qYEJvr/3WRBod8FVxAJQO/N
         Eiyy0lwaQUGr+f8asLiuHbou2HEw56ItQ3m4G4lRhd+kZZgAvahVg9z3gGs4SAeB+mW9
         kAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791328210; x=1791933010;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ibmYYYozCbtMLN39HWQw3hos6Pppwape+/pVJp+rgBY=;
        b=zvqIgnY336Zp4MlyvpmMq4tdp+iT9XSGATDrllQMlYBu9MgYAYLsypE+nAoYodT5Wy
         284IxuLDcvbwOQcD/micjMMBeGad4XkpNouAC/5RM/Jdy8P+cAYYZJ6BOWuGXZx55PgY
         WuFxzbPSA0EkxjPgtNK+wJ+kJP3dm/gekHG3kEoU+apEaNES2odQSTBktuENLRqoh3QU
         pKBN6Aavgubmx98ZT/iaj2mUOV/d3BFX6LTQXhwt8NI5MneyWBCBGdV1KYxKI3MtvSeo
         Wm0vnbwxXxq8obRd+3YU99wRGjPTozh0LobYXsT9sFZiHjqm5kmrkofleiQlRQyXuPwM
         +6Lw==
X-Forwarded-Encrypted: i=1; AKwUvBx2sjFm/F9wyTwMOTKrIzVpS/KJaskvxCdVtxMRdfubVt1bNUl86Oc77MUisAviVCil8XB9FV0=@vger.kernel.org
X-Gm-Message-State: AFuF++kRJKeXLqXZObU6HF78DY0Qaetk0cqKCjiRrMK9iMJp5DM6afOw
	XNiU15Nq+xs9WcJ8DEeCIGmAjc0+x0Lg1P5nHRkrZNwkfCh2fcUgKh/5sdwAWol0cnqwTkEKhc5
	CndHInz/j5pbaCdFHW7EIfiQMVS+YD/8=
X-Gm-Gg: AYBFou2uUP1z8Pz/tcPplnWajEvBuZRH+ILDBE4NVNkAyBcVLQG0UD4f+iWky4956DU
	atYNM0GxjGH5klZjRUpEPpjIjfipgqNJNOaAygGPUnnw9guPGo6HZlVAMR2pQZOVHGn+42cgnH0
	AN0a6opM0r8pb6bOyNh6GrXbJ8etAd9JVTO3drLEVTflZm2YF/naLbn/22Vi20FZZvnlgKTZPMj
	P6LpXJQTWDRNftoO9hBid0E3bTRoaKpSOvitiaYGOE6DNxS0N1acUxLSmhKwhnduuLD1ZhsbBtF
	UZhw4dErvBuY+tOXPiR9dsf5kEXU+GQVDkC87OQv/sELgZcQNOm1G5WH
X-Received: by 2002:a05:6808:4f2b:b0:4d5:27da:a498 with SMTP id
 5614622812f47-4fc4648102cmr846517b6e.50.1791328210398; Tue, 06 Oct 2026
 16:10:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com> <20261006192601.1875100-2-kuniyu@google.com>
In-Reply-To: <20261006192601.1875100-2-kuniyu@google.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 6 Oct 2026 16:09:58 -0700
X-Gm-Features: AclHuK-l4-iuHEPHyn3LL449FCmDh-CgW2cSSbCWIUk2Zw4pNN2ae4cxCj033rg
Message-ID: <CAMB2axPPyap2KDGqMqhCw6sBdqWb2G_68D9D7z_ow0YqYzpdpA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 01/10] bpf: tcp: Convert deny-list for
 bpf_{get,set}sockopt() to allow-list.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 12:26=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> Currently, four bpf_tcp_ops callbacks are not allowed to call
> bpf_setsockopt() and bpf_getsockopt().
>
> However, the deny-list is fragile, and when a new callback is
> added, we might re-open a can of worms. [0][1]
>
> Let's convert it to allow-list.
>
> Note that it can be written as offsetof(,X) <=3D moff <=3D offsetof(,Y)
> but clang can optimise to similar code anyway.
>
> Link: https://lore.kernel.org/r/20220929070407.965581-5-martin.lau@linux.=
dev/ #[0]
> Link: https://lore.kernel.org/bpf/20260421155804.135786-1-kafai.wan@linux=
.dev/ #[1]
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Amery Hung <ameryhung@gmail.com>
