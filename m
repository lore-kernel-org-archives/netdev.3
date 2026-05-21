Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCAD36215B
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 12:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367310; cv=pass; b=tAZnxEgenCKHpjYL739MieBZPPQG+JopXJkqzlyUCa9xhh4H+5CRVqKkC6KPd4CgBXCl8koqjyQQ8xO1JaOY8Vil7OLE9EK9TRUXcFTtombmtqNUFxTnrCxA1MY90nv4xB4zEdDMV/0EBCspJ0xlKwEvMZEJ59nqgUIXZQYiHUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367310; c=relaxed/simple;
	bh=ajNsPFWxi67i4bgMw3vkYCZO61HQjPsFiGOsP8Gh2kE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mhR/c34PhFdIOkPLT4dLdTxyuEncLmGdZNauxO1dwgqNZ1NkUdaAHex5/tITIJdCMJYIpEclfDlMGC/C3iyQTT4P32VLvKyLg6sdhEf+cAxOTlYoR6KAq/a218sgw+dYW3T392TlFnfAucQsLhvUMTcSY232DXSuGReYr3rzQqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2eALK4U; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2eALK4U"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a8891febd2so8462606e87.1
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 05:41:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779367306; cv=none;
        d=google.com; s=arc-20240605;
        b=b7JjY3PmrBYETZCqRfsA+Y4KymHLGqlA6kmUJMvi3C5q4rR3oQPS/cDVL4sNtP7ecG
         husdRsGLJNRorUekY5YuoxOryF3Ketw8x6ezuJgIhKHdSWEaQJmPMF3vSJG1odOmSkXE
         YLn6F0mMi1dREp5kOYfWE2Y2Qy7dNioYV1ttnwJNDRQHDBFkfurvHQYB/rnxUpnzBZIs
         Bf50FQhhAzN4ZYiz2T4RvugEywmiq5/LGfUTKQytOk2nr7J49rKubtlcpE1tnqNVBkGV
         kAiJEhGYNZW1SP/ZITtuTrfbo7xWB4i9Tvx+8hm7qqZbi/7JHY22thgpi0qXKgQ++qKa
         Ixag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wj8b0PInlbwEaQL2WeFM+DLmcZXYoekAuC/bTMttwzY=;
        fh=0Orh1w6plrrkZzB3sVTXmKLW5m58HOEGzOKA8R2AG4M=;
        b=Dp8zsNUZU5a0JMHYwXIuotOgF4fCg5yUvP+KEclk2JqfaHAtH48whNWVw63k/KNUcx
         bHDZ2og24gfdgpbKRDekY3GND2rQ8SW2sP1jfBkP8CnuXq5X1WaItTVqR/HqnSlGzchb
         S5y6x7rG5fE5jv1fFQpGUZk7vbhOcu+V3Ymkw87LkeN8idRTTAUcAE9NJx5sKefGhhR4
         +1fBilJpWQN5CO/m2mdCNMX9XErupCAABiiRKPlnMfURaaN0G15M4PDsdqrtXfCJlrx5
         irekTxnQje+rCVtICwoEkkQhBaX+esoSey0y6/CcHdIFBhGY/XBRIlu0SUp5bvUJtv1U
         24kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779367306; x=1779972106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wj8b0PInlbwEaQL2WeFM+DLmcZXYoekAuC/bTMttwzY=;
        b=E2eALK4UF2oNJKugR9N1qHNCiMYZg/DM/jpGJvKDKGpinboLNX+gDFNdSDKMlXVCuJ
         8hMOpJB0SR6YBr12CRFIoZsNsQGNGZLG0WEylFAlsuwCNv9O9MHNgt+6RYjI84mccAIL
         JaTeWlpTEJyBO5uY9ZcP3yVz80pJfbDXGG+Pmrq6jqgD0VrCx9kLRKDr8f4/1E4r9joS
         8NKuYa25+J1Q0gOA+0zYdoUMJx7Q4m0h2wNY1HXW3eVpVyFYM6evlAbRDeA+hNTr5ang
         uI6A9R9VyNuFzCozLDCB8aKREM9uDAnXv1QXcHamFkerYdbMIMy6WwobrDtlqg5UxSPn
         5Jaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779367306; x=1779972106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wj8b0PInlbwEaQL2WeFM+DLmcZXYoekAuC/bTMttwzY=;
        b=K8HLjqpKky7gdJpOjRBNQ6pHup1VniohMIy36od2FjVx3yzsoWSZbkdBsORnz2zBWB
         enoAZ0joBWK2NYoRlJZ7elf0gOZb+Uaq3cVErqsWx9jtAvxFKLqIEstJ+LBixT3YwhZV
         fAMXMss3UEeHgh+A3SulTBKUf1opJM8HEkhj042IgrVEVVTrpLyy8ZRW5GsF2fkbCayu
         56mNr6PQacwaQJs5ds6nOFkpQ96UDLtUhjIvmOmaqPEGRjTE12osQffpaGKXweXdutrF
         OTR9o3rqvR7Qix//utoPvyFuqVDF83cN7qUOSidkddxWKBrgf475nTPvkDtj+gQmmFNf
         Do4g==
