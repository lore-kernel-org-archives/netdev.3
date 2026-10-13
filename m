Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD3452CCF8
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914142; cv=pass; b=nMqT4OWJRi//u9dfyTKf9eaoJ1xb3LKqHOtqnQ+zdpZ2k+WCBeX6c+6x25urnpod6PoweWiD+sKRmhovntVYS/JK6+Eh81zba2OHt0xm1erVpXKyNxGVzfgDjy49TZeEdfhnpEc+HAtI4ea4vsNMIxx+NbOWz8Z+BjnwaPfKL6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914142; c=relaxed/simple;
	bh=SQgjO5qMcrjkdqWkFJWQ2/5aeiMU8vBt2jrTtWhC0bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5wci58IoYawcfXltx25csxR0ubRzD1oWu/5AaRuY1CIvESLpq8EX95d7rl6FCAJ01o2ZFineg5Y4tMlrrMQDCpCBMmLob9ORZx16LJsDuLmTD9ZNebYfTwRBwSQ39J7eSL9Kx7jiI+DKAFTCe6ZWbcvUI6W9pojiDCFXROL9f8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b=JNXQg/VP; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b="JNXQg/VP"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7cbc729b88fso493690137.3
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:55:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791914138; cv=none;
        d=google.com; s=arc-20260327;
        b=Lq3qhaFXR+yJ/7tRUpBgbaI5yVM1BQJEH97bO5t/ZCZ309sNugSZizjnberhumyk4s
         AfGXTpy4m3LOk4lM6ui7J5XZtbszjP2vDOOg43Iz7XIVROwp0Ck40eQP6WszQRwHf0HH
         xo9t9FVud+TlrNoKxYGmTlBMgbhOkg8290tLsRC/YmOvt0bOjL3l4z5sTRcwR+1iheps
         gkUUat4A24YXi0zABMHGm5rK8g1TNcU3k4zp3PqhVA+Z7YL2qAiYo8OHeSs/qe6oUIDY
         Ew45HVJRjxbB79QHetzoQli5AqDPzPnqnhBRfVABfWJqkKugzf2n+7zcFPlwiusbsNI6
         M7ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xw10GollzpDXFQSLBXSRG9PlzHoCfGflID06EBih6gE=;
        fh=xUFNwS8lEph4ogfJF4aLIO5rrO6OfdzMjOZG56RHY5U=;
        b=QPD6V+m2JGSqA7Zn8PLCo5dn0I1nueKtjq7u6T5MXTfYa93z+nhw4LVPqOgqaC+Cqm
         t67+fm4ext2fq43g8MpK3d3kZXkEw+xKor2hHuiZNOGOievwr4R71CifyCtpz+Bdrwd+
         ysp3nB/+h3wZvxeQ5GY2/NH00+4NeupyeA9wpSeTRLir0Guq9Vt7khn3wmUV36ibe2Gw
         kBkkAAtBMtL6WmTvw4MTq8gByzoUn6FE9gPpxSgBDBnTtG4/pUGa0mDPoD+xuHXP7lqP
         AGiiafNxz1nLCy4v2Snhh/0QDdw8/MG3KlYVjsKoWOq6RrqMY+SM8yIy69unYh7vFUKj
         xluQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1791914138; x=1792518938; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xw10GollzpDXFQSLBXSRG9PlzHoCfGflID06EBih6gE=;
        b=JNXQg/VPNBWzxhfwnGsYc8nw7bu2uInI8zdyWeaDgFlcDS9O4Go81kChcz9YmrbGiu
         tidJ+GJ741R/bS9MC0l++8xX/cIuOEGxn2mC0tAon5YQ7a6k/yiAXD13xhozJ3PwwALm
         z7qUefr4rpgAEJjWdYjAbiXJ3IfCrey3Sknd+DDQePCmufbcccnLS5l1fWtf2PcMJ6do
         0B/mVcSCVGy126WhsPGX3R7PFDOKjPla98LnX8eyZV+jAjb5eyEPOLsDbPvZPND/2pE9
         aex0p1YZdx2wa4UQ+VNHnwuqU3MmQ5c2WvHZckXykd1ioU7bfUv75p/kIWyM4A990Y7q
         P0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791914138; x=1792518938;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xw10GollzpDXFQSLBXSRG9PlzHoCfGflID06EBih6gE=;
        b=LY+BodZFDgTr7R9uS+lARS1Kv8Llb8A2bOksYkuQRul0PWmsXMXEpzZdUoeVsFNsVL
         XTLvI8RRNbqIuVSeEvJ0701bk2pcA+72WcmLbwijMi1Tjkw2HOhinwUzQOEX/hLiTHEQ
         zxDyLKS4yP/ulmONCZhCEpBz7uga+r5Te2L+oNpdImiPTZ9Uwf6mVUown4zhXYWsTrEY
         RZZYUUv2u6ILhy5iVPg8BliaXSs/H3g9TRJ+1nCoklY7qMuW08eEwN1zzHDfnWY8KLsY
         Cu1Nlumq04UzOpwPJVKnJiBpnE3+LDAUL6b/cFByrr0uOCgwobmIUw5k4x562q7bmjYc
         a0Jg==
