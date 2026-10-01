Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79FA2DE702;
	Thu,  1 Oct 2026 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790871904; cv=none; b=H6IMbKr3Vzj8HcNZ2FRzDzV9QVWP/3aVl1jH9K/C12ARorna61lpDoQisf1m5UctecPrzpILgi16P9xCF2d9Nq9KkiLjaoNdLgcR6UibjAE4Y/gr+Of8MURN6WQq2IhehBO6h58Lb2p2rovs6OAjd7xmMVrKakrtXyzGZKGKh3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790871904; c=relaxed/simple;
	bh=jNhFF1FFcdZQRcc7LMRUzfc/AU7mnjlXteBOBViWAo8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YcmGoUGH4JA/44uC2C4q2M9qB1ClfMm2gWfDtK7PJxFSbjLc+Eb8tMlcVL0iRvEe0dq6+2haaUjy3l2aKq5lb2hJ/KR0DgvmQhjSwcKJ4r0iP7jVaWv+DMMhcWPX089jwbLFunRk/lc1PBbzrheKgJbK3Mqe0e2eRRPm9qSWxNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L585SP/u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L585SP/u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D721F00898;
	Thu,  1 Oct 2026 16:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790871903;
	bh=AMAgKY4S+HX1BzWFw4AFQhIfukrsXa5LQUUUZV4C/hE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=L585SP/uBkp1wQh0SkdKP3OyK5s1DG+3S2S3zJxh9+UnukWOWFlGN4QsX7Ekkh0am
	 WmAXY9/aWGpYWrkp0Gum6ZrFx7LR/7/gcFVq1Eapjmwm6cYwdVCqLig9rpvaieOPJi
	 Mj9r1eKeuDE3GYlZcRfeZbHo8Ep2IOKb1KpNGBib3dbS83uKe+RdC+gYBYSE9B0EAp
	 0DHpfW9JBVjxf0ubFjGmGwvZvYA2YBxQvHdIOqx9JtbZVrH87cKoK2bY7HIUgAJUe6
	 XSynpDbrV2V99c0v0xchc2r8FS/4oOB9SkKSbeKKMnG/RyBMl8s6iMJHkAJrKNx2ME
	 rkn1F+kh/ZdTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A65D3811960;
	Thu,  1 Oct 2026 16:25:03 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.3-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261001131235.98504-1-pabeni@redhat.com>
References: <20261001131235.98504-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261001131235.98504-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.3-rc6
X-PR-Tracked-Commit-Id: e23a64eb244356ee47c0620f0722d51bd88db522
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d24e8ac715de2e16a53c144005b1863660a5fbea
Message-Id: <179087190171.2557118.834529597190153378.pr-tracker-bot@kernel.org>
Date: Thu, 01 Oct 2026 16:25:01 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  1 Oct 2026 15:12:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.3-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d24e8ac715de2e16a53c144005b1863660a5fbea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
