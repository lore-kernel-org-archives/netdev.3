Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.201
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793841538;
	b=muO5HDj4fJ6AH8oQ4V5s1BoMUtYGvJ+zzqvoFW/D/pVYFN1byLM0sSx8wEAwOwas0UEK
	 dqsHhivtmPJqJilFCHw10G7/19JONlZNih7suO5cW2TCSKD8BPrxmKHOJsk7KA+GRsfUU
	 8qQPDuwbZIlzQTALpb1fTifVMYaCv25fpND2IjnNdZz41f1IubcKWsREaGM7CI+tVH6di
	 cer3B7e5qj59WpMtzzONomkiYnaswGkHXsNGKSt9tlRcEd5XnP+6agxEcK266J7OP0gSh
	 T/bImO4ir7j91hbxETj3XOEuJGxLU9ZwvmzucUOevcAo/VoaJz1facdUVUAppvL2NXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793841538;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=33qkpdf9ukGrCIlvtoK0XJPAVaX1fyfDnYWQ0CErckU=;
	b=xovsKPREkTTGdwmvJvX76noavgjlRrfQGXclgovLTyeMgOP52Eq6vlXxnMJWLI7+cfZa
	 EGr7YoCiZL7nGPn8XdgevYn9BO5TNUp8Y6iPRdBH0sqwzJipMtpQ7dqg3xE5PXUCJKOcS
	 0ELPtpBgRcfroRFfBuYy3JojFrzOdvDLXEvGDVwmyrv2IjE4S8jKAzdma2HPrLsXwT+y6
	 qcAZEnJh1ZakS9kqEtbPQg2X7ahzM5C5LdtTKwQMuW55PmwE8ydqNJbHsRanx4UhPaO0M
	 3u/rBtUT5usDND1M+S3Ql9rcqcjFVPIfsXQaRLyvgB9VDHLku60o7R8esrCC2/1YMbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vnr9+srx;
	arc=none smtp.remote-ip=95.215.58.201
Received: from mta1.migadu.com (out-201.mta1.migadu.com [95.215.58.201])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF80606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 01:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FF80606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vnr9+srx
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=947IAn6HJ0NYIh2PUSsj5Xo94bVXq8zCjrEMI77rPVM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793841534; v=1; x=1794446334;
 b=vnr9+srxP6uif1XsIm7JqKFtPy3wgG0j7IQgAomqziWT3eRowu7koyLM91/TPftpnlL4ifc5
 Ul8MyFyK4Ga1t0Ab59el6oN6dok94Vie/uKaXFHY3nvdLPn5di3PlBsHmoD+7+1jgAtB5ecDbhs
 OKNz1bXmdiEVgcW08yezFBXM=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id c6f158b26a90fa81;
	Thu, 05 Nov 2026 01:18:53 +0000
X-Mizu-Trace-ID: c6f158b26a90fa81
X-Migadu-Flow: FLOW_OUT
Date: Thu, 5 Nov 2026 09:18:45 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Yun Lu <luyun@kylinos.cn>
Subject: Re: [PATCH net] bonding: fix slave_cnt leak on XDP enslave failure
Message-ID: <auvZdcFK5yW-bIW7@fedora>
References: <20261104092851.688361-1-edumazet@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261104092851.688361-1-edumazet@kernel.org>

Hi Eric,
On Wed, Nov 04, 2026 at 10:28:51AM +0100, Eric Dumazet wrote:
> bond_enslave() increments bond->slave_cnt before setting up XDP on the
> new slave. If that setup fails (slave has no XDP support, already has
> an XDP program, or dev_xdp_propagate() fails), the error path jumps to
> err_sysfs_del, which never decrements slave_cnt.


I think this is a same fix with my previous patch.

https://lore.kernel.org/netdev/20260914-bond_slave_cnt-v4-1-d14864a39e60@kylinos.cn/

ince you posted it, it looks like you agree with my fix.

Regarding the XDP and promiscuous/allmulti issues Sashiko reported, I think
those need a separate fix. The `bond_enslave()` function is over 500 lines
long and its logic is tangled. I’m working on refactoring it to make the
control flow and error paths clearer. Hopefully this refactoring will resolve
most of these problems.

For this patch, do you think if I can re-post it?

Thanks
Hangbin

> 
> Each failed enslave therefore leaves slave_cnt one too high:
> - SIOCBONDINFOQUERY reports a wrong num_slaves,
> - balance-rr picks slave ids beyond the end of the slave list, so
>   bond_get_slave_by_id() falls back to the first usable slave and
>   transmit is skewed toward it.
> 
> Reproducer:
> 
>   ip link add bond0 type bond mode balance-rr
>   ip link set bond0 xdpdrv obj xdp_dummy.bpf.o sec xdp
>   for i in 0 1 2; do
>     ip link add d$i type dummy
>     ip link set d$i master bond0   # fails: Slave does not support XDP
>   done
> 
> num_slaves read via SIOCBONDINFOQUERY is 3 before this patch, 0 after.
> 
> Add an err_dec_slave_cnt label ahead of err_sysfs_del and use it from
> the three XDP failure paths, which are the only failures after the
> increment.
> 
> Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> ---
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: Yun Lu <luyun@kylinos.cn>
> ---
> Discovered while reviewing https://lore.kernel.org/netdev/20261104064409.281303-1-luyun_611@163.com/
> 
>  drivers/net/bonding/bond_main.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 7019e5d8fdc8..7a394d0eb186 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2305,7 +2305,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>  			SLAVE_NL_ERR(bond_dev, slave_dev, extack,
>  				     "Slave does not support XDP");
>  			res = -EOPNOTSUPP;
> -			goto err_sysfs_del;
> +			goto err_dec_slave_cnt;
>  		}
>  	} else if (bond->xdp_prog) {
>  		struct netdev_bpf xdp = {
> @@ -2319,14 +2319,14 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>  			SLAVE_NL_ERR(bond_dev, slave_dev, extack,
>  				     "Slave has XDP program loaded, please unload before enslaving");
>  			res = -EOPNOTSUPP;
> -			goto err_sysfs_del;
> +			goto err_dec_slave_cnt;
>  		}
>  
>  		res = dev_xdp_propagate(slave_dev, &xdp);
>  		if (res < 0) {
>  			/* ndo_bpf() sets extack error message */
>  			slave_dbg(bond_dev, slave_dev, "Error %d calling ndo_bpf\n", res);
> -			goto err_sysfs_del;
> +			goto err_dec_slave_cnt;
>  		}
>  		if (bond->xdp_prog)
>  			bpf_prog_inc(bond->xdp_prog);
> @@ -2348,6 +2348,9 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>  	return 0;
>  
>  /* Undo stages on error */
> +err_dec_slave_cnt:
> +	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt - 1);
> +
>  err_sysfs_del:
>  	bond_sysfs_slave_del(new_slave);
>  
> -- 
> 2.53.0
> 
