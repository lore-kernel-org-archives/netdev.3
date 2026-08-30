Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB48532720C;
	Sun, 30 Aug 2026 21:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788126094; cv=none; b=cVDDkMka4l4XvxJUL2lhqem/aE1cWGxOMJ2xxvW0iGgbZDjjLuG25oN2WVpzsFj1aktc6Ob3PcOiQLUP3VyFUsZY8Lsen0RLCsmkJfcKbZlcLVvOQ8VZq66LmmF2Qzi5POet9SA2MzzNtdWaYY30layXVqNFIZVICHOqeJnj26s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788126094; c=relaxed/simple;
	bh=EIxKh8lUKLit9R6hZACQZxmL4/MNG2noh3A01b+W6D8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QVl/jmpWIxPkgdTInwCQCdpygEf2ZrlHPr8AB7WiYwlEUvVLgAZZxJCXnd9U3qt21/BEQ0A/GtC5mUaT9fr4syFe6HE89AQSaHtR9XpMsBCoP7K+tV0+5DuEGZPSUvYiLfqlaM8m0mbFYhsL7PZdxc81JbUceqdw0jg6UTQp9nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJJsbRWr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJJsbRWr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8607C1F000E9;
	Sun, 30 Aug 2026 21:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788126092;
	bh=PPB10GP6Rz2TsC/RY1tVoUpybuYgddw5qgCnGWGOXcw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eJJsbRWrB9yimvJNdMc0KVbIGRHdM1ERcZQdu837F70ibbpGNHC0rylKVrz9ma+co
	 Yj05UGxYwGfbaAvNM94wZVb0HBK0xC9PJ0AbYbJVaKIiU+RVzHgzE40CFD4I3QTZzF
	 drk2/PGlJYAVmqU1N5evE/6HLnPmGYhQC1I5H0sNoqzaFDFDviWZV6UFTWr1TiV64l
	 FvQsDY2SMFFX9IfROxlUQ1gFYTTfZvR6Vyxy28uz9geYxyaYGldJaxu1JsolckSvez
	 HV+3g6HajC5ZVXAlJ9JweGRsn/Lg5D279BPH9Yg7Gt7jb6qVW9J7LZIdqWsVMF8jcU
	 VW1eci/V8TA2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569C0380CEF0;
	Sun, 30 Aug 2026 21:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] vxlan: mdb: Fix use-after-free in
 vxlan_mdb_remote_src_del()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178812603589.3466124.393992773774745675.git-patchwork-notify@kernel.org>
Date: Sun, 30 Aug 2026 21:40:35 +0000
References: <20260826173604.90158-1-baul.lee@xbow.com>
In-Reply-To: <20260826173604.90158-1-baul.lee@xbow.com>
To: Baul Lee <baul.lee@xbow.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, idosch@nvidia.com, razor@blackwall.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 federico.kirschbaum@xbow.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Aug 2026 02:36:04 +0900 you wrote:
> vxlan_mdb_is_valid_source(), which validates MDBE_ATTR_SOURCE and every
> MDBE_ATTR_SRC_LIST member, accepts the all-zeros address.
> 
> A source list is only accepted on a (*, G) entry, whose source is the
> all-zeros address, and for each member of the list an (S, G) entry is
> derived from it by substituting the source. Entries are keyed by a plain
> memcmp() of struct vxlan_mdb_entry_key, so if MDBE_ATTR_SOURCE is present
> and holds the all-zeros address and the source list holds it as well, the
> derived (S, G) key is byte-identical to the (*, G) key and resolves to the
> same entry. Omitting MDBE_ATTR_SOURCE is not equivalent, as the key is
> then left with a zero address family.
> 
> [...]

Here is the summary with links:
  - [net,v2] vxlan: mdb: Fix use-after-free in vxlan_mdb_remote_src_del()
    https://git.kernel.org/netdev/net/c/4aa61c88b4e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


