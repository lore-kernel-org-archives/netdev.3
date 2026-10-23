Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792786886;
	b=IULXYVZeP7Aq897tSHG5C4dFqrisiiU/uvJAgH6nsDLfLLlEJNh5rwITHtUFJu7SdonU
	 PXtsj6/JWdcf+ypEiUEjvvK+4ROXaDYDWW1Iml9L0fNUK6ZSAnkeoMov8TYTxAqwBW70A
	 Cb4rbmrE+t5H27F22FRAP6e2mrXcHDA3A26DDHHrysGj45cVYQwdHBB6vYnGUDHnqZwPb
	 XDTUD23CjTGWh+3Wv7UDSJMbDcj8He1GUF+l0LiI1wXyuR1nbSGBBYjpRVCCGW8FkO8Bv
	 b6GWgQjCzYtAioeO+E47kv8BmzR+EYyJU4v7U13uQ0wxuBQT7IT0ohX4oOHfLW5UxLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792786886;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=zX4m+iRNl7Z65P0Rz5nVPT6l9PUVJzvfslBPHewCbDI=;
	b=jQid1PjGdMSyvK5zmChZOgwNvzWd+Xft8/6vr6LnRmI8rN6ipPMi2FV+xQGYd5wUPWLP
	 Vz5R1nJv+dYdfvU20AN5R7Un9XTkH4wDdn051iaQOEwFrBlnICLvH3ebn78G1cMpemTIg
	 ciupiRjFuKoymwAYRkZaXrj6cu7r9vVv1zBBIVK1Dby8Xv3DdpHmAvqcKV5VjCw4LD9vx
	 Eo2aMNwf3doboi7WcS+/r+f7FDEbM5mVlMi+tcY+pH0CYMsMoDvRjkWvXjTtNGf/3HBNV
	 Mpw2kz7+P6SFg987r0FhyCUB+ZZbSvP/yE/8owvrqgzgpEve6Dkt0QslfCni9UKvBRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LcDgcJsQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD941606A31E
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 20:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LcDgcJsQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33331F01825;
	Fri, 23 Oct 2026 20:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792786885;
	bh=zX4m+iRNl7Z65P0Rz5nVPT6l9PUVJzvfslBPHewCbDI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LcDgcJsQdwK9AAmrvC2jNaFG54yJ8lG8bhkLb9oZ268cxY1m81zRf7yTPjyCGsFic
	 mht7CpahG42anTPpLN770grdAvXGFr2JtitYSlK6qjyxZot3c796FUFbyCTuAdWTyX
	 OpDU45sZc0cRPANaUXqM6USpUWuPehIarjEYdoN4v51jDg/ZOaTdPICLNWTqa2/BUx
	 KiMnF6LoIT49s39eDSgcJ/XSn94j7dsHgG8wPnv+VgsS9xqmv05F3B1qIasXhSyWVr
	 kQxx5zMykGt4adVZ4BpZ04gmlKwAoBHEy3Tctzn976NPE1LNq5W6a4kDzcYcNP7wtb
	 Tc7WrgQ/L86lQ==
Subject:
 Re: [PATCH net 1/2] net: dsa: mxl862xx: bound FDB dump walk by table capacity
From: netdev-bot+sashiko@kernel.org
To: memoriaru@foxmail.com
Cc: netdev@vger.kernel.org, daniel@makrotopia.org, andrew@lunn.ch,
 olteanv@gmail.com, johan@kernel.org, kuba@kernel.org
Date: Fri, 23 Oct 2026 20:21:24 +0000
Message-ID: <179278688436.3134.7157929929766878085@kernel.org>
In-Reply-To: <tencent_A56873DA4A296F5D794B6A5989A180A21C05@qq.com>
References: <tencent_A56873DA4A296F5D794B6A5989A180A21C05@qq.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] net: dsa: mxl862xx: off-by-one in mxl862xx_port_fdb_dump()
  capacity check
- [Low] The commit message for "net: dsa: mxl862xx: bound FDB dump walk
  by table capacity" says that with firmware that never sets last=1,…
- [Low] The patch is presented as a fix for an infinite loop with RTNL
  held, but it has no Fixes: tag.

Pre-existing issues:
- [Medium] The kernel-doc for struct mxl862xx_mac_table_read
  (drivers/net/dsa/mxl862xx/mxl862xx-api.h) says "@last: Indicates that…

--

net: dsa: mxl862xx: bound FDB dump walk by table capacity

This commit caps the MAC table walk in mxl862xx_port_fdb_dump() at 16384
entries. If the firmware has not set the last flag by then, the walk
stops with -EIO and logs an error. The goal is to avoid an endless loop
with RTNL held when the firmware never reports the end of the table.

> A device (or its firmware) that never
> sets last=1 keeps the driver looping forever with RTNL held, and every
> matching entry invokes the DSA callback, growing kernel memory without
> bound.

[Severity: Low]
Is the "growing kernel memory without bound" part accurate?

