Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792476119;
	b=4VDm3lE5mcV+cj6fAGJvKIUUYyYKTBGerrUAu8jGXon8g0DB+bLa1/7Cgehh9YkJtAv1
	 GMn/w00BMvaLa24mn0NIkhkbhwdhPA/KFYE5LYhHnUNYgVIZ9qTbIyscAlockEEqMUjiA
	 rOCww1CIGUR+Ky7skdxqdF+owCiUTHGVaVrB5aL9zNYSPbcLGZO2s3LEA1B11iK+1hRsz
	 ukUFPzbkX3CXoaHHiDv2UgJeSocXKygriGYj2lozVrNyUtYN3Yg0aqBnKxC5NiyR3cMfX
	 /Cs7YRrz+Q54VxnVu6Nsk4aKHPW/soMMJQxBTOjeifb9YCyJp7vu9LPziXn6xcdqMEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792476119;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=4TLhFhXBSg8lGOos0oLHrudOOvSnA65Jfk1EX0Zd1UU=;
	b=AugJDt1iO9J/VN5ryufT3DmCtCRMlDYx00/ve2Hx4sVLxDjNxqQ1Ed3NYlobeHvgyPDD
	 scX6RNZcrsDe8/obbGjrTzT3t4x1c2VQjbQY7KHW9i8n/+tTpNwWf2tBEwu/iMW76989a
	 /OUYFSgSvfL8B5EWAJOszC8ZGy0zgi5dx3fUP5It4Tb7fdzago62R5OV5JV9mBswMyj6h
	 mrqJFRidwJ/E4XJiGsiU370YGdDKLhYg1/cIKkWsemQP+1JW/YlZeSR3jnZ3R99qXS1la
	 SFrkqULry9pMzCWMEPGyhPVK3HwH/F22GOTM9/aCViC5/4zXB+VdaDrhi/79Bq0vTcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=trustnetic.com;
	spf=pass smtp.mailfrom=trustnetic.com;
	arc=none smtp.remote-ip=54.204.34.130
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930ED606A31B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 06:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 930ED606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz6t1792476076t730657c0
X-QQ-Originating-IP: 4oYxQppEZuFywPUZ0pm65/5gg1VqipMU7ktu15H7bro=
Received: from lap-jiawenwu.trustnetic.com ( [115.205.193.71])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 20 Oct 2026 14:01:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17586144968859919614
EX-QQ-RecipientCnt: 18
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Chenguang Zhao <zhaochenguang@kylinos.cn>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [RESEND PATCH net v3 0/3] net: wangxun: keep MAC enabled for NCSI devices
Date: Tue, 20 Oct 2026 14:01:04 +0800
Message-Id: <20261020060107.25636-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
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
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M/xd4vZQUWI3ciAeBQD++7QXEylH/bGXsRvKuzjtic+WqrLp/gogN24x
	x6kIQSet9NwSI048qvbMGSfS9hBjb6aiicEKpNVal7QdSNFc6uJhpxbVedhbH/swvOBD2K8
	R+hYR0aiZEK4TP7f9zzDGNZacRfzXQijDD16cgOtq6Y+qPftaTJVewMVyAfc9YAyWjkRAuS
	j9zLFLTpr0bGKHd2KFsv5xYOB/FCvxSuqVKz3ZVxT34r6QCOMXxNVWoPK2pj5wyUofMpFQE
	GPIzBvlvB+9yOMIWEhihz5X6BAhKY0EL9SixrGYzOvJcEhr86JVGz2pufY4UDVkwr1O0Kbt
	bhzd4PE+ROlUTcFpG7U3i0zhBsmMlqI0+YNlqvsuMlmA9SMcXAPFqtGkL+GI9/lWcDQUABD
	+jgRTJ2mfo9whGHnof7cbmztRX9JtB+n1d7uu+RBsvvDgTe6WpgQVgqSVriIjcAlgHoPfEu
	qPC/RwZypNXtQXhQ66TKIzj2rUjsF6WLEU+sQDK+exgEhpfeWu76lbyrfsSsCrNsKmpsn+A
	euDUuSCAcPA7+l8n0SBHsVSTBBTIQiAiEJ4P240596Y8nR2SJCSJdON5oFnTnHahmj30SfL
	1MGMzcdyj6dHQxdi6R8F2DDOyYpBElSrFUEgu3lilIcABZBRw7L0mWoBfEOw4lEQTzkMcwx
	vfNF/T10yNHThkZunpBRLtJOmal6nfsVPk4Z1JU3b7maYaBv/LAwejbuJyQZoeXijIUzeVd
	DflkiM4UBB/CBh/vkWUDlADcF88IIerNFYU+WB4qw6LynymJuHpu+tkhbzzCsvHJnkko2VQ
	XY6hpjLcD6lXW9TMIHQOura0irjE1/1HSTf8p5reTCHpGKcf8r23NcADJsWIH3gJae96gGz
	NTG0WrDpyuIn8HOuzqg9q1AKZAu55kZJH67NXr9mWWkvopurt+rBvx+/o7fdG6Dt4L3MOEm
	vq726PDtnhEFgYgjLTd9lF9GbT6DCMGuKuOjTfn1ci164n+W4jVNikOEt+SBJtJvr3/qlcI
	zkObP7HY3LyIyeqFolhJWqgyZ66z/EzjtieUzcrtpd3odPMJjOkJpAwT3vJQzQB4wXQ/+ks
	ZwZ5+mlOMaWEr+dH5teYEZnPyNahZ+3koF7SualwC+3cdaYCxh1Z6IuNychoBxpqbgvHpDl
	QcJ8
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

