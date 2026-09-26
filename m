Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BE545D5FA;
	Sat, 26 Sep 2026 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790431244; cv=none; b=ufNwiVwuGJiDvyarv1RHOIkB6SK34peFL8X9MXVVhDLlvhVtyJljvbnDXnL5l+cj7QfLvoys+pxlS9WyBGWYNK97RfAh8Sa8C5b3sxKBqMbiin69iwGX9Zusb3iKY0dPSajKwnb08arJEev+NHkCqwW9poqjOxLNwWam1vHH7Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790431244; c=relaxed/simple;
	bh=khlAlwdgyRR7qXriq1B6qriQzxyn8/LP3JPW62ZGPjc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J5nDpY8ObAC20R7pp3sR99aiawBqtMVBJcd9sTir5kWHWYmzAtba/Ss4xAoVo78FIxRK/CzA8cDkixP3nPW7maTIWHxYWIa2w5zogPZArRq/hEFgPOwU6TW1nvWrKo88Qs7sbZaOXyvs6GeCogsl45czNS55ev705qUsNoGC88w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTqvsSmu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTqvsSmu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4F01F0089A;
	Sat, 26 Sep 2026 14:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790431232;
	bh=PQH3s/qTImkBoMqUW7VJUVAMmDbdZwuKeMhimx5KSG4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XTqvsSmuIsX4p2FCN9r8DGdPkF+L1KBiO4YwHsSbqY/dOcmA8GwnpxBvzgd6e5+x+
	 PEgYVwMGx8RveVaTxDSvJ0culykfMb3EF1AYY4PvwW6DVRcTkI3WRd1JngzghyeeVe
	 /w4SJVutTlzIvJqV6mnF1Qw2FVFjxQlyox8VlvyAe4J/d4oClcQFAoCxrbASQpTeVj
	 Xg0mwMZx+elYD31vD0rKfGetnZl5oyIbb3MvCWE+zRkXmf3Rbrni6cWqqB8H0Fa3WT
	 YyC2tBCmYDLU2qVfMt1R7RSjsYfQ+01mokrNcBdB5J9KEy0rpmRZJmGhSVnylEXo8n
	 IUHbvAtDTN+JA==
Subject: Re: [PATCH v29 net-next 5/8] net/nebula-matrix: dispatch: add
 control-level routing core infrastructure
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 26 Sep 2026 14:00:31 +0000
Message-ID: <179043123184.2160803.15291349410665636655@kernel.org>
In-Reply-To: <20260922120311.86593-6-illusion.wang@nebula-matrix.com>
References: <20260922120311.86593-6-illusion.wang@nebula-matrix.com>
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

- [Low] Commit message describes content the patch does not contain: it
  claims the patch "adds forward definitions of channel wire ABI…

--

net/nebula-matrix: dispatch: add control-level routing core infrastructure

This patch adds the nbl dispatch layer skeleton: it allocates the dispatch
management structure and ops table, wires init_module/deinit_module
wrappers to the resource ops, and tracks control levels in a ctrl_lvl
bitmap. It also adds four channel parameter structures with size
assertions to nbl_def_channel.h.

> This skeleton establishes dispatch management flow. It adds forward
> definitions of channel wire ABI structures and response enums required
> for later channel RPC framework, without implementing message handling.

[Severity: Low]
Could the "and response enums" part of this sentence be dropped or
corrected?  The patch does not appear to add or modify any enum.

The only additions to nbl_def_channel.h are the four structures
nbl_chan_param_cfg_msix_map, nbl_chan_param_set_mailbox_irq,
nbl_chan_param_get_vsi_id and nbl_chan_param_get_eth_id, plus their four
static_assert() size checks:

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
> index bf971121d2ecf..c9c99c967037e 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
> @@ -39,6 +40,32 @@ enum nbl_chan_state {
>  	NBL_CHAN_STATE_NBITS
>  };
>  
> +struct nbl_chan_param_cfg_msix_map {
> +	__le16 num_net_msix;
> +	__le16 num_others_msix;
> +	__le16 msix_mask_en;
> +	__le16 rsvd;
> +};
> +
> +struct nbl_chan_param_set_mailbox_irq {
> +	__le16 vector_id;
> +	u8 en_msix;
> +	u8 rsvd;
> +};
> +
> +struct nbl_chan_param_get_vsi_id {
> +	__le16 vsi_id;
> +	__le16 type;
> +};
> +
> +struct nbl_chan_param_get_eth_id {
> +	__le16 vsi_id;
> +	u8 eth_num;
> +	u8 eth_id;
> +	u8 logic_eth_id;
> +	u8 rsvd[3];
> +};
> +
>  struct nbl_board_port_info {
>  	u8 eth_num;
>  	u8 eth_speed;

[ ... ]

After this patch, enum nbl_chan_msg_type in the same header is still
unchanged from the baseline:

enum nbl_chan_msg_type {
	NBL_CHAN_MSG_ACK = 0,
	/* mailbox msg end */
	NBL_CHAN_MSG_MAILBOX_MAX,
};

and there is no response or return-code enum added anywhere else in the
patch.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922120311.86593-2-illusion.wang%40nebula-matrix.com
