Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9715C134CF;
	Sun, 27 Sep 2026 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790500115; cv=none; b=En6FtgL+huIreAquGz3fXHS0+tR+cMKpWv4IDlvWzpnsCWdi4PuuLHMTG9Pjwa62GqDhoQX6mXmhJMolbFO0rV3//UGGixm3Zo33RQJu0Ql01hinIYZKmpjGWKfodAmtQRvOhpikHQ1ZOqOxykMhnwG/SSPEJR+cPMA6lKDtEuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790500115; c=relaxed/simple;
	bh=oToI6ocywaDYgSDHv8lCPFoU+IWrD9coqeJrVTcBn4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BzyK4mWGb2F2zeOA042IM4QapmiLzbMcac2KJwveO+flAP89km4i+ZBuB6fk/mvJf0MoEux30CkGjSm5ePHyfOC3TMpyrWCedCw3nxkycs0mEZd47ck12IPnEIKKWV76javnETREE3KR8awe/LQ/VIx5g6CnbLDyr/rN0aZ2oio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=u82KcRhD; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=EkIN0g4j; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="u82KcRhD";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="EkIN0g4j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790500112;
	bh=oToI6ocywaDYgSDHv8lCPFoU+IWrD9coqeJrVTcBn4s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u82KcRhDZS937kGg7dAEPGj6Xp68bz0iqI5nEDa+4xu+aXq8rPqhor+JvHfRx0dyy
	 3n6HxUeT/vvFfKVmoeuu+XYghBCjAxX/iy9Iqd9drZpmbbceW69qyxPAgf2NmS5XmL
	 pg1nTeUtKY5pD2FH0hhhJIVui6OpvyMso3las2HzIAlfmDxXveg5XF3hbkiwaTNISt
	 wPj2tpB3vDeqVXfST+uHekgvzqEB9xW6/aM5XJZ338AHoq2L/JqsRv1ZtrlD28+KIK
	 Q7zDH0F+GxNVB+GRjlduPTPYoqF2JLQed+cD49E8KKiS1phJ4lM7dXatZERn19o9S9
	 jr6dEzc9+PnCg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id E567641309; Sun, 27 Sep 2026 09:08:32 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790500110;
	bh=oToI6ocywaDYgSDHv8lCPFoU+IWrD9coqeJrVTcBn4s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EkIN0g4j4VyzcvZ7DnA5vE22plL56oF8+i2iqErbLK5xuwzf2smCIuNAT3wt48xUn
	 XJLLbrG2yOhuwT8ftI+WPeFmXSL/E0vfntfFHLx0RywHpO31DTgjGpPUrBO6voUg+9
	 Nqy8ouAyhqUGO51bO4oc66UridSkvSctIQh1C3mqyAbXw0v8ZOirsGw5OG17FBG51g
	 4m/3XCXBJsIt6uvfHdBsqlTZIaxeyK+mFIsbhsTQmJM+vLBrGjG8hIp8eTyRmozvMg
	 jd/Tbb4AXf6spVl6FcgzwkZ0NncyKJtpde0pa1L3chgzHCJ4xNsbJMBgMYT6GN6Eux
	 hsNChUV3XRnfw==
Received: from [192.168.2.51] (p5798b961.dip0.t-ipconnect.de [87.152.185.97])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 7A06D412E0;
	Sun, 27 Sep 2026 09:08:30 +0000 (UTC)
Message-ID: <b67c9e75-a179-443d-b01c-dc78c75c22bf@birger-koblitz.de>
Date: Sun, 27 Sep 2026 11:08:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 04/15] ax88179_178a: Split driver into
 library and device specific code
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
References: <20260916-ax88179a-v12-4-60c04c9924a2@birger-koblitz.de>
 <178968029415.22033.4203681974249867316@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <178968029415.22033.4203681974249867316@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 17/09/2026 11:24 pm, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 (1) · Medium: 1 (5) · Low: 1
> 
> - [Medium] The module is renamed from ax88179_178a.ko to ax88179.ko
>    (drivers/net/usb/Makefile: `obj-$(CONFIG_USB_NET_AX88179_178A) +=…
> - [Low] New-file hygiene problems in the added files.
Added module-alias MODULE_ALIAS("ax88179_178a") as suggested

> 
> Pre-existing issues:
> - [High] ax88179_get_eeprom() (drivers/net/usb/ax88179_lib.c) can copy
>    uninitialized kernel heap bytes to userspace when the attached USB…
> - [Medium] ax88179_set_features() (drivers/net/usb/ax88179_lib.c:338-364)
>    ignores every command result.
> - [Medium] ax88179_change_mtu() (drivers/net/usb/ax88179_lib.c:400-426)
>    commits the software MTU first (`WRITE_ONCE(net->mtu, new_mtu);…
> - [Medium] ax88179_set_mac_addr() (drivers/net/usb/ax88179_lib.c:425-443)
>    calls eth_hw_addr_set(net, addr->sa_data) before issuing the…
> - [Medium] ax88179_mdio_read() (drivers/net/usb/ax88179_lib.c:151-158)
>    discards the return value of ax88179_read_cmd() and returns the output…
> - [Medium] ax88179_set_eeprom() (drivers/net/usb/ax88179_lib.c:229-297)
>    mixes byte-oriented userspace data with native-word register helpers,…
> 
Will fix where touched, see later commits.

