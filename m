Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1FD470E97;
	Fri,  2 Oct 2026 21:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975666; cv=none; b=IRF3Zi6ZZ1n4FCKE4B86wCX60lQQPGpe6Ik5lqRPOqUhfMfPbR1Q/nBFaGQSQ0a1a9WGe21if9ebdTReLJugljTrNDuBkGi+fGG/fNQu5uVGH8KLmbj5fktIvl+l+Ui9vi4d99UaOvcxOajLbrGTnzE2aJUpFw8ASamWX3i5HmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975666; c=relaxed/simple;
	bh=ihD+jYuc8aGimLsWC2fNYwCqEBRN5DqO8SljinEEIKs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SlPNk59+Q8O5+vRbAuJjHR88Vg2g0fRLjVBHxVMF4En1Z+LbRPTQik+WMJBQf/OzSCiGLk7UjxbGRBmko0tqnigIEgSKOP+vlvMsp18KFS8Qi9dC1OgDXR1UfLdvRv9ah0qjmQr5KZh79xjOjRW7IDURio02CiESgT4InuhbdSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVPcjoRG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVPcjoRG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08391F00898;
	Fri,  2 Oct 2026 21:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790975664;
	bh=vFPVeNzBGD1KZaurdlLVCaxab1LFncPCiYekAkL0Lfk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LVPcjoRGzWSjmfbjeR+OQr3sCYA8SzkHlBkmug1gI5cHkxaaczviD0W5ueLnrgXaM
	 Ks3pjQPH7otOQrRXsYeU1py0n9T0OMi3313zO023g5lIzNc29St9iNACg+1mZBim3g
	 jkeIruF7H4HhZ9KeePhjszZIJmchWt2YWw4O5zTTpalGHL94vWbmnALyG1DdmIj+KC
	 MollK9A+bE+TN8jqTAn3UutxbjPdAYZjpLSow4YM15wlGbZtL//nZf3YQ2TxbVdMs7
	 r6HnF4bJQzcVHDawcOIgg41K8XU2kqEsnFFc2A2IwhNLtiHcRw3EzpQvxbV3wfqAfe
	 pnk4itGZmkGXA==
Subject: Re: [PATCH net-next v13 7/9] net: dsa: lan9645x: add mdb management
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
Date: Fri, 02 Oct 2026 21:14:23 +0000
Message-ID: <179097566330.434549.248865005553005719@kernel.org>
In-Reply-To:
 <20260929-dsa_lan9645x_switch_driver_base-v13-7-827c2d3617f2@microchip.com>
References:
 <20260929-dsa_lan9645x_switch_driver_base-v13-7-827c2d3617f2@microchip.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] On a failed MAC table write, lan9645x_mdb_widen_dest() drops
  the reference on new_pgid right away…
- [Low] lan9645x_mdb_narrow_dest() commits mdb_entry->pgid = new_pgid and
  mdb_entry->ports = new_ports before calling lan9645x_mdb_write_dest().
- [Low] A failed CPU-only membership delete leaks a PGID reference
  because old_pgid and new_pgid are the same object.

--

net: dsa: lan9645x: add mdb management

This adds the DSA mdb callbacks to the lan9645x driver. IP multicast
stores the port group mask inline in the mac table entry. L2 multicast
points at a refcounted PGID whose destination mask is the port group.
CPU membership is carried by the MAC_CPU_COPY bit, and when the PGIDs
run out, add and delete handle it differently.

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c
> new file mode 100644
> index 0000000000000..92ab5f55f7913
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c
> @@ -0,0 +1,569 @@

[ ... ]

