Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7DA246781
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 05:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785477485; cv=pass; b=GdB90wa9LJHacT/Lp3pKZV2e9a4hkN6Q0Gp0w8EiLIE+880YtDSAkYRMDV5UWB7GSFyd6QzwWClstsy5liYCrBm8tlz9KIlSr8AlLMPKQuuFvV6TPK771VNOI8q+MKmpAqkbahIRq2OOuFeuLD60ClcJSak7rPb2KRrtK7EsCos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785477485; c=relaxed/simple;
	bh=emLssNANKjR6D2EA8lUIj+AFnHahRlXEY7tw7Bf+bVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dr0Qg+xHSbdVOZ+yyTmmCKXD3VGT6uZy1iAJwxXWupe2GGgyVlIES112MX6foMdo2J0XIXW9dHFZ5W8tgBf9MYijSaTglj2oFPm9IVSWn+/2FIO1SVcHv7Q8aHavZzTnuwsOW3mxLdJL1s7EdH74sWup1KXbz7bkmKbLmeRg7CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aw+qq58V; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aw+qq58V"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f93b2fe4cso308572f8f.0
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 22:58:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785477481; cv=none;
        d=google.com; s=arc-20260327;
        b=jvbs/SwKOSBcBn7bBCq7uZuQVnIM4YkssRmQljEgCNtelskBxHh36Q8H4FAx5i2qq6
         VZ6wHLYFSxgwfy4DgmTzrXp2emppF43jEFG9oZB9YlEiiKji9cIculzcdc3GMUHWsCYn
         bawc4kbjWwoI3RNtRZkMwKHmJLuO8jRybf0ewTzWDI5Tqs9zMZHru/bkwy7cG9iyynwQ
         r1njzkqQuLG6DoYUGqjcaR9qDHhq1byI4BhzRf13kjoyccquHq7OInS3wmkOj9hf2D1D
         CZEwS2/lzTpDT7vuwZLgkXc45dYeV6AYhF5tKnBEZL776yhdAeLRBVBOWlCf1iqXx8PA
         qleA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=co6uPJRR1e3jcke4HUwp1VdslS4AfxHjYg49CdPjVD8=;
        fh=l6gjbKcqtGJ/ymAkbfLX0T2LKJnLW4l1Q06ldYb/ZeM=;
        b=cxvLVnIQX5kuLwbZ/fmnsRC+Z69v9pHwRdJuiTpIAaX3Meyi/Weq3MOmT+FlwAtvxp
         qI92G+48/QQ2z3LWeLIRI4Xidp1r47u8btasCBmsmiNAbia8U+6o3UaIq8cOD6C2QTOQ
         jvh6qMa/K0QglMgKlouBxroMN0oiIgk+hcLFSC3CF16ydOrD7pqwnaQtArRRkIka5HMe
         xVtUdmtEQPNTT7dF8yk8DBd9b86ZE1GLh5QgIkflX63bU1U541yBRGBirNKeu1J9ajQ6
         Eueb9XUdzT6in9/7kAviEQZ0I8Ar3CLNStyqm5TP4aygDbjzLFq8GHzGN4KbMVr8JFrG
         T9Ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785477481; x=1786082281; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=co6uPJRR1e3jcke4HUwp1VdslS4AfxHjYg49CdPjVD8=;
        b=aw+qq58VXr4ckw/nk71FWCxg/rjkEnSLGZEku+EMHJ9/iMgDSEIYc8PqESYjRt38Wu
         /ALFRnNOA5UvHvX10tfafp26J6eQjyLPT+6wNSjWtnaZKNHT8EIQ+shqzPm9oq45i11c
         zz4DZVLGIwMid3LebkMCL81tBpg2GEBwaqxusVFT4VhFjd3EcCbxmT/gNfasTcMCauRu
         nTibl7lZPF/DpCOm7tNdgR9aH+OZHeVED/x8UhIcApNo9JXVFDd04BdrbxVQ01y/8Cz9
         vVmxEmGlRD2Q5AjGYb4lurJrn9z593ewyYshCSLUvmcttL2NhmwVzAccy3O7r/aToa4A
         27VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785477481; x=1786082281;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=co6uPJRR1e3jcke4HUwp1VdslS4AfxHjYg49CdPjVD8=;
        b=RA243qxutcYqTMufGxXSWzkB/gXw6jBfA4ut8HaJFyqxzC+0wvXecW2McJOn5Ilm3z
         h5qPVvvj3985wDbwelEF58IPsM6/jPZ+1OCt5n7DfqSo++FYxz8zucdyMPuVi6yxvXl1
         w+UwsM/p+9pjAh+CV0DMKwwqJ1JvN0UkylpuQJ0hiF50I7kmNyhjJdl5Gl1oFlFmFhWP
         xBptdUNysYmXZ4YFeKA1szIqnlLycisHu63gYoO0wdb6Ud3fp0zvu7mOPGygKKOSYMM1
         7klITGUwO5C6kXYPbgaaDVs0s7p/b0yhjUjwFLIGNHEmhrWsMwP5zFhAYEjSYAZtT3Kw
         CONA==
X-Forwarded-Encrypted: i=1; AHgh+Rq0HBvnmfJof8yD3sSQehAULxLEUrq6AUg5An6w0GQH07epu+n5poL7i7Rho7Xl+W9TaVU0O+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+crGQ1VyV1XcydmNMm7JVyHwwoRx9zuDcDbWS2/6xjwV1Cm99
	7WWZFuxvc/9iC6eYc+VZsqrTnUOdx/QEtYMRu1VWi3rz2IeJd5CReuHCzW4eG/xelAoRTeiUbmb
	NugawRFOLB5X4zFAx/3CeBEUQ+0+KvZneTef7HNPQGA==
