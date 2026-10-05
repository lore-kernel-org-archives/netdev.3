Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A82F4A3F1C;
	Mon,  5 Oct 2026 15:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212684; cv=none; b=CREBKnlleh1dBV/lny0Vnl4XxyxVxyLFcWzOi/MmbeKMwnbNaRw2Ilcwbx+jWp3mK9/91k3HdBCWKtGqQg0ih6gkFaz6aH+sfbWliFZY42sWoo8RqBP9zN1NrnE+O/vh8A4xt7W9+zKsDCC/jbY4O/IbpQC3C4HHftSthe+BS7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212684; c=relaxed/simple;
	bh=rJ2AbHjyJf+hYaHOyPJsGHzeoPTKPwWmzbTPn1N9bm8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J+OEMxjffuufeo439ssXC+HijllEDNQK2ZZVENp/r7jHlKC1KmdxkJC1dZStfKSe0RVkNtxc2+T+gVAfwiNiUdYWdZWAk8dRAnEkSmcf6L5ZRFMXys6Ob9EDncdhp1j/gOmYIAFNYllO7tkbAMi9FvC4qCofn8DCxVRNO6MY8Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qnh1IfUO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qnh1IfUO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE1D1F00893;
	Mon,  5 Oct 2026 15:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791212683;
	bh=5FRy4nP6x4AXovEyhDrHELuYi3xMJPxSHA11izmGAVY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Qnh1IfUOWMqkF1McU2WnaCuQTlbooyC42ISkhtpAj3ix9eRVBEf388y+wQ8juseJG
	 iaFc388tIrSCjWkFDITeeCWOboYVPIkzHezorf6MX2N3yG5vNIX13ZSbi9Cg2WLss8
	 cWWTmz8uMR85secp9BXj6rL9anooy87sFFR+FHymA4lv5tHr0O3/jarc/S1QpMTkmb
	 Dnic8Kmb6TNr56O6RrZ7KDLV/sn7D/o3H8tDS1h5cmTbw95Psoz3c8C/wKnvIy+ocM
	 okNRLdqVkPEPRusT90GiO6CA3D4u03kZmeXrqQlSfDO4eC1E/P39IOvx4tnkemOmW0
	 DrCMwioV2jh6A==
Subject: Re: [PATCH net-next 3/7] net: bcmgenet: rename ENET_MAX_MTU_SIZE to
 ENET_MAX_FRAME_LEN
From: netdev-bot+sashiko@kernel.org
To: nb@tipi-net.de
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.stevenson@raspberrypi.com, justin.chen@broadcom.com,
 pierremarinleclercq88@gmail.com
Date: Mon, 05 Oct 2026 15:04:42 +0000
Message-ID: <179121268236.434549.12657609913025768622@kernel.org>
In-Reply-To: <20261002-nb-genet-mtu-nn-v2-v1-3-96dc6d54cbee@tipi-net.de>
References: <20261002-nb-genet-mtu-nn-v2-v1-3-96dc6d54cbee@tipi-net.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In drivers/net/ethernet/broadcom/genet/bcmgenet.h, the patch adds
  the comment "Longest frame the MAC must accept for the default MTU"…

--

net: bcmgenet: rename ENET_MAX_MTU_SIZE to ENET_MAX_FRAME_LEN

This commit renames ENET_MAX_MTU_SIZE to ENET_MAX_FRAME_LEN, because the
value is a frame length that gets programmed into the hardware and not an
MTU. It also replaces the comment above the definition. The commit says
there is no functional change.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> index 86f2aed20dbe8..501dd12566936 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> @@ -28,12 +28,11 @@
>  /* which ring is descriptor based */
>  #define DESC_INDEX				16
>  
> -/* Body(1500) + EH_SIZE(14) + VLANTAG(4) + BRCMTAG(6) + FCS(4) = 1528.
> - * 1536 is multiple of 256 bytes
> - */
>  #define ENET_BRCM_TAG_LEN	6
>  #define ENET_PAD		8
> -#define ENET_MAX_MTU_SIZE	(ETH_DATA_LEN + ETH_HLEN + VLAN_HLEN + \
> +
> +/* Longest frame the MAC must accept for the default MTU */
> +#define ENET_MAX_FRAME_LEN	(ETH_DATA_LEN + ETH_HLEN + VLAN_HLEN + \
>  				 ENET_BRCM_TAG_LEN + ETH_FCS_LEN + ENET_PAD)

[Severity: Low]
This isn't a bug, but does the new comment match the value of the macro?

ENET_MAX_FRAME_LEN works out to:

  1500 + 14 + 4 + 6 + 4 + 8 = 1536

ENET_PAD (8 bytes) is not part of an Ethernet frame. The longest frame for
the default MTU is 1528 bytes, which the removed comment spelled out.

The removed comment also explained that the value was rounded up to 1536
because 1536 is a multiple of 256. Without it, nothing in the driver says
why ENET_PAD exists. The new comment presents the padded value as a frame
length.

The same wording is still there at the end of the series. In "net: bcmgenet:
allow the MTU to be changed", the macro becomes:

  /* Longest frame the MAC must accept for a given MTU */
  #define ENET_FRAME_OVERHEAD (ETH_HLEN + VLAN_HLEN + ENET_BRCM_TAG_LEN + \
                               ETH_FCS_LEN + ENET_PAD)
  #define ENET_MAX_FRAME_LEN(mtu) ((mtu) + ENET_FRAME_OVERHEAD)

With an arbitrary MTU there is no rounding to a 256-byte multiple, so
ENET_PAD is just 8 bytes of slack with no stated reason.

Could the comment either keep the 1528/1536 explanation, or say why ENET_PAD
is still counted as frame overhead?

>  #define DMA_MAX_BURST_LENGTH    0x10
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002-nb-genet-mtu-nn-v2-v1-0-96dc6d54cbee%40tipi-net.de