> +static int lan9645x_mdb_widen_dest(struct lan9645x *lan9645x,
> +				   struct lan9645x_mdb_entry *mdb_entry,
> +				   enum macaccess_entry_type type,
> +				   struct lan9645x_pgid_entry *new_pgid,
> +				   int pgid_index, u16 new_ports)
> +{
> +	struct lan9645x_pgid_entry *old_pgid = mdb_entry->pgid;
> +	int err;
> +
> +	lockdep_assert_held(&lan9645x->mdb_lock);
> +
> +	err = lan9645x_mdb_write_dest(lan9645x, mdb_entry, type, pgid_index,
> +				      new_ports);
> +	if (err) {
> +		lan9645x_pgid_entry_put(lan9645x, new_pgid);
> +		return err;
> +	}

[Severity: Medium]
Can this hand a PGID index to an unrelated group while hardware still
points at it?

__lan9645x_mact_learn() issues the command before it polls for
completion:

    lan_wr(ANA_MACACCESS_VALID_SET(1) |
           ANA_MACACCESS_DEST_IDX_SET(port) |
           ...
           ANA_MACACCESS_MAC_TABLE_CMD_SET(CMD_LEARN),
           lan9645x, ANA_MACACCESS);

    return lan9645x_mac_wait_for_completion(lan9645x, NULL);

That means an error from lan9645x_mdb_write_dest() only tells us the
outcome is unknown, for example after a failed poll read or a timeout.
The entry may already point at pgid_index.

If new_pgid was just created, this put frees its index. A later add
with a different port mask can get the same index back from
lan9645x_mdb_pgid_entry_create(). lan9645x_pgid_entry_alloc() then
rewrites ANA_PGID for that group, so an entry that may have been
written would forward this group to the other group's ports.

When the entry already existed (ports != 0), __lan9645x_mdb_add() does
no further cleanup. For a fresh entry it issues the forget only after
the PGID has been released, and it ignores the result:

    lan9645x_mact_forget(lan9645x, mdb_entry->mac,
                         mdb_entry->vid, type);
    lan9645x_mdb_entry_dealloc(lan9645x, mdb_entry);

The comment there says the forget "fails harmlessly if the bus is still
down". Isn't that the case where an entry pointing at a freed PGID is
left in hardware?

The delete side handles the same uncertainty by keeping the reference.
lan9645x_mdb_narrow_dest() keeps old_pgid on failure, and
__lan9645x_mdb_del() sets mdb_entry->pgid = NULL when CMD_FORGET fails.
The v12 changelog gives the reason: "so the index cannot be handed to an
unrelated group while hardware may still point at it".

Should the add path also keep the new_pgid reference when the write
fails?

> +	mdb_entry->pgid = new_pgid;
> +	mdb_entry->ports = new_ports;
> +	lan9645x_pgid_entry_put(lan9645x, old_pgid);
> +	return 0;
> +}

[ ... ]

> +static void lan9645x_mdb_narrow_dest(struct lan9645x *lan9645x,
> +				     struct lan9645x_mdb_entry *mdb_entry,
> +				     enum macaccess_entry_type type,
> +				     struct lan9645x_pgid_entry *new_pgid,
> +				     int pgid_index, u16 new_ports)
> +{
> +	struct lan9645x_pgid_entry *old_pgid = mdb_entry->pgid;
> +	int err;
> +
> +	lockdep_assert_held(&lan9645x->mdb_lock);
> +
> +	mdb_entry->pgid = new_pgid;
> +	mdb_entry->ports = new_ports;

[Severity: Low]
mdb_entry->pgid is switched to new_pgid before the hardware write. If
that write fails, which PGID does the entry use afterwards? Hardware
would still use old_pgid, while software records new_pgid.

The in-place branch in __lan9645x_mdb_del() assumes hardware points at
mdb_entry->pgid, so it only rewrites ANA_PGID:

    if (mdb_entry->pgid && refcount_read(&mdb_entry->pgid->refcount) == 1) {
        mdb_entry->pgid->ports = new_ports &
                                 ~BIT(lan9645x->num_phys_ports);
        ...
        lan_rmw(ANA_PGID_PGID_SET(mdb_entry->pgid->ports), ...);
        return 0;
    }

For example, take a group {A,B,C} on PGID P:

1. Deleting C creates Q={A,B} with the last free index, and the MAC
   write fails.

2. Deleting B finds no PGID for {A}, so creation returns -ENOSPC.

3. Q has refcount 1, so it is narrowed in place.

Hardware still forwards through P, so B and C keep receiving the group,
and nothing further is logged.

Should the in-place branch, or a later narrowing, rewrite the MAC entry
after an earlier failed write?

> +
> +	err = lan9645x_mdb_write_dest(lan9645x, mdb_entry, type, pgid_index,
> +				      new_ports);
> +	if (err) {
> +		dev_err(lan9645x->dev,
> +			"Narrowing %pM vid %u to mask 0x%x returned %pe\n",
> +			mdb_entry->mac, mdb_entry->vid, new_ports,
> +			ERR_PTR(err));
> +		return;
> +	}

[Severity: Low]
Does this early return leak a PGID reference when old_pgid and new_pgid
are the same object?

Take a group {A, CPU} on PGID P, whose ports are {A}. When only the CPU
port module leaves, lan9645x_mdb_pgid_entry_get() strips the CPU bit.
lan9645x_mdb_pgid_entry_lookup() then returns P after refcount_inc().
Now new_pgid == old_pgid == P, and P holds two references for a single
mdb entry.

If lan9645x_mdb_write_dest() fails here, the put below is skipped. When
the group is removed later, lan9645x_mdb_entry_dealloc() drops only one
reference. P and its index then stay reserved until
lan9645x_mdb_deinit().

Keeping old_pgid makes sense when it differs from new_pgid. Here,
though, mdb_entry->pgid already holds P. Should the put still run when
old_pgid == new_pgid?

> +
> +	lan9645x_pgid_entry_put(lan9645x, old_pgid);
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929-dsa_lan9645x_switch_driver_base-v13-0-827c2d3617f2%40microchip.com