X-Forwarded-Encrypted: i=1; AFNElJ+wz1OgKgHrhGxtwipiqzGU2q7eCQRv2hzQdz0gsgcNw9LdSz16j8n+yk6faUzO70iKlvjGq9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI1uqN2HIbMVABKI7n3ygDb89rLSpKS1lB5rJ2D9uGIEqIG6ip
	M9vzfCdD/Xe0blfn917VAr8E2O5SA03UTdq8lG7ylFmDhDMRLlckwboSZXat6ZvUphUcUvzhRAQ
	4S+kC9rwk+Md1E2mJFDqv8bRe5o9iQ9c=
X-Gm-Gg: Acq92OFp1awMPMDbOAjNPr6Cv06+ixCL6nkFxyIdGa8nGdNO8gsmduWe2byNYoaacs0
	GNIDUVy5mwF8ZIoLBZpKgCBfnbg0RjaJUrTvI2vRmz+hk3XMg7DkX+j0C5EPB0gh80A+Wczjwf6
	3bqlY/Q21iUJR6UHC4LIiWz9R4ly0Cy2OqXA7VVuoywI+4KqYuoGlEQXkjSRKoGiBenq2FEbdOd
	oCUGRw5Qr+goTCi0Y54CamoTFxQgZCjcsNT+UVnN4EU8whkgU1dmh2yej8bWIR5z0EfjkX6/s73
	5pUzwwtTSWhyITUc8vvCYdxs582i3EjtuiSYQog=
X-Received: by 2002:ac2:5312:0:b0:5aa:b6b:f6ef with SMTP id
 2adb3069b0e04-5aa2ba9ab5amr790697e87.45.1779367306048; Thu, 21 May 2026
 05:41:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520004244.55663-1-kerneljasonxing@gmail.com> <ag75Xicuk6JwkTkC@boxer>
In-Reply-To: <ag75Xicuk6JwkTkC@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 21 May 2026 20:41:08 +0800
X-Gm-Features: AVHnY4IBkmqbEX6oQILxsI_k8WLwSb3ijz5RH1EQPp_csx8ed2JTaWMUk7p7OIc
Message-ID: <CAL+tcoAJ3i-WGnVx-9ASF29gPNAaP2ucw76x3ftLog-b1TPf_w@mail.gmail.com>
Subject: Re: [PATCH net v4 0/5] xsk: fix meta and publish of cq issues
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 8:24=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Wed, May 20, 2026 at 08:42:39AM +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > The series is the product of previous review from sashiko[1].
> >
> > 1) META
> > patch 1: address TOCTOU around metadata.
> >
> > 2) PUBLISH of CQ
> > patch 2: make sure xsk_addr->addrs[] can be published to cq when
> >          overflow occurs.
> > patch 3: keep cleaning up the continuation descs (more than 17) and
> >          publish its address when overflow occurs.
> > patch 4: like patch 3, but only handles the invalid descs cases.
> >
> > [1]: https://lore.kernel.org/all/20260502200722.53960-1-kerneljasonxing=
@gmail.com/
> >
> > ---
> > V4
> > Link: https://lore.kernel.org/all/20260517063311.28921-1-kerneljasonxin=
g@gmail.com/
> > 1. correct the description of xmit path in patch 3 (sashiko)
> > 2. move set logic into xmit path in patch 3 (Stan)
> >
> > V3
> > Link: https://lore.kernel.org/all/20260515123018.80147-1-kerneljasonxin=
g@gmail.com/
> > 1. avoid breaking previous usage of sendto, and siliently handle
> > overflow case (Stan, sashiko)
> > 2. add one particular exception process in patch 4 (sashiko)
> > 3. adjust the selftest to make sure it passes in either virutal or
> > physical machines, which includes add usleep to support physical machin=
e.
> >
> > V2
> > Link: https://lore.kernel.org/all/20260510012310.88570-1-kerneljasonxin=
g@gmail.com/
> > 1. adjust selftests (Jakub)
> > 2. add READ_ONCE in patch 1 (Stan)
>
> FWIW I still get test failures (yes with patch 5 applied). PTAL.

Thanks for the test. But I've tried with ixgbe driver...

I noticed there are some flaky tests which have nothing to do with the
series. Can you confirm that it's not caused because of the series?

Thanks,
Jason


>
> >
> >
> > Jason Xing (5):
> >   xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()
> >   xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buffer Tx
> >   xsk: drain continuation descs after overflow in xsk_build_skb()
> >   xsk: drain continuation descs on invalid descriptor in
> >     __xsk_generic_xmit()
> >   selftests/xsk: drain CQ to wait for TX completion
> >
> >  include/net/xdp_sock.h                        |  1 +
> >  net/xdp/xsk.c                                 | 44 +++++++++++++----
> >  .../selftests/bpf/prog_tests/test_xsk.c       | 48 +++++++++++--------
> >  3 files changed, 63 insertions(+), 30 deletions(-)
> >
> > --
> > 2.43.7
> >
