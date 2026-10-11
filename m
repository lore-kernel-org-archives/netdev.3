Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479B53C81B2
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 05:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791696381; cv=pass; b=cTet6cm8as3ewxGJmEId3yd/HGBUdX7/ahOZQibSb1yg9IF2bf6+iIC/0lbRw/PXpE1gsGMgANNFu1kkRpyLKdDF3t+XDZYeuGEYP1QGc+dtKXHPcks1k0GSngujOMnlNjoZiXbT1JO6Wn1Yrh40xIwvEVLU73+LGRfJlKe0xXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791696381; c=relaxed/simple;
	bh=77rZFfgjYBTlmfFxdEKXYN3j8YeaENiscAJklGZpDd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXH4Zu6Fv/hUwg8CD8N0dhK01X1Vgj4PwafgM44nK8U2KyfswIeL/ZOcJLXIoOa6jJ5k0zNsi3+ZBb5NOvaojchZkmlDEwnZeCwSO2lmL6tbu6AnswMHSrIH7UW9+3wEnfBFY+zetoiI6rJN8J/4NOui7UQ8yiB5aiBYcucb32s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQsggebR; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQsggebR"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5350d9ea106so13788351cf.0
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 22:26:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791696379; cv=none;
        d=google.com; s=arc-20260327;
        b=OoSFL+/YuPwnNAGpvuMKvL6wesEg+SDzWLzKPOIdKFQfBBcnMGOOJK4bdK96aslKhy
         vD/+qLKMcyuKdJ/8YPciL7VqmpQEyBGswq+kxJWrtR7GHyN5nRZoqWYYR+ftWilDuiLG
         oA3eAKCpqm9ePtjK8quWyx5K68hoY71VstyES3XQqU3S8SNFZhkC+u67bxz89QEqbw6L
         0B/v+pUL+J48+s1jFonZq/vsMAU8CQKG/vek3FEbteCWl21gWHjAga7xsUkzzoPgpyo+
         Z0IOGc0QoZxj+Dc4KerOJjXLfFvE35ihOuDyYZC+4zfZ3EkJR/AkE/CH/KIzPQj9vPPN
         fxMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1i76vSVcCtW46mgdzvE51Z6MfQ6riiMaLLzExFhy9SI=;
        fh=ZZczrLB7uR7g7k0B9d38976FrsdqXYDF/nKCH7LGcMI=;
        b=iLf1Ob894lf1zDF+5zAPwzJ5bivoLu6/TcpT3rBbCCdGs2VpkO+5Ackdy6zdL1Ry4N
         l5eFRPDVRp1QPW8zjpo/vlxrmkd1olYzt5YpDhxMT9PQAf2nEYz9vb685KRNvxACyiRs
         5Yrx8BfQSyf7hIwLrRLdDAXpAfJjesjYtfK6Q5mf0Z1mfXEb/A5Ec+4ZnuNZ6TTbhm/r
         wtvMYOV82bvowOMtQST5rxr2IMJTSpZWfcchjzxp4sIV9gMZFR4U8sPE7/NlfMvpcnyf
         ho1owZtyo46AwT7z5aB4J7Spgnx4ptDQqjna28OR0HSlt7vgJMM39Gg/GyzU72BxvYvK
         VjwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791696379; x=1792301179; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1i76vSVcCtW46mgdzvE51Z6MfQ6riiMaLLzExFhy9SI=;
        b=MQsggebRpqTvK/77e7pxNlG2SnjQPv6a1RDvxjdT12CIz0G805TMlDiLp1bYvmXziQ
         7/LJz3W9vYfWlg48v6o32owSqc1mcqTbJbXDmHC/v2fGopfuQDi6Yenzgza2tY+8d+xV
         VuaHiBeJki50JmPymrSMbzI7MOYUA+Vmfl2SlnUqhJgx6LrxUX9eWeP5HLf8DwFcnQbz
         g9mMKTg9XxFt4vtJjX5PqMfIA1vhrqR/QceCx37SzUXyLpgq6dr2b1qhDF6yHcUT3Fdy
         vjGXijuZ+UoChOOWjslxARtQVFz3vax9XE0qpsG34CsBh/0kfLg6QG2EH0tzgg518Lr1
         Ux2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791696379; x=1792301179;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1i76vSVcCtW46mgdzvE51Z6MfQ6riiMaLLzExFhy9SI=;
        b=gcBvRXKwwQHyGl9PMeaKyxSJPpfl/FMt85YlViSqxku6L6iO2NRPqQPLkWCQfklzZf
         ms3zpoaHqn7uDnoKXPzllY89icTZUFcad1mUxkjnIKlnGZehL13Otk3A2js358wYaGjb
         yqwvWVqGzpgGLd6pOcaZ6BZwo5JEHJOLIXqLV4KGUsegHliuTV30VcH7ErrxpKxkRyqM
         Z9D1Ol5J0XA5SK4FPfrJAaMiuhtZyvACEBMOOnWXOANOFsMFZDlBuCQJIuO0aDcgKs+S
         gm7F/YC/rcW82sRO7VqgiOIcsUrLNyJ0lz0rOfnLTsJuwOmzsIB9dYyGv1O54gLRIxrs
         eEzQ==
