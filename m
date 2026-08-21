Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B867E31E838
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 13:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787319243; cv=pass; b=A0wvkSi07uUu7lZ1f6fuY00gaCLvz66m9g7VG24yyPLysCCEaM6Q7UppzaYVG1b9jpOHaWrpux67AkeDhRGy/7WX/SDkrYsawEbN9jI61FissfaqLaQ4Hrylnws1FBnQU36dkvO2CNzMZc7ap3mHJVQTAVt+742QK9/Bdgnlgc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787319243; c=relaxed/simple;
	bh=nYoghiuz9Kdd84pNDouWdj+ruzp0xFI/cFX1/gP+hvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TfRNm2i/AWbTQE/UY7+VHGadJP3cv6ZnJK49S+uKiaUC0G+zweEMrVkzxLShtycYPVdUaXLhVXpatFMtjBwdqWKqkAjV+Lv58xLl3gGfkdut+APYw2FF4FK3LGwY7v3g/HpGZ51z53PLheyXzIB2lno6CyBcspZ/pmIC4N3sohU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L6lBhVqF; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L6lBhVqF"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c2a818fc4so6342791cf.2
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 06:34:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787319241; cv=none;
        d=google.com; s=arc-20260327;
        b=oaiLqeQYaWngH68eCFxK8aF5meS5HmuWxfKMAAgyn+ZaM8DuZ6PzQ70gAJLXzwfLG4
         hCYgG6JDGRvTyV56r1ycTs/4jPCRMLA4bXMEL2WSJ85AsZ0JMB7PBWefD8rcd0RK5vN8
         oWuqSmdypF9DqhAibxg2Kf4t9S2Ne1KniJCcHxVAYxH7VW9Zm142fEhRyyrJRFxkhB+A
         tZb3VwoSg7L2mSR9prxrtN6DyyKEx23wxScULGEbp7Wcp/VrpProHjcWORR4IzskOo0H
         9OBdtWJVTnfa6Mv82GfutqY2ckWNPv0cCURelg+7V2+0xqA9qmoL1A9dyUN3FRtUgnB8
         8ylQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ss8Ivk3OqymC8x/f9L+J2Hz80x7W0eguZdcZDa7wz+E=;
        fh=9H1yTruTCpiK6n2jobKsPrSMjvF8yXWg5ZHubKURew4=;
        b=nHks9zDKxmwWN1AYR+KB86bVsGp4/GhPMPOUHd545bW9fw8bONl2+1hgHlMwRWYZIh
         1wdL6bsw03dI/8HL2IPhHhXb+2P+a/ycdmUGp1QiJSfgZHUbOebGOhBRzUPt2hyawy3U
         Fz01DqkhAC4lg8aAMcjd2NzwX6JWwSKY2Hpi3Qk9IvYoUGwY5n8QzEBdK4+cwTEyPHOK
         xkdtWs6kglD1+ETTwvYlqc+HUMQpTOn20XhGcUUFMm2nr+gH4LP3JbvvzLZ2h8zkH9cD
         pH3t6xOfI2eDp693Qgbu5mB9pElpMA5cSPyvE8DQ9mRAt7r1re0L2+SfouIC0yjSgWcp
         KeJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787319241; x=1787924041; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ss8Ivk3OqymC8x/f9L+J2Hz80x7W0eguZdcZDa7wz+E=;
        b=L6lBhVqFS9NpZWa4D7h4mBqhfDtv/y56qf3cgAeXMxP2mJun/lAPx7yaxvdHlpwOHB
         rjEHojVLp6hyWIn+gekpn403abCkDS9hWlkEXW2SOlWK/zuUi504kAcDVhSek7ps30rx
         kGLnnT3uq4jL6PeI/2+cHhJ63PohWdjP9yOAOVlbRyoNo+vGS9FGrvCOrt2FshLBcDen
         zq0SvbG0csC0QjB5mHpMZFf9TMd9W7cinTGyLdL84kZfRiualNXSNs4GZlnWI5kpSB4N
         M+OxtWMgFuvEMJDglg55KxuRi3UKWNAX0yWDhE1GNjBke2RlQGdRzivbgHQcPSy7v7B3
         DB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787319241; x=1787924041;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ss8Ivk3OqymC8x/f9L+J2Hz80x7W0eguZdcZDa7wz+E=;
        b=Ul9LfOri6JMqnw0C5C4Kn4guafNgjwjn3Fh8Ne+43UiqUk7iKDkoaWrT0+nHK/gs9Z
         HHVC0H1WJMH5TwujQCJOb3/MZF2yceAbOWcsuSygrFJQSsBZjVTGQ41KvddLErP3WJqz
         mIITof2l+OEbtdqhYUvQ5+l4hg+8JASpqabsv9ZGzWmtW61y9zGjhjG+XtsB7QR7xvkZ
         5Dn2IeTlOkyPWcX0fTR/nwsPizzRQ78FusAW4DQHDoHTRQKd1sF9chukLfF246HnQyah
         F/pt/Lt5IHkeHFhtr5rsBHYmufbaiHiVNMXCtQpY01toFpZA4+e6IGN+XFsYNn1EfrJ1
         qecg==
