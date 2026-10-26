Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793009719;
	b=WTPe/A6KBNblJ973bK6B/9+rZuQHgbhmTXJkERYsx/hChT4GtkkBwFm/mcXMgh1ElgQc
	 C3pK31DIZ5q/uuhryAAin4Kt+V6W5KZkV4iNr0u4c5nz/577bc1n9Cax2O0/VFq7JGd+d
	 spx8o05km4qw68C1T7lwPGRMbbVwvOxyVUZX7GvKSk7AC8d1SpQLCmTQ9GZu7jFcbfkaI
	 v7jOksRfVzGFOEGqVVbGGXOrGE47+jO20MBDA7Wx9uC5+dS7st8t82Ig2ShjRGMOMLbdG
	 SFKnJTyf+RtRNIz4qJq3zInGvn+u2MNdewSI5LCbd1LrcXLIqKE3hGQkwTS53jMPabw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009719;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=9aBZuFYnOniDZkDJYDzTBINBGxjSmG1ya1bp17w8auU=;
	b=maNOdSA0StfKP88LJWkiS+Od1Fkvlrc/VAxclBpFiG23/eP/70fA8apdTuplXMlq+WQV
	 ABcmKpRoEyFhC+pxy2zEf+UprkTZZ1hDL3AII+UiNq/7p/4itliRzfTs54YbAZ+h/waxm
	 YvjAHXORpUyIC5nNE/ki7JU3s4lGTKRazM4gO0uxwilAdzdNTOa/04+jCRmlss6z0uawT
	 6781irtwF+ZRx9Bvq4i75bEEo9G3cesZUxuzfxwl4wRT1V7Irt1rdvPuTSMpdgMvaO5Kp
	 Fq78klxJn+wDC+yCJIrP6RBOQKNS2tz0ifhTff/BO5FNHCOf0593QiEBfSv8lEjbLTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hWBOayci;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FB9606A31F
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 10:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0FB9606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hWBOayci
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso21238845e9.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 03:15:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793009717; cv=none;
        d=google.com; s=arc-20260327;
        b=ghfbZZcljlH2MGA1GOaglExWxtHTIUXx+Qi7rwKUVJ37qX8zp94SWXm5jSeww1OfJF
         cvpm8ibvgkue0EOIhdEBjyn6cZBRKMC4G0mBojwUVSIINYUUYsTWuu12ktWO4bUHIEx6
         H92VI7AD/S8SEvpF1yQ1XHzy/K6w2e4TO+MKPWT1wnE+8aUygUfv/o+V+e8njqyzS7wI
         mnH6IKDrjQIzjLFEA6L078BHvhBKh7M7RvDkowSfeFfiiKp4EK3mA3jhjFftIF7TH88v
         D9/jr3qZI1lBPmlfBgINsGOhzfXC7mrIH9Lhtl79PCE+G//I2DCMOJukDuWpH4JDqpWI
         oSTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9aBZuFYnOniDZkDJYDzTBINBGxjSmG1ya1bp17w8auU=;
        fh=ARotNC2dR+FBHgwFyrpfuIwOFcLfjO4Zz9oqSZCy83o=;
        b=csO/XC4bCvFd53JBbVIv5XsgPEAM2mtIheKjpIenodwCr5d8vzHxsTwyGu9bzDXGlk
         +ZWnrbcv6Fyx2NPbDQYUJQk06ED9o5+iA7Fy6BwQtLH5CPfMzv9ic/fzYIpHgXVULxy0
         dUsUAqTGe78V3wb6PJTgkI7TLpdBdfCMdq1SWcUh5zv4B1sW2dJRP29Og+oQPIB5XDk4
         5uhjN04SAAk3Gw3gOfmeyN29w0LW64YRlgSpUfSTRFyZ33MYbH7CZRs/QB3VhbpF3WvZ
         P6lj852JCI9lR+MXvj6o9OgQkd9iHdI66UDC6hRB1WK1N8c2nYYDIe6mPKrDyTMP9pEW
         E0sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793009717; x=1793614517; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9aBZuFYnOniDZkDJYDzTBINBGxjSmG1ya1bp17w8auU=;
        b=hWBOayciY+6ObABV4Sj87WKyKv7sYo6Nss8lpvQuDk2JVaFbm2I/YnHoazh8RbrKr6
         V3OlV4pIY9lNPYeAFLlkFQrJtYgEuJWANJIdVnxWAp0JaR1Of0rETrkEabue+rv04Hoz
         rA/fSqUD4GzXVWNkAN4SV3MJ42HlhqRFZGHdScvuK0htDzJbmTdG5RDnOtuX4AFHTShP
         fVjGAPrH2EHd/D3k9m6KTNt2kDCzA//r8D3ne95pqrTkzF7KBP81XOxLfddt5G3QcyVe
         8yKOJDnH7oIiqvr0KTANgDpRUngH4dtXdw9AxEt2wU+7aGmL93TwBLyEBVWsR2XoqY51
         2tSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793009717; x=1793614517;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9aBZuFYnOniDZkDJYDzTBINBGxjSmG1ya1bp17w8auU=;
        b=qg6uxgKBIYovEhimZ6QCxSOBKe7QPldrHntKB6xArsyK+G6RPB+6yWsULmi/SBd3MJ
         t1G++WnhJt2qx0zuQEqEB0j7E+rzp1Roaajh1yPfyMoyunnuYWjPe4VGwSlIs1r0lmuo
         W9lzdQzyrNqk+biwYu/hOIkRNGnuDj43BG4a2EtTsaPn0LhSXc0HbFWZWYmJaWVru2Qx
         atTFaG5pUojwkzlK9MZr5H9kIDSBh/D4CWHAPGJqG8/1+gCN2fXwC06edA5aG7O2P33d
         eUCvetbJD6nMA/SAJWK6YT2Hc24HZCmeDvwEqlRBB2LSmsh1dBtSFWjnLWNxQa5N0ILq
         ukuQ==