Wangxun NICs that support NCSI share the port with a BMC, which needs
the MAC and the optical transmitter to keep working when the host
interface is down. Currently the drivers turn them off in several
places, so management traffic is lost whenever the host interface is
closed or the link goes down.

Patch 1 makes wx->ncsi_enabled the single condition for keeping the
MAC enabled. On NGBE it also covers OCP cards, which support NCSI but
do not set the NCSI bit in the subsystem ID. Before this change they
had the MAC receiver turned off in wx_disable_rx(). txgbe now sets
ncsi_enabled from the subsystem ID, so there is no functional change
for txgbe in this patch.

Patch 2 keeps MAC Tx enabled on SP devices in mac_link_down() and
re-enables it in mac_finish(). It also keeps the SFP TX_DISABLE line
deasserted while the interface is down. The SFP core asserts
TX_DISABLE whenever phylink_stop() stops the upstream. As a minimal fix,
the override is done in the txgbe GPIO controller and only applies while
the interface is down.

Patch 3 does the same for AML devices: MAC Tx and Rx stay enabled in
mac_link_down(), and txgbe_down() no longer disables the TX laser on
NCSI devices.

---
Changes Log:

v3:
- Use wx->ncsi_enabled instead of the open-coded OCP check.
- Re-enable MAC Tx in mac_finish() for NCSI devices.
- Keep the TX laser enabled while the interface is down.

v2: https://lore.kernel.org/all/20260924020149.30800-1-jiawenwu@trustnetic.com
- Remove WoL related changes.

v1: https://lore.kernel.org/all/7DBD5726DAA21342+20260920085114.1062503-1-jiawenwu@trustnetic.com
---

Jiawen Wu (3):
  net: wangxun: keep NGBE OCP cards MAC enabled
  net: txgbe: keep MAC enabled for SP devices that support NCSI
  net: txgbe: keep MAC enabled for AML devices that support NCSI

 drivers/net/ethernet/wangxun/libwx/wx_hw.c      |  2 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c  |  6 ++++--
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 10 +++++++---
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c  | 12 +++++++++++-
 4 files changed, 23 insertions(+), 7 deletions(-)

-- 
2.51.0

