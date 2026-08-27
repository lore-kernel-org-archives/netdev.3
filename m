Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317C646AEE4
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 18:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787855229; cv=none; b=YzD9KVqVUxW10Kk2meCwKhjf3Wk4zki/6mVAR0Kxeypp9RQjkKB+mmU/xNz+j6yLwgTuNRVkjxPYXGzm7mFJMxle7wkvi8clMiI+nw+q0ND3kxi/UW9OvSi5Wzecb2J0RgrYYuJD/dGFWdDyYLiNKoooEPUOStRjgLEGsiOt0jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787855229; c=relaxed/simple;
	bh=QYThMHGG1K+g7XdUfWdgFZNifigH3qkZM0bwORC1CQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5o1Ipx4jV24qWqyt9dVjGGd9NJUbFe+cOGJE0IMj0gpNA2P621/gjkMNQZ4GhW42b8KCNwN0UUntbZRfDCm9w0xxqO3+WM365C0RmFol1XOR8u4wmvhR7OsYpK6eQ7LCFbNqvuZnCQwcLAVuQuRfDp2QAchUHj6oXoMonAPwWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=mtgkdzHJ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="mtgkdzHJ"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso96820b3a.1
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 11:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787855227; x=1788460027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bWfJta+Gdp3BTxZw5fOdxizjLpZb3H9i2ar+IchDHeI=;
        b=mtgkdzHJ+kKOLb9/pocEM+FY/c2arAH0DntR+IA9oQ14bo5dSXnw+Y6sDFXInihc1A
         5XLerAETkgMvTj8QDlMQOi7OWatckE3MOIZrEDFcVfEXXpMrMFnoMCQH8ISoQzlx4e5F
         fm2RGmlIgZiurQra9JMCe2k2Mh3LPZ6lOsC1CEkELC1pcLatBmyfIdtW/34r1bAW8HLv
         nMCmxs8YEC0h+aDnIpIt4sxfOHDWifFwUSFlZxmwpZzcvDMJlUb7RHZ4jLiCjzppIQo5
         aedi4VjJkQ8K7+z6kiNY1nXhJ4Ak/9IL5PhYGnNPpQotXuEaIlYhm1U854IewrL6VM8R
         tXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787855227; x=1788460027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bWfJta+Gdp3BTxZw5fOdxizjLpZb3H9i2ar+IchDHeI=;
        b=GnpWEZeTKVANaVB4z3l0mgTj5KY6wHRLDgOUB5cQxeVNC2UAjmi5nwycF4LVgpSPyu
         uFUBFaw4GCOocSZ2SpftLCPYY2Z7iSM5aPqFhrYmr8E5JQDJS3OiSbgQIbk9Ok7vcgVH
         qc9Mdo7uFgUTjBKZ4Vryiwx3KOUO5zJShGlpGyoF3UMN+EZ7TICruuZsO2L/IALJtjPL
         j1alkjMTD7Q9ibOZMRoWegjU19AqHAXb88eKMqkh6UgHDkQ3rh2RBiTgUUhDStqFY8D0
         Gw0PREaxARxTcRADpnYoQw0QJhoUSGCIE0QDtLbk5cWZAMa0ak5aIG8CG14KqsJcimSX
         zsMw==
X-Gm-Message-State: AFuF++kC2r4RrtTGe40r09ulqWV1qNrSWDIE5tkiqCRD5ZMbaRD6n6Mm
	QuHmkrwMPy4/8PJZqoD7DmmYZRt3RG9Ib2aATty/YoBedndNs8WW0jHg8rN4AQ5fTanOKYGdLmQ
	dFjOKGMZ5P6Dffw==
X-Gm-Gg: AR+sD13ePvngVTfq6V19sxwOJ0tbffI0lRD3vATpAtuqRlx7O5/rPoI/50fm/toVR6x
	/Aq5XKzJATHEOHYEFMmLzFA0wIBlt0QAAuFgqQFXiBY2qGftC95q3i/FuLLR7E87FO1do4Hop2k
	y9USD2/8civ0sQ4u7Sr+CZSXOsVUGQU9EgjkoX8vfa2j4n64rooSAymMQLDbXTqC3+w1Td+Jd2y
	GSoab0e9wtQcobzUlkFM1SW7tGKxmJpt43rroiZQbHlO0PdALRvWNUchB4vXOqZtC1TDpRaVybP
	CiiTtCcY1OeXMeD9N+gILtP7eP+o+QoD61Vsnj5K2njamA15XwCyGUE1I89wP+SHZf37xPjDoVJ
	hGnL+e6Innql7xBT5Nkzk5uRH/CIlC9UFfl6rpB5CG06/XdDX38vqqvY4tCT5CD5GBJNbInXQou
	1RT+fjb2UgVPwYXeTYhZ4kQTpk+EFwwp3XcIl5X7yviL3hXpZObuJl8FI+eMZMzlYtU6rwVc3Sx
	BtWUIXz6KCG8g==
X-Received: by 2002:a05:6a00:a585:b0:853:90fb:aa6c with SMTP id d2e1a72fcca58-854c6485748mr12053839b3a.2.1787855227265;
        Thu, 27 Aug 2026 11:27:07 -0700 (PDT)
Received: from gmail.com ([202.201.12.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8535cf4462esm2333905b3a.53.2026.08.27.11.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:27:06 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Peter=20N=C3=B8rlund?= <pch@ordbogen.com>,
	stable@vger.kernel.org,
	Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>
Subject: [PATCH net v2 1/1] ipv4: avoid divide by zero in fib_rebalance
Date: Thu, 27 Aug 2026 18:25:14 +0000
Message-ID: <20260827182514.4667-2-zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260827182514.4667-1-zihanx@nebusec.ai>
References: <20260827182514.4667-1-zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fib_rebalance() computes the total eligible nexthop weight in one pass
and programs upper bounds in a second pass. A concurrent change to
ignore_routes_with_linkdown can make the first pass return zero while
the second pass sees an eligible nexthop, resulting in division by zero.

If the first pass reports a zero total, set each nexthop upper bound to
-1 and skip the division. This matches the IPv6 fix in commit
d2c26c2911dd ("ipv6: avoid divide by zero in rt6_multipath_rebalance")
and preserves the lock-free rebalance path.

Fixes: 0e884c78ee19 ("ipv4: L3 hash-based multipath")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v2:
  - Replace the v1 RTNL sysctl serialization with a total == 0 guard
    in fib_rebalance(), matching the applied IPv6 fix.
  - v1 Link: https://lore.kernel.org/all/cover.1786812660.git.zihanx@nebusec.ai

 net/ipv4/fib_semantics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 0483519b7fb0..7a362f2e2c2b 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -874,7 +874,7 @@ static void fib_rebalance(struct fib_info *fi)
 	change_nexthops(fi) {
 		int upper_bound;
 
-		if (nexthop_nh->fib_nh_flags & RTNH_F_DEAD) {
+		if (!total || nexthop_nh->fib_nh_flags & RTNH_F_DEAD) {
 			upper_bound = -1;
 		} else if (ip_ignore_linkdown(nexthop_nh->fib_nh_dev) &&
 			   nexthop_nh->fib_nh_flags & RTNH_F_LINKDOWN) {
-- 
2.43.0

