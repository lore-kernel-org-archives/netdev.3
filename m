Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01260390C95;
	Tue,  1 Sep 2026 13:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268845; cv=pass; b=VkQDxpDdyww6GPjVT5h8c7OmSlsKtSZ2e/rZ0qCavjOiIOMEpPpIaRdv3zfUae3P8geEh1Y2HZ9CYrNAitm48ln9hUXDD0Ss/WDco192KqHs5nMZm3RiX3ewRv9ZAFY0c+UsIwDNrM3n1brans13eJPsoZjPcxz1IH1Pt77S3JE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268845; c=relaxed/simple;
	bh=MjFIhswWHGmA81saWxNm3PzHlKyCMCf2Imvg3vl+RZo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p3hPuOvR1tOh9keVukemiwmLsdB31no5TpDm2+ypiiagdf2z8vpVbKci75PNx4rppGV1a5mbj5553Bjw0l+1WfH2C2dUTxefR80KXFj9HV2k4BQ675asBAv7wEF0zo59zl+1+srewvQdOxmAnyVxpoO+eIRDWzuHIuH1Ef0T/Rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=dZHnT9DG; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="dZHnT9DG"
Received: from mandelbrot.. (xdsl-83-150-90-33.nebulazone.fi [83.150.90.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmtilli)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hZ61H62tNz49Q7P;
	Tue, 01 Sep 2026 16:20:35 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1788268835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JB0TMAWB5v8+c1siilNb9KvoFf3O00+TEZzQXqcio9I=;
	b=dZHnT9DGwHZX4YbFnNpPex5kbMbfwJKb6gXTlttSfLhUjR5g5qJilqf+TobasHoTXcpw4A
	bUFSQG6ZSL8rixgIibJmiyZnMx0Qw+bnq8Tsq6/4DGfuBBhk5LAT0pU0/y9mCbGjUcUPut
	YbqPdPoOIbYv18tj9KRWtR5gFWXxrhEqc8pAetO8J3cO+Y10KVqPytQOc8kM7rBO5oM39O
	8dhkKQJ9xlxzAJr+uVn1v8Bxm3EVPfOiaAmDX2zvyGBsuH5b+NdeS8cY7zP2QepLZUipXO
	ba2Xb4P834RB+0r5qAMcvOtB5EbtOcj6MRnkfMbFcJmNtU5KpT7AFU3FPfn5dw==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1788268835;
	b=iFs1HNvo3eIwJAel/L8Xcm209XGJhTtIaj2vAYVVvfDh/Nz0WlOI6wquejrFPsdeQcAMEJ
	KwlqtE4oH5kfmRzy9Bue6qJJFOE7dz2UwoZOmZec+L1EANE1Zc63ixHFGUvGg8AQbbLPo4
	EGvD0J9qccqKZk90qZtxWidKCLpeOh3jzTBWI7p1J07fk/GZCMR2zhoi6eF/9wg2BhXlPM
	458KMc5Wul/hW/FVD+08duEiBwD/EV+9f9RBCTlDqzCIsCP6zsfwqX2XiV/SKfobrtmwmK
	qOmr7pmxAAtvoDJwdpNMwlxwK6J3jWKK4ZVnjmVSvVPrtHrh8RdoZQdC9/N8sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1788268835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JB0TMAWB5v8+c1siilNb9KvoFf3O00+TEZzQXqcio9I=;
	b=ixUsWyzw9obhPB99i0fVNSY2JQN23dYRIcJ9U9LLnZkB++7CtLpm8Lu52mSsdCwCLBo0sd
	MdVR/PwTircpCZstQJ9JM5RbT+MRyEhSRho5+Tr0NUYfGj25+7UfoROqpMt0bXOYg6ByA/
	bS0tlA3+WIyXdw7rINdJtFGUrQJEsEbnZKAmICOKKpuX6UsqxIfnURms/gg/qTA004rMWI
	3oO+dRaepe4Ei4rwaUpfR1EYm7KBNNKcs0GCsLiWN+1uG35VP4RzdD+3Z+Mxz3uQZtC0x7
	AY5vJsMnDT6rpvJwHXIMRQJ7yv+vrhVKmihIV3lrs9IUDohfL1/KQHwsYfNiXA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=jmtilli smtp.mailfrom=juha-matti.tilli@iki.fi
From: Juha-Matti Tilli <juha-matti.tilli@iki.fi>
To: linux-arm-msm@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Andy Gross <agross@kernel.org>,
	Mihai Moldovan <ionic@ionic.de>,
	Denis Kenzior <denkenz@gmail.com>,
	Juha-Matti Tilli <juha-matti.tilli@iki.fi>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v6 01/15] net: qrtr: ns: validate msglen before ctrl_pkt use
Date: Tue,  1 Sep 2026 16:19:20 +0300
Message-Id: <20260901131934.225991-2-juha-matti.tilli@iki.fi>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260901131934.225991-1-juha-matti.tilli@iki.fi>
References: <20260901131934.225991-1-juha-matti.tilli@iki.fi>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Denis Kenzior <denkenz@gmail.com>

The qrtr_ctrl_pkt structure is currently accessed without checking
if the received payload is large enough to hold the structure's fields.
Add a check to ensure the payload length is sufficient.

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
Reviewed-by: Marcel Holtmann <marcel@holtmann.org>
Reviewed-by: Andy Gross <agross@kernel.org>
Signed-off-by: Mihai Moldovan <ionic@ionic.de>
Fixes: 0c2204a4ad71 ("net: qrtr: Migrate nameservice to kernel from userspace")
Signed-off-by: Juha-Matti Tilli <juha-matti.tilli@iki.fi>
---
 net/qrtr/ns.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index e5b2adb161d92..d544e4998c5d5 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -668,6 +668,9 @@ static void qrtr_ns_worker(struct work_struct *work)
 			break;
 		}
 
+		if ((size_t)msglen < sizeof(*pkt))
+			break;
+
 		pkt = recv_buf;
 		cmd = le32_to_cpu(pkt->cmd);
 		if (cmd < ARRAY_SIZE(qrtr_ctrl_pkt_strings) &&
-- 
2.34.1

