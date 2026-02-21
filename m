Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD173EBF31
	for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 15:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771686349; cv=none; b=k/+wHGah1XHv/fg3inS6SLnUwi8gXnI9eKnB9HcRqnwWSXVy/o/GdXGmtxbkaeqBI/hI1lPJ3TCPEZoBpv8LiVU3hdZhEqEW98jvLcjCNPrrU8Y6tXKTQ+S4GFmX8Gbh23hJ2KU33HSPQDySZudS58PKCoi5AbErF69Jhdf1lfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771686349; c=relaxed/simple;
	bh=1SoG0KFED/ZRemdzvZfEt59idgMoFs+ppiHQOWwuSWM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LgLTx951OPcVyX+UuXpVo2TBDro5AsKrFvO1Sh99sEAEwH+R/O7rbk/8f2Dt2nXcXjR9zk1L/HRwvxutdZXdKIyAIA34Wjr+A9SASxpRbsOP2RW32BEcYZTB94Tn8RKndmEIhOh0nUzezY2OMH1MhsRz4mXTX83HMOpXayteU+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1Un026cT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1Un026cT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4Zxa70BsPBpyeKBArzZz+QYGD7sAD7nz2aOkeOx+vHw=; b=1Un026cTp3Z3wmcnuxdMV6H9iY
	U+uZJ7CSk/DbOWHuZ5DI6Xvf8Uy1i6OcR/THZWtjx80Ty4HCW2NDXz74fp6K1DrP9ST+dN+63E8Nh
	/oNmaXZ7dsgVKNqxMTFjUttqVhX8Ui7s0CYu8c5B8o/a/kaOmYp4F0OJspzBtzsgxLkdlccC351OY
	zBd58xJ4DdxVjfgkYDi2fzgLlMS24JdpYS15hCb88AeFSzFUYNnY/837H3chhGQba3VTEg/M/I+7N
	TKF1MogmgkcZbLXdQdRfaQdSKjbN0Ll5N+DV+g52ZovoUwwjPAQul7BRZSxFLD1AvAPH8VJWDcNnM
	wlhlTi4w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38186)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vtoYD-000000002bV-0iuu
	for netdev@vger.kernel.org;
	Sat, 21 Feb 2026 15:05:45 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vtoYC-000000005Ps-0BTq
	for netdev@vger.kernel.org;
	Sat, 21 Feb 2026 15:05:44 +0000
Date: Sat, 21 Feb 2026 15:05:43 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: netdev@vger.kernel.org
Subject: Question: stmmac xmit: GSO vs TAPRIO max-sdu
Message-ID: <aZnJx4Mea7Ns-tsU@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

I've recently been looking at stmmac's descriptor code (and finding a
few bugs along the way...) I think I've found another bug.

stmmac implements various TC offloading, including some TAPRIO support.
This supports max_sdu, but it seems it is only implemented for the
non-GSO path:

        if (skb_is_gso(skb) &&
            skb_shinfo(skb)->gso_type & priv->gso_enabled_types)
                return stmmac_tso_xmit(skb, dev);

        if (priv->est && priv->est->enable &&
            priv->est->max_sdu[queue]) {
                sdu_len = skb->len;
                /* Add VLAN tag length if VLAN tag insertion offload is requeste+d */
                if (priv->dma_cap.vlins && skb_vlan_tag_present(skb))
                        sdu_len += VLAN_HLEN;
                if (sdu_len > priv->est->max_sdu[queue]) {
                        priv->xstats.max_sdu_txq_drop[queue]++;
                        goto max_sdu_err;
                }
        }

stmmac_tso_xmit() doesn't do any max_sdu checks. Is this correct, or
should the order of the above two if() statements be reversed so the
max_sdu check is also done for TSO?

(The TSO check in the above code will look different form what's
currently in net-next, as I already have a large pile of cleanups in
this area. However, it is functionally identical.)

Another question arises: gso_enabled_types is modified in
stmmac_set_features(). Is it possible that there are GSO packets
in the higher level networking queues while the netdev features are
changed, which could result in GSO packets being passed into the
netdev after e.g. GSO has been disabled, or are we guaranteed that
after .ndo_set_features() has been called, we won't be passed any
GSO packets?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
