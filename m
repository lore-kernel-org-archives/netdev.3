Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0288F39D6D9
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 16:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783528337; cv=pass; b=DGwnTm+f5LRqUQmVhbp1CHXgYc9UeGqAv5KK2hU3uDTjUM3l9yg8wRG7cKe0gEVGSfXXkoh5w77u+cvg2OIVWoHnKrF7WERkQR/aqUOUNaEuk0CNFTksccu8wecR58K3/85hPZaLuarBtM6RYlqI5MQdb+v2xk6DWzk8ihrwVSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783528337; c=relaxed/simple;
	bh=j3aEajN0/29oaUsTwZfKj6TerZXjtMIoVrKFtWWD32I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NNxz2R0GnHjGdhO555LAkyVDcqeSmFIJEV4VxgCWm+b39ghqk4jbbSpaFH/NMBGi7eSycC+giq1BO03DTiUDtqvy8WiCMNwaqKPkdpCv8TjYirV0zN+FIec0yA56KhRmyCU/Tm02cZtHJrWEU550VH4Dyo0NURu5wM7mDHzDxXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YdllqHIt; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YdllqHIt"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c8e2e39easo4849971cf.0
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 09:32:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783528335; cv=none;
        d=google.com; s=arc-20260327;
        b=fXwPmiPZy3LsITLfULi72rq6VWLY8qli+gzzgJCF7TSPTIJUUSun2pr3UxFSaXjkcB
         2raUgUdqwYBB8aYHZroObO9codtwKWe/G0wcZ5uUj3SQyme+2PDTzujtchKY3Sul6x/z
         oRcIL8p7LQPplxiYYAR5111YkJlnR15cGkOuyioR1zGWjcunZ7MZLf/n4ncn+CmLPTPT
         bulc1P0FIhvMzcDRF100ERc6sRoQ2iYnB2SLcVj5DQ8D/TylMbHaxXc2UgX3MLVMnXj9
         X7nle4RZonQedmeg/Jq1njDYpzHby3G3MkAleLSWrKIWcoFPIWfKBhvNXWzzML2JAX6H
         cZBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WUrebOkpLmw90DxZoL4UHWmGrurEOst5/kgqp4Dvt8U=;
        fh=VUCgSZne+KKHfsXyil0pDgah4Ky+0U3b06dsBhN+8/0=;
        b=oDlc+Wn94uMeWuZgJI3waBwLGulfKKf15ZcvyT4Jx8Bok2Y+Rkb4azUWy06OHxy87G
         g9JoQV7Bsyz4wUxz1mTTrvCpM8G/CUsDPkoANJXVSbodxKl5jnvv1NaI8cBLYqS8py4V
         u3PeYINKqlY4UBo3ESKl7sFJCRIPa1SuSksTMgVLGFFxTDuHRrj8tej1WffPV2Po83Ev
         0ctTJYck0jOq/N/IaaRwDfruNzo5RGTs6fFp16vTsCdlWMHx5S1cIxDzjMG8SpWoTpH3
         zWLNwtx/DjDZuUBIKKrTFhEtm3BOU20KMsPWyu5wQesT69b5xHz1ETE28ItmK1tZkFU1
         hICw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783528335; x=1784133135; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WUrebOkpLmw90DxZoL4UHWmGrurEOst5/kgqp4Dvt8U=;
        b=YdllqHItVoRmv+GRUrbSUyQjsN7FpiEFsPz4HbXioUCFfCy03IihrltpGwAuuJ7uYl
         RcmlR1OHAh1a3b4Z5s8RnPa201IlEuQwbxzGVy+qvI7u4SO1yhqAc1vt8P+6PAwdwBLO
         OLee2ASnR0GS+2j4ljMNecWarp3ULx7TP0dJTQfeAwD+zLOAVrYtYMjFru3LHYu/8w/r
         ORA9XXS6v0BrwJJ/+qh3SVfodnJt3FDJTQ64d28fuRR3tiJlwCQiCeR8HLy4C3zCQn2k
         2M5z7/Zx5NM4iPLA1e4ei8o7lh7cznUgzEhVEO5xdE9xPSkXFd8uONuooQKnFd8xQsr/
         Pnnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783528335; x=1784133135;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WUrebOkpLmw90DxZoL4UHWmGrurEOst5/kgqp4Dvt8U=;
        b=R4pEW3QzcTOe+EDhgkEBB/cD7ridcDWfM8xR/gDQwcUZE0Vulndav8tOjU2/x+mcSv
         79nIj5WYiuC3CXwVSHA3qnVIVhPfdBUV/pgUB28zb2rzM+GTTFAM8CMM2zqKeGAPE9Oq
         abzUsBXnAxBVyOZ9YXiXEMUduFNbMRFmfJqMEiFG+cr/9eLsV54ZFTAv7RiHbHTxDR/x
         wNittmn/+UkjKdqp4MrKGE96lFywuEdZJvljvquVQ9NbJ7sCsssUbiExWkbk6mpp+cuE
         UTF5lDOxIeODvae9OszMO00y21VMoInomDQt2ctX1a1l0Ar9m5Ls/DxSxDrPl/pFndx2
         4yXA==
