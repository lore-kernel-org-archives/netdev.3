Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214368;
	b=KMdyl/pvgvwj6LYjfCf0NzvJhxVz56qcDyUv1zJqDtxtEH0peh6LHbyf7JWEkuTlLHgO
	 IBquMOk/wVawdp1tluP0x5nSgTMuZ3g7xJYfKp1EHbmSUTO9deen+05RYoJNI7gKxbwYr
	 MCQ/5FjkpfQUNFACog6+VC+M9mmvZQwZWxwi3jxXRqYQMNC0iIQ+AI5mwhKooHQeVKBDs
	 Vs1F+Szcelsi+HNhuFymsTOuYJKssgDnyG+r9GCofeq3m7Aa+QKj2uwN6LseQwymTo73C
	 O9G3zcrXF5R8Lc9Lb7bT436W07VyQOHLzUVB/1pLe1WqsKn8v0WibsKuHZZfSZyd3Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214368;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=NtwLpNnGEAG611hD9yqWEfOA00W4FhB/tDd0pDB3CNk=;
	b=lFgfnIqfw5onEUUQfgumj3U4GYVy97BchYmS468R7kRLzfMWKNs29nGHu5yAsKtLWa6b
	 s53xqA+BcoQsiMtMpIez0wkNON9w3w35Uy2iW6xpInYYTgNevm4yzChlihlHOo72DP2Ir
	 B/jLf2QiYAWWB49Wlcze7rZKJsVmjKjDfdAtll6OMRJ36oYtMNtJfhb8P2tEaqwy5DuXi
	 rZqKh6sMgFu7lBsld67MSyXxdZJBZJCP8ZDimBrDcZJgKs2G+jSp4HAB9vd12Zs5xCkLr
	 hbVsK2cYXdmkUqayvMG4MqK6TMMFX0V6K3v9meJinkcZdTp4vgNsuHYxS5v4aoqiJtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GJXDgsRf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081CC6082BE6;
	Mon,  9 Nov 2026 08:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GJXDgsRf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B312E1F008A2;
	Mon,  9 Nov 2026 08:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794214367;
	bh=NtwLpNnGEAG611hD9yqWEfOA00W4FhB/tDd0pDB3CNk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GJXDgsRf2IfuZEnKi22tLwBIyJksLoSz03YBlOgIF2BCbeXbMhn20PTm3haOqINsF
	 rm+EdGEFogjiJzr8oMk1fpqPLo2XqpUEuwcdmeguWVy8odPwyr3Q5U36zZirQienx2
	 tz0IOGXKpaatpbYfFR2mCz6i+r75PFA4UyYUa4W7xnivDizTqu+qXKSUO9Ipz/jKpa
	 OSvx3fJHaZTyG4ycQn4Nr2oadK6pdZQmZM3aK0B4qcsRiJQvRRzjCE8sRReyECNKYK
	 I2tDTBsLfy/1utNTfquVUe8HcE+l/4qkByRtJIeA1duxJm4SA1jkbzhoMuGmkgMQNF
	 3lsRRfaz3hJ6w==
Subject: Re: [PATCH net-next v9 10/11] net: dsa: realtek: rtl8365mb: make
 L2/LUT access work on family D
From: netdev-bot+sashiko@kernel.org
To: namiltd@yahoo.com
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 alvin.sipraga@analog.com, gusfmora@gmail.com, kuncy7@gmail.com,
 fabianotassotti@gmail.com, gabonpivovich@gmail.com, contact@c127.dev
Date: Mon, 09 Nov 2026 08:52:46 +0000
Message-ID: <179421436631.994134.7851904994584475024@kernel.org>
In-Reply-To: <5df20e9a-2ef8-465e-9b10-ab520c493944@yahoo.com>
References: <5df20e9a-2ef8-465e-9b10-ab520c493944@yahoo.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Family D has no LUT isolation between the one offloaded VLAN-
  unaware bridge and standalone or software-bridged ports, and this can…
- [Low] Part of the commit message is wrong, and two behaviour changes
  are not disclosed.
- [Low] On family D, rtl8365mb_l2_del_uc() runs two separate table
  queries: a READ with METHOD_MAC, then a check of found.port == port,…
- [Low] rtl8365mb_d_lut_init() writes the literal 3000
  (RTL8365MB_D_LUT_AGING_DEFAULT) to the whole 0x0A32 register…

--

net: dsa: realtek: rtl8365mb: make L2/LUT access work on family D

