Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768D42BE034
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 07:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791097262; cv=pass; b=eWILvNUiwWmqmO4h3f7DcjoOrk59EOl+5bromOMNYUyDj1h0KokJML6hAV916i5cBEVuCYvnr8lOamjSHYTiA6evsSVHjtcZ3fbbt/gnLI3wvoUg206YymMtEf4cyWpPZ25dv2PayOyNbI91BT91+7CUlZocyRqJHsRU55XUNqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791097262; c=relaxed/simple;
	bh=8z2Q4aSQIYqwr1uqGgLedKrAGeZSHBHgbKQnEdpHYAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/u1tWlAy+fYElOtm36krpxdfq9f40OMpIRRengkE8qBP1MyZjjzmUI1CJxBaVKF8SKcasvM+0e4omjtLN4SyRv0s2MamXOTQ10fF5hFp/GGVigRqVnveWSfEgG34oZCBlAO6SmYd83xmnDRPW6RRB/V8NNzWyqJ7vsejYZCi5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiBoklOG; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiBoklOG"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3a97c689f0bso4632541fa.2
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 00:00:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791097257; cv=none;
        d=google.com; s=arc-20260327;
        b=qmg5eW551oowFSy/rQFVgpC+O2F605cB7BeZtT5SFKwbNPOMEp/a7wI3nG9PVmIrUc
         fnZR/rItCwYbQaaKnXrNFIPJ0hT7qTCyFl0TQTtuLimBfi1QSboxT+V2Eci7vAK5y+Lf
         Irp41nbngvFLzLdVpRFPLSao8PPSUyENawM5CW8BBWKHzifq4n7NNpudz6Y1eqGdgMPq
         ecuo/F3IEOWJQMvCehBJ07OHCXSp9k2WLqRlRQohTXuTkBhq32gzAHNnz+7LOMpXO8Wh
         kCKJTTVUKUyewF0zehP5pnlh6/qUzqgnhhStjpIEtbA6PVYhocUswD/bTECMlynJMB9i
         L1hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bXHSUTDfF56/ebo2tUNw1YI0rOH2BaPU/almIFz1WKg=;
        fh=0lKP2aF2pQ0Z+sM4wqJjvxWsLZzWNEhUfwLu8QTu/ww=;
        b=NZKBX/QSvcf8qA2yrKDxWVFlLpkTYGK7tEBDRDIx2qgSNxPIu1frXShHlEibkmr6q9
         7h++zKZz/uVRsKiPcFZ1fmasmoFgyZWOyVnViXbYroba8SCQrN3vtW9Kz1JeE5H/OnLK
         zHNBhHfcvOl54x5S3STKf3nvAwVWwLxc0qKzBPygQBjnf5VtPLFmT2a/GeBuPPMoBgQS
         eeQ8WkF3xXB0Vu+N2qsihbhsXJaxBTB3zSwrJMrFQYs+P78IxF42hMqycvWKy+eJvh6U
         hOq54V/jZCynarOUouFL2ZU/K9kUlrTSKHrwAvTIw+AnabYj3c+f4zVROWD54rLGrEIA
         3AOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791097257; x=1791702057; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bXHSUTDfF56/ebo2tUNw1YI0rOH2BaPU/almIFz1WKg=;
        b=LiBoklOGGsS/ZVUtxvjGuvE0/LLEQtcXqoGRRE5kCqLj9Q4dWGW+tCoRsvoRDwiGZQ
         Q+xJyMPEOm7tmd7El5v+7DuRvY+mvmVSyJDFJo5OXV7b1aHAlhp+z0p77x3duIWvPvmq
         puqQNveL2I1RBwxMBb8O8ElWPXpCKtdqqRJPloAKsvvncKHyzB6SmtOvJxROmPDWCzdL
         ibvwTKFLGFO7FpoiLxU8AF1TLrldNPKxFXNcBiSzpG1kBz8r8xyKUjJ56wwJPgZM3/MP
         Wcz6oOX6sw6j9QFfLYnKlLWfMr6/l9p3iVyzULkHz+13sMnGDTYos+bYIRCdyK7PV3O0
         yvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791097257; x=1791702057;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bXHSUTDfF56/ebo2tUNw1YI0rOH2BaPU/almIFz1WKg=;
        b=Eo7az3X1OZFKdlnwrw1AVBiP48Q8i79eWKVGgEu3soIKuyfC0sZaiWCiCjaKnSiOtg
         Kv8nWW2sYMK+3M2ve9QSjx8d4XVOEmjZ4ZMifNCKpaf1Mmfy+UCjR1AGNTmU3MMQ2UGM
         QjmnUE90AMw0Ft8q7cyXkqWqxi+ez/bxyu2cWRNBQQ0V93a29BKtpkyW7Pucp6fdqdmu
         2tGtN0KCFv8RY83Y8XZBraqqqyXh7DWFIb1nidcFZx8zvDzRqs4P3mmjzmYk8H3RpNUU
         MgsJ/iF/UAmtMwqYz4QZnFQVwNaWCUz9RLMcMY5W6jBBGSK9wV9PORgAdgqWFusAFlqL
         cw0A==
