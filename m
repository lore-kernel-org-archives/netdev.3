Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005E03B52FA
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 12:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785243055; cv=pass; b=jSFcOVTEG+oh/pNuZV5TY/cGYubGJiF3z6vvTH+iZ6FQoet5B9NE42T/az4pBoFG5ekjUQ1+a0+j1+/T2RrawSvcNgCYizziK/s8IEJ5eelU7Jkhot3TNAmIlNlFyipjl592VuH3Tg5HTQ9fe2dBjQjRmXT0CJVVqFd7P2mavsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785243055; c=relaxed/simple;
	bh=ciilDS+xRvPxsVuFSlMssShZX6uxtvggWQJNgCYLgG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEp/tkmop7m0ncwulfU6lINn2SI5mxJHI0CDZ7mp/Eq/nxH9kc7eB/+JT/A9UMbg14hQ+oPl1gWW8WRaAQW7V41TPNi9L5nY7Ar2vyoLDndL9EOFCYe0CbZH76FhW/tg0+W2NPux7b8f36zCK7XdCLKMHyRe9oWme50o7SwvF8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+n6tm92; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+n6tm92"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aeb98460c6so3981296e87.2
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 05:50:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785243050; cv=none;
        d=google.com; s=arc-20260327;
        b=a66r9laTHUSPKV8tEYCo1HEYiUtetLSDLS17I7xCZ5eq6kSvgHziDL59lhZZ7mPpsE
         2pXSVtqmZ/nqIPjAFNrMOL1F+Jof2cshzyCHnX3wte74L2U9Uc6yUdOSXD0aFKpYwmwl
         uJ7f6G4acOP0SMq+oC3G3METjMtbjfSem5oYt4bzexXe6im5hGMFm4ikX5s+a+haliHH
         qljSL35OZIRsHkX6oKSSmk//26fr6BiguC3BOmhv5Nl+396wQyU/rEweT5Up+7w4vXIm
         Ov9+F0Hjhb4FIhyfAitlM0ueU82ebwiDYIv7LEESD1TcSG/SYj4sO6jTdPbpcVN3rwWL
         RtEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ciilDS+xRvPxsVuFSlMssShZX6uxtvggWQJNgCYLgG4=;
        fh=Iqvx6IYhijrg9nwb6QLMjU8LjJpt0R8Wh+fPNeJpDNQ=;
        b=RwLDdF+f70+K8Di0mHw4eKS8U878IGTcvZ/33eG7hL06gh9Op6btvCUebqkDCnMle8
         XLgr/XH9nAcLldPFAhEXtmeCNQudj1Gxx4VQM+06iXbWL6y/7jDMZfxAa/79ANE8fxtf
         YJwAVR2lQDUoey68ehuzktpIRDcicDRgZqaLzdXMC+TXpxnsgPll3fcO/DSf9DG+Zlqq
         xIiGLYRu6+QZnV70EQym1V5+o4fCibMpP5i+qsD4SjtTkeY590Nsd6fiz2YxLN/sT/Td
         JB1ptrANclX0Imt7PTawmm5UPOqLprbbG52sIp+zRNqhZhTRpIhPQo+gVam4hOyFlGbu
         q7dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785243050; x=1785847850; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ciilDS+xRvPxsVuFSlMssShZX6uxtvggWQJNgCYLgG4=;
        b=G+n6tm92KuLMl/NClb9QGiwtrtfwe7NeNt9XuUlW/bESVrpppHqpwcX4GB7YMgSYOM
         YV9fn4QrZ4azpW2TO/2luvJhk+zud4cTrOWhHxjjHrom1+79UF1nVTMlhNPtWvG03c1e
         iqtlasI7SFj887Q6sI4sY5Ohv70r64FvR9ItAfZpzUYY3qM7mD1T5BF4GBz686waJuNG
         Dh11Zw6D44kEbBUojkwYyPJLeRSFeJkdc6rr9TjeMJHZfw63UhTk3Ety0fQhc66dIkyv
         D/FID+hDmooKtVMLCAt1GiwFCD02Jiqc9Tu6sTRD9N10IwnBW2z3x9UZSvBQ9nehrHGm
         qb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785243050; x=1785847850;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ciilDS+xRvPxsVuFSlMssShZX6uxtvggWQJNgCYLgG4=;
        b=Q6bu6PDkLfuRKMDISkzcGki3nzsNmz0/8h6fq3eQSfqVtjwnx3MHZWmEeqYpy/UCJ+
         ecC02b18lCZPQu6mmfO/XyTUgryWbvxIHRODzdK6/KtwF89KG9SKkvqeC4V+x/8YPbqT
         6HfAjVHcKX5ENBvymRjhCfrwYL4Y7n6WOHjVJ4X1LnE3jm92T9f09MoydTvQOV6zzWa/
         BFoACb/r9g2hnboRJq8+kjJGmyrKtERtC/KRflQpzTFze8B6Dq0Qulra4EaGVlTIxXbI
         f6UjwYnCsEIBDFmks4+5Few61+KkVJb5GobDqKOXkFBuV7P/zeewFNsyAsPEQ7EwE2wT
         Mkdw==
