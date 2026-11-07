Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794080369;
	b=ben2WDQRSloEh64Ezm//3mAdigreMJPm1PMYGJZ8HL/2OpuizG8bdAmy+w2P93rqwQHs
	 WteVk0FXzBm6yuR3hiPBAQ4KILWjSi9aIxG5FodvuUv7dMVCEgZ5POS8EwO7QzWq5Lav3
	 gIqbGzfhrVpjja9v3OZtRrbe7Xq854UMSccTC6af13tIk6qxIfQvPJDJeURaeARExqpHE
	 duF9rulWjInN7ALmaQVhIcGwpQzRiqSoQLKc4n+Iicz5sdKcy9v5Ds5s54n+FPAn81+sO
	 IJijfWqVk4js3RI8AaX/yqicz8lL6Hbfd1tkwpL3SqznU5ASVUg9oe5W2oFjUtNn3tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794080369;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=zGJS4a0bANFqpdBUr2HSdaiGkg8BLv8Y+Kfjy87REWE=;
	b=J9TbnTxGWQ2oNO4zotKdDW10faH1AUKiQrdux7DeO7KJhGzqjVvg286KXKv80WMSnwZC
	 25AstipD5FDY9/Jh6n5Agh/pFmA8fvp8DmQLsaIF8JMdBeOKk0AbW9JaoLtXsdLBRg0Kv
	 /mxmTfGz+BtQSyx3UFs4XjJOJhrrnWeOjOsDJHbsQ6L42VRTsIH4bdjIoZ9X1J9uBnPfX
	 ZaL1PPXX5YzNgmC9+ic+IjEEz9cnkTjp3zI4H0k6Hy2bK+GIFonaRY4UMhVBBEyczVVHu
	 EREJ7Z2/a3wdoqiSXR3RhPx+VL4+6o3iiKOMd/08uh9owvn8pZZj2SrT0eeBZtB8NzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FWU1Z2E4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C57606A333;
	Sat,  7 Nov 2026 19:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FWU1Z2E4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C67F1F0089F;
	Sat,  7 Nov 2026 19:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794080369;
	bh=zGJS4a0bANFqpdBUr2HSdaiGkg8BLv8Y+Kfjy87REWE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FWU1Z2E4EgVEuaiVIz9pIjEkAhL6Fd+Gel/ejfjDYlqcgZ0c3ERfmLg9/rnQTqNYd
	 F1eea5ESuIDypJkD0CYymXNfvy7F+sbScsdU2MU4FvZK8U4muxeIroGHZJu6xUPVQ0
	 YQXmlgUCaubczDXWLbvcqE/D5ZqO09G4sMbapCcJV4XsZj2z92Z4bkgiF48D+FOlUf
	 RiBEbWq59VkaXyg2bAsZcHEIDUTjgMad5VyEB5MxW5fAL7VV3+iRFueiCGXfmT05fS
	 5WBkNbPatB+tDfLxdeOhqPNTbeYHF9OU+U6LOTigovY3nClXJVdpKnhzJ0nhsVN0K8
	 cnaw2RxSq/H6A==
Subject:
 Re: [PATCH net-next 2/2] net: dsa: motorcomm: Add devlink info and resources
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Sat, 07 Nov 2026 19:39:28 +0000
Message-ID: <179408036808.994134.2387568593420048929@kernel.org>
In-Reply-To: <20261106184811.350700-3-mmyangfl@gmail.com>
References: <20261106184811.350700-3-mmyangfl@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The devlink FDB resource tree breaks devlink's rule for parent
  and child sizes.
- [Medium] yt921x_devlink_occ_get_fdb() computes FDB occupancy as
  LEARN_UCAST_CNT + LEARN_MCAST_CNT + priv->fdb_static_cnt.
- [Medium] priv->fdb_static_cnt is changed only after the whole FDB
  sequence reports success, so it can drift from the hardware when the…
- [Medium] yt921x_dsa_setup() calls yt921x_chip_reset(), which writes
  YT921X_RST_HW (chip.c:2258), described in a comment as 'almost same as…
- [Low] The uAPI resource names "ucast" and "mcast" under /FDBs do not
  describe what they report.
- [Low] devlink.h declares `int yt921x_devlink_setup(struct yt921x_priv
  *priv);` but includes only <net/dsa.h>.
- [Low] devlink.c defines its own macro `#define to_yt921x_priv(_ds)
  container_of_const(_ds, struct yt921x_priv, ds)` at line 11.
- [Low] priv->fdb_static_cnt is accessed in two inconsistent ways.

--

