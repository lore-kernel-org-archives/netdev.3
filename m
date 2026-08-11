Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D95399360
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 08:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786435580; cv=pass; b=tTP/jk4d8ReiU73VeoJ+LINi87DRgF8wHPT0YolBOknPp62bhtMpaTZonIeqA5wCsNz+LRWixV/gcTU5WdprBXlwErdlBfaDJPhaYgjnQPLw4e6+Snq1YHu9sYZeYZyGZG0j1qJftXIn5zte1g5bvLS70O1DNIZzeXRLmG/mwPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786435580; c=relaxed/simple;
	bh=l6/zFplgWPOmlxZ4EAlGxdwmcN2lEfmOKH5QKOVgMpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U95F7r4HSZIwpGVM3i59ItqVX6Ga+iMvLe5wBnYJ2lBFjgM4G7Rs9w7xHK/IfUtOOLYaTCzz7RB7LTY7j1s4z+TmiMJrhr2Acqq6RFGgOtfnrdiPjcINpqh4zkdzn1lff45duDMh9unSdTZUBIHs516xR8PtOnMgXV78OOEcgvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hhh5ytPU; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hhh5ytPU"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-80bb41f7f3cso29260247b3.2
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 01:06:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786435578; cv=none;
        d=google.com; s=arc-20260327;
        b=a0FqeUfFgSf2pzIb9i38pM1O6E5GvuYwO7D/eopDTYkkiK8+Dkokwap9WDUpuERb3M
         sXhaDQU1Si0EFlUiKq703vl2EZGjnNAmhC4EdibDIvFd8XpyEmD09SVMl1tuox2RHpz5
         dd0PZAH/qy5NXZJ5HTWfEdY+gWWAGeIf6i55OWYCJrhmddaHWnCOCBon8FRIzN0rSIGz
         6ruo2lWUYs7ZaTfSrC/YQ7P6FQwyPZMBD9Q9ncK7fvCZaCALVqGuoJnFbCdcGGASBU0/
         UzPDpxaKCmEGCc4r2PjlCEF41sttL12gtKLa5df20o0ORGQWc71DRgfA3908WENW97M9
         o67A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RP4gstB5JmdXf8GpNaWSK82JhJZ6GjJuZsqxEoPb0Gc=;
        fh=mhi5YNx4wBpB9K6zm6GCcSYYST9E323gy0Mo8q8TsGw=;
        b=Q1DWn3fwSJ6kOZ6vDVyotaso9SaiUUiqOxKnJ+IcsvQyGTggSeRw4xoeOn64P1NZLm
         YnYWaQzy5Die6VDp4sCOKoMzGw2VlgSiX6uMV3uN3ms4spV3titg1nCPoOkFyrVNeUEN
         LicMZgVVZBPnH8xGSlfkS6vVhfQJy0kZ8yXQLWau+HdtDIzyY+NZUh4Dnk+9bGAPKbOO
         CDD2duI/kz/x5Bu+eNK4Fm4FCEsy18JicaD+f3Rrgs72kQ7pJq11iRk7wNL8gvMCKCw3
         rtoao5XM8CE3x1J3JPJYSKOUq1+EUG5dOjJSmGQGMPiBPCmWODsebtHpC2N48550kKF4
         cNUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786435578; x=1787040378; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RP4gstB5JmdXf8GpNaWSK82JhJZ6GjJuZsqxEoPb0Gc=;
        b=Hhh5ytPULb9cX+xPCUexirUB3NunDjyV0tbx+/Pt8RFyyvJvjgRhGgzPOjJ26uzFPH
         ujgb5aOtA+CIAAmVqICjrNyonF/7wHmiK3cKUNO4WluO/HUUL3dTw0xe521Kh9SoBZ9s
         zjR3TGrgoSl+0j/waXy+hHpmahF0jtqGhtacswQZehfE0IfiWWwwH6Y9otfcfMfmwfqK
         uQl3SC/+Gcd3dmxd+/ZlFo5AOcjNu19qObLlkm6zzpeVkSlcr05JJU18dD2aRrrsKinu
         JyO8XGPF7/NFaHG7Cs9/GYQj+iJGAykzfc7rR5fWmQMhK9m0XeLZbE/ZkbUKElUjf7re
         iWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786435578; x=1787040378;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RP4gstB5JmdXf8GpNaWSK82JhJZ6GjJuZsqxEoPb0Gc=;
        b=WJPA4AxrEvyaUCuypMhX89xod+0msuTzyLTKsd0M2VZu8fD3ySubpdeLoDoi9UxPQV
         t3wQZB1BSXyN0Ipgsn/KfRo8IaBPqjcsw1mnDm71nxfDtdEWaRW/EHAHcRyVFZJMSyLq
         EOM06i/+mG8k40bbAE3jR1monnJoDgA7pb7vwynCEBpxt6csnGszvhn0wy32K2Hc44Ui
         EoQtpf8XMltOkfu3b7iFRTphCttgNm1ZhRA4YERMY73kh0WmiEWPAdLzrFT4hkq6Rr8B
         hfqqrWBWySI4uZevtA8LEHorWxum0hhIPqh2FFrbDKek4f0ZpVrJs+NXjTdsUUP3t0bL
         BzMg==
