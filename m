Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC80412BEB
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 16:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786467505; cv=pass; b=KMBgn0jEqtwC0q3lGSuG2D2jkHbJ+artxGYZtbdX5IvFv/NQB3Yp9RNh/vdsG0qub97fVlXKePnE9JBlFYNf456pn6C9AXQesScYYU9TeFovCuK6y3aUnMFv89L8/mKzlEkvRtLyh40urUeKa5zf/lBEV8CcTDoRgHlr4cIvkoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786467505; c=relaxed/simple;
	bh=p1Idd0+BrPC57hxyNa+KXpmXW4ID+phoJh3HgUE0RFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aMu82sYR61lrw73IsgCRk9Uem+DM4FFbOCJ6NSxC1i6CDWB8iF2oQWr18u0lmV5t/MaIy0UDJqLrqsNZ3ahFOxZh6T88UbkeAyzc9IURK++FBP9dKrUCu2SAT3Ercf3DTP/QMXNsJKO+3TyRiRQ/Wgz4rNov+S0Bh/NpKzVUOFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XAOvMZ5K; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XAOvMZ5K"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cede6375caso3185ad.0
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 09:58:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786467504; cv=none;
        d=google.com; s=arc-20260327;
        b=UUgChc5Q/VBKxEQEqwSs1rDhN29m9XAFY6ubvbwkzvm/sW3dTnKXbICCqZMdOQM9Rs
         KLduNjjLrWDep9Z/YkqiNKwW3oEAV4c0oPsTLUeNOmEjtpJFswAURG4FjfvCG1Gviv6p
         V9RVhqMlpuWLaJyBSHH7CYyC/7P1QrjNQPAHH29Eh68mE6rW66zKJb2eyeEqcms7Hj4V
         J0SN4JW/TPFp/MmlpBzNwHrRNEApzUcqwM9EHhsXxEL7nStdGU1i5osMBoXOM1/uBj+u
         D0+3LSf56XVHdA8SUc5SY49or6Hvani3PaO/hhcq19C2NeGN0MYizr0LyEqsHPDxRDSn
         zonQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cWgS+W4qLbOvGJ4zW2GbJqzmR98EMaFrD9S8IoZvEKc=;
        fh=ICU2Zm3WitMei1aEX8UWL/BjPJTsJJxs1MKywux6EIk=;
        b=raM1ewwtqh1Uew31k22TUrbd5vwiBftdBAcrxkbO+rmln7lwVG5D6WPYloldeKr50v
         h2Wn87FRyjV65598jKYUSy6aytl2fYrmtYVmS8nXarj1aPe3QoITauLT6dqXqA/uv7ql
         HkZPv/w94wc26t5G/qHqJCzF0EITrLB3GlXIBSS0dykFiVTGLFgnB2JsFkS9t0FCpby8
         3wTGNXVPtaYVhD1WGFipNMhfvLM7ap3RS/y4ZDmP6hfNVR7FhDQXUdqFzHKsav6OLQYe
         OroyVftJvm9ggOIk+WKsAQeQXccw6IlUaNndgBztHelF+Yt6CW71gxBsW6TJweIzTPH3
         M2vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786467504; x=1787072304; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cWgS+W4qLbOvGJ4zW2GbJqzmR98EMaFrD9S8IoZvEKc=;
        b=XAOvMZ5Kbhp6huQetVKNpFWlCrRD7EfKhOe9Oyoy3r9pEnyGYmSHabjnBkVZmlgKBp
         Nu9cciU6B0EOEl2lmoaPbZxWinpTK43isllxCT4j64o0Ah+1qtbfIbSfdLEccoXGN4hk
         4Ge8tgr8KG8eNwn+TtLSVeoBgSyghYQYLG3QG4sER2MUjZpMgD/sU+XMKVSn8EW8+QDq
         qP9sLNeiMSQI3/DcuQqaNz1lgByC+QPAMuPH0m5GNzny/Fzno96pdKR5h1IRk9HMnklG
         ULcJRVr91grMw+kAYnCr1jNIRPjcxnALnpSS++oCrsB3Pel9ac+6Jel10YAwjFvg4z3e
         1gKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786467504; x=1787072304;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cWgS+W4qLbOvGJ4zW2GbJqzmR98EMaFrD9S8IoZvEKc=;
        b=QvWhHQdCRM0eR3ZAmaXhXhGSdT8RovPgWEE1+1rV/9JPGWRwP2U+8etsJstwM4J9NB
         QipdEik2mA70TR1zHNIObtJBZgwb8V9fto9TepNhHf+tPhtg1eIuQqSuEWsFPHPQLXc1
         b/gorE00bKuBU8aWCEtQpeLgbodxPijteJEWnGT213J5S+0iq0pz80BD1ca4K8L5V19X
         K+zYDLtyALUdOoRMqhkKhds6ziGJxnBWC+EDl/sW5Vfq0VPaaG1VpEmLXk2pCHjpRiYN
         8qgOhaMP2T2xtlUZlFSlc84kfcWvh/0oQ7C24U9kJPOU9OJJ7yZnBRoxuGsZWSQuP4p5
         8j+A==
