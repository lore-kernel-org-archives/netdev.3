Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1D3360EF0;
	Thu,  1 Oct 2026 04:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829946; cv=none; b=K6rBRi8s6xvLaqn5T9oXOaxNdh7sDePKloswsFe5NNd7asattig89Kuh28lrI5SgZffvt5kmO3B41kGcUpn34Y/cOv9K9Fzlay2nW/f7nfQYFzdhQ/roLnvYkrQYhChb0JPbGtJyYEcd8WYcipIiKtc1R11S4i2qLnRQUY1fHpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829946; c=relaxed/simple;
	bh=wOhIMFPQYbO61V/m05we6ajnJVrCZVjS5UIzMQ+QHWM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IORTBs9bLTHvgMW6PzdKAwalQyutB/ehwaXsOoOCOnObJSlI61s7EuudSGl/TjyZLFPBeGsaajUN6qG2zH6XlIQiEtTSwGj5A+lMrlg5YeFNpr/tPnwu8d083dRxOpJkxO1cjp/VltrjQNFe4hk17hP6J3uJO7yGwbuTRu2H6eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CD/JLM6t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CD/JLM6t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4441F0089A;
	Thu,  1 Oct 2026 04:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790829939;
	bh=sDnJgVK5znLgl7gxq5TOi28d0oFVLXyskG9y+nmpzF8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CD/JLM6t8Lm71Nbji8I9tfao7oHGQtMOB13uejNTo3HNhpxTeLgJyjao2PcqI5m+y
	 pbIf7efizYD6HTTCJn0buzrb5t2MkXEtOV3MwSmM4+MGdB1zfuJbwUu1o7XhAAMYAR
	 v8g5+fTpNzYN/Xg9Ffo3NNxuW/4pPnAD6bRxj/ROE6uNX9VlRU9tTPV4oq2UW9oAg3
	 HSig87ntjQYQHWOK8Ri1Vysf1JCCuBNQ2s78olk2YKMCcC+ye/8OK9ce9Fwi4oMNWF
	 LV/UTF6SLXOn/NiOxt80oXR+nRMii7HQIlNPhNKF7M8B4ObU+NI9PpOMwmyq95yg8l
	 irXjw0iycynLg==
Subject: Re: [PATCH net-next v24 09/10] net: dsa: mt7530: generalize and move
 common function to lib module
From: netdev-bot+sashiko@kernel.org
To: ansuelsmth@gmail.com
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, chester.a.unal@arinc9.com,
 daniel@makrotopia.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 horms@kernel.org, joey@tinyisr.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 andrew@lunn.ch
Date: Thu, 01 Oct 2026 04:45:37 +0000
Message-ID: <179082993792.434549.3495252150597775203@kernel.org>
In-Reply-To: <20260928194511.41878-10-ansuelsmth@gmail.com>
References: <20260928194511.41878-10-ansuelsmth@gmail.com>
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

Critical: 0 · High: 2 · Medium: 3 (1) · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The name MT7530_MIRROR_EN is defined twice: once as a macro in
  mt7530.h and once as an enum constant in mt7530-lib.h.
- [High] net: dsa: mt7530: spurious command/trigger execution via
  sequential RMW on command registers
- [Medium] The patch changes the mirror register layout used for
  ID_EN7528 and ID_AN7583.
- [Medium] The VLAN table entries written to hardware are different after
  the patch.
- [Medium] Three functions declare `u32 val;` without a starting value,
  pass it to `regmap_field_read()`, ignore the return value, and then…
- [Low] Moving to one regmap_field access per register field sharply
  increases register traffic on MDIO-attached MT7530/MT7531.
- [Low] Two comments were not updated and now contradict the code.
- [Low] After a successful BUSY poll (val==0), the new FDB and VLAN
  command helpers ignore errors from the status reads that follow.

Pre-existing issues:
- [Medium] `mt7530_port_fdb_dump()` stores the callback's -EMSGSIZE from
  `dsa_user_port_fdb_do_dump()` and breaks out of the loop, but always…

--

net: dsa: mt7530: generalize and move common function to lib module

This commit creates an mt7530 library module and moves the common DSA
switch operations there, to prepare for supporting Airoha switches. The
moved functions are rewritten on top of the regmap reg_field API. There
is a common field table, plus per-chip mirror field tables selected
through mt753x_table.

