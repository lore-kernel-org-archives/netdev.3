Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794362419;
	b=Wk22y5O0oJWWQPEB9dFeF3vbC30wu9rRpScWmS0iGIkg6GwFhCzj1NFrt4t+NAh8r8KT
	 ysXbibRgbegJGnDtrU7ELrvFrcm9ephBDTgp1KvTRSUmJtxHsUnFiSx8KXNSFl/MsHboo
	 tYJYNlqOJ/M6meQCV6aEoKxuJU2FjmShSsYpFjmqwV9bJRhP4T0b449jzLk4moLOL/4Sr
	 kzhRUL3aD/lbPCN63E8f3mizYnem62BEAL9yUTnx65DT+acqCl8dYRmGCLH8IM2Ry5R2a
	 TEmWO13yxW+znptOUObaDWyQ3kLFHU8+2NktQYn4MdyhGfKwxjy8HuBM1M8VR6Un8mg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362419;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dtC/s3IFvRHvWLM5ctW+2r/vaRjYMyyM7FY+73RqcL0=;
	b=ln42Vj+/7MZDQaWAs0f3Fhm6KfjyFr4mwEE/8hSy9p+g37ZvZo8ABtBCavuXu/JjBMhC
	 ppGv/vx0k51Vj5dugvA9fvgf9mzpjWGVXlowPwZjvJ2oIWxyOrnTHvOiwFhpgZ3kRmKlE
	 gMqQ9/9ZlchvO+g9o8/kiKxSXjIgw8C0r/9TkvUtqYX1bl8D3pQK//fepLzrfljptgNuz
	 8S5+Vd4/tsaA6TT3lK7dNhsMLdW5xLg3DM64F4F06tjSxL+SdMyj2nzQnnhsW3GhLps1b
	 mLxtwdmcIbz1ytFs+eLWQbmu3IQ3FJVIiPeNIFf3rsrZi1y5hOLbp6hVmANBLwL4/kg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bvRxWyFG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3137606A320
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 02:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3137606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bvRxWyFG
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-37628596783so1371810eec.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 18:00:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794362418; cv=none;
        d=google.com; s=arc-20260327;
        b=R6OcWGUul00CuQcTaa9NRu1ODpP5LKlurg3At4Xkv2GHBhnyuAcPZrGgs5Ug9v2Me2
         KDX4sOF/W6ULfSu26nHK1sNvCO8M0UO/LmUFuB75aHQpNcvy4CypQQO5PnQE4ANW/9ar
         2+pnR2SYeYUja13vB9ZfQwJBCw5f4NWskYgJLB/3IO1+NCwaJwnZk6tQEwaCu+sev7+8
         K4LY6XafnXY4hrIcwqduYfi5MprO1FYzqgLbFOo/tAspAWqIUFmZ1MyIe2saftmTwiyj
         sfyY/vA9PhahiM96jR3djjc1vrfjzwBGWBj+OIltzppR0RD6dzu/xcq9TG7kWXYiCstn
         gZZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dtC/s3IFvRHvWLM5ctW+2r/vaRjYMyyM7FY+73RqcL0=;
        fh=voFQUW4q6+RvSHWyIUr1ravUatLaSvXwY900JyTZLUc=;
        b=MjPevreuGV0SU85vWF0klFCse0szOay7mbr95FGAPMdfKCgAU9atCL87yTuREwF7CD
         +V439B9ifegWcJzqvoj/73tvlomSwxQxulAw1SfE1Gycsof3DOlX0AjpuC3DiuW/oGT0
         ZIUuC6uvIlGpybu425uSebVcju9WreEsrsJF0q5Er9H4kGrMgGTZKTWYr+JWOXSFyv6e
         f2s1GALiA8kjce7ck6t1pJBM1xrP/HNAQUOKjIyczUKIcXISyBr4zw91xpNeKZ7GGgHN
         dKgdamqypdEewVsvccaYaB2aBxXm7ICE0ij39rh0eoe3MmgdAqJHN6p+UTa42MKxzusg
         X94Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794362418; x=1794967218; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dtC/s3IFvRHvWLM5ctW+2r/vaRjYMyyM7FY+73RqcL0=;
        b=bvRxWyFGwXzDLRtpU1+Z9VJNOOTsNT0608bHW+RTaiPzND6oFBDN/qWqzndR17T2BR
         KCn2IxPjarwRv9oaQoFUKWSwijRbWm+Ow/iXOOOwmli3lH/82MX/KzxoaWKZZ6i+8sH6
         VSE+pL9SIqnv3FAUOwjgnW8gmHuWeCZrlEpJ23fPmxEg5iNQEDg/aT7fk9g6AJbLLIlE
         d8n7kLo5VHvrtvzQZMdpAS/M2Ts4CtOTuV1imvMhxXAj3CB9Nh6Qjliw7Vqa7KGEQJBn
         tkNmJAwzRm2nQGjbRs6YP91uy4RcGAA+nuSwDAU97BQeflbNLcuTmOVJjt3Wizl3IkyC
         3W5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794362418; x=1794967218;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dtC/s3IFvRHvWLM5ctW+2r/vaRjYMyyM7FY+73RqcL0=;
        b=UhyYQHAu78yIpjXF2abIguvI91JUq8yHwZnuV+GM6olRMwafwKP8UcelQxSCI7OkKR
         sOTGwAtvNYutl8l7he19ozBZW0xarO4W1EaGHvFot4BbDoD0kjWUrLSeVE+HuWSCWXjM
         h4RA9+ITNrNAWEoKbaX8XNCM8ZkEpQI6JtyYHb33OCQ3v3xMnjWRKM0JnGVSpZZZeBiU
         SQwSwCug9kbXqHCBnrBPZB9PvgvMDgxfvqxDwN9du4ZbZG8c68a0DjJoSszNpwI/zJgf
         8bl4ga8hq38vhZ+pXuDDGbtpffTHQwpT4fqOSq/nhhGIscrs9IoHaD57A8QCs+4dRt8T
         n2Pw==
