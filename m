Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793810805;
	b=AOPjyOQJb7Amgz1QW0nn91u6vINCPmoz4+XMp0+pMJHjsxEI2Ft3bni+dNyaqzseUmP5
	 XnqW2goZpGyJxdqdBnA5X8/w3Dx5gglInMjHH2oOQ+Y/+rFSxur3HNo3bVp9bIAL2lITL
	 ww8qYrVJMr1BDtRB3LHjYX8nfthnDxO6zrpdw+1BAuCe3iwj3kvn71gMWNMyY3QX1pbYx
	 6Xv8Su8DqpfKs+0RrEkQGCU6JtR9HyZnJbTJO3wBwj4duLCqiIFjafLl+eDSZDZ+YhNKF
	 kP7klAHLV2tZQSs10/Yf3PoxlonnmDKdPtrXxcl6/gM62C64f3z67H96tjEhCsFZqfA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810805;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=xW8Hgn0qnZIeMrCgDDMj8in7eDtwrUG9nG8ML12gUO0=;
	b=uglhrcif0yvOsCvSA99vmbsDUmTeIYr/mfHltShB7eRVwpaP6P1SeTxkixVMoggBe8gS
	 GjmpDOSbZKU56kwjkPxbrnpkgMApcuYgbiAHEHnJgC/JxzrsJwdHhbXMWWV1masikWLfH
	 kfCSDnWQVGpGXc+CDirTHr+Wrjj6VUhiMFNhg6mYZMObmXTKDjUBckgwCVqK6XoRCa1Sf
	 FjC3CNGsgH9ie34ITL0hVpHFbCyf9MCp1D94ZL8NPguLu/XndRWf7iRIZ69wldT5bu8rp
	 kakE1j4wtR4PIPjrjWThAuABgS2+SQO418rlchfb24kAKGI3yigkdeXcAdlxlrmuifg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y0e9JUYS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0194C606A328
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 16:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0194C606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y0e9JUYS
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso7158825e9.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 08:46:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793810803; cv=none;
        d=google.com; s=arc-20260327;
        b=mM2xDUjQpYpojPHxeDWhWclpjvikcgRgqbyW/GgFT2DKUQaKbQzNYw7r5DFy5DF+TA
         ACD/zOxdthnl/ZRQEGdLMo/SeGMoNp77XeM9VuQCBJhjbXH5yfMvXcrfjR/6oZLVZc1i
         5obyeymM6IVxJOy/KGyN8TXcT8t3uVwxs+61N/f0qRLyPRORTvuJnl493XasA+Ox6w9K
         Iz1omFaD6SzEW9EhW3mnzD9b5a2OKJifadoVZ+EZwUGsFcLTTj2vgnXBo8duinC9X55Q
         RhcPyhS4TTQApejimo+yeN0pzewQU+tD32SzFg2MNFbbbSMYmy3G6vMAvy3FSlLUADwA
         tAMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xW8Hgn0qnZIeMrCgDDMj8in7eDtwrUG9nG8ML12gUO0=;
        fh=GJDOkJGMPhVedBW4znRBBLZnIkPYpiu96hIit20RvTE=;
        b=c3+0M6UfvSd57ygk6us8C3Q0Zkni/C2Slhob1xBkh709+M4xnfTxn9I+qxMh0ee50o
         WL1/rMv4agmoGd+ENHUGU8QPOWBEsJ9TnlPiZb8JUPNx7KtItv22nvFFicbXUSngCTkV
         Qo71iyQnSQhV78LQVzM73TH74PUL0onxBrr5GYyPvvqp8B8rtPkxa+of2TtW9KK2JOr1
         OYaWyIFqRzrtPRyY7rqu8ugdwPRuc7vLFhD/1Zx3t+Rso/D1oMMHZOUb0NmXtEbZP7k0
         wS5pla19z6I6j67Ze/v1wrIthmKXsc8xX3GJiuRCz3vUdSt85nURzBvMypha1JJ8Vd+H
         MTTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793810803; x=1794415603; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xW8Hgn0qnZIeMrCgDDMj8in7eDtwrUG9nG8ML12gUO0=;
        b=y0e9JUYSaUDBVvZ2e4FCtN4PphH4PhbUxTOvAqu1Yiwdw9J9JEw6UnDYeYAIMwHoTK
         q45hOs1zbGNPwzM7UlU4DiOgI74AA/XdJIvYogHT0fh5TuFGeS/LR//NOt77ARAngyAu
         WAann/dvzBCgMG6387hsiEo6pK+5LVVZfNQMSvVytJikApONJ/IL15cXX31eaVWe7AIv
         GAt4bl3SsPssyfcWFsBOdl1wE6a4OXeb2kaJ2DszQMhKhsXtRMdzxW9iEwuDg4EPXyxa
         bENBVm0zYvwx4MSWjeFlrTVgcVgxSFk/F2tH6ZdOOpiHJt0trZf/zdgME6VyJTj+OAkz
         F0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793810803; x=1794415603;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xW8Hgn0qnZIeMrCgDDMj8in7eDtwrUG9nG8ML12gUO0=;
        b=0QUB0crTBAYlpWnNybHyU+y9DGWqA2h/C7edZSSvIGI6PMmlTweiFk5I5nNa/ssBXG
         1cu4hkCDx3g4e0lg5pkA5JiidtZg8VgPeEHw1k1VzV/VcWSBA7BLGLBTVZQf7JhVlglC
         gGvPkUAWfYZ8U+hDMFCts4ROo794rc27ZhZysHyuXB9beqMNkdqfD0pKJNAuOJm5qpYG
         BdFoh1+kjeYQX/07IdJuf04igsU3zX2srUBgbS/JBmKVHldd+dgIMCKiIvqz3Gq8fo2S
         qMy5M47+qVJv/rI1DEghFhNWjOjeh+NPrSpRnR8wwYsyhtRryWayek865cBbw39Gbrlv
         BQ8g==