net: dsa: motorcomm: Add devlink info and resources

This commit reports the ASIC model through devlink info. It also registers
devlink resources for ACLs, FDB entries (with ucast, mcast and static
children) and meters. FDB occupancy adds the hardware learn counters to a
software count of static entries, which is updated in the FDB add, join
and leave paths.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index a7a9a74393045..c3c555cb8941c 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c

[ ... ]

> @@ -731,6 +732,7 @@ yt921x_fdb_add(struct yt921x_priv *priv, const unsigned char *addr, u16 vid,
>  	if (val & YT921X_FDB_RESULT_NOTFOUND)
>  		return -ENOSPC;
>  
> +	priv->fdb_static_cnt++;
>  	return 0;
>  }
>  
> @@ -761,18 +763,27 @@ yt921x_fdb_leave(struct yt921x_priv *priv, const unsigned char *addr,
>  	ctrl2 = val2 & ~YT921X_FDB_IO2_EGR_PORTS(ports_mask);
>  	if (ctrl2 == val2)
>  		return 0;
> +
> +	res = yt921x_reg_read(priv, YT921X_FDB_OUT1, &ctrl1);
> +	if (res)
> +		return res;
> +
>  	if (!(ctrl2 & YT921X_FDB_IO2_EGR_PORTS_M)) {
>  		ctrl = YT921X_FDB_OP_OP_DEL | YT921X_FDB_OP_START;
>  		res = yt921x_reg_write(priv, YT921X_FDB_OP, ctrl);
>  		if (res)
>  			return res;
>  
> -		return yt921x_fdb_wait(priv, &val);
> -	}
> +		res = yt921x_fdb_wait(priv, &val);
> +		if (res)
> +			return res;
>  
> -	res = yt921x_reg_read(priv, YT921X_FDB_OUT1, &ctrl1);
> -	if (res)
> -		return res;
> +		if ((ctrl1 & YT921X_FDB_IO1_STATUS_M) ==
> +		    YT921X_FDB_IO1_STATUS_STATIC &&
> +		    !WARN_ON(!priv->fdb_static_cnt))
> +			priv->fdb_static_cnt--;
> +		return 0;
> +	}

[Severity: Medium]
Can fdb_static_cnt drift from the hardware table when an FDB command
takes effect but a later step reports an error?

In yt921x_fdb_add(), OP_ADD|START is written to YT921X_FDB_OP before
yt921x_fdb_wait() runs. Two failures can happen after that write:

  - the wait times out ("FDB probably stuck")
  - the MDIO write was applied but still returned an error

In either case the function returns before fdb_static_cnt++, but the
entry may already be static in hardware. yt921x_fdb_join() has the same
problem through yt921x_fdb_add_index_in12().

If the same {addr, vid, port} is added again later, yt921x_fdb_join()
sees STATUS_STATIC with identical ctrl1/ctrl2 and returns 0 without
counting it. When the entry is finally removed, yt921x_fdb_leave()
reaches this check:

    if ((ctrl1 & YT921X_FDB_IO1_STATUS_M) ==
        YT921X_FDB_IO1_STATUS_STATIC &&
        !WARN_ON(!priv->fdb_static_cnt))

If there are no other static entries, the WARN_ON fires.

The opposite can happen here as well. If yt921x_fdb_wait() fails after the
DEL has completed, the decrement is skipped. The count then stays too high
for as long as the device exists, because nothing re-syncs the counter
with the hardware table.

>  
>  	return yt921x_fdb_add_index_in12(priv, index, ctrl1, ctrl2);
>  }

[ ... ]

> @@ -2154,6 +2172,8 @@ static void yt921x_dsa_teardown(struct dsa_switch *ds)
>  
>  	yt921x_leds_remove(priv);
>  #endif
> +
> +	dsa_devlink_resources_unregister(ds);
>  }

[Severity: Medium]
Should fdb_static_cnt be reset somewhere in the setup or teardown path?

yt921x_dsa_setup() calls yt921x_chip_reset(), which does:

    /* Reset */
    res = yt921x_reg_write(priv, YT921X_RST, YT921X_RST_HW);
    ...
    /* RST_HW is almost same as GPIO hard reset, so we need this delay. */

That reset clears the hardware FDB, static entries included. However,
fdb_static_cnt is only zeroed once, when priv is allocated with
devm_kzalloc() at probe time.

Setup can run again on the same priv if the DSA tree is torn down and set
up again while this switch stays probed. Examples are another member of a
multi-switch tree unbinding and rebinding, or a failed tree setup being
retried. If the counter was non-zero at teardown, the re-registered
"static" and "FDBs" resources would then count entries that no longer
exist.

