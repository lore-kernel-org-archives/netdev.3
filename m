Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794080368;
	b=a7lKqvvGnOA0LJVTZzr+kKOWUXbm0ZUWFSQif5lgRvN3Bev1KaO+naUlN5b7qxyssp5l
	 c3j79r/b31ToIdfjh88r+CgpmxkSZcJCnKDnZWNkegCcn6ZuOXZScBFcKaOc3zzOQ0Pn/
	 slCzJnMc0svo0mTXgpvNFR0nVozICa9rbEiSn8VDoa3sjkLFk0VtM1qhcn2ITr3QTu+dj
	 qqWZt5F1zuDJv+rBGQQbbpsTGGiQysJfPiXz/0ppZHAyHsiWhd8EsmPDhnmbxk260r2fa
	 spQ3eG/uqoXtC4dTPi/kL6o49mfNnqDuSFpN5h4fFVfSrmgETKAqyh9UCVuht1XVFQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794080368;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PPLNgcCbpdDwgqH/GLAU2EpORaOc7VYf2uI8S7UdHRo=;
	b=rUdN1xPqNp2ONnnLYsyCSwhPacPLa6QlpEelL2ET1jIxehxB5JNUtpPbUYLXX8nFw4Bg
	 6fz+5WUEmQozJWQrk+YVHjBy1YGLt+x3BwQIaayVSjDIb0UGlQEe3nagXvztI1Zuzlw2o
	 9Jvg5jDrqx7hf6xWh+0PJ8aNJWvi3A0waxEa+iys98TAhFOyPuCe/PWnnGT6F1gxc4moq
	 Kr1nlVtrXeDZ9/j9US2yU3XBuu5fcMrXNAt/7sS4TCkbEHlYIFqWB3L6AL7BgmWZTKCXK
	 /qm3NwARouc+sRM174SmDxGretLN+YRlo0/y++Rt0z/xveLv25IeajM7ur8WWxBio2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NwpSMJuX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16065606A326;
	Sat,  7 Nov 2026 19:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NwpSMJuX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749071F0089F;
	Sat,  7 Nov 2026 19:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794080367;
	bh=PPLNgcCbpdDwgqH/GLAU2EpORaOc7VYf2uI8S7UdHRo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NwpSMJuXbZx3xtljXRukKmlbb+Yn2XRiaFhKt3LkekUYKJ+Zs+srlrNYIS7qHoo9X
	 m/TTlWgvblhXJ6G6PWdXT4r/0FG3B7NrPAygeHLe7rolS6KGUnv3EwCcQ8H+MfXsVo
	 7FAnuHNSZWN3B5Dgyny4PeC8Z68ZJ+SSaGzZEt5nf5G9cIn0T1e/N72mlYGANMwLFb
	 hmOt5i4yIuqqie5VSfenaMOgF8aLliOJL2cQyy4YWjuYZCuTUzG7BTfuBoeafBXFiw
	 EY9XrUYJGZhwQYIH14q9qyClXN79npl8NWnORjB1k7ldyr7S0ls+Ly78yhlVjDXpyG
	 E5ZSeA+KAcbig==
Subject: Re: [PATCH net-next 1/2] net: dsa: motorcomm: Report error when FDB
 fails to add
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Sat, 07 Nov 2026 19:39:27 +0000
Message-ID: <179408036701.994134.5574691776169579582@kernel.org>
In-Reply-To: <20261106184811.350700-2-mmyangfl@gmail.com>
References: <20261106184811.350700-2-mmyangfl@gmail.com>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says the change "does not affect userspace
  tools: .port_fdb_add() is asynchronous and DSA core always returns 0…
- [Medium] The patch reads YT921X_FDB_RESULT_NOTFOUND (BIT(14),
  chip.h:284) after an OP_ADD as "table full" and returns -ENOSPC from…
- [Low] The patch fixes a real bug, but it has no Fixes: tag.

--

net: dsa: motorcomm: Report error when FDB fails to add

This patch makes yt921x_fdb_add() return -ENOSPC when the FDB result
register reports YT921X_FDB_RESULT_NOTFOUND after an add operation.
Before the patch, the hardware status was ignored. The commit message
says userspace is not affected because .port_fdb_add() is asynchronous.

