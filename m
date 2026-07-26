Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6847F36896D
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 09:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785058644; cv=none; b=OoPbWNTrixKuYNZRTc/YCa72sdNnlrAINKNQ4pBUs7jSy41uBUmteW5EbYDeBvi9bEyzOFBFMNTIEhfB+4vQN4Kwsdzkq7zSNn1pKllaM0Z3c2aYYMQvbjUHZTCSpFoEgfYEQ7/gEZv9vKVJczR6Uvg+o5F2ppuyBcvn7LY59tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785058644; c=relaxed/simple;
	bh=pOkihfaSnSHKFjIH2jYWLyfC/YVUUltkKQn6KvurBZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W82OPQOxO6CVU3H2WL5WRleaY2nRHM2WoLMX7iSGyisLYbL7rwXuxgML2++EeuefRdPhqLw8A/VhyxRK8t82e9RwjSlPFfO6Z723M6vbISu7H5EV18tBLp//QPJn623kPYQDSlcAnwbtDT1JaEtW+uLXP83H1JQbWTbK+FXn+mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=fcpAg5dW; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="fcpAg5dW"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-495590dde14so18692335e9.0
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 02:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1785058640; x=1785663440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hV1QsjkSL3s3fZmRDM2JjQpq2lLGidA+2yjlX1i2gxM=;
        b=fcpAg5dWIIkkuAT8bZDTipUx1whNk5hhFft3wOsNLdty5v8AIaifGaBaDe1vBTugoi
         c78bBiE5WvMSdCIWSyRgO10+Ynh4Pty9ycSMRqajo79zyFLAMWRZsRMtuSutI6wVSStN
         hN7jmShD4JMjB+k70SekOUwF2++anwMO9nS88G4ijheQ7oGUaq/rqiu5KANP9H0T89QJ
         yV+rkkjEZxt3rb6GwhUmFGL0iNmYsioBVa917pFWZ1GWIZPXxNiqK8HiA0kkZOI5vUgt
         e5j2NkiJmle16DAM1SPj2B8BO4tVTaAUvKs3c3CL6WOZYgjFsfWXJHNanaUjITke5Jzp
         1s/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785058640; x=1785663440;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hV1QsjkSL3s3fZmRDM2JjQpq2lLGidA+2yjlX1i2gxM=;
        b=cldq5KGMbIvwQSZZGwnaNz2zcAO1Ve4d/YS/9DxAtIcsU/zkobp0kh3LAllYFPdVig
         wHflBNPSk1JV/R6gAVDyVU7300c2SWS5lPSqYvRgQSaYrqyD9sPMkwAtc6eVCWChDNZA
         66i1mGDer7X1D5yS3OC/xnNbaT+4uJ8hC7P4d6rKGhP8SCGMhAs9ufgJPTr6uZaG9f1B
         Li6F/n3X/GSjKtby+u/6tQialzJjx9v2WvGhiWSCLwiCiH1MiePHtiAv7zW+PN3mVv9s
         dK1PCs2BxLN+n6Jq6f7y5ppU3nWZkgUX8z3FwIatfYFXXMp/OXp2DUvsPeeVU4kbB7Ar
         GZDQ==
X-Forwarded-Encrypted: i=1; AHgh+RqlWOXjZgWCsP0ziw6StGeLHcgCmxN62Y34GV0CnzuPNNJ0CqJ3XUqqoMNA7Xo3w8n/cnGLdKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7hfrL8dEbie8lFT1QiyQYHrB4wtTJvWg7jS0aMn4FAAPoJacy
	c7K2ZU4n5/GevHgFtJJIJ4cq67IgO7XZMzQlarwByOs9uvKGtuzFE8mdcpNq2g40mss=
X-Gm-Gg: AR+sD11CGzTSRr6LwwdUKao8okYPFCrBxRxxMFZbAxC3kCfXKyksgebwKOuY9OIMAVC
	9JgZLF5XWj8IB+LP2caP8vsBuwsQIBoreA+SManZYyCSOviWmqtXvoD1FH6pyAd5X57dJ4RwSqQ
	Qnt43iMwXZTMSnC/KVtfiMzWbwREed/GGnUgZR8NcXOzqIa0Bt5BlvHXKwjhuR4oliYUq7Ibxol
	j1q05ld3GbmU1CGRRbb6PxfAE2inXd9QeWERlSXcovphyjKuLSE7davQAVdRXJ5yzjW2dYCKpSR
	QbHXnhu53pcBgGoJOYciCZ8LBqohoqLxumPaSfUwEB44OUUOjYSgmV85HrhAYj0LbjuyPGrIgGN
	wKm6sGQdjGCfrSYv1MgbveNgvzilR0W4vgjpaojg98q9TTw1wxq5p1FRIqEuYVvaKX7YbNnrKLw
	==