The only callback passed to port_fdb_dump is dsa_user_port_fdb_do_dump(),
reached via dsa_user_fdb_dump()->dsa_port_fdb_dump(). It does not allocate
anything per entry. It writes into the fixed-size netlink dump skb and
returns -EMSGSIZE once the skb is full:

net/dsa/user.c:dsa_user_port_fdb_do_dump() {
    ...
	if (dump->idx < ctx->fdb_idx)
		goto skip;

	nlh = nlmsg_put(dump->skb, portid, seq, RTM_NEWNEIGH,
			sizeof(*ndm), NLM_F_MULTI);
	if (!nlh)
		return -EMSGSIZE;
    ...
nla_put_failure:
	nlmsg_cancel(dump->skb, nlh);
	return -EMSGSIZE;
}

mxl862xx_port_fdb_dump() already returns on any non-zero cb() result, so
the walk ends when the skb fills up. Skipped entries use no space.

Before this patch, the unbounded cost was CPU and RTNL hold time spent
looping over entries that don't match the port, or that are skipped. It
was not memory growth. Could the commit message describe it that way?

> Reported-by: memoriaru <memoriaru@foxmail.com>
> Signed-off-by: Zhang Hewei <memoriaru@foxmail.com>

[Severity: Low]
Should this have a Fixes: tag? The unbounded while (true) walk in
mxl862xx_port_fdb_dump() came in with:

Fixes: 340bdf984613 ("net: dsa: mxl862xx: implement bridge offloading")

The Reported-by: uses the same address as the Signed-off-by:. There is
also no Closes: or Link: tag, which checkpatch warns about. Was this seen
on real hardware?

The trigger also looks narrower than described. Firmware that has
stopped responding already fails in mxl862xx_busy_wait():

	return readx_poll_timeout(mxl862xx_ctrl_read, priv, val,
				  !(val & CTRL_BUSY_MASK), 15, 500000);

Garbled replies are rejected with -EIO by the CRC-6 check in
mxl862xx_issue_cmd() and the CRC-16 check on the read payload in
mxl862xx_api_wrap(). Both of these already leave the loop through the
existing "if (ret) return ret;".

So the only new case covered seems to be firmware that keeps sending
well-formed, CRC-valid replies but never sets last. Could the commit
message and the "not responding correctly" code comment say that more
precisely?

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
> index e05ad52cd297e..12cd40756a0c9 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx.c
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx.c

[ ... ]

> @@ -1510,6 +1513,16 @@ static int mxl862xx_port_fdb_dump(struct dsa_switch *ds, int port,
>  		if (ret)
>  			return ret;
>  
> +		/* The MAC table capacity is fixed by the device. A walk longer
> +		 * than that means the device (or its firmware) is not
> +		 * responding correctly; bail out instead of looping forever
> +		 * with RTNL held.
> +		 */
> +		if (count++ >= MXL862XX_MAC_TABLE_FDB_SIZE) {
> +			dev_err(ds->dev, "FDB dump exceeded table capacity\n");
> +			return -EIO;
> +		}
> +
>  		if (param.last)
>  			break;

[Severity: Medium]
Does this bound count the terminating read as if it were an entry?

The count check runs before the param.last test. Suppose the table
holds exactly MXL862XX_MAC_TABLE_FDB_SIZE entries:

- The 16384 reads that return entries with last == 0 take count from
  0 to 16384.
- The next read is the one with last == 1.
- At that point count++ >= 16384 is already true.

So mxl862xx_port_fdb_dump() logs "FDB dump exceeded table capacity"
and returns -EIO instead of finishing the walk.

A table that is exactly at the cap fails the whole dump, even though
the firmware ended the walk correctly. The error message is also
wrong in that case, because nothing was exceeded. 16384 is meant to
be well above any real table size, so this may not be reachable on
current parts. The check still treats the sentinel as an entry,
though.

Would it be cleaner to test param.last first and only count reads
that actually carry an entry? Moving the bound below the
"if (param.last) break;" keeps the same protection against firmware
that never sets last.

The kernel-doc for struct mxl862xx_mac_table_read suggests the
last == 1 reply may itself carry a valid entry. If so, the counting
here should line up with whatever is decided about handling that
final reply.

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch, but can
this break drop the final MAC table entry?

The kernel-doc for struct mxl862xx_mac_table_read in mxl862xx-api.h
says:

 * @last: Indicates that the read operation returned last entry

That reads as if the last=1 response still carries a valid entry. The
loop breaks before it looks at param.port_id, param.mac or param.tci, so
that response is never passed to cb().

If the firmware fills in the entry fields along with last=1, every FDB
dump would silently leave out the final entry. If it doesn't, the
kernel-doc is misleading. The tree doesn't show which firmware behaviour
is correct. This code dates back to commit 340bdf984613.

Taken together, the code change looks fine. All three points concern
the commit message, the trailers, or code that was already there.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/tencent_A56873DA4A296F5D794B6A5989A180A21C05%40qq.com
