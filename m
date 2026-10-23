Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792786886;
	b=g4cBGNPQnJLI+dnguFuEju5CU8nk3ANhAmyHCOPSV2lI/GZ7xC7lelIw9rPSZ4+8grwO
	 BCfB7h0q4IBQ+DVwg2BfPssuWpaMjyA08ZxCJ7pNgJQam+wFIxNS1SIFwyjAviqPlg2bw
	 cTIdxswq9GFI4YHYFcU9tB5XjWhC0SPb3vUKNuvQK5VMSU6aVPSgHmbbFiog3EL41D50C
	 WPUvb6dQNLvagdElXSDbrygdYVrHfogGop600xDQ0ki/bZOz8L7UF+c8s51Y3v+anV5Mi
	 xXnDLsaCWxlf1zrqseQplYxhLg1LKv6tW/ykEwdkz1KJbIDFEtgebVpRoT3tYwjM1Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792786886;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=dVP3Ft8QhHtFHSq/MFQh+wRKC9dVjM8Wg5lboJkdPNE=;
	b=t6KfQ1XNu8/eesKI4+sy5yz+W3cWtj2uKo4z69IDc2VwN/PTlE1APtTgQ7UqPjimLmdB
	 Ugy9i6Pbz3zVaSNew0qG/IzOIR8dx/LSAkC9Y+Jb06RGvPB/sAGCi1srb32M897cHq0lx
	 Ln+Gme7zCJQyFvpp27equK1F6+Hzb1coFm93wrvdDrxSJaZt4ECc20qAJM244v6ds5an5
	 UC9jC1T7y0Q9sw1dYG8o9Kt+xIRaRjE8Gk7dXrJeqnkg4jh4Sjr6Uha6etqet4BMD9GKm
	 aI5TwcrvNBQzCRaSpyDmuGs3MUGyrOAkER3zppESsFj2V+kdF3tzeHNCtIb82VF0IVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dpIPZD/Z";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B6E606A321
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 20:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dpIPZD/Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3D71F01828;
	Fri, 23 Oct 2026 20:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792786886;
	bh=dVP3Ft8QhHtFHSq/MFQh+wRKC9dVjM8Wg5lboJkdPNE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dpIPZD/ZlhPZuQvD/AfeD2CfaSFss5YNJT04QlD5XFBGFLYXGAsnX0Q18xVg0m9gT
	 E0dl5TyfaraSGJ2Wk0RZ5c1CO9d0kYsX27egPYVVR0G0BOVScd2jiW+hkMjWx0uffD
	 hrkoQgVsNf0gB1lFNPSi33Ilml2E1XNTvpPDbdplTKIxxuNuPE5Xx5zKe1sQ4DKIbm
	 6gfqpTASrhsNu//Uqk1OckrGlofD0fO3D+kVlF8VCivHhiLnFLNFTk48xJx0YhiiA1
	 Fwg+PVSF1adFum5a9zAMZJw1FLth6JX0uN7aZtqGt1kRYsGWpFdijlugbkn6vKjEPR
	 pnk838e/BDKLA==
Subject:
 Re: [PATCH net 2/2] net: dsa: mxl862xx: reject bridge_id 0 from BRIDGE_ALLOC
From: netdev-bot+sashiko@kernel.org
To: memoriaru@foxmail.com
Cc: netdev@vger.kernel.org, daniel@makrotopia.org, andrew@lunn.ch,
 olteanv@gmail.com, johan@kernel.org, kuba@kernel.org
Date: Fri, 23 Oct 2026 20:21:25 +0000
Message-ID: <179278688542.3134.16248009385402335155@kernel.org>
In-Reply-To: <tencent_920A69A08AE91025A2F5D4ADC3E555862E07@qq.com>
References: <tencent_920A69A08AE91025A2F5D4ADC3E555862E07@qq.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] mxl862xx_allocate_bridge()
  (drivers/net/dsa/mxl862xx/mxl862xx.c:587-606) still checks the device-…
- [Medium] net: dsa: mxl862xx: off-by-one check order in
  mxl862xx_port_fdb_dump()
- [Low] The commit message does not mention one of the two hunks, and
  that hunk has nothing to do with bridge_id.
- [Low] The commit message has several gaps.

--

net: dsa: mxl862xx: reject bridge_id 0 from BRIDGE_ALLOC

This patch makes mxl862xx_allocate_bridge() return -EIO when the
BRIDGE_ALLOC response carries bridge_id 0. That value is reserved by the
API and collides with MXL862XX_DEFAULT_BRIDGE, which the CPU port uses.
The patch also rewrites the comment on the iteration bound in
mxl862xx_port_fdb_dump().

> mxl862xx_allocate_bridge() only checks the transport status (ret < 0)
> and returns le16_to_cpu(bridge_id) verbatim.

[Severity: Low]
I have a few small questions about the commit message.

The code being replaced checks "if (ret) return ret;", not ret < 0.
Should the description match the code?

Should this have a Fixes: tag? git blame shows all of
mxl862xx_allocate_bridge() came from:

Fixes: 340bdf984613 ("net: dsa: mxl862xx: implement bridge offloading")

The message doesn't mention that 0 is also the "not allocated" value
for priv->bridges[]:

