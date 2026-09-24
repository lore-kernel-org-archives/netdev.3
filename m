Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F370A4A4EF0;
	Thu, 24 Sep 2026 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263949; cv=none; b=C0hM2L/E45CGwgb8wjnWsy7hR28yFxwEGJHk2Al6xTZMK6kPvgZhK836BLmaQqJur/1B+OkMJhIvioEZTRmkcCTzeWnCZopNMNYqeCqxiuxEomu7l3K0MLoCMV1C4uyXQRETLSxWQ22jIP0ioA4RV6Afnwyo4+mugkb/Bf0wRCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263949; c=relaxed/simple;
	bh=1LRDUbfHc19bILPUL/IhQhXeaKwHiT6RMVWSh5qizks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ueo4n25Kvxau6pOaNSXNDYQnlSGUM2WRU1JBXy69+x8YGByAfOvmVvbRpaOSs3BnpbTmMzdG/+5HKwJAYjj3vIQ3MutT34ACV0IFb7OqVsifY77VasjXX9IBQpT+9pPPLaJR6jO+IbKkJ4miQS1rbDUdNdFWg751C6XzKrFKcCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1/5Mo9rJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1/5Mo9rJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=plTJLDQAj0hnOAP6k8YFwOtFx4DzooHoww6QY6cF8GY=; b=1/5Mo9rJduTh85VwjBBLPiX2IV
	vO6IGHH1qxwqvx04BHbCeT3uncW3G7XghEMFlRJM9i2esW5O7tSQsVMA5fP1FEQ1I3xstcYs3zRyR
	pyJ3Yzoum9KIGcGnG/n8jWoxaZ/KL2Yp1h3ridhhghiK4kxiFDjE+kCJAqpXxXc9kRSE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9lQd-0071eP-NQ; Thu, 24 Sep 2026 17:32:07 +0200
Date: Thu, 24 Sep 2026 17:32:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
	horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
Subject: Re: [PATCH net-next v9 2/7] net: dsa: motorcomm: use max_ports in
 series for port bounds checking
Message-ID: <e5a632a4-053a-4f5f-a8e1-6aa1641571f9@lunn.ch>
References: <20260924094146.4128703-1-kyle.switch@motor-comm.com>
 <20260924094146.4128703-3-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924094146.4128703-3-kyle.switch@motor-comm.com>

On Thu, Sep 24, 2026 at 05:41:41PM +0800, Kyle Switch wrote:
> Replace the hardcoded YT921X_PORT_NUM macro with the per-series
> max_ports field in port validation. This removes family-specific
> constants from the common code path and simplifies adding new
> switch families with different port counts.
> 
> No functional change for existing YT921X devices.
> 
> Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>


For version 8 i gave a Reviewed-by: Andrew Lunn <andrew@lunn.ch>. You
are supposed to add this here. That then tells me i don't need to look
at it again, and it helpers those Maintainers who do the actual merge
decide if the patchset is ready.

b4 will append these for you.

    Andrew

---
pw-bot: cr