X-Received: by 2002:a05:600c:190a:b0:495:7a5a:d96c with SMTP id 5b1f17b1804b1-496b5719f68mr52364865e9.18.1785058640096;
        Sun, 26 Jul 2026 02:37:20 -0700 (PDT)
Received: from localhost ([109.160.73.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4866813sm150689605e9.8.2026.07.26.02.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 02:37:19 -0700 (PDT)
Date: Sun, 26 Jul 2026 12:37:17 +0300
From: Nikolay Aleksandrov <razor@blackwall.org>
To: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
	kys@microsoft.com
Subject: Re: [PATCH net v2] bonding: alb: re-check primary_is_promisc under
 RTNL in bond_alb_monitor
Message-ID: <amXVDy4aEa84He3S@penguin>
References: <20260725233930.2957317-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725233930.2957317-1-xmei5@asu.edu>

On Sat, Jul 25, 2026 at 11:39:30PM +0000, Xiang Mei (Microsoft) wrote:
> bond_alb_monitor() reads primary_is_promisc under RCU, then drops RCU and
> takes RTNL via rtnl_trylock() before undoing the promiscuity it set on the
> active slave. In that window the active slave can change under RTNL
> (RTM_DELLINK -> __bond_release_one() -> bond_alb_handle_active_change()),
> which already drops the promiscuity and clears primary_is_promisc. The
> monitor still acts on the stale decision: if the slave was removed with no
> failover, curr_active_slave is now NULL and the deref faults; if it failed
> over, the stale dev_set_promiscuity(-1) underflows the new slave's
> promiscuity counter and pins it in IFF_PROMISC.
> 
>   Oops: general protection fault, probably for non-canonical address ...
>   KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>   Workqueue: b42 bond_alb_monitor
>   RIP: 0010:bond_alb_monitor (drivers/net/bonding/bond_alb.c:1600)
>    process_one_work (kernel/workqueue.c:3322)
>    worker_thread (kernel/workqueue.c:3486)
>    kthread (kernel/kthread.c:436)
>    ret_from_fork (arch/x86/kernel/process.c:158)
>   Kernel panic - not syncing: Fatal exception
> 
> Re-check primary_is_promisc (and curr_active_slave) after taking RTNL so
> the monitor only undoes an increment it still owns. The other bonding
> monitors already re-read state under RTNL in their commit phase
> (bond_miimon_commit/bond_ab_arp_commit); bond_alb_monitor() was the only
> one acting on the pre-trylock decision.
> 
> Fixes: d0e81b7e2246 ("bonding: Acquire correct locks in alb for promisc change")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> ---
> v2: keep vars' rev-x-mas tree order
> 
>  drivers/net/bonding/bond_alb.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
> index 2d37b07c8215..839f7482dc18 100644
> --- a/drivers/net/bonding/bond_alb.c
> +++ b/drivers/net/bonding/bond_alb.c
> @@ -1534,8 +1534,8 @@ void bond_alb_monitor(struct work_struct *work)
>  	struct bonding *bond = container_of(work, struct bonding,
>  					    alb_work.work);
>  	struct alb_bond_info *bond_info = &(BOND_ALB_INFO(bond));
> +	struct slave *slave, *curr;
>  	struct list_head *iter;
> -	struct slave *slave;
>  
>  	if (!bond_has_slaves(bond)) {
>  		atomic_set(&bond_info->tx_rebalance_counter, 0);
> @@ -1597,9 +1597,11 @@ void bond_alb_monitor(struct work_struct *work)
>  			 * because a slave was disabled then
>  			 * it can now leave promiscuous mode.
>  			 */
> -			dev_set_promiscuity(rtnl_dereference(bond->curr_active_slave)->dev,
> -					    -1);
> -			bond_info->primary_is_promisc = 0;
> +			curr = rtnl_dereference(bond->curr_active_slave);
> +			if (bond_info->primary_is_promisc && curr) {
> +				dev_set_promiscuity(curr->dev, -1);
> +				bond_info->primary_is_promisc = 0;
> +			}
>  
>  			rtnl_unlock();
>  			rcu_read_lock();
> -- 
> 2.43.0
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
