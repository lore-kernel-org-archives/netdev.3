Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202333;
	b=qmwBs7ljI7aEVbw4SL20wtyGgx7gcwrdR7ruMMAyT6Stn6eGeXXe1CJHO9C5fmYhPCw2
	 x6QgKYV7xPqru9JM0QhcNHHlgEdHZ8A/MdJ/2OoQhZwbcSkKA7kqP3w0c4afiglbF9BEq
	 M631Z67MZLNMkXj6RlDpEgUlZWmtp5ubrDRD64YKQTJmp4ynwr3OLvxhc6dZN+BtZGKsU
	 DUdccr4tWK8XX/Q3t0IsLJcaMQWBiNzpHjHX3krRqWRaJjgcJzvGlQe5raGitxkYkukII
	 aFlku/Yn3e8fuR2GACJJqLxSYYolBZakquKkiG0/XfhMpPM3Z5hY8nbBp4yGui5I3Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202333;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=PtGkhC9S2RHHMUbx5O5RbAyWJWry3iPzZBG9iG5gv2qRyqTqA7Zmr+i4N/iP/23OtXhl
	 3/vJBDXq01M9dXr2gJvrKoM4rdag72DN3jfV2Zv+sji38qL8sdPJmghM6TJeMgKGR7WBs
	 WjZIaIcEfiR5AOVzlev03yzUVyIMPGqDGClrAnRyVJpVufo2YU4DtTSFSArSbYG9WrdJE
	 oM9MDrTKIBIZVffCpyX3WOIue4hT7Hc0VCKANP8FJ4MreHgpt2UCxxJHutvXV0MnWaJa6
	 L7dzsh36xhXro5gDj6LfFub1HZxGOD21IMX27DEMpr3PZF74+P/Wb/ofFE1xBD8Qe3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NYL7Eb8s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA4160A5BCA
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NYL7Eb8s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A88961F01828;
	Wed, 28 Oct 2026 15:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793202333;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NYL7Eb8shob92X50j9n5hBWDDfgx3KgaUM+hSonTJV2Isamss0v1N9SK3paeHGxfr
	 q3fEhrsursFyLZCA4qQtU0VW+6Va3AXiyDamLTp8qpeAeCdTavUC3LB5bDoqbcKPDl
	 KCkxYy5vqM1IolZCA3UxORw8+RCriie0oSqCD7C+bkbxrhQwjUUbXGmyqS6vBIZqQN
	 eeWaUi44LhJ1xIXBTmUXLG9/8wy2jAMsLSw33VjFd3AAimIgbUnm8QGW/viWtXH2Ny
	 hqsCgVJGvLguLHcM7bh8PriB7ob3OtvEIoAqIqZNRt1ll/Z86/zNvnOF+8wyN87gFb
	 s3U3jbLOFSDRw==
From: netdev-bot+sinfo@kernel.org
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Neal Cardwell <ncardwell@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Kyle Zeng <kylebot@openai.com>
Subject: Re: [PATCH net] tcp: initialize mapped children before route lookup
Date: Wed, 28 Oct 2026 15:45:32 +0000
Message-ID: <179320233222.3327.8369584186078811720@kernel.org>
In-Reply-To: <20261028154101.2153360-1-edumazet@kernel.org>
References: <20261028154101.2153360-1-edumazet@kernel.org>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
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
