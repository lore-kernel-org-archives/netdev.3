Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858F1513541
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 09:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788858739; cv=pass; b=Yf8Ubw20dIzZ0Q1UR8V65yX1SDc4jb2G25dxzmcN5OhY9nr6zwp6sUJioIavDHbJSTLnv7ab/bxQ/r3SGc4hZkBOswk7U74NjC07GlQ1Edg5pG8OHyy5QFv0gBp5UIDzRuEsgtIEOpgoyD/9C0yhGdm2z23FvzvXZ5yUmGy2X8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788858739; c=relaxed/simple;
	bh=Ln5N6LgmXlAc04GlN1hKzCJC1CG0QgHSWv228EdYC0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s4jP1wa39INy+eQnEdHvCqc9VylBIqXioz6H98q6QsaRo+Rd14LsPbjimJqAtJQMbKLTdpcQYjfgLFN7AkMq2/D+NoysBnb8P4RoGleLyKRnV9Aqp4NzrzeCfEn6lQChaJe8mPnJt/WpzX3KcMXAvZB/PyUt16HLPwAgHQan4z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=XWHIuzgW; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="XWHIuzgW"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3a0faa764beso29377371fa.2
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 02:12:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788858735; cv=none;
        d=google.com; s=arc-20260327;
        b=BzPNdBOxaLUOfNcj5j99Ksd/1Jtqc19GqU/xOwI8mLKt4IInIbcuFkyDqhRC5QUmHy
         GSQmPQ55dps6eb8ZSd0B14U/1e0P8QLf0x0jLlHfKCSVTEazG0fCJOjC6B4MjD5ZEGLJ
         k9F7EMs1KVVoH+s4GCHK3ccdouDx6wySFnc2vxAhvefkN5+FmdaYJFTcYwjQkj/xl7Om
         HK1FDCKAhoinxZMs/ewQUjAG4Y1Wl7zd3JGDpM3d400iXrVVaWw9MJyMcFdr0J4muEDX
         sBVCMWJJ/izH2jeqBSJcCXZ44b2qhsd9WHx2ylqgbHTu19KFs00YQSdUZQ518AD3LTgH
         mv6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zp60sdfO4ardVW9ZmRnEnuo3Pw/0xpFjf52DftQhuI4=;
        fh=oASwcGSiYVEZW+KRCJcuPpyTtDmi4F+omunLvYCE+Mo=;
        b=sptG1dYSxfGf+Ja61UyL0iGYHTb98NNEd+ko+ZLqB4yKvgfdlN/eAos6KaI71+SdhU
         2GMJPQZfOgQlx7SpMWPEUAVLF5JqO/FaIxLdE99c6nUkC5l5qpN5pBhGy5/C5iertIRn
         INrYUZHMgPpFlwgf+rey9ldOHmKpp1ajWc/MFlzPX+HN8saVd7QfAA91El8vqL9GGOLW
         /2cEltxbs74hM7rgCwd2/9mbNjxsljZJnV/OFKdUX4QFszacukA6ackP1h/OJtG8f96A
         ix1HZaMl50X4eHoI6SugNej6xFKIxqBkfS6ZVjMnTBFzJVEike3sYjwtC/r22Vf14haL
         dS8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788858735; x=1789463535; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zp60sdfO4ardVW9ZmRnEnuo3Pw/0xpFjf52DftQhuI4=;
        b=XWHIuzgWV40PFZ8HPljurhBn5rj4tX5+v4D1AAgPD9oF5RjjX7cGD6VoIM7sUJCYxl
         tapys12u9HlnRNugcNJxHtcaznVRbb2P20a1gUtKD1HxdrYUbfGdscSYNzNCF2pZDiWh
         VzxgqkG4FJsgRK1Py2Rjw77ZKO5xc3XPluYMeH2BmGqFSWx7UFG3XihONWmR2TZYFZhV
         8Ral2z1fkcz6QYhFQTlD6Z9xizHPgRO8j7wAacyjTiheQumt8AdEigf/ni1T0p5gjavL
         MpUn8X/UayPl5CMEvrXDOvmpaY9KomOxEuzi74PHJUROjyhnT01CNBgDIA2UuCuQl0Ks
         3xRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788858735; x=1789463535;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zp60sdfO4ardVW9ZmRnEnuo3Pw/0xpFjf52DftQhuI4=;
        b=h7MwDVwayedUB5IO3g3yAIC4J6n858VbksIDAeR+6bffkH95lxbObq1A3fjfy3l5aJ
         vuyrmVDXbn7BY2Llems8Um6MCaGTaRh8cAiXtdAtShXzEWonvHgxsoI9L4pR4DFqHMh3
         K3dSW6XvB54Vx9yFbK+AyJOrxq29rmgU8q/nkFuaY+14KxOUi9poadAkPQz9XQjj6AcU
         6rY5X3OxER9iss4wwqFFCLVsBwRRhu6XxOmnJ7iIhqXyGjewOt9a1gm56YbtaMXPnLP7
         fts+I8F1aPCAc01/3rC1SBEMb1d5pqOhoPec4PETddvcPu0eZFsWLRSFr1nYpVt3k4G4
         +u0A==
