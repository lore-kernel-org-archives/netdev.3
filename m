Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89030336EE9
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 11:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.149.7.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772106059; cv=none; b=khnUDw8gHBzsfp1ZM519pN7hegPAoiEoLsbuaqFH/Book+5tJzet4eFHKB9hFUh+MpSSnNDqgj4Y4LqTONcbBcTVV/+rvK3/uH74E7zjoUE1le28Ea24NbxYUUe6X/VYXoii+1aK9ppijQ02iPaeY7/mp8qa45RB7p0ODakUJxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772106059; c=relaxed/simple;
	bh=hvTnSFHQhCvxjjCGxnK9Lmmrw7vq0DMtXqak4rgEzbA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=mRB3IU6gh2QTljfEkqESh9egMDaioe+2TTQGDkEHcFjwJq8+39TOxEAb7eEF08iQUTRM0KxsXfX3InIGU+fxBI0+umjyGFptMEM6apzT86gDTwtYQwZ+E2XAsiKRh1yURn5/rFQrnm0ikl0rsTS25eTVe17cqaogpqh3lbzI608=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de; spf=pass smtp.mailfrom=tu-berlin.de; dkim=pass (1024-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b=LakXDvye; arc=none smtp.client-ip=130.149.7.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b="LakXDvye"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tu-berlin.de; l=1001; s=dkim-tub; t=1772106055;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=Sgz8P5WUR8ZhJ67hnRKMrMkFIDXHdEjQM29TPrhLM6g=;
  b=LakXDvye3yiRfe/HtBwnIGh6sXkTo1SG5O0OLFnDNtl9H8+ktj1XBNb8
   ozfrKDT5lYZZ51+NQla4I1LE8/zFT0o9EMYIntOZo3vVbUyxzVYBXPVWt
   xlM1ocCwZymJWszxp1bHCdgyxz/jTF4Q3dhCm0bO8T0kUVCcVtOxhGvu6
   g=;
X-CSE-ConnectionGUID: m4XkvQADSgOjMaqTVXEr7A==
X-CSE-MsgGUID: f4AIwmavRLKUCg+Jd33g2Q==
X-IronPort-AV: E=Sophos;i="6.21,312,1763420400"; 
   d="scan'208";a="57705315"
Received: from mail.tu-berlin.de ([141.23.12.141])
  by mailrelay.tu-berlin.de with ESMTP; 26 Feb 2026 12:40:46 +0100
From: =?utf-8?q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
Subject: [PATCH net 0/2] net/sched: sch_cake: fixes for cake_mq
Date: Thu, 26 Feb 2026 12:40:14 +0100
Message-ID: <20260226-cake-mq-skip-sync-bandwidth-unlimited-v1-0-01830bb4db87@tu-berlin.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAB4xoGkC/53QzU4DIRDA8VdpODuGhQW2nnwP44GPwZ20pRXoa
 tPsu0vXSzUeNh5nSH7/CVdWMBMW9rS5sowTFTqmNnQPG+ZHm94QKLSZCS40F90WvN0hHN6h7Og
 E5ZI8OJvCB4U6wjnt6UAVAygTpe2d9XJQrFmnjJE+l84LS1jZa1uOVOoxX5b21C1P3xnRr8xMH
 XDAGIyU0Uih9HM9g8O8p/QY8Bb+D9i7KKI3KkZrf4K3qydxf6laC4sGB209mqEzkus/YHkP67W
 wbLCVW+eG0H5c81/wPM9f69cejeUBAAA=
X-Change-ID: 20260219-cake-mq-skip-sync-bandwidth-unlimited-57f3a4bac385
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, "Jamal Hadi
 Salim" <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: <cake@lists.bufferbloat.net>, <netdev@vger.kernel.org>,
	=?utf-8?q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772106043; l=1011;
 i=j.koeppeler@tu-berlin.de; s=20260219; h=from:subject:message-id;
 bh=hvTnSFHQhCvxjjCGxnK9Lmmrw7vq0DMtXqak4rgEzbA=;
 b=O849Zi5jBHbB8uRofgBCD8NYX9+wpHS1xTpIzqsrQq/brWjaMARcodG+W9ZrpWqm/GP73n48a
 LRbkJNLwz8bAVvVZ502QFU5TEr7uPtzZqtP5IJ9IbA29RQ+0uU7IbAz
X-Developer-Key: i=j.koeppeler@tu-berlin.de; a=ed25519;
 pk=+pMLYEiy24PHhKr0HCDJhKWgh9WowPOEUOtiuMX7LLc=

This patch contains two fixes for cake_mq:
- do not sync when bandwidth is unlimited
- adjust the rates for all tins during sync

---
To: Toke Høiland-Jørgensen <toke@toke.dk>
To: Jamal Hadi Salim <jhs@mojatatu.com>
To: Jiri Pirko <jiri@resnulli.us>
To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: cake@lists.bufferbloat.net
Cc: netdev@vger.kernel.org
Signed-off-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>

---
Jonas Köppeler (2):
      net/sched: sch_cake: avoid sync overhead when unlimited
      net/sched: sch_cake: fixup cake_mq rate adjustment for diffserv config

 net/sched/sch_cake.c | 53 +++++++++++++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 28 deletions(-)
---
base-commit: 2b7a25df823dc7d8f56f8ce7c2d2dac391cea9c2
change-id: 20260219-cake-mq-skip-sync-bandwidth-unlimited-57f3a4bac385