X-Gm-Gg: AR+sD12RxW1x329M8BqgX+qxOJH5dzhxssBTzfeN0dpU8ZEVzv1uY0qjg/cJI7srurn
	ziqQeBX8JN7sxuETt6NOg2veTHbd2grt1Yx9yavmJ9z9rCMobcX6GNPu+mKOzIxNCqBIuuiX95+
	Zp5j4dM4iAC1jOv9CdLg6YRYa5/IN/kUvmuBX3eHraiMC22xZWaDQt28gvAHIZ8poyALq1lrodV
	I7JJQtlFSutk4dKOs3w3uZkyb4Y2CLY6nWP1OOo2TgWwwyY9SVwIDozGMoptNN+LtDfjX0eq5BE
	D2ySCOLCpF6+HEX3/LsNX2I1/UZNIXytXKzNIaIhuLXs
X-Received: by 2002:a05:6000:2408:b0:47f:8817:eb7c with SMTP id
 ffacd0b85a97d-47fd2b55221mr1622082f8f.42.1785477480683; Thu, 30 Jul 2026
 22:58:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730144652.5715-1-sebastian.chlad@suse.com>
 <CAAVpQUCkKUa55gJTqObD_6RNLDVdXqaak7Wst8o20X4RDnSmQw@mail.gmail.com>
 <CAJR+Y9J8d2uCN08+VYmsa4tKC7G5joM+DwN+PbskVDjf==A0=w@mail.gmail.com> <CAAVpQUC3L9aUdq7M2bReCEZ5MPLPSHgC+VjzFboWdTbG=CMV=w@mail.gmail.com>
In-Reply-To: <CAAVpQUC3L9aUdq7M2bReCEZ5MPLPSHgC+VjzFboWdTbG=CMV=w@mail.gmail.com>
From: Sebastian Chlad <sebastian.chlad@suse.com>
Date: Fri, 31 Jul 2026 07:57:49 +0200
X-Gm-Features: AUfX_mywxoD_Ydcvg-e0AGTntkFL7_SAynC_Fn-Z8XyY8XM5L8xc-TMXTuoMhv0
Message-ID: <CAJR+Y9KVw4VORFS-DDdATckcAjTpmnArTMFwqJHuB=v=pYHE8w@mail.gmail.com>
Subject: Re: [PATCH net] selftests: af_unix: skip scm_inq tests when SO_INQ is unsupported
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Sebastian Chlad <sebastianchlad@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 7:54=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Fri, Jul 31, 2026 at 7:41=E2=80=AFAM Sebastian Chlad
> <sebastian.chlad@suse.com> wrote:
> >
> > On Thu, Jul 30, 2026 at 8:28=E2=80=AFPM Kuniyuki Iwashima <kuniyu@googl=
e.com> wrote:
> > >
> > > On Thu, Jul 30, 2026 at 4:46=E2=80=AFPM Sebastian Chlad
> > > <sebastianchlad@gmail.com> wrote:
> > > >
> > > > SO_INQ was added in df30285b3670 ("af_unix: Introduce SO_INQ."). On
> > > > older kernels this returns -ENOPROTOOPT for SOCK_STREAM too, which
> > > > scm_inq.basic/partial_read currently treat as a failure.
> > > >
> > > > Enabling SO_INQ here is only a precondition for the actual test: th=
e
> > > > SCM_INQ/ioctl(SIOCINQ) consistency checks that follow. SKIP when th=
e
> > > > precondition itself isn't met, rather than asserting it succeeds.
> > > >
> > > > Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
> > > > ---
> > > >  tools/testing/selftests/net/af_unix/scm_inq.c | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >
> > > > diff --git a/tools/testing/selftests/net/af_unix/scm_inq.c b/tools/=
testing/selftests/net/af_unix/scm_inq.c
> > > > index 6268b5bf50be..2868cce61a9a 100644
> > > > --- a/tools/testing/selftests/net/af_unix/scm_inq.c
> > > > +++ b/tools/testing/selftests/net/af_unix/scm_inq.c
> > > > @@ -111,6 +111,9 @@ TEST_F(scm_inq, basic)
> > > >                 return;
> > > >         }
> > > >
> > > > +       if (err && errno =3D=3D ENOPROTOOPT)
> > > > +               SKIP(return, "SO_INQ is not supported");
> > > > +
> > >
> > > It seems you missed this in the few lines above.
> > >
> > >         if (variant->type !=3D SOCK_STREAM) {
> > >                 ASSERT_EQ(-ENOPROTOOPT, -errno);
> > >                 return;
> > >         }
> >
> > Isn't that just a guard for not exercising the tests against dgram and
> > seqpacket?
> > So the if condition I proposed is for SOCK_STREAM where SO_INQ isn't su=
pported.
> > When I run af_unix against 6.12 with no SO_INQ, I get both
> > scm_inq.stream.basic and scm_inq.stream.partial_read failing. With the
> > patch, both tests are skipped.
>
> Why is this selftest backported to the kernel without the
> functional changes ?  That's the problem.

I'm trying to run the latest selftests af_unix code against all tested
kernels and in the process I try
to see if some guards can be introduced to make that possible.

>
>
> >
> > Albeit I agree, if this test is run for stream af_unix not having
> > SO_INQ, it should be excluded altogether. After all the point of the
> > test is to test behaviour of SO_INQ.
> > Still marking the tests as skipped instead of failed for older kernels
> > is somewhat useful.
> >
> > >
> > > ---
> > > pw-bot: cr
