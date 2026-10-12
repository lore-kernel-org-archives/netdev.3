Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061BA48EC62
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791809993; cv=none; b=rhhSxBneauFRLgKufA6cP/W23KXPJxFmPUazeDgpa0BfxC5kFQXNUAkY/IlpTUAmWN3Co8Kex3KruVoCkTd92/qybcP/PdDm6DpOb94/LT1JORjyWJS14UOSu8zTZezdgcsUzcWuV52jd3PTDjWisT+GdDCptRXp1iKTeaS3PN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791809993; c=relaxed/simple;
	bh=fPB+wZjG3HVi2iSjYqkLH/ckgebyx31G+/S5iuLVqbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+083PMPdHl1B6XXWvYYHOmS0CrtrIw390Tp9awdieuXgYnyoLMhj3wQjyofRhXdQcXuktV9/uld2e/hffg8uKeuQxpPrFAbdt5B92k0VTfOxDk83W9GII9nFnfQgEg/yBeD8MF+kSrB9IfcC3xGa5+v5ODXq5h1TNQBOQQC0+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=Hfy+8nT2; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="Hfy+8nT2"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3550c917fd3so2685271eec.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 05:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1791809991; x=1792414791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sZ1/UevHkaiLLGQSB4KaOHNVe81DkpsaSLYz0M3iQ3s=;
        b=Hfy+8nT2yt9g3+G7dCdBi/fHHVBrfSIV0QEazuNWlYNFGudhXhYqcTmFO7F4Gh7ejf
         Qsi1tYXTSe1Dh8h9zDIaKlKKR6aTpRVoUyjWvp0h6ZzWYuTmT69isLiezxhQJ81dyIDe
         mROImD80ye+l12vs5955qYu232ece0JT5APKwslXb7VdR1pAZX8aAztRK5emVozE7xKU
         AoH1TU2H9lGdqzZ3RL7mF/avEJbNP0+s9wGHABTOAWjDHD6CvMgo0029mQPI6aWga6ri
         w/U4FQlk7ZULqUOx39KK06SsekJpv3QIb7fK2l9hzpBuaHu+qQHPzK3rGCgoc1s+8OCs
         2ZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791809991; x=1792414791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sZ1/UevHkaiLLGQSB4KaOHNVe81DkpsaSLYz0M3iQ3s=;
        b=n08ljuOFbnWPcdgP/Qoc8wj6QeD2bacpSHT272vAQJusY9w9gZf7nagBUtO6HiylsT
         U7zTndS77N52WeOOi6smxDri8lxWAnrDz165QsldDC5Lod0QPIfk493rvpWz01Mto0Lv
         V2jnSDyjVq16uEWk8cU6u2puhZ1bQBhLioKqijDfNMRTTnVZcHLmiSvCMimqwWAfguu8
         q+Q1p2juQsxZP19Re8K0hYFl/MBARd1580Gm6WY+tgUdi1fY+EAngMKNoWvX95a0IEYh
         QPhqCQahX5yCMSntqK7xToroI1gPrfJHKVE+7ODPz9hl3W4kYx1n6tBM3BurlxRomMmX
         yKVA==
X-Gm-Message-State: AFq9FYJoqBhpRIVIbf99KOnbyv6zTQY/vFYuPPvK1nXhM4R8CjsONP6a
	cUSjeGcVAu1GGWSfVx1ren6Ane9yVXv8oopmmLzU3seH1alMNZd+OehI9DUR8D39GYQ=
X-Gm-Gg: AYBFou1bLBFKp2zffXYELtElEwOK/9nc/JAqvsdWYceycbNDdVNzNuE6tz22jXX3nPo
	aqe62rogLCMRSWMSwjYVHfsds+XKU94HEsQDEm8q3tHiNw4bVZF5ACBiVDBRYmGYe6qeMd2SNco
	QsQNAYHlY4YzGvVoxWLXT1acT7usvfluZKQmWczth5/5Tj73F1rejy3mOZzn4AzLxmdRP2X8hJr
	dZc8phIdzPfKyJenBZ/f+DiJSwxxVzeFlhzJsziGk0T2dC4PWW+qoKj4mD+fiJGiysUnbCCqnHp
	0UqJ68o++TG6rLqXLVSV0tr6fZ4M8xNmLqMb4n7xK6CP5ILApxewx5OItJUIYHbeNOnL+yYH/PY
	WYmneUDMvnFGyXPsBcYR0yRrE4kWKhLgZhG2Fu1PMXjKOqdOhDBTkCHds0B2yYDHoMLGpSEGMkF
	C5rAR7Un2TZPtnhnIefEkoK1X12DMSpkkgIqzMdL0xc/Y+nDNwThra3HkHDuPHGvOR1qKx0Kw97
	A/+QC9s9ul80O0jmQgdIbTeAyhqfxD1/jYUigJr4Y2Da4usAYgHDX58SNqIWTrxhEX+CBsB/w==
X-Received: by 2002:a05:7300:8803:b0:353:7b46:4819 with SMTP id 5a478bee46e88-3537e032905mr15793475eec.8.1791809990942;
        Mon, 12 Oct 2026 05:59:50 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([69.25.95.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cacb61asm35348067eec.21.2026.10.12.05.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 05:59:50 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v3 2/6] amt: reject a gateway Query or Data from 0.0.0.0 before a relay is learned
Date: Mon, 12 Oct 2026 12:59:39 +0000
Message-ID: <20261012125943.558629-3-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012125943.558629-1-omar@blockcast.net>
References: <20261012125943.558629-1-omar@blockcast.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A gateway's amt_rcv() admits a Membership Query or Multicast Data message
when "saddr != remote_ip" is false.  remote_ip is 0 before discovery has
learned a relay (and is reset to 0 by amt_dev_open() and when discovery
gives up), so a packet whose source is 0.0.0.0 -- for example a
0.0.0.0 -> 255.255.255.255 broadcast delivered to the socket -- satisfies
0 != 0 and is accepted.  With the nonce freshly reset to 0, a spoofed
Query is then taken as genuine: it sets ready4/qi and the response MAC and
suppresses rediscovery until the discovery timeout, and a spoofed Data
message is injected the same way.

Reject both when no relay is learned: a 0 remote_ip must match nothing, so
guard the check with !remote_ip.  Discovery is unaffected -- Relay
Advertisements are validated against discovery_ip, not remote_ip.

Fixes: b9022b53adad ("amt: add control plane of amt interface")
Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index b284fa7..c3716ba 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -2858,7 +2858,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 			}
 			goto out;
 		case AMT_MSG_MULTICAST_DATA:
-			if (saddr != remote_ip) {
+			if (!remote_ip || saddr != remote_ip) {
 				netdev_dbg(amt->dev, "Invalid Relay IP\n");
 				err = true;
 				goto drop;
@@ -2869,7 +2869,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 			else
 				goto out;
 		case AMT_MSG_MEMBERSHIP_QUERY:
-			if (saddr != remote_ip) {
+			if (!remote_ip || saddr != remote_ip) {
 				netdev_dbg(amt->dev, "Invalid Relay IP\n");
 				err = true;
 				goto drop;
-- 
2.43.0