X-Gm-Message-State: APuU4Z9Wr8sL3Pi+pVRWAEvBFHeFjAIFLnQlwilPT/K9QZq4HtzlNPyg
	HNMsMP97ZgWnNaWS0IZJYMS0VaQ8dkbkYWcINCy0JsQkqR6Jp6BidMYU7cpx/n5Do+Pkvmfx4Kl
	LcTSfAmjnyb7J1LKqqyHCE3kS59cBTJMPh2M0uK4=
X-Gm-Gg: AYBFou2/HJXjz2ytLh3vXcJpB7g4hmwKi4jAjTU+9LAhdai99xiBasPiigJPwaBMgC4
	HikPd5wpREMKfM1pPiqlp0XGBhAAfDT2GbsgkV4UUGcPU8Upogm93Nzt2hico9Flh/lb2myHBMl
	ypyf7yhilN8k5EeoUqE8HBrYgA0Hw/mpeTn5BZdBPrbDbnw6yae6JD43kcoNXrdd3tdjpxEs9m2
	yynIYylwthr452GoLjoV6GZs9Zzhlj6NVrxqGntcVGscKcsr7SpboZsdYyOz7LsvB/BJiBzG3XM
	ce4oSV7w6ZoBXdd/EBWFxCxHzOtPXJIqcL1mfHPTJcXNaCgGCpEOSirOQ9JrTK22LGZKIG7dGcH
	0UkqNoUs8w7ydhUmldEoxjV/Sgi1VwXTtOp65hZPh2FRGpoDiKCxDkFoFrnPbVYWb0bA=
X-Received: by 2002:a05:600c:83c5:b0:4a1:88de:9e8b with SMTP id
 5b1f17b1804b1-4ac17191074mr340156395e9.5.1793810803211; Wed, 04 Nov 2026
 08:46:43 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAKx9m6PywVwkirvkAtz144c-yg71c2+OcNYOTM4Bjtd8dF2PaA@mail.gmail.com>
 <CAKx9m6OsGKGKGxPnjwy8U-bDyvXVEK-dVNmvP0ZqSL-t2Exsgg@mail.gmail.com>
 <anziUH_cC1LXoB1x@pie> <CAKx9m6OMQKufDpqGJewG1OyvZGBKGimSxxxGRDGWgFicSRoTGQ@mail.gmail.com>
 <apSDPwF49Z1Zd0kJ@pie>
