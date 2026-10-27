Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793066251;
	b=dOV9uzeT8wJp88mo/zuvmtfmEdTadZuIMdUd/GLdlVY9NCx1OMaDOkEiUMJuKqtvgTbZ
	 hOawGsp/OZA3/Wy+P+VfauSQm5ssr0+cnr6HHL8iUG1O7PGPfJYX5Gm70g1DQTOWvZQn+
	 8IlAKpcffuzwLJDhQCRLDTJcRDTEiiPigON4BiDPCPq4v0yuFnVsyw2QqlZfhYg7HtZKg
	 zRgG3ZUVwHxB6EYEo/ANN5q1Zf1TPy/IzYtmndOxKQBqpN2rpOOo+hD1lRv+7MvdmVHV3
	 1jOD3pCXQIbV+m9qPSdE+NQJOnAGs4a14TIW3XUcSFUn6e+Spz2SsRJ/arnqSYOgCaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793066251;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=NK5FFyjCkMxgeTHh2dC/Pdhkdnse5LPXhElDwUbDutU=;
	b=v8+lBY9EaTjiDXdGzvS/b3m9lyBNMI+l5L5YUkvAzp2oYJ6OCx6FH9jRaUyGcZVYBM3Z
	 3bzUQ64S065H6/xXAYVGHnFsy0B8Ev+UjHnTncJvFc7mCOaq0a8Zo3UDZajzHB0jQmkAC
	 jfC36fhge8rATZMZVMBNXsCSqFIK63cl9v2neQs0t0G9aWLA35fg/Azpbj0l1NYXxV2TT
	 u4lWygL6oi4lLvgtlnzP53nL+3ggHINV0x5DVXOLY/rzmFTbJgkVBLrmfu8AefFhtc73H
	 p4GtOV+7WzmngzxLFlXHcJ8QYV8iNdZt444+JKmU153lxFIFpxYKp6Pu/+LfC9LwC2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bwu5+Z++;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E59606A31B;
	Tue, 27 Oct 2026 01:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bwu5+Z++
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF14A1F01825;
	Tue, 27 Oct 2026 01:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793066251;
	bh=NK5FFyjCkMxgeTHh2dC/Pdhkdnse5LPXhElDwUbDutU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Bwu5+Z++DuLmsZ/xnrc9jVhQH0Izsq52h7iBxKCSeUC8ndDRZ3zmvdBLPOtZEmmZL
	 JxyzRkUvJZitMAZelCz2PRPqekwkXAuWzRV6iPcvCPh/bPvw0f66SdekAkbR6CyAM3
	 VWH9xotnhdVgzgXsNc6Xh5+DAmtTYib2eLQQ2VSqyMMtBYf66NxlfjLnrTsRUQgLu4
	 E1ykBTH9YQ3vWMp/khDYXc9/Z5cU+aywPyjZ+1WbAKcO6awHCZ06Qak1rg4tcYKwlj
	 1ZeaaHISaZK2dQiWmcuGqAvqQFJ3VxjaL8BZ7bujkkM1kqZmPyiQN2gqzaRtiwoI22
	 ZOFsoCZLA0Hzw==
Date: Mon, 26 Oct 2026 18:57:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Gabriel Goller
 <g.goller@proxmox.com>
Subject: Re: [PATCH net-next v4 0/2] seg6: skip route refcounts in seg6local
 lookups
Message-ID: <20261026185730.7f3d7004@kernel.org>
In-Reply-To: <20261023-seg6-lookup-noref-v4-0-0ad0a83960ef@gmail.com>
References: <20261023-seg6-lookup-noref-v4-0-0ad0a83960ef@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Oct 2026 22:47:55 +0900 Yuya Kusakabe wrote:
> seg6local looks up the nexthop of its IPv6 and IPv4 behaviors from the
> RCU read-side section of the receive path, yet takes and drops a route
> reference for every packet.  Skip the reference, as ip6_route_input()
> and ip_rcv_finish() do.

## Form letter - net-next-closed

The merge window for Linux v7.4 has begun, and the net-next
tree is now closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens. There is some uncertainty
about how long this merge window will last, so please check
https://netdev.bots.linux.dev/net-next.html
before reposting. net-next _may_ reopen on Nov 2nd.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

