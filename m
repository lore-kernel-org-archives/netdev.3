Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CD1421255
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 10:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786530084; cv=pass; b=dSh17DKYuIRJ46f6Ofq7tA8LRW+ODgc5Urjptm6dAc4Gt5GbUMzUyiaC/crGs16chHp3Jl4WxQMLgANJ+Zcmw9lBQUoOkLqKqnMopd952ppR9bLZJZCIlybeOI5tho5UzgPzfdGHo3SfyxbLBTbjl1jHydTv2oQWbWKeAI9iRr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786530084; c=relaxed/simple;
	bh=I5IV0FzcT3bJaNANnZrPSpNugFoJbXhqOz9mg8oKkdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJflPcE2U0XSyiDKCworIuAuUrJ7vfEWQ4Z4NiO1iNYUmtgPX+XEgk4B/1gAC35xo2n4umx7vm8b8YMVU/ldhU/WYQnjfR5tEmbm7Ai2LK03Zjy8oRsZW7PFUzuqf8gYjdas/vrG9euq1AViiCdpCk8qWHCjccWgXGFMU64WaFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ac6W/KqJ; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ac6W/KqJ"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cad8076b01so9356045ad.2
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 03:21:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786530077; cv=none;
        d=google.com; s=arc-20260327;
        b=IflO3otlLVWYn8BKtsO+nVP8Zzdcug94eIwPYQzl0Ouuokg4w4Agm5HZdgXECvAxeO
         gNrZdUz1D/laEx9omsvI7FK7g6LquwrCx7vbMfcdjPqJq4q97A/n9vibRvIikzDVUHVm
         a9aZUc9CPL87qZ76MF0LLgte+MZ5vdeIv9F0OOF5U7jkeyagISNFG+QzwyA1oxnRwkMe
         kJzph/w1a5uQXUmetTz6WTb3jJSUQhSPK497igRKf3GP3OKxZMAbrTm00SyJb4ZvTptF
         FM4FMox5u1ptX3Fd8V/HLYGCK+3pXKTVyexP4+p0wYP7/ZIVxpFLd2rIz+IFnMKz4eA8
         sokQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=I5IV0FzcT3bJaNANnZrPSpNugFoJbXhqOz9mg8oKkdM=;
        fh=KPPExBt19EQbQB5DhI291tsenTHlbNKbUS8icKZbz0U=;
        b=bXwhJe0yOYUUFKBfEjZt1KN2Cxd9lxfiUDbMBDP5ccb3mOPQbkWbRIQHA3arynlAeg
         I89z03SGqS4HuLcGqXA5BesiHyBM4LShE2RyDuXZkr3Vr206i2SpYccCX1RFXdiFr/OS
         lDfVKtBDyzusDZ/UljQJnSVHc9C08hNdqALzwCmFKSOCWQrirXz5zkRtpYh6y6x745Lq
         dBfps9QG4gTnCuoCKCYankDstzF8JcgVrIigRRI8089zhvVfm11/gPJv94ZwNCDL/zy8
         UAni3/A1zY/8uG0UnGs1kNs2KPF/m6wtKKwSevH80X1i0KqV1srCkf6EVPQR5LJ6peQL
         +efQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786530077; x=1787134877; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I5IV0FzcT3bJaNANnZrPSpNugFoJbXhqOz9mg8oKkdM=;
        b=Ac6W/KqJlatTKHG/aucIsKuMIAeVRlKdxFe1w+mIV4pO3eEe1/Kk+vZXFAoNENl4UY
         VV4CPBtHB5kE86LGyF8YjMmYIp5nX5Ysk/t7JcfsGC0reIKxowpDedZRScWSSzWzEyS3
         vTgT7+4Xgryulz7bKN6XmPqHvfftIz2XkfCykC4ZzLSy6pTJNsO2I0/7hbaB0UV2QB/2
         Bdv2fV4X5ssSbIBbF7U4tA5MJfcITZBz5FTKXiE5pUhs9L+nOY82qydo9KdeHZfEWNQr
         nnGaSkRp2PMX2T/FdDTb5BNI5HJzI3v4NnSsxkWMwzjtqgIoi34wdhNRJZ+ME0rd/xuE
         xz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786530077; x=1787134877;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=I5IV0FzcT3bJaNANnZrPSpNugFoJbXhqOz9mg8oKkdM=;
        b=HGnR5CLzHkAK7l9WGFMuW1cc5kcJKVsh9ftdVwJBILUK934ZZzi4UlagyPzFt5SwfD
         OUCNulEHH3FwLWIbj69U9AOzj2MeGVaC0msbBeAcejITgqIpGGeTpUzoFd4NHYp9+vnX
         zB80e4DI1IxI9MY30awdnCn7gehsxPFopL/8DEPzr+ypRMjKDHbWVQDj8VYZTm2OrQNb
         z6ixwSODyLkgRdhf4OJ51uip63Ct04FAKmm1KQuN92EQvYAAyiZ/Sel9cQN6CpULoFI9
         A7GxcSWgGRqeWoK7KSnGx6gSzWcb7YQD+6wC+Yct/s1JyLKKu94L2K6mzLRbpuTbxGw4
         zbeg==
