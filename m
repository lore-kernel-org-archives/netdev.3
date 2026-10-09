Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096B044F54F;
	Fri,  9 Oct 2026 13:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791552281; cv=none; b=KlqwJkaogopoYvfvZSQZSqRhcwepZLyELJWZxBiPDOHabqMIk+RmcA6V7qRqV9U6qlBTPPZZczTmtuP1H48pCXky9CbwAZhDHO42Yyfbx0+xmkRAWXVAXl71e4HMAw7H9VBh0blNF4fUYOM6/DaYY09zRUkvMkZladZpCMBjt4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791552281; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jovjSgyCAueTXxYDBn+v/VI+qwhLtiJWHN32nX7oYaXk8oKxJ6gVeEei9id6QnygCAl6ItmRDjAt3RnVlPGXRFEbyz9hrHeP2+zIqpqnsrIKPOLqcFXTwC6Exmmnraf8cpI5NCzgpefmToMinarapHs7qtCAwB2ddzBZOcJEuis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5YLpTb6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5YLpTb6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF311F000FF;
	Fri,  9 Oct 2026 13:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791552279;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z5YLpTb60iVKZiykt/V9WxkYLME/y6lm7c3uzqkR1FrIp88ZnPtIY/JVkpRVfloj2
	 fXKX7YZMdtcYQ8wfWBCQnDdAtUEEw1s6Q+PDGp9lzO+/fp3KUbxdjFFZLljRObY4BB
	 wv1Ad++kN3wh5FcVUwRmCoRzRpgxOJaSRNF+/bHCx/2XIqiMGbiI4lF+/DWFWXqbb2
	 N9G2koGSOKsDNnJkYqeV9eOH5hjELLV/iBxzZRItUxtH2SXc0eT5A18Xv7yUwH7rbv
	 mKq03ZEZtE/pIsR8yGKmxyZKVaahp8xyPAVUqJfmphsOOos/2f8Rqy5dWkSpTmdW9l
	 wEvRCkqLCrLlg==
From: netdev-bot+sinfo@kernel.org
To: Binbin Deng <18983559317@163.com>
Cc: sam@mendozajonas.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net v1] ncsi: Fix use-after-free in the device unregister path
Date: Fri, 09 Oct 2026 13:24:38 +0000
Message-ID: <179155227874.2527009.10651244740405714994@kernel.org>
In-Reply-To: <20261009132021.39611-1-18983559317@163.com>
References: <20261009132021.39611-1-18983559317@163.com>
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
