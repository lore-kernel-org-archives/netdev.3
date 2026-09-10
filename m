Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA332F7EF3;
	Thu, 10 Sep 2026 00:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789001388; cv=none; b=pKJscqRTcVVJhDdZJAPt+c2he+kNVb7wrEhQ5NZnYvm8koLwiQvDhcKf7+pxFkLg2yBEC184AgC86YoDcdKeb3FeNI/nNOrn2KOoiYPvXiKRFJMBGHDYjKfNmBu25OGBuT2SUdJ7IsAXnEZMZX+pv1LCd9kJOvgKP8O7KeSuV6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789001388; c=relaxed/simple;
	bh=5mswXCQphVxe1jBRJjmsJFTnRy+RdkOy9NFf9Y8/jTg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RRRghekCdm+6P7+pVUYn6kdfX60LVxyJvR/GFCRkSjWZdyQvv5uFtkIelf1Hlyn2Ce7+2O6Osq7GRWOrZMW9iXkHDGhqJCExT4R0KZy1ZsJiGlCIM5d5jlpU5ZDHdetqaxX03eYFOJno590q3roST7/3wO7aOuGWam4/eQg5N6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMm5JeLI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMm5JeLI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6F91F000FF;
	Thu, 10 Sep 2026 00:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789001386;
	bh=mK8p/Ek0PtL4WMQc8bjkI/6rLce6gIGBdtERaUshizo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YMm5JeLIfxTdfoQrwO4l9DysebS/zmVW8QC2lJrhwFb69vFsKgD1tzvcdwDweSnsE
	 KVrClDUDUPhueuxxvEFg7q70ikFqpu446hKxS4oV69pkdrUbdrE6rzzuFa/ddUWiRb
	 X9s5HR7llUHVOshh0CW1PI79GWTddKyQfP4wqAm92w/8oggZ4nl6+B14OTz3iweKN6
	 C3VQhz7dvcaCAqltwsINcDeOZQfOGsIFSdfnG577F1Fa+U9jUg/e++CyvgEqoyrzkI
	 xyBz6VS5cWWgDCYBirSVydbPWtWhbzklBuGnt/OCS070Qyq9YjwVCVNBtpEyZQe+bA
	 amSdIuMXadIZw==
Subject: Re: [PATCH] net: usb: cx82310_eth: validate skb length in partial
 packet reassembly
From: netdev-bot+sashiko@kernel.org
To: elb12345@hotmail.co.uk
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 10 Sep 2026 00:49:45 +0000
Message-ID: <178900138543.219967.2109789659455615313@kernel.org>
In-Reply-To: =?utf-8?q?=3CAS8P251MB0001C1EC5208155FCAB25268C8B22=40AS8P251MB?=
 =?utf-8?q?0001=2EEURP251=2EPROD=2EOUTLOOK=2ECOM=3E?=
References: =?utf-8?q?=3CAS8P251MB0001C1EC5208155FCAB25268C8B22=40AS8P251MB0?=
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

Critical: 0 · High: 1 · Medium: 1 · Low: 0

- [High] The new bound check `if (skb->len < dev->partial_rem)` in
  cx82310_rx_fixup() is a check-then-use on completely unsynchronized…
- [Medium] The new guard in cx82310_rx_fixup() validates `skb->len >=
  dev->partial_rem`, but the reassembly block consumes…

--

net: usb: cx82310_eth: validate skb length in partial packet reassembly

This adds a length check in cx82310_rx_fixup() before the memcpy that
completes a partially received packet from the previous URB, so a short
follow-up transfer no longer causes a read past the end of the skb data.
When the transfer is too short, partial_rem is cleared and the frame is
dropped.

