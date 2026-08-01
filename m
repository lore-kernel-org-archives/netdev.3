Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A81264A86
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 14:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785593520; cv=pass; b=Nii0kmp7M8iNJW0oOok360xTzTj6gwNbLJ4chZnzHPTRm6fV5lNACqu3zW2/GXylVFCBuZ05efEReaRBoKZZgZTNrDloZBIXNakwct82vDMORLbV7yoLTXtO5zedbdr0fvT60DtnBsgh8BYyeEutWlY8QK5RdkKWHmuA2zeDfno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785593520; c=relaxed/simple;
	bh=DIiuqkdIjb/ctIpjHpwyoys7CyUZDRQZHO7tc6VIfzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EYK6E/I9KR1R/49FbqNOMzTwvl+Y46BpoVkoRwEWlZd197it4ZEOXJ1S8+gMFlIhF2Uvh0xZYTQcIaGGFEuSTW5peWdjtBjOcc0HgxZlqhw+IrjPMJN+J10fIfD4/zwu3wJbayjpErEiv2gXG5t9VGa7bXXmE3wjeWCGsuUMk3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=hC9b10Gr; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="hC9b10Gr"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6685483aad2so2908213d50.0
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 07:11:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785593516; cv=none;
        d=google.com; s=arc-20260327;
        b=jUuSHJpD4Zip7003ueInQ3HZdFfkUYPnMx8XJLhZgjXm1B0+yHLjNc7F8LUS82mu6m
         4q2jlELS4uaxKUfv6L/ax8+nR4v+iuSH5x9ay7ZTBDH/AS4W4wEXi4LvxUTwvOa8iC17
         8T0izWObpYDV+s/GDL/RySk98aa2zomkwGq8MJnHGbJt+K+Fl4C9/kYjlhQHYZN7H+cr
         QYUeDN6fHp/f5971nhMpAtvXS1DfHOZlXmAflE4ZFm3j43c2aTfw7osNgZJpGAalKpyt
         N87QDtFJXzKShES9/VFEgnUIzrwJZQrG5b9ZIgRCBjMKGKWOMqPBohWJIRWQbGFR1ahW
         fVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lY3DBNb0yDaL6jMIr8DirN39C+BBh8jbElIyoEBUy24=;
        fh=2b/p8eILayIRMMhi4EcYALq6aHx0HHIpXO9DKD5N0bU=;
        b=AJYaQLG83mt3HIo3MxGB3Pe8qkdf8nAhjv4scXfs0esfwXQRAKd9M++hER2ULELPg7
         rJ+htvmF5yit/mHhobvrYwEfXf4ZIIA+Zx+mxEorbI9uFhuGYD2OTAvadLZsTycPyJ8h
         PfkRtxl81kTZbMmmx0LIvftLYUOAuSfRL9NtBzzpeYXY4MpaVxCu/qNLMSKqOJ4vEw2t
         CnwJgzFsSwDQy1IS0s1DdEjC2yp90YTCHc3AVSGOiI25GIl8WB09CDiDr5gqrRHg+cAQ
         O/EUGHEmisQWUijPg8zi6/BwFr70jkjopBP+Cpzhzx8M8zhWgYmnY/ailoGyQGQTkpsb
         SveQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1785593516; x=1786198316; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lY3DBNb0yDaL6jMIr8DirN39C+BBh8jbElIyoEBUy24=;
        b=hC9b10GrUKgj/o0Z384XwtCjuG1NtZzhtX1yaqmdaNs/jf4YuRwLhbYoSRF1p7mjaO
         xuENWqIuUhKj6e5kt1Qj3xXr7QqNNFmeQt6N6rf3fjv7cUa+4JW7uGEQjH+kkPlL6DxQ
         nnHACqJ9X2hMGwbdI3K0ILDuXLAldTNJbEVSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785593516; x=1786198316;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lY3DBNb0yDaL6jMIr8DirN39C+BBh8jbElIyoEBUy24=;
        b=MAqlT3KTFgk7/++by2do/ZOyhT3k+4Sw4QfKmnegYe3q793Hmn7dFDmeUkNAOincJN
         5jVMJXqGr3SF/biFj7liKycyu61lm59Z/NfKpyxY84KlVG6XtiTjr6Iku/m+zuoJMfpD
         Vg7DfSuH+Smre8ZU2HtzlywA7meHjUs2VvMn2bH3J2tcVnjpzPoG9P+xo6PVacib8mML
         xB9B6DnzHD+1lGUmjZHJqQyUBPFyhcr/y9nST0sZPEGK+PSOSPICRC9WZRhl1DvMwEgI
         jm2tlsUafaS1iWzQCIxpUHI1xxBY+iypL2LJ0BWcv4UREwF1BMufSyPr+uXiFdlfQFVV
         Yqwg==
X-Gm-Message-State: AOJu0YznoSaHqqslwVXyvmqFmIxWO824xeWSeOaBuY26P6RacD591jr7
	nhBprbBdX/WIyevXeFPGnnMFjyauZxgaOFnUJnxTO2vnKT5ZnzlhloNH0+ICeVp6M8mjMxa8CsC
	I7vBKRGEpWOy+00VtWUaTT+zuV3d8P6iZ/OQjHXmJ
