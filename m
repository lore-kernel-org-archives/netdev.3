Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD2B4503EB
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515593; cv=pass; b=oIEs7mULW7zXbqE4xpsqIildWKndWGYL+KJRlXarbcbRVTdiitcScOtXKfREhDvvbmnNZ1ZBg7m/iIwraed7/iZiJvGMNpvoeWmBcaCX0AhquoPYH0vhMpZgB7gEjIj4YqN5kF+Qc5iMep/uoWb/b2Xka7YUOK9qv/4PfMz2Xs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515593; c=relaxed/simple;
	bh=PVKlz5Hy/GkLDJyyu3N9NTA7m0qQhsDEvGuA6dt25YY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e3ek2Trkv2tiODskDrMiKz7zrP1ob7ZLMBhs0rP+mGw5Rk4FxCwSEvxvgxwu9tfd3xbIA2YHdOpPAponJ8Zc2bnF1UYvL+Qum9R3wh2moTQRryDeaKePVxZdnAy11nrNyDkLk+5b8jOCU0dsnyIXvZeUD5KsKGW18BB/MFt8SUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=fz2ziZwC; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="fz2ziZwC"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c99eaa1f020so1146806a12.2
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 09:33:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785515590; cv=none;
        d=google.com; s=arc-20260327;
        b=PXs6wHF9vMU1IQ5hf8LDnyzCDfPeole14+NRTQL3dBi4PUYneau34rvl0ZrNRHMisN
         8FONYt+6cjcHjDkLj61GXt/KLopDv4qeirLsFyWvCKQa83GiA+g16m5jwtUacuLafdvF
         4RAuX+IEVmgh501lRKzSTqOJblg4HOzcQmisSJuLPr4dUPWpZFgtCNspqwpypa6BmlFj
         AmuG2TXRwIChkjo2aUbau/Yi//ah9UWGftxoss6g34rSUEGne9Tz2jWg43fKsQCiref0
         pLmB1hmQZfwNLP9F8Ax1/y0VbckbFz4wfTYEBsB3YAFQiTFGW6GiYP9nOXi1zsHtbg6t
         WadQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h/R6XgGZ8iYD11tBPm/kghmJ6vKm7XBUnUxmAch7128=;
        fh=gSgRyn8Q68xtexn52QgV2ViTJddAKB3lH4ZZUu+wsOY=;
        b=en5no12W2k5LDI9rn+MVPoSE0ceKGgsbrX+NJJArCGtBGfDtd6VWbZNNpUb+2iXUQk
         2bEejoS1hPwe2ynFqN1K7TxzNet8PDke6EfhFreTyu5CAyLXoHexSUknZReMny4CIpMW
         od8AWnRyR8eCjZ7+y0k9ktcYxkNLPeJ5E+VyhM/iSZuXyx2LN4Zw2YHPzpdgweZYcDjb
         PRHpohGDZhDasxiQqI3j36UVf5uRTmjzOUzIbVKzOO+f9bCi8LDWDfKZuXswckU7mHpt
         bqPvKL5K9Q1J6lJnI/7ZCqZ16VFvOIvOcDsOPhAtfHxYxlI5yOqmU/fjEd8uqWeLiVLA
         Np/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1785515590; x=1786120390; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h/R6XgGZ8iYD11tBPm/kghmJ6vKm7XBUnUxmAch7128=;
        b=fz2ziZwC0wUKlCQCWnK6gEWuLTSVsmHVNb/PzfZlOY0w03PdHdkJVwzUPzv5yn3J4f
         J9GQE6tmzO0QrkwoeTTBfENH+S3VaUdnPaSAMxKe07960AoHvPy4iS/X/MYfixRFMYRG
         dvJc4coJ7WS2DdzQIrAclXNfiIj/K0bKKa7/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785515590; x=1786120390;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h/R6XgGZ8iYD11tBPm/kghmJ6vKm7XBUnUxmAch7128=;
        b=mZRaXINuAKWAlZlicMPBajND8a/DLsUXgbtSuRuVLF5EcUCINK/8woZbTY7m4l0StE
         gp/A3FrNslScb0+c0yUB3eFyjOGopnYmfmx3gkiUn22FWcr9SxYK91Th4RncDrRwsL0o
         wzYlNt/ry13njCcZ7ic4j4XojpyAmSZNowgLqzlSo7vzzTdW3Ui9CWTVoQRMnAtR7/1Z
         /INOkV63YX9H9hw7y7HK+MYE8R5gf0vmU6X74ZK4afcL1i3GCT740CCa3PsrSVLGjUi7
         0ocY28PbLOWjchZ/gU2m+Br8rc3tHp5iAG42GQN/Cc1a1sFIs39E/cikMslu+os7EOYk
         Ixdw==
