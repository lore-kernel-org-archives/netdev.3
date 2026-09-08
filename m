Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F06D34388E;
	Tue,  8 Sep 2026 03:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788839389; cv=none; b=HJCEe0j54p6zkiTuSTpQmHY0+p1EUvpRq9IIndTTP1XkX3dO3IS9YhV+B85Cv78SRyjzKJ+HHeR5/2GW2ccemrOzAphxpfO+/2spgF+lwUSAnbKdM70nA9IZU38Q3/0vYIBEdGxLBQmbJphIqHJgyyYtbRS1nWmNLz9mZtP/cOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788839389; c=relaxed/simple;
	bh=SaxA8NTcMnN4aUqtXFKx924TsyJxhccSlqDp57WiD4s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JKQzkJKKFuh0DfJRGKjRDd95SbJ5u2quGdMYQfilvzIKUXw4KdEu8A0aJwc+tEIQVIDnk6SFOv0b0t/Mipx+GzNlYQa99q13A/fVO3C4rF64ps95I/o4jZNrvEWwMbNaQDXFc7OrBRkTGDc01sPShPvsJsH5fwgHDj510EDwUyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AC8nYZZI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AC8nYZZI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848341F00A3D;
	Tue,  8 Sep 2026 03:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788839385;
	bh=2MOgnMmbsysM5Nvvt4fQRefJMihXzhZ5xrwgYiluytU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AC8nYZZI49Bm4Ym83WdlzNAWJd74Ppk0QqxTTHp2+QOGbeULhfX9QmjAAblm/1Vzb
	 SHuDD5OA++EllGrggXkNamyu8udl9+mYXAji60zNvkaPqnijB+kf8n44rD6HVAL7z1
	 aOt8ZF7owPhhYz+r7d3pyfcoy8MxxZIBCeNvV3lTvjX1MlLhKJpCFlHStTXN5hKkO9
	 s336Xc5EE1Q7+qmFaD/EUxmy/+vcriqHHGL+O/JtOUc6yXOoRk1xm3kZtHjL8SdMqt
	 ZOnSOjdkw1f2vbajukmhgPwVLOF1qed0Dxv4rOoJroxgb32Xfxt62LrXv1BRWm4G/Z
	 OjrTQAcP21XPA==
Subject:
 Re: [PATCH net-next v9 2/4] net: dsa: tag_ks8995: Add the KS8995 tag handling
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Date: Tue, 08 Sep 2026 03:49:44 +0000
Message-ID: <178883938406.219967.6481809293994424099@kernel.org>
In-Reply-To: <20260906-ks8995-to-ksz8-v9-2-8d8815a91bd8@kernel.org>
References: <20260906-ks8995-to-ksz8-v9-2-8d8815a91bd8@kernel.org>
X-sashiko-severity: Low
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

Critical: 0 · High: 0 · Medium: 0 · Low: 2

- [Low] Claimed incomplete submission: the new tag protocol
  DSA_TAG_PROTO_KS8995 / CONFIG_NET_DSA_TAG_KS8995 /…
- [Low] In ks8995_xmit() (net/dsa/tag_ks8995.c:52-54) the debug print
  passes the big-endian struct members hdr->h_vlan_proto and…

--

net: dsa: tag_ks8995: Add the KS8995 tag handling

This adds a new DSA tagger for the Micrel KS8995 / Microchip KSZ8995XA
switch, which carries its special tag in a modified 802.1Q header whose
last nybble holds the destination port mask.  The tagger inserts the
outer switch tag on xmit and moves the tag into the hwaccel VLAN area on
receive.

Two small observations below.

> diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
> index 23b4b74004ed5..4f44bf3ede238 100644
> --- a/net/dsa/Kconfig
> +++ b/net/dsa/Kconfig
> @@ -125,6 +125,12 @@ config NET_DSA_TAG_MXL_GSW1XX
>  	  Say Y or M if you want to enable support for tagging frames for
>  	  MaxLinear GSW1xx switches.
>  
> +config NET_DSA_TAG_KS8995
> +	tristate "Tag driver for Micrel KS8995 switch"
> +	help
> +	  Say Y if you want to enable support for tagging frames for the
> +	  Micrel KS8995 switch.
> +

[Severity: Low]
At this commit nothing in the tree selects NET_DSA_TAG_KS8995 and no
driver returns DSA_TAG_PROTO_KS8995, so the module can be built but never
bound.  The existing drivers/net/dsa/ks8995.c still returns
DSA_TAG_PROTO_NONE from ks8995_get_tag_protocol().

Looking further in the series this resolves itself: the following patch
adds ksz8995xa_get_tag_protocol() in drivers/net/dsa/microchip/ksz8.c
returning DSA_TAG_PROTO_KS8995 and makes
drivers/net/dsa/microchip/Kconfig select NET_DSA_TAG_KS8995, and the last
patch deletes the legacy drivers/net/dsa/ks8995.c.  Each patch still
compiles on its own.

Would it be worth mentioning in the commit message that the switch driver
side arrives in the next patch, so the tagger is intentionally without a
consumer for one commit?

>  config NET_DSA_TAG_KSZ
>  	tristate "Tag driver for Microchip 8795/937x/9477/9893 families of switches"
>  	help

[ ... ]

> diff --git a/net/dsa/tag_ks8995.c b/net/dsa/tag_ks8995.c
> new file mode 100644
> index 0000000000000..db90b3165a853
> --- /dev/null
> +++ b/net/dsa/tag_ks8995.c
> @@ -0,0 +1,134 @@

[ ... ]

> +	/* Always add a distinct outer tag. The user port removes this field on
> +	 * egress, so reusing an existing 802.1Q tag would consume that VLAN tag.
> +	 */
> +	skb = vlan_insert_tag(skb, KS8995M_STPID(portmask), 0);
> +	/* vlan_insert_tag() drops the skb on failure */
> +	if (!skb)
> +		return NULL;
> +	hdr = skb_vlan_eth_hdr(skb);
> +	netdev_dbg(dev, "%s: inserted VLAN TAG %04x TCI %04x\n",
> +		   __func__, hdr->h_vlan_proto, hdr->h_vlan_TCI);

[Severity: Low]
This isn't a bug in the packet path, but should these two values go
through ntohs() first?

Both members are big-endian in struct vlan_ethhdr (include/linux/if_vlan.h):

	__be16		h_vlan_proto;
	__be16		h_vlan_TCI;

On a little-endian host the tag just inserted (0x8101..0x810f) prints as
0x0181..0x0f81, which is not the value that goes on the wire, and sparse
with C=1 will complain about a restricted __be16 degrading to integer.

ks8995_rcv() in the same file converts before logging:

	etype = ntohs(*(__be16 *)dsa_etype_header_pos_rx(skb));
	...
	netdev_dbg(dev, "%s: received ethertype %04x\n", __func__, etype);

so printing ntohs(hdr->h_vlan_proto) / ntohs(hdr->h_vlan_TCI) here would
also make the two prints consistent.

> +
> +	return skb;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906-ks8995-to-ksz8-v9-0-8d8815a91bd8%40kernel.org