X-Forwarded-Encrypted: i=1; AKwUvByzRC/3mAWBPH0QBVAJoJKl8SblBlLarGJGFw9u6DLoxj8S/RB38gz2uoK0PjF3MKfOsiyVe6o=@vger.kernel.org
X-Gm-Message-State: AFq9FYJWy+5IiNVNQZZiAsexurndIEZxPosy+zF+ey6fISaH4/sbNg1Q
	0xGxL6UYpR7Xgw/9UDysHk73m7zoqMD2FnwJf590Y81V4NFMBQIEYLgls+YkdI2dHK82BqrbCZO
	q0wKewWtLFm5utfJdzjKksXy/AJ49iRc=
X-Gm-Gg: AYBFou0m+KJ8AISURoCO7cRwK168zmMkv4yzxaLwOQFm88x3qjuAJ/HAzg5JnCrgeHX
	zA3zFndX/Ey9iGzE1apuyc/64QUEnaVirCkNzVi5tWl40Be+TAXGen/4XuJetM93vwmScVNAnKv
	95BdNaFmneuEvau3JWq6df9oNJ0sfJSPDRE9p21aLvjjVkmZPEISRddcbG9OVSaDfhRY5z8WdL8
	mfQqZoUTl3ssErcqJS9N8OVzHErV5SR48mcVmMnnIvqJyFvjqlSMjBE9EoHZSq97Y8I+1NkU12i
	SXKE0Hb17JYvG1XoVk+BCC/uC/MVOJiKLJkG32AB/Qr9XjlEoks4ns4MxQIUNiQ20j6Zef6y81I
	jS7XhRauQ/GuVdGTD++cR/sDpEC+sKlgLdPowMIMAXiOgqSnuvNqayY8BRisXHtVEQY+XOvhz2o
	NyQmMQzWHTT/1nhg+yIaVctRyvQrrDjEQQqsb4lEORC9EI/z5yxPIKwk+WH+rqWwsanjE4FcK6U
	pSoJzrtXWXndw==
