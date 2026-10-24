Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792864208;
	b=RRH+RwDqYjGeYSoRmPPBX9Kjr03MOxQ3IoRRz92ZOno2H9CmhtAhnBfWM1nkTqRESsd3
	 7wxObYo8KuGe0cYF622Rg6lEth517YrY0rtYUDKpHHRlk3p3Io9jPOa+4KrN3oKS8OWZX
	 LOD0gKToim1iEo3rzyjCLt9cq0MFtOVfJ5rFW+9uVD9PsOa7aookh4a+wkpigpIxwvi7V
	 0B4FHBYEFmteel2l22CBX1ayN1tOzeY8d96GurZKMnvMwuR2m9L5H7uFEpi3jwmXtOltq
	 pzTwLpb+7xZmV5QdXMIERfgc39ZKi6Tk8+VAYHWL23fpQ/LtXGr8I4qShV7Ihe1ISSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792864208;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=e13VenEd1BEuorXMAXfr7EaS/N5/QZgYsznMIVDfMuk=;
	b=upjoRL8sn+EaI/GZNp+EgzufgOjr/mVkrrf9gil4r8PvO+wX9Ll9DA7bSCaDFC9IylLd
	 dJo4AmIfbQVdvKyDoKm6Fd2vHvyta+AEPrcDkNf+TD10Mzla+8NMGHMTOhs6dGcw4Mil0
	 MJSLLbTzLxEMD33T0TC2MQnNkbtN/H3u4Q+x8Il4b6pTElvw5p1MFQWRF2BTfq96mArUp
	 VQRemoUr4SvNCAHaFucE1zkK42B53H2I9Mbw4eStI8b+M8RXIudK34OgGu9chqFI9mpvJ
	 U4TRFkICihy5DXh/jxEwK6B8P0I0LYgDVV+qZoXzlfxz0OZ+HtD+UbWYZ1QGHB3FUDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=NWD9Yalf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0BC606A31A
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 17:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D0BC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=NWD9Yalf
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-15ea896ddc8so3074677c88.0
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 10:50:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792864207; cv=none;
        d=google.com; s=arc-20260327;
        b=KB0VBJl+WduhQzLDFU7VpJspghQoAIexjo5YYo4ArzbdDoeFCoLkuGDNb90RpMet7/
         Ur68omDYB6vVQ/Jxy5fp8/2o5yA+7YDXVAN/no6tqFd6Lkx/GU4MKoTS2yFaHK+pN1xN
         jDVqc4v6KDIilQvG9EZSo7LVCoiH5pcLyWTt+Qz0srPt7usFkw7NQF50Lpg5NseUOGMd
         pyWyGa+rB2/BcAGZ15cxDJJfUEI1RkAOU3PS0YrJ3WRGAr/thehg5ovOo8nr8YHX5biO
         xBWU373SSYMr7D8imI22aGM5MbgEiVl40hRu0iP6M0whMEDxEzoRRfavQlJvBaB8MeFH
         tbbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e13VenEd1BEuorXMAXfr7EaS/N5/QZgYsznMIVDfMuk=;
        fh=Z0dPoTFivEHestOrT1uaLQmSA3POvOFYpYDgcn9Q0k8=;
        b=qdsvs5RE5Wp4qbkxJbbyOyJhUE3nnCZlBtpKLoTHDvtLeCeytSCl5hAvyWBjP2Spgz
         F7ozkT+WXM4fEU9CnI6R3RCnmlTyLTi5Cvr950WnKJsWIEszB6v2+7+Mcdk06rHgAG3j
         K8qoqjIog6WiPH4NKo9KZN/VIyQAMLPrdviXQnGPLgSJqu2UYBepGz/RDPQvYUC30KUs
         N+JaiEebRi0piulx0wGFwQ0NxKLBCHZlhCiEOKoMevjp9Dq7VfCn7wK2lA/WFbKyQtv0
         tWdboy3hwqoSM04Pylw5zkh1cvXCf14gmFuXO2yi+kxVrTvbtLcCRw4HvZ+9qddkzs7d
         2lNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792864207; x=1793469007; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e13VenEd1BEuorXMAXfr7EaS/N5/QZgYsznMIVDfMuk=;
        b=NWD9YalfinQ0st4ZdbeUvc+/nnFyJrtqy+ZJfXN6KXdBDgh9Y8NLI9ctx45QUexlAg
         D023GoHw9LfggCx6/n2FRefFkRw4BB6+CSZ6C4ZSbxw1mo/BnedNdn8SPYMdiVkybO5O
         E4FCfReyo7I9uscBa8cACD9rF477+2wBAyAS9WxsiRnifM8OCNhxaQ2w7QB59M4Qmr2l
         tPGavWV8xcERJM92Y83XcaBzjt44XG45raIPKiMFuRAPcWMvgtNbhtcMNBNJKucB+cnY
         2GcErNCFaWOUCCUQfJ0qKUPc/+HWbnojoKOkdwf+20HvkN72MC/q6ZaXFDlf0C6M+x6r
         CYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792864207; x=1793469007;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e13VenEd1BEuorXMAXfr7EaS/N5/QZgYsznMIVDfMuk=;
        b=rSfcBnNAfWPBvJPENWvD9/ywGXUUd78pclbq/z8DC4IELkK54K+prS5tweG33ec+iy
         uG51zQJtusaSDjZ4bdJw2fZorhgTsNVSxjVqnSxh/PU+8nQ0cm38fdpx4Vy6/j7HDmpP
         yALFePQw8FMoNiUQ8j2c/VbQEdxut9DuPJKq1Pr4pOEAz8Fs9jAfqOVjfljrOz4OKBZr
         2tzF2chzC8e0ZrFOTUVl3oQMmC0QFgLTaEM8+9fm7DCadf75b5KM8w8kenicLqSpUwiK
         bIkL3IJSdu09aYVDZ6s1jo5nbH55F1ZAvON/ZR3YeLTfZyxzwSveFAQXky2EDbzD5R4D
         PBaQ==
