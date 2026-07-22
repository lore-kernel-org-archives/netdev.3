Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BDC43B4B3
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 20:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784752942; cv=none; b=c48WbedhmdlJYCEU3Zm4NKUJCeqi1s5+ewDi6XoIhDGN1RYMJ4bfmH44C4kA3jR7wvKu70zb4qVBoUUY/b5xojuojD6V5tAyjHgEsCAlPPdysfRSdeQLueEJ9JBINrVHfAIaOe8NrKKCMv+Wn+WGnUmZx8yPaxFuw8vYuwoIQD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784752942; c=relaxed/simple;
	bh=UmyFBuNz5X5Hyy0U3LR+Mq37vswOtP3oWtdCOBjjgA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vmh+Kzo8Ejx417d3bYVK6dC0UhVRIRB0np39HbjzeZgSfLBJKAT0xPbDIgufuSlCN0QySDuFX7c6oaphTZFI0Utn61WTXKLBwCBJLr8APmV7M5y3hFcV5ZxyGg0uBjipZwBi9yIfyEMqp9GC2AOv6wGmoDsrIE5qIVAkDBp/8p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=sN6I+eK6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UqZqHXd1; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="sN6I+eK6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UqZqHXd1"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id B5C451D00100;
	Wed, 22 Jul 2026 16:42:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 22 Jul 2026 16:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1784752940; x=
	1784839340; bh=ufTrcvY/DK0DEwSsselNdijiTnLcHUJsYKTgG4UIkBE=; b=s
	N6I+eK67Z51jDXadrzjvZLbrnEVJCfdMW9uzmy1IE+kS+NrHR4mGrOU28m7l++Km
	1ZMK4GyGigspy0nTUNBe4WT6akiEOBksl8Amjbe5LgDCacdC+kqta8YefkeqsEgf
	1qScYRI8eQlm1aDlpaNXhno3CSUK2f3pqrvBimXQgVF21DtbCNgcVaPIvlDlz26C
	Sk0Cqwpi+uLDECu6BIesyM2bPYuB8mrbAyYfwK/qx5BFVhnDBAcdJvJNVotto2sT
	XQgbXAJE6mDclkyQ5oQEpvSiN+UpiQ1m6kddOkf2BHeDUJYvvNVkwsjTOoSdywDJ
	PgaeBSm9J9uuIairgRyYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784752940; x=1784839340; bh=u
	fTrcvY/DK0DEwSsselNdijiTnLcHUJsYKTgG4UIkBE=; b=UqZqHXd1kjor0R4pr
	M+dKc3zNokoQbytNn9Qcv+0xB+UKiJL+vt6aLZvhxsnvAi76N7ppqk81hPiI4PTR
	S0ZbTRTkfkJVtNE/u6V8X8weANyIpkRaz/H89uydZVXTZjuBGsPKq08FWPY/CEiz
	3eG7ZQUdvbnljkhh/M287SdjuNEfjFOCINdkY/VHlqN78BZ1puiH859gM0Ta+L61
	Zci95XvMTbndqbVWHMhWGLoIuMmy7++NSs4RH69dK+l+a9QM23iNgYIOczW1P6Qj
	ibatulrQ0MJTJmdB3DwJ/fTy/XpaVgsf2s3h+VyS3n3/D10mZdbmYQ8lsRZv6rhB
	UksOg==
X-ME-Sender: <xms:LCthasxCCh-NNxz-FOCBe96ipN_bZhB79fA5nuOBFDBhi3JlYMfbSw>
    <xme:LCthanKfngbBC_J7TO1W6iIwCCbhkzVfmCxM9F3a50TmezBzxT4J5i4-McLfn04U3
    zGfwy4sHs8HHc2Y4_4dd6vah857S5bvYIxYUIZfpFYWD593cKAic18>
