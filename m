Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC93E3EDE62;
	Tue, 16 Jun 2026 06:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781592089; cv=none; b=ojjT3rCdWijg/rOk1Fre6LZFuP9qUFJy1Iep3xFeKepIoqNtn7fuWsdCZhZIGqYmhI300mKu+MABf2LPzrDc0t2+WtyfrIUPDXxpYj88hw7IAMYBm3ldjIwqz5XKkY7vgG8Y85BoJ6imYQ1rGB0aTLjVZWrOiw22mxGNE+hrv0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781592089; c=relaxed/simple;
	bh=Nn+j/SMDD+ksBhm0fcTUgibml7oItvZMiQiHH9Rzg8o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Psa7M6UeTNws+PAJsk1NoscuPauApBqoJ8Si+59wwz6ACKUw3/YYKLS9/Bqq6IIsaS0YloUBzWhs1xBoX0rLtQO0WBRT4K9MMwIChf4SArLhrF19gpMw7694M9PLJ9Gax6iqb+5GaE3Xpl2cLMV9mjniLW2Nh5HaHzUFjOSfX8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=gloyH7bm; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="gloyH7bm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781592067;
	bh=V2Z+nC4wHAVI0AuwYetVQ3xIQ99+k8HLZV8UDg8tK2c=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=gloyH7bm+RlZyb90oWwIYbbLjSmny/bCuAI862+8ttsEOI+RWtqwUE4SYcIkAe3Cj
	 dkTofZnxbo+KRq7POTNAJopPBYWWp2lsOTdw+r+rm4nlxRlU4A2ASenJ5XbXqdYb0c
	 K5AnloRVMmzTG4iYb0n9wTBoYuUIUWf+wFpxlSKw=
X-QQ-mid: zesmtpsz6t1781592058tcfbc6d76
X-QQ-Originating-IP: dEqSPUm5acj1W0R6sr6fgf3PSYl40VTD2hzx3wZhB10=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 16 Jun 2026 14:40:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15308741821471108466
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: kuba@kernel.org
Cc: joel.granados@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH net] net: llc: make empty have static storage duration
Date: Tue, 16 Jun 2026 14:40:53 +0800
Message-Id: <20260616064053.690154-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MJ0QbbALek+qANoWEQHjSVOPLRlQ0YNvv3UfUOLen+57/2uWitJkTvY5
	pQNhCc8hdNWHb8tVJ1R0iU2m6NQbbuPcVyzFBYMZA1vgD9UFMtbk/kBXfsbmuq2rnBNnc1k
	06Sn/697wRFjSOCm7otEdFJLPjIB6sK7ZNiasRmDatBefPvbzQiy/+1r78MrGJkwz+a7EHS
	isCxU3KkEKL0Q+/3AkOK/t3Q1mDYlBMhQ91IMUv+pNo1leJDcWdiAMI3nGt/7i3N98+xxMR
	6Rvc8YiIC/OjT5bWNO1nXnER/7LblMeOBU1TdqE9yC84S9XWMgXSO8D3OelM98mgslEiXf8
	egLNnGFlYEw0jDIYWimjIn9AllaAOUgp4ZuFvsp10dlwtfUI2EcYDUP1Y+7tAxNwyWYSiFU
	FkRK40VsGz/2rYEo6C6JFHm8j5BbggDeb1bxVauSnhqmjiWF7w0a2+cB5Yd6D/E5Yx+oTLd
	aSM4cRIlCi+ixB/4gc7LJTYUW0c7meUcyP5nwH1Am+ggg0xQgE0b/FF6io6ZUiOSmstPukm
	SIma9cRaxFEY2LK52w2ipDJyhDJyd3/hdcBaRj8j4fGXipTulkvnIJQYizAkTOma4YiVgi0
	Ep1Cvw3Vz6yjMS04rkJRsdEbTbGjLUScGQ5qCwg4F9R58fByPKjB7BrBbC/g2kRbbIEhEAo
	NXw9BJda3lAgbVVpVBsstuT2Dc7W2qH5wuX2NfE8lvObIovWmWepdqUhS4glaSIRTOr2I9v
	JQHG/WCxMgDhHYSXl1JKPCdBEnDV2n/gqnLrJrNxu/vQPf0Gt2kvVSwpH9mxKU1z+FZFydn
	0Redq1rZy04TpHcA5/FYZA6+Y8Hq0ajh0dSLFMn3MxzQLx5qyjkpxpJ3eYEi303U3Ig+5U/
	vHpc9Csc4yvroCkaijfscFeTqXthaDLXnyitavN9kN2Fv924MlQUMryVzgOYNjwHIDvuvjq
	zN2u15HhDhhQ7fc40ZF16FkzutDYgmtg32LNQ21nrj/pITVPG0LcXUiTJl5mkoi/9nEvW5V
	6HORRTU//8d3N7rh0ARAlOCIfFp3BflThlJH2AVGaWfPtTtfgZkd/iMa1ARkK3cg3H5CZV7
	MDVoHqUGdL5
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

Make empty have static storage duration (like net/sysctl_net.c does) to
avoid a potential use-after-return and keep consistent with
__register_sysctl_table @table 'should not be free'd after registration'.

Fixes: 73dbd8cf7947 ("net: Remove ctl_table sentinel elements from several networking subsystems")
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 net/llc/sysctl_net_llc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/llc/sysctl_net_llc.c b/net/llc/sysctl_net_llc.c
index c8d88e2508fce..15f1e5d88f208 100644
--- a/net/llc/sysctl_net_llc.c
+++ b/net/llc/sysctl_net_llc.c
@@ -47,7 +47,7 @@ static struct ctl_table_header *llc_station_header;
 
 int __init llc_sysctl_init(void)
 {
-	struct ctl_table empty[1] = {};
+	static struct ctl_table empty[1] = {};
 	llc2_timeout_header = register_net_sysctl(&init_net, "net/llc/llc2/timeout", llc2_timeout_table);
 	llc_station_header = register_net_sysctl_sz(&init_net, "net/llc/station", empty, 0);
 
-- 
2.30.2

