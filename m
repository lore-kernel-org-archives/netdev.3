Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394841;
	b=4h+zXscPEhJHsGsMl4g1hS9fFgszEkjkmIGCERDTbpIkFuT43TrjzIyoWy88HUIv8q/c
	 DF+J51QcILO5i2atMNT2WQLIZ24dimqWDdD9FdgNFJiPxUPwvSyJV0w0t5/SB7LVtbKJE
	 WncQsq0pkYLFWp85Co4xjrCEa+CiIBjGKbBZIhoq8kM2cp8jofkXqYcMPAY6ANHs9Wh4s
	 QgyCzwxfpcxP0tR+jrQEf2MTAdHsyERAFSt5g37a5fK2faA80mIe5noQ7RmNOvW7r+eGM
	 B02pc5CNSGJRjtQWqq4ufxkwY2WmUHUm9fp5hJ1/xaezm7gBUhhkabHy4LZCLXkdBtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394841;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=KTlWlfuITNwuhIa6PJcKp+S8YcpVXepl99NGmnhvqqU=;
	b=ySje32m9A/d7U4jI6rSuX29b2BYtyk+gd0UUeAORc9kMia2zTuh9occ56ExUIYonNMmN
	 UPvMjYzcqxAQblDz+wWcZg9X3/iD9jPYIIWAo38FinTZpkKJNdArpRXnXHzAQ4nTYeV2P
	 NAtlJZFkhReh1nwH1TGKOJQ4UaC1RWKkeqOWytJ8fFiXbx1XuSOnABcy8E5IznEZK35Cq
	 0o4+B3b8uAB7Fw6nZgj5EE/e4I3pR5ZA185/T+egVXqr77GNKK4CAwxjBpHkYsfJt8iAm
	 X6sDxtBXXKY5rPdaxhug8Ti5E2Na4DzrwfLuUvjJFaVbbEaopQL6uOgRaikuNW6gclw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=IiqPCQlE;
	arc=none smtp.remote-ip=209.85.214.226
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94591606A31C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 21:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94591606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=IiqPCQlE
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2e9d1114320so9458635ad.3
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394840; x=1793999640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KTlWlfuITNwuhIa6PJcKp+S8YcpVXepl99NGmnhvqqU=;
        b=uHX17QcZMDSQWzjonYJ6nEveUrG+bNygaeIoSlYA2DkxIXc46iRjRdqlIi6qzAV/YP
         ybpExKNg0NLl0d84+1HWqUW348especudXzpR1i8ObarGfbvC73wB3bioarKCVTCl6hg
         bhXi4+TIPV4heLSXqekQANebJ3XMs5Xv8rGcpWlG4MiKH3i3fsKwYWre4XiBz0vERP3f
         6s9RNHOcRR3hKC+JCLA2uTcqsS1iB16x10MLzx/DBm/avTpxUHZR6aFaPLZe9GcD0Auv
         k55YASSpSNkPPjkHH/xDVexM5RcXcu7Ef6TV4pQx+gSDMOMjL3Rmw0jSIcH6u7ghn3nf
         ZAfw==
X-Forwarded-Encrypted: i=1; AKwUvByrBbuVq2lupn4+7uTnjnxsoj2uQJVlpTpsr1GyDTU+Jk6DHbW/7cSf2heXmIodjLdWdePymQg=@vger.kernel.org
X-Gm-Message-State: AFq9FYILeG5FSDrNgx1PtDysAilPgwbcsKAzO9X21TK2/l0xxHUPxOJE
	dGm8lP69u98SG/3hPTGJeZX28Z0KLlDb497NPIwMDC/IuL1VOzAiC1lTt5A77wWAObhOem3Q8d4
	rtPEpRtYW/iukP3AlbzAu/QuyJjy31n/efitpHKD8dqpJF2BKx3dhMYZhwOvjl8r0Kht0Rtm/wk
	8DlmhQfHWt8l6hFva1bIu1BR0cqpBdk8AK3uSJCApqqTgFKPNEMD9DL1nLTknHAYNDbTVOXYHuB
	Xng/707VxJ2zb8YtHk=
X-Gm-Gg: AYBFou2DMTG4UqF/HcW87ue7dxvx1wI5KuG9D8nkXlYF0Nfpmbq92na1XtvJQ+tZY7W
	wU3uNnyIq0ssFpP+0bQbLs6pdK1iT0MuSjVndMjZ+yicduNGIJfzJ/jXRvBpXJ+IT4hOU6+MRs5
	CKIY/xTJAXdO9LbDa68kaXDIlbyAFs7c8bJ9QLsnh41rofxQoDkk1I68t8EpeY/iH664p1DE79r
	AP23F+YnK2p5mX/BS1luXdcpppZzztvnLRHn+/qN7SOn4LUchmzzKF3muYPsIsK9A8V5RS6RwLY
	Y0Y4PAJ+cvFFbMGw1C3aVddbzn6H06/sIo7tky8BZWnbLEriZwpj4FxW9Juaf9m3EYuOk47ddbE
	bAvf4e3iJXQrjRrq4GhmfL/eOOco+ucMwOFT/0JN3/c5p6d2OMa4qjRWpnVu8VEkiSnDu6beBSg
	hgCEsU9sVmD/bGyujqQcYWDuqnfB09dRVziCpEsZx5
X-Received: by 2002:a17:902:f645:b0:2e8:3d3c:d5d with SMTP id d9443c01a7336-2eb3649639fmr37403315ad.12.1793394839903;
        Fri, 30 Oct 2026 14:13:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2eb38e9f069sm479885ad.0.2026.10.30.14.13.58
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2026 14:13:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-35c3c370b17so1922529eec.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793394837; x=1793999637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KTlWlfuITNwuhIa6PJcKp+S8YcpVXepl99NGmnhvqqU=;
        b=IiqPCQlELKIg7/8ok4QEkbADHd7RAii6VtHEfzEkGtGi7K4bQkKoeW9kLnUmMO+OEF
         dlskpvJ55ZCkCKnKPAOcXhct/wbisGsz3btz6GlNPbipO/gGt4PvbwrzmlWIrfmZqQjV
         +3wpCQ3IvD34OnZ13pnTSo3fdls1YHTvpCU3U=
X-Forwarded-Encrypted: i=1; AKwUvBxIjlhvCzLC0v5VJvtnA8Orm1N7fWtqeT2BSw671/pdYwl+YKax9V6eCgm6ufTmkC0aW8Gtx/E=@vger.kernel.org
X-Received: by 2002:a05:693c:42d9:b0:369:f18f:3492 with SMTP id 5a478bee46e88-36a423fbc3amr5370404eec.35.1793394837016;
        Fri, 30 Oct 2026 14:13:57 -0700 (PDT)
X-Received: by 2002:a05:693c:42d9:b0:369:f18f:3492 with SMTP id 5a478bee46e88-36a423fbc3amr5370352eec.35.1793394836208;
        Fri, 30 Oct 2026 14:13:56 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42669128sm10574595eec.3.2026.10.30.14.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:13:55 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netde@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	netdev@vger.kernel.org (open list:BROADCOM B53/SF2 ETHERNET SWITCH DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v3 0/8] net: dsa: b53: Preliminary fixes
Date: Fri, 30 Oct 2026 14:13:42 -0700
Message-ID: <20261030211350.287566-1-florian.fainelli@broadcom.com>
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

