Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA823E5A19
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 02:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788748123; cv=pass; b=A+4tU0ATpEFB32qNNLE7PZhUdhT+HTHvTJhfjSt4/0yPW3I+KuSn1CZ5H1hUQDoKXf/Ql9tAMNCsfWsWJUA0Ed12k5EXDAnaXoaVn97ilDPHyetUlpO1yAJcBAUvwO9O4AtYDSP0Jm6ebxNqUwjReZnJSTQ6QS2RevMFImRWsbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788748123; c=relaxed/simple;
	bh=xaDigs+YPMftKzlU+luPuRXiinZXB7yVOimMjfEfb10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m23MdqpKaorHiTwB2DvIcQBx+4ufkusfT4jntXK5AL6IopLtURJoC+82wJ6huBvH5GzR8Kj43NvpQdtdh2jiKl3H/gG5qO5znNhXqvfhqXLhI/RBcAMBW9BiKWytBYSRf/TEvCMDN5+PqFjPXhAEs6Z5vvwPpDttF/Pr+Mh839Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3HCh/7O; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3HCh/7O"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d5335cf904so29538485ad.2
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 19:28:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788748122; cv=none;
        d=google.com; s=arc-20260327;
        b=LHfbCarHorRmn0kbR0zPVszxImL5/P84GHkmdqDpP7fscy52jSL7/xkwKqG7lByUHB
         sUVhFAd6cc/Nr86OKo8ptYc836Wg7lTA8Sjz9uV0Ns5RfJukH1s+Pv5o3j8tKtgUraRz
         3Alu64rfSStB2kPxDLSvmbgnmMbD+ibAHEDVLwiFgK9racuwx5Pkno2G7SOgccybiNs8
         FBbKxyC50qbZY9/BupZlN8RtmzztTuWvdNeUCMDmO8a/WqNMzth9tgypxJqKLAZJ+Z5Z
         slWeSxIhlUbAwYAdpKSHAylM3oCE2OTwtwsh7M0yj+++IMDCmBXcXuk05Or4jEe1FBJA
         cTdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xaDigs+YPMftKzlU+luPuRXiinZXB7yVOimMjfEfb10=;
        fh=8F6RgkOYPuOchPwRV21Fk10DIQiel3HR198YOSg3dOQ=;
        b=K/WYhH5tXdx8Xux7dWM1hJ/ROOGDEOjvGBd/0B1E8P+wJz1tonlYmrGlWfQnPmTb1f
         bzsQDuUCAVIU7wzK41aCxDdqQzc0x2xpsfbiTsdB3kzdo30BchV2x3Ppbj2RV29Y/rcy
         dDH/Q0jv1Dousgub7pe1hG/TUL3XS0aGu3eZRlZH9RwQ71upKdRXieGWRmcFGu5tZNwc
         e5R3GNOH0TUskAG7zIcJBtyYqbiIrIlL0Tyr9UB2zHaD5P2UMsMJpzY73M1lvR+ttIEh
         X/jtToXpfbx7lmcGfM3XWRZLNcz2e5pIfxbL4Aut3ZFPrwEsxAR5IlUHHDUPCohjA5Bq
         meIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788748122; x=1789352922; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xaDigs+YPMftKzlU+luPuRXiinZXB7yVOimMjfEfb10=;
        b=O3HCh/7OjR9v7VuPiINgLCKklDTk+L/8CpWGlMmvvDFWQooaRjyMLNbP4lF1/iUDr9
         ZTTyILY9R14Do1VJ8Nn3qedbzltYNpxBsCazfPM/TvptqORf4R3d4rG6fVCFvCQ8L5s8
         4An5mcA593D5EaAEmK/k3/WQE420FEKVmaWNBG0jv8FrzEQvSTBQ3ESHV4FXrgRZgsOu
         YLyTW/o0eHbgqH7p+wmkPqIMLBCX3o+WewHBSM1AbGHFOsDyEnsyKEiVG8KmzZuzLrRZ
         FJoNUKKGd2FwHfD32Mx8mvhb8YOyWMm1exqqBMBi5b2pp1/7q7JX5O165TmJLiGB4cpm
         sVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788748122; x=1789352922;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xaDigs+YPMftKzlU+luPuRXiinZXB7yVOimMjfEfb10=;
        b=SgZ/k+TWo7GQQSQuicOldzj5RLCC1k3jZjfYlehsdPEeFwXoa69l70qZ8IdgfjEU/u
         AlICt5zQw2zlRMwdZ5ZibZ8MRTdHqALxFh7KHT/od1JqReb+vz5BjEaCdmprtrjf12MT
         HtOxrn1Xj/Krb4rNfP8QK/4d7z6Uf0jEDxpJlDtqjiOkrqnkhFQ9y8KvkpCgV/NeyTrO
         ULjX2bHWPpipWP59YaOzbH8AcTrqjN4hIsO3gIED8WVCiCBZm8SNQmc932D3INbAD/Ur
         BUIul5KeyWFk2Ozf5M5hsSNHaTA6EfHQ3nRttr/12Y0G4VLivhYKmHEYH66QDbipXwss
         Ptrw==
