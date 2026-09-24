Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E0A4908A0
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257472; cv=pass; b=m7uhUEIty9T0K7EYTaWylKMZDhvNFonelQ1UbRalGHzZAYgMYmi9jzH1DoDtErkojWTglIxZfq7GZfr/CxahBaxKnzQDq/9iceTFibxLrpv1CtHeRBIahnr2JmianiAWiWvXJoLOLNSncrQniEN1EMqW6QhEx7qaCpQqKiPBR2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257472; c=relaxed/simple;
	bh=cFauOgA8z3U9PqAuxzmKGox+cZOoW7I+JwbiyAJGnfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=glG3zqUemzR0ILPAVcps22M7ODlYJvgDWF3tzeRDj0LRJYsuVrx06u51vRhRMXt1rgKfbnq9f23lIYSw0mITZG+a3/PjwbiwjmTrxZD5MN4mkLI+cRtSffYJBZGR+fb+rKcgdKEBVfdPgn05BPRO0WramBPUY/4BVtrLn4CEvoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXp8GWtP; arc=pass smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXp8GWtP"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc750a1482fso1380352a12.2
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 06:44:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790257467; cv=none;
        d=google.com; s=arc-20260327;
        b=GQnQchJ/ha9B4Vvan6Mkrk1o91ilyIVmWpUnCHNHSramU8R467fndp0LHLIrepCGC/
         axRQ0k60hpUqtHvsexkQ1sAHqL5jKjyEcaSMcNWt1ytFrTQ56YDgjMgv8VYlg7WTvCDh
         2RHE2E53f1R2LotkdG2bcA4SVkg0U6kgUX2OXsPA+6s8IgwvHNhFncP1DnnkkkhKJ01z
         rAfM/J3S/SwZxj5PTpysa25ncXoxqJHbZADtABy3zm5fWnHblPGqt2+p+cbr8gePsoIe
         2vhE45jwBPNqTYfrwMoMdDUlGW9EZFKD2Lz7kUYwV2JPKrJGcnL/dDoqrwpF7krS18m9
         Kwxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nlngpjoJXsEVxEuj2gq7hM2g/yYyiiwaQMo7R6hUNyI=;
        fh=1mRN5eobMYeM6r2bbK90MeX2WWdy1RAeAfW67+ucEfE=;
        b=sEP76rrNAe5PHQZpMouOA6w6HoqqedBB20G7B0ihH8spgbLhZhceUAgofvLGUolBU0
         MwkXoFxBrOfKKXZiuglZLDsdbMNjVHD8e1lU1DN4lBNZEnO3H1o7f/wayo0SqukpDezk
         twxPblrX68LYA24V/grTbDzeuoz13GOBCzNV/eya5YXhDN8FzWs9cw4ByxUEwlaeG16O
         0Xf9PwNR64s61JF6hL0Bn4IQyUcBJzCZKrontQGWuWIS+KiYAbyrxRbv4OJ6/Tv2WeM7
         A/e+OZbCxKrDsovXjIF2kOFVU3gUkV8SIT16EcZgGQ+41nn/gGhXej2pmktYJ+7wGnjJ
         x2LQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790257467; x=1790862267; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nlngpjoJXsEVxEuj2gq7hM2g/yYyiiwaQMo7R6hUNyI=;
        b=SXp8GWtPMjoV9qkWkWx8Qa+9vDPPN5DessE0/O7/1AcXVzrgDft4U9eYgx6+Rh4g8q
         qGGbiLPh/WiGhqva63M66QptrjdqHv8OOmH9ZSWurw3CPNu565s62WwLNHIwai6TyteG
         UcWe+Ww1+v3QL9dSwXLjql5sK36P96rOinmbl9IrAymGgZpaneu0XUYvkBndmdAgub9i
         5sQnSjtUFSSx5GtYkpTN4VKRdHngxBqzyluO9z1Xik9GVCtsqP1ZQeOn7Q91sBIrf8Dk
         mbZWjAEynFhLBebnza6CpMQzH1+sz+MMPAt3cRnbf/tmIh0ztx2iFroRus6gYJTpIMqR
         w89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790257467; x=1790862267;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nlngpjoJXsEVxEuj2gq7hM2g/yYyiiwaQMo7R6hUNyI=;
        b=qB9w9ECs4211gwbJpuy817ZwYkmYC6nBk2n/G/zfsdUNGil6R3q8jmtCHMJj+eFKHX
         hkfAjA/dI1erZmJCy5Zc72mm40L+wxYfxxhlrgQYNGf0skQRILyXRHw9hfTTXUG77HoY
         CA1BD9XazD/HIGSSrf1HVagMjcKq0eDH1UMSj7Tc3+D7D56qWA2GE68K62zfhETs4Jfz
         0uIXsp71kwWTUXzoEyBJSmQ+Tq4t28c/CESr1YsLuQBH2SIghUiMf6mv8jCJTxJEYTl7
         HkL0BR09/pA3WVjM2cRPmsmi6kRhXjAT1p0Dl86mwVPI4hDQPuzanRfFQ0781CDl4VPV
         dvEw==
