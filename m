Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E11342538;
	Tue,  5 May 2026 13:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987258; cv=none; b=XZNfLfqv0PiLJOk66Wm2r9PCBcXE9R7LF7K0JqkUvq6vQzRVvlhqbnmL0XvIrVfitsc9QAVEIYev4eMRs3Hcml9JwaB1EbWnQjdIdeR9x4yERKE/iTKXj0SoVy5v96Mns8JLeE2WTA1TF6Htyj4zP5GZQOkRmVXInFjEyF3HKFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987258; c=relaxed/simple;
	bh=ocaOKYX2DXY98GY3ZLZ7TSXAEE2pFhNyFqWr2vc53ao=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bow1B4TvtGaxHmBjnYZUl1feS6eGHN+sNxy+fi2LqT8I0Qvg+ZqlNdya93NLz3AiWWbalTDZUj1/YRkyGmiYzFCUL8WlhxeWwnSbtEp7lWsEQWJ1DPSVwc6mtYse648SjaY/JJ4o4BQ2xgccnwU2kiE59I8rxEuOJlE7pSce8L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvdFj7IZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvdFj7IZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC32C2BCB9;
	Tue,  5 May 2026 13:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777987257;
	bh=ocaOKYX2DXY98GY3ZLZ7TSXAEE2pFhNyFqWr2vc53ao=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dvdFj7IZSy1caS7Xwj5TUKjRHcBBqi1OXOopVQhJdW23O7UbgrB5sCBTzaBisVvby
	 jqWXmsLV9JIh/+3QeYkyrptt8p+/JzVUDwQcVq9jnScM1EUlJnUT+gzJk+ua9VjV0g
	 vUdFFLYhQ5EYfRsy2zfvgrgYKn+PWnNlmEnfVgsgDjcBygzt+JV9SCQhh50P49rV8E
	 VkAKgnkXbDCybWGQuXz1bSqIeZ6m1QKN5Nhjc4il3gklZ/i8ufrKRgvrmmBRxeI8zc
	 pgHp14Xd2VGFcgn4MLvlLg3CpothY2JyQeMKCWxp+uil4EAPZKA1skbIo+bjLWh0wc
	 7GlKVUFZBbtyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C473930232;
	Tue,  5 May 2026 13:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] openvswitch: vport: fix race between tunnel creation
 and
 linking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177798720755.2051666.6281717577088605401.git-patchwork-notify@kernel.org>
Date: Tue, 05 May 2026 13:20:07 +0000
References: <20260430213349.407991-1-i.maximets@ovn.org>
In-Reply-To: <20260430213349.407991-1-i.maximets@ovn.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, dev@openvswitch.org, linux-kernel@vger.kernel.org,
 tanyuan98@outlook.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 bird@lzu.edu.cn, n05ec@lzu.edu.cn

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 30 Apr 2026 23:32:50 +0200 you wrote:
> When a tunnel vport is created it first creates the tunnel device, e.g.,
> with geneve_dev_create_fb(), then it calls ovs_netdev_link() to take a
> reference and link it to the device that represents openvswitch datapath.
> 
> The creation of the device is happening under RTNL, but then RTNL is
> released and re-acquired to find the device by name.  It is technically
> possible for the tunnel device to be re-named or deleted within that
> window while RTNL is not held, and some other device created in its
> place.  This will cause a non-tunnel device to be referenced in the
> vport and tunnel-specific functions used on it, e.g. vxlan_get_options()
> that directly casts the private netdev data into a struct vxlan_dev
> causing an invalid memory access:
> 
> [...]

Here is the summary with links:
  - [net] openvswitch: vport: fix race between tunnel creation and linking
    https://git.kernel.org/netdev/net/c/83861c48ba12

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


