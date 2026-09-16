Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4075221D7
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576048; cv=pass; b=Fuz8lgxa3+toMv9Sd/yn2sMz7Zh5+CYGhN+7AIYcXCHsdsSrp8Iwz9gffg7C/WS+4535Pa1vy0Xcr/YNcaOQ+axnEK0XNocvY48bpAAg4G7zLuuIajJUGVdBbflAHZ+0z5H+6ItwMM8BBr45F0Kc1bNzthtECwnZs1MGJLqxKFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576048; c=relaxed/simple;
	bh=CZKsV8TBc/UU4QSemteZYCRFcL7JXkwYzG8Pz6oZRZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJm+UOaV5pkD8z65lCoR2UizEPqJIoZLeO9KDuJabBKXwxNuX5VfiSFmXWrjAtDT9wKBegU7deXX7CC8odyjM4T3GWrx/eXT3wYew064Vzc1p09w93mGmmFFwZkLEq2K3Lc8xaUztj1xUYrtqCsc8Ml4gXROgLN9bd6ycKuXavE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B5GHAVG4; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B5GHAVG4"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb76bcb1eso11658091cf.3
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 09:27:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789576040; cv=none;
        d=google.com; s=arc-20260327;
        b=qjfC4uRm7cF+ZJHj5Xsq1Us0zLIJKn+Ey8z8TW258ERJZr9vVzrv/NattpUC6d81F+
         uRvolUFDMRNaCa0/FhRk7PgtbZsIBMoACxgxncTwcu7yfg6ReVDGUnIgmR0Ju0np7YK9
         IM3SVZjppa28M1m6EFeEVjm4tfqRNQTgmIwxW8nElLHDyZpeLczlndyNoxYoCBwxEZ2f
         B54eQiAwJTdoq23pfGeeQteBC5KVzAVDsjOvLnPG1UfYQ03Ae933WixXnOj+3CmH/vn6
         za0DYA2ptGvrhJ8BAgrfuneQKVFOLfY7h+oC88UxC/ODCzkIfWxwIvYbss6MVAqMuyPo
         AXAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5wvcHHBL+iTEv0FJTwpkXt7VkvfWjy+zaGtBY5bI0rs=;
        fh=7udpQEuheXaT2WL6S3K9AF8pL9Sp7c4wTirnQesF1Hk=;
        b=T1MhiewXTDNt3ZgaChhavCHPO2haWt7v6rd7EmL9CMesItyGJ7YK7ux2cVKYhL3juU
         4K+QETW2WgSVqSK4EeH6U0nWIumdvcpM31tyVK7f4kLqYPwx7vxxzQz87CBefeF0Sq03
         GcR9p7/cdFQTvm2+YEENoSGr34tn+MtVBaCpfuHBftut8b1xu6yK9+TLnfymsOjrlBLc
         ZQt/QbfkBTEejq+T87MRs+XRtYtOuiCOBz/xws7HIywg+k5PuFJGSwJ4NeqZOtAxNEom
         0ySResm5YPrCkvkeRGtPsMF/w8E7/aXmH5zWL8xzimFWoMP2IxwWfMzNowBhgKzjKGXN
         rDdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789576040; x=1790180840; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5wvcHHBL+iTEv0FJTwpkXt7VkvfWjy+zaGtBY5bI0rs=;
        b=B5GHAVG4O5d4fEVbNzONKezi5D3pH/WzCdTpSIJH/VJmLAYY5eFMDiblK1/3bqJc4e
         p0bZ+ufhdqQ6DmfdKsx75eZBuk8vut++1kl27EZ2yntVulMmKhj/ZFC24mr3FQ8M0Uri
         YTtkXPdrXtpk0g6/TSbxo1232AGnAhTH4NtEPYqijtWVU3fNbU+4ltH5BLUbiRUG+1yn
         LLh6eyO0l859zxhMPmUHMHyK3zzNpJE+Kmkef095rZHeUAm9wNLrX3r/9PB1USdiiTuK
         GOtn8NGpTW1VTIfG0yWz9JMtcBC9zLBhI8fP9RThrWajX3hVGbxaRWe/W6OPZu05aBHs
         6i0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789576040; x=1790180840;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5wvcHHBL+iTEv0FJTwpkXt7VkvfWjy+zaGtBY5bI0rs=;
        b=sE1b6AhTbxJuYqiwiSaRbpNLc8wMWqNJnIOVV08bjcD8U7pvotWu6YeqtU2I7IWj9n
         vP23LQvUt6h5spN3uaqB1hJZA9thHHLUQq4t4gq0hzjJ6em9QRxMaSkcH/18n4A2ROKs
         FeV0j6HU7m0RXjuWlTXV1smulpKpORF583pbCMrPyrhU2pL5FP1XhkXxDfFCzgY7HcQl
         jJqD9OP3TSwEvHTW6tMNQGyAg4qGdQHAmbGR1TFu8rEMlAD8P9aiXnPgfQqefZAuRCDE
         7Sww/qt2wutUkG/dVgq+Tjrx2VcJlD30T5KgR455jVTSh0Qmz+D1EQN9OSPLMRm3buDG
         xGug==
