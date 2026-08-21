Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337923F6601;
	Fri, 21 Aug 2026 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787316696; cv=none; b=a3po4tPjGN+zZd2Ja9aAVoIF1lfNRlE0QkYepMoIZ73MPPRV39SgCcewzClMczRjBwZcGkQMbJA38g7Esc0+fkSt76hHy7gPKl+Hi277Iw+4MrGwMXmeA91wJcYSTqmjrzs8lOfVvOpce++tONhHR2idGT3xTnzXy0aW6nHAObk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787316696; c=relaxed/simple;
	bh=QJuaHMEuRwA76XSJf4PU56qD5Sa3jKPZzZ8fGZULEmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPawrbbMk2WntFfSBsyVWcEur3gBjH+mz5SO0i+hH4pg/E3kd+GusuBiAqV8ftQQ9dNZKSPf3j5XySVOSncj962c+ZLbCgkXXwXQOJJHwieYvWlCS2GE12r630LDv58UfVbiTkVY8wFqvunlsp7c62IIF/gwt1ovKH3hNcerKoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=G+1tk5O5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="G+1tk5O5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3SLCnubGY78/5xYtSrqKUUhnTDEvJu53SXE4sZhsa0w=; b=G+1tk5O5C4sW0JJeoP4FhNz0ra
	+pbdLzqZbpEzP4QroBln6Nm8MxeAc3pTDFKTMnU8EnIMhwSxz9J8xhnOy6xvU8QnAnZes6tqkXpxy
	UXDF7NViM6Jz8HXcf2on62i7KMANcsFlfSLmel/5kKgf+wX8jeyXaOWKzS7TyK/luH+0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wxOiS-000vqU-Kr; Fri, 21 Aug 2026 14:51:24 +0200
Date: Fri, 21 Aug 2026 14:51:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chih Kai Hsu <hsu.chih.kai@realtek.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	nic_swsd <nic_swsd@realtek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"bjorn@mork.no" <bjorn@mork.no>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next] r8152: use GFP_NOIO during system suspend
Message-ID: <29c03f4b-95d1-48c3-b8e0-f57ba2ffbaa9@lunn.ch>
References: <20260810065741.4019-1-nic_swsd@realtek.com>
 <918676ef-efcc-4524-a779-62eb2c3eb608@lunn.ch>
 <c2cabf10d22145bbb6a527e702b14b6d@realtek.com>
 <e5b2cc1bfc5448a6a4c14806b7e976ad@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5b2cc1bfc5448a6a4c14806b7e976ad@realtek.com>

On Fri, Aug 21, 2026 at 03:30:54AM +0000, Chih Kai Hsu wrote:
> > On Mon, Aug 11, 2026 at 02:03 AM +0800, Andrew Lunn wrote:
> > > On Mon, Aug 10, 2026 at 02:57:41PM +0800, Chih Kai Hsu wrote:
> > > > During system suspend, memory allocation with GFP_KERNEL can block
> > > > waiting for I/O to complete. If that I/O depends on a device that is
> > > > itself suspended, a deadlock results.
> > > >
> > > > Introduce RTL8152_SYSTEM_SUSPEND flag to track when the driver is
> > > > operating in the system suspend/resume context. Set the flag at the
> > > > start of rtl8152_system_suspend() and clear it at the end of
> > > > rtl8152_system_resume(), following the same pattern used by
> > > > SELECTIVE_SUSPEND for runtime suspend.
> > > >
> > > > In get_registers() and set_registers(), select GFP_NOIO when the
> > > > flag is set so that the kmalloc and kmemdup calls in those paths do
> > > > not trigger I/O reclaim.
> > >
> > > Do you have a reproducer for this? Or is it theoretical?
> > >
> > 
> > It is theoretical.
> > 
> > > > @@ -8693,6 +8700,9 @@ static int rtl8152_system_resume(struct r8152
> > *tp)
> > > >               usb_submit_urb(tp->intr_urb, GFP_NOIO);
> > > >       }
> > > >
> > > > +     clear_bit(RTL8152_SYSTEM_SUSPEND, &tp->flags);
> > > > +     smp_mb__after_atomic();
> > > > +
> > > >       return 0;
> > > >  }
> > > >
> > > > @@ -8758,6 +8768,9 @@ static int rtl8152_system_suspend(struct r8152
> > > > *tp)  {
> > > >       struct net_device *netdev = tp->netdev;
> > > >
> > > > +     set_bit(RTL8152_SYSTEM_SUSPEND, &tp->flags);
> > > > +     smp_mb__after_atomic();
> > > > +
> > > >       netif_device_detach(netdev);
> > > >
> > > >       if (netif_running(netdev) && test_bit(WORK_ENABLE,
> > > > &tp->flags)) {
> > >
> > > It seems odd to me that every driver needs to track if it is in
> > > suspend/resume or not. Doesn't the struct device tell you? Is there no global
> > state somewhere?
> > 
> > I found
> > https://elixir.bootlin.com/linux/v7.2-rc6/source/drivers/base/power/main.c#L
> > 2343
> > in the Linux source code.
> > 
> > pm_restrict_gfp_mask() is called before dpm_suspend(state). It removes
> > __GFP_IO and __GFP_FS from the global gfp_t gfp_allowed_mask. Therefore, I
> > think the driver can use GFP_KERNEL safely. Is this correct? Could you please
> > provide any advice?
> > 
> > 
> > >
> > >        Andrew
> > 
> > Best,
> > Chih-Kai
> 
> Hi Andrew,
> 
> Just a gentle ping on this patch.
> Based on my previous observation, should the driver use GFP_NOIO explicitly?

Please try to answer the question yourself. There are lots of drivers
out there. What do they do? What does the suspend/resume documentation
say?

	Andrew
