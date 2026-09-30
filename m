Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6311545D5FE
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 08:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790755547; cv=none; b=aj/X/VZgP94JKi9HZoVv761MNbja6r86xg/cL6ZWHDFgcI3BrEDD21EawBxCOWN2AQOmAzasdKDZi09vGxvLpqRAA6gSSa3uW7+7v/l5fpwHwufAkbThH0x0CBqh2jkn48Kane75zL/OSMd289Mr9olJewsxGg0d71yfMnQSIYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790755547; c=relaxed/simple;
	bh=DAA66x896W/BAcaHnM/Bw62XIqM9SguOpxhZxTjRhiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=daOEwhCgif8leeuOlj69QQt5V/vs6rvBbznP9XHVNACvw8AKkkHtqoyGKIr3RZRh+K/VhF51d8M4sgZTNAy3lo1sWQEGgqzPcVYgHZSrbd5b+7UAuKvh1M7dotcta6cgepmGi9XTGaFetok4v+CTH34rGrP8sYCxOjRGUhaJ4R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9fH1TTK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9fH1TTK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1B81F0089D
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 08:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790755546;
	bh=sVSy03xtWMDYRQ1TrBvKXaQv5pYck87L4jhpygpVIDg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=R9fH1TTKpLUrNQOJ9fccoN7kkSCVs2XlDjQklNwF7WqXvC1AHG0s7ZvNk4Zc7FZVn
	 1KBwWevOmzOuu5QvJxAj54Ya5pViItnVBoxL9sJw7JGnJElsqMoVQk/9u1+3r1pfrk
	 9PsOd3XnI1w+PEMUrbJkSbjzNA98mStpPHcssjAbxlRPVleeOdDoqrYnJ+4RQv57jN
	 eVVCJVBTrwx8aITnOODHEqdPjTox/Qg+Lm9/+Guu072NBpWDLuKvYLbJv3mDa9pxJK
	 DG7HznaIythzL/UyCrTSew62L9yuJCffPBYaDtLq8hH7ZKeXjUdi2EFExFfByfARjI
	 Z+xcfIeacnnyA==
Received: by mail-oa2-f35.google.com with SMTP id 586e51a60fabf-466ccde2a99so2703653fac.3
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 01:05:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw712Ghx+AlfoVrFnRC0e3gGNjm+8pMFL7Cl2ceoSHI8HCVgo6rxT2myZaP1Sq9ii4dMFJjt2Y=@vger.kernel.org
X-Gm-Message-State: AFuF++n5B/eUX3bYrpUBfCI4DeSbypC2UNpunAC6oRtz2dwIan60Qapu
	K0bN6claa5bWKWg5/36bQRda5T5St861n5hMHtaNZE2e7fiwL1Y8rTPLhD0TTDi4H9Z0fOre2FF
	MMRQEEtOJkNdZqMKi6cK1CwTb+iaVMoA=
X-Received: by 2002:a05:6871:3a2c:b0:491:86d7:4ccf with SMTP id
 586e51a60fabf-49ddd50ffdbmr781137fac.15.1790755545415; Wed, 30 Sep 2026
 01:05:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930075320.760328-1-4ncienth@gmail.com>
In-Reply-To: <20260930075320.760328-1-4ncienth@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 30 Sep 2026 10:05:34 +0200
X-Gmail-Original-Message-ID: <CAL4WiioHAjQkZHj30NBcsHsN2omELZn7desAdhL73n0KFw409Q@mail.gmail.com>
X-Gm-Features: AclHuK9eeOK43SrQI75VP0VZ1e1glwUL6o7gcuabNm6CvosLRXGGFHv9BAYcGyY
Message-ID: <CAL4WiioHAjQkZHj30NBcsHsN2omELZn7desAdhL73n0KFw409Q@mail.gmail.com>
Subject: Re: [PATCH net] ip6_gre: validate ERSPAN skb dst before PMTU update
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, William Tu <u9012063@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 9:53=E2=80=AFAM Daehyeon Ko <4ncienth@gmail.com> wr=
ote:
>
> A tc tunnel_key action can attach a METADATA_IP_TUNNEL dst to an skb,
> and mirred preserves it when redirecting the skb to a native ip6erspan
> device. ip6erspan_tunnel_xmit() treats any non-NULL dst as a route for
> PMTU updates. A metadata dst has no output device, so
> dst_dev(dst)->mtu dereferences NULL.
>
> On v7.2 with KASAN, an initial UID/GID 65534 process with CapEff 0
> created user and network namespaces, used namespace-local CAP_NET_ADMIN,
> and triggered:
>
>   KASAN: null-ptr-deref
>   RIP: 0010:ip6erspan_tunnel_xmit+0x10fc/0x2cc0
>   Kernel panic - not syncing: Fatal exception in interrupt
>
> The collect-metadata path already skips this block because its metadata
> describes the outer tunnel. Native mode must still propagate PMTU updates
> for real route destinations. Use skb_valid_dst(), matching IPv4 tunnel
> PMTU handling, to exclude DST_METADATA without suppressing valid routes.
>
> With this change, the same trigger processed three packets without a
> sanitizer report, oops, or panic.
>
> Fixes: 5a963eb61b7c ("ip6_gre: Add ERSPAN native tunnel support")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:GPT-5
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>

SGTM, thanks.

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
