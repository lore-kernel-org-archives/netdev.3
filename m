Received: from mail.qrator.net (mx12.qrator.net [185.104.210.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADDA382385
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 18:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.104.210.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788114531; cv=none; b=Tp8X674Qe5e1fgtDuO4ONT9vO8nWVzMaR7486UZrCyo2Exejy5pIcK0IgBCn/mC1UfK88VseI64yDdylhDza2yDpHAEfFdTgZyiNPrmwKKbQPFxA+FQX2Gr9voRAiXm3XEkvDiWa3n5nL2u4YliySl+oJkz/nYWAw2Td30jeHF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788114531; c=relaxed/simple;
	bh=dJi+Unr+id373WAFNyHriWGCGZvOi2K1b/MVPuGqk5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gry4557ojwTGR6lyrL3VLfeDZBMRGUF4qDEwjOxhOkddxfGbCiK/Q0f3AsIy8ZvsX7hOSeL1R+VPgldzCSVKVyi527k9mCzwsg5xBA5JbcxavrtqOS1bAIygJRL+f0E+mgXaMdQtSZHPvgK0+NzxEJOcK/Bm2KEYq13oknT8S+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qrator.net; spf=pass smtp.mailfrom=qrator.net; dkim=pass (2048-bit key) header.d=qrator.net header.i=@qrator.net header.b=FEncgqXG; arc=none smtp.client-ip=185.104.210.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qrator.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qrator.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qrator.net header.i=@qrator.net header.b="FEncgqXG"
Received: from mail.router (mail-postfixrouter-1.mail_default [10.0.5.10])
	by mail.qrator.net (Postfix) with ESMTP id 33B6F6B28A79;
	Sun, 30 Aug 2026 18:20:23 +0000 (UTC)
Received: from enterprise.localdomain (unknown [10.0.5.1])
	by mail.router (Postfix) with ESMTP id 06E936B28A73;
	Sun, 30 Aug 2026 18:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=qrator.net; s=mx12;
	t=1788114023; bh=dJi+Unr+id373WAFNyHriWGCGZvOi2K1b/MVPuGqk5c=;
	h=From:To:Cc:Subject:Date;
	b=FEncgqXGxj2lLJtcEjy5a7LykIS1UXJULmkgZoNFjeVP3te1fN5DGuFCpdvhmEBom
	 L5Ko4GlzkZUyD7E+Nkm3JXZluP6cgfQrB8lShARuO5eROpGKy6ehvBR5b5Lcj3ZxVD
	 Sc79zpdo2S07uhf7fP22wjryy3p2RUMUax6Z0Qg++CViSfHKHkAGufTJZWG60+/rfJ
	 VvmB3DP04KTrPKx1XnUp1uajhgPj0Vq9Jq9V4az+wHrBlhNFA8LgZDAdqNI0iRl6ZM
	 V93t/BakYUR7WmmFViMtmPrjq9tWVqcuc/EclwZKxh/IsJrAlbQHJupyU9Z48wJwAs
	 PAfkEvd9rG0pA==
Received: from localhost.localdomain (localhost [127.0.0.1])
	by enterprise.localdomain (Postfix) with ESMTP id BD9B5B3A8ACE;
	Sun, 30 Aug 2026 18:20:22 +0000 (UTC)
From: Alexander Zubkov <green@qrator.net>
To: netdev@vger.kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: Petr Machata <me@pmachata.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Alexander Zubkov <green@qrator.net>
Subject: [PATCH iproute2 0/2] ip: ipstats: Fix statistics split across netlink messages
Date: Sun, 30 Aug 2026 20:19:47 +0200
Message-ID: <20260830181949.1096-1-green@qrator.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When dumping statistics, the kernel may split the statistics of a single
interface across several netlink messages: if an attribute does not fit
into the current skb, rtnl_fill_statsinfo() keeps the partial message and
the dump is resumed at the same ifindex. "ip stats" formats every message
on its own, so such an interface is reported twice and part of its
statistics is lost. With "group offload subgroup l3_stats", which requests
two attributes that the kernel emits one by one, this is easy to hit on a
box with many netdevices:

    109: vlan859: group offload subgroup l3_stats on used on

    109: vlan859: group offload subgroup l3_stats

The first record holds IFLA_OFFLOAD_XSTATS_HW_S_INFO, the second one
holds IFLA_OFFLOAD_XSTATS_L3_STATS, and the counters are never shown.

Patch 1 reassembles such messages before formatting them. Patch 2 is an
unrelated hardening cleanup and can be dropped.

The merge itself was also exercised out of tree against the two message
shapes the kernel can split, offload xstats cut between HW_S_INFO and
L3_STATS, and bridge per-VLAN xstats cut between two BRIDGE_XSTATS_VLAN
entries, plus a layout that must be refused rather than merged.

I faced the issue on kernel 7.1.5 / iproute2-7.0.0, mlxsw switch, with
~120 netdevices. The split was visible in an strace as two RTM_NEWSTATS
messages with the same ifindex, carrying IFLA_OFFLOAD_XSTATS_HW_S_INFO
and IFLA_OFFLOAD_XSTATS_L3_STATS respectively. The further research,
patches and supporting texts was prepared with the help of an AI
assistant. I reviewed and tested the patches against iproute2-7.1.0, with
the proposed patches the interface is correctly reported once, with its
counters. Although the patches makes sense to me, I have little
experience with netlink handling.


Alexander Zubkov (2):
  ip: ipstats: Merge statistics split across several netlink messages
  ip: ipstats: Do not hide HW statistics when hw_stats_info is missing

 ip/ipstats.c | 285 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 280 insertions(+), 5 deletions(-)

-- 
2.55.0

