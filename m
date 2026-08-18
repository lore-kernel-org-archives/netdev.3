Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D18E331A48;
	Tue, 18 Aug 2026 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069515; cv=none; b=RTTbFxnzzQbQT6Z69eHd0OxucXn/xklyd0euxIeKMPrwhOVaRaS00LOYwqD+r+7T8wmEpzKNgJ71xuc+9FD5yEDAmMCx/ri/DDlzYQ33gRN9sOgXIl410N4/abliYm4C6Q1lHnzimpeLqlyVfjOJwbrHRjXLps8ARsxJA/tlteM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069515; c=relaxed/simple;
	bh=W1Em27AVhI3+oC4Pw2noIWML1funYsKpMOqvQkpbFMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHdVMaHeNRa3HKordAFBlgWKU6gDwogTiORXjbNh5lTG6gxgH26MU6EloxKeEk0N29nDT6Hj5dZnY4ss1B06Tw+MQ6sL8Mkoebe7YBsdfWrA89cpiYds19ygA6S5Cp4qmmDbijITOsCzFprLYzX/neQfdc0FsEz+mYRS83XjXOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=TvPUuGAK; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="TvPUuGAK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=W1
	Em27AVhI3+oC4Pw2noIWML1funYsKpMOqvQkpbFMo=; b=TvPUuGAKSS3ZFqRTMs
	xS21+SZFQiCcuQjZJwANgLchJEXvzLYvW7ZYHRj0dbvSLEFPK9xfuxTDuTEhbH14
	gdkRtlJmI0nu36yZFspisxTzdKUTzU6WSrCGeBomDWDklGivvW3GwxsR2kxMbcxA
	QkVRXKSFzcjQOevw/j6jE8LLs=
Received: from deepin (unknown [])
	by gzsmtp2 (Coremail) with UTF8SMTPA id Ms8vCgD3N0KXgoRqMNE+BA--.56393S2;
	Wed, 19 Aug 2026 00:04:39 +0800 (CST)
From: Ziran Zhang <zhangcoder@yeah.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Ziran Zhang <zhangcoder@yeah.net>
Subject: Re: [PATCH net-next] tcp: fix mdev comment in tcp_rtt_estimator()
Date: Wed, 19 Aug 2026 00:03:23 +0800
Message-ID: <20260818160323.6727-1-zhangcoder@yeah.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260818085354.34325d0f@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Ms8vCgD3N0KXgoRqMNE+BA--.56393S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrAr1DtryrZw1DCFWDXrWfAFb_yoWxXFb_GF
	yDZFW7Jw18GF43J3Z3Kr45ur4Ygw4kC34UZrWfX3WxCryrXFZ3XrWkCrnruw1Igw4j9Fsx
	Grs8XF4UCr1aqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: x2kd0wpfrgv2o61htxgoqh3/1tbiIhiCQ2qEgpit1gAA30

On Tue, 18 Aug 2026 08:53:54 -0700, Jakub Kicinski wrote:
> TBH I'm not sure this patch is worth the review overhead in the first
> place.

Hi Jakub,

Thanks for your feedback.

I understand the concern about review overhead. The reason I think this
patch is worthwhile is that the current comment has been misleading for
years. It only describes the common case but omits the sharp RTT drop
case, which can confuse developers (especially newbies) trying to
understand the RTO calculation logic.

If you still think this fix is not worth a standalone patch, I'm happy
to follow your suggestion on how to best get it in.

Thanks,
Ziran Zhang

