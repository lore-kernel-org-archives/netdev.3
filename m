Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C2555D895
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999086; cv=pass; b=g/nWVWNETRC+JkUkZXbdvxEt72w+SoItEN9/AsiQtGrd7cZpQt3BZh7LFmEsVP+jSrlLxVER/20r7IBXpPEhizsglanMk2v4S1HIzzIOvoGav5rcwtjs/IW5dQFPQmXSti/PQXEw4rnMyUWM7H+pRxS1vdlV6027HKcgvlaFi+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999086; c=relaxed/simple;
	bh=J2brDSW0l1yMue6LXvefjqX49viPH5qU5HJnhrLt8Jg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5rs0uy8Ivl73BaP1dgsuunOuDuziqi7YlOiFsswcM4UFxoN0N67K01RvfwQZ+YxsmcvBev3UKvRnFJqaRENPX5QXKu5+NelZrfl9I2aATDMi73B1Nm5F1JNcz3956uNVK45vPn7EJfyix/gAVTHE3Amdb5CN36RnavArHcnkQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCJ8gsBc; arc=pass smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCJ8gsBc"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7c02791cadcso1358402137.2
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 10:31:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791999081; cv=none;
        d=google.com; s=arc-20260327;
        b=moGdyBleMlA/3d1VeUGKHrkj8GmSE5trkad4nqD16pfydEev5MSC+5Ogv79OIwx+Xh
         5klLY4ItN4/OS7WRgPNnLF/YjJfvrBKGF5kZVDAllcznNwPObjHpi34v7D8Kny6VzoMl
         2hJtFyOCqDQUVBpuERr67zK6JJeJigl5oopvsOUAUyIuJXY5U+DCIOXpWwZEOaQiokBO
         wudzWjSHECpXbZ651CmmeSrBLxoim2BK3GJ4jmPDOKbqJaaFLbhHydMFJG9ZYLeG4Vnt
         tGDcvKQr+KY5omlf9C5AF0gxSClBzzgxhL3lFXHAFGlVrV8Vaiwtdj8HfmAQXS5uaMfj
         wu6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o5ZbzPIc60pdlOqSNGnFeiMPLZidMz1uIN4k+iGTLwU=;
        fh=zT239D3uluY0S4SaxSt6v9qsARJBm0AH8ZIzY6AOLC8=;
        b=j3xcbYo3G516T0J2DCp4cQmkUBTK0voySy01SXPldNkwI391tjKobEuY7prYPCyIxD
         BUwwzqcd9LS3VbVW6Mky5qh2/0BevK5+V4L4L5zjI3KSj9WLSicympivh8GK/+Ma3Olp
         s3vhFNJBSECyWMAoQSstbsoUHnCbBYK6Z7KpUmeBc4uQxll21NhdBDV3FT35IZ6til6Z
         XyqzV4VumLTNbUylKFIje8+M5dVP+0qwF1xo0ArCWitDe3emi9vDHWJUDDAH2JpR9hN3
         Bsp/xQMseaUbFmxYyM8dqHJ7kIYUVfW1HJPm2xw2R2RWykIgANf5gwBY2h1qh/xcjM3z
         7T/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791999081; x=1792603881; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o5ZbzPIc60pdlOqSNGnFeiMPLZidMz1uIN4k+iGTLwU=;
        b=eCJ8gsBcQEQEp4BscJ3S5JnGJOAHrQ3ikKr5uDqVQA+5gaWBCeMHNJ0mtj2uMqc/mK
         Us7J/hM/fd6NvBd4HJ3p87jPNdg8h0w1R5MZH95rJ/DO44Xj6DHkywVn/fkXmOscBLZi
         CvtYzUYtOmCXrZOi8tBK7ulWybVHCLVOr4SbHTlC2skxKKkVEBueAvN8hgK06AN19o1G
         +p2biUmLgezHq7c/lUM19cHtOCBcfMYWlajLpTWtTbIUVc8YNCgFCZdwmoYDiLevVm+5
         4fIm++aFv/DB0SER1ajayBSeik93ywF6gDpYtLfChF2kxVbeoBknhOBkeDD2cZoF0CKX
         fk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791999081; x=1792603881;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o5ZbzPIc60pdlOqSNGnFeiMPLZidMz1uIN4k+iGTLwU=;
        b=2Kju00Z7A2DXF1k5B7A7jR8PI3qJalUU3UavSgNmSO4B9l5MBZyvQ1CA3stEmXGhn2
         vmp8zcVs3nOybY1BnOXJu07Fz5U2klx/aVXOvmW1Wwi8WioaQHEcK7gGv/xcVaRO6D8H
         oxOY/c75or8YFjHTq5ZAvvEBbuKGDMB3SNYQtT45yBmoWDMcebo/iy+qKZX6bf+JUWUf
         f9vFkBmh76NzJzYikUt7O1g2HUMi3xlsnzS7KpP5BJxhRQXxe6xsdwDcNLSUcnShbbdJ
         V39VWX5Srd//WeSNZ0AXP4Z84sRQZ4vp4Hsue3x6H9mVS4UAn/o8CaJ1DextR0qvUpti
         v6Ig==