X-Received: by 2002:a05:600c:a06:b0:4a2:40:7f35 with SMTP id
 5b1f17b1804b1-4a35acaaacfmr115694155e9.31.1793009716860; Mon, 26 Oct 2026
 03:15:16 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261004152840.61222-1-b2rancourt@gmail.com> <e8669ef4-1b3e-4429-a6b2-db4c6a734f7f@intel.com>
In-Reply-To: <e8669ef4-1b3e-4429-a6b2-db4c6a734f7f@intel.com>
From: Benoit 2r <b2rancourt@gmail.com>
Date: Mon, 26 Oct 2026 11:14:40 +0100
X-Gm-Features: AclHuK8a3o2txfU9CppftX-zSmZGF88PYoTCRr2FEwkGvWFsn1ZWRvLH6WvAKpU
Message-ID: <CABti8MHmpc=sY5zE9Hpdq4OP_-Th_E7O1XQi=Md-aznGQmtikg@mail.gmail.com>
Subject: Re: [PATCH iwl-net 0/2] igc: Fix Tx hangs after NETDEV_TX_BUSY with TSO
To: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Sasha Neftin <sasha.neftin@intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dima,

Thank you for the review and for the explanation.

Yes, going with patch 1 only is fine with me. It is the actual fix for
the problem I hit: in my tests, it removed every NETDEV_TX_BUSY return
and every Tx timeout on its own.

I agree that patch 2 is a broader question. The same pattern exists in
other Intel drivers, so it makes more sense for your team to decide
whether and how to handle it consistently across them. I'm happy to
leave that to you.

Thanks again for taking care of my contribution.

Best regards,
Benoit


Le lun. 26 oct. 2026 =C3=A0 10:04, Ruinskiy, Dima <dima.ruinskiy@intel.com>=
 a =C3=A9crit :
