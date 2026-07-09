Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6693632ED39;
	Thu,  9 Jul 2026 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604969; cv=none; b=f2wrPxnU7v+9W9pBabA8CX+goE0NNxEJGpWvJuGnUEuH53duyrZA8p+pe1DzlpUXPOH0YfTeujDcPrIUAT7J3E/vPuWy8nkChjCy1givUU+/bOrPXxPc2/UXxMWbGkvKh/Ye2bdwCf4NA7e59pOvVT7z81o/yLtbWWX0guCrgD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604969; c=relaxed/simple;
	bh=jYDhU+0gLRTVXz98GtplL02xI0xjSigsD+386AoJ7AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBDCd2Tika0PrhB4/JoBWm07paF6h5nJM7b5S7Qey6mS3hXojlYgYzxwcp+yuZOzbQqkEM9Xa/cRLKJGh0839NVOsIhxlKOwE11t6AtN6F6g522uj8+DmqWXgktQ0Br86bJJEF/JUZlDCt74BfMUssQ+dlpyztbqRJdXCJlllkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FfV0Eh53; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FfV0Eh53"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Q5Byghl7sGMELUfR8Rn5qwLlTCwAYYa27D1ybdc7Ztw=; b=FfV0Eh53eISY4p4xvPMYuLuf/B
	9GFcdMa69KF4DmCkmiyIRSf11Dreb6AsGiTEiRwjqqWZnhv94txfO9TZ1nBEeFZMZ97vHjw3otR5M
	org7zlHzYitHcW034O4reiFxC+KK7/ZSiMz1sXowoPyRWMFv9lsCKUrotjmZblMMAU+o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1whp7v-00BVCn-79; Thu, 09 Jul 2026 15:49:19 +0200
Date: Thu, 9 Jul 2026 15:49:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oliver Neukum <oneukum@suse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	manuelebner@mailbox.org
Subject: Re: [PATCHv2 net-next 2/7] net: usb: usbnet: add cdc_state to struct
 usbnet
Message-ID: <88a47c25-d0f3-4a24-9924-4d270df2b894@lunn.ch>
References: <20260709120116.1423033-1-oneukum@suse.com>
 <20260709120116.1423033-2-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709120116.1423033-2-oneukum@suse.com>

On Thu, Jul 09, 2026 at 02:01:11PM +0200, Oliver Neukum wrote:
> This allows centralisation of code using cdc_state in usbnet, reducing
> code duplication. No functional change intended.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