X-Gm-Message-State: AFq9FYKw7mbbvQcNzSJpz/CqhrULpnFi6HL8B8UL4MCKoMW04zhFYzs2
	+CKYFjHdEZlyxjxw7xw+oOgiT4cGTMRmKX2cnpRrutGWazqbtZ2WZIfecAj+Tw7fSohZ7DmHuq6
	XharfUuKkyuK/VuvbH7Sc0hWs1l0YDVNjTbb5Wnw=
X-Gm-Gg: AYBFou2Hllya43NYuFOQ7OUSXL1jAoba2P7DX0LB0Bu/6EdiwCF8iWnO2iOt3hDows3
	SGcwNWEao11dHu9doR7gfd9qWKVXxI98OAnRm2lJLdyOr5oYlciuyMxVs13bYHUVtfMCBHPhv0B
	eSaBZb55XcPco7F1UyMt764l4bKc3dmO+9tkV+Zp7vk8rK1fGU/u77DDtOqI6iQ7ByNVlclcJpo
	mfEPPaClnxVj7azY8aJGZy0VRFf7pJYxI8f5bxDUqhxPGmUQitWOAfsqXjp3JtD40vjL82CMMON
	wvq63g6FpZqqsRbMaX1cbnN2Je5iAmJm2BP1BUsES0L5tTLbrSVSuKKqA5kI4zw0m8O6Mf3PGBY
	bLYbf8c4hmEbdv99QELitsu1Ky+ZSptoe6BiMwxj0k3CsQZIDsQ7rWZibrA+6udPrBLJNyJxvwa
	tgMSzM7D2i0rtRrYKEfm1RqxD9zVYMVmQSRQ5JkwTRrsd3
X-Received: by 2002:a05:6102:915:b0:7c2:799c:9031 with SMTP id
 ada2fe7eead31-7cb373d999amr4245321137.30.1791999080515; Wed, 14 Oct 2026
 10:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005-submit-phylink-suspended-stop-v1-v2-1-8b8e5d53dfc2@gmail.com>
 <224296ea-f196-44f3-91d6-1461846c55a5@lunn.ch> <CADvTj4qgcXE6azsNx-Wg5afatezLeuctGR607qO1WhZSmuqzBg@mail.gmail.com>
 <7ffb9b38-75e1-42e2-86e2-21a1666fc51f@lunn.ch> <CADvTj4pVtoMh=H=nJJaPxYf-ZqU8xJEJLMANUAXTFJWb5zBe-g@mail.gmail.com>
 <209159e1-bd74-4462-bf00-8c2421af29e2@lunn.ch>
