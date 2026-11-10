Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308641;
	b=IuzKE9UBqwT03tg0jsnHVF7Ih1iadHwSbcnuxglw8MzhzlVCP5BP/E5qkrwF+aYKgr4x
	 Lye3TigFYvnVWcj4IxM5RdF9J71EVpNdvWkzmI7K7l5cx1XBYWqwFSYNacqxHkIfqM8qw
	 aV5ZZEnb5fgHVqm+tWY40u+b5RGR1/PsQqfftTURIlRe4ME36JVpiX9gWbloHFUv01iPD
	 Ji3IyPT4c/7n+WkoR8vDoa38VRfaWyl0LcuCatA18+5i2lRwjfCGdmM5t0T4dwZVe8xg5
	 gziTPByGEvhrYNsSTLzPgecEz36pUdkFccuNVW7Q3l7+Q4ZkbujdSWEz4KYoxRxfe7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308641;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=KU2z44F5z8AlkeMTeRxbpE43lTbF6L4xlpkMWboCgTY=;
	b=V10IDQFWFaBAAYncMF/DCcUYaMMrM5DwRyIJYVbxp4FhDdbsN9sTgxo5TmRZ1HzOiyLO
	 C88N5r8eZh2R0PQ6VO5ADIohcb48ohqAgRiYWGV3Bs2srfLPP4Fuay3D8rn5r1rmdi3Be
	 mkYTOsawnXh8VStufBPC0ANzobLoQOa4Ib1+QSiwNMPoDuMOQ6PJ+6CrGpjlqcV3ANizg
	 uq2OkGlWHaM7ibtUrUZSLkOTEtyTOdzQb4nlICu+UbM8prc/931KpWHCGO1lJTEruZJk2
	 uLXaUfSBsAFR7eNp2nHQE/BhhdsmdunyumzQgpNd5lOk3+SmGeDm0oQU82PLD4Q4y9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JtC9Unp7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F261360A262B;
	Tue, 10 Nov 2026 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JtC9Unp7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2491F008BE;
	Tue, 10 Nov 2026 11:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794308640;
	bh=KU2z44F5z8AlkeMTeRxbpE43lTbF6L4xlpkMWboCgTY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JtC9Unp7OAH4V6zlGStMNADrYaS/WLqeKr/Wg2ugtfBM3Zjo0sRKyRRxhDrClnXQa
	 9fvvYA875sFfIA+j+aZHXZYAmILCYFV00rphPsKIF4LIp7hWWb8TdZgI3RPSe0NZEB
	 /sLMMI35RcG1th1J1o8RzR40OS1vVYa00Vph/m8rvuESOYWhjf8DtqsnoUxwkW9atv
	 /6ylsoHR+WHfQrv+nETrl7ktyFdNQySXtjZjkzyGwJ9wKxLjs0MLznyWC6JaGbE1It
	 vGcgThdn+GOUZDt8d8/P/PpbZMjKejkygnNXOK6jma62BylIHmNGpR0z4HTk1pNqRI
	 +htcfWD9XG6vw==
Subject: Re: [PATCH v11 6/6] net: wwan: t9xx: Add AT & MBIM WWAN ports
From: netdev-bot+sashiko@kernel.org
To: jackbb_wu@compal.com
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 wen-zhi.huang@mediatek.com, shi-wei.yeh@mediatek.com,
 Minano.tseng@mediatek.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, robert_yu@compal.com, Jeff_Chang@compal.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-doc@vger.kernel.org
Date: Tue, 10 Nov 2026 11:03:59 +0000
Message-ID: <179430863921.994134.2627836072572850693@kernel.org>
In-Reply-To: <20261105-t9xx_driver_v1-v11-6-2084aa512864@compal.com>
References: <20261105-t9xx_driver_v1-v11-6-2084aa512864@compal.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] This patch makes the header comment on enum mtk_port_status
  (drivers/net/wwan/t9xx/mtk_port.h:39-41) wrong.
- [Low] The new WWAN TX path disagrees with the existing driver about
  what port->tx_mtu means.
- [Low] In mtk_port_enable_by_type() (mtk_port.c:636-655), port->enable
  is consumed and cleared only when FSM_STATE_READY is reached.

--

net: wwan: t9xx: Add AT & MBIM WWAN ports

This commit adds AT and MBIM WWAN port types to the t9xx port
infrastructure. The WWAN ports are created from the FSM READY handler,
and the commit adds start, stop, tx and tx_blocking operations. The tx
path splits each write into CCCI packets, capped at the HIF queue depth,
and reports TX back-pressure through wwan_port_txon()/txoff().

> diff --git a/drivers/net/wwan/t9xx/mtk_port.c b/drivers/net/wwan/t9xx/mtk_port.c
> index 101ec14fc9934..a0defeec9abf8 100644
> --- a/drivers/net/wwan/t9xx/mtk_port.c
> +++ b/drivers/net/wwan/t9xx/mtk_port.c

[ ... ]

