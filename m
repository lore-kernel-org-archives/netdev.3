Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921422F8EAC
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 01:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786670658; cv=pass; b=EszbIGsgFdq1Nq0SS54Xii4H3rgy9kvl8zWAON567PqADP51Q8ZjZqtqwRfE8PIBPpZudQdHF0abk3HlJ03x2zBT4DA5u8JY6MQTPp0BkYJ0dANbtrEs2gp6CWzaMvMdHtzyP1wMesxIBKujAVsriLiUObBbKyQZwHGlmnLtT1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786670658; c=relaxed/simple;
	bh=cuyeLpBNdLoVcolWTIViFV7hFI/ReZfXIFwBtv+1YCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQfHStQrqufziYD6ot8DUdeCff7YMgMM7M/bMS8fqUELYFwT68mthJuzEK1Q20bS02MXZ9/10ocey06R7svL7Asl/kekFBKbBcQOyjPSOWwmioJsTJMgBXWzS+gaMKl6B/T0q9ZUKowJ33PH8++fGcaWYiGKTRt9x57SWR0+WYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HqY2Ikix; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HqY2Ikix"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8f23e851626so2833956d6.3
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 18:24:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786670642; cv=none;
        d=google.com; s=arc-20260327;
        b=sYVGADTN+gYoSEbrPs0XI2vIVy/ZYrsy4ZyiCYOqsbFuoRzO4eVFIOHVQyOhdujFN1
         KVaX/l59XyOmXwlsQ9Rswv7yHyDHmM3+1B8//7N/w8QHx4pfJv8TmsX9IKsrfdZ7by3e
         Cqw58wFRpce8rzINVrfx7VdwFbhJsyOC5diJuML8nZatKhQi/Fq4F3ARjA7QTe6i9I9/
         O3KhQ2wRmP0U0s7W+4g7l6wfu9KJ1Vsuhqrk3XliujuLzWfV6reoATE8L9ABaEM/PzmF
         MDv7LczciPbmt1JTBbfehn8sphpeAgtKT+dqMWe3HSDI+hz2hMeDhq/B7OC3IxtMcNk0
         TRgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dIqhgTXMNMbYFoYNlDKpK72/trU4eGHf7U7lg59BcD8=;
        fh=at5QiDAsnqHHBGb+D2vyl3YTr90DvshA1PVSzmISjsY=;
        b=BI2+g42ujzZ2BdHlxeEeQOf/bQg0KnsGkDpRIN7+nJno/xbQ6jDvxtannvgioBpK9n
         8MQudb3GvaqWFMppEi9co8yE3BVhdsWCoP7ULLzhN4BSZkWFjHmlyYlbExsfLABl85Td
         P7A68Td/RCrXXHCv2CB6gATb9tJ/C+600bOMoDUBKlZ446vlsDRTPyVMCd1ppyB6mtGM
         U4gKujigujR/pBMDodVQ3OmqPJ2ctPoaAAUwSclKSe1C/ldFhzvYIU3tGTX6hN1xEATK
         Bu74R3nQ6GbkxYiH5YlnOAIiqQ2hBpWjqQRFko5FXGocF7n1H3ampxCZJTL4xVqsfE3W
         rekQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786670642; x=1787275442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dIqhgTXMNMbYFoYNlDKpK72/trU4eGHf7U7lg59BcD8=;
        b=HqY2Ikixkwkg9v/A1z7DUT21E3D83h9z8nanVnZ5kCqZcKtdWqzfkZ30wvjNKUwlVb
         IbWU6Wi3gTlEz3EsQYWXLITp6N0HjYPttgqGG8ttpoQpcpsvALEC/26FArDkjswvHQRf
         k9uny4qXWAbCQqLSx2yS+rVTtXcbV5ydsWO/KsF4Nv4jWqJoBFpXLmJcbTrbxEtWPMdg
         f9PNDnCiiZc43Bih20nR+ba8XeifPorPz2pETiE14oL4YSP5hdTonuq6Hu6JD7JVv9+k
         gZd6HFh157LWofHRIewcmSfIV8n4Il6bgB/EjbFDoAj+mKYZJ7qOrKnjVMRPbKxFsfGe
         I4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786670642; x=1787275442;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dIqhgTXMNMbYFoYNlDKpK72/trU4eGHf7U7lg59BcD8=;
        b=bZ3smcG3c7v012e2FEPzr6qjjHEWXZRFp8bZcbY0jqqOhFbYQOK6aR6I/RTFKevfQ2
         cg0KQRO4u+JqNwH6mxVIbBrsOJ3gRBMW2m0QfSUFlMWryLTMevf5tj9QBGhbYrhjbxrf
         XOGKyncXq+TNuSNj1aDZiGTHPuhvn6ifBxBC4Zo8h4N71zGjaRG3i+i98JclYU1U8qSm
         jcUCV6GgQA4BKZSNBYwtlyUcDATYA5zN7rE4K+8KlnqiJjj/geweYJS13f9TbYJihCn/
         NBqNnGsi9UJH4Owsc/5OzYj/fxly7lDKKThLtGeN81P9dd5M6kegPEYI7lxh9EyyRUu4
         pQTg==
