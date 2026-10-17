Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22C838F638;
	Sat, 17 Oct 2026 02:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792205049; cv=none; b=jCoEAoUsB8TdKL63DVAsXB/cV0NPRSWh/j3Nc3lcHe/LAtjDTDcaxnX6UOCoPr6lrTuDPQpSGum9BzEwJ2sNNzidBWY0KPDwoTWjt9YIgfEXJdGqAiM8b+bnfLjQNflg+ntSUSkpKXo0tZT3CmCkflw/AvC8ZFgzvT214TU/jEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792205049; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dmcOv/pfpmVDwcclEcNH6dV7UUCwBYa8dSvfQkr289AwchVyOtaEt2BPGeYR+zqcq0liFhTQ9YHXTYOnrDiLOiZl1Lnv0PJfIu11aZBchi9k2PxjuCC0KOEEn3kTlL3p0fry5sq5z19TQa+6yF1E8r/xoc769q8JGnCxPaG9StM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChOK26dj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChOK26dj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA13A1F000C4;
	Sat, 17 Oct 2026 02:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792205048;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ChOK26djig4Q0Q0DI/I+HvFMPLDC/yrGIHRtLZlJJ9bLBGLAPUOJVibDVx3XA8D5x
	 6096JeuBVEHi4iHVHtPHBnHs233lDbPyWyVxV64c3IhNHdmlvaiADiSr8HK262LTmZ
	 oCqbDBu8n0XVC+/InXdyJK6vHokRqR6f2ozUi3gSoeGghvzGMj2dAJewZJoFOdXWdR
	 OUvu8Ohfw+lhmPayVQVlUNUfdWPxWpumpGv22+7NQlHcrUm7iTySNv3kLikf8LRDXD
	 upg4cLA000TY22S8iz4lQGEKSrSRSErk6zhelMIXI6SIpzn1w/sAvHnPKPT+o0v4x3
	 /8itmLCoB080A==
From: netdev-bot+sinfo@kernel.org
To: Binbin Deng <18983559317@163.com>
Cc: sam@mendozajonas.com, fercerpav@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 gwshan@linux.vnet.ibm.com, joel@jms.id.au, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] net/ncsi: fix use-after-free of ncsi_channel in
 ncsi_remove_channel()
Date: Sat, 17 Oct 2026 02:44:07 +0000
Message-ID: <179220504720.408196.6207154519517701545@kernel.org>
In-Reply-To: <20261017023934.419611-1-18983559317@163.com>
References: <20261017023934.419611-1-18983559317@163.com>
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
