Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A7C3033DE
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 20:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780689711; cv=pass; b=BxosrlarVPWTKrvpeFySTHt7wmt7W7ttEBEHP8npZmETBoYkHbkt/VRq/2CXbm/P24EfD0P8Ne59I93nseuBYr/it5wA2DtPoExi6L+TccEKeS+hkEGLMFxGjHibmlnIYKK4CUUQKvqMPjJeFd9byhXbBI/eANegAV8OBalKEXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780689711; c=relaxed/simple;
	bh=iuSpu1BzpbcOiHszbQN0eTT8b4TKgwFKK2p4hSM1+9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nvDER6gUHY0JZNHzD3Auk1Lqca4fPGNOvVoVd45Ss6uEHXckCZBLYfV0998KnBOnKNXzns723UfHn4CJetK+I5idVIUOf/xACEd88lpgvh62WZdqy28xWD5RLDxFT9hv3p/F868R5+aTxGCe+egvkMzLslyJufQoJIKpM632ok0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdMz56k8; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdMz56k8"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7e16f05fd79so25794487b3.1
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 13:01:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780689709; cv=none;
        d=google.com; s=arc-20240605;
        b=Xqo5YHikFlAF6gzj9WiFMlIw9A7UeM/9DDtJQC6wMqmmUwvIQts1Y08O46wJ/tNLvW
         B91rR2XWSS5Ev3TxU5Bc2H3yd1WhB2C1hvOvG0dtqEO3pu3tymWeLfRaVFwqdQ7Ns0Y1
         1NwoQdNRfA9il/Rl7ZMSLJsBlsjXNoR2CrPY/v1WifECmKXpUAlYK+eJegvOTnpp3S6A
         vk+cjTQakW7cxyOYJoUFMVvTPpGMQ5+7B5+9vAnvMiBivoG/F1GrgYv9AJUWNwNs1tGG
         t1oMynoMSK6XkufcRuQj+SmRADVHrAyS2WW/FUb3ZdBA+PDFg0u4NgLaI+0uKH6UkyS5
         bMeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YEHXC2mVOZGOk1Rk4zHY/GF28qsrwAqEm1e5Niz9baw=;
        fh=/EBgByzXI67uLkS0FrbIbSkdENlfbjG4786AUG7iwiQ=;
        b=DF3nw/wQ43JxVVUcTbvF8CjBW94wDJHI84eMYuvWCuFUVu0X0wlWbAwmNG42JYGcco
         Cf/K8J02tQpR3+gZu79deh5qXHfbyOg7MkRJiBiOJinRQaoUjw7ex6fpF8halTVqqxIq
         7VlJgZ3pKIUeqp/kRGwiCpFzRIiCM/BmfAJv9G5EvsC58Ccm6FdD0j6YiZFgpVIYgNRX
         ncI6LXTU5kW/gFkXYcpx/Gid6f7lz534HveW0cBjD6QJr6BnWTw4/7o7eA6XX2zbxoY7
         w7vXr9o+rwjzugKY9lVDYVgLcaCHAqyj/8W/eN5/Vo9nKRhPss/TZTG+GM+UOLXpfdM+
         nOCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780689709; x=1781294509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEHXC2mVOZGOk1Rk4zHY/GF28qsrwAqEm1e5Niz9baw=;
        b=EdMz56k8jBdKXFqF6c+LM+fAJU0lByOE3P94N0sRrP8gvILfwg1lncBjHNru8w5U0g
         nKGMRehQelcbmG0vP3Yh+R3v3a+JyWsjLy55WbXFF6rOQtHfdvHW0DyKJ4tYJh23vMOR
         3AqMjx1JYBjeNDwI37v9y3Zkyd1VbvTpST9g58OugnGzls4XwqGvEgE9eNiaD5XCeObb
         b6VBet/vjh9C2PhijHH1aMjZsec/xMQZEBAyAEQtpRRrgGGR+Q2QD4H2q70oWqkj7uT6
         LYQwJ9J2WwAyC9noFK4/ULK/QzFPB6Nj3odUDBYDiTTkGtUkizYGRmCZnAossxVvyyzj
         sGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780689709; x=1781294509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YEHXC2mVOZGOk1Rk4zHY/GF28qsrwAqEm1e5Niz9baw=;
        b=CySgWDi/DlKxzufxFI/60CdaBgX8ZnD7tDr4SuX4bHwYX+GKaRSPr6axxoJRMiQAr1
         +ZjaiNfVjtAaeN3lU8EGDdpKcILXxdcPaJuChNFbUm04IYvB6c1icVY5LIl+2M4FQnNE
         85W3B8tTB62Wl8U1OWN1eemdKiHAG8ir/MIlxfF7eEY9DwwVg/dIqvvB37Ab4m18l6+Q
         RD4b8xUD69UE8YmOMQ9DeETZ1zqi3FYeRLdXv/0I93XL7OvyDr6qXfckt850UmH1ubQl
         yt66BLLY5iyXXY103RllDtYkAehexUISAyojlxuwKTbclYN8QoHezMLNHRRoOXeLW4lv
         HzPw==
