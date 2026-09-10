Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E841B472538;
	Thu, 10 Sep 2026 11:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789039263; cv=none; b=Qa1P14AEnj+f79vdiad6om2Nwdwd5605HknW2QudLZMSAGZoh0pz0rSQ+zNR0CF89QFyDKYHSqa5Og76SUzOIcUjJfd3rRT16IoliL0XHBUqLhcsj7x82ALsGDkHtTDe6XJ5EAie2romZ5DuRb1nTKYLcJPAwxrHY5oT5V1him0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789039263; c=relaxed/simple;
	bh=ZhpZWf7gt/ntSjX/0lq5QSKLq0nCHzWs+GKIJ30FdhY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r3mdbFqRCf/aKfgwsF777h3zSDL6HF11IipC+zd0K94bGOeywERwecgukavrfJ+MQKNmLNUQQ9+6qyd+hNk3oR3fg0Sh2SVRp88VUmLhWpprqu9YbpymDOq+uWIp3ViSETsfYy5g9S+BNqKSS1MciXzcevAUlL8PxmD99SzQ36w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eylY9PD3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eylY9PD3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40341F000FF;
	Thu, 10 Sep 2026 11:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789039261;
	bh=2ZaCLKO5p03OO7RPJLxcps83roWsY+5awdnBDv/LhLk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eylY9PD3Wm75mVwYu1DZwEE47Mobv66WePBqailWcJOyVAwJ2TqGVIIK+jThTmQuU
	 duQMf1Mnzp8wuXQDzkL7A6Ik4k+PYokWy1lnLalxLYuxC0y6Np6IhEkJPBHvE1U/3K
	 OLH8oELm9j8Eyye45QVamtKkUpbtbLRSWWEbY/JDOfIzJ0YipYCyoiMjuBTXNS/LC8
	 ODYKgASkMB+d+rRc5FoFQ2nHyj9XSWUv/YtLDxDC0dF0VelVkr6UY2g305+L19y+OC
	 1HndVBeWAsgE6S2/NH8he1yg4BUbGkIGbZQIb8P7KGycbJrm/vgvYSKfA/3DqkYsmM
	 pn+if0wzKJNtQ==
Subject: Re: [PATCH v4 net-next 09/15] net: enetc: add MAC address filtering
 support for VFs of ENETC v4
From: netdev-bot+sashiko@kernel.org
To: wei.fang@oss.nxp.com
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew@lunn.ch, olteanv@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, wei.fang@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 10 Sep 2026 11:21:00 +0000
Message-ID: <178903926035.219967.18291576292215190234@kernel.org>
In-Reply-To: <20260909100733.1139689-10-wei.fang@oss.nxp.com>
References: <20260909100733.1139689-10-wei.fang@oss.nxp.com>
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

- [Low] DISCARDED (resolved later in the same series).
- [Low] struct enetc_msg_mac_hash_filter
  (drivers/net/ethernet/freescale/enetc/enetc_mailbox.h:226-232)…

--

net: enetc: add MAC address filtering support for VFs of ENETC v4

This adds two VSI-to-PSI mailbox commands under the MAC filter class so an
ENETC v4 VF can ask the PF to program its unicast/multicast MAC hash filter
tables and to toggle promiscuous mode, with trusted-VF checks and a limit of
8 multicast hash buckets for untrusted VFs. It also takes si->gen_lock around
the read-modify-write of the shared PSIPMMR register, and clears a VF's
unicast hash filter and promiscuous mode when it loses trusted status.

A couple of questions below.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h b/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
> index 832d2f6ddcd8..6fa66c863748 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h

[ ... ]

> @@ -204,6 +220,32 @@ struct enetc_msg_mac_exact_filter {
>  	struct enetc_mac_addr mac[];
>  };
>  
> +/* message format of class_id 0x20 for hash MAC filter.
> + * cmd_id 0x3: set MAC hash table
> + */
> +struct enetc_msg_mac_hash_filter {
> +	struct enetc_msg_header hdr;
> +	/* bit 0 ~ 5: ENETC_MSG_MAC_HASH_SIZE
> +	 * bit 6~7: ENETC_MSG_MAC_TYPE
> +	 */
> +	u8 sz_type;
> +	u8 resv[3];
> +	u32 hash_tbl[];
> +};

[Severity: Low]

Should hash_tbl[] carry an explicit endianness annotation?

