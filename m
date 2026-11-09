Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211341;
	b=jzfhMp5Is/i28PtkuFrKizeCUVcFpc68wOklgHlA0EMSEd6IxCcM30m6VWXc30LS5TCO
	 gfNqggZWg+jX+kdy970EqkUOqAlRQKtv9V5/X3YVmttwp8EF3Iaj6x0kPUHD8g5FbjShm
	 CbQWzx0HnAg1TOO4JPl3e1CNnjYZkJXLoCS6ESpOohjEZjlMgvBUCXzK4mFSmULUQkb+g
	 de9am9EVqt7FUd/9dlSoMaC/RMW031T+G10kEbqryqimApkm9HUhghq0D7GNDPwIdYEq8
	 BTRC0xThYPuxT3zHEJfYAGEyvqKjmZhySydwHpEBOmlrqYat6pXjQvlEIcyQsoNlmtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211341;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=zn9xg9opWibp15PfCBcWey+5DGHdCRlF3nHuppKwlss=;
	b=y4ki4DNVKEyqtCqxGoFIlTZMR5LdCwGLU1meqkksGIBeiWLv2Col0OaFDaWzeuLp0Gfo
	 mj5J8unxwt6leJYHZeHPNtnzvUVNJ5Wc1tNVCqEgI52/Jo1E6b8PJ0IRkYmrtM6w7G8q1
	 MCXyw/PwTOAc9mQFkKUaFdIhYx2BznP0C5H0XLE+MedzGiv0ckqChSRjiOp4CcWbeprzb
	 eh8T+GXNQZRenhhQ2BCOxaVxNVldXrqGItcoZq0GnKmT/8IBNYMIJWcFFvFEOs/mQtmxY
	 seOXGwS29qgyzHjTamE3Ec9G4csYnBbkzxDkyg+fwJibOwG8Sb+ZsXY9WVsxrFMFllg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J368ZaPs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1CB606A335;
	Mon,  9 Nov 2026 08:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J368ZaPs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2361F008A1;
	Mon,  9 Nov 2026 08:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794211341;
	bh=zn9xg9opWibp15PfCBcWey+5DGHdCRlF3nHuppKwlss=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J368ZaPszS8xybdDT4fbGyjht0xi43TS+zYaplUQhixvwYLaLsTkNTyRDoH6/mzii
	 CL/YfCbQfnvJlima2nW5+/u/2GIgiaZQQCLfqAnnznI0Gewl0rTa2cTz41EqBqW16V
	 xXlNlZxuLh83UVNRO/xYvC5b5Ty0bi2vU0EfLf8Qe2LEKxCaGoN67pIrq6Fu9T921A
	 1QM+/g4CWz+20HgRGxqOnP1KXf1moBBB0Is3bENj6pVYFS03JsfnP63b/dsDE8qJca
	 cbACGvQDesxhpg64jffZ5bVKPvc8ufmh+k1nyaQVfQP/hr66KI8HZF3b+26GS5Qfnp
	 jsbroJC3dJLiQ==
Subject: Re: [PATCH v3 2/2] usb: gadget: u_ether: fix out-of-bounds read in
 get_ether_addr
From: netdev-bot+sashiko@kernel.org
To: liuc63@xiaopeng.com
Cc: gregkh@linuxfoundation.org, akpm@linux-foundation.org,
 andriy.shevchenko@intel.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, khtsai@google.com,
 fangxy@xiaopeng.com, rdunlap@infradead.org, dbrownell@users.sourceforge.net,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Date: Mon, 09 Nov 2026 08:02:19 +0000
Message-ID: <179421133992.994134.2792673257546866633@kernel.org>
In-Reply-To: <20261105072147.3383565-3-liuc63@xiaopeng.com>
References: <20261105072147.3383565-3-liuc63@xiaopeng.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message misdescribes what users see after the
  change.
- [Low] get_ether_addr() still accepts malformed addresses that have
  trailing characters, and silently cuts them down to their first six…
- [Low] The patch fixes a slab-out-of-bounds read that KASAN reports in
  get_ether_addr(), reachable with `insmod g_ether.ko dev_addr=ab`, but…

--

usb: gadget: u_ether: fix out-of-bounds read in get_ether_addr

This patch replaces the open coded six iteration parsing loop in
get_ether_addr() with parse_mac_pton() for ':' and '.' delimited
addresses, and with hex2bin() for the separator-less form. The goal is
to fix an out-of-bounds read on short strings and to stop accepting
non-hex digits. It also makes USB_U_ETHER select GENERIC_NET_UTILS.

Link: https://lore.kernel.org/all/20261104025058.2650911-3-liuc63@xiaopeng.com/

> The configfs dev_addr and host_addr attributes of the ECM and NCM
> functions reach the same parser through gether_set_dev_addr() and
> gether_set_host_addr().

[ ... ]

