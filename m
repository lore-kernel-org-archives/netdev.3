Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01CF271443
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 14:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771253110; cv=none; b=j2VFpNY4q5J5Y6tgZiKVT+Sgs2GrhLQEUXtSu5CF5ZJW1l82L9hiGekr/XLBhUoiFBRbY6nFBnvnSzUlFsVerK5+VGfHT5rL6drXu+zBlK/wieHFkqqJHAJfwaleygmsq/AMhdekbjTiSdu2RppRJn4OP3RzPVFC8lMCG+8/3A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771253110; c=relaxed/simple;
	bh=vVbYTQNtCLrZJRLZTjnE1u4Fp+d7jcknTeQtRoqN3tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkM1VoRHLj2IuwFr+vY74Hx33gVgKlBRdE34B9hkbzpVEvuUxtPHu+kAH12MQ1LsS93iKpGJHaqHwBHWUwMPkr32Rcod03p4kVYF7wkJFS6jDGCjuVYZ55AcF4lXDUUTMIzRgXTEhoBg88qoH2hG6VnkGoBmoeUAnSX7uoBFjh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=uk0EZKep; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="uk0EZKep"
Received: from ms-a2 (211.4.31.150.dy.iij4u.or.jp [150.31.4.211])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61GEivIf039544
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 16 Feb 2026 23:44:58 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=5bCpWiEp9VW4lJCKmXR8/tiro6CGPU2d80FCuwGyxp4=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1771253098; v=1;
        b=uk0EZKepyhoHCuCSYFHOAEXm3SaFQfKqYZwpfRbilHzr5nML3QJXHKYbBNkpCPKi
         b3lcq+F+L/ISLXFyxcb2ADT300oOk5I7ZtLU26mSj5RqtUnNAtKTfk+DlzJy2BWI
         ML5EZZC3pykXxc+u/A6C+3LNW4dShQrIfPi7l5wP7B06UvTa+4MYRc5NBGoe2jYj
         BCpkhKYn+mPjw7HMyed/pag/uSgCku6pLstqihuzHh58nyjmENdhpRIu5TChXt7z
         yTykj11LKe3vtjTxXeaSJ3y+eWQSJ0rfvF2qbwALdu+/PGJp2wvdwFKCdu737HyL
         W8k1OOIyAq3zr2YOerIP7Q==
From: Kohei Enju <kohei@enjuk.jp>
To: horms@kernel.org
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net,
        edumazet@google.com, intel-wired-lan@lists.osuosl.org,
        jedrzej.jagielski@intel.com, kohei.enju@gmail.com, kohei@enjuk.jp,
        kuba@kernel.org, mateusz.palczewski@intel.com, netdev@vger.kernel.org,
        pabeni@redhat.com, przemyslaw.kitszel@intel.com,
        przemyslawx.patynowski@intel.com, witoldx.fijalkowski@intel.com
Subject: Re: [PATCH v1 iwl-net] iavf: fix out-of-bounds writes in iavf_get_ethtool_stats()
Date: Mon, 16 Feb 2026 14:44:57 +0000
Message-ID: <20260216144457.19871-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <aZMZTTXWtIO1ERpm@horms.kernel.org>
References: <aZMZTTXWtIO1ERpm@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 16 Feb 2026 13:19:09 +0000, Simon Horman wrote:

> > @@ -345,19 +344,19 @@ static void iavf_get_ethtool_stats(struct net_device *netdev,
> >  	iavf_add_ethtool_stats(&data, adapter, iavf_gstrings_stats);
> >  
> >  	rcu_read_lock();
> > -	/* As num_active_queues describe both tx and rx queues, we can use
> > -	 * it to iterate over rings' stats.
> > +	/* Use num_tx_queues to report stats for the maximum number of queues.
> > +	 * Queues beyond num_active_queues will report zero.
> >  	 */
> > -	for (i = 0; i < adapter->num_active_queues; i++) {
> > -		struct iavf_ring *ring;
> > +	for (i = 0; i < netdev->num_tx_queues; i++) {
> > +		struct iavf_ring *tx_ring = NULL, *rx_ring = NULL;
> >  
> > -		/* Tx rings stats */
> > -		ring = &adapter->tx_rings[i];
> > -		iavf_add_queue_stats(&data, ring);
> > +		if (i < adapter->num_active_queues) {
> 
> Hi Enju-san,

Hi Horman-san, thank you for reviewing!

> 
> If I understand things correctly, in the scenario described in the patch
> description, num_active_queues will be 8 here.

Yes.

> 
> Won't that result in an overflow?

I think it won't overflow.

In Thread 1, iavf_set_channels(), which allocates {tx,rx}_rings and
updates num_active_queues, is executed under netdev lock. Therefore
Thread 3, which is also executed under the netdev lock, sees updated
num_active_queues and {tx,rx}_rings.

The scenario flow lacked netdev_(un)lock, my bad.

Thread 1 (ethtool -L)       Thread 2 (work)        Thread 3 (ethtool -S)
netdev_lock()
iavf_set_channels()
...
iavf_alloc_queues()
-> alloc {tx,rx}_rings
-> num_active_queues = 8
iavf_schedule_finish_config()
netdev_unlock()
                                                   netdev_lock()
                                                   iavf_get_sset_count()
                                                   real_num_tx_queues: 1
                                                   -> buffer for 1 queue
                                                   iavf_get_ethtool_stats()
                                                   num_active_queues: 8
                                                   -> out-of-bounds!
                                                   netdev_unlock()
                            iavf_finish_config()
                            netdev_lock()
                            -> real_num_tx_queues = 8
                            netdev_unlock()

> 
> > +			tx_ring = &adapter->tx_rings[i];
> > +			rx_ring = &adapter->rx_rings[i];
> > +		}
> >  
> > -		/* Rx rings stats */
> > -		ring = &adapter->rx_rings[i];
> > -		iavf_add_queue_stats(&data, ring);
> > +		iavf_add_queue_stats(&data, tx_ring);
> > +		iavf_add_queue_stats(&data, rx_ring);
> >  	}
> >  	rcu_read_unlock();
> >  }
> 
> ...