> diff --git a/drivers/net/dsa/mediatek/mt7530-lib.c b/drivers/net/dsa/mediatek/mt7530-lib.c
> new file mode 100644
> index 0000000000000..098dd45d3ee9f
> --- /dev/null
> +++ b/drivers/net/dsa/mediatek/mt7530-lib.c
> @@ -0,0 +1,1128 @@

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

[Severity: High]
Can splitting the command register updates into separate
read-modify-write field updates start a command with half-written
parameters?

The old mt7530_fdb_cmd() and mt7530_vlan_cmd() put BUSY, the command
and its arguments into one value and issued it with a single
regmap_write(). Those values were ATC_BUSY | ATC_MAT(0) | cmd, and
VTCR_BUSY | VTCR_FUNC(cmd) | VTCR_VID(vid).

mt7530_lib_fdb_cmd() now does three regmap_field_write() calls on
MT7530_ATC: MAT, then CMD, then BUSY. mt7530_vlan_cmd() does the same
on MT7530_VTCR with FUNC, VID and BUSY. Each of these reads the
register back and rewrites all the other bits unchanged.

That is only safe while BUSY reads back as 0. Both helpers return
early on a poll timeout and leave BUSY set in hardware, and no caller
clears it.

On the next call, the first field write puts BUSY=1 back into the
register, together with the new MAT (or FUNC) and the previous CMD
(or VID). If the switch treats any write with BUSY set as a new
command, it runs the old command with mixed arguments. The CMD and
BUSY writes that follow can then issue it again.

Here is a concrete case. mt7530_lib_port_fast_age() issues
MT7530_FDB_FLUSH with ATC_MAT_NON_STATIC_MAC. Suppose that times
out. The next mt7530_lib_port_fdb_add() first writes ATC_MAT_MACTAB
while CMD is still FLUSH and BUSY is still set. mt7530_setup() uses
that same combination to flush the whole table, so the static FDB and
MDB entries would be lost.

The VLAN path has the same risk. mt7530_hw_vlan_update() ignores the
result of the RD_VID fetch. After a timeout, the FUNC write could
program whatever is in VAWD1/VAWD2 into the previous VID.

mt7530_lib_mib_reset() has a similar issue. The old code did two
whole-register writes, CCR_MIB_FLUSH and then CCR_MIB_ACTIVATE. The
new code does six read-modify-write updates, so the switch sees four
intermediate MIB_CCR values between disable and enable. If those bits
act as triggers, each write can cause its own flush.

Could each of these registers still be written in one go? For
example, the value could be built from the field definitions and
written through the whole-register __MT7530_ATC field. VTCR and
MIB_CCR would need matching whole-register fields. Or do you have
another way in mind to keep this generic?

[Severity: Low]
Should these two regmap_field_read() calls have their return values
checked?

regmap_field_read() does not write *val when it fails. val then keeps the
0 left by the poll, so a failed read after FDB_READ looks like a
successful lookup.

If the rsp read fails, rsp keeps its previous value, and
mt7530_port_fdb_dump() could repeat or skip entries.

The old helper returned the error:

	if (!ret)
		ret = regmap_read(priv->regmap, MT7530_ATC, &val);

	if (ret < 0) {
		dev_err(priv->dev, "reset timeout\n");
		return ret;
	}

mt7530_vlan_cmd() has the same pattern with MT7530_VTCR_INVALID, so a
failed read there is reported as success.

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mt7530_lib_fdb_cmd);
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
This isn't a bug, but it adds a lot of register traffic on MDIO-attached
MT7530/MT7531. There the regmap has no cache, and each access takes
several MDIO frames:

- mt7530_lib_fdb_write() goes from 3 register writes to 15
  read-modify-write field updates.
- mt7530_lib_fdb_read() goes from 3 reads to 10.
- mt7530_lib_fdb_cmd() and mt7530_vlan_cmd() go from one write to 3
  read-modify-writes plus 2 extra reads.

All of this runs under reg_mutex, including the up to 2048 iterations in
mt7530_port_fdb_dump().

Some updates that used to be a single write are now split. For example,
mt7530_port_set_vlan_unaware() writes VLAN_ATTR, EG_TAG and ACC_FRM of
PVC separately. mt7530_lib_port_change_mtu() writes MAX_RX_JUMBO and
MAX_RX_PKT_LEN separately. A port that is passing traffic briefly runs
with a mix of old and new settings.

