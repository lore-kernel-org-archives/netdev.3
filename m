Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE3635A3BF;
	Thu, 23 Apr 2026 17:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776966090; cv=none; b=emtNoroOTiLtDzsp5UNNPz3TLKaV3+D5wZIOep3Rzwz+RMIY9K1aZb/6AIQo+G0ppRodFI3qccUru+aJObqWKMjfFKUr5w/SizCLpYEFwMwkJ25do7x1GPaRxvWPBdA1GI+TnwT+9D8vCHFrFoSEHiV/oXeePFhgtwtq4W5V3BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776966090; c=relaxed/simple;
	bh=yYXclDNUBzqnsXB+xS/OOb4t5oNW0A8Ot3vHbbyoEIU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WndIjBzF7Y0Qqx5TFmvj9XrvjczAnlXWfP36xuG6H44xYevEBoXPJEA8XVgRWnmTOAqlY8LEIpcNnpWHowxyufoWZRD/oEVwo8AEcYH8qOu7tHTDlPuKDzkYgEQDAhKzBciZsMmZBTHlcVDxygfkDC4yZ8IlrqGeGFQhsxiI/Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4vqWxN6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4vqWxN6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A7DC2BCB4;
	Thu, 23 Apr 2026 17:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776966090;
	bh=yYXclDNUBzqnsXB+xS/OOb4t5oNW0A8Ot3vHbbyoEIU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K4vqWxN69RmYXTMOa8sHY3sD3sfXjUmnpiWWA5WaJWHPtVevDITEI66HhhNAqFc/I
	 mKtZtHujQFlJ0IgDCkhlIzgNa4a/eytWSLDq4gXaocnIvxWcqqqwNoHUDllHsAzmXA
	 LKSlX8HmyvrCYrJT/H6pNK28f3LnU07XH06Nem7J86yORgznu0GIqCbQAMUdl9xreg
	 eJW/ZLT/F2gGLRh+a4bEiVsjTR/aauedj/J14zdIOzURJHUSM/8bJUAM9L8UL4nEqN
	 bfmJmYESXTdbNsMvTcg/RbX+5PsG9aDdhQGwEBKFSn2n1RbXKB5An9sXyy6vRpt5aZ
	 V+xmw3wTMwXiA==
Date: Thu, 23 Apr 2026 10:41:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: syzbot <syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] general protection fault in
 kernel_sock_shutdown (4)
Message-ID: <20260423104129.203447dd@kernel.org>
In-Reply-To: <69ea344f.a00a0220.17a17.0040.GAE@google.com>
References: <69ea344f.a00a0220.17a17.0040.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Apr 2026 08:01:35 -0700 syzbot wrote:
> Subject: [syzbot] [net?] general protection fault in kernel_sock_shutdown (4)

#syz set subsystems: rdma
