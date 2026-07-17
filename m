Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE0B314B76;
	Fri, 17 Jul 2026 20:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784319468; cv=none; b=q6vl8xR/F1m9cmU9owJcS1SxsK6Ls4r2S93m4s7VT/WnzZU51MkfSU6ZfIjCyU8V1xdVLAsLOxo4XcxpAtPtYqRVqKbM4EPEt8CUghJGELxJ9/LlhUfbdoWZ1867y2KXYfNpuonBeXT5G0HdCCTmDpoI80Xo9TK7EwC2dWnQ9xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784319468; c=relaxed/simple;
	bh=j1BVRejTn3i9RLhtlh7kH1GGzMdbbGAcriybGLUh/kY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YI7NaflBqawkcMlN2ehp0UAliBIJ0i1RZ0oNMdG+3NdrPNI2m2tySZztg8c4KgMBE27xOcBdcG+TV5aeJ21W1tUGCwNX5bL4KvCZKTQoLXgZriHGntLAq2C+n4WMML0ujKKEmvfIaOEBpVBtwLeFZmmVT4ucPqr/7G3+oMrpJag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3+U5hFQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3+U5hFQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954D71F000E9;
	Fri, 17 Jul 2026 20:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784319467;
	bh=1yR+uVMZ5Kx6VZqT6fMQbfN/cTZLQWZ9FTkVuasQObk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=M3+U5hFQMlRDm0F89qJRa/74tkkGW7x/rOqXSgqTLMdoApOFZ3bNIVR83o3OTsnhR
	 uk4hGxJPsa5ZHUVTUYo7WYM8KBSt77U0JMXJxeY6a/TUWlpIeTnMbR9luF6qFsTcJn
	 Rjsmdwb91aphu0J6g5EiO4U6x0INy83Y+Hg29TCSf8Pfe8Ifs20mWL95dZHebuusj0
	 FWfyiGztPQJtqV3pU56PVNnWfWyw7iZOuJdPY+1zRiah2PiwWdrZXsAEyxPzk6tHzo
	 8O49jiSLw6eNA1xAaR9KYuqTKmNv38Ov98gtibmg0dMv+Zlc0WaWPdwPfk5zCVkZgi
	 5z4ialaNaCZpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19914380CFED;
	Fri, 17 Jul 2026 20:17:21 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.2-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260717132610.363857-1-pabeni@redhat.com>
References: <20260717132610.363857-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260717132610.363857-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.2-rc4
X-PR-Tracked-Commit-Id: 56d96fededd61192cd7cc8d2b0f36adfd59036c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e13caf1c26587434f0b768193100440939c0fb91
Message-Id: <178431943968.1854741.8747903421545916136.pr-tracker-bot@kernel.org>
Date: Fri, 17 Jul 2026 20:17:19 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 Jul 2026 15:26:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.2-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e13caf1c26587434f0b768193100440939c0fb91

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