X-Forwarded-Encrypted: i=1; AHgh+RoDn960V3ITlrAvqfFEVRJhHaGPgG2svWx8xV1CjiESFWdf+QOSXssXW8YupLqZb5ZIP54j4ZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3BihWg3COaVaXqvb+xmVGjkHM5mKf1ngMPqY2/o8ti9RvbWU8
	BUfskSsBpNXfiQM9l6y1ZINrMYMEwE4O6OKqLy9KFV98zFCVDWR9WPPrhg4KDNsLBk2i9MUwJd7
	yr5Su3yHnaBp1R5zKPy2mHxiDws7688cYJVLolcxT
X-Gm-Gg: AR+sD104s8IukAeDST4YehAQJ/iLBLJf/ZGGkh6G0/0z4vUHV4RqqilSRHPj+fSBTKz
	Cm1zi+jbJOiAy/ZX5+XZjsi1mREoGQm66bA21ZdtEyBnvLGItx9F/97sjE8f+ystognC4k1gfkZ
	DKXLgCftl2qcFoUF+lc5RvoJr+NZW/LUpppBxkKCSU89TE6TI9zPVBW0TL+lHMG3rAzWS252VKb
	GGx7NNvw3IXZEi/2IgqS8U+W3JsQgNnAjxaS6ak+n8ZfKMAkdnSFGt/nI9QA5b+sqbD/kbhLWlz
	imye0Mm6ZpnPd2Y3tdFPOCKmM7Ykrjw+2cQwaDZlQ3P31vQYFb0c90mM+z28fuPOJGxro8/78oF
	FIXFgXePoVwAMuDq35g6oQnbszpgAN76JhvK4A4X7jYXkavUNmOI7Ez6XBQbXDZ6Honhm
X-Received: by 2002:a05:622a:8a:b0:528:17d9:2d99 with SMTP id
 d75a77b69052e-52df5a748c7mr56019081cf.43.1787319239877; Fri, 21 Aug 2026
 06:33:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821070512.3122442-1-edumazet@google.com> <20260821132600.GA1114497@ziepe.ca>
In-Reply-To: <20260821132600.GA1114497@ziepe.ca>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 21 Aug 2026 15:33:47 +0200
X-Gm-Features: AcwNN1V6oNdvFwAAv3HY3JcQlXjx8ONj-vvgS2EgMpIJf3AFwislXa6y7fMMyxw
Message-ID: <CANn89i+qesZmW6tO6tOPriGYYqpxr+c2L7Tdvb2OG-GX0H_ODg@mail.gmail.com>
Subject: Re: [PATCH] RDMA/core: Fix use-after-free in ib_get_eth_speed()
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 3:26=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Fri, Aug 21, 2026 at 07:05:12AM +0000, Eric Dumazet wrote:
> > In ib_get_eth_speed(), dev_put(netdev) is called before inspecting
> > rc and dereferencing netdev->name in pr_warn(). If dev_put() drops
> > the final reference to netdev, netdev->name accesses freed memory.
> >
> > Move dev_put(netdev) after the warning block so netdev is kept
> > alive while its name is read.
> >
> > Fixes: d41861942fc5 ("IB/core: Add generic function to extract IB speed=
 from netdev")
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  drivers/infiniband/core/verbs.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> I was intending to take this patch next cycle:
>
> https://patchwork.kernel.org/project/linux-rdma/patch/20260812081708.3246=
8-1-krystianmkaniewski@gmail.com/

Ah... I missed that.

>
> Which has the same change embedded?

SGTM thanks.
