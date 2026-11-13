Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559754;
	b=Kbj3wSSoSoV/T0WCmq6lSuyrc0p2Pl/9mrniBOFjD9C0Ou+MWauu6E/jv08kzD3tZQbk
	 kPCED68K+gkEYJeIJ2c3TfuDvHQne9VKwCBXTsjO1l/kxFUFXKW3VCRNQoGiSyvW7aRNq
	 DytqOz9TScmnIAioIVHyfadbDG2jz4W0XObOR/t1q2X/eFPiI+eO/B24F8eazmrVt0g3C
	 +76IeD3q+ibxTbvZ07Rlx3BPNancT2fVjD4Gg/HkeGFKSJUJhsNPsGOPx22MwfAu1DVpa
	 QZ3lj0xGP8G378lPzAU8S8QVbncjg4cLkrKpbRtnX5P0qAaJZUnrTXo0Tu+FqVNbpLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559754;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=CxJEPSxKZkA5JInxRotIu8NqmleT1f29t/E9d4ZVi80=;
	b=XXbAAImf9iapnjLhEMzjgxCir15Eg+yEtyr29KonOZ4zD6v8+q8Z0sGEYsxsARPxWFYf
	 ywqYTkdDmplrI69XC/hR3uHRzLtxA82ytXyv9wYBO2EwhT1RERMJ/k8NrVJqyfPxX6XVX
	 EFvFBETfcREExoI8GC+n2Zad7Cs8Uc0BxCGdPuvCyQ7rGEkjT8RdWKFdwLgyxnAXMLZb0
	 IVnkKuxhxtE28Dtn81l203GrzJt5FBRvAeugOLeC5oCgQ6Ae5dikWAx3AkqDxDwfCxST0
	 IlQYB97+5MmFNd756OUDM0E7akNKfRrhcRfLfY+kf8Pf93SmLB42wjSqbKmkMCmRzZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DE7Oc838;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C69C606A880
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 08:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C69C606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DE7Oc838
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-8615687a9fdso907647a34.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 00:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794559753; x=1795164553; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CxJEPSxKZkA5JInxRotIu8NqmleT1f29t/E9d4ZVi80=;
        b=DE7Oc838yKNszWJy1P1XzJd6Wq2+LyuJsByCk9qAizJpewW87iGgH+RSzzkiYFQlfP
         g6e3TI80TiSu2JKvCdwAiDHcgcksrd2eSUFt0GDHVVD+9VkHzfbgfeHK9ekPvciIlNX+
         S6MFCnL2AwaXzKKb8jz+N/qFJe1m14U5x8blA/hlE2kJ07h/OdjHgTepC04mYHux63Mr
         iHoi9GZbXSQ/6NBevQQLwTNmuXr3tTq/zszPbGTel4sfBSqv8lhG1xf4xCL7/jtfdbBO
         9e7faft9PmGkR5435uQYufb+8jtP5J4LdrZ8B7EFVXlgZJABUZa/G37CCMuQkEEPEeIv
         Wkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794559753; x=1795164553;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CxJEPSxKZkA5JInxRotIu8NqmleT1f29t/E9d4ZVi80=;
        b=S/KFJLjon8e+4nWx4CysGb0YIjoZ2us3fSWcNwmA9fYcZNgybCWwwrm6hgqnit5UU2
         C4AO+Ss5KzOuKhnxkbMuSD17AIyIe7qg00RzIFBbDb3y/Jd0xwPYp3APq7VYpPkVPZoP
         xEsWHB/7W7Ex5sWFa/oLiGbbhkyMllZng9UkoIQTM9Y8rjG9AJhG3GGgR7+35TFJIGA6
         ObP7mYZ3efM9W2LqH8jTyn6kllArACs88iwiWgmjYYyWLA48ZBrez6P74gXcVi03NS+E
         y7iaaxRmreHPxARqMtzVT0DXFrBJOkUc4Qc/0jUnL2VIgltcy9SpupuNZTh3p4a7xzA+
         HmpQ==
X-Gm-Message-State: APuU4Z+GcaeoBOFx9o0Q6xPnIBRBEaspfVwcWlR3ID2gRlPGVm8skElG
	o6kHDh8gxXZQtDykJOod4iI+I7xKyNeMUSGL5vHCJlJJ79O3eHUDUdeN
