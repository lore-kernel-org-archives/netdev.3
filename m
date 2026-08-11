Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3183BE172
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464658; cv=pass; b=RQg76qxHk59CScgBXV7IsyKLdo+B1o5Bq2LX9Dw4fgV5/3BHLZpsfnBeBvdGO3+sH+E81XxlZms2vHvVGcvacnOLMaoKQ4V8Nj/PyZau4e/uMKeVAlOkkFauPRlwrbMdFFC2sr+80dk9fVn6Tq4WlUch5cAyOKslPz8ZGQRE4Xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464658; c=relaxed/simple;
	bh=vuoLOK/rnYLKL8Mx67lQ0cuVc/C7UhzCs9iR/P/EQf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iU3r01ERrNl3fTpvNeyOKbT5r/peFsN1zE9xByTWWvh18yYhisCVAufese/ObKP7ss73Qd/joZ059j2sJS+9wh2mUyalRJpOsWgn4/CD/JVVN+sA+DzP3HZWu9Qz+9DknoJFRpDJzD+NfJRJ+NNWMWQR1483X3K9X+i9w8GwGbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=COQSUHpt; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="COQSUHpt"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so1497465ad.1
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 09:10:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786464656; cv=none;
        d=google.com; s=arc-20260327;
        b=rTmX/tMHO4ZIJ6f4jb/ZRgyV6aEocadMwdl+w5v7cQCf7nPnn4WFY+9fRB1wPx+ZAA
         MIhykvx2XvIlrZBD1cCDPpwvae1qw04dQuGCcVuQ3dtxOZbApidsMV23BMuVNOQ8TVam
         Se5xuFYHMC3XNgDSIrcSkyo/XX4sdh+0TKSCwH+vdMgjOdVjtTPRqPun9YOBGCd8Ahfo
         F02uW3lClSzIKiA+OvMF/vsiB4mXoz1fz1yzKTmIvXV0IZ+JmO48UZ/K35xTtSISS+yQ
         JmWv5QXaj3qHrpOKMyFXlfo8ChgOI9Nr0ZecWKRPw4BQk3SiB9/UmzM/2LG22dMTYJJW
         FZFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oR6Lfn10OI2dMXCG9wKlSbygEMyQ0mqk7f3Zkb4+G84=;
        fh=mbPXVwsxSyhcVeUFQs5uePk2gwN4DQITrm3CWJW6sTQ=;
        b=hPz00oa+7+4k1KkNnNRE+XYTSzEk2YTewU7SIbKH2brW7Qkve/Tp7oHlYzwjIRZo7c
         i46AwouDtSocbkMAuPjUrrNr+ruxxcyNLVOEEjLkAJKqFUnI0gB3/9nS3Efqva7n+Wld
         gO2lgOfeZdQpsfNKQOBgfhLEg1M7HpKoNORf4D4ByzfBMAHjKj09DLqyZxHPMYrLx0SD
         RJGhfjLJzPjU/2CBsY7NMiEyxre3omhrq/9cj/ZpPi5PXdJJZ/C3XfeCY9Yb5nxikqyb
         fxupWzNSFlp18SJ+Eb0fvCLHQVEZTvyWv5GPhhWCbGB6pCem83+z6jusldGo93sQT/BT
         ih9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786464656; x=1787069456; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oR6Lfn10OI2dMXCG9wKlSbygEMyQ0mqk7f3Zkb4+G84=;
        b=COQSUHptmpmqLVucnAPzUZCEpWOZXXXLGirfhCPmyenlPim9HPTL0cKFu/8dp+JiSD
         WSY+lIPBjqc/pGcgk4v/2IHQEPJ22eX3LnBFNbbV2j7BFGyY9xtFzVjivrSMH5jqc+dh
         NhNxf0r0WhVcsG2lhwMhSdUDtyC91feD+S+djqOjFgHDnUc44O/NI5kcOG4TV+SxpQXy
         DZ7dsoSubf3jE+Mxfkrvkmj34KhY9CxP12aKoKtrzwMpO+9KWnTkmKQMQouVCYEWiwO9
         VVqJc3dffkHJRS3Pes/tcP/0czyATdwRnOY6GaQBwedGjui7Rpyy67Bz9j6M+WOyMBYx
         hzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786464656; x=1787069456;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oR6Lfn10OI2dMXCG9wKlSbygEMyQ0mqk7f3Zkb4+G84=;
        b=JJiuZ8817Xuy/u9Dydv5NxTUeH2cGTbXieruyczMa04I7CgcBe6+7I691ZDxkL5wMO
         6hNXPpVgWdM6SGTk7s+Ca6Rj6bjB58fUacFalPJ1pXcbOJ+9W6Y2y0ASLbfBG2E0xn+Z
         e5DlmHXdlmpsYafb/MvUShPHQd7Yvtsp1b/hC9THcFHg/G7175GbtKd3qhg9WKE5ZsVT
         Fg26lLj51hTwoNENp6DIpAsZgSK79hqWnvqOMQOwSdXInyOgAxLOsfsuAPCNz3bgA3Cm
         fdUsYQmbGwCEvbL01+gb5+0+p49sva/Bnxp5W4Wu+Dnp9jX4KCxqb0vhV86Wx5YcqhF8
         5t0g==
