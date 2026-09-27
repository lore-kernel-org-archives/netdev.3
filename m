Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B862C35893;
	Sun, 27 Sep 2026 09:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790501804; cv=none; b=kIbhYSokJilpLY0G9vDyiV8M3yiDZAn6ApO8yixS5/ZspFpjfHm78RUTBlMRes7xHzmE85fV4gFnDABMi5gIJw3DdtfU4N71y5utxdXwEPjolFQ5u39mTBEbndlcqMJ0oImv/Efl3cs2O7UWSvPrLD7f4s8Otw1C8ApOaVOfZyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790501804; c=relaxed/simple;
	bh=877P9thvOC69SC6aZ03dphdj1j4Lx1k1zv5MCStgjoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jfSdtdkk7QkKNLnhNhbLbDaUlwq2cgM/7afLJNvfK9r1MrIMfpIDZ3k3N7MTXG0+9m7MJw1doFg4LRmdwpPmwq+1jvQ5YGFGJZaPu6K4lQ04JREyl51cxsKhseAAi7c7UzPHc/Q3/BcVg8S/qsLQXEeasC2YIuWH59EJ3rJEDLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=iXBc85xq; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=EbMRPnu3; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="iXBc85xq";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="EbMRPnu3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790501800;
	bh=877P9thvOC69SC6aZ03dphdj1j4Lx1k1zv5MCStgjoo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iXBc85xqWXpbWp6MgmYRlrz8rE7UmfTnKr6c5CHUARTj3Y0jiCsGXmAP/YBMLenHj
	 mzW1T0UXPQ/bChxELNOKSd91ZM8mZ/JXQ52nFzlhimRAr7uMd7GU5GfROcJ/ypOCG3
	 0st+AJz0tftsUHMNShxnItkDhG86oaQcQiPZw8aqce7Vb9XHgk4l7EWm1Tx8VaYqHm
	 63xsJWiWVx07/nPg6t37u2t/PaKTDL3//g4H4bGc5rCRXNYryqUqxh2iNQQ/EwoX43
	 uKJwZWobLG0dTlD0pXYUy2yF8W8iVhhUbpwwr28Hu+emyannIY8zZpmjFttESVb7s1
	 grCHEyt+c4HCA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id EC23541312; Sun, 27 Sep 2026 09:36:40 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790501799;
	bh=877P9thvOC69SC6aZ03dphdj1j4Lx1k1zv5MCStgjoo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EbMRPnu33v5foiBwAQ7D/WiaWYx1t58rtzU+F/iHC/mNPUzL1GI2RYwZBvmGu1AQR
	 Qa5I0entFrc7KX59fvyOc+6+pIemS26e32hxbHYFM9lPzASeDLjM9yLtS4EDynT2Ar
	 T5C7jVeEKNv1ZkjmuWFdQMUmhHd8elILVauSoLEIZoUVRI5NuUrUluZ+bo+k3EqxeU
	 99GRoqLpzkhP+SwInERCBLjTkf8mRRhnPiLTG9ojKDZLPj2jkXVyF6OSyuSyMWMHOW
	 OrMHFnRDBAPWT6+PJUyaqLpCixbcEcUcztr1iBhGRHlq3vHF3m/5pUl2tAPVm67Pd9
	 dx3ISnbslgH3Q==
Received: from [192.168.2.51] (p5798b961.dip0.t-ipconnect.de [87.152.185.97])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 880DB412CD;
	Sun, 27 Sep 2026 09:36:39 +0000 (UTC)
Message-ID: <c85b5623-a8c7-437d-8d75-14e59b20b1c5@birger-koblitz.de>
Date: Sun, 27 Sep 2026 11:36:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 11/15] ax88179_178a: Add Suspend/resume
 support for AX88179A/772D/279
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
References: <20260916-ax88179a-v12-11-60c04c9924a2@birger-koblitz.de>
 <178968030357.22033.18257401689515949008@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <178968030357.22033.18257401689515949008@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/09/2026 11:25 pm, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 9 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 2 · Medium: 4 · Low: 3
> 
> - [High] ax88179a_suspend() (drivers/net/usb/ax88179a_devices.c:170-172)
>    calls usbnet_suspend(intf, message) but discards its return value and…
Fixed by moving usbnet_suspend() before the WoL configuration, and
unwinding phylink_suspend() if usbnet_suspend has failed.

> - [High] ax88179a_resume() (drivers/net/usb/ax88179a_devices.c:210-214)
>    and ax88179a_suspend() (:138-142) call rtnl_lock() from inside the…
Will fix by using the same strategy as asix_devices.c and holding a
runtime-PM active usage ref in ax88179a_bind().

> - [Medium] The new WoL programming in ax88179a_suspend()
>    (drivers/net/usb/ax88179a_devices.c:146-152) performs a purely…
Will fix by clearing the bits before they are conditionally set:
tmp &= ~(AX_MONITOR_MODE_RWLC | AX_MONITOR_MODE_RWMP);
When wolopts == 0, the arming bits do not matter, because the PHY is not
put into a monitoring mode, they do not need to be cleared. Note that
the firmware clears these bits after wakeup.

> - [Medium] The new PM callbacks consume the results of ax88179_read_cmd()
>    without checking the status, and for one-byte reads the destination is…Will fix by initializing tmp8 before the reads in both the suspend and
resume callbacks. In resume read status is also explicitly checked. For
suspend it is not clear whether to abort suspend just because the WoL
programming does not work justifies aborting suspend. Since tmp8 is
initialized, no garbage from the stack is written.

> - [Medium] ax88179a_stop() (drivers/net/usb/ax88179a_devices.c:1163-1165)
>    sets 'reg8 = 0;' and then calls ax88179_read_cmd(dev,…
Duplicate of a previous bug, fixed by correcting to ax88179_read_cmd()

> - [Medium] The new ax88179a_resume() calls ax88179a_reset()
>    (drivers/net/usb/ax88179a_devices.c:208), which unconditionally…
Will fix by conditionally setting AX_RX_CTL_PRO flag of data->rxctl
in ax88179a_reset().

> - [Low] The comment added in ax88179a_reset()
>    (drivers/net/usb/ax88179a_devices.c:1140-1142) claims that when the…
Will fix typo in comment: ax88179_reset() -> ax88179a_reset()

> - [Low] The comment added in ax88179a_resume()
>    (drivers/net/usb/ax88179a_devices.c:201-203) says 'PHY-power is re-…
Will fix by changing wording of comment.

> - [Low] The new PM callbacks issue a chain of vendor control transfers
>    whose results are all discarded and then report success.

Duplicate of above, handled there.

