Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C104BE42E;
	Tue, 15 Sep 2026 23:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789514453; cv=none; b=Eib4UZrYV+OG3x8RAdxNIzpfrOQVhzk0vvBuORB+jnjF2Iut06dD523RSn9hw8zFOasCvBRbBOQ+vW/FcLd/0gDEGkZKxrrT1leYaxCRIVAgVi4gGH1epdO7jhGMsTj/BEefX6VI20O+O5106/Zf/xqTdvsZFd0xUP59LO9jAIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789514453; c=relaxed/simple;
	bh=QWOqeLgdOC/MK7cjQDIAV8GkIha/ePT7XQrs7Xz7B0E=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MExqmUpHxuIRC6Y7jxTvQoMZ3vUn52J4CBdL74PldbY08A+9I4zoqTVnNQQToRMr1qkzy+vtSIFwGNrqprZR9jACAcabDnaVD0/+nYBWIbQawADWX8nvSTn2JDqcSXi3pr3/dkRqZvvMnjccr9x5zjr4j9WM74cqRwF2laUcXPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZ64rXTw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZ64rXTw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746271F0089A;
	Tue, 15 Sep 2026 23:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789514451;
	bh=+HPLiZZN3i40ABBHtqgLuf0XLXTZptDhyrSYWueE2r8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hZ64rXTwoV8xRa1MU1O9FkYvoPtCLqIqngqk5E/1+rj6XNfjKvocUfmLw1BSlM+0t
	 UibDjo2jcYya5Evka5XoTLPFYwcwUJ/z1JA9DQp9WEFsl81/BuaA+FMj+rlpu80H0u
	 9dNOIYmQzGOu+qNp+ez0XSI7ol92tWMLqaK5lyLZxQ78AIPeMYoQxqakJ1fp6epuR8
	 3Eg0MKDz7Jhtuyr3SmgLcb/jOWd71lcf2Yl6qEl1bnok+Rmn+/gvzFZaDwi4cpJYRD
	 kupmiQXLk52BJYx8uag+lsmDP+rZGzhpLMFJ+Nye6ZX9QKKe0wGR/v/crNOAZTL2RJ
	 g/kNWX409GZEQ==
Subject: Re: [PATCH net] ch9200: return error on failed register writes in
 ch9200_bind()
From: netdev-bot+sashiko@kernel.org
To: s.shtylyov@auroraos.dev
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, mjg59@srcf.ucam.org, linux-kernel@vger.kernel.org
Date: Tue, 15 Sep 2026 23:20:50 +0000
Message-ID: <178951445003.22033.8083675025384414442@kernel.org>
In-Reply-To: <20260914202503.52920-1-s.shtylyov@auroraos.dev>
References: <20260914202503.52920-1-s.shtylyov@auroraos.dev>
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

- [High] Ineffective fix: the six newly added `if (retval < 0) return
  retval;` checks in ch9200_bind() (drivers/net/usb/ch9200.c) cannot…

--

ch9200: return error on failed register writes in ch9200_bind()

The patch adds error checks after the six control_write() calls in
ch9200_bind() so that a failed vendor register write aborts the bind
instead of being ignored.  It carries a Fixes tag for the original driver
commit 4a476bd6d1d9.

> diff --git a/drivers/net/usb/ch9200.c b/drivers/net/usb/ch9200.c
> index a206ffa76f1b9..ab3cd3902ed72 100644
> --- a/drivers/net/usb/ch9200.c
> +++ b/drivers/net/usb/ch9200.c
> @@ -360,32 +360,44 @@ static int ch9200_bind(struct usbnet *dev, struct usb_interface *intf)
>  	data[1] = 0x0F;
>  	retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_THRESHOLD, data,
>  			       0x02, CONTROL_TIMEOUT_MS);
> +	if (retval < 0)
> +		return retval;

[Severity: High]

Can these new checks ever observe a failed register write?  control_write()
in the same file discards the USB transfer status on its normal path:

drivers/net/usb/ch9200.c:control_write() {
	...
	err = usb_control_msg(dev->udev,
			      usb_sndctrlpipe(dev->udev, 0),
			      request, request_type, value, index, buf, size,
			      timeout);
	if (err >= 0 && err < size)
		err = -EINVAL;
	kfree(buf);

	return 0;

err_out:
	return err;
}

The only return err; is at err_out:, which is reached solely from the
kmemdup() -ENOMEM branch.  All six patched call sites pass a non-NULL
2-byte data buffer, so the only negative value the new checks can see is
-ENOMEM from that allocation.

A STALL of the vendor OUT request (-EPIPE), a timeout (-ETIMEDOUT), a
disconnect during bind (-ENODEV/-ESHUTDOWN), a protocol error (-EPROTO),
or a short control transfer (normalized to -EINVAL just above) are all
turned into 0, so ch9200_bind() still falls through to
get_mac_address()/eth_hw_addr_set() and reports success with
MAC_REG_THRESHOLD, MAC_REG_FIFO_DEPTH, MAC_REG_PAUSE,
MAC_REG_FLOW_CONTROL, register 254 and MAC_REG_CTRL (which arms TX/RX)
left unprogrammed.

The sibling helper control_read() already returns err on its normal path,
and ch9200_mdio_read() checks it with if (ret < 0), so the convention
control_write() is expected to follow already exists in this file.

Would it make more sense to change control_write() to return err after
kfree(buf) instead of (or in addition to) adding the caller-side checks?
As it stands the commit message claim that this makes the driver "bail out
of ch9200_bind() on failed writes" does not seem to hold for actual
transfer failures.

> 
>  	data[0] = 0xA0;
>  	data[1] = 0x90;
>  	retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_FIFO_DEPTH, data,
>  			       0x02, CONTROL_TIMEOUT_MS);
> +	if (retval < 0)
> +		return retval;

[ ... remaining four checks have the same question ... ]

>  	retval = get_mac_address(dev, addr);
>  	eth_hw_addr_set(dev->net, addr);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914202503.52920-1-s.shtylyov%40auroraos.dev
