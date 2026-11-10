Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315289;
	b=SxvWd9lCuUQW+m0Iko4a50IF1DXHhR1sOIqBIpb8AkXh/KcePQOcfTxObi4F0BvOIrNw
	 8Z6J5+hCmBUOjDFwIawric0tixl9awSl26z5DAuqYvYUU98TDGLIErbJFX66mk/S2Rj3r
	 uWFtu10sVIEAs6/gifpofwZhe0dQA4NP54j/yYC9jj94dsoi3SunN+4bziyaXbBWLzlez
	 lIKlmnECWzifAGBArM/7rQ+UWU4WdRg/wZa5p9snUAXlbxzS1R/TAC7zgZshJcb3lotFP
	 5qKIIvOdO6wduwzO4cD9O4NSdgpIgW/IR2iBU6mgBrCyhsqB+tvYyhJzFDzgepuZx2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315289;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=gyj3WBwr+g6cTChQ7569xuCmr22nb39zp7bmHW0h6ts=;
	b=4WKpndvdEp6zyiGDBMYAsngRHQ2copMkFGRtgbFg622FL2sbgfrthpqhdTR4yy8yeaEr
	 vcunIOJk8o/pmNXjsmXBF7nkrUHRVu6VoI8s+TNk+6VQYQnJXXnWxYuQe/+x+WpdLSLfX
	 hsiNqwBVhP7hWYCdm9FGWgLEDgLiIF5EhEIdOjUAHuBsrCzb1hvspLi5uulB1mIpGdSwY
	 AgGdw0bfvO5eEAGsVDkP4gAje86WR0nGL+mz2gLursWqXoveF/FwXfgNLK7KOJvHS5p2P
	 mBK90cFVE/s8ytnFu8ItLt/d7tn467qn8FI9JWURRAFL2eL0h3xV0jUFlgXWKwkO4cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NjDCR5YV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D4460A261A;
	Tue, 10 Nov 2026 12:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NjDCR5YV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4191F008A5;
	Tue, 10 Nov 2026 12:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315288;
	bh=gyj3WBwr+g6cTChQ7569xuCmr22nb39zp7bmHW0h6ts=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NjDCR5YVTZytBeoSmU3uGK+Gc1EI2cJkwhAMBb33GQ541oGITu+5qJzXirJQHi87L
	 E11Rbv7AFqXkL9FM31G5mzSj0XI8SVW8o/VRH88L5RW8UHfU0SZZ2sI73wwxBOzk95
	 34lP3rmMrnZ1DdJH2mkNissX2BO0KljM+7CNFSNcLGSevl6AVGBjydG+zJUmvZ6LbN
	 wj98pPHWlAlyHQ8JdOEVidQg2llYdPMojh2wG8YMKafN1pwhoGSMyJXsRY2ZZic9Zk
	 afe7QQik2GPkd6456DGoIdiYXZdMMes4JFShqvOAUvdvisIJlBRVsObCz7AnLNB+HC
	 731ceMFO/Sjbw==
Subject: Re: [PATCH v4 2/2] usb: gadget: u_ether: fix out-of-bounds read in
 get_ether_addr
From: netdev-bot+sashiko@kernel.org
To: liuc63@xiaopeng.com
Cc: gregkh@linuxfoundation.org, akpm@linux-foundation.org,
 andriy.shevchenko@intel.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, khtsai@google.com,
 fangxy@xiaopeng.com, rdunlap@infradead.org, dbrownell@users.sourceforge.net,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Date: Tue, 10 Nov 2026 12:54:47 +0000
Message-ID: <179431528770.994134.4467102794206412303@kernel.org>
In-Reply-To: <20261106030605.576584-3-liuc63@xiaopeng.com>
References: <20261106030605.576584-3-liuc63@xiaopeng.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message gets the effect of the dropped notations
  wrong for configfs.
- [Low] The new get_ether_addr() still silently accepts malformed
  addresses that have extra characters after the MAC, in both branches.
