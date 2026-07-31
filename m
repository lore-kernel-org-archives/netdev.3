Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72BF35DA6D
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 05:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785477254; cv=pass; b=kS9FYcJSMpEPH5KfpjiBLcomVA7hVhKYCMnx0UB5WlmYXUTJNjRJZPFQAGWrcu+xl/i3MVD5omTOKzI4MUB/EM4gXJBuw9M8CFivkuipLJ+KzNhhAvdwGYMcUXQHMvRbtCtoGSeql4ZhYXI5jhZccqDmf5S/sHGQE1xRochXIX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785477254; c=relaxed/simple;
	bh=XHNlV19Q7ml2a2pJDaT8s/3fB3WCjJvCUV5nREXZKk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IKnDoEUszvoFkd1ZOgrw7dE7f/ehLkzdPu5r31xIG6Ya1KB2hAFwHFHXsIdae7bzZUlLrRn6cy/FSBuqDGUrxDitY48LJOMobU9EhkMo+NqDEuQPXEbyIoCtCcTUfsX2dMvXgewQQWhmwCRLls+lC7hp1BancJ+uzjSTparuto8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cc6geEsl; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cc6geEsl"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cc73e322dbso4839575ad.1
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 22:54:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785477252; cv=none;
        d=google.com; s=arc-20260327;
        b=WGiPQQR8elcsiEAg7uA1DLLRAl7x5QdTLIQhHU5plAEtkn4SK/atYGgQC4rrQoGw+w
         DpLXXWO/CyS9DY2fQTWwSk/NLI3fApmiYxT4qkEV2cNRHQQLIVB5wmaOqEUFcX+zkivz
         1DT8PHaXr0UuI2N/5RGBX/VeEJ6XcN8bt3uZ1/hIt0kl9ICc1cO6t2QaApXjLnBuvZN3
         fwcOSZJLCnYzpg28nkmqZqJFJuwXto6Zj+5ayLvuYwjhkdlrVZgoTaqfITH3A0YLw/B1
         SnkI012FafJ+UVnHpYQX7P/1OZw1qZ5ow8wV1bhhd/iiunpI+qVf52C0rM2WROXOXlTv
         WLNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UmCP+stc0u5tGezIQuklmcGnHK4QDUd8Q+1LBzW0BG8=;
        fh=trhsGPz9qmtpheqLDwTMTml0nVKeYpHZZ6jlUs6mUSA=;
        b=nVN/yNCVblsW6RLpS9moV5A76wZaigqtWy8yXfduh4iQ2fVuUqJK6LoT7h9NnlUf/g
         JI4w6qsj1Ak8X0pRJhIURsaXzcQW2H24e6qOu3LnICCnZ49M7eRzRk6xzupWxTYlFYhu
         vU/lpZNVnzVLN2Ia34vMyPm7DsaTHMDiuVlbPQlEng5ZpM30rLQ2mdaXRvbeMxRsNjVc
         C05qEuxLBpsWJlVmc8+OdhJWyMrA/1HGM/fCF7LoQOXN2WU4d3bTnvVD6dUiQgkpJHKY
         7y/cdkYpltm0UhCsxRxxphM3ZGrZ6UtD0tm0G07/qEEzps7FX09epVcEvvo+c0GDtf/b
         mJfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785477252; x=1786082052; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UmCP+stc0u5tGezIQuklmcGnHK4QDUd8Q+1LBzW0BG8=;
        b=cc6geEsldfN+TNRpTF1uMSM1aiGq5MusGVZDS02rsy2/z4VMdCD8uN3EbJFI68Dl1o
         lPfLg6WvXen23onyZEzIZkQCQgItH2QPi9ocUq1XE0PMcUXGuTYPatVIpbnMWzHwx0eC
         Fhy/oBz9Ype6tQnkexpaQHqerIWp+spf4h4UTafA5vHZ1EHt2Ir1NkeIhMLBUMnp0HzY
         fLKNAwS7OLLb0+boU9O05LOwWLg3kOchtbpOt5gPa1RLLB9UuppbM2VEM0UjmpOuStuL
         ZHYxfYnvgf/d5vWKtK2sJXQNd0LmXfZE7+w2NhidkErQazGFLn2RJpechmQZXKIfyivD
         HxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785477252; x=1786082052;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UmCP+stc0u5tGezIQuklmcGnHK4QDUd8Q+1LBzW0BG8=;
        b=hz4pPL0PLA/C3U1tkcNVPNHXpAzJJFoKPfSiEUd6vix2jIzmCugmQv+bIQpeT6Tnxx
         zoleQMHP85b0I1lY3HxA0tEo180mUmFcIQHjOjLzTVjrs2zSrfKY3bi+4GNS3aI2Z8Nb
         X7WL4SwtJdN7HW0AVeNOks1MGCa1A2GsYWa0CvsfnmBKXMp3lHS2u141Htm0yF+PKmBX
         vHqRhBTxIgr3cNB6F1gLMWLDocbD/+SRV85EByof2DrwwFBCROnRUBHkAgIiEyDVLbFU
         e0j7cceCZb4wzGvwsvGSL1oHdOZy1WmikLG7p0fwRLSufvrPcpM1ReXAK5g83usQHJZR
         f1YA==
