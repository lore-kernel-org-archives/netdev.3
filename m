Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16583BE64B;
	Sat, 10 Oct 2026 13:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791638458; cv=none; b=re3GYqAKO1vsgM3aAkWQLfX7nduAcYqrZxwM/pZxDLtNGPmhF5P6HnUPWwidPFuRV9WcJwjTg91TyaTOi2ePHRrHU5BOOOS+YXGU2prvA66KCFmG1dQAx329Dox9uLtoyL2Nx/8TYf2PVwPoZxE+csXpzddncxOFZ6BU8vzIyng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791638458; c=relaxed/simple;
	bh=aPmgaj82zpWSqWSssQ0+TEKN7KhnJ59x94IiabkFUvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nF8ZsiqgG4TWlAHz3MDxxyRQE2WB1DzN525wQh85JUFE99dyy3UACMfIc/K+o+PL7Q4CWYmqQUUVfUDkpkxCtkzJbA+XEdWet+ScR+ji3ROVsAgd+lbZuoYrrau14M2aKLXd4fmFWye+y+QuHGk+HocTl5pNWjlKvyUysQN3bnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=oPhuziBx; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="oPhuziBx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=aP
	mgaj82zpWSqWSssQ0+TEKN7KhnJ59x94IiabkFUvc=; b=oPhuziBxi22IB4NtIh
	o0WSF3vVvdD2faB39uotU3IjEusrLyuKHiZ/tZfy98ukFQvB29VPD300dS6278dR
	i4VI21ESCqcU46O9zUlhTyM0kGqYYMJheiQtrJa4kYEIH7TfJIVyDpw6vpxzu66B
	jc3igt1UoS/RlqeOPAW98JQSE=
Received: from deepin (unknown [])
	by gzsmtp1 (Coremail) with UTF8SMTPA id Mc8vCgC3z7KMO8pq7X5ZBA--.31562S2;
	Sat, 10 Oct 2026 21:20:12 +0800 (CST)
From: Ziran Zhang <zhangcoder@yeah.net>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ziran Zhang <zhangcoder@yeah.net>
Subject: Re: [PATCH] net: skbuff: replace magic number with macro in skbuff_clear()
Date: Sat, 10 Oct 2026 21:19:14 +0800
Message-ID: <20261010131914.8073-1-zhangcoder@yeah.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260723144724.6492-1-zhangcoder@yeah.net>
References: <20260723144724.6492-1-zhangcoder@yeah.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Mc8vCgC3z7KMO8pq7X5ZBA--.31562S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUUUUUUU
X-CM-SenderInfo: x2kd0wpfrgv2o61htxgoqh3/1tbiIQ0-AGrKO4063QAA3i

Just a gentle ping on this patch sent on July 23rd, any feedback appreciated.

Link: https://lore.kernel.org/all/20260723144724.6492-1-zhangcoder@yeah.net/

Thanks,
Ziran Zhang

