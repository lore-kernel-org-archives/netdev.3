Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF4039280C
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689449; cv=none; b=peuZj5j2zZP/3N6v6JorOGncBX0CPS1X5qCfjwfo/ZarcYtxJgnMBqpjnWO1vpfeG97KcjVPDsiK9F2uWGsTAM8/aofeI/n1pwtE+bSiIt+DT2dZs84A2D4c0spud1TZ2F67THZk8NfpTQFLSKvDZRYPjpYTXyI6Hr+q8LHjnsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689449; c=relaxed/simple;
	bh=PnY3n5UXp41Vwfo3l5PFYpKGwxxbfXs0Sckxqm78yns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7lLmqVwl8by4voz2ahEQXmH52KvusF9KzqVanXiHr8qgvyYPQMqLUcU7Me4M1sf2yCeuzl+OpNE6uHCfzZnjndiDyX7Xv3AsyvmvxYfut9gQqq6K8N8yVTqT+mva+NAgKqcl/npmDXshHtTu+gApV6mFKK50tlkey3LlmMAeAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZMUC71+b; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZMUC71+b"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=k74zDYNsIHMKvFenq5Y945axJ1MFbmkTfoPjO5NmnpI=; b=ZMUC71+bhO8Z0xj37TQV8CRqMC
	iKR5RMZTw3EPnHkgzm42OxSq9vInMJX6kUHZjldFGEV6qu4M8TrasdodNuanotzZ63Mj3YuzcngtL
	dCVD5L8DLDGK7QOqDZM+DgD2Tyww8Ke3mHE0fldiu63qPZKu53xOB2BgI+nx0DRFGGhA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wZmoT-0089tB-LK; Wed, 17 Jun 2026 11:44:01 +0200
Date: Wed, 17 Jun 2026 11:44:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v1] ixgbe: Implement PCI reset handler
Message-ID: <9befcf6b-a20b-4e2a-8d22-1bcf1a7460d8@lunn.ch>
References: <20260617084329.199110-1-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617084329.199110-1-sergey.temerkhanov@intel.com>

> +static void ixgbe_reset_prep(struct pci_dev *pdev)
> +{
> +	struct ixgbe_adapter *adapter = pci_get_drvdata(pdev);
> +	unsigned int timeout = IXGBE_PCIE_RESET_RETRIES;
> +
> +	if (!adapter)
> +		return;
> +
> +	/* Prevent the service task from being requeued in the timer callback
> +	 * while we're resetting.
> +	 */
> +	if (test_bit(__IXGBE_SERVICE_INITED, &adapter->state)) {
> +		timer_delete_sync(&adapter->service_timer);
> +		/* Prevent the service task from running while we're resetting. */
> +		cancel_work_sync(&adapter->service_task);
> +	}
> +
> +	pci_clear_master(pdev);
> +
> +	while (test_and_set_bit(__IXGBE_RESETTING, &adapter->state) && --timeout)
> +		usleep_range(1000, 2000);

Please consider using something from iopoll.h

> +
> +	if (!timeout) {
> +		e_err(drv, "Timed out waiting for __IXGBE_RESETTING to be released. Reset is needed\n");
> +		pci_set_master(pdev);
> +		return;
> +	}

because this is broken. You need to retest the condition before
declaring ETIMEDOUT.

	Andrew
