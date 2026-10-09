Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF632737F9;
	Fri,  9 Oct 2026 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791544475; cv=none; b=TFT6pjlflZvo5rpoj4yH5ep3mgBwq6+L2tWzoPbNGBZW0W1f4J3WslGcX8CNSqx66T2/57279Es6vZR4L9YtQIozEPgYg31eBFbjGd7wZF94f4ffzqahU5WuMt97XBDM73X0XfbNNlvsvtDBIOUCX5HySORflpI8SAOaysYbG2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791544475; c=relaxed/simple;
	bh=Frc+ADQTxRwKDWaoqMQMlUJQ/gCXB8qyIs31/48aD70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NruNG9V44DgcCVRBivbQVAAeLrOXoeVkeM+KR2c3ypCH+9IwQ9kpzljl67km/6HYCclPGa52RYhRCsEOgL/r/WeKsjwFaCvNnEWzhqT7VjObF+yVJ0o7SnFm5zdZ8ubwjwJKy46DrEtbMp+QjFnhBbU0R7iE3qybq22ek0CELcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRNfl91K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRNfl91K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4511F00893;
	Fri,  9 Oct 2026 11:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791544467;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NRNfl91KP3x0gvus4SvFnEd1BAZgncEGXyBgEhgAdIcbNK9EH7qMNidPymnK5XrpO
	 u54YHX7ZFRq2zYQDE66bNudyKlwzcVT1twu2/Sl2QqneKx75DSmcSLQen2xzLHmwtG
	 /gHSB7glWHz+A3+oyQmW3jvouKY54Sgj4Brs+95fqNUl5E5aGubgADV/sK0Csyzqk4
	 HLLDWgUDADRkaPTkMyPnhVLPE+ySLdKPhvj/cqY+3rSCfa2CdSxbXjETTiPicGzJFS
	 9XZG2rtdn2uCYz523wm8fzXnKyQIoVKCm68rqEvo70+EtZyMrSPa6lg5oXkM3eG4AB
	 1oblLS1h3qO7w==
From: netdev-bot+sinfo@kernel.org
To: Pengfei Zhang <zhangfeionline@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>, zhangpengfei16@xiaomi.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: fix RX coalesce frames counter
Date: Fri, 09 Oct 2026 11:14:26 +0000
Message-ID: <179154446637.2527009.3819979695606095666@kernel.org>
In-Reply-To: <20261009111138.320089-1-zhangfeionline@gmail.com>
References: <20261009111138.320089-1-zhangfeionline@gmail.com>
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
