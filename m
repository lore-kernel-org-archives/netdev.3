Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20331F4631
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462951; cv=none; b=W17JJmwN6Cgj7v+Mvg2MqqqsI4LTiX/E8f7xb5hq571xNQoxJH0P0BQmYW6KZkTCoYsTtBCXZ1GoRBzg/ZGW2qW7orpvKv1xHy8jml2IQQ8Qz8oFBKJ1QViUzHeLaLp8IX9FK93ZxT3ey0o5dKafsF/FDuLgHEisiTg93BWjWDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462951; c=relaxed/simple;
	bh=fBhK9E6T76/CETycbev/y4lAnQM+WBJpfCoqHexfnJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rRddBNC1PcAa+Kf2r+/UK9u4EA0vMaz9Bt5rsNX5f4Q4D2wph5Ed28YjsWMBH3ACdeDhrsYJcJx7MCrNvb9ixwFtFSrm/ih0M0oE6skQ/1SRsnpnl+fQQs15tZV2N+QXKXDbykMJvlWjWT6LFBx3iPkiqTcWIzp7+K6/6kQ2E2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pjwi9rM/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pjwi9rM/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9F51F000E9;
	Tue, 11 Aug 2026 15:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786462950;
	bh=+UvIubeMbDV226VLlx20SVBvFh/LAcXJjxm1IP+jovg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Pjwi9rM/25pdo0aQgH2TzuhLsqwYTO2CpQYNqCijeaIwqpcIYNEbwZgiu2fGrb0Y3
	 NsWEkFvJgNL8lvoLZPseGhfxE8zIyHpU0PHPl+uAeZeaYLvI1+A5LvMpJNu7wkTnRl
	 QMWv9L2qU1/XtsK0RSu3yKqRWxowsg9RskbmwsrAwC8vDTRgYlX7TdolxIwoOQZMVu
	 VCEvOozq2MEcpQ0YR92yl63ZEgQvPC8L0/1HsUshKN8a6Ax8KEc3lPNUhk/5CXbvxv
	 pYECpWHngVIwPxrTLe3+PGLrjEO2NdFbzepE4xpNgV1FRrDrU6KyXAjeYSzdfEjlP6
	 bm2H++AG07cnA==
Message-ID: <ee6e639c-558c-4538-afdb-3ab6c1c3476f@kernel.org>
Date: Tue, 11 Aug 2026 09:42:29 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 08/15] ipv4: Replace &arp_tbl with
 arp_table(net).
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@google.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Elad Nachman <enachman@marvell.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 Petr Machata <petrm@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Nikolay Aleksandrov <razor@blackwall.org>
References: <20260811022448.116235-1-kuniyu@google.com>
 <20260811022448.116235-9-kuniyu@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260811022448.116235-9-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/10/26 8:23 PM, Kuniyuki Iwashima wrote:
> We will allocate per-netns neigh_table in net->neigh_tables[].
> 
> Let's replace &arp_tbl with arp_table(net) and remove extern
> definition for arp_tbl.
> 
> Three notes:
> 
>   1. mlx5e_rep_netevent_event() and nfp_tun_neigh_event_handler()
>      have code assuming neigh_table other than &arp_tbl and
>      &nb_tbl, and the part is removed as it will be false once
>      per-netns table is allocated.
> 
>   2. prestera and rocker uses init_net because they set
>      dev->netns_immutable to true.
> 
>   3. mlx5e_tc_update_neigh_used_value() dereferences nhe->neigh_dev
>      in trace_mlx5e_tc_update_neigh_used_value().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> v2: Add note about mlx5e_tc_update_neigh_used_value()


Seems like this is not a bisectable patch set. References for arp_tbl
and nd_tbl need to be fixed up before switching to per network namespace
tables.



