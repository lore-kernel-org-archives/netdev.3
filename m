Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF16F4D17A1
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789666051; cv=pass; b=igli8SB/ih2PJ4nPiVi3gXuyhJ9qJ73sp1FlJAe6nbsiT5djo7/H0yXbbQL9eNeRXHPYDEviGKrQhxlmX/CEJRZ7/OQycH923CR8f08D5A9tnaA9AEbLu43If6IUGeF6lMmNiXRr8yNnJWGLTcsJjtt0At37sIWR8DeDJ6ckx3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789666051; c=relaxed/simple;
	bh=rnjJ2IzL4qK8F+LMB5D40jZ72KTwVoNqdK2RH6FWOTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KfsdUKUdGdZaOBet7CRE6cDw2+agVqKk4uVPqYQgO6tedNAGD8J0bWDG3LH8zl/turyatWb288Zy0A+4h3auA2PIQcex+ygX/qTD+8l9iYCQ/Bdbmzje1PSMUw4c3Xxc9eYejG1D6U8GyqqMPaiM6lw4a28MjxUTL09AlHYNGaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/EOIUFV; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/EOIUFV"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb1a98dso881181a91.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 10:27:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789666049; cv=none;
        d=google.com; s=arc-20260327;
        b=KCHUAU4+oxtWOT6vKgfx9uh6grPQMPi8jSW9KgAKGfP7OgdBbE9/8Lu98NonSo0nt6
         aNHfxcJzAVUVIXdlz80Ml5DvDOoPaNJ6PJkvgc5SxkhI9mSJnEC8CWN0JonIV+YbzHen
         KMp1E7qe03Z5NqZNj9exG5IfLuhwYWnvWRfe/ZhhSFzUXSjF9XZSdC/syr+E7acSDIe9
         9aDURiRbYtaVVYvJ7aUr2iza/4GefiNlBePJN/oKmpPgTN9RjYhjUoHxRAMtLD60qiDY
         7WXdfhOQ/vVtUaWiO6PnNB+KdUdLRMVCQ43yp95S315Zn3b94yih4R9yCdIhGwhg0ngQ
         l/SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rnjJ2IzL4qK8F+LMB5D40jZ72KTwVoNqdK2RH6FWOTI=;
        fh=mDBUBD4R2MFJn4q9OWniynWXLdbHJzQZELk4nyUDuGY=;
        b=TpUEmAkVdNRaihc/8mcoNIjB5If6FB2CYt49Qqx7rUqxO1AecKBmfPDqd4ZRPrJP/0
         A0MJunsZbvJeCT4g6gRUG8XqNaYqvutAboc/+L9DhyXBkp8KkYo4bi+dXPPCcv5o/wLs
         dy9UfCRHjO6MTtQHA9LQoYxdHGdB8De4nfthRLlofIF6Y06H3WazPBwHE4Eh9TzHpDN0
         lB3rReNo3qe/DZESQeGYrNMlKa0ktkhwsgQlV9amOEN+E80ybIOtvC8Xokw/zkKnkJL8
         STG4AjBqU+mrFnoV4rwSPXp7DiI9rQPZj1Mu3Ri7+1BkUWq1w0wEKeOxJPnNG+7B+EpV
         mnzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789666049; x=1790270849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rnjJ2IzL4qK8F+LMB5D40jZ72KTwVoNqdK2RH6FWOTI=;
        b=P/EOIUFVamxgwK6SDy+zh7t1x8RRYudJFaA10XcXxnzn85VO5e6+5LMlq/sjnkAXaV
         YfcxlYkIH1J8pTcsV8p0lBy4D8QNSr1Q7l/z+lDKi6f11Wmg4g3hxhHuPZEwvNzqwshz
         PLR2wa8jYqTM0YFcIX6qZoyrH9g61a9Td9C06GaEWscC4pEb/TJRzRqtlSRFKz967Bjr
         A5Bzn/FeuEs3qh5cVKUGd2siTLAozBSZNqGGnugPTgx4lFTU9fjUZ9Pg1F4wABGJvXf4
         HSaewfc3A7MmUNRW8Ls2QygEZF8Q4cYLJwqD9KI7QagOgys18+j8YdB/2kOPAIel607G
         TlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789666049; x=1790270849;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rnjJ2IzL4qK8F+LMB5D40jZ72KTwVoNqdK2RH6FWOTI=;
        b=CeWNGd0hhL7yvcYBL9uzB0oPzvv5QFne5pg/Pqyf9fzALWOvtpTTBMTPUM1cgg1Cou
         jSjft3As8iRYKtXsHGOEbIEwWr34tpjrPKvdOJATxL3bFrHEoZSa1/2Ge5HASktT3rUP
         XTG33r18DFiOrr+lbdGXPMcvS1jbTaEMPk641luEOoK2fOUHDdZwyVOcR4sdzouU1b+u
         jO1jSG+Jvm2I+PSBAZdxzy8t3nhiaECU07MrBmW7wPeBXmGlIchQ3sgxUToCiGwtLsTY
         +Y89TpE14FQjtV6U+hisU1u4ZY0VBzGn9iSIKVxZwmnBgnbN9AmC+TTPToyIC456E1xl
         Bybw==
