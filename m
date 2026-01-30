Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9597A35BDBC
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 23:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769815967; cv=none; b=bWengrsd1sAsgO2KmpJOnibDjdlDyoMDaJ5n9bCh30VuWNWiA8BsSwT+x6REOADmPT7r/lEGTzEZKTPSQ0NZ2AAsRmQahzf3t9cmljPsNv3/d3AuTVeft8PxovUSY1aZrp9k/cjABcwv3MxKZUUCyjWquK23xqWm8Ianwsf49Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769815967; c=relaxed/simple;
	bh=/SEyYHvH7iWqiKUat+/itCX98zZr2kBJvICdFWwX4xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=An+qV1zDzE/AVZ6F7rlU2nLLaN4eu+2W169l//SwpGpW2yASOHf36vbqwjvCkOkzYtqzvwLT4gW3Zrz1P8o+KuCzOevBrhfRg4yQ3cVQri+jOjAjhrb3lpd0Dhlm3b0Fn8jjOvKMX22gqMj3FB1kRnhIlsPrcq0MSgTYALUO/WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWVCq1T7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWVCq1T7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77286C16AAE;
	Fri, 30 Jan 2026 23:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769815967;
	bh=/SEyYHvH7iWqiKUat+/itCX98zZr2kBJvICdFWwX4xM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bWVCq1T7ceJUcT0glVeMPF1aBB4nBn8MhjujLO03jHjbDoQuOkvE2dRzzMXOPaIK0
	 pFoRsGyxp7baUfT4yUxaG2hJY9/n90m5RWz9sQCa1PtWEeNxiIgVPa9LEiLNHYVJw2
	 thdPFOrsBawCmM4Cxq+15b4TZYapxAly45htW7w5Ol6+MoUrKmJE6iexX0phcTaz7a
	 D2UcH1LOV5U74qqyqlmmYWUcGOnj3qsBr8hdQtmljINNB6oLafyTHiXn16MSQwNpPL
	 sAxThANMl/rIUfucVDucFjom6pueaWtRSLlr1DDQkjZrb/Npa3VPUS1OnqPTMtiU7l
	 k/s5EQ6Nzxc0w==
From: Jakub Kicinski <kuba@kernel.org>
To: xuanzhuo@linux.alibaba.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	lorenzo@kernel.org,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	dust.li@linux.alibaba.com,
	edumazet@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	lulie@linux.alibaba.com,
	andrew@lunn.ch,
	netdev@vger.kernel.org,
	guwen@linux.alibaba.com,
	dong100@mucse.com,
	lukas.bulwahn@redhat.com,
	vadim.fedorenko@linux.dev,
	enelsonmoore@gmail.com
Subject: Re: [net-next,v24,6/6] eea: introduce callback for ndo_get_stats64
Date: Fri, 30 Jan 2026 15:32:45 -0800
Message-ID: <20260130233245.923444-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130093412.98407-7-xuanzhuo@linux.alibaba.com>
References: <20260130093412.98407-7-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
eea: introduce callback for ndo_get_stats64

This commit adds ndo_get_stats64 support to the Alibaba Elastic Ethernet
Adapter driver and introduces a spinlock to protect concurrent access to
rx and tx pointers when gathering statistics.

The commit message says "Add basic driver framework for the Alibaba
Elastic Ethernet Adapter(EEA)." But shouldn't this say it's adding stats
support to an existing framework rather than adding the basic framework
itself? The other commits in the series appear to have already introduced
the framework.

This commit introduces a spinlock to protect against races between
eea_stats() and the queue setup/teardown functions. The race being fixed
was introduced in commit cf49df362e30 ("eea: create/destroy rx,tx queues
for netdevice open and stop"). Should this commit include a Fixes: tag?

Fixes: cf49df362e30 ("eea: create/destroy rx,tx queues for netdevice open and stop")
