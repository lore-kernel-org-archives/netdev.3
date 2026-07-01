Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCCA3FBB66
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 10:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782902697; cv=none; b=lNDvneNL9+wVLQSX6bl4oRwTJUXNNU+6eNRLJNV5MaZ/N/+lxhI7pcSjqPWLUIrV5Ga3u4TJDQujNxyQbN696lov1d3AYZnbn5R1gTAqRFxzue7O++T1m3C+UmswIR+YeW+GYy/VPwkXl3QENi/cVsp9qcF8Yu/gOiTF2ZEdImM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782902697; c=relaxed/simple;
	bh=D/vBBwBsOv6LCFJVb8CYh/XxO4FuXAOFO0vEjsc9Mps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWloaQUO9iEkC7StTJaIY1taS9LYTDeeCNOmUWGHmAzzR8/aWifHpAyT6Uxe/05jyp1leCSYR4w2wn1lD1r98IoDsm3+TF+MaHMmChH5i7Zz8R9vJGa64zAeS3ZY4/PNGz2EU2jbgdB2CvMeFm/UtIcaOXs1iuqNWa0bZpXERAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=RSa6cvkk; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="RSa6cvkk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MlO9/xg58sbko0NqILOg0eZp8g27KvCJW04RWhfiJUI=; b=RSa6cvkkwFrNTNhFaXT8r6cHd0
	hYJtXgUqy22fmyMIzJWPAHxcnHeqVv7oTNl0w3LJ8NbhIJeJ3ovza5IKACjxwNZSsVri8AM7K7jHo
	CaS9XME8c2jbmonHiWFpWsGEaHtLY07quanJRlt2TSELgXWQPtA4zdCMLO8WnsKWdM4KHKCc+d5EF
	O9xqojk+7bQWaajzbXjTlrmWZJbUyV5C3A2MDb4+S7INPumkyOvoBtHIdFwQSh2tXJSsiu2HYhlcB
	YPlzooKsWmaSE20rcPROl2nDS6yA4EeajtzHUX35ecEc2eI4EW0SzEkz/tbuB3QUk2yUQvcqYV127
	ql0CPkNg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wesQq-007mqI-15;
	Wed, 01 Jul 2026 10:44:40 +0000
Date: Wed, 1 Jul 2026 03:44:34 -0700
From: Breno Leitao <leitao@debian.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
	Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Thomas Gleixner <tglx@kernel.org>, Rongguang Wei <weirongguang@kylinos.cn>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: Re: [PATCH net-next v9 5/5] net: wangxun: add pcie error handler
Message-ID: <akTvTF7n9P1lrqCN@gmail.com>
References: <20260701072357.33984-1-jiawenwu@trustnetic.com>
 <20260701072357.33984-6-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701072357.33984-6-jiawenwu@trustnetic.com>
X-Debian-User: leitao

On Wed, Jul 01, 2026 at 03:23:57PM +0800, Jiawen Wu wrote:
> +static pci_ers_result_t wx_io_slot_reset(struct pci_dev *pdev)
> +{
> +	struct wx *wx = pci_get_drvdata(pdev);
> +	pci_ers_result_t result;
> +
> +	if (pci_enable_device_mem(pdev)) {
> +		wx_err(wx, "Cannot re-enable PCI device after reset.\n");
> +		result = PCI_ERS_RESULT_DISCONNECT;
> +	} else {
> +		/* make all memory operations done before clearing the flag */
> +		smp_mb__before_atomic();
> +		clear_bit(WX_STATE_DISABLED, wx->state);
> +		clear_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags);
> +		pci_set_master(pdev);
> +		pci_restore_state(pdev);
> +		pci_wake_from_d3(pdev, false);
> +
> +		rtnl_lock();
> +		if (netif_running(wx->netdev) && wx->down_suspend)
> +			wx->down_suspend(wx);
> +		if (wx->do_reset)
> +			wx->do_reset(wx->netdev, false);
> +		rtnl_unlock();
> +		result = PCI_ERS_RESULT_RECOVERED;
> +	}
> +
> +	pci_aer_clear_nonfatal_status(pdev);

After bfcb79fca19d ("PCI/ERR: Run error recovery callbacks for all
affected devices"), AER errors are always cleared by the PCI core and
drivers don't need to do it themselves.
