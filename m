Received: from mail-qt1-f228.google.com (mail-qt1-f228.google.com [209.85.160.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C1344A710
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515846; cv=none; b=SAEULFNo/9G1ddDsxNjpnJ1sZ9++oxJrY7RAtVyKACY8MjPpyc1ZUSuIQDvQrgsPIB6TDFD6L8Mie3qFfFvsAnQd8QebUlhrfurN1Opf6Rs9C5XP0EI7XgNg0oEjlIdSH6y3qpki6e2RvjnzuhzDrk/yiaSCzg2akEU0duRGKEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515846; c=relaxed/simple;
	bh=qY6aPKpX+OxWw+UAI55wtyPh1DaWz8WHgumy1dU/8ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YfVf5HCBVklQfXdoWpdZGaX26NQon6jjO5gzyKT3U7mYQ3ioMG2kQI68THQgP56gpRcADsz4Etp85CfBuTMf1K5EwBj1tZZzSh8tNr9CBxDt/8ooZdwJUl27sAnKQJ96GwUSDxA0F5Zqnp7q+2feOfqD9IjaNyIGRENiQOT8NHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PUzb5aFB; arc=none smtp.client-ip=209.85.160.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PUzb5aFB"
Received: by mail-qt1-f228.google.com with SMTP id d75a77b69052e-51e4ba1cfb4so7171151cf.0
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 09:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785515844; x=1786120644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S0mL7LdNZpr9btSXfODZh7CXj2sMytdsJEG0jRgwtnw=;
        b=s3mqZnO53OoLzlfVPxWfoEQU6vgPIJtpCToy+mFPmknvTbBU1E385DHlRD+kxfp2lG
         I3KisZT3JRo7+gVey1PZJkkenOCFlFxhq0d5NriDmt7spy9USbP1s7MsMkINewpvTiFy
         JrlrE7u6a2SNgJQqHLM41S08GWbsv94tSaOfcbFmk34r2jx2it4kRVn9lF7xrLotri5c
         QV5AHTXzSJqQjYjNRmSKlcxqZxCGGxZXU0BQVFsENCjXn/97TYMdsmkV3wdlXb9ZONv0
         +bWIk+rdDydC5Cw+D4JaKkiIHqOgMtDtIRmWMoK6SofAS81k0bf8B3WB2QZ74RD5v2i1
         NVCg==
X-Gm-Message-State: AOJu0Yxj6iCtK914dZL53lrzMz1dZZ1dS/z1pTvJvkRzCeV4tbrnPPHR
	wwEJncnE703IFRbGicigYrN0JvX2riZAtNpwmRl43hmT3lrZkf/L4UwyUoeEBIzC92r0ZCY5Jkn
	5AtYdL8ZFXvIYT59SKFgMfv+5mbnUovxWiq0BOJL7sDqTAUpwoRq2Ar6isFa876yjdS5zIBeEp9
	TMfPXR0CXlm+ApVf/bfh7oPLfFxULUKasImmFxksFR6hNrluli5qQEvu1ZRM3Kn1RVCmIv9Kdw0
	voA46Tc3Q==
X-Gm-Gg: AR+sD11X1mEEBGTqILHMzcfjDnxRcVZedgUgnYG/jRU2Jp1i3OuNKfh6hHk+g7u39aO
	81gRk5ZZDrtUXoWZ0B7gaf/nM2vLGm64WUa0PLDY/8XWCAVCP57w4v/50ZfsYdxb6+tS67JLkHK
	BQ+iyCRuo7H02v/4vCQ9CtItOO2EYjkv26YCip6G09bqPirBPkTil0tBmLHNWwkkJNnajtG4OjD
	rcwgg4yZ1JlqUI/MhYImaPVAMlVTq8GX2lSFLtevQ10Ml5Ooteb1DoV+Zlky5PvkTPRPQ92Nnce
	Y6PVE96azTQJYjZof9KftrPUu5TQig4nuf1qe+P+L/7tv2H8VAfxZBEsmzdY4Azmta54OTw6UV3
	UMXMqCTOTbdrSHc16E7F9ZfdU6CDRnbswvS7pjGtb8Dwlk0VPVKLq/YS8LCamAzQd6MW2OFR6bU
	3Fd79T2Y2vekuJ8ugJ4DfWV0XaOj3PMoFqCg==
X-Received: by 2002:a05:622a:4cce:b0:51b:efbb:fbf with SMTP id d75a77b69052e-52b566b52e9mr19328541cf.18.1785515843591;
        Fri, 31 Jul 2026 09:37:23 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-52b4e7eba8esm769951cf.1.2026.07.31.09.37.23
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jul 2026 09:37:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8484ba00601so1488402b3a.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 09:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785515842; x=1786120642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S0mL7LdNZpr9btSXfODZh7CXj2sMytdsJEG0jRgwtnw=;
        b=PUzb5aFB3EchgsED5ewy4PQMOX8rb19CN7x0CIPOigTR2Xzju4v7LasFKoJ5OhAE6M
         3Szg7zyieyZaHGpiNL9v072XQ41zUca4trga0rFXdHMh+O6ulhdNXcYQzmmy4z3KE6Up
         yYECIs17URA2AbXPLHDpCsbke+JFsX7V9GPqA=
X-Received: by 2002:a05:6a00:4fce:b0:848:2f74:d8d2 with SMTP id d2e1a72fcca58-84ee49269a8mr301142b3a.67.1785515842264;
        Fri, 31 Jul 2026 09:37:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:4fce:b0:848:2f74:d8d2 with SMTP id d2e1a72fcca58-84ee49269a8mr301117b3a.67.1785515841760;
        Fri, 31 Jul 2026 09:37:21 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbe57020sm690127b3a.17.2026.07.31.09.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 09:37:21 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhargava.marreddy@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	dharmender.garg@broadcom.com,
	ajit.khaparde@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [net-next, v2 0/3] bnge: add more functionality
Date: Fri, 31 Jul 2026 22:07:09 +0530
Message-ID: <20260731163712.3463362-1-vikas.gupta@broadcom.com>
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

This patch series adds a few functionality for bnge driver:

Patch 1-2: Implements ndo_set_rx_mode_async().

Patch 3: Adds a dedicated HWRM (Hardware Resource Management) command
         sequence to handle explicit interface down and up transitions cleanly.

Thanks,
Vikas

v1->v2:
1)  Addressed review comments from Sashiko.
    https://sashiko.dev/#/patchset/20260724142954.3101980-2-vikas.gupta@broadcom.com
    https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260724142954.3101980-2-vikas.gupta@broadcom.com

2) Removed a patch (bnge shutdown callback implementation) from the series, bringing
   the patch count down to 3. The implementation shall be pushed in a separate series.

Vikas Gupta (3):
  bnge: refactor rx mode helpers to accept explicit address lists
  bnge: add ndo_set_rx_mode_async support
  bnge: send hwrm for interface down/up transitions

 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 132 ++++++++++++++----
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   6 +
 2 files changed, 112 insertions(+), 26 deletions(-)

-- 
2.47.1

