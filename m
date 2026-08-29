Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BBD20459A
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 21:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788040139; cv=pass; b=OnIs5wjag7T1GvcRBdcNvnCjSKDo4yOdRV0NBpH9y9EpHt0PFPU+Cx0cUAqAu3MHeHYzj5KbQLFMut7y1+ZiubEZWk0/vjVY3SrwztOf0obUvASB81ghb84wTlZCWh8jMMM7+GPd5iaOrRxaxy88dhtfG6LT4rDfWWKAwXKN+yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788040139; c=relaxed/simple;
	bh=H/9uYP1Y0PBrBKTFWJikeiR9zRmEoPiRFj12d2R9vT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGk33XVI4B0HVTQdq7gRIw9UBSKvz/f4uVUM/HPzZx6EPuGm90AYDUUW6V61Z6Ene1vciP27mfn8cXsxD6KAOgFUSAArEB/cT9vjVJlR02z6Ig1cl4XjEgNuoeBOQ2+VWXNuE63wNBl94cyGjhh94e3/V5MqJmOuD5KyHBx2t8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o0TLnWst; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0TLnWst"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-853c401326eso1291304b3a.2
        for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 14:48:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788040137; cv=none;
        d=google.com; s=arc-20260327;
        b=jOZq8uCfz/9Q3IjFIQFDI5Q35g4xR9fnz/G0ND6DlB6u7e3PO+SBAJ8k8nRYbmuaS+
         TT1DstyZxFXavOri5S0Nyak8AT1HElokg/vMzMNgnOrY7Rn3M2iViMT8m4qGxS1jaSiY
         f2TzOmauIpvRAIDAsquKL6gXtzqLZGca9VR9o0baM0ZAmvPbW9MKfxqENys6EhEjMsZn
         3bmG8U/BNzPHYrD8VnM2R65i46hPZWlPBxRSg8rPR+UX7iQE85SLrlNzZvVX1URgTWrg
         7QKLX4MjROGeYqLBklu5HHBStjDixjsqe3HKJJv/RC1WVh+6GkOhPkh4DupmyBCbqbhk
         FPuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ftkIDhd/30DKPZ6nznnqMe05znOkwZBhgu28kTzrKrY=;
        fh=4tMpu72jNLw0z/xTm+owXaauuf58teDNJWKMvYP3vXA=;
        b=eLqmIA/l7iRHtTOQylARr2hMwMF8kRa2htSl1Ai/iwMFP47vD2OhcOEpdzbvD6uY6b
         +cn/RrxFJRiCCDlnYFdvDkCn+MmXZ5ixYlH2Jl6CiDCr9BN7UGlZfxIxt2S5dLeX2/Kr
         ui837z0hkazokH2MJnDz+c8YcJWWX2m6HWkuAGxEFGrPNn6m4etpuHJj+KTv8mkJlw02
         kjYs4XhIEexKwWQn6RAsa41vocd5anrj4EBs72yS35Esi0c+16aWzUrEVv2qr5ocz2t6
         0UTxvlTR75mR9U7/s5Hhqwf3whuUFK1Acxqm7KY//VjwmwUjmaxAnOlD/ZbEeN1ElT0P
         PgOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788040137; x=1788644937; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ftkIDhd/30DKPZ6nznnqMe05znOkwZBhgu28kTzrKrY=;
        b=o0TLnWstOJge42ij5H+k/i0aqIQZkIIdDlOALWA+yoj9L8jcs4zZEqowkN/rzjYEPI
         GcczW6bOFaJXIizZh9TcFEcfZIMPxfQL6iOPeCAFeofHlpw/eUFIWCBwU/MDJYsK4maG
         Rk85v85h64IGXfyMZ0QAzyd+ktLni5LAHrjH0ZPV6tnWxb68pkFnu/vU3d99itKBiTuc
         GgUNNiGzM+2hlZKtVfPM5wWMbVGAYzCd5LjAQ+kWPnIlx7uzYHQojVNngfs9+Qc3/plL
         wreVgwuPdryeYOxfxiN1GzpgEVmWhdqF7p+nRbfzia0az0xeNeXYaxa5Zf1WUotwEBs6
         SpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788040137; x=1788644937;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ftkIDhd/30DKPZ6nznnqMe05znOkwZBhgu28kTzrKrY=;
        b=j6Rq7elGhhkPTujuRkABw258mU1GDMixMmg9CQIjFXh/rAxG/0iJShu7vITtyGxZwQ
         nf0p4T8p22LqBxyoYkbyE0yXJbnWtPqrYpQuVVwKbZIZVG8uZNid0wWhcVpaLpC38+VA
         N/n2Xo/U1MqZLecm0nDTT7aY2P8CZ23E3Il8WqfB6OLazsJYHzJ22wBQsbrY7D5+O8nF
         enfL19t73U8qW1lBciWZ2/vvixlIRRLPKRh884a1QokgPWLPx789E3+uum2T70RD4b/H
         QVryi0zmR8Dg5oK6Y57exUcks+1GV6LsUk0nS09EJzpgRIhOjcgMe8xV9oIxjl3yEroP
         OfUw==