This adds family D (RTL8367S-VB) support to the rtl8365mb L2 table code.
It adds 5-word L2 entry (de)serializers, the family D table access
register widths and a LUT init step. Because family D has no EFID,
port_set_efid() becomes a no-op, fdb_isolation is not advertised, and
only one bridge is offloaded.

> Entries of standalone ports, which DSA also programs with VID 0, use
> the same SVL key and so share FID 0 with a VLAN-unaware bridge. Family
> D has no EFID, so there is no isolation between them in the LUT.

[Severity: Low]
Is this paragraph accurate? On family D, rtl8365mb_setup() no longer sets
ds->fdb_isolation, and both standalone filtering helpers in
net/dsa/user.c require it:

net/dsa/user.c:dsa_switch_supports_uc_filtering() {
	return ds->ops->port_fdb_add && ds->ops->port_fdb_del &&
	       ds->fdb_isolation && !ds->vlan_filtering_is_global &&
	       !ds->needs_standalone_vlan_filtering;
}

dsa_switch_supports_mc_filtering() does the same check. So on family D,
DSA never programs DSA_DB_PORT FDB/MDB entries for standalone ports.
Those ports get no host unicast/multicast RX filtering, and all their
traffic is flooded to the CPU.

The message also says the delete lookup is there "so that a missing
entry is not allocated by the delete". But rtl8365mb_l2_del_uc() also
skips the delete and returns 0 when found.port != port.

Could the commit message describe both of these changes?

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_l2.c b/drivers/net/dsa/realtek/rtl8365mb_l2.c
> index cd5b333932bee..146075f24edf8 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_l2.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_l2.c

[ ... ]

> @@ -349,6 +437,35 @@ int rtl8365mb_l2_del_uc(struct realtek_priv *priv, int port,
>  	fi = rtl8365mb_get_family_info(priv);
>  	fi->l2_uc_to_data(&uc, data);
>  
> +	if (rtl8365mb_is_d(priv)) {
> +		struct rtl8365mb_l2_uc found = { 0 };
> +
> +		/* Do not blind-write: look the entry up first (as the vendor
> +		 * code does) so a missing entry is not (re)allocated. The
> +		 * lookup and the write are separate table queries, so this
> +		 * is not atomic; it relies on FDB operations being
> +		 * serialized by the caller.
> +		 */
> +		ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
> +					    RTL8365MB_TABLE_OP_READ, &addr,
> +					    RTL8365MB_TABLE_L2_METHOD_MAC, 0,
> +					    data, fi->l2_entry_size);
> +		if (ret == -ENOENT)
> +			return 0;
> +		if (ret)
> +			return ret;
> +
> +		/* The key has no EFID on family D, so the entry found may
> +		 * belong to another port or bridge: leave it alone.
> +		 */
> +		fi->l2_data_to_uc(data, &found);
> +		if (found.port != port)
> +			return 0;

[Severity: Low]
Can the hardware change this entry between the lookup and the age 0
write? Each rtl8365mb_table_query() call takes and drops map_lock on its
own, and l2_lock only serializes software callers. The switch's own
learning and aging engine writes the same LUT, so relying on "FDB
operations being serialized by the caller" doesn't cover it.

Only found.port is checked, not found.is_static, so a dynamic entry
with the same MAC and VID/FID key passes the check. If that MAC is
relearned on another port inside the window, the age 0 write (keyed
only on MAC and VID/FID) would delete the entry that now points at the
other port. If the entry ages out inside the window, the write would hit
a missing key, which is what the lookup was meant to avoid.

DSA only programs static entries (uc.is_static = true in
rtl8365mb_l2_add_uc()). Would returning 0 when !found.is_static close
this?

> +
> +		/* rebuild the write payload: the read overwrote data[] */
> +		fi->l2_uc_to_data(&uc, data);
> +	}

[ ... ]

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index e9aac7ec7f4b7..c2b83b7e26235 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
> @@ -460,6 +460,17 @@
>  #define RTL8365MB_LUT_PORT_LEARN_LIMIT_REG(_physport) \
>  		(RTL8365MB_LUT_PORT_LEARN_LIMIT_BASE + (_physport))
>  
> +/* Family D LUT configuration */
> +#define RTL8365MB_D_LUT_CFG_REG			0x0A30
> +#define   RTL8365MB_D_LUT_CFG_BCAM_DISABLE_MASK	BIT(6)
> +#define   RTL8365MB_D_LUT_CFG_IPMC_HASH_MASK	BIT(4)
> +/* On family C this address is the per-port EFID register! */
> +#define RTL8365MB_D_LUT_CFG2_REG		0x0A32
> +/* Written as a whole register: the field layout and the unit of this value
> + * are not documented.
> + */
> +#define   RTL8365MB_D_LUT_AGING_DEFAULT		3000
> +

