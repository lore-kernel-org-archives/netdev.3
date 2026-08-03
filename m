Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FC03769F8;
	Mon,  3 Aug 2026 23:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785798874; cv=none; b=h1clydIrU/cYFYrKKMDmxoPfbb/3fKeVec61rMwbxYgEXdRme5TsK2tURqIpFSeYKq5cfVcqDnsoSuX5u60WANEgb5AaniVE7+WHS8zr9KRSe7oSEa9dm14HflZ2fH9RRWdqQOA0aPP3peZTpJVVw9wuMzpvBvfPugcvKuJNEX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785798874; c=relaxed/simple;
	bh=VBqevWXYRSsB3dtPiPFTx1565acpCc0K7Q4lcPUaKFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iXd22ciqBABOOLhcGmStGHzHOQF+xoPvhXheDzeAqkPZItMmFGNzi1TBim6p+CYf/uJ3maXI5Aa0mZcvdrazpTV2IMKEW0jfEcyMEpXVRg7aVe3k8noqoE1ZnneMBmLcBo+H4Gwi2i2M7EwCVoaJIiPnoQ/+NeCZ0uC113to+6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cj2WlhH2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cj2WlhH2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2D81F000E9;
	Mon,  3 Aug 2026 23:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785798869;
	bh=MD/yAV106LHwXRBAWHB+UTcvnPh9U5gA3masZYdFzbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cj2WlhH2wMfz1PzsNsexYkjNmGlSGVARx7qzDVwI5QBgKyL9u46GqEA2RivKHfvwD
	 Xa+gFFKe26IjJWCMmioVegHHTtOWaiTkk10HfhPKJIueUlj7IF0e05E7fbOxIXBkz+
	 YNo181VU3Yq9dXHyk0Gh15nT1ySUU8nOFOqfm4+Al6pwT8LC/VAgy7fC3+fBeUfEa2
	 yMiSfD3P9OZcvT3CEY7WKUiEAdDz9h7sBS/rjnqe2gV60M6SxwqJ4lmSocbHRdKRNH
	 cDAArPhvCvG5kGoMya1Vku5VEuRHmB6YnucP6bpQkTtVfLdlWZdhXlQOE7fadK1yMo
	 iUnueo4TWIqTQ==
From: Jakub Kicinski <kuba@kernel.org>
To: gongfan1@huawei.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	wudi234@huawei.com,
	tengpeisen@huawei.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	ioana.ciornei@nxp.com,
	mohsin.bashr@gmail.com,
	dimitri.daskalakis1@gmail.com,
	hramamurthy@google.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	chenanwen@huawei.com,
	august.hewei@huawei.com,
	luosifu@huawei.com,
	guoxin09@huawei.com,
	zhoushuai28@huawei.com,
	wulike1@huawei.com,
	shijing34@huawei.com,
	zhengjiezhen@h-partners.com,
	maxime.chevallier@bootlin.com
Subject: Re: [PATCH net-next v12 1/8] hinic3: Fix drop skb when skb_checksum_help() fails
Date: Mon,  3 Aug 2026 16:07:43 -0700
Message-ID: <20260803230745.2291141-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <d8091108ba3034f99c08cd8ad620406e7e9395bc.1785120952.git.root@localhost.localdomain>
References: <d8091108ba3034f99c08cd8ad620406e7e9395bc.1785120952.git.root@localhost.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. Larysa is right, this patch
looks like a fix. And there seems to be more bugs in the csum handling
according to AI.
---
> hinic3: Fix drop skb when skb_checksum_help() fails

[Severity: Low]
A couple of things about the changelog itself:

The subject reads a bit garbled ("Fix drop skb when ..."); something like
"hinic3: drop skb when skb_checksum_help() fails" would be easier to parse.
The body also carries a stray two-space indentation on the first line.

There is no Fixes: tag.  git blame on the pre-patch hunk

	skb_checksum_help(skb);
	return 0;

