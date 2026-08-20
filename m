Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45127415B68
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 11:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787227140; cv=pass; b=IbFjmgUUf/Rh4COzXvF+r0idC0sXvlSJuUiwKWPBujemEmx756NQS9kcxqhEgLN18NP92AXarQzKbbGcmGoFRmLRFKtZnytwbUFdY5hiXFNpGQMfy7/4UIb8bMChZ9J6r9BZsFMPJqfPcgL5Ug6N/x7GTNY8ufGdfI5DcSmd1xA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787227140; c=relaxed/simple;
	bh=ImOCecJImRFG7dcjt4Zjn2EN4G5XEEg3aaA9PXxBLHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QbcvhjAa37qSMDE63YEDvTHMSYyXkawVAhfhFodKrAUKNf9P3Eu4bwDZa4ItHWn6ux0QZMrX/Xky3KczYvcA+Ffj5LBPIjaYHzPPHRhUhtnByCkg//fvlyjtv04KC+sdqkjq73EW3cgYakcR5LslPhuNIOAzCeRfUghg9AVilhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=EgKbEpaB; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="EgKbEpaB"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84e0688b859so270821b3a.0
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 04:58:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787227137; cv=none;
        d=google.com; s=arc-20260327;
        b=pFM3FpS/6U7NUqDLLZasWdbQ6Mo6GA0UYWBuq8HRFV5fU4V8tDCazgCFzOFIZGi19X
         sQRrupcWqyeQ45inkrBQTMRrS3dAjAyzEK8SOZMSMbzk8DbVv34LVfDcmV7glkcedotr
         8Fdxjwq4bJ8ePvEFnQGZW5NS3Z8E8S4hNxbRlHowyjtRrThBu4de3Pad1w5b6lUCeHp2
         66e3NxEqX+t4i+WsuHaVlLKQ6dL7Gm/yp5n1NUMj6L5nyeAv7DJEb3xrAsfx0EUpavHI
         5g2/WLGR6nskqXt5jZaYZ3EMProj2V/+cCWzLRzxDxF3vmNwuo2Dk4fKMlYoLvbNor+7
         L12A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bf3YKh+ptY6dsEL/5t3RcfoK5c8dQ++Ak7cpFCxnHC0=;
        fh=Mo4jABy+Qqpu3ugugQfCi9Eaac8e5YZFLy7xCFbdG2c=;
        b=Twf6KacF01I4cjC9v41i+8aaxnYmtwv+UuTjkgQ6KNkOvWHm0f87zjEQHqSMK+7fAW
         2DxrjfrtBFRxhe9aUGAt7SkDoeQ0Tu3zpZwINxVI5AVjSxNZDb2Mehui1llJY3EkKBVx
         yhceIXDSFm4/9rGHpK0veEPmL3EMRjDEzJL6HnE8vQDqY05wAtXbC5TJIcrnpDGjFtqJ
         tvtPEID9Br+wNEKxg33eI0TH1moOxgwCk6gE9+ErX7meD4nuj9p0zCIjlyA+onrBiAGF
         9qtSxuhqBcMeDnKtBmrd3zlyDLXNpru0ybQBnhVKpvLrVhQWhT/SqoQKMqT6KE0/DqoO
         lbeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787227137; x=1787831937; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bf3YKh+ptY6dsEL/5t3RcfoK5c8dQ++Ak7cpFCxnHC0=;
        b=EgKbEpaBeYu+hTsBjoxf3bAYcU8rIN5an6cNEbomoqZUJdpFvFHLH57jtXVs1xO2pW
         dHzeU9LvGvWpctXngrjxymVcYsIV5+52q2HByT8ZAQ2fzRCqtU3Qsj8sjSrevqrkJzax
         0u8gCEM4fjKu4MO8QXjQtMyw0P//0P0pGUxIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787227137; x=1787831937;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bf3YKh+ptY6dsEL/5t3RcfoK5c8dQ++Ak7cpFCxnHC0=;
        b=W6PljTQTDPCqlX3ZVrhJ4bpqwf+hBBtRabHg71BzehLptE9Y2g5Mi20WJ5/Q/5uxG9
         vF1tmlgub8pSKIKayTRv46RlSmUyXk9aQ3Hyol/MQNo/uSEMmZ3z5NCplKdVj8g0lgWb
         6IP966nLxLNSWuw+TOpeKLlO8gF8O0F3cywsWE5aGyeBgG8ZC0buokJppjm+yByjeX1D
         KTDwhWpMuDQmD/CiUrKCX063TY/QV3GN1wr29fbcCIGViNfVq+QE3E5C+uFF01bY8Lxh
         gShxNhlyeGy1R3yZ04a4hoGYEjCGbHnNaOVfuZB708UhjF0ziliFH4pYg9+TRfvKGxFZ
         4Muw==
