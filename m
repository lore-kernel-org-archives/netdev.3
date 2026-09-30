Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0D34E80C3;
	Wed, 30 Sep 2026 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790772626; cv=none; b=QkAXGoV6o56CAGW3rdWw7tEOORkHZ9Frlc+BoZiOgdn53UmhJIbZcVWYb7qctArlh00TZczjm1tx36PNYUpdrFiPECza44N8RZX23fI1Wa9PZZcJXf9dYE9jPHnt4KvneETP07Yy/mp1WdaRiMQdPtHnlgokuVK7PYYsJdW6LqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790772626; c=relaxed/simple;
	bh=Frc+ADQTxRwKDWaoqMQMlUJQ/gCXB8qyIs31/48aD70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I7tD4UMQfYAL1QjkJyuO0JqYE1nH07vaJazM5W1z/WuoFB0309cXQS8B5859pjS0CgbaVOKQQu8e1pREI05Akf9IT9lAcaNQb7HizuI985SgkIKoBwhgQKsQBzGrvwdr7DvSftfjn2y6r2mJWw1G+KpHmMLBDc5emNHm0cC4+FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBUI6Vpe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBUI6Vpe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C0D1F000FF;
	Wed, 30 Sep 2026 12:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790772613;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LBUI6Vpe7LkYZp0fRjgobvRt+inliDYtbviJuQv7tMs4DBHGRgDX4wjDbKAbH8xaD
	 rLmQfSnzx1lVfEvjdxfReUO4ocBo7em0HMhqTsJXg1gQsIp5++1EhlEhnQuBjqUJm0
	 sFyak7R8TtHR8c04yRiJZ88DUJ6Z2PdrnqZkc8jYlJGBPe3dWmFdsZw2Qjh0VMCGqP
	 2m1sW+8eMCD3l9h+ODpb0cMfs/V3d9NktYi/9xYu3s1td/NYVtzEErTlI8l7Gtj037
	 EM2e7ctLU497Pvd15yVtp6oe7CKgjh5vbbQWnVIKzDqzeqU7vUHCavwqu+m3pQF2Bd
	 4gqa05D1/4mYg==
From: netdev-bot+sinfo@kernel.org
To: Meghana Malladi <m-malladi@ti.com>
Cc: elfring@users.sourceforge.net, haokexin@gmail.com,
 vadim.fedorenko@linux.dev, jacob.e.keller@intel.com, pabeni@redhat.com,
 kuba@kernel.org, edumazet@kernel.org, davem@davemloft.net,
 andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com, danishanwar@ti.com
Subject: Re: [PATCH net] net: ti: icssg-prueth: Fix switch mode for offload
 and non-offload cases
Date: Wed, 30 Sep 2026 12:50:12 +0000
Message-ID: <179077261251.31693.1465174699926958543@kernel.org>
In-Reply-To: <20260930124356.3083743-1-m-malladi@ti.com>
References: <20260930124356.3083743-1-m-malladi@ti.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