X-Forwarded-Encrypted: i=1; AHgh+RorncGASsiqdTW0nb+OBahoOQMXAqeAPpzpb92wawdPqiEimcBL3b1bjDj5FV4NEo78o1Uvdbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDFlc8br2qvLGlxGjkF25Ma3orqF7K1wdoxYaHIEEnmGC/CVw4
	+azZimpbfk8ydJsKI0WWo1Y+EcaTjyZSrn957ggU4455AOfjQaxW4E6SnOOWNni/qhMqERNFOHU
	2cgkfbLTBSapjSuoIown06uAa6P5119qHy4FyG4ak
X-Gm-Gg: AR+sD10YtsgP15NipcdT7jfU6jzjoqmB/Cha2by15Qo2gBJ/UIvjsvz1qGpX30cRI3l
	SGiJ8brPr7EWV5+yexqahxNHpAjtZD9wkvrOEmBiAzmQgaMDWk8FSXILyVmJtiT1Bwk5ITzq8pm
	XYrLGMhc2puuLSnVLESULqDal7FMs4XJshKOEEP7d31SNLOcNxs1ibYVeisWhcCPJtQURIwZ6lQ
	NVFtVsNe4fo7LR4dxQft2RV0eTShLigi+kl/V5at5hBMvZfANcL+yMBXvx81bNMky6YWWDb9F0j
	tX0T/J6LKhkVyNKJSdto/BPvCsho34L2cTx8quQtViKzx9P0yMmMejwu9QFbDbzzmmE5O+CY53n
	lpK4+eE0hKg==
X-Received: by 2002:a17:902:e746:b0:2ce:b436:272a with SMTP id
 d9443c01a7336-2d3171a2d69mr5868425ad.3.1786467503059; Tue, 11 Aug 2026
 09:58:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786108672.git.asml.silence@gmail.com> <f769116a3f5267f06cb9a9a819d482ddea2e0852.1786108672.git.asml.silence@gmail.com>
 <CAHS8izN4SAUCUQySd+VTbdayX-Stj+eYOqAof+Vhi=EsRb93_w@mail.gmail.com> <70b36cb8-bcb3-400f-a3f6-d038bff88723@gmail.com>
In-Reply-To: <70b36cb8-bcb3-400f-a3f6-d038bff88723@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 11 Aug 2026 09:58:07 -0700
X-Gm-Features: AUfX_mxQRJ5lJVMdC3KvfzaiGNzSb3bPiW1sF_ivLo0dSz182zuFZ-UONptoA2k
Message-ID: <CAHS8izPWWk1wxwbfLHKQQrHA1vGURSf6A9cmWMskb6aSfNYVjw@mail.gmail.com>
Subject: Re: [PATCH io_uring 02/16] io_uring/zcrx: move RQ head/tail to
 separate cache lines
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 6:16=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 8/10/26 18:35, Mina Almasry wrote:
> > On Fri, Aug 7, 2026 at 6:25=E2=80=AFAM Pavel Begunkov <asml.silence@gma=
il.com> wrote:
> >>
> >> RQ head and tail are currently put into the same cache line, which can
> >> cause false sharing problems when refill is run on another CPU. Put th=
em
> >> into separate cache lines.
> ...>> +struct zcrx_rq_hdr {
> >> +       u32             head ____cacheline_aligned_in_smp;
> >> +       u32             tail ____cacheline_aligned_in_smp;
> >> +};
> >> +
> >>   struct zcrx_rq {
> >>          spinlock_t                      lock;
> >> -       struct io_uring                 *ring;
> >> +       struct zcrx_rq_hdr              *ring;
> >
> > Is this not a problem in general for everything/most/a lot of using
> > struct io_uring? Should you make this change to struct io_uring
> > itself?
>
> No, io_uring headers are usually accessed by the same task,
> that's unlike zcrx where the consumer and the producer are
> two distinct entities.
>

K, thanks.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina
