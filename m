Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792778526;
	b=WOAn+Y0ewsOK2A9YYfwQ9DboNZGfPM+gTN85HFplNSZR645pF38OIJ4KrawJNHtgoxqf
	 +eY48Ek8ZVHahIwPc35ba0PbBGcgc8sMZePoxwRls0TR9oHUQRqmwTzGdPqewxph7NUDi
	 40rXZLvEw8Dk95laH6edgOUPatwwtznkUfZXHr+Qfnu6FioABMrewOqssnoT9Bff6Z41y
	 +bxQcTzT1dQ7PwNZTmpBbMTfLQplgZ9tq5+nx+mtBHdaNtzkO5RumQWHOJEFHzRyVjTJI
	 +7wtVyIAhhFjl1bQJnx9yjjVZ/YwqIwThHfNyPP9ABvJePIf0NFukomL3enu7Cgvssw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778526;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=F8kKKkeVRH1C1ujyKt/WTDLWrsF0jQEilWBMIPiH9zQ=;
	b=X2Zz/YQbxIuHz3pJEjzSl9j3MJnKPtLWv18v7YtBVWIe5lHw/T4mxG5qgt2yb1OoSZKA
	 u7gP04+rL+XGKs2fz1rI8eDfXdVAdhLORLpkx8y/ZMeKAobq6DIAOdEkm/l98mPvgxkuL
	 lEgmPJCtJ9+IHKHfzraXEkY35fpPwVEVDLizk1EyJq9WFIsbVm3iqU58nTy5iWBOX7S66
	 p1UH6pNuU6rfegoOvudYWytq88gwy4M0zkN/VZ2S82MQSffgLREu2z/93/HmLEau2W6Cd
	 5ACPGVD06SEZWNMowsGfEzCvt7E7HWSmuEse6rAzkqwubZN714WUzs3G5u3fGFDZXOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=iLherPiJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A524606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 18:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A524606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=iLherPiJ
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a064fac8cbso670351b3a.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 11:02:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792778525; cv=none;
        d=google.com; s=arc-20260327;
        b=llJc9/iCAjcGDaxchtmF1lUq8awlWnNM0aYcJ+RMeTVfHQSLhB2aZxxo8Aa260wg+y
         HIj4KR4B0mEoLwPT+OWsaODUqnJd1iq55zSLO4iOoyZvJF7MpHwMHvWwQgHNRLO2p5cT
         x6Y3upDUP4AIU47k9pzFqJSZ5uGBWw/s7mbC6biA5dnD/O+VkHW735DvJd+wCFVwGqGS
         qcaOqBN3JRqx1rOl53EcxBtAT2sNg4ot7z+oRCLw/boVY388j4IN47qLsCvlFhQ2w/of
         qTi2WHigJ+jUG8CSPwBispzHxYMZ7kfHE8QR1reitruSR5G5kj+Q5mIxuZw3JPOUuG2w
         cKvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F8kKKkeVRH1C1ujyKt/WTDLWrsF0jQEilWBMIPiH9zQ=;
        fh=vRECJD16v2TSCK3PA2E216a4xPrseSw/C7vzaRh5znc=;
        b=nL+D2zMYg8Q3SkpRxbnNJcE1hCAmL2l2cLwlsR44fbE8zLAZIYBtFg6W2lInlx4m9M
         hJKIYcvSjEL3rgTu2CCEPPgKfONTB8gdl2QxwJ5ohiS27CwYrwKWJcDLEfHR9RoqJ/kd
         rgILLmJy+UiIltI6Tz7pqu1LVc0JMPTLO2C/Q69vlYqwaKEMKNNvFLXfRuKtSVM4zKNj
         HRjn4f8QCct6F3wAeEBH6LVp4QQRCo6MoyVh4LeVLT0DNkVt26suM9Ya8SqcfmeUuVZg
         mKCb/WN2a9gG7l+dRMf/9+QBKrYV3Z2//4oaq8QSH89USaSFKfEfuJQSDR8X21Gd2jEO
         +H8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792778525; x=1793383325; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F8kKKkeVRH1C1ujyKt/WTDLWrsF0jQEilWBMIPiH9zQ=;
        b=iLherPiJazIvBi/OrLC/L1EUCDN6c5EYuyrQAtv2gV735sg88WEkZCXOuviNrDbmta
         74IJ2+IrblOk2tCK3R2d6j+wEfW55OukdYW/jvrTobnnuRBAHAa1mtcJ/7ieJm7v2aDu
         OospGnmpYWGC8IAEVNAG2zWtbj7b9Bx3wCtSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792778525; x=1793383325;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F8kKKkeVRH1C1ujyKt/WTDLWrsF0jQEilWBMIPiH9zQ=;
        b=zUHQElljoNM0f7sYvRJ/Y7f9jmbC9W2twH4vWMxLRVaFHX7oPcWv0tABIyZsWoNmyL
         SfkqJKwJa31U7+WgnijHIWl94C2gWkzuNt0BLezALRTbpBwNhY+AYLI4/+52Sm5v3dRN
         aFYU0fWWmbpfptorJJ2UgcDRCm4LBUU/RRdS+rJ4mIPyfYq1BAvpSfhdkP7AGQVQxazB
         Xjpl4KIVbbeZ+G+b92y2sFQh5XPw7IsTwJFw5ZVHER1h1klxXNfXz7mV6ZprpM6lGY/E
         DTiLfXN/1xKl2pIbR3GZeDvXSDlt1Y71YM3fb03AS9jcwcy5Ns1tsTqKngvjIcRvRUs3
         sBiQ==
