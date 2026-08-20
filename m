Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287613C6A56;
	Thu, 20 Aug 2026 20:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787257880; cv=none; b=cObIlHQbYTliPVoTW/USfAzlR+WKvni/MLag/g3c7chVKkppifWksVPlPh7q92HBY391zHB9CjM6ty3FBCAWUGq0vRCmDZOPbUi7lzr/ZQV1dKbPspRg3DKXvJ9s/WfKjfcyjtQ+W2NTafJHWEFiRfDnAnHuD789uH9Fq1DrNec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787257880; c=relaxed/simple;
	bh=QHU25mnumAA5x01aLRvGzN4NhXblhKI/1CVBu6yG0bg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TtTPgmZn1mGDcyrxIoR/jEveNOKUYVXeS6UWK5KLwfYrt1jzF19VjU175xsCcqhOWrp+PEPTBSGBMeg8jrWtsYm8qXKw4S+RTodldJdmninW7/wpGLSHbTd2Tjcg69iwZbtjqwVkcNldVoclVUoL2ni3xJ2RsH86NiJ58uUp1nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bS0Oct/V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bS0Oct/V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB581F00A3D;
	Thu, 20 Aug 2026 20:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787257875;
	bh=EnWYHeVJW4ZfcdgTI2+PZRvGihKpXR1Rwasv1exy2CE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bS0Oct/VmoTTRyqiQtsRLu6n0MjmPSJRQYA0pR/ZvpODlnVCauSK3gC7nE5Olt/4I
	 gGbv8CTIrw4VpjeWxDygF/CSNMulWxco0HKRqyBCD3Ji+6NHUXOYdzvkT4M4LhuZvj
	 HLupQwLtXXGekrf/++FiwjcDBy+xUyIeSOWcG5Cmx6823q7ZXFFnalxV3c67tLj92s
	 W0IoV2a6+gYv4djU9C5knbxvmGpvwKXxZkBhyLQxgpOCaG+Lb+uBsLfkzu+jM4V63h
	 a9flFKXo/VPW01/HVchKVhaGYshP14CnP/ieZjHhd3hu+4vuzeFUhiHqg00bQxuphM
	 mXgDOWuOF/dmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AA8392445B;
	Thu, 20 Aug 2026 20:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 1/2] net: core: propagate unreadable flag in
 skb_zerocopy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178725782538.470503.1324832379530837261.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 20:30:25 +0000
References: <20260814191336.187243-1-almasrymina@google.com>
In-Reply-To: <20260814191336.187243-1-almasrymina@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: kuba@kernel.org, kaiyuanz@google.com, willemb@google.com,
 edumazet@google.com, pabeni@redhat.com, sdf@fomichev.me,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dev@openvswitch.org,
 davem@davemloft.net, horms@kernel.org, ncardwell@google.com,
 kuniyu@google.com, aconole@redhat.com, echaudro@redhat.com,
 i.maximets@ovn.org, kerneljasonxing@gmail.com, asml.silence@gmail.com,
 bobbyeshleman@gmail.com, fw@strlen.de

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 14 Aug 2026 19:13:30 +0000 you wrote:
> skb_zerocopy() fails to propagate the unreadable flag when copying
> unreadable fragments, causing target skbs to appear as readable memory.
> 
> This patch fixes the flag propagation. Additionally, it returns -EFAULT
> if readable fragments are mixed with unreadable fragments during
> extraction, and returns -EFAULT in openvswitch queue_userspace_packet().
> 
> [...]

Here is the summary with links:
  - [net,v4,1/2] net: core: propagate unreadable flag in skb_zerocopy
    https://git.kernel.org/netdev/net/c/68d8c6532659
  - [net,v4,2/2] net: tcp: block mixing readable and unreadable frags
    https://git.kernel.org/netdev/net/c/d9c56501c72f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