This struct describes a wire format: the message lives in a DMA buffer that
the mailbox hardware copies from the VSI buffer into the PSI buffer, and the
header in this same file already declares the byte order of its multi-byte
field:

	struct enetc_msg_header {
		__be16 crc16;
		...
	};

hash_tbl[] is the only other multi-byte payload field and it is plain u32,
so both endpoints are implicitly required to have the same byte order. The
producer fills it in host order and enetc_msg_set_vf_mac_hash_filter()
recombines it in host order:

		uc_hash = (u64)msg->hash_tbl[1] << 32 | msg->hash_tbl[0];

If a big-endian VSI kernel ever talks to a little-endian PSI (or a
non-Linux PSI implementing the documented protocol), would the hash buckets
end up byte-swapped, so the SI filters on the wrong buckets while both
sides report success? The CRC16 is computed byte-wise over the buffer, so
it would not catch that.

Would declaring the array as __le32 and converting with cpu_to_le32() /
le32_to_cpu() on both ends be preferable now, while the format is being
introduced?

> +
> +/* message format of class_id 0x20 for MAC promiscuous mode.
> + * cmd_id 0x5: set MAC promiscuous mode
> + */
> +struct enetc_msg_mac_promisc_mode {
> +	struct enetc_msg_header hdr;
> +	/* bit 0: ENETC_MSG_MAC_FLUSH_MACS
> +	 * bit 1: ENETC_MSG_MAC_PROMISC_MODE
> +	 * bit 6~7: ENETC_MSG_MAC_TYPE
> +	 */
> +	u8 config;
> +	u8 resv[15];
> +};
> +
>  /* The generic message format applies to the following messages:
>   * Get IP revision message, class_id 0xf0.
>   * cmd_id 1: get IP minor revision

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> index 08a9ffdd3eb0..22f5485e968a 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c

[ ... ]

> @@ -116,6 +242,10 @@ static u16 enetc_msg_handle_mac_filter(struct enetc_pf *pf, int vf_id,
>  	switch (msg_hdr->cmd_id) {
>  	case ENETC_MSG_SET_PRIMARY_MAC:
>  		return enetc_msg_set_vf_primary_mac_addr(pf, vf_id, vf_msg);
> +	case ENETC_MSG_SET_MAC_HASH_TABLE:
> +		return enetc_msg_set_vf_mac_hash_filter(pf, vf_id, vf_msg);
> +	case ENETC_MSG_SET_MAC_PROMISC_MODE:
> +		return enetc_msg_set_vf_mac_promisc_mode(pf, vf_id, vf_msg);
>  	default:
>  		return ENETC_PF_MSG_NOTSUPP;
>  	}

[Severity: Low]

At this commit, is there anything in the tree that sends
ENETC_MSG_SET_MAC_HASH_TABLE or ENETC_MSG_SET_MAC_PROMISC_MODE?

Both new handlers here, and the UCF_DENY mapping added to
enetc_msg_vsi_send() below, only become reachable with the later patch in
the series ("net: enetc: implement ndo_set_rx_mode_async for ENETC v4 VF"),
which adds enetc_vf_set_mac_hash_filter() and enetc_vf_set_mac_promisc()
and wires .ndo_set_rx_mode_async = enetc_vf_set_rx_mode into
enetc4_ndev_ops. So this is only a patch-ordering observation, the receiver
landing one patch before the sender, not a defect at the end of the series.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> index 7dcb4a0246f5..a60af40d8546 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> @@ -107,8 +107,12 @@ static int enetc_msg_vsi_send(struct enetc_si *si, struct enetc_msg_swbd *msg)
>  		case ENETC_MSG_CLASS_ID_CMD_TIMEOUT:
>  			err = -ETIME;
>  			break;
> -		case ENETC_MSG_CLASS_ID_INVALID_MSG_LEN:
>  		case ENETC_MSG_CLASS_ID_MAC_FILTER:
> +			if (FIELD_GET(ENETC_PF_MSG_CLASS_CODE, pf_msg) ==
> +			    ENETC_MF_CLASS_CODE_UCF_DENY)
> +				return -EACCES;
> +			fallthrough;
> +		case ENETC_MSG_CLASS_ID_INVALID_MSG_LEN:
>  			err = -EINVAL;
>  			break;
>  		case ENETC_MSG_CLASS_ID_CMD_NOT_PERMITTED:

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909100733.1139689-1-wei.fang%40oss.nxp.com
