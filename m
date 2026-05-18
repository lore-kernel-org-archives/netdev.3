Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32A72EC54A
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 02:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779073035; cv=none; b=QNixp8jZmW1Vcv58qAs+VwmDUNfJNHaq+NmOIPUAgDrsyEL3sQ407fmxtsxlmPQeEE0U3KzvsL640j0rjAHJ849tXADE6J6N+Fn++2xWQ3QNc3kV6d9TEAhosHEt0AfjMmQoj+Qrb8NwUkim5Wisx1cR04fImFLbEjbhWk/DmnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779073035; c=relaxed/simple;
	bh=bREeIfU9hi73O2jSzxRawajQz0U5vFbSMKoLoK0FMec=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=tfKl26MgYqhSD9I0ioG1kYm9+Epy8NBNi8xrHKLUZdWqP/NSaf8EGdiR09tDCEpfoQMc2x1OIag2hZjj7l5izx6KKqfzd+HMlKNOB3UBtHq7E2NK928myDjV5UKuuvRxeLDW5zmKMmL9NJ1XJcsz3jcZLleql6+XmkG4h3Mv5Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Y06611Cw; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Y06611Cw"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779073025; h=Message-ID:Subject:Date:From:To;
	bh=bREeIfU9hi73O2jSzxRawajQz0U5vFbSMKoLoK0FMec=;
	b=Y06611Cwc4HQdbIZO1DB68y4yCXP8sUPk08wPv/NGgYoY8Eqxm9Tnu1X9Ke4IE7CNo6UmTHMfpOJhxye651nKaGYQH3CA6ylz6IutMhuT9YVR7pek8Hnr089XgHaHj7OwF+kj6DBmQZacRJ19tiRiRhbKYbHnznCZ/JempAsgBk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0X32xQop_1779073023;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X32xQop_1779073023 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 May 2026 10:57:04 +0800
Message-ID: <1779073005.4098387-9-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v43 7/8] eea: introduce ethtool support
Date: Mon, 18 May 2026 10:56:45 +0800
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
 Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org
References: <20260514095138.80680-1-xuanzhuo@linux.alibaba.com>
 <20260514095138.80680-8-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20260514095138.80680-8-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>


No regressions from Sashiko.
