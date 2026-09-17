Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8422030594E;
	Thu, 17 Sep 2026 00:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604695; cv=none; b=MhZBZlu+AraoI1EX7SLcIv4iVLGlUjx2kDAx/FTZfllDwXFk/aFv5CSzo4ayu0WEv5ZIwj6blo8J1tW7V+d8gs6uR0F24qSHI6mKQaJG3iKP855a3sw60MjA3bjgBajPrgAtQJ/0hXI+0liK0PW2m1rJnkRYdNX8wGTYXtoitkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604695; c=relaxed/simple;
	bh=5qz+sS7mC18t17f2GbV+JzJ6dja2oPZFU5/+qXA9LLU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D9ofcjXTPM8p2gSzxYMyQ0h/wNoQgSejCEh9MwqeuG5hZr7BB59g6ZXGTtkvQtIvwWev9rCC2mCSAveHKe9PEOYM0fp3TIEo+CLLZ79GSxnds8ZuIXHeWzlvRUosmb6nOraxv5xZN7uIHLFfmycnARu1wosb7PVouZ2Jb1OJRPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnUgvymp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnUgvymp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648E21F000FF;
	Thu, 17 Sep 2026 00:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789604694;
	bh=BK543tMrE/YgjQmqF2LPnVo5G74ZNutS7/2Y0dU3VkQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DnUgvympQHCXXIEOs8nmCKM0+ooaq6EGOq7sOhBRrw97WQ2QDMj6X05Ng8+7RA5t3
	 fC7bnJmukkaHhu4H7lp3vQYdRHUlb4YJ+/WL6fz4STVbo0EdaNWDXvb7WYdttgu7XI
	 W09+ZyB2uCnbxIyi6lbaxqhwHNv7WLsD3QwlzUAN89UL4UbCwrZEJptGHzU64bIbf6
	 WrNGZhgsK31RWhaZZ0lneBD1ywU/1G909vQHCfos9NF5bo2N8EqqxHD2nxxfqrSnbY
	 tDzj9sOaDBrCGCZLN7RF3f89pOgmI1YiEQxLYpMpanxj9b197Ovd5xnNbUC6hEzO2a
	 fndvE+SkobnSg==
Subject: Re: [PATCH net-next v2] net: usb: asix: reject a truncated Data
 header in rx_fixup
From: netdev-bot+sashiko@kernel.org
To: elb12345@hotmail.co.uk
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dev@lynxeye.de,
 andriy.shevchenko@linux.intel.com, kartikey406@gmail.com,
 enelsonmoore@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 17 Sep 2026 00:24:52 +0000
Message-ID: <178960469295.22033.14261478886981268855@kernel.org>
In-Reply-To: =?utf-8?q?=3CAS8P251MB000193C798F98A11C73C3E9DC8BB2=40AS8P251MB?=
 =?utf-8?q?0001=2EEURP251=2EPROD=2EOUTLOOK=2ECOM=3E?=
References: =?utf-8?q?=3CAS8P251MB000193C798F98A11C73C3E9DC8BB2=40AS8P251MB0?=
 =?utf-8?q?001=2EEURP251=2EPROD=2EOUTLOOK=2ECOM=3E?=
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0 (1)

- [High] The fix is incomplete: the sibling four-byte Data-header read in
  the same function is still allowed to read one byte past skb->len,…

Pre-existing issues:
- [Low] Missing lower bound on the device-supplied frame length in
  asix_rx_fixup_internal() (drivers/net/usb/asix_common.c:190-214).

--

net: usb: asix: reject a truncated Data header in rx_fixup

This adds a bounds check in asix_rx_fixup_internal() before the four-byte
Data header read in the "start a new frame" branch, so a three-byte tail
no longer pushes offset past skb->len and wraps the copy_length clamp.
On a short header the parser state is reset and the URB skb is dropped.

