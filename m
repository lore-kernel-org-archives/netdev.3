Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327555;
	b=TNXaEqF+VHsjAJlPET9jVTVfqZMOqaFrFMFM/pbL+xlBu+iIIKW1oGPPADUc0bARvsWl
	 vxBU0s+FRfBLUqrYh3olr++kNxo3r4yxQDqDA3lmrJj9BT3TaKtjybfTToHw1ZraaywBn
	 ZQAyRANQPjDXmv/VnzholI/RVVUoitTixQQsn4lNtcgRZ8sfALpsM/a8Zio2GpxvMb9Pg
	 ZS96ezfRbCCjJtvqW/XOcFkF1LBWEDwltLrR6kMWjOfpfJr1nWhFe2WrFsz97/nYWWGSZ
	 ANjq0Jh3OU0F5FWGiRB7OUDzLzxOwIW7e17pYZPRJZ2TtG5k3qSu4YXceazKlyYK7pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327555;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=q7HjRmi7XdKy/SNRGrukOlv31d12fQ/iW1Kt/6C2fdM=;
	b=5FQsHfykdkYY8zjzRG1nob3nkg403B4BqXSVMxHK9e1IJ3pXDBRmcpNTdc13XnyMOjCU
	 PuV8HMd+r8LhgHNN6Iljw82a+p929DYQEPuR9AWTuQM/xNzzYFnuW6c5PE496dHHZKU+h
	 7pYpyhodQavKzYxw1wPEIrQoOwlOhWiCxmb3zrTcf69CQ9yBXEpmeKDGdNCSpYiWJZkeh
	 VYujT+pJQ9qiN8T3KbSYZWgbm2Ev3FPGJhpsq5oh+2WtXeJESdKeAliu41ehmelfoxW1h
	 ixjTFw+pTe3A+HVHJ/iNqx5R3MOB9RwdsrgHZhTPAx6XtEpzs6tlJ1CMeDYN54Otc2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bq737qz9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68868606A32D;
	Tue, 10 Nov 2026 16:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bq737qz9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8F51F008A1;
	Tue, 10 Nov 2026 16:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327555;
	bh=q7HjRmi7XdKy/SNRGrukOlv31d12fQ/iW1Kt/6C2fdM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bq737qz9IyKMof3byxda/R5ZedFO89YVYSOou3iVMv390cdrOEqDNg/hYRjWtf2n2
	 5HRfqTLUsgrreXi9bdC+QyzqYRJ7LhazjQzWzTLyxW+X91zu8eappvjt6boJNYLJRu
	 y672uieKr/ajWtg7OXEZpdCXteGQF39nOk0dv1uIei0Q3hcKXkJaXaazQawQDYw4Bu
	 zkKk7IxinAD56itK2sDYfv2UKZL9lzCE8iNF0Le4rkOypjtIF2xxR6LZidz3G/QINU
	 kXZt+b9x4mC45W+/3aAXYdyjVZU30vIXOvGsg99206OXJzDiBbBQ7NctvmUm7oZUof
	 93J3ES2TyumgQ==
Subject: Re: [PATCH net-next v6 04/10] bnge: add RXFH ethtool support
From: netdev-bot+sashiko@kernel.org
To: vikas.gupta@broadcom.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com,
 dharmender.garg@broadcom.com, ajit.khaparde@broadcom.com
Date: Tue, 10 Nov 2026 16:19:13 +0000
Message-ID: <179432755388.994134.9789036024798595217@kernel.org>
In-Reply-To: <20261106093524.838341-5-vikas.gupta@broadcom.com>
References: <20261106093524.838341-5-vikas.gupta@broadcom.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch adds bnge_set_rxfh_fields() (bnge_ethtool.c:856),
  which lets userspace change bd->rss_hash_cfg while the interface is…

--

bnge: add RXFH ethtool support

This commit adds ethtool RXFH operations to bnge for reading and
programming the RSS hash key, indirection table and hash fields. The set
operations are only allowed while the device is down. It also changes the
default RSS key to the system-wide netdev_rss_key_fill() key.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
> index 2467e44de291a..878fe4888160f 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c

[ ... ]

> +static int bnge_set_rxfh_fields(struct net_device *dev,
> +				const struct ethtool_rxfh_fields *cmd,
> +				struct netlink_ext_ack *extack)
> +{

[ ... ]

> +	if (bd->rss_hash_cfg == rss_hash_cfg)
> +		return 0;
> +
> +	if (netif_running(dev)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "RSS configuration can only be changed while the interface is down");
> +		return -EBUSY;
> +	}
> +
> +	bd->rss_hash_cfg = rss_hash_cfg;
> +
> +	return 0;

[Severity: Medium]
Could the hash fields set here be silently replaced at the next open on
firmware that advertises BNGE_RSS_CAP_RSS_HASH_TYPE_DELTA?

The new value is only stored in bd->rss_hash_cfg and 0 is returned at
once. Firmware first sees it on open, via
bnge_open_core()->bnge_init_chip()->bnge_setup_vnic()->
bnge_hwrm_vnic_set_rss(). That path always sends the full state, with no
INCLUDE/EXCLUDE flag:

drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c:__bnge_hwrm_vnic_set_rss() {
    ...
	req->hash_type = cpu_to_le32(bd->rss_hash_cfg);
    ...
}

Right after that, bnge_init_chip() reads the value back from firmware and
writes it over the stored one:

drivers/net/ethernet/broadcom/bnge/bnge_netdev.c:bnge_init_chip() {
    ...
	if (bd->rss_cap & BNGE_RSS_CAP_RSS_HASH_TYPE_DELTA)
		bnge_hwrm_update_rss_hash_cfg(bn);
    ...
}

drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c:bnge_hwrm_update_rss_hash_cfg() {
    ...
	if (!bnge_hwrm_req_send(bd, req))
		bd->rss_hash_cfg =
			le32_to_cpu(resp->hash_type) ?: bd->rss_hash_cfg;
    ...
}

bnxt uses the same HWRM interface, and it switches to delta semantics
whenever this capability is set:

  bnxt_set_dflt_rss_hash_type() sets rss_hash_delta = rss_hash_cfg
  bnxt_set_rxfh_fields() sets rss_hash_delta = old ^ new
  __bnxt_hwrm_vnic_set_rss() sends HASH_TYPE_INCLUDE/EXCLUDE

If DELTA-mode firmware does not apply a plain full-state hash_type as
requested, would the user's "ethtool -N <dev> rx-flow-hash ..." setting
be dropped at the next "ip link set up"? In that case there is no error
or extack warning, and bd->rss_hash_cfg quietly takes on firmware's
value.

Before this patch the full-state send and the readback already existed,
but nothing user-driven changed rss_hash_cfg. Later patches in the series
don't seem to add INCLUDE/EXCLUDE handling or a check of the readback
against the requested value.

Should __bnge_hwrm_vnic_set_rss() use INCLUDE/EXCLUDE when
BNGE_RSS_CAP_RSS_HASH_TYPE_DELTA is set? Alternatively, should the
readback be checked against the requested configuration?

> +
> +err_l3_shared:
> +	NL_SET_ERR_MSG_MOD(extack,
> +			   "2-tuple hashing is shared by all flows of an IP version, use ip4/ip6 to disable it");
> +	return -EINVAL;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106093524.838341-1-vikas.gupta%40broadcom.com
