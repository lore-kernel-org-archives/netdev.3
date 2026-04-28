Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098B724A047
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 22:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777414146; cv=none; b=U5r4nz3JYa4KTFXsiHONCphCFbptRD9ZDCblDQw65cWCTz30cBRFzn69nntwP+VL3v8/KbSNLPOF/544PWqA+ZD+/pBOj9Um+MPL1IUBSySNipCtF18X2Nb/4B1PCZyWcHqy4bxZGxXi8nvXoPRuMR3IPbmlwotjGodKz5dkmnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777414146; c=relaxed/simple;
	bh=x1XvoD6CdLaXGQiqcH1TSk3YXjGJCCCMtZA2FfkmB6w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CD5AkiBlmJ0WhA46pRn49G+mzGLOtF2Rfnu9AlYsMH1PTsQXl1nIsZJ6CqAdWPukXuyBGAQDbRSz4pcgtDXbSC5AFaJF0FGYbneASlvAKxeeRQi0NDycFivmrMczYb1fri0K+OF3tZE8gADCQ9mcBWjUR8DtK52dxiDRqN7kwdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hza1UDJz; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hza1UDJz"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3585ec417f6so118554a91.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 15:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777414144; x=1778018944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCnVOkDShq94T5VwefRKEMLWWmYtQ4fBZXaM6oWb0CI=;
        b=rmPFk3zbw+9qI3epSBKbaWJbEILBaX5yj4F3Iky5FPesFjkLTFbo4NqqQWUHEG8b3n
         HUW572syVCBlApq3Zqh30wOi5f3m3lUnDCRhTd1SNTVkt1jRrguxUAnXXRAr8xO20gkd
         tNUdbrX6L9RxLl2BcQigLZrJ1sqnApLVf7DeazlhEAmi5++/4ZA3n0aaDGXAFmzAQrvN
         Hf7lXZBZK0thGkEpd5JKUspeIjUVYsjo39n/pHBBpEJhQB7T9JuAkDen+VCjSEqwUj3U
         dFdFnT09Uz2UUTYUUatnassWKjcv2yJcv/5X3JqLz8Vo2vnkKa+XEBORB98Qoq3HxVCh
         FRDg==
X-Gm-Message-State: AOJu0Yz+oA+I3ZphVRcZ+XbUDidWHmoG+7J4BtsstCujrlrNNrHBU3uH
	1WvmUGx9ZtBeWFOXAuMDaNSc1s7KDgtriqN+ZBsrZLPSuknKEYAoXM9HwPPSutz3CgovyJihqFA
	dgFZOTESVF7pYojt5YJKhKUYYVYrE8takTToj43N3sVoHhfpKWSNTsJej0dIlMhpXW1eXYUhKOi
	jDD06ulXlUGeOfeWbSjXoz75EJ04K5LahsgJcBtgDJgu3ok8ai8WniT2E/Mg8WiDsZBvz5xBNAO
	z9sfOJ0Cw==
X-Gm-Gg: AeBDiev/ZFS2ioz9UZNwdBS3LSqxi1bTx+EoQqzkwgTnfoBSzX9X7mAnvsRwmtmq7KM
	5WQoGm0f+0I1F5rG8fDDsAXVqVLjAvMCoUQ4dVwPmdMAo9cgw+iLFyDNwvxLSwT4+N6MCe8iTdg
	xf3BvBPiJOZRfNgVJ8BAtUmZaspG2zqYIy1/2Avhv+34wPuDvilU0xfGDp34iHcw7TGmww9cSZk
	SifCd02S+Jq7oocQxGQUysp6y8gNOEHnnuDL6SqY0Izp+av2QMAyziOY9Zw2hkk3ZeuJC/BJeRV
	w+UdbZFC6/XA8b+JC5qQ7iOlDwqQuFOZWXIPt3d6LHDGGlODND5eVuaOosJ5CQIeFE8LycMBlmg
	mj8bSruOtCKxsAG0mwv+oQLI6VW8dEjiBCnKYoCBfhQQnKkkq0uX1iVB780R01oSSPjZfPEqGpy
	8YK72IV+dQ0uNfyqnNICIUfAb42X+52KgdszeCMCG/iu4/rrHdKHdU7ea9k6anzoDxbBeY
X-Received: by 2002:a17:90b:180c:b0:35f:c5b8:ef6d with SMTP id 98e67ed59e1d1-364a247d48dmr422033a91.3.1777414144313;
        Tue, 28 Apr 2026 15:09:04 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-364a02e54cfsm97705a91.7.2026.04.28.15.09.04
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2026 15:09:04 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50e423a05c8so7512151cf.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 15:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777414143; x=1778018943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SCnVOkDShq94T5VwefRKEMLWWmYtQ4fBZXaM6oWb0CI=;
        b=hza1UDJzvEXwi0PO1vNQVASJiFf5s0rP38ocyKkk7KyH+16jq/qOwa62jDJ2zxKytv
         jpPjnC+e/oENV+byTbHkuZBPZMsCsRTLt1QFS6a+MS9f305I4SXlIe7h7oZgFjVqRDbe
         e0IBR3xwxovXXzhLaQzswd+rK0w0bWmHfcojY=
X-Received: by 2002:a05:622a:1456:b0:50f:b732:2027 with SMTP id d75a77b69052e-51019ea064dmr9477911cf.29.1777414142646;
        Tue, 28 Apr 2026 15:09:02 -0700 (PDT)
X-Received: by 2002:a05:622a:1456:b0:50f:b732:2027 with SMTP id d75a77b69052e-51019ea064dmr9477401cf.29.1777414142122;
        Tue, 28 Apr 2026 15:09:02 -0700 (PDT)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5101ae3ced9sm1410181cf.14.2026.04.28.15.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 15:09:01 -0700 (PDT)
From: Justin Chen <justin.chen@broadcom.com>
To: netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH 0/2] Keep PHY link during WoL sleep cycle
Date: Tue, 28 Apr 2026 15:08:56 -0700
Message-Id: <20260428220858.2076469-1-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

First we divide the init/deinit path to allow for a partial init/deinit
during a sleep cycle. We also remove some unnecessary small functions at
the same time.

Then we modify the suspend and resume path to allow for a partial bring
down and bring up. This allow us to keep the PHY link up and to resume
network traffic much quicker.

Justin Chen (2):
  net: bcmasp: Divide init to allow partial bring up
  net: bcmasp: Keep PHY link during WoL sleep cycle

 .../net/ethernet/broadcom/asp2/bcmasp_intf.c  | 246 +++++++++---------
 1 file changed, 125 insertions(+), 121 deletions(-)

-- 
2.34.1