X-Gm-Message-State: AFq9FYKAoLJqkMkS+uwBVvs3s5ClmV7vPY6tG8PpwSbAQj06fKzfQtHd
	aeAv297otkrusr3AH63Asi0oV//P8qujBIPqTo7vwSnMXykHGgsAtTu/1cIca74GvjBN86CORhF
	pUfSB42ud7a+jI/WEsMxhiOuddbQYivk=
X-Gm-Gg: AYBFou3ftCUlxMFmGM1Em7YUKWYSm8fEJLickD83usEq8sXoOBdQuJ7SIPnbKMFtNcI
	TfOWDnJ25UNx873LfWyHKNOv7iw0oZ/cMfbBSszJpNJxHNXuxV4g6oTebgOKa9aFNbWSYRBu+rw
	8Q9geuN+7nC+z/MxeiRuWQA4LNYHagADDLFEFDB+lYMnON19o7FlCF5ZrBu2KkDW3fpWL6L0ysB
	dZAuCWznhP5xlMtSOnsIaWsOKGnATi9SbvzfYFB9+6BmPP3LFNV6dslxw5ecRlnnddDz8iN8Jah
	m9fKD9n10glm0hqvB/Rd3qxbsHJpiLxXm7F6Mia/doRm5xf9XXqysA==
X-Received: by 2002:a2e:bc03:0:b0:3a6:6f81:1017 with SMTP id
 38308e7fff4ca-3a974f53555mr10680051fa.17.1791097256973; Sun, 04 Oct 2026
 00:00:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930071536.627964-1-maimon.sagi@gmail.com> <20261001183814.4e9e88e6@kernel.org>
In-Reply-To: <20261001183814.4e9e88e6@kernel.org>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Sun, 4 Oct 2026 10:00:30 +0300
X-Gm-Features: AclHuK-gKLM5DyDjTIWluJ54WCoWTSUW6QHXG092v8fap6l1hS-WaFJz59CPzZQ
Message-ID: <CAMuE1bF_=t7qoPxxhXA5pAShnWx9kGpy0BSnRj_CwuD9WUuX8Q@mail.gmail.com>
Subject: Re: [PATCH net v4] net: axienet: cap the TX poll return value at the
 NAPI budget
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, radhey.shyam.pandey@amd.com, 
	michal.simek@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, robert.hancock@calian.com, sean.anderson@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 4:38=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 30 Sep 2026 10:15:36 +0300 Sagi Maimon wrote:
> > @@ -1027,7 +1027,12 @@ static int axienet_tx_poll(struct napi_struct *n=
api, int budget)
> >               axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, lp->tx_dma_cr=
);
> >               spin_unlock_irq(&lp->tx_cr_lock);
> >       }
> > -     return packets;
> > +
> > +     /* The whole ring was reclaimed above, which may be more than the
> > +      * budget, but a poll must not report more work than it was given=
.
> > +      * netpoll polls with a budget of 0 and expects no work reported.
> > +      */
> > +     return min(packets, budget);
>
> Please take a look at commit a58cdf56b6e, that's the correct approach
> (incl. feeding 0 to napi_complete_done).

Thanks, that is cleaner.  v5 does the same: it reclaims the ring,
completes with napi_complete_done(napi, 0) when budget is non-zero,
re-enables the TX interrupt and returns 0.  It is posted as "net:
axienet: do not report TX completions as NAPI work".

Sagi

pw-bot: cr

> --
> pw-bot: cr
