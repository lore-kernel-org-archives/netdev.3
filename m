Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A40951B196;
	Tue, 29 Sep 2026 12:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685288; cv=none; b=VdPmU+NpSHQC7THGQgCe+QPXb427GRzGM4Dfel8ml+MLiGNeAOiNIQk9KJxH87rrph+DtLCrXdYF9rd5nTvWLeSXkRyJCztFzSoZV38r49HknQWxm9jsp5FfK4iH/wL/Kq8eV0VQlhziuY0AyK3s3MvRiEUqdOdn5mulDyrmTg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685288; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lt41C0CukNbDx1RrdXv94pdsAshEFeMvAaJE3HrxzVpYgiceZcpdqf930L1ANq3CnlMBrWTD+6BRCmNgBDBE+ePzdXilQ4t6l1HoJu0KCDW6J99WYuWsEVDCSnALU2oj8g/McMPKzaS28PLWvykSRzi2KeWn5o3Jwm/taWvp1UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AS9Y8cUU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AS9Y8cUU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484EF1F000FF;
	Tue, 29 Sep 2026 12:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790685287;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AS9Y8cUU0K5Vh3g/tb3oX7MTDqTBy8lWildZ5ulIRgrK2uzt4t6slaWogKoZ1nEBR
	 A56brpG1ZCYZVk03EJ1BAI9hdQT02YVbgEcZ2ZR0UFf1dCb/odq65Ws+RYPt9RrhsY
	 2LuzKrqBVgUgXYauj3sKhHeidLeF0+7lxpMOBpqK+XOLwDJXqFe0JghYMYDOtxv9EZ
	 +g6U+pUtG9jnGAzhnQ8vzqf9QMsI3Lnd9yAe3zRMNute42N50/2ldxOEIMzL0Rcmj1
	 +bnFPw/RsWzkCQLrAmtT3vcvMNSDrSfmvArrgjiRVf9sRvy449hIhcB9yq/RH4Ppz0
	 aKK8fa//OY/OQ==
From: netdev-bot+sinfo@kernel.org
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: Disable checksum insertion for XDP frame TX
Date: Tue, 29 Sep 2026 12:34:45 +0000
Message-ID: <179068528574.31693.11994088057366518251@kernel.org>
In-Reply-To: <20260929121025.20821-1-jszhang@kernel.org>
References: <20260929121025.20821-1-jszhang@kernel.org>
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
