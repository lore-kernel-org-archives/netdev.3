Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120A63033E6
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785772179; cv=pass; b=CdLaFVGKj/BU6J3rly6IjsmwIza38CocXgWdZGW87g7ZseMcfknbu6Z+9SQIaouFuCedf77KHaFiV2mH20/2RAzj1goz35zpnMiGJyoU89GxUTxJ61B5erZzJuvuY7N/hYiSOVG+EPL34cybwmEwHqwM/QZ+rCnoCM6KE4BZTns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785772179; c=relaxed/simple;
	bh=DOlMtvCfJ7o4VuuBFoocy6J/auvYReWhdXy8N44l1T0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B0kcMAsdTY6INmDVOGKmKajzMBWdvcQest+tzEDwxskoaQYrpsa/Qms5OSeKbo+QAdTfU1sMMJLKejARL2yR/9AIBRQDF3iFkm8rFSzwyxxqJGvDMmZ8ebJLc664CgN/R/m8AM0NsiaNjZ16rzVM1xAFjwOcKR9LzCHAtinSvLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bYNliSNY; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bYNliSNY"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ccdf36f63dso178435ad.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 08:49:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785772177; cv=none;
        d=google.com; s=arc-20260327;
        b=chHH/TyTTiwdF/+4JV59Qks7THMu8Zkfu4N/qMZVnCLyKDpF5xJ69iQMimQqU4wGs6
         Fd8/eFykPDQbtPrQuKjuKUm2cKUjrlKaA2C+C3XH27fvEekxZTEJ7h19UjfI3uqzaH2Y
         39tnm0EVnZQFaHRD1PkJQC5Hhn7RuT573aSl3QLv5OaVpgzxoszYrI9SGxZPQtvkstkK
         TlMEt7T6/x1TLb7bE/Vvc2oy7M6QgUTEBKxrzs5ZHF5FNY0YRM5VznGYVrkC+5I34FCW
         8RlNFwkFPPnDuLqsS0gXjS2IHkRcfVr6lLaoyf5P20SqS8VjdacYzW6O1R2rwwy8kwnU
         a9DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bDDUbDBbcdgvHo7yFBS+jBx4XPTog3/CTIpeljXK+o8=;
        fh=CyfXAbpyHBrJpK38L+j6uFGAPixO5JDsMdP1sA24GeA=;
        b=jx6SpYZ+kJEZEQ1e3SUuGdFlwSzfdtdrcUF29fh3vg4UeaWcDCAICUhvH6Z0Hav0k1
         rWEA8a9NlMoC2vcrlPpenoGB7yn0oQuZwdtYA1c/Ik3mxFXET6Jasvh1UDjUlo3o04i2
         6r2IREiUMgUsa61EzaZFdpAoVbNlF+pUjVFjz7JDR/ce7Cm5//31o7buNSpWz918M63r
         8GPbIsURX5ddbcyCJ4zF3eGlAmDAf/8mZg+o0AAb0JcnOmrfb4b8KwYQmJ7o3Ez7hy3L
         yGmztJrjru7lRyUW1XG7F97RQtgkBZUNTjbtqiqc5/U4Jio3/P08CDNRzGsGOZuK5LP2
         S7fA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785772177; x=1786376977; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bDDUbDBbcdgvHo7yFBS+jBx4XPTog3/CTIpeljXK+o8=;
        b=bYNliSNYpok+ie1TF2lN9zkPkbAUAae2+ag1gpK4p3mLCXZw+3ccK5l+sGp91R4tiN
         VXYaxUzewep6vgHMqqksvmplscVT6pwFMWLM1j4F0J1kShPJlcgsJg11A2C+fZkwFk7C
         ntnvvh5ADChJhGyRnPE910wB6z+yD/HwAmUbikM6ZfViNoUf3vd43AMbjKRwfEJEUUZ7
         AfU0QtsYQmOk8rJHdd+HtVJkWMC0X5QKfsuFSG04A90wdsTWImqHL9hACrQrjdo8e8V2
         SYyGowOSy1lmJZboFFkwSIJTltJujc2DDaXM4m1y32zAV567yuhSYZU+jUzD5Lf/lxip
         ex7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785772177; x=1786376977;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bDDUbDBbcdgvHo7yFBS+jBx4XPTog3/CTIpeljXK+o8=;
        b=jT3qrWS+md/3yeUlK9LlI7IPx0oHPjhfL57C5MSaqgHA/7ZFYI9JFD0ialINTjeuks
         XeoFQA+//FA+pT8cJD9xLUrJiOt+R+SEsxfgArX9454qRNA0Bm7Unyn1h7+5afB7oRE9
         vn/gFnTUDYHhik190yRzOmTUTj5DQK+RdbE0/EXk88kybXO++TwjiWiBbtWoF3hZbO8D
         zoTB/Q4vVVg12zDm7Q+u/xe6rQLPbqhbi6Ix9KPnQnwyn19QOoIYemsWl/S3+jd2+zkQ
         MCe5lC/8LAQnFUWUbt5llnlb10sJiXP2PB5fafN9hY7iSnchSZKBPTK99YAkC4oxA9rt
         BcdQ==
