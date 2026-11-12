Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493842;
	b=aAaoAEXFiyYBV3miS2SY3hA6LMJAV9JfgxsNianVk84PhW4gDUK5cn6nx7+mqRhr+vSJ
	 YisZjE7AGQ5jZ3NLvCMa6wjy7qdAR95Xe+0e5QcV4INZQPV+SZ0AwQfH4UYFaL4gGQ0I4
	 Rae/rTA5pcUsTsX9MWjMl24KZ82uaYB6RoXukWC2Fnv51eGA+h6VrIpWz+mc9HmKo5Me6
	 Wd8l/7JBLRTy8g3bE4lgWvoku0C/RS+syFJsBs/IzilxUkZgE+g9U4R/fXMA0YKLsWvDy
	 iJWypmkGG5z+9N2n1bH4BKx5K96XHvyJaj+LSEYLT6CZTHtU4I1ZHD9Fcxc1rXS336Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493842;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=p6yFbRoI34EBEWBA8uir1WZa2ELxczuwwTv1IUA9M2I=;
	b=UUAEGb5Z2auzwXiEh/Nhbvnqx13nw88J+6XueCGQQZn1pfmYJr1GltQ+sTAQbdG4tSc6
	 SgeTvnbJjsXS/Tw9b4ojnZ19/HMTeNOoLnMgI105bCWSbkIQwdl2X0QR3wi7jnHF0zK5X
	 TDMymoYcl08BTnByyP5Jvgxv+ApuOmSNsMueyUNmMUpViMtFHnddxvFNc31KxteZDEuuI
	 NNYrEor3ZpCEu+DHXxf2lFUXHoVuEFuNkumgYcAos8UICaGxLrj98DHE+LnoV4vUzf+9O
	 y2+Yi5vIZWwYUl5b7HIUIqiVlkXTwRaG1sxd854DigUoahDUnquJw1X8eDgWWLlSyPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iACWokM5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6399606B0B3
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iACWokM5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4C21F00AC9
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 14:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794493842;
	bh=p6yFbRoI34EBEWBA8uir1WZa2ELxczuwwTv1IUA9M2I=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=iACWokM5dCMBq+sQAlvPoQXNgbafPVCzko61mUoyValRzk3cuG01rv1kUqa0vNPCG
	 8ZsnU4+sRpAzCiefDb/gph/yB/RRigIwZSbkZNE9l6JDSK/5yJKPBrTyMAHTvbDypR
	 4JMAk0SWnMC9qzrbGrrzWGkHLyqOiqBKdEc1GtzPJUbLTgVqJ8CXix8c0BF5tYguay
	 Z/ASh8N+OAcqAuEZNG2mBCSk1uWyc1niUeTxI8er8cTAtM9PE3IoGjayPq4WcM+w6b
	 cXWFQxEACl1dHKeuATJiyu8eX5KG4RPDUqlwu01hkWA6Fl6eme9Ujj5yjhMjCDOaE0
	 3K1Xyamsr86UA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3adfc004920so35600041fa.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 06:30:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErG8YyOwk5w+BSYZqG7EtZsSEcdxSBJJYFGc2qa9jEYuMvEL2v5AQzgNtSVFTEOMjbZM2RKvtyE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/sBiBRr1uZGdYnaZaPA1i4ipta3UDMujfCMVqjAp6tyqKhdDxL
	Xg3CN6XZ624t7tVJNUz43Kz4sMMs+8dhv+jPPkPGfVYgo1x03aNM7esncl2YmLoBSvx4frJHjIn
	vb7CG9JAalzwmFBqCbAdFri3YxhOn2M0=
X-Received: by 2002:a2e:bd83:0:b0:3ac:e14b:4233 with SMTP id
 38308e7fff4ca-3ae126d6bccmr14164511fa.26.1794493840822; Thu, 12 Nov 2026
 06:30:40 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-sun8i-emac-jumbo-v2-0-aca0cf23cf17@gmail.com> <20261112-sun8i-emac-jumbo-v2-2-aca0cf23cf17@gmail.com>
