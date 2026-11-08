Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794108760;
	b=0EZLBfBbUoVGmbO476xE+wgwGTuWnG/68CotmgpvIT1wzCGcXSt2IuP+jtzAqnIs5UfD
	 ezxhmexgLKyImhxs1MzjbCcEOovu7V86urFIUDns2bMwOTtcV9I1oDMt728TSo3BooIE4
	 drRL9ABeWdIIIpBH/m1O2NNE0UxHa4zaZ8xqwt4dcHvvA++myfqRlkrcutQfTZZjMavsp
	 oOh7AJiLfR/rZXPFQIvAUq0vwRJpkq72kfb5DR0Nxi/j8T/qgbBUKkgFQV6SacZiUIHNx
	 YCevAqJNtvTmSCojhXKBwog4Cv0sJHw4nL0yzcQvux+T+emsEFGFdeTn+5RJXctQjdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794108760;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=dWjDHi/ava+PNlwN23UkjzjBYrqch6Raos60ENp0ko8=;
	b=Al85OPxE+joa+yx6EYT0dnugELUyS6XsQDSUJRcYcMxnV+/sNUhpeuURdG/y+JnF4Uqc
	 x8JsnD9GAUDdcP2J9MQIaA3ZMIAdKy/dMvMcdJdGgf4iXpjy25aMneO3ehlDGx8+qiq/K
	 U32E0/ueQTv8b2j2qrDEtFfQbLFXD/+0TcSNqD79otl2yqumCy+MCGKb9W71JFxAILOkb
	 TOy2mbJcho/WU0+rrl1Nfavnasmt5C05iJ7UQjXGxrYNwTppz7O0NmlTqTjMIyRNIP52A
	 WDiGs8fruHz6DJW3F6G+KmOYs6DbUxDhHE1NKlwAKFrAiayf2cCbRgslTnPnPAWH4Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XzGJbjnA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A7A606A32A;
	Sun,  8 Nov 2026 03:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XzGJbjnA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCFF1F008A1;
	Sun,  8 Nov 2026 03:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794108759;
	bh=dWjDHi/ava+PNlwN23UkjzjBYrqch6Raos60ENp0ko8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XzGJbjnAEj+EcHHcM1vcP1DvtyVbVG58WOii84Ktl4e0j7lgnLbFoGf4JuPEDrHth
	 bPXiB9hsG428eYsOg/ucUDV0kuAQrhLMUKEqPGJo5Fqu4bMF6I8tacTvkZAvD2NUnq
	 qncaDZoP5s76UhdZOUahCprJpOaSn1fOsbM1id/pf70QNvFrwv2J3f9iuQuZtxh2KX
	 QxmKqax3boOuftjnGA/ukaF/GT5abT4I6+ubb/G8XJQIZlv1KSHENip9fuUxVtIdp7
	 3edjl1ewGIujS6f3F9VDCUtbKBZtYbPwvL3jeuQJlemoXoMtl/VE3i2/3FnJYkRrfT
	 cPhZL6OyhM0VQ==
Subject: Re: [PATCH v2 2/2] usb: gadget: u_ether: fix out-of-bounds read in
 get_ether_addr
From: netdev-bot+sashiko@kernel.org
To: liuc63@xiaopeng.com
Cc: gregkh@linuxfoundation.org, akpm@linux-foundation.org,
 andriy.shevchenko@intel.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, khtsai@google.com,
 fangxy@xiaopeng.com, rdunlap@infradead.org, dbrownell@users.sourceforge.net,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Date: Sun, 08 Nov 2026 03:32:38 +0000
Message-ID: <179410875819.994134.18111408259009320213@kernel.org>
In-Reply-To: <20261104025058.2650911-3-liuc63@xiaopeng.com>
References: <20261104025058.2650911-3-liuc63@xiaopeng.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new parse_mac_pton() call in get_ether_addr()
  (drivers/usb/gadget/function/u_ether.c:691) still accepts malformed…
- [Medium] The commit message misdescribes the user-visible effect of the
  stricter syntax.

--

usb: gadget: u_ether: fix out-of-bounds read in get_ether_addr

This patch replaces the open coded MAC parsing loop in get_ether_addr()
with parse_mac_pton(). The old loop read past the end of short strings
and ignored invalid hex digits. It also selects GENERIC_NET_UTILS so that
parse_mac_pton() is built in.

