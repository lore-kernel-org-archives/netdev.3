Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD093D8132
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786975250; cv=pass; b=eV6jiJELrOWvMSp75VCF5doSTLu1+g6vScq4tNB5OppKpBlF3MJZsm8/MdgULmvmHrlknpcd+j4+uR50lq5YiwUNmQCASQKNs99dww5VUiBJk6ttele7ywnK3W4CTfVzNLgrCrqKQAENgFlJCJDYsqfEE99G+7EyvY651ZYIPs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786975250; c=relaxed/simple;
	bh=uwFVZizsIwbTNzT0uWAjBSyym5rWZAfIboosknJx/6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dt6BkyEpYNOdLAcMehmRUhCRvlE9kEp+rjBFL+LzUqfqtuN6pHjVeSsNKoC2ly563oAsIOzmYVZfYuWT8/khoWbUKHGz+Y9UGIXsQZOtoZ9cyRi17Yg2dToXZwzYZu/MQ5wdR4MWeYVE1v7rGnsSTmnqYwvYBSK7V2MlDk+u/Yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CQE4hu1u; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CQE4hu1u"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-52d5bfa4bafso33405161cf.3
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 07:00:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786975248; cv=none;
        d=google.com; s=arc-20260327;
        b=krKWiFFkPxf0opuXIR8tHHNE6jfnmsuYyG5H4fGgjFL6I2ryXhkzIie/JoZ0uROMOi
         hnL7dAOouSWXGKZ423PTnw8rVV1CsndlGlKGYfMH3Gmjf4bfsZW07taT0coBm05pP5Mc
         OOIC4erBbInVOzDojk4P32luqOMpoJvQRpXY9g4psLYOqpOY8oiEqfdJec56lUjgdco/
         1GJ5BVfwGzNbFK/AL0HEbi8uRsMUrADG7L8Ddy/GlgRryF0HJ0AeJNwRjtIQdZnBX9yU
         HONpDKeRGgjicpM1k9k+aoSKoJ7W1VA0Tg/8mfF7sWJTNPNfRC2wUDaXHfg+rIcbrseC
         uPcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ca9kcU3jldwd0A7QmeTrF6s2QDqxNO9NQYGZFDC/u0Y=;
        fh=V368cwkRVktXNwSKKIjNsSBUF/hVnrnSIHxoqI7fbKQ=;
        b=glqL1lrEZQn0OhJ4l/reXH0HeP8ADu8UXpMb9agIqago38t0rzrS6W8YxIFC9myCwm
         7s5LFoGE4StmEKsEK193D+pfBSCPP2DRqZEQLNrJhxPKSW31pHfLksvsnVcySdLq2yIg
         Sa1CZLgYInyVbWQw/bWbzK7WsLyAG9Uv384mm5gqevOkBU46c9k6zR/QN20wHX89lvTv
         Ll/TEopBtQWc4u0Pm7hxUekPI08YgrchFYljiZTbxKf9eT1xSSefg2o6yzVUwAhNek4C
         xJxKw8IJKlwERG3SjCTXfU2tAiAjQGtH6RF0YxS4HeKLpyLsIaZf4Kbm1clReE7V53un
         elgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786975248; x=1787580048; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ca9kcU3jldwd0A7QmeTrF6s2QDqxNO9NQYGZFDC/u0Y=;
        b=CQE4hu1uQM4iW7Sr0005Rq81zWM7nOyj2IecToLGQl8fInmP8RgQOUqYnCJOTINDT0
         yFQa19rCdDp8Z816RYXwhRtyT34BMeivte1l6PRreYiiJBs1XaT+Y/VFA9n4jqVfMOQa
         ps5UCQ/vC/UUx7+p4yjw45FrYZ8YNABGRRHKccE9K2QULgYG7LKGUFzbTCbYpQNfL9I6
         VDDK7EW5iKIIXLeaLuDPxU4uYtSElDfDaINY4KLIwifhhiT1Q3yjZtCya/YpMYFSkoVo
         uQ15liTsTuAFVUYOmE1FE1LhtppWMqkfP9fasp5imFGylmlKfEm5YodM9KNlnaPyMLw4
         ps2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786975248; x=1787580048;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ca9kcU3jldwd0A7QmeTrF6s2QDqxNO9NQYGZFDC/u0Y=;
        b=svHL5kY1ByfRby+roiltysSXB7NeZGqA+WS8Llq9HoQAK9fH3bQEkJmbVSgHXU2ZOu
         V0lAlBFttXGD5CmNebgxcpXrI6CF1Rn4TJ94kinmhoVzWQ3OL5f+DsGBun2ZPQavEjEA
         72sQrP9iuaGI5zmNa/kjkDLHNqhOvkSzvZr7QaH3TM4EA+BGdRfi4KZLevKLTvKmsPpm
         u/r+0iDnWeP9zSl7vbIuv73vvfmACmYguFJoQghCCF7d+a2m19YmELSK2y42ZOprkaW6
         YjDF7Gfy/t3Xx/xuoXPpwZ0SpS5ZR438QTONTX8+R606Lox1YGkjPtXeqgowzJxIvaE0
         iAug==
X-Forwarded-Encrypted: i=1; AHgh+RpiP3NSMEe0xTIHlZOcKnLBNtO08aM0dEt+iM65RE07RpFC26d2bsHomeSl7F6u98Rdak82VFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAStHDg04s2KhUzqGFv2H5BsRA1HngLzn+wKDkeCihCAvcm5KH
	7R/hJuX8l9oWzsWfSeojL2TPv3GUYnlMptFvHDSVcGRi/KEJDpdb9PUwt3x8whAgSL9LhgHQTZu
	/UjV+UBZ60QqZEzhz9ZDVRbGP3qYu5cYiO2VXWpuY
