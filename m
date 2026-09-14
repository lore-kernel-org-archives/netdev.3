Received: from mail-4320.protonmail.ch (mail-4320.protonmail.ch [185.70.43.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CC8392831
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 19:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789413940; cv=none; b=VWEDKy/a+ww4ZxM1PRwOsZ+7SV4oBgDmyLIVAcjUR0P+Z8303XO5zi04Kmu/0KCpuqnQtNFZQyNdNLsfhpavtpCH+Kbs14jOe2P2EA7hjwIxAj8BeNzucWfAZ8x28giWOOdlBdBOmGkUe3+2pBuFJLH+6yxPSXkCUkp0AHgGILM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789413940; c=relaxed/simple;
	bh=kyb66ULhPPzxrXw36pCWHN8uYJJgC1eCjUnfcPOjX4I=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=GREqKUWio1cx3FFR85Pr4ntf5dkI/1oNcNNQrxU+4dFrvygLt9BaNoqLGPFKRTww3gJuUZA/uHf89ZMYASPLlttla/I9jA/7mlXiv69xbcEnjpbX5i8CpobMBi2TWrnOuaa/OAK6cuDxfr6tZpPOiLYCY4W0d5KPWW2V04LV4X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jurrevanbergen.nl; spf=pass smtp.mailfrom=jurrevanbergen.nl; dkim=pass (2048-bit key) header.d=jurrevanbergen.nl header.i=@jurrevanbergen.nl header.b=bspk9kHB; arc=none smtp.client-ip=185.70.43.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jurrevanbergen.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jurrevanbergen.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jurrevanbergen.nl header.i=@jurrevanbergen.nl header.b="bspk9kHB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jurrevanbergen.nl;
	s=protonmail3; t=1789413927; x=1789673127;
	bh=kyb66ULhPPzxrXw36pCWHN8uYJJgC1eCjUnfcPOjX4I=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=bspk9kHBeOff+dgyYRxdkPto7W2doLJlgDOSzPhCYLDX775XOVtWBPOG/NZVTANB3
	 2Qi0mF0mLTzCJB32oAdAsF1EMYiOviEoiV8d75sUBzdU+VOhy6pdTDxENtBf0KDq3+
	 UUsYIRg/qNlFRtqgRk9SBR+2t0AQIaNDlLpryTD0HRv+QMFWfIiI5BglNsEV/j4cmf
	 cRcUlNPl6W19UK2ZUvVTM7+MegZASvIsuTk9QsBaybqscONBHoAJOYd4r7SiCAOM4+
	 k9YZ1Cr5k2S+xCFFGUha4wE02XqZQ04xsm7T0cmoBeSXXHdjoxm96RA8l77KTtMy92
	 NVQdHTXT9wb3w==
Date: Mon, 14 Sep 2026 19:25:21 +0000
To: linux-usb@vger.kernel.org
From: Jurre van Bergen <me@jurrevanbergen.nl>
Cc: netdev@vger.kernel.org
Subject: [BUG] pegasus: RX length confusion and Pegasus-II heap corruption
Message-ID: <69ebe458-da95-4a8a-868f-40b17753e2b5@jurrevanbergen.nl>
Feedback-ID: 145391479:user:proton
X-Pm-Message-ID: 8d6b9eeafc1eb108dca6f3862308930f28c8f303
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

I would like to report two issues in drivers/net/usb/pegasus.c,
read_bulk_callback(). A malicious USB device that emulates as a supported
Pegasus adapter can trigger the two issues.

First issue, the driver trusts the packet length stored in data supplied=20
by the USB
device. It checks the length against PEGASUS_MTU, but does not check=20
that the
claimed packet is present in urb->actual_length. A short USB transfer can
therefore make skb_put() expose unwritten skb tailroom to the network stack=
.
The device can receive some of this kernel data through ICMP error=20
responses.

Second issue, on Pegasus-II (chip 0x8513), the driver advances=20
rx_skb->data by two
bytes before it rejects an oversized packet. The rejected skb is then reuse=
d
as the destination of the next 1536-byte RX URB. Repeated rejected packets
move the destination forward through the allocation. This allows=20
cross-object
reads and a repeatable, device-controlled linear overwrite of=20
skb_shared_info
and later heap memory. RX-error packets can keep the destination at the=20
chosen
offset while writing new data.

The important code pattern is:

```c
if (pegasus->chip =3D=3D 0x8513) {
 =C2=A0 =C2=A0 /* Length comes from the USB device. */
 =C2=A0 =C2=A0 pkt_len =3D le32_to_cpu(*(__le32 *)urb->transfer_buffer) & 0=
x0fff;
 =C2=A0 =C2=A0 pegasus->rx_skb->data +=3D 2;
}

if (pkt_len > PEGASUS_MTU)
 =C2=A0 =C2=A0 goto goon;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/* skb is reused with shifted data */

skb_put(pegasus->rx_skb, pkt_len); /* no actual_length check */

goon:
usb_fill_bulk_urb(pegasus->rx_urb, pegasus->usb, pipe,
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pegasus->rx_skb->data, PEGASUS_MTU,
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0read_bulk_callback, pegasus);
```

The issues were reproduced with raw_gadget and dummy_hcd using the built-in
ADM8513 ID (07a6:8513) as emulation target.

The Pegasus-II overwrite is confirmed exploitable:=20
https://x.com/DrWhax/status/2098408939507351760

Possible fix directions:

- Convert the device length into an Ethernet frame length. Reject it if=20
it is
 =C2=A0 smaller than ETH_HLEN, larger than PEGASUS_MTU, or larger than the =
bytes
 =C2=A0 present after the device-specific prefix and trailer. Check minimum=
 wire
 =C2=A0 lengths before subtraction to avoid integer underflow.
- Remove the direct rx_skb->data adjustment. After validation succeeds, use
 =C2=A0 skb_put(), skb_pull(), and skb_trim(), or an equivalent sequence th=
at=20
keeps
 =C2=A0 data, tail, and len consistent.
- Make every rejected-packet path leave the skb unchanged, so the next=20
RX URB
 =C2=A0 always uses the original buffer address. If this cannot be guarante=
ed,
 =C2=A0 discard the skb and allocate a fresh one.
- Before each URB submission, verify that PEGASUS_MTU bytes fit between the
 =C2=A0 exact transfer-buffer address and skb_end_pointer().
- Read the Pegasus-II length with get_unaligned_le32().

Groetjes,

Jurre van Bergen


