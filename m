Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777D33F7AA6;
	Thu, 16 Jul 2026 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784194451; cv=none; b=uiMbYr7MmzotV5DZC9P3EUqM8zWkGxTs24pryiV/ekdkW5q2G2bOBlBZDAp4enI83SmmrKx1L52LFWc8DfWQJEO+2PBJfuMc3Fo6RehxHTuJFxGOEfGhjfUfFadP0jouPsj3cQxzb0UJ6E3XI6MDTeUsEVI6ldEsON+HfB+ncbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784194451; c=relaxed/simple;
	bh=dLibkOZyYpSzyucuT1ZWMnA4RP4kDL/epSeE2QtHVCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzVVbQYb91dlvPcHbV+wwW6vRFWgxdedqCbMwSqb0ZM3rEJlixOwVpMn0QIYsNXViTxe5HCL6dzBb/vDtYsOVPrHL47Fu9wqnNXTQrp2utA14g6gIBf3apmwIo7sGsJB2yRSRH+/J2KszP5iVqBh/SeLWrwa1iQ7jwLh+GJfdXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYKLNcbP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYKLNcbP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DD11F000E9;
	Thu, 16 Jul 2026 09:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784194446;
	bh=3tYIqGgD5+HGDzoYPGbWL+lcyio+ysnq9CbeRAizqNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EYKLNcbP0I/2BvJuDvg5LZ5z1R5J5rxVE5socwcKODtXB3dnxuRLLDZExKpW7JXvH
	 P9sLi8mZxxes/n4DiAd+nX8z/NBpLeqzdgyeUZswmRKXCpey4uBQ1q8AuOuIKtC9oP
	 AEC4KBZ/Y2JuRX7Cg5RdCKhhEn9FwyNP6jqs3/ztivJ5IG74WpHBAHHWhB9ci8CqyX
	 d2CARI3QaiXXlNnc0AAVeJUxw/6rDe0r0Fe0ls6C8V+k4+turwqaI/OQcEIbGV5SW0
	 ktU85B9vmDnTlTa09Rx8RGRkQWez8IDRdpfn+Jw4+4tXmHGS77H2dIN12ROvyQO9G4
	 eZObdKJK1p65w==
From: Simon Horman <horms@kernel.org>
To: jackbb_wu@compal.com
Cc: Simon Horman <horms@kernel.org>,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	wen-zhi.huang@mediatek.com,
	shi-wei.yeh@mediatek.com,
	Minano.tseng@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 2/7] net: wwan: t9xx: Add control plane transaction layer
Date: Thu, 16 Jul 2026 10:33:55 +0100
Message-ID: <20260716093355.231047-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709-t9xx_driver_v1-v4-2-a8c009d509c5@compal.com>
References: <20260709-t9xx_driver_v1-v4-2-a8c009d509c5@compal.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
--- Patch [2]: [PATCH v4 2/7] net: wwan: t9xx: Add control plane transaction layer ---
commit a06b668b7ebf78322cb2957d8a6a11fdfb9235ad
Author: Jack Wu <jackbb_wu@compal.com>

net: wwan: t9xx: Add control plane transaction layer
    
The control plane implements TX services that reside in the
transaction layer. The services receive the packets from the
port layer and call the corresponding DMA components to
transmit data to the device. Meanwhile, TX services receive
and manage the port control commands from the port layer.
    
The control plane implements RX services that reside in the
transaction layer. The services receive the downlink packets
from the modem and transfer the packets to the corresponding
port layer interfaces.

> diff --git a/drivers/net/wwan/t9xx/mtk_ctrl_plane.c b/drivers/net/wwan/t9xx/mtk_ctrl_plane.c
> new file mode 100644
> index 0000000000000..cf6079218e1ce
> --- /dev/null
> +++ b/drivers/net/wwan/t9xx/mtk_ctrl_plane.c
> @@ -0,0 +1,45 @@
[ ... ]
> +int mtk_ctrl_init(struct mtk_md_dev *mdev)
> +{
> +	struct mtk_ctrl_blk *ctrl_blk;
> +
> +	ctrl_blk = devm_kzalloc(mdev->dev, sizeof(*ctrl_blk), GFP_KERNEL);
> +	if (!ctrl_blk)
> +		return -ENOMEM;
> +
> +	ctrl_blk->mdev = mdev;
> +	mdev->ctrl_blk = ctrl_blk;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(mtk_ctrl_init);

[Severity: Medium]
Does this patch actually implement the TX and RX services described in the
commit message?

The commit message claims to implement control plane TX and RX services, but
this code merely introduces empty initialization stubs (mtk_ctrl_init() and
mtk_ctrl_exit()) that are currently dead code.

> diff --git a/drivers/net/wwan/t9xx/pcie/mtk_pci.c b/drivers/net/wwan/t9xx/pcie/mtk_pci.c
> index 72259bf1b6033..68dddd652effc 100644
> --- a/drivers/net/wwan/t9xx/pcie/mtk_pci.c
> +++ b/drivers/net/wwan/t9xx/pcie/mtk_pci.c
> @@ -467,6 +468,7 @@ static u32 mtk_pci_ext_h2d_evt_hw_bits(u32 chs)
>  
>  	SET_HW_BITS(hw_bits, chs, MHCCIF_RC2EP_EVT_DEVICE_RESET,
>  		    DEV_EVT_H2D_DEVICE_RESET);
> +
>  	return LE32_TO_U32(cpu_to_le32(hw_bits));
>  }

[Severity: High]
Does this code apply a double byte-swap on big-endian architectures?

Using cpu_to_le32() converts the bitmask, which is then cast to u32 and
passed to mtk_pci_write32() (wrapping iowrite32()). Because iowrite32()
intrinsically expects a host-endian value and applies its own conversion for
little-endian PCI memory, the value is byte-swapped twice, resulting in the
original big-endian layout being incorrectly written.

Additionally, this can cause ffs(hw_bits) in mtk_pci_send_ext_evt() to
calculate the wrong bit index on the already byte-swapped value.
