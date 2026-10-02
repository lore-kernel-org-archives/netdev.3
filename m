Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F766448CF6;
	Fri,  2 Oct 2026 21:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975664; cv=none; b=rp/Zs2STwbaBLpf8X6Pdz7O1RKlBOe1qX1kMU8s4b7jlIRAAjcdC2bXlIk7uJdwoRUlVcP96DyaAXXMAakb5R8YhdQ/2aRivViBYnR/fM3Pe9+CG3d63ZsZwKJs6SQaI5jioCriGeAs4F2wnMSoaEzu6pbOh7fbClPTpNfVAcog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975664; c=relaxed/simple;
	bh=awgzGu4sxFCFxD48Lb+IbUwCn63+qQjYheIp/Nc2lmw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kL4uJr+0H6wJGR+n2yfKV37t4BCPJ9URLW8wyQ9cwKf1avc7AJdITv1oIaOHvTJYhjI2YWom8WTEf4xKxzlZ3Z+LyGxi+JQUM6J9Y41e+dkode51MNJBP+qjmiF/4sJ+CoxiLPBeVRXc+b0niXQ4lNrEHhIC05erVSzdjte9acE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODeo93Fm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODeo93Fm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E441F000FF;
	Fri,  2 Oct 2026 21:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790975663;
	bh=T/YZm+aul8tdAvjGCsYn21TD0yXQoycOQC/NLVGGiRg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ODeo93FmlvPF9F/ygKb9Ht554BmbK7h4L7Mm+Dy0QVeaRwJXL2Sf3UGo8olXz4kuY
	 /0tE4aFRGUqSH4l+rJhLBvqXyVo042uuGN9yiOA06VqIVe36cLN15ppyxldb2uyYMu
	 +1cexbolq9etBVq3/alxPr9KcH8zKI0q2iFu2nVTELSJ/Ri97/77iU6w9Kb5YeRM+H
	 S9dWmwaKcas2wHpWET6DCDXaHeh8qyka0z7qAa6TsfzcSMzc5OZuvjjXMBSePFiNT8
	 yIovJNTLz2dX6RgAPAVRWgKAYjhUuNRPcc8qUcvxtufLY408hI2Z6jIqefFxJXAGj+
	 1PWvFTUUv/3ag==
Subject:
 Re: [PATCH net-next v13 6/9] net: dsa: lan9645x: add mac table integration
From: netdev-bot+sashiko@kernel.org
To: jensemil.schulzostergaard@microchip.com
Cc: UNGLinuxDriver@microchip.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 woojung.huh@microchip.com, linux@armlinux.org.uk,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 geert+renesas@glider.be, magnus.damm@gmail.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Date: Fri, 02 Oct 2026 21:14:21 +0000
Message-ID: <179097566160.434549.9925459819174275044@kernel.org>
In-Reply-To:
 <20260929-dsa_lan9645x_switch_driver_base-v13-6-827c2d3617f2@microchip.com>
References:
 <20260929-dsa_lan9645x_switch_driver_base-v13-6-827c2d3617f2@microchip.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] For a non-zero VID, lan9645x_fdb_add() and lan9645x_fdb_del()
  map DSA_DB_PORT and DSA_DB_BRIDGE host entries to the same hardware…
- [Low] Each new MAC table sequence writes the key, the filter and the
  command through lan_wr().

--

net: dsa: lan9645x: add mac table integration

This commit adds MAC table support to the lan9645x DSA driver. It adds
learn, forget, flush and GET_NEXT based dump helpers keyed on (vid, mac).
These are wired into the port_fast_age, port_fdb_dump, port_fdb_add and
port_fdb_del DSA callbacks.

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c
> new file mode 100644
> index 0000000000000..50ce1378b9dae
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c
> @@ -0,0 +1,268 @@

[ ... ]

> +static void lan9645x_mac_select(struct lan9645x *lan9645x,
> +				const unsigned char mac[ETH_ALEN],
> +				unsigned int vid)
> +{
> +	u64 maddr = ether_addr_to_u64(mac);
> +
> +	lockdep_assert_held(&lan9645x->mact_lock);
> +
> +	lan_wr(ANA_MACHDATA_VID_SET(vid) |
> +	       ANA_MACHDATA_MACHDATA_SET(upper_32_bits(maddr)),
> +	       lan9645x,
> +	       ANA_MACHDATA);
> +
> +	lan_wr(lower_32_bits(maddr),
> +	       lan9645x,
> +	       ANA_MACLDATA);
> +}

[ ... ]

> +static int __lan9645x_mact_learn(struct lan9645x *lan9645x, int port,
> +				 const unsigned char mac[ETH_ALEN],
> +				 unsigned int vid,
> +				 enum macaccess_entry_type type,
> +				 bool cpu_copy)
> +{
> +	lockdep_assert_held(&lan9645x->mact_lock);
> +
> +	lan9645x_mac_select(lan9645x, mac, vid);
> +
> +	lan_wr(ANA_MACACCESS_VALID_SET(1) |
> +	       ANA_MACACCESS_DEST_IDX_SET(port) |
> +	       ANA_MACACCESS_MAC_CPU_COPY_SET(cpu_copy) |
> +	       ANA_MACACCESS_ENTRYTYPE_SET(type) |
> +	       ANA_MACACCESS_MAC_TABLE_CMD_SET(CMD_LEARN),
> +	       lan9645x, ANA_MACACCESS);
> +
> +	return lan9645x_mac_wait_for_completion(lan9645x, NULL);
> +}

[Severity: Low]
Can a failed register write here be reported to DSA as a successful learn?

