Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D50C472084;
	Tue,  1 Sep 2026 13:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268939; cv=pass; b=LqY26fBymOiyRUvLwfa7D2VX1ninOCbreWwrW9JGbob95EfQlQGcUJ/mShB/lVLieP7VOB07aSTqldOPIphnBrxF49l+5XerRWeWEMOibvg1ayvc9uRHSdN2srE3siIyXndz5mBxJTERO0ABDMX1KX9dk4FFpDGy9fefbH9tPYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268939; c=relaxed/simple;
	bh=I6+6D5NMypTbm/L4XqjdnDGV4qktEPqHN7NLR96bzNM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UfxBVJajeXNFregAtNl4Kij9wKYSE4dNjPEu868HByQgqxOCwbRvnDGiFvsHU8q5tcbxUkqCT2RJKu1Sj3GvIbq41bAu+DifxVZXf5o40EcN3tmz776R3JbaihGEuCDJS/qzcNi6KRLQ78rvqIXu6gkA86mnTlW9UNVYq7f+j+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=RuEimtTv; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="RuEimtTv"
Received: from mandelbrot.. (xdsl-83-150-90-33.nebulazone.fi [83.150.90.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmtilli)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hZ6383qPmz49QNp;
	Tue, 01 Sep 2026 16:22:12 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1788268932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PEUjQjjsFci1enYBM15zd0rVQmDzTx8erkfzrvkeXzI=;
	b=RuEimtTvH2oxN+JjDSCVkH/Tlvg7OReTX5147N9nNJEtapAmiFYHTkkA31yzm9INcm8pL9
	m1ZS6YHgHf8HcQRUhWQZpkt6rQMEPCw8Fn1SqldgAIs99e0Jlsn/ZhQdfjJnRit71kBbas
	F/yAUBCNZNbi2GTJHn1LB/mkAMyb/IFQuaNJ1w92ahj6YybFhUnkHMMW1+fmx1QSPhC4yy
	zedEJlDGGnQOPKUt1EjcjLfRcYZMNNCIXQSdsfkCqoE0udwKRYSOBmiXiVSj7xiMu5VozI
	rcx4pNcwm+aqvU4Ux5Z2k2FyLNQ3Neh39nQ6sDQEriiZ4Rezt3wVjglxBaYx5g==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1788268932;
	b=wNFe60L9TLBCl7gTDxp+mZRv7lxWcefjmVCEjwxRnltEwV+jByQJ14i7zFtv8IjLccrMkA
	j23OvDQfNzQsC1KDxU6y1DDszzZscg/myzcP5w38xax7T4xQxJSAFK1eow58VPhdRj7SVc
	MTmh5wdg7q1O4QPhDXPk8JAn9Fwn74BJikMNe7Dgi9VeVQ8zlfeHp9S3Bh4BWUFOPQkIrW
	dQRHZ4pLhu+PwFiSoQ4X3H6Dty1Ms8siijGTD+5YLO1neCKU/45u6bKXOECN9TyNkggAOe
	iqttiWE+pykslDZRajj6CsXg/X5Je1EgErR4t80sUrfjyUrnXFAkJMdQeEwXwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1788268932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PEUjQjjsFci1enYBM15zd0rVQmDzTx8erkfzrvkeXzI=;
	b=hZMGYfUykUXDwPZJxxkmDZ3v7MWapGf82YB5NH9/FLwdhMYABGYXiHnHeA7HCLXGhpg+o+
	y8IMcRrNWPXrYkDBn6fAQah4zqeVdf+Mh/vWQqhT1tSmKF5tbxFd3REJWhMUaHYBJNTJnb
	2ewLk53b/eMv2fmIa6SoRlzwEYxEXHT1C17KB1Le3Ynhli9p3k07nwj99xGI+uD/jvpCD7
	OMq9sHhW6TSbcfQJ5bnONfQq+4eQI4h8YbyowXUYxXXQGwdKnL7y+dnFyCqQGyqwvThbpv
	swSFeTOiQb1rcXzzD2LAu1gsK9/bcIi18v7QRaCTnGikaHm6HfFlw79ikm6zSA==
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
Subject: [PATCH v6 13/15] net: qrtr: limit endpoint range to 16 bits on 32-bit machines
Date: Tue,  1 Sep 2026 16:19:32 +0300
Message-Id: <20260901131934.225991-14-juha-matti.tilli@iki.fi>
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

On 64-bit machines, use the full range for endpoint ids, but on 32-bit
machines, use only 16 bits. This gives plenty of endpoints, 65534 to
be specific, apart from the invalid zero value and the local endpoint.

This should fix any issues where a long-running system with lots of
allocations might allocate an endpoint id bigger than 65535 on a 32-bit
system. The node id, the secondary part, is already combined with port
id into a value that is potentially 32 bits in existing old code.

NOTE: please don't merge yet. This commit will have to be either
squashed or removed.

Signed-off-by: Juha-Matti Tilli <juha-matti.tilli@iki.fi>
---
 net/qrtr/af_qrtr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index b27c5a659795d..f1601c0701fdb 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -22,7 +22,11 @@
 #define QRTR_MAX_EPH_SOCKET 0x7fff
 #define QRTR_EPH_PORT_RANGE \
 		XA_LIMIT(QRTR_MIN_EPH_SOCKET, QRTR_MAX_EPH_SOCKET)
+#if BITS_PER_LONG >= 64
 #define QRTR_ENDPOINT_RANGE XA_LIMIT(qrtr_local_nid + 1, INT_MAX)
+#else
+#define QRTR_ENDPOINT_RANGE XA_LIMIT(qrtr_local_nid + 1, UINT16_MAX)
+#endif
 
 #define QRTR_PORT_CTRL_LEGACY 0xffff
 
-- 
2.34.1

