Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C043CF1F8
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 02:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437672; cv=none; b=NtfmDXTHuQiaVi0yjhRDCeaq2bdx4vTRjRsB1/XzFRw7cdFFebCWyXOkwifqRfXYi2VnEqAafLD8Y00Nzgg2gCmbkvy8T95rPAIGWlrgshY2oSgtULDWhRud/vEy8ORCHV1qtjU6kzQBBDHZ7Kj4Fm7A/YZ2gYPEk7mFsgGlVqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437672; c=relaxed/simple;
	bh=47N8G5BWNFbihI+kG8rP7b0Ptg2lotvKp6rBRwf6MZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SSK5nfEI3eF7dWJ0QhZCmGLq7a0ZeakLzPlXThn1nPj2GgNYAUveIN80tdyUQz+5tyPBOMmT4TOYle/EQgUfGUuCSzYSdfEe+3DyDzGmuzyNQjEXDpt6hRr0tA61D+69g9+tP2Rnbz4xf/e0ISnWwlal9KcrRI+XgKwqptDaKjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AomrIu9G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AomrIu9G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B251F000FF;
	Tue, 15 Sep 2026 02:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789437671;
	bh=IzxfhIb4axDYUnVO1J/2T7Kl0D7e3d6pHu5+81cAe9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AomrIu9GtbFFQTCMXrvuDmxR08gnmRlD1dJEFTqcLhYnjidw8BTuoI4kaoKfoimuf
	 /wjc1r9K6xYOx17OPRWJKvOMZp2oC0g7x5N6fY46K8I2kS5tWjV+hwWVPb5WJdLyDR
	 ayQhZVFIQKGC4sXyvl4gUHY7Xo7dX5m8VLVFCfJ7E3gfwP772CB6OpdJI5NyuD7i5M
	 5+UXD/UAnfCO1QjNk8oe9kWrfpKHiTUP1ey+usRrAjdj7WbnXp8xDk7lNpTx7DCczM
	 tyINpi9bf8ChBVeJ4QVDTLZQ+P4JTP4s34HPaNGtt2N/0RaOBhsweolUbQoVEfqAyE
	 /f08Fax68RlMg==
From: Jakub Kicinski <kuba@kernel.org>
To: edumazet@google.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	idosch@nvidia.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH v3 net-next 3/6] vxlan: move VXLAN_F_MDB to struct vxlan_dev flags
Date: Mon, 14 Sep 2026 19:01:10 -0700
Message-ID: <20260915020110.887289-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911062200.231316-4-edumazet@google.com>
References: <20260911062200.231316-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
vxlan: move VXLAN_F_MDB to struct vxlan_dev flags

This moves the internal VXLAN_F_MDB runtime state out of struct
vxlan_config.flags into a new unsigned long flags field in struct
vxlan_dev, accessed with set_bit()/clear_bit()/test_bit(), in
preparation for making vxlan->cfg an RCU-protected pointer.

One question about an out-of-tree-of-this-patch consumer of
cfg->flags below.

> diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
> index 56ca928328330..cf606256d0929 100644
> --- a/drivers/net/vxlan/vxlan_mdb.c
> +++ b/drivers/net/vxlan/vxlan_mdb.c
> @@ -1219,7 +1219,7 @@ vxlan_mdb_entry_get(struct vxlan_dev *vxlan,
>  		goto err_free_entry;
>  
>  	if (hlist_is_singular_node(&mdb_entry->mdb_node, &vxlan->mdb_list))
> -		vxlan->cfg.flags |= VXLAN_F_MDB;
> +		set_bit(VXLAN_DEV_F_MDB, &vxlan->flags);

[Severity: Medium]
Does this change relax the mlxsw NVE offload validation?

mlxsw checks cfg->flags with a deny-by-default mask, so the 0x40000 bit
used to land in the "unsupported flag" test:

drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c:
#define MLXSW_SP_NVE_VXLAN_IPV4_SUPPORTED_FLAGS (VXLAN_F_UDP_ZERO_CSUM_TX | \
						 VXLAN_F_LEARN | \
						 VXLAN_F_LOCALBYPASS)

static bool mlxsw_sp_nve_vxlan_ipv4_flags_check(const struct vxlan_config *cfg,
						struct netlink_ext_ack *extack)
{
	...
	if (cfg->flags & ~MLXSW_SP_NVE_VXLAN_IPV4_SUPPORTED_FLAGS) {
		NL_SET_ERR_MSG_MOD(extack, "VxLAN: Unsupported flag");
		return false;
	}

The same mask exists for the IPv6 underlay in
mlxsw_sp_nve_vxlan_ipv6_flags_check(), and both are reached from
mlxsw_sp_nve_vxlan_can_offload(), which only looks at &vxlan->cfg.

So for a device that already has an MDB entry:

  bridge mdb add dev vxlan0 port vxlan0 grp 239.1.1.1 permanent \
      dst 198.51.100.1
    -> vxlan_mdb_add() -> __vxlan_mdb_add() -> vxlan_mdb_entry_get()

before this patch that set VXLAN_F_MDB in cfg->flags, and a later
enslavement to an mlxsw-offloaded bridge was refused with "VxLAN:
Unsupported flag". After the move, mlxsw_sp_nve_vxlan_can_offload() has
no way to observe the MDB state, since nothing outside vxlan_core.c and
vxlan_mdb.c tests VXLAN_DEV_F_MDB, and the device is accepted for
offload while the configured MDB entries are not honoured by the
hardware forwarding plane.

Note the previous rejection was already order-dependent: MDB entries
added after the FID was enabled were never re-validated, because vxlan
MDB emits no switchdev notification at all (git grep switchdev
drivers/net/vxlan/ matches only vxlan_core.c).

Would it make sense to add a test_bit(VXLAN_DEV_F_MDB, &vxlan->flags)
check in mlxsw_sp_nve_vxlan_can_offload(), or to state in the commit
message that MDB presence is intentionally no longer a bar to offload?

>  
>  	return mdb_entry;
>  

[ ... ]

> diff --git a/include/net/vxlan.h b/include/net/vxlan.h
> index 7b82075055237..d323f91af2364 100644
> --- a/include/net/vxlan.h
> +++ b/include/net/vxlan.h

[ ... ]

> @@ -313,6 +314,10 @@ struct vxlan_dev {
>  	unsigned int mdb_seq;
>  };
>  
> +enum vxlan_dev_flags {
> +	VXLAN_DEV_F_MDB,
> +};
> +
>  #define VXLAN_F_LEARN			0x01
>  #define VXLAN_F_PROXY			0x02
>  #define VXLAN_F_RSC			0x04
> @@ -331,7 +336,6 @@ struct vxlan_dev {
>  #define VXLAN_F_IPV6_LINKLOCAL		0x8000
>  #define VXLAN_F_TTL_INHERIT		0x10000
>  #define VXLAN_F_VNIFILTER               0x20000
> -#define VXLAN_F_MDB			0x40000
>  #define VXLAN_F_LOCALBYPASS		0x80000
>  #define VXLAN_F_MC_ROUTE		0x100000
