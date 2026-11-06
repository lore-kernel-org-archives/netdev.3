Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.206.16.166
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964417;
	b=WpB83KGgYCn/0CQlctrvcqAGLc9OFUPx7JZ9XEWmEUEvsQ1qsR0SMqAdRfV6h3fB/8S9
	 6IDBcNfCh1jlPV7EKQQTC55v6laLWYRKVFMegzF4iXEbj/pHhUJVVxzT1ZW7bUbAIpDaV
	 Cg4yp/Npo3t11P0pjBq/8q29aUa+9eIRl0d93ws/XIWUGvFxFDfvXuKDMeIKWowyaaEMs
	 OzFqarHKo6tCwkud+/cVfjuuA/7TVO3Qr3AxbUYQsRN/m/IQtGH8r+WUSmGA3w4G1ql6N
	 S+hAS+BPV7BSUXcY3l5Pw+ak1iWtoRBxPLwmnZsIGqVIjDR/BoA84JRrMFVfmkA84iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964417;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=xr1ZydXFc2EfREs2tnP0GSJUkk+7dmWoZc5lCVrfVjg=;
	b=aMdJhv60TePWGBr0QyigbyLBUxNDJgF2MJZRRyIEznv1HkXaqis2Pxj/pbaaWp21pb7W
	 AUX8cWHtewKM29mHZgw6VYqe9V7XuBrn13M5yk6HRdFT7lEJ0v4pKYiW/V1GJKj22ysN3
	 KOR5CYAdgEkRDIAZgUiGk7BYZmlXntotZcIxYVXdFyH8IhLOWX1YVYTSQ+ydYOX/C3yVj
	 D+jlJEf2AztQgTpyVvk4jmjGy5q/R/blNqjceyKopUSnMnpPL+GXbN+AiKmWnrr2jjKx2
	 jeQ8so2r+mZnq/R5YawwRjcnegmlKCmivRdAPJjiDAePm87AUrUSBA3Zf+EJcmUqOWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mucse.com;
	spf=pass smtp.mailfrom=mucse.com;
	arc=none smtp.remote-ip=54.206.16.166
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4596D606A330;
	Fri,  6 Nov 2026 11:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4596D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz10t1793964266t3cd986d1
X-QQ-Originating-IP: eM1C2NUQNTKmaU9lL2ivyCFoVMnYSK2AhgTAEOBL5+A=
Received: from nic-Precision-5820-Tower.tail7b ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 06 Nov 2026 19:24:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10207227521404303170
EX-QQ-RecipientCnt: 10
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	dong100@mucse.com,
	yaojun@mucse.com
Subject: [PATCH net-next 0/5] net: rnpgbe: Add basic management and statistics
Date: Fri,  6 Nov 2026 19:24:20 +0800
Message-ID: <FB722C2F25FE9005+20261106112420.43050-1-dong100@mucse.com>
X-Mailer: git-send-email 2.50.1
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
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: Ni68Q0J6fxe2R6MWvByUeCYIGEpG8D5FzADryyeLWV4z2DC81Ojj1cw8
	2f/HuiDGd7ODYzJoidxL6I1SFrlmfkxBVCRVKnBZHTlbZBDAjyP1W7tEJXMm38yO6F+uaqa
	5PYajJlDm+xRdms1ICPg64VZWem+6knHn48jG8i9KK98o6djDLiPqpJJedtcEcQEO9yAaA6
	WS+yNNoVbRxCu05wk/2NsErTHUcWYsU3KxjPgUCCFae6YtKmmN08GdwleBbtMFLwAsepAGP
	P4yiH6UYTU0BTcQasjB6rLRqhKcJpGaRKM1LZcBJPriwciPsr9P/MJfOkDLS5ykPQRW66vS
	SwuB1C3TVkH0iTszjef8U60PSQPP37nG9U703IfYp06n0RroWqNM/fk2QJG0UAdPN9v5DU5
	1wy7jMlfzborTAg+jQIaLnLr/QTfMRUV1K8s3lYLZ3Q6Oz9FhVhP6fvcbQBdRckolSRZnqG
	+QhJML7fuwEKzas+cz2v+rK5MTb6wynR5/9fSIYeoZmw/gbxYb0O/zrh1NFdQyhDMtSot/A
	biI7Qk0DAacri5B5f9N8cuLI7R3TIz/NKtg33jxx1ZhOvhCpvNOqGazjOI59GxRpiH5YN5U
	EdpSsc4tj1CEf3zVt3mGkT2tMew7qHk/k71kc+Lepj0cT0FZtb5fR7yoVyoDGQTB1ELyZJl
	gqIrBnDQZoMyQd2kJUCZODTdIIBBAd/RJv3wCMMidrko5RsZ6u4MLyCwlodZT1pyL/77Ch4
	GabFB45tTrUg3/giWG4cG67kY4/+g0D/N+nG/pxDsrB2QA4nNirmztaUPT3PdkRojPAT7J2
	1GEy8BZqCxxup6e29pJ6a2TADmWwJuYleOWurwTcobRaXFtCsPwjC9SweG1qAR7zwR3GvRY
	5xbp2dZegmqQOjOMh1h+z2UcagkuvlUbyUQTviYR4o56GzdvMVrjuq8KZbf6rwMqKpnJTRj
	OeBvnB0zg/x4BH0QfQs8Z9rxyRrowaV87n9NT3ZSt99o8h8bh7aiiEE5bJaIpAI3/gXY/C+
	NDj3h3wvt4Op6ULyyaJTulQv8CiOLh8/2VSSM+CYH3WdwLaK/q
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

This patch series adds basic management and statistics support to the
RNPGBE driver.

The series introduces:
- Basic ethtool driver and link information
- Link settings reporting for copper, fibre and backplane ports
- Copper autonegotiation, speed/duplex and MDI/MDI-X configuration
- Primary MAC address changes
- Hardware and per-queue statistics

These changes allow users to inspect and configure the adapter and
monitor interface and queue statistics.

Dong Yibo (5):
  net: rnpgbe: Add basic ethtool support
  net: rnpgbe: Report link settings through ethtool
  net: rnpgbe: Support copper link configuration
  net: rnpgbe: Allow changing the primary MAC address
  net: rnpgbe: Add hardware and queue statistics

Tested on N210 and N500 copper ports with firmware 1.1.8.0.

LLM assisted with development, testing and code review.

Dong Yibo (5):
  net: rnpgbe: Add basic ethtool support
  net: rnpgbe: Report link settings through ethtool
  net: rnpgbe: Support copper link configuration
  net: rnpgbe: Allow changing the primary MAC address
  net: rnpgbe: Add hardware and queue statistics

 drivers/net/ethernet/mucse/rnpgbe/Makefile    |   2 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  24 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  51 +++-
 .../ethernet/mucse/rnpgbe/rnpgbe_ethtool.c    | 242 ++++++++++++++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   2 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    |  28 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  17 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c |  35 ++-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |  26 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_stats.c  | 217 ++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_stats.h  |  37 +++
 11 files changed, 672 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_ethtool.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_stats.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_stats.h

-- 
2.50.1