Entries can still be present at teardown in two cases:

  - entries installed through ndo_dflt_fdb_add() that upper layers never
    remove; dsa_switch_release_ports() cleans these up, but it only runs
    at switch removal
  - entries left behind by the error-path drift described above

When those addresses are deleted later, yt921x_fdb_leave() finds no
hardware entry and returns early:

    if (index >= YT921X_FDB_NUM)
        return 0;

So the inflated count is never corrected.

[ ... ]

> diff --git a/drivers/net/dsa/motorcomm/devlink.c b/drivers/net/dsa/motorcomm/devlink.c
> new file mode 100644
> index 0000000000000..cddc77a6fd111
> --- /dev/null
> +++ b/drivers/net/dsa/motorcomm/devlink.c
> @@ -0,0 +1,208 @@

[ ... ]

> +#include "chip.h"
> +#include "devlink.h"
> +#include "smi.h"
> +#include "tc.h"
> +
> +#define to_yt921x_priv(_ds) container_of_const(_ds, struct yt921x_priv, ds)

[Severity: Low]
This isn't a bug, but this macro duplicates dsa_to_yt921x_priv() in
chip.h, which is already included here:

    #define dsa_to_yt921x_priv(_ds) container_of_const(_ds, struct yt921x_priv, ds)

Could yt921x_dsa_devlink_info_get() use the existing helper instead?

[ ... ]

> +static u64 yt921x_devlink_occ_get_fdb_static(void *ctx)
> +{
> +	struct yt921x_priv *priv = ctx;
> +
> +	return READ_ONCE(priv->fdb_static_cnt);
> +}

[Severity: Low]
Is this read meant to be lockless? It is the only occ_get callback in
this file that does not take priv->reg_lock.

The writers in yt921x_fdb_add(), yt921x_fdb_leave() and yt921x_fdb_join()
use plain ++/-- under reg_lock, without WRITE_ONCE(). Also,
yt921x_devlink_occ_get_fdb() reads the same field plainly under reg_lock.

This callback runs under devl_lock only, which does not exclude the FDB
writers, so the READ_ONCE() here is paired with unmarked writes.

Would it be simpler to take reg_lock like the other callbacks do, or else
to use WRITE_ONCE() in every writer?

