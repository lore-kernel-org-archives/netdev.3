Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793359708;
	b=VgeFZvIrksWjVF0juD0amB7S4EB2V/04pXZqDowRov6h3henVpn4D3vKqtC/94D8OGsa
	 Tqf3YQCHQccKjxee5HiFhd3clLTwnoM0GzKneuY+ox48LE66FpCQ9ImxkiKKREq367e7R
	 sj89i4W/0W7JZxkgYmYrrZ/lfTMJn8emgR6LF+tttglT83lgo7owdtzxj8TASSJ9i0L5+
	 ipIpnsdV+pZx2Og5Frdwkgx/nxJwCjHFTVSxDrD9j38NEtSvQKyjbcn7hpblI4HtulsCC
	 rw+aOxb5Pgio2dWAt9L+QFg5Mbnn6yzN2NtN74OZNNZ00o0kV/pf8Y/QC4/MAiwDrOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793359708;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=6nKRA7VpnTg8LL6hJs+2zVnoEpbZxXVRw/cjVV+gHvk=;
	b=U7E1B+fPnzDarD4DeRmm8LN00H39V0NssFzOLAJodnzR6Dc+cmR0tZouUvQEXbpF9S6o
	 KLLZCFcewByeLo+DtRV3imOsOgFziEausTj4nNCd/B0aOGZxR9qIQpHvLxXHfUjuBjmvc
	 LorrDf4GLVZgU8wMyXFKv5ax6QmCpRZZHaCbA2FOaoi/9mpGrgrHDjRjUabXaYOZVurbJ
	 OJEUZP+gWOAjLuItbODw4G/Dyvpc2JPkXvyWzYniiYeR+XLVI7E7Ll7fvfjWPxEy7fbMS
	 N4qMHNAHm95nVzwB1XK/J63UZgAW0cfL3tAQ6/H3UdFYQZUuiRPdxbqomlQZkpYLTlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RweMM4tD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C70606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RweMM4tD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF65F1F000C1;
	Fri, 30 Oct 2026 11:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793359708;
	bh=6nKRA7VpnTg8LL6hJs+2zVnoEpbZxXVRw/cjVV+gHvk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RweMM4tDQjV/Erw0poTC2PhsTdpM9AL6Pwm+fh29amy6jyCtYtQjLCLfrANoC7o7V
	 IZMI/aRmQiTjpukvXoTMcXmBLE7aUQCDEu6cUfKRQO/RJRs09L8KUqC6RqIRdOb2wB
	 M05d3cxg1bYFPtbuBursLcWoasgltSl4+hVl35JLDe7+ty3110Cpe/wsELWKKp3F/y
	 WQ9TSUlU06oYgCoeqvSn199aU6a1vtpJmdQVcS4l7pTnaHsk8xdDY0PP6t35XtJlhO
	 2xkrPsl+xqi8r8hu28aj8JXaO08G+Px0EvdHdUgrA3ln53U8a1Zn5kdUOFWulhmvpN
	 x3bJDEG0ngoRQ==
Subject: Re: [PATCH net v3 1/2] net: dsa: mxl862xx: bound FDB dump walk with a
 read limit
From: netdev-bot+sashiko@kernel.org
To: memoriaru@foxmail.com
Cc: netdev@vger.kernel.org, daniel@makrotopia.org, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, johan@kernel.org, kuba@kernel.org,
 pabeni@redhat.com
Date: Fri, 30 Oct 2026 11:28:27 +0000
Message-ID: <179335970748.3134.15827650378445276832@kernel.org>
In-Reply-To: <tencent_1AD6B5B7C296D319F828A281A2A65B95D609@qq.com>
References: <tencent_1AD6B5B7C296D319F828A281A2A65B95D609@qq.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch says it stops mxl862xx_port_fdb_dump() from "walking
  forever with RTNL held".

Pre-existing issues:
- [Low] The kernel-doc for struct mxl862xx_mac_table_read
  (drivers/net/dsa/mxl862xx/mxl862xx-api.h:120) says "@last: Indicates…

--

I found two possible regressions in this patch.

1. (Medium) The 16384-read cap is finite, but each read is a full mailbox exchange done under RTNL. rtnl_fdb_dump() ignores the -EIO, so the long walk is repeated once for every user port.
2. (Low, pre-existing) The kernel-doc for @last says the last=1 response carries an entry, but the code throws that response away. The new comment follows the code's reading.

The draft reply:

net: dsa: mxl862xx: bound FDB dump walk with a read limit