X-Forwarded-Encrypted: i=1; AHgh+Rp483t7cRzsDgF51+/J6H+232fJPODLnsVC30sumGRjpT80i46IKm19iaG38RVUTIUcAVZQP1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu8UUDxtd1VMu0BZQuZ7o7OtmDb2QBy/bhE6cHelcQc3t2rW0l
	bEWdbRzBeiEqklzncKDD1GR7EAD2O7aZRJbJgeggtuO3mZuPuRvsGDO/9ryPcEDakIlSBOn2Cl0
	kLfAvrtTsBVC5jZr0rzyRuZ6yn+Dfpnw2jJyn1INI
X-Gm-Gg: AR+sD11lnXwAhueBbitVsKe6vS6jm/hiWcH2FB01tRb8bv6lVYolVS4WRJR6mc0O6ud
	fzU61DlSKRWjem/tWjmKx/cdeIYjBAXANa5T19/gSE+4iinR9Qhjsq5GIZG/SwoP4vsIWUbA19U
	RWgec+U/7QwDFo84sq0SlpILCxIXcU8RO8roPjqGAvbBWq0rdgBtVveu+fUoq8ZbYltuU0HmZKm
	j9xobw/ct7i0YXWq9hlJVmZffMLGcP/5QoCgDxWVoibryAQPjL06mn/AOFeA6OSifcOKWjh62rj
	MFoZKG4Tx8uKD8OLB8nNB+GO553LBSHJltrvnlhHJKL9RjravaXwkTscoDx+LObCTvUMZKjuPsC
	ZuVM0La46KbdCB0hl4/BJGAxKQTs6Y+86mhjsXIBMTFXr2OnwjgADw7ea
X-Received: by 2002:a05:622a:4c8e:b0:52d:7a9f:57ed with SMTP id
 d75a77b69052e-52d85381ed8mr28730751cf.5.1786670641602; Thu, 13 Aug 2026
 18:24:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813222629.492738-1-gmj@meta.com>
In-Reply-To: <20260813222629.492738-1-gmj@meta.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 14 Aug 2026 03:23:49 +0200
X-Gm-Features: AUfX_my5-_1sQD24ajVztBBHmvhJOEErJJXlcG4I6zdgItnN7gZx2Uy1YTDUI70
Message-ID: <CANn89iKFHCA9B1+0FkML=BxZ+0ytu3s5YBLjbt5-+X+CCox09A@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v2] net: gro: coalesce short IPv4 packets
 padded to the minimum frame size
To: Glenn Judd <gmj@meta.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Richard Gobert <richardbgobert@gmail.com>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kees Cook <kees@kernel.org>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 12:26=E2=80=AFAM Glenn Judd <gmj@meta.com> wrote:
>
> Software GRO fails to coalesce a small IPv4 segment that was
> padded up to the 60-byte minimum Ethernet frame.
>
> The selftest tools/testing/selftests/drivers/net/gro.py subtest
> sw_ipv4_data_lrg_1byte sends {100, 1} expecting to receive {101}.
> In current code, it receives {100, 1} (no coalescing) instead.
>
> Cause: inet_gro_receive() computes its flush term from
> tot_len ^ skb_gro_len() before skb_gro_pull(), while skb_gro_len()
> still includes trailing Ethernet padding. A small IPv4 segment
> padded up to the 60-byte minimum frame has tot_len !=3D skb_gro_len(),
> so flush is set and the runt never coalesces.
>
> v1 detected the padding with an added iph->tot_len read and
> skb_gro_len() comparison on every IPv4 GRO packet. Instead, split
> inet_gro_receive() so that everything after the header validation
> takes the flush term as a parameter, and pass a literal 0 on the
> common path. That folds away both flush updates and lets the
> transport dispatch become a tail call, leaving the common path
> shorter than before this patch rather than merely unchanged.
>
> Assisted-by: Claude:claude-opus-5
> Assisted-by: Codex:gpt-5.6
> Assisted-by: Meta:internal-AI-tooling
> Signed-off-by: Glenn Judd <gmj@meta.com>
> ---

I am pretty sure I met NIC where the extra bytes were not zero.
Unfortunately I no longer have access to them.

Your patch seems to target a specific NIC.

Look at my prior commit : I made it generic. Checking if the bytes are
zero has the same cost as computing their partial checksum.
(real cost is the cache line miss)

commit 88078d98d1bb085d72af8437707279e203524fa5
Author: Eric Dumazet <edumazet@google.com>
Date:   Wed Apr 18 11:43:15 2018 -0700

    net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are friends

    After working on IP defragmentation lately, I found that some large
    packets defeat CHECKSUM_COMPLETE optimization because of NIC adding
    zero paddings on the last (small) fragment.

    While removing the padding with pskb_trim_rcsum(), we set skb->ip_summe=
d
    to CHECKSUM_NONE, forcing a full csum validation, even if all prior
    fragments had CHECKSUM_COMPLETE set.

    We can instead compute the checksum of the part we are trimming,
    usually smaller than the part we keep.

    Signed-off-by: Eric Dumazet <edumazet@google.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>
