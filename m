Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792946918;
	b=zPJ26SNgBmEYgM/CjOPHT/qocGpiz8CGcYc4nWA6D3nKUif1cf1cmBbRvJ3Y/paD4b7r
	 FPdzZrxGMilGLsY8JKfA4y/U+DpFYll+rGaEZBoq5757Pl2k6/U8CZ3V/0o/+vqTDEIDa
	 GT5Or+euc0IKwYz9GUHoipSMS5MueJzTxTt6YUzD+o8Irh9U0cvb2vgwyb19qW+XLQAnm
	 rqt5DLzeM+jg5l3EdtdpJ6zZbKU8oGL96aV6+yywpe/14T8aXFwmh+Q67xx3miw+dS23c
	 35gTuihQziBqhgc/Hq9tpVZ/FCC8WSZ9vXGyP+UhJwfKyC6AhG/+ImlvOszwJq36OPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792946918;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=OQ5OjXs0aIahC9OVKlKWWMFSX1nU2p7OCig10Q5/wzk=;
	b=1RWxHFkKimgPsBdnFtdDM7lrskTpCmhIVR+IOfLMZtBQWZAnMZh/ZCGsY5+Z/H5AMUW4
	 hnIk7CK4Et5hgcScKYI7JClvU33l2Du38E4iRGnPBDL+4Y48k0J9ea1oME7z6WNxGpn5c
	 vc4VA3Ak7qQTkSO3XHIOuZw9caAyhwlg72zS9Sc9HKXaYooFuVWTeH+JnEjIRjMvYKQx6
	 nwaYYzo5ZnX09Yl3zgG23Gbfck0ZdamuU6C+/27GkAjjkE27NM2HYZhpVbkdKJnRYfTHo
	 nulDlWzYYThIqn6awiPZ5eaV7AB9nekz8wpMGwAZFpgqDTovCdA9ONaJBFdCx0yjJYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KYmnvVXK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F35D606A31D
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 16:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F35D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KYmnvVXK
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso6590810eec.0
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 09:48:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792946917; cv=none;
        d=google.com; s=arc-20260327;
        b=EqoHrwMmtoaYTtA1tW4XwoTqvdn9Hbicybv0McMOCWfDIWBPPnaC1SmI2iw9OQx8E+
         bgiyqh46fV1NF+mgxASNb3eJQzkxq8IvFTkXMgbLBFiKryALD+Ix1AUWBrOQHYIXoxP/
         /udO8F2oCebQ/V2S6568/qbShbfqquxbqqNPg85B2xIw5jYI6SM7DaPaDbU/H3taOS8D
         VReowAtSbGEnIok3qIWSybmD+YPvLGLSklW0JkMtRx/VYaaloZKyk1eTBWiHFRsWD2Vr
         bSaMFzD015l8TiR7LwBc1lTOsTgnXPYuD+SkSQKeuUOy6AEzWDRW6ZIDRos8wSRyNcOw
         b8iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OQ5OjXs0aIahC9OVKlKWWMFSX1nU2p7OCig10Q5/wzk=;
        fh=XeKaIULN0wbwbsgpxM6cNWkOQZmFWAPZmxtpZJf2CmY=;
        b=BZ6a2FUKjcCe9zPaSpN+AMnqRwIPHSfbf6SCwO881SDW40hXqgnVaaHNhEUj3gCJVk
         fM46IKp/Ll0owhU1HFAvXyd0qfnkXGDTb17WuuFvGGjfmzpSrmgGU+hK9DlgM3aK8qtq
         7FJoFtmiQSiA9ZbvVdGxXZuHF7JMPKkZTMKw+ED07BLFUwmZx6BCCD5Aaz2J+Rgl8wGv
         gQxc9JgcjjuK2RlS13M27MK2wFXU9nuhtjZuEJyp25omNbPm41zT3E+87E0SCn/+/098
         MngJbE/FXsfrHBRzDY3F1OjrSJFt/kZ0SdAhVgfdJwL5E3Qaa9m/F2TfJnkSpYh7ef/n
         uBpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792946917; x=1793551717; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OQ5OjXs0aIahC9OVKlKWWMFSX1nU2p7OCig10Q5/wzk=;
        b=KYmnvVXKqmgzmzcYvgaBaE2o02vTlgFEhxL1z9bImYcjsrPqSwTb/uT4x98PWQ3Avz
         xmWPMeKQzEN55YHwCXqXnABiZx039OJtIL8+lt6hdomTYYNtNqizDQXSjWavfeHB4LJu
         dNI274UzUkEtefjRtU2EUFZLWxLV8VPxJgT7c+ARjxaBt6KjMYVAPfn8ub2Kd+fi/pKJ
         y1IJO9RgQlIwu/psiG2D1NnGKhd1julDHjPg0GejY/VoWMcUo2X9nER+AnjGuTq5jE34
         pnBaXMrW2nYwKZ09gRlN8+I87/aOlBTdynHQhDr3c3h6CLdyyyerNOEEOldanrfp7vos
         5fUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792946917; x=1793551717;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OQ5OjXs0aIahC9OVKlKWWMFSX1nU2p7OCig10Q5/wzk=;
        b=2MeWgFl/cLQFpmwaT20OnVNsnckFb2mvm2+nZrO7hVmuGiMo0NG7dchJS0PTwhveyq
         uV7DnF0xMWZ2Bxn2A5cGpRBqY4GETkvhFRvSrGIpEh4HVDlPjUXn9oqVIUBLmhkmRdIi
         FkvsL+KwEIvWKIfRnOpinBUcduoZV5ZuXR+faRM+1VXHr91NlUZSEKiX+4d9kJtPRkqc
         BEoZfyum5ez3Yiic94XEGR6ptEzka5Jr7C1prZ5HqZeh7FWBFg2Gn/GPfT98Gt5+eg2a
         1KDGT/6njoVJ4rNwQtuuonHijwSL7WQEnBelSb9mJYOfviWwF0IErqGhNFyI4XIN6xwM
         afLA==
