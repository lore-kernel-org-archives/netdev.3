Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B33149E5CB;
	Thu,  1 Oct 2026 07:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790839758; cv=none; b=hk3OSZ5br6ot3afBHMaLhvhLLTTswtnL6LvlzRDuAjTj8GYduwk1vZhjpGdjUy8xGPvs77ChTOcXlcUif7TOlu1puvbGRTm67SNCPGvVMkSxFGADVHbxau5Hb/uAR0N1uGuC/ein7+5A5EJNq3+yCP53QabX62OTIYUaPkXXFuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790839758; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EwfmuwLvNZSagp9Z+W5q3InV1bf2hPkSOZdvfPg4+1HPmztHzpxaCk59vTrN574lgcWCp6HP+N+URHXaKqTi+4KqX/4Bny0e22D8/XJdbKsVpWHgYFXunhyuDr5Ry+flywPPIQMB4snI4F3UOe7F0fXxlOTfpHAQY5UOwJNxwM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQqBkR2p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQqBkR2p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC221F000FF;
	Thu,  1 Oct 2026 07:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790839752;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fQqBkR2pCOD/x2PSRbDxhbmBi3omvZ8f0rRRVleNkfMEste2ygPR9Mb99EgkxIahJ
	 gAMUIed3JYPPRgePNoiukYo4qBYU5ZX13tX/ZKnmbqt2FrImc3Yccb/+QORngnovT9
	 Sr+uVh3qbmPXakU3eukr3mXNGXonhBHtZp127+kLirGxoAUfTt+OrmxWH23iRKNLXM
	 OnMnD0YMO6tYiXt0TgG6Hl1wXUDCtSNs+Ejk3JtndQ6PLkkAjJ7+CrAq/sNnsqp9nk
	 gkXAUNEQs6IaN/mqB07mlySAzrDpdmhh+//gTIq8BjuspIdBlW4iIJB1g3AAma/Th2
	 SAmpDEXwJThgQ==
From: netdev-bot+sinfo@kernel.org
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phylink: allow stopping a suspended instance
Date: Thu, 01 Oct 2026 07:29:11 +0000
Message-ID: <179083975139.31693.3996104334258103624@kernel.org>
In-Reply-To: 
 <20261001-submit-phylink-suspended-stop-v1-v1-1-0669fdb4a93b@gmail.com>
References: 
 <20261001-submit-phylink-suspended-stop-v1-v1-1-0669fdb4a93b@gmail.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
