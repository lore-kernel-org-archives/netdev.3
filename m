Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6DE23EAA0
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 00:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789516819; cv=pass; b=cyfXVIBKe/iISP3x/jDTmKeFk8bRzHxRuepnAwAqdg5FkwmSf+meNsW4XBn5xwbjdYZkKCP7g8Ks1TjrfFehvEC22IUofFPzJ3+3XXPwSLISfIRz3ATr0F9bzwDGYneZe5qxjIdEe8kAlRLARqiOFNb7BXpv/I9YxrltCKdfy3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789516819; c=relaxed/simple;
	bh=rFk3NaeHNNH0hSNPhaHZllTRrOXlY/xKEfFXelzLWb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=le7nGVUzyFE3118wtLgK+6M/moYfm/KXsEXorMJH6NMhMwwtM+cNh+Wp5yQmzJk4hTmIFWiuWh0qJmaNoohkgg6476W1Nj1yxQkClRmM1HTd4hnULl/3WwrPaJI3Hd+WhndaIDUXDDRtSjt269tYtfiShhkdwS6Vd7RKFq+Bpjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FL5VUHQN; arc=pass smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FL5VUHQN"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-85d43da99ddso3015047b3.2
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 17:00:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789516816; cv=none;
        d=google.com; s=arc-20260327;
        b=drGUBb+VIPt4BF8wxqHulxUg7AMAqzcPs5RcroQDlgt7igjUXTsQmUWduf8qejPeqf
         b7SdyF2AIub+cfesl/rDIVxNSg6p4XgHD9exSRVwzJNZp8N50AdrTiKYXKNlLJL0uCgC
         BuYoHKH3nEPU7g5+fhqfUjkpk9EP4VCXAu1fN3HZlutVPcjWPhyZyj16v9iSz2qZ3rXA
         EqqJWkdo2JcsFFjpWKrO7A+7sTrbY7Ao05a2iQd+ezmlbYTgGYMMkSxwnwoLrFx2jcBD
         Re28N+pwJhreRzjNrcp1RPL3Dg208skaqZJ95k7cohkliVlGKv43+OAshN6CMsngS3oc
         it1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m2j/UN3Om6uoh71hgVNZqVY7SOMb3gp+7bzpkgn28wQ=;
        fh=s/cyDmcahmUiT0fpl6M1HcQj8I8ariLMiFmBTihan2o=;
        b=aCE8wI7Y4+mhdcAzbSN2hpINmWdI14iShSjaOhVQ8Ws1RqRpdQY/mrMyBReGjPDnj7
         vKChiK2SgBKx1KA5G7GYoA/ncviU/qEajNeL0Wt8T0gDjuVIRqiZr1RxHxKe1GOUyhE7
         1BVoLVBT/r+HF4NJ23peo6x9BvVFPDchHYjHWi2dD6YXQfk37U673EykxF5zgALZhXFV
         GBAO9NBS/vkWMmPUkjUOWZpbI1QoAe8YINTys/ofKIvS3NpbKEHVYTqYXjkrbtYQxitk
         8LNkzbJA3rV7OXJg3kjLiSffA7tI/VcBaWhZIZv93DNuas8/bf7G4HT7mWYZ/kF18DGR
         W+TQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789516816; x=1790121616; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m2j/UN3Om6uoh71hgVNZqVY7SOMb3gp+7bzpkgn28wQ=;
        b=FL5VUHQNeNozwby2Hq8KUC25PnXKN7YgHmx9tnXO5Vq91BgfgNnqIHoD59llCHXoik
         B4u5SudrK/WdO9jHtieoURahgeOo/KbKFMMMoiZt3O+XUo1NW0HE7l5HcaDz4Ga6eZH7
         AcOsJ1qZ1GIGhOEmh4FhZPGJg0dKvKVatYQGnwT59J8DlycQanGtN7vjfmhRnQCVHSXq
         EaSp4XRDkPiq9LAHf6HmpzV6gxBCLFsVCvz0O9oGiHimHSDR5fzlcsAYQ5UUDYT7XazN
         RCIpbt4pY6z0qA4M0LnD78Dgbj1/6+ogVjxIU9m9SxxUxPRtNo7Fm+18hr6MfwxHqSJE
         Tpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789516816; x=1790121616;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m2j/UN3Om6uoh71hgVNZqVY7SOMb3gp+7bzpkgn28wQ=;
        b=Qy7beiTn+45TmUAER2ViryiZERJrfTZ6wb5oAjUvr0IlhQQYLdXjYzdoR/xtC5YJ/b
         P53Rj8nOl3QZ6dk+KWqf4+row3FZ386Q3SjHFsdNKM5g7Np8djPEGwg0T0ItL71UZWdY
         tRF7Uq2yKeJgwnOg7hybRMTGNIjQfK6YH7XYO8keaV90gxlwNdvCJ4L4el0+TZQHMrMw
         htydWALgWTNeKxVtrU/BOo3Gc37pX7o5Q2mDrbuIhzvRnYVvtQxATfBsUC3wAdgFuuiX
         l2w7yvLJ3PO/U7AzFic/di2fMT1Jwxh8r+M5THhGtsRhAG0yzxDrF745V/Gx3pgc4VVB
         P47A==