> What stops working
> is the Cisco notation "aabb.ccdd.eeff" and irregular groupings such as
> "123456:789abc", which the old loop only accepted because it skipped a
> delimiter wherever it happened to find one.  Supporting them would need
> a parser per grouping, so such input now falls back to a random address.

[Severity: Medium]
Is the random address fallback accurate for the configfs path?

For "aabb.ccdd.eeff", parse_mac_pton() rejects the string because it is
shorter than MAC_ADDR_STR_LEN. hex2bin() rejects it at the '.' at offset
4. get_ether_addr() then returns 1, and the caller discards the random
address it wrote into new_addr:

drivers/usb/gadget/function/u_ether.c:gether_set_dev_addr() {
    ...
	if (get_ether_addr(dev_addr, new_addr))
		return -EINVAL;
    ...
}

gether_set_host_addr() does the same. The store handlers generated by
USB_ETHERNET_CONFIGFS_ITEM_ATTR_DEV_ADDR() and _HOST_ADDR() in
u_ether_configfs.h pass that error back to userspace:

		ret = gether_set_dev_addr(opts->net, page);
		mutex_unlock(&opts->lock);
		if (!ret)
			ret = len;
		return ret;

So a gadget setup script that used to write "aabb.ccdd.eeff" without
error will now get EINVAL from write(2), and the old address stays in
place. It does not get a random address. Only the legacy module
parameter users (ether.c, cdc2.c, multi.c, ncm.c, g_ffs.c) ignore the
failure and keep the address that was randomised at creation.

Five functions use these configfs macros: f_ecm, f_eem, f_ncm, f_rndis
and f_subset, not just ECM and NCM.

Could the commit message describe this configfs ABI change and its
scope more precisely?

[ ... ]

> The loop is older than the git history: it is already present in
> drivers/usb/gadget/ether.c in commit 1da177e4c3f4 ("Linux-2.6.12-rc2")
> and was copied into u_ether.c by commit 2b3d942c4878 ("usb ethernet
> gadget: split out network core"), hence no Fixes tag.

[Severity: Low]
Should this still have a Fixes: tag? For bugs that predate git, the
usual convention is:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

2b3d942c4878 would also work. Without a tag, and with Cc: stable
dropped in v2, stable and distro backport tooling will not pick up this
fix for the out-of-bounds read that KASAN reports.

If the fix is backported, the commit that adds parse_mac_pton(),
e5765bbb2de1 ("lib/net_utils: allow mac_pton() to take a custom
delimiter"), also needs to be marked as a stable prerequisite. This
patch does not build without it.

> diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
> index 59d85d6a84a89..deedea8a19fd7 100644
> --- a/drivers/usb/gadget/function/u_ether.c
> +++ b/drivers/usb/gadget/function/u_ether.c
> @@ -686,18 +686,16 @@ static int eth_stop(struct net_device *net)
>  static int get_ether_addr(const char *str, u8 *dev_addr)
>  {
>  	if (str) {
> -		unsigned	i;
> +		bool valid;
>  
> -		for (i = 0; i < 6; i++) {
> -			unsigned char num;
> +		/* Try the delimited formats first */
> +		valid = parse_mac_pton(str, dev_addr, ".:");
> +		if (valid && is_valid_ether_addr(dev_addr))
> +			return 0;
>  
> -			if ((*str == '.') || (*str == ':'))
> -				str++;
> -			num = hex_to_bin(*str++) << 4;
> -			num |= hex_to_bin(*str++);
> -			dev_addr [i] = num;
> -		}
> -		if (is_valid_ether_addr(dev_addr))
> +		/* Fall back to the raw format */
> +		valid = hex2bin(dev_addr, str, ETH_ALEN) == 0;
> +		if (valid && is_valid_ether_addr(dev_addr))
>  			return 0;

[Severity: Low]
Can malformed addresses with trailing characters still get through
here? parse_mac_pton() only checks for a minimum length and never looks
past the 17th character:

lib/net_utils.c:parse_mac_pton() {
    ...
	if (strnlen(s, MAC_ADDR_STR_LEN) < MAC_ADDR_STR_LEN)
		return false;
    ...
}

hex2bin() reads exactly 12 characters and returns 0 no matter what
comes after them. get_ether_addr() does not check that the string ends
after the parsed MAC, optionally with a trailing newline.

As a result, "aa:bb:cc:dd:ee:ff:11", "aa:bb:cc:dd:ee:ffzz",
"aabbccddeeff00" and "112233445566778899" are all accepted and silently
cut down to their first six bytes. On the module parameter path the
address is marked NET_ADDR_SET. On the configfs path, which passes the
whole page, the store reports success.

The old loop also ignored anything after the sixth byte. However, the
commit message says "parse_mac_pton() checks the length". The
parse_mac_pton() kernel-doc also says "@s must be MAC_ADDR_STR_LEN
characters long" and "false if @s is malformed", which promises more
than the code enforces.

Would it make sense to reject trailing characters in get_ether_addr()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261105072147.3383565-1-liuc63%40xiaopeng.com
