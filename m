Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BA01A6834
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 18:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784744126; cv=none; b=XKfurVREEDJtrOZnvU5ipoDleluHIteRLj9nqY1NVwknV+NQXk6AtLfFRRmnGS50gcMnfZgqeKXLT2cg3v/DQNg5f5V8BbxaLFOmmxKrCK62OuasMtbRynrSIjBflwtgGzpdrM26Kk8JEkSWjqPPduElDr/R8cNWMyy1lnd5Eao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784744126; c=relaxed/simple;
	bh=8EIKOkGwKr3YR7p2Cr2mP1qxHAqfx3x05unogwhq/SU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wfz8lrZVYqJwvACOjTh4MrZ9NBu5hxEd0j1Fki1y9ANJVL8y2xzATRUFC5MtpT+TJDzh3iGU/PgAiI4xiP98b+tTNtWj9g07FF6zEosJ2K9X7iIOu4K3m7p70kkyMz4KyiJsPHQ8XSDgtv04VDeLpgtymEDFl0bV/D+rP4R7Y9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDWlcvjr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDWlcvjr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879C51F000E9;
	Wed, 22 Jul 2026 18:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784744124;
	bh=GYX+ND2Ram7qWL11imcPBYhc+XkPdiCcbjLoQcJDA8k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NDWlcvjrh0f+4hj43O5sM8vN8mlpwEaOGFoaWgiJyr3fCScv1f8aSs4VcKRdcw3e2
	 +1MZeadAzsQLajewb2/JQjBUSMhUWg48m1UfEldWubGv6QVLEZdOHDjADcrVzFQQiQ
	 zegfPmCMVQ8btL95MOvOdNW1qx6CPrJCDT5fkqYYQBGi2HY7bGdiLLF4ZQnhlCKUQV
	 pbEhrQ7wdwTc5gbDdtTKN1FjQKZuQEPZHupgJ71WqbELpYO6J8Fa3tEovc+/QVmAFY
	 qL3WmXkqkbD7lYHOsfUXKG4IdPUztXH1SVRJMhEQ22R794OA4q4y+DQRC/r8h/gsnM
	 hfKwxeHD566mQ==
Date: Wed, 22 Jul 2026 11:15:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alice Mikityanska <alice.kernel@fastmail.im>
Cc: Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Xin Long <lucien.xin@gmail.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Willem de Bruijn <willemb@google.com>,
 David Ahern <dsahern@kernel.org>, Nikolay Aleksandrov
 <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>, Stanislav Fomichev
 <stfomichev@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
 <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
 netdev@vger.kernel.org, Alice Mikityanska <alice@isovalent.com>
Subject: Re: [PATCH net-next v9 0/9] BIG TCP for UDP tunnels
Message-ID: <20260722111522.569fc202@kernel.org>
In-Reply-To: <20260710134242.216538-1-alice.kernel@fastmail.im>
References: <20260710134242.216538-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jul 2026 16:42:33 +0300 Alice Mikityanska wrote:
> Patch 09 adds selftests.

Seems to fail:

https://netdev-ctrl.bots.linux.dev/logs/vmksft/net/results/745543/157-big-tcp-tunnels-sh/stdout

# selftests: net: big_tcp_tunnels.sh
# 0.05 [+0.05] Setting up VXLAN over IPv4, veth tx csum offload on
# 0.11 [+0.06] Warning: Extension comment revision 0 not supported, missing kernel module?
# 0.13 [+0.01] iptables v1.8.11 (nf_tables):  RULE_INSERT failed (No such file or directory): rule in chain PREROUTING
# 0.14 [+0.02] Warning: Extension comment revision 0 not supported, missing kernel module?
# 0.16 [+0.02] iptables v1.8.11 (nf_tables):  RULE_INSERT failed (No such file or directory): rule in chain OUTPUT
# 0.18 [+0.02] Warning: Extension comment revision 0 not supported, missing kernel module?
# 0.20 [+0.02] iptables v1.8.11 (nf_tables):  RULE_INSERT failed (No such file or directory): rule in chain OUTPUT
# 0.20 [+0.01] Running IPv4 traffic in the tunnel
# 5.24 [+5.04] Warning: Extension comment revision 0 not supported, missing kernel module?
# 5.24 [+0.00] iptables: Bad rule (does a matching rule exist in that chain?).
# 5.26 [+0.01] Warning: Extension comment revision 0 not supported, missing kernel module?
# 5.26 [+0.00] iptables: Bad rule (does a matching rule exist in that chain?).
# 5.27 [+0.01] Warning: Extension comment revision 0 not supported, missing kernel module?
# 5.28 [+0.00] iptables: Bad rule (does a matching rule exist in that chain?).
# 5.28 [+0.00] Captured BIG TCP RX packets: 
# 5.28 [+0.00] Captured BIG TCP TX packets: 
# 5.29 [+0.00] Captured TCP SACK packets: 
# 5.29 [+0.00] ./big_tcp_tunnels.sh: line 150: [: : integer expected
not ok 1 selftests: net: big_tcp_tunnels.sh # exit=1

Sounds like we're missing some iptables options from the config?
