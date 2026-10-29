Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290524;
	b=iIjgk2BQi+GlbhehUr3PwLt1WusF0qT2pjVBzjxXb8pVaNbRn/cE0WuLlNCov56YGOTO
	 y3gppDlr+iHXfNwgLqUetgOzw9RZi5Yxsqwo51EqP3G5JhC8WCy0wwbqX2UB8JTgRDGb2
	 KqYoPeMqc00jAzCzR/M9Dk8uHvpYgGRJNMZZELjlR35eMHJmKGWhfuNPWuKXZ4zwNrmTo
	 jrRD97ylyPDm3sCLowJdJ2uqOECDY4G9VDLYv44HIrikmkDCdMqxi5+FHpG6mFUCdudfu
	 cjjc0qYC416b7CgcTykGA5CuSR/dvFQXkH6r7hX0RglPBSzsoNQdQk93pveOanp5N1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290524;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=CV+I0WfjDJ8Xoj3e8ojq5cBu+5LIzM4ObkQfPuSQTBg=;
	b=0g/v+tWqno3D21pybyYUdnB3gN9rJHJGwpBoOBQhWuNBF3wJ9AjNXH6EnpeTH2jgz6mW
	 n/n1Ml78y/TmGmSHLld1u1DulxdJguEKnmVDMRMqKCHMwx5mYD4acspxFh5CH+ub7nqjk
	 AiyxWJvY0Qe5EBDoGyZKdIFFHcPv+PJB4lU0pJXsDYKqp/+SSpViGwOaWn4stl4/TeAr2
	 JS6PcWcDPWaZVl7XLA9bLEJppCL/iBLXbDDSFYxoC+kjpTnyLjkuKapGOfzUV4JQSP3K3
	 rYZs+1h74GQeMHhjgKfth+crHFoK2pulcAMtmzTrTLV3SKb4vOSKHJUip/ni6vTVIjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="J6/3Ybfd";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C73F606A32F;
	Thu, 29 Oct 2026 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J6/3Ybfd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF021F01829;
	Thu, 29 Oct 2026 16:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793290519;
	bh=CV+I0WfjDJ8Xoj3e8ojq5cBu+5LIzM4ObkQfPuSQTBg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J6/3YbfdXih6LdqmNzf85m3u+79OgsTyL8UXkkYqBpIkTUfwXf5ll4YphhX/1ShMe
	 JoP4HVfHwMgOSiYsP28WRA7TsmqG89V46NfbjZfyHkcOik16O8QD1aKlKxJP2cTNMA
	 DLQPzkk8aWimObKTP3+XXLHgw+lSQZwPG90ujG5FytxuQCIztbURtAlZKoD4y+C8cH
	 Q2GwhF7n7b4fq3s12KOFlUT4lLI7WHB4SgHXexuCMgxOs5csGwjEDj8TnbgcEz/EU3
	 zbLHa9mOTH9uGUHZCcRuueKo04Wzd/xICRK7l4P/2TdcU29phWPRtigIuPbiJ1zaoW
	 4W7pWYeeb3nyA==
Subject:
 Re: [PATCH net 07/11] net: au1000: fix buffer descriptor free list insertion
From: netdev-bot+sashiko@kernel.org
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, shaojijie@huawei.com, horms@kernel.org,
 runyu.xiao@seu.edu.cn, mmyangfl@gmail.com, hvr@gnu.org, jeff@garzik.org,
 danny.kukawka@bisect.de, mugunthanvnm@ti.com, sebastian.hesselbarth@gmail.com,
 linux-kernel@vger.kernel.org, manuel.lauss@gmail.com
Date: Thu, 29 Oct 2026 16:15:17 +0000
Message-ID: <179329051744.3134.5754193683869445346@kernel.org>
In-Reply-To: <20261027223140.3774570-8-f.fainelli@gmail.com>
References: <20261027223140.3774570-8-f.fainelli@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message and Fixes: tag present this as a functional
  bug fix, but the bug never affects runtime behaviour.

--

net: au1000: fix buffer descriptor free list insertion

The patch changes au1000_ReleaseDB() so the returned descriptor is pushed
onto the head of aup->pDBfree with its pnext pointing at the old head.
This matches au1000_GetFreeDB() and the list setup loop in au1000_probe().
It is tagged as fixing the initial git import.

> ReleaseDB links the old head to the returned descriptor and makes the
> returned descriptor the new head without updating its stale next
> pointer. This loses free descriptors and can create cycles. Link the
> returned descriptor to the old head instead, matching GetFreeDB and the
> list initialization.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

> diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
> index c0e38a507f892..f8976e324f0e7 100644
> --- a/drivers/net/ethernet/amd/au1000_eth.c
> +++ b/drivers/net/ethernet/amd/au1000_eth.c
> @@ -583,9 +583,7 @@ static struct db_dest *au1000_GetFreeDB(struct au1000_private *aup)
>
>  static void au1000_ReleaseDB(struct au1000_private *aup, struct db_dest *pDB)
>  {
> -	struct db_dest *pDBfree = aup->pDBfree;
> -	if (pDBfree)
> -		pDBfree->pnext = pDB;
> +	pDB->pnext = aup->pDBfree;
>  	aup->pDBfree = pDB;
>  }

[Severity: Low]
The new linking looks correct. Can the old behaviour actually be seen at
runtime, though?

au1000_GetFreeDB() is only called during the first ring fill in
au1000_probe(), before any au1000_ReleaseDB() call can happen.

au1000_ReleaseDB() is only called from two teardown paths. In both, the
next steps free the descriptor buffers and the au1000_private that holds
pDBfree and db[]. The first is the au1000_probe() error path:

au1000_probe() {
    ...
	for (i = 0; i < NUM_RX_DMA; i++) {
		if (aup->rx_db_inuse[i])
			au1000_ReleaseDB(aup, aup->rx_db_inuse[i]);
	}
	for (i = 0; i < NUM_TX_DMA; i++) {
		if (aup->tx_db_inuse[i])
			au1000_ReleaseDB(aup, aup->tx_db_inuse[i]);
	}
    ...
	dma_free_coherent(&pdev->dev, MAX_BUF_SIZE * (NUM_TX_BUFFS + NUM_RX_BUFFS),
			  aup->vaddr, aup->dma_addr);
err_vaddr:
	free_netdev(dev);
    ...
}

The second is au1000_remove(), which runs the same release loops and then
calls dma_free_coherent() and free_netdev(dev).

So nothing ever walks or pops the list that the old code corrupted. The
lost descriptors and cycles in the commit message would not cause a leak,
a hang or a wrong DMA buffer.

Could the commit message say that there is no runtime impact, and could
the Fixes: tag be dropped so this does not go to stable and the net tree as
a functional fix? Another option is to remove the au1000_ReleaseDB() calls
from the teardown paths, since they have no effect.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027223140.3774570-1-f.fainelli%40gmail.com