X-Forwarded-Encrypted: i=1; AL+hErESYF7lQ0z509gnWbjN17uhrG5VQALH3hmfRMirW6/xYAabtBOnjFwF8lwFlnByYltNVa6ey0I=@vger.kernel.org
X-Gm-Message-State: APuU4Z8P1TDQsMZbpFq/F73RNR3M/oEn5X+aTyFinqc+iGEl8MFDyzNY
	0YsYf6W8sOT8WlqNJaUBo3WzO1QthIbU41Uf+pz6qkgkHUW37JsH44EXf+1sJiR00E05bvb9clr
	DnianOuAjUELRK/W4Rh2tvc34Kq6jxwI=
X-Gm-Gg: AYBFou1ad94T7+KCRW7eSpV+bZyJLTNpHJJWKZc429Mb0HteW1UR/KNNtaayApqr9HG
	f0lLvmSekLwl3zjTHveadnbBbSLOr6HjTV4sf8gChRmQOQOYiUJBlITf5fVIA+xptjoSwEyT0sP
	kqRCpyq75Hg9ASEE6lbu1U2sM5iX8ow0tmxdlvvvIb92r9WHLrSRMhYWw+IpbbzIxAju5fwAelP
	uropqhLHuImZENf5VioN3gOPeK/mpuFrvZsx3tkVIGRz5S34PMN3XdYIzeKs7Jy/Hl3XpX1l727
	P7/6H6kASJl7/pnSV6ZChFoTjI0wv4ECvc5gVoIbup5HpnqB60Gx/p21/bn5wEskzl0f5OPTm9k
	xiWIYQdr+bXO9KPe73VsTwnLPnFzYPWxYRZuaxBCuUrGyiaT8EczVpqIu96tsn9XwwEUODjPg5s
	QmXXQlBnQPHf5fzRZAw6ul3R/KiHs=
X-Received: by 2002:a05:7301:795:b0:36e:e349:f2cb with SMTP id
 5a478bee46e88-3768579dfa3mr1470248eec.19.1794362417519; Tue, 10 Nov 2026
 18:00:17 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110-smsc75xx-rx-fcs-v1-1-4e048bfc28f3@gmail.com> <137b3cc5-7077-45d9-8ba3-ea4c584f1992@lunn.ch>
In-Reply-To: <137b3cc5-7077-45d9-8ba3-ea4c584f1992@lunn.ch>
From: Joas Antonio <joasantonio108@gmail.com>
Date: Tue, 10 Nov 2026 23:00:05 -0300
X-Gm-Features: AclHuK8ROedb8-shxTvKJCqZsFUqIT-32EYB708a8vtoB04n-gGoY_3AV2iFUVI
Message-ID: <CAOCBhwFSS_weykmFvmHQJ0VuMxW-dxHytBn81rn47wfWwnsV9Q@mail.gmail.com>
Subject: Re: [PATCH net] net: usb: smsc75xx: reject frames shorter than the FCS
To: Andrew Lunn <andrew@lunn.ch>
Cc: steve.glendinning@shawell.net, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> I assume there is soon going to be another check to ensure the frame
> is big enough to have an ethernet header? Can these checks be
> combined?

Yes, that makes sense, thanks.

Looking at it again, short frames are only half covered today.  For
the last frame in the URB usbnet drops anything shorter than ETH_HLEN
after rx_fixup() returns.  The other frames are copied and passed
directly to usbnet_skb_return(), so a frame of 4..17 bytes (0..13
after the FCS is stripped) reaches eth_type_trans() without a complete
Ethernet header.

I will send a v2 that tests for size < ETH_HLEN + ETH_FCS_LEN in the
one place, which covers both the underflow and the missing header.

Regards,
Joas

Em ter., 10 de nov. de 2026 =C3=A0s 19:41, Andrew Lunn <andrew@lunn.ch> esc=
reveu:
>
> On Tue, Nov 10, 2026 at 09:03:21AM +0000, Joas Antonio dos Santos via B4 =
Relay wrote:
> > From: Joas Antonio dos Santos <joasantonio108@gmail.com>
> >
> > smsc75xx_rx_fixup() takes the frame length from the RX command word
> > supplied by the device and strips the FCS by using "size - 4" for the
> > allocation, skb_put() and memcpy() of each frame that is not the last
> > one in the URB.  The length is only checked against an upper bound and
> > against skb->len, so a device can report a length field of 2..5, which
> > gives a size of 0..3 after RXW_PADDING is subtracted.
> >
> > size is a u32, so "size - 4" then wraps to 0xfffffffc..0xffffffff.
> > __netdev_alloc_skb() adds NET_SKB_PAD to the unsigned length, which
> > wraps back to a small value and the allocation succeeds.  skb_put()
> > adds the length to the 32-bit skb->tail and skb->len, which also wrap,
> > so the skb_over_panic() check does not fire.  The following memcpy()
> > then tries to copy almost 4 GiB from the URB buffer into that small
> > allocation and writes far beyond it.
> >
> > A malicious or malfunctioning USB device can use this to corrupt
> > kernel memory or crash the machine.
> >
> > Reject frames that are too short to hold an FCS, as lan78xx_rx() does.
>
> I assume there is soon going to be another check to ensure the frame
> is big enough to have an ethernet header? Can these checks be
> combined?
>
>         Andrew



--=20
Joas Antonio dos Santos
Cyber Security Specialist and Ethical Hacker
joasantonio108@gmail.com
LinkedIn
