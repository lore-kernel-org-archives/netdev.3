Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504234;
	b=PP1mcc6asu6SdFh9fgakQ3GSM56sSErY/+o3Lgk9nXxyv0Z2XhMgtwTn5IpIjWMEz7EI
	 /aNZBA0NEb/46qUGNjGB54yfrln7+uMIxnI9A/wKwSzL8rlM4ml+MopCwR+Ywp4TAiKys
	 8mHcbcKEnthuwYifYaYi4vCWip8/IKuWlCdctfoPohnQiTKvgUYCA5XuRF5HZ9wW452os
	 q74ZfpdNS2piHWiyqmrfezvH+8mdIFdkucqEBCd7pe8A7K8Cvt7vsj1Go5k1SVIyEfq9m
	 q9bGTrnfu8u/kxogn9Tl20lhPaqRMah0KbFJOCwORUEBi5au0GsnhxU7LBEJg0sK6ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504234;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=96lFzuIF0y8LTZ/Xj/gpwS61X9RAuz+hWffATqcJfZw=;
	b=IBUfxLMMWLhDZxKjZij78RqR24R1k7DCdsrVTA/IPQsgPAPwluRdUkctTaNooxLBz8g6
	 JtNX8s88odEfZu4WmnvOcinUe6c/iPBy/YLjmMhJnMA64cQm4bcHNxJyQo6kPSwymtV2t
	 41v91ZaM3TvzBY/QUe5kp3eMyixgjOiRDToel7fv0q1TcNU3fv1oHLwQVTjTEODq4YACv
	 9a+ilgue3fF7G663tzNpFMU+KIFRl14NYeAVpAhULqueGCbPJHy08dMXJR04ctPkcfB9u
	 pXopWURluAJok1j0LID97he6UileI2lWBaqWkMPcSX6KBNC1tqiurW5nUsWJGMusBrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ONkEtMSC;
	arc=none smtp.remote-ip=209.85.221.174
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A2E606AB27
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 13:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69A2E606AB27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ONkEtMSC
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5e948e56af3so1075422e0c.2
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 06:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792504233; x=1793109033; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=96lFzuIF0y8LTZ/Xj/gpwS61X9RAuz+hWffATqcJfZw=;
        b=ONkEtMSChaZ/kXr1iIEYaNVrBiwMiySHPPA4GNOuWGjsv2BrWZaUOoJ5J8X79pnhzx
         7xeioSNgPyYCGWj1xPBLR07Leiirw6LR50AaNasrNP9fdE0h+qyR4cqnPsx559blmnCm
         /J8TRgNz/PJHHKEYIHNmhgqbj4I8QUPvUY3njmNyIrRaQ/WgCBs3Y4m9U1tLESg4FdLg
         VHwJR/y8o8iNmGCnvKhfdShCGL7l9Wd13QQBbEg1M22mdwsRPfSXn3CUVUGdQp0noAq9
         +9hlGW6PebbaVKG4L+r2scB6fSxBz2vzVEP8IPYNFObQfW4GxhGEyGD7r1f4zzOCfn+U
         /+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792504233; x=1793109033;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=96lFzuIF0y8LTZ/Xj/gpwS61X9RAuz+hWffATqcJfZw=;
        b=gt6WB8Rhug/yNngKIfx4XB9bOsEoZu1EHxrEbeg/HsWw2ZqHRy3aLsqYuEhywVLqWO
         Bikf7Hl0MWLP+8b1xIWyrfE6qeoUCLwtSVyNWC3Wds8zzU7fEVyoTXUusNwTGL5+yEuP
         Av9bS7KwASiZYVP49ONdAH3hgNjV5WOWAyfLnxSKDCKVHtpJi6i8OHqLz02UdCfRYeGf
         1VN3Iuo7xlJWo3gvkuq5U0CQzB0No3lAx9pTiPbAaj/gsv3zZwBzDkiam5tUA0vQUA4g
         wqZoXr9yg2AoE348oL1cPnYXsq54Cgl6LxH+mVAKxLuoUCYSiZIMAawEPWys4nQ2WNnr
         ozlQ==
X-Forwarded-Encrypted: i=1; AKwUvBxud+LPMLvTsonv+iusgZq0ou383MrPQdDugkPnm/FYl3a6YGdJ5F/Vb1eqEItTVGvQCHGQkDs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKz09xZrKhOnPlST1z+yHFtDTr6QxgX+hyet9cAHd5ztooPRTQk
	0bP8kvQp2yhan4DCe2OINixn7CdYZlfDBR5fYTNjqB0JtWtwTWFouCQS
