Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A4A3368B0
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 21:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772574829; cv=none; b=i/JpL1Fg0SZPASYhJan9KKE69Nv/kMUoknZ5ohgdg6tlgbkOW+HxvLm0+BmN3cwbzi3PzNTMNq8YH4i10g/MdC/5C+ZAygMjbs5RRz620hip1pQd6px7X/cAoxkPkmpOA/wH6/Ay7c8Y08+uj/rVOejo41NWAVdFR5usSGsQe7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772574829; c=relaxed/simple;
	bh=FKUXZ2rjCJUDaX/wfFuvdMZ/mD+Rc4gJVmhyDRnIPw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fYO/gLnCdblCDwzkmKYmEDR86cshnBnfDXTCL/RTvZQ2cl4Ke4MU2dF4KvYvWvnBJFC2tYoPZbcQ3lBiTW3vdH8Aw9TTT0Y4wBQHTzDVI27MSNdmYoLh29cCt9upfO4LMSX3k4Xym+8D5iLOpREjrwi1m60y+SjHdIeI/MY5K0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKc2sOhY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKc2sOhY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDC8C2BC87;
	Tue,  3 Mar 2026 21:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772574829;
	bh=FKUXZ2rjCJUDaX/wfFuvdMZ/mD+Rc4gJVmhyDRnIPw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cKc2sOhY/Juuign2oMcqS1gaFDs2drbi03MipajnE/enBRPVjrASsgi6kLKPq36x3
	 jQ6Bz+a/9LyiLRcK9Fzj/A8EbXfd6au1a/+CBfc8Y9BIVdqPhsCqGoTYB+ADOtdxmG
	 zAv0itr0lwcqZR5ld0/Zm8LIToI0GBlnUJs31mA6UsGZzuPNk43yqNX1gY4ZhQyJAG
	 Ao/BwqzTUo3FVGLnR75Of5GIdOU7DkKwAC29u+y7e/0Ulaf1UhCOWiPx3X9Br1cQQK
	 2iwT0v65IdZ6IA6G1vN9Yo5TdkXvf7K7+ro821pr8WVf/W5I1A1xJaNQBjFZp/l6Pz
	 Zju5REPoF4oKw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Thomas Falcon <thomas.falcon@intel.com>,
	haren@linux.ibm.com,
	nnac123@linux.ibm.com,
	tlfalcon@linux.ibm.com
Subject: [PATCH net 11/11] MAINTAINERS: remove Thomas Falcon from IBM ibmvnic
Date: Tue,  3 Mar 2026 13:53:11 -0800
Message-ID: <20260303215339.2333548-12-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303215339.2333548-1-kuba@kernel.org>
References: <20260303215339.2333548-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We have not seen emails or tags from Thomas's IBM address
(tlfalcon@linux.ibm.com) in over 5 years. Looks like Thomas
is active in perf tooling at Intel (thomas.falcon@intel.com).

Subsystem IBM Power SRIOV Virtual NIC Device Driver
  Changes 49 / 134 (36%)
  Last activity: 2025-08-26
  Haren Myneni <haren@linux.ibm.com>:
    Tags 3c14917953a5 2025-08-26 00:00:00 2
  Rick Lindsley <ricklind@linux.ibm.com>:
  Nick Child <nnac123@linux.ibm.com>:
    Author d93a6caab5d7 2025-03-25 00:00:00 14
    Tags d93a6caab5d7 2025-03-25 00:00:00 16
  Thomas Falcon <tlfalcon@linux.ibm.com>:
  Top reviewers:
    [22]: drt@linux.ibm.com
    [13]: horms@kernel.org
    [9]: ricklind@linux.vnet.ibm.com
    [3]: davemarq@linux.ibm.com
  INACTIVE MAINTAINER Thomas Falcon <tlfalcon@linux.ibm.com>

Move Thomas to CREDITS as the initial author of ibmvnic.

Acked-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Cc: haren@linux.ibm.com
Cc: nnac123@linux.ibm.com
Cc: tlfalcon@linux.ibm.com
Cc: thomas.falcon@intel.com
---
 MAINTAINERS | 1 -
 CREDITS     | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f208f877746..a276b6b5aeb1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12212,7 +12212,6 @@ IBM Power SRIOV Virtual NIC Device Driver
 M:	Haren Myneni <haren@linux.ibm.com>
 M:	Rick Lindsley <ricklind@linux.ibm.com>
 R:	Nick Child <nnac123@linux.ibm.com>
-R:	Thomas Falcon <tlfalcon@linux.ibm.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/ibm/ibmvnic.*
diff --git a/CREDITS b/CREDITS
index 339712b62e99..77f10f651c87 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1242,6 +1242,10 @@ N: Veaceslav Falico
 E: vfalico@gmail.com
 D: Co-maintainer and co-author of the network bonding driver.
 
+N: Thomas Falcon
+E: tlfalcon@linux.ibm.com
+D: Initial author of the IBM ibmvnic network driver
+
 N: János Farkas
 E: chexum@shadow.banki.hu
 D: romfs, various (mostly networking) fixes
-- 
2.53.0

