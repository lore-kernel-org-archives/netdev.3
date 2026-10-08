Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF60A3955C4
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 18:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791485411; cv=none; b=BrFgZiP/rjs+JfV0zuo/1XfUsJa1Iqj3yCCVy+vskgm6KstHtMWeVe/FXIrkBXO4b10vbxrHJjk/kGmdbdm2HnuJmiLIl7KCjVgXepv/x72KNXejDxZFNfSyKK6im9AC/SelXbGvmtHDtAMcrCyqShv1LzQs5ezeCxD6izqYwIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791485411; c=relaxed/simple;
	bh=ND/EF0PLUo7wrzDIPLgKyafXiSAPRt+HJNHOQfYtLDI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WjNrsLeDs1L84QbKWAjauNhPQRA8985WJPKQ4kxMFEb6rOndumTPCQcEvT8HuBMisQ+zvaPyL9aDil6HsBZzLJIvBwYsOCr1R0mUxk1TZ2XA7Yj+onhQMHxMJ0V1lkhC1T1is537kBL6pp84p/JoskC6+3MOtoas0zZvq7Fxty0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnNzSkSA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnNzSkSA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D331F000FF;
	Thu,  8 Oct 2026 18:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791485410;
	bh=3K1Ypmx038fos9tBNuaBD/cfSLgrYr4fQCkM/BGqC9Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CnNzSkSAyf7YbOVF/i1hHoTKDHcADdJXgklM0ANmrlYU9LksWpicuj8tB+uMG4gb6
	 aeZXMbrG7YsYZNCmy5DH3pa8adAMYEmKPYj4z7mfIdovpEW8hfsL7GsB22iNiw1f7l
	 l1LZnmnZS1IS2sQV2N0TPpQbjTQ4Yuggxgmvq+s1O8xCm/47qk0L2KvAp3VOnH+oUq
	 /X+HZGkyQ6FAi6OWoOpWV9JZaFwCO/6pig+GbH2DOLdLD8zBtuuUTVWMC4rPltb9LI
	 qNk/e7Lxd6MHe2lnmmQwJJw5jc1izOO75sJ/29ae3fk6FWIUAzprFjcdiGhK6uNHVd
	 jQw9Bop8owUPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1772380CEC8;
	Thu,  8 Oct 2026 18:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: openvswitch: validate transport header
 presence
 in set_ipv6_addr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179148540851.391001.9119366879884174127.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 18:50:08 +0000
References: <20261008104135.4722-1-fmancera@suse.de>
In-Reply-To: <20261008104135.4722-1-fmancera@suse.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, jesse@nicira.com,
 aatteka@nicira.com, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@kernel.org, davem@davemloft.net, i.maximets@ovn.org,
 echaudro@redhat.com, aconole@redhat.com,
 syzbot+4cc63fcfb3845e149969@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 Oct 2026 12:41:35 +0200 you wrote:
> When executing IPv6 address rewrite actions on IPv6 fragments,
> set_ipv6_addr() calls update_ipv6_checksum(). If parse_ipv6hdr()
> processes a non-first IPv6 fragment, it sets key->ip.proto to
> NEXTHDR_FRAGMENT and returns early without calling
> skb_set_transport_header().
> 
> update_ipv6_checksum() unconditionally evaluates skb_transport_offset()
> on entry before checking l4_proto.  Because skb->transport_header is
> uninitialized, this triggers a warning under CONFIG_DEBUG_NET=y although
> it is completely harmless.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: openvswitch: validate transport header presence in set_ipv6_addr
    https://git.kernel.org/netdev/net/c/3c6a4b11330f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


