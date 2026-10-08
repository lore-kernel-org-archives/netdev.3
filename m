Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E82131716D;
	Thu,  8 Oct 2026 06:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791441373; cv=none; b=DY+k51JB96TR9dVNSu4syfyEzexDRUCv20WcgBzBnwSOeFLQNd7VFuuq9nMZaZaC5hlKzmhrivhSd4uXvoIn6blUxuXbW4+LifYQIeGs88rR+V/+MND55odvHULQtbxFnlkGnxVblQ3TCMZIuDlxapm8gIyN8DBI/DR6/ONSHTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791441373; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oYpgElAxylG29LGWqwEjr43D0PUZ65RjrGW2QGh3Jm8ZanA4i7URm1s+E0eQ49Nh81PRITk0FTqAvXyfVen6LWajavQkucH0GUym9JKnSR/JG0w/zEgpIsw+75q2veBhXoKDyVi+f/PYlDXE4jRrVllDl6w/Defkyr5tbXYtYO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eum2dbpZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eum2dbpZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C95A1F000FF;
	Thu,  8 Oct 2026 06:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791441371;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eum2dbpZhpcMtwT+YcnmGZreNLg1DS7lS7pL9VO4K0jKmmcQFJWRZ/XluRuaSg1zt
	 b2nasbB2xz9bj2C8ujTl0eEY8w7xn5cLhNkYU21T3boaOXGU/gDEe07CK/cFheTjs5
	 pMKhna0ZY4OU56sZveFKb4zXJO8jHLMWSs+8fWUBcsfzWVBuFRt864a/hvUkcKNGBD
	 HQL3VC9ROYHHZWcfbD6MiuHVs2WCywD964dbEV/moivTdfJTGvbqWetwB8lzNRmOIe
	 anQVj4N9XeqrpzPshkOhbQ4hLiqpkZeTjn362+QGG4edqSW2yEmQ7VisVwMVWQ2oUU
	 xUXUuyKhb1CGg==
From: netdev-bot+sinfo@kernel.org
To: Cen Zhang <zzzccc427@gmail.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
 jjzuming@gmail.com
Subject: Re: [PATCH] ipv6: Protect the cork MTU read with RCU
Date: Thu, 08 Oct 2026 06:36:10 +0000
Message-ID: <179144137085.2527009.14623414863708511631@kernel.org>
In-Reply-To: 
 <pm-ip-core-objects-candidate-0007-v2-46f5bb8aa2cc9824a047@gmail.com>
References: 
 <pm-ip-core-objects-candidate-0007-v2-46f5bb8aa2cc9824a047@gmail.com>
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
