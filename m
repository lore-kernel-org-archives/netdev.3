Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70A336DA0D;
	Thu,  1 Oct 2026 04:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790830745; cv=none; b=RdtIw+WI8D22+OIq3VoorX5THN75kiIHCj1dQN82rwc2oH2EufOPIzW1luQ51ZkRhxDpgvWr+d6RqdHHOyAUe1xXOyP0dsh/cKjwUO3aA9vPUaICoMvvj2d92DaCHt1aeDB7tNYwflQQwIOhZic3sewSDOVvpVQ7yIjpLvPCBW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790830745; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tg+DDUNl+cF73JvEy0I1dkFcQ0/Q5RKwZbZWdMFRyiFtfM68EctZguWKSbG1orF4HFsetCyD9PqYNOV5H806lv2nIsSxwpKp4s67f8JpyvTtJaL78+HKM352kzVEIEyYg+UJictKi3dRFi1dKhaMfy0TEV9NogFMhsfJas7WxEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzTwqSji; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzTwqSji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A9D1F000FF;
	Thu,  1 Oct 2026 04:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790830744;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EzTwqSji3ot+XrUWfJ/UxMnJYTJo8eYKk5SD/NQnoybXyFvDMjaeqyWZ4m9pwtmg7
	 QIX7KToA8P8hHgpeIzzwRNHwINfC9l4Cidpt1Hi7zCfHJwkT4hSi9ZSWxvUVXdZXyp
	 n4F9+0IeMzcDFJ9FM5+HJDEi/oWkkwvdvLYhbKq3NH2Msf/qNMzGugMAr334OJz+ui
	 tRaQtMBGQz1biqN9kzF+eYMsq0YZ0DkqgwkzCKt6NhOdtlLEdiwKNAyA36wYeCsvPN
	 f9gYuzSDLaRnLGLVNnvgs9lLMN3akstmKt6bF0B+ItLfo/iS8XOFaHQvJSXc87mcFa
	 8DEnjlIP1AjZA==
From: netdev-bot+sinfo@kernel.org
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net] net: stmmac: take ownership of saved RX state at poll entry
Date: Thu, 01 Oct 2026 04:59:03 +0000
Message-ID: <179083074323.31693.13810000342248985832@kernel.org>
In-Reply-To: <20260930-stmmac-rx-state-v1-1-c286c43813c1@gmail.com>
References: <20260930-stmmac-rx-state-v1-1-c286c43813c1@gmail.com>
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
