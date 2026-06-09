Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D4D331EDB;
	Tue,  9 Jun 2026 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032162; cv=none; b=F1WPGqS/TwP5bhj9aybSZMD85Z6ruLwVQVmApXVZ8pqhhfkPOnQCS9O2bh6qTuR2QujggXQ2bSy3szCK97LBqP6bofUeLUUkWuWDjnsC/ZDjkkyH5eqqAbuKV6lXl6RpEPnWHjuMLeqTW4wG3QIFWTHQJwOm4ZCl0OGi5xnrDBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032162; c=relaxed/simple;
	bh=HNXGKPXdxYo9bKGs0Naoeipeo0HmxCIeMCO2N3AxG24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=njSslvm50UV3gx4ptLJ9oYoqdH/2nqY0751xYoKl/Tfn5UgMZPNu9wFCCqiWT+UiGVn3yfTcwAvs3EQpoiou/YSHVUakgULOQ0Cefi3LSUQS+t6gHY9ATRCrotMha2aTXaK6Js3GFfHCf4MJTXCQUHncLGB8KrxuTKPRSmNxPos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaPYyGjb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaPYyGjb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0C21F00893;
	Tue,  9 Jun 2026 19:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032161;
	bh=/nHqzI9mAhWk8DRTjhxaMhskoSFoxZYcm0S0iB2COgA=;
	h=From:To:Cc:Subject:Date;
	b=PaPYyGjbS0Awain3MifVv2QIZGq/EolM1BLnBpS01ICEum2XMAm37n7BvWWPN6+4R
	 f8hqR4LjDCAdcAQ6T1K3BAAzF9TTgz5Ij3p7H5XwT+y+3tG7Q/sZZPOUQQLcitnO+N
	 ZMjBdu8PsthdPOxY/09k9Ljb6IqWfhZe4kLq0ErioFtIyUozEea1f0CV0W7Hozn/F+
	 sfnpqnAA1rx8mCIEzYZZnAzvbFSF02spZj5wDyJFek/wRK5eeaAZ8m6oFJOETSMTfU
	 2r+jx5Dvk5kvU6S1jNQnyiDSXUEmXnCjoOAi4Rzz/gdpYT6JqtAcnjIc7s33lNEskc
	 NemlLhHLXVoMA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next] docs: networking: add guidance on what to push via extack
Date: Tue,  9 Jun 2026 12:09:19 -0700
Message-ID: <20260609190919.1139517-1-kuba@kernel.org>
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: corbet@lwn.net
CC: skhan@linuxfoundation.org
CC: linux-doc@vger.kernel.org
---
 Documentation/networking/driver.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/networking/driver.rst b/Documentation/networking/driver.rst
index 195a916dc0de..abd366dd5e43 100644
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
+Number of driver configuration interfaces pass a Netlink extended ACK
+(``extack``) object to the driver (either directly as an argument or
+as a member of a parameter struct). The drivers should try to report
+most errors via the ``extack`` object. System level exceptions,
+indicating that system or device is misbehaving or is in bad state
+should continue to be reported to system logs.
+
+Messages should be passed **either** via ``extack`` **or** to system logs.
+Drivers should not try to report the same information to both.
-- 
2.54.0

