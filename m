Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E92344D92
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 23:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780096548; cv=pass; b=TcDOS/I4AAZq07ySxW3ex/0SCjsz4BPYJodPuEywvZU2ryITqgRgB6oSYZG3NT3nsDoqtokRwfkk1cSLI6Ntu4Fxfpa+o/0YiGTD2n6ouUxgEt6iQTFUfaZ3icB36lLc8usLkQYAo2WIoHmrhNqmUxmJfgYMkQBfqPkxkaZ0Noc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780096548; c=relaxed/simple;
	bh=bBw1XnjmMTYK6wWrvj+VnW1NORhnL3UCwxE7Z3XCV0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MpDmv4JsBG8EmUetmZ2wPJLsgaE1cfpTFHJjwiFhLoJxw6huoE51RptKz8rzBVswXzi/VZNz/quHW//cUxfU6kcURnjsFmr15evvIZHYWdrn/kKY4MuJU9THvMA7gvqTjd1YfLdroxNK/a//JUPgpBoEqy7fdw9L10l5T9V+Ioc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=N0RycM6W; arc=pass smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="N0RycM6W"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-43b6f19b7d4so5835507fac.0
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 16:15:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780096546; cv=none;
        d=google.com; s=arc-20240605;
        b=CpKb2jGmMYfpD+VXDbmWcd9eDHVUDO15ob/9n6ld4qfkUzifUqOtQkxRPFt8w6O9jY
         7q9A4NdQXKs0/0HIyMmZ3qTL0mbz00BGDGGGpoO+vJcAql2XtAcFY6W1ahKGtiSFIMoH
         3hJ6afPtJ65K80CC5w0WcG3M9aM8XppFrGGa0qm0gXCLAkkgYXjWCrmhpf3d1GernRkL
         SUxhEO/Vh5mhd2LKrSY3g9gXrK+uH+jaISrf02m7y/GwPFMW7iAi3ld8XVehHJQAhMBH
         aBydnClYEhsfzLO2jjuAZwFzIDCc3Zkdx9U4C3DDPJu1xqSOdIbogYQvFiAqgLQhSy6d
         o5DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bBw1XnjmMTYK6wWrvj+VnW1NORhnL3UCwxE7Z3XCV0I=;
        fh=MhhBLmX35DuQF2ScoB4a20mqOQAcbphDj7VQPLFHWiw=;
        b=GA7wSG6VthOVhF6MMPmw5igWWVunjdb9MvXM06Gv16n4kH+6TtGf+f8tP02hAc0Vm/
         wPQxfHdfCCp/2mvhtnXjxx4rgLMwOAHum9DrQj6DlgXVxul8XysqrRtOSSZ6RTQ+CYag
         327Bkxwn+KCUoHcfBDA3FX7qJnAHg/E3/rmIRR0Gb1c7eUutZ8MIAW30EluJchXBAAWB
         viQgnahLDq3N2ZPXfnbgdtOU9euM+A5aQL8/fIbrwROzuXQqDYHBjjTKazo2sum8DgyX
         PGLcXzZoYMWYuquTY+7tzyluTQAQi1cfGxql6KEMrtB469s4S53KBkETtQGJbsLyiS7S
         TSbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1780096546; x=1780701346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBw1XnjmMTYK6wWrvj+VnW1NORhnL3UCwxE7Z3XCV0I=;
        b=N0RycM6WYTMn8t08APmVAkz8dIbzKpj/J/fBJj4SJbtg8M/ymRID1D7XGEfGeTQrHE
         ZPCPBswx+WKFDvq3GWia94ve85My4yHgLO+2EWpk+P8M8+6J8+4uuI/yib1NkZpxykao
         gYaJztHYIjttjvsjTh7bFimiCMa1lwHt7fca8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780096546; x=1780701346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bBw1XnjmMTYK6wWrvj+VnW1NORhnL3UCwxE7Z3XCV0I=;
        b=fu1bRwk4m4Ilt7LLqYxXid7VBFtMnbG7bAzt4eZ+HlwUMazG8bf8uAtxrN3AHs1dqj
         7S5YfiOSwmzvEMjHxbZT39yX6rBxntU/Y1p5WhWZEfgPF7tp63JLp1ztf6WeO16qhGem
         8ruLSett+dNMHp9pOsgQHmN8aZ7/ARlrCfA9O9d4lI4pzUcGePbiQ1KVxIlZWVZqMhU4
         uLQE7xTKEld6hdna1kHRze1QpHjnrXjQS6f4/sqzoLqTk4AaWjuZX3otC91uws0R+7h5
         TR9CBE675BPA61VtYgqNEcRSOpOKDp/LzBKgKpT+eyEimCVKBTYXGIQGbb4woY6B1y/E
         XEKQ==
