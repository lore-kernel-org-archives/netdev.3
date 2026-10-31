Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793483762;
	b=Yr3L+cS8PpwVpmYH8HyyDLlPhqxK3+wn9L+Xc+cw0DX57OcDSxioOgVEHw5vw0pwfRON
	 XjxE5iGeRPcYuMYAnwCnGtI/6iYnFxmKRkNRUqC9C81fWwuEUpxgrFBIkBuBy0o4+lxhL
	 YFl3YeIbCworLhs79kDlEZH5pR/Tut7eJpJjAmdPd3XD3KP03zhc7jGur4dVYYGRM5eb2
	 fyOMc1fQ4O5y016Gz8rzgghRr9y+ITT2/ZQkEQqOtKTbFm7LBSQKE6pwR6F7crT4n5FX1
	 Pyj6yVqyv9wuE/0VLvchtHaomRAwQ3EGB5PThNznvW4PwHutXLHWsEF/Atr7gxYzOSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793483762;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oFHrqw12rnDNC2aJHVaACTgX1tjugHvyCfEzO1+BNjs=;
	b=4Gj/kQ5ofeRWSdTgS2W/H5WmrdJZHzQ4x3HiyIQJ2watLH8ZWkf7NYNI6+RRRdil7bai
	 Ee+nGSW5LIOX5Dk54VJEpT4sUm6JS0oULLacsN2vq6JPmBFqkJTM9NY233oevyi4R5BZp
	 fP53frHc0fmyDUALRnQavggWP8QGeu+j2Y0MKEdgnMkrMyhM4zyWYi+4qrHNnLKx+9Tos
	 SCl7UgN/h/xq1UofE293ohrPiHsQxttP5ZIdwP+ttTx5u6CSvj7AaMjRR676EwkPIbQPY
	 9NY6Ix3IwEsrpqloJ8KDJBZgsis7JHZqWJi13dY12B0nNjgGZJveizDiH0crzw39CSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=geXW2klX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEDD606A31C;
	Sat, 31 Oct 2026 21:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=geXW2klX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D4D1F000C1;
	Sat, 31 Oct 2026 21:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793483761;
	bh=oFHrqw12rnDNC2aJHVaACTgX1tjugHvyCfEzO1+BNjs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=geXW2klXLawQTpru96+1zxq1uLY/c4gpFbzoISIwk3bYRcizIR3jYnGOcwbco9Dn6
	 oaH8HRe4zcFT+6JYD1ZZQF2k4NXOrWddjOqyN/ct44ZH/mxWpWGdReMWLe6ZMCxIVb
	 VkjN2FPUWNyaNhYsvoBqQxrOIc2d/DjhflxCmp8M/Zhe3/VkYDnaPeLJgfAskSOh+i
	 ntfJZ1oQTZ+9Ale0jHzLCt4MDFEKmY/GK9ISJUu7TgienX7oRRL5vqjtCmrkjCdYZd
	 DiBzNlXZ8sKGdMKOpu7JcO86812a9QA841cGoDGpcXL+1v21pTXJdmj2DnPCJDxfSa
	 m2meQsvV27pjg==
Subject: Re: [PATCH net v3 3/8] net: dsa: b53: clear stale state when creating
 an ARL entry
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, vivien.didelot@gmail.com, linux-kernel@vger.kernel.org
Date: Sat, 31 Oct 2026 21:56:00 +0000
Message-ID: <179348376043.3131.9215522572202391161@kernel.org>
In-Reply-To: <20261030211617.288562-4-florian.fainelli@broadcom.com>
References: <20261030211617.288562-4-florian.fainelli@broadcom.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In b53_arl_op() (drivers/net/dsa/b53/b53_common.c), deleting a
  {MAC,VID} that is missing from the ARL now returns -ENOENT.
- [Medium] Deleting an ARL entry that is not in hardware now fails with
  -ENOENT, including the -ENOSPC lookup result, which used to return 0…

--

net: dsa: b53: clear stale state when creating an ARL entry

When an ARL lookup misses, the patch now clears the b53_arl_entry before
building a new one. This stops a multicast add from ORing the port into an
unrelated bin's bitmap. A delete of an absent entry now returns -ENOENT
without writing to hardware, and that includes the -ENOSPC lookup result,
which used to return 0.

> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
> index 559d4b360c828..c38e8c5838bd8 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -1990,11 +1990,15 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
>  	case -ENOSPC:
>  		dev_dbg(dev->dev, "{%pM,%.4d} no space left in ARL\n",
>  			addr, vid);
> -		return is_valid ? ret : 0;
> +		return is_valid ? ret : -ENOENT;
>  	case -ENOENT:
> +		if (!is_valid)
> +			return ret;

[Severity: Medium]
Can returning -ENOENT on delete leave DSA's host address tracking out of
sync with the ARL?

b53_fdb_del() and b53_mdb_del() pass this value back to DSA. On CPU/DSA
ports, when the last reference drops, dsa_port_do_fdb_del() in
net/dsa/switch.c treats any driver error as "still in hardware":

	err = ds->ops->port_fdb_del(ds, port, addr, vid, db);
	trace_dsa_fdb_del_hw(dp, addr, vid, &db, err);
	if (err) {
		refcount_set(&a->refcount, 1);
		goto out;
	}

	list_del(&a->list);
	kfree(a);

dsa_port_do_mdb_del() handles errors the same way. The struct dsa_mac_addr
then stays on dp->fdbs or dp->mdbs with refcount 1.

A later add of the same {addr, vid, db} finds that record in
dsa_port_do_fdb_add() or dsa_port_do_mdb_add() and only calls
refcount_inc(). port_fdb_add or port_mdb_add is never called, so the
hardware entry is not reinstalled. The record is only freed by the leftover
sweep in dsa_port_teardown().

How can the hardware lose an entry that DSA still tracks? b53 doesn't set
ds->fdb_isolation, so dsa_port_bridge_host_fdb_add/del() force
db.bridge.num = 0, and all bridges share one ARL namespace.

A unicast ARL entry holds a single port. A user-port static FDB for the
same MAC/VID, for example in another bridge, overwrites the CPU port's host
entry. Deleting that user-port FDB invalidates the entry, and the later
host delete then misses.

There may be a second path, though I have not confirmed it.
bcm_sf2_sw_resume() calls bcm_sf2_sw_rst() and then ds->ops->setup(), and
does not replay FDB/MDB entries. If that reset clears the ARL, every later
host delete would miss.

Before this patch, the 0 return let DSA free its record, so the next add
reprogrammed the switch. Would returning 0 for a delete of an absent entry
fix the stale-bin problem without this side effect?

The commit message mentions the return value change, but not its effect on
the DSA core refcounting. With the Fixes: tag this will also go to stable.
Later patches in the series don't touch b53_arl_op(), b53_fdb_del() or
b53_mdb_del().

[Severity: Medium]
On BCM5325 and BCM5365, does this make every MDB delete fail?

b53_mdb_add() returns before it touches the ARL:

	if (is5325(priv) || is5365(priv))
		return -EOPNOTSUPP;

b53_mdb_del() has no matching check:

	ret = b53_arl_op(priv, 0, port, mdb->addr, mdb->vid, false);
	mutex_unlock(&priv->arl_mutex);
	if (ret)
		dev_err(ds->dev, "failed to delete MDB entry\n");

The bridge calls switchdev_port_obj_del() on RTM_DELMDB whether or not the
add was offloaded:

br_switchdev_mdb_notify()
  switchdev_port_obj_del()
    dsa_user_port_obj_del()
      dsa_port_mdb_del()
        dsa_port_do_mdb_del()
          b53_mdb_del()
            b53_arl_op() -> -ENOENT

So every group leave or expiry on a bridged 5325/5365 port with snooping
enabled would log "failed to delete MDB entry". It would also log a second
message from switchdev_port_obj_del_deferred(), which only ignores
-EOPNOTSUPP:

	err = switchdev_port_obj_del_now(dev, obj);
	if (err && err != -EOPNOTSUPP)
		switchdev_obj_id_to_helpful_msg(dev, obj->id, err, false);

On other chips, when a user-port FDB or MDB add fails with -ENOSPC, the
bridge delete that follows now fails too. For FDBs,
dsa_user_switchdev_event_work() then logs "port %d failed to delete %pM
vid %d from fdb".

Should b53_mdb_del() get the same 5325/5365 guard as b53_mdb_add()? Or
should a missing entry on delete be treated as success? b53_arl_op() and
b53_mdb_del() are still the same at the end of the series.

> +
>  		/* We could not find a matching MAC, so reset to a new entry */

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030211617.288562-1-florian.fainelli%40broadcom.com
