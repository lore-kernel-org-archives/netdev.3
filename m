Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792725944;
	b=LKpDjj56rJrEqgoRTPmbPeupPumYw+wRV0sCbHgjK7KvsRJRFhS4jiwJiCJEtT3NTuPL
	 57noWwyvtfBncr1WYFcxKOmHwmtsinlvBHV6o657nbCWo8DDV9hV3PwKm+oir91cimt+l
	 e/Z2a7D5+nm7Zfulq9yQF51vLN0E0PPT7eKdNLl9n6E5j5aU6/lqLD2kc9ilxkETCyTM0
	 E6OsjULxVip7oVh4eMKqXLbmcvvMJRfWqUDKby/h2OlporS19nlngomWgJ7Amx0Hf/vYi
	 8IgW0UrdpHzR5g4GmgNRxDhI7W5FnpWDwzyJ24aHJpjl1y5OTO3rdzGyMHlFdeg8Uzg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792725944;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=uaSfqiQ4FrRQdMg9pQ8MmVZnbE5vzFmaYPRmyjeQAhk=;
	b=uv/1L0crwYSeI9XQLzqdHat8WvqIYXakNLn/4NZPXKYoonXS37z/Cpew5RpnGuzateXb
	 IaWmdAo+uBC2xWiRyOYgo2GdeP1ubt8ZlBWkNKHAOmj1qa/gfHtGV4eWWp242WwDRWJuQ
	 kSJQdT+tlBcMzxqxJTZj6NzVdcTsVKpBbJKmSGR/ELFiFeUL9ah2s37A7h1wF81f1EByh
	 UvBRWzZVasNE0piyySltcKpHyuTTjwveOIL6eN1hZa8p+6h94zBmsVJjQ0njh+tMw59uW
	 fjXrfMZmeAvi1uwJZqIMRxFAVVnFRQlepgdVf1gp4hAxIaj2ad//0CM3HvApqk6tA5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Jlq1Gyl4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.49
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE82E606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 03:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE82E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Jlq1Gyl4
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5bfa65c8617so223047e87.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 20:25:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792725942; cv=none;
        d=google.com; s=arc-20260327;
        b=r+SyTA5IW95O10JR916ysIEGQiQ9ZWhPXT7ttQtLF2sVi0TaZNWb9DcvVtOXuQkFKA
         a5TCQF1Jbtr9HajyG7gzHKSBLdqol/U1usmrQkn4DPJF+zZiLG6dyFjb7O1y61Y8yCgz
         tLf0YLiJtxB1VyzwN07dlA6bhhTg/6T2SR5T1w9MGHPlOnYgqrw7PR1uqI4YSRKRBPYW
         cgQlkX5C1aHqlOGaJ2xENSko0JiTM1qiHF9QLavFV7OX29ttEFxawUY9JFbrX0Tx2IUR
         RVY+dF2blG2gYKNW2QpzXc9BjN6nqDZS4Yq91JYn8vvNr4qEQ6z1zzu5autqTESu39uy
         NPng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uaSfqiQ4FrRQdMg9pQ8MmVZnbE5vzFmaYPRmyjeQAhk=;
        fh=yY5eIrGHTZaqPvmFYi0OpPEkRuf+eV2Oyj7t3Qzgkfw=;
        b=H25CDHvNT/2iD8cg6nLwG+cGO3YX1eE9VCelwPUNuIP6ZoFoHOJRk+cxarUZ8BucyJ
         Mb8VSlGFWT9a8C5RiK30KuEfqHvgAywHaVSUsX4LYIA584uH4+uKwlgHZ7Ls/zfk4Qs2
         sSN6YMPeeHgzaS5qwLiA4bJ2dQFbJTZEEL7nJ4fK8xW4kN175ThPilxDuC4eaBE2w/zC
         jyPW++lmtKes76ODOa208/SZUXZnNM/ZEQo5fuNMKfiKh2jE3K6Dg59idRbK624VYzLf
         SwbK5tw7kbOm76gimcvd53Vv4vS/rnL/GrNFbdaQqp754em/SiOuRoqq2XFP00ttCrA+
         XUvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792725942; x=1793330742; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uaSfqiQ4FrRQdMg9pQ8MmVZnbE5vzFmaYPRmyjeQAhk=;
        b=Jlq1Gyl49tvExxyUuCAPtiTpo6qQJsjdunC3JfX0NPPEpNilTTYCvVrkCBnNLsDJ/q
         DQepKK2cvOMgbHKkpgepIFY0EwmtMdGWhLP4IBN1K/YnwWxTD5x45YO4gfWaka5Yvsr2
         Ucy6Ey3rjk+6wGEXd/fGL7X0Xuya7ViMRYUNbs1hfx9eapVzmW/on3JhgNFdoVy9Y7j8
         4H17oK1h6kdeA0l2xiRQmb8nLSDmnZJsV3+Nd09nQ0zY3g3ybbmuxAneKpvspLz97fl1
         JNsWL/l5HbbWcfZePxqFzoCNBUj1OgzD6KygD/tiWQszQBB8flOl60dKZLzVgsKNRfCS
         jTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792725942; x=1793330742;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uaSfqiQ4FrRQdMg9pQ8MmVZnbE5vzFmaYPRmyjeQAhk=;
        b=glZVvQseI10mYFEbqRURPjicDjqNagfYBvQrRijMh+Dhs0UR6kI1cZM8h09rW4Te4P
         HCgMmO/e6nfiIQS7dCcmbufH+sOmzZacGbJB9XEvL7m8ON6TFRnCYZbVt5E2mXmFp05h
         8gwoH/NYnthzTp4M0fHhMNrpR8h5WBmUfgyK5vi7Zaw36bFnbSoNTUK/czwAFhBWZV8A
         l9f79mu/TqSzbIbkaOhgETMUNslg4Vdo2zTLudbhStf4sBW8AB+pwAmIwkbbO/6NFyNm
         Dy12J55N43bTp1vIBQj74QNvPFDkqAYn7GpIJhikzENsfi+SsmscngKYaCOz0XPCGRI5
         KfYg==
