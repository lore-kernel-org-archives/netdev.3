Received: from mail.qrator.net (mx12.qrator.net [185.104.210.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46D354489F
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 18:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.104.210.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891556; cv=none; b=ZvtIS6XJy4nTYy14Vly7FGRD/E9J4Ulo8g3CbeR53rS+MytZovHwMg0By/WeIfvyl2dgjZAv4Qd4fuUXup+SQDNaljas6VJPMog8xZh5q3i4S7YHG6eMXN2s6mRxX+z1eNxupZMfXi4otdv5SzNNTFFQvF+JxIwBeBTXE0Z6j+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891556; c=relaxed/simple;
	bh=sTNsuukiNJr3oQBvtE7nfzxkn0GUqo9Piao1Aku1JFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3uTjKV3tOxT1FogHk0R/kcmfJojp7Y4FNooA+qLGCZLJsZILwWdeDOfvXF77eOc3a4oivhFOZezMTqQhLC1AeI+B1YI2SjpV/g5TVP4TuaYaZXD2KS2maKmWIxJCcx4dHzLqoVLx23va/JEt59uYSoUe3FaKcfbi7i5M0uuNKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qrator.net; spf=pass smtp.mailfrom=qrator.net; dkim=pass (2048-bit key) header.d=qrator.net header.i=@qrator.net header.b=GkWBP82m; arc=none smtp.client-ip=185.104.210.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qrator.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qrator.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qrator.net header.i=@qrator.net header.b="GkWBP82m"
Received: from mail.router (mail-postfixrouter-1.mail_default [10.0.5.10])
	by mail.qrator.net (Postfix) with ESMTP id D63306B28AEF;
	Tue, 08 Sep 2026 18:13:05 +0000 (UTC)
Received: from enterprise.localdomain (unknown [10.0.5.1])
	by mail.router (Postfix) with ESMTP id 9D8206B28AEB;
	Tue, 08 Sep 2026 18:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=qrator.net; s=mx12;
	t=1788891185; bh=sTNsuukiNJr3oQBvtE7nfzxkn0GUqo9Piao1Aku1JFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GkWBP82mZQy+sGMP0DXwk0V0tyHGovf/zAuNooTIWxqGcHYTF82T9ayC/8ewxK7rY
	 XoTL9ZtDBavlc8Zq7Twfd6Zb72atXB9QRuHpFo/U+ABjFtr2SzfGhntrK8jrN5zdEY
	 N7jCDKdDKre1GavE7fAfwLkWMTsBa3EsNe2c9mq0WifO8Vv6+B2nyReUHxU/cl7pjb
	 hDRm62dbdDKfRMq3QHO9J8OctFLsQi5vYVdjYMLt5LzH7oCbbSyY//6corPLqBq0BQ
	 bQQF/1WK5FIu98puQRvPuQPXaKGtIljRl0hyMWPkIQ7djQeb4vWiLCcS3L8v+BLmw2
	 Z8WZZ2Yl6XtkQ==
Received: from localhost.localdomain (localhost [127.0.0.1])
	by enterprise.localdomain (Postfix) with ESMTP id 1E852B3F3160;
	Tue, 08 Sep 2026 18:13:05 +0000 (UTC)
From: Alexander Zubkov <green@qrator.net>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Petr Machata <me@pmachata.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Alexander Zubkov <green@qrator.net>
Subject: [PATCH iproute2 v2 0/2] ip: ipstats: Fix statistics split across netlink messages
Date: Tue,  8 Sep 2026 20:12:23 +0200
Message-ID: <20260908181225.31712-1-green@qrator.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260830181949.1096-1-green@qrator.net>
References: <20260830181949.1096-1-green@qrator.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel can split the statistics of one interface across several
netlink messages, and "ip stats" formats each of them on its own, so the
interface is shown twice and part of its statistics is lost. Easy to hit
with "group offload subgroup l3_stats" on a box with many netdevices:

    109: vlan859: group offload subgroup l3_stats on used on

    109: vlan859: group offload subgroup l3_stats

Patch 1 merges such messages before formatting them, patch 2 is an
unrelated cleanup.

What the merge rests on, for whoever touches it next:

 - Only the last attribute of one message and the first of the next can
   be two halves of one nest.

 - A leaf is emitted in one piece, so a leaf attribute seen in both
   messages is a layout the kernel does not produce, and the merge is
   refused.

 - An array is only ever split between two of its elements. Were an
   element itself split, the result would not be distinguishable from a
   longer array of shorter elements, and no reader could reassemble it.

 - At the outer level ipstats_stat_ifla_max[] tells which attributes are
   nests. One level in there is no such table, and none is needed: the
   children of the two halves are whole either way, whether they are an
   array, split only between elements, or attributes indexed by type, of
   which there is at most one of each. Appending them is then what the
   kernel would have sent unsplit.

 - Where the merge does not apply, the two messages are formatted
   separately, which is the behaviour this patch set replaces rather
   than a new failure mode.

v2:
 - Comments and commit messages trimmed, the merge reworked around the
   two border attributes that can actually be halves of one nest.

Alexander Zubkov (2):
  ip: ipstats: Merge statistics split across several netlink messages
  ip: ipstats: Do not hide HW statistics when hw_stats_info is missing

 ip/ipstats.c | 266 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 258 insertions(+), 8 deletions(-)

-- 
2.55.0