X-Gm-Gg: AYBFou1Uj+ZLZ2Fe+cmbD4donTkmuQulRGp1METQiXMuTRdFqwRvMxJRe7Vuv2ktDIb
	A6wY/TLZAeWnd1INwtAxhUw48imNrJVF9Un+lFiHASgZt2khvCHQ4NWZY6tLWsQWqTcS/+99zoX
	k3W3uoXQ77VFKyWme0XAocISA1Om1IGC9CgycK7OfHzZORbe/f9NqUoAtIaTlFBwUvNWBGf1ukz
	iJDjvW05L1RScrv6Z5YnH3BvbuIZMAySSlWCi0KTG4dZmLHfq48mpu1l57rFihDlBPYvo25etSP
	V8QKhVm+1mHHC+ODsOazIYJ7ZZT2On/8U1tlOq6lxVByTdKCjIizspHyl1wgnwuoemRVo4BfqyX
	PpdhHDRLofW7y1E7RBKjtNY518bxQ8cGwUL7ia96RocBOWE0gh4CFGcLcaiA+CfpS+lZeStBh7j
	ZmVrCk6GPb4fR+WBCkKo24X3ViQYi+XRU9HL7otNmE0j3PjdT+o3L9i0HXG5WZMi203w7dFe8YL
	mpZm+QcnDHIJyvyhht6EsE2rOaruabuCAnGXjv6ACvUsunzuXDWrda/lC0WA45ayil4IQG431Tr
	wOQkvRwFa7hf7i/ZjmzGvGPpuNnJ4xa+/ncmKE5SLDg5k39C8BpZzqfxI18h7KIQPvc9eLAjQqP
	Iawf4eNxFc+Btj0gndKBFLWZY/jXwfBIk7vWt/LHhr3O1FbH41GJS81EER4GO8hrcUaCqBa3v+Q
	nGs+LLKFeeKG3QTEVXOFRybeg9Mq1+lnV6Apl/IO6y7HlaEWJ1yMc=
X-Received: by 2002:a05:6830:4c03:b0:7fa:ac4f:79a with SMTP id 46e09a7af769-862898708ccmr1498843a34.22.1794559752867;
        Fri, 13 Nov 2026 00:49:12 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8628817d979sm2034202a34.22.2026.11.13.00.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 00:49:11 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH net 0/4] net: phy: restore driver state after userspace MII
 resets
Date: Fri, 13 Nov 2026 01:48:39 -0700
Message-Id: <20261113-submit-phy-mii-reset-v1-v1-0-02a55f352a91@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQrCMBAFf6W8swvdCIL+ingw8WlXaCzZWJTSf
 zfqcQZmFjiL0XHoFhTO5vbIDXTTIQ3nfKPYpTFCH3aquhV/xtGqTMNbRjMpdFaZVTTumXqGSFW
 0eiq82ut3PiKz4vSXrb8z1e8T6/oBsefl/IAAAAA=
X-Change-ID: 20261113-submit-phy-mii-reset-v1-1b9ec0e2be11
To: Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michael Chan <michael.chan@broadcom.com>, Hauke Mehrtens <hauke@hauke-m.de>, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

An MII ioctl reset needs to restore the PHY driver's configuration and
software state before the PHY worker can access the device again.

This was observed while testing AC200 receive statistics: a userspace
BMCR reset cleared the hardware counters, and the next update interpreted
the decrease as counter wraparound.

First remove b44's spinlock around the sleeping phylib ioctl. Make phylib
propagate failed writes, wait for reset completion and keep the PHY worker
disabled until driver reinitialization finishes. Then use this path for
phylink BMCR reset requests targeting the attached Clause 22 PHY.

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
James Hilliard (4):
      net: b44: keep phylib ioctls outside the spinlock
      net: phy: propagate MII register write errors
      net: phy: quiesce the state machine during MII resets
      net: phylink: reinitialize the PHY after an MII reset

 drivers/net/ethernet/broadcom/b44.c |  4 ++--
 drivers/net/phy/phy.c               | 42 +++++++++++++++++++++++++++++++------
 drivers/net/phy/phy_device.c        |  2 +-
 drivers/net/phy/phylib-internal.h   |  1 +
 drivers/net/phy/phylink.c           | 14 +++++++++----
 5 files changed, 50 insertions(+), 13 deletions(-)
---
base-commit: ead6fa9a0ab194f02a2f36d634b193e9c5f9a1c6
change-id: 20261113-submit-phy-mii-reset-v1-1b9ec0e2be11

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

