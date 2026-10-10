Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178C4353A8C;
	Sat, 10 Oct 2026 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791649169; cv=none; b=T0J/gQ23FjR5FNbiKLhXbQusm+xl1Mw6M4JObg/d0KFWmvgtSIoq+GfBCx95bWWvK238iqnvZ8qiT5F2S8omhwQveV/FigwK1xpPjqc6euE5Q/w1t9uzOClFMfjtB8g8UTU5lA/QKvG60l7Dwfg0RAdrY3yGwBwhGkBXJKCAgGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791649169; c=relaxed/simple;
	bh=LkBP6vHu+KDlcj5Q3hJd8EZMGqtK+7Md/B4cEVG54Zk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l2nS76iJG3wJh29L3j0Uecy9MEO92GO0BuqQIV0M15Bao2ZlwRnfDvOPA5zLLMtlRCPmDxgh3PnDbM/5vFKIJtt07qiqMkpogLxwcTHeTjw51a72hgdnMiLeSd8sXm/ap3LV/Qoh4iImEe2uYBXHfUjpWDCWoEXCv1ZZmHFYBCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErhWKQV5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErhWKQV5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0919E1F0089C;
	Sat, 10 Oct 2026 16:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791649165;
	bh=2juRqnHEQQLVS1LEV/+MTd0BnnLRiFZT11y27leIL5A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ErhWKQV5Nflr4Ej+QtCFF4io4fPK+B5DuAq/xcA6VCIK83dkaqVfKyiaLlB25sq8q
	 ffR+Pv+7LPEEQeMUI2mvJFxGs0IGYz8tTYMAkrWH9g63+XFZaPyO4BaFFmXnbwb4S+
	 /HQrtIaiQMb5yMc05E68pkrkr2zxJfmWAvTmt3UgfzmsDLut2OWWVIgSp7a3ZBkUpj
	 3EX2IaD14t2L/kGgyjw2lYnBynYoVetxHtyig+d7nPylcngB/wbg1yYGH8zzZo+lue
	 3kFDCqkHgc2ZpSHMHIgf2YAn1GcFzlC0YJWydyG4e7TkGDZr75e91ReWNhhzrNc1Pu
	 oJZ0/N8VxsJBQ==
Subject: Re: [PATCH net-next v25 09/10] net: dsa: mt7530: generalize and move
 common function to lib module
From: netdev-bot+sashiko@kernel.org
To: ansuelsmth@gmail.com
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, chester.a.unal@arinc9.com,
 daniel@makrotopia.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 horms@kernel.org, joey@tinyisr.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 andrew@lunn.ch
Date: Sat, 10 Oct 2026 16:19:23 +0000
Message-ID: <179164916348.434549.6628066246745434268@kernel.org>
In-Reply-To: <20261009161102.38961-10-ansuelsmth@gmail.com>
References: <20261009161102.38961-10-ansuelsmth@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 4 (1) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Name collision between the new enum constant and an old register
  macro in drivers/net/dsa/mediatek/mt7530.c.
- [High] net: severe MDIO bus performance regression via sequential
  regmap_field accesses
- [Medium] EN7528 port mirroring now programs the wrong register.
- [Medium] VLAN table entries written by
  mt7530_hw_vlan_add()/mt7530_hw_vlan_del()…
- [Medium] Failed final status reads are treated as success.
- [Medium] The switch to regmap_field_read() introduces uninitialized
  stack reads.