X-Forwarded-Encrypted: i=1; AKwUvBz9W/YtffKR4v5tNwtslONe8pauaeaAbZlB8+UQ6T9sfYsGOlczFaeDD7Cp73SfkuxED4mr4mk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIQa/IG5/C3uZGbtRpznAAIg7geKqSeU7kPo1oL2NMlkYAIN4tH
	9+zOHMwUjAnhGjA+DP0EODVUahKhiAKBVtJ6poB34zL4sWY0eWjTmnlT5i7GXxa5LAZpZOAMyGd
	phGI7DBLiQcUlgRQp2uYW0HwDSooGk82XQEQbfrP0
X-Gm-Gg: AYBFou1FfEvPmCEZpEJlmQmSd7TbmrUKsqQf+fIi/R/GPQ8PBQb3vPZgQbAQ8JIBa5i
	GQaqcrXNBVHIEjCKTgLNnyWBAirPCJjCbmFrf1A/lsEECNSSGpfFpfMYfyEpSVu/ymU13rfUyGV
	enA8ZhPFTotKEf2jFgsUEErr+H//lFq4krzJRNqzkz5CDZYkApv2Tonj3d6dfpSOo2dOw5oGsn0
	iHow+O4SGTTBqRtS06lsmzXQeqafQBhiyk81dmLBItoDfJ6suHWJIzFKmIDHps/KlKnBbDFfEXx
	opkRYnFEReQ+B+P42EMsJ+xbV3JRkaEMvUh0htUdDmjL49lr7RLvTkbAMPsihI3hx0WCoj7meqO
	LzuD1Pi9swE9QhsIYTwjL/XMOztW7qiVoAKM=
X-Received: by 2002:a05:7022:7e0a:b0:195:9228:50a0 with SMTP id
 a92af1059eb24-1993686f4a1mr3698533c88.42.1792864206204; Sat, 24 Oct 2026
 10:50:06 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <224334a7-150e-4794-af72-596c3821558c@kernel.org>