X-Gm-Gg: AYBFou32m4CKGRJQNX6L4PR9z3hZtUrp9UqwGWDdClzpEuiKxc438Y4y4/d4TSg5yFf
	OhGQIt0W1e2J5Qm96Mkmc7WvSA3Y/tlymyUfiXlcnjIXQMC6CyWqM34m1sIe0abIgBxzcgCHc6Z
	+3NiKeVVozToovjWiXLwgw8jZuOnDMk/ItGpZiXm/hw36cOJ4z11ej2AU/tBInxseoM2khNQCic
	UIfDstfoDU25h8UwIzJiYOIX6cPAVmVa2g64jvwgBhlTe1ooc4xAyrFaD3PDwcqacm/TyTGOtqM
	iWmQH6YrikV2Y9MxNvM366wgMSyTrbm3bOqrPYwHmYAXvUJsUOYco1C9l3KMZStkGqSaRVmCu47
	kc3riceSSR3iEDWEBM05DGieuZCyQ+6kJY7m6Voywgz1t60LzkcnnpRCFpf+DwKK1nrXNpKE9Vd
	8QAntPP+gfmFL2B31D3czVz2DkFT9CPzsn6meR+6uGx2xTN38i1at+78Y7kFeyFrW71VzDRiCxH
	Nj6cyXEZ3RYzkMZpS+nnMrDXlshlcGEvPxknetV4hqKJ84MJbAzKMSjyaoCDAKTZBkKFUofvCYS
	40D5ej3Ex9m/zsrc2GWRCNKJX51HCvmIjk9uFg==
X-Received: by 2002:a05:6122:4890:b0:5e9:5e79:ab3 with SMTP id 71dfb90a1353d-5eaaa954f51mr4242745e0c.21.1792504233298;
        Tue, 20 Oct 2026 06:50:33 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eac20d6aa6sm7205788e0c.7.2026.10.20.06.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:50:32 -0700 (PDT)
Date: Tue, 20 Oct 2026 09:50:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Josh Don <joshdon@google.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1a81a5aacc334@gmail.com>
In-Reply-To: <CAL+tcoBjWDwA+MrjzRapUeAom-4siL-cnXXLQrVf-A4myNRxyg@mail.gmail.com>
References: <20261019230758.2960779-1-joshdon@google.com>
 <CAL+tcoBjWDwA+MrjzRapUeAom-4siL-cnXXLQrVf-A4myNRxyg@mail.gmail.com>
Subject: Re: [PATCH] udp: Add noinline_for_tracing annotation for
 udp{,_v6}_send_skb()
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Tue, Oct 20, 2026 at 7:08=E2=80=AFAM Josh Don <joshdon@google.com> w=
rote:
> >
> > We hook udp_send_skb() and udp_v6_send_skb() using BPF fentry program=
s
> > to monitor UDP transmits. Both functions are static and have two
> > callers: udp{,v6}_sendmsg() and udp{,_v6}_push_pending_frames().
> >
> > After an FDO profile update, udp_v6_send_skb() is now inlined into
> > udpv6_sendmsg(), while an out-of-line copy remains for
> > udp_v6_push_pending_frames(). The fentry program still attaches
> > successfully, but it is silently bypassed for all uncorked sends.
> >
> > To address this, make both functions noinline explicitly for tracing,=

> > as was done for tcp_drop_reason() in commit dbd5e2e79ed8 ("net: tcp:
> > Add noinline_for_tracing annotation for tcp_drop_reason()").
> >
> > Assisted-by: LLM
> > Signed-off-by: Josh Don <joshdon@google.com>
> =

> I actually mentioned this thing a few times before. The original
> thread was from Breno who tried to apply a similar change for tcp
> sendmsg. The fact is until now we don't guarantee those functions
> should be kept noinline like how uAPI works just for BPF prog. What I
> suggested was to select a series of functions in one Doc so that we
> could tell people those functions should be noinline or whatever else
> just for tracing in a soft way?
> =

> Otherwise people would argue there are more functions that should be
> done in the same way because they internally trace it.
> =

> Willem, Kuniyuki, any thoughts?

We'll have to review hooks on a case-by-case basis for performance
impact.

If possible, it's preferable to select hooks that cannot be inlined.
Over limiting what the compiler is allowed to do.=
