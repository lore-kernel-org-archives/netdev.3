Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC9D39891E
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 12:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788006063; cv=pass; b=p78wtSaRhUgyiAvVZodUMKWZeaRzHrO+ml4CXlyRuKoYZDpMJ0iFXpQsWRc6hPmaV2258OdLroQ7K7buGaxhU0ODMq2Wsv3eIuMM3sWMGgrOJIt+/w2dQlpr7VKt4GUnrYPWXI3D3R6ib4D5ILG02Eo3ZBq48tqRGR3Qe2Fr/Zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788006063; c=relaxed/simple;
	bh=YhhiT+lMqx5HjW0/PRoXbfXIAG7+7GDtlBab+gtNpMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kAy4JBUAzYC4BORJZIneL8EhEg/4kKpzCMB7HoilXBLC2n8RuSrZSofcmOoTjBoqtG5GatCs3JRfKHdPB6zmxFja61ccKm/313GSvyIFosYwocVXPJjBPI5O0fOyVkDDnE67s+bZ1Qo+iqN1cqfyJMDV2OEvfN/4mET/IHGw9JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=HFcDzDb6; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="HFcDzDb6"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3a1f75277f3so14274251fa.0
        for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 05:21:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788006059; cv=none;
        d=google.com; s=arc-20260327;
        b=X/TzSjurGEvo/X5PVDtx4NMgIZpFw74A+DjsJzl5o0g2I3kQctS5FfPLwUgNME60iW
         Xzmqgm9HsOK5QbFBH111JmllLvAe7C5RbYY4mIdL/jObfoLffYbF885vhzJoXIPK8QIM
         7cQd8q4Fo1kGHbwzhCzjwkMZz8Xc7mn9Vw+HgESFoaUDGZc6Z2tI2UmChLX9dvRj5a0u
         nFzSooKx0SRk7fcpc3HJkOqwCNRS9Q/h9Q5HKzVjMxl0iKPcumCwj3VEIPKFR/0/Z4Ms
         QlIII33MDQaQODzaHO8TcJjCXuVpklwxG3aXYyIQXUSyXnGUxjFKCnoCDEhnv6vK3dmb
         /mzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nE/f8PbdH5aPK+fOdkT8SOOm4R+FJIcq6dMyrpYaz8g=;
        fh=yMvtgaqT2e7gkx/r8ILA/L7sOV6kim4nYvtpBXkn5BI=;
        b=Q2vIZ5t6EiUh01C3pRgZ5Xcy7r3BnI0LGiReqB0fijXl2tCeogRvm1k0x/VNvYbIoN
         FcILIqC+vXz/7NANT7acFb6Hkx4WLtMRYJLJNsMkfUkzWiVlzGikaS9xaqZ/byVk4daQ
         6WjBrVAl2sEe9XKTvWh3EQK2uBOOI9fBu3V2hAPENHUZ2p54u6d5D6zaayj1DbYCuRGC
         ToGoq8zmCQ3T0PQrQ3wArLNnqVBt9cr3yqmgXU+vaMWOOEDcE82xnGUNNVDGGYx+0583
         4dfhbVfF+ipnw0LWumPPlqQ1VST0BfgqH0vQLJevx0KU2wm7oGZ3nsCCBNl+SePQHY0Q
         rZGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788006059; x=1788610859; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nE/f8PbdH5aPK+fOdkT8SOOm4R+FJIcq6dMyrpYaz8g=;
        b=HFcDzDb6kRKB9Quw6R/ZsGMk2g6xONxRRL7G7ZagrcGy+LkN9nw+h/uLM4ZNMHF89I
         tMhKA+J4t0yIa2OombsSE6wxqK8xzFqfdZ1J4d25kNOfiszRZz20uL6iVVZhfwMPi5mw
         qfJwwsnO6XEwWGBm1L3GmKfQGjjL1DlLzcjx1QWFS8Qe+MUd1Zwgdwreoj1Ii7Sj4Ze3
         foymhnRv0iaJcgMc149nibCZNX5NuEcyBvm1v2nrYHyugSC/F8aByY+rzAzRdbxzxnZP
         zNR7VMmsxXmV5gPT0prLq7SK1Ya4sQz8vjoJmg7tZ/1KY0HSPSxH+z5YR2EpPWP+JSsp
         Ey4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788006059; x=1788610859;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nE/f8PbdH5aPK+fOdkT8SOOm4R+FJIcq6dMyrpYaz8g=;
        b=egwxJORgC1g0EbyC6qzV3GwGs3Jvm5aj5X8x+D4PA3eBOfOgQ8FFCf5OEGrCT1wIZ4
         xBOe0XaJVx0eJoaSzm4/LPQHwFg1c3h6autBBpNL3YvDNBAU8mPaLn3DaDo1WEoQ/IaV
         c5T3bb9F/u99MOwlGjwsVmMDZL5T8hnV+tH9coe4iSuwzk5qhY+dRZiOF5/KOScsWIkH
         9xcFjNH+9IuaKUiSw+mbCjQeNJJNNDO5poGiVu7OD5JERmDHZ81AqaiOxsHiQOE1AFSi
         8s0GpkaC7EJjD8GMRrGa0zXej44B2iQpQRpD6KIb4cHcsuIbA7Y21VuQNTqsRJvRcwQr
         9Lpg==
