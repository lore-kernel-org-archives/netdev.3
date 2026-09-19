Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D6145D927
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 10:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789812611; cv=pass; b=JZRB/LDWW/pKHdv+Xx+agpK087msL2XDhGFu7nadiI47opXcxN5HlCDCKTvN97USnSUbRxwmWyQ/WkdK2XCykF3DLEcIwCQcsRF7hDccQ9CaYTDeTiB3Tyd9jzSpLS8JZplMAtkRgpmX54NFqPxwbxuxG6JGreFhxct3PTCKvLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789812611; c=relaxed/simple;
	bh=qEicP/EnbFKWWC+ZMFHq8A8CUaY/UPf7WAOaWR3gYSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mb/kgkjrrpVseaCFvC7wdQohx3M7jpj7NCsAdTceIuWCXPBbZd1G5rZ8ADUODbli+Xxry8fLFoVUEXpJKHbZtZJqp/qvrguRz5lwiwyQ8jpCxy6UHWSm7aKSybncmYFsaBVnV1Q0beEG3IAqYrAv5qwzY3usSREQf1UoSscPv6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=sPG3wXCF; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="sPG3wXCF"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-86b90133ae8so1137585b3a.1
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 03:10:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789812608; cv=none;
        d=google.com; s=arc-20260327;
        b=aJ4sdyeK2Au8XFx3WJRBdhAj4Dng5crOfPq79j5yHfK/1TAMrSlCawnDy2f/kDcpEJ
         WoeiMhLS8Talnu8m8bL6dyH4NAc74KezLS45kgy9Qj81B68LMJMqaWZMua6AZke13pqh
         Fn3oXMFgftnIqLKvAi6Y14vNAUOlFFabZKts28/gY0yEpvCIZM++Kqhcz0DJmiYiMcLX
         WJ5VevdVCuQc4w6gwxUORCd0bzhlnT3ZqeFzHLWcLdoIQZ+MPXh6e73HNQy1dwjEquK6
         5UlUPrOKlYjq5tpBBnqCwTB2w5+QX27w6ZFm0mDkj3ERPF1/+tP7CPUGHFxiF7uCUmv7
         FxGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RYML6Quodf3/gZskF5KoxX7uYmVV34bFJSRCvUETSK8=;
        fh=C0ocf9f1CzFnWNe9i+R4SK08bQ0AQJAlmvR6HjAmm8Q=;
        b=EjCIw0ouzNDZg3kHpXPl822Uc38XL0BC95Zi7ZXIGzvvOF1wJv6RV37iaEEThaR27E
         bxF3poEt3uo+q1sMjyilmkgOZ54ie82I4pyrQ2y1RLSZB297A+THFMbLqo7uocgX9zn+
         AE2iFfmOk/4yWQu1zh5VQbJAIBKDbcJ/L6SEmL7W82NhtNGHm3V7Gz2DIMsK0nfkvMlz
         JHMBZfzWEjg9W1UZ/l9TuMsJg0bEz7siPq29RCqyOsrUyPaLsePWuXB3gvpqVy7Ppyp6
         9PdYtWN9teAo636o6k86lK8em6ZiiJy+ZH4JQosRP/C/hDskTXv1oYLW8ppSaz6YOfcx
         DfYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789812608; x=1790417408; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RYML6Quodf3/gZskF5KoxX7uYmVV34bFJSRCvUETSK8=;
        b=sPG3wXCF/v9scsAvB66dbOuFkbhd0V/Q7BsmBwuEwlUEQUVwS4Q6ggTf6tdIw4J0Yt
         ySEaNXznCnUO/xYvQB3WFVY6g2QhmcbB9GfFW/ehJhEUD9jsuj4v60DE7puvKJryBE0W
         Beysy2TxHm/nFKs+MJThRSoEmB6w+6OyJTZ+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789812608; x=1790417408;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RYML6Quodf3/gZskF5KoxX7uYmVV34bFJSRCvUETSK8=;
        b=cj2APfogNklIV6tG2SZ4o3rF0hdHtij5oH8fjbPkWK9d3Xr9ZEKoTnXQdkIJjtwdAP
         +MDNeVVY8QVvJlGR1XOY+UIIVXHhxaEEfAV02G4ASUAo10vnydCBnYV7caOYtoxFjHL9
         E9OLnv0cGSx6T3wfvkGwktJunhMifgiU1QQboxsJ+6fhYuzrIVBKh+PW5Mcy4mr3qYQM
         uIktKxjb5oML/BNrkxcg5v62e0NBJFpUYr0pmnP856zWtFsAEBXqnPUgRBdlLFC5Knqj
         HI+wqCr5ncuZQhcUOHM7YhUdK3rHvu26VVLCjLybC8wTnPidu3EPs8Pz10z78eGI1UyQ
         UMIg==
X-Gm-Message-State: AFuF++nTmEsrrUbV7fki8hHF9IWaxuL2/pPRQiO3c4cOoSSeY6QCLmVO
	kTrtLHUNJaBNuu/1lSeZIzVGDB30QqjsvdzjfN1WjjhaSywyd4pdXpszDOE6KTdZ9coe/vEYeuG
	JZkeDVJe7Z7B+ASp503Nafz/tM53J/IK9pW6YdP4Y