[ ... ]

> @@ -3628,6 +3643,23 @@ static int rtl8365mb_change_tag_protocol(struct dsa_switch *ds,
>  	return rtl8365mb_cpu_config(priv);
>  }
>  
> +static int rtl8365mb_d_lut_init(struct realtek_priv *priv)
> +{
> +	int ret;
> +
> +	/* After the jam table: lookup multicast by MAC (not DIP) and keep
> +	 * the CAM enabled.
> +	 */
> +	ret = regmap_update_bits(priv->map, RTL8365MB_D_LUT_CFG_REG,
> +				 RTL8365MB_D_LUT_CFG_IPMC_HASH_MASK |
> +				 RTL8365MB_D_LUT_CFG_BCAM_DISABLE_MASK, 0);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(priv->map, RTL8365MB_D_LUT_CFG2_REG,
> +			    RTL8365MB_D_LUT_AGING_DEFAULT);

[Severity: Low]
Is it safe to write 3000 to the whole 0x0A32 register with
regmap_write()? The comment above RTL8365MB_D_LUT_AGING_DEFAULT says the
field layout and the unit are not documented.

If the register holds other fields, such as an aging enable or speed,
or reserved bits that need their reset value, this write overwrites
them. Since the unit is unknown, the resulting aging time for learned
entries is unknown too. It could be roughly 300 seconds or roughly 50
minutes, depending on the unit.

The driver has no .port_set_ageing_time callback, so the bridge's
ageing_time is never applied to the hardware. Family C leaves this
register at its reset default. Would a masked regmap_update_bits(), or
leaving the reset value alone, be safer here?

> +}
> +

[ ... ]

> @@ -3842,9 +3883,16 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
>  		goto out_teardown_irq;
>  
>  	ds->assisted_learning_on_cpu_port = true;
> -	ds->fdb_isolation = true;
> -	/* The EFID is 3 bits, but EFID 0 is reserved for standalone ports */
> -	ds->max_num_bridges = FIELD_MAX(RTL8365MB_EFID_MASK);
> +	if (!rtl8365mb_is_d(priv)) {
> +		ds->fdb_isolation = true;
> +		/* The EFID is 3 bits, but EFID 0 is reserved for standalone */
> +		ds->max_num_bridges = FIELD_MAX(RTL8365MB_EFID_MASK);
> +	} else {
> +		/* No EFID, so bridges cannot be told apart in the LUT: offload
> +		 * only one, others fall back to software forwarding.
> +		 */
> +		ds->max_num_bridges = 1;
> +	}

[Severity: Medium]
Can a hit in the shared FID 0 namespace drop traffic on standalone or
software-bridged ports?

On family D, rtl8365mb_port_set_efid() is a no-op, and the new
serializers map VID 0 to the SVL key:

rtl8365mb_d_l2_uc_to_data():
	bool ivl = uc->key.ivl && uc->key.vid;

rtl8365mb_d_l2_mc_to_data():
	bool ivl = mc->key.ivl && mc->key.vid;

rtl8365mb_vlan_setup() starts every port with PVID 0. That puts three
groups of ports in FID 0 for lookups: standalone ports, ports of bridges
left to software because max_num_bridges = 1, and the offloaded
VLAN-unaware bridge. Ports that are not offloaded have a CPU-only
isolation mask. With fdb_isolation unset, no static CPU host entries
are installed for standalone MACs.

According to the comment in rtl8365mb_l2_add_mc(), the hardware applies
the port isolation masks after the L2 lookup. Suppose a frame from a
standalone port hits an FID 0 entry owned by the offloaded bridge.
Wouldn't the destination mask then be empty, so the frame is dropped
instead of being flooded to the CPU as it would be on a miss?

These cases look reachable:

- A LAN host on a learning bridge port sends frames with the source
  MAC of a standalone WAN port. The switch learns that MAC on the LAN
  port in FID 0, and inbound WAN unicast to the router is black-holed.

- Bridge IGMP snooping installs a VID 0 MDB entry for a group whose
  only members are LAN ports, while the router receives the same group
  on the standalone WAN port. With mc filtering off, no entry adds the
  CPU, so the stream is dropped.

- A host that moves from the offloaded bridge to a software-bridged
  port is black-holed until its learned entry ages out.

On family C the unicast key includes the EFID, so the first case cannot
happen there. The commit message says the isolation masks cover the
missing LUT isolation. Are these drops expected, and should the commit
message mention them?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/9b73858d-fc09-4988-8bab-fd7b88db9412%40yahoo.com