X-Forwarded-Encrypted: i=1; AKwUvBwzdLLpujvAVBc6X0O0ll2dArNff8xAJ3P+QvdpB8S8JlHF/fk8yuPZdeeuPeBCYXq203SAkbk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVaIJGfXRlW3pZQhuY54kwuZxMdmlMpWQLHqgTYXMB8HwBT0Aw
	+4qtTwAR0iboU+qPlBvAvjiG5YY7SmcpzBaAC6R8UV9lw3K6NB8J+Hd2E/rX1+WIoaGwJTi7VRH
	LL3ELX0VZPEABCtyy55huX9W0UqSpq0lMm6m4mUeNqw==
X-Gm-Gg: AYBFou0xPR22lVw4GoqKcmU803qMmk99OZ+VFL0gmt4LuHpdy5n5FBTRq3UCceThMAf
	SEpxs7OyFncbC5V4KPMAY7c5FiiAuDT1RTe8vFD9SP/d6gk8LrKNb1D2Ks1O5MuSStuk5LGqEeE
	5m2t63u8aAIX3GY8ydFnvP1lq2F0toADlORUzkzoLw/hg/IMYBc1CnLokqImikT0q0k1Z40AAsg
	GqRVunAmXANVbPRIxfcut22Kz2sMtoXVq+j0F73KDtaOAHCmUyIJy5Nr6lZ2+DGj7skkRNXMlV3
	ysbPsxR3QvkbVaGmo0KSnP6OuAW77YSt7ZI5pM1YYxacetEL0iOkZm4wGCxlG8HWn4SvJEFJBm0
	1UOAj9cVH9WloTMPUXJIfEiIftttleAC1mcOrln5rzB75WRXTgzAxanERRlBprJiFIMi01MB49t
	3uB78mbMgbhg+HjaqvBKpeWuYV/XR4IWy+6kOsKZ8=
X-Received: by 2002:a05:6102:f85:b0:7af:4a46:4c12 with SMTP id
 ada2fe7eead31-7cb36987a6bmr3459618137.2.1791914138076; Tue, 13 Oct 2026
 10:55:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013002701.1957686-1-rjethwani@purestorage.com> <as37-A3DKONrFuxs@krikkit>
In-Reply-To: <as37-A3DKONrFuxs@krikkit>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Tue, 13 Oct 2026 10:55:26 -0700
X-Gm-Features: AclHuK_wQkqntYOIxy2Ar-py7TItAzxl71amVVkxjGfGZLHJpFnvXugBsb0o8yY
Message-ID: <CAKaoeS1E7jMyP8F9a+SAheE4+o6RG2VOdA5uiSjZe5yX+E0wEg@mail.gmail.com>
Subject: Re: [PATCH net] tls: refuse RX records after record-number exhaustion
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Jakub Kicinski <kuba@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 2:38=E2=80=AFAM Sabrina Dubroca <sd@queasysnail.net=
> wrote:
>
> 2026-10-12, 18:27:01 -0600, Rishikesh Jethwani wrote:
> > A receive socket records sequence-number exhaustion only in sk_err.
> > After processing record UINT64_MAX, it advances the counter to zero and
> > reports EBADMSG, but SO_ERROR or sock_error() can clear that error.
>
> I vaguely remember a discussion around making some fatal errors more
> permanent (ie not use sk_err).

