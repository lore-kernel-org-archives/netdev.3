Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5362502573;
	Wed, 30 Sep 2026 14:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777689; cv=none; b=XLFLiIoIL5OrglBdgIgQbC1L4xFKR2qjrrkfHWDXH9UqNtcW6S1UclZ5O5h9fgUFxbrWbORJilcuFWRM6XUHoBa4SX+nW9KwKgW6M1upFkYDWOF+ZFQei59W2Hk1/haDCTur6quYC+pzVTJPB712lVopJcNq2iJR4ae37x+iTuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777689; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XWlkSADdZpTAUhVNuP38LiNgeG9VvqTyeCLZz3vjXSGsuZnva+AzQRo4B3l8qfCJgTUVC6bJkF/1FWB60gOCzkdUuXiA5jEoeQOc4BiLlvGJzi27otSL61GreZ54II24MOk38BhTRPojuk7Dzk9GeL9bsk2OymvgRtKLq1Yn3vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vsbn7AtC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vsbn7AtC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526F61F00899;
	Wed, 30 Sep 2026 14:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790777666;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vsbn7AtCsCT+EhL6r2RIPB6fPFC9PrRSTYHpKRHDsgelkzkxkL6/pwVwJgNB6VAA/
	 sfswnZD32W6jBaCOAP0uE36EZMhnk+rMYhsDRol9Y60AC7QZbPQpl5ZoSYyO8AR0iI
	 wYNvGDQ8QYWrAVW/3WuLekfpokk8L0CjZh46uiEy6Pv9brQbVueiYKUHl0bnGW/QwQ
	 AH+4eZpnYzXKEg4LyBSQesXXiX1xRpCF75SCgXGfbJ0T028P4lzEXIt3CcMRyGi/dn
	 ffSNoO3sBcV7g5MWw709O/gzk7uQiBqOyinGoUkbLmssLIIOX4o35/YzwXXWU44ijw
	 NDzciLTYwdNCQ==
From: netdev-bot+sinfo@kernel.org
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dsa: motorcomm: Fix register rollback in
 LED setup
Date: Wed, 30 Sep 2026 14:14:25 +0000
Message-ID: <179077766581.31693.7541948300673794721@kernel.org>
In-Reply-To: <20260930141151.3973221-1-mmyangfl@gmail.com>
References: <20260930141151.3973221-1-mmyangfl@gmail.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