X-Gm-Gg: AR+sD11oqZRYg47WmMpdA6/meB6VUo27ELDmxnwrBz0F3ca8jUTanj4Bf6UWoanv4DR
	8mS0GdmUFW5UizMdcmfxBmPTCzKJWoqlMDCdbdDORY0EzoeWI9oAEPfn8jWdHfKvQJy0BVOASHY
	plxkLFd8CaRht2f+TmKzFD3WF4K0R1b85IN+ngr0O0itMF3TQiFvObIoov8HKStzLeNLaedJpEY
	EuD7y3i5m3qvBN9Wto792y7yxEIOssnvGJ/UmbrYvoN8Y0sD670wnZXHbuJwZPKnrEXt1bYZ/4s
	9uNBG86DcWcwYbxbHe2/AmZIknLCtGSARXRvAc6HMkxyw7OgXCMF2T4m
X-Received: by 2002:a05:690c:6e0b:b0:7ff:19d6:74ee with SMTP id
 00721157ae682-81fd4c1e186mr57279427b3.33.1785593516164; Sat, 01 Aug 2026
 07:11:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785434373.git.milkory@outlook.com> <1e9ab39597423fd5d13cfaaf52279b8ee3d9fc3c.1785434373.git.milkory@outlook.com>
In-Reply-To: <1e9ab39597423fd5d13cfaaf52279b8ee3d9fc3c.1785434373.git.milkory@outlook.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 1 Aug 2026 10:11:43 -0400
X-Gm-Features: AUfX_mzVPrYcO4vRECCIDiMsA0UZw6dhtJDjQlWPzZIYPkvX1yQD9jF19Hc0HRI
Message-ID: <CAM0EoMkEA2shJB9dBt_ZfDrZTzCZdvbggFNFdnAUz=gKkDcBQw@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] net/sched: reject overly deep qdisc hierarchies
To: Ren Wei <enjou1224z@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, 
	vega@nebusec.ai, milkory@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 1, 2026 at 9:42=E2=80=AFAM Ren Wei <enjou1224z@gmail.com> wrote=
:
>
> From: Zijie Huang <milkory@outlook.com>
>
> Deep qdisc hierarchies can lead to excessive recursion in qdisc tree
> walkers and exhaust the kernel stack. The existing loop check does not
> cover the create-and-graft path, so a hierarchy can still be extended by
> creating a new child qdisc below an already deep parent.
>
> Store the hierarchy depth in struct Qdisc and update it when qdiscs are
> grafted. Reject new child qdiscs once the parent is already at the maximu=
m
> allowed depth.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zijie Huang <milkory@outlook.com>
> Signed-off-by: Ren Wei <enjou1224z@gmail.com>


This is the same patch i sent you except you changed the failure path
to send EBIG instead of ELOOP. Is there a reason?
And your feedback message is not as informative like what i had.
NL_SET_ERR_MSG(extack, "Qdisc hierarchy too deep (max 7)");
This way the user doesnt have to dig to find what the limit is.

Note: Your AI did not assist in this patch rather, I spent about 30
minutes looking closely using human knowledge.
I am not looking for credit but for your education going forward: if
someone invests their time reviewing your AI generated patches and
suggests a different path that you adopt, please add a suggested-by
tag crediting them.
Or don't bother sending any patches, just report the problem and
provide the Poc, I could have come up with that patch in about the
same time investment.

I am going to ack the series unless someone complains about EBIG vs
ELOOP in which case please fix the msg..

cheers,
jamal
> changes in v2:
>   - Store the qdisc hierarchy depth in struct Qdisc and update it from
>     qdisc_graft(), instead of walking the parent chain.
>   - Move the depth check to qdisc_graft() so it is applied at the actual
>     attach point.
>   - Add tdc tests for the maximum allowed depth and rejection above it.
>   - v1 Link: https://lore.kernel.org/all/cover.1785304107.git.milkory@out=
look.com/
>
>
>  include/net/sch_generic.h | 1 +
>  net/sched/sch_api.c       | 9 +++++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index 45a1e8c78222..cbc248776511 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -99,6 +99,7 @@ struct Qdisc {
>         struct hlist_node       hash;
>         u32                     handle;
>         u32                     parent;
> +       int                     depth;
>
>         struct netdev_queue     *dev_queue;
>
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index 668bcd60d183..65b35528d125 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -1114,6 +1114,9 @@ static int qdisc_graft(struct net_device *dev, stru=
ct Qdisc *parent,
>                 unsigned int i, num_q, ingress;
>                 struct netdev_queue *dev_queue;
>
> +               if (new)
> +                       new->depth =3D 0;
> +
>                 ingress =3D 0;
>                 num_q =3D dev->num_tx_queues;
>                 if ((q && q->flags & TCQ_F_INGRESS) ||
> @@ -1211,9 +1214,15 @@ static int qdisc_graft(struct net_device *dev, str=
uct Qdisc *parent,
>                         NL_SET_ERR_MSG(extack, "STAB not supported on a n=
on root");
>                         return -EINVAL;
>                 }
> +               if (new && parent->depth >=3D 7) {
> +                       NL_SET_ERR_MSG(extack, "Qdisc hierarchy is too de=
ep");
> +                       return -E2BIG;
> +               }
>                 err =3D cops->graft(parent, cl, new, &old, extack);
>                 if (err)
>                         return err;
> +               if (new)
> +                       new->depth =3D parent->depth + 1;
>                 notify_and_destroy(net, skb, n, classid, old, new, extack=
);
>         }
>         return 0;
> --
> 2.47.2
>
