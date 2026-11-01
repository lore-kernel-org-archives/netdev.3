Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793569620;
	b=LWFX0Neng26DhXvW9uASf12+YRjY0k8IoC+QNIfaQrYlRhBWjLOuv68T+6zjx258a3AT
	 O3uMW7Qn74h1YxF8+LJq11iFYQiMC8HWdOydaYdsR5dqR+a3wtgXwSYTm6GWeS8Skhbyy
	 GtqEpoIUe0JkO3JSCjsluMdL8Tn0kTyKQhp5fErW57byuNPUaUxz0GGCwLv4iC93Pf1jd
	 c83/I/FhLrJyNc1p6Hb5zpHoqajArGco7wbp5+Gn2YQPtqrx7rVf6og158iTLSfFVEHTD
	 CehHTKLMVxvmXUFBomZv76M9JpK2OAFHCSsMnoVa4GYDR5sfa626FuOYJ47ryz33wQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793569620;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=uk9492nY2Z6AZT74vYyROopjR/2FFVIMtzAYStpAoSY=;
	b=eDXIYhUBFrXbDYEfO0jINv2SRFIehR3FTj8dhRbqFV8VKsE60ipTnxK8uNWahapAW0Uw
	 UIGiBmJsXGPR0toDoT4vjr7iroFla0oJ7X1FVK1bCYPLIwVFDhSFgHZfkf0k8JYvpdsJu
	 /4ZAEuvSIXSP2Ym8oygH4BP7JVIG+KRaWrtWf5vDbXtUkiI33J9s6u/h10Rg9vxhJERvh
	 U0/LDI2jGMhofMlxLBR+rrUAOANTiL4r06WBpDs8RHqGo2cyXYD6IRGiLrmW3D6AKqZQ6
	 4OU6jnATRWPyhhzz/9vBn6N693SEv8gqxOrqsvR+XWe9ZlSJ0PtxxBOmMkxINA9+ECg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LdjK2vne;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09216606A330;
	Sun,  1 Nov 2026 21:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LdjK2vne
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8731F00919;
	Sun,  1 Nov 2026 21:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793569619;
	bh=uk9492nY2Z6AZT74vYyROopjR/2FFVIMtzAYStpAoSY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LdjK2vne0p8pZm+XRGfSotz6w/ZxSZQUB2YOfoze+X7J2e9kBQs1VBJ3N6nXlzTdI
	 /tuw3f9Uxb27gJaEL/nt1GyRsSEB/ayUNcqZqZv5+LEAp6zxiLQkxxnacKemfN7ovK
	 efTPws4n3hVlo7xbmzykoEUWFgTphK7sDX/u97uRrnUdLGgPCqjjdut53vCDk2/LHE
	 7him/tpEldBckmrvktlPKPLtMsI/qR5WpjMoWzuz49OpovDTjC/h62wNe+NSXBCtrd
	 sLHZh4cEdNTmc6t12UK/Uo9rrPmUPXIbhKVHItzVGPlxwER+buETrxG1Vddm0CV48g
	 Ev1NCV4j+mqww==
Subject: Re: [PATCH net v2 3/5] net: dsa: b53: clear stale state when creating
 an ARL entry
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk,
 linux-kernel@vger.kernel.org