X-Forwarded-Encrypted: i=1; AKwUvBxX0zMKOYFPL7VoWeiwXVu8c6NoyMKYNqMYzPw4OvM5t8VGOBvnzmYt/u35hbjsKce3PIzrAjw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKqEdGCoqnyDmZOtTpBCjBO3rFDptTEOTK8w6vA99Rmwbc9XZ+a
	1eRptPFTgOO4OoRD6VDkavFray8+vvfOduFLhSkbH16M/2oB4fIt4KGAFdVXjqUMA84rL7ng03V
	sHT4vgnK7AcIwhAR3RLrjaJykG2SqQCg=
X-Gm-Gg: AYBFou32uabBxRUYxFYlFMpHgOwhUUl/noQaoC1HSci2HQdnPCfEJUeKMhj4I2xQkiX
	9d611sKQveXwaxSNJxf9UtTpwvqxaJTOZZIDa6T6z3R5M6kQl0DInNC4S2rp/A+R1g/0NICcv8D
	+X6UqFbw9ze1mamOVuPqn9u7xqAuZU1lkO8MwNOjykmKLYHXY4QXbjjis7PtSUdfhBgNM9WaP9f
	TjRIVPcqCHN1pzgGK+4tkZdJ4Y6HtTyOzHg+HaaUQBFYGY9XgFoL8rzd4mL8daFnaieu3ADM50t
	anXnwlwj4idpTeohuLgAXstUFhNx1wf7zyaVq30dL1tjwnb9QfQW6MHvGBMbX1RnWEe5mM0R44u
	fXDQcTv8exyou1jAd+19GULGBHuh2dDdnWzQgKVGWZ6jLQiBmTrdFtrhdPRKeIs1pDjtMfMDHsZ
	MZCKMcBy32aay1F9xp1VJixu8kiA==
X-Received: by 2002:a05:693c:87dc:20b0:350:2a5c:56c with SMTP id
 5a478bee46e88-369e84b1873mr7142255eec.20.1792946917425; Sun, 25 Oct 2026
 09:48:37 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <179287943591.17355.17353179557993329094@gmail.com>
 <at0vzdlVTF8XAzHj@strlen.de> <179288180870.24716.7833838593165388250@gmail.com>
 <at2V3g-B1Ko2x1iK@strlen.de>
