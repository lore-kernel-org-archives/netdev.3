Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4D6274B43
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776791789; cv=pass; b=AOtMeVEcUbUccbTKU4IVQFsIgzE7O7mKjG52rq4Jf7if/tEg02CItCTCHwxn9fVOVXB8UubeRaLSpm3s6bB0wJCf/ZoMw7G/RkUKpmx68ECn9fCQkr226fLo6YLAteROmwaYE5asjO0ef55jIXIY1/hXhWsc9MnXdDIVne7ByFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776791789; c=relaxed/simple;
	bh=2CBZ1Rqc23Qaydu6GW+vtGWePFnNGnpAokO03IopENg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nHIndnxHIrhVKQwZkh8sLwzcnkdyE5SEshqT8/bG1feeakXrrn+wp5VXrhvuM6d4hC5IjmG4xf1YXYRIPZCB9TCTEcwkjtY+s5DiOSyZjk+JVwHhWlXNGkXtFHQ2gEV/icqzdPm9DZk8o+ZpbCB5ae4fsBBworVABBHo4pJU9LI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBctzsqh; arc=pass smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBctzsqh"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-479ae363aaeso2422871b6e.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 10:16:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776791787; cv=none;
        d=google.com; s=arc-20240605;
        b=ZHe55cEVJoLzl0bRRAYv0h3L+hvEsO77xecG8isfqYLHtyXMz23NJRK3MIX7RPovMK
         hB2ib8tFeKY60Ubz0GbF65eYiVii6AxCdjNqE2aBsGQaKIUhWTW09PNJqozAsyCgDBQN
         QFZLpczCxNRx7ISLZzltEpPVUO6yxLNvJPgXbXkrMdUa0tYg+cA3q/Wl28e5vcZund24
         LzTfFf/m9pL1ht1zXd8DWca+q7s8tfd4kaEYeSBAjL86SvtFz08pLxuy0PxNN5/HVfrM
         KWbnSPwP8cE9XPuNHUugGhCMLJF5c/2R1YPrQ2oEMzr/XK6NWUGSp5PrIRmMiPZgas4x
         tiDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Fzd73w16DcPSlyS3AsXsVnxBJzGmztdTG3B2VSdjWsU=;
        fh=LmbDLh6Xvbfn6qEkjTNxk1tgNZJ8TJnB6IiaLRe7SpY=;
        b=MZTveqwYxADA7/8THtIDtc/6DCxEMFE1kDQ3dk5UFDOos22Ow/wXsELiu2ealouimV
         MNZMLs9meqAskjIo8pWZGRuNmRma9saSG4UtGSBo/Ib6JlgCPgIsUsFiSoKPI+YttCTD
         zD9yTqp4lUIL8JI8PTyUzCbMWSB86mXTQzHcDRjP/pzM3tTLvvteBTEuinpHrJcdHjT3
         hAL+zHUL3j/yDrEe/sDGAkTbmOzalH1edlFJftAvlJxFhB9KNlQYpdNVHuSzQ+GjH/jt
         LcIlsPhRs2cwtVKLhmMepoXi85mHiV7jC+T3Yka7fTiYVSGq+QmnI03S5lHJH9MaiQYj
         j4Ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776791787; x=1777396587; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fzd73w16DcPSlyS3AsXsVnxBJzGmztdTG3B2VSdjWsU=;
        b=QBctzsqh9lk/nzln/vmCFdXp5lDeqsxWxl0UosJDJ5At2PnGNg9BYpgkDLLWE55KP7
         5KGtBAcefKf3+clua5MaYp2o13glWsUAjLb9nFLjLNifY+XYGxps/a6Seu/GF97WLci0
         BKyZfy5BIaJy//IfgGJCJm3KFftLO5vkU4MpxQASWosd4xqLWR1BoJ5EdHyD+pVL0sAS
         ZpP9OtbTmDXwbLpOVFt2LM+KOE/rtt5hHF0hsm0n3sa1zEJ1r228nw0CZW9CSwyHlQhr
         KXNdXdT9nQ4AXllI3qk68mlIS+QZjHRZZWh39UI7Mz51rt9ogAAzUmFS+utdraDf9aua
         TvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776791787; x=1777396587;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fzd73w16DcPSlyS3AsXsVnxBJzGmztdTG3B2VSdjWsU=;
        b=tQ8UJZV3kbYS45PnaebkCLMlVhKCmgqCLEF/xNYFbsyZPBlyhuUDnWFAX3DQMgrzJk
         V8+D6ev+WM+FlyLu0iUNVRwfLwhyOCfjWTlVLYSqSgnLr/nl8Koo/zGnswh/WqmuPIRI
         Ty9BTzmVqimSYiDgFjm+KCFscXF4ghu6tnVJl8WgOBsUL/kvXq6KepWOkN0mTyBeVDmw
         S9F8VczyyD44TkSYlEUGltr9BQt0V292e92TUUHrDAR/A7arjBDPMtzf+vxV1VMv84qB
         s9+8m8x8E4eQ2l2xJUhy0wJYPY4/EhyWe9reFzIGIxNfNpoz9/rdqF+Pxah4QdEGdN0p
         FSIA==