X-Forwarded-Encrypted: i=1; AKwUvBz5cDixJ9aT3j2JKqUgCqXq91Erc+Mo32z1BXf8fohOQ74uUJ1AkPhyXY6TP7ttneJa3tURBOw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJtkkdP0D1qTF8BdLuHxOO6BMQYFkw0kcUZxa8OMLi5jXDp+KtT
	4JZOJc/M07a1kg1228clzE9BicYcET1Sr0JJn9OZnhnBxlD5pMA20BhCIGM7k4SlSYOfs5TUAKi
	jx4618cLcWYo8gZ8YXMElVbmKl0CBE/8=
X-Gm-Gg: AYBFou3McrBVj8I/kU4qDybFMb0AnKAowZ1Fd96lWxDtfE+XATTvivDOXMws/r61r2V
	opRkT8vehLXf1ysAI4FxJT+P46C2JR20tndC849R6LHC0XRnUboDYXZeS7R5ob/MjB09jWQXAwm
	as1ofaJ4kxLY8ODy0FfIAX6PiKYSwmB9t6/Mh+xVYdoj2N8DDsDTZAPoaeiF6X89aiDFfIOHjd3
	asibHE5adtIR0X+TIsjouytl6uVjA50MyiNcHAnlrDd97Ah0+w26BYsMu+5VSJgs6VhkEc6rn5l
	O86Ttdz+MUiWjZOJ8rOP9aUt8Qh/a76I5VOMXL7ShKrhaGGk0PvoPHfL4BHyfOfAF/Z+BSGRPiL
	4IVNwj0s3o8dg80OLrxuCGE9j1hrzCyYeLN7E
X-Received: by 2002:a05:6512:6686:10b0:5bf:b144:fcbf with SMTP id
 2adb3069b0e04-5bfb144fdbbmr118545e87.11.1792725941650; Thu, 22 Oct 2026
 20:25:41 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021065750.2069795-1-anilkaushikwireless@gmail.com> <179256621789.3290.7142786984430868325@kernel.org>
In-Reply-To: <179256621789.3290.7142786984430868325@kernel.org>
From: Anil Kaushik <anilkaushikwireless@gmail.com>
Date: Fri, 23 Oct 2026 08:55:29 +0530
X-Gm-Features: AclHuK_d_hZRKbJNpdkbqa9tJF3np4JnVtczVtRePxLBpAVKzzWcz50egBKIldw
Message-ID: <CAG0Mgm-nXSvuA78MnGaxDPLaRM1p4WGnj61GxSEL8cOmZvGf-w@mail.gmail.com>
Subject: Re: [PATCH net] gtp: Require 'CAP_NET_ADMIN' when joining the gtp
 multicast group
To: netdev-bot+sinfo@kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Harald Welte <laforge@gnumonks.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, 
	osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 12:33=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrot=
e:
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
Found by manual code inspection: GETPDP requires CAP_NET_ADMIN, but the
multicast group that sends the same data did not.
Thanks,
Anil

> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
