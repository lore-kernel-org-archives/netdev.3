Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793291067;
	b=BHgXISQuirQQcub5oN7afeE40RWD+bBjb9eQSKArwT8UvOvGvH4Z+fwByRL2lVedcC09
	 4aZJbW8tyugDkykyEKBizeIklSgthyxcpLw8fAIxiQzbX0bAgwFSuaH5fPFbl0cNxAOV/
	 aMLWWPK2G2XNfeDpqmvH6H5grZE//hznu2f/HhYry5W7+PFTATirKFQihLEVqoRhAr3fS
	 AHz4X3nZtI6hH7RRX4t6Z7pAuzqPiM2WHFgQ0aqvo9GBvPpb2pN1zYOVYFEFaEysKlQMn
	 JWDUIagWWTqMCcB9yaS2idvmFkeFL4ZRR0X6qons8kqBZ6jr7dLDpui/khFiCVlSt2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291067;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oNt+k5hd6gK3JHgbJpiRSUaj/zK/QDMMxaVigJ+IVv8=;
	b=D+WHhie4sWKGA4xa41ZQmTdUynI7UgaAkAbFU5HLu3CXXAip5eoUB33FBgJw53P+4n0b
	 zgdmjrvbC9SSpHAmg4zaPrM1FuXy4u4WsNUWaE+QgBG7TPvXoD57O/NATzwSA+eqs5qyo
	 GTELjqzQcXImYHhGCNCZ59CtIoeb35N2vUvn5ZsWuU4UZixvRoN7jiHM+uwYx7q46of8N
	 mdM2i60QuwHr1MdTlfa/UoSfcJ69Lcnr1iX8BYfgcdpqm5tXUiAV4mbSRd4zFauF4KVIU
	 fOeFUCYsLGGRU+J1yrtNYTuHOX4ic8NbnvAxy9ZM0/VwgOufLpe6O4c39QjbbTUi14Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EGgcrtXQ;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D22606A31D
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 16:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43D22606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EGgcrtXQ
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48e20edd106so1859389f8f.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 09:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793291064; x=1793895864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oNt+k5hd6gK3JHgbJpiRSUaj/zK/QDMMxaVigJ+IVv8=;
        b=EGgcrtXQdOXQe8Wg0+y8mCFeBHdwKIWFWLS/tzXhFxzxnqxJrzHwwWiZtPoBhrGyJ5
         MJMiCdAOXmfo0PFLF8Gw6XXBHnFLiZx1RPVgWgOIayKgr5ex+ji6RJACXHIRA2UMfkUp
         K94IctlgigFoTiFGSgNvWkZJwURBoPJ8ZOAXPv7ziW7TPFNd0rY8zBP8/sFl6i6HaLu9
         TGAUU8LJZhRX+gcJnKV2J+GUnwrH/f8+XehiIAOGPRgYE/VmO2/uvWCsMyyDFz5kHlf/
         kwp16+H7ZDGxYyLza2o5TJWPDlOpw3LGog5MqLTr0MGnczBNMJQ1jAlV2E+vyAkVSNmj
         avbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793291064; x=1793895864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oNt+k5hd6gK3JHgbJpiRSUaj/zK/QDMMxaVigJ+IVv8=;
        b=KKp7m2Hq87HGLVQowj1zpjBmczBS3eaMSBQq89sXe/szCZO4FWyc9GgakRQcLE5qcT
         HhUrSH76ZcMPO3WCrgzH9DcMS8/LDYYMKGrVA7in4zuJDZTaB5zZ70JApZxWgqPjPFeb
         YNX3gw/09upIwAzRbeEDWYKWirYH3R7Sa+/wxCMwvA8zsVC2e7IciTrRHQ88xRmp0bQ3
         hEpPQxUogUEb50sEmi+0H2mKT4qfkV4rDIlzn6/h5mBYLRx9wc4FMKDwg6GEDdQ3b41F
         eCCGv0Ai/8SGVZcHFBldGq+/4yFP0MRaECwEQfxknPbrkOVTclS9yYHCq4ditT/7bQPj
         vtaA==
X-Forwarded-Encrypted: i=1; AKwUvBxCUkvQzi5SrtLQAUk0ReYjKPXjJ5u8YX5Zyv4O7TqNMaKE+q8c+qDsjUFfI1H6J75OUgu3UtA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIQJCn+vYvNzfMiMwxDpim3ckJpD9vyq64UlLEuDXERk9SW1Xga
	U5f8IJ/viflxVvTLcldUytwDUhfrZSEOucF0VdEEMz5Y2Z1F3fy43m8=