X-Forwarded-Encrypted: i=1; AHgh+RqlxKANw1Rl3SOyDNO4WHoSfCSJDYz7onBBUyxLE/8W1WBxPysLSIOm53n8WsAqWM/tFxKFNQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMLHvGyFvGYwklsJFQebO4T08uwujWNejKOXQ/sa/vATC9Z6uY
	2dkU9wU1f78T1lizRl53l16WVkdlD/iNCzL5gWVVAGPtSdavkbo0UHthJFMFcB4ZaRzcmVneEa1
	ibnKv4mtTExomgZgxWFhMLtXrWDLw5Yw=
X-Gm-Gg: AR+sD10nb4sJXcyDQKYgQvA4PZkOmwiJIQtsWDuwXEreHbtazjy30LPwURHr0Ghi1Zm
	lQwtmJbDnFPT4wan66CO/J+da0TqQDa8mVeJU7XF/+vGPb+S3SompFuVOD3otf8ogD4naPkvhAn
	Q9D+ikLbgCb2xOF9rJm9HPrLzfemnI8s/4HSAdI5y+66hRK8XjSIMWNNSi1pvBr/uDYG3bbu/qF
	yI8rGrx5Amiw6zYAOlOD1vZxSBoS7/FjNFmtcEQEIc4Ht0nGyEyL5Str3bD/ZEpwMo+Rb7/vQsV
	SArIjpmGu4mdPCvzXJtEF1E0yQB3EyMr2B36L49oaIcj3ALM+i+jYKW/z7EMgqjXT90EfpCdmKi
	fkhUcBosRH1rwTSner8H9QRY204djcTmgLTK7ny2/4jhMYuEsihbVNesyQjub9BKE3dg4e1VYw2
	47+7iC1y95r8f4Ay27+r8=
X-Received: by 2002:a05:690c:4c0b:b0:821:133e:569c with SMTP id
 00721157ae682-82f2b5bab06mr8447847b3.15.1786435578515; Tue, 11 Aug 2026
 01:06:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805072641.402-1-strst.gs@gmail.com> <CAOiHx==-d_nzO+TQO+4UD4GfoLSOBUyfLuO+hfj8rQ1if4sZ4A@mail.gmail.com>
 <20260806102327.wrig23oltjzogyi7@skbuf> <CAOiHx=kqmZSM2Vzusc_bcpJfTjJC=jYPgU3wnz_xX+_nnuiNtw@mail.gmail.com>
 <20260810120442.255nahzmurjhi5jn@skbuf>
In-Reply-To: <20260810120442.255nahzmurjhi5jn@skbuf>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Tue, 11 Aug 2026 10:06:05 +0200
X-Gm-Features: AUfX_mxkgy4u4sH2s1-UgSumgSnKCOC1S9Ps9-kKwiDYC0gZe7QHJT6e7iCTOho
Message-ID: <CAOiHx==noeBoE97kgrUm_-HkRNBpEuUVs49r5uFTiUSxWVdL_w@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: b53: be VLAN unaware when not filtering
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Semih Baskan <strst.gs@gmail.com>, florian.fainelli@broadcom.com, andrew@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladimir.oltean@nxp.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 2:04=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> On Thu, Aug 06, 2026 at 01:09:03PM +0200, Jonas Gorski wrote:
> > > static int b53_arl_rw_op(struct b53_device *dev, unsigned int op)
> > > {
> > >         u8 reg;
> > >
> > >         if (op > ARLTBL_RW)
> > >                 return -EINVAL;
> > >
> > >         b53_read8(dev, B53_ARLIO_PAGE, B53_ARLTBL_RW_CTRL, &reg);
> > >         reg |=3D ARLTBL_START_DONE;
> > >         if (op)
> > >                 reg |=3D ARLTBL_RW;
> > >         else
> > >                 reg &=3D ~ARLTBL_RW;
> > >         if (dev->vlan_enabled)
> > >                 reg &=3D ~ARLTBL_IVL_SVL_SELECT;
> > >         else
> > >                 reg |=3D ARLTBL_IVL_SVL_SELECT;
> >
> > This ARLTBL_IVL_SVL_SELECT bit is only implemented for a small subset
> > of switches (bcm5302x / bcm58* and bcm53134). Additionally, according
> > to the register description, this also requires enabling "per port
> > IVL/SVL" mode, which is not enable by b53. The description of that
> > also says that the VIDs used in SVL ports must not be used in IVL
> > ports. No idea what the consequences are if they do.
>
> What does enabling per port IVL/SVL mode do?

I don't have access to a datasheet or a device to test, Florian will
need to answer that completely.

I can only guess from the register descriptions, which imply that
enabling SVL for port makes any ARL lookups SVL based, i.e. VID is
ignored/forced to 0. Presumably this essentially only applies to for
frames received on that port for lookup / learning.

There is a global option for configuring IVL or SVL, but this option
is only valid when VLAN-aware is enabled in the switch. Without it,
learning is always SVL.

I do not know how the per port IVL/SVL actually register works, and
whether you can enable IVL in VLAN-unaware mode (I would guess not).

Note that there is no differentiation in ARL entries themselves
whether they are IVL or SVL entries, only the table index calculation
changes.

Best regards,
Jonas
