Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E61D44A3E8
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 08:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790930643; cv=none; b=JwzbfmTf8YZQGEDidvfep7AcWZ9rX/R+cQwCeDdSW1YBTsSASL63TwIr67gEZwDn0xHxRyqWiDCdRc+VbADYmp4RhWX16EhttbsXMADGb1bamfoeif9N4gXiBRHD00QrPDE5Q/LoB/CJja5QUOTxkyXrc6t0DL/oYZ0UQ2ldFoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790930643; c=relaxed/simple;
	bh=VkyfvI4JFYrHbohS/9ZHexkHJcpRb70LNq8ohC/ZJd8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DBaFxoFitM4fGbDZGxemm/dh24fqgQXUBpYHcnw/WiPTTk3nlImQd9cj7ALXqWihg/9lN/oEFodeOMYNok2btVwDbIRqXl9aSTS/d5k0dWhgtZKZr/Btpz+CeqAYIIvCbzlvWyihMhbmRuULEZMa/bQZoRqoWHM41H0NbAisojM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJMgg6z1; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJMgg6z1"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a003bd18e5so29378255e9.0
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 01:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790930640; x=1791535440; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6dhi0KckrbogHHoZX7wC0NbCcVaNRSNuFfvNHe9W2GM=;
        b=cJMgg6z11PTs1OBryr/rjuGqZpLyP7YtWohyCOP3Buecw5gv3TocVhEGosUGJoYkBC
         z8NJbsInfV8leY04lT4i4bTu0+SpaW6qHNJz526RhnjxShbUUHCj0i5aVHm9HTBZ0xoz
         FBCD7Qg91ua7YIqFh2p2MDAcrIcapfdQG/7Qn9zkeappQ8qVqafSeM0LHd58NvysTg8w
         dGBmcI136PQnyJ//drwfreIbu/wAcpEu6zZZcWiP/8UHxUFdPFS4tCNRvbC6xP+W2jkP
         b3lUtkKzYtqXmR1CiU42Lr62cevbmTmFQKydhpubO09gf4opqq3B8GFpxWeJYkZFLrNz
         KDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790930640; x=1791535440;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6dhi0KckrbogHHoZX7wC0NbCcVaNRSNuFfvNHe9W2GM=;
        b=uFYApYtwWW13FJ0YfX/JKQaOZGmJ6BaPwjo/l2eD3tgFKOVSl6SJPXEJarA/dG/cb4
         O3B+KTsdHzX7VnyCaHLjop/boBv5M1w6TQGFgRoZkPHfVXwKCNcdG9Z/ekoDoVGemOX/
         xj6CnNTYHYRGrJvcHrzzKIshS5MHaWZRt/Pms5gaDzT6uls4JBEbUoWT6hIvkT6WmI2p
         Xxj7/Udu+fS6RyQqfhsisYOCKWu0CIrgEFwUjaJ5Q3z6H6A8KgSF41hVAIFAeKW2JrHw
         rz2yJiPlFNbsNKJK0/LiRlu7lJPm3S+fRvQBoF/D7dp60saylQh2C2+/ZZAuNdwAKS8z
         TysA==
X-Forwarded-Encrypted: i=1; AKwUvBwpD0mK11q4aN4Ruibvxw/X/kQQGv4PfbPnlwYuVweYYZV+X5nIMsA0Rui/TzW/JeXoJP3W3Q4=@vger.kernel.org
X-Gm-Message-State: AFuF++lQkkKwZAhfC9AxpyNJjW7WktAp6d7nOyGoo6ZFqhoO9y/UPFHr
	UHDLf4IM1+Utp+L3W5yuuqDLfKTh25c34l7nt5JrIOEmM0W9jOLGv8Bx
