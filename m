Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB42F4CCDCB
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 19:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154841; cv=pass; b=hddVR9jmXeTSnEt5QIvzxtvze83qIRCbHhLus0PzitLvTsAmXj5QgR4KJHw3cLbf1IZ39YZXipIfl9dy1Eo458rRZJCe/uQ2e148wZ0ojiQJOKdJ0UV4IH9x+X73Kdh6l1YQ5IUqlJkA90aHEdD18UZHiL6TUaBJTfqgD3/63bQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154841; c=relaxed/simple;
	bh=w6/9piynRRKXPssCmFy5vTu4brh1mtSocO/C/Q3IPQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=raCpEKyWSNBwtXloX53M7RTIbkGxWIFlh6WuRKJnUoXm9GjkQQ8tD8QvDxpy5gPsIYOGKh7V65ZDil1AZY+/IZvdVYPtkhh+buHeynX9gdTc3aMRCsqmUNxgsjK7MK3f6mjUMln7bRmwIdUiQE18dQEVVflGiRRf1eoyT8PGhjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMKI/3a+; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMKI/3a+"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2dd05e8b98cso12788525ad.3
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 12:27:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789154839; cv=none;
        d=google.com; s=arc-20260327;
        b=sEyIEHMrTvrB5DYIBfI1qZzlUV8Lfmvqy305u42RjrwZ2tzar8pythsJ2kdiOlOhJb
         a8p1sKg+grAKE7GVmDwj7ThBsyG+/MzIh6dGbpZM9NN6VoHvNL03rE6YGi7x/Ed57ulu
         HUEH3Gbv80IsiBjJ4OnxrB//tQX18f/A4GdpGpFCKnhJCkJDxodFeSLfq2fHhQtKqK/J
         BpbSwUfeVIe0/r+1IDmi2I/giUG30bhJAffZUYVUVJOyd882A9wIbvnsnk6myZJR4u1F
         YrJOaGfxw19yD1VW2OE23xMnYonANuQjO0K02KuIuQwaS6+Slg9cjZAU0RgFmgO/1JMO
         98bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w6/9piynRRKXPssCmFy5vTu4brh1mtSocO/C/Q3IPQc=;
        fh=ynN7ywSGL1O6fhr1e8Fzs2+B2Im6VpUo3bzZNkePU8Y=;
        b=Px+7xMYDL83mr0v8oElQTn788EBjB7J2IAd+CgAglhk9gYwwuSVM9Fb9zVn30Q+I72
         yhN8+iwJ8/c3EVuYfSjcAnBicI9eRGjH44IzRgCZKIn/OaR4uPeZRK1kdjP+oQ9oP7bY
         5sMkCXdPBOL3N7b2kazZHWtaLdzFoI2W0EIhciy+x2YWR0VoXysa81jUpYOAnA1Y/Lga
         +XcQa3B+HnqaJ9nZe9ve6qaDPf023PeTvZuom7BD1l+5lqEFfZmI8kGPAtxcRGmzbGWu
         Dyj+8h7fEDrpJ+7MTR+RLVNjnIImXHsFop0WQ0lrpkKVrcyXeMvbwD63kU+Um6j2QKCh
         tB1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789154839; x=1789759639; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w6/9piynRRKXPssCmFy5vTu4brh1mtSocO/C/Q3IPQc=;
        b=JMKI/3a+3wv3uiuCWz41fwmldb5i20HYq9c7xiJMPkNgNuzA0Gv3bDmbSbRzTHwW77
         U5qjTO5xxxuJtMC3Kzd+vdy7yTPyvVCJBFo518i4NIOTwI17Nl/4M74P1cyfFaescYwg
         Qbb2iBpSZ6RoAKD+nNPS0LCf8t1QJxFI7yi3Ilq0Wh+nBmFPT0UHEDksx6eqYLnMkY0X
         iWcrTrIBIg6Lam42Gfh0CwBnMrYntWB/78rQxlDudtkK6Hhnx45hy/Rqvye6mMXAvfUm
         AJ1lfdN2DEtrkfNHDLfcFlqp/an7LNa3kJDbrRKdlerNil1jcMb2iG5YZFOCymPbsgkQ
         3nsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789154839; x=1789759639;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w6/9piynRRKXPssCmFy5vTu4brh1mtSocO/C/Q3IPQc=;
        b=mDYJzPqLuoYAzYmtQCLFVcng+tFQWzoRsXO49RZWRMtHD6CupuyipzusP+3kh1uo3T
         NdJ7/EEfsZDlB6ngOvGnGxbLawfEne9AiOjy2ApPsKFtA3ARqTyX6jOChv5qBb7NhhOb
         XjR/0QX2I3YiO+OQFwbiOhPk/wBgwZBpSQq284NCepCN37pfuzSB1dqkV+rNvnHWnOyj
         6E0umIoRY/dd+Srqr0fJyiPfg3tLilLcUkbFIixkGBITtEHk3w5tpiUX/OD/5tCzm4HA
         jR3lptu81Ob1KUznmivRYg0r732ZZYpTMJQw4NWge50yjl4XPTC5IGtLABtGTjwSJ9Hy
         tsgw==