>
> On 04/10/2026 18:28, Benoit DE RANCOURT wrote:
> > Since commit db0b124f02ba ("igc: Enhance Qbv scheduling by using first
> > flag bit"), igc_xmit_frame_ring() requires count + 5 free descriptors,
> > while the queue is only stopped in advance below DESC_NEEDED =3D
> > MAX_SKB_FRAGS + 4. TSO skbs with 16 or 17 fragments then hit
> > NETDEV_TX_BUSY. That return skips the tail write deferred by
> > xmit_more, so the queue can stay stopped with descriptors the hardware
> > never saw, until the Tx watchdog resets the adapter.
> >
> > Patch 1 aligns DESC_NEEDED with the admission check. Patch 2 writes the
> > tail before returning NETDEV_TX_BUSY, which remains reachable for skbs
> > with buffers larger than IGC_MAX_DATA_PER_TXD. Each patch was tested
> > alone; together they keep the queue stop logic consistent and the
> > remaining busy path safe.
> >
> > Setup: CWWK router, Pentium Gold 8505, six I226-V (8086:125c rev 04,
> > NVM 2017:888d), 7.2.8, default MAX_SKB_FRAGS =3D 17. Load: CPU saturate=
d
> > with busy loops, a remote build routed through the port, two SSH bulk
> > streams in each direction and short TCP bursts, 180 seconds of load
> > per run observed during a 195-second probe window, TSO enabled on the
> > egress port. bpftrace probes on igc_xmit_frame, __igc_maybe_stop_tx
> > and igc_poll recorded NETDEV_TX_BUSY returns, the inferred last tail
> > write and next_to_clean stalls.
> >
> >                         runs  Tx timeouts  NETDEV_TX_BUSY  TX_OK return=
s
> >    unpatched 7.2.8         3           25           10890       7.3M
> >    patch 2 only            3            0           10751       9.5M
> >    patch 1 only            3            0               0       8.8M
> >    both patches            3            0               0       9.4M
> >    unpatched, TSO off      1            0               0      21.5M
> >
> > In all 25 timeout episodes, the stalled queue had pending descriptors
> > after a NETDEV_TX_BUSY return. The probes inferred at least 214
> > descriptors beyond the last tail write. For that queue, the hardware
> > register dump showed TDH =3D TDT =3D the next_to_clean value recorded b=
y
> > the probe.
> >
> > With both patches applied, no NETDEV_TX_BUSY occurred, so the flush
> > path of patch 2 was not exercised in that run; its effect is shown by
> > the patch 2 only runs.
> >
> > TX_OK returns count igc_xmit_frame() calls returning NETDEV_TX_OK,
> > excluding NETDEV_TX_BUSY retries. These are software call counts,
> > not hardware packet counters; with TSO disabled, segmentation occurs
> > before the driver.
> >
> > Related code, not addressed in this series and not tested:
> >
> > - bnxt: commit e8d8c5d80f5e ("bnxt: make sure xmit_more + errors does
> >    not miss doorbells") rings a pending doorbell on the drop paths. It
> >    leaves the busy path alone, reasoning that busy can only happen if
> >    start_xmit races with completions that both enable the queue, in
> >    which case no kick can be pending; the current code warns "ring busy
> >    w/ flush pending!" if that assumption breaks. In igc, patch 1
> >    restores that property for skbs whose buffers each fit in one
> >    descriptor, and patch 2 covers the remaining case.
> >
> > - igc drop paths (skb_put_padto() failure in igc_xmit_frame(), out_drop
> >    in igc_xmit_frame_ring(), the DMA mapping error path of igc_tx_map()=
)
> >    also return without writing a pending tail, the case bnxt fixed in
> >    e8d8c5d80f5e and 00eeab0c644a ("bnxt_en: Write doorbell when
> >    linearizing skb fails"). The queue is not stopped there, so pending
> >    descriptors are delayed until the next transmit on that queue rather
> >    than stranded.
> >
> > - igb, ixgbe, fm10k, i40e, iavf, ice, e1000e and e1000 also defer the
> >    tail write with xmit_more and return NETDEV_TX_BUSY from their
> >    admission check without writing it. Their stop thresholds match
> >    their admission checks, so this should only be reachable for skbs
> >    needing more descriptors than the stop threshold assumes.
> >
> > Not done:
> > - runtime test on a kernel built from this tree; the patches were
> >    tested on 7.2.8, where the affected code is identical, and apply
> >    cleanly here;
> > - launch time (ETF/taprio) and XDP/AF_XDP traffic, which share the
> >    ring and the wake threshold;
> > - longer runs and other I226/I225 boards;
> > - only the igc objects were built with W=3D1 under allmodconfig, not
> >    the full tree.
> >
> > The analysis and the patches were prepared with an LLM-based coding
> > assistant, which also wrote the bpftrace probes; the results above come
> > from those probes and the kernel log on real hardware.
> >
> > Benoit DE RANCOURT (2):
> >    igc: Fix Tx stop threshold to cover empty frame descriptors
> >    igc: Flush pending Tx descriptors before returning NETDEV_TX_BUSY
> >
> >   drivers/net/ethernet/intel/igc/igc.h      | 8 ++++++--
> >   drivers/net/ethernet/intel/igc/igc_main.c | 6 +++++-
> >   2 files changed, 11 insertions(+), 3 deletions(-)
> >
> >
> > base-commit: a83267db14681b3be481e02a4d5a38177507006c
>
> Hi Benoit,
> Thank you for this fix. Much appreciated.
>
> I wonder if we can go just with patch 1 for now. Reasons:
> - As per the analysis, just Patch 1 resolves all the issues encountered
> (the corner case resolved by patch 2 is not reached anymore, although it
> remains theoretically possible)
> - As explained in the cover letter, Patch 2 changes the behavior in a
> way that makes it inconsistent with what other drivers are doing. Maybe
> the new behavior is more correct in all cases, maybe not, but in general
> I prefer to avoid introducing inconsistencies, especially when I don't
> fully understand the effects.
>
> Best,
> Dima
