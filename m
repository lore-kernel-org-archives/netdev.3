Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D1C4052C4
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 15:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790436105; cv=none; b=hmegxqWIw+m8of3ry7A66lV/LI6FH+QJwkxBJ/Sqmq7zrSdcVKxhH0eVA8r2TL99pVeZhAM2CWmh7kQ4Vg6F5vruiq4xFUeIKXTyFw3+cFWWzT1qA9PJLkJvO8AYW6Sm/QOGbp3PhgeKWctx/FX4Cf0OiU2NrUcEZ4GGvi8QqKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790436105; c=relaxed/simple;
	bh=0umEdwiL8pHccpdqd2wUgGrHwmhXMyTGQxPB/23fc2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FH38iyGcjYgc0nAVyLH9wmfpboqKV6NB3SKWrS6QLTUEmJ+a37oU6f/dQ0xkAFqVawL5gGOvtyaSvWda/92QO1BOE/bqwmEDeBeDiyPygPoPjtaimxjqyzhu9DGiHV3Q6VJAQkA4RTl1b+mcdG7nMhq1fHF8sK6zLLIeWhLKLX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz8t1790436087t11894747
X-QQ-Originating-IP: lOj93Et+AslTzArJ8F/+z6u0i9S4wSuteJ+XAzVqYrc=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 26 Sep 2026 23:21:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14288034212453184480
EX-QQ-RecipientCnt: 12
Date: Sat, 26 Sep 2026 23:21:24 +0800
From: Yibo Dong <dong100@mucse.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vadim.fedorenko@linux.dev,
	u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yaojun@mucse.com
Subject: Re: [PATCH net-next v13 2/5] net: rnpgbe: Add basic TX packet
 transmission support
Message-ID: <E0433BAD8940027F+20260926152124.GA880591@nic-Precision-5820-Tower>
References: <5CF5340DA3D4CE3C+20260920092622.345496-1-dong100@mucse.com>
 <178998604523.2160803.309404195274642417@kernel.org>
 <20260925160705.GQ13925@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260925160705.GQ13925@horms.kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: NMaN42BznLNVZKtCsvqOL87ALy0xN43izqeCuNW1Y2KhIxOmN32OUntH
	mN7mNnZIKdotf9v/QEFmpOgftTM1vK9E1JpKGLUsuir5u8E7DXy4esBUVL/+PQavbLD5Nzb
	9iCPTzFTJuEjbK+YiCLP+fxnonGbiQApbGk+aXbm5un31LdaPxk7CdtwtxcNSyLJqR1AgK5
	k2/CzS/UK+GlxTyaj0TDd2/vy/q+zIH9nBRqrAQJuEosAmEcOXC+UXDiFnAmU//TfcvFed1
	/kbR7SntG9tj0W5McTIwjLu8MTOQaFXWd408jhaUSAiAZiyFhcOoP2GU+8u7ez8dojONelR
	4KRWxqrLJoj+mFyj0/FPZgLcbZC4bmd7sScJmC2U4UwwzfUVKi62Y0yQv9sVZEFmtbUggOK
	7d+GMxEpZw23HCnSyyOib9clb6OtRomEAJQWErcnDq719u0MoUZh+07WKTmpCQYBshtCxoe
	/RwYIWVk6WAiC3mF+PM9/zdFjqNcOKnDVbAx1lrnnJGQfpp8kA9jp/Ky0fvk2Afq9mm6OZc
	fgslnwM1+yfMkeeOEkW/YuSWgOBcwKx+ixlvfkbetVcFqapQUSKr5q1v1VKm2S2U3fuOJFL
	SbGj0TUw0UNmyBFF0YKil0lZD0OrckPlkhnDi4p9vz63djW5AnPH1fs4WvdVKakHXd0D5ty
	Cglmz4IizHBBbxV0NeCCJ3hUlUjcRDl/7+8MubZd/U1fqF4nyGBurDucx84iaXeFyOwFigM
	sOMfPpLH67a6UO9ff36auwXDnZ7TmvL2lAsLQnUxiTt40gw1v6PzMpqDAOlH4CpohRhapiF
	Zw6jtx+w529ohc8aeziozEft5KYlO4aPfm/TSa8lK2Zhzjj7mLuR+eL+69X34SX8ixiNbPM
	tPnu/Sj74Nb385sZvfDk3430OlCCOU/Foc7PupM7hbtX1JQDc9uTZXm73+NLKrV4CS66MG5
	CsVhgTVVzCUI4jTet8Aaq72FzNNfW4BFT8Pf05x2u/AOlX95A5b3L1oZtPSRwTaBwOgy8Fi
	T1gEOoORk5mIdMcFyFdb+9Jt5js2fjmcpDHGbE+wPmIblGJHam3sxzcg4TolP95V1w6SE3+
	Q==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

