Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8A7480DF0
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 19:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789415862; cv=pass; b=MfsZVuSvLvQmjH3y0gmO4sjxhlA3RDjmuTTZchniMNvmkuexA4LQj2piZ0SGmhdHeKxoPaMUvAs0Cq93p0eX9b3XuVgv1m6kLszFZFY4mUxTpwIK7eQ51xmpbEffa5M4hD/+/zMEkJvQKMxa6kh0+DfUJERiOCRJjV8sd2PzFNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789415862; c=relaxed/simple;
	bh=mNtjIShgEOpg3NU1cq+Q2V5BZXd/ImLm75jOEBGsIVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dr/APQkQ32TKClO30svrMd9hLfzGRJkXvLfHMKUJWxDQ3Xg9TViyEuy9b6Jo3ufTYkhm++Eq7qd093tfpsxkrYij4/tMVnjlmy582vnZX1E+WWWW5r4DXUsCiat7BHVrYvkQdk4bYVr/2ZBpWLK5OLVk0Bnakz5Iz/adJ3umdEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lkFqT3Ei; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lkFqT3Ei"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb766bfd3so27692531cf.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 12:57:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789415859; cv=none;
        d=google.com; s=arc-20260327;
        b=d0wIqe+ivH1hU+EQn1LiYzwoztx7YCJfurmY4qFDSAdI9u4+6Oqdnacf2LxQmMWNBh
         bs3nheRCwSRNN0vC30zEC/qwgtoyKlCxl4s/VE+D2XZ1m8Ru02UGTvvlGB9pVSdnXCr4
         79YIxpTQBa90L6vF14ihU8usNNjD2G4G0zoAFjxNzPrZmArp6Pv0/6x+iGkrij4Sid21
         +XWi0hhKflLBlGW2gz618vQhQ2lZZM5DoGBzISe+23UJu7XMjso79xlo1PbhoH3q8JdD
         5ETIyJpkOwwigc5WNUYzb0v9KwsSJJp6pMmrWp855V/J9z8BA+T45ObNU1pXEuLoQolV
         blBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NhbS15FnZAU+1gYy2dw9ahFXA7LjkCuXe7erg5i5hK0=;
        fh=ZSm5dwUUDfb2wyHmyV7XxLPutYM+Gb7C1NUCZkRrfhs=;
        b=drFaBjVw6gJHVDzOq8KM1qc3OYBDZNkjZkKL1C9S1b6lipukSe37hHeBkXqtSX2SO5
         O0VA8T43LR45rYF8fKDBgLqDi6078z91+iSk7ctv5fQCNj39x3M1sMzcLS6UXRrfrpAw
         UN7lJnIZZBlLdZhIYg0J7zuryD3L8A65f1tZ7oehkWvKvCMmmKw8eDukuZt2XkOO5xwp
         HkZTTz0InFsiYU47BgMja+tJl4ZjVjd3OlKKXaqPubBG2aEGGvMJOhS9waUzB8N4XZMP
         gXHuJBu7Rlhf8+yRLs6TtoJ1ra+2P3kOImGBIq/wyXQhVpX5YE5vbCr3oHlDc3u7MJL8
         66hA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789415859; x=1790020659; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NhbS15FnZAU+1gYy2dw9ahFXA7LjkCuXe7erg5i5hK0=;
        b=lkFqT3Ei3QqrhhPMG1VguvdpUPbDAkbX5SHd0hpu1X5cavODPrasq6Kcw7SiQstNSn
         Xbo9KTRXGTSQ6duy7hQUC/4hHjgJj2wi+L2D/34yzoOi0dvymapiIpuL66M14kNaac1T
         tbIg1M0lt9NxgbaW3OgzkbCqGajEg/7IGJvGrPjEUOTJvdCOxMpe0W1EAzNNZrfdEZCf
         1DWWOTRXYrmP231u/PePqTwh28qJzxhF9xLybdSgxOdn10x2GDm22PT+8fdAc+7BlkW1
         ahCTu0Erw559GD8oM7Mxe1JlZyezr8M4jW4dvKMjHCh4B2FGxDcXw244NPe3y/s2XxnT
         bPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789415859; x=1790020659;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NhbS15FnZAU+1gYy2dw9ahFXA7LjkCuXe7erg5i5hK0=;
        b=dgURUhhGuuq1a7Oc09/M/KRPfruzkcWNomyg7VL/9MfDQ9RFFXL5/R94gqk2xd0K7Z
         HqkilbUeeHd4Ji6onrWYAP+is7ObIx6Wc2NfdxF9LbjhE0kErkfA2G5SPH2jBqk/0Lux
         T8IuZsmkMdljYkZISM80KkWmL8wFlOqTBM8WzllNUDfgN2BOV7T+C2KsGyEEFhTSdgU+
         QvINjX0w5kPlQZYF4jl8Qn19D5zj7z58GvzPVXE+/dBFua5LfNrawsF2YKWwfFYtJ7O0
         gvIybg47+GUdAO9FB1x3jUc/zDOpWlL/DgUVjQiV7rZsOVvVk+Lfzvk+Uh+Kgu52pjpy
         pW9w==