X-ME-Received: <xmr:LCthamri9NA2VzvZBRcibvs4kbYykF9pAsK0cgyU6mQwFm64oKs4bqRGaw8Qh28n3LezBnZy8esXOXD1rK5Y2w>
X-ME-Proxy-Cause: dmFkZTEltE7bp6gOpiCvivsFphRTOnMYfitX1ZvrIbDk77FZXF6rJrd3FWs7u/maoftZZh
    pQdyy6xw7uHPAGdC/U8hRfGa6Uc/5/rPl36g1PbcNdetl9d+WOi724PhB2mP2O/AWYQ4up
    /xYcZuAcWNeFV8yGgfGvH40x8z7m8HcmmJYLGV5JNoVhbCNiMj3wAZizrPj4RijElFw4nu
    09p6q3r0y1OCFwrZYktTFUSY47Jjug9hoAt6UgcrPniOSokhv+lKp60eF6HHpMURqYL2ZS
    t0h7L9WAKSYjfJhoSK8iumgB2Mjqm7Xe+jZgW3XkvTBdTCJYIpilq/gBgnXjS3UV+RL0Ef
    7O2c+XkMTASFOZyeSWhIyj1EFvgbXJmcHi47P4aY1LZJPLkhbqKtwHq27SH7jNj9ZUAtrd
    7dsMbzj+YUuSOx+0R0uIh6S+h24n73SVLsoEtW34n7rs10u25Of3kKDxECSZrR4LNYQyDt
    YROTXdgnsCigRnpR2+n2omf6MD+U7umTDsZ+XaYAAE+Z8cOqf2A5sf8zpS64oLbNrq6NP0
    jJVFGFBPhkrkMsuXuvS+vo+4yHTNiIX/eO1Ecbfu/mI1c7326/3jxDUl2CN8Zb7UmRhU6D
    yYTH7PMTpQKgec3uWjgmDo7YQK6/IxldPsxyE03pPHK3MvLo5XnRZmjCT+Tg
X-ME-Proxy: <xmx:LCthamLNCCczSLDcjJXBeSvgVd6i3Avd9EFdHBblRzoLRlyOR_EvKA>
    <xmx:LCtharQ7sw4afmqx1X0dTVGNcKRoItJaiFzWUbTzdJzrZvviaXQ7kg>
    <xmx:LCthalt94G8l6L7gW_x2lmb47v1eQYb42Wmw3oYMvVAKuJd7Gvxwsw>
    <xmx:LCthasZpUiOVTwaWXH5I8enlNttxp5bALy4HrcP188vruEOhqbC58A>
    <xmx:LCtharqcoPS1ok79JCpQzMKuTBnH3uSoXCWpEYBQsCcJ-thJ4HgyD5U1>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 16:42:20 -0400 (EDT)
From: Juanlu Herrero <juanlu@fastmail.com>
To: David Wei <dw@davidwei.uk>,
	netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Juanlu Herrero <juanlu@fastmail.com>
Subject: [PATCH net-next v3 2/6] selftests: net: remove unused variable in process_recvzc()
Date: Wed, 22 Jul 2026 15:39:46 -0500
Message-ID: <20260722203950.58550-3-juanlu@fastmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260722203950.58550-1-juanlu@fastmail.com>
References: <20260722203950.58550-1-juanlu@fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the unused `sqe` variable in preparation for the multiqueue rss
selftest changes to process_recvzc() in the following commits.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
---
 tools/testing/selftests/drivers/net/hw/iou-zcrx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
index df6b622043438..c6dbd0ad53681 100644
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
@@ -269,7 +269,6 @@ static void process_recvzc(struct io_uring *ring, struct io_uring_cqe *cqe)
 	unsigned rq_mask = rq_ring.ring_entries - 1;
 	struct io_uring_zcrx_cqe *rcqe;
 	struct io_uring_zcrx_rqe *rqe;
-	struct io_uring_sqe *sqe;
 	uint64_t mask;
 	char *data;
 	ssize_t n;
-- 
2.53.0-Meta

