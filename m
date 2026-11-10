Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794292887;
	b=E9nTK+YRICP8sKwoHTz/CLgMsBIS/N2+YvIaV8kRUxTRgkh8sqhMqxEEX833L528SUQF
	 hyvC+m/pdM1dZ/3GzTrHYO5NwGZEbMFyPYjqmfGnQQanBIbjvkYlW+cXwvtZBooiZsyOC
	 dW51z5xRMPBukhikTjfDT/wvCavWabO7WBLtLIyNPJOpce3k1ekGl2ua5ZxpoCWWjWH8g
	 +yzmc8mdh8xwMro0wyu7AJSmpgDN6Ju3sWxUWruTuFi98fEmw1k+5O4vKiD6XGZRE9AG4
	 bFsgR2baXE72dOnE19miNTiwdfikUFEfjKtPVyaHMkfYQ5MPvTK8bJNTC7EWmMN633w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794292887;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5Jm8CmWCS+409DVRpY2+DlWVRbEH4X3VIeQI4VAZvY8=;
	b=CFkD6x8bm7U8NElP3hUiuChn+iptLLLxhfid2tysi3fLE4PofpgzJwfmgJPtLFfWOJGs
	 N3nPKaFl9BV1aDQ6tV9FRIhBO+4FxYqTe6hHon8DXNWE3IfG2KnswYdK1aU4Y0UYHAxuX
	 flOMBaBeNkwJnOGZSbTmusEyuyQVLEVRjhD1ptD+ZzvsKEDMk90YRixCbH22IHIZSv2eE
	 5HRVWg1BJFwZlEAGfP2Q55VP8E/zpZo9uM25yYq+ddsRcJ1wejd5g7reCGPFzHtuxfOVh
	 2yGbQwHP0F8vp6WrCduq+wviFroQwQ8JAAXVcbB17PlFpv3GfuNfhNOaA6OkyBx7nng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ku6oRIVn;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5115860A6F7B;
	Tue, 10 Nov 2026 06:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5115860A6F7B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ku6oRIVn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=ku6oRIVnWj9CiJzoeVUSods1NYk5PStssoE5vzfE/94wBRvbZU9U/LKZuztZFb3d4CoEJGxsXeex0
	 fi4hG6owCWLzigAK0gOIR+jXie0EtGUG7V9NoiC2FnNYyX3neTVQ9m1YWD3ngguXAIobpsuV0mTG3T
	 72aoJ/1MlR0yPby8=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26af2bc91c8e-07a60;
	Tue, 10 Nov 2026 14:41:21 +0800 (CST)
X-RM-TRANSID:2ee26af2bc91c8e-07a60
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from DESKTOP-3K8GUTQ (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66af2bc8e8a1-aa5cb;
	Tue, 10 Nov 2026 14:41:20 +0800 (CST)
X-RM-TRANSID:2ee66af2bc8e8a1-aa5cb
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	danishanwar@ti.com,
	rogerq@kernel.org,
	jan.kiszka@siemens.com,
	diogo.ivo@siemens.com,
	haokexin@gmail.com,
	horms@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
Subject: [PATCH v2 net 0/4] net: ti: icssg: Fix device_node handling in prueth_probe()
Date: Tue, 10 Nov 2026 14:41:13 +0800
Message-ID: <20261110064118.1138-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
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

Hello,

This series fixes the device_node handling in prueth_probe() of both
ICSSG drivers.

Patches 1 and 2, carried over from v1 unchanged, fix a device_node
refcount leak on the "ti,mii-g-rt" and "ti,mii-rt" syscon lookup
failure paths. Patches 3 and 4 fix the port scan loop that is shared
by both drivers: a port whose reg property cannot be read is skipped
instead of being routed based on the uninitialized value, the node
reference is taken only for a port that is actually accepted so an
out-of-range reg value no longer leaks it, duplicate reg values are
rejected, which is what the existing "port0 and port1 can't have
same reg" check intended but never caught, and that unreachable
check is dropped.

Thanks to Simon Horman for the review of v1 [1][2] and for suggesting
to collect the fixes into one series.

Changes in v2:

- Collect the two independent fixes into one series (suggested by
  Simon Horman).

- Add the port scan fixes for both drivers.

[1] https://lore.kernel.org/netdev/20261109165235.GR18859@horms.kernel.org/
[2] https://lore.kernel.org/netdev/20261109170036.GT18859@horms.kernel.org/

Xiangwu Lai (4):
  net: ti: icssg-prueth: Fix device_node refcount leak in prueth_probe()
  net: ti: icssg-prueth-sr1: Fix device_node refcount leak in
    prueth_probe()
  net: ti: icssg-prueth: Fix port scan issues in prueth_probe()
  net: ti: icssg-prueth-sr1: Fix port scan issues in prueth_probe()

 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 32 +++++++++++--------
 .../net/ethernet/ti/icssg/icssg_prueth_sr1.c  | 32 +++++++++++--------
 2 files changed, 38 insertions(+), 26 deletions(-)

-- 
2.50.1.windows.1



