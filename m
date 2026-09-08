Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CA955C32B
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788886112; cv=pass; b=EGpgoSHqgN4Y5VCb0Vp5f/qFqe9URVY+qlzS3F+dSDPGdJtSYJg+Y3jPpyoas1LguD8F2LJs9VzrYaAwFM7Vj/k26U1rjTHiEcKlT8UH5Fz1JhHUMqy/eTtenwnyhLOUNmtTIxpT45OgCOcKh8WGJHetyBeWghXht9VBPSTcU+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788886112; c=relaxed/simple;
	bh=c1n3waaPORh3tcA2sV2EqqghSpkzgjC9VJQYZMO5/tY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKaeYC+dqybUVOBUkZmn8nDa4wq0Tfm+LAH/fKODnE1eeSWmt3JpHOgz6agE/3O16UJxOYmEgZzYQkLcIU7fi974bHAnrUJmCnyEM9CJZ5f5Ro7vAuaZTHvxxU8RhxUqx1di3C6o4ozE4CjOkMvYf0ZZRW1oFnW9raLKN5jFjdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UgKuElQE; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UgKuElQE"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4aeso124766a12.2
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 09:48:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788886110; cv=none;
        d=google.com; s=arc-20260327;
        b=E1RDanC7w6+7e+AShGEHGRLx9hszmfm7XaQX4U0wZBR3PV5WIY9i9YwGgy/Fv8cvck
         eN6hmkoeXEGRXJ/L9BfjQF0nE9iOfM8aefoQJ31SBAo4VSi9cdlNH2YraTLhoxuURdw/
         wVsIx5i4E70CdEbU2hef1sX+R0f8HCJg4GQJkuPJDOZ9PEEqKL/U0vXsNPUGrufDFTkw
         e8BwP3NJPycl7Q6UMHV7bTHns9/GRvHPTvCkMAMySiw3VMD/IdTX3AsJp29C6aPjApiS
         JEB+QA5rynoOzIQbFY3PPUVcjoPHVDQXmv+1C+g0Iu/CXDoxUKIOrMx8v8jkSVTkb6Tm
         Gf1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9tOzAahEHQRZghzxDfOITioa1lYN6edgiK/GHik65Lw=;
        fh=jK0VVMZMRq8hxFrySCe4CI0Xh30sZTlZ7OgjK9MUQ+s=;
        b=MxgdzS5QqCF8Zl6IqtswKXTz53ZXRQlv1WR288njGm3NA3G2F9Bv/B1YdnW3D8/3ye
         SF3W+drGKdLp2dt9XI2IRzUCGEArRU0gJtWX019GkzW+I8owOM7DfO5b0oqjdsHbpsNU
         AKrP/+kD3Ui1LR5Ls0lbJDW2gfMeo43CKtskHl6POXCXMSOeeg6AogmAqgIXB5YpEm+L
         MOJWvM1oym81GhopSqYA8Ax3o6D5xRXmSrQQ6SaIm/GhosXdUgQ9+3DmkT7YYcuD1RTy
         z8rJif3QrzAmro8BL/g+/klTtUUd65xXzp73T2oFol7W5ARuhR80ClI5Jd/njQ+7plvy
         eh+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788886110; x=1789490910; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9tOzAahEHQRZghzxDfOITioa1lYN6edgiK/GHik65Lw=;
        b=UgKuElQEfcy0bsvykKe+ZCGZTcTXoaYW2IFcCQN7LFxboBxROYTTZEfd6ULdLE4nlh
         YBnE38b555RBoTdfoOQCmXD8cRUvnc2njMjMmgb6MvkOa20ekivkfcQS2FYxpZTHv6Q3
         oE2Gu0bpq7wTLPTPzevtCV79TGZUrKgG1t68ywpFJlvfBBSG/rTGrl3EU4g5DmoS21e2
         WfRLiWHpbRbt5mD+AEDfVDXDvwrEN1rxZ49NKSuz8t1W6q2C1z7tmnwDdqn3Oy/oE1Tp
         vGMlo62Kd0KLcYelNR9HcNvVnKQehccgTIonoDwFbdrMxidtxVXcpBF7MOUb4qAkFeC6
         OhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788886110; x=1789490910;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9tOzAahEHQRZghzxDfOITioa1lYN6edgiK/GHik65Lw=;
        b=lhc4v9a1i+3zZqqmnVXI8oc25NaeQXro4tHJKwlo41uKqDJc5ErtYcDFziaXVSaBBG
         ic/NmxE/5Q9rEGJUUFxHlVtRYUEJdZj4Sd0DeioPS2WBObehfUw7YEA38A3nzsPovok+
         PQcVXFV/y0S0ftn+Rr2qNAbMLAav6iRPRgJhp56rSy8MW9E4OOTyvmRJKJy7AtIdmqfm
         pLeGAg3ItMVZz2OwPri5v455ubrJHIx3MTfyqzVMcnjk/vlv0H4Fk3tMn8Iq8srMYHK0
         SIM7UrnTroVq6v8jzFy3nxdpmjyjaat1NPVBhzvjR7yAbgBtl3WES4LICxnwbueuB430
         zXpg==
X-Forwarded-Encrypted: i=1; AKwUvBwtZUKqz1hCmI1MbDx08DhHInMg700bXxtMTsPNnskm+35HRcW/t+aIPcJonwGiUbElnVQZU/I=@vger.kernel.org
X-Gm-Message-State: AFuF++m8ovloOxadpa1+FB6wWa5vZxbeq7lSwHzTucy4/LqF4ilGyzGg
	owoslO8NM+g1XDaHENX/Kg2A3qj7tgXAE/bpP6wzN/ENKfbLBV7C250WtVY+DaJI2RjEuMaLKj8
	HEnSdIn3jIt9OjjH1/cJDLNS98NN9So2Kp0RjIJSC