In-Reply-To: <20261112-sun8i-emac-jumbo-v2-2-aca0cf23cf17@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 12 Nov 2026 23:30:27 +0900
X-Gmail-Original-Message-ID: <CAGb2v664HN=K_rmHo6c8vUruiO=oSx_xyP6+R=W4=mayxGfNCw@mail.gmail.com>
X-Gm-Features: AclHuK9rczOZ2CpznM4g4dhi1PV55KlcijiBk3NrxFJJUCi_uq6z_UIAjJL6B74
Message-ID: <CAGb2v664HN=K_rmHo6c8vUruiO=oSx_xyP6+R=W4=mayxGfNCw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: stmmac: dwmac-sun8i: Enable jumbo
 frames up to MTU 2018
To: aiyengar1990@gmail.com
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
	linux-kernel@vger.kernel.org, Corentin Labbe <clabbe.montjoie@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 5:41=E2=80=AFPM Arun Iyengar via B4 Relay
<devnull+aiyengar1990.gmail.com@kernel.org> wrote:
>
> From: Arun Iyengar <aiyengar1990@gmail.com>
>
> The sun8i EMAC advertises a maximum MTU of 3712, but no frame larger
> than the standard 1518 bytes is actually received: on an H616 board
> (Orange Pi Zero2, RTL8211F over RGMII) every ping above 1472 bytes with
> DF set is lost, and the rx_length counter goes up for each one.
>
> There are two independent limits:
>
> 1. EMAC_RX_CTL0 bit 29 (JUMBO_FRM_EN) is never set, so the receiver
>    rejects frames longer than 1518 (1522 with a VLAN tag) bytes. The
>    Allwinner BSP driver (sunxi-gmac) sets this bit unconditionally at
>    init. Set it in core_init as well; core_init runs after every DMA
>    soft reset, including the one done by an MTU change.
>
> 2. The EMAC has no Synopsys HW feature register, so stmmac uses normal
>    descriptors in chain mode and, without enh_desc, sets max_mtu to

The hardware only supports normal descriptors, period.

>    SKB_MAX_HEAD(NET_SKB_PAD + NET_IP_ALIGN), which is 3712 with 4K
>    pages. That value is not a hardware limit. The descriptor buffer
>    size field is 11 bits wide (the same in the BSP and the QEMU model),
>    so ndesc_init_rx_desc() caps each RX buffer at 2047 bytes, and
>    ndesc_get_rx_status() discards any frame that needs a second
>    descriptor. On TX, stmmac_xmit() only splits jumbo frames for
>    enh_desc, and norm_set_tx_desc_len_on_chain() masks the length to
>    11 bits, so a linear frame longer than 2047 bytes would be silently
>    truncated.

If that's true, that sounds like a serious bug.

But that's just the limit of each descriptor. The stmmac driver already
has code for both chained and ring mode descriptors to split one fragment
across multiple descriptors for TX.

I think what should be done is just remove the "if (enh_desc)" check
before

    is_jumbo =3D priv->hw->mode->is_jumbo_frm(skb->len, enh_desc);

Now if the jumbo frame code is buggy (because no one ever ran into for
who knows how long), then that should be fixed.

> Moreover, the RX DMA only fills a multiple of 4 bytes of a buffer: on
> the H616, with 2047 programmed, a 2044 byte frame (FCS included) is
> received in one descriptor and a 2045 byte frame already spills into a
> second one. The usable size is therefore 2044 bytes, the same value as
> DESC_BUF_MAX in the original sun8i-emac submission and in the U-Boot
> driver.

And it also has code to deal with a frame spanning multiple descriptors
or buffers in the RX path. So if you say 2045 bytes is spilling over
to the next buffer, then the size limit for each descriptor's buffer
should be 2044.

I think this should be done somewhere in stmmac_setup_dma_desc() by
aligning bfsize or ultimately dma_conf->dma_buf_sz to a multiple of 4.

The limiting to 2047 bytes in ndesc_init_rx_desc() also seems suspect,
as the rest of the driver is not aware of this limiting, and would
likely cause misalignment or dropped bytes when reassembling a frame
from multiple descriptors.

