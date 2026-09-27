Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177C0346FB5;
	Sun, 27 Sep 2026 22:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790547161; cv=none; b=Wv1pQCPjuLyjpCxlvRh99u2wLDryMLYZ5kU4pp8Dh4GJJ8PgDK9o8BlWSvBXyDNqknzCpae6JcurDAKJRD2uS7C8yPru2sfBBknG0XhAO5esIkn5tr3ABk3dLTsmKFN069SCCdDYlwNclZjYpYSTEFIWz0/le27ikuUoqxWalXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790547161; c=relaxed/simple;
	bh=KosBPrjMQH5NtMST6KKQee/ICzF4jq9FIQox2fW2PWY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gpw1bNTZ3X5F7nAIQ0pQ1Q4nKAH/rFyddsdGPoOGdKzIVoJK5NFXf2/pIumNV7vW85YiX9HIrj6AJnnzw9/89YZuGDWymoXYJhQjSLEXHQFuiJ/BfHrSAe6SyBBi+rqkA603VcI5ll3DrdlQlMXDBJ6KHLV4KY/Gno/w2kYO8H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzQLTmLK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzQLTmLK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7D11F000FF;
	Sun, 27 Sep 2026 22:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790547159;
	bh=4XoGYkDwhzPvXX0AVDCt++12ErmpBCBIfE+6evrUFJI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MzQLTmLKECOvVATgIwTQf7KqCKyi+LfpXjmMhvQ9Mj6KpHf05Mk1m7Fr1jl30ZjrG
	 Smr8F1sd4McK7y9UmSu8Xhpcf6n17p8A4DBOUd1jYOMQKTMoW64NTQ7y/9keY/2dB4
	 t7+nck1juQxX5x8/E91kbfTDXBD4O4jspGVRyXgdAKUpSTaQPdXXCjjVgPXu5BxPaw
	 s6K5N92a8+6T6SQnjRp+E882mpx2ciktamjyX6IyHHooAMGmRJIMs/rfiODwGsobeb
	 4/ereX1Gok0ogdxZSQFzi09KQdyT30mN7tZXbTnDZplBxop9+TsHoWk5EmwsJ3Wqgs
	 e3ilyPb6L4kzw==
Subject: Re: [PATCH net] net: dsa: qca8k: propagate MDIO errors
From: netdev-bot+sashiko@kernel.org
To: yongzhao.derek@gmail.com
Cc: netdev@vger.kernel.org, ansuelsmth@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org
Date: Sun, 27 Sep 2026 22:12:38 +0000
Message-ID: <179054715863.3145.10179961093285192493@kernel.org>
In-Reply-To: <20260923215748.1336-1-yongzhao.derek@gmail.com>
References: <20260923215748.1336-1-yongzhao.derek@gmail.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The Ethernet MDIO read path can still return a timed-out PHY
  transaction as valid register data, so the MII fallback this patch…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the patch
  reworks the code around it.

--

net: dsa: qca8k: propagate MDIO errors

This patch changes qca8k_mii_write32() to return errors from the low and
high half-word writes. Those errors are then propagated through the
regmap and internal MDIO master paths. It also stops the MII busy poll
on read errors, and has the internal MDIO read callback return the real
error instead of 0xffff.

> diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
> index 4c928983b8623..0851e4d65b81c 100644
> --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> +++ b/drivers/net/dsa/qca/qca8k-8xxx.c

[ ... ]

> @@ -836,14 +838,18 @@ qca8k_mdio_write(struct qca8k_priv *priv, int phy, int regnum, u16 data)
>  	if (ret)
>  		goto exit;
>  
> -	qca8k_mii_write32(bus, 0x10 | r2, r1, val);
> +	ret = qca8k_mii_write32(bus, 0x10 | r2, r1, val);
> +	if (ret < 0)
> +		goto exit;
>  
>  	ret = qca8k_mdio_busy_wait(bus, QCA8K_MDIO_MASTER_CTRL,
>  				   QCA8K_MDIO_MASTER_BUSY);
>  
>  exit:
>  	/* even if the busy_wait timeouts try to clear the MASTER_EN */
> -	qca8k_mii_write_hi(bus, 0x10 | r2, r1 + 1, 0);
> +	ret1 = qca8k_mii_write_hi(bus, 0x10 | r2, r1 + 1, 0);
> +	if (!ret)
> +		ret = ret1;

[Severity: Medium]
This problem was not introduced by this patch, but this exit path is
being reworked here. What happens when qca8k_set_page() fails just above?

    ret = qca8k_set_page(priv, page);
    if (ret)
        goto exit;

qca8k_split_addr(QCA8K_MDIO_MASTER_CTRL) gives r1 = 0x1e, r2 = 0 and
page = 0. The cleanup write to phy 0x10, reg 0x1f therefore only hits
MDIO_MASTER_CTRL[31:16] when page 0 is latched in the switch.

qca8k_set_page() returns early when the page matches the cached one. It
only updates the cache after bus->write() succeeds:

    ret = bus->write(bus, 0x18, 0, page);
    if (ret < 0) {
        ...
        return ret;
    }

    *cached_page = page;

So if qca8k_set_page() fails here, the previously selected page P was
not 0.

If the failed page selector write never reached the hardware, could the
cleanup write clear bits [31:16] of an unrelated register at
P * 0x200 + 0x3c?

No master transaction was started on this path, so there is no
MASTER_EN to clear. The result of the stray write (ret1) is also
dropped, because ret is already non-zero.

qca8k_mdio_read() has the same pattern. Could a set_page failure unlock
and return directly, or use a separate label, so that the MASTER_EN
clear only runs after page 0 has been selected?

[ ... ]

> @@ -919,12 +929,7 @@ qca8k_internal_mdio_read(struct mii_bus *slave_bus, int phy, int regnum)
>  	if (ret >= 0)
>  		return ret;
>  
> -	ret = qca8k_mdio_read(priv, phy, regnum);
> -
> -	if (ret < 0)
> -		return 0xffff;
> -
> -	return ret;
> +	return qca8k_mdio_read(priv, phy, regnum);
>  }

[Severity: Medium]
Can the Ethernet leg above still return a timed-out PHY read as valid
data? If so, this corrected fallback would never run.

Suppose every status read in qca8k_phy_eth_command() succeeds
(ret1 == 0), but MASTER_CTRL keeps reporting BUSY for the whole
QCA8K_BUSY_WAIT_TIMEOUT:

    ret = read_poll_timeout(qca8k_phy_eth_busy_wait, ret1,
                            !(val & QCA8K_MDIO_MASTER_BUSY), 0,
                            QCA8K_BUSY_WAIT_TIMEOUT * USEC_PER_MSEC, false,
                            mgmt_eth_data, read_skb, &val);

    if (ret < 0 && ret1 < 0) {
        ret = ret1;
        goto exit;
    }

    if (read) {
        ...
        ret = mgmt_eth_data->data[0] & QCA8K_MDIO_MASTER_DATA_MASK;

Here the -ETIMEDOUT from read_poll_timeout() is ignored. ret is then
overwritten with the data field of a transaction that never completed.
qca8k_internal_mdio_read() sees ret >= 0, returns that value and skips
qca8k_mdio_read().

The commit message says:

    instead of masking them as 0xffff. Returning 0xffff causes PHY
    read-modify-write callers to treat the failed read as valid register
    data, which can corrupt unrelated bits on writeback.

Doesn't the same outcome remain on this Ethernet path? Should the check
after read_poll_timeout() in qca8k_phy_eth_command() also bail out when
ret < 0 and ret1 == 0?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923215748.1336-1-yongzhao.derek%40gmail.com
