Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372DC3590BF;
	Mon, 19 Jan 2026 11:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768820874; cv=none; b=gQF2Dr3Z9OuoSR7t74AU7I0RgiJXijh/qoleJ1ZEvhUbwVwJdLNQxIiyCivOd/dd0iYoOFxv7DkCISDmukLrt7nqIZ70GntR0LlRJs7pRl+1sVfQq9jjvycRDyDdUgURBEsqAU1W1FJbJJCG1vfzrmiq3zEE7/r5iA4cw5/vAL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768820874; c=relaxed/simple;
	bh=An51ruep0nnPkZqicsczLI0Cx1NWzahrg18iz2lC4A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRrepXpUfXAtSjnoJPOEpaL5LuoTLDXWpb6wdnAtXkgifaBDzUd2iN5i3HJlJ9wXi7felaD3kVGq2SNFkeKXBbkUY4U/IH/DdzTupOXVP0c+V5JtfXqEcHLlxRbLAgQoXo4v1YGnS8Pgcp3r8PO8PKWwlcWkzw5m5L83rtBs2ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X9p+sZAR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X9p+sZAR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB44C116C6;
	Mon, 19 Jan 2026 11:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768820874;
	bh=An51ruep0nnPkZqicsczLI0Cx1NWzahrg18iz2lC4A4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X9p+sZARZAuo6ybIXfy9FMSjmhuB+aGGCCNtoTitRa5r4wn2AcWgrWAVOPJuZjod/
	 gicdh5KVAVD1ysBIkn6M4ch0Db4v2CkTGM3k8Jk5mA2YXP89Pbvn+jp5Fy9d+5CIdU
	 uiws+qNhWXA9BjKy7g692brE75p50xlotDtIt+1c=
Date: Mon, 19 Jan 2026 12:07:51 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: insyelu <insyelu@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, nic_swsd@realtek.com,
	tiwai@suse.de, hayeswang@realtek.com, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: usb: r8152: fix transmit queue timeout
Message-ID: <2026011936-panic-unbutton-418d@gregkh>
References: <20260119105647.82224-1-insyelu@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119105647.82224-1-insyelu@gmail.com>

On Mon, Jan 19, 2026 at 06:56:47PM +0800, insyelu wrote:
> When the TX queue length reaches the threshold, the netdev watchdog
> immediately detects a TX queue timeout.
> 
> This patch updates the trans_start timestamp of the transmit queue
> on every asynchronous USB URB submission along the transmit path,
> ensuring that the network watchdog accurately reflects ongoing
> transmission activity.
> 
> Signed-off-by: insyelu <insyelu@gmail.com>

We need a real name please.

thanks,

greg k-h
