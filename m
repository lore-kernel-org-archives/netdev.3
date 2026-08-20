Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CD6362138
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 19:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787252546; cv=pass; b=tnnIM0p2OqUK6v+2ELwo1lxovb8dBQ+P4YdjRFaoMXRexhcTUzEHbeS0Lm42CRTJPGbDfEgOAodqkY2WYDICzNqiaV3Tx9iCECIKCbahmsS4UcgEC1dBmyHdsHDcq6cZpB1msZKWAZU1NUKQmw4mz/jOU9pIHpWsCp+/Lbifq+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787252546; c=relaxed/simple;
	bh=Um1AjudN3fT58qKpqjln/OYtdWEKpdeAdeLwIV35gx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N6XHljEl6qACttKzM52ijG1wWW5bvLGRfHVJsTi6+HktmuuBrMq9trnLXmT0n8U1bumaxecMwJ0ihQAq5bjSN+cerMb+F12bUe7sTNeF6/eqvcqMGodXOR7NIQ+kkZhm3XOu+lajAs5+5qHhiKPpDHmyMNAMz10FDCbVu4Yimm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Q5L4+oaB; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Q5L4+oaB"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso78628b3a.1
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 12:02:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787252543; cv=none;
        d=google.com; s=arc-20260327;
        b=d7yKwLfge01Lz5LjWyvNW+rvkDPaI1sHRUlHRnY0fqiULwOfc7EIkGst0NCu3q0J4K
         uW4ntlelaHETiJodmMEPG6xk3KwHCFiGqISNTd8I1HRE3vOzmfSRjVNywGE5tYT+S1yH
         O/xT5j2mxajBr/Q2+NSMpX215MemWdFfCOCQzLMQABWJz7rSSXyHtcjbdJIizqK8ZmVg
         XtS7bv1mEIVYnKwCqR+z3iT6HLl+tk6jmFZTmD95czcNkSv+R3GowctkwzuoGdlY897n
         uHj52FbJeGM3q+kQZJubxBB7di7Qtnej6nU3enz6bogBT1JReyQnKTdbkxhe5mmQcNTD
         M9mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WekAR0zwUUh62Wg85KhhRK5U6IJwcZf6PT4loGgsd8o=;
        fh=Mo4jABy+Qqpu3ugugQfCi9Eaac8e5YZFLy7xCFbdG2c=;
        b=cprp2RbEVEf093J0OwAYqOa68MHAkoP3PTpMXqGHQdoeAIAnaIKWU8KakELKpyMC67
         EsZuxRf1EMeQrxXztRM3w9NGGb3E7b8ozDmYRolQSs04YAcrQ6nE5YCAEUDtiBSpkY3X
         8bH9tSkHWQ2eNK9VNr2SNzFvDjFqu74Qh1yHDifi4X4KgZ83YgmgpNAhY9u4+drBUVIN
         wSv09XW5+qb5J78YJ9ESgs0XDUVyjyWhsgjByNlhfqFTcvsfejWrsggYvuR1qju0VY4Y
         VTadZtmCyHZZfHx7WwMfKdvo7JwaB24F4VWtdmKAbxYqURlZeT0SvVEoaKDQpa+J03Xc
         MgKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787252543; x=1787857343; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WekAR0zwUUh62Wg85KhhRK5U6IJwcZf6PT4loGgsd8o=;
        b=Q5L4+oaB1p2JHcFtboIG4Czp98ZJEs5LyfVhBaCR+seENE4INW9mWggsHOHS32ZgXe
         rVVsijSxk1jIqM/9vjr//8zR9jIlGq7/ZmUKcgJ2z3reuWwJLaGdOJbxJUKARAuAe3bC
         6V1DV4sq3ERVP77sRyNqM5VW4M4R8N0wGG0rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787252543; x=1787857343;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WekAR0zwUUh62Wg85KhhRK5U6IJwcZf6PT4loGgsd8o=;
        b=eoL5pGbV1qxCakuEacSOPwEJgWPdazwa4xieOIV1DyBjswt6i327oDxRovvfnwZSqf
         KknKJF1DWg37Q+HKbdOojABKtdqFsK7hSw3Jjd1O73IPircPHBcY/EGqs3h9y/v5s4LQ
         btXY+GwgHczWqh3w4AiLt5sPiD6c2qvG694dzUWHlplbwwoy2i+1bmOFBfV8aw1MCJvm
         kSosUMJw03wHE4GGT78u3DphwdLdyquSfMKva9ktMCq125q+a5RzY3CcA9YroyUjWrvO
         kHeEt5YNUMHW5AFOpLMitpUOrxNloAyck4S5vMOlsmHu/bBb5C72hM9DnidcLwNvJROR
         2v4Q==