> diff --git a/drivers/net/usb/asix_common.c b/drivers/net/usb/asix_common.c
> index 4f03f4e57655d..8c5f863efe7d6 100644
> --- a/drivers/net/usb/asix_common.c
> +++ b/drivers/net/usb/asix_common.c
> @@ -179,6 +179,13 @@ int asix_rx_fixup_internal(struct usbnet *dev, struct sk_buff *skb,
>  				rx->split_head = false;
>  				offset += sizeof(u16);
>  			} else {
> +				if (offset + sizeof(u32) > skb->len) {
> +					netdev_err(dev->net, "asix_rx_fixup() Short Data header, offset %d, len %d\n",
> +						   offset, skb->len);
> +					reset_asix_rx_fixup_info(rx);
> +					return 0;
> +				}
> +

[Severity: High]
This guard only covers the header read inside the loop.  Does the other
four-byte header read in the same function, the resynchronisation read
before the loop, still go one byte past skb->len under the same
device-supplied odd skb->len?

drivers/net/usb/asix_common.c:asix_rx_fixup_internal() {
	if (rx->remaining && (rx->remaining + sizeof(u32) <= skb->len)) {
		offset = ((rx->remaining + 1) & 0xfffe);
		rx->header = get_unaligned_le32(skb->data + offset);
		offset = 0;
	...
}

The predicate uses the unrounded rx->remaining, but the read happens at
the even-rounded offset.  For odd rx->remaining that offset is
rx->remaining + 1, so the read consumes bytes
[rx->remaining + 1 .. rx->remaining + 4].

With rx->remaining == 5 and a following URB of skb->len == 9 the test
passes (5 + 4 <= 9), offset becomes 6, and bytes 6..9 are read while the
last valid index is 8.

Is odd rx->remaining reachable?  rx->remaining is set to
size - copy_length with copy_length = skb->len - offset, and offset only
ever advances by sizeof(u16), sizeof(u32) or (copy_length + 1) & 0xfffe,
so an odd-sized frame spanning a URB boundary leaves an odd remainder.

The byte that gets read past the data then feeds the size versus
complement verdict that decides whether the in-flight rx->ax_skb is kept
or thrown away, so a good partial frame can be discarded or a real
desynchronisation accepted.

Would matching the two sites be enough here, e.g.

	if (rx->remaining &&
	    (((rx->remaining + 1) & 0xfffe) + sizeof(u32) <= skb->len)) {

so that the pre-loop predicate describes the offset the read actually
uses?

>  				rx->header = get_unaligned_le32(skb->data +
>  								offset);
>  				offset += sizeof(u32);

[Severity: Low]
This is a pre-existing issue and not something this patch introduces, but
while looking at the header validation just below this read: is there a
lower bound on the device-supplied frame length?

drivers/net/usb/asix_common.c:asix_rx_fixup_internal() {
	size = (u16)(rx->header & 0x7ff);
	if (size != ((~rx->header >> 16) & 0x7ff)) {
	...
	if (size > dev->net->mtu + ETH_HLEN + VLAN_HLEN) {
	...
	rx->ax_skb = netdev_alloc_skb_ip_align(dev->net, size);
	rx->remaining = size;
}

A header of 0x07FF0000 gives size == 0 and (~header >> 16) & 0x7ff == 0,
so the complement test passes and only the upper bound is checked.  Any
size in 1..13 passes too.

The resulting runt ax_skb goes straight to usbnet_skb_return(), and since
asix sets FLAG_MULTI_PACKET the skb->len < ETH_HLEN filter in rx_process()
is not applied, so eth_type_trans() -> eth_skb_pull_mac() dereferences
(struct ethhdr *)skb->data and takes h_dest and h_proto from bytes that
were never written.

For the record, this does not hang the parser: offset already advances by
sizeof(u32) (or sizeof(u16) in the split-head path) in the same iteration
that reads the header, so a size == 0 stream still terminates the loop.

Would a size < ETH_HLEN rejection alongside the existing upper-bound check
be appropriate?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/AS8P251MB000193C798F98A11C73C3E9DC8BB2%40AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