X-Forwarded-Encrypted: i=1; AHgh+RrtdeUXVWM7qN9n0IBrwwc/lXMMB+FJb/43NRGYV5CmVcPy257aWmfyihOKtYg1PrEWYd/gka8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywju76lDITKJ5TZSSqU4uqrZQizIszFE3W9LC5LmeWkGjTZ+Bi0
	KS41MFKVKcFyT1HCxkG3YgyQDnyApaJ5kXUvOypgyO3AQAFiKC5rk6lRhAukDUM5PNUnXIbUf28
	VsTkDsLV6FAZfN/6trzeX5OAjr0GcmBXBKRfuGxn7
X-Gm-Gg: AfdE7cnUpbzPEo1DGQUNfVZcJvaN43D3I96GHn+0FA3hLXz0kqeuYc23G3eEycwWo16
	NGn2m7HhXCPMEOHPuAIAIg8gs/vSOngkRmkZZTHYz7aKYkMGMoUqaoieyBvMAtz7O0XDZBAbh5x
	u1mFMgdMP7RYJGoKJxt/6Gb1kqW1rLRzvjSo2JbqdtZJJBIbQaa1/0o5/HrQvtNQrADIAuI9KbT
	nnUpTBgPX9aUTtF10o2Si7q/b5ogzsLQlyn8lyxUc9EiCiHca1CXGMEFWwp7bMaANsEAgGr4YV7
	nlOeuEDcBrYGEZ13yXedNknsbG3DzIK+8lHbvEqPpRohyyVfmIPePcuRRCswaj9KmWshBS5Y0Ww
	LIFQy+L8=
X-Received: by 2002:a05:622a:610:b0:517:7e6e:708f with SMTP id
 d75a77b69052e-51c8b49bea1mr32469801cf.52.1783528333984; Wed, 08 Jul 2026
 09:32:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708133815.3419465-1-usama.arif@linux.dev>
 <ak5rH-SWjiqR6MVe@gmail.com> <bc16e45e-32ef-45d8-99af-14f088733ab3@linux.dev>
In-Reply-To: <bc16e45e-32ef-45d8-99af-14f088733ab3@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 8 Jul 2026 18:32:02 +0200
X-Gm-Features: AVVi8CfVmy7GjTbj7GHzvYXfQ9HcYkZLmXQ50o7RhyVEJb452ShBm1kuME1IQ6c
Message-ID: <CANn89iLc1Bv_wmKvr_9mtGRM3gL7kgoy2Prr2SgtHY4C=ZgfBg@mail.gmail.com>
Subject: Re: [PATCH] net: use sync wakeups for socket error reports
To: Usama Arif <usama.arif@linux.dev>
Cc: Breno Leitao <leitao@debian.org>, davem@davemloft.net, horms@kernel.org, 
	kuba@kernel.org, kuniyu@google.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, willemb@google.com, 
	shakeel.butt@linux.dev, hannes@cmpxchg.org, riel@surriel.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 6:09=E2=80=AFPM Usama Arif <usama.arif@linux.dev> wr=
ote:
>
>
>
> On 08/07/2026 16:25, Breno Leitao wrote:
> > On Wed, Jul 08, 2026 at 06:38:15AM -0700, Usama Arif wrote:
> >> Measured on a 176-core EPYC 9D64 host running a Meta production
> >> workload, bpftrace on tracepoint:ipi:ipi_send_cpu with a kstack filter
> >> attributed the sock_def_error_report -> ep_poll_callback ->
> >> try_to_wake_up -> ttwu_queue_wakelist -> __smp_call_single_queue
> >> chain to 16,326 IPIs/min.
> >
> > I am interested in why so many sock_def_error_report().
> >
> > That's seems a lot for genuine socket errors (RST/ICMP) on a healthy
> > host, so I suspect these aren't errors at all?
> >
> > Can you share the full stack above sock_def_error_report()?
>
>
> I ran this bpftrace script the host now (results added at the end):
>
> sudo bpftrace -e '
>   kprobe:sock_def_error_report
>   {
>     @wake_src[kstack()] =3D count();
>   }
>   interval:s:60
>   {
>     print(@wake_src, 5);
>     exit();
>   }'
>
>
> The biggest source is tcp_sendmsg -> __skb_tstamp_tx, which as you said
> is not an actual error. __skb_tstamp_tx clones the outgoing skb, tags it
> with ee_origin =3D SO_EE_ORIGIN_TIMESTAMPING and ee_errno =3D ENOMSG, enq=
ueues
> it on sk->sk_error_queue via sock_queue_err_skb, and calls sk_error_repor=
t
> so epoll raises EPOLLERR. Userspace then reads it with recvmsg(MSG_ERRQUE=
UE)
> to get the SND/ACK timestamp.
>
> So the workload has SO_TIMESTAMPING enabled on its TCP sockets, and every
> packet completion and every ACK triggers a timestamp delivery through the
> error-queue path, which is why sock_def_error_report fires.
>

It seems we can not please everyone.

https://lore.kernel.org/netdev/20260526063650.952-1-xuewen.yan@unisoc.com/

Perhaps this SYNC heuristic should be a per-socket choice so that
applications can decide what is best for them.