In-Reply-To: <224334a7-150e-4794-af72-596c3821558c@kernel.org>
From: Sheena Mohan <sheenamo@google.com>
Date: Sat, 24 Oct 2026 10:49:54 -0700
X-Gm-Features: AclHuK9luGbh8I7Sn2OnPwKHzNq8BI1aq3D9XSieoohs51n8og0fglWx-EqeQbI
Message-ID: <CADWJPTundpvzkpJrxva=M+6YF4zQ9dRSY78Xypi9B1NuH58Usw@mail.gmail.com>
Subject: Re: [TEST] Google's Netdev-CI: a few flaky tests
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>, Netdev <netdev@vger.kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 9:02=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Sheena,
>
> I hope you are doing well.
>
> While looking at the results on the Netdev CI for the Google runners, I
> notice some tests are quite flaky or constantly failing. I marked them
> as "ignored" on the Netdev CI while this is being investigated.
>
> - IDPF: psp-py started to a month ago. I guess you are monitoring the
>   results, but then if it is normal, it might be easier if you block the
>   known bad tests from running on your side. Just in case, a few links:
>
>   https://netdev.bots.linux.dev/flakes.html?tn-needle=3Dpsp-py&br-pfx=3Dn=
et-next-hw&ld-remote=3Dgoogle-idpf
>
>   Because the previous branch didn't get tested, the regression might be
>   due to the modifications introduced in the previous branch as well:
>
>   https://netdev.bots.linux.dev/branch_deltas/net-next-hw-2026-09-23--16-=
00.html
>   https://netdev.bots.linux.dev/branch_deltas/net-next-hw-2026-09-23--08-=
00.html
>
>
> - GVE: "queues-py" test started to fail recently: I *think* it is a
>   regression due to the following patch that has just been dropped, but
>   we will only know that in a couple of hours:
>
>   https://lore.kernel.org/20261021155611.68473-1-phx0fer@gmail.com
>
>   https://netdev.bots.linux.dev/contest.html?remote=3Dgoogle-gve&executor=
=3Dgve-nipa&test=3Dqueues-py
>
>   https://netdev.bots.linux.dev/branch_deltas/net-next-hw-2026-10-22--00-=
00.html
>
>
> - GVE: A few tests are unstable for a while and have been ignored: do
>   you mind looking at them, please?
>
>   https://netdev.bots.linux.dev/flakes.html?min-flip=3D0&pw-y=3D0&br-pfx=
=3Dnet-next-hw&ld-remote=3Dgoogle-gve
>
>
> - IDPF: sometimes, it takes ~4h to run the results (+1h to start).
>   That's fine because we have a 6h window, but just wondering: is it
>   normal? (The GVE runner seems to start quicker, but I guess that's
>   because one is on bare metal and the other in a VM)
>
> Thank you for your help!
>
> Cheers,
> Matt

Hi Matt,

Thanks for reaching out and flagging these issues. Here is an update
on each of the items:

IDPF

  - psp-py: We agree that blocking known bad tests on our side is
best. While we resolve these
    failures, we will disable the failing test cases to reduce noise
on the CI dashboard.
  - Run/Setup Duration: The longer setup and execution times are due
to running in a bare metal
    environment. We are looking into optimizing this to reduce the duration=
.

GVE

  - queues-py: We also noticed this failure recently. Since it is
suspected to be a kernel
    regression, we will continue monitoring the results.
  - Unstable/Ignored Tests:
      - devmem-py: Should be fixed by patch 4 of the series recently
sent upstream:
        https://lore.kernel.org/netdev/20261023204706.3112215-5-hramamurthy=
@google.com/T/#m0f075c545d9de1c0ad3bd95da0f009a82e80b6c5
      - napi-id-py & bond-options-sh: We will investigate both tests.

Thanks,
Sheena
