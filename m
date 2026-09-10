Received: from mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAD1346E5E
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 03:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011096; cv=none; b=Jr1g98fXXkLaLOr+MUfHAImedKmlwlIv7pFAp9MNl4Hv3ztaSFM5S4FE4zb6N4u+sFsT3twYryHzJDgByW+uKsZY7loE8fQ1bkj6zyl3LQytctDe545Za3sQtWuBAygFIuZ+KXezR7CHl5YRt0sdRVNT2ng5eHhgqQ2LuHKV61s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011096; c=relaxed/simple;
	bh=aLkBeEJcdzZPX5usT8fQ/iUIo/4BaqB/Q9hmuUUytKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIchAlmNZC9EirHOJKAINVNQqZjTeJd/rddFmqLnTOdqYsoYO6e34ZuRozNlMnhNWA2M2f3AdE7Dz+stTWo5Tj2Tq53hmysACX4bu7UGFlMS3oWKXCruWK/2SoSeQC6Bi8ANUkRQXw87a9WjsU1OkekzYsm+/TpWZp65H7YG13o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C5n5reHX; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C5n5reHX"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=aLkBeEJcdzZPX5usT8fQ/iUIo/4BaqB/Q9hmuUUytKU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789011090; v=1; x=1789615890;
 b=C5n5reHXf6dNb5W1xkJQjnY2c8Fu+ggYLAubFPODXOHLio7uNxl1iMS4RL65GujdNXBVktTH
 PR1ehFkSG/THlnx8gDoZRlhR959nVF9vN/hHLhuPtWRIZHSz7VuTw7DLKEBm6rcTAOwp9vQAjEt
 u1YLfQo6Gw/WIFZTuNhBRiBE=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id dad1c01d340feea7;
	Thu, 10 Sep 2026 03:31:30 +0000
X-Mizu-Trace-ID: dad1c01d340feea7
X-Migadu-Flow: FLOW_OUT
Date: Thu, 10 Sep 2026 11:31:21 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	daniel@iogearbox.net, joamaki@gmail.com, razor@blackwall.org,
	linux-kernel@vger.kernel.org, liuhangbin@kylinos.cn
Subject: Re: [PATCH net v3] bonding: fix slave_cnt leak on XDP error paths
Message-ID: <aqIkiQD1Z-FcEsLQ@fedora>
References: <20260907-bond_slave_cnt-v3-1-57df3b3cf2cb@kylinos.cn>
 <178889459114.219967.6984751596437332187@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178889459114.219967.6984751596437332187@kernel.org>

On Tue, Sep 08, 2026 at 07:09:51PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Critical: 1 · High: 0 · Medium: 0 (1) · Low: 0
> 
> - [Critical] Newly introduced slab out-of-bounds write in
>   bond_update_slave_arr(): moving `WRITE_ONCE(bond->slave_cnt,…
> 
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but the XDP
>   error paths the patch touches are still incompletely unwound: the…
> 
> --
> 
> bonding: fix slave_cnt leak on XDP error paths
> 
> This moves the WRITE_ONCE(bond->slave_cnt, bond->slave_cnt + 1) in
> bond_enslave() from just above netdev_compute_master_upper_features() down
> to after the XDP setup block, so that the three XDP failure exits which
> "goto err_sysfs_del" no longer leave slave_cnt incremented.  The increment
> is placed just before the bond_update_slave_arr() call.
> 
> Link to v2: https://lore.kernel.org/r/20260903-bond_slave_cnt-v2-1-02e27304ca36@kylinos.cn
> Link to v1: https://lore.kernel.org/r/20260902-bond_slave_cnt-v1-1-36e95bf4a6ff@kylinos.cn
> 
> > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> > index a9bff7663eeca..1514a8ba0888d 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -2284,7 +2284,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
> >  		}
> >  	}
> >  
> > -	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt + 1);
>        ^^^^
> 
> [Severity: Critical]
> Can removing the increment from here overflow all_slaves->arr[] in
> bond_update_slave_arr()?

This is a false positive report. The bond->slave_cnt update is not removed.
It's moved just before bond_update_slave_arr().

Thanks
Hangbin

> >  	netdev_compute_master_upper_features(bond->dev, true);
> >  	bond_set_carrier(bond);
> >  
> > @@ -2332,6 +2331,9 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
> >  			bpf_prog_inc(bond->xdp_prog);
> >  	}
>        ^^^^
> 
> [Severity: Medium]
> This isn't a bug introduced by this patch, but the XDP error exits being
> adjusted here are still only partially unwound.
> 
> The three "goto err_sysfs_del" cases in this block ("Slave does not support
> XDP", "Slave has XDP program loaded" and the dev_xdp_propagate() failure)
> enter a chain of labels:
> 
> 	err_sysfs_del -> err_upper_unlink -> err_unregister -> err_detach ->
> 	err_close -> err_restore_mac -> err_restore_mtu -> err_free ->
> 	err_undo_flags
> 
> None of those labels calls dev_set_promiscuity(slave_dev, -1),
> dev_set_allmulti(slave_dev, -1), bond_hw_addr_flush() or
> bond_slave_ns_maddrs_del().  Those undo steps exist only in
> __bond_release_one():
> 
> drivers/net/bonding/bond_main.c:__bond_release_one() {
> 	...
> 		if (old_flags & IFF_ALLMULTI)
> 			dev_set_allmulti(slave_dev, -1);
> 
> 		if (old_flags & IFF_UP)
> 			bond_hw_addr_flush(bond_dev, slave_dev);
> 	...
> }
> 
> which a failed enslave never reaches.  So when the bond is IFF_PROMISC,
> IFF_ALLMULTI or IFF_UP and has an xdp_prog attached, does a failed enslave
> leave the candidate device with a leaked promiscuity/allmulti refcount, the
> bond's synced mc/uc addresses (plus the lacpdu multicast address in 8023AD
> mode) still installed, and the NS-target multicast addresses added by
> bond_slave_ns_maddrs_add() still present?  Since the device is no longer a
> slave, is there any path left that can drop those refcounts?

Maybe flush multicast addr after dev_close(slave_dev)?
Anyway, this is need another patch.

> 
> >  
> > +	/* Increase the slave count before rebuilding the slave arrays. */
> > +	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt + 1);
> > +
> >  	/* broadcast mode uses the all_slaves to loop through slaves. */
> >  	if (bond_mode_can_use_xmit_hash(bond) ||
> >  	    BOND_MODE(bond) == BOND_MODE_BROADCAST)

Thanks
Hangbin
