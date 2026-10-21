Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792615125;
	b=ONhxQYm25dLCA8+GK3cRmhuoabCRlS322Qu5eXS6Yqhlx/jP+a6Hp1Nk0wDnlgXKGQCq
	 9zH+ejxSYGpxMDnEBZQNdc0KLtT7TCbHcdYLF3DtSWlyFQEeEehq3r2/EobBxO//QFHsO
	 45SPcBDTwV4km7ZtgN5jXSSY13+11x7eC9njxiaWBRNBVnpOzSYUnkUJv179gVgT13kjI
	 InOKRmF5I7OfHqA10ETaHnBmBYEl//DWDopKOAQHH3lTqLB3qEh3gEs6kFDBK46QDiLga
	 un3izdpqsmnRHR5nWkyV94RlNu2Gugh/3osmCdBRFEwG/nECViNeUlnsMjZrZYdDH5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792615125;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QDqMOsDuzil6WajGuk0RdRf8D0CQ7SO9x51N1GbZQdM=;
	b=XWOYWGG8TRBKIpy/ypzrEOrF5G3ZNQ13m7/tYr4hlH9pwgmcrUU50W+NLBu+uGDx+Fw/
	 kLJalNKXSntRca9hVlTXHJlXaJZEoQGlqlrXxBD8ORJ5JuL3H3mboREtK974yJt6HLDcZ
	 oRTlqFnO2y8y0odH6A582Bc6hBPhbMW87k34FfoTBcmt+ItSrjWvPIhwAPrHb6iaXz0vc
	 Dx78xeAL1tTbyVQ1gvRm+pXH6Tlroqm5kWuFHJXaEXiKP8Uki5ZjHuMKcZ7AINSWKc+Mg
	 zlyGbjuKwjliIDO5rl+wAGj00NIDPSiG6HsHIKZPfgk9HTj/P8KextoIKvdCT5LdiPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=asu.edu;
	spf=pass smtp.mailfrom=asu.edu;
	dkim=pass header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b="TYuqt/5m";
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF90606A31F
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 20:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BF90606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b=TYuqt/5m
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3282db206d3so2664785eec.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1792615124; x=1793219924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QDqMOsDuzil6WajGuk0RdRf8D0CQ7SO9x51N1GbZQdM=;
        b=TYuqt/5mO4PjbfnCRxwcJm7BAZwyqRgmg3wp2FBQnEulaSDO8PG1kkau9TrwwG/4rm
         S54X/KvrMS9ftanemrX+21iKHDVucwkzknh255Dw7twnycP9vUEZrqRsbbDZwXmPkQkt
         kL9NjK5dKf6Fr2cUe9oywBQ442UmXHTvzbL3IJRcSb2SOTFLMItZhRVw8nyLvka7+ENJ
         8pSUlA6e168H6A/u6qwE2ZDguV9Upife7jLXEE2IVYaQfjU7FxjhZXDPmilKpww/F5rD
         vaRFpqIqaJcohE82mXETz77IOXcp5EmcODCg+YODE4SJdZTAHCS2QOp91iygN85PDmBY
         KeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792615124; x=1793219924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QDqMOsDuzil6WajGuk0RdRf8D0CQ7SO9x51N1GbZQdM=;
        b=K5PAyUkM+SpjyqAbvo71J+Ve+9cLgxBu0tHTL9lNWYgVST1j3mkETiMqoRfyKHQoYo
         5Gx4hvG90qv8gcDdqaZjdogBHngVkPW5qWRrwYp+zUVYedSgoYXdSIKif8JfqmbLiOnx
         b5TKCW+QP19KQd2dE00Y2LucjSjfLdxAZb+m+HvKiuf5brEGt9bYMk8MPE6kqEqWYXZU
         wrDwoxLYLxoCLEKjF5nM62tqxr5EOOH81LCrdAQSZMvv4nb1s1LaZA6E2V6M/UjnsCto
         i4X1vF/uQEzjPAdAW7I/omVFSJK6oqdKYIrG0uN6n9bU/ul9yY+rLtyX2ZjG1nDJH887
         6ZuA==
X-Forwarded-Encrypted: i=1; AKwUvByKThMpqBt7UQETn5J+gFv/XrQ1YBMtNErvW9CH6LkAw03Kl0874OvrZcs7qCYSgbAQbh3N9gY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKbp0yv+vjRfXLsDWcDYrZIor3l9AXMYiGbPUcidOkdE37OOE7V
	rQzzakjWTxIKMsti0kNaPkp8o6pMdivZnymrD2z30qU/ssN7v92oFNKKRX9eZC387Q==
