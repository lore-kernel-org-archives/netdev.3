Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794447825;
	b=CKDMBnIqaK5W5w+0BCHspjH4Qxa+aGhT7/xE7PcuFpB8CAq178U+0dpNP69iOe4Um3+B
	 gmKUNtt7yzMxCvXhaCcCxYnb6lgQRsrFywGnx1MesAhlvLsVur9ATnJOWFpoj044iNzOq
	 n5F2DF0idyY64LZC12cHRTRZu/2j2lJICEYsmJYilDRotWYlyWBAkMD7zfx5ZFUgBtlUr
	 8uxwqA4OhrZMbMTj4Fw5fhiZmHX1mRgmQ2rdzLivhM6P9HGNZKNYy2SXcPPNUsAAkwM61
	 GXT4/3mKybipAVI+3d3OtkKX7TGkrf86x3BiMrFbvKbh7dvWqPD3O6tqZI3MtSqoBDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794447825;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nMExbhHbUShuDL/HK3bakDlz8yxEpdyfIAchERz0TLI=;
	b=xYnAo1WPdXW/0W09++qGVmUn6lkcEhRNv2ikWikXK12EzhskN0Xlqo19hfFiAOK9/NLj
	 DAvypItLAwBfQFfcUUz3HCSx4xSwWsaQfumNe/S159izZvAYVO1dq9hSK/aOfsGhE+1o8
	 2530zrOHNeQrjZtFNV2N/tJbzB6x9pBoOwCTEEPg4Nz6zNW0GGg+Tx3iD7alEcGH3mVMz
	 qFLzrpgQ0KVs2PStZJPAMsgI6iuGyX4Wf+JwMs86TZWLEzf/Do4mSVvRQISJKdMhj5JvV
	 qmOflGAzoN7nKNd/LFsjulsIVuZWBDAZmLlFqyqz4q/UfMyeOpoM6afyrNd+nvqr62A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBxwTeE2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89267606A31C;
	Thu, 12 Nov 2026 01:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBxwTeE2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D461F00A06;
	Thu, 12 Nov 2026 01:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794447825;
	bh=nMExbhHbUShuDL/HK3bakDlz8yxEpdyfIAchERz0TLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UBxwTeE2oxe4Oite1VV+xMkPnDljFEZn9vsX62wHqgkT+b1z4VR2r0Pyiv73seoMW
	 uzMRxVROWwxOA58D66q3F/++t+cMvrNnpvZXaJregzDEbMp60S+HKQjr6qcsvPWXpn
	 0r64lBkWXU14Z/gMkBW7Jc7CV9+vFBG+EQoRG8SoknEbjQ9e86VcZ2slwjnypT8hxG
	 9F5z0rrn1OMq1z5Xz6P3r2eLlP8jh119IZMUDLLPuyUz/bt8icfWCNWexvtCy+cvp1
	 SAjz7mORiGcn9Qgg2Paj3X+8us50SJsnNc8bs1vZeBJ9y1eXfg2BloyUpmEdP1qI2/
	 KIZfaJpQiOuGw==
From: Jakub Kicinski <kuba@kernel.org>
To: rc4d5a@protonmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	oliver@neukum.org,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: cdc_ncm: fix out-of-bounds read of chained NDP32 offset
Date: Wed, 11 Nov 2026 17:43:36 -0800
Message-ID: <20261112014335.3355552-2-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107140432.647365-1-rc4d5a@protonmail.com>
References: <20261107140432.647365-1-rc4d5a@protonmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: usb: cdc_ncm: fix out-of-bounds read of chained NDP32 offset

This patch adds a negative check on the dwNextNdpIndex value that
cdc_ncm_rx_fixup() reads from a chained NDP32, before it jumps back to
next_ndp. A value from the device in the 0xFFFFFFF0-0xFFFFFFFF range
becomes a small negative int. That value would otherwise get past the
size_t bounds check in cdc_ncm_rx_verify_ndp32().

> net: usb: cdc_ncm: fix out-of-bounds read of chained NDP32 offset
>
> This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
> --------0069204657d9df8cf4194503c90bb3fa2463289ee31cd304c80a0972fb84c9ce
> Content-Type: multipart/mixed;
>  boundary=2a1cb552390cbfe7fd100b88c3ace6355fd4256b41310b91c8759db253cb
> From: Ryan Prinz <rc4d5a@protonmail.com>

