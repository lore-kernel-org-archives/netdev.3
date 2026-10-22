Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792663925;
	b=Ho4DJX2lol3oBM4FoZHtKsLvthV+Vw29npww8WYzG26d8UsvxSaGLc4Jwq0EeDCLkFeY
	 6DuqeOo+9q1y7SREmjt05fMpxvbMmKKFJBS7INS5JsVYQaC7OfOLsiOBdfWJ0sQs/jgP0
	 cV15D0WbD2nXRHUNX+MV4gJC7Ffg18iZ4zlQszCEaDKv3zOTVnGWjsT43ZGi9Y89qE3B6
	 oIkCa/9Un3CtBt/jN3cz/HFF0vodV93oJz9hpSSKS7G8Y9/BuWnhZUd9ExySn4j8MzThM
	 CgOkA8hu7Dysl2YzQAui3bNKVozsXhSHhP29SxAqrwSunf7vT0htKfF/fcIvv+UDqrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792663925;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=z3F9JHf6trC/pIG5RHIb3Go9hOw8hqDLDOYVKeUN8WE=;
	b=A2SnIJDNhNGr2XS6U0x/uQnFmq3T360nYtoEvJFgz+4yDMEA3WvheRSex6BOlb8gm91y
	 RMrXlBk0DM/XnPfKxuCLzt6ZnNzW+daPPJ5yQfPychVOie7SFPEoOpiCFS5PgB8J9aLiC
	 yXVDjfqxMSDnSOrEEUiRzDjI3UO+ZBxvTkT+cr9oHTw0j5NCJxO+qGxoWID/P3h5nAJ8e
	 o+m2ofSrgl4FeLOUldBfoCkVVk+lMPeEzuQHfaFNA2IMeRaooHnpMLUABZHo/FCyNRUkC
	 rRkY19sU7bnGGuFpdNqAs65Mk1OvAM0GoIJrgv9GrJWdQKlMr2+awWoRtmVNeyHJX7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NvzyuT82;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30882606A31B;
	Thu, 22 Oct 2026 10:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NvzyuT82
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0481F000C1;
	Thu, 22 Oct 2026 10:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792663924;
	bh=z3F9JHf6trC/pIG5RHIb3Go9hOw8hqDLDOYVKeUN8WE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NvzyuT82/Xh39fzbJ3PhI7eayAc9ul1e3vzJ10PVoeOiPJQLzftsimJwReMDlTis8
	 R4jtVZLYSdcbhjj0fG8T1ubIiRZwu+ZE+TmVJltC4tY2PXpubTjdK8hmaxFEZFOf1g
	 Tob2anglNxDypcs5yB/eLb7Z5Au53k3hcPh9qUYdej5x9T9CFtz0IDHrKsROKV4/NX
	 Nec7egAF+dGL2BTJxB7opTpnhLap/YFrolpfk9t0ZKxhh0i7ZURF/3qwU15HbjY8de
	 m6L2GF5RJaXY7qexM92WUBsTTo5ab2vBkismbQZ4H604OEjhHhASKYnVvGvfJYcjwi
	 9wg/Cc7NyIdrw==
Subject:
 Re: [PATCH net-next v2 1/2] net: dsa: qca8k: serialize register access
From: netdev-bot+sashiko@kernel.org
To: kuncy7@gmail.com
Cc: ansuelsmth@gmail.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 22 Oct 2026 10:12:03 +0000
Message-ID: <179266392377.3135.12848522239467347386@kernel.org>
In-Reply-To: <20261019191137.307514-2-kuncy7@gmail.com>
References: <20261019191137.307514-2-kuncy7@gmail.com>
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

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch fixes a regmap work_buf race that already exists in
  released kernels, but it has no Fixes: tag and no stable Cc.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is a high-
  severity bug the series builds on.

--

net: dsa: qca8k: serialize register access

This patch drops .disable_locking from the qca8k regmap config, so regmap
serializes use of its shared work_buf. It also swaps the order in which
qca8k_conduit_change() takes the MIB and management mutexes, so the order
matches the autocast path.

> diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
> index 07227ae8bc04..9a8b9e34a27c 100644
> --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
> @@ -579,7 +579,6 @@ static const struct regmap_config qca8k_regmap_config = {
>  	.write = qca8k_bulk_write,
>  	.reg_update_bits = qca8k_regmap_update_bits,
>  	.rd_table = &qca8k_readable_table,
> -	.disable_locking = true, /* Locking is handled by qca8k read/write */

[Severity: Medium]
The work_buf race described in the commit message is already in released
kernels. Should this patch carry a Fixes: tag and go to net, not ride
along as groundwork for the MIB stats change?

The race seems to come from commit c766e077d927 ("net: dsa: qca8k: convert
to regmap read/write API"). Before that commit, qca8k_regmap_config used
.reg_read/.reg_write. In that case __regmap_init() skips format
initialization and work_buf is never used, so .disable_locking was safe
then.

c766e077d927 switched to .read = qca8k_bulk_read and .write =
qca8k_bulk_write but kept .disable_locking. In __regmap_init(), this
branch:

    if (config->read && config->write) {
        map->reg_read  = _regmap_bus_read;

routes reads and writes through the formatted path. That path writes the
register (and value) into the shared map->work_buf and then passes it to
the driver callbacks.

Callers outside rtnl can already hit this without the MIB work this
series adds. One path is per-port phylink resolve work:

    phylink_resolve()
      qca8k_phylink_mac_link_up()
        qca8k_write(priv, QCA8K_REG_PORT_STATUS(port), reg)
          regmap_write()

Another is the LED class callbacks, such as regmap_read() in
qca8k_cled_hw_control_get(). Both can run concurrently and end up writing
the wrong switch register or returning the wrong value.

Would something like this be appropriate?

Fixes: c766e077d927 ("net: dsa: qca8k: convert to regmap read/write API")

That would let stable kernels since v6.3 pick up the regmap part.

>  	.cache_type = REGCACHE_NONE, /* Explicitly disable CACHE */
>  	.max_raw_read = 32, /* mgmt eth can read up to 8 registers at time */
>  	/* ATU regs suffer from a bug where some data are not correctly
> @@ -1782,13 +1781,16 @@ qca8k_conduit_change(struct dsa_switch *ds, const struct net_device *conduit,
>  	if (dp->index != 0)
>  		return;
>  
> -	mutex_lock(&priv->mgmt_eth_data.mutex);
> +	/* Same order as an autocast, which holds the MIB mutex while its
> +	 * register write takes the management one.
> +	 */
>  	mutex_lock(&priv->mib_eth_data.mutex);
> +	mutex_lock(&priv->mgmt_eth_data.mutex);

[Severity: High]
This is a pre-existing issue, not one introduced by this patch, but the
series builds on the autocast path, so it seems worth raising here.

qca8k_get_ethtool_stats_eth() publishes the caller's ethtool buffer and
then waits with a short timeout:

    mib_eth_data->req_port = dp->index;
    mib_eth_data->data = data;
    refcount_set(&mib_eth_data->port_parsed, QCA8K_NUM_PORTS);
    ...
    ret = wait_for_completion_timeout(&mib_eth_data->rw_done, QCA8K_ETHERNET_TIMEOUT);

exit:
    mutex_unlock(&mib_eth_data->mutex);

QCA8K_ETHERNET_TIMEOUT is msecs_to_jiffies(5), which can be a single
jiffy. On timeout, mib_eth_data->data and ->req_port are left pointing at
the buffer. ethtool_get_stats() then vfree()s that buffer once
qca8k_get_ethtool_stats() returns.

qca8k_mib_autocast_handler() runs in conduit rx softirq context with no
lock and no check that a request is still pending:

    port = FIELD_GET(QCA_HDR_RECV_SOURCE_PORT, ntohs(mib_ethhdr->hdr));
    if (port != mib_eth_data->req_port)
        goto exit;
    ...
        mib_eth_data->data[i] = get_unaligned_le32(mib_ethhdr->data + i);

If the MIB frames arrive late, for example because conduit rx is delayed,
can the frame for req_port write into the vfree'd buffer from softirq?
ETHTOOL_GSTATS does not need CAP_NET_ADMIN, so the request side can be
triggered by an unprivileged user.

The exit path also runs for every frame:

exit:
    if (refcount_dec_and_test(&mib_eth_data->port_parsed))
        complete(&mib_eth_data->rw_done);

Can stale frames underflow port_parsed after it has already reached 0?
That would trigger a refcount WARN.

If a stale frame lands after the next request's refcount_set(), can it
also complete that request early with partly stale counters?

Separately, qca_tag_rcv() only does pskb_may_pull(skb, QCA_HDR_LEN) before
it dispatches to this handler. The handler then reads mib_count counters
from skb->data without checking skb->len. Can a short MIB-type frame cause
an out-of-bounds read here?

The later patch in this series, "net: dsa: qca8k: report port statistics
from the MIB", keeps the lockless handler. It adds a periodic autocast and
a QCA8K_MIB_ALL_PORTS mode that indexes mib_eth_data->data +
port * QCA8K_QCA833X_MIB_COUNT. Doesn't that make timed-out requests and
late frames more frequent?

>  
>  	priv->mgmt_conduit = operational ? (struct net_device *)conduit : NULL;
>  
> -	mutex_unlock(&priv->mib_eth_data.mutex);
>  	mutex_unlock(&priv->mgmt_eth_data.mutex);
> +	mutex_unlock(&priv->mib_eth_data.mutex);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019191137.307514-1-kuncy7%40gmail.com
