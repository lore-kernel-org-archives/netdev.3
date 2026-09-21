Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A70738E8BD
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005729; cv=pass; b=ANoRTgQze0yIZGCXcK4Dml95qhsZHaQOsDvGGw7RL8skIUe42SxMM7IlVQUT7rJNAoT1/hdyB4liC5c8uFOLr4Q4ui/d1HFf5SVZKJIrYjuSTeReABa/ZPklTT5nb0b1aWxPWbD1VvR1I+nVsomyceTCYtOTx3ILGKugK6mivJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005729; c=relaxed/simple;
	bh=hqCP8q73l4xlgKtVJj6PdBYEoe4oFusfyO5eUoNJNqU=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XFn5H8zfbbsxhoL8sV4GNPO1pwxFlHmYHWqH6Q4iDsHtaCrBzIxu+LuD4dlI8xWWh+bjw9MOmAgmv6PQC4qB2M1XKCccRABDeHAsfKaLuK5XUSQ1aKweReO8qrlS113BUkT/jkItmQzAvk7wX7WeZCWfuIM/zS2j17Nme37MUg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khu.ac.kr; spf=pass smtp.mailfrom=khu.ac.kr; dkim=pass (1024-bit key) header.d=khu.ac.kr header.i=@khu.ac.kr header.b=QZPlboIE; arc=pass smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=khu.ac.kr header.i=@khu.ac.kr header.b="QZPlboIE"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8b402f4e3so3276363e87.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 08:48:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790005719; cv=none;
        d=google.com; s=arc-20260327;
        b=CiLx0UVGPznzgAN7zADbsgyNdtr+9P+wvse3EKM8y1IO0noyBMkRTdO3r3fPQ6w6sY
         RqJJ6v7E/QTHqTnV2AG18D1giJYUjE3whtGV3RNS+4pAAGy/Bl0u4HJZh1nAyVhZj+XF
         hWoFiD+cwvKvbrjiND1aOv+yQQpQrHkJ5G8BQh3NTSp06NdIBQBE64NpFywW+NVIHGkA
         u1U3/Nek2SCb/1LEHR78R/+RqkT46D6aDzEfai84ItPNPQkrMMpGMN7qKTxkbwfiydaC
         4u4jK3L5xXxZQjDQBKbb5mGCqGJTH97hikIToh27ocLOuegATzMMSzNyFMxsKe50dBJg
         3Y5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:dkim-signature;
        bh=hqCP8q73l4xlgKtVJj6PdBYEoe4oFusfyO5eUoNJNqU=;
        fh=RHaF+0QY9m4d5nq3yNW5p+bZJcBMVOhYJmOJqb4NOU0=;
        b=j0LDCSQiXse5oZMFm1zZCrAiLqNVZXpmSaAbgTJlU4psADzh3VLM7eyjhdCy+5db0d
         lt4dkfmWSsouXBgxeSxBGuDz/hTNfWMZD5KinTOJFMurIPxSkV8iMJ6kpwvetwSZZs29
         187WtO5Nj1RbNcGNLWzZXgPq0m0cdEJkI2WIVy+6fZn6oZLw4wtmdorXxeJKrJh8NPSO
         BAnEtmT/bqzvgByN8EzMRnogR/2hmQktFo3IjvYAO5haKS8YF6h3IKKesTOEhpR7ljpV
         eLeCGuz1ajG09ZfucWWZiH31OjPQfzR7VVOIe1FYrej4A+vV0P7ma1aoBmOCqZZeAJ91
         uoWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=khu.ac.kr; s=google; t=1790005719; x=1790610519; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hqCP8q73l4xlgKtVJj6PdBYEoe4oFusfyO5eUoNJNqU=;
        b=QZPlboIEL1Fvy/6YuFk4c6nLMsXJAcCu7aDHFIdKS/HOxESvaZIYGtvNYneVJMQvsI
         KONoLq1pZKBQgiH0Pc1D0r/moJhNQ44FumFIsyNAbgKqHoIwUe+pT0G/FX5iaCVx6F5l
         Yg8/2L466p+beo1TmGjm4XCQ5WMUkSZGe8NfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790005719; x=1790610519;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hqCP8q73l4xlgKtVJj6PdBYEoe4oFusfyO5eUoNJNqU=;
        b=KLLnh4E1NCLnuNW05bQcLzBk8zqslQjk01UQc+TdF1nXZVkqi7hW+amUYuzj5wt14k
         9+XYsUIOSd0/FCOikJTdHGTLEq8VuSBVDs+P8plQ9rybHazGws0+VDDsMXAoYQGwHC9I
         W8+e1wNrnsN0ZKCy9aHezTP4jTpcUL+DMR92OYiOP/vb5BXFZ2ak0GFZiRBzKZU1NRdP
         n/2yfXc+GLsyenz07qssypkY7FasjqywFxuMII5euCgvIMN5vg3A4zLBo9iUbDI04MmL
         8xm2sXywLFG51rCAcIBvu7Tfz1kGS5GHEQOLmftoF/aKuSNrbncaxFyVSKAwmrHagzVo
         gLTg==