- [Low] mt7530_lib_mib_reset() replaces the two full writes to
  MT7530_MIB_CCR (CCR_MIB_FLUSH = 0xF0, then CCR_MIB_ACTIVATE =…
- [Low] Two comments no longer match the definitions they describe.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  mt7530_port_fdb_dump() saves the callback's return value (for example…

--

net: dsa: mt7530: generalize and move common function to lib module

This moves the common MT7530 FDB, VLAN, bridge, mirror, MTU and MIB
helpers into a new mt7530-lib module. They are reimplemented on top of the
regmap_field API, and the per-chip mirror register layout is now
described by a reg_field table in mt753x_info. The commit message states
that no behaviour change is expected.

> diff --git a/drivers/net/dsa/mediatek/mt7530-lib.c b/drivers/net/dsa/mediatek/mt7530-lib.c
> new file mode 100644
> index 0000000000000..098dd45d3ee9f
> --- /dev/null
> +++ b/drivers/net/dsa/mediatek/mt7530-lib.c
> @@ -0,0 +1,1128 @@

[ ... ]

> +void mt7530_lib_mib_reset(struct mt7530_lib_priv *priv)
> +{
> +	regmap_field_write(priv->fields[MT7530_CCR_MIB_ENABLE], 0);
> +	regmap_field_write(priv->fields[MT7530_CCR_RX_OCT_CNT_GOOD], 1);
> +	regmap_field_write(priv->fields[MT7530_CCR_RX_OCT_CNT_BAD], 1);
> +	regmap_field_write(priv->fields[MT7530_CCR_TX_OCT_CNT_GOOD], 1);
> +	regmap_field_write(priv->fields[MT7530_CCR_TX_OCT_CNT_BAD], 1);
> +	regmap_field_write(priv->fields[MT7530_CCR_MIB_ENABLE], 1);
> +}

[Severity: Low]
Is this sequence equivalent to the old one? The removed
mt7530_mib_reset() wrote the whole register twice:

    regmap_write(priv->regmap, MT7530_MIB_CCR, CCR_MIB_FLUSH);
    regmap_write(priv->regmap, MT7530_MIB_CCR, CCR_MIB_ACTIVATE);

regmap_field_write() is a read-modify-write that skips the bus write when
the value is unchanged. If MIB_ENABLE already reads as 0, the flush write
is never sent.

Bits 30:8 and 3:0 of MT7530_MIB_CCR are also no longer forced to 0, so
reset or bootloader values in those bits survive.

Could this change how the MIB counters get cleared and activated compared
with the old code? Separately, the MT7530_CCR_TX_OCT_CNT_GOOD write is
misrouted by the MT7530_MIRROR_EN collision described further down.

[ ... ]

> +int mt7530_lib_fdb_cmd(struct mt7530_lib_priv *priv, enum mt7530_fdb_cmd cmd,
> +		       u32 mat, u32 *rsp)
> +{

[Severity: High]
How much extra MDIO traffic does this add on MDIO-connected switches?
On MT7530 and MT7531, each 32-bit register access already costs
several MDIO frames. mt7530_regmap_read() and mt7530_regmap_write()
each issue a page select plus two 16-bit transfers.

The old mt7530_fdb_read() did three regmap_read() calls, on TSRA1,
TSRA2 and ATRD. This version does ten regmap_field_read() calls, and
each one is a separate bus read of one of those same three registers.
That is more than three times the bus traffic for every entry.

The write side is worse. regmap_field_write() goes through
regmap_update_bits_base(). These regmaps don't appear to have a
register cache, and the ARL registers are volatile anyway. So each
call is a bus read, followed by a write when the value differs.

mt7530_lib_fdb_write() does three clearing writes and then twelve
field writes. That is up to 15 reads and 15 writes, where
mt7530_fdb_write() did three plain regmap_write() calls.
mt7530_lib_fdb_cmd() likewise turns the single ATC write into three
read-modify-write cycles before the BUSY poll.

mt7530_port_fdb_dump() goes through this path once per entry, up to
MT7530_NUM_FDB_RECORDS times, while holding reg_mutex. Every
port_fdb_add/del and port_mdb_add/del also pays the expanded cost.
The VLAN paths do too: mt7530_hw_vlan_add(), mt7530_hw_vlan_del() and
mt7530_lib_setup_vlan0() now do one read-modify-write per field. The
old code built VAWD1 in software and wrote it once.

The result is a large increase in FDB dump and update latency. It also
adds a lot of MDIO bus load that the PHYs on the same bus have to
compete with. That doesn't seem to fit "No behaviour change is
expected".

Could the library build the full ATA1/ATA2/ATWD and VAWD1 values in
software and write each register once? On the read side, it could read
TSRA1/TSRA2/ATRD once and extract the fields from those values. The
per-chip layout could then be described with masks rather than
separate regmap_field accesses. Alternatively, were FDB dump times
measured on an MDIO-attached MT7531 before and after this change?

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

[Severity: Medium]
What happens here if one of these final reads fails? After a successful
BUSY poll, val is 0. regmap_field_read() returns early on error without
touching its output:

    ret = regmap_read(field->regmap, field->reg, &reg_val);
    if (ret != 0)
        return ret;

A failed ATC_INVALID read therefore makes a failed FDB_READ look like a
valid hit. The unchecked rsp read leaves the caller's previous rsp in
place, so mt7530_port_fdb_dump() could act on stale ATC_SRCH_HIT or
ATC_SRCH_END bits.

mt7530_vlan_cmd() does the same with the MT7530_VTCR_INVALID read and
returns 0.

The removed helpers propagated these errors:

    if (!ret)
        ret = regmap_read(priv->regmap, MT7530_ATC, &val);

    if (ret < 0) {
        ...
        return ret;
    }

Should the return values of these reads be checked?

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
Can val be used uninitialized here? regmap_field_read() reads into its own
temporary and does not assign *val when regmap_read() fails.

Before this patch, regmap_read() passed the caller's pointer straight down
to mt7530_regmap_read() in mt7530-mdio.c, which does:

    /* Callers do not check for errors, keep the value deterministic */
    *val = 0;

With the field API that zeroing only reaches the temporary inside
regmap_field_read(). On an MDIO read failure, an indeterminate port_mask
would then be written back into the ARL entry.

The same pattern appears in mt7530_lib_port_mdb_del() with
MT7530_ATRD_PORT_MAP. It also appears in mt7530_hw_vlan_del(), which
branches on an uninitialized val after reading MT7530_VAWD_VLAN_VALID.

[ ... ]

> +static void mt7530_hw_vlan_add(struct mt7530_lib_priv *priv,
> +			       struct mt7530_hw_vlan_entry *entry)
> +{

[ ... ]

> +	regmap_field_write(priv->fields[MT7530_VAWD_IVL_MAC], 1);
> +	regmap_field_write(priv->fields[MT7530_VAWD_VTAG_EN], 1);
> +	regmap_field_write(priv->fields[MT7530_VAWD_PORT_MEM],
> +			   new_members);
> +	regmap_field_write(priv->fields[MT7530_VAWD_FID],
> +			   FID_BRIDGED);
> +	regmap_field_write(priv->fields[MT7530_VAWD_VLAN_VALID], 1);

[ ... ]

> +	if (new_members) {
> +		regmap_field_write(priv->fields[MT7530_VAWD_IVL_MAC], 1);
> +		regmap_field_write(priv->fields[MT7530_VAWD_VTAG_EN], 1);
> +		regmap_field_write(priv->fields[MT7530_VAWD_PORT_MEM],
> +				   new_members);
> +		regmap_field_write(priv->fields[MT7530_VAWD_VLAN_VALID], 1);
> +	} else {

[Severity: Medium]
Are these VLAN entries still fully defined? The old mt7530_hw_vlan_add()
wrote the whole register:

    val = IVL_MAC | VTAG_EN | PORT_MEM(new_members) | FID(FID_BRIDGED) |
          VLAN_VALID;
    regmap_write(priv->regmap, MT7530_VAWD1, val);

That cleared EG_CON (bit 29) and PORT_STAG (bit 31). The field
read-modify-writes here keep whatever RD_VID or an earlier access left in
VAWD1.

mt7530_hw_vlan_update() ignores the result of:

    mt7530_vlan_cmd(priv, MT7530_VTCR_RD_VID, vid);

If that command fails, VAWD1 can still hold the VID 0 entry staged by
mt7530_lib_setup_vlan0() with EG_CON set. Could the new VLAN then be
written with EG_CON=1, overriding the per-VLAN ETAG?

In mt7530_hw_vlan_del() with members remaining, the old code wrote VAWD1
without FID, which reset it to 0 (FID_STANDALONE). The new code keeps
FID_BRIDGED. Does that change which FID_PST STP state applies to the VLAN
after a member is removed?

Even if the new behaviour is preferable, it seems to differ from "No
behaviour change is expected".

[ ... ]

> diff --git a/drivers/net/dsa/mediatek/mt7530.c b/drivers/net/dsa/mediatek/mt7530.c
> index 7781a63b4e6fd..6087e5826780f 100644
> --- a/drivers/net/dsa/mediatek/mt7530.c
> +++ b/drivers/net/dsa/mediatek/mt7530.c
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
Does MT7530_MIRROR_EN expand to the new enum value in these tables?
mt7530.h includes mt7530-lib.h but still keeps the old register macro:

    #define  MT7530_MIRROR_EN		BIT(3)

In enum mt7530_regmap_field, MT7530_MIRROR_EN is 0 and
MT7530_CCR_TX_OCT_CNT_GOOD is 8. By the time these tables are compiled in
mt7530.c the macro is defined, so their id becomes BIT(3), which is 8.

mt7530_setup_lib_priv() then does:

    lib_priv->fields[reg_field->id] = field;

That overwrites fields[MT7530_CCR_TX_OCT_CNT_GOOD] with the mirror enable
field and leaves fields[0] NULL. mt7530-lib.c does not include mt7530.h,
so MT7530_MIRROR_EN is 0 there.

Wouldn't this oops when a matchall mirror is offloaded?

  mt753x_port_mirror_add()
    mt7530_lib_port_mirror_add()
      regmap_field_read(priv->fields[MT7530_MIRROR_EN], &val)
        field->regmap on a NULL field

mt7530_lib_port_mirror_del() would hit the same NULL in
regmap_field_write().

Also, on every setup:

  mt7530_setup() / mt7531_setup_common()
    mt7530_lib_mib_reset()
      regmap_field_write(priv->fields[MT7530_CCR_TX_OCT_CNT_GOOD], 1)

This now sets MFC bit 3 (or CFC bit 19), enabling the mirror engine at
boot, and MIB_CCR bit 5 is never set.

Would dropping or renaming the old MT7530_MIRROR_EN macro in mt7530.h
avoid this? The collision appears to still be present at the end of the
series.

[ ... ]

> @@ -35,15 +188,15 @@ static struct mt753x_pcs *pcs_to_mt753x_pcs(struct phylink_pcs *pcs)
>  
>  /* String, offset, and register size in bytes if different from 4 bytes */
>  static const struct mt7530_mib_desc mt7530_mib[] = {

[ ... ]

> +	MIB_DESC(MT7530_MIB_TX_DROP, -1, "TxDrop"),

[Severity: Low]
This isn't a bug, but the comment above mt7530_mib[] still describes
offset and size. struct mt7530_mib_desc now holds field_low and
field_high regmap field indices.

In mt7530.h, "Each define is an offset of MT7530_PORT_MIB_COUNTER" no
longer holds either. The MT7530_PORT_MIB_* macros are now absolute port 0
addresses (MT7530_MIB_COUNTER + off), and the "64 bytes" notes now sit on
the *_BYTES_LOW halves.

Both comments are still present at the end of the series.

[ ... ]

> @@ -1769,13 +1233,14 @@ mt7530_port_fdb_dump(struct dsa_switch *ds, int port,
>  
>  	mutex_lock(&priv->reg_mutex);
>  
> -	ret = mt7530_fdb_cmd(priv, MT7530_FDB_START, &rsp);
> +	ret = mt7530_lib_fdb_cmd(&priv->lib_priv, MT7530_FDB_START,
> +				 ATC_MAT_MACTAB, &rsp);
>  	if (ret < 0)
>  		goto err;
>  
>  	do {
>  		if (rsp & ATC_SRCH_HIT) {
> -			mt7530_fdb_read(priv, &_fdb);
> +			mt7530_lib_fdb_read(&priv->lib_priv, &_fdb);
>  			if (_fdb.port_mask & BIT(port)) {
>  				ret = cb(_fdb.mac, _fdb.vid, _fdb.noarp,
>  					 data);
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

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. The
function saves ret from cb() and breaks out of the loop, but always ends
with:

err:
	mutex_unlock(&priv->reg_mutex);

	return 0;

dsa_user_port_fdb_do_dump() returns -EMSGSIZE once the netlink skb is
full, and rtnl_fdb_dump() only keeps its continuation position for
-EMSGSIZE. Could the remaining FDB entries be silently dropped from a
multi-part bridge fdb show?

[ ... ]

> @@ -3513,6 +2744,8 @@ const struct mt753x_info mt753x_table[] = {
>  	},
>  	[ID_EN7528] = {
>  		.id = ID_EN7528,
> +		.reg_fields = mt7531_fields,
> +		.num_reg_fields = ARRAY_SIZE(mt7531_fields),
>  		.pcs_ops = &mt7530_pcs_ops,
>  		.sw_setup = mt7988_setup,
>  		.phy_read_c22 = mt7531_ind_c22_phy_read,

[Severity: Medium]
Should EN7528 use mt7530_fields here? The old MT753X_MIRROR_REG(),
MT753X_MIRROR_EN() and related macros in mt7530.h only selected
MT7531_CFC for ID_MT7531, ID_MT7988, ID_EN7581 and ID_AN7583. EN7528
therefore used MT753X_MFC, with enable at bit 3 and the monitor port in
bits 2:0.

With mt7531_fields, mt7530_lib_port_mirror_add() and
mt7530_lib_port_mirror_del() on EN7528 now read-modify-write MT7531_CFC
bit 19 and bits 18:16 instead.

The rest of the driver treats EN7528 as having the MT7530-style MFC
layout:

    if (priv->id != ID_MT7530 && priv->id != ID_MT7621 &&
        priv->id != ID_EN7528)
            return;

That is from mt753x_conduit_state_change(). mt753x_cpu_port_enable() also
skips the MT7531_CFC CPU_PMAP setup for EN7528.

Does mirroring then silently stop working on EN7528, while bits get
written in a register this chip otherwise doesn't program? The
MT7530_MIRROR_EN collision above currently crashes earlier in this path,
but this mapping would remain once that is fixed. It is unchanged at the
end of the series.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009161102.38961-1-ansuelsmth%40gmail.com