X-Forwarded-Encrypted: i=1; AKwUvBxJAJ+0fKY4AivgcZDiYnNyYk4StD86n+08e4vvkwDfEPEi2FdYChBW7qorNk8YeJSxyAHCsCo=@vger.kernel.org
X-Gm-Message-State: AFuF++mAFh7Xg4gaDXD7YQRQmz2kYdUGL1y+DuCm/a3VUi8XFowt/fSH
	AAX5Kar93tVky8/Xt5tDdnuQsqdaZT5ETULbfGyEqivon/dpSUHdh8A5r7kcgFSCgBie9msmJka
	DQkQ9v2YjNW0+gfxLX8sl114IqPQEuFDWgJSR1gtbu+BKL4ZlRxnlLBtOR8C+BA==
X-Gm-Gg: AYBFou08vpmwDYAyo1LORFu3lIV62088yjKgShNbGhJeUvWxTyjVJh/nrh2P8vBpAFZ
	xUOYyIbPkejKTstjUTcF1kBudDWaunyIkp1KxTRNWC9ZWjAu2bUf8bGYDQN24EUFsonENfMT6Lr
	YxAbtUuzg0Mvu8vxTlKuS66eauv4ek5x9SqSr/yOi05/6A8+M5cJFKNzG0Tu22FxPygqono4Kdh
	cAS17cH1/fTJzU/9iIagVaIz68FmQm+oy2WvE30ut4qcMxBPKAfRR7hFF4IWmx6FnC2yEjpuDvX
	R/N98SVribBbHUerfiCptkX4BLkiL7CX1I8UXi3EdsFP5OZs4cu+kR5j7zfxgffwxYInd3QH8Ep
	RGNvuu2Nqw7rioOAyPT3uxwfx0SAzIhHT7S/CfRr5Ynq8w16HbkxPhOdUSD7Jam7roD/eLOX0rn
	0X6BeTxG3LWkJSreh09eiB
X-Received: by 2002:a05:690c:6602:b0:878:cee5:989b with SMTP id
 00721157ae682-892207639c5mr2133347b3.6.1789516815928; Tue, 15 Sep 2026
 17:00:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911020438.3502801-1-kris.pan@intel.com> <20260911023804.3503989-1-kris.pan@intel.com>
 <20260915164008.4f65ddc4@kernel.org> <20260915235335.3580993-1-kris.pan@intel.com>
In-Reply-To: <20260915235335.3580993-1-kris.pan@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Sep 2026 17:00:03 -0700
X-Gm-Features: AcwNN1XHLPi6WXJbDgXJBEW9xClFElJ8jnBfY1cNd_Ib0ENvWLhMDV8ounMWFwo
Message-ID: <CANn89i+_mDmngcd2rm_huSOd7y5m-Ek8d_h1vspHZNmTBCeRoQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: iterate online nodes in skb_defer_free_flush()
To: Kris Pan <kris.pan@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, pabeni@redhat.com, 
	horms@kernel.org, atomasov@redhat.com, oliver.sang@intel.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 4:56=E2=80=AFPM Kris Pan <kris.pan@intel.com> wrote=
:
>
> Right, the node-offline race is real.  I'll fix it in a v3 so the flush
> doesn't depend on node_online_map, e.g. a per-CPU mask of pending nodes
> set by the producer and drained by the flush.

Certainly not.

We should not add a per-CPU active-node bitmask updated by
skb_attempt_defer_free(),
as writing to a shared bitmask from remote CPUs would re-introduce the
cross-NUMA
cache line bouncing that commit 5628f3fe3b16 eliminated.

Instead, keep for_each_online_node(node) in the skb_defer_free_flush()
fast path,
and handle cleanup in the cold dev_cpu_dead(unsigned int oldcpu) hotplug pa=
th.
