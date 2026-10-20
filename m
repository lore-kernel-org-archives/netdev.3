Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792490824;
	b=S26UCBUKIPHEpb4Ida6spdy3ksepAhDLjZIvPd6wcat7idWNs7L/0V6QoWuMQXaMjVxu
	 v/CrUNmnxG7dzy/K7sSgkySum7Sgoki04oADErLHZi9tK3nadN3+xIgMZ7Z0XR6EXXUIu
	 JybbC2FYinDigbKJpIuJK3bLurygSu9Ph9Kokx54l3Go7FMWgmOR/fntEbzbQZI3cyTLQ
	 rP39CSjk6UQDO4H4YrfL2ObrAN86eT5/heoJYu8dPTrZisJt2dbm/r41ETuKSvjk9kK65
	 rGrgLXNn/0V8znKCAvdxsNc6Bxe2UTHRWaikv83QTCiq3RWuDYElCbb0/mVFfn8etRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792490824;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=gqk4kcmRoMaSTvrG4XMjC0bfnvl+ByKIzfnkUV+Ycig=;
	b=uqWqFB+i294UrHqiSVTYMVKu2XFPd49hzyQmBBpLqOau8pvIkLxMo8gza4IlueuTeSQg
	 jahJ+b3Aan84bSf5sYQJsLPuK4xLF+K0K3o0UjS/rpVtqDF/PsZ6cDgK3QEFKLbEY8uxr
	 RFTP5D0AwySDhjy1fNxCoo4pmF9UzJZtSeud4o2bmJpYBvjlUXCPmBbUYfsa9TLh9HgBU
	 1U7cuII32sYv1EbfsaRCGfgGvFXJOtzB6w2AAqVR/rZ60Qnr3zCmsapqMZ2dXT/5BaVhE
	 CwdM8tdkNA+9wr8tu2HOa3JUFCL7k20SHQZLhZqunapmo1Wu10/yyCz0QZyvIUt1mmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b="O/E3ln4Z";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBED606A31A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 10:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BBED606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=O/E3ln4Z
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a070781f63so754352b3a.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 03:07:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792490823; cv=none;
        d=google.com; s=arc-20260327;
        b=VuvL+zALw4gnYfHQtVXmgd8yazlVGDrJ0B9kcfmL803n/1CNEFOejCCnh8MwmD2rGJ
         8KGYHSHWOgpkohcDd5ixSWmpA05PFqO3aqCZnqwsj88dNLxgdxBwP3zAke7zbzgFCTPs
         JDwy3NNvhh2RRflkRlQpl9Pt+5OAx7wNig9fePCc6eoUqJC2CU1hI3hdd+rYKWpfXw6x
         yZ9cOVwWzIn7Uysn8M+LzQwxvtc3FhB4eeq6EsA959cyi+U8H3YLMgnvP18i24snx1gN
         nm10PmRkNTIIT3yRqQzPYZ1NvHyfB6JT4i+JrNjgMBLYteRRb/1uC0MlMPdFBOlFgNgj
         PJXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gqk4kcmRoMaSTvrG4XMjC0bfnvl+ByKIzfnkUV+Ycig=;
        fh=xmp1vX2ksVRtN/ju6J6bqhuSKfOgjk3q1XA6KuGu+8E=;
        b=srh/rH9NeC7t9o5k5WxUkGWGFt0KE12v+Lry3yn4LoGZLm7Pq+Ta/eEXW/vLYVkUeG
         f1bT68EZ68aRtF9IrvoX/EwbOrDAeQlaJEpUm/I6E6drKBRtUpIoVYR/GNYbmW5i4lF9
         Q+78HOEc1IZU7XZNtxWLQtfPQY+NcExxizzaddSsX/QBUR6Qqhxk0hLd+FOmX2frRbNw
         U6Yv8338eMmJ4m46THx3DBTJkWCV144MB+rjZzFpS/egffvq3WC19jutTFzzROrWl7Jt
         C69haWhCME1wnNSXGWkaWA0RgUUU1V4socdJPL22dYkLRUMhu9+DDI1Wh/O9iahkDE1E
         HVqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792490823; x=1793095623; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gqk4kcmRoMaSTvrG4XMjC0bfnvl+ByKIzfnkUV+Ycig=;
        b=O/E3ln4ZT1QrN8datpby5kBaHVYt1svAKGkJ8Ebe4n83jlGoaZukaTtlldeWViC7QF
         Si2Nxa9hKCxQq02xQFxZ1YIiNIVbLELP2pQb5RAOcZw53Sel87yu2qZ3lR601azbnOA9
         pk+PxlLczu5OO6RkacD5aVueVNKt+6hanQGfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792490823; x=1793095623;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gqk4kcmRoMaSTvrG4XMjC0bfnvl+ByKIzfnkUV+Ycig=;
        b=vy4d+y0NAzKNBk4jit7Zsa4ZJfK9EfWTyuY/pbKObUBYOQHBxv9HnqsAzpg/YPvDH7
         nxL6y3ygKD85b3sI8FnMR63qjF229bzHKaLyEOhjU/U0KZxQH0WfnFk5258fINr5CDEn
         5L76uH1SRxz1rxstPemez/Zq8xF73oAwG+gC8Vhl4K2MVZsjYugpBZ3IWmA6g9xcQlce
         zaL1WM5PWoxA7n5VHqF+P48Fo8hTS70oCWDEXGxNxCB0FK/AJ3vSE+3Euqwfxd77DNmf
         Xko2y/goIitJzDEZDTqnvq3Bsm6sfSfNMD07IDckf0q/uUi8pDnb2BetjHDUNx1wPz8n
         /I7A==
