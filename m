Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA3D4F0527;
	Mon, 19 Oct 2026 13:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416320; cv=none; b=YcGs7//hVAvoOMFQK5C7C5qJ13HWpf2XUTo/UwF+7jntd4Crzwtqh5kWqaFvaSLgVOodK104XvSVV7CKhXYBc3rwcQ1IzPvYpW2+8V8H0dT4GeakTW5DD+HFN4HrH6hFBo+jf/UINTKBL1CU/jyFlJz2ygpdpgbNcpciUuoXHGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416320; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lx+hwsPD6Fbc4KqDh8SJrdafNFtIWGUgVmqbBX+YBXVKOsvNk1aJfBreSg2pvqnSPfmE+wkLqfCGFZ9HgHdXBhBupKHGxQ/xY5Ln6hh6oa9SM/jdZ49nAKMsVilEh28tKH0UaBLa3Y9KjFaWSG2qJVdJxc9lYVwoemG1FZp4ye0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+QhBJmw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+QhBJmw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650B21F000C4;
	Mon, 19 Oct 2026 13:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792416319;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W+QhBJmw7wJCiqyzBNAHpepvNLtMo1bc2rYrlIPMgnYb7oiI2LKWXj2zVfIR4i7mt
	 741yfQOld4xExZpg/Lxg+K1SGoF5JzWSIWXV5yGE2ti4918DO6bzJ2lSSvz59IjvpT
	 5HMqgi2EXNjVjjlm6kgvb3Mmbm5q7itlJT8q4XLHWXdpTIxNNM+Si1IkCVLo4wyrcr
	 +mMvBHX4b7iKWWLKKEcCq5db8GTZ5BgiM6V5PbEl+0Vet8fy2WmfjXFjDkHCT4tFq8
	 RAKatShd1y5bHwguqm50EaLoOHgKWaiSWN8M99D0h2d3o4Nh9E9bBPMvd8YJ1svYBx
	 FSmEY7h5IQ87w==
From: netdev-bot+sinfo@kernel.org
To: Haoran Wang <haoranwangsec@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH] ipv6: icmp: use skb_dst_dev_net_rcu() for echo reply and unreach
Date: Mon, 19 Oct 2026 13:25:18 +0000
Message-ID: <179241631899.3290.12435413086500350464@kernel.org>
In-Reply-To: <179241613335.5916.18191480036849517944@whr>
References: <179241613335.5916.18191480036849517944@whr>
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
