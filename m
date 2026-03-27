Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B1D13AD05
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 01:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774576219; cv=none; b=oPbx9/JcfQ8/GWp5PULRUXOyzAticvipH1co4Z3zCL0dJRxiaUzsjVdRPodgQP0BxkS6e9sL9fLnmA/w1JQOwTJktSMBvb6xYc/hozpYGh0fmYZIpKVNJnPFL1VYhgh3ELi6jNOizGCyfXYyPSYEmNqlogiTAK8mMqb0rRHp3P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774576219; c=relaxed/simple;
	bh=T1O4b28BbEHhL6yLGeqMJA0Ma2/HKDqyrUeEDG3E1w8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bdSo7ocgD5H6EfE55ZwWyT3xz74gKd2rMpSNLF8YCwzfJXPOozOVIC7eh1vVwETOCjt2et99Jwt6NVJ0WgwH2ABZxPaguZFsRitGtV40JggRfEeh3ljG8N0hgf6aB2UQbX1C+TkOlgJshmvVCtMJOWtzP8roHOyY8EBZIoReMBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNW0M4Pj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNW0M4Pj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43CB2C116C6;
	Fri, 27 Mar 2026 01:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774576219;
	bh=T1O4b28BbEHhL6yLGeqMJA0Ma2/HKDqyrUeEDG3E1w8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QNW0M4PjYqR4IVd5TktLwE/PzxeOBvxgZoWS069x5mFTp7EWAVkr6PVyoKDKa/nBu
	 mvxbcqlfuxdjDlRNI9yDV7I/6knE4kUs246YJck1gxw8yogmpfSm/oYDgDzS4R80kL
	 I1x8qxKEkuEupbXzb+oTiWleWqQXohtmNWLnYjVZJ3v2yfwP/f+gV1MLgttwI6MC53
	 uc6N2HPPdQQFBG9E9ljtOoJcZ2AfUYJ09bytcgE+aGr54fddpj9d/ILolRa8UaR6VU
	 Kejgen022g39Bka2WGRQAWazSD4eWg+RoX7zezLuUbbT4YVZZ/wO4ijY0ExR68UdCu
	 cWauTUwouiksw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E9B3809A07;
	Fri, 27 Mar 2026 01:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mpls: add seqcount to protect the platform_label{,s}
 pair
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177457620555.3256339.18296172329190801679.git-patchwork-notify@kernel.org>
Date: Fri, 27 Mar 2026 01:50:05 +0000
References: 
 <cd8fca15e3eb7e212b094064cd83652e20fd9d31.1774284088.git.sd@queasysnail.net>
In-Reply-To: 
 <cd8fca15e3eb7e212b094064cd83652e20fd9d31.1774284088.git.sd@queasysnail.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, ebiederm@xmission.com, kuniyu@google.com,
 gnault@redhat.com, tanyuan98@outlook.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, bird@lzu.edu.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Mar 2026 00:25:57 +0100 you wrote:
> The RCU-protected codepaths (mpls_forward, mpls_dump_routes) can have
> an inconsistent view of platform_labels vs platform_label in case of a
> concurrent resize (resize_platform_label_table, under
> platform_mutex). This can lead to OOB accesses.
> 
> This patch adds a seqcount, so that we get a consistent snapshot.
> 
> [...]

Here is the summary with links:
  - [net] mpls: add seqcount to protect the platform_label{,s} pair
    https://git.kernel.org/netdev/net/c/629ec78ef860

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