- [Low] The patch fixes a real slab-out-of-bounds read reported by KASAN
  (with the old loop, `insmod g_ether.ko dev_addr=ab` reads str[3] and…
- [Low] The kernel-doc for parse_mac_pton() does not match its
  implementation, and the new caller depends on the undocumented…

--

usb: gadget: u_ether: fix out-of-bounds read in get_ether_addr

This commit replaces the open-coded MAC parsing loop in get_ether_addr()
with parse_mac_pton() for the ':' and '.' delimited notation and hex2bin()
for the raw 12 digit notation. This fixes an out-of-bounds read on short
strings and the silent acceptance of non-hex characters. It also makes
USB_U_ETHER select GENERIC_NET_UTILS.

Link: https://lore.kernel.org/all/20261105072147.3383565-3-liuc63@xiaopeng.com/

> The configfs dev_addr and host_addr attributes of the ECM and NCM
> functions reach the same parser through gether_set_dev_addr() and
> gether_set_host_addr().

[ ... ]

> The notations that keep working are the byte pair ones, ':' and '.', in
> any mixture, and the separator-less "aabbccddeeff".  What stops working
> is the Cisco notation "aabb.ccdd.eeff" and irregular groupings such as
> "123456:789abc", which the old loop only accepted because it skipped a
> delimiter wherever it happened to find one.  Supporting them would need
> a parser per grouping, so such input now falls back to a random address.

[Severity: Medium]
Is the "falls back to a random address" part accurate for configfs?

It holds for the legacy module parameters, which reach get_ether_addr()
through gether_setup_name(). The configfs path goes through
gether_set_dev_addr() and gether_set_host_addr() instead, and both throw
away the random bytes:

drivers/usb/gadget/function/u_ether.c:gether_set_dev_addr() {
    ...
	if (get_ether_addr(dev_addr, new_addr))
		return -EINVAL;
    ...
}

The store handlers generated by USB_ETHERNET_CONFIGFS_ITEM_ATTR_DEV_ADDR and
USB_ETHERNET_CONFIGFS_ITEM_ATTR_HOST_ADDR in u_ether_configfs.h return that
error to the writer.

"echo aabb.ccdd.eeff > functions/ecm.usb0/dev_addr" used to succeed. The
old loop skipped the '.' and produced aa:bb:cc:dd:ee:ff. Now
parse_mac_pton() fails the length check and hex2bin() fails at the '.'.
The write therefore returns EINVAL and the attribute keeps its old value.
"aabb:cc:dd:ee:ff" behaves the same way.

The message also names only ECM and NCM. The same macros are used in
f_ecm.c, f_eem.c, f_ncm.c, f_rndis.c and f_subset.c. All five are
documented in Documentation/ABI/testing/configfs-usb-gadget-{ecm,eem,ncm,
rndis,subset} with no format restriction.

Could the commit message describe the configfs behaviour change and list
all five affected functions?

> 331a2d82bcaf predates the git conversion and only resolves in the
> historic tree history.git, so a Fixes: tag naming it would not resolve
> for most readers and is left out.

[Severity: Low]
Should this still carry a Fixes: tag?

The function this patch changes, get_ether_addr() in u_ether.c, was
introduced by commit 2b3d942c4878 ("usb ethernet gadget: split out network
core"), and that commit is in git. The usual convention for bugs older
than git is also available:

    Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Cc: stable was dropped in v2, and there is no Fixes: tag either. Stable
tooling has nothing to match on, so the out-of-bounds read from
"insmod g_ether.ko dev_addr=ab" stays in all maintained stable trees.

The fix also depends on parse_mac_pton() from the preceding commit
"lib/net_utils: allow mac_pton() to take a custom delimiter".

Would a Cc: stable with a dependency note, or a separate minimal fix for
stable, help backporters here?

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

[Severity: Low]
This isn't a bug today, but the kernel-doc for parse_mac_pton() added in
the preceding commit "lib/net_utils: allow mac_pton() to take a custom
delimiter" says:

 * @s must be MAC_ADDR_STR_LEN characters long and use a character from
 * @delim at every separator position, e.g. "aa.bb:cc.dd:ee.ff" with ".:".
 ...
 * Return: true on success, false if @s is malformed.

The implementation only rejects strings shorter than MAC_ADDR_STR_LEN and
ignores everything after the 17th character.

This caller depends on that prefix-only behaviour. The configfs store
handlers in u_ether_configfs.h pass the raw page down, and it normally ends
in '\n':

_f_##_opts_dev_addr_store()
    gether_set_dev_addr(opts->net, page)
        get_ether_addr()
            parse_mac_pton(str, dev_addr, ".:")

So "echo aa:bb:cc:dd:ee:ff > dev_addr" passes 18 characters to
parse_mac_pton().

Suppose the helper were later changed to enforce the exact length that its
documentation describes. Wouldn't every colon notation configfs write then
fail with -EINVAL? The hex2bin() fallback would not help, because it
rejects ':'.

Could the kernel-doc say that only the first MAC_ADDR_STR_LEN characters
are checked? Alternatively, could this caller strip the trailing newline
itself?

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
Can both branches still silently accept an address with extra characters
after the MAC?

parse_mac_pton() only enforces a minimum length:

lib/net_utils.c:parse_mac_pton() {
	if (strnlen(s, MAC_ADDR_STR_LEN) < MAC_ADDR_STR_LEN)
		return false;
    ...
}

It never looks at s[17] or beyond. "aa:bb:cc:dd:ee:ff:11",
"aa:bb:cc:dd:ee:ffff" and "aa:bb:cc:dd:ee:ffZZZ" all return true.

hex2bin(dev_addr, str, ETH_ALEN) consumes exactly 12 hex digits and returns
0 regardless of what follows. "aabbccddeeff0", "aabbccddeeff00112233" and
"aabbccddeeffzz" are all accepted as aa:bb:cc:dd:ee:ff.

In each of these cases get_ether_addr() returns 0, gether_setup_name()
marks the address NET_ADDR_SET, and the configfs store reports success.

The commit message says parse_mac_pton() "checks the length", but that
check is only a lower bound.

Would it make sense to require str[17] in the delimited case, or str[12] in
the raw case, to be '\0' or '\n'? A single trailing '\n' has to be allowed,
because the configfs store passes the raw page buffer from echo.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106030605.576584-1-liuc63%40xiaopeng.com
