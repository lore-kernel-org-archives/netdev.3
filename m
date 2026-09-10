Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12659489891;
	Thu, 10 Sep 2026 12:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044547; cv=none; b=pQr1trKr/SUXDDMPFIwLfiPuyqqAKd45O9J2ivtV8hapuxaw3tR1Me2eYf6sg6KxjNNSM4rD7ARTGDf3SJEhgT//qZGAvTCPfcqEMylFEfDNZ78fiZntTILrjL378KOfQ3L1mClCcM08Azk7LH8ZcNyvRHqjsmlpHc+rGdTApYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044547; c=relaxed/simple;
	bh=l5+A02h73yIrASfg3OaLIlNxRCZnwXIYp/SV3zHJCT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bb+TuTJ+oLntyEgS1+bbj+WW1PLVkU+xQZlYmazJjhvMUAAIrjHWQZjhBU94YEogl18wDEHyMADSeCbIx1ZHr3VVuZ3ecENSD2RNRNWqvLDKP5rQ/32iJJZ0Y/GOYE19yG2Kh0QgvcJluAj9O3Pn/zVPQ4if8DrZjq+HNTvWBTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=WibuvB5I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZNkaqB4H; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="WibuvB5I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZNkaqB4H"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id AEF07EC01E2;
	Thu, 10 Sep 2026 08:49:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 10 Sep 2026 08:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789044543; x=1789130943; bh=/f7y8GIYOt
	1dmihm8mAaj1Wt7G6td6c+pu/O53d6aOE=; b=WibuvB5I5YlPZ9uOJPMzzTYQBP
	azAfLa3mexlUIZJ+CM44Bod5PlGhKv0ZXc6ezfGY25sujlloco1K/yR1dPiVkVOj
	erpvRhVbD3JsuDJYZATiQLotMQIsVDPfZCbRkbd6XdgI8euDs/w+JaihBP2+Cu5N
	l1saRyBS7DYDkwnKlTPTJSiT3RXV/cv37DGvyDn6T9OkRhCxbvdkYbjrb5yvPZOi
	WP/yaiNfRe8krY9///uApCm4Y/CRL2UiuaPmsBxvmbLagAdgjx0DZmGBrsL+EO2Z
	oONU3fA64v3zadyIEwSlnvp0TZThUb8hZYnth6tEz5tMJLKqDd+LmWMFFxJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789044543; x=1789130943; bh=/f7y8GIYOt1dmihm8mAaj1Wt7G6td6c+pu/
	O53d6aOE=; b=ZNkaqB4HGS+/d+93uVVScv91ONajaKZqrGHBHWDq6m4VuzitNNO
	roBpgd0SoXayemarh5yWtnZemezpX/z2eEglyNSXsPOL09vIvxYZnOACWKGlx1e1
	PKAXjHnURjYGTicY2kfpfA7RriKX9P5oXhzLRd8F6uV9NL/wYhfWR5M2zImEQZ94
	J9saZ8KtNWj5UdrMjON5oydTIV+P5yDZC3ASiLxtTvuheaikmuY7NX2vo9XOUA5G
	y9+MJLP1Pz1XbJLCRjZhkgOpiUS531w1Nj+BXKql9zrOQ0s2jTlaXct+xoz41aHj
	VT78rRhzf0pO2jeShDMIXbE38KZSmGaq/sw==
X-ME-Sender: <xms:P6eiakkhtSsQze5UG2iAHIpW8wm4Cw_D0Z9fXCsbzSKXmhmUTwUN_w>
    <xme:P6eiaqbL-GoEOe36ff19G14K5rBrAzBZZKrEMHrsdeStcLdzVvN2YeG2FLTZ3NCBi
    gfBwLTNT1rNuJojArpBPM6KBHpkN91LqaYxT7-9UkzSWyAD>
