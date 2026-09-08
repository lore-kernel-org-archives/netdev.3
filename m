Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021483AC0C9;
	Tue,  8 Sep 2026 08:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788854502; cv=none; b=ZBxIww2SKPy+LASpTL25q1yxZGS+aUBpFJc4+Dux3UCHy2DCBYs9C+QzznvNb56QBhxqzOiXWgi8ZBlXYt7V8TOjFJe2czx515S1s9J6UuJ8o0UFwm/C16fAQf3kblg3A8NwVaekb8TN8BlSWqM7LT+7xOCHzmVhxq1DGpL5MnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788854502; c=relaxed/simple;
	bh=Ni5sLgabX3+TrgYKZLGpGL/A9YLHAwDLjMNIBhaOLTw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ccDDAkdenpT66a9cA4CaE1FOPcfCWtX4MnuXbkxEln/7U8lECNykFy8MLiC/t8NjyK5+FS4Nc1g4mh8RCsB4+rPSqK3XH7QfBJIw3fHmETUUOQDhd7Ltqk4MotvbrAW8zEBpAs+1Z7IBHFb+X+/r+IUrt+BK4kiLt8lNSoEG7DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iorwu3x6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iorwu3x6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF171F00A3A;
	Tue,  8 Sep 2026 08:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788854500;
	bh=SmrRj7Gav6q2XR9DsmOZbzfZ2pmI6wotYdOd/GW3g3Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iorwu3x6aKOsF07d2RrEXCC5sVMjD9q76d26bOGDEF0LNMDBbupvK1vGBaCVoyrEH
	 iUwceYtxKeEKQisz8x0soZUarwyaisz1wwXREcGGAhROtxzKRE6VifuGruCrSO/I81
	 ccFrTObSIu2lhZE3E5EqT4wM49KKatA/pXUxjzO3Kl/cy0c4jZCy7nzK59ibkugmZc
	 r/eJgMSkYsTzM+rq9jjqN0IgnhRrU6tTIDFbVmDHp1rtz0cdCrapPpxtGu+EhzvrLL
	 +YV8isg5nKNz0nF60FQSKeRaQiMbhLlpBNJJ/I/ae8lvcyC7QUjBmXb2+30ILmdBkF
	 YEg19jSO8wdCQ==
Subject: Re: [PATCH net RFT] ch9200: do return USB errors from control_write()
From: netdev-bot+sashiko@kernel.org
To: s.shtylyov@auroraos.dev
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, mjg59@srcf.ucam.org, linux-kernel@vger.kernel.org
Date: Tue, 08 Sep 2026 08:01:39 +0000
Message-ID: <178885449964.219967.4487690524073410201@kernel.org>
In-Reply-To: <20260904200108.85165-1-s.shtylyov@auroraos.dev>
References: <20260904200108.85165-1-s.shtylyov@auroraos.dev>
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

- [High] Incomplete fix: control_write() in drivers/net/usb/ch9200.c now
  returns the real USB/short-transfer/allocation error (negative errno…

--

ch9200: do return USB errors from control_write()

The patch removes the unconditional "return 0" from control_write() in
drivers/net/usb/ch9200.c so that the value computed from usb_control_msg()
(and the -ENOMEM from kmemdup()) reaches the callers.  The commit is tagged
Fixes: 4a476bd6d1d9 ("usbnet: New driver for QinHeng CH9200 devices").

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
The commit message says the intent is to "propagate USB errors to the
callers", but do any of the callers in this driver actually look at the
returned value?

There are only two call sites.  ch9200_mdio_write() is the void
mii_if_info::mdio_write callback and drops the result completely:

drivers/net/usb/ch9200.c:ch9200_mdio_write() {
	...
	control_write(dev, REQUEST_WRITE, 0, loc * 2, buff, 0x02,
		      CONTROL_TIMEOUT_MS);
}

so the BMCR write issued by mii_nway_restart() from ch9200_bind() still
fails silently.

The other call site is ch9200_bind(), which assigns to retval six times
without ever testing it, and then overwrites it one last time:

drivers/net/usb/ch9200.c:ch9200_bind() {
	...
	retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_THRESHOLD, data,
			       0x02, CONTROL_TIMEOUT_MS);
	...
	retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_FIFO_DEPTH, data,
			       0x02, CONTROL_TIMEOUT_MS);
	...
	retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_CTRL, data, 0x02,
			       CONTROL_TIMEOUT_MS);

	retval = get_mac_address(dev, addr);
	eth_hw_addr_set(dev->net, addr);

	return retval;
}

Since get_mac_address() returns only 0 or -EINVAL, doesn't every newly
propagated control_write() error get discarded here?  If the three MAC
address reads succeed while, say, the MAC_REG_CTRL write fails, ch9200_bind()
returns 0, usbnet_probe() only aborts on "status < 0", and the netdev is
registered with MAC_REG_CTRL, the FIFO depth, the threshold and the flow
control registers never programmed.

Would it make sense to add the call site checks in the same patch, e.g.

	retval = control_write(...);
	if (retval < 0)
		return retval;

otherwise the error swallowing that the Fixes: tag refers to stays
reachable and the change has no observable effect.

One related detail for whoever adds those checks: on success control_write()
now returns the transferred byte count, not 0, because the short transfer
test leaves err == size untouched:

	if (err >= 0 && err < size)
		err = -EINVAL;

So only "if (retval < 0)" tests are valid at the call sites; a later
"if (retval)" check would abort probe on success.  Would it be preferable to
normalise success to 0 in control_write() instead?

If the intent is only a preparatory cleanup with no functional change, could
the changelog say so and drop or justify the Fixes: tag, given that stable
and AUTOSEL will otherwise pick up a no-op?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904200108.85165-1-s.shtylyov%40auroraos.dev
