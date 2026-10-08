Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6B21CDFCA
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 03:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791431264; cv=pass; b=JWlSGg9ObKyMva7DgGlfnhrYrEPBF272jtiYOUmb50TTCXi4ULG3Q5oD0+N1HSnF13uDU2sVNXYK3zmNPbfOPy0yKfb6MD8dCWg10tYSSHGl1hrOAmMiAsPm0wY+yuZMWOkL1947V59oq1c5qZISCnocy54WwerzHgt++TsepkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791431264; c=relaxed/simple;
	bh=hmIaX9g2UY3IiA9iMw57vnMPvXkBT/g6WD/ssMJVrbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQzfsfuhmulu0FnsNOfK8ZLXu6JDjdEsGEa9mvy3Mj1+O5b5CTLwpOVKD8DXGrG4Lon6UIo8xdTUhecMU4TAPYk/Z+wQ4wD+cvyLGmSaPUvkwwklA3iy9CVKfXUUDVedVBF+PnDtmggd1PG9+bCajuj2WnqVfpeqvOIbZxwc4Yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ErE7IQi+; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ErE7IQi+"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6aae147ef9dso6073a12.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 20:47:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791431261; cv=none;
        d=google.com; s=arc-20260327;
        b=dhNkZXaFxGI7esZvUQG04ng0388QtGVMnI55jVqCN59/f1olCpP0+1DMsOA51Gl+Q+
         jFCuK2uT4pAP3oPga9VkgnXUkEm5DSPgNx2OdhyIHc/u8g9HjIxTjUcsqrHuTv3QdzG0
         w1eiVAFTuu0V7OhpbA6ADTL71tiOWApBgLFONvnU7//f4L0vJMZ/GaZZLIiXm3sshgQe
         VyOMCmOaBG7VU9tUE2DC3dk8jd3fo36lw6zgNrWEvGH91axUmIcCBbGn/t12hE1MENER
         H/5fLRZhbnsOaLOK0wf7GsPIJBqSmMlcPtdDAdbx3mTOXx+YCMQjc3Ht1QCAi+JbSSXF
         piNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o+i3IdPj88TN4eYMrOi2MDJvpLqv8ut+DCtbOvdTzLM=;
        fh=IEWhChlW8yOiWvNdBQvO4Q1CUSNRkE3fr3/VVt1Keqk=;
        b=kJ1W1fh91lS+g5qRBxKetttbBYywp+i8Soj+nwpYSpFgTMQWKJBase+CHJZ2nFaCGi
         /3nvlSm3BQpG00V5VExLKeKU7NUvj5NLGHROkdQlY2Ypxkd99YzgBsUPle/xbJpHE5TU
         OrBOunIMCAaW8pprZf/+g2fRUJypF3eWA6XdyYSnmyWMpQIUH+R2JN7TVTXgjWo3fH08
         OvRDC4o6K60G4EJuLYncOXd1ruKH3smzJBRyFMlbTb+LFfXMjRrSB6SugZ8absvRFNWZ
         QKUPv3orUBNFNUyZGkOj3sBhIKwNfJ7Ns9lqJVe2DIiQVDHizg2LFn4YN+uqZIQ1n+Xe
         7GJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791431261; x=1792036061; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o+i3IdPj88TN4eYMrOi2MDJvpLqv8ut+DCtbOvdTzLM=;
        b=ErE7IQi+X0+OxrOo7cjvN9T7mYmo+FWMGCwT42VmOU5QlhEGV0w7CwHfzR3Jiyb0/m
         P9QXKS2UTlRvqwYsNWI/VEPX5H6tvf9g9O53SNRq6fvA6TJn0+5g2L2H1huKW0jXTn7B
         WTlqQ6JdYCh9aZYWROT/Fb3QT8F9AG524wewQsh4Vf2Xv+2NOjYk8mcxAXWlYQYhzfui
         wD5/kEvHXIikNTlu2n+oDIGpu+34kZdDiv4H5Xmnxdj6HHe9B11SCSv2Q0PwidWxooIJ
         grWzsZgA7sCwrGTZqSTd7YdJnFLUnI2apsQ8HxN9RSeepWzzp1e2BFoiXZj7YaV+qvul
         qWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791431261; x=1792036061;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o+i3IdPj88TN4eYMrOi2MDJvpLqv8ut+DCtbOvdTzLM=;
        b=t+QYgQRZIC4iLJHrER58bxuC2dkR7Tg6RSehy0kq7H1klMRP7s9cDtvl6g2/8Sp7Fs
         o1wzxfQewv12oKVBxP9KKqMaOPo9resEhH+rdKtHi7dyxkpBu0mQ4HI+o9wIdstL6Rpk
         V4lfahYBQnmJG9vB5Uul+LswyQ3RRBUZVou7eG40pBgTlF0AXc7Abb4EePcJ/D5sjNY3
         7IpRb3ywWuvtu9zgsBOpBYjyvuZIavjWRn1BG8ofq0ZpckT+yoaS0z7WP+zfceToVxAD
         e7WDYfl7NS32VhOx9978OzuHr++YLYiIDz1xuGsQvofqqKRHJO4OhC1eokZ2HWGQJMqh
         9aVQ==
