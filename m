Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8953CE4BD
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776782012; cv=none; b=CzVbXsyu5qAy1Rjv3cYZct2dyLiVJSTG22YHEB/z29djVhO5HWsiAs5kRE4M30zPKXBCQ0SYFDMQvFRhZOgGiwaTl1DPLDIdjXl/Kgu/t6BYni7ceEUXT0uPFiybZ6Q14ZjO0tRyobWTe7gCmLvURD0V3PqscPGRY5hA+I663Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776782012; c=relaxed/simple;
	bh=owD5oaIcc+vRnpaYo0FyalSKDi1/DvPEQsJIilTllE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtbtcCfAtii3xPMflrFWVKDHDn+Tv+fQkZCrJlB6xzou8hJc35WmrOc7FDAeAB1paHW42fvwHkClydsrQEfZAUodtOdRp/jaPR0Bjoz/26024nuMo+0BPCHdkz7VXz9JCuuAXnLvSV5H5NCWp5vGbWc1THHSPoYWDjnSDmJ2z34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 8745F10615;
	Tue, 21 Apr 2026 16:33:19 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7165A6033A2C; Tue, 21 Apr 2026 16:33:19 +0200 (CEST)
Date: Tue, 21 Apr 2026 16:33:19 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>, Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH net-next v6 11/11] net: wangxun: implement
 pci_error_handlers ops
Message-ID: <aeeKr8j8iHBUC8sM@wunner.de>
References: <20260326021406.30444-1-jiawenwu@trustnetic.com>
 <20260326021406.30444-12-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326021406.30444-12-jiawenwu@trustnetic.com>

On Thu, Mar 26, 2026 at 10:14:06AM +0800, Jiawen Wu wrote:
> +static pci_ers_result_t wx_io_slot_reset(struct pci_dev *pdev)
> +{
> +	struct wx *wx = pci_get_drvdata(pdev);
> +	pci_ers_result_t result;
> +
> +	if (pci_enable_device_mem(pdev)) {
> +		wx_err(wx, "Cannot re-enable PCI device after reset.\n");
> +		result = PCI_ERS_RESULT_DISCONNECT;
> +	} else {
> +		/* make all bar access done before reset. */
> +		smp_mb__before_atomic();
> +		clear_bit(WX_STATE_DISABLED, wx->state);
> +		pci_set_master(pdev);
> +		pci_restore_state(pdev);
> +		pci_save_state(pdev);

The pci_save_state() is no longer necessary here, please drop it.
See commits a2f1e22390ac and 383d89699c50 for details.

Thanks,

Lukas
