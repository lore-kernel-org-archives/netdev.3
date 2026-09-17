Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEAE427FBE;
	Thu, 17 Sep 2026 22:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789685851; cv=none; b=N56uT1SzesFVi/oO8yfzHDTj/B5O/YZI20tz4KCb1Y5TL26+XVXYIzzcvuE3bXVU3ESWfgFXxk2299K1kO+bObS5GM5oTgk9mRuEWKzKojXPhu3kw4FdBAYwsZkMLLMhLKKRkQMAQ0xWx80OjgUDROFBQJ/N6827DFhg3IoOWxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789685851; c=relaxed/simple;
	bh=qa7OGhOQCh5fuAGRUdHQ2RVdrcOkKfxOQ9t/qyWSfSc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l1brksq3QcEIIPl0hOHKfGQqjrFGQIwGXoGWvwAv3pxpQTAo2AzArn3JR0JRccPDZ0KLepwMgTXeS/kxHpMVxcP3izrHowJVN//31TvO3cs0oPpsLIU+68jn07h4DM+CFttae6lG3J+qVvRdhH+DnfUcBcZEm4hylap1f62Lc98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3NQCx5r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3NQCx5r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64781F000FF;
	Thu, 17 Sep 2026 22:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789685849;
	bh=ilicRCmqFvasuixppZEMlgaTPhvq5xI+UZ6QBfSQpeY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=E3NQCx5rhymtgxTxg7kHk0VZHR1nDzTmQtXbUClnw69M/AfKlbCWYKsaoZ+uM+j+/
	 Rf15wNcjC4qqe8kAIQl95VtaM6i+fUQoEZn2bVaFLJIwBDa7MQ3aq9KtZdb29MIyW6
	 +xTqsUUaNSWH63J/sKlGSJEWwdgveA9f5bGyEuz+2Oqb/p73d0HmML/PXGwUd4/EH2
	 wHZX1fwo6zRNmQ1+qYIqjXq/VyFhlCIPKPsz0+Z2nj+NgOAJ6vU87mFlW8FLl0irdx
	 pFKG3qeg7MXpWzTt9xkp1g0U9QtIRuVnFjB4TLGIplVlnNx0FUH5rHhvS2QWEBpYfe
	 mXeP3XhuDUxcQ==
Subject:
 Re: [PATCH net v3] net: usb: asix: reject a truncated Data header in rx_fixup
From: netdev-bot+sashiko@kernel.org
To: elb12345@hotmail.co.uk
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dev@lynxeye.de,
 andriy.shevchenko@linux.intel.com, peter@korsgaard.com, kartikey406@gmail.com,
 enelsonmoore@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 17 Sep 2026 22:57:28 +0000
Message-ID: <178968584828.22033.13891381457185560010@kernel.org>
In-Reply-To: =?utf-8?q?=3CAS8P251MB0001D5442318B9E58797D230C8BA2=40AS8P251MB?=
 =?utf-8?q?0001=2EEURP251=2EPROD=2EOUTLOOK=2ECOM=3E?=
References: =?utf-8?q?=3CAS8P251MB0001D5442318B9E58797D230C8BA2=40AS8P251MB0?=
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 1

- [High] asix_rx_fixup_internal() (drivers/net/usb/asix_common.c) still
  reads a 4-byte Data header that does not fit inside skb->len at the…
- [Low] The netdev_err() added by this patch in asix_rx_fixup_internal()
  (drivers/net/usb/asix_common.c:183-184) formats skb->len with %d, but…