X-Forwarded-Encrypted: i=1; AHgh+Rprh9LP4JSkZe7f6xdEMIALjVy5UL02CMv2DvFdkIXu72gdoTG8JXSXLYMqM4IChWptumGBu2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx58iBfZQvAlgIVeiieTEIYI57N97bnQtXCEhCpEDGK4eV8o/o+
	LQHdAw00OexZ7RNwEqYkQ5a9KubruP16LjnYz4dBzrXQLuEba7CMchGQauvvyYKsOsniIVevP6E
	6tH8dprd2GATZ3ImpQs/XlGAooHCumdOSvS97DukC
X-Gm-Gg: AR+sD13JeB36FuvyWAUQt40PmPuhlgADorfQfDeHbYYRWBLMpxYyGMplFy9kf8OCBAy
	ZmSg+QsMgV2S1Kj8xY8oCliQT/7+iZdVhA/E68+LLtmBKNIUM+qa0wamk04eSKenI8UImuRWGN3
	dYUy/+NdoKeCwHXNdsnM16+g6E86e+ttLKtUWDnIKFYshVlvZKLThQVAFbaHmH3XGS0ikAm0nm5
	8RKMtH4z+O9m1ryxoxU2VkE4CchAkb6Zu3H2bEsZ7Jv7eDL7CYdfAK5BoOPINKqX/gTYttR9jUY
	sjXfKcqqQ/HPcNC52RWJL98bDk+BV56QPBTXiO0Mxt+wF79XFgJNuTA=
X-Received: by 2002:a17:903:8cc:b0:2c9:b404:b55 with SMTP id
 d9443c01a7336-2d0547c47camr19813265ad.6.1785772175105; Mon, 03 Aug 2026
 08:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260801125308.1342897-1-almasrymina@google.com> <11a640b6-46b1-44d6-aee6-872107f7f570@gmail.com>
In-Reply-To: <11a640b6-46b1-44d6-aee6-872107f7f570@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 3 Aug 2026 08:49:22 -0700
X-Gm-Features: AUfX_mxuRZE_5YlrLRVNZUt9l6IVegdW9lxgyK58unN17IDZUXqeuLXiKHOfNHs
Message-ID: <CAHS8izPPPnjQyEZTYbMTMTr9rMOfKrmYPSUG0syHf=O1OOtYQA@mail.gmail.com>
Subject: Re: [PATCH net v1 1/3] net: core: propagate unreadable flag in skb_zerocopy
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Florian Westphal <fw@strlen.de>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jason Xing <kerneljasonxing@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 2, 2026 at 5:33=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.c=
om> wrote:
>
> On 8/1/26 13:52, Mina Almasry wrote:
> > When skb_zerocopy() copies devmem payload fragments, it fails to update
> > the target skb's unreadable flag. This causes the target to appear as
> > readable memory.
> >
> > Propagate the unreadable flag if any devmem fragments were copied from
> > the source.
>
>  From a quick look, it doesn't seem like the function would work reliably
> with netmems even with this patch, but that's a different kind of issue
> we can return to later. Curious, did you hit this in prod?
>

No, this is sashiko report on another patch.

I think you may be right about the need for another check. I'll double
check and if this partial fix doesn't get merged as-is i'll submit a
v2. Thanks!

--=20
Thanks,
Mina
