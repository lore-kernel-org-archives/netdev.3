Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8F62F7445;
	Sun,  4 Oct 2026 12:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791115718; cv=none; b=qoEoW+QSsOoZ2Wb8JDzcpIlh40Ct1DSRe1fc0YU+MSumNKFMQ5cCggncFCbQggjL8TnAJVnsQLoIESICjARKorW5KXMZ8njgPIyN14SdEf/ugWH9L8YKFM2Dz39vcoA7XgZ/srN76RvoFX4jQRDNTH1/MXJE5gn12Fyv8PCY4oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791115718; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FVoFYwoZk0a0xyP91aGx5gFyEPEcEaSyA+6MvVjGWSAKnknNyfxa5z2mqHMzLDvA2mUWhAB8J/ErpCFG5IOhIA3JksTbu1SdhIYa6CZFbgKtT5rdhfvPZe6zbD05AzN1Tu5u4Eb7PYlgeevakj6rTcZKypt3LCUCX3yuLqFGKvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZutm8nj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZutm8nj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE9F1F000FF;
	Sun,  4 Oct 2026 12:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791115717;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NZutm8njI2v7VK97N07h9qgy6qxGWip/seTajVlknDy/BU9gYfcU7gmqE1Kqh4wJm
	 xtQxupntjNEcw45lswEWMoouzK7ejY3tvI5ggyLbn5GjfgRVwde6L+IaoudsZo7RTN
	 Yn1scpQiLTS2BIWuH1qE04RuDuJ+/AAlEw0y/ie1FJc8AaTHWdncvVs3gcb3CddXUo
	 Q90g6UXVH6WwD8oPf/mR/oOkZ2ogR+TR2fl//PrAnbgLRd9VzcT+nf5DOxwT2SaOuG
	 3AtPvNWx+/+avJLf4/1fzzo10l4tINCJYV5VurRwcIySeH3PFm+FilezYAy8minmz+
	 vnqtBmXuZm/iQ==
From: netdev-bot+sinfo@kernel.org
To: Zxyan Zhu <zxyan0222@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, richardcochran@gmail.com,
 maxime.chevallier@bootlin.com, muhammad.nazim.amirul.nazle.asmade@altera.com,
 rohan.g.thomas@altera.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 0/3] net: stmmac: dwxgmac2: timestamp
 interrupt support + Agilex5 fix
Date: Sun, 04 Oct 2026 12:08:36 +0000
Message-ID: <179111571610.1402591.377888819234151971@kernel.org>
In-Reply-To: <20261004120526.2728564-1-zxyan0222@gmail.com>
References: <20261004120526.2728564-1-zxyan0222@gmail.com>
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

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

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