X-Gm-Message-State: AFuF++l57nIgoFkEbhAgxADPQ4CTqXLVLEizeE9UNgtgjQTMVT5iYVBo
	gf8AGEroXVtZPVZ4Cwca9D9UNXd5dRZg9IJMaafqy2g7PJvJzhYmuKrOvGLKwo+W/cesyYdQPLw
	bF0RAjBGNhAyxOvmOrbrD8+T+wGeqfheik7kMWQjG/+M=
X-Gm-Gg: AYBFou07YFO6BrwZVTXvlQo+6DWUPHjnEjX+zSI7UTwm261a0bwttusjX4O6QK5iOTh
	tyVN2TVSWSwHglov/w3h8zpGVxwYzA1DjstBF1Jv1IBXLpkenj4wvDEbcojiAJ7mQFv7yYImE63
	vegha1M+HdWu1nYMTUm220bsMtWjTgnIALpclzpRsKMrYMIwRs7G4B+h4N8cmC250UoDp+vZQU/
	zDnmOGaSG/rSnI892+yZYMV52y6jnjGoOlgcVLLNMQ+LBEIWyrGViFi4kJunjj/HV67y25aVcVb
	tvxAVUiT+JeDtSO8ZqUblb9iEjmIvficyotlZGfVL2Hg81i0iQmlthGGGTR6wsZmAMy0TajCx/c
	=
X-Received: by 2002:a05:651c:2214:b0:39b:2ff8:64ae with SMTP id
 38308e7fff4ca-3a371baa751mr31491061fa.9.1788858735444; Tue, 08 Sep 2026
 02:12:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788539302.git.zihanx@nebusec.ai> <a2bd6f3ed29919a7328363b548299ae583f052b0.1788539302.git.zihanx@nebusec.ai>
 <1502561.1788855907@warthog.procyon.org.uk>
In-Reply-To: <1502561.1788855907@warthog.procyon.org.uk>
From: zihan xi <zihanx@nebusec.ai>
Date: Tue, 8 Sep 2026 17:12:02 +0800
X-Gm-Features: AcwNN1VjbRsYQi4-L2RFvdf4MtUlRnpbC25DyHdWsl-aWFY71LW8z7GWMLBUSh0
Message-ID: <CAANe3eRBFAMdZaUEL_ds0xc2N7jC8gOT1NTEynY2oCQimiv6Qg@mail.gmail.com>
Subject: Re: [PATCH net v3 1/1] rxrpc: fix encap_rcv skb accounting exhaustion
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 4:25=E2=80=AFPM David Howells <dhowells@redhat.com> =
wrote:
>
> Zihan Xi <zihanx@nebusec.ai> wrote:
>
> > Reaccount encapsulated packets against the UDP socket before queueing
> > them on the RxRPC local queue and drop packets once the socket rcvbuf
> > limit is reached.
>
> This seems reasonable.  I do really need to add separate accounting for
> buffered incoming DATA packets and for all other incoming packets (especi=
ally
> ACKs), but I think that can be done after the skb_orphan() point you add.

Yes.  Once the skb is orphaned, that split can sit after that point
without the UDP rmem charge following the packet onto call/conn queues.
>
> > Clear sk_user_data under RCU protection and release the socket only aft=
er
> > the local queues are purged.
>
> Is this actually a fix for a separate issue?

No - it's required by the skb_set_owner_r() change itself.

skb_set_owner_r() sets the destructor to sock_rfree() and does not take
a ref on the UDP socket.  The old rxrpc_destroy_local() released the
socket before purging the local queues, which would be unsafe once those
skbs are charged to the socket.  rcu_assign_sk_user_data() plus
synchronize_rcu() is only there so a concurrent encap_rcv() cannot
attach more socket-owned skbs after teardown has started; sock_release()
then waits until those queues have been purged.
>
> Anyway:
>
> Acked-by: David Howells <dhowells@redhat.com>
>
Thanks for the ack.

Best regards,
Zihan Xi