X-Gm-Message-State: AOJu0Yw4Es9hA11jk3DrzwV00BKF20dYXH0DAAGEGlRbTlJooLeUQDrA
	q43Oxg8vdqtJ9SZ+Ea6iqSp3OWAiTny092h/XEILzCvuDG1TfINyMdxeaBTN82t/5N3/dnjfAS/
	I/72DlWwhaYsTzFkXS3n5qsLVfmbeDG5OUY6jHv1u59yW61qOpkfqsA==
X-Gm-Gg: AR+sD132xaQy2LpyzsbtUKE6aeMpVEBG3233+n0lT55kTfQLw85BU1zq9tYNk83Y4bz
	2PIPEn24U4f9WzT4AYv4b/F8jqZnePmyZEl5piDbfNwWG2IOW/AETfJEIJ+g/NTQd+/9M1Frz/8
	CtrMY+gaovafzzvcmrNuVCYkcV/u2sjvKuaMqsKNDFF8z5IEHTIe/fFYW5Rhq8np13P+ja1eyZU
	6PU7SIMFwodSBmeZXOzttqOeixif4kEPcJ89GDCoeIp0BrcJUe8YSLB84Ua+OE5ScR4WxBBm3F1
	jCteKYIg9N5MLSbIxs0Qa6OiSzHwJvTXUhucFQ9gvA==
X-Received: by 2002:a05:6a00:2d04:b0:84b:9a69:156d with SMTP id
 d2e1a72fcca58-851f9a2c87amr209008b3a.0.1787252543473; Thu, 20 Aug 2026
 12:02:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819204210.23722-1-fw@strlen.de> <CAM0EoMmT7xFtxrVwCm1ohpfVAPBuVBFHB8q_eTQ5taSquKo9og@mail.gmail.com>
 <aoboL020DIcOn2lx@strlen.de> <CAM0EoMnvz6A_v65s=jcdw5nxL6N2+yd7ZBvp78mtt7edkPe-sw@mail.gmail.com>
 <aobuk1osK-Lq-aMk@strlen.de> <CAM0EoMm8G9FaZZfctYKsm4Rkd3RVmVxkWMp6zJ1Gbxge5hdp0A@mail.gmail.com>
 <aob8wQn2EuI2N-BO@strlen.de> <CAM0EoMnLj_5HQrxSWPhJcks1bedi_OMEr6-_=q2+c_cWDn=8Cg@mail.gmail.com>
 <aoc7RqoGX09plRrt@strlen.de>
In-Reply-To: <aoc7RqoGX09plRrt@strlen.de>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 20 Aug 2026 15:02:12 -0400
X-Gm-Features: AcwNN1Wph1VAfr1RBGrO84VnqnqWppDqXE-ecbCVvBbryIerrCk9975HK5DiPxU
Message-ID: <CAM0EoM=zwZ53OcuVM9M2egx3Rue5fxjCRW9qGM4HfCoLn+DKcQ@mail.gmail.com>
Subject: Re: [PATCH net 0/4] net/sched: reset conntrack after packet munging
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, victor@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 1:37=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> > > Yes, e.g. what if pedit inflated th->doff?
> > > nf_conntrack_in() checked that this was fine, but now the pipeline
> > > can re-neg on that.
> >
> > True.
> > So my question to you then is: what about BPF, OVS, future thingy? Are
> > you going to fix each individually?
>
> I see no alternative?  I mean, what are you suggesting?
>
> We can apply the patch from Kyle, that will stop the reproducer.
> But I can tell you that we'll need hundreds of followup patches
> all over.
>
> I mean, we always relied on IP stack having checked that iph->ihl is
> fine, the ipv6 header is complete, etc.
>
> And that isn't exclusive to netfilter.
>

Agreed.
My suggestion is: if you fix pedit then fix all other sources.
Kyle should be able to provide repros for the others (ebpf etc).

cheers,
jamal

> My best suggestion is to remove skb->_nfct and reparse everywhere,
> but I will NOT make such a patch, IMO conntrack and netfilter might
> as well be axed then.  Hey, would solve a few bugs.
