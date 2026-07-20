Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428F73C5DDE;
	Mon, 20 Jul 2026 17:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784568274; cv=none; b=oO4oK1nZoV7Ctz36uoH+or553hcwlKQzU2oZeTH+UYZ2+Dv0vSzMtRw0ov0CO1yPe79OZ0U1a6kdfGu8O+1+f1K8Z1vujFxO+x7StTv7wgi8FMcQWkuJvvK/yBHhQ2xdKtCIzYJAXydx7Tmh4IGHTNiaLzll/oG7RxJZaBlngW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784568274; c=relaxed/simple;
	bh=MexdZ+C5UP2SC0n1BKF8AUTaU8qLgkXkuttrTeMtPok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNaLwzFXJGFZvVsE8ASfhKBKdTooR8GVnklXGs5USmSWJwYiEJqdRcVw7UGeoz18BtfxDFeqxBBGABkas4WZqVEpOZiusqRtw/tCTCSD7wHG8y7MEaPqZeHu5WHfhVQXmZsajcWPuxSmWNZPJIOhTgE5imvpjh4eDXqSeYKN4YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GICTNdQJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GICTNdQJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727E21F00A3D;
	Mon, 20 Jul 2026 17:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784568264;
	bh=kGgVs5ACgMVF0SmRTGK+8BPS6M9ObQxdkIQiWa/ipFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GICTNdQJS+nCyjynzFfI9XqoZktcGeKJrchYTBJlIYugOjvGpwPmXFs+m1hFlswmz
	 ysH6vuMLs57Rci2x4/dhmCumjvXGScIcMvsl6NGGlTZJA/vv3DDCkGMYbmuIHJFk1E
	 m0E9pi1UAyp+OOffM+hUgaypBKegRoewlTCqHhL8AwUrf5tIwJRzsenYy2jzjabryT
	 kQVvbjo1Tl5Jtj613kHaY4Zw2yrmyPbpPzm0eeXB+9w+hEQNWK6gMOeU1clK9ZuobM
	 gwqnTiTMM1Vl5/5sH7gI8Pvd1mHr5TVQd6gnTU62PRhU70bK+oR/+u7YX3P4js/bWK
	 f6QOdoiwcj42w==
From: Simon Horman <horms@kernel.org>
To: rkannoth@marvell.com
Cc: Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sgoutham@marvell.com,
	hkelam@marvell.com
Subject: Re: [PATCH net-next] octeontx2-af: npc: Warn on NPC_IPSEC_SPI key overlap
Date: Mon, 20 Jul 2026 18:18:58 +0100
Message-ID: <20260720171857.278396-2-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713144247.545592-1-rkannoth@marvell.com>
References: <20260713144247.545592-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
https://sashiko.dev/#/patchset/20260713144247.545592-1-rkannoth@marvell.com?part=1
---
--- Patch [1]: [PATCH net-next] octeontx2-af: npc: Warn on NPC_IPSEC_SPI key overlap ---
commit f018da26dc974202fbe56b064f0bc0375c74613a
Author: Hariprasad Kelam <hkelam@marvell.com>

octeontx2-af: npc: Warn on NPC_IPSEC_SPI key overlap

When scanning the MKEX profile to determine supported NPC features, warn
if the SPI extraction field overlaps with other key fields. AH and ESP
may legitimately use the same key offset for SPI, so continue to
advertise NPC_IPSEC_SPI via npc_is_field_present() instead of treating
the overlap as a hard failure.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> index 91b5947dae060..b217c1c19810a 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> @@ -730,6 +730,9 @@ static void npc_set_features(struct rvu *rvu, int blkaddr, u8 intf)
>  			*features &= ~BIT_ULL(NPC_OUTER_VID);
>  
>  	/* Allow extracting SPI field from AH and ESP headers at same offset */
> +	if (npc_check_overlap(rvu, blkaddr, NPC_IPSEC_SPI, 0, intf))
> +		dev_warn(rvu->dev, "Overlap detected the field NPC_IPSEC_SPI\n");

[Severity: Medium]
The commit message notes that AH and ESP may legitimately use the same key
offset for SPI. However, will this new dev_warn() trigger anyway for those
valid configurations?

If an MKEX profile configures AH and ESP SPI extraction at the same
offset, npc_check_overlap() will still see them as mutually exclusive fields
with different lids (LID_LD and LID_LE). Does this result in spurious
warnings polluting the kernel log on valid hardware configurations?

[Severity: High]
This is a pre-existing issue, but does npc_check_overlap() have a data
race when called concurrently?

Looking at npc_check_overlap(), it assigns a local pointer to the shared
scratchpad array and then mutates it:

rvu_npc_fs.c:npc_check_overlap() {
	...
	dummy = &mcam->rx_key_fields[NPC_UNKNOWN];
	...
	memset(dummy, 0, sizeof(struct npc_key_field));
	npc_set_layer_mdata(rvu, mcam, NPC_UNKNOWN, cfg, lid, lt, intf);
	...
}

If multiple VFs simultaneously send mailbox commands that trigger overlap
checks across different CPUs, won't they overwrite this global dummy struct
and corrupt each other's flow validation?

> +	/* Set SPI flag only if AH/ESP and IPSEC_SPI are in the key */
>  	if (npc_is_field_present(rvu, NPC_IPSEC_SPI, intf) &&
>  	    (*features & (BIT_ULL(NPC_IPPROTO_ESP) | BIT_ULL(NPC_IPPROTO_AH))))
>  		*features |= BIT_ULL(NPC_IPSEC_SPI);