X-Forwarded-Encrypted: i=1; AHgh+Rr6jjS7nm7rNfjQfI8v1y64dKGbZMnu223LW68Qrp0yPKgFZqPuRuyke+qZRRwkywEAToWL6Uk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0G5SaDBaTy3YVNnJ3IGk9mopqIKxVD77vePPcq0B19QBl12qz
	yH4daSLqxXTHoOdBw4c9MnHYrX+HgrQME+TW5VbFb+JXYn7tNOAxnh3QJgGg0pEJeJ6Syk05hBK
	Sx5zvI8b9zW/UeQQvW4MTIdixN9WyalnPikaMwPFX
X-Gm-Gg: AR+sD13R8kew127z021iBNGrO3J3dne8hcQorNL1NWXXzicczHtkX/IYHskLJ4T+x6k
	+ADL79lpV8QdDXqZzOLSz6GHwXxJV4EihiQybKgh2zonUjj280i6b43WPFym8zeXpyHuA3TB8Gs
	/6++ethmBMgxLOi+4G+IbPgITeAgEgi9LBd/aGpmNiwihVeMRbRYuwvFgPfO7XNU10h4QKVSoxz
	6EDd5P4/lkm7Q96BDQrOAwsYbcbqzeyhYjEZvoS5sxQOyUslwOQQTxFaOjQtWx7Mv8jpBvxT+HN
	TBvFFzAlKTVFMox06gKOEXYvrM5H03AhU13wwL54FeIiSRTd8/s2rdRbbZW+GXWpvi1fl2LyDlr
	ryEiCa6SKbUpSe0WF9uWLyUfcGT5zHamGINclwMpuSi9k/yQaI82dqJSV8LNB19F6WO5eLqiOOs
	WTUrWoAEpQpoDGITj3lQ35BK0=
X-Received: by 2002:a17:90b:2747:b0:380:f34a:6ff1 with SMTP id
 98e67ed59e1d1-392ec673319mr4988797a91.17.1786464655648; Tue, 11 Aug 2026
 09:10:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811022448.116235-1-kuniyu@google.com> <20260811022448.116235-9-kuniyu@google.com>
 <ee6e639c-558c-4538-afdb-3ab6c1c3476f@kernel.org>
In-Reply-To: <ee6e639c-558c-4538-afdb-3ab6c1c3476f@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 11 Aug 2026 09:10:43 -0700
X-Gm-Features: AUfX_mxQ-eWKgCcOc7LkSBADPKEU1AcWofnuzPewaL16HDTe5JFxHaWkGGMhxqA
Message-ID: <CAAVpQUATfZAif2brwjaqdWTH_JzKzRjFdZ+Yrj07TrTkcYXQWw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 08/15] ipv4: Replace &arp_tbl with arp_table(net).
To: David Ahern <dsahern@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Elad Nachman <enachman@marvell.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Boris Pismenny <borisp@nvidia.com>, Petr Machata <petrm@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, 
	Edward Cree <ecree.xilinx@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 8:42=E2=80=AFAM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 8/10/26 8:23 PM, Kuniyuki Iwashima wrote:
> > We will allocate per-netns neigh_table in net->neigh_tables[].
> >
> > Let's replace &arp_tbl with arp_table(net) and remove extern
> > definition for arp_tbl.
> >
> > Three notes:
> >
> >   1. mlx5e_rep_netevent_event() and nfp_tun_neigh_event_handler()
> >      have code assuming neigh_table other than &arp_tbl and
> >      &nb_tbl, and the part is removed as it will be false once
> >      per-netns table is allocated.
> >
> >   2. prestera and rocker uses init_net because they set
> >      dev->netns_immutable to true.
> >
> >   3. mlx5e_tc_update_neigh_used_value() dereferences nhe->neigh_dev
> >      in trace_mlx5e_tc_update_neigh_used_value().
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> > v2: Add note about mlx5e_tc_update_neigh_used_value()
>
>
> Seems like this is not a bisectable patch set. References for arp_tbl
> and nd_tbl need to be fixed up before switching to per network namespace
> tables.

It's still bisectable, and this comment is just to make human review
(against AI)
easier because Sashiko keeps asking "Is it safe to dereference dev here ?
previously only the pointer value was used for comparison", which is false.
Sashiko just misses that trace_mlx5e_tc_update_neigh_used_value() does.
