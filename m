Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48A34582EA
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 09:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786698670; cv=none; b=kxxBT4X2MFFE/gh3rIqn1Ts70G7HHozlhgg2VKP6GRinQYBTCH5/NbJ19A/moEHa5wZq14hJIFYlt0xx8BWUVtuCPZuowz0llzRL/nU2DrkS8gIubzwOVnC0SW4rpZmpWlGUZuSJky4S2M9M2vSDqF/bYM+4VsLLWUMPW3fKt+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786698670; c=relaxed/simple;
	bh=D+zrBT0ZGSNOMO2IwawwUlukirkCq+drXjkafF6pPAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bFAi4TyADIJA4xMh+U2sJEgHq6z9O4yYiJCMmoSo7pqR3iaOpxa+We2JaLJqapa9wyxcondD6ER82pRZp8nMnTd1V2pFbj7lnTNkawYzHvwZbL98d7WAP9XSndV8VmP8iSY1DSjrNVLYq7x63xx8rlMb1H5SyyFGRKlADVAvPLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dUUOJmGY; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dUUOJmGY"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso874832a91.2
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 02:11:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786698667; x=1787303467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3rqj6MNuRHMhzwluCEZg0MCNuMGlG0chZi1NOjoeikI=;
        b=EEwW6Q2+moENCPf0faE8X/9XTSVGvW7NXo3IQ4iwyVi9Ued+CsMDHk2PEO3X2tvFtT
         jrbSRZeaFCi73ZpUAw+PJVF4td3mCrglTMtpXbddNvFcjSCwR0M/WF2+4+ZhP8nLDVWQ
         IsJG9+48FWqU6R1vHLEbA/hSkT6rIm8DiALM/wz9EHlNcUoS3iUW6qoe1Dyuw0/NXNOq
         RgrrxSLomMwv5ubxyM054+w0GJ2sixPen06vtFSswEImBwL7PIy0YoqIkYfoH/gIUxUR
         fVvKq/dDZ3jRzU9dsv/IprTdR+6lZVrZ6YkJNJ+TtrnxDJfpGqemc1l3t6HWnvCFtY0a
         5g4Q==
X-Gm-Message-State: AOJu0YySNIkaBr/lsoLFRO58IbvDkM8qK/kIiWHvsQFcvmyjLyczK4Rw
	3YyFFXVDCbfAdlyaQ4lgeXtKz+z6GDrE470+wYDnB/DNgX/qLPBYJX8P8+Rw0iMQbw5yQf9cPpK
	I8b1w1apxm4dht0M3VUSmt/fFPHOVb2aXzxskGlAcm8I3f0dOcTPvOhMUUb4IN0nJo0wqzGKQ0S
	+GQQTSSP+s+x1rITqhQJtcefnpAC+zoW1tTlgT+efH5npDSH9XwQsEXuyyvEWhtD90Fee0VhZXb
	E6EAWj2Uw==
X-Gm-Gg: AR+sD13LzzrhJV6lmYaUGTKzzJQzPMA7Um5I9HYaYdup5CvYId3rCJJeuJW5uLBta8i
	0k8+E/UXM8CXnJB/2WFIgAXGt/v/GAlJhtNdtu9vtdevLtB9u3IWITaVgFUiRwZbojtK1Tjgx6B
	7UCU1z7eMo79qDp86i5RjuBIj3Fh8dPcwjwX1G5x3WjqoRxTOOc42BvA0wOsiUAmsYrHfv6zFK8
	DfUXW7SbbsCly6jhtAa21vWBK8fHljhZBDClUmFdz6tlYMY9OnDcZXAgUqmhHJIMdTFUZReZ1mW
	5ho/EE+EaYVS7bpzxLfN+0AZPSFdOzyEedr3ezXReG+xXlqAz87KOs6j7ERBI5a+mkduF14mR8x
	KmbuXfx+jKELGUbkXk/KV7ub9RdREhbUwbWSlQz6iHWiVomxRd9GaIia0pu/TXTWGzIy8wFYCe1
	+F+1gggW5et0y6JxUfQkCueD1WTBH9DpUWsA==
X-Received: by 2002:a17:90b:1dc4:b0:38f:1dc:672f with SMTP id 98e67ed59e1d1-3933ba72497mr4701305a91.18.1786698667471;
        Fri, 14 Aug 2026 02:11:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-394eac9537asm661749a91.8.2026.08.14.02.11.07
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Aug 2026 02:11:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so1142030a91.1
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 02:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786698666; x=1787303466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3rqj6MNuRHMhzwluCEZg0MCNuMGlG0chZi1NOjoeikI=;
        b=dUUOJmGY6K5T+8sA0zrfBlV44rO6wc0Xobq4SWDowQRl2CkZyjUOdrX1YEhnLxTltf
         WFEGqoI46j87wrtEgx/n8pbq+RId9EBzyzZfGXbC467L+/NH/Puy+K7+hHN11Xftog1h
         Tg1VpbsXHTnVLxsYAv8go/r2E1RS1xqeqhHyQ=
X-Received: by 2002:a17:90b:582c:b0:381:c500:b0d1 with SMTP id 98e67ed59e1d1-3933bad0d4cmr5296269a91.20.1786698665768;
        Fri, 14 Aug 2026 02:11:05 -0700 (PDT)
X-Received: by 2002:a17:90b:582c:b0:381:c500:b0d1 with SMTP id 98e67ed59e1d1-3933bad0d4cmr5296104a91.20.1786698664564;
        Fri, 14 Aug 2026 02:11:04 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1413887e3e7sm7056408c88.9.2026.08.14.02.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 02:11:04 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	leonro@nvidia.com,
	jgg@nvidia.com,
	bhargava.marreddy@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	ajit.khaparde@broadcom.com,
	siva.kallam@broadcom.com,
	usman.ansari@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH net-next 0/2] add callback
Date: Fri, 14 Aug 2026 14:40:52 +0530
Message-ID: <20260814091054.359508-1-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi,
This series introduces support for the PCI shutdown callback. Patch 1
implements it in the bng_re (RoCE) driver and patch 2 in the bnge
driver.

Thanks,
Vikas

Usman S. Ansari (1):
  bng_re: add support for the shutdown callback

Vikas Gupta (1):
  bnge: add steps in bnge_shutdown()

 drivers/infiniband/hw/bng_re/bng_dev.c        |  6 +++++
 .../net/ethernet/broadcom/bnge/bnge_core.c    | 24 +++++++++++++++++++
 2 files changed, 30 insertions(+)

-- 
2.47.1