X-Forwarded-Encrypted: i=1; AHgh+Rr1t/owFtwXjY8trpiQXSg6wSLkjHGNcMYH0gapbalF2gPwAX4YckCRjTYO11uH4gSqpbGbCLM=@vger.kernel.org
X-Gm-Message-State: AFuF++mhsmCryJBNkXBMpRDkBTKo4P596n5gGXpN8oTcD/zyp7NQwKBg
	+qC9iW2K2NzCCRJuvVmzIGyaGVUknomZ5saSgXHQ05eRk8NRU9wjx4JzS2LIyGVb1CNk/G2RYyF
	Nz75diPyG6k8Rkl5ZH/1sUjWAmWMd1fg=
X-Gm-Gg: AR+sD11T+9DO9uib//GlVNKkdEFxs7Aj4BRa5Bas85nNTLK7QbGl9Qx2cBSP8Ru8mkm
	5nBbKKw4SckNHFfCTuVCP9tpWIEhyt30Zr+HxS+QqzyltAvcPendv1AaspNAhIJMtVQRlG4jPPF
	aNwMNr8EsOaT8QVaYIIvAyVVLhRUlTA7ztfDgLDCIrLQrPwqnNdgmOH72T0FNarRYjwJr2XeisZ
	jzXfJKmNKk4Ekhs8kZN7yOkz9Oaa+mUupWlx2Ref3r5MBa5QwbfBPENVt8sf1UDYtwSbslzZGLV
	3aDnK/VTCEKdubcguy/kKQhhzNNc/iYG+vwuzbV4Zdhfs6Ei6L2FwbO0641VzYHIEQotvUXZdya
	YqzppksrceaXMGVsKkzSYT+biIFBur/2sv5Tf/U/XsCuqyQ4AZeDvETYIgyV+NfL9cO3UKRmIgi
	eOEg==
X-Received: by 2002:a05:6a00:14c1:b0:847:83bc:d2a4 with SMTP id
 d2e1a72fcca58-8562839d7b2mr27163440b3a.2.1788040136977; Sat, 29 Aug 2026
 14:48:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827-sctp-zero-chunk-inqueue-v2-1-2e7669c6a6cb@gmail.com>