in hinic3_tx_csum() points at 17fcb3dc12bb ("hinic3: module initialization
and tx/rx logic"), so would it make sense to add:

Fixes: 17fcb3dc12bb ("hinic3: module initialization and tx/rx logic")

The body ("Changes hinic3_tx_csum()/hinic3_tx_offload() to propagate
skb_checksum_help() failures into a TX drop.") restates the diff but not the
observable defect.  skb_checksum_help() only sets skb->ip_summed =
CHECKSUM_NONE on its success path (out_set_summed) and jumps to out on every
error, so ip_summed stays CHECKSUM_PARTIAL.  The old code ignored that and
returned 0, so HINIC3_TX_OFFLOAD_CSUM was not set and the frame went out with
just the pseudo-header checksum in place.  Could the changelog describe that
user-visible effect?

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
> index 9306bf0020ca..53c065194136 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
> @@ -261,8 +261,7 @@ static int hinic3_tx_csum(struct hinic3_txq *txq, struct hinic3_sq_task *task,
>  		    ((struct udphdr *)skb_transport_header(skb))->dest !=
>  		    VXLAN_OFFLOAD_PORT_LE) {
>  			/* Unsupported tunnel packet, disable csum offload */
> -			skb_checksum_help(skb);
> -			return 0;
> +			return skb_checksum_help(skb);
>  		}
>  	}

[Severity: High]
This isn't a bug introduced by this patch, since the old code called
skb_checksum_help() in the same place and also kept transmitting, but this
patch reworks exactly this return path so it may be the right place to deal
with it.

On the success side skb_checksum_help() can linearize the skb:

net/core/dev.c:skb_checksum_help() {
	...
	if (skb_has_shared_frag(skb)) {
		ret = __skb_linearize(skb);
		if (ret)
			goto out;
	}
	...
}

__skb_linearize() -> __pskb_pull_tail(skb, skb->data_len) collapses all page
fragments, so skb_shinfo(skb)->nr_frags becomes 0 and 0 is returned, meaning
hinic3_tx_offload() continues on to transmit.

But hinic3_send_one_skb() sampled the fragment count before calling
hinic3_tx_offload():

	num_sge = skb_shinfo(skb)->nr_frags + 1;
	/* assume normal wqe format + 1 wqebb for task info */
	wqebb_cnt = num_sge + 1;
	...
	offload = hinic3_tx_offload(skb, &task, &queue_info, txq);

and then keeps using that stale num_sge for both the WQEBB reservation
(hinic3_set_wqe_combo()) and the descriptor count programmed into the
control word (hinic3_prepare_sq_ctrl() -> SQ_CTRL_SET(nr_descs,
BUFDESC_NUM)), while hinic3_tx_map_skb() only fills BD0 plus a loop over the
now-zero skb_shinfo(skb)->nr_frags.

Can the device then fetch buffer descriptors that were never written on this
pass, i.e. leftover addresses from previously completed and already
dma_unmap'ed WQEs at the same ring slots?  That would mean DMA reads of
stale addresses appended to the frame, or an IOMMU translation fault.

The path looks reachable for a non-GSO CHECKSUM_PARTIAL encapsulated skb
carrying SKBFL_SHARED_FRAG page fragments (MSG_ZEROCOPY / MSG_SPLICE_PAGES /
sendfile) over a tunnel that is not UDP dst port 4789, on a port that
advertises VXLAN offload.

Would recomputing num_sge and wqebb_cnt after hinic3_tx_offload() returns be
the right fix?

>  
> @@ -412,6 +411,10 @@ static u32 hinic3_tx_offload(struct sk_buff *skb, struct hinic3_sq_task *task,
>  		offload |= HINIC3_TX_OFFLOAD_TSO;
>  	} else {
>  		tso_cs_en = hinic3_tx_csum(txq, task, skb);
> +		if (tso_cs_en < 0) {
> +			offload = HINIC3_TX_OFFLOAD_INVALID;
> +			return offload;
> +		}

[Severity: Medium]
Should this new failure path bump a counter?

HINIC3_TX_OFFLOAD_INVALID sends hinic3_send_one_skb() to err_drop_pkt, which
does only:

err_drop_pkt:
	dev_kfree_skb_any(skb);
err_out:
	return NETDEV_TX_OK;

Since NETDEV_TX_OK is returned, the core does not account the drop either,
so the frame disappears with tx_dropped still reading zero in
'ip -s link'.

The driver already declares counters for this class of event in struct
hinic3_txq_stats (dropped, offload_cow_skb_err, unknown_tunnel_pkt), and
hinic3_get_stats64() already exports txq_stats.dropped as
rtnl_link_stats64.tx_dropped, but a grep shows those fields are only cleared
in hinic3_txq_clean_stats() and read back in hinic3_get_stats64() — nothing
ever increments them.

Would incrementing txq->txq_stats.dropped here under the existing
u64_stats_update_begin()/u64_stats_update_end() pair make the drop visible?
The other err_drop_pkt users (hinic3_tso() failure, PLDOFF overflow, DMA map
failure) share the same gap, so only this new site comes from this patch.

>  		if (tso_cs_en)
>  			offload |= HINIC3_TX_OFFLOAD_CSUM;
>  	}
-- 
pw-bot: cr
