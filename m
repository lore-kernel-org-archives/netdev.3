Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F336D3B7B70
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 09:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790416212; cv=pass; b=LxAyqeTcOC3HJz0cXK+eV8oqeo/5h5Kvn6J2/CNN5skFQvfD391axxywr08MYkFC3mcTS7ckxsk9HunzafvA95Cp7TO3T7i63Gyi7Ga+LJW0aD/ItPwCe/KM0/5jmugRh35lIyAtWUS7YULzZub/1zYXKm2J6IjqYYbLTl9KTxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790416212; c=relaxed/simple;
	bh=XqyMobrLIiayo0q6QPacLWkYpIqhURVI2ky4S5npPcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HqQDKfb4JxMmT8B/lbxBO40ggi0gDUfsSoJ+xa8k47mTHBlqWRBgtVW5LWnURg5To58NmWrbMCctEp9cRB8nTu+1fAppiQxyG+ZceF3BXUSV8X+/CDtGVdCepB4V3eoaBB1Zzs7p8qV7xs+c49TG/eyaByuvBP5O5D3ojxtRo6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=p9X9b3aN; arc=pass smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="p9X9b3aN"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd04edb5so2682290c88.2
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 02:50:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790416209; cv=none;
        d=google.com; s=arc-20260327;
        b=sjtz8CGzv7FgZsgAcsygftvgTWkb4efc86joDToOyAwAfSoYjLBYUy21rqhmo5t/o0
         DwSMU7ySE1edc3D7OGY7T/Uuo2PFhs6fVOJemlyb65Kmdrv/e9eikHy7/Rav+Ua9Btvi
         7xlIZaDZYO4HAhyZ1hY/b8yWJza316EmY1r3TnPYjaIl41WozoIWJiF5OAu1U5HNkOU+
         lppC1RP7R1U7JQ8JDJVyEDtDJsgzuJujxKUFqCQE6acaQ4BrViYOL+plYghhfLrONA4O
         PQliO+cVjVA0P3j23eqCT/FJj7UZZLimrRy21NV0UWFzKxDRk0q1e6XJTo79OfVAJvDR
         1Iyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XqyMobrLIiayo0q6QPacLWkYpIqhURVI2ky4S5npPcw=;
        fh=q8yOk1rc3LNZjbAZdciYCPhiT+KLq3ujJG3+bd4yRCQ=;
        b=QIlltBk05KxCNHURJhVOQdQmVFbRyVMqmDQgPRotW8DzDGwNWem28MLRCmitqNIZl+
         OIKHwbvex1rhZSlN8mum57Lw8pnlr+x/5TdXhxzFcq9DyNnRkNUvB5azAvkBjNiVvOyO
         OUcdf+ilSqPYtUxDbFN/p1msJ9BpmZsXcbzjYzUaRObtRn4z7Ja0V/1WKgkQy2WolZhC
         o0Naa/QW0P3khWVmGmLIJzKMnNi+dt0gPGTwjCu99PRkSk3kQsbD4hQz/093y/7mYYph
         z0Tk3CEupIOn74QvDxwDjblma593I385shXbNYcTv9YEX82ejNAYX77gdF1XVOLYPIFo
         GZgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790416209; x=1791021009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XqyMobrLIiayo0q6QPacLWkYpIqhURVI2ky4S5npPcw=;
        b=p9X9b3aNNEFn5qcFJpr8zmwBjhE9Oaud+fByNZC1d5zF8OLR2IMpXGum+OJjOyKSUV
         /fRPte+dZ+xqTSc/jpVeLVW5/B5DHxQWqAvWN/eHx8FbeNt7/kdW4cYVzaon0ys+2xzn
         fLuRrciK3MW9AQsMypQGlGhJzAWBJkyuyIolA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790416209; x=1791021009;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XqyMobrLIiayo0q6QPacLWkYpIqhURVI2ky4S5npPcw=;
        b=btQWIRnMfSu4UHYQ3s3GWFZwcXdxy+3e/zTR1SMVDq543VMrO9bAei7EjTO38Ju7T6
         e2sLc9M+raTECzpua8HoAEphHzouSwivMlcGBcuwO1z0cvZnh8GNhi7wcvV4Q2JAuYQh
         AzbyV/V0lkyNtizh2jtVgdGWOrR5fd/95wy+4PNf8zom/v0dTkTTLq55sGVWBx3nyS1p
         yFqIDs+WPqhSRbNuV3OwWi5PvSHZE4wi7Qof9O2vbnUXfxTMtOEOmjx5UNb1+onu8VDV
         ovCqh31/cqewRDaGcvICW/X2cWJnw3t5VrTH3ShJgr+1q3w1tDi0xNMi+iWZu1acRDeg
         yQEg==