X-Forwarded-Encrypted: i=1; AKwUvByI9cXAYUiRzOc2BTdHBL3dpzryjvRZQsmIKyiJYM3C8CI9AR1oyraLNj4gMVpfO4wNrt6Q5cI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIoHOXc45yRZmmK+1wMg2T16taKvcPfBHl8ZtPg0sFu24OCONEk
	PQoIDidjlfzMtoP8JZioBm50RvW/kbl/l4e8l747mRIrDDunwAM1PteTHUMr2Xh6C6mHJXWKRCK
	UWNy3835dc/lm52h2yrzw8yip8THqbFQrG3W/X+R3cKHkDYH65VIG8Frd
X-Gm-Gg: AYBFou2CuIW/DXhbt7m0rUmHf4ei3Bsn2vcLewP+rGldcQQj6bWLr4cFs4FrD44Dvxl
	By1VDJNQZLA4R4tv84uTn9gKd1M7xSWD8YgCT9kStd9fRmHd031j1jQMEKXRAnfUEgvRotd1KhP
	C+Cwc7BymQDu5xMjv6ihCABuwCPQZr9tYphqgdjuliCfa93udG2zZb7ymaoq0FVSu/v2CPoG5Wt
	7MEStHrtRMkwcY9SyLvy0JM7cb+26uQSuH/N/Dr8GPsZsFmiJq5oI30/IEGRxqM+p+ef5Oe4yFX
	tBgZNMDe/lHH3TivWdqZ9cbn7nRNmYIlNcxfxm6a5SNKn+2HEE+WUg==
X-Received: by 2002:a05:6402:3041:10b0:6aa:babf:adeb with SMTP id
 4fb4d7f45d1cf-6b011817377mr26565a12.4.1791431260743; Wed, 07 Oct 2026
 20:47:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008033952.1399670-1-almasrymina@google.com> <179143111228.2527009.8261160290330374252@kernel.org>
In-Reply-To: <179143111228.2527009.8261160290330374252@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 7 Oct 2026 20:47:28 -0700
X-Gm-Features: AclHuK9sz06UkGmr5iDRvSbOq56U94lHz2lSbMyrmJMCxUT9MaMD_pYjvGf9Hok
Message-ID: <CAHS8izOxMs=OAnGk4WOqtgiS9s2YXDOqt8cpvhOhtoviRVJcXQ@mail.gmail.com>
Subject: Re: [PATCH net v1] net: devmem: prevent mixing fragments from
 different bindings
To: netdev-bot+sinfo@kernel.org
Cc: Stanislav Fomichev <sdf@fomichev.me>, Paolo Abeni <pabeni@redhat.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Ralf Lici <ralf@mandelbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 8:45=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

Sorry for the double post!

The LLM discovered the issue while I was working on something
adjacent. Manual code inspection by me confirmed the issue is real.

The issue is not actually triggered. It is theoratical.

--=20
Thanks,
Mina
