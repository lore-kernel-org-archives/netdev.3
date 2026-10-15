Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB54943A80A
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 20:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792095267; cv=none; b=t8lNGeH0r7VsJ4c0s2O8lKXMp4+xBi7Hp47fqbTSMP4DMfMBxvnreon4XAmP9sr9cjOur7XQo9UWdZTpVV+kLhmnfE6kcp3MsFZjUUj92b52Fudd1VmcjwzdvSCBtl/MJcxbkA+ONTbG3bfp/Uw99RtKi84Vk35AWB/r5VqNNgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792095267; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EHWfN+JEgtTv9g9BWP3N4nd8zQgRLP+QLct9QA1+0Xp+RMk2H6EQsx/bHwAoZwJu+Efnwb2x97gPmQaaNcjV83LxDu1968nlJ1A8r5taowHB9W6BPomsHGa3Vo0SIwY9kbu1+sdsKRF/G7lyGbi5v6FgCRDZoOUZNI9il1wz6+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hlm8Jp39; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hlm8Jp39"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159C61F000C4;
	Thu, 15 Oct 2026 20:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792095266;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hlm8Jp39R0qToBg3RysasZDwvcgRhX7E+BX5SizIcl7m3zdil5bWDSlo2pXdIF7cd
	 8vzRBpQhE55cpSUo46808hY3OMgVgO7n2rewQ7vusvpGUC9sVVV6g4Gg8vQLRXbYyu
	 FyHiymkK+tmWgwFEnRuu0YHME78FDbtjez6HNJUm8xCEx/5eJkA2fNBB8Dkr3v7d0U
	 /HHHHxwzqQ01Gcc3gdZKOnqibI6luTO9Ng6vYphvdzaC/HAFYevMKOYeIM9ho96eve
	 IFuqxoB8Lk1pNaImWsRkulXhTPT0l5AlJoNjpb5WFbosZ4eA65eXWS1NE3ldtNsyA0
	 iuSwe0R9FK3ZA==
From: netdev-bot+sinfo@kernel.org
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH net 0/2] tls: device: fix users of copied_seq after the
 strparser rework
Date: Thu, 15 Oct 2026 20:14:25 +0000
Message-ID: <179209526555.408196.10402909579775011337@kernel.org>
In-Reply-To: <20261015201135.2744031-1-rjethwani@purestorage.com>
References: <20261015201135.2744031-1-rjethwani@purestorage.com>
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
