Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EAF366557
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 03:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779073460; cv=none; b=Dp3Hq6YppFBQ7Vrw283v2p8Zk7lBRm7g9AOWmwJMP4DokkL/lH+CJe2WmXscoF/46LsqGfYDK2n31He14I6Mqsx2hrzjz6iqMZ6jRPKY3DlJ++8Sbae+6RxAirQMLPgLj0HPu4ylVx1ZDSRc63uo98Uwtq0fBHLaiwFHWBtM3+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779073460; c=relaxed/simple;
	bh=ZP70uEwWZB1e00uw4fecKU/PrJuv//1vq3Buxaac2cE=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=qiKEOYeHJNWESwOJ4IWkqSvoVjL86oTMSAZiFTo7qocY9mCMBX8YF7OgdnV1Htt9vfChyaYB43H0B1qXWaWkLqRasq9cA8hG++lrGeUh5jPCtMCE+3aqYebfvhNRbNSKX4J5npNym20uZbYIkMvqlnMbYjya7DVlPf7vMrdePlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CjxmO4/x; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CjxmO4/x"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779073454; h=Message-ID:Subject:Date:From:To;
	bh=ZP70uEwWZB1e00uw4fecKU/PrJuv//1vq3Buxaac2cE=;
	b=CjxmO4/xYmSERcs3HxnuEhbezefgP/oUTacD6UgCsGyu0UHyTTPAH8+1/N5h18ADNVmn66Nh0Bn46UaepnEQT0qgejLxwCRtN7qxIp4iSr4TJgWcqjWc3jvM4Q/oEECBndxMHOtktV1k09mecsV81AC0axi80nKKqDyg9lDTH7s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X32ye8S_1779073452;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X32ye8S_1779073452 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 May 2026 11:04:12 +0800
Message-ID: <1779073307.6412275-11-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v43 8/8] eea: introduce callback for ndo_get_stats64 and register netdev
Date: Mon, 18 May 2026 11:01:47 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Dong Yibo <dong100@mucse.com>,
 Mingyu Wang <25181214217@stu.xidian.edu.cn>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Dust Li <dust.li@linux.alibaba.com>,
 netdev@vger.kernel.org
References: <20260514095138.80680-1-xuanzhuo@linux.alibaba.com>
 <20260514095138.80680-9-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20260514095138.80680-9-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

https://idealab.alibaba-inc.com/ideaTalk#/ideaTALK/chat?sessionId=252ca245-ee4a-45d8-a859-d20100fe3f91

Sashiko comments linear growth in the stats counters.

However, I plan to introduce qstats (queue-specific statistics) in a future
update, which will be a more appropriate place for such tracking. I intend
to defer this feature until that implementation; it will not be included in
the current version.