> Limit max_mtu so that a frame with two VLAN tags and the FCS fits in
> 2044 bytes (MTU 2018). A device tree max-frame-size can still lower it.

So what you are doing is just papering over what is broken underneath.
Fix the actual problem so we can have MTU up to 9 KB.

> Longer frames from the wire span two descriptors and are dropped as a
> whole by stmmac_rx(), which drains the descriptors of a split frame
> since commit 834ec9530832 ("net: stmmac: drop split frames on AF_XDP
> zero-copy RX").

I doubt that's the case. This commit said it only covers AF_XDP, which
is not your normal network transfers.


ChenYu

> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 24 +++++++++++++++++=
++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/=
net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> index 0c82662fbe6e..a18d3daf6a3f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> @@ -6,6 +6,7 @@
>   */
>
>  #include <linux/clk.h>
> +#include <linux/if_vlan.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/mdio-mux.h>
> @@ -219,12 +220,25 @@ static const struct emac_variant emac_variant_h616_=
emac1 =3D {
>
>  /* Used in RX_CTL0 */
>  #define EMAC_RX_RECEIVER_EN             BIT(31)
> +#define EMAC_RX_JUMBO_FRM_EN           BIT(29)
>  #define EMAC_RX_DO_CRC BIT(27)
>  #define EMAC_RX_FLOW_CTL_EN             BIT(16)
>
>  /* Used in TX_CTL0 */
>  #define EMAC_TX_TRANSMITTER_EN  BIT(31)
>
> +/* The buffer size field of the EMAC DMA descriptors is 11 bits wide, an=
d
> + * the RX DMA only fills a multiple of 4 bytes of a buffer: with 2047
> + * programmed, frames longer than 2044 bytes spill into a second
> + * descriptor. The stmmac normal descriptor code used for this EMAC only
> + * handles frames that fit in a single RX descriptor and a single TX
> + * descriptor buffer. Bound the MTU so that a frame, including two VLAN
> + * tags and the FCS, always fits in 2044 bytes.
> + */
> +#define EMAC_MAX_FRAME_LEN     2044
> +#define EMAC_MAX_MTU           (EMAC_MAX_FRAME_LEN - ETH_HLEN - \
> +                                2 * VLAN_HLEN - ETH_FCS_LEN)
> +
>  /* Used in EMAC_TX_FLOW_CTL */
>  #define EMAC_TX_FLOW_CTL_EN             BIT(0)
>
> @@ -645,6 +659,15 @@ static void sun8i_dwmac_core_init(struct mac_device_=
info *hw,
>
>         v =3D (8 << EMAC_BURSTLEN_SHIFT); /* burst len */
>         writel(v, ioaddr + EMAC_BASIC_CTL1);
> +
> +       /* Without JUMBO_FRM_EN the receiver flags every frame longer tha=
n
> +        * 1518 bytes (1522 with a VLAN tag) as a length error, so any MT=
U
> +        * above 1500 is unusable. Frames are still bounded by the RX
> +        * descriptor buffer size, see EMAC_MAX_MTU.
> +        */
> +       v =3D readl(ioaddr + EMAC_RX_CTL0);
> +       v |=3D EMAC_RX_JUMBO_FRM_EN;
> +       writel(v, ioaddr + EMAC_RX_CTL0);
>  }
>
>  static void sun8i_dwmac_set_mac(void __iomem *ioaddr, bool enable)
> @@ -1209,6 +1232,7 @@ static int sun8i_dwmac_probe(struct platform_device=
 *pdev)
>         plat_dat->mac_setup =3D sun8i_dwmac_setup;
>         plat_dat->tx_fifo_size =3D 4096;
>         plat_dat->rx_fifo_size =3D 16384;
> +       plat_dat->maxmtu =3D min(plat_dat->maxmtu, EMAC_MAX_MTU);
>
>         ret =3D sun8i_dwmac_set_syscon(&pdev->dev, plat_dat);
>         if (ret)
>
> --
> 2.55.0
>
>