X-Forwarded-Encrypted: i=1; AKwUvBx1tkD/KfLBqO1UQQiUzT9jeBQriOUbi0D01uEAgRf0eYnD5507YA4IG1ZLJ8039UY5tdzYj5w=@vger.kernel.org
X-Gm-Message-State: AFq9FYJDEdpSjP9rZGPs+gD3K7xvrT22MhfEs5+DzLONnAtT9Az3uSyG
	1MWzRl4Ut72thPbFqSL1TsnSk37DmH+IAiZ1zSZvPtGYrOtNo/G2fQXBTqAGey2OfDU4DSdS8WO
	qJEqfQ/By8zbTabp0wmwqGB5/A6LSWlPIoxdsnbmUfYmzDngmsnW+TA==
X-Gm-Gg: AYBFou3DBLsJ5B32b2dSsEWWE50Pugl+zuXlqUoZPSG+mh1mtNPUL3rhrMV39cRml2r
	oOP6DarwZSB1C62F1N3SVAE1FmcjL1cyJvkfEBOlXTCBFiyrd+sNYmaMZPpL77wRPQCdoDrbDzR
	B0O+HhmJWf8SdLjLTvT8AFNHW+KKtdsKNHIwsEou1YenX+ZyQsddCeux5rYTuQjj91JDJPGE6WA
	VuGoqL9o06tX7amlc088avfl3FNYIwquYuSNq0ke+fIjxjgjv7gOdjwu4JaeWxPMTK2ytGI0fuw
	wu06yZ7sTsLmTPb3zjcu80lOiIHfo/K6ENZEKZO4bQzideOdhOsRjBnpBihO9EBAv7lCYA7nw8j
	wa3cXclzKFg1eSZHOHLqV1Fj8EM/f9NGV/uUJUFLMY7NBlK3HeQgDjU7WIDhlrtjbOkJjdE2CM+
	ogfJlY18HL148554I=
X-Received: by 2002:a05:6a20:4328:b0:3e1:8a96:7bbb with SMTP id
 adf61e73a8af0-3e37669ae93mr2719334637.51.1792778525406; Fri, 23 Oct 2026
 11:02:05 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021155450.66934-1-phx0fer@gmail.com>