> +
> +static u64 yt921x_devlink_occ_get_fdb(void *ctx)
> +{
> +	struct yt921x_priv *priv = ctx;
> +	u64 count = 0;
> +	u32 val;
> +	int res;
> +
> +	mutex_lock(&priv->reg_lock);
> +
> +	res = yt921x_reg_read(priv, YT921X_LEARN_UCAST_CNT, &val);
> +	if (res)
> +		goto end;
> +	count += val;
> +
> +	res = yt921x_reg_read(priv, YT921X_LEARN_MCAST_CNT, &val);
> +	if (res)
> +		goto end;
> +	count += val;
> +
> +	count += priv->fdb_static_cnt;

[Severity: Medium]
Can this sum count the same FDB entry twice?

The total is LEARN_UCAST_CNT + LEARN_MCAST_CNT + fdb_static_cnt. That is
only correct if neither hardware counter includes static entries that the
CPU installed or converted.

For multicast: SA learning cannot create multicast entries, and the
driver does not configure hardware IGMP/MLD snooping. So every multicast
entry comes from this path:

  yt921x_dsa_port_mdb_add()->yt921x_fdb_join()->yt921x_fdb_add()

That path writes STATUS_STATIC and does fdb_static_cnt++. If
YT921X_LEARN_MCAST_CNT counts these entries, every MDB entry is counted
twice in "FDBs". If it does not, the "mcast" resource always reads 0.

For unicast: yt921x_fdb_join() rewrites an existing hardware-learned
entry as static through an index-mode ADD, and then does:

    if ((val1 & YT921X_FDB_IO1_STATUS_M) !=
        YT921X_FDB_IO1_STATUS_STATIC)
        priv->fdb_static_cnt++;

Does YT921X_LEARN_UCAST_CNT drop by one when the CPU rewrites the entry,
or only on age-out or flush? If only on age-out or flush, then a
"bridge fdb add ... static" for a MAC that was already learned is counted
under both ucast and static.

The commit message describes these as hardware counters for "learned FDB
entries". Nothing in the code shows how they treat entries the CPU wrote.
The answer depends on hardware behaviour that can't be confirmed from the
code.

> +
> +end:
> +	mutex_unlock(&priv->reg_lock);

[ ... ]

> +static const struct yt921x_devlink_resource yt921x_devlink_resources[] = {

[ ... ]

> +	{
> +		"FDBs", yt921x_devlink_occ_get_fdb,
> +		YT921X_FDB_NUM,
> +		YT921X_DEVLINK_RESOURCE_ID_FDB,
> +		DEVLINK_RESOURCE_ID_PARENT_TOP,
> +	},
> +	{
> +		"ucast", yt921x_devlink_occ_get_fdb_ucast,
> +		YT921X_FDB_NUM,
> +		YT921X_DEVLINK_RESOURCE_ID_FDB_UCAST,
> +		YT921X_DEVLINK_RESOURCE_ID_FDB,
> +	},

[Severity: Low]
Do the names "ucast" and "mcast" match what these resources report?

yt921x_devlink_occ_get_fdb_ucast() and yt921x_devlink_occ_get_fdb_mcast()
return only the hardware learn counters (YT921X_LEARN_UCAST_CNT and
YT921X_LEARN_MCAST_CNT). Static entries from yt921x_dsa_port_fdb_add()
and yt921x_dsa_port_mdb_add() only increment fdb_static_cnt. So a
"bridge fdb add ... static" or an MDB entry never shows up under "ucast"
or "mcast".

These names become uAPI once they are released. Would names like
"learned-ucast" and "learned-mcast" be clearer?

> +	{
> +		"mcast", yt921x_devlink_occ_get_fdb_mcast,
> +		YT921X_FDB_NUM,
> +		YT921X_DEVLINK_RESOURCE_ID_FDB_MCAST,
> +		YT921X_DEVLINK_RESOURCE_ID_FDB,
> +	},
> +	{
> +		"static", yt921x_devlink_occ_get_fdb_static,
> +		YT921X_FDB_NUM,
> +		YT921X_DEVLINK_RESOURCE_ID_FDB_STATIC,
> +		YT921X_DEVLINK_RESOURCE_ID_FDB,
> +	},

[Severity: Medium]
Does this hierarchy follow devlink's rule for parent and child sizes?

"FDBs" is registered with YT921X_FDB_NUM entries. Each of its three
children, "ucast", "mcast" and "static", is also registered with
YT921X_FDB_NUM. devlink treats children as parts of the parent:

net/devlink/resource.c:devlink_resource_validate_children() {
    ...
	list_for_each_entry(child_resource, &resource->resource_list, list)
		parts_size += child_resource->size_new;

	if (parts_size > resource->size_new)
		size_valid = false;
    ...
}

Registration does not catch this, because devl_resource_register() sets
size_valid = true. However, devlink_nl_resource_set_doit() re-validates
the parent:

	resource->size_new = size;
	devlink_resource_validate_children(resource);
	if (resource->parent)
		devlink_resource_validate_children(resource->parent);

Since size_min == size_max, the only value a set can use is 4096. Even
that no-op, "devlink resource set ... path /FDBs/ucast size 4096", leaves
"FDBs" permanently reported with size_valid false, because
3 * 4096 > 4096.

The children also overlap. ucast and mcast split entries by address type,
while static splits them by entry type, so a static unicast entry
belongs to two siblings.

Would it work better to register these counters as top-level resources?
mv88e6xxx does this: its ATU_bin_* resources are registered with
DEVLINK_RESOURCE_ID_PARENT_TOP, as siblings of "ATU". Another option is to
give the children non-overlapping sizes that add up to the parent.

[ ... ]

> diff --git a/drivers/net/dsa/motorcomm/devlink.h b/drivers/net/dsa/motorcomm/devlink.h
> new file mode 100644
> index 0000000000000..e13fbe320bcaa
> --- /dev/null
> +++ b/drivers/net/dsa/motorcomm/devlink.h
> @@ -0,0 +1,16 @@

[ ... ]

> +#include <net/dsa.h>
> +
> +int
> +yt921x_dsa_devlink_info_get(struct dsa_switch *ds, struct devlink_info_req *req,
> +			    struct netlink_ext_ack *extack);
> +int yt921x_devlink_setup(struct yt921x_priv *priv);

[Severity: Low]
This isn't a bug, but devlink.h uses struct yt921x_priv without including
chip.h or forward-declaring the struct. leds.h, mdio_bus.h and smi.h all
have:

    struct yt921x_priv;

devlink.h only compiles because chip.c and devlink.c include chip.h
first. Could a forward declaration be added so the header is
self-contained?

> +
> +#endif

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106184811.350700-1-mmyangfl%40gmail.com
