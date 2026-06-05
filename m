Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C831B6D08;
	Fri,  5 Jun 2026 04:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780632241; cv=none; b=T36ecpkMvmeW7/uynuqwsVAt1B/eg9u6880K3Ftd3gxI/xPRkcZxPyC5A2oeh/7NnqPgXuGjVeSMh1FCmc4oxAcust229EKDi5adJQhC965H4X7YOxQfFDmGOYDzuyOg5XFuBhffqiAawARK4ixVbo2HpGcm3BrvJZMsw79ZVP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780632241; c=relaxed/simple;
	bh=Whx3sQMluE7DMB1qNGQ21AhcBh59lFH3V5pYzvSSqug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBtbfqoHKKJcY4la9nfrnfs3Ruei/2Hrn5y/mnsVYtYSslQR+R8uSPFDWEmfMIUiZd5yHw3EST1FD3juvJGygLupQIcP146j7HEDHW/1FqLHqMuK1bmIvdDMrIPbL4x6jzYkjNaercJ5CO6YD7Ayk1llSJ/xLkhJ78/qf14KtRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jg2ynLis; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jg2ynLis"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bANUXCFrVrCd6bLm0zhgtB0sbNZmZO2gt3veZW1sXN8=; b=jg2ynLisWZx8nDLiGgvYQezxur
	akoS4KpVri/A698HWbLtW8MGT55C18zsjT10rCEaNkSF7z9us558lmq0XpEFRb6n56vFk/xqi/K8r
	LgpwlFWh1Y0cux3GTMzkNo5TQyu/a/FpDHdMGeGpLxE8UAb7dDecwWyvqx0COxpAFMhA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wVLmj-006AQk-EP; Fri, 05 Jun 2026 06:03:53 +0200
Date: Fri, 5 Jun 2026 06:03:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chih Kai Hsu <hsu.chih.kai@realtek.com>
Cc: "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	nic_swsd <nic_swsd@realtek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH net] r8152: handle the return value of usb_reset_device()
Message-ID: <3e108daa-7913-4890-8331-9761a4654b1f@lunn.ch>
References: <20260604092247.27158-450-nic_swsd@realtek.com>
 <c1ddf8f3-71f7-434c-ad10-64096b65fe51@lunn.ch>
 <ce2651bf86fc401b9e1e7cc29b5a6c22@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce2651bf86fc401b9e1e7cc29b5a6c22@realtek.com>

On Fri, Jun 05, 2026 at 02:42:34AM +0000, Chih Kai Hsu wrote:
> On 04/06/26 8:54 pm, Andrew Lunn wrote:
> 
> > On Thu, Jun 04, 2026 at 05:22:47PM +0800, Chih Kai Hsu wrote:
> > > If usb_reset_device() returns a negative error code, stop the process
> > > of probing.
> > >
> > > Fixes: 10c3271712f5 ("r8152: disable the ECM mode")
> > 
> > https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > 
> > Does this bother people?
> Yes, it does.
> If the driver does not return early when receiving an error code from usb_reset_device(),
> the subsequent execution will trigger a kernel call trace.

Please include a link to such a bug report, kernel call trace etc, to
to show it bothers somebody. Do you have the hardware and can trigger
this?

	Andrew
