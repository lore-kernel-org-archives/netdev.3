Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394984;
	b=NkNW3pS+jTN4Zj6zDnw08fyXN8ZJ5pm8fUfNqFqTRsHnkSyScgvPSxCMetOvvty0SeS3
	 JtevbbG4eNDXbf9+aVkZvYl5healDAHHQoPdkVb70+fQCcLjwHhWbND1/lK67VoF/vdiN
	 nTI/OT4Z+vk9NhYSV7suaYmFW129pHdzGsSEvyFFrwS82N2hb/0aZcfXyeiMiZfanT/Mp
	 P7g8puECEcFWbCsmBdyL+x6pjFDu054XVaVdc8PIxDBwYBRilNqV5y6Of4bQxs5eEEXSd
	 xWFBXZGo2MygwVeHZjk2SsvTcssu6jROu2idIH9flOIeC5f/Ck9ats0iFAZM1sYQuSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394984;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=KTlWlfuITNwuhIa6PJcKp+S8YcpVXepl99NGmnhvqqU=;
	b=QIdkTW0QdtwKNgY62kEaCvvKyGXCPk7uKDzwb4nb5VcEjKvAGZn/o+SVj8VpT1GlWgUq
	 wiXrwIwRUmn9ud+/82etGisk/iNUpxK51pT2Yft1+8sfTeeJhN0r41665p7GnRkPTOYko
	 wmJpRCDhpoz4+UNouyFx38Sm2A83wyBJXVN2M6qoL1WFBnt/rRgS0zbazV69RpEycM9od
	 KG2uGAifl937INCt00nUFQMwChlyna+PFqmo/KEIgMzjwpJ+ebyiNOvefl36Jm/5Qeh7J
	 11Ygj5CH9JdOW8Li3ZhsqUszbI/7kEu+gYbWD5RFlDChNPDK3voYG45nQGyu5xzkGsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=N4YDj68k;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FDC606A31C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 21:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5FDC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=N4YDj68k
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cd62c570b5dso700661a12.2
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394983; x=1793999783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KTlWlfuITNwuhIa6PJcKp+S8YcpVXepl99NGmnhvqqU=;
        b=iDLEvBUf7XEZsA6+J/a5wYEY1ZcwZwShk52iu7f1p0brb1mSyeHL7zMQYP40bsjWjU
         oTgLoR1QE+OS2dkone71jtNglgFNRxz+1l8/OoJFbV0EXayB1B+6kIQP4B59rFLrTSeI
         TfSTY7MZnHCUBUknqJE79VcV81kKi/fDBAQp9lUhveWyM5Q/5jvSEGfTnFkUtvHN2CsE
         IO2hlGiVmIQ4Tm9LKBDPZNmYayrdedpuQw4dSLPHeHNG+cR63owj1tDfyl3c5OmDjQMS
         qE1YRDGRChvejxFSuddTte1XKARGTHunUNJgeVUSz0ThHtnMlpjhm8ujPX7370bn0Rwp
         P7iw==
X-Gm-Message-State: AFq9FYKVAG9Bhog8BRx9puCBqdD5++D9GCUKCxbGWmyN8sn9R2gj+amA
	sTz+ObdgUYOWQ78UNOt03lDjBK1A/JoFSwk3tCIj7+lmoAIh9+BqZwiSRdTfE3Za0i3LAH4SNBG
	+mU1qGdsOx8rY5G8xLcnNjIQjMisjAltS1xqTC2aroLxVQSllhjVQzIIrkMnHID2gGLbVqrYmB7
	j7XgXKkm7363fNDod6fTcAh4z/fGWx+o4FI4a/GYQOP5V3sOTGrA0XIZwlXZ52h8gHbb/TOcl16
	VQCkptpgfNEiDPBpZA=
X-Gm-Gg: AYBFou3D804MmHk6geCnF0R+huUq33BbssW3urQ27id9AcIkEl2dCrEN7ZO4nBncnMX
	XbPCoQs97UbZsGwZ7BdTH806TCGPxpPJFCxwLycixD0iJoCGZgK9XAVOLR/3PQrsYgSqIZ7iKfU
	Ss44SHpkkyC/sHWhzcYyOkqTbOIV06T8jFjH+YIKYBJzwYeh3Tq4mHOok3uP+9nhQm/ej8PG9ei
	gOENQckUay9EFKt3FZYahDVkQ4B+eOwXEipXcQ5eNuSaXk9cJduhIVRynk2sZjgsM938i5KpxrC
	BNZ+gXAruWFJsj2CuIqTMqu6BnDKO1lPWa/XiqEDAO9W9iOLstyJ3HfV8PbjdWiBIECrzKdO7NH
	zW+yTlrC6q+DIKU+U3GIyXU/wwipgfXRq6RTwZzSQoFk5fNBMXqXfM0z733Jw8I4V1qIwYpA/SZ
	yjox6ZS6FHpYSeRZyXgVK7WruBfLC3kMqFPmg4dLHJ
