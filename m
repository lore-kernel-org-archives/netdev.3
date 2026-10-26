Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792992989;
	b=YqpMePSS8ZaBz7j5rJbEuzhY6Q/FQyyetLdev0siIWvlNzGwSPKBzjfXq/aF15Hy6uts
	 vG3nvwY+5kDrqPGdD99R3DB7+WuMtOADrauNISwo0EoDmc2F+ucpa9drtKQBVgZpf0/AH
	 yaMf9JLdxc5ipF+ZOz9zIKcwz1alK66ypdE6V168gov/Xn5hTZNhhc3zGJ6BfraWAfGo2
	 0v2ERYoqMzQ7i+zt/VDDrOfIju0KDbns7fzUrK8FYxDjNyo7KxedLJ36AqepueW8Day3U
	 JtkP1dGphS6FiXrLwtCNlpL/AxzxmMw7S1Foaoyx39g2Vt2+vHaC8gJTFtR/lIdcEhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792992989;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4FzJ80Q5D/VPRLbKelDy3UZsEYnGkuTYp52tkB+Plws=;
	b=Kka3g7vYi+57Gvu8qwn2BogPzuU0zmU7jqIsWZU2/IlUe2MCVbUa/FLQBonQa8Njz7kN
	 gMztpvGT4Bz3vdEp73pRqo2VtmXUmZsIQrZlSkf+YHsMxA1iMm4o2jbNpB+qRQ+B9UyVQ
	 iPrbSuhWMjtfHaanvn//B5XplycMkRvD5+zyCT1oM7Ah3JH70dMMe+dkSY8Wby+ZVXqrT
	 /rApdGurWpiZUA2j5VwN2nlmUeq6lg1BXXbtkYELQp6CFR1plNi69t3E3Ahnl5rmQvX0s
	 J0DXPtMAac+LKYvYbGk08VjLyPVRfC52TWE1IIsRlNx90U3t7thJAZYYoGyh6IGeiDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=91.218.175.156
Received: from mta0.migadu.com (out-156.mta0.migadu.com [91.218.175.156])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCD6606A321
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 05:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBCD6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=IKpBcbwGcEt6VGnkPgPXGL4icYZfO5gorFdDU5Rf/FY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792992985; v=1; x=1793597785;
 b=tRRbi7yy8SJo8ciJTUdPXbaOm+5p5NTFyG0G676n7F0K2cId8wczbUoPtmsLOROASobAwUoq
 1O2iARQbikjoDwAd3Z5lWPf+teoXg1euUsokLpxKB4Ve44bMbNrDiL2ENCCELbgvWfnhaRv8HF7
 dgcXA3kHOavFi6tVCCVQtyJg=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id c7a288749cf7c812;
	Mon, 26 Oct 2026 05:36:25 +0000
X-Mizu-Trace-ID: c7a288749cf7c812
X-Migadu-Flow: FLOW_OUT
Date: Mon, 26 Oct 2026 13:36:13 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Hannes Laimer <h.laimer@proxmox.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 0/2] vxlan: keep reserved_bits on changelink
Message-ID: <at7mzU0z89CVdjki@fedora>
References: <20261023-b4-vxlan-changelink-gbp-v1-0-f0d13951c09b@proxmox.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023-b4-vxlan-changelink-gbp-v1-0-f0d13951c09b@proxmox.com>

On Fri, Oct 23, 2026 at 01:14:26PM +0200, Hannes Laimer wrote:
> Currently reserved_bits are reset on every changelink. This leads to
> packets using extensions that were enabled on creation being dropped
> after a changelink. The first commit describes the problem and
> solution in more detail and the second just adds a selftest for this.
> 
> Signed-off-by: Hannes Laimer <h.laimer@proxmox.com>
> ---
> Hannes Laimer (2):
>       vxlan: keep reserved_bits across changelink
>       selftests: forwarding: vxlan_reserved: add gbp changelink test
> 
>  drivers/net/vxlan/vxlan_core.c                           |  2 +-
>  tools/testing/selftests/net/forwarding/vxlan_reserved.sh | 15 +++++++++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
> ---
> base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
> change-id: 20261023-b4-vxlan-changelink-gbp-de5e81eed8d1
> 
> Best regards,
> --  
> Hannes Laimer <h.laimer@proxmox.com>
> 
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
