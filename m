Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC70B3921F0
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 07:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787902422; cv=pass; b=UVxJYnOA/yWcC/lX89zem+jSdx99rNgzHinA64dJuA+BSMu1Z3hP4oJjm1DB1jlqZ0iA99UajV9RUWN84cf0HwCiaqK6kVhNlblEOsh4E4ahNaLvwoKU0KgfcopWdCUoGyJBCg3vGseZ4/GUiPSH09ptgeNJl4mL+IfGKS4FWQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787902422; c=relaxed/simple;
	bh=YBA6hTBM2zJKMcOv5B6eXA7s0EUOJ3bOStZg17l1SVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKAhGkxaIets/GME7ck99/8V65F8Jyr5PzfLvCqAf/b1G6LTNdfF6M8HC6tY8XFbEIM+rFwx+k+4wja4P3eLaZvc3qFoiSOQp5+nKj8dPD5o3ADqQVR9PGtVrI6XFoDeCrRObBwJTZ2nh16F4mBWLVSjsEzW/8jKLLoXsEl/uRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rr98YIHm; arc=pass smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rr98YIHm"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-939094306b0so51471585a.3
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 00:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787902419; cv=none;
        d=google.com; s=arc-20260327;
        b=qRUsYlcFzT5yd1J3qW11GtcW+Vif+Zw5BTija2TzsPFGyFuKNOCaT026uJ3j+1jN3z
         AY1hRTYNfL30ZXrJuJmPsiU4ejkticFLVFsaW9GJXA5xTNW+QfRqwJdv0O2nvBmEqcq2
         RMXlylnPoUm6sWyeBbv6Vq9BXMrBI58HX9iGJ3uCqjCOlbFHNHkGQfxWHCGQpXaNXypO
         92FA/2u4/hgLD5lAObk2VZU0a/qsUqfTi170CjOgKoXuYFbyssCv9/MbGdexBzqobG81
         GerCbDPb0jnuYsO3XOk+HoTMG/83mP0YXqZln6OXRQykMBhiY76m0jHnZMoadeWoPR+s
         /20A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MaXt8bgzgCbl3MVunftubpe4nSjxrU+2s/qgfZJp7gc=;
        fh=7NJqynM4Tg1PgKruxaBYrQzh9U8jiOELJk62DjLmvbk=;
        b=hqkTTdnV4YkJzx7On3uIeToXof5woZ7SDli46+pIVQO3kOXXu7yanBUdly9o6nn3KY
         cQuvjxPE4hF3TjM8DszCy5tFmiw6ZzWrT0dXT32zWRhtBsDCtiVmOP6A8HFwA9fgChkd
         054EfoLNQe6RkkV7UU2Mg0K9DG0tf2//1FGYpRTJeSbnLGwuuafQs7c9BLaI7mJuBl7/
         1KUQlBy9Lkvp9ts0ey85U6aiobsIiMuwFBpt9bVScqnpXx4EwNPSYubP04x0L99d4scK
         S59vkHFw/I4E6x9kwPnrJhjcpRr4cQ7j2WhbVv2lU+9psq8DC+O/e7Z0JTKDDYzjbnSx
         zv7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787902419; x=1788507219; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MaXt8bgzgCbl3MVunftubpe4nSjxrU+2s/qgfZJp7gc=;
        b=rr98YIHmIvdYQBvxdtfM9wI+6XhcIxjTJwNrT2UEnrL+6yn5X0RpVeXpCOx4RLhg5M
         TpEITtxitzrShxM/Z5Wte2gmkdXqDrkCIXEt/xgY7T5dh5L8YpNeVvVLi+e8HRlJqv6d
         RlJisXMOzueTLBkJKzCgCKBxVjLaIVOK8zEoH/UNAnqlHmMvQ/NQ3vWUO6wunNJrwo3d
         O2Qpsbu1Ae3gi1Q5XToXQCZyMnT0Jh0Ple4a+QubeOwgjnoxi5cq2lFmeboKgCWaSaWH
         JxO8HN4qKexPd1OVIjNE/3jaaHgNp/9JBuxOSWsvBrH//s2ve7ccm/Dct60jTv2vg+Rl
         W0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787902419; x=1788507219;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MaXt8bgzgCbl3MVunftubpe4nSjxrU+2s/qgfZJp7gc=;
        b=e8Ta1eUGCsu81EKumJYdwm32zzzCN3U8VteeMP0iHLJ0HKfWb7BI6bGs9Z1+6fYLvF
         j6JNjUZbPbdWeXTaBW/JoMtmHvDaIoSdyMQjCQL9mAV3sTDDDG717gRVr6/0lHu4+0gk
         j9rFh2FVBKD31gn5TmNvzjvn8hYl59i/AzNI7b4xRybh5VFOfBbWXEKEMQeXcinidsnX
         nTa7VApzIVDrU76ASOEUNmowUVhUGmBFT8ooDIvUKYs1HI/kWK+hZSqrbq1yQ2QmvFwU
         xx9SUWJ+E9PozKITHvV2NFqjNSKiJka+bX97ZZgoarAJ76UqsffpiCFrljrzjvyjMw0r
         e2xA==