In-Reply-To: <20261021155450.66934-1-phx0fer@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 23 Oct 2026 14:01:53 -0400
X-Gm-Features: AclHuK-ubfVgOu4vslU3ch3G-Bg_NGM92UpB-RTtvTN9YazG8Y9e1DYiHE9MfEo
Message-ID: <CAM0EoM=XC7V630n8P7_UhECTFDuJcP8XqeYnU+jUG68a78YteA@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: re-cap skb->queue_mapping before indexing dev->_tx[]
To: Dudu Lu <phx0fer@gmail.com>
Cc: jiri@resnulli.us, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 11:54=E2=80=AFAM Dudu Lu <phx0fer@gmail.com> wrote:
>
> qdisc_restart() computes txq =3D skb_get_tx_queue(dev, skb), which indexe=
s
> dev->_tx[] with skb->queue_mapping and no bound.  A tc BPF program
> attached to a transmit qdisc can store an arbitrary __sk_buff.queue_mappi=
ng
> after the tx queue was picked; that store is not re-capped on this path
> (the existing cap in netdev_tx_queue_mapping() only covers the
> skip_txqueue path), so an out-of-range mapping indexes past dev->_tx[]:
>
>   BUG: KASAN: slab-out-of-bounds in sch_direct_xmit+0x744/0x89c
>   Read of size 8 at addr ffff00000e0802d0 by task A-254-2_S4/100
>    sch_direct_xmit+0x744/0x89c
>    __qdisc_run+0x34c/0x1d04
>    __dev_queue_xmit+0x1aec/0x306c
>   Allocated by task 1: alloc_netdev_mqs+0x758/0xfa0
>
> The same stale value is then handed to dev_hard_start_xmit(), which
> reports the same fault.  Re-cap the mapping with netdev_cap_txqueue()
> before it is used to pick the tx queue.
>
> Fixes: 10c51b56232d ("net: add skb_get_tx_queue() helper")
> Assisted-by: LLM
> Signed-off-by: Dudu Lu <phx0fer@gmail.com>
> ---

I did not look closely at the rest of your posting, I suspect there
are similar issues in some of them:
please please since you are using AI ask it to check if there is
already a submission for what you are trying to fix on the list.
See:
https://lore.kernel.org/netdev/QDISC-MD1X.v4.r0.20261021042722-1@mojatatu.c=
om/

I got my report from sashiko after submitting a fix for a related
area; hopefully your guy is not just scanning the mailing list...

cheers,
jamal

> Tested base
> -----------
> Detected on Linux 7.3-rc4 (commit 93f51579e7df), arm64 QEMU guest.
> Re-checked against mainline f47d223627f8 (v7.3-341): the affected code
> is unchanged between the two, so the bug is still present there.
> Checked against linux-next next-20261021 (commit 9a482184d910): the
> affected code is unchanged there as well, so the bug is still present in
> linux-next too.
>
> Reproducer status
> -----------------
> A reproducer was written and executed on an arm64 QEMU guest (KASAN,
> CONFIG_NET_SCH_PRIO=3Dy, cls_bpf); it fires at the claimed sink, and stil=
l fires on
> a kernel built with ea4d4b5dddb5 applied.  The reproducer source is not p=
osted
> here per Documentation/process/security-bugs.rst; it is available on requ=
est.
>
> Triggering conditions
> ---------------------
> CAP_NET_ADMIN (attach the classifier and qdisc).  The residual is the
> store made by a tc BPF program attached to a transmit qdisc, which ea4d4b=
5dddb5
> explicitly scopes out.
>
> Notes
> -----
> Built and checkpatch-clean: this patch was applied on top of 7.3-rc4
> (commit 93f51579e7df) and a full arm64 kernel (defconfig) was built with
> it -- no new warnings or errors.  scripts/checkpatch.pl reports 0 errors,
> 0 warnings.
>
>  net/sched/sch_generic.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index 6f6a6f0d5eb0..c326d12942e5 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -432,6 +432,13 @@ static inline bool qdisc_restart(struct Qdisc *q, in=
t *packets, int budget)
>                 root_lock =3D qdisc_lock(q);
>
>         dev =3D qdisc_dev(q);
> +       /* A tc BPF program attached to a transmit qdisc can store an
> +        * arbitrary skb->queue_mapping after the tx queue was picked, so
> +        * the value reaching here is not necessarily one the device can
> +        * serve.  Re-cap it before it indexes dev->_tx[].
> +        */
> +       skb_set_queue_mapping(skb,
> +                             netdev_cap_txqueue(dev, skb_get_queue_mappi=
ng(skb)));
>         txq =3D skb_get_tx_queue(dev, skb);
>
>         return sch_direct_xmit(skb, q, dev, txq, root_lock, validate);
