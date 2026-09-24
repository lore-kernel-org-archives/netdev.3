Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197A9254AFF
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 01:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790213561; cv=pass; b=MSJtV3czPk79uHcLuEuXG+Lf1Cv9GnhXiHRW8PD1+GyHW/AhJY/axzVygK8hT0tPXTSmlOuCV1rGfAamroSbKLitM/fMAI+TovRdLk2uFtL9FLEA7L9FlukCFy8wlFfZNVOr+6TcZ9leJRcbOdETeW8eRGcSx86jWvj1JRNpjcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790213561; c=relaxed/simple;
	bh=dTSxZVmCcqHILP/3apvpr1RSS1ZcuVwDqzKMuhEs/B0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXLDYwrVabLNoPRgM3ypSdbKvKFxwOcjN4iR/XrV8Bh3YFsOm4DJqthNYMHSiMt7GPHXhtQydHBLgM2RP0gH0JxD3b9hUQNaE6AE9M19vZjprn+rcVBbl7XkWvhdNaPdA6Sva6C2Fxp1Ju2NHHltQnvsW3GrbinrI2p9d2TMgMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NhwQQshY; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NhwQQshY"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d8fd7a3f38so17145ad.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 18:32:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790213559; cv=none;
        d=google.com; s=arc-20260327;
        b=NFLwGlmVpYWLJJVP5gBnwyN3HTsgY4f4c8T+24CohScqMAhY6zdaamNSo1/S0K8ROy
         u8B8K3w4lvw0GPC47tA2VdFcoM9aJJgUOoHC5yU6LXQ0JtQI5b8xIzZQD2ch8KOY73CF
         PdSZa0CzX/kMXyedlgqAxjnnAf4qiVgiI81BiTrUCa8NkvlpzWC1UIYgrcmfl0kYU5rr
         9AKCWJOFNguGUnuudTZ8YGyazCKZAQc2B0YVtAuxc9P9CG9oN/Sfqk65OKizXJlKR0r5
         dbuEkGVGo7D+2A0YCtRHp5zZFpDAjVAb5A9onDbH20+vD11lnvdTtQVhj9JifE41kTor
         WzwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eg/mRIvNkuqzeOvIRs9uy/lV7fqU0FUJo60NeOfUu1o=;
        fh=TI+LqaAcLZb8txyA6IzcZXnL3wec3FwflHVInwRIVTg=;
        b=a8P5XoprXWuxx16x1z3vUaoAIzuecf0aE4OV9Pi1bWOduc4hwXIzqLtcV30X2CPeBX
         SFe9Sj5x4K1UIfP3ES3oQ4Rq0PyIQA3vGX3vZ3YYsmFwVawQUydOgEOHaPTgMVm76c8m
         jrwRSoLzX8Nha3OdHPNTqjODQMNPD2FCC5K8RjIKJYcTRSx4W4koF5WJ84gSXnNOhCYY
         IuEt9LRIrTv6Mu2JIwb76H0chV2gr3TczFfq4ZAzNuehJjEgyrWFR6cZLSti+j9mU+Mp
         sI4akUVXZlgJXSgRGILOJRiz7n2+K+Rh1YY3519rXPLRdZ8nvnW5fz3G9CswDlyT5Z9k
         5q4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790213559; x=1790818359; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eg/mRIvNkuqzeOvIRs9uy/lV7fqU0FUJo60NeOfUu1o=;
        b=NhwQQshYeV0QwWg+xvjgAdLwHB6dkzhJXnv9nJgQPaIsBlzducBOECOpn5jgzlc4DW
         bLY61tQXVRfe0Oyo+CcFy65LHMeEBCGNvlrsPBQk08vv4wup6gQMbc9y8/mppcmwQMAj
         +Lil0vv4jRr0emgZtmRPM0tggkEVWYGib1cGhDwcxvh49Ys5cg7/kEAXYeHNFPkqaakx
         ZOPmwXsvTaAz28nxiOHVmJApSjDVh5tbhIN2UmiRjzfa2fg2Y9sJ+NqWWv3tjDPVdZD+
         FbtHxOnMIJa0uqliZJNpl5ucSDfZ9lX+tfgfJnjeRuZgDx3fcmd2b2NtC56lWP2GSwkS
         wSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790213559; x=1790818359;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eg/mRIvNkuqzeOvIRs9uy/lV7fqU0FUJo60NeOfUu1o=;
        b=myjTo7FTSFeBCAR/Wry8xq8gzynTzPf4CG5bNTOuU7eGOuEdhuTYNS0mnbv9R41vs0
         ptK1QhNOPPUoTtqOHIW8k2gegHvamHlRjv3MABbxHf8s0ivgqM6JazjEmiJQrd7H297I
         ASLqoni4c4iopIiKr5tST4bfCR7INjcob3GSSCC07gBZX+WP8WhqK9VGAIoTCzRxvaz7
         gV73mi5IIsvVZFbSBi4z8APwrP08x8a7nzZ70OwJelOS4cJ0lFOrrILv8CCkuPruknLm
         jWN33X5JzkFzwG9ybEVhRnZxJV556T3t/PvW3JrmHS3rNl3QFbOCKJUizFhmjQufag7c
         qK5g==
