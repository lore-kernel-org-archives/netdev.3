Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43387552956
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084245; cv=none; b=GnKt+y4hSWX8qkDuMXxn+IBkPJvB7Xu1xwqiR7tiahqPC2OMPwiONYrWgLHyAjuBXmUBGHuXITr9b7VovPAiCyCisSm2bKu/xkGsUNnvVoSsQr87M8wspDIr4kJf/gOsGXxtydlSvrR09TKfeEpxiiMedQB1FUtz3U4C7xNZnLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084245; c=relaxed/simple;
	bh=4SlchRATHbQIMfeWnGPHSC4zXqQ9oQRyDSLhp31lhMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpfvnZa1qGSvDsP4COt1v7lCUXO//AGSlYFrbHvZRI/jCJa73AqVeRYYAohWXBT1CDkNm+A9PyddQip+7FK6ZoYG62d9YPP7lmOzdJS1SjRj6AHzRc/7lHRfcTO3qNby6EtM2pRnEBC2qQbj0sfKCx+w+a9MJpaBO/sDKz8k+cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HobNQjy0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HobNQjy0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2E01F0089A;
	Tue, 22 Sep 2026 13:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790084243;
	bh=Pg18Pbgc69cV/gMwftuCBy3l3rv1TNxDzsc3uJalHFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HobNQjy0ovN9pu/OlHwLLFLYVz4krXttMJRS75AuUrHuQmdYFg5X1zi6n2FiLkfSX
	 lkF9iPH+ih2GG4NUwO6eTrqXOq3vRqFqqmNmd8YkpkxhnLr0ebJuElVXj2ZATb5U3S
	 1JdlZNud9snmXFhj0WwairRVttOasKOSWkmsQDpDchkVehB5ycnjRlhes+6cbG2I0O
	 yqphrj0tr5c1s6kPGeWTEd04GQGMb/Y/lKIIchK3U1XsnhDJ1zhURu+m2V8cRI/uqM
	 XwDPJRqeJ2GyV3gdeRDhFPuEfiJQXFfhtyX+NfG8rEUSpdfdVAwc4WO6oAzledQCRx
	 x5LYq/kBJCe6w==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org,
	Martin Belanger <martin.belanger@dell.com>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 2/2] tls: return a distinct error for control records from read_sock
Date: Tue, 22 Sep 2026 15:37:08 +0200
Message-ID: <20260922133708.84522-3-hare@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260922133708.84522-1-hare@kernel.org>
References: <20260922133708.84522-1-hare@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Belanger <martin.belanger@dell.com>

tls_sw_read_sock() leaves a non-data record on the receive list and
returns -EINVAL. The same function returns -EINVAL when an sk_psock is
attached, and an actor may return it for other reasons, so callers
cannot determine whether a control record is waiting.

Return -EPROTO instead. The record can then be read with recvmsg()
and a control buffer, which reports its type.

Signed-off-by: Martin Belanger <martin.belanger@dell.com>
Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 net/tls/tls_sw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index d1ad31986cf2..7ac606900ff8 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2044,7 +2044,7 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 
 	/* splice does not support reading control messages */
 	if (tlm->control != TLS_RECORD_TYPE_DATA) {
-		err = -EINVAL;
+		err = -EPROTO;
 		goto splice_requeue;
 	}
 
@@ -2132,7 +2132,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 
 		/* read_sock does not support reading control messages */
 		if (tlm->control != TLS_RECORD_TYPE_DATA) {
-			err = -EINVAL;
+			err = -EPROTO;
 			goto read_sock_requeue;
 		}
 
-- 
2.51.0

