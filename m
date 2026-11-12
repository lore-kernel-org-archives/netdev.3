Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794471737;
	b=iCGiCoDUdO3KF1Ne8lvyMpEEviAfa129UY2MXb2EhLL8lzTr7BrrZGuqdukBc21UCevp
	 UgqQq7T8gWfkeaPncQycdmSLVUtHWV31iwTU4lqutig9kOx6qv3BoxCrr+HSybKTvoLCb
	 XAZDfPxPgNKt1MYOrAljSVSMbZIesouI10B+KNNzeV/aYN4up4/hOOfOrtPNW+zYwQUgW
	 UEtlgjmQKRQTcpo36oQvcLmuP3AgA5wzAQsKXm5seuqg/SaijI6tnusQZUhIKMJ2PT5J7
	 Uj66FbKIA39ONFmFpCnnD+j+orOvTLqyJSu8TBMUFx+OWbccZtUu/VkoJNH6M7cmWsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794471737;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=y3VGdkCUnkt2V5Pv8M04oyZ8QIftmWWOUYUBeD+hMlE=;
	b=BpvyYGn7R+45aU7SF/jmayxOnkQGGGLM8ziu+Im7qDQ7RRRA7kd5sktGv8ChWigli2f7
	 IVaXXQug0qAu2LE4M9mUCQ58hanO6zMa14vQH0sexncU1EK50k4rFk/ch6qIR0porDm4e
	 Tt9WvyuH3Vz2T3UWQJURiwVxyj/uYj6iqJvUt++28BoDDUkX2sQUNWrIqOBvZK2StoaWo
	 TdeRsdCogGthd0Ve9bU/V9Z/A4jqvJGOfJi2pEKmn+7NGseipgN2Ssox51zPdyXdX+BgY
	 wIrLbn7uKtdYuis8rzB1l4H/q011gWPIVjE2YDWUO47AiUrARR4uK4a81vTDP0aTOxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b="F3eBT2/p";
	arc=none smtp.remote-ip=185.70.43.101
Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch [185.70.43.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4D8606A321
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 08:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B4D8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=F3eBT2/p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1794471734; x=1794730934;
	bh=y3VGdkCUnkt2V5Pv8M04oyZ8QIftmWWOUYUBeD+hMlE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=F3eBT2/puTi8pHKtTA2uyLhocY0H2qITMaARVSvZjLH1wWT9WzGU1cK68P8lEwxGK
	 azU5VU0zW56OQZpXQrenu0EgYFvsfKUMR9bRVdbawIhLeSPoci6hjCtt8wNPweNcd1
	 D3CiuqGSCruGEnevxVMMoRivT8Ht7dgPVv9czjcO/dR3EBNK7oy1hHbHg1AzqBmHtu
	 ZWimbyn6vsaQnpYKq9Y3VlbEXY7Kue59b5wffvmbki6k/Tqp5FGxYttnvLIfVoD39y
	 e29rpn3dr5v2tlzGeM9KXNTubnu/biFGh27ENr8Y4gMPRx8/tf6IJzjHeIgolkTY8s
	 ryYjcizh23igw==
Date: Thu, 12 Nov 2026 08:22:09 +0000
To: Oliver Neukum <oliver@neukum.org>
From: Ryan Prinz <rc4d5a@protonmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ryan Prinz <rc4d5a@protonmail.com>
Subject: [PATCH net v3] net: usb: cdc_ncm: fix out-of-bounds read of chained NDP32 offset
Message-ID: <20261112082022.995351-1-rc4d5a@protonmail.com>
In-Reply-To: <20261107140432.647365-1-rc4d5a@protonmail.com>
References: <20261107140432.647365-1-rc4d5a@protonmail.com>
Feedback-ID: 190731814:user:proton
X-Pm-Message-ID: a5706a62db05980e620ddf4924f1684f0585a100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The NDP offset read from dwNextNdpIndex on the 32-bit NTB (NDP32)
path is not checked for a negative value before use. A
device-supplied dwNextNdpIndex in the 0xFFFFFFF0-0xFFFFFFFF range
sign-converts to a small negative int. cdc_ncm_rx_verify_ndp32()'s
existing bounds check then double-wraps: promoting the negative int
to size_t first produces a huge value, and adding
sizeof(struct usb_cdc_ncm_ndp32) to that wraps it back down to a
small value that passes the "> skb_in->len" check, causing an
out-of-bounds read of up to 16 bytes before the skb's data buffer.

Fixes: 0fa81b304a79 ("cdc_ncm: Implement the 32-bit version of NCM Transfer=
 Block")
Signed-off-by: Ryan Prinz <rc4d5a@protonmail.com>
---
v3:
 - Moved the fix from the cdc_ncm_rx_fixup() call site into
   cdc_ncm_rx_verify_ndp32() itself, at the actual point of the
   size_t wraparound, so it covers every caller instead of just the
   one chained-NDP jump. The old call-site check is dropped rather
   than kept alongside it, since it would just be dead code once the
   helper rejects the same value first.
 - Fixed the adjacent netif_dbg() to print ndpoffset with %d instead of
   %u, since it's a signed int and can now legitimately be negative.
 - Added a sentence on where the out-of-bounds bytes actually come from
   on real hardware.
 - Resent as plain text; v1/v2 picked up a PGP/MIME envelope from the
   mail client that leaked into the changelog.

Reproduced by calling cdc_ncm_rx_fixup() directly from a small
out-of-tree test module with a hand-crafted NTB. With memory-sanitizer
instrumentation enabled to pinpoint the vulnerability:

    BUG: KASAN: slab-out-of-bounds in cdc_ncm_rx_verify_ndp32+0x11e/0x130 [=
cdc_ncm]
    Read of size 2 at addr ffff88800fcd2a34 by task insmod/367
     cdc_ncm_rx_verify_ndp32+0x11e/0x130 [cdc_ncm]
     cdc_ncm_rx_fixup+0x7a3/0xed0 [cdc_ncm]

Scope/impact:
- Triggering the 32-bit NTB (NDP32) path requires the host driver to
  set CDC_NCM_FLAG_PREFER_NTB32 for the device. The only driver that
  does so unconditionally is huawei_cdc_ncm.c, for Huawei mobile
  broadband hardware. Local/physical-USB-attachment or
  compromised-device-firmware attack surface, not remote.
- Reachable offset range is -1 to -16, bounded by
  sizeof(struct usb_cdc_ncm_ndp32); the subsequent dpe32 array read
  always lands back inside the legitimate buffer, so this doesn't
  escalate into a larger OOB excursion.
- The rx skb is allocated by usbnet's rx_submit() via
  __netdev_alloc_skb()/__netdev_alloc_skb_ip_align(), both of which
  reserve NET_SKB_PAD (>=3D 32 bytes) of headroom ahead of skb->data.
  Since the reachable negative range is only -1 to -16, the read
  stays inside that same headroom/allocation and picks up stale
  bytes rather than crossing into unmapped memory.
- No out-of-bounds write found, and the leaked bytes only feed a
  signature-match comparison. There is no path found for them to
  reach a delivered packet or the device/attacker.

Given the local-only trigger and lack of a confirmed write primitive
or crash, my read is this doesn't need security@kernel.org handling,
but happy to redirect there if you think otherwise.

AI Disclosure: An AI assistant (Claude) was used to assist with the
analysis and testing. I have verified the vulnerability, the fix,
and the test results myself and take responsibility for this
contribution, per Documentation/process/coding-assistants.rst.

 drivers/net/usb/cdc_ncm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -1698,8 +1698,9 @@ int cdc_ncm_rx_verify_ndp32(struct sk_buff *skb_in, i=
nt ndpoffset)
 =09int ret =3D -EINVAL;
 =09size_t ndp_len;

-=09if ((ndpoffset + sizeof(struct usb_cdc_ncm_ndp32)) > skb_in->len) {
-=09=09netif_dbg(dev, rx_err, dev->net, "invalid NDP offset  <%u>\n",
+=09if (ndpoffset < 0 ||
+=09    (ndpoffset + sizeof(struct usb_cdc_ncm_ndp32)) > skb_in->len) {
+=09=09netif_dbg(dev, rx_err, dev->net, "invalid NDP offset  <%d>\n",
 =09=09=09  ndpoffset);
 =09=09goto error;
 =09}
--=20
2.51.0

