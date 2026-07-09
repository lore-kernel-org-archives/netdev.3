Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D2B314A98;
	Thu,  9 Jul 2026 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605147; cv=none; b=edNiPINZeUzDGXM/ryq5LQCyZOzoMHxrHOWryb0A6/9MMv9ptt+ZWra0TUJIW9aOgIyfBxq9gTWOvS+K/dlto6TIergIxdnDfywsgURMnlpdcvbUyoBwuJSNjNgVXFFRD6sJvW3szn/9uvEKnDDUXZ0O3kTq18BEDhHWfwCxGnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605147; c=relaxed/simple;
	bh=fWLxLSHenOv38XNPbeKKS1v1FMI2edLQyY0fToHqhAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VM8y626WqwBihMuWzTLeJ0aZXBj521tt3XMI+9WqNqHWXTDNE47W8ql1SRN0LA9BwPh7O212kZbyc3OCyf5wzQAUuqQ6KkHrdTf6+rFkK431LlhTPidIJ4Apqg0FOT1JaEt6tGmZZm2ylCbm+xCzLRRVtCCz+d+jpN9UCfobrzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wG7dnAry; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wG7dnAry"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QCA9Yo1BFegUcn7V9vx5TBVhdxfjl/2wj4qUL+v7pS8=; b=wG7dnAryQrHUyHKUPMoZ/tHfWn
	nqPOYbVo1+NoldeCBqYoMDFIObDVbGmAx28AQovm2JGXTpYrtJm6wKfYGT3PaDc4bRo5ulI3XkSwZ
	mrSycgtvcH4pCH+AJBNqDNauXZZqLKtut8r284w0GxSCQuS19hEJN2x7LPJw3jwC2rgs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1whpAq-00BVG5-Ie; Thu, 09 Jul 2026 15:52:20 +0200
Date: Thu, 9 Jul 2026 15:52:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oliver Neukum <oneukum@suse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	manuelebner@mailbox.org
Subject: Re: [PATCHv2 net-next 6/7] net: usb: remove dependencies on cdc_ether
Message-ID: <16ea3a48-d5f6-4b35-935c-521c201b14dc@lunn.ch>
References: <20260709120116.1423033-1-oneukum@suse.com>
 <20260709120116.1423033-6-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709120116.1423033-6-oneukum@suse.com>

On Thu, Jul 09, 2026 at 02:01:15PM +0200, Oliver Neukum wrote:
> Now that the driver no longer exports symbols to act
> as a library for other drivers other drivers don't
> depend on it. Remove the dependencies.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
