Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703112;
	b=Ars2FBLjVBZGvShQD/Mbov8SGl65ysFqdwqwoPzoLDU7V1NVy23SIeKML8juitaWiwfY
	 XXdwsmw4n26rwURGUa1iOwALoDkHJlAb1UCYf0I79LQSGeBfU1zpse2aGQtZWWk/0irBf
	 27qWQppx3au7hzbprMvLCUBHm030BOZ3Qc+LdgSycSwhsQ8tN51gxB+mlHovH9C5+KvT1
	 DsZ0ZJK85+cvYr3Mn54Ra6zgWJwvZUYQk6/crpg7+3OJyLwxmDqp2Yry8bLwSrTHAc8xX
	 c8KnUGOwLHhCydi1BbcRc5ieNpvEZu73bZjRExtmxsY+wDEsckZxqGCEvk+Ebaeem8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703112;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yve30OsJK2xindd1FBXy9Xv7cVmfGR9bOzhjL1cRnLI=;
	b=DDMzK1UBPCT9Pt6vPRsUP0/UMtKkKrLE1qcqv2a9Vae0OKRBYm/c4KJVPyMwRLuAijv8
	 QTfz+EOJeJa0BVai3YKN2/EFqZd2i+Hgb/wrp+1ly+163m/qa5zUmENUzVf4UBcCziKBr
	 3/X5F78C1JlM6JtKVK58Aee/6Bv8c+9JCtkRRqQtMvBZm94FJY9MCV0luUu9YZkxIgEkl
	 mnO61SB1wzmthiHcI7a5VnL32sgx4HrhsEDA3mssxflfzOr4CraoqP+8NzaU/rCSwOelU
	 s8smsEfqsQsZOGch9orCVDq5ygOyk3glEans9EAElJ0muL1BQpRQlFKwBnx90R+hiNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=dXIUWkvu;
	arc=none smtp.remote-ip=115.124.28.171
Received: from out28-171.mail.aliyun.com (out28-171.mail.aliyun.com [115.124.28.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5614A606A82E
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 10:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5614A606A82E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=dXIUWkvu
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793703108; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=yve30OsJK2xindd1FBXy9Xv7cVmfGR9bOzhjL1cRnLI=;
	b=dXIUWkvu9CjDJA8H5kqUlRVnSlPu5vwoHlaZBK/bpFvIeL3LwtL760WlPecLxDHGiqGALsao/PTeLZJwxsDM1H/RLHzEF/6xUOdQhN4heHm5gmnx9CcmG0/JO0I/3ITYENj3eBFULGtIYMje/a7SbgqztPc/t8k7kSyIBUvLelI=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.136758|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00690489-0.000466603-0.992629;FP=17182226299554687800|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037026024;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.jvivrQZ_1793703106;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jvivrQZ_1793703106 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 03 Nov 2026 18:51:47 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: netdev-bot+sashiko@kernel.org
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	netdev@vger.kernel.org,
	Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: Re: [PATCH] net: wwan: iosm: fix potential skb leak in MUX DL decode
Date: Tue,  3 Nov 2026 18:51:46 +0800
Message-ID: <20261103105146.34477-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <179369405864.488856.5590338519083448566@kernel.org>
References: <179369405864.488856.5590338519083448566@kernel.org>
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

Hi,

Agreed on the main finding - skb->data cannot be NULL there. Same
conclusion as in the thread with Loic:

https://lore.kernel.org/netdev/20261102105307.11263-1-fangxy@xiaopeng.com/

I'll drop this version and send a cleanup that removes the
unreachable check instead, without a Fixes: tag so stable does not
pick it up as a leak fix.

The pre-existing findings on the missing skb->len checks and the
unchecked next_cmd_index walk in ipc_mux_dl_acb_decode() are being
addressed in a series I'm preparing.

pw-bot: cr
