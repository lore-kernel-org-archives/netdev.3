Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BDC33F5BE
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 03:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789531048; cv=pass; b=bwmyqAml9ZlDGk7Fu4teHz/P7f42nbcfXuzw3klr2BQPR7E5kYnDc1C+PMcnqE+qc6mdJJkwk2D5nuw0kUzNx5SKJDTm7cdhG2iBjnAhoCnzbd7HS2K2sjuRoTdLt7Dg5DivJwfM87dJ3hXpr8pIvkLPrfNf2LghyvnD75KiABo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789531048; c=relaxed/simple;
	bh=u0yf/ZsCjhLjq9G9BtB8G1f/03wIvVhVp8fs0jxsUYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fDoOcE7GDcI/SY+Q42L1K9rvWVVCvKc6hX2WhqIaqYZCGOK7ENKL02beH3NiIL656Qb2MMtlpAW6X8jm6kUlAv2Vg9RbT4FTE3SRVJr6kO2f/m3i6MRD/SzAz9lmtkJGaEd/Cth3PCaBsSeVlyQImB0RRcs5vbF3xKUo2Bc1dlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQhJXuow; arc=pass smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQhJXuow"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b899413537so584863e87.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 20:57:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789531045; cv=none;
        d=google.com; s=arc-20260327;
        b=Z2gIogneP9tpbZnNBBVNzWQd3vb+KjFiTbN1LodzPH3B5PagC5HDbk0Hu76kZk1gd2
         mabg9dxkO/lA5h7GxOeMwzkTqIOsXmt3oi/S8ZYDIJsorumRpoCTi6qTyet6zWV8KLZl
         BIjlImJ6qTjJeZnIJMHGbGpu4/sOg8+JbIJLsSpmIox3NMUoO1tuTSqdje+EBhZlNeiM
         N38t6owvLuTcTiRSWmI1Db5gLSF4iBDquoIyb5zkQA1PepIF0CfZHqFgN7C0V3PA1Iqr
         Y9ajCmj63F1UW0Fjn6AF6OEo2KZESVqFbchekO7lkC+82YEzLKj9uHrfTvyhMGLrZyix
         LZWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xQDR48WjHEqsMRL2A1gJmeKRcqUr2W7BIowYB3PxMEA=;
        fh=PpwnYradG4TFhQRlMeEF9HxaHfXwMFfz4c+oKEZmfm4=;
        b=i4FqxuFm4veZQz0DMGMbtGYID7qBMj0WU6sLVZYyg1CnoY09R8jjpNGkX/Ygu5RYCh
         9EbxJP4azw63fLFJiD4RFPLGb1ZJZ0JFN13CQOKbqLCtg2+p34Cqk5CQVE3EuvGCI4SR
         LUYVkorHCWRI7YDPVSMSnY7rneF9UMCIJk1SQIxwmFFKk/gCRhi2mei2kxXj0u/aQGdK
         MnO7WrdYw0MrpdjNUHuUHqkktv40NOil/tEr2X7nuWinutvrGVh7na9QCNEQ/G0A2tD4
         9eZE7ABDmT0FOtUOpcmJjKrSHKay79pad+UcDWDnVtc71FPv/VI+M39Bzq8EiMl+gg1Y
         dHPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789531045; x=1790135845; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xQDR48WjHEqsMRL2A1gJmeKRcqUr2W7BIowYB3PxMEA=;
        b=UQhJXuow2gEJAUlxNN5tb0PS9mtS6ye3NB14B+uYe0K9wvyOc+yXuPbDl+JqgAucve
         YdH+dnOHKQ3UukdAR2Hal3Q2ml0kQi8h7xyqdx3or8URpxD4TV5kpiAZddQ6w0FV20lJ
         5zFL77QUMdT535sfk8daBWPcbgpKWgm2A+hRSUFfH/gyGQWWqgj3UYvqOeobHMkQLvva
         8lKC7oOYseWDR6KtkB5TE5vyQ2RP6NozcOrKRu90qlipGLPrldK1U2QFXruVa8NhJbbt
         AzObR6GESHrWV00PkbhkMsr2aePyPNEOPMmZODh3NsxA2E4kxnun/Q04Irmjj4Jl5aCC
         DLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789531045; x=1790135845;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xQDR48WjHEqsMRL2A1gJmeKRcqUr2W7BIowYB3PxMEA=;
        b=FV/GRlbTQY3/ufbHCtkYXnTRXGglKU1ZawO7wxH1Us5ksmub89q6fTHQJiTVeXac61
         h7fM92JWgL+NQgQYiJo94aDzwvaoFMp3mrlctyilzo7KojoIAcJ/FFR/QR0syybFw9oa
         TrYMOBUtNzSdVHAyoXSL14JxR+nYdB9AfPZTaV1PG4tPap2JhOoZuHZHBPfWxyYa/Gfq
         sHcoa5yUk/4y1qJMGfH1wKgtqNg5KEDAKyaItdaSMYsPSStJjXhq+hwyV3b04Q4KgmA3
         cYEQi1MPlzJF8ZEkSfMcC5Hm2wSK6zyg90DZHRcu99tf4t0IIJkBEwaJB1yyr4Srtql+
         J6mw==