X-Gm-Message-State: AFq9FYKZQ9iCeCdAnDECbM6+uwrIrTg+QzuZBnGVnkp8Eqgwfhi7ELHZ
	hD010WySXv0DX5/x+j5L4rNIBUTd59Exh7RXvWUgmRhtIaFgRJG+jOKXpsK7hhSskcfqt/6mSM4
	04L6MNY2a+cwM6/MACN9QPfo3gAvQ+zExp7PxUETj
X-Gm-Gg: AYBFou2OGbeaUmMreptXY6rFewGa5SnVSNzZfy+leEMzkcgezRC/UoaW+zKy4JxLnZd
	dKJeAVVaUK20tGXp617ngLMSL64Ur+Z4SWujLKEa7Mb5396beKv3uEMcuq29TrBtpCTCSwW3R9r
	lJRX6KasZFg8hvgBtUFdiWw7yfv3EgtddIZAuXWWSWCJdNOizjvKKc9j0Rh6FYkUqiTwWt9ZTng
	coqJzy0IhCQ2aWmtlxDf5JhKeaUgIlUv//4oPFaMQAFBqHnUjcpI43zMh3uQGpbN5WsSxeEJyKO
	+0I56Av/VTtfXPE/683Yej89RXNZc8kYdThVrwQH8Y2GXusphSJCjYlzyhirOtDUCGANAl/qIjo
	UQZYO6w0djTBCI+7XvP1/1sQ+iSLvhqm6vw==
X-Received: by 2002:a05:6a00:10c7:b0:881:fffd:26ab with SMTP id
 d2e1a72fcca58-8a04be37532mr8001944b3a.24.1792490822862; Tue, 20 Oct 2026
 03:07:02 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-BA27.v7.r0.20261019115505@mojatatu.com> <QDISC-BA27.v7.r0.20261019115505-1@mojatatu.com>
 <87wlrdwof7.fsf@toke.dk> <CAM0EoM=6joWtYQdkw0KheH0sEx0r1P7_+6aEt3235OQZSxD9Mg@mail.gmail.com>
 <875wywvjct.fsf@toke.dk>
In-Reply-To: <875wywvjct.fsf@toke.dk>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 20 Oct 2026 06:06:51 -0400
X-Gm-Features: AclHuK8PGEkccFOWafkEkHCeXxJeERy7lXG0VwKRnOb1QP0RMA5crHAy1snL_Kk
Message-ID: <CAM0EoMmd9ojgk9ePsW2=FxZq3Koh-ZS+OhUSAU0YuSCS-szEXw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/4] net/sched: cake, fq_codel: return the
 classifier result to the caller
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	cake@lists.bufferbloat.net, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 4:58=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@toke.dk> wrote:
>
> Jamal Hadi Salim <jhs@mojatatu.com> writes:
>
> > On Mon, Oct 19, 2026 at 2:11=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@toke.dk> wrote:
> >>
> >> Jamal Hadi Salim <jhs@mojatatu.com> writes:
> >>
> >> > The Fix:
> >> > cake and fq_codel run an optional external classifier from their enq=
ueue
> >> > path and then compute the flow hash inside the helper. Have the help=
er
> >> > return the filter's overrides (cake) or a 1-based flow index or a re=
quest
> >> > to hash (fq_codel) instead, so the caller owns the flow selection.
> >> >
> >> > This is preparation for the accounting changes that follow. Packet
> >> > classification and flow selection are unchanged.
> >>
> >> It's not clear to me why this change is needed at all for fq_codel?
> >> fq_codel_hash just does a reciprocal_scale() of the skb hash, it doesn=
't
> >> mutate any qdisc state. So why can't fq_codel_classify not just stay a=
s
> >> it is?
> >
> > It is not functionaly needed for fq_codel, it is more because these
> > two are cousins and simplifies subsequent patches.
> > Note in patch 4 we force the same semantics on cake as in fq_codel
> > (classifier decides the drop, the caller owns flow selection). Keeping
> > fq_codel's classify the same makes patch 3 hunks in the two files
> > similar. There is another reason: the old helper encoded "drop" as a
> > magic return and carried the 1-based +1 arithmetic on every return
> > path.
>
> But you're not making the same change to fq_pie, although its classify
> function is line-for-line the same as fq_codel. I think it's better to
> keep those two the same; you can add the new check to fq_codel between
> the 'idx--' and 'codel_set_enqueue_time()' lines just fine.
>
> > In any case, unless you feel strongly i would rather keep it.
>
> Well, see above :)

Ok, i will drop it ;->

cheers,
jamal
> -Toke
