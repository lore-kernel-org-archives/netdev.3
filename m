Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430642DF13F;
	Fri,  7 Aug 2026 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786112732; cv=none; b=HMz+pdHbaOyZdPBTiYVmAcfZB5S+7au35ZYBMMj4wDvBJ/Tnet41VyYXRuLd0euhWnjaTghnEHyGVEjOhhMTB+OygF74AW4VGib4LdVttJ93VgfanwLW/QbE0ZznpSBBkZ9CcAJSA5WuwqQsp1vEySTVjOnEeyZtt6etEeyTvmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786112732; c=relaxed/simple;
	bh=EECuk7N2cA6Oa/5Z9csB0jQgOBwniWWgxKe9434Ss2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYMhJhc0NDIHJiDpxcBXggXoSRVrx4TnoY0AvB9qAkQvQJ6x4biGzDK0+T2t5tfyD3pRxZ2C23SPkFlf9T5PYkVKW9t0Ybrwq/AAxpBV/vvWkZuzCIPk3NQ9Fc9S9EkjR92PeISbpQlsqJpn/8nbTPqA94Zq3b53JyDyNZXfGtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8QJoBrx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8QJoBrx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882F51F000E9;
	Fri,  7 Aug 2026 14:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786112730;
	bh=i2Z8NEk1ahmUsaUuW3bNeWB6LgPaFITwCVOCDXlB65w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n8QJoBrxMkb4NlOUnex6GnBTKSnS4WHQpuyOz5pvbu9tfZaPjMEgeauF6KtPSnOTL
	 N2UwF6KayHX/QlEsWYxjwy97MxEIglorrx46P4u2KVJX0bGYirYVpcYTcX8Xitqqjh
	 5tva1LuP+9YFgTtxQ71V0cwkeXDMTBLOfdgL57G7qoHWH5BbGb2O4ApMTdx10kHy7D
	 i1Uc4MeAtfUuFWVLiCV11RqSqlQy3rc1md6lQRzy02UbFi8BP8/KODKgJiDSRxULIg
	 6/tGXmK4TmdTSHQig8YExe7AxGt6bt7d1cfv7zOG3KdnGtR5l2pVjpKY6kd8rGSGRa
	 eGZK7BMSVaqbw==
Date: Fri, 7 Aug 2026 15:25:26 +0100
From: Simon Horman <horms@kernel.org>
To: nshettyj@marvell.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Satheesh Paul <psatheesh@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] octeontx2-af: Add mailbox to read default MCAM
 entry
Message-ID: <20260807142526.GM51943@horms.kernel.org>
References: <20260806075631.2007542-1-nshettyj@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806075631.2007542-1-nshettyj@marvell.com>

