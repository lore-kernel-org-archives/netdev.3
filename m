Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1858443A807;
	Tue,  4 Aug 2026 11:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785841847; cv=none; b=k6t6mWUvnPxMc/d/B8uWGs5Y8yOFeumv4mI5oeTa7e1eYmJ/uDhtJzLPHeQIWVnB0UTEm296UAkXH2rvz/7AqMU+gAH9XnmsGWKchBbND0DQgucauJXSmFpxB4DK3yi2s9VrRW1Ka6ixmA+F0rQ+48BUHamm/TzsE6qMB5ZGXpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785841847; c=relaxed/simple;
	bh=FesufFAAZA0yXKELnvADBD0lfjqXrwfNEAbRuBN1xiw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gj/DxnaMZSJaH/imK0upINEuMWEAXpY9RTGp6HJiVGE/DeCMdLfFUszQPK6yZFy8YediJzzGUG6KWOaZmCG/KebeFkDSIIRX+9djkdGZy4dLVdkRayjJSyso+n7WFQcqbzaILkPg1N6qwhYIQr+QnP2TFnuaBAxwCFqCSXJwKUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcrdOEqd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcrdOEqd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB121F000E9;
	Tue,  4 Aug 2026 11:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785841845;
	bh=nKpthTClJKuBHSyyZTe5s3L6EPDJ/ZCChyd78ynPaak=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BcrdOEqd6lokYMMbl3P9NkjP5t8YUW9ZXakupi04rmLkSqeIfK4dAyMcuDAV/LMco
	 Ty9QGpG1B9UfqAke5et15YevHBGdvVcBCYdOJxhw5DGLC3mlcWmCap7WEEC+9xlgNK
	 SQbA3rrnZBp13ac4pwDNtGrEnoaqwj8l2FZOSN3yPUodjsJRYOg0Qz7gEFt6fqbmC3
	 L6yFh7F4i5LHQu5neLsyxQJkCobY3XHf8dA3OvUQAkJwA/vFWItNn5tQG/kssj3uAB
	 gEdZj61td0+xgma4/d7Kuq+jk2wT4zksODCpoIf3ODNVR5Berhr/i++pptFBFNnILj
	 C0JlvJ/FUOBwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A083924FDA;
	Tue,  4 Aug 2026 11:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] net/openvswitch: check Ethernet header length in
  key_extract()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178584180615.3101099.8416627312797177820.git-patchwork-notify@kernel.org>
Date: Tue, 04 Aug 2026 11:10:06 +0000
References: <20260730222006.118652-1-blbllhy@gmail.com>
In-Reply-To: <20260730222006.118652-1-blbllhy@gmail.com>
To: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Cc: aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com,
 tgopinath@linux.microsoft.com, kys@microsoft.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 30 Jul 2026 18:20:06 -0400 you wrote:
> When a packet arrives on an ARPHRD_NONE device (e.g. TUN),
> ovs_flow_key_extract() trusts the user-provided skb->protocol field: if
> it is ETH_P_TEB, the packet is classified as MAC_PROTO_ETHERNET and
> key_extract() is called without ensuring the skb has ETH_HLEN (14) bytes
> of linear data. key_extract() unconditionally pulls 2 * ETH_ALEN bytes
> for MAC addresses and parse_ethertype() pulls 2 more, either of which
> triggers a kernel BUG in __skb_pull() when the linear area is too small.
> 
> [...]

Here is the summary with links:
  - [net,v5] net/openvswitch: check Ethernet header length in key_extract()
    https://git.kernel.org/netdev/net/c/cf6f8b29befb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