X-Forwarded-Encrypted: i=1; AKwUvBxlket/VmQ7lCo9WeMb3lHsoOnursikFIaQPULpwiazP189hOdlmaYHnG4I4G76feZEicdpXu8=@vger.kernel.org
X-Gm-Message-State: AFuF++lutLyjIBFz9F5ZwyAVNMJSacnsqYBS+IEMwHm+PDxoyEV3ErbD
	PXHqJUZfdBgXapmzipwwrgs4ml/a36MW3leaaBHjHtNcYPJqeLQFSeOuU//RIjDe8TVz9SWKPP8
	ktLQPZaUl3zzLITMB9aBvobR9uoUQOMQ=
X-Gm-Gg: AYBFou2lh42oA+FmRVo4BlvsGk24M/kUEyQgMcYG5rEP9SfFOUsRxcWZi+eZBE66qK5
	qrcRoqDTRnby2o8mgqL5xN3Ap75Bz/Vlz3kOHogd8z5RpMx/VJ3aTWZc3O47NdxAw4AO+cx4FYu
	Y7HG5LklqggNYBKVmedtYgtpKAt/UchiIeH1XiOU1bZ4qYEwPHdNuqnMWli0ZFjmUj8f1zbZyxS
	PhcYpxCBU8uVB9QYR0xXyCiD3YlxpZXvFUGlucs+/3hBDhr0fCZxptciG9d5tqnVB682SlQZ2sR
	aMSP47ZIfKNCY2iBvL32SFX9hUoT8JE+/sR/y1eoMHP5BzGzIdOd710Xts/kqJa+bAdiO6DBCJT
	w+WWZvIB5OpO5DG2w+M+ore8mJVF07qsc93SbS81MLxI+alx4SjJQJw/xmlu+RCw=
X-Received: by 2002:a17:90b:1b03:b0:39e:3558:f925 with SMTP id
 98e67ed59e1d1-39e3558fa6bmr9227481a91.24.1789666048912; Thu, 17 Sep 2026
 10:27:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aqvBPVcN__UX8P85@sirena.org.uk> <DLHJEZ0K0FV1.SCQLJJQNS1ES@gmail.com>
 <66d3f5cd-12df-4000-8459-360ba57cea12@sirena.org.uk> <DLHJUSTDSQ05.28VUGOV7YPS6V@gmail.com>
 <ec2acd16-40e3-46b7-b120-ce9eec70e942@sirena.org.uk> <DLHK013DCY3J.19Y8X3Z0RTWCI@gmail.com>
 <9d668d7c-8f85-49ad-bdb9-5cb81fb6f60d@sirena.org.uk> <c80c4e2aee9502d781fb52bcd5c0972ccd3bc7e4.camel@gmail.com>
In-Reply-To: <c80c4e2aee9502d781fb52bcd5c0972ccd3bc7e4.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 17 Sep 2026 10:27:13 -0700
X-Gm-Features: AcwNN1V_0iUx8qs13fNseQxj5RN_q6E_gTGBE2XuMqNGKhunfH4trjoxSpweNWY
Message-ID: <CAEf4BzYp0YAbhkdkKJn1FR0pjUF3JXUxqXkZtWqKiSVPT4=qOA@mail.gmail.com>
Subject: Re: Missing signoff in the bpf tree
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	linux-next@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 10:08=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Thu, 2026-09-17 at 16:03 +0100, Mark Brown wrote:
> > On Thu, Sep 17, 2026 at 01:27:01PM +0200, Kumar Kartikeya Dwivedi wrote=
:
> > > On Thu Sep 17, 2026 at 1:23 PM CEST, Mark Brown wrote:
> >
> > > > Do you have a full list of the current committers, I guess there's =
been
> > > > more bitrot than just this?
> >
> > > It's me and Eduard, apart from Alexei, Daniel, and Andrii.
> >
> > I've added you and Eduard.
>
> Apologies, that's on me, some issue with scripts configuration again.
> What would you like me to do? Force push with SOBs?

rebase preserving merges, and add your SOB for all commits that you
rebased, including "xsk: Use a 32-bit compare in xsk_map_gen_lookup"
which you didn't apply, you still need to add your SOB
