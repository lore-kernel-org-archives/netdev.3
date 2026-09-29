Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A34552947;
	Tue, 29 Sep 2026 20:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790714118; cv=none; b=vB0ar9TqFHaLnMoxRWvK/3BYad4et4pzf3RPnfOCv6dMyPtG8bKHCH8xhaMPR2o3yVFk55YIEjmuOU6ESHMGz8EGINFSgRRMfgr7Wq4eXC64ZgOBcdYtfx/FJvV5DmHvSYjXEA/R942415wpeg2JZ956nN+MA38XkvzvR1xSxqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790714118; c=relaxed/simple;
	bh=XLJH+4mv+4fSNUaJzEDrKDKnEWstan/Eeuew2/nUfeQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E1L9ChaJ9W3xRocoq4dzhRtucNGLrpG18znMj6CcrdAXlVI9Y87C2GtXw7DU7TnVSGu/5N06N7/YT+rAiGI4P645arrqvsrNCFAQg78iGiQNOQN69lQoclBgm2jHw+6Br8BDN7Wc44HgzwokYovx5+iGTwX4mT1cBPwGPJ81Lu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWNmxK9E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWNmxK9E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59AA31F000FF;
	Tue, 29 Sep 2026 20:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790714110;
	bh=1uaxMpbC19Rv7Kr1HPB1SGm4dFqmRKKFklLiC4sSLG4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AWNmxK9EW0wgTTGpyInYQFtcdEDnBjuk3O1tUdsYf5g6rCJDjHNUeGUMlzCDQOWeQ
	 ci2C1SOh2tDe8XdWboE0fOQ2DYgiBEnDSeo59vD6PTklwpH2eH40b8LaFfO7HP6tQN
	 vZETGH55Z89c/qudncmCVRDkltg7EqlpY6bvbliLbmNYanLdvDwYynQEZ1NUlsRZhi
	 /7b3Zn/VcTCOkYodtohFRKR0fPRs0zW5nxImU3qvOcA3KTie3YSKWgiIXEWVIS0dqQ
	 EQJZXjJ7tZ7C7aMpHeA6BaBGXq3CZrFp1mmMg7LzVqNpwLWDQ7qaRw3X5pOuPN0tMW
	 Wc85c8wF0JkYw==
Subject: Re: [PATCH net-next v23 8/9] net: dsa: mt7530: generalize and move
 common function to lib module
From: netdev-bot+sashiko@kernel.org
To: ansuelsmth@gmail.com
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, chester.a.unal@arinc9.com,
 daniel@makrotopia.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 horms@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 29 Sep 2026 20:35:08 +0000
Message-ID: <179071410894.434549.16063622147466326737@kernel.org>
In-Reply-To: <20260925182435.21207-9-ansuelsmth@gmail.com>
References: <20260925182435.21207-9-ansuelsmth@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 3 · Low: 3 (4)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] A name collision between a macro and an enum constant puts the
  mirror-enable regmap field at the wrong index.
- [Medium] mt7530_read_port_stats64() no longer fills
  rtnl_link_stats64.multicast.
