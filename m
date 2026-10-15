Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC5D556B8A
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 20:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792097734; cv=pass; b=BBM7O0HBOuSDjrTcHJ/dyT7hTHVcjVpFB6Lwfzaba8F7GX1p7m1dJmkJBh8hZoJ2SWFEZOhQlehFr0F6ZX2WEOz8OpWYP5qmf2dOYQuewJ12TcZXRG7PF0ULLxtBWgdjFZD3ouDusuPcd998+6SRL1KZgEZkg64v4aOwYwXEUag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792097734; c=relaxed/simple;
	bh=oxcL+DRLHpYRuFoWgi1CdwrKDasz59wF1+KBu8njpV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aZwRr3+D1hsYyPEY40uYXaxTLdJ3X+a5UH8y0zuoW01WzcdgU5G63Uunbq5lQv+ezsYryP/AOT63Y+ntZfB+FvehjWqi1rMUbW3ZuzWm1F9KOcMSPr/RYjmu7c4zSBH4bf4oqDwmQH+yzTVFN0vb5PeWxlZC1Da2t/mAImMm+zA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b=FINtlzK/; arc=pass smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b="FINtlzK/"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7777fa8f1ccso1605069137.3
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 13:55:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792097731; cv=none;
        d=google.com; s=arc-20260327;
        b=MlIDJopYj8ROkgwLpe9H1C4FQziC+K3NuIJn5AmAINVE+hCTYVBIs842Hd8w1u0WK/
         T2I3EtgZr9C+d68fwfBmit5rKF9iaUCwu+GuaryvIO3Sb+LxQ43Oyw/GT01ldFFfViBN
         p4hy+kc3Zy/c4eoAgjAtrWJbKevGVpDiN+lUEwOO6BL5X/dubB2jNNmvDHIlN/exfCqv
         HNBz66M6ipI6eyW24VkYrqrT2bL5mLxO7d8HlbIpX8kQOJ4oY5MrZuq9hztthyJNqrbE
         Y+qLtyDRLRN9f7UxpdowZpsnGuY5q9cANB3YGstqYyw/FDojA8g71JbY2x4slurlg8Fi
         joig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iZa+VRwpFoqUOiuw2h255Iumi459YfZ43vaXhQz0jBw=;
        fh=bRwc2joVQhsis7QiBSILN1mRBNnv9Y4/X1r2910FThE=;
        b=OBKb4gw2hi1Lac06pY0Ec5DtxCKcfK8SoiImcxETdcjorvQwOj0qy5H+bwGOmKjNAv
         Hpd2tvJX22TLS6e8GmL7pH6ThYGpXeFUgT5RMIyrn1n/L/K5rQas4dL4QNUjFxVVT27C
         gGs7ANS/dCkiwV7SrXnfDKJRP968q0m8zyNwL7NPRZLNgA8WTR7xOSaZq99PD/rwB38z
         TN/1BdCGo3NyoK+ls5di/Opql0nQmuIUelGgF2jGe7Tfcd6VvQPw9pAwlhfb89f3bQKV
         f+032A0x4LUv1WdsiYDuJBckMwJIJOkBnZCQDSTx944LJkYpzakznxSJHQDjTIGyANr9
         Zzgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1792097731; x=1792702531; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iZa+VRwpFoqUOiuw2h255Iumi459YfZ43vaXhQz0jBw=;
        b=FINtlzK/RmRJTsG1m/S/TRO5jCb5dNkQ3IA/HsG38I5WEfU7a+cHc/y7uxALQjhkd3
         xMEO9D64PK+2v3XQTdubIGrbtc03Ch4J2rrd1arwLzEvwnHiqSrIBiekwOlsET8I0TQM
         tiFDAD1Ya60ubt9J2LSg2AnVSFS6joZ2+YI1rvjyF66iPn2XdCAGV/dvaeZBVHb7eEe7
         paV0WPQhbLD34caPB/6j9HsIIDrm1lqcFE2TasYYHynBgjCUKNRdMvtq9MQ1AH8JxW7J
         uhcw6Zdz/4bFybaojJDjXMCzlX9WIbb/8zJB2vvzAgWVUJFQICH+rbt/Fizg6TUJh6z2
         GikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792097731; x=1792702531;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iZa+VRwpFoqUOiuw2h255Iumi459YfZ43vaXhQz0jBw=;
        b=Q/Kf+Nj55O+tHk+uIgD4DkPeQcrEDSFpagcKFEZKJPBwp5s9FawM75jMzCddwg1q3Q
         2GkE10b0KoqRGZjy5OX7Yn/2EMCN+L8LcgWoI3DebqgCvgk0AyU7Ag6iLVEmWW2d+GyE
         cFZAy+G0G2bqhuSjHsdhBjsmavn3u8vlUA4Sw/TX30jDquvC3vPZpMbbPEYMTlyFh3tB
         h/IF42T/aZ+4AULeHWJXaWmksJn7nJf19S5B6Xl6OxaZMOUr7kgI3U9PpsmF5IfzqtNG
         POeA3tFZR6J+YtkXg/C9rsuRT/QrS9986VoQG2J1in4xWfyom9venZAq74aeC6JX1RM5
         bZYg==