X-Gm-Message-State: AFuF++kUGMNUJKm6gq1021mptjRmUTSUJLR/1ijgDDlGsu11j2w/mn3W
	eSn+Rf+OYtEneZrzqdzcvpkHMf1QZCR1ctPLURzBGcL55KLQfJIyGKdFjdIo4u7VKd839MLcnDc
	IPJy51zyzCwc2ssk7Gs62FTiKFEJownbY7VktVK4t
X-Gm-Gg: AR+sD11QiFfZ38W2dhs0r0PKpuGAd5C3j3Q/zgugjSINAaCWgXnf/hbe4xgAA72BnUw
	BiDETZ6n7ZLBDb9s9da+MYtFu/SRelnzWLk7aGl/4389xXSYDuT5INxN13XUtnVMrVesDo/35CJ
	kchk0Lv4s2rxcDw44hmxeDfb+RGLg7tSdUpqSJFwA3XaohVM0SYrSZ6vKgjTqSCySwkZzK5ZwLs
	8cozfvszeNZlq0lb5dko5BwbtV5MQtonDCb8Bt8q4npfdbFBwsPALchuxDiJ4fCMiHlsnKFEtub
	k+x3G4aYEcOzcwwddNjxxtxa7l8sAXTUBfXHR0e9Man903BuSBv6KyiwjEEnT3rZrogoAqSAKXr
	lQ3i7a6u5LGQMVv2N2Bz4JCr1ZwaUmE+//0YlqkDoqmCr8bL3cvKRrzoaCJY=
X-Received: by 2002:a05:620a:2852:b0:938:fd59:cf9c with SMTP id
 af79cd13be357-93913904373mr529822085a.24.1787902418813; Fri, 28 Aug 2026
 00:33:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787854085.git.zihanx@nebusec.ai> <a31c6fb1ab9846c85e245fcf34948ac2bc27e521.1787854085.git.zihanx@nebusec.ai>
In-Reply-To: <a31c6fb1ab9846c85e245fcf34948ac2bc27e521.1787854085.git.zihanx@nebusec.ai>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 28 Aug 2026 09:33:27 +0200
X-Gm-Features: AcwNN1Xwt8ZkRbVLESHeyULoFgOkxvi-Dh5BUkpOANwSgHRWFFlEenhIbtckd90
Message-ID: <CANn89i+1xLiL=nZOwoSH+OwX1+8io_Cd2_5b4s-_NcN+kBh+8A@mail.gmail.com>
Subject: Re: [PATCH net 1/1] ipmr: restore a limit for unresolved cache entries
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, stable@vger.kernel.org, Vega <vega@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 8:52=E2=80=AFAM Zihan Xi <zihanx@nebusec.ai> wrote:
>
> Unresolved multicast cache entries retain up to four received skbs while
> waiting for userspace to install an MFC route.  The cache entry count was
> tracked but no longer bounded, so a stream of distinct source and group
> pairs could retain packet memory until the system ran out of memory.
>
> Restore the unresolved-entry limit for both IPv4 and IPv6 multicast
> routing.  Reject new cache entries once the limit is reached while keepin=
g
> existing entries available for normal route resolution.
>
> Fixes: 0079ad8e8dc3 ("ipmr: remove hard code cache_resolve_queue_len limi=
t")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> ---
>  include/linux/mroute_base.h | 3 +++
>  net/ipv4/ipmr.c             | 6 ++++++
>  net/ipv6/ip6mr.c            | 5 +++++
>  3 files changed, 14 insertions(+)
>
> diff --git a/include/linux/mroute_base.h b/include/linux/mroute_base.h
> index 4d55827e9705..af9247bb3f4d 100644
> --- a/include/linux/mroute_base.h
> +++ b/include/linux/mroute_base.h
> @@ -224,6 +224,9 @@ struct mr_table_ops {
>         void *cmparg_any;
>  };
>
> +/* Bound unresolved MFC entries and their queued skbs. */
> +#define MFC_UNRES_QUEUE_LEN_MAX        10

Wasn't this very very very small limit a reported problem in the past?

Nothing will prevent an OOM to happen, even if you set the limit to 1

If panic_on_oom is set, it seems to me that this is working as intended.

If we want to silence the OOM, just change ipmr_cache_alloc_unres()
to add a __GFP_NOWARN?
