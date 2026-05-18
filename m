Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D814304BB3
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 02:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779073067; cv=none; b=cmTGHgvkZXb5HzxImNpB7eAGvcukD9IMtJzs9+hY++nYaMyLbQR1NTQ4hUlDt72aAOC1oc7+h7Ce8ojmL7veJZGjJ7gBLm/IgCVyThieUixIVwfmwy7lYIhmmmBcTouuCPBZ1vmWAcDCuV2BOAi+lw/8FT/oPd+c9M1qMCCgNag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779073067; c=relaxed/simple;
	bh=8JjJ5G7lxLlPleEr/l7XFsVNsUNIUxV9ZfKBvW/+WrQ=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=CGPovotRrZmznrETXFa91BKfksI8DM4x/qD4FuuUgEEb14zClx8RvuzC5Iiu8avbIdBKRl97CSQPbPsYPqhWVuC3zSPrzlWyGHE8lAFUPLIYHZN14eZDTwENwjdxAHukOiaZUcbQmNL1/9pwyN3aC10j3w9l65+Bn3jXAGj9ImA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MTsJs2qN; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MTsJs2qN"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779073064; h=Message-ID:Subject:Date:From:To;
	bh=8JjJ5G7lxLlPleEr/l7XFsVNsUNIUxV9ZfKBvW/+WrQ=;
	b=MTsJs2qNUz/LhyOSWWcpxIyCWjq2MrFB+8fs3AANif2H2f6szKxIgpz3bOhvXfDzZRW7kNa9J9vjnFwrC5SrANNUMFFcblmgiLLzZa6D1T32VIlrB47WgqtJPCTy1+MS4/43zath77gP/aeP/quErLavmXQ5WkowXSZxmQdSt2Y=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X33-1Tr_1779073062;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X33-1Tr_1779073062 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 May 2026 10:57:42 +0800
Message-ID: <1779073032.5681694-10-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v43 2/8] eea: introduce ring and descriptor structures
Date: Mon, 18 May 2026 10:57:12 +0800
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
 <20260514095138.80680-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20260514095138.80680-3-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

No regressions from Sashiko.