[ ... ]

> Subject: [PATCH] net: usb: cdc_ncm: fix out-of-bounds read of chained NDP32 offset

[ ... ]

> MIME-Version: 1.0
>
> --2a1cb552390cbfe7fd100b88c3ace6355fd4256b41310b91c8759db253cb
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit

[Severity: Low]
This isn't a bug, but the mail client's PGP/MIME envelope ended up in
the changelog. The boundary strings, a second copy of the mail headers
and the Content-Type lines all sit before the real description. The log
would have to be edited by hand before the patch could be applied.

The notes below the --- line also look damaged in transit. Some words
are split across lines ("Triggerin" / "g the 32-bit ...", "analysis
and" / " testing").

Could this be resent as plain text without PGP/MIME? It also carries a
Fixes: tag, so netdev would expect the subject prefix "[PATCH net]"
instead of "[PATCH]".

> The NDP offset read from dwNextNdpIndex on the 32-bit NTB (NDP32)
> path is not checked for a negative value before use. A
> device-supplied dwNextNdpIndex in the 0xFFFFFFF0-0xFFFFFFFF range
> sign-converts to a small negative int, bypassing the bounds check in
> cdc_ncm_rx_verify_ndp32() via size_t wraparound, causing an
> out-of-bounds read of up to 16 bytes before the skb's data buffer.

[Severity: Low]
This isn't a bug, but could the changelog say where those 16 bytes come
from on real hardware?

usbnet allocates every rx skb in rx_submit():

drivers/net/usb/usbnet.c:rx_submit() {
    ...
	if (test_bit(EVENT_NO_IP_ALIGN, &dev->flags))
		skb = __netdev_alloc_skb(dev->net, size, flags);
	else
		skb = __netdev_alloc_skb_ip_align(dev->net, size, flags);
    ...
}

Both allocators reserve NET_SKB_PAD of headroom, which is at least 32
bytes. When ndpoffset is between -16 and -1, the read at
skb_in->data + ndpoffset stays inside the same allocation. It picks up
stale headroom bytes, and those bytes only feed the wLength,
dwSignature and dwNextNdpIndex checks.

"Before the skb's data buffer" is accurate relative to skb->data. The
notes also say the KASAN slab-out-of-bounds report came from a
hand-crafted test module. Adding one sentence that the bytes come from
the skb headroom might still make the impact clearer to people reading
the log.

> diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
> index 19db5a668dcbc..f5c8a60704233 100644
> --- a/drivers/net/usb/cdc_ncm.c
> +++ b/drivers/net/usb/cdc_ncm.c
> @@ -1838,6 +1838,9 @@ int cdc_ncm_rx_fixup(struct usbnet *dev, struct sk_buff *skb_in)
>  	else
>  		ndpoffset = le32_to_cpu(ndp.ndp32->dwNextNdpIndex);
>  
> +	if (ndpoffset < 0)
> +		goto error;
> +

[Severity: Low]
This isn't a bug, but would it be more robust to reject a negative
offset inside cdc_ncm_rx_verify_ndp32() itself?

The helper is exported and takes a signed int. Its bounds checks can
still wrap through size_t in the same way when ndpoffset is between -16
and -1:

drivers/net/usb/cdc_ncm.c:cdc_ncm_rx_verify_ndp32() {
    ...
	if ((ndpoffset + sizeof(struct usb_cdc_ncm_ndp32)) > skb_in->len) {
		netif_dbg(dev, rx_err, dev->net, "invalid NDP offset  <%u>\n",
			  ndpoffset);
		goto error;
	}
	ndp32 = (struct usb_cdc_ncm_ndp32 *)(skb_in->data + ndpoffset);
    ...
	if (ndpoffset + ndp_len > skb_in->len) {
    ...
}

In the current tree, cdc_ncm_rx_fixup() is the only caller. Both paths
into next_ndp now reject a negative ndpoffset: the existing check after
cdc_ncm_rx_verify_nth32() and the new one here. So the in-tree path is
closed, and the new check follows the pattern already used for the
cdc_ncm_rx_verify_nth32() return value.

A check inside the helper would also protect any future caller. The
netif_dbg() in the helper prints the signed ndpoffset with %u, and that
could be fixed in the same change.

>  	if (ndpoffset && loopcount--)
>  		goto next_ndp;
>
-- 
pw-bot: cr