In-Reply-To: <at2V3g-B1Ko2x1iK@strlen.de>
From: Joas Antonio <joasantonio108@gmail.com>
Date: Sun, 25 Oct 2026 13:48:26 -0300
X-Gm-Features: AclHuK8nWBBaduAuSBl0zsyZnm0f5QTkQEz1Yhbnl-LnIzySkyTP_8D8glFnwKY
Message-ID: <CAOCBhwFsbHzRuxngYoG3DDOB_KgBL5c0aHvZEVh58Xkeu=h1oA@mail.gmail.com>
Subject: Re: [PATCH nf] netfilter: nft_set_pipapo: skip transaction elements
 during GC
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>, Weiming Shi <bestswngs@gmail.com>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Florian,

You are right, and I was wrong. Sorry for the noise.

nft_set_elem_init() does stamp the expiration at parse time:

    nf_tables_api.c:6860
    nft_set_ext_timeout(ext)->expiration =3D get_jiffies_64() + expiration;

but I misread where the reference timestamp comes from. It is taken
in nf_tables_valid_genid(), before the first message of the batch is
processed, not in nf_tables_commit(). So expiration is always at least
tstamp + timeout, and the sync gc in pipapo_gc_scan() cannot see a
new element as expired, no matter how long the transaction takes.

The "empty set" I observed is explained by the elements simply timing
out after the commit (10ms timeout), and the dump skipping expired
elements. It was not the gc collecting inactive elements. The
comparison with 86b6471e690c was also wrong.

Please drop the patch. I'm withdrawing it.

Thanks for taking the time to check it.
Joas


Em dom., 25 de out. de 2026 =C3=A0s 02:38, Florian Westphal <fw@strlen.de> =
escreveu:
>
> Joas Antonio dos Santos <joasantonio108@gmail.com> wrote:
> > The catch is that the expiration isn't stamped at activation, it's
> > stamped when the element is allocated. nft_set_elem_init() does:
> >
> >       nft_set_ext_timeout(ext)->expiration =3D get_jiffies_64() + expir=
ation;
> >
> > and that happens back in the parse phase (nft_add_set_elem), while we'r=
e
> > still going through the batch. The element only goes active later, in
> > nf_tables_commit(), which is also where the gc tstamp is taken
> > (nft_net->tstamp =3D get_jiffies_64()).
>
>
> Can you name the line in the source code?
> I am not seeing it :-(
>
> > So the expiration is really parse_time + timeout, and the commit-time g=
c
> > scan checks it against commit_time. If you add a big batch of elements
> > with a short timeout, they get parsed one by one and the commit only
> > happens at the very end, so the ones parsed early in the batch have
> > already gone past their timeout by the time we reach the commit tstamp.
>
> Thats not supposed to cause a gc?
>
> All the sync gc functions are supposed to check against the reference
> timestamp taken at the beginning of the transaction start, in
> nf_tables_valid_genid().
>
> They are NOT supposed to check against wall clock time.
> Even if transaction takes 5 minutes: the sync gc step should
> NOT observe even a single timed out elemenent.
>
> They become stale only AFTER the sync gc step.
>
> tstamp is coming from nft_nat->tstamp, i.e. start of transaction.
> e->ext timestamp therefore should never be in the past compared
> to that reference time.
>
> 1751                 if (__nft_set_elem_expired(&e->ext, tstamp)) {
> 1752                         if (!nft_trans_gc_space(gc)) {
> 1753                                 gc =3D nft_trans_gc_alloc(set, 0, GF=
P_KERNEL);
> 1754                                 if (!gc)
>
> > I confirmed it on an unpatched 7.3-rc6 + KASAN: add 20000 elements with
> > "timeout 10ms" to an interval+timeout pipapo set (the parse alone takes
> > ~6s) and the set ends up basically empty. pipapo_gc_scan() collected th=
e
> > new, not-yet-activated elements during the same commit that added them.
>
> How? I'm not seeing it :-(
>
> > It's the same thing you already fixed for rbtree in 86b6471e690c, the
>
> I thought that was about false zap of rbtree end nodes which doesn't
> apply here :-(
>
> > races the grace period just like the rbtree case, but the precondition
> > (gc picking up the not-yet-active elements) reproduces every time.
>
> How?
>
> > If it'd help, I can respin v2 with the parse-time vs commit-time
> > expiration written out in the commit message, just let me know.
>
> Yes, please explain in detail how time can advance during transaction,
> because its supposedly impossible.



--=20
Joas Antonio dos Santos
Cyber Security Specialist and Ethical Hacker
joasantonio108@gmail.com
LinkedIn