X-Gm-Gg: AR+sD12PjR/12OOnXtL7/BykEjofUyL7fLFHjiBK8sTP7BjZlUTLGPSd0suqTnRcBYJ
	meF79YQDqXaKPFW9y/6d572VOEMMoI/Uj5Gy08TsrcTUGJ/Zugp2U+FSgsDRJOmMfmnqZGd5eFf
	XYOKB2La4ywFWPLeZkoWuGWz7kaGXy8j8ruieglVtKM8uR+BUnf0GFeL8nbU1NVpmMyNCzfN/pg
	KCaeQdbC9jMjdSCneIph4Y5xza26mV3GS2EIxBVAY7e93i0L4xfz4cxzN84dMpHnltNE2tiQdUi
	/pb/dSCXSMDM8OgNF/CK8mwQIc3Vwgd70ZKrcc9kk3WHqjeClu09zomy79gEo0lldjX31omzxnk
	HCoYPe4kM/Sy0eY4qOUte9GY8SZyln45QKlZ8aZe8x8lOZaf89xy+FQfKdHU3uF3U+RfL8VzdYN
	GvpBAoZdYpVq3biEg=
X-Received: by 2002:a05:622a:58c5:b0:527:7027:cc1b with SMTP id
 d75a77b69052e-52d854b2a48mr280877261cf.32.1786975246915; Mon, 17 Aug 2026
 07:00:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <34f44e8a-9fa4-4cb3-822e-5db54fb6df44@I-love.SAKURA.ne.jp>
 <CAAVpQUC672LJN_8KQ5BzadS26FnUrh4ayjyu-n5x=W7U69u7fA@mail.gmail.com>
 <CANn89iJd-s+mocDFXgt2rtFQVBGNJ7xEy=tUMKa5Da+brptXzA@mail.gmail.com> <7d6d4139-4389-4083-8569-ab2b7265ce3c@I-love.SAKURA.ne.jp>
In-Reply-To: <7d6d4139-4389-4083-8569-ab2b7265ce3c@I-love.SAKURA.ne.jp>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 17 Aug 2026 16:00:34 +0200
X-Gm-Features: AcwNN1Wiy-lwEjDzzPRbaOeSLw9IZckGj-lL-sc0Chi20Vq2LykaPRnQK3yCJqE
Message-ID: <CANn89iKwWFwRxEDvw7eUPD-tKL_dvYrZeye_3be37q6qYzQ15w@mail.gmail.com>
Subject: Re: [PATCH] net: make sure final 'struct net' free in
 net_complete_free() is always deferred
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 2:59=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2026/08/17 14:26, Eric Dumazet wrote:
> > On Mon, Aug 17, 2026 at 6:28=E2=80=AFAM Kuniyuki Iwashima <kuniyu@googl=
e.com> wrote:
> >>
> >> On Sun, Aug 16, 2026 at 4:08=E2=80=AFAM Tetsuo Handa
> >> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>>
> >>> Since there is no serialization mechanism (e.g. the RTNL lock) betwee=
n
> >>> llist_add() in net_complete_free() and llist_del_all() in
> >>> net_complete_free(), it is possible that net_complete_free() finds 's=
truct
> >>> net' as soon as net_complete_free() added it to the defer_free_list.
> >>
> >> Did you see a real issue or is this based on AI report ?
>
> This is a theoretical issue which I noticed while writing
> "[PATCH] net: add missing ref_tracker_dir_exit() to net_passive_dec()".
>
> >>
> >> netns_wq is single thread workqueue.
> >>
>
> There was a typo.
>
>   Since there is no serialization mechanism (e.g. the RTNL lock) between
>   llist_add() in *net_passive_dec()* and llist_del_all() in
>   net_complete_free(), it is possible that net_complete_free() finds 'str=
uct
>   net' as soon as *net_passive_dec()* added it to the defer_free_list.
>
> Old kernels called net_passive_dec() from only netns_wq context, but
> new kernels call net_passive_dec() from not only netns_wq context
> but also other contexts, don't they?
>
> >
> > Indeed, this patch is not needed.
> >
> > pw-bot: reject
>
> Sashiko did a correct review (despite the typo above) and is reporting a =
pre-existing issue at
> https://sashiko.dev/#/patchset/34f44e8a-9fa4-4cb3-822e-5db54fb6df44%40I-l=
ove.SAKURA.ne.jp .

Hi Tetsuo,

Thanks for the clarification.

Regarding the ordering in cleanup_net():
cleanup_net() runs strictly serialized on the single-threaded netns_wq.

For normal namespaces going through dismantle, they are added to
defer_free_list at the very end of cleanup_net(), after net_complete_free()
has already run for that round. If an external context holds an extra
passive reference and drops it later, all pernet exit ops and the
rcu_barrier() have already completed in cleanup_net().

For namespaces that fail early in copy_net_ns(), they were never published
or active, so they never had network traffic or DST entries attached to the=
m.
Moving llist_del_all() before rcu_barrier() in cleanup_net() does not chang=
e
anything for these paths.

However, the observation regarding the copy_net_ns() error path is valid:
because failed namespaces never go through __put_net(), net_cleanup_work
is not queued, so a failed net structure can stay on defer_free_list until
another namespace is destroyed.

The proper fix for that benign issue would be to directly free the
struct net in the
copy_net_ns() error path (since it was never active and does not need defer=
red
freeing), rather than modifying cleanup_net().

Thanks,
