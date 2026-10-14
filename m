Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123A6547069;
	Wed, 14 Oct 2026 02:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791946755; cv=none; b=ru0gTSGhs5LcCXcwcfJKr2jPX+TzwlldB+VuAHryA5+R7WgJ+AEJxgZJAQ5xgonAg/bz0i1MWbOpdRHyplsOiTbD8olHsZjVmdyEE0t0E3gQJVUr7gLnF5/VYqMvMHZ8dwu/OpEukmkxtXdCu8LBruIWwMhF7P9QeAOwAVSaKwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791946755; c=relaxed/simple;
	bh=qkdGT4/3MeM0wJoZi3kT/3un768SUlkCg82wEbc/OXs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pclee1/J87dc9Sis3ImmIrqfjTmY8eR+PWc320vfvSR3HhY15IqXDhaUtlITasr5IlO6AlBnCueLjiuKSYDt5+gi8i1XxUQXkiRyP92pzI73OHAOeD92mq2jkE2fowg6N9exsFwrq+zAwwCcMvlccdTCjz7qPwIV33pZUtLiFUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhxDPc4c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhxDPc4c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8141F000FF;
	Wed, 14 Oct 2026 02:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791946753;
	bh=8g0oV9u03694sGT88Tbdvul2lqVZJXMHy1lAgGcGObw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nhxDPc4cQn4fSkXzPMAFqPetDHV/JfIhM7CSvCxpTb3dT46yAmDF2CeEd5XsbMuQ3
	 KEOTGYQCLdjDOOWqLBmFbNkzWR5qIKZmhgsoibDyximoqvMYtpFLlRmifx9GeQ8PvO
	 3y4p1EZ4VJ1hXjBGTx5O6PeX/r1hy7WRU//I1HxAma396fSeuV9mX8ddl0rxrkyKTl
	 UqvgblkYVFLnC0RbUwsPqTlMbN+QPT6X1GQqkBIIovgo+Aq3G14a49bNoGcZrNmBXH
	 1EKRpiTS0orGy/cC6j7YjOwzlKjn4TQNTdMwxhHliTau4OFAp82nWugYc/3Ascbs5Z
	 zjB6khPsiw6Aw==
Subject: Re: [PATCH net-next v16 1/5] net: rnpgbe: Add interrupt handling
From: netdev-bot+sashiko@kernel.org
To: dong100@mucse.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaojun@mucse.com
Date: Wed, 14 Oct 2026 02:59:12 +0000
Message-ID: <179194675270.434549.14836976664474746215@kernel.org>
In-Reply-To: <A4AA29A72BA34A26+20261013023025.63622-1-dong100@mucse.com>
References: <A4AA29A72BA34A26+20261013023025.63622-1-dong100@mucse.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch is titled and described as "Add interrupt handling",
  but it also changes how the already-merged driver shuts down and is…

--

net: rnpgbe: Add interrupt handling

This commit adds MSI-X interrupt setup and teardown for the rnpgbe driver.
Vector 0 is reserved for the mailbox and the remaining vectors are used for
the data path. Mailbox lock polling now uses a sleepable variant, and a
shared helper sends the firmware powerdown notification from both remove
and shutdown.

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> index 70a2b0082ba86..6022a1a2ddf1e 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c

[ ... ]

> @@ -236,6 +281,26 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	return err;
>  }
>  
> +/**
> + * rnpgbe_notify_powerdown - Notify firmware that the driver is going down
> + * @mucse: pointer to private structure
> + *
> + * Skip the mailbox access if an earlier shutdown has already disabled the
> + * PCI device.
> + **/
> +static void rnpgbe_notify_powerdown(struct mucse *mucse)
> +{
> +	int err;
> +
> +	if (!pci_is_enabled(mucse->pdev))
> +		return;

[ ... ]

> @@ -272,7 +335,8 @@ static void rnpgbe_remove(struct pci_dev *pdev)
>  {
>  	rnpgbe_rm_adapter(pdev);
>  	pci_release_mem_regions(pdev);
> -	pci_disable_device(pdev);
> +	if (pci_is_enabled(pdev))
> +		pci_disable_device(pdev);
>  }
>  
>  /**
> @@ -287,9 +351,14 @@ static void rnpgbe_dev_shutdown(struct pci_dev *pdev)
>  	rtnl_lock();
>  	netif_device_detach(netdev);
>  	if (netif_running(netdev))
> -		rnpgbe_close(netdev);
> +		dev_close(netdev);
>  	rtnl_unlock();
> -	pci_disable_device(pdev);
> +
> +	rnpgbe_free_mbx_irq(mucse);
> +	rnpgbe_notify_powerdown(mucse);
> +	rnpgbe_clear_interrupt_scheme(mucse);
> +	if (pci_is_enabled(pdev))
> +		pci_disable_device(pdev);
>  }

[Severity: Low]
This isn't a bug, but should the commit message cover these teardown
changes? The only related text in the commit message is:

  Notify firmware of driver powerdown from both remove and shutdown
  through a shared helper.

The patch also changes how the existing teardown code behaves, and the
commit message does not describe these changes:

  - rnpgbe_dev_shutdown() now calls dev_close() instead of calling
    rnpgbe_close() directly.

  - rnpgbe_dev_shutdown() and rnpgbe_remove() now call
    pci_disable_device() only when pci_is_enabled() is true.

  - rnpgbe_notify_powerdown() skips the mailbox when the device is
    already disabled. Its kernel-doc says this is for remove running
    after an earlier shutdown.

  - Shutdown now sends a firmware powerdown, which the previous
    rnpgbe_dev_shutdown() never did. The commit message doesn't say why.

The dev_close() switch looks correct. rnpgbe_close() now calls
rnpgbe_down() and rnpgbe_free_irq(). Calling ndo_stop directly leaves
IFF_UP set, so a later unregister_netdev() would call it again and run
napi_disable() and free_irq() a second time.

Could these changes be explained in the commit message? Another option is
to split them into a separate patch, with a Fixes: tag if they address an
observed problem, so reviewers and backporters can follow them.

This code in rnpgbe_main.c is unchanged through the end of the series
("net: rnpgbe: Add link status handling support"), and no later patch
explains it either.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/3B42BE25B3696EAE%2B20261013022920.63529-1-dong100%40mucse.com
