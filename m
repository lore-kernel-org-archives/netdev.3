Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1E73AB26E;
	Mon, 20 Apr 2026 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691286; cv=none; b=Y/5F4OGAn5Z1hM7cYbREwh2JNsCCXdI96CUPN+qLX5fKqHWfD82hUF0n4q+gcTXcCZaH1R/xUSjE9+mFEtxmDsDRJvNLZg5vHZY4ZpmhO4VGeWF2xM851sf5Ol95NlIjB2kqI3GXu7QhsUMb1Fi09Kl4KCDyGjQJ5TUAgcg6uQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691286; c=relaxed/simple;
	bh=DtaC9BBV2mp7K+i9tmB1F+t3t/28nMoUYoKHx1gzvVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCYz9WsxXCoi3nfvEqwY1ybDN26hQwbMjWXkOp6YKRWmKTVD6d5pEq8bfs0o/cuYqsijM/Ch3min7qnE18MW/KWzGlefVJwouCd74ONekwLqwC1IIL2QNHcZszhAG8YEyr8eZtfZSYOe7ZZw1S9ySL90eVjABB11YLR+Vqfps9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXWwGDws; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXWwGDws"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC881C19425;
	Mon, 20 Apr 2026 13:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691286;
	bh=DtaC9BBV2mp7K+i9tmB1F+t3t/28nMoUYoKHx1gzvVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aXWwGDws9FGBIM0pev0J+EvLpF2Cf5/DpYq1ITR/dU61DebMq8pnBrcgT9risoSE1
	 yEUP8iADMS4aW+XUd1e+T46JffkKdcFNpCJAhYNxzRUB+mnKqOZxwKAszjYmGYfcaD
	 738OChq17okKIC0tqgk6U8Fg6R/jX3AEcdfBHDoO/s1OsiPrdgp0Yx3paL8XwA5QFw
	 Hm+MVbGMTHIgUwWEFCCXg+mEXLpiRbuycSOr2E5VCSMHu4w+sKC6GIWPvXZ5OHGy/1
	 HgTXSHynFQW+G1pEIe5+9j6aiNr/OumjmNNIDLGKzBZ64ZClYO6N/sdk8YqaOCm3Y0
	 rQM43Q9xJG7SQ==
From: Sasha Levin <sashal@kernel.org>
To: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH 6.12.y/6.6.y/6.1.y] net: sched: fix TCF_LAYER_TRANSPORT handling in tcf_get_base_ptr()
Date: Mon, 20 Apr 2026 09:21:07 -0400
Message-ID: <20260420-stable-reply-net-sched-tcf-layer@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415214348.850171-1-chelsyratnawat2001@gmail.com>
References: <20260415214348.850171-1-chelsyratnawat2001@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Apr 15, 2026, Chelsy Ratnawat wrote:
> Backport of 4fe5a00ec707 ("net: sched: fix TCF_LAYER_TRANSPORT
> handling in tcf_get_base_ptr()") to 6.12.y/6.6.y/6.1.y.

Queued for 6.12, 6.6, and 6.1, thanks.

--
Thanks,
Sasha
