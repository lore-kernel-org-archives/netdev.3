Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660596;
	b=TUxrxoZsG2HaYcZmGKBRgCbcqaFKFP4+TWlnoRwsDIoJCrS/I0hkxcz8aH8gR4/TSpNy
	 fcD+e9Llk4+M5V+AJ/kftbredYcvyZGM4Vl7RVddnDmvwFofgZ1pgVvrM0gv7sjhaYoaK
	 2f8NOlJ2jJ7OAjdJbknqFpGSePIiv3Kp7aNewwzYRMwYxVi0uZOj3CSFqFHzWl/pFPkYI
	 jUzO4sbify8tYq6f5bepNKQA/z61NNR4I26sImR0o0YWCFc1b5mI/ynMxychVWO+NPwAi
	 Z0eELC8nY+wjTH2M1FRGAjOPIzZBc9FB1qB0bk/FC7zt9kXrw8a0eVYiRGcHXEQ/IIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660596;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+AMxaezLFZtkF1EvuUK/tXZzKytmFsqIBjzoA/zZ63o=;
	b=VgJsZLqa7vzj/ZJI73Thisfv3pc3p8t0hShInEyk/QYkSrD1yP13WFkBT0ygdi4m3ypZ
	 r4pbBvUHuRl95YPT1d4UJhJX0tgQOIrDqjtxXvXjSbXv0UOh/5XKCQfbP1DFDgArNfW7Z
	 W6NW3rLW+QJ2tTxhufbK3/SYYC5b7v63KIs8XelQ2eWf7IBdeREWixdv1R5jGPo6QatNJ
	 ZnEVnmohy5e05NrAP403ta4DUSoJXix58a/A3m7wHK8BCmLgI9fxyeLWPHrWLX73Iny8o
	 jcu3oQGJ8jf7hgwgjbrfS1GnJe1jZ0xzF45G84wGVgEQPXQTDgGy63wMH3A7iGhSFrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZU1HCeFp;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F14606A31E
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20F14606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZU1HCeFp
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-18cdcfc05ffso1771327c88.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660595; x=1793265395; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+AMxaezLFZtkF1EvuUK/tXZzKytmFsqIBjzoA/zZ63o=;
        b=ZU1HCeFph/wJgGTzVZkhlg9w7trEg+OTizmdm4p17VwRxNxVeJcfgv3xxyI1dov+d0
         nGR/V5KoP+dm+xbTkZMoZqOM7eI7JGMva5TYXNTZVtrn+WiD9tm5hduEFAd46JI0kW36
         kmoH6LkXRygjWw3CyqeXznsmRaM57CpaTdt7UICJ6h0Zj1QMuardelo7LYXi5IUtiyk7
         nHEFw9HV09H5APytB7OdSPf4L2TGV3EFWcEY1UpjBhV2YBQxaSutYAuZhKuYipKQS/Jh
         GJ2qM1cVALmfMGH2I9KuVHUprZRv7v+tIFcfoAAQmxg64UNXjlAYl+5MxaEDfBmK94sW
         RnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660595; x=1793265395;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+AMxaezLFZtkF1EvuUK/tXZzKytmFsqIBjzoA/zZ63o=;
        b=JQCINNj0L6ZfA+/gaknkpKrEGC7gcjPrKDBcjaqn20n/K30RB0CvEVz0d3ki+O++WD
         ULw+mtAZqqcDT8HTkXIFQ8wYwFSnBOhJOUVjF3F1HvfgFmNOO8FsknLTLLOwSWW+P71D
         zSUwH/37v6DKz/UdcqZwuvw8Y9dyx6qW8EFEoOAxTy2WrR7x54caX7VOwMD8pM4GHf3K
         ULU5hqPIXxKGmqQ8/sXpN6pkNtyYPwirfgALRGfSqtz4EsJZ7L8GrLZja5+ZWEoscja3
         tzg/RLTrF2H/DR3PBoJkMs5k16Io6CcG5CEDSdgQiGmMLiu9ZBc3CUUCTVqZ5ClyZO5d
         ++Gg==