In-Reply-To: <apSDPwF49Z1Zd0kJ@pie>
From: Giuseppe Nespolino <g.nespolino@gmail.com>
Date: Wed, 4 Nov 2026 17:46:31 +0100
X-Gm-Features: AclHuK9_yja2JGAKkLua79AIy7He68jvu-sXCLEGjHXqKKP-0aST3GQ2LevbB2Y
Message-ID: <CAKx9m6MMTVg0WQXVwQurT+ZaPfmYkaXV8reOJzLuYR=gA4s+vA@mail.gmail.com>
Subject: Re: dwmac-motorcomm: RX dies after long s2idle, only wrapper
 SYS_RESET recovers
To: Yao Zi <me@ziyao.cc>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Answers are inline

Il giorno dom 30 ago 2026 alle ore 21:24 Yao Zi <me@ziyao.cc> ha scritto:
>
> Hi Giuseppe,
>
> Sorry for the late reply.
>

No worries.

[ CUT ]

> Sorry for not making me clear. I mean the state of OOB_WOL_CTRL right
> before motorcomm_resume() sets it would help, which would prove whether
> it's the case that some firmware or internal hardware logic
> automatically arms OOL WOL after suspend.

Sorry for the long silence, I struggled a bit to recollect data.

I built dwmac-motorcomm with a dev_info() dumping the wrapper registers
at four points: entry of the suspend callback, entry of
motorcomm_resume(), right after stmmac_pci_plat_resume() (i.e. just
before motorcomm_deassert_mdio_phy_reset() and motorcomm_init()), and
after motorcomm_init(). Ubuntu 7.0.0-42, real s2idle, four cycles in the
same boot: three came back fine, the fourth (31 minutes) broke RX.

                 OOB_WOL_CTRL  MGMT_INT_CTRL0  INT_MODERATION  EPHY_CTRL
  suspend entry  0x00000001    0x00000000      0x00c800c8      0x00000075
  resume entry   0x00000000    0x003f0000      0x00000000      0x00000001
  before init    0x00000000    0x003f0000      0x00000000      0x00000001
  after init     0x00000001    0x00000000      0x00c800c8      0x00000001

PMCSR already reads D0 at resume entry; SYS_RESET reads 0x80000001 at
all four points.

So yes, OOB WOL is armed when motorcomm_resume() runs, but on every
resume, not only the failing one: the whole wrapper comes back with what
look like its post-reset defaults (0x003f0000 is exactly what I read
right after a SYS_RESET in August). An earlier pm_test=devices cycle left
these registers intact, so the state loss only happens in a real s2idle.

The failing cycle is byte-identical to the three good ones at all four
points, including after init: the DIS write lands and the masks are
cleared, yet interrupts stay dead (MGMT_INT_CTRL0 then latches 0x11,
mmc_rx_framecount_gb grows while rx-0/tx-0 don't). So these registers
don't tell a good resume from a bad one.
That matches another result I owe you: on 1 Oct I put a naturally broken
controller through a second 60s s2idle before recovering it, and that
resume did not fix it, whereas the same resume does recover a controller
where I armed OOB WOL by hand on a healthy link. So the natural failure
doesn't look like "OOB WOL left armed"; something the resume path
doesn't touch stays wedged, and only SYS_RESET clears it.

I think that still argues for the patch: the device comes out of s2idle
in a reset-like state nobody commanded, and resume never performs the
explicit reset + init sequence that probe does. I'll send it as you
suggested, with the usleep_range() folded into motorcomm_reset(). With a
single natural failure captured so far I can't claim more than that it
recovers the stuck state; I'll keep the instrumented module loaded and
report back.

As before, the analysis was done with an AI assistant; all numbers come
from this machine.

Thanks,
Giuseppe
