Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794162775;
	b=vAWZbgyTQ76P5PKNHqLy4PLmDuFZzdp/Bu8vGo0iV0k3mBdt6A+wNsmJUucKP9+XJ1lw
	 Y3kM+ihoMjL7ANVH13cXw9Q+2ISt28U04akd+LjfczqFELOJXp5EFWtFEQN07XycJs6gF
	 RBgoMmj/xE6W1xJ9md+0u21sb3t6t/4aLHNu3ST0YPr1a1OQgKkNYla+GKn7lXhbOj0Z0
	 ZtijEqrED38dMeGwJucfo2DrQFYSwmck0r9fFw+YNuDd1aJ4J6MEsBkY5NjYSSMv5jMtS
	 PKKPTShwkCMrs+jigYC6W5xO4TpHAT1K7vBs4BrRmWPs+2zhLf3xNFrXbYKMo+ifzlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794162775;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=N5dUptyXKtymXcF3BYXgfRvm6MlHnsEhV3IJM/biYQ8=;
	b=VdV7DV/izQ+qggDCy88tKugrVIW7Us/WO8I8EynNQgdDrCQxE6zgyWHKwsOgdi1xGz3o
	 WXqkQM+gtfqBm1rgLfk2Kf1H+jXiuOwmBo2b/WIIHlsvEk38Bbe5GP/CTa7i0wpDZSGh5
	 tV+csWjvi8PW/n8TCEMNiejBT4JVY/v4FVO6oDTLw46p0cdjj2g4YGFif4F1dMA2giz1S
	 ugXoR03LnRi5VsRxexve1PSaLU+aiu7L7QZ3IdEo4H2/mHiAp8uFluGyMkM5xZ0X6izr3
	 q0xKzwieYb0Ce1icBTJL5OWJS6vikEhPEA9zkxvEF2RX9IVunYANTgef7KDxGApibwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W3m9nWxT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82A7606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 18:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W3m9nWxT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBD21F0089F;
	Sun,  8 Nov 2026 18:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794162774;
	bh=N5dUptyXKtymXcF3BYXgfRvm6MlHnsEhV3IJM/biYQ8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=W3m9nWxT2IxSjNfirhnfFytvZ/GiejSDsBBQVrCpmu7yVrnIG47uuoAalyVHKzBzV
	 9Kr2Dz+2/l84VR3zEVO2eqoQfgMNuQ8RONbF68wHY/fTOE3vA6d5QIU7SOh6N+GWJF
	 Gh9QvRJxUbihnpCNTyRA3YNS3ITMuZP0tpRrD3eBwMB3NJNMMeyG4yiKPpxafSEND7
	 LopKycjgnGp6wJD2wmxITVHcyqZpgY9XJSikc4u1zuW2ULOtzOU7Wf6hsU63HmsKSI
	 H4bYJXYEIAKQtuclKp2V4MFJCQRG/eJaSHNUmgif/HHovjGREnP8lCGj+FZG2yxTn9
	 5SUythStTBx/w==
Subject: Re: [net PATCH 4/5] fbnic: Suspend phylink after taking the datapath
 down in ndo_stop
From: netdev-bot+sashiko@kernel.org
To: alexander.duyck@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, kernel-team@meta.com, kuba@kernel.org,
 pabeni@redhat.com
Date: Sun, 08 Nov 2026 18:32:53 +0000
Message-ID: <179416277370.994134.16129749928882463511@kernel.org>
In-Reply-To: <179381516644.9644.9042901965231900737.stgit@ahduyck-xeon-server.home.arpa>
References: <179381516644.9644.9042901965231900737.stgit@ahduyck-xeon-server.home.arpa>
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

- [Low] The Fixes tag points at the wrong commit.

Pre-existing issues:
- [Low] This problem wasn't introduced by this patch, but the kernel-doc
  for fbnic_mac_free_irq()…

--

fbnic: Suspend phylink after taking the datapath down in ndo_stop

This commit reorders fbnic_stop() so that fbnic_down() runs before
fbnic_mac_free_irq() and phylink_suspend(). Tx can then drain while the
link is still up, instead of draining into a MAC that is disabled and held
in reset. The PM suspend path goes through ndo_stop, so it gets the same
ordering.

> Fixes: 6ede14a2c636 ("fbnic: Move phylink resume out of service_task and into open/close")

[Severity: Low]
Should this tag point at an earlier commit?

Before 6ede14a2c636, phylink_suspend() was already the first thing that
ran on the down path. fbnic_down_noidle() first called
fbnic_service_task_stop(), and that function started with:

drivers/net/ethernet/meta/fbnic/fbnic_pci.c:fbnic_service_task_stop() {
	phylink_suspend(fbn->phylink, fbnic_bmc_present(fbd));
	cancel_delayed_work(&fbd->service_task);
    ...
}

fbnic_napi_disable(), netif_tx_disable(), the RPC/rx-mode clearing,
fbnic_disable() and the fbnic_wait_all_queues_idle() call in fbnic_down()
all came after it.

At 69684376eed5, fbnic_mac_link_down_asic() already disabled the MAC and
held it in reset:

	mac_ctrl |= FBNIC_SIG_MAC_IN0_RESET_FF_TX_CLK |
		    FBNIC_SIG_MAC_IN0_RESET_TX_CLK |
		    FBNIC_SIG_MAC_IN0_RESET_FF_RX_CLK |
		    FBNIC_SIG_MAC_IN0_RESET_RX_CLK;

6ede14a2c636 moved phylink_suspend() from the top of fbnic_down() to just
before fbnic_down() in fbnic_stop(). It was still ahead of the queue
teardown in both places.

It looks like the ordering problem described here dates from
69684376eed5 ("eth: fbnic: Add link detection"). Would this be more
accurate?

Fixes: 69684376eed5 ("eth: fbnic: Add link detection")

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> index 8a6703afca384..52244219d1668 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> @@ -86,11 +86,11 @@ static int fbnic_stop(struct net_device *netdev)
>  {
>  	struct fbnic_net *fbn = netdev_priv(netdev);
>  
> +	fbnic_down(fbn);
> +
>  	fbnic_mac_free_irq(fbn->fbd);

[Severity: Low]
This isn't a bug introduced by this patch, but the kernel-doc for
fbnic_mac_free_irq() in fbnic_irq.c says:

 * This function undoes the work done in fbnic_mac_request_irq and prepares
 * the device to no longer receive traffic on the host interface.

The function only disables the PCS MSI-X control entry, calls
synchronize_irq(), masks the vector, frees the IRQ and clears
fbd->mac_msix_vector.

Host Rx is actually stopped in fbnic_down_noidle(), through
fbnic_clear_rx_mode(), fbnic_clear_rules(), fbnic_rss_disable_hw() and
fbnic_disable(). With this reordering, fbnic_down() has already stopped
host traffic before fbnic_mac_free_irq() is called.

Could the comment be updated to say that this only tears down the MAC/PCS
link interrupt?

>  	phylink_suspend(fbn->phylink, fbnic_bmc_present(fbn->fbd));
>  
> -	fbnic_down(fbn);
> -
>  	fbnic_time_stop(fbn);
>  	fbnic_fw_xmit_ownership_msg(fbn->fbd, false);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179381496288.9644.9775319757787890210.stgit%40ahduyck-xeon-server.home.arpa
