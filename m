Received: from mail-ua2-f28.google.com (mail-ua2-f28.google.com [74.125.226.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674B84FDA5D
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 10:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790676316; cv=none; b=jnQdZxUn9q9D15tnrMVH8i06azUko9KITz7VCB34MOnd7v7VZP6DwD646fZSLSbG7JwbYIzzL8MgpZ3eglf4+EnrKHfhwG/+m5RHyAXeM4PwDMrtNWgYMzqkgYxL+8cYqT6BMK3gc9fSStbebdhtNS7GL+uXA6HGWiwlv+2Qx0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790676316; c=relaxed/simple;
	bh=HO3kMzX3++941hDd+4FiOnTVZEiTsHEAJWUsba7xzCo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nPb7G5yFBKYR6BSQD4/rQiRACjhPtlN6goNPRFpg4qD1/NdCv/DgZUR9QQM4yDkRCIO/guDILn2MqyhzcK60EnA1dWT83L1y3QazBbi9SwR8P6LEsCZXbu1x3/3M5fv5NTELEbEybFo1NotcaxkL0/93MspFcYxXHubhD2rwsQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=EbKRY/5q; arc=none smtp.client-ip=74.125.226.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="EbKRY/5q"
Received: by mail-ua2-f28.google.com with SMTP id a1e0cc1a2514c-97e7c796e3aso829336241.1
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 03:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790676304; x=1791281104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UoyoK9QhTWTjtlh2q64dzZQ7shB0zCBWTARiumkOiSI=;
        b=EbKRY/5qx2mTAd3MdnsYVSSU3iVPaZ+hMxYWQBF/ZXQuvXovtSYpijcgJF1/wxg9O5
         Djog+TegeUqewO6V3C6aIhAW+Zno4FcedSfBj3ds/aLurjUGBSkYA4CbfW8EgmEJoKVp
         5jVy2ykFO3UjywNAD+g68FV2NtJrhUWi2XYh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790676304; x=1791281104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UoyoK9QhTWTjtlh2q64dzZQ7shB0zCBWTARiumkOiSI=;
        b=Hf6Hk7ABtIakPwsgGH2KAihBtAAr8dQEhSQyj7L1Wra8qYdiAMPOqL0VBlWfGS/4eg
         Tbr+1FTC/CCAbsPAsnEQTdOR7R2IrA8s1x9sf6ES8446GFHgMVAGRVYPAhXoSpTo8PKI
         teDFY3KVJXDpugJs27l1ZWe9SY75PjV39EmUjKszQjniipft9H3XXPK2xKKdvm0yFisY
         /iWujBi3FxNaf29q0GSXpx+ZBcnezFRUt7bLodB7kXxb9Cerdt1spbJMbprelVp2J+bF
         6+FfSZA76OsysfEGmhQ0VNt7VNDM+oDMIUjZFrB0JmLYZnTM7FtuwmahkBS9DJZx5K1E
         Vs+Q==
X-Gm-Message-State: AFq9FYIWKCuk7UrrIL4c4nQY2xUnT+Hjla42bis2lVqZ0msSrssAYuUD
	4eSV++W90zypS5mndIhQo8F43GG+k1WvuOfCMUNwiDOz559zQOpnwHXYZ/UY8jmj58FB8dKFCUa
	KnSgxAA==
X-Gm-Gg: AYBFou2F+zKveIaOUN765JofR/oJz6UUGf//DfUH8qSw3o2WHahkBs6Nd4qY33W+6BX
	+zgbnHwZidmLSnovVmvDToa9odUsxgHgq43RMiZGUEydHvcOBcaT2SV19oaweKtXmk7fhCYANlI
	3elfQp4MQDndlHQKOohCsICvcf84z9mhyN4p38xB0O8b9z0hP/Ty2FiB0LXdlbYXMz0jEQndsh7
	nPwX/5tcge4iY2rPJg5HNDrHsP0FurwZdHDiYqvHh8yXZ0RBqBBJ6NoG2PS0B9oUV9qlqnt6f23
	EJ8tASHefLuT46hbQh6aXkVY8Gcd4b1dVRzZnUZRNFvqav7hnm4zrSnZYtbmz3vD1FgMAUBjLpl
	YgoGlshwf9SSQfJ5M718oVxm6z+A7eQvAzJDalGODS1ySBKaUHUHJOeXXu0V6M/30tEvVN+vbRl
	PFsbzmTd7dza34i+sGKmS0wPEUQspN6knzCTG7NXRhw3gNGR1z9X5azfEGtEnNXa0eNxDvLDUc+
	n87mrvNDo0WAWGrQYdGZnwddvMxOgOtKAcxnWz1mKWD7GZNug==
X-Received: by 2002:a05:6102:3ec3:b0:7a7:19aa:f0d8 with SMTP id ada2fe7eead31-7af1f621049mr4571207137.37.1790676303901;
        Tue, 29 Sep 2026 03:05:03 -0700 (PDT)
Received: from majuu.waya ([184.147.180.207])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7b39b6a6272sm12764792137.7.2026.09.29.03.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:05:02 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	hybris <hybris@mojatatu.ai>,
	sashiko-bot@kernel.org
Subject: [PATCH net 0/2] net/sched: sch_teql: fix shared headroom and header strip
Date: Tue, 29 Sep 2026 06:04:47 -0400
Message-Id: <QDISC-6HS9.v1.20260928064754@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two pre-existing defects on the teql transmit path, both around
teql_master_xmit() -> teql_resolve().  The first makes the slave's
headroom write corrupt a shared skb and strips a userspace-supplied link
header on retry; the second leaves skb->dev pointing at the teql master
while the skb is parked on a slave's neighbour arp_queue.

Patch 1 fixes the shared-headroom write and the header-strip on retry,
tracking the header length the slave actually added.
Patch 2 moves skb->dev = slave ahead of teql_resolve() and restores
skb->dev at the arp-queue reinjection point, so a parked skb names the
device whose neighbour took it and is delivered with a link header.

Both are follow-ups to commit dc4b95b8fee9 ("net/sched: sch_teql: restore
skb->dev on the slave failure path").

Jamal Hadi Salim (2):
  net/sched: sch_teql: fix shared headroom and header strip on slave
    retry
  net/sched: sch_teql: keep skb->dev consistent on the arp-queue path

 net/core/neighbour.c |  1 +
 net/sched/sch_teql.c | 34 ++++++++++++++++++++++++++++------
 2 files changed, 29 insertions(+), 6 deletions(-)

-- 
2.43.0
