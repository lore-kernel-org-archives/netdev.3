Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B58B36A35A;
	Thu, 10 Sep 2026 04:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789014766; cv=none; b=pfgrbkSCzyg18Py2ZaLAzkDg/q26SYwBdWcbAkN8YQqkPfm6ESAn1/x67QM+6U0Pp9d3Wh0c2ad37SC8v7hX213aHP8rgtvNvl5IBGm4Llp/XbToO7TLXg1CilplvRfK1MlHs1Y6ymuHwYQ4w2zgYblwrxDXiCpouv+lkLxkOnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789014766; c=relaxed/simple;
	bh=MFKzVYgGQEd11ppCdPQZn7O0GNRRG1Mhk6EDGf/9rEo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BcMU6ktvVHtDwH5OsJW/E5DPX29xA3p/FVFW9cm7OoFYU4Tn4/dOKuwn0VZadVT4vsw40uBRgmQdho6KnAoocPMGMdFjfF/SnK8il02LyKMFqDqgL1D3w7DHSFb1ggcXU/6WljUn7Me7DeQEggHb/hjaxq2J7czUTrAxT8Dgbh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/+uRx3R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/+uRx3R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BF41F000FF;
	Thu, 10 Sep 2026 04:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789014764;
	bh=nLomoyMuXiOxkohf3Z2yt0fbleEgNC5NNGz+z6kEYZw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=F/+uRx3RBbxhWQNjRFmM9fS6VCvHCvSoq5Te6UCgUURUF+sW9NzeFFsEmlrvsZ17i
	 VeI82RHauLI3xR/hTn49GEcmxMgVxYv7WYu9AwY1dzD+Qmj2Fb/VzG8ZyTAJ5rt/P8
	 R1HZCEPbpaGq/PaGfEWCXdXBADX+EdpRmwQaewhCYphpOhkFunNdXQNF/l23/F8PUr
	 7FeSX+OJB1pCyw+4caDtfOOVmbSHi0s3rvNKZcRQMAEwz3zC8ZC/3K/GRRDrc0jjWA
	 239LTE0H/iHUFP/t+GAtu8gnN2xPPqOsDyoO6TYpm7jD8Z2tjqSfPvT7/roCTNe9Do
	 LZf1Lk9UbKp5g==
Subject: Re: [PATCH v3 net-next] octeontx2-pf: report port connector type in
 ethtool link ksettings
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com, hkelam@marvell.com
Date: Thu, 10 Sep 2026 04:32:43 +0000
Message-ID: <178901476356.219967.4043623609208931989@kernel.org>
In-Reply-To: <20260909040621.397255-1-rkannoth@marvell.com>
References: <20260909040621.397255-1-rkannoth@marvell.com>
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
  (drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c:1236)…

--

octeontx2-pf: report port connector type in ethtool link ksettings

otx2_get_link_ksettings() now reads the connector type out of the CGX
firmware shared data (struct cgx_lmac_fwdata_s.port), masks the low eight
bits, checks the result against a list of ethtool PORT_* values and stores
it into cmd->base.port.  Unrecognized values become PORT_OTHER.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> index 9bee1b91eeaa..a05dee0085a3 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c

[ ... ]

> @@ -1231,6 +1232,23 @@ static int otx2_get_link_ksettings(struct net_device *netdev,
>  				OTX2_MODE_SUPPORTED, cmd);
>  	otx2_get_fec_info(rsp->fwdata.supported_fec,
>  			  OTX2_MODE_SUPPORTED, cmd);
> +
> +	port = FIELD_GET(GENMASK(7, 0), rsp->fwdata.port);
> +	switch (port) {
> +	case PORT_TP:
> +	case PORT_AUI:
> +	case PORT_MII:
> +	case PORT_FIBRE:
> +	case PORT_BNC:
> +	case PORT_DA:
> +	case PORT_NONE:
> +		cmd->base.port = port;
> +		break;
> +	default:
> +		cmd->base.port = PORT_OTHER;
> +		break;
> +	}

[Severity: Medium]
Can this report a wrong connector type when firmware never populated the
field?

PORT_TP is 0x00 in include/uapi/linux/ethtool.h, and the ethtool core
zero-fills the settings before calling into the driver:

net/ethtool/ioctl.c:netif_get_link_ksettings() {
	memset(link_ksettings, 0, sizeof(*link_ksettings));
	return dev->ethtool_ops->get_link_ksettings(dev, link_ksettings);
}

So a zero firmware word takes the "case PORT_TP:" arm rather than the
default PORT_OTHER arm, and ethtool prints "Port: Twisted Pair" on a
fibre, DAC or backplane board.

Is a zero word possible here?  The member was carved out of the previously
reserved (zero-filled) tail of struct cgx_lmac_fwdata_s by commit
49f02e6877d1b, which shrank LMAC_FWDATA_RESERVED_MEM from 1021 to 1018:

drivers/net/ethernet/marvell/octeontx2/af/mbox.h:
	u64 mgmt_port:1;
	u64 advertised_an:1;
	u64 port;
#define LMAC_FWDATA_RESERVED_MEM 1018
	u64 reserved[LMAC_FWDATA_RESERVED_MEM];

RVU_FWDATA_VERSION was not bumped at the same time, and
is_rvu_fwdata_valid() in af/rvu.h only compares header_magic and version,
so firmware images that predate the field still pass the ABI gate and hand
back zeros for this word.

Would it make sense to also consult rw_valid from the same struct?  It is
the per-LMAC validity flag, and grep shows it is currently only referenced
in mbox.h and rvu_debugfs.c, never by this new consumer.  Note also that
the debugfs dumper added alongside the field prints rw_valid, lmac_type,
portm_idx and mgmt_port, but not port.

Separately, does the masking defeat part of the validation?  FIELD_GET()
with GENMASK(7, 0) drops bits 63:8 before the switch runs, so firmware
values such as 0x100 or 0x103 are published as PORT_TP and PORT_FIBRE
respectively.  mbox.h documents no bitfield layout, mask or reserved-bit
contract for this bare u64, so it isn't clear the upper bits can be
discarded rather than treated as "not a valid connector code".

Related to that, the commit message says:

  "Extract only the low 8 bits of the firmware field and validate the
   value against the standard ethtool PORT_* definitions before
   publishing it to userspace."

Given that neither the unpopulated (zero) case nor invalid values living in
bits 63:8 can be rejected by this check, could the description be made
more precise about what is actually validated?

One more question on the encoding itself: is there an in-tree statement
that fwdata.port uses ethtool PORT_* numbering?  The only other firmware
description of a "port" value is struct cgx_lnk_sts.port:8 with
RESP_LINKSTAT_PORT in af/cgx_fw_if.h, and that macro is defined but never
decoded by cgx.c, so the mapping to PORT_TP/PORT_FIBRE/... appears
undocumented here.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909040621.397255-1-rkannoth%40marvell.com