X-Gm-Gg: AYBFou1ghFJX40Jim0UIc3OEbsQckVdI8ZwQz20syfSCsNDT0cnFAISD6jhocSDZnOu
	iXglV16z32EzlO2XT9jkjFtz6fb7sg4M07JYaH1b4oU+Zp0s9b7FQRhT1gcDHpOEi/QQ1pW0F62
	XP0S2DC6Xz5YBzlNbYupxP31iyIYmWZCeBkK9lP4pamNzxF48zbajh9juVBKMPdWv//S/CjVxDJ
	A4kgsFD/WS/4r7z0dXajEIHcjRI3uANv2uxhybcWyuZ9psjXwaTa2g0W/+pj7rcSLgUG48lUhfq
	fVQKDUCNCB4FwuYHiyPoFBVXx2uxp/NVOqGNCmTtamRKzuoRv4Fp1EGmwYVmxKMM1/LYcK/v9Ge
	pI2KqPrSD3OhoxmOGGqhXNxVGeHEQOLbFEybYPzTqkcRSgnGHt1Y6UNBUvf9j0VV23nobSN/26t
	R8464hrbGFU7sjc7OCubxquajlw1vR2ctpR/LBbJWyKv7f6etdPT/v60eA+Wejhw6YH4IksJ0h/
	V7Gg3hl8VxA6wR5lqhl
X-Received: by 2002:a05:600c:3501:b0:49f:fd40:80fa with SMTP id 5b1f17b1804b1-4a0276b78f7mr35135585e9.34.1790930639550;
        Fri, 02 Oct 2026 01:43:59 -0700 (PDT)
Received: from foxbook (bfj133.neoplus.adsl.tpnet.pl. [83.28.47.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0394e6c5asm43917315e9.2.2026.10.02.01.43.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Oct 2026 01:43:59 -0700 (PDT)
Date: Fri, 2 Oct 2026 10:43:55 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Dane Linssen <linssendane@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, Mathias Nyman
 <mathias.nyman@intel.com>, Alan Stern <stern@rowland.harvard.edu>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: r8152: RX stops until rebind after -EPROTO on the bulk-in
 endpoint
Message-ID: <20261002104355.698eaf00.michal.pecio@gmail.com>
In-Reply-To: <CAM6_QD-CbYSsmic5LhpMi-aMXuC_VaniELBzaBeWO8SWm4UONA@mail.gmail.com>
References: <CAM6_QD_PoTdwdM7DvzzgHRs-G5EvQu-c5oNGve=GuKV4wFYAvQ@mail.gmail.com>
	<CAM6_QD_xAyTFVvYKvCrrZmS+fV5DBBje9V=VdkDMMSpt2ussRg@mail.gmail.com>
	<20260928120343.49e02c07.michal.pecio@gmail.com>
	<CAM6_QD-CbYSsmic5LhpMi-aMXuC_VaniELBzaBeWO8SWm4UONA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Sep 2026 14:48:05 +0200, Dane Linssen wrote:
> Andrew:
> As far as I can tell it isn't a regression. The adapter is new
> (2026-09-17) and has only run 7.2.5 and 7.2.6, which don't differ in
> r8152 or xhci. e765ab012f73 ("usb: xhci: Improve Soft Retries after
> short transfers", v7.1) should make it rarer, not more common.

IDK if it's a regression or not, but the symptoms seem consistent
with a know problem which exists since forever.

> Michal:
> > Out of curiosity, what's your xHCI chip?  
> 
> Intel Sunrise Point-LP, 8086:9d2f (i5-8250U), so not ASMedia. The
> other host with the same adapter, which hasn't stalled, has an Intel
> Comet Lake-LP, 8086:02ed.

OK, thanks.

> > As a bandaid, you could try increasing MAX_SOFT_RETRY or this:
> > https://lore.kernel.org/linux-usb/20260905101837.4b7849c5.michal.pecio@gmail.com/  
> 
> Thank you. Would you like me to try this to gather more data? If not,
> I already have a userspace watchdog that rebinds r8152 when the LAN is
> unreachable and the bulk-in endpoint shows virt_state 0x40.

You could try it. We may consider increasing retries in mainline if
this turns out to solve real world problems. Though so far, in the only
reported case of 3 retries not working, 10 retries over a span of 100ms
weren't helping either...

> I only enabled it after the two stalls I reported. In the 19 hours
> since, including 71 minutes above 5k rx packets/s (peak about 29k),
> there hasn't been a single "Transfer error" message, and no stall. So
> nothing random so far. The next stall will show whether it's a burst.

Any results yet?

Regards,
Michal
