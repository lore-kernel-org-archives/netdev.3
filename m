Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8F03955F1
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 20:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791233006; cv=none; b=Tj5oue21CGwiwAdVW8Npk2YgZdMNxmjMYHrsjepNvaQ1PoImzGZjBP3LCVLqnWppI9BFRGeOgBe311+VIVwW+AC2zYpPkWZK9IpWFawo0PRfrW7tJwqUbucji6Q8LekMNw5ddQ8UOCTPSUee2bnVGkO0qSt28TKtowfFtff7wYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791233006; c=relaxed/simple;
	bh=HdOsHIEF4mAjouq8GsaUcRgtiReMcVzhP6gLLshOi3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qoI9RgDqCM1YbSV73UQGd1+I97+ihXeQ9PtzSI8bC3pi4kQjmFBvGmPlaADxI9aOnXWTo2Ha1ROmQ6ZeUQa82+aQT/9qOBjOlhr/B7yzmvVimCxKp2tVc6LhZzeSRR9gwFSG9RS1P25jV5uL+E4X3JSFzx6rYfKGP+KO+6vMxgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Zb1zy+6N; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Zb1zy+6N"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2db80fcdf8bso3591235ad.2
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 13:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791233004; x=1791837804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7e/3UyeTvPJx0BNCHNJiQNlaQAdHMWfXAXVh4sYdnSc=;
        b=qhdN4CBYxkGOSj7ASJEm4fnISqyDt9Vf/jZXk7qKf6lbsweEh7JKS5hbHxL32gse+8
         dl9mFACsb+/Mw/TO6vORhX9tUSEvLiS7JwPaa1+O8N0RvNmxu/MpQaYZcecP7+izWyR2
         VIF6RKYCIa1fXN7gVR/Y3WWfhDbFCpfg03YdNrng4NUbT/gGQx+l4NDJs5Y1N+TS7Hw6
         4MQ1ZadeCW7Fu4NuTw/rQKgYenhcqho7b3Gs/+frdEfnb2bzZzcKkZ3baRDEgjlpcAd6
         /Fnp7j6Tvzw8Mys+TOlJlTdGGdg2DdW8/rUFBhkXQCk91aZ9HwgUp/CtGSAindSZNgCk
         tJHA==
X-Gm-Message-State: AFq9FYKJEGJ9lH/5u6CXmLMzG5KNDrnYxc25vv646dif58ux/3sY3DuR
	o1rYTjHWJMOPplXwPipbXcRGhO8IoNDZl3ht4AKcXII2DcKoOluMtdrUZ8Kmeo7RR5qm7n+m/6w
	8m9kxxNeQdq4bQ1jmsBengFAC50Rgd11oA3w3Lct2zW2OcrgiJNhWb8poIFfmB7oTfHeh0cqHPM
	HGfMPp6NMNeu9l2vILSV3I0Iqmxtz33dAiu+rEVwkz3Ilv4HHi8anmO33Uc92Xb5BTCcNudduPc
	CIlO2Muzeg=
X-Gm-Gg: AYBFou3pyxSPNfm4ZVDsqNx3dEPhNn1dVQXzuTx1qn0gS8iDxjYDAfalEAolGudSPo0
	lO1IOvH/Jo42jyI28jCWShGzgR5GxE0XW1uG2m3kWz3jOG/5oklGSt5Mtlm6dzBkrjzINvHUh74
	mBpNSOv3ygF8522audhiad93xKR6KRJHBpQnPQVtV+oHAM7FVE6+PUTHOUNT2EHHvC1wlclJR09
	dQTJ86xMI4QHi10U+MvXuQRvar33OuoABiRSj6ZthBeEUK0ofIDZ9LQ7juYUDYH8hvZSnr1QDbr
	+rr5oNBfiWGtVDlE10wPzigCoMX5aSPrO0QSWcTSsnKVUDWPln8Yc76b8n03aoghbXNgiXLn8S3
	9VDx49GNFWxWPBFDNRMDRmqyEF9ZWEhnOYyD77zS5uLlH2aI3UeYVyHemNk1RK3XeHM+rsXNE4G
	CqOv624/VEoNvcpujJdj9zvAFaAtI1CrWnOi8=
X-Received: by 2002:a17:90b:2885:b0:3a4:e934:e85c with SMTP id 98e67ed59e1d1-3a6cec77357mr5401984a91.41.1791233004272;
        Mon, 05 Oct 2026 13:43:24 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a8533a9905sm329904a91.1.2026.10.05.13.43.22
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2026 13:43:24 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5351f1b26e6so31802791cf.2
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 13:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791233002; x=1791837802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7e/3UyeTvPJx0BNCHNJiQNlaQAdHMWfXAXVh4sYdnSc=;
        b=Zb1zy+6NowO23Th2vQI/sdW8RgerDO04WQUeb0vNkTX1lm4E0rCjERUkkt84fnW1Nc
         B5vA5t9MVgr+IKvpXDzx1rgdp8fmQ7t4DLii95XlgPdtKEgaWt37JHBivWallhBit+Ca
         bBsWgr5k7UZzFIOvYhQkznS4/jMnoJImFF3BM=
X-Received: by 2002:a05:622a:2615:b0:535:266e:f123 with SMTP id d75a77b69052e-535266ef66amr110216611cf.11.1791233001985;
        Mon, 05 Oct 2026 13:43:21 -0700 (PDT)
X-Received: by 2002:a05:622a:2615:b0:535:266e:f123 with SMTP id d75a77b69052e-535266ef66amr110216311cf.11.1791233001543;
        Mon, 05 Oct 2026 13:43:21 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917d593b457sm96914086d6.4.2026.10.05.13.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 13:43:20 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	joe@dama.to
Subject: [PATCH net v3 0/3] bnxt_en: PCIe FLR/AER fixes
Date: Mon,  5 Oct 2026 13:42:43 -0700
Message-ID: <20261005204246.3822563-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This patchset is split from the earlier 9-patch series to limit the
fixes to the PCIe FLR/AER issues only (patches 7 to 9).  The other
fixes (patches 1 to 6) will be sent to net-next separately.

The 1st patch is unchanged since v1.  It refactors a bnxt_clear_bars()
helper needed by patch 2 and 3.  Patch 2 fixes an issue during driver
init.  in the kdump kernel on a Dell system with a smart PCIe switch
upstream from the NIC.  Patch 3 fixes an issue in the AER code path for
non-fatal errors found by a partner.

These patches have been regression tested on Broadcom 5750X and 5760X
NICs running 237.x.x.x production FW.

v3:
Only include the 3 PCIe FLR/AER fixes.
Updated to address some more Sashiko comments.

v2:
Updated to address some Sashiko comments.

https://lore.kernel.org/netdev/20260928041712.3467803-1-michael.chan@broadcom.com/

v1:
https://lore.kernel.org/netdev/20260831024342.2161156-1-michael.chan@broadcom.com/

Michael Chan (2):
  bnxt_en: Add bnxt_clear_bars() helper
  bnxt_en: Fix driver init in kdump kernel

Pavan Chebbi (1):
  bnxt_en: Re-write the BARs following any type of PCIe errors

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 164 ++++++++++++++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |   1 -
 2 files changed, 108 insertions(+), 57 deletions(-)

-- 
2.51.0

