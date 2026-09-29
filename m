Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9CE4FDA52
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 10:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677010; cv=none; b=HmUNG4rr3r/hGR10qRq0ooxMlYCVOkwpF+48thy671W54fTbfD0ilSSduV9gnPHUjdIQgIzoJ13dsRCvwPtlH97e9CCcSiHznQD6is98dss4X4X8vBVNqmNO7Gs4ELayT/dlf7mw5gNvcSH1Ct9K86i3UN0ubFPq9d1+HndBCkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677010; c=relaxed/simple;
	bh=HO3kMzX3++941hDd+4FiOnTVZEiTsHEAJWUsba7xzCo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uyWr+W4n5Za5m01BsX1ZO6H+//5418DAwy++z4w7eA01CrdR3vASErPBX+EUKSZjqhHTn/znk30m71IzyfCbw+HPaAJ+jrGQGTb1tGxEG4DTqLtnTzrYLlCqwFyqYFJb+XdtJH+PiZLM5tfFuVI/LGzx3z3LKdEodSG63F1Fm7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Ufh/hhNC; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Ufh/hhNC"
Received: by mail-vs2-f43.google.com with SMTP id 71dfb90a1353d-5d3dc9b7f45so41952e0c.2
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 03:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790676989; x=1791281789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UoyoK9QhTWTjtlh2q64dzZQ7shB0zCBWTARiumkOiSI=;
        b=Ufh/hhNC6Wgp30e4S0p5ZET/FX37yjeOVhmXJfr0zkrwaQmZTqtU/VT5LKX8s41Zo/
         vzjrJyYbk389H1v7jYR4y3qJvpYuZ7S3ha+uUfKDTQ6eJ5bHbRbjfljmSReZNiLc/V9v
         c6OMy1DPyyD6BevDFZpq/2iBfgzDwH1wb7E1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790676989; x=1791281789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UoyoK9QhTWTjtlh2q64dzZQ7shB0zCBWTARiumkOiSI=;
        b=0jtTI3OUnE+3UjW3AOxYbSXDhX7A2OrAHg5vRm7co2Pye4oCU/1RB6GmZSSthKHepL
         3OH88P+VgdTMPjPLX0nqNaavkGvOaao30rJrPJoYD5poFDfBRsL1w8wXRDMB3sXGGsxQ
         lvKQ4zCoNg/gKLNBtBCjNxaitpAz3RebSFV/ivSnsqO6xqnjktqKJu9ezR4V8ZRbZdn6
         10BDw1PeInLdKh659D695bGvoBmWNyQgHmWwqkZyepV17D3Q8IPmStINwRe/kaa+Kyo/
         SQLipePiOPxnvwk6CmSFX709l9EwxUaoaD4i8dGfaoaD7sFHFUe7BT4D0XldTXbOrALs
         Sg9A==
X-Gm-Message-State: AFq9FYIqmu9zKBUfY0dK/hy6ysGIXRbv+cVAIps/UVOBNWQbdPt0UuBw
	WaFcTKnIvTOn2+1bxm9NtfDU7vU7qxsZ7zoE82/tCHLReUj8KqWeYtfnhC2uoAzEQJDuE0pfohU
	P7GrKnw==
X-Gm-Gg: AYBFou0RXaGuAL6WUOMbjAKAPf/NJsYmEMBkCBncJ4S+VwewxFIeC+GrvWsuzYARL8c
	nEyVl83HnIV2bdCxOUvsS4++UW880NoZFpZ6SuVwepmNgUBV80Um4lHGm2/nLMjmXBHzBD6HyV9
	98Yf4muukpXexanNnuHZtBqHXaQdVZkKWSzFVTa6iyBqvEuocpb+/uJvdrgq3N/q6uYn+0KH5ba
	+mg4xbZ6fgev/lbMVf2k2Hy64AI6GUcsrwtvxnv76iFodCmpdc5hCOapVuXF3chQ0j6b1Feam5x
	9a1aA89J8hT+KkY3s0q4bDMej72ty7cbK49HP0dyxap77jkUckipxVTZ4WRO+CxnlLvqL61hj5X
	L54F07/kIKGrG9N+G11LuLuBBjsribEZmmMb+ixZBZ2CYltByqLwPS77IxZny6Mf9nQ5PtG+fDU
	6FvjdLbGapEqoJ7khvf5L8d0o8L0JMc1QqrdKFlMJcrcUMaC6ktEAY9QHztRW7ClbXhqt0NW8OE
	FrF4xjqpiV5UCE+nlbYq5dtW/KnMs+qJNMT7ITY/A2+nvAsqg==
X-Received: by 2002:a05:6102:a53:b0:7b4:740b:9b6 with SMTP id ada2fe7eead31-7b4741a67c0mr1736414137.26.1790676988044;
        Tue, 29 Sep 2026 03:16:28 -0700 (PDT)
Received: from majuu.waya ([184.147.180.207])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7b39b15808esm13134189137.5.2026.09.29.03.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:16:26 -0700 (PDT)
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
Date: Tue, 29 Sep 2026 06:16:12 -0400
Message-ID: <QDISC-6HS9.v1.20260928064754@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20260929101612.1WFW_KNa_AcaNSXi8zeurVg2F0bKcbxsQicEDHfQkSo@z>

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
