Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6144B44C51E;
	Thu,  6 Aug 2026 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786014070; cv=none; b=MM23h3PhoV0haApLD4+FCKhIj56zcd19ysklSxHnp5kttqpnuJ+lt8JuYQHWLhHCj3pyxQbuxvSflyJn5aNSaM/pukvCec/rzaUydbPBjEyOjxyi2mbHJzegjle6Lr9tY8Bn5MNUoXlpHAHyUSxIiWz8aS9Fr8FmjawSimS0hws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786014070; c=relaxed/simple;
	bh=WCSoqS3pUJKJoA4xArINSHjysEl99GdjTHyM1L3QneU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kdtfa+zViXbzR+RZGx4sy9IG8L5k37LCbO3+pg0xSPBeew6gLAHMMPiu3crL/X9xxzNQmW3oL4GwKvxvVkXv2OzH2201/qjC1c7gQf1kh/uFayyQxwkgrh1x/7UnNhWPiWv31vvtgr21Whw7i4AVYR4qJaW7qNXN0RLFwoOB1sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqVcmV8a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqVcmV8a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3035B1F00A3A;
	Thu,  6 Aug 2026 11:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786014069;
	bh=ONk+gNvthaGJYJkBNeuMrqJiZPtO9rMt7uPFqnRXrgM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oqVcmV8a7Buoqwaydxx96t308wx3lV6n8KyeczFlx700krzm9dZ3IoJXV/GucblG9
	 gMa9PGIruK1WyfK3hcXQhSZMyPWcb9tzlD1J5gJOkSTpyb9nMglQrxo9WHBWqcfkVs
	 crMlauem1LuRY/M6mQt1VwabraYsmdJuxflFY3YfijUoVoHvDhXF/+ZxW02duAu3fa
	 iv4y5t5tDl13LvvM1Xw+7H0EpBlU1Y1CjPy82EQXrlHO2h1Zq1u76UBXV0m24Ga56h
	 ccoevtA9NV44F8kWkenoKBfVhJJOkQPL11/ca1PHQZU2/KVRxbg88ky3OV5w2Y7PZZ
	 5qSBpcG0WH0xg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0931380AA4F;
	Thu,  6 Aug 2026 11:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] rtnetlink: cap IFLA_VFINFO_LIST at a
 documented
 number of VFs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178601402843.783742.8946807120634040311.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 11:00:28 +0000
References: <20260801114944.115272-1-iprintercanon@gmail.com>
In-Reply-To: <20260801114944.115272-1-iprintercanon@gmail.com>
To: Artem Lytkin <iprintercanon@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 donald.hunter@gmail.com, jacob.e.keller@intel.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat,  1 Aug 2026 14:49:44 +0300 you wrote:
> rtnl_fill_vf() emits one IFLA_VF_INFO per VF into the IFLA_VFINFO_LIST
> nest and closes it with nla_nest_end(), which stores the accumulated
> length into nla_len. That field is a u16, so a nest larger than 65535
> bytes is written truncated modulo 65536. The list dates back to commit
> c02db8c6290b ("rtnetlink: make SR-IOV VF interface symmetric") in 2010
> and has never been able to describe an arbitrary number of VFs; nothing
> regressed, the encoding simply cannot represent it.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] rtnetlink: cap IFLA_VFINFO_LIST at a documented number of VFs
    https://git.kernel.org/netdev/net-next/c/51e15308c6ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