In-Reply-To: <209159e1-bd74-4462-bf00-8c2421af29e2@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 14 Oct 2026 11:31:08 -0600
X-Gm-Features: AclHuK_7ESZCxbu9yX6KRTFYHTg5lezZAnYOymXlJdJMMz41cBXby-SS2_TBP7w
Message-ID: <CADvTj4okPfzysGTX88jPFvr9jUuN3KGKzscCjDt7tT-RQ4vE_A@mail.gmail.com>
Subject: Re: [PATCH net v2] net: phylink: allow stopping a suspended instance
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 11:13=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> On Wed, Oct 14, 2026 at 11:07:27AM -0600, James Hilliard wrote:
> > On Wed, Oct 14, 2026 at 10:02=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> w=
rote:
> > >
> > > On Tue, Oct 13, 2026 at 01:46:24PM -0600, James Hilliard wrote:
> > > > On Mon, Oct 12, 2026 at 7:22=E2=80=AFPM Andrew Lunn <andrew@lunn.ch=
> wrote:
> > > > >
> > > > > On Mon, Oct 05, 2026 at 01:09:05PM -0600, James Hilliard wrote:
> > > > > > After a failed MAC resume, a driver must be able to stop phylin=
k without
> > > > > > resuming it and reconfiguring the failed MAC. This is needed wh=
en recovery
> > > > > > leaves the interface administratively up but detached until a s=
ubsequent
> > > > > > down/up: ndo_stop() must finish the suspended phylink lifetime =
even though
> > > > > > the MAC could not be restored. The missing transition was ident=
ified by
> > > > > > code inspection of the stmmac recovery paths.
> > > > >
> > > > > I don't particularly like this. It feels like a workaround for a
> > > > > broken MAC. It would be better to fix the MAC so that resume does=
 not
> > > > > fail.
> > > >
> > > > Fixing an identified cause of resume failure belongs in the MAC
> > > > driver. The intended purpose here is narrower: allow orderly shutdo=
wn
> > > > after the driver has returned an error, rather than recover the MAC
> > > > through phylink.
> > > >
> > > > stmmac_resume() already returns before phylink_resume() when hardwa=
re
> > > > setup fails.
> > >
> > > But why did the hardware setup fail?
> >
> > The exercised failure was injected, rather than a diagnosed spontaneous
> > MAC fault. This change comes from auditing the existing error paths for
> > the deferred stmmac recovery fix.
> >
> > > This is what i mean about it being a workaround.
> >
> > The deferred fix addresses a separate software failure: suspend has
> > already disabled NAPI, but an unsuccessful resume leaves the interface
> > administratively up.
>
> But why was the resume unsuccessful?

There is an independently reported case where resume cannot happen:
an ASIX USB Ethernet adapter unplugged while the system is suspended.

Xu Yang reported this on an i.MX93 EVK, with a warning and call trace
showing phy_stop() called from PHY_HALTED through phylink_stop(),
ax88772_stop(), usbnet_stop() and usbnet_disconnect().[1]

The sequence is:

- Suspend calls phylink_suspend(false), which stops the PHY.
- The adapter is physically removed while suspended.
- USB core skips the disconnected interface's resume callback.
- Disconnect unregisters the netdev, whose stop callback calls
phylink_stop() on the still-suspended instance.

That call sequence remains in the current code. Successful MAC resume
is not an option once the device has been removed.

There is also an existing resume failure path in UCC GETH. On
CONFIG_PPC_85xx, resume rebuilds the controller resources, including RX
buffers allocated using netdev_alloc_skb(). That helper uses GFP_ATOMIC,
so allocation can fail under memory pressure without a hardware fault.

The allocation failure propagates through ucc_geth_startup() to
ucc_geth_init_mac(), whose error cleanup calls ucc_geth_stop() and then
phylink_stop(). With non-MAC-WoL suspend, the PHY was already stopped.
This reaches the transition directly during resume error cleanup,
without the deferred stmmac changes. This second case is from code
inspection, not a hardware reproduction.

These are independent of the injected stmmac failure discussed earlier.
The USB case provides an existing hardware report of why shutdown may
need to proceed without a matching resume.

The earlier discussion favored handling that case in usbnet.[2] That
is a separate question about where to handle the transition, rather
than whether the transition occurs in practice.

These examples most directly support avoiding repeated shutdown of an
already-stopped instance.

[1] https://lore.kernel.org/r/20250806083017.3289300-1-xu.yang_2@nxp.com/
[2] https://lore.kernel.org/r/1c352c2f-c8b3-4cbe-9921-8ba5f0e4b433@lunn.ch/

> Sorry, but i've asked this multiple times. You never give a good
> answer, so i'm just going to:
>
> NACK.
>
>         Andrew
