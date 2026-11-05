Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793869865;
	b=jGKibtqOVyvyP4xfwE9KPl4CM/FSCS/2lLF2vJOTGP5sjYqcGIW/ZcPdgtTI1GF6XlZF
	 vYlUJiSZnAqQKiieXLmfF48KB5OgSPi/GmeUQiO7Q97xhvXXMEZ1EERwzlTHxCb1Lkpa8
	 PkiFSHiXEjYJeHxuSlCKCDfRa9Z35dxG/S4wJbgOeXGHXLPeXRR21LKTSVSlO7326fNis
	 l4jgMmhHKSoEGh/lLpPnjT3jUs97uy0RB76DIOVLy9p+l9ngT7KRyQXtO2rgHm/QIO15S
	 taQ67VikeQ4/xxaZqxDMX2aNxZRhZxs88cGj/VWRcHuYaHuaNrQYoRIwff1gWtUSSPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793869865;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=4+ZqNO1Uua075MEzu4+jAJNvV66dGvERxAz2lyx10y0=;
	b=n1NexJ/tHVVjlG6nOoZCY88QFCbcl0ld+tYlmUcPLtC2bju57gVpkxjZWrVxO7nikfGC
	 iT/tuNsrU6VE6m0hJyKReJEniLPcihG21GcDrKbJjEkPdsbH+jxKzEtlzqGQ149nzHGH2
	 rHkKgCokuB2Cw6QpRydm80BD8VBLd5KnDyf+ZYQakoX0ETElCRm9tww4ISTKVLsnGmDx3
	 8McOlQvmA4/t4Ehby4CTo3RTFO65I0pMwq0QEwVuFQENYXuC6MbfHQrRNBujqsJ37wwYi
	 i3i1uR3hqtIqYMD0joE3dQ4RpnuZFD5m2XbM3PFm8e3f/9NuR+m9t3Bvyxj45K+Wz0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=UUyuMllB;
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2DF606A326
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 09:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B2DF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=UUyuMllB
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so1241990a91.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 01:11:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793869864; x=1794474664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4+ZqNO1Uua075MEzu4+jAJNvV66dGvERxAz2lyx10y0=;
        b=Mk3lMh3MpxYjFB3uSBJVpubSTivisxk5IDIgFFP2Y2U5j1v3RrZ0U7/gJ+KWnQV31t
         NjHFXG6H7IbJbDvN7LV6uhzdpkZH0WYQ341YoEjRk+4LWwAQJ5cCJEddzF9g8gny4XA9
         YBVyuMDYzEY4eymtnjy8np+RuhgZaoOgH3D8dfvSdjHWy1w1CoRvGW4C8f32v8pxp8WW
         gWMe7v6ZCVbjkwIvYirXcCf9IMmKqRoXgLQCk8Q4JgQdafLCI7+XNkvwtNixu2XMWI2J
         MbK9vlNEW/GnAHCyNuZ+pO/QGpLJb4WqXzZxHn3ZnpxwPjl55+ukw2LI7DMlnjBePShr
         KvmA==
X-Gm-Message-State: APuU4Z8Flbnykc/wJogvAhxDkbGRiGcJ1pQk+Y4JjFZKlXS+oI04l8Bi
	PKKVzMShmlD8BlOhyDWb+jCkv7yAGS8EM6Fj0GwHRHLTHmNRlhTLlBPILGcKTIfIWxPqJB0/QTo
	TiYOk+61kjvM0Q2IDFbJeY2ujvmRJ3bOLyglffPU7gAdq2ajaQaK2BdnrtOHC32ggo5wP30EoLG
	nIpynHLisIIKqDVklCElOuER2DOrv8K/GMmy14rlr5IZU82HmENmv/CaSSkRzx4baFIeGipQhxr
	FlubhfaR3AL