X-Gm-Gg: AYBFou3VrtKOB3p7LB1k2W8t9uHlHG3WNhQaJnOWYvrGCCye9TOIV5fdjHzJHqSPFBt
	veBFJsJB2xTrgd1SAPt182O83i1jd3hbwWsMaGuQwlL9j5KDWV4w9XwlWzficH1rpRsI8ilZ48C
	yUeDRhlsFEeqPpWYesoCxWyvrqipWC2oUFGjBQGEPrWC+qoFf+hklNcTVk1qZAIadwAZXoGjcFo
	kn7p5928y/e6KRs2tlP+14tgQkKIAlDcQBPsOdmnPe5b6+RRRNrJDk0wwCL/8KdIvV2HH76GxQ0
	uYClixHRXeE329dhHr05D0ANtZqxfR+BEBl4GBMjHSZM59Lc79iDkHkuL/X52Wd4yxrdpwfV5oy
	EWiTK4js0ulqU0fl3QXveK2FzPCvU83ZkR5LiWB8A2m1ncCATFnntLQcSHGGCBoeLmK/Jr8L19P
	pmiuBsNRvKD63k3w==
X-Received: by 2002:a17:90a:e7d1:b0:398:9be8:ea68 with SMTP id
 98e67ed59e1d1-39bac3f1db7mr862611a91.21.1788886109362; Tue, 08 Sep 2026
 09:48:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907215853.3709987-1-kuniyu@google.com> <20260907215853.3709987-3-kuniyu@google.com>
 <20260908100548.GB903218@shredder>
In-Reply-To: <20260908100548.GB903218@shredder>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 8 Sep 2026 09:48:17 -0700
X-Gm-Features: AcwNN1Vb3IlaS-ZkzlERehvlJT4RJKDOIanQZEJ4YHIDnPhxFipI2axCepoo7Vk
Message-ID: <CAAVpQUDFQ7N93tFCeOAmqe6V9TOfYMZz3masEvh4_nd8iwZGyQ@mail.gmail.com>
Subject: Re: [PATCH v1 net 2/4] neighbour: Enforce min/max to NDTPA_INTERVAL_PROBE_TIME_MS.
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Yuwei Wang <wangyuweihx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 3:06=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wro=
te:
>
> On Mon, Sep 07, 2026 at 09:57:53PM +0000, Kuniyuki Iwashima wrote:
> > NDTPA_INTERVAL_PROBE_TIME_MS sets .type and .min but misses
> > .validation_type, so no validation is applied:
> >
> >   # ynl --family rt-neigh --do setneightbl \
> >   --json '{"name": "arp_cache", "parms": {"interval-probe-time-ms": 0}}=
'
> >
> >   # ynl --family rt-neigh --dump getneightbl --output-json | \
> >   jq '.[] | select(.name =3D=3D "arp_cache" and has("config"))
> >           | .parms["interval-probe-time-ms"]'
> >   0
> >
> > Moreover, nla_get_msecs() uses msecs_to_jiffies(), and u64 is
> > silently cast to u32, so a larger value can bypass the min check:
> >
> >   e.g. 4294967296 =3D=3D 0x100000000
> >
> >   # ynl --family rt-neigh --do setneightbl \
> >   --json '{"name": "arp_cache", "parms": {"interval-probe-time-ms": 429=
4967296}}'
> >
> >   # ynl --family rt-neigh --dump getneightbl --output-json | \
> >   jq '.[] | select(.name =3D=3D "arp_cache" and has("config"))
> >           | .parms["interval-probe-time-ms"]'
> >   0
> >
> > msecs_to_jiffies() returns MAX_JIFFY_OFFSET if the value is
> > larger than INT_MAX.  Also, INT_MAX ms overflows int NEIGH_VAR()
> > when HZ > 1000 (Alpha, MIPS), and passing a negative integer to
> > queue_delayed_work(unsigned long delay) causes sign extension,
> > which wraps around the expiry time to the past, resulting in it
> > being handled as 0 delay in the timer wheel.
> >
> > Let's use NLA_POLICY_FULL_RANGE() and limit the max to 1 day.
>
> Please add a note that this controls the probe interval for "managed"
> entries and therefore a max of 1 day is unlikely to break any
> deployments.

Acked.

>
> >
> > The same max check is applied to sysctl as well.
> >
> > Fixes: 211da42eaa45 ("net, neigh: introduce interval_probe_time_ms for =
periodic probe")
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> > Currently, the sysctl range check is not applied to
> > interval_probe_time_ms, which needs this fix:
> > https://lore.kernel.org/linux-fsdevel/20260905233819.1064529-2-kuniyu@g=
oogle.com/
> >
> > Cc: Yuwei Wang <wangyuweihx@gmail.com>
> > ---
> >  net/core/neighbour.c | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
>
> The maximum value should be documented in Documentation/networking/ip-sys=
ctl.rst
>
> Also in Documentation/netlink/specs/rt-neigh.yaml:

Will add the changes.

Thanks !


>
> diff --git a/Documentation/netlink/specs/rt-neigh.yaml b/Documentation/ne=
tlink/specs/rt-neigh.yaml
> index 0f46ef313590..c8e55c98d564 100644
> --- a/Documentation/netlink/specs/rt-neigh.yaml
> +++ b/Documentation/netlink/specs/rt-neigh.yaml
> @@ -341,6 +341,9 @@ attribute-sets:
>        -
>          name: interval-probe-time-ms
>          type: u64
> +        checks:
> +          min: 1
> +          max: 86400000
>
>  operations:
>    enum-model: directional