X-Forwarded-Encrypted: i=1; AKwUvBwuYgQbI5amBkcNAgKTkDy+Rx9vFknvrAZ704AOoveBOJ77zcZysUvZ1Sm9br4WewPQpWtBIFQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kIEPUuf196MemcaFR2VjTFV4VgFbEm9fxqKk7l5IqEpXM0qBs5
	iIxmopxtFPGyR4GRFt0NY/hFfmJkxzkuJFP5qYVonZ7GjN+IYkzsuhCJ2eSd7bbfUua1tu7zsfa
	b1qSllB4s5x1jNyJT3mMda+fAKUSqi0CIXFXdJzoV
X-Gm-Gg: AYBFou1udpl4Cpp5lgQ/THjW7xNSHOGkWSVCVI4z9Qr9yqe11OiDC3Jbw+mUvyVPdmC
	Ljs9BO4/PpqWeWWpN+k7q7W/rhqBdIgXvsDOu/zgz/VVMRQy6qLa8vfRKEvMA48dZdD5A0CMYaD
	eLf4+5CCN56mb9Q7sUnK1b6YHdewrX+wWl00PLRfwRco+zyC6BBaqdVgYuzhsrmOSYaPBoPaa1Z
	cNrv9bxksCfdf7v/cXs7cu3T22GkbMl0HXF3e2it6k4UW479hsH6PqlPJeHByQwtduR2WBjU4vp
	TASloNzmOERymN5VJ/qyPmpXM+UNwTSuVaN5CkNfWnD5T39cYmKlV7GWPoU7gzSxf+9tufTYCTw
	NZslQcB3pBqAnhVKwm5nuoJCRSXS/CwE+aLQmStH7Ee284IghNUdHcfoP
X-Received: by 2002:a17:902:f543:b0:2d5:db38:800f with SMTP id
 d9443c01a7336-2df7b3e1e8emr3139705ad.14.1790213558743; Wed, 23 Sep 2026
 18:32:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924004252.1196328-1-edumazet@google.com>
In-Reply-To: <20260924004252.1196328-1-edumazet@google.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Wed, 23 Sep 2026 18:32:27 -0700
X-Gm-Features: AclHuK_5gmEvd5ztmx7Cvp5dcbokyDvfsSC410uOlkoS9cxcxbCN8xIfn6vphVk
Message-ID: <CAEAWyHfm_C2aB3YKRQiFUZXG57BLvNqS=FTR=YA8O2TjHcXSyA@mail.gmail.com>
Subject: Re: [PATCH net 0/2] gve: DQO: fix handling of out of range TSO MSS
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Eddie Phillips <eddiephillips@google.com>, Ankit Garg <nktgrg@google.com>, 
	Joshua Washington <joshwash@google.com>, Willem de Bruijn <willemb@google.com>, edumazet@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 5:42=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> The DQO TX path assumes that the MSS of a TSO packet is within the
> range supported by the device, [88, 9728].
>
> This holds for locally generated traffic, but not for packets coming
> from a tap or from a packet socket: virtio_net_hdr_to_skb() takes
> gso_size from user space and only enforces a minimum, layer 2
> forwarding does not check the MTU of GSO packets, and
> gso_features_check() bounds skb->len and gso_segs but never gso_size.
>
> Patch 1, from Eddie Phillips, deals with the lower bound. It moves the
> existing test out of gve_prep_tso() into gve_features_check_dqo(), so
> that these packets are segmented in software instead of being dropped.
>
> Patch 2 deals with the upper bound, which is currently not checked at
> all. gve_tx_fill_tso_ctx_desc() stores gso_size into a 14 bits wide
> field, so that an MSS of 16384 silently becomes zero. Falling back to
> software segmentation is not an option here, because skb_segment()
> splits at gso_size regardless of the MTU, and would only replace an
> invalid TSO packet by non TSO packets larger than the 9728 bytes the
> device supports. These packets are dropped instead.
>
> As noted in patch 2, oversized non TSO packets can still reach the
> device whenever the stack segments in software. This is not specific
> to gve and is better fixed in the core, so a patch for
> __is_skb_forwardable() will be sent separately for net-next.
>
> Eddie Phillips (1):
>   gve: fix TX drop when GSO MSS is too small for hw
>
> Eric Dumazet (1):
>   gve: DQO: reject TSO packets with an out of range MSS

For the series:
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>

Thanks!

>
>  .../net/ethernet/google/gve/gve_desc_dqo.h    |  5 +++
>  drivers/net/ethernet/google/gve/gve_tx_dqo.c  | 32 ++++++++++++++-----
>  2 files changed, 29 insertions(+), 8 deletions(-)
>
> --
> 2.56.0.rc1.310.g51773c2048-goog
>