X-Forwarded-Encrypted: i=1; AKwUvByOpOYCCkCds1d5QPcAW3isNmiHM+MuUtFBMwFIxeInnQYGN09sup5TyLCMZ2lnyyDW7IOO6aw=@vger.kernel.org
X-Gm-Message-State: AFuF++mjedd5EI3zf0SbJX9Z63o4KIfdeMcKRPrNXvRIvda7FMEmZmLf
	BbIxMdqcYW5t7uFGrX6KWp1B+8Xwex1bcnCsMpPs/rfd9n67bvBUy7D0SNSopSZVOqIqy/KKz7B
	fEGmRICbIb+TT+W554PKonvYlcNzhR9PJiXHXoERPsic=
X-Gm-Gg: AYBFou2dHkm13TPR5DhK2c61FfRZKA6nyXxu4JSQwj8TYw3grQQFEaUH1kn6fbx+TOk
	sM5PyY0fq0XMNLv3Q5BfXI54UnKaMosuGtp61ZZCCYHuf3fusBaCSeDh8miLNxKvmrQOPYXHSfh
	wcWA6o0HKYnyFtEOwzaoxYd+qShwsiwaCmoLmTEiljXuVuK1umI3AMBJ4kNv5DtUHQfyhQSD1k1
	e2vKL+tcbLN3oZ/TnPiu0310zagTuYb3QipNgWqF8ISjFGJLQkAN9kNKCZ4ddWQSYIynrY8YFwI
	rV2r2fXd2QqSuqox0Pp9rdPf0re62/jPfM/b51SfnXyiykm1wDFzN0ja/zBJ1HqRdshLINC37s0
	UIRNLHVGnpWU=
X-Received: by 2002:a05:651c:2227:b0:3a3:2127:8ef3 with SMTP id
 38308e7fff4ca-3a321279098mr394261fa.10.1788006058169; Sat, 29 Aug 2026
 05:20:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787903722.git.zihanx@nebusec.ai> <8e45ea5d0cf764267a90d959fa40f0f831aabf08.1787903722.git.zihanx@nebusec.ai>
 <apKl65BbdyWCtre7@strlen.de>
In-Reply-To: <apKl65BbdyWCtre7@strlen.de>
From: zihan xi <zihanx@nebusec.ai>
Date: Sat, 29 Aug 2026 20:20:44 +0800
X-Gm-Features: AcwNN1WiZi8R9J8wiesRuFh5zNnD6DxT-pHV8VKVtagX319I_sL7Cv1N8NzmPJ4
Message-ID: <CAANe3eT8ycDkomgpzZmni7hMrUX1fr2dE4QvQOcKCPEcw=J=2A@mail.gmail.com>
Subject: Re: [PATCH nf 1/1] netfilter: nf_dup: prevent asynchronous duplicate recursion
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Phil Sutter <phil@nwl.cc>, Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, coreteam@netfilter.org, 
	stable@vger.kernel.org, Vega <vega@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 29, 2026 at 5:27=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Zihan Xi <zihanx@nebusec.ai> wrote:
> > nf_dup_ipv4() and nf_dup_ipv6() use current->in_nf_duplicate to keep
> > duplicated packets from being duplicated again while ip_local_out() or
> > ip6_local_out() walks netfilter hooks. The task flag is cleared as soon
> > as the output function returns.
> >
> > NFQUEUE can retain a duplicate and return from the output hook. A later
> > NF_ACCEPT verdict resumes the same skb at the following hook from the
> > verdict task, after in_nf_duplicate has been cleared. A later TEE targe=
t
> > or dup expression can then duplicate it again. With an earlier queue
> > hook and a later duplication hook, one packet can sustain an unbounded
> > packet generation loop.
> >
> > Record the duplication state in the cloned skb as well as the task. The
> > skb flag survives queuing, reinjection, and skb metadata copies, so an
> > asynchronously resumed duplicate cannot enter either IPv4 or IPv6
> > duplication helper again. Copy the flag through nf_copy() so fragments
> > retain the same state. Keep the task flag for the nested xtables jumpst=
ack.
>
> Not sure about this one.  I think this is a case of "behaves as
> intended", you get oops because you *ask* the kernel to oops.
>
> I think there are a great many other ways to OOM the kernel,
> outside of dup/TEE/nfqueue.
>
> IFF we prented that this is a real problem, then I would
> prefer to solve this in nf_dup, not involving sk_buff changes.
>
> I cannot see a sensible use case for nf_dup outside of
> physical hardware (sending packets to some external
> packet logging machine for instance).
>
> So. I think a better solution would be to either disable
> dup in user namespaces entirely, or, restore the "old" behaviour
> of passing the clone directly (no reentry) if we were configured
> from user namespace.

Hi Florian,

Thanks for the review and for outlining the two possible directions.

I take your suggestion to mean that, if we decide this is worth addressing,=
 the
fix should stay within nf_dup rather than add state to struct sk_buff. Befo=
re
deciding whether to pursue a patch, I rechecked the practical impact.

The current reproducer intentionally drives the system into OOM, and this i=
s
not a memory-corruption issue. An unprivileged trigger requires user and
network namespaces, NFQUEUE, TEE/dup support, and a userspace verdict servi=
ce.
CAP_NET_ADMIN is available in the child network namespace when user namespa=
ces
are enabled. However, vm.panic_on_oom is global and cannot be enabled by th=
e
child namespace. With the normal panic_on_oom=3D0 setting, the demonstrated=
 effect
is resource pressure and possible OOM-killer activity, rather than a direct
kernel panic. I have not demonstrated privilege escalation or a memory-safe=
ty
impact.

The crash log in the cover letter came from a separate root validation run =
with
panic_on_oom=3D1. It should not be taken as evidence that an unprivileged u=
ser can
directly panic the host.

Based on this reassessment, I do not think the original struct sk_buff guar=
d
series is justified. My current preference is therefore to withdraw that
series, unless you think a defense-in-depth change is still desirable.

If you do prefer to keep a small nf_dup-only change, I can prepare either:

1. disable IPv4/IPv6 dup in network namespaces owned by a non-initial user
   namespace; or
2. restore the historical direct ip_output()/ip6_output() path there.

The second option preserves one duplicate but bypasses the clone's LOCAL_OU=
T and
POST_ROUTING netfilter processing, so it changes observable semantics. The
first option removes dup/TEE functionality in those namespaces but avoids t=
hat
hook bypass.

Please let me know whether you prefer that I withdraw the series or prepare=
 one
of these defense-in-depth changes. I will hold off on sending a v2 of the
struct sk_buff-field patch until then.

Best regards,
Zihan Xi