Pre-existing issues:
- [Medium] In asix_rx_fixup_internal() the device-declared frame length
  is only validated against an upper bound (`if (size > dev->net->mtu +…

--

net: usb: asix: reject a truncated Data header in rx_fixup

This adds a bound check in asix_rx_fixup_internal() before the four-byte
Data header read that starts a new frame, so a three-byte tail no longer
pushes offset past skb->len and wraps the copy_length clamp. On a short
header it logs, calls reset_asix_rx_fixup_info() and returns 0.

> diff --git a/drivers/net/usb/asix_common.c b/drivers/net/usb/asix_common.c
> index 4f03f4e57655d..8c5f863efe7d6 100644
> --- a/drivers/net/usb/asix_common.c
> +++ b/drivers/net/usb/asix_common.c
> @@ -179,6 +179,13 @@ int asix_rx_fixup_internal(struct usbnet *dev, struct sk_buff *skb,
>  				rx->split_head = false;
>  				offset += sizeof(u16);
>  			} else {
> +				if (offset + sizeof(u32) > skb->len) {

[Severity: High]

Should the resynchronisation read at the top of the same function get the
same bound?  It reads a four-byte Data header too, but its guard is
expressed on the un-rounded rx->remaining while the read uses the
even-rounded offset:

drivers/net/usb/asix_common.c:asix_rx_fixup_internal() {
	if (rx->remaining && (rx->remaining + sizeof(u32) <= skb->len)) {
		offset = ((rx->remaining + 1) & 0xfffe);
		rx->header = get_unaligned_le32(skb->data + offset);
		offset = 0;
	...
}

For odd rx->remaining the rounding adds one, so with rx->remaining == 61
and skb->len == 65 the guard passes (61 + 4 <= 65) but the read is done at
offset 62 and consumes bytes 62..65, while the last received byte is at
index 64.

rx->remaining is odd whenever the device declares an odd frame size
(size = rx->header & 0x7ff) that spans a URB boundary, and the extra
condition skb->len == rx->remaining + 4 makes skb->len odd, which is the
same odd-skb->len precondition the commit message calls out.

The stale byte then feeds the bits the synchronisation test looks at:

		size = (u16)(rx->header & 0x7ff);
		if (size != ((~rx->header >> 16) & 0x7ff)) {
			netdev_err(dev->net, "asix_rx_fixup() Data Header synchronisation was lost, remaining %d\n",
				   rx->remaining);
			reset_asix_rx_fixup_info(rx);
		}

so the verdict can be made on a byte the device never delivered, either
spuriously reporting lost synchronisation and dropping the in-flight
rx->ax_skb via reset_asix_rx_fixup_info()->kfree_skb(), or spuriously
accepting a desynchronised stream.

Would writing the guard on the rounded offset cover both sites
consistently, for example:

	if (rx->remaining &&
	    (((rx->remaining + 1) & 0xfffe) + sizeof(u32) <= skb->len)) {

> +					netdev_err(dev->net, "asix_rx_fixup() Short Data header, offset %d, len %d\n",
> +						   offset, skb->len);

[Severity: Low]

This isn't a bug, but skb->len is declared unsigned int in
include/linux/skbuff.h:

	unsigned int		len,
				data_len;

so %u would be the matching conversion here.  offset is int, so its %d is
fine.  The neighbouring "Bad SKB Length %d, %d" message has the same
mismatch, so this new line inherits it.

> +					reset_asix_rx_fixup_info(rx);
> +					return 0;
> +				}
> +
>  				rx->header = get_unaligned_le32(skb->data +
>  								offset);
>  				offset += sizeof(u32);

[Severity: Medium]

This isn't a bug introduced by this patch, but while looking at the
device-supplied length validation a few lines below the new check, only the
upper bound is tested:

drivers/net/usb/asix_common.c:asix_rx_fixup_internal() {
	...
			if (size > dev->net->mtu + ETH_HLEN + VLAN_HLEN) {
				netdev_dbg(dev->net, "asix_rx_fixup() Bad RX Length %d\n",
					   size);
				reset_asix_rx_fixup_info(rx);
				return 0;
			}
	...
			rx->ax_skb = netdev_alloc_skb_ip_align(dev->net, size);

			rx->remaining = size;
	...
}

Is there anything rejecting size below ETH_HLEN?  A header of 0x07ff0000
passes the complement test with size == 0, so netdev_alloc_skb_ip_align()
is called with 0, rx->remaining is 0, copy_length is 0 and the empty skb
goes straight out:

		if (rx->ax_skb) {
			skb_put_data(rx->ax_skb, skb->data + offset,
				     copy_length);
			if (!rx->remaining) {
				usbnet_skb_return(dev, rx->ax_skb);
				rx->ax_skb = NULL;
			}
		}

usbnet_skb_return() calls eth_type_trans() because skb->protocol is 0, and
eth_type_trans() dereferences a full struct ethhdr regardless of skb->len,
since skb_pull_inline() only returns NULL without stopping the caller:

include/linux/etherdevice.h:eth_skb_pull_mac() {
	struct ethhdr *eth = (struct ethhdr *)skb->data;

	skb_pull_inline(skb, ETH_HLEN);
	return eth;
}

Can skb->protocol and skb->pkt_type then come from uninitialised bytes of
the freshly allocated skb, with a 0 to 13 byte runt handed to netif_rx()?
Any size in 1..ETH_HLEN-1 looks the same, just with a partially
uninitialised header.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/AS8P251MB0001D5442318B9E58797D230C8BA2%40AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