X-Gm-Gg: AYBFou2SOK/BCbwvUdlPiEXm41g+D6Ue2ESFtcmVMooelcCWMfmy2D3Q18rp0I2F8ZE
	psfSjs/HGkvJ1oi0o2TBirIUZJU4cQFDTULxtwS/2vrhsViyPwX5hDDL6cZy9XqZ1uHbfev+7xm
	Dos3u4iz7gU3sDEKiquy/uCR0Qjv6HSyCKdMKBW9x+fXmZyH0DhZ1i0jnnwjbp9FnJiHEKko2/A
	4gZWq72ztdPYvZpzl3aKt/vgKiAQLKnFPtq1K8V7mWJSRLSnde8QjxatE28TWQ81XQxAxmBlYU9
	3XPpTlUBZGrjGDoMwQV7NSLWyTlH04cecaq81CaabM0N8GzOoaT610BTOK0316ILQ2L/AlgFgJP
	FJpjlAiEmogufI1/MOHTtJRwV/S9S5GQAlk6YWQ==
X-Received: by 2002:a05:6a00:4b01:b0:86e:ff2c:49dc with SMTP id
 d2e1a72fcca58-874dd9f6878mr7820183b3a.24.1789812607807; Sat, 19 Sep 2026
 03:10:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918133953.12494-1-bernard.ladenthin@gmail.com>
In-Reply-To: <20260918133953.12494-1-bernard.ladenthin@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 19 Sep 2026 06:09:56 -0400
X-Gm-Features: AcwNN1VS-xsnAR5LyJvNlgJZwaJgnYO98rSW_4EN9wWu2tP9xWHjz-tTeYnaBag
Message-ID: <CAM0EoMkgkfBJjVs-uEayfLvgnmop1rLgFFxkjGL4m=iexHRBxQ@mail.gmail.com>
Subject: Re: [PATCH] net/sched: fix potential stack infoleak in em_text_dump()
To: Bernard Ladenthin <bernard.ladenthin@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, alexander.potapenko@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 9:40=E2=80=AFAM Bernard Ladenthin
<bernard.ladenthin@gmail.com> wrote:
>
> em_text_dump() allocates struct tcf_em_text on the stack without zeroing
> it.  strscpy() writes the algorithm name and a NUL terminator into
> conf.algo[], leaving the remaining bytes uninitialised.  nla_put_nohdr()
> then copies the full struct to the netlink response.
>
> KMSAN on Linux 7.2-rc6 reports two kernel-infoleak splats from this path,
> one triggered via "tc filter show" and one via a raw RTM_GETTFILTER dump:
>
>   BUG: KMSAN: kernel-infoleak in _copy_to_iter+0x1c9/0x2620
>     nla_put_nohdr+0x83/0x130
>     em_text_dump+0x291/0x550
>   Local variable conf created at: em_text_dump+0x5d/0x550
>   Bytes 168-179 of 199 are uninitialized
>
> I am not certain whether this constitutes a real security problem in
> practice: the test was conducted in a controlled KMSAN environment and
> the leaked stack bytes may or may not carry sensitive data on actual
> production kernels.  I am reporting it because KMSAN flagged it as a
> kernel-infoleak and the fix is straightforward.  I can provide a
> userspace reproducer on request.
>
> The original code used strncpy() which zero-pads to the destination size.
> Commit b04202d6065c ("net/sched: replace strncpy with strscpy") replaced
> it with strscpy(), which does not pad, creating this condition.
> Zero-initialising the struct closes it.
>

Two things:
1) Don't Cc security@ in the future on trivial things like this.
2) You MUST provide a reproducer - even for something as trivial as
this. Since you posted the splat, you must have a reproducer.
Share it. This one looks hard to re-create with tdc, so please provide the =
poc.
We only pay attention (prioritize) patches that post repros which our
automated system can use to reproduce.


cheers,
jamal
> Fixes: b04202d6065c ("net/sched: replace strncpy with strscpy")
> Link: https://lore.kernel.org/netdev/20250327143733.187438-1-richard12031=
0@gmail.com/
> Assisted-by: Claude:claude-sonnet-4-6 [KMSAN]
> Signed-off-by: Bernard Ladenthin <bernard.ladenthin@gmail.com>
> ---
>  net/sched/em_text.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sched/em_text.c b/net/sched/em_text.c
> index 343f1aebeec2..4132f8c3c5fc 100644
> --- a/net/sched/em_text.c
> +++ b/net/sched/em_text.c
> @@ -113,7 +113,7 @@ static void em_text_destroy(struct tcf_ematch *m)
>  static int em_text_dump(struct sk_buff *skb, struct tcf_ematch *m)
>  {
>         struct text_match *tm =3D EM_TEXT_PRIV(m);
> -       struct tcf_em_text conf;
> +       struct tcf_em_text conf =3D {};
>
>         strscpy(conf.algo, tm->config->ops->name);
>         conf.from_offset =3D tm->from_offset;
> --
> 2.49.0.windows.1
>