> The configfs dev_addr and host_addr attributes of the ECM and NCM
> functions reach the same parser through gether_set_dev_addr() and
> gether_set_host_addr().

[ ... ]

> Note that this makes the accepted syntax stricter: the old loop also took
> a separator-less string such as "aabbccddeeff" and the Cisco notation
> "aabb.ccdd.eeff", both of which parse_mac_pton() rejects, so such input
> now falls back to a random address instead of being parsed.

[Severity: Medium]
Is this description accurate for the configfs path?

Only the legacy module parameter path, through gether_setup_name(), uses
the random fallback. On the configfs path, gether_set_dev_addr() discards
the random bytes and returns an error:

drivers/usb/gadget/function/u_ether.c:gether_set_dev_addr() {
	...
	if (get_ether_addr(dev_addr, new_addr))
		return -EINVAL;
	...
}

gether_set_host_addr() does the same. The store handlers generated by
USB_ETHERNET_CONFIGFS_ITEM_ATTR_DEV_ADDR() and
USB_ETHERNET_CONFIGFS_ITEM_ATTR_HOST_ADDR() pass -EINVAL back to
userspace.

So "echo aabbccddeeff > functions/ecm.usb0/dev_addr" used to succeed. With
this patch it fails with EINVAL, the previous address stays in place, and
no random address is assigned.

The message also names only ECM and NCM. The same store macros are used by
f_ecm.c, f_eem.c, f_ncm.c, f_rndis.c and f_subset.c.

Could the commit message describe the new EINVAL behaviour on configfs
writes, and list all the affected functions?

> diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
> index 59d85d6a84a89..26471cb086b37 100644
> --- a/drivers/usb/gadget/function/u_ether.c
> +++ b/drivers/usb/gadget/function/u_ether.c
> @@ -686,18 +686,10 @@ static int eth_stop(struct net_device *net)
>  static int get_ether_addr(const char *str, u8 *dev_addr)
>  {
>  	if (str) {
> -		unsigned	i;
> +		bool valid;
>  
> -		for (i = 0; i < 6; i++) {
> -			unsigned char num;
> -
> -			if ((*str == '.') || (*str == ':'))
> -				str++;
> -			num = hex_to_bin(*str++) << 4;
> -			num |= hex_to_bin(*str++);
> -			dev_addr [i] = num;
> -		}
> -		if (is_valid_ether_addr(dev_addr))
> +		valid = parse_mac_pton(str, dev_addr, ".:");
> +		if (valid && is_valid_ether_addr(dev_addr))
>  			return 0;

[Severity: High]
Can malformed addresses with trailing characters still be accepted here?

parse_mac_pton() only enforces a minimum length, and then validates
indices 0 through 16:

lib/net_utils.c:parse_mac_pton() {
	if (strnlen(s, MAC_ADDR_STR_LEN) < MAC_ADDR_STR_LEN)
		return false;
	...
}

Nothing from str[MAC_ADDR_STR_LEN] onward is examined. Inputs such as
"aa:bb:cc:dd:ee:ffzz", "aa:bb:cc:dd:ee:ff:11:22" or the typo
"02:11:22:33:44:556" all return true. The truncated 6-byte prefix is then
used as the address.

This covers the module parameter path through gether_setup_name(). It also
covers the configfs dev_addr and host_addr stores of ECM, EEM, NCM, RNDIS
and subset, where gether_set_dev_addr() returns 0 and sets
NET_ADDR_SET. That seems to contradict the u_ether.h kernel-doc for
gether_set_dev_addr() and gether_set_host_addr():

 * Returns negative errno if the new address is incorrect.

The commit message says parse_mac_pton() "checks the length and every
digit", but that only holds for the first 17 characters.

netconsole's remote_mac_store() handles this with an explicit terminator
check after mac_pton():

	if (!mac_pton(buf, remote_mac))
		goto out_unlock;
	if (buf[MAC_ADDR_STR_LEN] && buf[MAC_ADDR_STR_LEN] != '\n')
		goto out_unlock;

Should get_ether_addr() do the same? A single trailing '\n' would still
need to be allowed, since configfs writes from echo end with one.

>  	}
>  	eth_random_addr(dev_addr);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104025058.2650911-1-liuc63%40xiaopeng.com
