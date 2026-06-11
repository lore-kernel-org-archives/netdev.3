Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466553BD63C;
	Thu, 11 Jun 2026 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198518; cv=none; b=Bs0Ja8TRq1vSkMSOOyrdRjKK/8/qIloko9Ygx8paUYOR28IxL9DPffxV+yq9mJEPzmL2dj3LvsRnoS9wbXWAf+5e6euVM3cNAo/GMb+mvet7FTxbWa1QKzX/fJfQciByHzvkPmXeecSAHMvKFU96G/6Rh706IACF+iHpFYo3Q1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198518; c=relaxed/simple;
	bh=oyV1ai1PBM4DTWyjLYyA0QqbBh5MfSH/K+Y7AfR8B5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D6rGtVV3xUqU5uQmcMK9qcZJpvOGAaE9+1SGFX/45kSC4dlSUsuo1n1cwbQHvV0ugic9jkb2wUh8BI5VxKJOKtFCVkSAN3ddBd9XZ79duIKx/zEFj13b3bpmCBcQcO0/1BqKZOtUFREOs/55qTFAP4Kt97CqRjzxAnAp9q0NJrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uk/9JU+m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uk/9JU+m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238A31F00893;
	Thu, 11 Jun 2026 17:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781198513;
	bh=yMIRtVAbaSjolqJjcTWBcOrVYaBhk0KzhTLifQtt17w=;
	h=From:To:Cc:Subject:Date;
	b=Uk/9JU+mWXnTO3w4SnJCs2U3Tp2NoB4/vMjnvG+PYaEnCtnedp18/Eo4SrNNyNPxM
	 mFvqs9bHmjKh5QJVKDAn0dRMaCU83O2Rgf1hHGU0MFvXtuEJdDdB6ATy7J6CnzdKNR
	 IUzX6aGkT7A6VH++j0drGmy/cJOYO7ibHjVWj8yELWVAC/i8wr9Pkax2Izu1HdkY7D
	 B/4AZsxwWv9EQ6QgfZie01awVaS2nqzzyS3AHQVXio58O9ohGqGsPo64yyXmhbGCSV
	 cVmbnhL4BfpnQZbetq6mIm2oNliPbKXRNiq8lIYFohhAFoOUKpJTpkt7YcRiHFEjzE
	 JUb2/FCxELLKw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Joe Damato <joe@dama.to>,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v2] docs: networking: add guidance on what to push via extack
Date: Thu, 11 Jun 2026 10:21:49 -0700
Message-ID: <20260611172149.1877704-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Every now and then someone tries to duplicated extack
messages to dmesg. Document our guidance against this.
Also indicate that system level faults should continue
to go to system logs. The high level thinking is to try
to distinguish between what's important to the user vs
system admin.

Reviewed-by: Joe Damato <joe@dama.to>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2: some nit picks

CC: corbet@lwn.net
CC: skhan@linuxfoundation.org
CC: linux-doc@vger.kernel.org
---
 Documentation/networking/driver.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/networking/driver.rst b/Documentation/networking/driver.rst
index 195a916dc0de..920c0ec98759 100644
--- a/Documentation/networking/driver.rst
+++ b/Documentation/networking/driver.rst
@@ -128,3 +128,16 @@ to be freed up.
 If you return NETDEV_TX_BUSY from the ndo_start_xmit method, you
 must not keep any reference to that SKB and you must not attempt
 to free it up.
+
+Error message reporting
+=======================
+
+A number of driver configuration interfaces pass a Netlink extended ACK
+(``extack``) object to the driver (either directly as an argument or
+as a member of a parameter struct). The drivers should try to report
+most errors via the ``extack`` object. System level exceptions,
+indicating that system or device is misbehaving or is in bad state,
+should continue to be reported to system logs.
+
+Messages should be passed **either** via ``extack`` **or** to system logs.
+Drivers should not try to report the same information to both.
-- 
2.54.0