X-Forwarded-Encrypted: i=1; AKwUvBxPRP5jwCz3oyESIpdKyYNQvtqQDqkIbBYpmHfQZm4SFFK59BXu8cqwNzcGfle63lPr4EBQ1yA=@vger.kernel.org
X-Gm-Message-State: AFuF++lyHSP31JLemk0jGk9GN1l/qyiqei4EZcRnbPOfvnESpjHDdAee
	DyRmam2IgYEfiShHxsXCoctgl9t+S3RugLpe1Ahq24XMPgkhfqAvkWpJ7x8XMttcdOE747fPLy4
	3CwuGOm1gxV4AkiIExCOyLnD8rCoMedw=
X-Gm-Gg: AYBFou0WdYMc4WUSHUKu4sFm22nlVcR+WiKxqZzCSrSw1oXMgdZZkzdQvHVEQn7W20+
	oTaQX+XXIlx8kBU8cfD73LVODr/DkNI9w28Sg3yRfR0nth1bVUXaAPdIJ7bqINxjTIjAM3a/4kC
	EUwfJfoZIb7Gfi7rheOadZGKUhjiVwjAeZE4t8AIPeSLjgDUXiYcxBey4imLUQnbpHYzATlkCAZ
	87S670Z8JWegt1hzC01iiTfWNkkcLlg085KAwgxf3xVutPWEjOtui7+A6YRV7lLv9CTRytXHhSV
	RzyVexCKmxcy2wFcLUEsKAM+w5sgVYpqCdpaqLXHch/EfE4ALCQ11A==
X-Received: by 2002:ac2:51c3:0:b0:5b2:158e:9918 with SMTP id
 2adb3069b0e04-5b8b661e3b2mr186213e87.19.1789531044560; Tue, 15 Sep 2026
 20:57:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915065534.102249-1-maimon.sagi@gmail.com> <6acfc82e-7690-4759-90df-22b64a5441ba@lunn.ch>
In-Reply-To: <6acfc82e-7690-4759-90df-22b64a5441ba@lunn.ch>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Wed, 16 Sep 2026 06:56:58 +0300
X-Gm-Features: AcwNN1VE21f4CHLNHevQeu2epcwUcVn4gToPTCHI40hLednW88eNlo6h6UQyzGs
Message-ID: <CAMuE1bHKr_-cE7VpSMc_8nYGgaH9Y901XMqRLzvKYodn8CHiXA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: axienet: add a TX timeout handler to
 recover a lost DMA interrupt
To: andrew@lunn.ch
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Michal Simek <michal.simek@amd.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 7:15=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Sep 15, 2026 at 09:55:34AM +0300, Sagi Maimon wrote:
> > axienet_dma_err_handler() is the driver's only reset path, and the only
> > two places that schedule it are axienet_tx_irq() and axienet_rx_irq(),
> > both on the XAXIDMA_IRQ_ERROR_MASK branch.  Every route into recovery
> > therefore depends on a DMA interrupt being delivered.
> >
> > If a completion interrupt is lost the queue stops making progress with
> > descriptors unreclaimed, and nothing ever schedules the reset: the erro=
r
> > branch cannot run because no interrupt arrives, and NAPI is not polled
> > because it is only scheduled from those same handlers.  The interface
> > stays wedged until the driver is unloaded.
> >
> > Add an .ndo_tx_timeout handler so the netdev watchdog provides a route
> > into the existing reset path that does not depend on the interrupt that
> > was lost.  The handler only queues the work; axienet_dma_err_handler()
> > then performs the reset in process context, as it already does for the
> > error-interrupt case.
> >
> > .ndo_tx_timeout is added to axienet_netdev_ops alone.  On the dmaengine
> > path lp->dma_err_task is never initialised - INIT_WORK() for it lives i=
n
> > axienet_init_legacy_dma() - so scheduling it there would be a bug, and
> > watchdog_timeo is set in the same branch for that reason.
> >
> > Tested on a Xilinx AXI Ethernet MAC by clearing PCI_MSIX_FLAGS_ENABLE
> > underneath a running interface to drop completion interrupts: without
> > this patch the TX queue stalls permanently, with it the watchdog fires
> > and the interface resumes passing traffic.
>
> Have you seen the hardware wedge without faking it by clearing
> PCI_MSIX_FLAGS_ENABLE?
>
>         Andrew

No, I haven't seen a naturally occurring lost completion interrupt.
The scenario was reproduced via fault injection by disabling MSI-X delivery=
.

I do see occasional hangs on my development platform,
but those are caused by an unrelated FPGA bug that clears BAR0 and
PCI_COMMAND at runtime.
In that case the watchdog fires and recovery is attempted, but reset
cannot succeed because the MMIO window is no longer accessible.
I don't consider that relevant evidence for this patch.

My rationale is primarily structural.
axienet_dma_err_handler() is the driver's only reset path,and it is
currently reachable only from axienet_tx_irq() and axienet_rx_irq()
on the XAXIDMA_IRQ_ERROR_MASK path.
If a completion interrupt is never delivered, NAPI is never scheduled,
descriptors are never reclaimed, and there is no recovery path back
into the driver.

The watchdog provides an independent route into the existing reset
logic that does not itself depend on the interrupt that went missing.

I'm happy to reword the commit message to make it clear that the
validation was performed via fault injection rather than from an
observed field failure.
If you feel that scenario alone does not justify the additional code,
I can drop the patch.

Thanks,
Sagi