X-Gm-Message-State: AOJu0YxCSO3o12rkj9VQIp3ERFU03RUgfF+vW3SUYDv4Dow/U6Z4FsAG
	uZ54A9RtCCRC+x8kybg8dyHLD3g0GinSIYu3x15fN7a7ozU+AV6K86IT79kRR7yr3XQ/c0bp8AW
	py0wNkZcMDVyLKO09GZVwX4BjeWSOzTg=
X-Gm-Gg: AeBDiesVJskrcxzLjCfcAcaJRGUKeMFBBplyTdL5MrlE8Ly4YNkt+2LgB1tLZccFAEq
	qJ+CCq+4xVCy9TgW4pcqlVf/cRcWkLHoeSl4YJGonQ6WJlp1d/+TN2TejWBViRPxS9DIt17o84y
	j7ZEIiMbTOMt99O4AtYyZb18lau/SjxnnVT3yb8If78BpMDxKIOA/6AjNDuDi7PG8bu2bDrZT3l
	ir/Oh31mfOjUZnS7PCCwe2uvscGb2fEgFh50hE0nWm9bZNsAMhlaptFhzOGU5i3wUaCbAb1RTVn
	tY/psr0y2NZpcLZLUB1mbMiZDraPYC891VJuBeXz4P56RHenA5Zad/dMB+4=
X-Received: by 2002:a05:6808:2f0c:b0:463:a42c:503a with SMTP id
 5614622812f47-4799bf4bd21mr8436947b6e.14.1776791787044; Tue, 21 Apr 2026
 10:16:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421152216.38127-1-devnexen@gmail.com> <e190409c-3dee-4de8-b1a0-7867213cb801@kernel.org>
In-Reply-To: <e190409c-3dee-4de8-b1a0-7867213cb801@kernel.org>
From: David CARLIER <devnexen@gmail.com>
Date: Tue, 21 Apr 2026 18:16:15 +0100
X-Gm-Features: AQROBzDqbD5N-Y5TdVq2TaKl4j8rp50eNk6JIIFOT2auU5qIfZqbTrQS8OuZX_k
Message-ID: <CA+XhMqxB7dw-wSiuBvJ6e-s2aoDA84MHeUGA3eHSZb4EHpzpfg@mail.gmail.com>
Subject: Re: [PATCH 0/3] mptcp: add RECVERR and MSG_ERRQUEUE support
To: Matthieu Baerts <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, martineau@kernel.org, 
	geliang@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks for the head-up, cheers !

On Tue, 21 Apr 2026 at 17:07, Matthieu Baerts <matttbe@kernel.org> wrote:
>
> Hi David,
>
> On 21/04/2026 17:22, David Carlier wrote:
> > MPTCP already advertises IP_RECVERR/IPV6_RECVERR as supported, but the
> > parent socket does not currently provide usable MSG_ERRQUEUE handling.
> >
> > This series wires the MPTCP socket up to the IPv4/IPv6 error queue
> > paths. It propagates RECVERR-related sockopts to existing and future
> > subflows, makes poll() report pending errqueue activity through the
> > parent socket, and allows recvmsg(MSG_ERRQUEUE) on the MPTCP socket to
> > consume queued errors with the parent socket ABI.
> >
> > The series also handles mixed-family subflows by applying the matching
> > sockopt according to each subflow family, and avoids silently losing an
> > error skb if requeueing to the parent socket fails under rmem pressure.
> Thank you for this series!
>
> Even if I agree it would be good to have full MSG_ERRQUEUE support,
> net-next is currently closed, and only bug fixes are accepted, see:
>
>   https://docs.kernel.org/process/maintainer-netdev.html
>
> pw-bot: defer
>
> Instead, I suggest switching the discussions only to the MPTCP ML if
> that's OK. If the CI is happy, someone will try to review it over there,
> when time permits. If not, please send the new versions only to the
> MPTCP ML, with the 'PATCH mptcp-next' prefix, and ideally on top of the
> 'export' (or 'for-review') branch of our tree. For more details:
>
>   https://www.mptcp.dev/contributing.html#kernel-development
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