Would whole-register writes be better for these multi-field updates?

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
Can port_mask end up holding uninitialized stack data here? val is not
initialized, and regmap_field_read() returns early on a regmap_read()
error without writing *val.

Before this patch these paths called regmap_read() directly, and the MDIO
backend zeroes the output first:

drivers/net/dsa/mediatek/mt7530-mdio.c:mt7530_regmap_read() {
	/* Callers do not check for errors, keep the value deterministic */
	*val = 0;
	...
}

regmap_field_read() reads into its own local variable, so that guarantee
does not reach the caller. If the MDIO read fails, a garbage port map is
ORed with BIT(port) and written into the static multicast entry.

mt7530_lib_port_mdb_del() has the same problem. So does the VLAN_VALID
check in mt7530_hw_vlan_del(), which also uses an uninitialized u32 val.

Would initializing val to 0 be enough here? mt7530_lib_fdb_read() and
mt7530_hw_vlan_update() already do that.

[ ... ]

> +static void mt7530_hw_vlan_del(struct mt7530_lib_priv *priv,
> +			       struct mt7530_hw_vlan_entry *entry)
> +{
> +	u8 new_members;
> +	u32 val;
> +
> +	new_members = entry->old_members & ~BIT(entry->port);
> +
> +	regmap_field_read(priv->fields[MT7530_VAWD_VLAN_VALID], &val);
> +	if (!val) {
> +		dev_err(priv->dev,
> +			"Cannot be deleted due to invalid entry\n");
> +		return;
> +	}
> +
> +	if (new_members) {
> +		regmap_field_write(priv->fields[MT7530_VAWD_IVL_MAC], 1);
> +		regmap_field_write(priv->fields[MT7530_VAWD_VTAG_EN], 1);
> +		regmap_field_write(priv->fields[MT7530_VAWD_PORT_MEM],
> +				   new_members);
> +		regmap_field_write(priv->fields[MT7530_VAWD_VLAN_VALID], 1);

[Severity: Medium]
Is this change to the programmed VLAN entry intended? The old code wrote
all of VAWD1 here:

	val = IVL_MAC | VTAG_EN | PORT_MEM(new_members) |
	      VLAN_VALID;
	regmap_write(priv->regmap, MT7530_VAWD1, val);

That forced FID to 0 and cleared EG_CON and PORT_STAG.

The field writes now keep whatever the VTCR_RD_VID fetch loaded, so the
entry stays on FID_BRIDGED. The VLAN FID selects which FID_PST STP state
in SSP applies. Removing one member from a VLAN therefore now gives
different forwarding and STP behaviour than before.

There are two related changes:

- mt7530_hw_vlan_add() no longer clears EG_CON, PORT_STAG or the other
  VAWD1 bits.
- mt7530_lib_mib_reset() now does read-modify-write on single MIB_CCR
  bits, instead of the two full CCR_MIB_FLUSH and CCR_MIB_ACTIVATE
  writes.

The new FID behaviour may well be more correct, but the commit message
says:

    No behaviour change is expected by this change as it's just a code
    move and reimplementation.

Could these changes be split out, or at least described in the commit
message?

[ ... ]

> diff --git a/drivers/net/dsa/mediatek/mt7530.c b/drivers/net/dsa/mediatek/mt7530.c
> index 50e80585d5585..d0f2691a44a0a 100644
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
Does MT7530_MIRROR_EN expand to the enum index here?

mt7530.h includes mt7530-lib.h, where MT7530_MIRROR_EN is the first
member of enum mt7530_regmap_field (value 0). mt7530.h still keeps the
old register bit macro with the same name:

drivers/net/dsa/mediatek/mt7530.h:
	#include "mt7530-lib.h"
	...
	#define  MT7530_MIRROR_EN		BIT(3)

mt7530.c includes mt7530.h, so both initializers above become
{ 8, REG_FIELD(...) }.

mt7530_setup_lib_priv() handles the per-chip table after the common one:

	lib_priv->fields[reg_field->id] = field;

The mirror enable field therefore ends up in fields[8], which is
MT7530_CCR_TX_OCT_CNT_GOOD. fields[0] stays NULL. mt7530-lib.c only sees
the enum, so it uses index 0.

Wouldn't the first tc matchall mirred rule then oops on a NULL
regmap_field?

mt753x_port_mirror_add()
  mt7530_lib_port_mirror_add()
    regmap_field_read(priv->fields[MT7530_MIRROR_EN], &val);

mt7530_lib_port_mirror_del() does the same with regmap_field_write().

mt7530_lib_mib_reset(), called from mt7530_setup() and
mt7531_setup_common(), would also set the global mirror enable bit
(MFC bit 3 or CFC bit 19) instead of MIB_CCR bit 5:

	regmap_field_write(priv->fields[MT7530_CCR_TX_OCT_CNT_GOOD], 1);

The macro and the enum constant both still seem to be there at the end of
the series (the AN8855 driver patch), so a later patch does not fix this.

[ ... ]

> @@ -35,15 +188,15 @@ static struct mt753x_pcs *pcs_to_mt753x_pcs(struct phylink_pcs *pcs)
>  
>  /* String, offset, and register size in bytes if different from 4 bytes */
>  static const struct mt7530_mib_desc mt7530_mib[] = {

[Severity: Low]
This isn't a bug, but this comment is now out of date. MIB_DESC() takes
(field_low, field_high, name) regmap field indices, not an offset and a
size.

The "Each define is an offset of MT7530_PORT_MIB_COUNTER" comment in
mt7530.h is also wrong now, because the MT7530_PORT_MIB_* defines include
MT7530_MIB_COUNTER.

> -	MIB_DESC(1, MT7530_PORT_MIB_TX_DROP, "TxDrop"),

[ ... ]

> +	MIB_DESC(MT7530_MIB_TX_DROP, -1, "TxDrop"),

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

[Severity: Medium]
This patch did not introduce this, but mt7530_port_fdb_dump() drops the
callback's error:

	ret = cb(_fdb.mac, _fdb.vid, _fdb.noarp, data);
	if (ret < 0)
		break;
	...
err:
	mutex_unlock(&priv->reg_mutex);

	return 0;

When dsa_user_port_fdb_do_dump() returns -EMSGSIZE because the skb is
full, rtnl_fdb_dump() gets 0. It then moves on to the next device and
resets fdb_idx.

Wouldn't that leave the rest of a large FDB out of "bridge fdb show"?

[ ... ]

> @@ -3509,6 +2738,8 @@ const struct mt753x_info mt753x_table[] = {
>  	},
>  	[ID_AN7583] = {
>  		.id = ID_AN7583,
> +		.reg_fields = mt7531_fields,
> +		.num_reg_fields = ARRAY_SIZE(mt7531_fields),
>  		.pcs_ops = &mt7530_pcs_ops,
>  		.sw_setup = mt7988_setup,
>  		.phy_read_c22 = mt7531_ind_c22_phy_read,
> @@ -3519,6 +2750,8 @@ const struct mt753x_info mt753x_table[] = {
>  	},
>  	[ID_EN7528] = {
>  		.id = ID_EN7528,
> +		.reg_fields = mt7531_fields,
> +		.num_reg_fields = ARRAY_SIZE(mt7531_fields),

[Severity: Medium]
Is it intended that EN7528 and AN7583 now use mt7531_fields?

The old MT753X_MIRROR_REG() and MT753X_MIRROR_PORT_*() macros chose
MT7531_CFC only for MT7531, MT7988, EN7581 and AN7583. EN7528 therefore
used MT753X_MFC: bit 3 for enable and bits 2:0 for the monitor port. It
now programs MT7531_CFC bits 19 and 18:16 instead.

Other parts of the driver still treat EN7528 like MT7530. For example,
mt753x_conduit_state_change() has:

	if (priv->id != ID_MT7530 && priv->id != ID_MT7621 &&
	    priv->id != ID_EN7528)
		return;

Also, mt753x_cpu_port_enable() does not program the CFC CPU_PMAP for
EN7528.

Could this be a regression that breaks port mirroring on EN7528?

For AN7583, MT753X_MIRROR_EN() left it out, so it used to set CFC bit 3,
which is inside CPU_PMAP. It now uses CFC bit 19. That looks like a real
fix, but the commit message says "No behaviour change is expected".

Should the AN7583 change be a separate patch with its own description?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928194511.41878-1-ansuelsmth%40gmail.com
