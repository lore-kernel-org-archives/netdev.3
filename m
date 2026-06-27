Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07C82DC334;
	Sat, 27 Jun 2026 21:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782595267; cv=none; b=SIZWV4Mz1uE9L+wboFg9errPSUBrf6WFZUTPEWpM/vkg30NBom5HtYlM83nPuHKDYaff0jcE/O1Uasv8Ie6cZW2BzP2KsDut6R+OQZsipXa6sZ7XGPvTuxWCneVBzCHMXHhzV0ZkxMenGH6pZDSydq5Q+pBJLSfhG4eJi3xy6Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782595267; c=relaxed/simple;
	bh=a0XRv66ZKwYN34WisdMWGQz1ku0D/FSqbFEugYyFpHg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WoOU394pkjMuYtexBwPO3/e28TVRuL/eFWnS94cKvRLJ1m9d5TmA10AECFCe4qszn6K+I3ZoixfZJqgPqZOWs+A9cl9/lVSqj/KwKzeTJzOWTi3Ph6vF0+ytWMlXetZ6iPp5m/oXA0l3J+j3VaZM9XCgfz00TlMLvSvvQ7/p0rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pbc/+RNu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pbc/+RNu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C6A1F000E9;
	Sat, 27 Jun 2026 21:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782595266;
	bh=OPcHu+8oNdjc0lF6pPKlxAVPxDNMPVc+ktC36owKY6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Pbc/+RNumMh7R+a9YiwcaCCSnrhFPRDLNEHOlS6nCNpMdUsFMC6CcRXmKh/VpUGCl
	 +yM4A8CLM8shY/LrZq7DAQPGNTeSHozxTRDdeL4S77xp3pNMZmnz673pQrgqM5M0bS
	 1ZF5w5lq35iV6JTUG9H/jusyfjVT9cT6tyNO2vln6nKJ5YyT/50BI1ZZ+BPk42ovbI
	 sdYbRzAznFUvI2q060mZ8/Z7Md0YsUgJ4DaUZ9w3F+OPUoZ1AbFmccNXaoODjziHT6
	 fQF6Sy8eXfUUdE8aP/Eq0cVQQb4rd735zFzZJ2ZVGr6Yft+dibWX5dlNmh9s5U/QLZ
	 zsSd9b+JIV3kQ==
Date: Sat, 27 Jun 2026 14:21:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, leitao@debian.org, sashal@kernel.org,
 bigeasy@linutronix.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: Re: [RFC PATCH net-next] netpoll: hold RCU while walking napi_list
Message-ID: <20260627142105.29f1322c@kernel.org>
In-Reply-To: <20260627101228.1191586-1-runyu.xiao@seu.edu.cn>
References: <20260627101228.1191586-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jun 2026 18:12:28 +0800 Runyu Xiao wrote:
> CONFIG_PROVE_RCU_LIST reports the poll_napi() traversal when the helper
> is exercised directly from netpoll_poll_dev(). The current source has
> important lifetime defenses around NAPI deletion and netpoll device
> close, so this is not presented as a proven use-after-free. The issue is
> that the RCU-list reader contract is implicit at the helper boundary.

Please provide the stack trace from the report, rather than just saying
that you can trigger it.
-- 
pw-bot: rfc