X-ME-Received: <xmr:P6eiakU30djSYEV-ER9lPmA2lEYrJyvtVr6WfxPpr64LtYhmz6V8UJExBZM5L_1-da8ouLiwJCDS9snyVRHdxjCT8DdEYR05c8JAQR2eSYc>
X-ME-Proxy-Cause: dmFkZTFKKiM4dyM6zauEw8A7kaHIbwivS0cEwiKibpIDAHKepDSn11kfRGIkXb87PHeDz8
    UzfehcInsnAxCHgXmDVsOKH0vO1It6FnI+wNZ/8JExs+2XooLq1draESBhVSOftLbgQpkA
    JOlX8X30k4nXfwnAOHxnMkznyeocH0x5iiAwBQ/nKk/+X8G4R53Z/JHt16QRS5/qF0MjhK
    eEflwQfkRO4mk/2ha4T2WZmSGw3lM20TF6x0DWgw1+3WspZoP6mgWlkvlmv7pEqFSkrx7x
    VMc5hRBR7bpTLBsAMNiGYtw5U05GCCswooQD6ohBo6lBbHfLSebqWVDqWQw3801RDjv/t9
    dr5HCk1K1hR8eHK5MihF7olfo9zf07rLhxNzEnFqm+2CdpkSVOiQsc5Ay+LZToDIpBEL9e
    coKIkR4K0QUsHas0mzRbo2/DC7KWXudvnumG+wwuCVbO3B5yyr2dAFe9jm2jySq17JcKew
    yFBwXJVUaxKXtndSAv3WAIpFE6pY76WJwIqyXhq1JjNogQ/wfmcD973aKH1DOJgthsKGu7
    94Ww+aG28Qtsx15CKhvTA2/xq9udsfc2PEQe8bSGoQyOuTOf/VFaClpYgWwQwHMiKoEf9S
    Qhe4VT8I2bi6NjdQ5D6Z1Pn2bZGAci6Vq/hXKYOU6uh0S1R9s+IfWmz5kmLA
X-ME-Proxy: <xmx:P6eiaqDYR8Qjlf_6HHEY8FTNNGm_lktZdmrhsQwGuRMupdxCb7TXaQ>
    <xmx:P6eiajw0bbeg5dSpK1iPljOosYNF_1gGp9-nBOX9USItSiWpXNz5Gw>
    <xmx:P6eiagYaHIAbYsCaJTrd0uu_LyfEyNgZdkKnqtu-3gCauA5jOjVOtA>
    <xmx:P6eiagRQsnmMCcsr2jDekJtUliorOjOrVF2QJUJMvQhmxKLoczTlzQ>
    <xmx:P6eiakjwHgAGCO5aUV1Z5fBmpWoklUY2-rkvGqVkIxyfbf3GzTgf7UiH>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 08:49:02 -0400 (EDT)
Date: Thu, 10 Sep 2026 14:48:54 +0200
From: Greg KH <greg@kroah.com>
To: bolewara@gmail.com
Cc: Chas Williams <3chas3@gmail.com>,
	accessrunner-general@lists.sourceforge.net,
	linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+e4b1171e7c5ae2556f9e@syzkaller.appspotmail.com
Subject: Re: [PATCH] usb: atm: cxacru: stop polling on device shutdown
Message-ID: <2026091037-rosy-cardigan-e5ac@gregkh>
References: <20260804-usb-atm-cxacru-stop-polling-on-device-shutdown-v1-1-d7fd757cee31@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804-usb-atm-cxacru-stop-polling-on-device-shutdown-v1-1-d7fd757cee31@gmail.com>

On Tue, Aug 04, 2026 at 10:28:36PM +0530, Anuj Bolewar via B4 Relay wrote:
> From: Anuj Bolewar <bolewara@gmail.com>
> 
> cxacru_unbind() sets poll_state to CXPOLL_SHUTDOWN under
> poll_state_serialize and then calls cancel_delayed_work_sync(). If
> cxacru_poll_status() is already running it only stops rescheduling when
> it observes CXPOLL_STOPPED; CXPOLL_SHUTDOWN is ignored, so a running
> worker re-queues itself. cancel_delayed_work_sync() then returns while a
> delayed work is still pending, and the work fires after cxacru_unbind()
> has freed the instance, causing a use-after-free.
> 
> Treat CXPOLL_SHUTDOWN like CXPOLL_STOPPED in the reschedule decision so
> a worker that sees the shutdown state stops polling and cannot re-queue
> itself after unbind.
> 
> Reported-by: syzbot+e4b1171e7c5ae2556f9e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e4b1171e7c5ae2556f9e
> Assisted-by: deepseek:v4-pro
> Signed-off-by: Anuj Bolewar <bolewara@gmail.com>
> ---
> cxacru_poll_status() reschedules itself with schedule_delayed_work()
> unless poll_state is CXPOLL_STOPPED. cxacru_unbind() sets poll_state
> to CXPOLL_SHUTDOWN and relies on cancel_delayed_work_sync() to stop
> the worker, but a worker that is already running when unbind starts
> never observes CXPOLL_STOPPED and re-queues itself, so the delayed
> work still fires after the instance has been freed.
> 
> Treat CXPOLL_SHUTDOWN like CXPOLL_STOPPED when deciding whether to
> reschedule, so a running worker cannot re-queue itself during unbind.
> ---
>  drivers/usb/atm/cxacru.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Did syzbot ever test this?  I don't see that in the link above :(

thanks,

greg k-h
