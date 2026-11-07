Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794021799;
	b=v08QSHaCM09vJnY3UhcKsLoM0RMg8qT0WrFV6ArmYzE20BFCl5+xnuhQPhU8d9oZQboc
	 YAlUX02YR5WD6KhwgaQcbAp5iqfFt7pqmGoV8gQZ/nwxYHXuBLYZv0ADoSKJ6OenyKmDo
	 i7neGr3YJCWEhel9hSdIAKfrvs+DsmFkau/azkdSv0lRLZELIvmJPNQOkYxtTjh6VGQqr
	 cC92powpGOZ31iGE9ZVPViRyeAdETMCBEvbpY/yNzM2xqR588mdg9WB4byd2xOUTPr48F
	 HKBjJq0bkFfsEwg1LOvcaomjeU+mL+kDDOorpyysE18fxGHXOOjkjqsvx+f7Bd15+WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794021799;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=VkKNvjYB/XrLT101psQRlLLKmu8u1pDOUOv3kXxoEDs=;
	b=WRWkmlW5rRWnQJaPpGYVZHlBwk251cEaMWY8KY6E60LMyXcngwcBWIXvHYqVQOlOsryM
	 YGRwo+vjL9C+TOkMmjOtUx46SU6mcz134fFg5BLm976EwO4lriF6y4j8WRaaceZrQkboT
	 hgee0qj2sfMf2WyN3lHQHmsb03Lm6SZQw2+hCE6xUtZxP/w667JAQ7puqofSVLrgZLyvf
	 mvlwfVELs2ctzU03G3JuHvAmkfkrrpse2u4D1Bb+HmfX4g9M0jG546Rc92NfWc1YNrvMl
	 jeKcgWjqZQfjtMZiRkZAOEhItpe+07ud4ApAXnx24USc2HfQ7q1T8LwjIFpC6YRDl8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=APFbD6+q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E23D606A32D;
	Sat,  7 Nov 2026 03:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=APFbD6+q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0E41F0089F;
	Sat,  7 Nov 2026 03:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794021799;
	bh=VkKNvjYB/XrLT101psQRlLLKmu8u1pDOUOv3kXxoEDs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=APFbD6+qi1C70+nCWnrwtlhWWAUokTB2Gdjt5ZIzZlm2Ndf5nsfTEb7j5qNaNkMRF
	 I1IcLi08H16q7KC42PFWVg+eBpnHby+Xel2O5kae7NjKUkIOlCZ2NYLH5aoDVDTpvU
	 z7zprwzFVcTfvAdy8Flz5hTEZ54WYofPl94i596eICzjU4bj0Mtd8pnhOywshdcC1c
	 wCox+sNxeNkdlY9fuePELkLx6WVRIV8wF47weKvS+25byRd2w7t5SYgUztT3nBEYs/
	 7BvH2JzykA6orSWnugfWBQYV0JFTSPqB/jRBqjBidCskGcwV93i/6ZsKlcf8pQfx1u
	 hUC/+hoyaPIlg==
Subject: Re: [PATCH net v7 1/3] nfc: nci: uart: serialize driver selection
From: netdev-bot+sashiko@kernel.org
To: shubham@octane.security
Cc: netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev, david@ixit.cz,
 horms@kernel.org, gio@octane.security, kuba@kernel.org
Date: Sat, 07 Nov 2026 03:23:18 +0000
Message-ID: <179402179848.994134.13388599854026266988@kernel.org>
In-Reply-To: <20261104062026.80599-2-shubham@octane.security>
References: <20261104062026.80599-2-shubham@octane.security>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message understates what the bug does.

--

nfc: nci: uart: serialize driver selection

This commit allocates the NCI UART context when the line discipline is
opened and claims it atomically in NCIUARTSETDRIVER, so two concurrent
callers can no longer both register a device. It also puts the transport
registry under a mutex and pins the transport module before calling into
it.

> NCIUARTSETDRIVER assumes that tty->disc_data remains NULL until a
> transport has been selected.  Two concurrent callers can therefore both
> allocate and register an NCI device for the same line discipline.
>
> The transport registry can also be changed while a caller is copying a
> template from it, before the transport module has been pinned.

[Severity: Low]
This isn't a bug in the code, but could the commit message say what these
races lead to? As written, it reads like a duplicate registration. The old
code looks like it allowed memory-safety problems.

In the old nci_uart_set_driver(), both racing callers allocate a context
and call ops.open(). For nfcmrvl, that path is nfcmrvl_nci_uart_open() ->
nfcmrvl_nci_register_dev() -> nci_register_device(), so each caller
registers its own NFC device. Both then do:

	tty->disc_data = nu;

The last write wins. nci_uart_tty_close() only tears down tty->disc_data,
so the losing nu and its NFC device are never closed and are leaked.

That leaked device still has nu->tty pointing at a tty that is freed
later. Bringing it up afterwards would go nci_uart_send() ->
nci_uart_write_work() -> tty->ops->write() on the freed tty_struct.

The old code also read the registry twice without a lock:

	if (!nci_uart_drivers[driver])
		return -ENOENT;
	...
	memcpy(nu, nci_uart_drivers[driver], sizeof(struct nci_uart));

If nci_uart_unregister() runs between the two reads, the memcpy() reads
through a NULL pointer.

It also ran ops.open(), which is code in the transport module, before
pinning that module:

	ret = nu->ops.open(nu);
	if (ret) {
		kfree(nu);
		return ret;
	} else if (!try_module_get(nu->owner)) {

The reproducer used a pty, and NCIUARTSETDRIVER has no capability check.
Would it make sense to name the leak, the use-after-free, the NULL
dereference and the call into an unloading module explicitly?

Step 9 of Documentation/process/coding-assistants.rst asks AI-assisted
reports to check Documentation/process/threat-model.rst and classify the
bug as a vulnerability or a regular bug. Should the commit message include
that classification?

Does this also need a Cc: stable@vger.kernel.org tag? According to
Documentation/process/maintainer-netdev.rst, netdev follows the standard
stable rules for fixes.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104062026.80599-1-shubham%40octane.security