X-Forwarded-Encrypted: i=1; AKwUvBw04svCA6c+tkidYA9oHjAGiosk9vN1jW0qq1iaaRGAPunXvCZznS7UFaf+29qRodZGRxcm0VI=@vger.kernel.org
X-Gm-Message-State: AFuF++kf7315nWAP0gs+MGQ/cF6nPAVYz9UkseBDKSpS33FJfW2BMkP/
	2D3CuNUtUhAmpmbRzFSK+7huHcuRWQf1xLmflnp5utOLTv75rysIONIZkaiTWdJmv7cg5vHX6G2
	42S0QhnexE1K0yFZVOGYkbK6fkiYddq0=
X-Gm-Gg: AYBFou1A4slQt30D1xHo6+N41JXV4nbJgcK80TfU787NaRLtDlEBlrUpYe1imGMKTDA
	q8KuY0EYsS1FU1r0pH+mY/BojZtvQhUfK4ezNbOZV4/kSIKhX/DE9hQy+LpJgcshkjTTpP3rLMs
	L5RaaItcRMZPgJ9UkyArgN3i/cKIEyqtpHG2vKFvu2kk5tTSuCO5kEG9MXiUrYfrgZATSyx29pK
	czZpkHVY96KHnd33bhtGfa1G06Nr2LpG9h5TSFMIH3B+8KjUKxTRYF+0LpVffNC0bhNlFfakDYF
	Kid/ZpPx7dHEqDqosn5GYeDk7v/Jhn4NxptLa9eMY4ARNi/eVPTWtYjIoDs49ktZ0IffDemFpdq
	OuRFe3EhUOuZSDFq0l6YuSHrGqp3yTAg4EtIl4bHKlGhxaWZuXv/2Qw==
X-Received: by 2002:a05:6a20:1f28:b0:3dd:a196:69e1 with SMTP id
 adf61e73a8af0-3de0ea1cec2mr2440252637.60.1790257466883; Thu, 24 Sep 2026
 06:44:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919213634.3314055-1-benquike@gmail.com> <4745a390-6859-4a5e-8ee1-ab9634b3bc10@redhat.com>
In-Reply-To: <4745a390-6859-4a5e-8ee1-ab9634b3bc10@redhat.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 24 Sep 2026 09:44:13 -0400
X-Gm-Features: AclHuK8jtpDrFAVJeOq2D55eedj6RdtFuoTdSF_mfwp1fcThXvzJ0oWBMiBjo5M
Message-ID: <CADvbK_c0+KxZ-AZA4vhWpOT1DFBic-iy9gfrd18s0KQAdskvTA@mail.gmail.com>
Subject: Re: [PATCH] sctp: copy zeroed stats to user in sctp_getsockopt_pr_streamstatus()
 when !streamoute
To: Paolo Abeni <pabeni@redhat.com>
Cc: Hui Peng <benquike@gmail.com>, marcelo.leitner@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 6:14=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 9/19/26 23:36, Hui Peng wrote:
> > @@ -7589,6 +7585,8 @@ static int sctp_getsockopt_pr_streamstatus(struct=
 sock *sk, int len,
> >                       streamoute->abandoned_sent[__SCTP_PR_INDEX(policy=
)];
> >       }
> >
> > +     retval =3D 0;
> > +
>
> AFAICS the above is not needed; retval will be zeroed later, if in case o=
f
> no errors.
Agree.

>
> Also this is IMHO net-next material with no fixes tag.
>
If users call getsockopt(SCTP_PR_STREAM_STATUS, &param) without zeroing
param, the kernel should still initialize the output fields when the call
succeeds (return 0).

So we may think of it as a Fix.

Thanks.
