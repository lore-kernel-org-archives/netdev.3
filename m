Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0C542883D
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782984533; cv=none; b=ZBjts/PBqtlKNkP9y0feqPCb3yjH5iT1hZ5xgu5VIYYLsKgUnLTNeBVhAq7HM4i76AFU+n9PFP1QyoqIyTte83puqsiNjZNl3euq/D3B1UhZ7dZOE2HWaYsod45oEh4alEgQzcITjZ+o2c2o1AxeQ0sB2RRrZgP1qBzra5OEAvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782984533; c=relaxed/simple;
	bh=y/Hn1/1rqtxyjVuIe/I9nsOAEPe2vsFy0dLKDjWLjqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L6awrD9xe5E+ZZCiOmFLPyBtDd/q8qMcf0IY9C37m0sps9fyYBlbAxALM33CDGZAu5yU1Shqed8EDhgnf2ye7JpOeLU/UWxI9q8MvRTgKMCPvRG0SsebP2IaxaHYC1836wrf3UBsic+t2PKpB6+V3KC+3sgI5AtnWKUalRaRGLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=UUmL5Dts; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="UUmL5Dts"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782984529;
	bh=y/Hn1/1rqtxyjVuIe/I9nsOAEPe2vsFy0dLKDjWLjqM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=UUmL5Dts4dPXIZTha3aWgz4DgURlm2gGNYccvKlGVMEwtN7pCNI51qUTv8QhBe2fX
	 zUxgGV9TYv4hGbZ7eKlev56AV37zpqJCCChY5F21x0B32txPR2qQlVRo/+kE5NM6SN
	 DxSCnVrv/mMJw4IJiemUAPx2Hw7oDuT4NB+t7j8g=
X-QQ-mid: zesmtpsz9t1782984515tdd95c517
X-QQ-Originating-IP: a5tZZhdSxrCaphevRi49vA3hQewzPsivH7xErfon5qg=
Received: from localhost.localdomain ( [1.202.39.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 02 Jul 2026 17:28:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6819691085097765292
EX-QQ-RecipientCnt: 12
From: ZhaoJinming <zhaojinming@uniontech.com>
To: pabeni@redhat.com
Cc: andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	madalin.bucur@nxp.com,
	netdev@vger.kernel.org,
	sean.anderson@linux.dev,
	zhaojinming@uniontech.com
Subject: Re: [PATCH] net: fman: guard IRQ handlers against pre-init interrupt 
Date: Thu,  2 Jul 2026 17:28:14 +0800
Message-Id: <20260702092815.1206704-1-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <e1f8aec9-751b-4a51-ab09-ca3c37522e30@redhat.com>
References: <e1f8aec9-751b-4a51-ab09-ca3c37522e30@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OGh9fzPfJD5fnMe/sy3klgEbhZXCQNQSEZGKt+ZqCT6QxoNZjCw381q+
	kvLh3l27iRwC29PMuYIAG0BKclo3ml7BpdXo6Vurb6WdyfY4XW+AGyJCYb7sXWHb5kjXa58
	d3Y3yYHssm0VNm13g3bfg+YdmmYyBscvurdqvfWHSr28EHGwkWGYuXCzu6y0SDFeeHBPt3K
	mLdnmQ3ykqyY1jg2QtqzxawEF16Kg9rHdpjqBoDWr/XeE3ORM78Bd9VE4JtzngPbt2plpLd
	dJbM8onK8glR0wFJuglk1KRvCFR4N8wH6Ry0wvvDXoGTItyNLY9EVkZ4LATyoHsaoW4iu6j
	AaV+CpdzMIMhfc57HPWzMzjkKaIqduhAagQPgKlwbwlRF7koLk6TfAaOZzs/mwPedfmjbzp
	oGLl9IkIjWsl/bVXS9Ni7YaKLB9ilaVBoEhHxOsZSkYzLohMA7ZY/5Q4g1te+4Gti03qq4U
	tAlN4mbbpBioG1CNtiVZoA4AaqYbxAyIozKA8megn68tTc5COFM42p6K6RANZXVV2tqLJay
	Zo9cW1/Hqyh9JDdS8KxjEccdoB9CaKZM+oDHHf4t17ijjshXcA6ULQbe4F7GXmadBd7BULx
	uWP8D188AISwy78ouvJyxPPNJ1Oqs2K1WEl4/H2f4tvtpzdC+BcDIna3U6YILPneHlm087H
	LW4CzcYjcYPYR5yfbOd1sxNd77Y6LLlKyhNGEKLrqbUCUyD1GPNb2+O7UFk6ZaU3CGRuTtk
	qmLqs5vr4lPTr//UDwRuzlyFXDylcoNoSIIDnJXpIBi85xPksjuOAmlQK8wKij+eakHJCa6
	JUnrMjRiiumtEF4SHc9OUOuRNQ34NycdOMXNDQ4WgZUSLNCPdHS+Rope+rIOnjwf15BANaH
	N94h5V6ASFLkPOnuT4y+ZMJTLeuLwXeR1noXAxskJ64jPnDuV5DRM6seNd9TTwz3/DoFvSg
	4TDeLrl4UTBtMxepuogU0BK+/O96e/GssHbcOBZrdZkKJYs4sfbWdWsGKQiir5z693euhNC
	Pjf5Vi2OSbWz02SQJg
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

Hi Paolo,

Thanks for the review. You are right -- the irq_ready approach was
fundamentally flawed, and moving IRQ registration after init is the
correct fix.

I have updated the series to address your feedback:

Patch 1/2: Move devm_request_irq() out of read_dts_node() and into
fman_probe(), after fman_config() and fman_init() have completed.
This eliminates both the pre-init NULL dereference and the UAF on
probe failure in a single change. A separate UAF fix patch is no
longer needed.

Patch 2/2: Add proper error cleanup in fman_probe(). The existing
driver had no unified cleanup path -- fman_init() and devm_request_irq()
failure paths leaked fman and its sub-resources. This patch adds
fman_free_resources() and fman_muram_finish() to release everything
correctly, including explicitly freeing IRQs before kfree(fman) to
avoid reintroducing the UAF window on the cleanup path itself.

Patches are against net-next/master.

v1 patch (irq_ready + READ_ONCE) is dropped. v3 UAF fix patch is
superseded.

Thanks,
Jinming