X-Gm-Gg: AYBFou1+cZXnHCXND/7M/sVpqQ65mTKCiYzOIMUw8MCjk+yORst0qxdlFMlfTBsf0AX
	UYMFNHN0KIwHMCZX2vUSAhuCKvY5ftAvjEO2wvncD2+7eTb6DqDXLSOoLwwPvRgYNvd+fBLalfz
	L84aBgai6JU9rS+tS8YRE4cqkqQWIjoI4hvFoWzPqaz4SSEoaNhF4OixdBdDHSyeu0IvkHB3oWK
	LzmzQ/DnoYrLTY1PCTprpaHkB6PdAXOz9JdcMOZQsKs41iGTH0NNGJhVdI1SkF7l5ueXdKvMk6b
	EuYyHOGFHpL01THBBbImjicpd6DzAKHmfi6r0/nOkZyp1YSz0jjs4l9I0zA83Y/mUz+Z/g5/RyG
	h/GwXjroW8xZxm+s8v9rYgW/UX+8q2lfpVJMY7er1Vw8KxJo/M1cLZFkCKZA9gy7l0yQpVqFruA
	iq5wnzvFYOCIDEZeaw3wKha7xFzdw7wzVAkL1gS2bWGH1pjLtMbvlLoOeiuaSVXEaSBP8MmxkyI
	7//4AXXCv/ifeYJDrzFs38vCjF8946AlllQKAmvvdM+kaE/hm0O11MZsx7ZRYSi73bZiCpmdQ==
X-Received: by 2002:a05:6000:603:b0:48e:389:d2d5 with SMTP id ffacd0b85a97d-48e5d5b4a5emr14665720f8f.51.1793291064450;
        Thu, 29 Oct 2026 09:24:24 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e6dfaa4ccsm135494f8f.39.2026.10.29.09.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 09:24:21 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: David Heidelberg <david@ixit.cz>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	"John W . Linville" <linville@tuxdriver.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2 net] nfc: llcp: use disable_work_sync and timer_shutdown_sync in local_cleanup
Date: Thu, 29 Oct 2026 16:24:19 +0000
Message-ID: <20261029162419.2420980-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

local_cleanup() tears down timers and work items before
local_release_work() frees the nfc_llcp_local structure.  The current
code has two ordering problems:

1) timer_delete_sync() does not prevent timer callbacks from re-arming
   the timer via mod_timer().  nfc_llcp_tx_work() unconditionally
   re-arms link_timer, and nfc_llcp_sdreq_timeout_work() conditionally
   re-arms sdreq_timer.  A work callback that runs during
   cancel_work_sync() and calls mod_timer() causes the timer to fire
   after the structure is freed.

2) cancel_work_sync() does not prevent work items from being
   re-queued.  nfc_llcp_rx_work() queues tx_work via
   schedule_work(), and the timer callbacks queue their associated
   work items.  Since tx_work is cancelled before rx_work, a
   running rx_work instance can re-queue tx_work after its
   cancel_work_sync() has returned.  The re-queued tx_work then
   runs on the freed structure.

Switch the timers to timer_shutdown_sync() which rejects subsequent
mod_timer() calls.  Switch the work items to disable_work_sync()
which rejects subsequent schedule_work() calls.

Reorder the teardown sequence so that both timers are shut down
first (their callbacks queue work items), rx_work is disabled
before tx_work (rx_work queues tx_work), and data structures are
freed only after all asynchronous callbacks are quiesced.

Fixes: d646960f7986 ("NFC: Initial LLCP support")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
v2:
  - Switch work items from cancel_work_sync() to disable_work_sync()
    to prevent re-queuing after cancellation, as identified by the
    automated review and confirmed by Simon Horman
  - Reorder teardown: shut down both timers first (their callbacks
    queue work items), then disable rx_work before tx_work (rx_work
    queues tx_work), then disable remaining work items
  - Move data structure cleanup (skb_queue_purge, kfree_skb) after
    all asynchronous callbacks are quiesced
 net/nfc/llcp_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 74bf817007cf2..984e7088288f0 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -173,15 +173,15 @@ static struct nfc_llcp_local *nfc_llcp_local_get(struct nfc_llcp_local *local)
 static void local_cleanup(struct nfc_llcp_local *local)
 {
 	nfc_llcp_socket_release(local, false, ENXIO);
-	timer_delete_sync(&local->link_timer);
+	timer_shutdown_sync(&local->link_timer);
+	timer_shutdown_sync(&local->sdreq_timer);
+	disable_work_sync(&local->rx_work);
+	disable_work_sync(&local->tx_work);
+	disable_work_sync(&local->timeout_work);
+	disable_work_sync(&local->sdreq_timeout_work);
 	skb_queue_purge(&local->tx_queue);
-	cancel_work_sync(&local->tx_work);
-	cancel_work_sync(&local->rx_work);
-	cancel_work_sync(&local->timeout_work);
 	kfree_skb(local->rx_pending);
 	local->rx_pending = NULL;
-	timer_delete_sync(&local->sdreq_timer);
-	cancel_work_sync(&local->sdreq_timeout_work);
 	nfc_llcp_free_sdp_tlv_list(&local->pending_sdreqs);
 }
 
-- 
2.47.3