X-Forwarded-Encrypted: i=1; AHgh+RqWlpCrJ56XXa71R9xfj8kY2iHMfYFy7773tbGHMROMnMDcpoMmdB5917G2s9vyHEGnbl2rfYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkxf/opCstmfQ8oZWY5IAFmUaUUI0MFlWr7PrKevAX95mM5FpG
	Yl9K9YDiWQrg9X5e/+mqfMUjrvllPdw9UuGQe0Tg/IwwIXua4vlCqkHUFtthzbVfqlvda7/2ixH
	fAFJvOusnudjPpH6giOBffFVHikYsS2Q=
X-Gm-Gg: AR+sD11b7dYaovqVM7HM9HC2yRmDEyAjKsswkcWqidd+N6vtdPPIPcClT+rqSQvZDXQ
	xCeSB55qWxD1t/ERHZfALfGzws4Oz8Q7RkN5XOvcdbmHSyt0qm8Db9WXdP35bSciTBZQ95Oj9Q0
	VUgTkzPxt8GIt6RjA5e9nhilPWVQIFdV+5kSD/y6e023aiJw0X8Lwle4lO2VJACenXmViP5qJUd
	lSnwnPJFOeMBiP5NjcR4e/eURKJGJx9anyUrbjGngQH0qu95kNQsP8u7EzXRb6VYKOzr20MitL6
	spxkgeyXspemx7HqofA7z8AAUvv51/expevIltty1dv4YZMnDg==
X-Received: by 2002:a05:6512:3d92:b0:5b2:aa5d:9d34 with SMTP id
 2adb3069b0e04-5b2d02549demr532927e87.32.1785243049814; Tue, 28 Jul 2026
 05:50:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725031214.43059-1-sigefriedhyy@gmail.com>
 <20260725031214.43059-2-sigefriedhyy@gmail.com> <20260728101318.GA849975@shredder>
In-Reply-To: <20260728101318.GA849975@shredder>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Tue, 28 Jul 2026 21:50:38 +0900
X-Gm-Features: AUfX_mwsdRbo9fWBs-7B6gagL8r82IARkhC2JhHbxB1AoFtJCjjAI5_hFuH8Qms
Message-ID: <CA+7S2vLgC--DOw1VLkRgpJ-X3pW5s4uox2tD8QFHzL5cdZjxiw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/2] ipv6: report why a route was deleted in RTM_DELROUTE
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Chris J Arges <carges@cloudflare.com>, David Ahern <dsahern@kernel.org>, David Wei <dw@davidwei.uk>, 
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Gal Pressman <gal@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 7:13=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:

> There are too many changes in this patch. The meaningful changes are
> mixed in with a lot of churn. I suggest splitting it as follows:
>
> 1. Add the rta_del_reason enum and ip6_del_rt_reason(). Call it from
> ip6_del_rt() with RTA_DEL_REASON_UNSPEC. No functional changes.
>
> 2. Propagate the deletion reason argument from ip6_del_rt_reason() all
> the way to fib6_del_route(). Purely a mechanical change with a lot of
> churn.
>
> 3. Change the relevant callers to specify the deletion reason instead of
> RTA_DEL_REASON_UNSPEC. This is the meaningful change.
>
> Now the only thing that is left is to expose the deletion reason to user
> space.
>
> 4. Add a deletion reason argument to rt6_fill_node() and pass UNSPEC.
> Purely a mechanical change with a lot of churn.
>
> 5. Change rt6_fill_node() (and rt6_nlmsg_size()) to expose the reason to
> user space assuming it is not UNSPEC. At this point it is still not
> visible to user space since all the callers pass UNSPEC.
>
> 6. Add inet6_rt_del_notify() (see more below) and call it from
> fib6_del_route() with the deletion reason. The inet6_rt_notify() callers
> do not need to change.
>
> 7. Add the multicast groups and the notifications to rt-route.yaml (see
> more below).
>
> 8. Add the deletion reason to rt-route.yaml.
>
> 9. Add the selftest.

> At least sport and dport are only used in RTM_GETROUTE, but it does seem
> like they won't be rejected if encoded in an RTM_NEWROUTE request, so I
> guess it's OK to put them here.

> This hunk (adding the mcast groups and notifications) is not related to
> the deletion reason. Please split it to a separate patch. There are too
> many changes in this patch as-is.

> Why not use enum rta_del_reason like we do with kfree_skb_reason()?
>
> Also, only one caller calls it from the deletion path, the rest pass
> RTM_NEWROUTE and it's weird to see something like:
>
> inet6_rt_notify(RTM_NEWROUTE, rt, info, nlflags, RTA_DEL_REASON_UNSPEC);
>
> Maybe create inet6_rt_del_notify(rt, info, del_reason) and have it call
> __inet6_rt_notify()? Then we don't need any changes in the addition
> path.

> Please use the enum throughout the patch instead of a plain u32.

Thank you very much for all the detailed reviews!

Will adjust all the items properly in patchset v4.

Yuyang
