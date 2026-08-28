Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6086F246762;
	Fri, 28 Aug 2026 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787930137; cv=none; b=W7f8yBoPerTpbTTweL+flvqTgDuBKCKARbTpFyBDE9spkfa/SipzxEdhn9rJ3N6l68aixuLl1FHtTYxuiu3s0tqmmlwtbJT0LOJ9U7Z0FK8F5a8W5rdkl6wh1nLJeyUsmHP/oTJts6pWpcoT0McFZtku5l4NEvSg3M83gTBxbJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787930137; c=relaxed/simple;
	bh=vHM7IuyBYqU+aanM6T9n5z+27YmsvMatP4sTu9IDIVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLBUR8QBGUQLs+tSZOShJU90ckX2xk39Zcz3f1C4HflSrKhFnjoEFdOPW77k7Jkip1MLPsLvddNzQrPmDfP3DxFH7+sYqb7y7juyW0+Y+xvP0PnIdB+lCtaN0pT6HlIH7lwF7zFB/uiwwgnaJIo7cIw4lM5loRA1rtvQFTODoA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eh0ELsyP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eh0ELsyP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6SkOmdvoiBqKfQ+sV84Hc+Uue6acCGOEhTyi6KmwzcE=; b=eh0ELsyPIb23kpIE0hDOnUu2oX
	FyHQv6MYEIL52keZa60gVvbLPfPJo9Dt9YZOTRgjnEkbgh6Ob6idFvhoL8p1jDVC8LWbExWCpGd/u
	lIwNOsE8KHELjRcozypECl+SJe3l0MmVNjiM2IBX+IfssjTFn51I6FBtctClAr13laKk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wzyId-001pR5-5c; Fri, 28 Aug 2026 17:15:23 +0200
Date: Fri, 28 Aug 2026 17:15:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	falemi@asu.edu, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] _phy_state_machine / phy_stop -- a USB PHY that reports an
 MDIO error to phylib panics a panic_on_warn kernel
Message-ID: <63bfddae-b456-4645-b992-e730bdd4b1ac@lunn.ch>
References: <CA+0ovChAkaCGmDrkaAzfrmpccDXVampiV9OmjLKwDgkYXThvGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+0ovChAkaCGmDrkaAzfrmpccDXVampiV9OmjLKwDgkYXThvGg@mail.gmail.com>

On Thu, Aug 27, 2026 at 10:29:36PM -0700, Farhad Alemi wrote:
> Hello,
> 
> As part of the kernel research at ASU's SEFCOM
> lab, we hit the crash below. Crash reports can be found here:
> 
>   https://github.com/farhad-alemi/public_bug_reports/tree/main/146-phylib-phy_error-warn_on-mdio-error/
> 
>   smsc95xx 6-1:1.0 eth0: Error reading MII_ACCESS
>   smsc95xx 6-1:1.0 eth0: smsc95xx_mdio_read: MII is busy
>   _phy_start_aneg+0x0/0x480: returned: -32
>   WARNING: drivers/net/phy/phy.c:1352 at phy_error_precise
> drivers/net/phy/phy.c:1352 [inline], CPU#0: kworker/0:3/5063
>   WARNING: drivers/net/phy/phy.c:1352 at
> _phy_state_machine+0x667/0xf20 drivers/net/phy/phy.c:1613, CPU#0:
> kworker/0:3/5063
>   Modules linked in:
>   CPU: 0 UID: 0 PID: 5063 Comm: kworker/0:3 Not tainted 7.1.0-rc5 #1
> PREEMPT(full)
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> 1.16.3-debian-1.16.3-2 04/01/2014
>   Workqueue: events_power_efficient phy_state_machine
>   RIP: 0010:phy_error_precise drivers/net/phy/phy.c:1352 [inline]
>   RIP: 0010:_phy_state_machine+0x66d/0xf20 drivers/net/phy/phy.c:1613
>   Call Trace:
>    <TASK>
>    phy_state_machine+0x2b/0x70 drivers/net/phy/phy.c:1652
>    process_one_work kernel/workqueue.c:3314 [inline]
>    process_scheduled_works+0x881/0x1170 kernel/workqueue.c:3397
>    worker_thread+0x988/0xde0 kernel/workqueue.c:3478
>    kthread+0x333/0x420 kernel/kthread.c:436
>    ret_from_fork+0x351/0x940 arch/x86/kernel/process.c:158
>    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>    </TASK>

Could you point out the crash here? I don't see a crash.

      Andrew
