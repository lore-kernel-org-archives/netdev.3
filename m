Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB52435AB2
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 14:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902841; cv=none; b=YJhT99bLQ33yLKtabvzgT5ImZEdVCqqrM/0vEOmRHOvAssM1Cp3mwdWrRkS5PtNhrIsXf/5v+mW5NnMGtaTLsQIm02MAvykoUVSZCHgevxX65RQerkS79I2M0BUTs8i1iYf03I2F8AMx3ses0T6ZaJK86dmAfCqxsv/C/pID9Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902841; c=relaxed/simple;
	bh=ZUgQ8afTp26R6doPLDBXTL9k98gWN2F0KnghYDa0mW0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hYaoBcINaBfqvOhUhxJftH8a310VPLkWqSBL8BBFZHTUAYgMMPH0/ET+yInMfMmhbYCWRcc3QjFSToFbYQNv2Dt+BxMEu+AQdv40HSwpMJS5EiAzgd4p8uIIKwWiq6ZAKjK4RZe7eAYp4Ng4NmkTzUFWAsjf+B1GJtPIz75qMbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gw+M2/WU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gw+M2/WU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500091F000E9;
	Fri, 24 Jul 2026 14:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784902838;
	bh=EX9TQx2K7flt3xbhzeGUu0GEND0jYFrRp2g/Va7B144=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gw+M2/WU5yF1BxhHNfrpm3BkNLIYtSBkkghTBO35hLVH1FVGZKK7tYJjeGB9+YwIl
	 D88ZjNE7ehzPbtcqzxiSUposDL/+NucBSRmtDE4R5pH+r+22NXf43WqVS7SPGUicGx
	 DN1JN7xcLt/9AoCXoQZ+orwxlNIbrTpKCKD3ErfJUTtQdU6ZGYcqWdRunMbeCeQuI8
	 k9bEuSY0srjA37Ac8f+gem18t7uLhekEFS4wC1NvocD/l4OpZZlXFcWMCzzh2t+vJf
	 XMXGE/Cd2jMBMk0wXL8Bph7FgVMqCrbFa49HlXRbUVLcvn9FLP9C0/m39Wj74pdrrz
	 Av/t83bJuDNYQ==
Date: Fri, 24 Jul 2026 07:20:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net] net: do not send ICMP/NDISC Redirects when peer
 allocation fails
Message-ID: <20260724072037.26b2a672@kernel.org>
In-Reply-To: <CANn89iKuh3PbaoWskJEd7MXWZNmLDUNH7DdtE7hmAz+MTOybnw@mail.gmail.com>
References: <20260724072901.1633601-1-edumazet@google.com>
	<20260724064246.2a22ee44@kernel.org>
	<CANn89iKuh3PbaoWskJEd7MXWZNmLDUNH7DdtE7hmAz+MTOybnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 16:15:54 +0200 Eric Dumazet wrote:
> I have no idea really :/
> 
> vng --cwd tools/testing/selftests/net -p 4 -r ./arch/x86/boot/bzImage
> -- ./fib_tests.sh
> 
>  All tests are [ OK ] for me.
> 
> Tests passed: 257
> Tests failed:   0
> 
> Note that my change in ip6_forward() does not early-return, unless I
> am mistaken.

Ack, weird. The only two other patches that came in recently seem to be:

  net: ip6_tunnel: use tunnel parameters for fill_forward_path route lookup
  net: udp_tunnel: fix memory leak in udp_tunnel_nic_unregister()

neither of which seem like they should cause this :/

I'll keep this patch in and keep an eye..
