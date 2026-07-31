Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E9033ADB9
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 07:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785484265; cv=none; b=oPhu3x21QyolWoLTlge+Wv4lbpuwJV0cHbIgqx57TdjMfzKzHlTNq6+oJH9N/Xn7+pbB+TWGkhyaqO2GlxqYnUCPDfw4+FOMe3ga8Jano7KQRpuPJJ5qnNIyFCgeB/WLyul4ymwu0TzSKehfb4Obn5mKU2VukxB4t0Lvli9gR6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785484265; c=relaxed/simple;
	bh=JXH142h6xkTrPLsM+pzzlOqBej96+RJ/DMR7sNTsU90=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TmzWxqe6TZtl0i4h4nBPV5am0rZL7K8zKTktHIamLHsjhBF7wDhWvT3EBt2YTeLfh7T2h4BfRoX61D453/UNFUsciqo2mHzHm1NXmUgmEMwrOjlhHfLjrZ5znr++hwDIxXOrScKIiTDUJwy0TYwuI6pb+6LG75OV4gJQYsU4i18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpsz1t1785484204te59000a6
X-QQ-Originating-IP: wnN5kiT21G3qjSDSq0Upu0Nx+j+5pZcZK1Dy/bF6GVs=
Received: from localhost.localdomain ( [122.235.139.83])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 31 Jul 2026 15:50:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17781807480015387417
EX-QQ-RecipientCnt: 10
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	linglingzhang@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next 0/5] net: wangxun: improve statistics support
Date: Fri, 31 Jul 2026 15:49:53 +0800
Message-Id: <20260731074958.19333-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: OIi9LpvIww0GhslhkHL2iXd4w1UuOgRDmzQ3XtKQ8rF52XX4xf5xHydl
	VMXiNUgclg3styN2k97s9szMeORdAiG3g46QqJtSDbeDQWahGoAmEpWXNEqe3QcOy1jGgZe
	89YkCktkfUKTD7FcXkN8hoBwL7s3E2uVMNMGiwkDu2mN7nXG0Aly2dmLFDibRFf8fT01+UK
	1UVPQtKqRqg9b/lf70i6W7Z1RwGn8UN9xeorbYSl2LJSeCinSZCpYYAomgVovw2DSB/wRsi
	cRClq4J2A8gxw4399TGeH44nybphrs+3xw32DAy+Dsl6lG8xW1wYsA33xk+1wLku9QRXEBA
	EyBDYQ7+dTh77TBiYZqQ1Oqn+IFIp6KEH87JnFWh6o44f1sc4X9K+G2I1Zry/dPQIARYFov
	O58ZbTWGSGVLMtkPtm3AgsdxQLsFvvAQ4A4CP9vUVWbxLJfoafm15yp9xGQhsjyh0V42Nkt
	ovy3mgOFL0ianWB8nSFcMOHkkY1ha4vCwbXIjxbAAC72nzclrvwO3oA1/jqUQmafuc/EqkI
	ctCeazMnmEX9FVKbaQMHFKmS/J8Mlw7tOodvPLLO5eMJu0rCYZgOzWeDPvwwcORCrQ51MmF
	U4OsK6ciUZfL58Yx9b9s9wjiiZOGvkvYQOY1T6pAkDICwN70lPpF1i4rwtKft2YT+hv2eb1
	53yAGnmxTHezMpa1g3JkN8oPv1+3qN5IEv0GFHfx5HMdLw9Mq1vDY3EFur3ym6VMbjRn8de
	FEwr14CoazeUp8nsCsENJvUmr5eDgsK1rjgFggWo0NcWT/+0h9C0YN41Nk5ndd3IgIU6zuJ
	XPHmw2v1+2VWxxF8rM6oBlaQWcV9/LzmcNjJuDwlDCuFS1YSmf7kWytl2oc/kGrM3WZyWeE
	I9yN1yfxqmPv3jh7Sl1IvU3iVf5RAO0HFwlTAbW+9u7hsbxNWgzqgRnF2XQ2Qz58uq2RHtZ
	/vRYGCKwVBE481Gnohaw/ybnvyyGMOBA+8Vz6dp6LlbtnI9abHTZRpmHAlDgngFy11UqK1K
	AjmXz8UV2S/PGhhCqLfyr9raLMvZCMpSfOykF/Hd1xkOO7wwfObTD9E7TTY5xdgKQsUtieM
	uFNhtpvPSEBbXAMzY11GE133mItr8AqSA7J438/ke6ytkzbgXiZACGYwz70VbyOLmbFdKIF
	GieU
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

This series improves statistics support for Wangxun drivers.
Currently, VF drivers do not periodically refresh software statistics,
do not expose per-queue statistics through the generic netdev statistics
interface, and do not provide ndo_get_stats64().
The first patch fixes the suspend/resume flow for wxvf so the service
task and device lifecycle are handled correctly. The second patch makes
wx_update_stats() safe for VF drivers by allowing it to cope with
temporarily missing queue pointers during queue reconfiguration.
Once periodic statistics updates are available, libwx can implement
netdev_stat_ops, allowing Wangxun drivers to expose standard per-queue
statistics through the generic netdev qstats infrastructure.

Finally, VF drivers register ndo_get_stats64() so standard interface
statistics are also available.

Mengyuan Lou (5):
  net: libwx: fix suspend/resume for wxvf
  net: libwx: enable wx_update_stats for VF drivers
  net: libwx: Add per queue netdev-genl stats apis
  net: Wangxun: add support for basic qstats
  net: wangxun: add ndo_get_stats64 support

 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  8 +++
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 51 +++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  1 +
 .../net/ethernet/wangxun/libwx/wx_vf_common.c | 23 ++++++++-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  1 +
 .../net/ethernet/wangxun/ngbevf/ngbevf_main.c |  2 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  1 +
 .../ethernet/wangxun/txgbevf/txgbevf_main.c   |  2 +
 8 files changed, 87 insertions(+), 2 deletions(-)

-- 
2.30.1