X-Gm-Message-State: AFuF++m9ZnJwuI+NAUz1DiY7QjDUYNsiG9xmCWkS4CK/RFCwCmCB66/W
	CiOMgsS+LTHsu2EZdwJ04NAeYH/2JTfTMcbZ3UgEMqTPVW5VDiPccXPqxJyT7Di1R0TRqDxHypL
	9r+PXFnms5o7NTvGNg2F2K9EInAQpkblqdgHJQsZN+g==
X-Gm-Gg: AYBFou23bVHHVPf92D8VvmfHWTKT+j9j8Ejcx03abFsVp1Dog6FJ0k++RhSiNtqUWlp
	gXxHjZ3GKa4E4nsGw0PEHjZSpElsfivNo049388/XfsswoGEMKlMc4TsA3Od9RHcpzPfaJX1rHN
	7SdKJM8SrkmofN8EApXF7txk2C5Z/nPXH+3uYky9J6+Eg5+MQ2rLNQ1M6o+fBacIY8bEO2zsoYO
	ILTeqVhZZpkrqixMvvm7k/y6zbBsXnwqej8s4f/Yzk6LG67naiDnxht/30nx3Fe0hTsNvVk2p3s
	Q+6SptyGJEyQCcaKHDcBvMT9NTmaxjPqRVMKkrgFPWOjQN6J3BP/aDapwhKKt8yTGMol2PNo6Fz
	9hBDouD030ZBZTD0lGVh/vDv66yOacR9F
X-Received: by 2002:a05:6512:39cb:b0:5b8:bc5e:d100 with SMTP id
 2adb3069b0e04-5b8c195b41cmr4452537e87.42.1790005718733; Mon, 21 Sep 2026
 08:48:38 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 21 Sep 2026 08:48:38 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 21 Sep 2026 08:48:38 -0700
In-Reply-To: <DLL0PZY25HAD.1RWXC61P3MZRV@bootlin.com>
References: <178911388614.25348.8892025153904636456.macb-resend-1@khu.ac.kr>
 <20260915083839.71546-1-pabeni@redhat.com> <CAH1Bc_yQYJ6cWyYVvfWK0pAgrXW1TMkpzmNxZvAXAKZJdiOqWQ@mail.gmail.com>
 <CAH1Bc_z6PFc7N6XVZ2dQEH=7D9mkXwGkXP2KKMW-Emd4zcf3fA@mail.gmail.com> <DLL0PZY25HAD.1RWXC61P3MZRV@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?4oCN6rmA7Jqw7ISdW+2VmeyDnV0o7KCE7J6Q7KCV67O064yA7ZWZIOyghOyekOqzte2VmeqzvA==?=
	=?UTF-8?B?KQ==?= <5mghybrid@khu.ac.kr>