X-Forwarded-Encrypted: i=1; AKwUvBw5hWNyeJ4nVVB33i/GLTEOFEUadql6lFmrZkKfEs6MlDC2wPe/tj32xOAWfmAZZNma+DIPpJU=@vger.kernel.org
X-Gm-Message-State: AFuF++lC/FlTKqt9slJzxfKjmg+Lqe2nlIFPf/yAiXEGCXWPvECFm9Hx
	c5a+6Jwi/6nIGOExIYoZk7b94OlOz8NCI46o1Tl1T86j0D53FjQ3UQm6ZAiCr9wI1mVIiK83G9Q
	Noxs9JZ31Kb7io3X4S+SxACLkhYBpvbQnuieTBBtO
X-Gm-Gg: AYBFou1bDVRQn/50M7UhCx5nG4f2KSvIcadXa5rjS0017E59gHTlgMmtVed2dFQFY+k
	VfD+xcijmz3KCR5XVgxc97IwNBtDr3NHnxpzS9jLV1pwf6tscNQLNieF2fbeUHuHvog559CJNfl
	ZbVBHsKrb3EYN/QeP50li6L7JuCLyRrvxkm1XIjLm6+1RVqFeEPh+I1MY1aSRVCkS1pd+h/xrWf
	rJ2eaMwvqAoO9VCvJxnnlxZxQCZqHMGqe7objlRG1jMwmsolsx4Kl4XqUWfQ91aRxl2ASA7kU8y
	p+WRD2R/W2VmVjksM/JuPoDR+xBH0OuUbBlJIHUXG1PR2Tb5k18LbwELs9ZPyRBZFp2971kCPtx
	ZRRhg2sLlgm55Ym2ju2+6/j6FA5rnoqsHaDAtVg1nujmUBInef0G8m/A1oWnpYNjmroRd77dllW
	+eYcOA/WaiTNfGJK4AxzAMjg==
X-Received: by 2002:a05:622a:1342:b0:530:f764:7fa with SMTP id
 d75a77b69052e-5310d01250fmr64121441cf.39.1789415858860; Mon, 14 Sep 2026
 12:57:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911073758.2714564-1-xiaolinkui@126.com> <CAAVpQUAUAgAVutpQgMu4LjG1KOpm9Du0Kw1kbp2vHtHqQ5USZw@mail.gmail.com>
In-Reply-To: <CAAVpQUAUAgAVutpQgMu4LjG1KOpm9Du0Kw1kbp2vHtHqQ5USZw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 14 Sep 2026 12:57:27 -0700
X-Gm-Features: AcwNN1UgcMj7SzhoUPKgP3AUBpymk10tNK0tr092p4i0zgSbO2ofzNCz0cSJbMk
Message-ID: <CANn89iJTMxWERqz1tdxuQ2jW6Rr7xN_ceh_yejtrBTPwN_YEeg@mail.gmail.com>
Subject: Re: [PATCH] ipv4: fib: annotate data-race around nh->nh_saddr
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Linkui Xiao <xiaolinkui@126.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, idosch@nvidia.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linkui Xiao <xiaolinkui@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 12:51=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> On Fri, Sep 11, 2026 at 12:38=E2=80=AFAM Linkui Xiao <xiaolinkui@126.com>=
 wrote:
> >
> > From: Linkui Xiao <xiaolinkui@kylinos.cn>
> >
> > fib_select_multipath() compares nexthop_nh->nh_saddr against the flow
> > source address with no lock held, while fib_info_update_nhc_saddr()
> > stores a new value from another CPU as soon as the preferred source
> > address of the egress device changes.
> >
> > Commit 195374d89368 ("ipv4: fib: annotate races around nh->nh_saddr_gen=
id
> > and nh->nh_saddr") added WRITE_ONCE() on the store side and READ_ONCE()
> > in fib_result_prefsrc() after syzbot reported
> >
> >         BUG: KCSAN: data-race in fib_select_path / fib_select_path
> >
> > but it only covered that reader. fib_select_multipath(), reached from
> > fib_select_path(), is a second lockless reader of nh->nh_saddr and was
> > left bare.
>
> 32607a332cfe added the reader after 195374d89368.
>

Indeed, please put in V2:

Fixes: 32607a332cfe ("ipv4: prefer multipath nexthop that matches
source address")

pw-bot: cr