> diff --git a/drivers/net/usb/cx82310_eth.c b/drivers/net/usb/cx82310_eth.c
> index 5df657acf3d55..bdae1d8ad5f43 100644
> --- a/drivers/net/usb/cx82310_eth.c
> +++ b/drivers/net/usb/cx82310_eth.c
> @@ -251,6 +251,10 @@ static int cx82310_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
>  	 * end of that packet at the beginning.
>  	 */
>  	if (dev->partial_rem) {
> +		if (skb->len < dev->partial_rem) {
> +			dev->partial_rem = 0;
> +			return 0;
> +		}

[Severity: Medium]
Should this compare against the rounded-up length instead?  The block
right below consumes (dev->partial_rem + 1) & ~1 bytes from the skb, not
dev->partial_rem bytes:

drivers/net/usb/cx82310_eth.c:cx82310_rx_fixup() {
	...
	memcpy(skb2->data + dev->partial_len, skb->data,
	       dev->partial_rem);
	usbnet_skb_return(dev, skb2);
	skb_pull(skb, (dev->partial_rem + 1) & ~1);
	dev->partial_rem = 0;
	if (skb->len < 2)
		return 1;
	...
}

The extra byte comes from the odd-length padding the file comment
describes:

 * If a packet has odd length, there is one extra byte at the end (before next
 * packet or at the end of the URB).

partial_rem is fully device controlled, since the previous transfer sets
it in the incomplete-packet path:

			dev->partial_len = skb->len;
			dev->partial_rem = len - skb->len;

So with a header length of 1497 and 4 payload bytes the device gets
partial_rem = 1493, and a continuation transfer of exactly 1493 bytes
passes the new check.  The reassembled frame is returned, and then
skb_pull(skb, 1494) is a no-op because skb_pull_inline() bails out when
the pull exceeds skb->len:

include/linux/skbuff.h:skb_pull_inline() {
	return unlikely(len > skb->len) ? NULL : __skb_pull(skb, len);
}

The return value is not checked and partial_rem is cleared, so with
skb->len still 1493 the while (skb->len > 1) loop re-parses the payload
bytes that were just delivered as a fresh 2-byte length header.

Can that lose RX framing?  Depending on the payload bytes the loop then
either trims and delivers a duplicate/garbled frame to the stack, logs
"RX packet too long", schedules priv->reenable_work when the two bytes
happen to read 0xffff, or stores a bogus partial_len/partial_rem pair
that mis-frames the following transfer too.

Would testing skb->len < ((dev->partial_rem + 1) & ~1) here, or checking
the skb_pull() result, cover the odd-partial_rem case as well?

[Severity: High]
Is dev->partial_rem stable between this check and its uses below?  The
guard reads dev->partial_rem, and the code then re-reads
dev->partial_len and dev->partial_rem for the allocation size, for
skb_put() and for both memcpy lengths, with no lock, no READ_ONCE() and
no local snapshot.  These are plain struct usbnet fields aliased by the
macros in this file:

#define partial_len	data[0]		/* length of partial packet data */
#define partial_rem	data[1]		/* remaining (missing) data length */
#define partial_data	data[2]		/* partial packet data */

cx82310_rx_fixup() runs from rx_process() under usbnet_bh(), which has
two entry points that are not mutually exclusive.  usbnet_bh() is
registered directly as the delay timer callback in usbnet_probe():

	timer_setup(&dev->delay, usbnet_bh, 0);

and it is also the body of the BH work item:

drivers/net/usb/usbnet.c:usbnet_bh_work() {
	...
	usbnet_bh(&dev->delay);
	...
}

The timer is armed from the RX error-throttle path in rx_complete():

			mod_timer(&dev->delay, jiffies + THROTTLE_JIFFIES);

which is exactly what a malfunctioning device produces, while
rx_complete()/defer_bh() keep queueing bh_work on another CPU.
usbnet_bh() takes no lock around its loop; only skb_dequeue() self-locks
the done queue, and rx_fixup() is called after that lock is dropped:

drivers/net/usb/usbnet.c:usbnet_bh() {
	while ((skb = skb_dequeue (&dev->done))) {
		entry = (struct skb_data *) skb->cb;
		switch (entry->state) {
		case rx_done:
			if (rx_process(dev, skb))
	...
}

So can two invocations run cx82310_rx_fixup() in parallel on different
skbs?  If CPU A passes the new guard with partial_rem = 100 and
skb->len = 200, and CPU B then executes the incomplete-packet store:

			dev->partial_len = skb->len;
			dev->partial_rem = len - skb->len;
			memcpy((void *)dev->partial_data, skb->data,
			       dev->partial_len);

CPU A's later re-reads use the new values: the second memcpy copies the
larger partial_rem from a 200-byte skb (the over-read this patch aims to
close), and the first memcpy can copy a larger partial_len into an skb2
that was allocated from the earlier, smaller len, writing past the slab
object.  partial_data is also read while being rewritten.

Would snapshotting partial_len and partial_rem into locals and
validating and using only the locals (or serializing the reassembly
state) close this, rather than adding another unsynchronized read?  The
race window predates the patch, but the new check's soundness depends on
partial_rem not changing between the check and the copies.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/AS8P251MB0001C1EC5208155FCAB25268C8B22%40AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