X-Gm-Message-State: AOJu0YyhP+XGFzihMtp7tJNtSlyVIQjLf2xMee3GOJi5qazALIlOSfje
	/HCwpVGre5uJUD1sbWkPP45pXeoIhmaCAVF2FFyUmmQq5KK+jmOgil0aqIAIcYllwVh4Pymafwt
	mgWumkvFuS5Uyv0s/k+EWRxtM7mOOEFMpIkSkF8n4XmO3q7SpGRJYfw==
X-Gm-Gg: AR+sD10T429lgefm6ncr1S/vfXxdzKgmheEpi4jy3axy5nvejACLDlJ+hzpUJNt5SiP
	3yraakInOtfUr7ZiaHF8Mjgh0MbbW0P+dp10lgXtQpmw+ttMoIVIjcCPHvqvcuLWT5W6P4umcRw
	ZSGA5wxMV0B6KXcF3Tt9zmK5so7gV76JvMv8LSwCGi0PJIZ+4TTXDqTBpJWGJ1yWy4SgBf5Xcap
	YyJa7uCWU9FFLnQv1NSnaatxERM/h6fZQhSKOOPh7QaGz9xsf/QLpS2cZ60G+bwaTK5sKkbDsvp
	9vccKbUhBNzlWIRY+doqds3DGj8vkgvkoGhFxUJhvsd9hQ==
X-Received: by 2002:a05:6a00:800b:b0:842:5b66:3c7f with SMTP id
 d2e1a72fcca58-851d34833efmr20446596b3a.0.1787227137441; Thu, 20 Aug 2026
 04:58:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819204210.23722-1-fw@strlen.de> <CAM0EoMmT7xFtxrVwCm1ohpfVAPBuVBFHB8q_eTQ5taSquKo9og@mail.gmail.com>
 <aoboL020DIcOn2lx@strlen.de>
In-Reply-To: <aoboL020DIcOn2lx@strlen.de>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 20 Aug 2026 07:58:46 -0400
X-Gm-Features: AcwNN1VsL2hPP_mlfyADtSkV1o0USlQEHIpMQQT7ICK15fq30ePHoI_IpXXUkpQ
Message-ID: <CAM0EoMnvz6A_v65s=jcdw5nxL6N2+yd7ZBvp78mtt7edkPe-sw@mail.gmail.com>
Subject: Re: [PATCH net 0/4] net/sched: reset conntrack after packet munging
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, victor@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 7:42=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> > I apologize for the delayed response in the private exchange, but let
> > me repeat my thoughts here...
> > As you said, the munging can be done by an ebpf program (at different
> > attachment points, not just cls/act using multiple helpers).
>
> Yes, and that is ALSO buggy.  For BPF its even worse because if you
> permit arbitrary writes at any point in the stack you will also
> invalidate e.g. addresses/offsets stored in skb->cb[].
>

There are a lot of helpers that could cause a mess.

> > "Packet rewrites are still possible with BPF. However, unlike pedit,
> > that needs privileges in the initial namespace."
> > That's only true in the default setup, but with BPF "token delegation"
> > it no longer holds (will be reachable via unshare -Urn).
> >
> > I have not tried to verify what i am claiming since we "last talked" -
> > but could try it out when i get time (weekend looks promising).
> > If what i am saying is true then you will have many places in ebpf to
> > fix, which is not ideal.
>
> *shrug*
>
> > But even if not true, you can still do it with CAP_BPF - which leads
> > to the same outcome. Unless we are saying as a general rule we should
> > prioritize where/how we fix things based on whether they are
> > reproducible via 1)namespace -urn  vs 2) require root permission
> > (assume this includes CAP_BPF)
>
> I think 2) is very different from 1).
>

I agree. In fact, on the tc side we prioritize fixing bugs
reproducible using unshare -urn over those that require root.
The question is: Should that influence how and where we fix bugs? It
is something i am struggling with.
Example: If the ebpf one could be reproduced with unshare -urn would
it have been fine to make the fix sit in netfilter?

> > With that thought in mind, the question is: is there a single hook
> > entry point where this could be done?
>
> No.
>
> > Example: nf_conntrack_in() or nf_confirm() as the choke point which
> > catches all?
>
> Those are too late.  You would need a new, unconditional sanitizer hook
> at INT_MIN, in all of IPV4/IPV6/Bridge, plus additional code in core.c
> to refuse installation of custom hooks before the sanitizer hook.
>

Yeah, that is a bit much.

> And that doesn't solve BPF (can sit anywhere) or OVS (no idea here if
> its affected or not).

OVS is very likely affected.
I saw your other email and you are the expert, but I am itchy to try
the nf_confirm() approach.
At minimal it should fix the PoC imo.

cheers,
jamal
