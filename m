Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17B23EF67D;
	Mon, 20 Jul 2026 23:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784590648; cv=none; b=gBmlrMZL0lyPddySGb8OFvJTR8Bo1EBfPKgXBIyBcbb0cYSxbeI9trp2IBOQqQFg6a8n77xy97mog8o4gbGzAaC2f+vTxBx2Zez2vnssoaEAOcEVL1EIjFzc3auj4IeegeBiOWTCCzRjMojxrEl/TQPdIoVNa1K4WOovdZ/wS5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784590648; c=relaxed/simple;
	bh=WXRldwChHYO5dRo4rLY2M8GHYoEvnr84xfitp+WXzTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MklC/JxIzdI8kD/TXIAVnfOY43sC07hcc4B4I689/cvxFqcwcIIsWoDBObF8kANRFN0OAQLx3g9C+FIX3v9dizpLX7J1j0MiT9ExNPuN7nvhI9wZzn7sxq9lMTnUod8wRgxI+Eppfhmr9SapWTPS0lhmu6sd9IN+xr87DFsWuFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzA7Yy9c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzA7Yy9c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EB61F000E9;
	Mon, 20 Jul 2026 23:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784590646;
	bh=lwOICG5i0pW3uN/3H1HBjIcrWrprzrVeHaysqFw9ans=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TzA7Yy9cdbf4Xblvq+ahyanYkY/dNfjmAQ29pqN4rOpv1sC4JRncNFrrkvXyWm8iv
	 7gi3fK2834PH53JrpJcCQdGwCR9c2GjyApKQPm5kLN24/EYYTT5fHEiA10/8SWEpKP
	 OZ0dPoZaM3wmEuDdLbsFpVpjIYZI40Bk4+LtC0fcf8VX5HoDeMi00BVlYiveLZ+LFZ
	 xWhfCKDe1iUor7ySnI1PmWu+ymzZwOvUy/1Ypbd9NazGEPVVXhH6cpR+C40UMlO47p
	 YkCpKPwfwkqsU1AMItydppMXqzQI3rcqW9AIM+iT85h0BGPdfQTx1SWXWIcN54hV+K
	 cmFT5qcR+tjEg==
From: Jakub Kicinski <kuba@kernel.org>
To: lukeh@padl.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	vivien.didelot@gmail.com,
	gregory.clement@bootlin.com,
	andrew@lunn.ch,
	horms@kernel.org,
	f.fainelli@gmail.com,
	tobias@waldekranz.com,
	cedric.jehasse@gmail.com,
	kieran@sienda.com,
	mh@rme-audio.de,
	max@huntershome.org,
	christoph.mellauner@joyned.at,
	simon.gapp@gapp-audio.com,
	Ryan.Wilkins@telosalliance.com,
	mattias.forsblad@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 07/12] net: dsa: qca8k: Pass error code from reply decoder to requester
Date: Mon, 20 Jul 2026 16:37:24 -0700
Message-ID: <20260720233725.444651-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703-net-next-dsa-rmu-v1-7-a03febf20bb4@padl.com>
References: <20260703-net-next-dsa-rmu-v1-7-a03febf20bb4@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: qca8k: Pass error code from reply decoder to requester

This patch changes dsa_inband_complete() to accept a response buffer and
error code, and updates dsa_inband_request() to return that error code to
the caller. The qca8k driver call sites are updated to pass response
buffers through the new API and to use the returned status directly.

> diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
> index 499cc8ef5dde..ffa3b1ba23be 100644
> --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
> @@ -167,6 +167,8 @@ static void qca8k_rw_reg_ack_handler(struct dsa_switch *ds, struct sk_buff *skb)
>  	struct qca_mgmt_ethhdr *mgmt_ethhdr;
>  	u32 command;
>  	u8 len, cmd;
> +	u32 data[4];
> +	int err = 0;
>  	int i;
>  
>  	mgmt_ethhdr = (struct qca_mgmt_ethhdr *)skb_mac_header(skb);
> @@ -191,7 +193,7 @@ static void qca8k_rw_reg_ack_handler(struct dsa_switch *ds, struct sk_buff *skb)
>  		return;
>  
>  	if (cmd == MDIO_READ) {
> -		u32 *val = mgmt_eth_data->data;
> +		u32 *val = &data[0];
>  
>  		*val = get_unaligned_le32(&mgmt_ethhdr->mdio_data);

[High]
Can the decode loop overflow the on-stack data[4] buffer? The wire-supplied
length in QCA_HDR_MGMT_LENGTH is a 4-bit field with a maximum value of 15;
after this block in qca8k_rw_reg_ack_handler():

    if (len == 15)
        len++;
    len *= sizeof(u16);

len can reach 32. Later the copy loop uses:

    data_len = min_t(int, QCA_HDR_MGMT_DATA2_LEN /* 28 */,
                     len - QCA_HDR_MGMT_DATA1_LEN /* 4 */);
    ...
    for (i = sizeof(u32); i <= data_len; i += sizeof(u32)) {
        *val = get_unaligned_le32(data2);
        val++;
        data2++;
    }

which writes val[1]..val[7] (28 bytes past *val), overrunning the 16-byte
u32 data[4] destination. This overflow existed in the previous storage
(mgmt_eth_data->data[4] on the heap) and this patch relocates the sink onto
the softirq call stack, where the overrun can clobber saved registers or
the return address. The driver advertises .max_raw_read = 32 through its
regmap, so a legitimate 32-byte bulk read is sufficient to reach this
path; a malformed reply is not required. Should the ack handler bound the
decode to sizeof(data)?

> @@ -213,7 +215,7 @@ static void qca8k_rw_reg_ack_handler(struct dsa_switch *ds, struct sk_buff *skb)
>  		}
>  	}
>  
> -	dsa_inband_complete(&mgmt_eth_data->inband);
> +	dsa_inband_complete(&mgmt_eth_data->inband, &data, sizeof(data), err);
>  }
>  
>  static struct sk_buff *qca8k_alloc_mdio_header(enum mdio_cmd cmd, u32 reg, u32 *val,
> @@ -314,7 +316,7 @@ static int qca8k_read_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
>  {
>  	struct qca8k_mgmt_eth_data *mgmt_eth_data = &priv->mgmt_eth_data;
>  	struct sk_buff *skb;
> -	int err;
> +	u32 data[4];
>  	int ret;
>  
>  	skb = qca8k_alloc_mdio_header(MDIO_READ, reg, NULL,
> @@ -335,30 +337,25 @@ static int qca8k_read_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
>  
>  	ret = dsa_inband_request(&mgmt_eth_data->inband, skb,
>  				 qca8k_mdio_header_fill_seq_num,
> +				 data, sizeof(data),
>  				 QCA8K_ETHERNET_TIMEOUT);
> +	if (ret < 0)
> +		goto out;
>  
> -	*val = mgmt_eth_data->data[0];
> +	*val = data[0];
>  	if (len > QCA_HDR_MGMT_DATA1_LEN)
> -		memcpy(val + 1, mgmt_eth_data->data + 1, len - QCA_HDR_MGMT_DATA1_LEN);
> -
> -	err = mgmt_eth_data->err;
> +		memcpy(val + 1, &data[1], len - QCA_HDR_MGMT_DATA1_LEN);
>  
> +out:
>  	mutex_unlock(&mgmt_eth_data->mutex);
>  
> -	if (ret)
> -		return ret;
> -
> -	if (err)
> -		return err;
> -
> -	return 0;
> +	return ret;
>  }

[Critical]
Does qca8k_read_eth() now return a positive value on success? Looking at
dsa_inband_complete() and dsa_inband_request() in net/dsa/dsa.c after this
patch:

net/dsa/dsa.c:dsa_inband_complete() {
    ...
    if (!err) {
        spin_lock_bh(&inband->resp_lock);
        resp_len = min(inband->resp_len, resp_len);
        if (inband->resp && resp)
            memcpy(inband->resp, resp, resp_len);
        spin_unlock_bh(&inband->resp_lock);
        inband->err = resp_len;
    }
    ...
}

net/dsa/dsa.c:dsa_inband_request() {
    ...
    return inband->err;
}

so a successful read returns sizeof(data) = 16, not 0. qca8k_read_eth()
propagates that positive value to its callers, but qca8k_regmap_update_bits_eth()
still uses:

    ret = qca8k_read_eth(priv, reg, &val, sizeof(val));
    if (ret)
        return ret;

and qca8k_bulk_read() uses:

    if (priv->mgmt_conduit && !qca8k_read_eth(...))
        return 0;

Would qca8k_regmap_update_bits_eth() then return 16 as an error to regmap,
and would qca8k_bulk_read() unconditionally fall through to the MII path
even after a successful ethernet read?

>  static int qca8k_write_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
>  {

[ ... ]

> @@ -573,7 +563,7 @@ qca8k_phy_eth_busy_wait(struct qca8k_mgmt_eth_data *mgmt_eth_data,
>  			struct sk_buff *read_skb, u32 *val)
>  {
>  	struct sk_buff *skb = skb_copy(read_skb, GFP_KERNEL);
> -	int err;
> +	u32 data[4];
>  	int ret;
>  
>  	if (!skb)
> @@ -581,17 +571,13 @@ qca8k_phy_eth_busy_wait(struct qca8k_mgmt_eth_data *mgmt_eth_data,
>  
>  	ret = dsa_inband_request(&mgmt_eth_data->inband, skb,
>  				 qca8k_mdio_header_fill_seq_num,
> +				 data, sizeof(data),
>  				 QCA8K_ETHERNET_TIMEOUT);
>  
> -	err = mgmt_eth_data->err;
> -
>  	if (ret)
>  		return ret;
>  
> -	if (err)
> -		return err;
> -
> -	*val = mgmt_eth_data->data[0];
> +	*val = data[0];
>  
>  	return 0;
>  }

[Critical]
With the new positive-on-success return from dsa_inband_request(), does
qca8k_phy_eth_busy_wait() now return before writing *val on every
successful transfer?

    ret = dsa_inband_request(..., data, sizeof(data), ...);
    if (ret)
        return ret;
    *val = data[0];

ret is 16 on success, so the function returns without touching *val. The
caller in qca8k_phy_eth_command() then feeds an uninitialised local into
read_poll_timeout():

drivers/net/dsa/qca/qca8k-8xxx.c:qca8k_phy_eth_command() {
    ...
    u32 write_val, clear_val = 0, val;
    ...
    ret = read_poll_timeout(qca8k_phy_eth_busy_wait, ret1,
                            !(val & QCA8K_MDIO_MASTER_BUSY), 0,
                            QCA8K_BUSY_WAIT_TIMEOUT * USEC_PER_MSEC, false,
                            mgmt_eth_data, read_skb, &val);
    ...
}

Does the busy-wait loop then read val uninitialised on the first
iteration?

> @@ -604,8 +590,8 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
>  	struct qca8k_mgmt_eth_data *mgmt_eth_data;
>  	u32 write_val, clear_val = 0, val;
>  	struct net_device *mgmt_conduit;
> +	u32 resp_data[4];
>  	int ret, ret1;
> -	int err;
>  
>  	if (regnum >= QCA8K_MDIO_MASTER_MAX_REG)
>  		return -EINVAL;

[ ... ]

> @@ -703,19 +682,13 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
>  	if (read) {
>  		ret = dsa_inband_request(&mgmt_eth_data->inband, read_skb,
>  					 qca8k_mdio_header_fill_seq_num,
> +					 resp_data, sizeof(resp_data),
>  					 QCA8K_ETHERNET_TIMEOUT);
>  
> -		err = mgmt_eth_data->err;
> -
>  		if (ret)
>  			goto exit;
>  
> -		if (err) {
> -			ret = err;
> -			goto exit;
> -		}
> -
> -		ret = mgmt_eth_data->data[0] & QCA8K_MDIO_MASTER_DATA_MASK;
> +		ret = resp_data[0] & QCA8K_MDIO_MASTER_DATA_MASK;
>  	} else {
>  		kfree_skb(read_skb);
>  	}

[Critical]
In this read branch dsa_inband_request() returns 16 on a successful
response, so if (ret) goto exit; fires and the code never reaches:

    ret = resp_data[0] & QCA8K_MDIO_MASTER_DATA_MASK;

qca8k_phy_eth_command() therefore returns 16 (0x10) for every successful
internal PHY read via the ethernet fast path. Is this the intended
behaviour, given that the value is propagated as the register contents up
through qca8k_internal_mdio_read() and qca8k_mdio_read()?

The follow-up commit dacfa5deb518 ("net: dsa: qca8k: Update error
handling") converts each of these if (ret) checks to if (ret < 0) and
adds an explicit ret = 0; in qca8k_read_eth(). Would folding those changes
into this commit make the series bisectable, since between these two
commits every ethernet-fast-path MDIO read returns 16 and
qca8k_phy_eth_busy_wait() leaves its output argument uninitialised?