> @@ -626,6 +633,27 @@ int mtk_port_ch_disable(struct mtk_port *port)
>  	return ret;
>  }
>  
> +static void mtk_port_enable_by_type(struct mtk_port_mngr *port_mngr, int tbl_type)
> +{
> +	struct radix_tree_iter iter;
> +	struct mtk_port *port;
> +	void __rcu **slot;
> +
> +	radix_tree_for_each_slot(slot, &port_mngr->port_tbl[tbl_type],
> +				 &iter, 0) {
> +		port = mtk_port_tbl_slot(&slot, &iter);
> +		if (!port)
> +			continue;
> +		/* Consumed, so a later boot acts only on what its own port
> +		 * enumeration advertised.
> +		 */
> +		if (port->enable) {
> +			port->enable = false;
> +			mtk_port_get_ops(port->info.type)->enable(port);
> +		}

[Severity: Low]
Can a stale port->enable reach READY here? mtk_port_status_update() only
writes port->enable for channels that appear in the current enumeration:

    port->enable = FIELD_GET(MTK_INFO_FLD_EN, le16_to_cpu(port_info->channel));

Nothing resets the ports that are not listed.

In mtk_fsm_startup_act(), mtk_fsm_parse_hs2_msg() applies the MD port
enumeration first. If a later RTFT entry is malformed, or
mtk_fsm_send_hs3_msg() fails, the code takes hs_err and re-arms the
channel so the modem can retry the handshake:

    ret = mtk_fsm_parse_hs2_msg(fsm, hs_info, skb);
    if (!ret)
        ret = mtk_fsm_send_hs3_msg(hs_info, skb);
    ...
hs_err:
    if (hs_info)
        mtk_pci_unmask_ext_evt(mdev, hs_info->mhccif_ch);

Suppose the retried enumeration leaves out a port that the first one
marked enabled. That port keeps port->enable == true. On READY,
mtk_port_wwan_enable() would then arm its CLDMA1 queue and call
wwan_create_port() for a channel the final enumeration did not advertise.
That goes against the comment above.

This depends on the modem firmware sending a different port list across
handshake retries, so it may not happen in practice. FSM_STATE_OFF is
terminal in this driver, so the handshake retry seems to be the only way
to get here, not a later boot.

Would clearing all port->enable flags before applying a new enumeration
close this gap?

> +	}
> +}

[ ... ]

> diff --git a/drivers/net/wwan/t9xx/mtk_port_io.c b/drivers/net/wwan/t9xx/mtk_port_io.c
> index e92ce1cb7c00f..d5232cb150bff 100644
> --- a/drivers/net/wwan/t9xx/mtk_port_io.c
> +++ b/drivers/net/wwan/t9xx/mtk_port_io.c

[ ... ]

> +static int mtk_port_common_write(struct mtk_port *port, struct sk_buff *src, bool blocking)
> +{
> +	u32 packet_size, left_cnt = src->len, cur_pos;
> +	u32 payload_mtu, sent_len = 0;
> +	struct sk_buff_head list;
> +	bool force_send = false;
> +	struct sk_buff *skb;
> +	int ret;
> +
> +	ret = mtk_port_status_check(port);
> +	if (ret)
> +		return ret;
> +
> +	payload_mtu = port->tx_mtu - sizeof(struct mtk_ccci_header);

[Severity: Low]
Is the CCCI header subtracted twice here? mtk_port_ch_enable() already
removes it from port->tx_mtu:

    port->tx_mtu = trb_open_priv->tx_mtu - MTK_CCCI_H_ELEN;

mtk_port.h documents MTK_CCCI_H_ELEN as:

/* ccci header length + reserved space that is used in exception flow */
#define MTK_CCCI_H_ELEN		(128)

So port->tx_mtu already looks like the payload budget. This code and
caps.frag_len in mtk_port_wwan_enable() both subtract
sizeof(struct mtk_ccci_header) a second time. Each packet then carries
16 bytes less payload: with Q_MTU_3_5K, frag_len is 3440 instead of 3456.

The error is in the safe direction, so nothing overflows. Still, this
math, the "payload budget" comment in mtk_port_wwan_enable(), and the
MTK_CCCI_H_ELEN definition can't all be right. Which meaning of
port->tx_mtu is intended?

> +	if (src->len > MTK_PORT_MAX_TX_PKT * payload_mtu)
> +		return -EMSGSIZE;

[ ... ]

> +static void mtk_port_wwan_enable(struct mtk_port *port)
> +{

[ ... ]

> +	/* These bits must be set before wwan_create_port(): the device node
> +	 * becomes openable inside it and mtk_port_common_open() rejects a
> +	 * port without PORT_S_ENABLE.
> +	 */
> +	set_bit(PORT_S_WR, &port->status);
> +	set_bit(PORT_S_ENABLE, &port->status);

[Severity: Low]
This isn't a functional bug, but does this patch make the comment on enum
mtk_port_status in mtk_port.h inaccurate?

/* State bits, not locks: callers serialise ->enable(), ->disable() and
 * open of a port.  The atomic bitops only make a repeated call a no-op.
 */

For the WWAN ports, open comes from userspace through the WWAN core:
mtk_port_wwan_open() runs under the core's ops_lock. ->enable() and
->disable() come from the FSM through mtk_port_mngr_fsm_state_handler().
Nothing serialises the two paths, and the comment above set_bit()
here expects open to run at the same time as enable.

The open vs. enable and open vs. disable interleavings look safe because
of the w_lock ordering, but the header comment no longer describes how
this works. Could it be updated so later code doesn't count on caller
serialisation that doesn't exist?

> +
> +	wp = wwan_create_port(port_mngr->ctrl_blk->mdev->dev,
> +			      port->w_priv.w_type,
> +			      &wwan_ops, &caps, port);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261105-t9xx_driver_v1-v11-0-2084aa512864%40compal.com
