Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9A33328FD
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 02:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792377879; cv=pass; b=XJSTF76NbqjRgnJKGbretc/AOO4rrGnNPTlpcDmldIN7NGmZVjdR/YC5/da88ZyON4f2z+u4+I8SQZfj0dbzgKCMRgEaGrFvrVwPiIwJ7dIk8rzAJGorZgY4pVmmepGjkJdrHWNrrdHGXbwyEpCQQAFbxX9ahHNh5qo7WPFRHRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792377879; c=relaxed/simple;
	bh=H8gBL+Tbkuh5ikiT/QxIWPCRO5HignGSZr/FBWXq8ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LL1NluqBEj3poEHuMijngInhNKzUW8M4LI4bLoFUxM6EHPHxiNe0Rpkll/Lm5UP9XbTxRZiThBWu/dXdRWheuYfLS5hHJ/grl2Yz7CwgsvlP7l7KVjigXJ9PdVjWqOJSz5reofjCtIRuIEPIKhkNwUCpq1lOCNhJrDMU+7rOP08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtiXZ+l/; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtiXZ+l/"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c2a4e013a44so186727266b.2
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 19:44:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792377876; cv=none;
        d=google.com; s=arc-20260327;
        b=i1V5HfKKni3MAMfwVBNgxRCuwE5StOx51Il51uHU56SVC2sItFThe0HMyQJh4V1VBL
         QnfNxFse+ewo9qfqzVzg9AjXg9RdH4c+eM4cGRY/DltlbVdvH/tiP+rZOn11eM9+l7+q
         Duti2o9G1cSWYvNJ/syxvm58L9Y7rSGW9XPmlE8utOLcsbH7SFknu+vjzmH1Nwg9iADB
         mZnDqL3buppAxZZJEk0F/0gdcOKREca0sepkNuIb14XANS8Bo6C+SXACZ1sgrWntxfP4
         1RA2aaqrpi5QM6BuhCP1w1X1rXtZbCaTFKsLllHODndaq2cqElcZBMQgo11UjRLqhJGB
         C3yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=H8gBL+Tbkuh5ikiT/QxIWPCRO5HignGSZr/FBWXq8ew=;
        fh=uKCSp8/2t+N4YHdLiKKFs7fISgvLS72L4KwSYsKRSkM=;
        b=fStY8aMQqjOK1W0FUDTbG5w9Of9nag2phO4Rr1bVnJGXxEKEfxWt5RlcxHIdVryECl
         6KwIWR+8eSTgOP11ky1Yu3fKtVZxMJMxxS5hqUkNr7HPblJ+LRgQD/a2oo/TJaBsUzZ1
         C9GbINYoQwz9MrSx61oVcqk+fRQfx73vrmH/Z/XGsuS558MlMJw1337Sm+aW2qRrAGt/
         c5RZNZk9VBh/dY2RcU69crqFpIrYCAr85WQGC3Tw0CtIid6trLk5zFGc21ch577keBSj
         OnU+w2r8ydNd7hx2DjBeeWoO5EYflr+dF2CWr1URNgnbTtB2GsCwqy8IzsbdwzeuLqPo
         j6xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792377876; x=1792982676; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H8gBL+Tbkuh5ikiT/QxIWPCRO5HignGSZr/FBWXq8ew=;
        b=WtiXZ+l/Nf66nKHzqyovBo8zxcMaqmMLuuff89h2r4oQSCHcgdRERZuncEEFyRGuAm
         Dj+Qat4VNUeqV5n7swfSgHhp1nocnOkMJGePTYxP4w78WBAuMKfW1YhT97M8vayXP5LL
         3rn3hlFFZlhfS6Q3u4l8vr/4RerFW1uMEyumrPd7VIp2j51rmCtRt98gBWVa41TeOgq5
         3PnJZbbr6hLcdrHbAfAikbiErUuY36y2ftWqKQNrowtv9QLrY3pvXn0P9oAfPh7WfDXA
         Z8HfPDPPzCSfweJu2gixB8TIwj++39TxrKZVY/X1+kgsF9HONQOrzXvYVqXHN1rVwMM9
         NXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792377876; x=1792982676;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=H8gBL+Tbkuh5ikiT/QxIWPCRO5HignGSZr/FBWXq8ew=;
        b=0HINUrLZRbI7F2HnG2mpK6R6JQvzK00Dll8Mg9BMVY/PTBB95WFogK3GfDxpF1j5WD
         RR2gmmhQjKUJj7kekumLfpOJdsWIXPyXpQ/OEJANuWRQWrB2cN9VrnvKj9SyaclIt5qr
         sr2bAzUC4Z43w0tC51lhX4EfVJtwhg4B/llLdG4GbyajUHpPo0j/vGmaGeD4XaEZUJAB
         OiHiUgLIUuiLNh2Z6P7xsOIlQPgkT1PGHr+1gxQLE3fEoGPAePeR0HzelXNhDZ6utXSx
         HdIVOk9/EGrBTpiVlLJb13pJnKeXdiH/Lu/A9Vp3/iHpoKI+bAyNYoEQNovjh17YpCm0
         HBEA==