X-Gm-Message-State: AFuF++lIZkn7ppT4AeR0V4whzuUiAOPg0gubyn3wxmmm8hg4KArQnCnp
	B7aL9cyTlTr6bYc2Ohk4wpXJtvwyWP+KOUdcuHJA20brmH8AzP9PsAbxT3+P6vR+D2l4Cu5nN9t
	l6Tlj5QfLb1JMqYWIeHvhFNEq3SeizTnjkxlhX+dN
X-Gm-Gg: AYBFou0uXx8P9x4vIaeoTEVu5CjJ1fdvjVT61IFRJNxXbXHBD0jJOCYrHwbstHh2avj
	A1rk2we0LOSIcYANQHOrmDo+HeQNQcbdESiEgpesIG1kFOI9t/1LVfuTufZlU0RVRDY6UOAmEYl
	Pg+5Xr4a+TeRkyc4lriLkAxWPsFFkYpHdT0up0odr0RdEvZKdrw37dHzS1WYnWxBuEG8BTEPcAX
	3XAqxkKyQtIGoihTYsOC71aydGOtAt1uBqLb5Fk9DEqIofDEY4RdcW36GOXozoAkhgpUe1Kprrk
	q60roOlwzqo0E9Rv5YXUIBMBNRiCJV4w1MFolVn6feyBIXRDYUaCUQ3GEPevPvndN9vYNQSSaoS
	MKIRK5TVWFFJEkTVa+8ghSz5j13sXzLI1tKSi0FWwGGDXVNFZcAykUYhQNvhfDAtfY1bAKE+86g
	hNxJFLjg4BlYchmTRICFaJcIxhdmH1+UvrzQ==
X-Received: by 2002:a05:622a:110f:b0:531:cf:b9dc with SMTP id
 d75a77b69052e-5327ee5e315mr57726971cf.11.1789576039235; Wed, 16 Sep 2026
 09:27:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916143717.1875082-1-littlesmilingcloud@gmail.com>
In-Reply-To: <20260916143717.1875082-1-littlesmilingcloud@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 16 Sep 2026 09:27:08 -0700
X-Gm-Features: AcwNN1VQ6CTcVmS3X_ezXS1lS3jOoR8VrCY1MCKo-lPJza77JSmcjB68i55jAx0
Message-ID: <CANn89iL5XujaOU9TjhOufAR092PXDBumMPiJy6GFXdzjujH1kg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/9] tunnels: add core and gre drop reasons
To: Anton Danilov <littlesmilingcloud@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 7:37=E2=80=AFAM Anton Danilov
<littlesmilingcloud@gmail.com> wrote:
>
> Only vxlan reports drop reasons among the tunnel drivers today.
> Everything else, on both the receive and the transmit side, ends in a
> plain kfree_skb(), so a packet that a tunnel throws away is invisible
> to dropwatch, drop_monitor and perf trace -e skb:kfree_skb.

This is not correct, and it is the justification the whole series rests on.
kfree_skb() is a one line wrapper, from include/linux/skbuff.h:
static inline void kfree_skb(struct sk_buff *skb)
{
        kfree_skb_reason(skb, SKB_DROP_REASON_NOT_SPECIFIED);
}

Both spellings hit the same trace_kfree_skb tracepoint. These packets are
already visible to perf trace -e skb:kfree_skb and are already reported by
drop_monitor today. They just carry reason=3DNOT_SPECIFIED.
It goes further than that. The tracepoint also carries the call site:
TRACE_EVENT(kfree_skb,
        TP_PROTO(struct sk_buff *skb, void *location,
                 enum skb_drop_reason reason, const struct sock *rx_sk),
drop_monitor's summary mode aggregates on exactly that (trace_drop_common()
keys on point->pc), and packet mode exports it as NET_DM_ATTR_PC plus an
in-kernel resolved NET_DM_ATTR_SYMBOL. So userspace gets
"ip_tunnel_rcv+0x1a4" for each of these drops without any of your patches.
That is how tunnel drops have been triaged since well before drop reasons
existed.

A consequence worth noticing: several of the kfree_skb() ->
kfree_skb_reason(skb, SKB_DROP_REASON_NOT_SPECIFIED) conversions in patch 3
are no-ops.

Now, I am not objecting to the series. I am objecting to the argument,
because the real one is better and you are not making it:

Every failure in these functions funnels into a single drop: / tx_error: /
err_free_skb: label. So "location" is one program counter for all of them.

Four distinct failures in ip_tunnel_rcv(), around twenty in ip_gre's
transmit path, eighty across the series, all collapsing into one bucket.

Call site attribution, which is the pre-drop-reason fallback, tells you
nothing here. On top of that the pc is not a stable interface: it moves wit=
h
compiler version, inlining and config, so it cannot be used for filtering o=
r
for comparing across kernels, while NET_DM_ATTR_REASON and BPF filtering on
the reason field can.

Please rewrite the cover letter and the individual changelogs along those
lines. Several of them repeat the "invisible" wording.