In-Reply-To: <20260827-sctp-zero-chunk-inqueue-v2-1-2e7669c6a6cb@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Sat, 29 Aug 2026 17:48:44 -0400
X-Gm-Features: AcwNN1W4BkB_tLbeddy0Wwm7bmTO0fGD1p86kquDxuqJYp1vS5AQsqvG4z3gYNk
Message-ID: <CADvbK_f-8-0f6i82iH3vuuNBjJwG+Gm2o_RxH37mpBpUc4nZ6w@mail.gmail.com>
Subject: Re: [PATCH net v2] sctp: validate chunk length in the inqueue parser
To: theminershive@gmail.com
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Vlad Yasevich <vladislav.yasevich@hp.com>, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 5:33=E2=80=AFPM Charles Vosburgh via B4 Relay
<devnull+theminershive.gmail.com@kernel.org> wrote:
>
> From: Charles Vosburgh <theminershive@gmail.com>
>
> SCTP chunks always include a four-byte generic header, but
> sctp_inq_pop() currently accepts shorter declared lengths. A zero-length
> chunk leaves chunk_end at the current header.
>
> When ASCONF is covered by the association's SCTP-AUTH policy,
> sctp_assoc_bh_rcv() can continue before the state machine performs its
> normal chunk-length check. sctp_inq_pop() then returns the same malformed
> chunk repeatedly and the receive softirq can lock up.
>
> A remote SCTP peer can trigger this after establishing an association on
> a kernel built with CONFIG_IP_SCTP and configured with
> net.sctp.addip_enable=3D1 and net.sctp.auth_enable=3D1. The reproducer di=
d
> not require application credentials, a shared SCTP AUTH key, or
> net.sctp.addip_noauth_enable=3D1.
>
> On commit f967455fb2a5 ("seg6: reset IP6CB after IPv6 decapsulation"),
> one zero-length ASCONF caused repeated
> watchdog soft-lockup reports in a two-vCPU KVM guest. All 3 pre-trigger
> health probes succeeded, while 36 of 37 post-trigger probes failed. With
> this change, all 37 post-trigger probes succeeded and no equivalent
> soft-lockup signature appeared.
>
> Reject chunks shorter than the generic SCTP header at the shared inqueue
> parser boundary. Mark the packet for discard before either caller can
> continue processing it, while preserving the four-byte generic minimum.
> Declared-length 1 through 4 controls and kernel-generated ASCONF traffic
> remained healthy. The patched sctp_hello selftest passed for IPv4 and
> IPv6.
>
> The complete private reproducer and validation evidence are available
> directly to maintainers on request.
>
> Fixes: bbd0d59809f9 ("[SCTP]: Implement the receive and verification of A=
UTH chunk")
> Cc: stable@vger.kernel.org
> Assisted-by: ChatGPT:GPT-5.6-Sol
> Assisted-by: Vantix:claude-opus-5
> Assisted-by: Codex:GPT-5
> Signed-off-by: Charles Vosburgh <theminershive@gmail.com>
> ---
> Changes in v2:
> - Fold the minimum-header check into the existing chunk classifier.
> - Keep pr_debug() on the malformed path and leave chunk_end unchanged.
> - Retest lengths 0--4, legitimate ASCONF, and IPv4/IPv6 SCTP traffic.
> - Link to v1: https://patch.msgid.link/20260826-sctp-zero-chunk-inqueue-v=
1-1-86769dcc7f8c@gmail.com
>
> To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> To: Xin Long <lucien.xin@gmail.com>
> To: "David S. Miller" <davem@davemloft.net>
> To: Eric Dumazet <edumazet@google.com>
> To: Jakub Kicinski <kuba@kernel.org>
> To: Paolo Abeni <pabeni@redhat.com>
> To: Simon Horman <horms@kernel.org>
> To: Vlad Yasevich <vladislav.yasevich@hp.com>
> Cc: linux-sctp@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  net/sctp/inqueue.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/sctp/inqueue.c b/net/sctp/inqueue.c
> index 5f988b3a8814f..d666cec6b194e 100644
> --- a/net/sctp/inqueue.c
> +++ b/net/sctp/inqueue.c
> @@ -212,8 +212,10 @@ struct sctp_chunk *sctp_inq_pop(struct sctp_inq *que=
ue)
>         chunk->chunk_end =3D ((__u8 *)ch) + SCTP_PAD4(ntohs(ch->length));
>         skb_pull(chunk->skb, sizeof(*ch));
>         chunk->subh.v =3D NULL; /* Subheader is no longer valid.  */
> -
> -       if (chunk->chunk_end + sizeof(*ch) <=3D skb_tail_pointer(chunk->s=
kb)) {
> +       if (unlikely(ntohs(ch->length) < sizeof(*ch))) {
> +               chunk->pdiscard =3D 1;
> +       } else if (chunk->chunk_end + sizeof(*ch) <=3D
> +                  skb_tail_pointer(chunk->skb)) {
>                 /* This is not a singleton */
>                 chunk->singleton =3D 0;
>         } else if (chunk->chunk_end > skb_tail_pointer(chunk->skb)) {
>
> ---
> base-commit: f967455fb2a5a2079b9eb5823e9ccf359174bf9f
> change-id: 20260826-sctp-zero-chunk-inqueue-b478dca552c6
>
> Best regards,
> --
> Charles Vosburgh <theminershive@gmail.com>
>
>
Acked-by: Xin Long <lucien.xin@gmail.com>