X-Forwarded-Encrypted: i=1; AKwUvBzkQ91vRLPoSSG2WzMBzqqzPUfHhYQB0VW/R7a3Q6/CPJgTP/ZGJRfDN2z5ZKp6t6xwIlLMAIQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nPMn3r2yqFpoC9xggogAhZMOJsE8AA9Cq3Z5MhzyCfTouLc6tL
	RwHEQX3wrWC73kmGYLzeuwHNtzK3CfLvIwEr+Pn1w6kdoTTYwdeRCG1WhaNlLTmZDd2xYd+DGBT
	UrKQ9f+5WAYt1roeNyiywDbB6F8qxIPc=
X-Gm-Gg: AYBFou0i2aqc7O1fa395G1x2iJjqnVoCejDzPg8s3V6jggOKiERBo2e1XI0nx3eW5zb
	BU/6YsN3+qvYRteqypiMwLOAH6OYMZJehGDB7y4A0hxoeDnkKTDStspdopaxx9yILFeFAnZibhf
	bOtb/PjuFk+5nm06TyrNsxYcpMzw+BoT0xmCYfYiMzfbsv2SZRe3t9tdhIZc2wKNG9GN4Uq2M3s
	yWoEqlH7HF98o90LWpbDs40ObgYpiHmnqjxd1B/IG10yxGD3OFai1IMxCSyNjANO8zhFleNhvtn
	iKaLiyf49u0UQAPWLkl9r6kXTjPtb93qn2EaOfkDqSyDWe5Op4x5+1qKQBWxSkU5w69D3BrTYg3
	9P55aBwLC+tDYpCik3GeySn/CRtlLlkysmETgPbTGcWAVz6ZI4J19fkRP
X-Received: by 2002:a17:903:2349:b0:2d0:cc92:f7a3 with SMTP id
 d9443c01a7336-2db125a5535mr296058245ad.2.1788748121672; Sun, 06 Sep 2026
 19:28:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904105542.70540-1-phucduc.bui@gmail.com> <20260906131711.247708-1-horms@kernel.org>
 <CAABR9nFYrmteCtb6E_txg13U31Bf50p0PUBvaOXi3gmT7Z+0RQ@mail.gmail.com> <GV2PR04MB1173965A34420E072C0DD3A1988B22@GV2PR04MB11739.eurprd04.prod.outlook.com>
In-Reply-To: <GV2PR04MB1173965A34420E072C0DD3A1988B22@GV2PR04MB11739.eurprd04.prod.outlook.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Mon, 7 Sep 2026 09:28:30 +0700
X-Gm-Features: AcwNN1WcmIfrIxdZpRQHswHCpN6F3ZPaKgnosKc26H5L6i-cyqOgzdxXQl4mPdE
Message-ID: <CAABR9nHUXPL8dV8iqJ-x4OWRLw-qRm8MTq_QDTEJ94WhLWRiqg@mail.gmail.com>
Subject: Re: [PATCH net v3] net: fec: Propagate PTP initialization errors
To: Wei Fang <wei.fang@nxp.com>
Cc: Simon Horman <horms@kernel.org>, Frank Li <frank.li@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"richardcochran@gmail.com" <richardcochran@gmail.com>, "swboyd@chromium.org" <swboyd@chromium.org>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

> >
> > This is a pre-existing issue:
> >
> > Previously, I suggested using request_irq() and free_irq() manually,
> > but that would add more code.
> > Another option is to replace alloc_etherdev_mqs() with
> > devm_alloc_etherdev_mqs(). With the LIFO cleanup order,
> > devm_request_irq() will be cleaned up before free_netdev(res->ndev),
> > which should resolve the issue.
> >
> > Since this is a long-standing, pre-existing issue, I think it would be
> > better to handle it in a separate patch.
>
> This issue is currently being addressed in another thread:
> https://lore.kernel.org/imx/20260904-fec-ptp-pps-event-uaf-v1-2-9af446be4a11@cherr.cc/
>

Oh, great! I see it now.

However, it looks like that patch does not fully address the root cause.

There are two places where devm_request_irq() is called:
For PPS in fec_ptp_init().

In probe():
devm_request_irq(&pdev->dev, irq, fec_enet_interrupt,
0, pdev->name, ndev);

The approach in that patch only handles the first case, so it does not
fully solve the problem.