X-Gm-Gg: AYBFou0uWZP21d3sMvuOg8zHFxMktKCS13Npk8UFT3TunYZTW2G2iemItkcME6lmbD7
	OyTUBL+0iv951vR3zBGL8kW0oogHfg1NpxkRb/IPCL+8sqkbDFz9J/MUgf5SxizxDxsp+G7WWTQ
	5Prz/5+ZO6zWhBFKq6+VkPtz741gJcTSwwGNsodAucbfBhvUP6xGEwxs9niH8wUCmQJy4/+qa20
	Am5q5XFWLq5Knl2vH6z8hODnJuFEn0AuegmbnFOkcQ8GHXhhI1nVV11UXFV/nsVQvAcRtafZ0BC
	VmLWrExBRWHH+xVzDFvMupBkcs/hIYqNLAJTzJweOKIINJSSi0RvkNXpuv+1esZEfszKgrNKzWA
	3/mzT0v8wMMjKSEIkdCERyZAgWtX1B12AqWQOSvKTPAECufGR6X/9c3KDpxsu3LcTutIOumHRx7
	y5+iZ5BQegDYLmqMsCZATR0RMvxbUyepeM9IYXSFp+GrzgfOATbiiztSdOMIdMGnXV/by97mEiX
	IS+v2gAL6NUZkfPe3NJcsKYU4Ml/7goGaIHbbZAfPruR+21UAf+2fCIEf3XKfriouwCwbnpnQtY
	rjpnuuIvICE=
X-Received: by 2002:a05:693c:8955:20b0:339:7b3b:236d with SMTP id 5a478bee46e88-3674cf43498mr4460582eec.15.1792615123572;
        Wed, 21 Oct 2026 13:38:43 -0700 (PDT)
Received: from gio.localdomain (ip68-109-140-205.ph.ph.cox.net. [68.109.140.205])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367405edd7bsm9857018eec.6.2026.10.21.13.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 13:38:43 -0700 (PDT)
From: Giorgi Kobakhia <gkobakhi@asu.edu>
To: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Xiang Mei <xmei5@asu.edu>,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Giorgi Kobakhia <gkobakhi@asu.edu>,
	stable@vger.kernel.org
Subject: [PATCH] svcrdma: bound check rc_curpage in svc_rdma_build_read_segment
Date: Wed, 21 Oct 2026 13:38:17 -0700
Message-ID: <20261021203817.3898293-1-gkobakhi@asu.edu>
X-Mailer: git-send-email 2.43.0
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

The existing guard in the end of loop is not enough for bounding
rc_curpage, because it only checks if some part of the chunk goes beyond
the rq_maxpages.

    if (len && ((head->rc_curpage + 1) > rqstp->rq_maxpages))
	goto out_put;

If the chunk exactly fills up the pages, then len is 0, guard is skipped
and the next chunk makes head->rc_curpage go over rq_maxpages.

Commit 81381d1a90de ("svcrdma: Adjust the number of entries in
svc_rdma_recv_ctxt::rc_pages") made OOB accessible, since it
shrunk the rc_pages array size to rc_maxpages.

Commit d1bea0ce35b6 ("svcrdma: bound check rq_pages index in inline
path") added a loop-top "rc_curpage >= rq_maxpages" guard in nearby
function svc_rdma_copy_inline_range(). The same check would guard it in
svc_rdma_build_read_segment().

OOB write is triggered in svc_rdma_process_read_list():

 BUG: KASAN: slab-out-of-bounds in svc_rdma_process_read_list
        (svc_rdma_rw.c:1148 svc_rdma_rw.c:1197)
 Write of size 8

 Call Trace:
  svc_rdma_process_read_list (svc_rdma_rw.c:1148 svc_rdma_rw.c:1197)
  svc_rdma_recvfrom (net/sunrpc/xprtrdma/svc_rdma_recvfrom.c:1022)
  svc_recv (net/sunrpc/svc_xprt.c:870 net/sunrpc/svc_xprt.c:968)
  nfsd (fs/nfsd/nfssvc.c:919)

Add bound check for rc_curpage in the beginning of the loop.

Fixes: 81381d1a90de ("svcrdma: Adjust the number of entries in svc_rdma_recv_ctxt::rc_pages")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Tested-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Giorgi Kobakhia <gkobakhi@asu.edu>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 9aaaade99e6e..a98041139075 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -777,6 +777,9 @@ static int svc_rdma_build_read_segment(struct svc_rqst *rqstp,
 	ctxt->rw_nents = nr_bvec;
 
 	for (bvec_idx = 0; bvec_idx < ctxt->rw_nents; bvec_idx++) {
+		if (head->rc_curpage >= rqstp->rq_maxpages)
+			goto out_put;
+
 		seg_len = min_t(unsigned int, len,
 				PAGE_SIZE - head->rc_pageoff);
 
-- 
2.43.0

