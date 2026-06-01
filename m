Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF7E3403E2
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 06:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780293928; cv=pass; b=Gg2H+/Jh3D9P4QisIvgLksq1sCV7ESdLbqvvQHSPe7r83S7n6eTOUL9tObWT5DJPHDHap/TW+YEEQCNI/snyRGPr6B3SF2LJFqoHt6kIXk3zdUn8ZDwKDBGzXMRFgR1UbnkU8mavFYl6+2r2EHZbrR/2GEfpCSvWzKYYQEIXR0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780293928; c=relaxed/simple;
	bh=B+ge0q+NK7KzDZMKIw1oop+AtAxI77a6GtO2I50sGsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWPoYBaK+Ub3B99x0K+Yy/qeMObzx7XjSeKTK6xgfU8JdeVMA7XQ9CwOXAy1FPRzyFl62bMW5hekeP+gIFInFOuG5yRaQMtbO/cDf5tlQvx0xc3Y5uQgByoKwguDzu9ygAdTmr+MQXaDHNEr1lwokGSJc41/7GGR2TFQ03Ig4Bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PF0iKT62; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PF0iKT62"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36c68964315so831133a91.2
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 23:05:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780293927; cv=none;
        d=google.com; s=arc-20240605;
        b=fTyEDT6azD9xt61z5NbKNNbhAkm0X9/rntLrLHDAl5dm5ndeiqQGirTJKgzEOVTZ0H
         iUeWoVSgEsEIIRi7Q5/j64THP08TSovc2gqAe2GBYcuMOoyDa+kCmCjKsxsDSoIW1XtB
         lSUIknONBZh6orgQbHj6KdmcLlLinhN+eKlVrf2j6HoU2gIRQb2Z0ADm7h9G2zIhcKCI
         M/Y3M8Sc4Sd2Pze8sx74/FXyFEZZ7+ZRjLetpl1aCpYDIl57KlR0PBn4DMu/4JbliVCv
         Qp+Q+DY/6Rxh+52a06IjpQ2fAhENXb/uERx7pZFQc9KBwmJ4E18V+zH2/M1qF5tYizH3
         DoJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=glLTXShkm5YP1+5MR78Yj0KypTdD3fdo1XmOBdHITCM=;
        fh=hTxh9LXTEs29emjSViRngh2hRY/zS6cins6XRmcBYHc=;
        b=iSPGqqcIWX+p8rGpOBEuA3TwSBBc+PyEy/3VftPYHRC+fKjNWWpgoBb8Dp/KIgpc0G
         8BHfpHW13mchNd8QEhZquXD82qO6GucI1GZusiNt7ay1Jqm65iKRWAcwKAJqvheTR7bP
         b2qg8UwtkD+XgypbIMJfRaary7q7BStXTZrT+xyjGT+99b0eJWpga/hoLcs/AdoWJUhQ
         n02Q4ez4sCXuEmWLBghhPOO+5Ojinag2w7PK9lPFnYkTeBMNvO5rGJU47ib131UhY24a
         SBavTkxbbYIaQiTlJKbRooPyQVY8C9sh3mYZJ88l1EX59xr2z09bT/I33QA5usg79VPJ
         532A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780293927; x=1780898727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glLTXShkm5YP1+5MR78Yj0KypTdD3fdo1XmOBdHITCM=;
        b=PF0iKT62P1JEarosD887TKYlKijqxqqYdUU/Jeamxho/gNRM65TA5jPhg+SRHSASgQ
         7O4VWHX4ybzY8uRiag09Aq1ZSfRr0NZy6NmVk4dIVeEYbiQ8Qf2hVLAioBzNJ99xq5Nv
         395PatDEZKSH410UH6NdGHebw1wPpOtYqv2zJBlJmIvg4IRFEVvLluYl9n+6OZ+3esCU
         t31tL7Rc/dnvacKG2cPdszNFJK03rozo5NwatVNQ09TNT4dgfz31J6a+gNbTduPnAZk9
         A9eBW5pZcevrrSsQo+tN0pRnjRTqDo08PGpEjvN3CewTZJ1rWGRHAifPHorvmiE4DCqe
         wi3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780293927; x=1780898727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=glLTXShkm5YP1+5MR78Yj0KypTdD3fdo1XmOBdHITCM=;
        b=R79DUU98TPlurfUnFCouWQAOjITryYkrDg3YOsftRnK/xWVsDDqyV0d87Is2VTwUCl
         dSYHgx2avz/wqlJEOYesgcR5Pf3VCCxY7d8/TOqjcrRZV1yXuBTEJ3p+Y/2djuZXSFj2
         QEngQrLkaX84PjGMSs8rDxohmgRJejq7+n+OYULWxIbHLJFUTQUjMQKnvWxUltgBqszH
         lZ4oyFQjvJeYXMBjf79V4w7XI3D+T/IkFeev0t3ca1hsvMpuJCfLU1LzvYPCOFo8BhN2
         mLWzGLSuUUQUPnB5NYe6ytbb7ANyKRfLs6Nnzgc9CF0rjAQ7eS+MN1fvDeepQOFSxxxa
         ledg==
