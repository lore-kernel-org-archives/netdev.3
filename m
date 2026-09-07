Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D4C38F658
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 06:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788761486; cv=none; b=cearcN3VPANFSJ1XqZ4e4SGjxat+dAQJgEEaieUJIAn1OTHpQwoxujXBLpnpMieUZeje3U7Ql82teW000LQHgOkdOXmKAp+oTyyFH8Eff16UJkd3CbEkUr88BXjA17YmVt3fTM1vlC6HE5JFXmoPCstsPaiuUJaDxA6EdDJ2hD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788761486; c=relaxed/simple;
	bh=FI1qd7d2ySxaV0oFho9k2Hszh8YHhfcFU1jf7pymnyY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I0WJj85SEpRqJR2rbY1YYccca62taBM8s6r3ZEB54OxFjFudOgIuo2bvu9j5yBIhFhaj+Mw04mXyFEH8t3u6PPdi0gfSl4RMNN9A9uK3JVhxdncg8Cx5IBz1GZMZ/yvwtG3IiqN9FcGL+e3LZkUfb2N+mXzfObFOM1SIi+3oT4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWo/VH63; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWo/VH63"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86ECD1F00A3D;
	Mon,  7 Sep 2026 06:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788761485;
	bh=d2KGv+sK+pCrKcIpFTuE2XNpNwcc4oZeCwopwb8XW8w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MWo/VH634SnXpL28YjBoHlspnla50dzX3TSSQd2w9V+Z2OM2KJZCcKl3l0zjTUHty
	 FJh0y3wuDVTf2Q9TR74K7UKK5dKbF9MQ72TZqfFn051p1Q+fM33WPee/92vvWvR29I
	 vT9+i7GJoOuTqGCQCOTu7nZUQzt6Ek8gOHaMsPQPXVWlMNurLxPtLw/Pyd8uKjeB5p
	 XHbY1Jmueg6IRZr8QgUpcVvjftYy3lxwAb+zRr8vssTEGQEWXmp17oPY61nqaaYjJz
	 kxr0FC0gvOlGVGZDsaqREBCS+BB8rD2WPLr9OEuuQOdthypyqzX6KJXqQM495pUsf+
	 zjQ8EVx7+3/Gw==
Subject:
 Re: [PATCH net-next 5/9] vxlan: move VXLAN_F_MDB to struct vxlan_dev flags
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, idosch@nvidia.com, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Mon, 07 Sep 2026 06:11:24 +0000
Message-ID: <178876148406.219967.14098720425429878351@kernel.org>
In-Reply-To: <20260903120840.1024153-6-edumazet@google.com>
References: <20260903120840.1024153-6-edumazet@google.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] Moving VXLAN_F_MDB out of `struct vxlan_config.flags` into the
  new `vxlan->flags` bitmap silently loosens mlxsw's VXLAN offload…

--

vxlan: move VXLAN_F_MDB to struct vxlan_dev flags

VXLAN_F_MDB is moved out of struct vxlan_config.flags into a new
unsigned long flags field in struct vxlan_dev as VXLAN_DEV_F_MDB,
manipulated with set_bit()/clear_bit()/test_bit().  This is preparation
for turning vxlan->cfg into an RCU-protected pointer.

> diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
> index 56ca92832833..cf606256d092 100644
> --- a/drivers/net/vxlan/vxlan_mdb.c
> +++ b/drivers/net/vxlan/vxlan_mdb.c
> @@ -1219,7 +1219,7 @@ vxlan_mdb_entry_get(struct vxlan_dev *vxlan,
>  		goto err_free_entry;
>  
>  	if (hlist_is_singular_node(&mdb_entry->mdb_node, &vxlan->mdb_list))
> -		vxlan->cfg.flags |= VXLAN_F_MDB;
> +		set_bit(VXLAN_DEV_F_MDB, &vxlan->flags);
>  
>  	return mdb_entry;
>  

[ ... ]

> diff --git a/include/net/vxlan.h b/include/net/vxlan.h
> index f41db72e9229..f4f519a365f5 100644
> --- a/include/net/vxlan.h
> +++ b/include/net/vxlan.h

[ ... ]

> @@ -332,7 +337,6 @@ struct vxlan_dev {
>  #define VXLAN_F_IPV6_LINKLOCAL		0x8000
>  #define VXLAN_F_TTL_INHERIT		0x10000
>  #define VXLAN_F_VNIFILTER               0x20000
> -#define VXLAN_F_MDB			0x40000

[Severity: Medium]
Does removing this bit from the vxlan_config.flags space also change mlxsw
offload admission?  vxlan_config.flags is read outside the vxlan driver by
mlxsw, which rejects any flag it does not know about:

drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c

  #define MLXSW_SP_NVE_VXLAN_IPV4_SUPPORTED_FLAGS (VXLAN_F_UDP_ZERO_CSUM_TX | \
						   VXLAN_F_LEARN | \
						   VXLAN_F_LOCALBYPASS)
  ...
  static bool mlxsw_sp_nve_vxlan_ipv4_flags_check(const struct vxlan_config *cfg,
						  struct netlink_ext_ack *extack)
  {
	...
	if (cfg->flags & ~MLXSW_SP_NVE_VXLAN_IPV4_SUPPORTED_FLAGS) {
		NL_SET_ERR_MSG_MOD(extack, "VxLAN: Unsupported flag");
		return false;
	}

The same catch-all exists in mlxsw_sp_nve_vxlan_ipv6_flags_check(), and both
are reached from mlxsw_sp_nve_vxlan_can_offload(), which takes its cfg
straight from netdev_priv(params->dev):

  mlxsw_sp_netdevice_vxlan_event() -> mlxsw_sp_bridge_vxlan_join() ->
      mlxsw_sp_nve_fid_enable() -> ops->can_offload() -> flags_check()

Before this patch, "bridge mdb add dev vxlan0 ..." made
vxlan_mdb_entry_get() set VXLAN_F_MDB (0x40000) in vxlan->cfg.flags, so a
subsequent "ip link set vxlan0 master br0" on an otherwise offloadable
device failed with the "VxLAN: Unsupported flag" extack.  After the move the
bit lives in vxlan->flags, which mlxsw never inspects, so that enslavement
now succeeds.

mlxsw has no VXLAN MDB handling (vxlan_mdb.c emits no switchdev
notification), so in that ordering the MDB entries would be silently not
honoured in hardware and multicast would follow FDB-based hardware flooding
instead.

The pre-patch rejection was ordering dependent (MDB entries added after
enslavement were never revalidated, so the same unoffloaded state was
already reachable), and commit bc6c6b013ffe ("vxlan: mdb: Add an internal
flag to indicate MDB usage") describes VXLAN_F_MDB purely as an internal
data path flag, so the mlxsw behaviour looks accidental.  Still, the
changelog presents this as pure preparation for the RCU cfg conversion.

Could the cross-driver effect be mentioned in the changelog, and could the
mlxsw side confirm it?  Checking the end of the series (9c4524e8ff6c), the
bit stays in vxlan->flags and the mlxsw supported-flags masks are unchanged,
so no later patch addresses this.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903120840.1024153-1-edumazet%40google.com