X-Gm-Gg: AYBFou14HGgaFaadd2yAqvU64QV3PxZP+crDdFxj9vEDU3WoPQfqWEPqvUeJEllyJ2m
	AswSS5YqIvgrK3wP01WkkRbn93VY61jSYhyOUsL3w8EV9NPnzRcjj+Qi7rVNBcX98eOVUqfA6Ri
	LtU/anC7JrCbrzvOArjAfeajFkNAHkeNJyGbnH6UfJ0OzhEg+SRC8bRZT8VvfR1jBWuX5kOKuWp
	MkXRhzoyEZvk3LpYwSa/IXZovurg6saHU21pmeIkC5az1qfo+mYB04FgoPNCay8MsLW3sH8gDQy
	xr90uuqJu59SnCVE6xxFfWDHPIl1B2teG98KHvFwLD8fG13YijAVIKfQ2CGbfSoGIIscTCPIFJn
	Phlr9OczT0vOZpyqSKhdUcF4puDiJoXEUX6P01AS2KSs+WrZKgIRqrf6UFJfBe1O+yMid0bcr/G
	QliHBwbsbMAJUGMH/aIyxqvxpc+zkbX5449w==
X-Received: by 2002:a17:90b:4b10:b0:3a8:185:cf40 with SMTP id 98e67ed59e1d1-3ae89724b06mr15979673a91.10.1793869864160;
        Thu, 05 Nov 2026 01:11:04 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b0b93e8cf1sm1044070a91.8.2026.11.05.01.11.03
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2026 01:11:04 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-535066512b0so46152581cf.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 01:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793869863; x=1794474663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4+ZqNO1Uua075MEzu4+jAJNvV66dGvERxAz2lyx10y0=;
        b=UUyuMllBWNBMjTXRRyz6Qq4H52mR0Hs6nSMXb+lB8GRVNLKQMVBrig3wiG9HGZoBe3
         Dq4PcCK4y39gG88HV2JIJ6BdIEqra5PL/gfz5nmgW5pzEQ5k4KFkjLlDUpFMgt9TcMyG
         bQTdkTSUeB4ashXuB8cm5+i30COn54ZyzFqK0=
X-Received: by 2002:a05:622a:1a97:b0:537:b9f5:e05 with SMTP id d75a77b69052e-542b82fa50fmr318543361cf.69.1793869863165;
        Thu, 05 Nov 2026 01:11:03 -0800 (PST)
X-Received: by 2002:a05:622a:1a97:b0:537:b9f5:e05 with SMTP id d75a77b69052e-542b82fa50fmr318543191cf.69.1793869862721;
        Thu, 05 Nov 2026 01:11:02 -0800 (PST)
Received: from mgmt5.dhcp.broadcom.net ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b100af507sm47298591cf.6.2026.11.05.01.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 01:11:02 -0800 (PST)
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
To: leonro@nvidia.com,
	jgg@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	vikas.gupta@broadcom.com,
	ajit.khaparde@broadcom.com,
	dharmender.garg@broadcom.com,
	sachin.holla@broadcom.com,
	Siva Reddy Kallam <siva.kallam@broadcom.com>
Subject: [net-next v3 0/3] bnge changes for RoCE driver
Date: Thu,  5 Nov 2026 01:01:51 -0800
Message-ID: <20261105090154.1293846-1-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.43.5
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Add bnge specific changes needed for RoCE MPC channel
support.

v2->v3:
- Addressed Shasiko review comments

v1->v2:
- Created pull request for RoCE MPC channel changes
  of bnge driver 
- Addressed Shasiko review comments

The following are changes since
commit 05441d697f7f ("Merge tag 'cocci-7.4-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/jlawall/linux")
   Merge tag 'for_linus' in Linus's tree
and are available in the git repository at:
  https://github.com/siva-kallam/linux bnge-roce-v3
for you to fetch changes up to
commit d60317882851 ("bnge: Reserve ring resources for
upcoming RoCE MPC support")

Sachin Holla (1):
  bnge: Reserve ring resources for upcoming RoCE MPC support

Saswati Das (2):
  bnge: Pass BAR1 doorbell mapping to RoCE auxiliary device
  bnge: Update HSI

 .../net/ethernet/broadcom/bnge/bnge_auxr.c    |   1 +
 .../net/ethernet/broadcom/bnge/bnge_auxr.h    |   1 +
 .../net/ethernet/broadcom/bnge/bnge_core.c    |   9 +
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |   3 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |  56 +++++-
 include/linux/bnge/hsi.h                      | 161 ++++++++++++++++++
 6 files changed, 224 insertions(+), 7 deletions(-)

-- 
2.43.5