This patch caps the MAC table walk in mxl862xx_port_fdb_dump() at
MXL862XX_MAC_TABLE_WALK_LIMIT (16384) reads. Past that limit it returns
-EIO, so a device that never sets the last flag can no longer keep the
loop running forever with RTNL held. The limit is checked after the last
test so that a correctly ended walk of a full table is not rejected.

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
> index e05ad52cd297e..37e8c18f14f33 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx.c
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx.c

[ ... ]

> @@ -1513,6 +1519,22 @@ static int mxl862xx_port_fdb_dump(struct dsa_switch *ds, int port,
>  		if (param.last)
>  			break;
>  
> +		/* The exact MAC table capacity is not part of the public
> +		 * driver API. Use a conservative read limit: 16k is well
> +		 * above any documented table size for this family, while a
> +		 * device that never sets last (or keeps answering with
> +		 * entries for other ports, which never reach the callback)
> +		 * would otherwise keep us walking forever with RTNL held.
> +		 * Checked after the "last" test so that a correctly ended
> +		 * walk of a full table is not rejected.
> +		 */

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch. The
new comment does rely on it, though.

The kernel-doc for struct mxl862xx_mac_table_read in mxl862xx-api.h
says:

 * @last: Indicates that the read operation returned last entry

Read literally, the response with last=1 still carries a valid final
entry. mxl862xx_port_fdb_dump() breaks on param.last before it looks at
port_id, mac or tci, so that payload is thrown away.

The new comment and the commit message ("the walk needs one read more
than the number of entries it reports") assume that the last=1 response
is an empty end marker.

Which reading matches the firmware? If the kernel-doc is right, every
dump drops one entry and the placement of the limit check is off by one.
If the code is right, could the kernel-doc be updated to say that last=1
means no valid entry was returned?

> +		if (count++ >= MXL862XX_MAC_TABLE_WALK_LIMIT) {
> +			dev_err(ds->dev,
> +				"FDB dump walk exceeded %d reads, aborting\n",
> +				MXL862XX_MAC_TABLE_WALK_LIMIT);
> +			return -EIO;
> +		}
> +

[Severity: Medium]
Does this limit really keep the RTNL hold time bounded in practice for a
device that never sets last?

Each iteration is a full MXL862XX_MAC_TABLEENTRYREAD mailbox exchange
in mxl862xx_api_wrap(). The 53-byte struct mxl862xx_mac_table_read
moves 27 data words plus a CRC word, so after the first iteration one
read costs roughly:

mxl862xx_api_wrap()
    mxl862xx_busy_wait()
    mxl862xx_rst_data()          /* 2 writes, busy-wait, 2 reads */
    CRC word write
    mxl862xx_send_cmd()          /* 2 writes, busy-wait, 2 reads */
    mxl862xx_reg_read() x 28

That is about 40 Clause-45 accesses and three busy-waits per read. At a
typical 2.5 MHz MDC this is about 2-3 ms per read, or roughly 30-50
seconds per port before the -EIO fires.

mxl862xx_busy_wait() also allows up to 500 ms per wait:

	return readx_poll_timeout(mxl862xx_ctrl_read, priv, val,
				  !(val & CTRL_BUSY_MASK), 15, 500000);

So a device that holds its busy bit could stretch the bounded walk much
further.

The -EIO also does not seem to end the dump. rtnl_fdb_dump() only stops
on -EMSGSIZE:

		if (dev->netdev_ops->ndo_fdb_dump)
			err = dev->netdev_ops->ndo_fdb_dump(skb, cb, dev, NULL,
							    &fidx);
		else
			err = ndo_dflt_fdb_dump(skb, cb, dev, NULL, &fidx);
		if (err == -EMSGSIZE)
			break;

Each DSA user port goes through dsa_user_fdb_dump()->dsa_port_fdb_dump()
->mxl862xx_port_fdb_dump() on its own, and the failure is not latched.
One bridge fdb show would then run the user port count times 16384 reads
under RTNL, with one dev_err per port that is not rate-limited.
Userspace gets a silently truncated list rather than an error. Each new
dump or -EMSGSIZE continuation starts again with initial=1 and a fresh
budget.

RTM_GETNEIGH's dumpit is registered without RTNL_FLAG_DUMP_UNLOCKED, so
an unprivileged local user can trigger this repeatedly. Other RTNL users
are blocked meanwhile, including mxl862xx_crc_err_work_fn() and
mxl862xx_host_flood_work_fn().

The commit message does not explain where 16k comes from. Would a
jiffies-based deadline, a bound tied to the real table capacity, or
latching the failure so that other ports and later dumps fail fast work
better here?

>  		entry_port_id = le32_to_cpu(param.port_id);
>  
>  		if (entry_port_id == port) {

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/tencent_1AD6B5B7C296D319F828A281A2A65B95D609%40qq.com
