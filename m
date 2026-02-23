Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF7A378D82
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 21:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883430; cv=none; b=nptHMcED7UceHNC9kYnd720Yu902nv5k3GXERu6Q6ncb9enx70ftgERkS3s5glLq22Jpt4VQISsyBNLcBpJydP8XXs3xQrw5ygFdjBHgpeQbmt80Za6F44lbJbEs/LJvsQyO5Ahbnw39888ALrYmOnc59wwVYSF4sPgxXps3+1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883430; c=relaxed/simple;
	bh=urs7LFEFzoIA8YPfdWzwjXPvYvVkNZEMfiFNbQSTi58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5pqq1Cbgivd8LjEH1vIlUJP9hGx8YYSP3mlObMgyAPm+p/lL4Jjuqz1ZalZiU31MCiK3WOhlhkYyDYh5aHLesv7I3qnHw8ax2UfUD+Gz4XEBcQL0AQCTR0Ij9oEcHXsknM6BOLX/tQtLLqWLsEIFeafiY9IUWNMqpFgYoZnGlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=TciR3zCO; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="TciR3zCO"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fKZKK1k6Rzlh1Wr;
	Mon, 23 Feb 2026 21:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1771883427; x=1774475428; bh=nnFa9
	8OY9ljH31aKjq4xyU/FDPBwt+RV3CAa4GqfTp4=; b=TciR3zCOOrCRvtqqenN9x
	aGqDunUrT0V2bvQnIuCIV8Ko94Ahn6YQTu+oP65tINdKPUQ8iWXxjsVwy6nNkuoq
	2mEjqfh0LCKAs6BImMQ7OK1hAhJgIo1tLAxMZU24msvHzuVQRXys9ScDgrlX0AxB
	ABJ/MUY+Q6uJ76++2IgMoq+jFRswFulHj12da6uy/veEepV/l8JIqqEhP9rWhpTA
	c/DrV8pDi6vLG02mciyejPvRDDIQmGc0XfFkLkOVSzqW6hALROquqN7MzA2tWDTd
	Yo9RqjV1x0xQ42VlFHikGrYkoQbXIFhgGGqk2eeVR//P3SFgjJoAacRMBdxINrCp
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id zKMjZq9ZOlrP; Mon, 23 Feb 2026 21:50:27 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fKZKG3Y55zlfddf;
	Mon, 23 Feb 2026 21:50:26 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Shantiprasad Shettar <shantiprasad.shettar@broadcom.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org
Subject: [PATCH 18/62] bnxt_en: Fix bnxt_dl_reload_up()
Date: Mon, 23 Feb 2026 13:49:06 -0800
Message-ID: <20260223214950.2153735-19-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
In-Reply-To: <20260223214950.2153735-1-bvanassche@acm.org>
References: <20260223214950.2153735-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

bnxt_dl_reload_down() calls rtnl_lock() and netdev_lock() if it returns
0. Hence, bnxt_dl_reload_up() should invoke the corresponding unlock
calls. This issue has been detected by the clang thread-sanitizer.
Compile-tested only.

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Shantiprasad Shettar <shantiprasad.shettar@broadcom.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org
Fixes: 004b5008016a ("eth: bnxt: remove most dependencies on RTNL")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/=
net/ethernet/broadcom/bnxt/bnxt_devlink.c
index 15de802bbac4..1e9a3454bb29 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -562,6 +562,8 @@ static int bnxt_dl_reload_up(struct devlink *dl, enum=
 devlink_reload_action acti
 		break;
 	}
 	default:
+		netdev_unlock(bp->dev);
+		rtnl_unlock();
 		return -EOPNOTSUPP;
 	}
=20