X-Forwarded-Encrypted: i=1; AFNElJ+1u/xx2FkdnIKuyzyiL91mY6xsVxb3DJiF7vpnH5qbJFlAOQOM3s4sgIqFT3bWk1lMo01vuIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6i0oDll7h+/GsdGJ3D001YDbf3TAL6JnBUSXyKwBA4tJPCZHu
	XVYmJev4/enWY2njQILOuKPsSd0oJ+eI6vh2/vKgwLDZ6Hg0gKSgt7ghWfSENB2mJOi0yk/TLSi
	nTjZdawtuGsAaZs4Id26mOEE4TgCUeA8=
X-Gm-Gg: Acq92OEOLMXk6Zm3+x6yPPnargPnHkkeTqlHrGMDurT2V3XQ9MuKo6/f+vdYaBCzNFl
	UoHicXqkzakd/Tjugei1MnV7S5OzdtGGaLeb+KnRMpkCwu7Y+Ugt1rMznRmT8Sl40kMinu2ZW1q
	ymevru6U+S1DfbMzT8q70AVNkaWEQ9VomPTqgdSPYKIA97/qiBt8B0DcFnAvhANnPMs1A+LvBmB
	nhGeZyh7bMfh338X0nurixkUow2Ky/VRDP37Eb8HGZXX3MUvGEzT8cvOty2R8YDfQkrZUoR5nc0
	u6OWNzlYDqWrhHOUe/4LyL1k9gLQkzLXzA==
X-Received: by 2002:a05:690c:6b04:b0:7bd:73f3:7a67 with SMTP id
 00721157ae682-7ed107cf391mr52358317b3.28.1780689708955; Fri, 05 Jun 2026
 13:01:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605183551.969144-5-ameryhung@gmail.com> <3a3a97529e6a13b4220026c0d97d3c2341a503e3f815e0c67f1cc6a8ba13cab7@mail.kernel.org>
In-Reply-To: <3a3a97529e6a13b4220026c0d97d3c2341a503e3f815e0c67f1cc6a8ba13cab7@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 5 Jun 2026 13:01:35 -0700
X-Gm-Features: AVVi8CfKlJUM2adC1GCY5k2YYjFmyeBHic4clMKFl33ELz2dAtmJl2Cjsf1RD1c
Message-ID: <CAMB2axOHwmz7OWb92va84L09Ag=fVmjqBMD6Z=YspvUr9476EQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/5] bpf: Remove WARN_ON_ONCE in check_ids()
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com, 
	ast@kernel.org, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 12:08=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > bpf: Remove WARN_ON_ONCE in check_ids()
> >
> > check_ids() warned when it ran out of idmap slots, assuming this was
> > impossible because the slots are bounded by the number of registers and
> > stack slots. That assumption no longer holds: referenced dynptrs acquir=
e
> > an intermediate reference that lives in refs[] but is not backed by any
> > register or stack slot [0], so a program can accumulate more reference
> > ids than the idmap can hold and exhaust it.
> >
> > Exhaustion is fine for verification correctness. check_ids() already
> > returns false, which makes the states compare as not equivalent and
> > prevents unsound pruning. The only effect of the WARN_ON_ONCE() is log
> > noise, or a panic under panic_on_warn. Drop the warning and keep
> > returning false.
> >
> > [0] 308c7a0ae885 ("bpf: Refactor object relationship tracking and fix d=
ynptr UAF bug")
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
>
> This removes a WARN_ON_ONCE() that can panic under panic_on_warn, and
> the commit body explains the idmap exhaustion only became reachable once
> referenced dynptrs began acquiring an intermediate reference in refs[]
> that is not backed by a register or stack slot.
>
> Should this carry a Fixes: tag pointing at the commit that introduced
> that behavior, which the body already cites as [0]?

I don't think a fix tag is needed, This is just to reduce noise. Not a bug.

>
>   Fixes: 308c7a0ae885 ("bpf: Refactor object relationship tracking and fi=
x dynptr UAF bug")
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/270340=
08594