On Thu, Aug 06, 2026 at 01:26:31PM +0530, nshettyj@marvell.com wrote:
> From: Satheesh Paul <psatheesh@marvell.com>
> 
> Add an NPC mailbox command so PF/VF clients can read the default
> unicast MCAM rule associated with their NIX LF.
> 
> Signed-off-by: Satheesh Paul <psatheesh@marvell.com>
> Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
> ---
>  .../net/ethernet/marvell/octeontx2/af/mbox.h  |  2 ++
>  .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 34 +++++++++++++++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> index 73f743e4a83d..cece197d1074 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -309,6 +309,8 @@ M(NPC_MCAM_GET_DFT_RL_IDXS, 0x601e, npc_get_dft_rl_idxs,	\
>  M(NPC_MCAM_GET_NPC_PFL_INFO, 0x601f, npc_get_pfl_info,		\
>  					msg_req,		\
>  					npc_get_pfl_info_rsp)	\
> +M(NPC_MCAM_READ_DEFAULT_RULE, 0x6021, npc_read_default_rule, msg_req,	\
> +					npc_mcam_read_base_rule_rsp)	\
>  /* NIX mbox IDs (range 0x8000 - 0xFFFF) */				\
>  M(NIX_LF_ALLOC,		0x8000, nix_lf_alloc,				\
>  				 nix_lf_alloc_req, nix_lf_alloc_rsp)	\
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> index db27ea622f35..266bb762691c 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> @@ -4303,6 +4303,40 @@ int rvu_mbox_handler_npc_set_pkind(struct rvu *rvu, struct npc_set_pkind *req,
>  				      req->skip_size);
>  }
>  
> +int rvu_mbox_handler_npc_read_default_rule(struct rvu *rvu,
> +					   struct msg_req *req,
> +					   struct npc_mcam_read_base_rule_rsp *rsp)
> +{
> +	struct npc_mcam *mcam = &rvu->hw->mcam;
> +	int index, blkaddr, nixlf, rc;
> +	u16 pcifunc = req->hdr.pcifunc;
> +	u8 intf, enable;
> +
> +	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
> +	if (blkaddr < 0)
> +		return NPC_MCAM_INVALID_REQ;
> +
> +	rc = nix_get_nixlf(rvu, pcifunc, &nixlf, NULL);
> +	if (rc < 0)
> +		return rc;
> +
> +	/* Read the default ucast entry */
> +	mutex_lock(&mcam->lock);
> +	index = npc_get_nixlf_mcam_index(mcam, pcifunc, nixlf,
> +					 NIXLF_UCAST_ENTRY);
> +	if (index < 0) {
> +		mutex_unlock(&mcam->lock);
> +		return NIX_AF_ERR_AF_LF_INVALID;
> +	}
> +
> +	/* Read the mcam entry */
> +	npc_read_mcam_entry(rvu, mcam, blkaddr, index, &rsp->entry, &intf,
> +			    &enable);
> +	mutex_unlock(&mcam->lock);
> +
> +	return 0;
> +}
> +

Hi,

There is an extensive AI-generated review of this patch available at
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260806075631.2007542-1-nshettyj%40marvell.com

While I'd appreciate it if you could look over the entire review I think
the most relevant point raised is the one I've pasted immediately below.
Could you provide some feedback on it?

  Does this path return the contents of unrelated registers on CN20K?
  The index comes from the cn20k-aware lookup, whose first branch is:

    npc_get_nixlf_mcam_index() {
	if (is_cn20k(rvu->pdev)) {
		rc = npc_cn20k_dft_rules_idx_get(rvu, pcifunc, &bcast, &mcast,
						 &promisc, &ucast);
	...
    }

  but the entry is then decoded unconditionally with the legacy reader, which
  uses the pre-CN20K register macros:

    npc_read_mcam_entry() {
	cam1 = rvu_read64(rvu, blkaddr,
			  NPC_AF_MCAMEX_BANKX_CAMX_W0(src, bank, 1));
	...
	entry->action = rvu_read64(rvu, blkaddr,
				   NPC_AF_MCAMEX_BANKX_ACTION(src, sbank));
    }

  CN20K MCAM registers use different bases and shifts, for example in
  af/cn20k/reg.h:

    #define NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W0_EXT(a, b, c) ...
	offset = (0x9000000ull | (a) << 4 | (b) << 20 | (c) << 3);

  Elsewhere in the driver the helper choice is guarded, e.g. in
  npc_update_dmac_value():

    if (is_cn20k(rvu->pdev)) {
	if (npc_cn20k_read_mcam_entry(rvu, npcblkaddr, rule->entry,
				      cn20k_entry, &intf,
				      &enable, &hw_prio))
		return -EINVAL;
    } else {
	npc_read_mcam_entry(rvu, mcam, npcblkaddr, rule->entry,
			    entry, &intf, &enable);
    }

  and rvu_mbox_handler_npc_cn20k_read_base_steer_rule() uses
  npc_cn20k_read_mcam_entry() for the equivalent CN20K message.  Without a
  similar branch here, does a CN20K PF/VF get garbage key/action data with a
  return code of 0?


