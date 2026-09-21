Received: from mail-lr2-f35.google.com (mail-lr2-f35.google.com [74.125.230.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D713AEF46
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 07:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789974643; cv=pass; b=OQP/f3zZRY01gf7SeLmpvKl1/QbCfEcOxHqrGmAalQ3lmhxb0Fxd8UEQ7ZBHnbMsaU6i4Yov6musJyVC7prODwiUYBgeWQQ+GVgjiWp4lk8VujoVDJtoiPKM0+fHfKG7/M4VxdBb38dzygI2eiyj6RQPR9D5s+5BuktwJUq989k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789974643; c=relaxed/simple;
	bh=kJH7+kos1l9lkpvaZyjlUUt9NhEpQOT2pMMtBb2piIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iua0+vAVp10erPWO/n65wxB29Ohi/rp2I/eKcC8vHO0MqLZDg7GHupLcbsLbDHVV1IjcPTY1XpI2qZzAfUfOnJzZTLV/Jrz2OkrP1Td4dD0+Pe9vio/ZQOHLqnzEqp96NwVDG0WR02YTMX51cUfz2XogWgPkAk/tCvZrZxytHoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=Hb/5K9Kq; arc=pass smtp.client-ip=74.125.230.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="Hb/5K9Kq"
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a49c068e85so22676121fa.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 00:10:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789974638; cv=none;
        d=google.com; s=arc-20260327;
        b=cbjtRrpCiGrviblTPLiNL0paTsbA097D0kNno6LXJI9Ets6aPHx7iErhdaVi7USxdZ
         qXTTmP9G1B3Cxk4Ug/E7EltizqVfo3eG/e8keMwWW83p7JtK7b0ie6tdaeUGU2stg1YN
         aYWLyDojMBo6YezeKH+vi9CAdNiQgBgDSG+0YUq2VsaSFRMQJD3ep8w5WNZXMO0+9y6z
         8S+4M6pGEibV5Lia0oBY9x47yaIxKuyoul236JLaEhRs1rR7C/Ajo/GbCFHXwLiJFMlv
         DYjfkcgH9S9B+/Q6lhMdYVV6Ni7WY2nzGoatcarHuLlbMTvSyYdUzeEh9tOs+UbmCIOw
         pZHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ohcBhfXjMZ0w/piBj8Wfzyl/Cc0Gtqk0dL3r6ReUuIg=;
        fh=C0uLJ/T+vscBLk7upV1T6OOxGEs2GRYKwncc+LIiOFQ=;
        b=Te7S/PO35hvMks4ElBnACoTwSKwao8V1iFPIpXXjOHJDF1X86/qcUNI4bPaHMl7009
         //mTVF2Lyj1vJm1UQ+71Lsm5VzGabOfTHEv+xG9lBYAnv2Dj/vEXQ9XQL2ixGlrktqvb
         LZDmGSphUKvPD/xmZ0y2dQMNZTlCRneBtQjvNKM2UIJLA3noopxs4FbyRHQjUTd4MxOX
         6/RWdbkoNDHZLc4sPwZEpAieeuICjgsmR/UJ1xpyJ3GB/n8oFviOtnnRQWdIsiVw7bv0
         FYNYOsXPSctKeoTOHl03HkvJJO7i+ZdPD0zL5yK30A8psRTfpUlY2UT5EwyO3cl0CxyG
         qY2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1789974638; x=1790579438; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ohcBhfXjMZ0w/piBj8Wfzyl/Cc0Gtqk0dL3r6ReUuIg=;
        b=Hb/5K9KqMJ3aBi2GtHACmHMerZlDcswpnDm0o6VCgfQNYkS51BtgBLF/vzt5rS9WD5
         RCYM6xRGh1iUJpVeGwJM8qGnBh747L3cHn1P3aygbG3GFjLxe9mCKoK+eNZF1SsfxP8U
         sqXF3U5vkCzbLJl+zHiuofQ2CdNcPi4Nn577x2yti2l5TxTXttPjKz5ESWApzFFvsDnY
         LQK8CAbU6WFrvJd1pYQ2OQkDB+6J99qvYaq6NDrQESh2mjN4JXCxkTIM+UXwqS1joo/Q
         OqVodN9Eiqw2N0YXKJis5u8XS+1FXZKSo8bKDANYcNzuACGASmnmPQhowBvu2f9f5aap
         SjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789974638; x=1790579438;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ohcBhfXjMZ0w/piBj8Wfzyl/Cc0Gtqk0dL3r6ReUuIg=;
        b=LmE7+bDrLOzgOPDidlSCtwF21B+tmwcYhZuc24MnbGiHaJX/dW6k7svs6cLbW3a1DA
         au5MCCmyL4otB9AzI64YQPeBusMFSZ0HKdpJxmv7WSiravJFU66+9mZW9FvrQJvN5lBR
         XZtgCKwllu9+TXNYes47KWrEmjqfmZ1ncp8nVwgtvy+Sa9bHoh6ArjWeyZM2Mnx7KN8A
         8OdVi4zYSI7Ax6nYeO7FUp5h/yMX32aZ9/M8GQPYYxaD3Os7WZ+TiPAxXqpjwdcx+B1R
         GRXxFO2Tp2Rkm0JtjjFTstDX/MewN37YZSbxUn2oSh6qgW0O7wcES2Nloag8EmYMQ9Kt
         Cg8A==
X-Forwarded-Encrypted: i=1; AKwUvBzGfjM0Y8lT3XQZtTBxdktIdzUvy1P4RxM0hIrhmhrB3vImUIazkhoc5sVYZ3WUzKf7YLSRTmI=@vger.kernel.org
X-Gm-Message-State: AFuF++nMOzLLZPIJpFf3lmJzDW4MEvwVBvcocb8ISLYnHU9QqofdWpNw
	J9heU1AZY7dS1xchsPBIJ63bdkky7zHR8BZHBO0YHIfF+fZNTeox0p6xbwTHBd47Aw1RALwoY6x
	vA48l3NNF0atDtNCfi/rzTD6zILx/8hXPIsk71vDRT0s=
X-Gm-Gg: AYBFou1loIQdsLARq8dadLGQr992y104OAbcxjEg95rl2oo5HEdFiZX1TGJtl9eua9F
	bC6+ajghancAS4JWPEQgKY4ZLznPlUxADElcZsZ350qaoH+WlIX1u1PPjdRPe5QGXFFfz/v/SIl
	wXk8Iw1bFTQsUQsLKivTO9T4NqBLB2E0tXZkPPW6S9X8SlKior0Lcl26SlkbhlJB19IbqQ10sDp
	GCBH2bDBDATf4VOtpQU/gTe81DgvfBwVOBFKViIKLky/C1Iuy8gaViXCJCJw17D6eXHRNY8fQwf
	XrlJTKsWy+cBzBgK4sTmibLr2v6JAsU+kzxCoyA8BvFF5Vw5kC7Rmyo/nXOJzyV4Kb8Fbg3oDYl
	LE6GLCsb5Uw==
X-Received: by 2002:a2e:a98c:0:b0:3a5:b187:c7a1 with SMTP id
 38308e7fff4ca-3a5fbf0215emr21570991fa.9.1789974637997; Mon, 21 Sep 2026
 00:10:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917030301.5502-1-zihanx@nebusec.ai> <178996076640.2160803.16028832049809238100@kernel.org>
 <e1efae34-24a7-3b24-22b0-6a838aa93d52@ssi.bg>
In-Reply-To: <e1efae34-24a7-3b24-22b0-6a838aa93d52@ssi.bg>
From: zihan xi <zihanx@nebusec.ai>
Date: Mon, 21 Sep 2026 15:10:26 +0800
X-Gm-Features: AcwNN1UcIHa_FP3_g69sLth774wwgDQwaw2Ruj6A1N9ozW6m1CE6EgqsboVPQSM
Message-ID: <CAANe3eSYSxU_OhSSsp8aML6XH2a8qm2+nZSmdJAzZ6Q6uxwN2A@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] ipvs: avoid stack overflow from recursive
 connection expiration
To: Julian Anastasov <ja@ssi.bg>
Cc: netdev-bot+sashiko@kernel.org, horms@verge.net.au, pablo@netfilter.org, 
	fw@strlen.de, phil@nwl.cc, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 2:50=E2=80=AFPM Julian Anastasov <ja@ssi.bg> wrote:
>
>
>         Hello,
>
> On Mon, 21 Sep 2026, netdev-bot+sashiko@kernel.org wrote:
>
> > Thank you for your contribution! Sashiko AI review found 2 potential
> > issue(s) to consider.
> >
> > Critical: 0 =C2=B7 High: 1 (1) =C2=B7 Medium: 0 =C2=B7 Low: 1
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchw=
ork
> > know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> > (one such reply per series is enough).
> >
> > - [High] ipvs: use-after-free in ip_vs_conn_expire() due to timer re-
> >   arming race
> > - [Low] ip_vs_conn_del_put() (net/netfilter/ipvs/ip_vs_conn.c:1333-1346=
)
> >   keeps its old comment "Try to delete connection while holding=E2=80=
=A6
> >
> > Pre-existing issues:
> > - [High] ip_vs_conn_del_put() (net/netfilter/ipvs/ip_vs_conn.c:1336-134=
1)
> >   cancels the controller's timer, drops the caller's only reference on=
=E2=80=A6
> >
> > --
> >
> > ipvs: avoid stack overflow from recursive connection expiration
> >
> > This changes ip_vs_conn_del_put() to return whether it managed to delet=
e
> > the controller's timer, and makes ip_vs_conn_expire() loop back with th=
e
> > controller instead of recursing into itself.  The stated goal is to kee=
p
> > chain cleanup synchronous while using a single stack frame.
> >
> > v1 Link: https://lore.kernel.org/all/cover.1789110326.git.zihanx@nebuse=
c.ai/
>
>         Zihan, IPVS has conn refcounting which does not look
> natural: the hash table has reference and the timer callback
> has no reference. Let me try today to change the refcounting,
> so that unhashing occurs after last reference is dropped,
> the conn lookups already use inc_not_zero, so we will try
> to consider the timer_delete as successful stealing of
> the refcnt from the timer callback (yes, the callback should
> hold refcnt, not the hashing). But first let me try if the
> idea would be successful. As result, your change should
> be small as before, we should be able to delete conns safely.
>
> Regards
>
> --
> Julian Anastasov <ja@ssi.bg>

Hello Julian,

Thanks for looking into this.

The Sashiko report was generated for v2. I have already sent v3:
https://lore.kernel.org/all/cover.1789877273.git.zihanx@nebusec.ai/

I'll wait for your refcounting changes and then rework the iterative
expiration fix on top of them.

Regards,
Zihan