lan_wr() returns void and only calls WARN_ON_ONCE() when regmap_write()
fails. Suppose the ANA_MACACCESS command write is lost but the reads that
follow still work. Then lan9645x_mac_wait_for_completion() sees CMD_IDLE
immediately and returns 0:

	err = lan9645x_rd_poll_timeout(lan9645x, ANA_MACACCESS, val,
				       ANA_MACACCESS_MAC_TABLE_CMD_GET(val) ==
				       CMD_IDLE);

In that case lan9645x_fdb_add() returns success and the bridge marks the
entry as offloaded, but the table was never changed. The same applies to
CMD_FORGET in __lan9645x_mact_forget().

What happens if only the ANA_MACHDATA or ANA_MACLDATA write in
lan9645x_mac_select() fails? Would CMD_LEARN or CMD_FORGET then act on a
stale key? That could be the previous operation's key, or whatever the
last GET_NEXT walk in lan9645x_mact_dsa_dump() left in the registers.

lan9645x_mact_flush() has the same problem with its ANA_ANAGEFIL write:

	lan_wr(ANA_ANAGEFIL_PID_EN_SET(1) |
	       ANA_ANAGEFIL_PID_VAL_SET(port),
	       lan9645x, ANA_ANAGEFIL);

If that write fails, both CMD_AGE scans would run without the port
filter. Would that flush dynamic entries from every port instead of only
the requested one?

This only happens if the parent MFD bus can fail a write while later
reads succeed. The parent driver is not in the tree, so that could not be
confirmed. The ocelot-family drivers follow the same lan_wr() convention.

[ ... ]

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> index 6818b91f4bed2..5cb4f5fe13740 100644
> --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c

[ ... ]

> @@ -360,6 +364,81 @@ static int lan9645x_port_vlan_del(struct dsa_switch *ds, int port,

[ ... ]

> +static int lan9645x_fdb_add(struct dsa_switch *ds, int port,
> +			    const unsigned char *addr, u16 vid,
> +			    struct dsa_db db)
> +{

[ ... ]

> +	if (dsa_port_is_cpu(dp) && !br &&
> +	    dsa_fdb_present_in_other_db(ds, port, addr, vid, db))
> +		return 0;
> +
> +	if (!vid)
> +		vid = lan9645x_vlan_unaware_pvid(!!br);
> +
> +	dest = dsa_port_is_cpu(dp) ? PGID_CPU : port;
> +
> +	return lan9645x_mact_learn(lan9645x, dest, addr, vid, ENTRYTYPE_LOCKED,
> +				   false);
> +}
> +
> +static int lan9645x_fdb_del(struct dsa_switch *ds, int port,
> +			    const unsigned char *addr, u16 vid,
> +			    struct dsa_db db)
> +{
> +	struct net_device *br = lan9645x_db2bridge(db);
> +	struct dsa_port *dp = dsa_to_port(ds, port);
> +	struct lan9645x *lan9645x = ds->priv;
> +
> +	if (IS_ERR(br))
> +		return PTR_ERR(br);
> +
> +	if (dsa_port_is_cpu(dp) && !br &&
> +	    dsa_fdb_present_in_other_db(ds, port, addr, vid, db))
> +		return 0;
> +
> +	if (!vid)
> +		vid = lan9645x_vlan_unaware_pvid(!!br);
> +
> +	return lan9645x_mact_forget(lan9645x, addr, vid, ENTRYTYPE_LOCKED);
> +}

[Severity: Medium]
Could this forget a CPU port entry that another database still needs?

For a non-zero vid, lan9645x_fdb_add() and lan9645x_fdb_del() map two
host entries with the same (vid, mac) to one hardware key pointing at
PGID_CPU: the DSA_DB_PORT one and the DSA_DB_BRIDGE one. Only vid 0 is
split, into HOST_PVID and UNAWARE_PVID by lan9645x_vlan_unaware_pvid().

DSA refcounts the two entries separately on the CPU port, because
dsa_mac_addr_find() includes the db in its key. The shared-key guard only
matches entries of the same db type:

net/dsa/dsa.c:dsa_fdb_present_in_other_db() {
    ...
	if (a->db.type == db.type && !dsa_db_equal(&a->db, &db))
		return true;
    ...
}

So when a DSA_DB_PORT entry is deleted, the guard never sees a
DSA_DB_BRIDGE entry with the same key. For DSA_DB_BRIDGE deletions, the
!br check skips the guard entirely.

One way to hit this:

- swp1 is in a VLAN-aware bridge.
- swp1.100 is a VLAN upper whose MAC M differs from swp1's.
- dsa_user_vlan_rx_add_vid()->dsa_user_schedule_standalone_work(DSA_UC_ADD)
  installs a DSA_DB_PORT host entry (M, 100).
- M is also a bridge host address in VID 100, which adds a DSA_DB_BRIDGE
  host entry (M, 100). This happens, for example, with br0 using vid 100
  self and the same MAC, or with a local entry of another port in VID 100.

Removing either entry, for example by taking swp1.100 down or deleting
the bridge VLAN, goes through:

dsa_switch_host_fdb_del()
  dsa_port_do_fdb_del()
    lan9645x_fdb_del()
      dsa_fdb_present_in_other_db()   /* false, db types differ */
      lan9645x_mact_forget()          /* CMD_FORGET on (M, 100) */

Wouldn't the hardware then lose the entry for the host address that is
still wanted?

__lan9645x_port_set_host_flood() leaves the CPU out of PGID_UC when only
bridged ports request host flooding. Unicast to M in VID 100 could then
be dropped instead of reaching the host. The felix driver uses the same
pattern.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929-dsa_lan9645x_switch_driver_base-v13-0-827c2d3617f2%40microchip.com