> Note that this does not affect userspace tools: .port_fdb_add() is
> asynchronous and DSA core always returns 0 for that.

[Severity: Medium]
Is this accurate? yt921x_fdb_add() is also reached from the MDB path, and
DSA returns .port_mdb_add() errors synchronously:

yt921x_dsa_port_mdb_add()
  yt921x_fdb_join()
    yt921x_fdb_add()
      return -ENOSPC;

When a port joins a bridge, host-joined MDB groups are replayed as
SWITCHDEV_OBJ_ID_HOST_MDB. nbp_switchdev_sync_objs() then returns the
error unchanged:

net/bridge/br_switchdev.c:nbp_switchdev_sync_objs() {
    ...
	err = br_switchdev_mdb_replay(br_dev, dev, ctx, true, blocking_nb,
				      extack);
	if (err) {
		/* -EOPNOTSUPP not propagated from MDB replay. */
		return err;
	}
    ...
}

If the hardware table is full, will "ip link set lanX master br0" now
fail with -ENOSPC? Before this patch it succeeded.

For deferred MDB adds, br_switchdev_mdb_complete() now calls
br_multicast_set_pg_offload_flags(p, !err) with an error. Userspace then
gets an RTM_NEWMDB notification and sees offload_failed in
"bridge mdb show".

On the FDB path, dsa_user_switchdev_event_work() now logs the error and
skips dsa_fdb_offload_notify():

net/dsa/user.c:dsa_user_switchdev_event_work() {
    ...
		if (err) {
			dev_err(ds->dev,
				"port %d failed to add %pM vid %d to fdb: %d\n",
				dp->index, addr, vid, err);
			break;
		}
		dsa_fdb_offload_notify(switchdev_work);
    ...
}

As a result, "bridge fdb show" no longer marks these entries as
offloaded. The driver sets ds->assisted_learning_on_cpu_port = true, so
every learned station MAC takes this path. A full table would then log
one dev_err() per address, with no rate limit.

The new behavior looks more correct. Could the commit message describe
these changes that userspace can see, especially that bridge join can
now fail?

> Signed-off-by: David Yang <mmyangfl@gmail.com>

[Severity: Low]
Should this have a Fixes: tag?

Before this patch, a static FDB or MDB add that the hardware rejected
still returned 0. DSA then called dsa_fdb_offload_notify(), and the
bridge set MDB offload flags for entries the switch never installed.
Traffic to those addresses could be flooded or forwarded wrongly.

The ignored result goes back to the original driver submission:

Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")

Could this also go to net instead of being bundled with net-next feature
work?

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 33e5fc127244d..a7a9a74393045 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c
> @@ -725,7 +725,13 @@ yt921x_fdb_add(struct yt921x_priv *priv, const unsigned char *addr, u16 vid,
>  	if (res)
>  		return res;
>  
> -	return yt921x_fdb_wait(priv, &val);
> +	res = yt921x_fdb_wait(priv, &val);
> +	if (res)
> +		return res;
> +	if (val & YT921X_FDB_RESULT_NOTFOUND)
> +		return -ENOSPC;

[Severity: Medium]
Does the hardware set YT921X_FDB_RESULT_NOTFOUND when an OP_ADD finds no
free slot?

Everywhere else in the driver this bit means a lookup miss. For example,
yt921x_fdb_has() checks it after OP_GET_ONE:

	if (val & YT921X_FDB_RESULT_NOTFOUND) {
		*indexp = YT921X_FDB_NUM;
		return 0;
	}

The neighbouring bit is defined in chip.h but never checked:

#define  YT921X_FDB_RESULT_OVERWRITED		BIT(13)

If the hardware reports a full table some other way, this check would
miss the case the commit message describes. Static FDB and MDB entries
could then still be lost silently while being marked as offloaded.

If OVERWRITED means the ADD evicted another entry from a full bucket,
would that other entry also be lost silently?

Could the datasheet meaning of these bits for OP_ADD be confirmed?

Separately, yt921x_fdb_add_index_in12() still ignores every result bit.
It is used by the join and leave update paths. Should it check them too?

> +
> +	return 0;
>  }
>  
>  static int

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106184811.350700-1-mmyangfl%40gmail.com