- [Medium] mt753x_table[ID_EN7528] now uses `.reg_fields =
  mt7531_fields`, so on EN7528 mirroring goes to MT7531_CFC (MIRROR_EN…
- [Medium] mt7530_lib_port_mdb_add(), mt7530_lib_port_mdb_del() and
  mt7530_hw_vlan_del() declare `u32 val;` without initializing it.
- [Low] mt7530_lib_fdb_cmd() and mt7530_vlan_cmd() ignore failures of
  their final status reads.
- [Low] Two comments were not updated to match the new code.
- [Low] Splitting whole-register accesses into regmap_field accesses
  multiplies register traffic for FDB and VLAN operations.

Pre-existing issues:
- [Low] This problem wasn't introduced by this patch, but
  mt7530_hw_vlan_update() ignores the results of the RD_VID command, the…
- [Low] This problem wasn't introduced by this patch, but
  mt7530_lib_port_mdb_add()/mt7530_lib_port_mdb_del() handle any failure…
- [Low] This problem wasn't introduced by this patch, but
  mt7530_lib_fdb_write() returns void and ignores every register write.
- [Low] This problem wasn't introduced by this patch, but
  mt7530_port_fdb_dump() returns 0 unconditionally.

--

net: dsa: mt7530: generalize and move common function to lib module

This commit adds a mt7530 library module to prepare for Airoha DSA switch
support, and moves the common MT7530 functions into it under a mt7530_lib
prefix. The functions now use the regmap reg_field API. There is one
common field table, plus per-chip mirror fields taken from the match table.
The commit message says no behaviour change is expected.

> diff --git a/drivers/net/dsa/mt7530-lib.c b/drivers/net/dsa/mt7530-lib.c
> new file mode 100644
> index 0000000000000..098dd45d3ee9f
> --- /dev/null
> +++ b/drivers/net/dsa/mt7530-lib.c

[ ... ]

> +int mt7530_lib_fdb_cmd(struct mt7530_lib_priv *priv, enum mt7530_fdb_cmd cmd,
> +		       u32 mat, u32 *rsp)
> +{

[ ... ]

> +	ret = regmap_field_read_poll_timeout(priv->fields[MT7530_ATC_BUSY],
> +					     val, !val, 20, 20000);
> +	if (ret < 0) {
> +		dev_err(priv->dev, "reset timeout\n");
> +		return ret;
> +	}
> +
> +	regmap_field_read(priv->fields[MT7530_ATC_INVALID], &val);
> +	if (cmd == MT7530_FDB_READ && val)
> +		return -EINVAL;
> +
> +	if (rsp)
> +		regmap_field_read(priv->fields[__MT7530_ATC], rsp);
> +
> +	return 0;
> +}

[Severity: Low]
The old mt7530_fdb_cmd() returned an error if the final regmap_read() of
MT7530_ATC failed. Both regmap_field_read() calls here ignore the return
value.

After a successful busy poll val is 0, and a failed read leaves it at 0.
That means an invalid entry would be reported as success.

A failed read of rsp leaves the previous command's ATC_SRCH_HIT and
ATC_SRCH_END bits in place. Could mt7530_port_fdb_dump() then process stale
search state and report duplicate entries (bounded by cnt)?

mt7530_vlan_cmd() does the same thing with MT7530_VTCR_INVALID. The last
patch in the series wraps these reads in NULL checks, but it still doesn't
check their return values.

Should these reads check their return values as the old code did?

> +
> +static void mt7530_lib_fdb_write(struct mt7530_lib_priv *priv, u16 vid,
> +				 u8 port_mask, const u8 *mac,
> +				 u8 aging, u8 type)
> +{
> +	/* Clear ATWD registers from previous access */
> +	regmap_field_write(priv->fields[__MT7530_ATWD1], 0);
> +	regmap_field_write(priv->fields[__MT7530_ATWD2], 0);
> +	regmap_field_write(priv->fields[__MT7530_ATWD3], 0);
> +
> +	regmap_field_write(priv->fields[MT7530_ATWD_CVID], vid);

[ ... ]

> +	regmap_field_write(priv->fields[MT7530_ATWD_MAC_BYTE_0], mac[0]);
> +}

[Severity: Low]
This isn't a bug introduced by this patch, but mt7530_lib_fdb_write()
returns void and ignores every register write, just like the old
mt7530_fdb_write().

mt7530_lib_port_fdb_add() and mt7530_lib_port_fdb_del() then issue
MT7530_FDB_WRITE even if writing the ATA/ATWD staging registers failed.

Could that write or delete an entry keyed on a partly programmed MAC/VID?

> +
> +void mt7530_lib_fdb_read(struct mt7530_lib_priv *priv, struct mt7530_fdb *fdb)
> +{
> +	u32 val = 0;
> +
> +	regmap_field_read(priv->fields[MT7530_ATRD_CVID], &val);
> +	fdb->vid = val;

[ ... ]

> +	regmap_field_read(priv->fields[MT7530_ATRD_ENT_STATUS], &val);
> +	fdb->noarp = val == STATIC_ENT;
> +}

[Severity: Low]
This isn't a bug, but splitting whole-register accesses into regmap fields
adds a lot of register traffic on the MDIO path, where the regmap has no
cache. Each field write is a read plus a write. Each 32-bit access over
MDIO is a page-select write plus two 16-bit transfers.

The register access counts before and after this patch:

- mt7530_lib_fdb_read(): 10 register reads instead of 3.
- mt7530_lib_fdb_write(): 3 clears plus 12 field read-modify-writes,
  instead of 3 writes.
- mt7530_lib_fdb_cmd(): 3 read-modify-writes, the poll and 2 more reads,
  instead of 1 write, the poll and 1 read.

mt7530_port_fdb_dump() repeats FDB_NEXT plus mt7530_lib_fdb_read() for up
to MT7530_NUM_FDB_RECORDS entries. It does this while holding reg_mutex and
the MDIO bus lock, with about 3x the old bus traffic.

Would it make sense to keep whole-register accesses for the ATA, ATWD,
ATRD and ATC registers?

[ ... ]

> +int mt7530_lib_port_mdb_add(struct mt7530_lib_priv *priv, int port,
> +			    const struct switchdev_obj_port_mdb *mdb,
> +			    struct dsa_db db)
> +{
> +	const u8 *addr = mdb->addr;
> +	u16 vid = mdb->vid;
> +	u8 port_mask = 0;
> +	u32 val;
> +	int ret;
> +
> +	mutex_lock(priv->reg_mutex);
> +
> +	mt7530_lib_fdb_write(priv, vid, 0, addr, 0, STATIC_EMP);
> +	if (!mt7530_lib_fdb_cmd(priv, MT7530_FDB_READ,
> +				ATC_MAT_MACTAB, NULL)) {
> +		regmap_field_read(priv->fields[MT7530_ATRD_PORT_MAP],
> +				  &val);
> +		port_mask = val;
> +	}

[Severity: Medium]
Can val be used uninitialized here? When regmap_read() fails,
regmap_field_read() returns early without writing *val.

The old code called regmap_read() directly on the caller's variable.
mt7530_regmap_read() in mt7530-mdio.c sets *val = 0 first, with the comment
"Callers do not check for errors, keep the value deterministic".
regmap_field_read() reads into its own local reg_val, so that zero no
longer reaches this caller.

On an MDIO read failure, stack garbage would become port_mask and be
written as a STATIC_ENT multicast port map.

mt7530_lib_port_mdb_del() has the same pattern. mt7530_hw_vlan_del() tests
an uninitialized val:

    regmap_field_read(priv->fields[MT7530_VAWD_VLAN_VALID], &val);
    if (!val) {

Should these val variables start at 0, or should the return values be
checked?

> +
> +	port_mask |= BIT(port);
> +	mt7530_lib_fdb_write(priv, vid, port_mask, addr, -1, STATIC_ENT);
> +	ret = mt7530_lib_fdb_cmd(priv, MT7530_FDB_WRITE,
> +				 ATC_MAT_MACTAB, NULL);

[Severity: Low]
This is a pre-existing issue, but any failure of MT7530_FDB_READ (I/O
error or timeout) is handled the same way as a missing entry. In that case
mt7530_lib_port_mdb_add() writes a mask containing only BIT(port), and
mt7530_lib_port_mdb_del() writes STATIC_EMP with a zero mask.

After a failed lookup, can this drop the multicast membership of the other
ports?

[ ... ]

> +static void mt7530_hw_vlan_update(struct mt7530_lib_priv *priv, u16 vid,
> +				  struct mt7530_hw_vlan_entry *entry,
> +				  mt7530_vlan_op vlan_op)
> +{
> +	u32 val = 0;
> +
> +	/* Fetch entry */
> +	mt7530_vlan_cmd(priv, MT7530_VTCR_RD_VID, vid);
> +
> +	regmap_field_read(priv->fields[MT7530_VAWD_PORT_MEM], &val);
> +	entry->old_members = val;
> +
> +	/* Manipulate entry */
> +	vlan_op(priv, entry);
> +
> +	/* Flush result to hardware */
> +	mt7530_vlan_cmd(priv, MT7530_VTCR_WR_VID, vid);
> +}

[Severity: Low]
This isn't a bug introduced by this patch, but mt7530_hw_vlan_update()
ignores the results of the RD_VID command, the PORT_MEM read and the final
WR_VID command. The old code did the same.

vlan_op() can run on stale VAWD data. mt7530_lib_port_vlan_add() and
mt7530_lib_port_vlan_del() then update the PVID state and return 0, even if
the VLAN table write failed.

Should the errors be passed back to the callers?

[ ... ]

> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 50e80585d5585..83cfbd8ee081f 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -24,10 +24,163 @@
>  #include <net/pkt_cls.h>
>  
>  #include "mt7530.h"
> +#include "mt7530-lib.h"

[ ... ]

> +static const struct mt7530_reg_field mt7530_fields[] = {
> +	{ MT7530_MIRROR_EN, REG_FIELD(MT753X_MFC, 3, 3) },
> +	{ MT7530_MIRROR_PORT, REG_FIELD(MT753X_MFC, 0, 2) },
> +};
> +
> +static const struct mt7530_reg_field mt7531_fields[] = {
> +	{ MT7530_MIRROR_EN, REG_FIELD(MT7531_CFC, 19, 19) },
> +	{ MT7530_MIRROR_PORT, REG_FIELD(MT7531_CFC, 16, 18) },
> +};

[Severity: High]
Does MT7530_MIRROR_EN expand to the enum index here? mt7530.h includes
mt7530-lib.h, which declares:

    enum mt7530_regmap_field {
    	MT7530_MIRROR_EN,
    	...

After that include, mt7530.h still keeps the old register bit define:

    #define  MT7530_MIRROR_EN		BIT(3)

So in mt7530.c both tables get id = BIT(3) = 8, which is
MT7530_CCR_TX_OCT_CNT_GOOD in the enum. mt7530-lib.c only includes
mt7530-lib.h, so in the library MT7530_MIRROR_EN is 0.

mt7530_setup_lib_priv() fills in mt753x_fields first and the per-chip
table second. That overwrites fields[8] with the mirror enable field and
leaves fields[0] NULL, since priv comes from devm_kzalloc().

A tc matchall mirred rule then reaches:

mt753x_port_mirror_add()
  mt7530_lib_port_mirror_add()
    regmap_field_read(priv->fields[MT7530_MIRROR_EN], &val)

with a NULL field, and regmap_field_read() dereferences field->regmap.
mt7530_lib_port_mirror_del() also writes through the same NULL field.

mt7530_lib_mib_reset() is called from mt7530_setup() and
mt7531_setup_common(), and does:

    regmap_field_write(priv->fields[MT7530_CCR_TX_OCT_CNT_GOOD], 1);

This would now set the global mirror enable bit (MFC bit 3 or CFC bit 19)
on every setup, and MIB CCR bit 5 would never be set. The old code wrote
CCR_MIB_ACTIVATE, which included TX_OCT_CNT_GOOD.

mt7530.h and mt7530.c aren't changed later in the series, so this seems to
still be present at the end of it. Should the old MT7530_MIRROR_EN define
be removed or renamed?

[ ... ]

> @@ -35,15 +188,15 @@ static struct mt753x_pcs *pcs_to_mt753x_pcs(struct phylink_pcs *pcs)
>  
>  /* String, offset, and register size in bytes if different from 4 bytes */
>  static const struct mt7530_mib_desc mt7530_mib[] = {

[ ... ]

> +	MIB_DESC(MT7530_MIB_TX_DROP, -1, "TxDrop"),

[Severity: Low]
This isn't a bug, but this comment no longer matches the descriptor. The
descriptor now holds regmap field IDs (field_low, field_high, with -1
meaning no high word), not an offset and a size.

The same goes for this comment in mt7530.h:

    /* Each define is an offset of MT7530_PORT_MIB_COUNTER */

Each MT7530_PORT_MIB_* define now includes the MT7530_MIB_COUNTER base and
is used as an absolute port 0 address.

[ ... ]

> @@ -861,38 +833,40 @@ static void mt7530_read_port_stats64(struct mt7530_priv *priv, int port,
>  	 * To simulate a global frame counter, read Unicast and addition Multicast
>  	 * and Broadcast later
>  	 */
> -	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_UNICAST, 1,
> -			       &storage->rx_packets);
> -	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_MULTICAST, 1,
> -			       &storage->multicast);
> -	storage->rx_packets += storage->multicast;
> -	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_BROADCAST, 1,
> -			       &data);
> +	mt7530_lib_read_port_stats(lib_priv->fields[MT7530_MIB_RX_UNICAST],
> +				   NULL, port, &storage->rx_packets);
> +	mt7530_lib_read_port_stats(lib_priv->fields[MT7530_MIB_RX_MULTICAST],
> +				   NULL, port, &data);
> +	storage->rx_packets += data;

[Severity: Medium]
The old code read the RX multicast counter into storage->multicast. The new
code reads it into the scratch variable data and only adds it to
rx_packets. Nothing else in mt7530*.c writes the multicast field now.

mt7530_stats_refresh() starts from a zeroed struct rtnl_link_stats64.
Won't ndo_get_stats64 then always report multicast as 0 on every user port?
The commit message says no behaviour change is expected.

[ ... ]

> @@ -1785,7 +1250,8 @@ mt7530_port_fdb_dump(struct dsa_switch *ds, int port,
>  		}
>  	} while (--cnt &&
>  		 !(rsp & ATC_SRCH_END) &&
> -		 !mt7530_fdb_cmd(priv, MT7530_FDB_NEXT, &rsp));
> +		 !mt7530_lib_fdb_cmd(&priv->lib_priv, MT7530_FDB_NEXT,
> +				     ATC_MAT_MACTAB, &rsp));
>  err:
>  	mutex_unlock(&priv->reg_mutex);
>  

[Severity: Low]
This is a pre-existing issue, but mt7530_port_fdb_dump() still returns 0
unconditionally after this label. A failed FDB_START jumps to err, and a
failed FDB_NEXT ends the loop without keeping its error.

Should the error be returned to dsa_port_fdb_dump(), so an incomplete dump
isn't reported as success?

[ ... ]

> @@ -3509,6 +2738,8 @@ const struct mt753x_info mt753x_table[] = {
>  	},
>  	[ID_AN7583] = {
>  		.id = ID_AN7583,
> +		.reg_fields = mt7531_fields,
> +		.num_reg_fields = ARRAY_SIZE(mt7531_fields),
>  		.pcs_ops = &mt7530_pcs_ops,

[ ... ]

> @@ -3519,6 +2750,8 @@ const struct mt753x_info mt753x_table[] = {
>  	},
>  	[ID_EN7528] = {
>  		.id = ID_EN7528,
> +		.reg_fields = mt7531_fields,
> +		.num_reg_fields = ARRAY_SIZE(mt7531_fields),
>  		.pcs_ops = &mt7530_pcs_ops,

[Severity: Medium]
Is it intended that EN7528 uses mt7531_fields? The MT753X_MIRROR_REG()
macro still in mt7530.h maps only MT7531, MT7988, EN7581 and AN7583 to
MT7531_CFC. Before this patch, EN7528 mirroring used MT753X_MFC with
enable BIT(3) and port GENMASK(2, 0).

Other code that this patch doesn't touch also treats EN7528 as MFC-based.
mt753x_conduit_state_change() groups it with MT7530 and MT7621, and
mt753x_cpu_port_enable() leaves it out of the MT7531_CFC CPU_PMAP chips.

On EN7528, mt7530_lib_port_mirror_add() would now do a read-modify-write
on bits 16..19 of register 0x4 instead of bits 0..3 of MFC. It would still
return success.

AN7583 changes as well. MT753X_MIRROR_EN() did not list ID_AN7583, so its
enable bit was BIT(3) in CFC, which overlaps CPU_PMAP. It is now BIT(19).
If that was an old bug being fixed, could the commit message say so?

The MT753X_MIRROR_* macros are now unused, and they contradict the new
tables for both chips.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925182435.21207-1-ansuelsmth%40gmail.com
