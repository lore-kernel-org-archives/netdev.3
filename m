Received: from herbert.ortolo.eu (herbert.ortolo.eu [80.67.179.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885F9387343
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.179.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770051984; cv=none; b=Xjc8nLRqvj3nyu5oI/0kVeLFZNlBfIUXB4kiMWbEJ8EOrLNmVo+DLTcbCh9ko1d116WXA6+XyRw2rquQ4X62cRSwAeZMhRRBBF9qEHnpRlBapOg+ef3YKScggAEcIVxHqEzwcYz1a3jJVFJLBXBeRvR4UUi84Ulr0SMC1dmGfC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770051984; c=relaxed/simple;
	bh=zKUGRj4u4BViCIuoDiq57lZvsIIvalNDWqWzapVybq8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PH1h2mdeFpUu2bmjCbukAeMf1ASpZHD8BoUcWjIgwINyHWTE2PEDZNyBdM9nzhDv6XRn+gSO+YYo1y/NeTBEE2Mkz1T8o2ux6kYxRjF0f9F5tutcV7HePfeNZn1eLVtYX0Y1CIYyY3t+Y8BVdkjtkDaQkf8V5g8lkRZh/OHnei8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ortolo.eu; spf=pass smtp.mailfrom=ortolo.eu; dkim=pass (1024-bit key) header.d=ortolo.eu header.i=@ortolo.eu header.b=hyLaeCQH; arc=none smtp.client-ip=80.67.179.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ortolo.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ortolo.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ortolo.eu header.i=@ortolo.eu header.b="hyLaeCQH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ortolo.eu; s=herbert;
	t=1770051656; bh=zKUGRj4u4BViCIuoDiq57lZvsIIvalNDWqWzapVybq8=;
	h=Date:From:To:Cc:Subject:From;
	b=hyLaeCQHehUteSK6Ea3UgRDcEUKdPgVmQeDiFQG+02isJHrL0ld91jrl7xpnd4Lxg
	 UJbT6F4H7IHWa0YKBtFo24adZAT4Cddw9YbE7nyZg/ne3BfwoXJGkCvOvYaehzl6tQ
	 tCLbB1VuKyoS1ztTTzLlTn4ae0UqCbs97PGyfjUI=
Received: by herbert.ortolo.eu (Postfix, from userid 1000)
	id C6DDF7373B; Mon, 02 Feb 2026 18:00:56 +0100 (CET)
Date: Mon, 2 Feb 2026 18:00:56 +0100
From: Tanguy Ortolo <tanguy@ortolo.eu>
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Francois Romieu <romieu@fr.zoreil.com>
Cc: netdev@vger.kernel.org
Subject: Weird issue with r8169: shutdown on carrier comeback
Message-ID: <aYDYSHhaF1vQSxdW@ortolo.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

I am experiencing a weird computer issue that is at least partly linked 
to the r8169 driver: the computer shuts down when the Ethernet cable is 
pulled off and plugged again. Or when the switch goes down and up again.

To be more specific, the computer is a [Trigkey Key-N100][1] running 
Debian Trixie. That computer has two Gigabit Ethernet controllers:
     $ lspci | grep Ethernet
     01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller (rev 15)
     02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller (rev 15)

[1]: https://devhome.corp.adobe.com/docs/default/component/ethos-flex/docs/devhome/prerequisites/

One of them is configured, and when I pull off its Ethernet cable and 
plug it again after a few seconds (or if I reboot the switch it is 
connected to), something simulates a power key press (log from 
systemd-logind: “Power key pressed short”). Even though I configured 
logind to ignore such events, one second after this, the computer shuts 
itself down brutally, as if experiencing a power loss.

After a few experiments, I determined that:
* it happens on both Ethernet interfaces of that computer;
* it happens only on _configured_ interfaces: in particular, it does not
   happen if I unplug the Ethernet cable, run `ip link set enp1s0 down`
   and plug the cable again;
* it does not happen with the proprietary driver r8168.

I am not really sure the r8169 driver is at fault here; it sounds more 
like a very weird hardware issue in specific conditions, which are met 
when using it. Anyway, I though you deserved to know, in case it could 
be useful. Please tell me if there is anything else I could do to 
further diagnose that issue.

Regards,

-- 
Tanguy Ortolo