X-Forwarded-Encrypted: i=1; AFNElJ9bA4iU3fR2ahGsqYuI0Y+mjY6+feF6NwkgI9/h36/67W/8RaBQSdZXo0h8y3lT75rjS19wbZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8NJRP1do4i7i+wpakv9KC+rm78uLL4Zwkg+s0EVAWq11IRGhO
	ih0HerBD8R+X8aG0wjcDHIxn/2n3rV58Jt+u9AFzj4C3XD0SeQVwjOFHdpFvjSjqvq4i4MDQIzh
	qWIxCoSPqOhhWxrVn5zrQmksmahZkJZk=
X-Gm-Gg: Acq92OFkO/B4mr2GJMCdS9Fh/s40OO98l/kEeNEnQxXXcPNkSyXyJTq0B/n0/Rp2IPV
	ReNBIWo1BkzJaO88DMnaktSsJQ1s/JNOlU9AMfn7XctEkSaf9KvynJhwOZjBJoEx30ZQ2EirEdi
	73WRQe8yU5jJjvR6vFDI/UFMTlHar3onVGhCHCjV/wmBJjA63xXBZB+svkcAdxfC5BnmO/LbKaY
	mxAgEbnqGZzqmk42OCbKIxJ8bdShdR/3BQ5U9UNDx3dpd1Y/8G7G3Pj17FZ03KOkuwXrYmPODVe
	AqikaqcoDjACGvcBHKA=
X-Received: by 2002:a17:90b:5704:b0:368:b01c:85a0 with SMTP id
 98e67ed59e1d1-36c501db7b8mr9360839a91.14.1780293926650; Sun, 31 May 2026
 23:05:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD03fjaBJGtNATBxaYO-PAxdKC=HxYgE+M7HQ_a0O+3Sp9Mruw@mail.gmail.com>
 <84d8f2a1-6562-47a9-93d7-2d7ff33c31c0@lunn.ch>
In-Reply-To: <84d8f2a1-6562-47a9-93d7-2d7ff33c31c0@lunn.ch>
From: Grewstad <dogestad24@gmail.com>
Date: Mon, 1 Jun 2026 11:35:14 +0530
X-Gm-Features: AVHnY4LKTOZKUlPxUKSEpglGPR9NoZNvIqTRTd9Vh-G5jAMDbvZ2ZfNVIZn_hGU
Message-ID: <CAD03fjah2GMedDtauPQjP0++3USpy6tm3AUemgAjVHS=5Nirtg@mail.gmail.com>
Subject: Re: [RFC] drivers/staging/axis-fifo: TODO file and subsystem direction
To: Andrew Lunn <andrew@lunn.ch>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, jacobsfeder@gmail.com, 
	linux-staging@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, hjk@hansjkoch.de, davem@davemloft.net, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 1:22=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
>
> In addition to what GregKH said, look at the vendor information:
>
> https://docs.amd.com/r/en-US/pg080-axi-fifo-mm-s/Core-Overview
>
>   The AXI4-Stream FIFO core was designed to provide memory-mapped
>   access to an AXI4-Stream interface connected to other IP (such as
>   the AXI Ethernet core). Systems must be built through the AMD
>   Vivado=E2=84=A2 Design Suite to attach the AXI4-Stream FIFO core, AXI
>   Ethernet core ...
>
> when used for Ethernet, a uAPI is not needed. The FIFO driver would
> just expose an kernel internal API the Ethernet driver would use. Are
> there any Ethernet devices using it? Is there a driver for the AXI
> Ethernet core?

As I said to Greg K-H, it's 'chameleon' hardware because we don't know
what it'll be used for. It could be SDR or Ethernet or whatever it is
programmed for. The main thing is that it is a streaming interface.
But we cannot assume the use case.

> Does drivers/net/ethernet/xilinx/* duplicate the same
> code? xilinx_axienet_main.c says:
>
>  * TODO:
>  *  - Add Axi Fifo support.
>
> which could be this.
>
> As GregKH said, find some hardware using these IP cores, or synthesise
> your own, and then work on the driver.
>
>         Andrew

Yes, the Axinet driver's TODO suggests adding AXI FIFO support.
Currently, it routes
packets through the AXI DMA engine, but the TODO mentions:

 * TODO:
 *  - Add Axi Fifo support.
 * - Factor out Axi DMA code into a separate driver.

This suggests that the AXI FIFO is merely a different configuration of
the axinet
driver, allowing a Xilinx AXI FIFO device to be used for ethernet.

It does not, however, establish how the AXI Stream FIFO IP is intended to b=
e
used outside of the Ethernet context. Since the AXI Stream FIFO is a
general-purpose IP block used in a variety of FPGA designs, it is not yet
clear whether the Ethernet use case fully defines its role in the kernel, o=
r
whether it should be treated as a more general streaming component with
multiple potential consumers.

Thanks,
Arihan Bhor