X-Forwarded-Encrypted: i=1; AHgh+RoEaVS5gwSpjCC8ROuHUDF+U5AGOk7WDYIe4BhwKO88paEd6G72WcQKvGbKRBapq0YBUsuZ+2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6MnVajENY3Cn/SmJz21+Psfe4prsvjSFv8klHnLWHLhvttfbd
	CaHECR33kyu+xskXcgzjv7YmQm0qG6yqCegQifLw+tno2tT83V8CJX74WZ/73rfSyb9E+64yz08
	K/YKAvwT7/wuUPtcrqTKxbklI4K0qompQndcgPNe+
X-Gm-Gg: AR+sD13qaW2ypVlFrbLah0w9WA62SUhw6W5CzQ4W4RIqi72l1LcEeTV8F9qBULl00Ny
	+d/hofa//jYq5zFeGHfh4UYxmWsp8o23X/4h8rX+GKCJ7o39EeXT0jCCCR3uTnTLbONhaXcwdqC
	27c+zaX+vgCJZoBDB6a3AZhNDGv8yKC7HSwPPEvKf0BHIRhF78N9qQ8vxgRMyI0TbZywehCnj99
	L3fwbeKVw66VbaTJT0hO1XQGDN+SBFfbJCtnVzUwjYGmyBFvS0JlSxwzO3S3gFmn5/qLk8MwH3J
	cWJuyKcQe2mBx6Z/ZWAavLLxKk0gUf9wCGSwLI7a3nYr+Q==
X-Received: by 2002:a05:6a00:23c7:b0:848:63f4:b4bf with SMTP id
 d2e1a72fcca58-84ee49b1735mr277980b3a.74.1785515590142; Fri, 31 Jul 2026
 09:33:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731140533.566493-1-david.lee@trailofbits.com>
In-Reply-To: <20260731140533.566493-1-david.lee@trailofbits.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 31 Jul 2026 12:32:57 -0400
X-Gm-Features: AUfX_myU3wxzECte2ZdSiP3LMMltOm5l0gUHFzi71XQc7cSh0nKaoZzAwLOnjxY
Message-ID: <CAM0EoM=UDkGKLivsdDS5JaVMuefR4jLC2rAWJcOR8XD-4N_EgA@mail.gmail.com>
Subject: Re: [PATCH] net/sched: sch_qfq: prevent aggregate self-replacement
To: David Lee <david.lee@trailofbits.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, Kyle Zeng <kylebot@openai.com>, 
	"Dominik 'Disconnect3d' Czarnota" <dominik.czarnota@trailofbits.com>, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 10:05=E2=80=AFAM David Lee <david.lee@trailofbits.c=
om> wrote:
>
> qfq_change_class() snapshots the current aggregate settings while
> holding the qdisc tree lock, but drops the lock before selecting the
> destination aggregate. During that gap, qfq_enqueue() can move the
> class to an aggregate matching the requested settings.
>
> When qfq_change_class() resumes, qfq_find_agg() then returns cl->agg.
> If it is a singleton, qfq_deact_rm_from_agg() frees the aggregate
> before qfq_add_to_agg() immediately accesses the same pointer, causing
> a use-after-free.
>
> While holding the tree lock, skip the replacement when the destination
> is already the current aggregate. Any estimator replacement has already
> completed, so the class change can finish normally.
>
> Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR c=
ost")
> Bug found and triaged by OpenAI Security Research and
> validated by Trail of Bits.
>

Please always send a reproducer - either as a tdc test case or if it
is sensitive send it privately to me and Cc the other maintainers.
As trivial as this looks I will not look at it without a repro.

cheers,
jamal

> Assisted-by: Codex:gpt-5.6-sol gpt-5.5-cyber
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---
> Trail of Bits has a reproducer for this bug that triggers a
> KASAN use-after-free and can share if needed.
>
>  net/sched/sch_qfq.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
> index 6f3b7273c..e900890e9 100644
> --- a/net/sched/sch_qfq.c
> +++ b/net/sched/sch_qfq.c
> @@ -517,11 +517,14 @@ static int qfq_change_class(struct Qdisc *sch, u32 =
classid, u32 parentid,
>                 sch_tree_lock(sch);
>                 qfq_init_agg(q, new_agg, lmax, weight);
>         }
> +       if (existing && new_agg =3D=3D cl->agg)
> +               goto unlock;
>         if (existing)
>                 qfq_deact_rm_from_agg(q, cl);
>         else
>                 qdisc_class_hash_insert(&q->clhash, &cl->common);
>         qfq_add_to_agg(q, new_agg, cl);
> +unlock:
>         sch_tree_unlock(sch);
>         qdisc_class_hash_grow(sch, &q->clhash);
>
> --
> 2.53.0