mxl862xx_port_bridge_join() {
    ...
	if (!priv->bridges[bridge.num]) {
		ret = mxl862xx_allocate_bridge(priv);
    ...
}

mxl862xx_get_fid() {
    ...
	case DSA_DB_BRIDGE:
		if (!priv->bridges[db.bridge.num])
			return -ENOENT;
    ...
}

So with an id of 0, the bridge also looked unallocated. Each later join
allocated it again, and bridge FDB and MDB operations failed with -ENOENT.
Would it be worth describing this as well?

Firmware that follows the API never returns 0, so this change guards
against firmware that breaks the API. Could the message say so? It would
help with net vs net-next and stable decisions.

The Reported-by: trailer has the author's own address and there's no
Closes: link. Is that intended?

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
> index 12cd40756a0c9..dbe20014d090e 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx.c
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
> @@ -593,7 +593,16 @@ static int mxl862xx_allocate_bridge(struct mxl862xx_priv *priv)
>  	if (ret)
>  		return ret;
>  
> -	return le16_to_cpu(br_alloc.bridge_id);
> +	/* Per the API spec, id 0 is not used for historic reasons. Accepting
> +	 * it verbatim collides with MXL862XX_DEFAULT_BRIDGE (the CPU port),
> +	 * silently merging the port's FID with the CPU port's filtering
> +	 * domain.
> +	 */
> +	ret = le16_to_cpu(br_alloc.bridge_id);
> +	if (ret == 0)
> +		return -EIO;
> +
> +	return ret;
>  }

[Severity: Medium]
Is rejecting only 0 enough to cover what the commit message describes?
Every other u16 value is still returned as a valid FID.

The kernel-doc for struct mxl862xx_bridge_alloc in mxl862xx-api.h says:

 * @bridge_id: If the bridge allocation is successful, a valid ID will be
 *             returned in this field. Otherwise, INVALID_HANDLE is
 *             returned.

The driver doesn't define or check INVALID_HANDLE. If it is ~0, as in
the MaxLinear GSW API, 65535 would be accepted as a FID.

The commit message also says "duplicate non-zero ids returned for two
ports collapse their per-port FID isolation". However, nothing compares
the returned id with priv->ports[*].fid or priv->bridges[*], so
duplicates still get through.

There's also no upper bound check against the hardware FID range.
Commit 340bdf984613 says the switch supports at most 63 bridges.

Both callers only check for ret < 0 and then use the value:

mxl862xx_port_setup()
    priv->ports[port].fid = ret;
    -> mxl862xx_bridge_config_fwd(), mxl862xx_set_bridge_port()

mxl862xx_port_bridge_join()
    priv->bridges[bridge.num] = ret;
    -> mxl862xx_sync_bridge_members(), mxl862xx_get_fid(), BRIDGE_FREE

mxl862xx_port_fdb_del() matches an entry only by FID, VID and MAC. So if
two domains get the same FID, deleting an FDB entry in one domain can
remove an entry belonging to the other.

Should this check also reject INVALID_HANDLE, ids outside the hardware
range, and ids that are already in use?

[ ... ]

> @@ -1513,9 +1522,11 @@ static int mxl862xx_port_fdb_dump(struct dsa_switch *ds, int port,
>  		if (ret)
>  			return ret;
>  
> -		/* The MAC table capacity is fixed by the device. A walk longer
> -		 * than that means the device (or its firmware) is not
> -		 * responding correctly; bail out instead of looping forever
> +		/* The exact MAC table capacity is not part of the public
> +		 * driver API. Use a conservative upper bound: 16k entries is
> +		 * well above any documented table size for this family, while
> +		 * a device that stopped responding correctly (e.g. firmware
> +		 * crash mid-walk) would otherwise keep us looping forever
>  		 * with RTNL held.
>  		 */
>  		if (count++ >= MXL862XX_MAC_TABLE_FDB_SIZE) {

[Severity: Medium]
The previous patch introduced this, not this one, but this hunk
rewrites the comment above it anyway. Is the bound checked in the
right place?

In mxl862xx_port_fdb_dump() the count check runs before the
param.last test. The final MXL862XX_MAC_TABLEENTRYREAD response only
sets last and carries no entry, but it is still counted against
MXL862XX_MAC_TABLE_FDB_SIZE.

With N valid entries the loop does N + 1 reads. On the last read,
count is already N. If the table holds exactly
MXL862XX_MAC_TABLE_FDB_SIZE entries, the dump returns -EIO and logs
"FDB dump exceeded table capacity". The firmware ended the walk
correctly, yet bridge fdb show fails on a full table.

The macro name and the error message both call 16384 the table
capacity. A full table is exactly the case the bound is meant to
allow. Should the param.last test be moved above the count check?

[Severity: Low]
This isn't a bug, but this hunk has nothing to do with bridge_id, and the
commit message doesn't mention it. It rewrites the comment that the
previous patch in the series added ("net: dsa: mxl862xx: bound FDB dump
walk by table capacity").

Should it be squashed into that patch instead?

The new comment says 16384 is not the table capacity, but the code
around it still says it is:

#define MXL862XX_MAC_TABLE_FDB_SIZE 16384
...
			dev_err(ds->dev, "FDB dump exceeded table capacity\n");

The previous patch's subject also says "by table capacity". Should the
macro name and the error message be changed to match the new comment?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/tencent_A56873DA4A296F5D794B6A5989A180A21C05%40qq.com
