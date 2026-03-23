Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B8635F193;
	Mon, 23 Mar 2026 17:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774288176; cv=none; b=TLe/YvB6XdO6mVfvMoi4VQzWeP8tr7G+Mg8NzBY9R1YrN3xVqWFOVwIiLBfx/kSWqdqh3CbEDQkc+y2L0fj/38hepP3XIuBkV0lFH6hCEcsbZBQWV46hpS1JV4YNQmSkxaEmSJ1B+obFCZBOUkFp9PQ69oUMX4LH0N8s2mbuAhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774288176; c=relaxed/simple;
	bh=Az2Zp0rUgzw7fe6Vgy8bvNqzI3sQf1pc5Ypg03fduTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Whe0nOi7r0DPUIqRN/7WYzQqbSo92Uu/S2MzZoyU+wBHlsusavxBhzh3SVou3JWqzbOBOLy5diuaST1y7WJYF8VRzEl8gvvNju4qI9eO6QW9oaX7bKIOC3YpUquMqBn8DSoA7xN3+nzR0Nt3HD5sDLnzaZrP6qCjiSepxG5u2Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAezfb6W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAezfb6W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6838C2BC9E;
	Mon, 23 Mar 2026 17:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774288176;
	bh=Az2Zp0rUgzw7fe6Vgy8bvNqzI3sQf1pc5Ypg03fduTc=;
	h=From:To:Cc:Subject:Date:From;
	b=uAezfb6W8s+pDiBEbq169eF3l/9KYBvXzTJtODiUoeQUci3Z1pnhh3NW6mOpYMv2D
	 U7PvTrOjDDc/SJP8yXGkv5PUnytr0F2rEGvJBpCYoRiAFKjH0kGg+GjD9v8EmjtU/Y
	 ZtOwlAqewgfUZiBrD4wr9hiOK2DHtoKadqN9NEG8G4oZ6t7Rn5bE8t9JLadBWlDWiw
	 wISSA4bV8rNk0kydirwed6+s3dABqjxBJbEqtPC+WCerwyecxa19Xflg95AdG9PXXs
	 TWYBlZm+Hqq7UjFCCzQpuAgpvYDLV5XS9A0RH4HPVXo/OnemL5WWB72GMcLwLrkbyF
	 HiiHdaUmldo8w==
From: hawk@kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com,
	=?UTF-8?q?Jonas=20K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Chris Arges <carges@cloudflare.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH] net_sched: codel: fix stale state for empty flows in fq_codel
Date: Mon, 23 Mar 2026 18:49:20 +0100
Message-ID: <20260323174920.253526-1-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jonas Köppeler <j.koeppeler@tu-berlin.de>

When codel_dequeue() finds an empty queue, it resets vars->dropping
but does not reset vars->first_above_time.  The reference CoDel
algorithm (Nichols & Jacobson, ACM Queue 2012) resets both:

  dodeque_result codel_queue_t::dodeque(time_t now) {
      ...
      if (r.p == NULL) {
          first_above_time = 0;   // <-- Linux omits this
      }
      ...
  }

Note that codel_should_drop() does reset first_above_time when called
with a NULL skb, but codel_dequeue() returns early before ever calling
codel_should_drop() in the empty-queue case.  The post-drop code paths
do reach codel_should_drop(NULL) and correctly reset the timer, so a
dropped packet breaks the cycle -- but the next delivered packet
re-arms first_above_time and the cycle repeats.

For sparse flows such as ICMP ping (one packet every 200ms-1s), the
first packet arms first_above_time, the flow goes empty, and the
second packet arrives after the interval has elapsed and gets dropped.
The pattern repeats, producing sustained loss on flows that are not
actually congested.

Test: veth pair, fq_codel, BQL disabled, 30000 iptables rules in the
consumer namespace (NAPI-64 cycle ~14ms, well above fq_codel's 5ms
target), ping at 5 pps under UDP flood:

  Before fix:  26% ping packet loss
  After fix:    0% ping packet loss

Fix by resetting first_above_time to zero in the empty-queue path
of codel_dequeue(), matching the reference algorithm.

Fixes: 76e3cc126bb2 ("codel: Controlled Delay AQM")
Fixes: d068ca2ae2e6 ("codel: split into multiple files")
Co-developed-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
Reported-by: Chris Arges <carges@cloudflare.com>
Tested-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Link: https://lore.kernel.org/all/20260318134826.1281205-7-hawk@kernel.org/
---
 include/net/codel_impl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/codel_impl.h b/include/net/codel_impl.h
index 78a27ac73070..b2c359c6dd1b 100644
--- a/include/net/codel_impl.h
+++ b/include/net/codel_impl.h
@@ -158,6 +158,7 @@ static struct sk_buff *codel_dequeue(void *ctx,
 	bool drop;
 
 	if (!skb) {
+		vars->first_above_time = 0;
 		vars->dropping = false;
 		return skb;
 	}
-- 
2.43.0

