Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED34237B007
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787851833; cv=pass; b=PY1iVnJPYxVXdeKibRZNNJHqlct17g+fKg+cILVdKWCM54u+xbE7WrBDDH/cWT6/TE2EZmNb4hWhwEpSvXyrBENyniZrjaWP6/thvID/PAZXhu1KJJs6b3VZX5tGjdpeRphLhYjzgsDZhVSmQ2IwEs2Ai4k7w9f/ql65oPhq/fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787851833; c=relaxed/simple;
	bh=JHGHTCIHkS7ZtSd/nhPlvivP9R4MXEl6d74i8khb/Yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EsYVJ27yT7AYweZ1QuInnp85vC3wSXR+8JUHihZeo1n/gA5drizU7J7dLfpsWMpxIL3YuuA37OlvuWV87uaO07R3srhKzwcrg1N/0W8ryrawGjVkh4QlV8/SQTRetMpDGBBpM1Tsm381jnaqdpVuVJk/T3l8kSmJ2QSJmZvdli4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=PE92KcBx; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="PE92KcBx"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc1c9879395so155880a12.1
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 10:30:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787851829; cv=none;
        d=google.com; s=arc-20260327;
        b=mbtACj+xb09sruhzFdBzW9/OWIxHMG0JLqECqexdIxX5Gb4+lkgGCUWsU82cyZMzKE
         BGQ/pqmGobmFtZXm9Wx/a7SbBIezGGgUw20qfmwvgtt2M5W6jRL6+yz/+/UxzbQEO7XG
         93pFZ6ZIaRaKhZBnHkRpMcErGnl8KIcsSwGfNipvGT8M6S5VddKzXLGiqKjBx2IVf16L
         HmyCrllBl8A6y9fTcKeH7K6n00/zRY6hYRjUPTbElhR8SlgU75TiX0yFHKiMA4srwtJu
         0LvE8paNWlIBVuiuGm6qbBme6VGEmebvfBNpPSkBG5jWPV70eV8HnkLO2DwH13NAzta8
         AjHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iLLGcbVfuf7yTVoqHZ5vu3n3AKk5F6JdfA/5wggXb4w=;
        fh=HT4IJx8X1XHWE0kO1rJYUVXvPrGfN/R8edo5bEfj7r4=;
        b=QprWjJ7Gotufq+k4d/rNN4hr6RUoPIa0zmhy/3nhdiDrEzYxnJa8ievUKWS4BflzTB
         w6NR8kIcjiaqD4qdwhkYC3ke/ILSpk7+L38SvRK3SxAvQD184T1OqKCEx0tbVt24Ftr3
         ZiSAT2+duVtJYTvTEl364fPLJGtRbSc2t+8+xG2UVj00yiVRqa+OTjAIGEezySVcJEKx
         F0dbr/Vuyx1HSB4Ew43SljQsQzP95UwQCGNGQirqjP9A7+CfX0jOyh2wScQJaxTkqE+E
         AzHHrhHo34nzH0ZrMjll9gCGMU/xEX59drZhT+hyOmvC3ld1rAr4c4vG66q2Ud2U8dN3
         VbVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787851829; x=1788456629; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iLLGcbVfuf7yTVoqHZ5vu3n3AKk5F6JdfA/5wggXb4w=;
        b=PE92KcBxaKBdKSIPDJ8c1DK1dY7foYtGGdx7Cybh3RXQGzUO/I8/AmmJo65cytftMc
         RxvfG3hVusk51XRvnpDKrCCln3wE5jIrV460l5N9zCxG61TZ/PBAyxXYLowdmb8AFy+y
         rr3745dDjaBJC8BuWOL4vS0ASRaxXdJcVdUCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787851829; x=1788456629;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iLLGcbVfuf7yTVoqHZ5vu3n3AKk5F6JdfA/5wggXb4w=;
        b=K0zZYg2BknqoqegZ1/GKi5bjiT0bEyBajPyrZj+ZVifB2ewlA5pdm37FGbp4J0A9Jf
         3nHK7cDwgTfxunxX48R06aP0+uZ9WR/zt8oW5fNjWUlCwD3nhd+tJAcmvJ1GeKkbtSTj
         7PNi5Gtg+81DzVARzeYQCL85Zi6BWqv3i8AwiwGMdJXRzfaNWNPaGIFDiCcro9r0mJpQ
         i40I4latq/2HqSUNVQ7VccKpQmrXYFA9qod7vTBFTNuT6kqVVxShXgBoEgLkuOwBqL8x
         s5HKl7h0HSz4nOxsCo7Rjf9KqsTNG+bVOabwB8LJrNfcY5qdAXPoDpmTcgOJWqHLToxI
         IPig==
X-Gm-Message-State: AFuF++mrKX0JAGEQw+zB4B1olepxyfTZRCjw+jHYvwzIYVjSOH4rWB2U
	aHGAEwTWtPWQ3pLUhA1GcH7oN0ceDriawUDbe1u9KWI9ujv/fBReG65DqGWOnwIBszpGMUWrsCH
	rUPA5qwZBhtVDc4PVVr+mlBCjxJDWkkGQY6bo4ubAR+zQe3hYUUVsBnRQ
X-Gm-Gg: AR+sD11zngQEPm2YjsnyE71thLGSxd34ZX5tYySM0NSStSE9Hg8119DUW1x2QlsqbiT
	GR0kZCPjU3XVmzE755+nUEd8a6QOFMsj62c6ufEbSzt23FkgjsQmiTKRT7/A4sWHMQX6Hlebzlx
	MrdI6WLZTjjACRX8FhSyruVZvQrDEqcVSQkUAx7NvRZMlWBuKJo2imtibwSuRzAAQMBYHKVcXw7
	PNPADh4tEBnBHea7nCy+xZQvwFXgaB0pwU2u8isGEOk2e2kAYRKtLKWeZJIUzJyeqH6/vrvt0yu
	3CjjEy+DaTn/OQMitSDklvRy9l5fWJoL1atxxgwKjNjPFg==