X-Gm-Message-State: AFq9FYKyzbBvldtNzqClArMNLx3JFBQERlYQzO5cGtgot00LgneqZ7Nk
	h6ksUdyMuYT/cnj13906ZSic9rMZqQveRThe2jRyOy+QkhyO13ZFA8fRobuO2W4+8cg0VoLS+to
	tRGyVF3wwM4eZmqTy8RbkSq3ggcnyplBrQc+sQ3ibFg==
X-Gm-Gg: AYBFou1hOVmahomL6loHkVg35ws1EyZ0bl/6UA9SmTNilcHD2i1uRMQZUw5vq+Rdx1g
	5Z2MB64EFnqXorawvkRHEv6UR79fHbGu+w0uforbxaILJ7toTS39dW9OI3VGd0XolM+M7eXlI6c
	f8isTBUCR8685RfhCbLiVL24yWpeDNLHoeDJRRtLa9R5RzlB4K7dRbY26SGbD31t2HleftEngXJ
	KQzwEcrjclL//Np6cXTeeiltkfqRE15wJ9CF8UKrK/w22pk4Kk1v+YdcB2lGkizAav1HXlci00v
	QR+us0fCxPWfKkeLa8jIfvYZsfrEBipUx0GoHa22wAUGibQfyBhcnMdlHm+ON51vvBsHr46d85f
	mltZJFBBfh2Y5mV301Y8uTquGF38cFG+dBO+EDmiHA+UQUjEKgCU9waRK/vMCuCR/AusKPQEYqC
	8iM6Dyg89Qq3Xsfp/c5rYBVpMFFGYOiq+wPQVEFcRf
X-Received: by 2002:a05:6102:50a8:b0:7cc:1d0b:6d33 with SMTP id
 ada2fe7eead31-7cc1d0b6e14mr138384137.26.1792097730684; Thu, 15 Oct 2026
 13:55:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015201135.2744031-1-rjethwani@purestorage.com> <179209526555.408196.10402909579775011337@kernel.org>
In-Reply-To: <179209526555.408196.10402909579775011337@kernel.org>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Thu, 15 Oct 2026 13:55:19 -0700
X-Gm-Features: AclHuK_KJKMqgPTEBOM4jIVqlplrA2L0KkNOxz_yqNIgpeoekK7xG11MjUkpUfI
Message-ID: <CAKaoeS2dKXBY4zKtf1LDx5cbMaSxfcvf4oHuri5uEu5vis3pfw@mail.gmail.com>
Subject: Re: [PATCH net 0/2] tls: device: fix users of copied_seq after the
 strparser rework
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 1:14=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote=
:
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
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

Both issues were found by code inspection, while
working on the TLS 1.3 hardware offload series.