X-Forwarded-Encrypted: i=1; AKwUvByAxnBQoDfD4t+9qF/BKWt9TC3vr5NyJfJtxazkJvPX0W6pZO9Aj2IFNwOZvM1wwj3B6LjL5a0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLBsNzN6MOmanKaDAzCnsw50NfsrMmt0GmT6K4zOiSPtZZvurg2
	/KPMe1P2U0CQCbgrCSBbzx0PFsNPHCl13bgbevzldYv5UQrtZ9hGhfFCmpjeUb2HrBkQ/yFK1BL
	0nGPu40BtO7ucDOCN85piXhC5VdCxiQU=
X-Gm-Gg: AYBFou3hZBcBkuFKnziOB+V3Miw9GTm+KiQ0LxKFZ2zoPE16VQOO9TKz3H+APF8A1Zq
	JgjQ2moi5QdmepPKNFp2yO4vmTN+ce1YR5HN4aeYTugvJ1Vlmhm2XW7ko6DPmRPXIpWbYUHEMuk
	BW5A/c7u2tcYqZY1+ADfhJcaVlmxzYkpviz8hWOd+vciPqrfK2OR4iexVW5vrBuzOlSa2AT31yJ
	CA/sbhIFhhPsHmnhSGlVyWWE/iNOHfAmZ6uXSGnLoQC0bsa8iHhKoAXJGyzvF492nsT10rXIxU8
	uDRECxHLPgQTclm3QhGrwHbubNLeYWKczHi1TAhurlbz1QwwUoiD7hwtEzZFRqPNk9tmH3xcJ5e
	fAt61uQ95gtc=
X-Received: by 2002:a17:906:ba88:b0:c29:3c97:c994 with SMTP id
 a640c23a62f3a-c41a06e6f22mr428888166b.35.1792377875551; Sun, 18 Oct 2026
 19:44:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5a4715dd-89e0-4868-9ffb-c8fb73b18d04.ref@yahoo.com> <5a4715dd-89e0-4868-9ffb-c8fb73b18d04@yahoo.com>
In-Reply-To: <5a4715dd-89e0-4868-9ffb-c8fb73b18d04@yahoo.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 18 Oct 2026 23:44:21 -0300
X-Gm-Features: AclHuK932M6q_zkFu_mbN1a4J9J0hT7LZ-thPB6vZAsfRFyFX0Tnvfr-Pqnzhzw
Message-ID: <CAJq09z4kKcQ+idfP+19pogi-H5s07SgKO-CGg7AWX8An-9p4Fw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 0/9] net: dsa: realtek: rtl8365mb: add support
 for RTL8367S-VB
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	linux@armlinux.org.uk, maxime.chevallier@bootlin.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> This series adds support for the RTL8367S-VB (chip ID 0x6642) to the
> rtl8365mb driver. The chip belongs to a new "family D" that differs from
> the existing family C in its VLAN table layout, speed/RGMII configuration
> and SerDes (SDS13) handling.
>
> Patch 1 documents the chip in the devicetree binding.
> Patch 2 adds the chip family infrastructure (no functional change).
> Patches 3-4 add port speed and RGMII mode configuration for family D.
> Patches 5-6 add VLAN 4k table access and raw-VID PVID handling.
> Patches 7-8 add SDS13 PCS support and re-latching of the SerDes.
> Patch 9 adds the RTL8367S-VB chip table entry. It comes last, so that
> no intermediate commit exposes a family D chip with incomplete
> handling and the series stays bisectable.
>
> Family C's functional behaviour is unchanged. Changes in a shared path
> include a mutex serializing SerDes register access, as well as
> .pcs_disable in pcs_ops and .conduit_state_change in dsa_switch_ops
> (both bail out immediately on family C). The port count is capped at 8
> for family D only (patch 9).
>
> Tested on a TP-Link Archer AX55 v1 (RTL8367S-VB, CPU port over HSGMII
> to an IPQ5018) with bridge VLAN filtering and per-port PVIDs. SGMII has
> also been seen working, but I no longer have the exact link partner and
> speed it was tested with, so treat it as lightly tested. RGMII mode has
> not yet been tested.
>
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

Thanks, Mieczyslaw, for working on this series.

Support for Family D is very welcome and increasingly necessary, as Family C
ASICs are no longer being used in new designs. However, the current support
still feels incomplete in critical areas.

When porting a new switch family to rtl8365mb, each feature and hardware table
shared with Family C needs to be verified against the new family's register
layout. In particular, this series leaves rtl8365mb_l2.c untouched, but the L2
table layout in Family D differs from Family C (from memory, the table entry
format is 1 byte shorter and the bitfields are organized differently).

Passing basic traffic in a default router setup can easily give a false sense
of stability because the switch starts forwarding with factory defaults.
However, as soon as DSA attempts to configure FDB entries, dump the L2 table,
or manage multicast groups via bridge operations, the driver will interact with
the L2 table using the wrong layout, causing silent data corruption.

To make Family D truly upstream-ready, we should adapt these shared components
(especially L2/FDB handling) or, at the very least, explicitly return
-EOPNOTSUPP
for unsupported operations so the driver fails gracefully instead of corrupting
hardware state.

In the cover letter, you mentioned the test device. Do you have the Archer AX55
on your own bench now, or were these tests run remotely by users?
Exercising full
DSA functionality (FDB add/del/dump, VLAN filtering, STP, flooding controls)
usually requires a dedicated local test setup where you can generate, sniff,
and inspect traffic directly.

Best regards,

Luiz