X-Forwarded-Encrypted: i=1; AKwUvBztMpaWjJbNjj5tKhCNj5mLIUhhd774wn3szIn5jhJeeM5pIYFMQjfiYjAAnjp8nZQBXaljs/k=@vger.kernel.org
X-Gm-Message-State: AFuF++mS4JE7ngU0RAdXQr/O9zaeUrx8AQQ3ahd/pf0KFcPVmVhE+nOt
	Dx8UzPHY7sc7vgVUnXt+xw04mc20T22Wu3O7Bd0KT29biIX+EZPYB7NCHOeDbQmC/ZLieHCtDZr
	TO6WFPTu4DQgLs+m9JUlgk6yJMX+mYFI=
X-Gm-Gg: AYBFou02DjXvPA5ZT0g1ibOVFGnUjofszEsV9BuEfV0GB/PQTzoNHg1TZPdSm/z5CZ6
	jkuzddnfOus225xXdWCL+R5EVOla83B9HewU51C9TZ4a3h/3sWHkVvuly0foNo4KERESLvXWJB4
	kYwPO1CUvA29QAndVfXsELQAugaVcVG1r1s5ef1oJQtFY2CcHCck3NL3MEIa/Sjq3Cno1au04mg
	+h/hNDQBX+vQToqwU0kfowmAc02hai/aa7Ny0RrWy1gudnLkVvyrIIFeZcUnzLbsX/IpQkhcRuv
	Rm2a8uReDc09ohFJT9RlpVI9/ZCwen5k7jg/uSxqnkaDF8U8d+/E7zG+48J6N6sb1MTdzHTpimD
	Cpb1xvHvxCoOtQ4O/nBGubIT7qvcvYaL+dxqSCoLp4OOOuPNZ
X-Received: by 2002:a17:90b:1847:b0:395:4de0:b78f with SMTP id
 98e67ed59e1d1-39d9bbe0f12mr10387705a91.1.1789154838863; Fri, 11 Sep 2026
 12:27:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910183222.307208-1-toke@redhat.com> <20260910183222.307208-3-toke@redhat.com>
 <0e8f9a9c-6295-49ad-b29b-84613dfbfd65@linux.dev> <871pb0dshe.fsf@toke.dk>
In-Reply-To: <871pb0dshe.fsf@toke.dk>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 11 Sep 2026 12:27:06 -0700
X-Gm-Features: AcwNN1UNE_XMfGnmmE1hCum3jv72pXAvdmmsUQvigC_2xKHdjhV4FMljr04cN54
Message-ID: <CAEf4BzbToKWpKwkYNovhOrB-ZvXXyMr71BBaTQN9DsM7KrFzPQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Adopt bpf_program__add_flags()
 helper
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 2:53=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Jiayuan Chen <jiayuan.chen@linux.dev> writes:
>
> > On 9/11/26 2:32 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >> Adopt the newly added bpf_program__add_flags() helper everywhere the
> >> selftests non-destructively modifies program flags (which turns out to
> >> be every use of bpf_program__set_flags() in the tests).
> >>
> >> Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> >> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> >
> >
> > Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> >
> >
> > =E2=80=8CAI pays excessive attention to wording.
> >
> > maybe just delete whole parenthetical notes=E2=80=8C "(which turns out =
...)"
>
> Well, the two instances the bot is complaining about turns out to have
> been added after I wrote that commit message; I didn't re-run the 'git
> grep' after rebasing for v2, so I didn't notice this.
>
> I'm not sure if those two are candidates for conversion as well, TBH. I
> can respin with your suggested change to the commit message, or just
> convert those two as well. Or just leave it as-is, I suppose. What do
> the maintainers think? :)
>

let's replace, you'll need another revision anyways, thanks!

> -Toke
>
