Received: from mta0.migadu.com (out-22.mta0.migadu.com [91.218.175.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C730F4F5E0
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 00:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789864930; cv=none; b=quAyVydw5KWeSYxxi2LFJ54NAJo/2XRft+3GmGqIPifD5FB+IGQd0mGS2uSYi2ONI3ys1lDfWLA40u1d9RFVM2NNY/rgEFBSj4Krwz4eyt3jOiPA2hZf4riStxMm1YyMmRnQ8Q26kZlEYz2EuDpWvrI+V1kHQSg3uuFog8lZxdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789864930; c=relaxed/simple;
	bh=QEaVE2m8CGO8U9AP7AKRV19eWj0yHW+Dk2N/YZX+Nj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvhxthiMfFnEewcTEp4PfvC2ZVNxbPyE3TUDXfCIWhM0qpZmaNKetFaGcIi2Xao4/qtbj2Zkh79LBRk/lp5nASAynt99Xqv3nXFNY1gV/tFKufN7KyXQU+tmZ4rgmwZ/t55y892u3l6bngL784vqSa5hpDJwRH0uDYgCLuNTYOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f5q5udJt; arc=none smtp.client-ip=91.218.175.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f5q5udJt"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=QEaVE2m8CGO8U9AP7AKRV19eWj0yHW+Dk2N/YZX+Nj0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789864924; v=1; x=1790469724;
 b=f5q5udJt7cH7jP+VE+rhRPRDPQT0Vj/qSYe1oFCuUWe3WHAyzWdR1TdHBZBdwtoACa5cQ703
 ZsZHeia0JTU3s/OTzn+PEABSNLzxWCkSgFjnvTCDTfdLVOlcpmXYPtNBqOqTe1ip1ojN+1Mftd+
 xfmbKRVjJX+4h5LhQdJsqVwI=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 8e50ea4228a871cc;
	Sun, 20 Sep 2026 00:42:04 +0000
X-Mizu-Trace-ID: 8e50ea4228a871cc
X-Migadu-Flow: FLOW_OUT
Date: Sun, 20 Sep 2026 08:41:55 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: David Dai <zdai@linux.ibm.com>
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jarod@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, pradeeps@linux.ibm.com
Subject: Re: [PATCH net v2 1/1] bonding: crypto offload enabled, non-offload
 slave failover, rekey failed
Message-ID: <aq8r0zsm8_a7R5vD@fedora>
References: <20260918211155.1664493-1-zdai@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918211155.1664493-1-zdai@linux.ibm.com>

On Fri, Sep 18, 2026 at 04:11:55PM -0500, David Dai wrote:
> Create a bonding device (i.e. bond0) in active-backup mode, 2 slaves.
> Active slave: offload capable interface (i.e. eth1), primary interface.
> Backup slave: non-offload capable interface(i.e. eth2).
> Configure strongswan service swantl.conf child SA "hw_offload = crypto"
> Start strongswan service
> IPSec Crytpo Offload is enabled on top of bond0. i.e. 
> ip xfrm state |grep offload
>         crypto offload parameters: dev bond0 dir out mode crypto
> 	crypto offload parameters: dev bond0 dir in mode crypto
> 
> Active slave eth1 takes adavantage of IPSec Crypto Offload capability. 
> 
> If active slave eth1 is down for any reason (i.e. eth1 link down):
> ip link set down dev eth1
> non-offload capable interface eth2 failover to becomes active slave. 
> The existing SAs can continue use software IPsec after failover.
> Traffic still keeps going properly.
> 
> However if eth1 link had not recovered yet, strongswan service does
> new child SA rekey, or uses swanctl command to do new child SA rekey, 
> it will fail because active slave eth2 doesn't support crypto offload.
> In bond_ipsec_add_sa routine, it returns -EINVAL now, which is 
> treated as fatal error by xfrm_dev_state_add routine in kernel xfrm.
> 
> To make the non-offload active slave survive the child SA rekey, need 
> to make bond_ipsec_add_sa routine returns -EOPNOTSUPP instead when 
> active slave doesn't support IPsec Crypto offload, the xfrm will 
> gracefully fallback to create new SA using Software IPsec. 
> Network traffic can keep going.
> 
> After offload capable interface eth1 link is up, becomes active slave,
> next time strongswan child SA rekey will create a new SA which enables
> crypto offload again.
> 
> Fixes: 18cb261afd7b ("bonding: support hardware encryption offload to slaves")
> Signed-off-by: David Dai <zdai@linux.ibm.com>
> ---
> Changes in v2:
> - Add "Fixes: 18cb261afd7b ("bonding: support hardware encryption
>   offload to slaves")" in v2 patch comment.
> - Remove last line in v1 patch comment "This way, network traffic 
>   is never interrupted, always keeps going." to avoid confusion.
> - Link to v1: https://lore.kernel.org/lkml/20260903220123.475685-1-zdai@linux.ibm.com/
> ---
>  drivers/net/bonding/bond_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index a9bff7663eec..de2489c3d9bf 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -490,7 +490,7 @@ static int bond_ipsec_add_sa(struct net_device *bond_dev,
>  	    !real_dev->xfrmdev_ops->xdo_dev_state_add ||
>  	    netif_is_bond_master(real_dev)) {
>  		NL_SET_ERR_MSG_MOD(extack, "Slave does not support ipsec offload");
> -		err = -EINVAL;
> +		err = -EOPNOTSUPP;
>  		goto out;
>  	}
>  
> -- 
> 2.55.0
> 

Thanks

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