X-Received: by 2002:a17:90b:4c44:b0:3ac:403d:6232 with SMTP id 98e67ed59e1d1-3ae897e0829mr2861913a91.55.1793394983187;
        Fri, 30 Oct 2026 14:16:23 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae87fd8e2fsm901649a91.4.2026.10.30.14.16.22
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2026 14:16:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-341eff9e381so2637248eec.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793394981; x=1793999781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KTlWlfuITNwuhIa6PJcKp+S8YcpVXepl99NGmnhvqqU=;
        b=N4YDj68kQYgEbq+uOwYTqasIjgWrIfTZWz6/X+IrHhQIMXzGVKOLXMxvTqTqtAGO6L
         rf5mElUewIoP1dsmxuAzF7pI3bnztMJu3a8tcRtz1gYSjPVS2sbAFCP0bGAFThUMCi5j
         XTEHOdSv4HNj6fbEkNZWRZCgqjETVqD6k/Ebk=
X-Received: by 2002:a05:7301:618a:b0:351:68e8:4646 with SMTP id 5a478bee46e88-36a424199bemr4705036eec.37.1793394981087;
        Fri, 30 Oct 2026 14:16:21 -0700 (PDT)
X-Received: by 2002:a05:7301:618a:b0:351:68e8:4646 with SMTP id 5a478bee46e88-36a424199bemr4704977eec.37.1793394980218;
        Fri, 30 Oct 2026 14:16:20 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42935b4asm13513535eec.16.2026.10.30.14.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:16:19 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v3 0/8] net: dsa: b53: Preliminary fixes
Date: Fri, 30 Oct 2026 14:16:09 -0700
Message-ID: <20261030211617.288562-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
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

This patch series contains fixes to issues reported by Sashiko on the
b53 PCS bug fixes being submitted, and then some more that came from
code review and testing.

Except for issue #2, all of the other issues did trigger in testing and
needed to be corrected.

Changes in v3:

- patch 2: added Daniel's R-b tag
- patch 3: mention in the commit message that deleting an absent entry
  now returns -ENOENT, including when the lookup runs out of space
- patch 4: document that the patch also fixes the clear of the capture
  port field in b53_mirror_del()
- patch 6: reference count the mirror source bits per port and
  direction, ignoring deletions without a matching reference
- patch 7: new, harden mirror register programming:
  - reset the mirror capture and source control registers at setup for
    b53 and bcm_sf2, since not all switches are reset
  - check and propagate all mirror register read/write errors, only
    taking a source reference once hardware programming succeeded
  - use the source masks rather than MIRROR_EN to decide whether the
    destination is occupied, and write the destination before the source
- log failures in b53_mirror_del() since it cannot return an error
- patch 8: new, fix the mirror capture port encoding on BCM5325 and
  BCM5365, which use an 11-bit bitmap (CPU port at bit 8) instead of a
  port ID, and translate the CPU port in the ingress/egress source
  masks as well (verified against the BCM5325E, BCM5325M and BCM5365P
  datasheets)

Changes in v2:

- collected Jonas' R-b tags
- corrected logic in patch #3 to propagate -ENOENT, memset after the
  debug print, translate -ENOSPC to -ENOENT when deleting

Florian Fainelli (8):
  net: dsa: b53: initialize the jumbo frame size register offset
  net: dsa: b53: fix the SRAB grant timeout check
  net: dsa: b53: clear stale state when creating an ARL entry
  net: dsa: b53: reject conflicting mirror destinations
  net: dsa: b53: use the correct override register 2 Gbps bit
  net: dsa: b53: reference count shared mirror source bits
  net: dsa: b53: harden mirror register programming
  net: dsa: b53: fix mirror port encoding on BCM5325 and BCM5365

 drivers/net/dsa/b53/b53_common.c | 183 ++++++++++++++++++++++++-------
 drivers/net/dsa/b53/b53_priv.h   |   3 +
 drivers/net/dsa/b53/b53_regs.h   |   1 +
 drivers/net/dsa/b53/b53_srab.c   |   2 +-
 drivers/net/dsa/bcm_sf2.c        |   5 +
 5 files changed, 152 insertions(+), 42 deletions(-)

-- 
2.53.0