Date: Mon, 21 Sep 2026 08:48:38 -0700
X-Gm-Features: AcwNN1Vx1sHe6ZDAEcThELJ4Tdn2z8qxNTUS-8vTPEnaX6AQ6ya6oOxZJBqyO1M
Message-ID: <CAH1Bc_yDpY1q3yLH5R+fbr_3=LicRv-qsrcPQYspZHz095TVxg@mail.gmail.com>
Subject: Re: [PATCH net RESEND 1/2] net: macb: Preserve one-step mode on
 rejected timestamp requests
To: theo.lebrun@bootlin.com
Cc: netdev@vger.kernel.org, pabeni@redhat.com, conor.dooley@microchip.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, richardcochran@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Th=C3=A9o,

Thanks for explaining the approach.

I found both issues while validating hardware timestamp configuration
on the Raspberry Pi 5's Ethernet interface for my research. I reproduced
them on the board and tested both fixes there, as described in the
cover letter. These were hardware-verified failures, rather than
cleanup based only on source inspection.

I've already applied the fixes locally on my Pi, so there is no
immediate urgency on my side. That said, the structure you suggested
looks like a cleaner way to handle the configuration path overall, and
I think it makes sense to take this opportunity to rework it in that
direction rather than keep the changes limited to the current fixes.

Rather than posting a v2 limited to the current two fixes, I'll prepare
a new series that refactors gem_set_hwtst() along those lines and
incorporates both fixes. I'll link back to this series for context and
validate the reworked path on the Pi 5.

Thanks,
Wooseok Kim

On Mon, 21 Sep 2026 15:11:13 +0200, "Th=C3=A9o Lebrun"
<theo.lebrun@bootlin.com> wrote:
> Hello Woo-seok Kim,
>
> On Sun Sep 20, 2026 at 11:04 AM CEST, Woo-seok Kim wrote:
> > Following up on my September 15 reply. I noticed that the series is
> > still marked "Changes Requested" in Patchwork.
> >
> > This series fixes rejected timestamp requests changing the TX mode and
> > the two PTPv1 RX filters disabling receive timestamping. As explained i=
n
> > my reply, the additional issues predate this series and are not made
> > worse by it. I propose keeping those fixes separate so that this series
> > remains focused on the two reported bugs.
> >
> > Could you please reconsider the Changes Requested status in light of
> > that reply and continue reviewing the series as posted?
>
> To me it all depends on the intent behind your series. If you have faced
> this bug in practice and your patches are intended to fix your usecase
> and prevent others from facing it, then we can take your patches as-is.
>
> If they are edge-cases cleanup patches and you never encountered the
> issue (maybe because you don't have hardware), then either
> - the patch won't be accepted because it's overall churn or
> - you fix the full sequence fully and we consider it a noticeable
> improvement and take that series.
>
> About "the proper way(TM)", I expect something like:
>
> int gem_set_hwtst(struct net_device *netdev,
> struct kernel_hwtstamp_config *tstamp_config,
> struct netlink_ext_ack *extack)
> {
> struct macb *bp =3D netdev_priv(netdev);
> u32 regval;
>
> if (!macb_dma_ptp(bp))
> return -EOPNOTSUPP;
>
> // Step (1): tstamp_config->tx_type validation and precomputing
> // of TXBDCTRL and NCR values/masks.
>
> // Step (2): same for tstamp_config->rx_filter.
>
> // Step (3): read-modify-write NCR, writel TXBDCTRL & RXBDCTRL.
>
> bp->tstamp_config =3D *tstamp_config;
>
> return 0;
> }
>
> Improvements:
> - we remove writel from the validation code
> - we write to NCR once and not twice
> - we don't have a tiny gem_ptp_set_ts_mode() function that returns an
> int for no reason
> - also NCR RMW probably deserves some atomicity through locking
>
> Thanks,
>
> --
> Th=C3=A9o Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
