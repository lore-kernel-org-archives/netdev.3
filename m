Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8627372056
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 03:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785728484; cv=none; b=KWHZgkQRQSjksrbIIuouSE0ZWqdg/iK7X65bTHqxNBTfnApeEapuUgPTYpYNaKppY6rXqox3/ujns3kOvCViLnhIZVwYBqiejzNTOrGXvzKAW1JSJgxQwwDUmq/AyCGOKX78DnJHOMhVuXd+8co2E9PlmbAebsDYpFxMSYmRGq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785728484; c=relaxed/simple;
	bh=NCMW4kQRyBWSj2E3oOTBkzWRrKKMpt0eKzLDMpatx9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHCJ1g/PhQwe3sdbMJ0fXcS7lxEGnASxNIdGnsAG8D3P8qgDRh/IGXtq2cdF82uuiKwAgOBOU4R+401KKAJ6ZC8gtqvTjphM7X7tp76e63GbXxklq9xTmMDhdFy6MCefoYQqBc0xDv3IZzVOtxG1HzgdVMU2DSu7fSWlUE/tJG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=xnK6PMTq; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="xnK6PMTq"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e071ed6aeso2226653a91.0
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 20:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785728482; x=1786333282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NCMW4kQRyBWSj2E3oOTBkzWRrKKMpt0eKzLDMpatx9c=;
        b=xnK6PMTqK146IzXA4PJD65/xzUYMlsQsTRsM3vQHESajUrVka74oq2zKaSAZHhWR6u
         Hi5tCIhz1hqbjkScLbKtyvYa8YPscLTwibI/tYHhhTMxMqgipa+xRdtVU9/yB0ThvIk3
         XP0HqvWIXZ1PWlAO3GsUkmaPQzBVGfnjFMc8FLDYmdmkuzYkcQD7wMzYgC1pt0018/P6
         SfRrtP5oP73JWVdYmVZp9/e004xJgJQWl3WKR2ft3FT2oBxuoN8kXV9SzpbWyu1nRmWv
         cJ+ZZlYmJOz6/GaCiJAoFphm8qQj5yV9NyLTp6UOa6XmiGrQen1Fg6YLV9marLubqsFY
         jEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785728482; x=1786333282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NCMW4kQRyBWSj2E3oOTBkzWRrKKMpt0eKzLDMpatx9c=;
        b=KPTSId4pwcW2Go68warRzndqSPNhRN66N3aw2GK9bKkrrQPRjiCiFQWRLmg42Il4yM
         vyEWHE1IUEhtQZG/2pv5ygQU8L3uPcrx5SxkBBR1g9fU1DHZ58bAivvSwLvjyFZoL6yw
         CEMt3edNK8RFGKgISXFKqJeIzl9vEmYSghULeyEh3V/LPRzp32tt9XJ+eSo1W1zk9dDg
         Ru94XjXNWLLFmtwPR5apSWAU6pIqKVa2+tYzZeL0qwLd89DcMM0XJOFREF9+HoRLw4op
         OO6pQlh8XVek/M6uFRMEGkGi9WO3xKnbwdiWXiGZpd4rURI2GUEQJqcnR0Y0OXpikNOV
         2XHw==
X-Forwarded-Encrypted: i=1; AHgh+RrEr2f0SQz2meEgoM4oi72QC+6vAnF14JtVkgEsyvj4mr5GyDPwqDEBIJW2dmzRarHIgDBfcGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YylL7qugIG4UdrvipCUwWURJHQSuLBaOdM6SnjXLrq0oAl/Jpk4
	qUanVoBPbUBgJc1hLwz1qia/7o31E3p+YXY5qnMXGd5Tsmb6UIjQztf45VNEAqIAUk4=
X-Gm-Gg: AR+sD13wgx2hGpUEiCB+JFlOI0HHGLXeUJmXAN0FA6WG1Hcj0qytcWK+G+hS8OLxyN3
	GDpVze5YHaK7D3k2Nyb3fwezzNMdskOf46q3ayDlF9gIsmG2yFlBQjfWP104Y9VABM+Ztc92TCd
	48YQSMNwDBY9PxZfuxZJ1zEsCI1nq73eGEET3NeXJgHvvyWOuimeZYSJukxkdscDiUXucYA0dK5
	+kZydH8KjJPyWy4FwdWyYkpw6dXkIu90a9kdi3jKpBe4BJAtpMAXzvh7eu+LxDuvdWYDY3ku/Lp
	jkx0oIckg3vLO4j0z1LSFstxEqZVVYfGJh/FRkimj1VBG4zUJ/HXh32ReezQNpXkK8amD5mQRcD
	oV5SBQ/tl2568vOU1fNvPxXsszXAGKUv2N/tGMyJtiALohg+upmbu6P+RgLWNTljG6SOz5kik8J
	XYAtaP/wxMsPsbrJGvxCXuj5b8OQ8gcIqDIhAK1thUce8fHYUIpfPkdjCmHcf2NETNgKfc
X-Received: by 2002:a17:90b:50c4:b0:38e:447c:9a15 with SMTP id 98e67ed59e1d1-38fbc516655mr7151775a91.36.1785728481711;
        Sun, 02 Aug 2026 20:41:21 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2bac654sm3299609a91.10.2026.08.02.20.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 20:41:21 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: horms@kernel.org,
	mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	guangguan.wang@linux.alibaba.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	sashiko-reviews@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: Re: [PATCH net v5 2/3] net/smc: bound the peer rkey counts in SMC-Rv2 LLC messages
Date: Mon,  3 Aug 2026 12:41:05 +0900
Message-ID: <20260803034105.2051552-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801094208.1937951-3-yhlee@isslab.korea.ac.kr>
References: <20260801094208.1937951-3-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Does this bounds check allow processing of stale memory?

It does, and 3/3 of this series stops it. This patch bounds by the size
of the buffer the message landed in; 3/3 copies the tail of the message
into the queue entry and bounds by its length instead.

The bound in this patch never fires on a link with a shared v2 receive
buffer. It works out at 507 rkeys for ADD_LINK and 2046 for
DELETE_RKEY, and the min_t() above it has already capped both at 255.
I measured a 44-byte DELETE_RKEY_V2 declaring 255 rkeys: mainline and
this patch draw the same response, and in two of the four exchanges an
rkey read past the message was live and was deleted. With 3/3 applied
the response reports 9.

It does fire on a link without that buffer, where it becomes 9. That is
the out-of-bounds read this patch fixes, and why it carries Cc: stable
while 3/3 does not.

Best regards,
Yehyeong Lee
