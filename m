Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98223383C6F;
	Sat,  9 May 2026 14:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778337130; cv=none; b=KCBsmpnAQ2q5WyqCDLOhvTGrjKeTgJekqSjANnZ7QWOJC7Fqm9UMOHhRRD26095Q5AA9Cxh+2hk8v/IL1tMnOvGyGnTSe4ekQ1Fdjxqre051AiFr1p2O5mWUia5zdlzAmCK75toUe3Qfhuv0AyOfo73PuijDgt+69vhYqW6gUpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778337130; c=relaxed/simple;
	bh=AsdAFh+zjK/la+mCxx5uuCWuAxNmqC/t6b/D1EDzW6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHOkZKXyW/tnK6cE+1xEHWEn+b/2EhzN+L1Tq1zXxH5bmM5nTtZvjdXTxAQcDOCHlPKSoHsiJ2wSPZ3v2B3WFWueZavzOn1rlFMRa+iLnH0Hg1Dxx7wdicoyhdLsgLBFyeHb33AH9EXpJbYaCQjiIFFdrkWuyKKRnCadgfr8M+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fY7WMeZi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fY7WMeZi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CD5C2BCB2;
	Sat,  9 May 2026 14:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778337130;
	bh=AsdAFh+zjK/la+mCxx5uuCWuAxNmqC/t6b/D1EDzW6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fY7WMeZijk5TZYHjFllXPx5ix70TnPkokMux5zTjln8PwXJWBZiC9ggjDBrApKaZr
	 Ymmmdp66UN4c2gniKcNum9KHC3CJzahexffHY6H81X6CSVtLGippoV7k6sZIuF1efe
	 WtEngFc5ezWH3tkUgHOWyU6IxcByvflAUyQIoplFcdlxd0MVqiOeKJV9VRRWhs7uxj
	 6F2KdEcu/pesOSS1g+F4idEFuk0Q8EzmbCZaFS6Qatg08jwgbevSiFL0ZMstGAcehC
	 CVDXfIPcZBg67l/b4YoC02SolOzU9FIDO3Nosv3OINfruZs/96B+7GsYjqeGaRIUV+
	 mDKSvLT3UxRWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Dipendra Khadka <kdipendra88@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Sunil Goutham <sgoutham@marvell.com>,
	Robert Garcia <rob_garcia@163.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Naveen Mamindlapalli <naveenm@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Suman Ghosh <sumang@marvell.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.15.y] octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_flows.c
Date: Sat,  9 May 2026 10:32:02 -0400
Message-ID: <20260509143000.stable-reply-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509055846.1893377-1-rob_garcia@163.com>
References: <20260509055846.1893377-1-rob_garcia@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit 5d55ed19d4190d2c210ac05ac7a53f800a8c6fe5 ]

Heads up: the cited SHA points at an unrelated drm/amdgpu commit. The
correct upstream for this backport is bd3110bc102a ("octeontx2-pf:
handle otx2_mbox_get_rsp errors in otx2_flows.c"). I fixed up the tag
locally before applying.

Queued for 5.15.y, thanks.

--
Thanks,
Sasha