X-Forwarded-Encrypted: i=1; AKwUvBzm27Ro6ZluMGBYsvqpbxQmBfhFgkErUYg5A4UcKy75Ayfwp6Qiv8TFW+tTC3fLYuFanaGM1QI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJKIWCcveH2rPd4TyupNE9SK1sn4EUPFqgnPX/FPqtrdwFDT6zl
	vF0iz3de+v/OAdaB0ODVJv0Y9jgT/jplRXB3RSk7w0A43NZCTmCov9WVnFfdLbCBJNiA4wDcLZT
	PvXpY4G9LciGQ61ifjFlPMk+FCjwcubPEwFp9sfq8
X-Gm-Gg: AYBFou1ZqwE3b8TOT9RQgkwFWRlHBITk0QRj0p7b3ZxtdpebT/dolztcUEq9Ms3wPtQ
	ZQPPVv0GNQj6Y88LUdKLxsDVwO4+cMBQVpC6n3uXxLA5SvRgdFmnny8XCxU8At7cAm3wkteN2Z8
	ddEFAwLKyMgNF8Q8YkDcbtYCPyMYFmB5BS5YuMFJxvjM7eLMN8qnLRr5K9a0HM136ac22csSlz1
	18RGA4nebCdxZeemuJZ+3tR3AN7R5hwSpxh+l1ZkD6JRugVKAmc9cXTA3x6pGTavNar/hWO42NX
	jC3X+05TR8voh+QesHvzRkTaVb3ocQTVx44kRBCCA3tOOpY1w/ErwWhTdugL+1MXd2lcF2zLrhO
	FvteYvkcTqtHk1MCb4UBwLwKC1UxQTgR/+9y2HK9Q6/bbHGvZFwElO98WoIIclM+VHGYMhPKHJL
	NdKHDx08hM6rTprniN9AY=
X-Received: by 2002:a05:7022:29b:b0:13c:ec65:7bca with SMTP id
 a92af1059eb24-146ce680830mr3047598c88.13.1790416209014; Sat, 26 Sep 2026
 02:50:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-JCOT.v1.20260910090924@mojatatu.com> <20260925171834.73b5b367@kernel.org>
In-Reply-To: <20260925171834.73b5b367@kernel.org>
From: Jamal Hadi Salim <hadi@mojatatu.com>
Date: Sat, 26 Sep 2026 05:49:57 -0400
X-Gm-Features: AclHuK8ozjCUr8GkFMwDP03J3HTQRT-rnIrz6ZgUgaH8T_J6FhqTiPvsXV2w8II
Message-ID: <CAAFAkD80zx12Cskdf8NaF1pkSbLUiYSeTEmvpSR8o6P2d-JEOg@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: cls_api: reclaim an empty proto on the
 error path
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, hybris <hybris@mojatatu.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 8:18=E2=80=AFPM 'Jakub Kicinski' via Hyper-Yielding
Back-end Review & Insight System <hybris@mojatatu.com> wrote:
>
> On Thu, 24 Sep 2026 04:32:49 -0400 Jamal Hadi Salim wrote:
> > Tested-by: hybris <hybris@mojatatu.ai>
>
> Please stop adding these tags, they tell us absolutely nothing.

This says that our _automated_ bot tested and it adds the tag before
we send the patch.
It does more than tdc for a specific patch set (e.g., PoCs for code
paths not reachable via tdc) and it does find issues sometimes before
we send out.
If a human had done the same, wouldn't the protocol be for us to add this t=
ag?

cheers,
jamal