X-Forwarded-Encrypted: i=1; AHgh+Rr4K16m4ypQO/40f6N+ApoxWHcNBGDWVOQloUrdPb6sTf+BrmT4HwdfT3iI21p0aZr45CPIpRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXIkvUoaRZo9juGpt3rg1r4up93+9gbdW+hFHBDaIuee+HtdSZ
	5ALkjKngSEpf4242p1rPTsJ9FMxvnNO/GWXEyVEXOS68U8gHMbmlqmRaHBJZqktJlhyOYSbmOXk
	wK9YrlW55mnWHE3VZNHGIHjZhsKkTyUo=
X-Gm-Gg: AR+sD10yeWl8r+xSnp6BeLt6142GEYeDfixYxbCpiq0gQnQsfnbEzXQhV35bIxshU3l
	XzUoM1xyVn+B9YgqbPgEePOiR1rUtBIXLiqWliQrjEcejPTonyN21/ID2gd5mFOH8VcmIIEexD6
	h6UGP5B6FwaUq7pvYtidrKBIgHwzZrqJ/m9EJuPGF2a5bTnSmprKRnMXkgEM0uQXNwJvczxYBQM
	I/czTKgOcCs7T77Pt+uCP8JhEaXTlXtqfq9i/dv/W//a+7bohtZEjvo/4BIo5Sh2hppXryTQjI3
	e/7Dlg4As01E4GgGuzW6dIIJvhi8F9tVftSB2MDJxsb6jQ==
X-Received: by 2002:a17:902:cecd:b0:2c6:a772:7e43 with SMTP id
 d9443c01a7336-2d34560d1e8mr43024445ad.18.1786530077441; Wed, 12 Aug 2026
 03:21:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806073119.387-1-strst.gs@gmail.com> <20260806073119.387-2-strst.gs@gmail.com>
 <20260806111523.gjlhjfmb526f2y4g@skbuf> <CAAsRjRnhdPJOCE5BwU7zUTJ0mtSYCOA3xLcF5ejZQT8OFjYiYQ@mail.gmail.com>
 <20260806124313.see74vgu4dlqqse7@skbuf> <CAAsRjR=RyiraYdLkOcHEagGKXK5+4zwQbT-Zq-1DwVkPiKUNpg@mail.gmail.com>
 <20260810120821.lykofvogbrn2y2ps@skbuf> <CAAsRjRn7qFWy4UBL8tWGQ9pBo5q3du4e=tU9gSKkSSd7K3RaDA@mail.gmail.com>
 <CAOiHx=n43MPXKxA7oxBjGh15pa4Uh5etxkPdrV+0GxACEnrRJA@mail.gmail.com>
 <20260811095828.xwb4nsmx74wtzjei@skbuf> <CAAsRjRn0LNMspFCbi_7QMQsNPBhMXeAZfcvrc40k-Y87F7jHmA@mail.gmail.com>
 <CAOiHx=mv9Ygywqbi9pR_K4vvu6tJtxdj9zObp_QB80wwV2zmCw@mail.gmail.com>
 <CAAsRjRnhN67bbyUQpo3iHNMiOK-7vUQFP1CaBrEydNc3jBAtsA@mail.gmail.com> <CAOiHx=kDG_wDjUzcDAYB8yPF=DLMJkzh=QSseBB_p_M4pfa-wQ@mail.gmail.com>
In-Reply-To: <CAOiHx=kDG_wDjUzcDAYB8yPF=DLMJkzh=QSseBB_p_M4pfa-wQ@mail.gmail.com>
From: Semih Baskan <strst.gs@gmail.com>
Date: Wed, 12 Aug 2026 13:21:06 +0300
X-Gm-Features: AUfX_mwK48P6fCtj3SFlVWV7Zs_2aGcVCto3ezw5X0k6P2yVRh4EDCsIUfutXkQ
Message-ID: <CAAsRjRmhNc+yZsF=NQjSNjzoxta2KODedkgQcabzYMNZh5waeg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: dsa: let drivers offload 8021q uppers on
 standalone ports
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, florian.fainelli@broadcom.com, andrew@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladimir.oltean@nxp.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jonas,

On Wed, Aug 12, 2026 at 12:52 PM Jonas Gorski <jonas.gorski@gmail.com> wrote:
> I think the register description might be wrong here, because changing
> the VID to PVID for untagged packets is the default / expected
> behavior.
>
> The datasheet for switches I do have say it replaces it if the VID is not 0:

You are right, and the MDK text is wrong for this chip too. Measured
just now on the BCM53011, volatile write with a timed revert: with
CHANGE_1Q_VID set, tagged broadcast frames carrying a VID absent from
the VLAN table, which deliver 0 of 10 across a vlan-unaware bridge
with the bit clear, arrive 10 of 10 at the far port. They arrive
untagged: the VID is rewritten to the PVID, the frame is classified
into that VLAN, and the egress untag map strips the header. Clearing
the bit returns delivery to 0 of 10, and the untagged control ran 10
of 10 in every phase.

So the bit is a real ingress reclassifier with your datasheet's
semantics. The original VID does not survive to the wire, so it
cannot serve the 8021q upper case, as you presumed earlier.

Best regards,
Semih