Date: Sun, 01 Nov 2026 21:46:58 +0000
Message-ID: <179356961852.3131.14443659841627836744@kernel.org>
In-Reply-To: <20261028212310.3847553-4-florian.fainelli@broadcom.com>
References: <20261028212310.3847553-4-florian.fainelli@broadcom.com>
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In b53_arl_op() (drivers/net/dsa/b53/b53_common.c), the patch
  changes the result of deleting an ARL entry that is not present (op ==…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but in
  b53_arl_op() (drivers/net/dsa/b53/b53_common.c) the unicast delete…

--

net: dsa: b53: clear stale state when creating an ARL entry

This patch clears the b53_arl_entry in b53_arl_op() before creating a new
ARL entry. As a result, a multicast add no longer ORs the port into an
unrelated bin's forwarding bitmap. It also makes b53_arl_op() return early,
without writing anything, when asked to delete an entry that is not
present.

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
> +

[Severity: Medium]
Is it intended that deleting an absent entry now fails with -ENOENT?

Before this patch, the -ENOSPC delete case returned 0. The -ENOENT delete
case returned the result of b53_arl_rw_op(), which is normally 0.

The commit message only says the function will "return without writing
anything". In practice both paths now return -ENOENT to b53_fdb_del() and
b53_mdb_del(), and from there to the DSA core for both b53 and bcm_sf2.

On BCM5325/BCM5365, b53_mdb_add() never programs anything:

	if (is5325(priv) || is5365(priv))
		return -EOPNOTSUPP;

b53_mdb_del() has no matching check. Every RTM_DELMDB that comes through
br_switchdev_mdb_notify() -> switchdev_port_obj_del() will now hit this
path and log:

	if (ret)
		dev_err(ds->dev, "failed to delete MDB entry\n");

switchdev_port_obj_del_deferred() then logs a second error, because the
code is not -EOPNOTSUPP. Ordinary IGMP/MLD group leaves or timeouts on a
bridged user port would produce these messages.

The same thing happens when deleting an fdb/mdb entry whose earlier add
failed with -ENOSPC.

CPU and DSA ports see a further effect. In net/dsa/switch.c,
dsa_port_do_fdb_del() keeps the tracking record when the driver returns an
error, and dsa_port_do_mdb_del() does the same:

	err = ds->ops->port_fdb_del(ds, port, addr, vid, db);
	trace_dsa_fdb_del_hw(dp, addr, vid, &db, err);
	if (err) {
		refcount_set(&a->refcount, 1);
		goto out;
	}

A later add of the same address finds that record and calls
refcount_inc(). It never calls port_fdb_add()/port_mdb_add() again, so the
ARL entry stays missing until teardown. Before this patch, the delete
returned 0, the record was freed, and the next add reprogrammed the
hardware.

There are two ways the hardware can be missing an entry that DSA still
tracks:

  - bcm_sf2_sw_resume() resets the switch via bcm_sf2_sw_rst() and does
    not replay the host FDB/MDB lists.
  - b53 has no FDB isolation. A host entry and a user-port static entry
    with the same MAC/VID share one ARL slot, so deleting the user-port
    entry invalidates both.

Documentation/networking/dsa/dsa.rst says port_fdb_del/port_mdb_del remove
the address "if it was mapped". That reads as if a missing entry is not an
error.

Would returning 0 here (perhaps with a dev_dbg()), while still skipping the
write, keep the fix without these side effects?

>  		/* We could not find a matching MAC, so reset to a new entry */
>  		dev_dbg(dev->dev, "{%pM,%.4d} not found, using idx: %d\n",
>  			addr, vid, idx);
> +		memset(&ent, 0, sizeof(ent));
>  		break;
>  	default:
>  		dev_dbg(dev->dev, "{%pM,%.4d} found, using idx: %d\n",

[Severity: Medium]
This isn't a bug introduced by this patch, but should the unicast delete in
the found case check that the entry belongs to the requesting port?

After the switch statement, b53_arl_op() does:

	if (!is_multicast_ether_addr(addr)) {
		ent.port = port;
		ent.is_valid = is_valid;
	} else {

It then writes the bin back as invalid. It never compares the ent.port read
from hardware against port.

dsa.rst says port_fdb_del should delete the address "if it was mapped into
this port forwarding database".

b53 does not set ds->fdb_isolation, so dsa_port_fdb_del() forces
info.db.bridge.num to 0 and the driver ignores the dsa_db. Suppose the same
MAC/VID is added on port A and then on port B. This can happen with two
VLAN-unaware bridges using vid 0, or with a host FDB entry on the CPU port
plus a user-port static entry.

The single ARL slot then points at B. A later delete on port A removes B's
entry, while the bridge and DSA still believe it is installed.

This patch only reworks the absent-entry branches, so the found-entry path
is unchanged.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028212310.3847553-1-florian.fainelli%40broadcom.com