X-Forwarded-Encrypted: i=1; AFNElJ9njiIpxqn36OfxFTCG6c+D8TDZWWbE6Hkge1UdPxaXaxx30aFUNRYArwlGzAZwfTpEFbnMs1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeTuzuNA36WG62YVz1L1A4UblfirTODzST23J4z5agBuUerpCO
	dP0/BGBdCeRUAmlQzVVXYMFWWe6zb5fY+0pgHb+cslsfl+3LpwqCDbrEjZeusCATnzKKixD/Bhu
	M8rcKY8pxStKPvil0qU6wOV9/NNMY3shZZFvyBxx7qQ==
X-Gm-Gg: Acq92OFZkGeckGvwCN4zJiKN1EfItzXEBUZra4oGQGX6JjMwup3fV+/bU8FkJTeXwrn
	iwiCLyD/AGy5I3eSRrxyWBAkjaEDkNg15n5Ykp+HiHsJYaQx4BHX9CFGzkph2/wREPzBkYXH+Do
	/D35gMLVYv9WvBPo+lQt91uEzt3H3njrhOn7ph48+tp/YG5EOI/Utr7dvqDrZpLa6g2hjHSR0Ei
	ao03JPorC/dmlPqp3KM0FVCZgMU7WNRqEkgij51lJfTVMd4Q5ofEWYAwQ0OYZzm22g+7g7b1A8F
	j60ghufZrZtQeu234hyFrRra2I621opt7/IOFO1VTukRkL5EOmT7hSz+XGDXHz6y
X-Received: by 2002:a05:6870:ea08:b0:43b:50fa:1c23 with SMTP id
 586e51a60fabf-43ca408c7abmr1382308fac.13.1780096546551; Fri, 29 May 2026
 16:15:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526220847.28365-1-kylebot@openai.com> <20260528181319.79aeb1b2@kernel.org>
 <CAM0EoMmH+5q1JXH0c0GRJHLF3sN-BjpO+4X+ESjARz_rmZZ28Q@mail.gmail.com>
In-Reply-To: <CAM0EoMmH+5q1JXH0c0GRJHLF3sN-BjpO+4X+ESjARz_rmZZ28Q@mail.gmail.com>
From: Kyle Zeng <kylebot@openai.com>
Date: Fri, 29 May 2026 16:15:35 -0700
X-Gm-Features: AVHnY4L9MHWxXKSCNif9mqocmkaKMhr-N9Fqn5Fl0Rzp0dcj3azcPQU11w9P4OI
Message-ID: <CAC7i469+v1bcoxD=82=VJffV-yXiL7gPtfKPdNatRSpGQincVQ@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: act_api: use mutex in tcf_idr_check_alloc
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Vlad Buslov <vladbu@nvidia.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I ran the PoC against Jamal's patch (with inserted mdelay calls)
multiple times. And I confirm the issue does not reproduce with the
new patch.

Best,
Kyle

On Fri, May 29, 2026 at 7:13=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Thu, May 28, 2026 at 9:13=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Tue, 26 May 2026 15:08:47 -0700 Kyle Zeng wrote:
> > > Currently, the NEWTFILTER path uses RCU to guard action idr accesses =
while
> > > the DELTFILTER path uses mutex to guard action accesses. This
> > > inconsistency leads to a race condition scenario, which can lead to
> > > erroneous operations on refcount, eventually leading to use-after-fre=
e
> > > situation.
> > > In this patch, we revert the introduction of RCU back to mutex in the
> > > NEWFILTER path, which is consistent with the DELFILTER path, avoiding
> > > the race condition.
> >
> > The commit message is quite inadequate here. Looks like a
> > run-of-the-mill UAF so you should explain the flow / race that leads
> > to it properly.
> >
> > Doing some extra digging with Jamal off-list we can't find the reason
> > why normal RCU protection wouldn't work here so maybe hold off repostin=
g
> > until you hear from Jamal.
>
> Kyle, can you try the attached patch?
>
> cheers,
> jamal
