Received: from mta0.migadu.com (out-16.mta0.migadu.com [91.218.175.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC395411F95
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769342; cv=none; b=P8kGicuuUUOq4lLt8TYNxe70Vt8sira3sH7BUIDygiCvlmPCKiflBzTWdPrL/TT8XDfyJcT59guFIA3w+Z2JFSqhgMzX74NJizUkVjuEX11nQEw2lCEJihalm1PEIQH1gBTuUvzQehhBb94oDMhb48OrR9k1B9a7JyRYA8ZTosw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769342; c=relaxed/simple;
	bh=LSTwH7YPnh688EaYa+Imxdg38h8r1Vt9jgw0Fed1QyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rR3aePVoJSsg+LkC+dske3qiC2V8GXbVpikYa2WqikT6UtnOE34NtHBLTKxVTyKgEyBxzZSKWTlU73m5ME2lCKdTHKVRCA3V8T/Qw431/DBu3AxbmFKBDn3nYRteLNzfbYU6uBU1DggN89CDNMfNoqdnCPdf9484t9/1mkQmqdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fZftVR6Y; arc=none smtp.client-ip=91.218.175.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fZftVR6Y"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=LSTwH7YPnh688EaYa+Imxdg38h8r1Vt9jgw0Fed1QyU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788769337; v=1; x=1789374137;
 b=fZftVR6YanTIOg4Vz/I0mzDxKtlnB+68uKSv00O1+jJ5MBowD9ZRI+Gyx+O1E2U8LbfdEvyM
 N8CB0Wnj50L6LbmDVPaogR8Rz6BCRaQ3cSraaxEroRmqjydLY+dlI/R6Cgt5nbY0RT/q/T74F7v
 +wWzTlufO+xhrmVpz7aih3Co=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id a05b63f883a0db4a;
	Mon, 07 Sep 2026 08:22:17 +0000
X-Mizu-Trace-ID: a05b63f883a0db4a
X-Migadu-Flow: FLOW_OUT
Date: Mon, 7 Sep 2026 16:22:07 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jussi Maki <joamaki@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>
Subject: Re: [PATCH net v3] bonding: fix slave_cnt leak on XDP error paths
Message-ID: <ap50L7dUBxZulHWK@fedora>
References: <20260907-bond_slave_cnt-v3-1-57df3b3cf2cb@kylinos.cn>
 <c5d539bb-3bb6-4f76-8c75-05a8f240c39f@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5d539bb-3bb6-4f76-8c75-05a8f240c39f@blackwall.org>

On Mon, Sep 07, 2026 at 10:41:50AM +0300, Nikolay Aleksandrov wrote:
> On 07/09/2026 10:07, Hangbin Liu wrote:
> > From: Hangbin Liu <liuhangbin@kylinos.cn>
> > 
> > When bond_enslave() succeeds up to the XDP setup stage, slave_cnt is
> > already incremented. If XDP setup subsequently fails, the error paths
> > jump directly to err_sysfs_del, bypassing the slave_cnt decrement.
> > 
> > This causes slave_cnt to drift upward on each failed enslaving attempt,
> > which would lead to unbalanced traffic distribution with round-robin
> > mode.
> > 
> > Fix it by moving the slave_cnt increase after XDP setup.
> > 
> > Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
> > Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
> > ---
> > Changes in v3:
> > - move the slave_cnt increasement before bond_update_slave_arr() (selftest)
> > - run all bonding selftests on debug kernel to make sure no regression (Jakub)
> > - Link to v2: https://lore.kernel.org/r/20260903-bond_slave_cnt-v2-1-02e27304ca36@kylinos.cn
> > 
> > Changes in v2:
> > - move the slave_cnt increasement after XDP setup (Nikolay Aleksandrov)
> > - balance-xor mode is not affected, not mention it (Nikolay Aleksandrov)
> > - Link to v1: https://lore.kernel.org/r/20260902-bond_slave_cnt-v1-1-36e95bf4a6ff@kylinos.cn
> > ---
> >   drivers/net/bonding/bond_main.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> > index a9bff7663eec..1514a8ba0888 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -2284,7 +2284,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
> >   		}
> >   	}
> > -	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt + 1);
> >   	netdev_compute_master_upper_features(bond->dev, true);
> >   	bond_set_carrier(bond);
> > @@ -2332,6 +2331,9 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
> >   			bpf_prog_inc(bond->xdp_prog);
> >   	}
> > +	/* Increase the slave count before rebuilding the slave arrays. */
> > +	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt + 1);
> > +
> >   	/* broadcast mode uses the all_slaves to loop through slaves. */
> >   	if (bond_mode_can_use_xmit_hash(bond) ||
> >   	    BOND_MODE(bond) == BOND_MODE_BROADCAST)
> > 
> > ---
> > base-commit: 38b6be101006d3e7af972999f45d4f1e8250587a
> > change-id: 20260807-bond_slave_cnt-88e78c5f0ab9
> > 
> > Best regards,
> 
> I think the comment is redundant, of course we should change slave_cnt before it
> is used by anything that needs it.

Yeah, this is a reminder if someone else need to move it to other place.
I can remove it if others also ask.

> 
> Anyway, the patch looks good:
> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

Thanks again for your review.

Regards
Hangbin