X-Forwarded-Encrypted: i=1; AKwUvBzRGbVpQR7Q1mUTHmTDH2Byoxiu4Asm/CdbmqArt2NjwegWD/5u5pd5XRGTMfVpq53qMPgBFBo=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7DpNc/EV8c6ISa9oL1UZotoxejL/UNEQ0+xYtzuG9qJrtirMm
	Dnk1go7EpSgU0VUoKYVKtppGvtGveIvjaWW5tNi/Og++0d2VG/27dVZg
X-Gm-Gg: AYBFou3/99Cujl/y5LI9v+iH98PKGLRlnTCG6qHN0qKuOBgr0fV6klDCLL/JMkrexM2
	QtL/lxiKpYX+AAYeq04SbuQzb+ji7nUXugCP2nbo4Ayfm3LdeBo/G1WSbU5xXFAq4Zksu9aitID
	Vu4b1oKLlWSnN1JiCCH/5bfLtutlgxUxom9zdQdMlkGtK9HVNCCwqWQ3K4xWrONn0+eXFex5X8w
	LhzCl7+Z6tnY53gUffk13shkH9ib9F6Tuffng196enf+27HZyrfj8WJZIcMprtf7NqRVmfyFkf9
	2bCYC0j2opPlYV7nCKb+oHdhuqE0xW9j15VWSn5LlUQQgQ/Qv1H010OakiwJG2OA2KOc5qtLLNs
	ZATBAg46y5UNK8xHeJ6V72QKKi9/HYpEfXzWBzaLQtWgShUwX4rOcXlHPJ0DSR9lnX62i7yrg4z
	icfZ3C1sg9FE/5+kfEl6Ok/j21eOo84oPLoMdE7X6fmSYem1gzVehM36o4wpwYTqtPPepEa5Wdi
	UjfqK9YizR2hOdwY/e6SMXPR1vEoaV26q14M7bI5lBDihmjmglOifnCPgOU7xTtitThmuAbFEPZ
	R+ZaGVWe8nvECNZUxLFpfxu/uyCZPn2rJz/zHS6x
X-Received: by 2002:a05:7022:407:b0:14d:c7ae:85dd with SMTP id a92af1059eb24-190a52e2836mr8053196c88.7.1792660595263;
        Thu, 22 Oct 2026 02:16:35 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903b3d0530sm13702627c88.11.2026.10.22.02.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:16:34 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] net: bridge: VLAN range notification merges unequal state
Date: Thu, 22 Oct 2026 02:16:29 -0700
Message-Id: <20261022091629.3652038-1-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

br_vlan_fill_vids() encodes per-VLAN state, tunnel ID, neighbour flags
and multicast context from one v_opts, so every option must be equal
across a range.  The dump/options paths enforce that through
br_vlan_can_enter_range(), but the old-style br_process_vlan_info()
range loop only checks whether the request changed PVID/UNTAGGED on
each VID.

The old path can therefore merge adjacent VIDs whose state or tunnel
id differs and emit one range carrying the start VID's options.  The
notification then describes a VLAN map that the kernel does not have.

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1.  VID 10 was FORWARDING and
VID 11 was BLOCKING.  An old-style RTM_SETLINK range request changed
UNTAGGED on both VIDs:

  one RTM_NEWVLAN: vid=10 range=11 state=FORWARDING
  dump:            vid=10 state=FORWARDING
  dump:            vid=11 state=BLOCKING

The notification tells listeners that VID 11 is FORWARDING even though
the kernel database keeps it BLOCKING.

The old range path must run the same option-equality check per VID or
emit separate notifications.  The February 2026 expansion of
br_vlan_opts_eq_range() for neighbour/multicast fields did not add this
missing call; I found no matching fix or CVE.

The PoC and program/console logs are available on request.

This was found with a multi-agent workflow; the
notification/dump divergence was reproduced in QEMU/KVM.

Thanks,
Cheng Yongkang