X-Received: by 2002:a05:6a00:1da4:b0:847:8acd:747c with SMTP id
 d2e1a72fcca58-8562ba7dcb8mr1537496b3a.13.1787851829194; Thu, 27 Aug 2026
 10:30:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825081052.133898-1-jhs@mojatatu.com> <81ad3c6c-85d3-4ba0-b36e-3db21138416d@redhat.com>
In-Reply-To: <81ad3c6c-85d3-4ba0-b36e-3db21138416d@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 27 Aug 2026 13:30:17 -0400
X-Gm-Features: AcwNN1W5MtHUvt907HbvKT0Wx9tpkEAYjM1m7_cW7ZJ1J38wEThkvR6LGeVp2lI
Message-ID: <CAM0EoMk1b8kFf_FNH5vJvT4g6Nc3+affDB1PrJcm=p8nyoaAeQ@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] net/sched: cls_u32: fix duplicate handle when
 node ID pool is exhausted
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, stable@vger.kernel.org, 
	vega@nebusec.ai, Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 6:30=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 8/25/26 10:10 AM, Jamal Hadi Salim wrote:
> > gen_new_kid() falls back to returning max (htid | 0xFFF) when both
> > idr_alloc_u32() ranges are full, instead of reporting an error.
> > u32_change() trusts that value and inserts a new knode with a handle
> > that is already live in the hash table, breaking handle uniqueness
> > within the table's node ID space.
> >
> > The handle was never reserved in ht->handle_idr, so every later error
> > path that does idr_remove(&ht->handle_idr, handle) removes the
> > reservation of a different, live knode, which is then reused =E2=80=94 =
one
> > failed add compounds into further duplicates.
> >
> > The 4095 limit is per (table, bucket) =E2=80=94 ht->handle_idr is per h=
ash
> > table and the range is derived from htid (bucketid), so a table with
> > divisor 256 can legitimately hold 256*4095 knodes.
> >
> > The sibling helper gen_new_htid() has the same silent in-band failure:
> > it returns 0 when the tp_c handle pool (1..0x7FF) is full, and
> > u32_init() publishes the root hash table with handle 0 without
> > checking.  Two root tables with handle 0 alias in u32_lookup_ht(),
> > allowing cross-tcf_proto knode add/lookup/delete.  Add the same
> > exhaustion check that the divisor path already has.
> >
> > Return an error so u32_change() fails with ENOSPC/ENOMEM when the
> > node ID space is exhausted, and so u32_init() fails with -ENOMEM
> > when the hash table ID space is exhausted.  The extack message
> > distinguishes pool exhaustion (-ENOSPC) from a transient allocation
> > failure (-ENOMEM).
> >
> > Conditions to recreate the bug:
> > - CONFIG_NET_SCHED=3Dy, CONFIG_CLS_U32=3Dy (or =3Dm with module loaded)
> > - Create a clsact qdisc on a device, then add 4095 u32 filters with
> >   auto-generated handles to fill the node ID space for the root hash
> >   table (single bucket). The 4096th auto-handle filter add triggers
> >   the duplicate handle (fh 800::fff reused). Reachable at Level 2
> >   (unshare -Urn, namespace-local CAP_NET_ADMIN).
> > - For gen_new_htid: create 2047 u32 proto entries on the same block
> >   to fill the tp_c handle pool, then create one more. The root table
> >   gets handle 0 and aliases with other handle-0 root tables.
> >
> > Fixes: 7801db8aec95 ("net_sched: avoid generating same handle for u32 f=
ilters")
> > Reported-by: vega@nebusec.ai
> > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> > v2 -> v3:
> > - Fixed tdc test that sashiko (correctly) pointed potential security
> >   issue on.
> > - extack: condition the "Hash table node ID pool exhausted" message on
> >   -ENOSPC; emit a neutral "Failed to allocate node ID" for -ENOMEM
> >   Introduce small extack helper. The v2 message was misleading for
> >   -ENOMEM (Sashiko nipa gpt-5-6-sol-1-2).
> It looks like that sashiko was able to think more about this patch and
> found new stuff:
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260825081052.133898=
-1-jhs%40mojatatu.com
>
> I'm unsure if that falls under the 'same bug' category and should
> addressed here or separately. WDYT?

Separately. The Sashiko findings on v3 are the same pre-existing
issues it flagged on v2.
All three are different root causes (IDR key mismatch, refcount
management) from the silent exhaustion failure this patch fixes.

I am tracking them as separate follow-up patches for net-next. Here's
the list just from this one patch from the sashikos, none of them
wrong, but none "regression" and worth fixing for net in my opinion:

1. handle2id() alloc/remove key asymmetry in the divisor path causes
hnode handle duplication
2. ht_down refcount leak on new knode hw offload failure errunbind cleanup
3. ht_down spurious refcount_inc on update knode hw offload failure

There's a bunch of minor ones, that may be worth fixing for niceness
but as you know no good deed goes unpunished with sashiko, the moment
i post a new patch it will find something to complain about.

These are:
- Commit message range "1..0x7FF"   being inaccurate - which is true.
- Extack should say "bucket" not "table"  - which is a minor refinement
- tdc test to check and assert for ENOSPC, i think the explanation it
made is sensible. We only check for failures not which exact return
code it made, but if i change this it will meaning changing a good
number of tdc tests to follow the same approach.

I could probably sneak some of these in in net-next or i could just
resend only fixing this. What says you?

cheers,
jamal

> /P
>