Do you have a pointer to that thread? If there's a preferred way to make
these errors sticky, I'd rather use it than add a one-off flag.

> > parser-ready record also bypasses the socket-error check in the record
> > wait. The receiver can then accept a record authenticated for sequence
> > zero under the same exhausted key.
>
> I guess, but what's the problem with wrapping as long as we don't
> reuse the same record number?

You're right, in practice there isn't one. The only way to get there is
for userspace to install a rec_seq close to the limit, so sequence 0 was
never used under that key and nothing can be replayed. Starting there
already breaks RFC 8446 5.3, which requires the first record under a
key to use sequence number 0.

What's left is consistency. Today the wrap gives at most one EBADMSG,
and none if the next record has already been parsed. After that recv
continues at record 0, which is neither rekeying nor terminating. TX
behaves the same way: the UINT64_MAX record is queued, and it goes out
once SO_ERROR is cleared.

So I'll drop the security framing and the Fixes tag. I can either drop
the patch, or send a minimal version for net/net-next that makes the wrap
error stick on both RX and TX, without touching the rekey path. Which
would you prefer?

> > Getting there needs an initial record number installed close to the
> > limit, since 2^64 records cannot be exchanged in practice, and a peer
> > that sends the wrapped record, which the Linux TX path refuses to do.
> >
> > Mark the RX key exhausted when its record number wraps, and refuse to
> > wait for or decrypt another record under it, or to replace the key.
> > Plaintext that is already decrypted can still be read. RFC 8446 lets a
> > sender retire a key with a KeyUpdate as its last record, so in that
> > case leave sk_err alone, report the pending key update as usual and
> > let the new TLS_RX key clear the mark.
> >
> > Add fixed AES-GCM wire vectors and TLS 1.2/1.3 selftests for queued
> > wrapped records, SO_ERROR clearing, splice, peek, partial reads, TLS
> > 1.3 key replacement and a KeyUpdate in the last record. Every case
> > first verifies the penultimate record succeeds. The vectors avoid a
> > userspace crypto dependency and the TX path's refusal to generate the
> > maximum-number record.
>
> For 1.3, just do a "silent rekey" (change the key but don't send a
> keyupdate) on the TX side to record number 0 with the same key? And it
> should be enough to test this with just 1.3.

Agreed, that gets rid of the fixed vectors. Since 1.3 only uses the
record number in the nonce, TX can also produce the UINT64_MAX record
cleanly, using rec_seq 0 and the IV XORed with UINT64_MAX. If the patch
stays, the test will be 1.3-only and built that way.

> > diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> > index fbb274287aa5..63bef0153182 100644
> > --- a/net/tls/tls_main.c
> > +++ b/net/tls/tls_main.c
> > @@ -730,6 +730,15 @@ static int do_tls_setsockopt_conf(struct sock *sk,=
 sockptr_t optval,
> >                       conf =3D TLS_SW;
> >               }
> >       } else {
> > +             struct tls_sw_context_rx *rx_ctx =3D tls_sw_ctx_rx(ctx);
> > +
> > +             /* Only a KeyUpdate may follow the last record number */
> > +             if (update && rx_ctx->rec_seq_exhausted &&
> > +                 !rx_ctx->key_update_pending) {
>
> I'm really confused by this.

It refused a TLS_RX rekey after a
a wrap that didn't include a KeyUpdate. A new key is harmless, as you
say, so I'll remove it.

> > +                     rc =3D -EBADMSG;
> > +                     goto err_crypto_info;
> > +             }
> > +
>
> --
> Sabrina
