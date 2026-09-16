Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC35544AB7C;
	Wed, 16 Sep 2026 07:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789543448; cv=none; b=CNe9dRiYWyiGWAvjWOGTziN3KnsRZuzWenGUDW46FF8adNQNVOoabOb7Pm6WVCB9g8JHcC+Q8AhPiZ+zD6JajWxPpzLnYRQXinsVmF8vinyPdTzl4fUk6gmdeMe0hDaYLxIf80qhrA4TPZKsoMXbMUnH6mtdNwnUw6JR13x4JPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789543448; c=relaxed/simple;
	bh=pv4YiSEYhniYeLjq5C6aGWtnsM7lriLkIlczhuma2jA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bzwNjNYDLh9d+bjPgEbQbZCphWOHeBXr4ICYMA19SWuJT8Kc6Np4fuYCSXiC/VaRnLqMiPmpYW7GHIgQEoUrvhBKs0cpairpuaQP2pVygpC4vXDvS3+EI4Mce4P9/bPUtb5Ac8w2pm2z8nzvM8Ow0QhuXbw5yBT9lmK/7qbkmy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciyHJtRG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciyHJtRG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBC51F000FF;
	Wed, 16 Sep 2026 07:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789543411;
	bh=JEEBo7DCo8qHlpa9rPEfL3KH46iSCK/Xfmzst8QTGW0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ciyHJtRGkfrkTrp3XYYpNPTa5GPqeJnxo6KUyPBNpeW7OuRDgjIxZzmgTJnm0upRJ
	 DKe8tmiFC4xYKIimL/AP6jaWXqLSnj7J0fDHX9Dp+UuOIlH0OchdFkjz6PU7Jbw78V
	 9y+3M5f3pY3vfPfOkmXXufu23mJN1D7p3r45V3QCLwslF2tIeYmqWVUSc0arGrmKtU
	 oG1UUtMrT0CEWKKYo/fDSaEThT2VDl3f0Bf7j73E/thBoj+AqNipL2ylAuzD99CuQn
	 um098l0CkeNWEBZr4Bm4SD7/+sVqlsiZP8smQ8WRXKtsG2odBCBcNPhOc9v1XU9MQe
	 tkRnjW5Q30cqg==
Subject:
 Re: [PATCH net-next v2] ch9200: do return USB errors from control_write()
From: netdev-bot+sashiko@kernel.org
To: s.shtylyov@auroraos.dev
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 16 Sep 2026 07:23:30 +0000
Message-ID: <178954341078.22033.8722936070498955076@kernel.org>
In-Reply-To: <20260915185805.38712-1-s.shtylyov@auroraos.dev>
References: <20260915185805.38712-1-s.shtylyov@auroraos.dev>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 0

- [High] Incomplete fix: after removing `return 0;` from control_write()
  (drivers/net/usb/ch9200.c:137-171), the helper now returns the…

--

ch9200: do return USB errors from control_write()

This removes the unconditional "return 0;" at the end of control_write()
in drivers/net/usb/ch9200.c so that the function falls through to
"return err;" instead. The stated intent is to propagate usb_control_msg()
errors to the callers.

> diff --git a/drivers/net/usb/ch9200.c b/drivers/net/usb/ch9200.c
> index a206ffa76f1b9..3a81e9e96fd33 100644
> --- a/drivers/net/usb/ch9200.c
> +++ b/drivers/net/usb/ch9200.c
> @@ -168,8 +168,6 @@ static int control_write(struct usbnet *dev, unsigned char request,
>  		err = -EINVAL;
>  	kfree(buf);
>  
> -	return 0;
> -
>  err_out:
>  	return err;
>  }

[Severity: High]
The commit message says this will "propagate USB errors to the callers",
but do any of the callers actually consume the value?

There are two in-tree callers.  ch9200_mdio_write() is void and calls it
as a bare statement:

drivers/net/usb/ch9200.c:ch9200_mdio_write() {
	...
	control_write(dev, REQUEST_WRITE, 0, loc * 2, buff, 0x02,
		      CONTROL_TIMEOUT_MS);
}

ch9200_bind() stores the result six times and overwrites it every time,
with the last store clobbered by get_mac_address():

drivers/net/usb/ch9200.c:ch9200_bind() {
	...
	retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_THRESHOLD, data,
			       0x02, CONTROL_TIMEOUT_MS);
	...
	retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_CTRL, data, 0x02,
			       CONTROL_TIMEOUT_MS);

	retval = get_mac_address(dev, addr);
	eth_hw_addr_set(dev->net, addr);

	return retval;
}

Since usbnet_probe() only aborts on a negative bind() status:

drivers/net/usb/usbnet.c:usbnet_probe() {
	...
		status = info->bind(dev, udev);
		if (status < 0)
			goto out1;
}

bind still reports success when every register write failed, for example
when a failed MAC_REG_THRESHOLD/MAC_REG_FIFO_DEPTH write is followed by a
successful MAC_REG_CTRL = 0x0D5F write that arms DMA/receiver/transmitter
with unprogrammed FIFO and flow-control watermarks, or when the
MAC_REG_CTRL write itself fails and the netdev is registered with the
datapath never enabled.  Is the observable behaviour of the driver changed
at all by this patch?

There is a second point about the resulting contract.  On success
usb_control_msg() returns the transferred length, so control_write() now
returns a positive value (2 for these register writes) rather than 0:

	err = usb_control_msg(dev->udev, ...);
	if (err >= 0 && err < size)
		err = -EINVAL;

Would the obvious caller-side follow-up "if (retval) return retval;" then
treat every successful 2-byte register write as a failure?  Would it be
better to normalize success to 0 in control_write(), or to check
"retval < 0" in each caller and update the callers in the same patch so
the errors being returned are actually acted upon?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915185805.38712-1-s.shtylyov%40auroraos.dev