X-Forwarded-Encrypted: i=1; AHgh+RpwwtUInHW3vIVsXHPPXD+h2b+Vt8S7kiTS96STy6RgBtIoUxYjJ0SD2EPyvJNnPhzFufrJKj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YymrVIx+zzzfCuPqiteNK4Hw75x/qkoD7eb1e1SL3n4Bpp8Yn18
	M3O5PSF4uVAHW999MsIwTh8a1ytCC8AtBHQxDDPYbfTppUk6ZRdY/9vUv85nY7h15q8lRvvV6sc
	1beADD3EwVj7XMkDYW9WIyJg/eQHvCsoKlqSizpScjSDY52zwxww9AfzAtBcX2g==
X-Gm-Gg: AR+sD10DvjH8kMlm4qchmPxDh0/1ywWpdm1rTwUcUOPQJwCiihwVFs5Q86vqqWIUDF3
	CQCj0uXE9T1ah/YeqkKLwgztU4WEns4IRMlFChyKf0pwpqCisTiHblmiuFmYyN/4pjgpk6MyOsw
	8pNXAo7ZR3ijkKbdIqXuMn4SqmT1giddgwfPhbG9PEV9URpT8qhebhZ3Cl1JTgzph5L6TM858GG
	Dg78cd/ouwI0NvlwRY8Ej1GTVOsdjsMoMSb2zLxxFwHULpvGTP2YKDkTxTeiYSmZseQMADEnCpJ
	Lw+A7VvaTwk/vv7uM4vj88/tW7qX6pGbtH5BFgpNxcF6gACH55l0kVVgW4B3yttFgn42hDXbS1Z
	lSL9ZBadTh6Yeh6Fiq47hSkiF7eI1J9a0kLdTSAMpX5fMVpZ+TZxc/IIB8yYDlPFuQY0sscZdD+
	c9344CgaZUrhIzfPQSfsrJfcK6edC3+x2WalvX
X-Received: by 2002:a05:6a21:6f15:b0:3c4:3321:4fe9 with SMTP id
 adf61e73a8af0-3c91b0665b7mr652070637.7.1785477251652; Thu, 30 Jul 2026
 22:54:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730144652.5715-1-sebastian.chlad@suse.com>
 <CAAVpQUCkKUa55gJTqObD_6RNLDVdXqaak7Wst8o20X4RDnSmQw@mail.gmail.com> <CAJR+Y9J8d2uCN08+VYmsa4tKC7G5joM+DwN+PbskVDjf==A0=w@mail.gmail.com>
In-Reply-To: <CAJR+Y9J8d2uCN08+VYmsa4tKC7G5joM+DwN+PbskVDjf==A0=w@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 31 Jul 2026 07:53:59 +0200
X-Gm-Features: AUfX_myToYb7rGPnToADD5lUFwNvUNL-Bmm3V54srCmsQZ0xQkDmokDft60kLwY
Message-ID: <CAAVpQUC3L9aUdq7M2bReCEZ5MPLPSHgC+VjzFboWdTbG=CMV=w@mail.gmail.com>
Subject: Re: [PATCH net] selftests: af_unix: skip scm_inq tests when SO_INQ is unsupported
To: Sebastian Chlad <sebastian.chlad@suse.com>
Cc: Sebastian Chlad <sebastianchlad@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 7:41=E2=80=AFAM Sebastian Chlad
<sebastian.chlad@suse.com> wrote:
>
> On Thu, Jul 30, 2026 at 8:28=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> >
> > On Thu, Jul 30, 2026 at 4:46=E2=80=AFPM Sebastian Chlad
> > <sebastianchlad@gmail.com> wrote:
> > >
> > > SO_INQ was added in df30285b3670 ("af_unix: Introduce SO_INQ."). On
> > > older kernels this returns -ENOPROTOOPT for SOCK_STREAM too, which
> > > scm_inq.basic/partial_read currently treat as a failure.
> > >
> > > Enabling SO_INQ here is only a precondition for the actual test: the
> > > SCM_INQ/ioctl(SIOCINQ) consistency checks that follow. SKIP when the
> > > precondition itself isn't met, rather than asserting it succeeds.
> > >
> > > Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
> > > ---
> > >  tools/testing/selftests/net/af_unix/scm_inq.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/tools/testing/selftests/net/af_unix/scm_inq.c b/tools/te=
sting/selftests/net/af_unix/scm_inq.c
> > > index 6268b5bf50be..2868cce61a9a 100644
> > > --- a/tools/testing/selftests/net/af_unix/scm_inq.c
> > > +++ b/tools/testing/selftests/net/af_unix/scm_inq.c
> > > @@ -111,6 +111,9 @@ TEST_F(scm_inq, basic)
> > >                 return;
> > >         }
> > >
> > > +       if (err && errno =3D=3D ENOPROTOOPT)
> > > +               SKIP(return, "SO_INQ is not supported");
> > > +
> >
> > It seems you missed this in the few lines above.
> >
> >         if (variant->type !=3D SOCK_STREAM) {
> >                 ASSERT_EQ(-ENOPROTOOPT, -errno);
> >                 return;
> >         }
>
> Isn't that just a guard for not exercising the tests against dgram and
> seqpacket?
> So the if condition I proposed is for SOCK_STREAM where SO_INQ isn't supp=
orted.
> When I run af_unix against 6.12 with no SO_INQ, I get both
> scm_inq.stream.basic and scm_inq.stream.partial_read failing. With the
> patch, both tests are skipped.

Why is this selftest backported to the kernel without the
functional changes ?  That's the problem.


>
> Albeit I agree, if this test is run for stream af_unix not having
> SO_INQ, it should be excluded altogether. After all the point of the
> test is to test behaviour of SO_INQ.
> Still marking the tests as skipped instead of failed for older kernels
> is somewhat useful.
>
> >
> > ---
> > pw-bot: cr