X-Forwarded-Encrypted: i=1; AKwUvBx4vCB/IxV7oiSMUpTkMGDuxRKTt8RMT4QUeaV5Yp8p1FOUn35GKpgynZRsIVzjtrAfVcDqSfk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIgQjkySSfVR5Bl7H0CwZs1H2FJOMhgKzqFQ1m2AvXxHPGyR0lb
	PxTCGUk+o89eWPPGh2E87FOQcrIIcIpDHU7kQv8fsS3WCbC7dVMlYukDo4NJZ9rCKkxLVS2WRLj
	sixP+jNnVhDlP2JF4CCIAzioIKHEogsI=
X-Gm-Gg: AYBFou3odj3RkHA4XdUXr2GSpIXLYtEjkOm0Q8yKKOqg+dyhl/ZZvAklf1HxlFSAt/L
	TBZ1rVzEIQGC26TXoJQ0yaxI+Hj5Y6FAEZX9fz8pmE6zXitP/zFzgWxm2SM66Tpv96CYPQtdwRM
	IsVOlGc02OpCrkA3IHRa/cRz7RAUEfxzj0p6IDwsRVKWIYtID18I/fKxk0MbJML4wud9pQKcVnz
	vkg1/yXHL8TTTmAsOlWveylnn67nqbyQaGi69G8tM6utLOmVAy4JHo5GZoo39ZlXMQg3KIObQzZ
	b9bqysdzO4NUsYONqebsBRl8gJDt22R2jq94tCF76ibpHxU1DjaJwIMOE73NW9m9vsehkUUMUWl
	8S507eLZHjZvWZDSFZOkUtNERh2PO3yFFOX5t2souxlLhphaEIWrEJOkYjShT6X1jWNdC8vHpUI
	Tt8RGGVwhY5zaiFkQCRImO+qm4BrMS0Gf+K6eDofIUFTcQopyG0+/deZiZfWVuigisf8F9rXgOO
	Zj09aU+lS2CmaqZp2XME13BF2G5AQE=
X-Received: by 2002:a05:622a:4815:b0:535:7692:786 with SMTP id
 d75a77b69052e-5359fae3fe1mr113804581cf.20.1791696379015; Sat, 10 Oct 2026
 22:26:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011052006.60585-1-jain.sm@gmail.com> <179169628642.2527009.18099159731266030842@kernel.org>
In-Reply-To: <179169628642.2527009.18099159731266030842@kernel.org>
From: shashank Jain <jain.sm@gmail.com>
Date: Sun, 11 Oct 2026 10:56:07 +0530
X-Gm-Features: AclHuK_e2G4wGlYi2pZCqS6Wc_bIdvLjmkNcLTMqIuPeyyB_aBbCowg7WmVNY5c
Message-ID: <CA+FWx==a6tGvhtPfz92PJa4CxgR4tGNBGHQMq9jEhX5P-4sB2g@mail.gmail.com>
Subject: Re: [PATCH net] tcp: keep the route window metric when SO_RCVBUF is
 set before connect
To: netdev-bot+sinfo@kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The issue was found by manual code inspection assisted by an LLM
(Claude Code, Claude Opus), while reviewing the networking changes that
set window_clamp on unconnected sockets, and then confirmed with a
reproducer before posting. The patch carries an "Assisted-by: LLM" tag
for that reason.

Reproducer: mainline a5ebb76233b7 built for x86_64 and booted in qemu,
two network namespaces joined by a veth pair, with
"ip route replace 10.0.0.0/24 dev <veth> window 4096" on both sides. A
small program sets SO_RCVBUF before connect()/listen() and reads
TCP_WINDOW_CLAMP and tcp_info, and the SYN/SYN-ACK is captured with
tcpdump.

Without SO_RCVBUF the route's window metric is applied
(TCP_WINDOW_CLAMP=3D4096, rcv_wscale=3D0, SYN "win 2920, wscale 0"). With
SO_RCVBUF set before connect, mainline reports TCP_WINDOW_CLAMP ~1 MB
and rcv_wscale=3D5, i.e. the route metric is ignored. Reverting
b025461303d8 ("tcp: update window_clamp when SO_RCVBUF is set") or
applying this patch restores TCP_WINDOW_CLAMP=3D4096 and the scaled-down
SYN window; with no route metric configured, mainline, the revert and
the patch behave identically in all four combinations.

Thanks,
Shashank

On Sun, Oct 11, 2026 at 10:54=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrot=
e:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
