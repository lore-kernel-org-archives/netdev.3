Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.59.229
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211420;
	b=n6HzAHESblVW1ZNJMijveuRresJbI8zPKlq4qnSAghkCbiOeNQJJ6frLZqIVG+scxyqh
	 /NCjdMx0KD3yNqPveOuF2Ddr4m4iI3nwZRDFrpL/pQTt2MnqHOR4/SSM3UQarpD2p3D8w
	 ppiKhBAO+TCdOsnzj8vRj1epxF47cWBz+Dra8ENIxCMjlu1MAUChRBucJPgbkLCBCKTIj
	 vqzvIjkjYX4cG5vvhu04mfRaIO8XT9MZMjBe/j++krQlTi3glz1cW8/JXBxZzYmZvZ4Yv
	 LHpj6JXhz98mJafEx8L0KUeGX/5czEcYaHGOKdRcGNzZqyAgB3GI4VGAVTWksbWG0hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211420;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=riezwqPrJE1vkjepQ5ZLKTc1XEAXtVQQ57dUWUKKQnA=;
	b=leHlDOLEYI968VdVY88oOyMJ1LEKgX2cC8xQdjptnNWByWbppVZ8kn87UjEQPLCsna9n
	 A5Q5PU1tGXQkxziQU1DkSGvYuY4OZo/fTpaeL2qGkRfrH7TyDFtODCL0yrRM4d8TbiqLn
	 Sn3YF1LmD3crbWr5rHMchrwH+Yc9bQP8pyd9g7BSWdMTQeupIWyoyuSukAwWA9bgN+6FL
	 1/RRziMseFsVBtLo1haRRZcZIq9uqkgsSEI0FU4vYF4nOYE6BqLCRFiTEXWAq9iIv2y4W
	 Z4pKYXAOisAeqZjpwvC6lCsF15RkEdoQ7eG5/vwFaeQJGVU2PVcFhwwO04Vo4ZfJtCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1wt.eu;
	spf=pass smtp.mailfrom=1wt.eu;
	dkim=pass header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=ILQEXiap;
	arc=none smtp.remote-ip=51.159.59.229
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24F2606EE94;
	Mon,  9 Nov 2026 08:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C24F2606EE94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=ILQEXiap
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1794211414; bh=riezwqPrJE1vkjepQ5ZLKTc1XEAXtVQQ57dUWUKKQnA=;
	h=From:Message-ID:From;
	b=ILQEXiapRQcdJ3azEHy1K2aOFK8gl7K1/7E5iVEdoIGfpYl3DXy41Ab0JEC1Q84iW
	 NAdc40yMCm/kwWIrNdrTXYjMijyZ7ffyfPFPkujcwEVhg7SYOZsJtoQLcWbU5ymtd1
	 eqHyzfOWmEd2v58H6/FVC4kjkDfWhCUCGLhVkGrM=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 7861DC0963;
	Mon, 09 Nov 2026 09:03:34 +0100 (CET)
From: Willy Tarreau <w@1wt.eu>
To: Jonathan Corbet <corbet@lwn.net>
Cc: skhan@linuxfoundation.org, Randy Dunlap <rdunlap@infradead.org>,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        gregkh@linuxfoundation.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH 09/14] docs: security-bugs: reports left unanswered for 7 days will be dropped
Date: Mon,  9 Nov 2026 09:02:35 +0100
Message-ID: <20261109080240.29444-10-w@1wt.eu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261109080240.29444-1-w@1wt.eu>
References: <20261109080240.29444-1-w@1wt.eu>
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

Between 5 and 10% of the questions or requests sent by the security
team or maintainers to reporters never receive any response. The doc
only said that such reports "may be abandoned", without any indication
of time, and team members keep collection of unresponded threads in
their boxes just due to this.

Let's say that reports for which requests remain unanswered for 7 days
will most likely be dropped. This matches the maximum embargo duration,
which is how long the security team considers it reasonable to keep an
issue private. Also remind that concurrent reports may cause the same
bug to be addressed by someone else who will then receive the credit
in this case.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 Documentation/process/security-bugs.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/process/security-bugs.rst b/Documentation/process/security-bugs.rst
index 11c385630855e..f19c712bc8e7b 100644
--- a/Documentation/process/security-bugs.rst
+++ b/Documentation/process/security-bugs.rst
@@ -383,6 +383,14 @@ run additional tests.  Reports where the reporter does not respond promptly
 or cannot effectively discuss their findings may be abandoned if the
 communication does not quickly improve.
 
+In practice, a report for which questions or requests from the security team
+or the maintainers remain unanswered for 7 days will most likely be dropped.
+This matches the maximum embargo duration described below, which is how long
+the security team considers it reasonable to keep an issue private.  Given the
+number of reports handled in parallel, the same bug may also end up being fixed
+later after being reported by someone else, in which case credit can no longer
+be guaranteed.
+
 Messages sometimes get lost, especially those containing attachments or HTML.
 Since the report is private, you have no other way to know whether it was
 delivered than to ask. However, some subsystems have a long report queue, some
-- 
2.52.0

