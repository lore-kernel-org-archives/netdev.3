Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89213B71D9
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 08:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787733660; cv=none; b=PpaIS2G6Fa/N6Hxh3EcFW5KqLOa5vjJ+9bmF+XC5W4Dw0/W1e7JN7es/4QCmKvWn+PolJSxdE0Sp+CDQOlnEb3qxvLjeTkC0oQF6WakzVwTJU4SGVczd1llbzg0L35sIP9USG/xu+fu7gKkD9zlNzhb751PPbTn7jPg70ryIKZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787733660; c=relaxed/simple;
	bh=cAXiymtMzUKFBxX7p9Bysxg3gPz3+q0anwznctiM3cw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kIuh1DPYEAeydlOcG3dWwDfYHUsn05f5sfR6/+93U/ofEGEGzTJgUmb/h8Ap3v5R4ewc9Xaigs8ngFESZVqvBRC0C7CKFee0/0EKFvtFYnrgoR0Z+XAY0VcjEdU4ENJR1uqhL85XAHr+cV+kw+udb8RaByjrfvFpZFt2udSHFYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPs4DhAX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPs4DhAX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF141F000E9;
	Wed, 26 Aug 2026 08:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787733659;
	bh=fO4y6y1dEsP3Aw8nNZLiwz+eVBwOjHcGvK9vYH0EnNU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HPs4DhAXxHl/f8QMk2wbcHzMvcKzDnfmgkgmTlxTIfMgBx6eaGHlVBNApw1ntjBQ8
	 0lf5CHXCLTEavdvVvUqZPXlQBkB0K+iWKo+S5e3YL8lyyHwUxyeK5O6lDmUeU8RQx4
	 iiT6iaeMoz2ucfEAYF2A6VCMF/kRChRvTo+BbIMMKJsFDbj9dR+maQuTWCejHhp1Sq
	 ZB4blzKk1ajp6Ou2vGq8UAyWqF1b22yEQVo5j3cqZcPzFqKR+zMXjUsJvRnC/cUVUi
	 SuItbJrMBoysZZ4ko/Q8mBFpB3Lto+geqYYXUJP50UyfpBVNVzoqknKI1nJ0WMgdy/
	 0A1XkNwaF1+TQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198E53926267;
	Wed, 26 Aug 2026 08:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/1] seg6: reset IP6CB after IPv6 decapsulation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178773360589.127668.6735942347177499899.git-patchwork-notify@kernel.org>
Date: Wed, 26 Aug 2026 08:40:05 +0000
References: <cover.1787388261.git.zhilinz@nebusec.ai>
In-Reply-To: <cover.1787388261.git.zhilinz@nebusec.ai>
To: None <Zhiling Zou zhilinz@nebusec.ai>
Cc: andrea.mayer@uniroma2.it, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 david.lebrun@uclouvain.be, vega@nebusec.ai, zhilinz@nebusec.ai

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 22 Aug 2026 16:49:26 +0800 you wrote:
> From: Zhiling Zou <zhilinz@nebusec.ai>
> 
> Hi Linux kernel maintainers,
> 
> We found and validated an issue in net/ipv6/seg6_local.c. The bug is
> reachable by a non-root user via user and net namespace.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/1] seg6: reset IP6CB after IPv6 decapsulation
    https://git.kernel.org/netdev/net/c/f967455fb2a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


