Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BFD3DB641;
	Fri,  4 Sep 2026 07:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788508767; cv=none; b=HCMtuaAPGJOf1VEwl0gdVSGNscAM1ciOpaiZ4w6rtWm+g6Nir83cKoSA2CjvsuzTTCejIZEv1UIG5BnLrtG/yFiQlU3NRu39eTJmLPtZQdxDDZD2Up/+cnbBY0Vbeumxjxg01mBMpVnT4XBdsW0gPK2WIjBgLERc9EoG9ki4S9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788508767; c=relaxed/simple;
	bh=3aEQblZaaJNvrWFdG04ITHf704vGjeq2MTnydsa9gW8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ii2Ope7xiFWQGLSIkRSd3ggD41veiDFdlP5Fk6x1EJ4rBLEyqad7VUk/ommerD4GuM4P1FIm8XH9lzEHlw0UFZ21Cym5uz+2Ibkt0g5V/eKUWra8R3kahC5izw6dmP2Mr77utieCaCOQNFz+eboKOq0H0TlO8EOIXsoCQRPSaiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlMwr7nJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlMwr7nJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F241F00A3D;
	Fri,  4 Sep 2026 07:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788508765;
	bh=71mPnVlP98Wj98gZPeaQTSsU41ec47FdcSzRllKnIA4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jlMwr7nJoRDwjGDZlNKMjw9Inh8mHF4I07ugUnN8JtHART3faujA7HjBRWkDzm5O2
	 Q6qFypkz2A6m408pftrafYRb83rX31NIJ7sdK6gRbAzkzKCPLZIm7HzvUFMUJwlKgw
	 X03+s132gUClGt1/EqZ/UQt8eP38r6BIqFWXDZIIxHV3DiccX4OLP+arc7X8yr5tNJ
	 KrW9WX6iuIJP8uP4bxAYLrFPhB6CRMMoO4C5CPtHgq9ktPQH/qZk05UoBnjydmOojO
	 ra8N7nFqRVNCkGUj8+EdZESspMtfw60Ah0bhBSJO3+5AS7qygPpaf/gh0IhFTPjgPg
	 U26BmG+441RIQ==
Subject: Re: [PATCH net-next] octeontx2-pf: report port connector type in
 ethtool link ksettings
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com, hkelam@marvell.com
Date: Fri, 04 Sep 2026 07:59:24 +0000
Message-ID: <178850876430.4131868.17635457333077226877@kernel.org>
In-Reply-To: <20260901045857.2779326-1-rkannoth@marvell.com>
References: <20260901045857.2779326-1-rkannoth@marvell.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] otx2_get_link_ksettings()
  (drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c:1235)…

--

octeontx2-pf: report port connector type in ethtool link ksettings

This adds a single assignment to otx2_get_link_ksettings() so that
cmd->base.port is filled from the CGX firmware data word
rsp->fwdata.port, with the intent of letting ethtool display the
physical connector type.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> index 9bee1b91eeaa6..65630de435397 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> @@ -1231,6 +1231,8 @@ static int otx2_get_link_ksettings(struct net_device *netdev,
>  				OTX2_MODE_SUPPORTED, cmd);
>  	otx2_get_fec_info(rsp->fwdata.supported_fec,
>  			  OTX2_MODE_SUPPORTED, cmd);
> +
> +	cmd->base.port = rsp->fwdata.port;

[Severity: Medium]

Should this raw firmware word be translated before it is exported as the
ethtool connector type?

The source field is a 64-bit value in af/mbox.h:

struct cgx_lmac_fwdata_s {
	...
	u32 lmac_type;
	u32 portm_idx;
	u64 mgmt_port:1;
	u64 advertised_an:1;
	u64 port;
	...
};

The destination is the __u8 uAPI field in struct ethtool_link_settings,
documented as "@port: Physical connector type; one of %PORT_*", whose value
space is sparse and exhaustive (PORT_TP 0x00 .. PORT_DA 0x05, PORT_NONE
0xef, PORT_OTHER 0xff).

So the assignment silently narrows to 8 bits, and a firmware value of, say,
0x100 becomes 0x00, which userspace prints as Twisted Pair.  A value in
0x06..0xee is not a legal PORT_* code at all and ethtool prints "Unknown!".
The same byte then becomes the base value for ethnl_update_u8(&lsettings->port, ...)
on the netlink set path.

Would a switch or table mapping the firmware encoding to PORT_*, with
PORT_OTHER for anything unrecognised, be preferable here?

Every other consumer of the same firmware structure in this function does
translate: otx2_get_link_mode_info() maps CGX mode bits to
ETHTOOL_LINK_MODE_* bits, otx2_get_fec_info() maps OTX2_FEC_* to
ETHTOOL_LINK_MODE_FEC_*, and otx2_get_fecparam() bounds-checks against
OTX2_FEC_MAX_INDEX.

Is there anything that tells the driver whether the firmware populated this
word at all?

The field was carved out of the reserved tail of struct cgx_lmac_fwdata_s by
commit 49f02e6877d1be ("Octeontx2-af: Debugfs support for firmware data",
LMAC_FWDATA_RESERVED_MEM 1021 -> 1018) without bumping RVU_FWDATA_VERSION,
which is still 0x0001 in af/rvu.h.  The only check applied to the ATF region
is the outer header check:

static inline bool is_rvu_fwdata_valid(struct rvu *rvu)
{
	return (rvu->fwdata->header_magic == RVU_FWDATA_HEADER_MAGIC) &&
		(rvu->fwdata->version == RVU_FWDATA_VERSION);
}

and rvu_mbox_handler_cgx_get_aux_link_info() copies the region verbatim:

		memcpy(&rsp->fwdata,
		       &rvu->fwdata->cgx_fw_data[cgx_id][lmac_id],
		       sizeof(struct cgx_lmac_fwdata_s));

The struct's own rw_valid indicator is not consulted by the new code.  On
firmware that does not fill this word it reads 0, which is exactly PORT_TP,
so a fibre or DAC CGX/RPM SERDES port would be reported as Twisted Pair
rather than left unspecified.  Could the assignment be gated on
fwdata.rw_valid, or on a bumped firmware-data version, and fall back to
PORT_OTHER or PORT_NONE?

One more question about the commit message:

	Populate cmd->base.port from rsp->fwdata.port so users can see values
	such as PORT_TP or PORT_AUI via ethtool.

This states the firmware supplies PORT_* values, but a grep of
drivers/net/ethernet/marvell/octeontx2/ shows this new line is the only
reference to fwdata.port in the tree, and there is no firmware-encoding to
PORT_* table anywhere.  Can the firmware encoding, and the firmware version
that started populating the field, be documented in the changelog?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260901045857.2779326-1-rkannoth%40marvell.com