On Fri, Sep 25, 2026 at 05:07:05PM +0100, Simon Horman wrote:
> On Mon, Sep 21, 2026 at 10:20:45AM +0000, netdev-bot+sashiko@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 5 potential
> > issue(s) to consider.
> > 
> > Critical: 0 · High: 0 · Medium: 2 · Low: 3
> > 
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchwork
> > know by including "pw-bot: cr" as a separate line at the end of your reply
> > (one such reply per series is enough).
> 
> Hi Dong,
> 
> There is an expectation that the patch author responds to these
> AI-generated reviews as described above.
> 
> In order to move things along I'll provide some feedback on this one
> (but not the other's for this patchset).
> 

Thanks for the heads‑up and your feedback.
I will fix the issues and send out a revised version for this patchset.
Starting from the next submission, I will respond promptly to AI‑generated reviews.

> > 
> > [Severity: Medium]
> > Should the return value of dma_set_mask_and_coherent() still be checked
> > here? The previous code aborted probe and printed "No usable DMA
> > configuration, aborting", and dma_set_mask_and_coherent() is a plain static
> > inline int with no __must_check, so a failure is now completely silent.
> > 
> > If dma_supported() rejects a 56-bit mask, neither the streaming nor the
> > coherent mask is changed, the device keeps the PCI core's 32-bit default,
> > and probe continues through pci_request_mem_regions() to register_netdev().
> > 
> > The dma_get_mask() test above keeps highmem frags away by not setting
> > NETIF_F_HIGHDMA, but it does not cover the linear-data mapping in
> > rnpgbe_tx_map():
> > 
> > 	dma = dma_map_single(tx_ring->dev, skb->data, size,
> > 			     DMA_TO_DEVICE);
> > 	...
> > 	if (dma_mapping_error(tx_ring->dev, dma))
> > 		goto err_unmap;
> > 
> > nor the descriptor allocation in rnpgbe_setup_tx_resources():
> > 
> > 	tx_ring->desc = dma_alloc_coherent(dev, tx_ring->size, &tx_ring->dma,
> > 					   GFP_KERNEL);
> > 
> > So every frame whose linear data sits above 4GB would be dropped with only
> > the private per-ring dropped counter moving and no kernel message.
> > 
> > The commit message says only:
> > 
> >   "Configure streaming and coherent DMA masks for the hardware's 56-bit
> >   DMA addressing capability."
> > 
> > Could it also state that a DMA configuration failure is now non-fatal and
> > unreported, or could the check and the error path be restored?
> > 
> > The call is still unchecked at the end of the series, so no later patch
> > covers this.
> 
> I wonder if this is a side-effect of the development of this patch-set.
> It does look like a regression that should be addressed in this patch.
> 
I left the return value unchecked because Documentation/core-api/dma-api-howto.rst
states that dma_set_mask_and_coherent() does not fail for masks wider than 32 bits.
And feedback for other patches point this out:
https://lore.kernel.org/netdev/20260814123330.4b8056f5@kernel.org/
So maybe uncheck the return of dma_set_mask_and_coherent here is ok? Or
I should check the return?
> -- 
> pw-bot: changes-requested
> 
