Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794217581;
	b=oxksDin2g6k+pO7B8yEIdwqDhSnARf6HPY4Di/EL28iL+gOtGy/058TnBA5jWdfyH9k/
	 rDX/ADMc1q/1vQWDh5puvJmszPmQTn8tXN5Z+wX6W89curMW7nKSZwZiiM0ABVz/h10vi
	 bwT3FyvFavCqIKMrsmSfrm4OlnDTxSZI+CLgscUhBJWGnk8mDbWWKOpVWtfvp0FCsilw/
	 iZpeOcnH9jLytR76FiwPojLsR4MKNxDq/nR+WVHVtyC3okKdUtPJReuHsMB8IqIdub2uu
	 lY0Zn8lIkLiViz4123eSESaLX5cWsWScB8H5+utGwCEuO24P1BzRbXaPV65xsxmNETA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217581;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=I3+NouKuoxAgixZVZV3nbvzvjEvnpGqmaSWB1kp1G5I=;
	b=o+CoC1C1FbyNb3fWemq65sFFr9qNCg/X6pbdsrZwIkHgxIjBfbqJYgDD4l2eyvfKp/Ab
	 zWgQNmhmDDrCY0HOsrZ7IwT4Q2L2YwBTfXhL9iaGz+blusMCA2VG1RJ2WZCSpUjx7WL2F
	 un6eSSIWDo5YwAZ6WdKQgIJ36o6S0YTuD0Xae0lYEYsVnFsIp32cbUZqCdghfnJySeFSu
	 jAUgKy30ogc4EvJKamsmDIKNQcAFwnsryuPTCAwEyzbyIO6zo3KKlyQI4qOSJ99kJYbNA
	 jcLYVZ7FmFUo6H6IDzvNHXsr13IhWH6ylrfB6f8xtldqaK8EtTZj/6jxRmEodBcERZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DahYE7sK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75903606A330;
	Mon,  9 Nov 2026 09:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DahYE7sK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F151F0089F;
	Mon,  9 Nov 2026 09:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794217581;
	bh=I3+NouKuoxAgixZVZV3nbvzvjEvnpGqmaSWB1kp1G5I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DahYE7sKsGhL5RHZFY4xPbLD/1UnSfOGGUab8Mn80XewgtoKGgQXS4+xHeXx0BbVa
	 5R+bR4U/iL8fin4pxhTy1hpoJn2dsBjwpelRJUFOxKhCc510Ryf+MTVGalHKUS3+f+
	 IG1weEEiKw8p7/nYSrGBUREBKYsfVlZrTb8OS3aero0YpGHMbEK6x3UMTK53BLG9ss
	 U1Hab4acCT0CZlkkKZNdjXgNhj2s02mJSGE3pzGGvh2wD8R5PYDHNqUnzWwVOtyeew
	 3muV3nFWnzSOQBrkYidRXelNE+KWetsH1cPl4UrPAZ8JA70wQsf4Z5/pXPpAubbiE2
	 r3JefAAES5kAQ==
Subject: Re: [PATCH net-next v2 2/2] net: dsa: motorcomm: Add devlink info and
 resources
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 09:46:20 +0000
Message-ID: <179421758032.994134.11840442430338687736@kernel.org>
In-Reply-To: <20261108094512.1285796-3-mmyangfl@gmail.com>
References: <20261108094512.1285796-3-mmyangfl@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The devlink resource tree registered in yt921x_devlink_setup()
  does not match how devlink resources work.
- [Medium] The FDB occupancy callbacks
  (yt921x_devlink_occ_get_fdb_ucast(),…
- [Low] The patch adds devlink info (DEVLINK_INFO_VERSION_GENERIC_ASIC_ID
  via yt921x_dsa_devlink_info_get()) and six devlink resources (ACLs,…
- [Low] YT921X_LEARN_UCAST_CNT (0x18043c) and YT921X_LEARN_MCAST_CNT
  (0x180504) are added to chip.h as bare addresses with no count-field…
- [Low] yt921x_fdb_add() issues a hash-mode FDB_OP_OP_ADD and checks only
  YT921X_FDB_RESULT_NOTFOUND.

--

net: dsa: motorcomm: Add devlink info and resources

This adds a devlink info callback that reports the ASIC name as
asic.id. It also registers devlink resources for ACLs, the FDB (with
ucast, mcast and static children) and meters. FDB occupancy combines the
hardware learned-entry counters with software counters of static entries,
which yt921x_fdb_add(), yt921x_fdb_join() and yt921x_fdb_leave() maintain.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index a7a9a74393045..95d57e74d64c2 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c

[ ... ]

> @@ -731,6 +732,10 @@ yt921x_fdb_add(struct yt921x_priv *priv, const unsigned char *addr, u16 vid,
>  	if (val & YT921X_FDB_RESULT_NOTFOUND)
>  		return -ENOSPC;
>  
> +	if (is_multicast_ether_addr(addr))
> +		priv->fdb_static_mcast_cnt++;
> +	else
> +		priv->fdb_static_ucast_cnt++;
>  	return 0;
>  }

[Severity: Low]
Only YT921X_FDB_RESULT_NOTFOUND is checked before the static counters are
incremented. What happens if the hardware reports
YT921X_FDB_RESULT_OVERWRITED here?

yt921x_fdb_join() calls yt921x_fdb_add() only after yt921x_fdb_has() has
found no entry for this MAC+FID. An overwrite would therefore mean that
some other entry in the hash bucket was replaced. If that entry was
static, the switch has dropped it, but fdb_static_*_cnt still counts it.

A later port_fdb_del/port_mdb_del for the evicted address then takes the
early return in yt921x_fdb_leave():

	if (index >= YT921X_FDB_NUM)
		return 0;

so the counter stays wrong until the next setup.

Ignoring OVERWRITED is not new to this patch. The new counting, though,
assumes that every successful ADD adds exactly one static entry and
removes none. Can that be checked here, or does the hardware never evict
static entries on a hash ADD?

[ ... ]

> @@ -809,7 +831,18 @@ yt921x_fdb_join(struct yt921x_priv *priv, const unsigned char *addr, u16 vid,
>  	if (ctrl1 == val1 && ctrl2 == val2)
>  		return 0;
>  
> -	return yt921x_fdb_add_index_in12(priv, index, ctrl1, ctrl2);
> +	res = yt921x_fdb_add_index_in12(priv, index, ctrl1, ctrl2);
> +	if (res)
> +		return res;
> +
> +	if ((val1 & YT921X_FDB_IO1_STATUS_M) !=
> +	    YT921X_FDB_IO1_STATUS_STATIC) {
> +		if (is_multicast_ether_addr(addr))
> +			priv->fdb_static_mcast_cnt++;
> +		else
> +			priv->fdb_static_ucast_cnt++;
> +	}

[Severity: Medium]
If the existing slot was learned dynamically (for example, bridge fdb add
on a MAC that has already been learned), this rewrites it as STATIC with
an index-mode ADD and increments fdb_static_ucast_cnt. Does
YT921X_LEARN_UCAST_CNT go down when the slot is converted this way?

If it doesn't, yt921x_devlink_occ_get_fdb_ucast() and
yt921x_devlink_occ_get_fdb() count this entry twice. When
yt921x_fdb_leave() later deletes the entry, only the software counter is
decremented.

Multicast raises a similar question. The hardware doesn't learn
multicast source MACs, and the driver doesn't set up hardware IGMP/MLD
snooping. So YT921X_LEARN_MCAST_CNT is either always zero, or it counts
the MDB entries the CPU programs, which fdb_static_mcast_cnt also counts.

In either case, can the reported FDB occupancy exceed YT921X_FDB_NUM?
Is there anything that confirms these hardware counters leave out entries
added with YT921X_FDB_OP_OP_ADD?

[ ... ]

> diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
> index fc315f1d8f87b..d3f2a86feb228 100644
> --- a/drivers/net/dsa/motorcomm/chip.h
> +++ b/drivers/net/dsa/motorcomm/chip.h
> @@ -248,6 +248,7 @@ enum yt921x_app_selector {

[ ... ]

> +#define YT921X_LEARN_UCAST_CNT		0x18043c
>  #define YT921X_AGEING			0x180440
>  #define  YT921X_AGEING_INTERVAL_M		GENMASK(15, 0)

[ ... ]

> @@ -312,6 +313,7 @@ enum yt921x_app_selector {

[ ... ]

> +#define YT921X_LEARN_MCAST_CNT		0x180504

[Severity: Low]
Both counter registers are defined without a field mask. The devlink
occ_get callbacks use the whole 32-bit value as an entry count, for
example in yt921x_devlink_occ_get_fdb():

	res = yt921x_reg_read(priv, YT921X_LEARN_UCAST_CNT, &val);
	if (res)
		goto end;
	count += val;

The table holds only YT921X_FDB_NUM (4096) entries. Are the other bits
of these registers guaranteed to read as zero?

The neighbouring registers define their fields with GENMASK(). Would a
count mask used with FIELD_GET() be safer here?

[ ... ]

> diff --git a/drivers/net/dsa/motorcomm/devlink.c b/drivers/net/dsa/motorcomm/devlink.c
> new file mode 100644
> index 0000000000000..a9a611ef55713
> --- /dev/null
> +++ b/drivers/net/dsa/motorcomm/devlink.c
> @@ -0,0 +1,216 @@

[ ... ]

> +int
> +yt921x_dsa_devlink_info_get(struct dsa_switch *ds, struct devlink_info_req *req,
> +			    struct netlink_ext_ack *extack)
> +{

[ ... ]

> +	res = devlink_info_version_fixed_put(req,
> +					     DEVLINK_INFO_VERSION_GENERIC_ASIC_ID,
> +					     priv->info->name);

[Severity: Low]
This isn't a bug, but Documentation/networking/devlink/index.rst says:

  Each driver that implements devlink is expected to document what
  parameters, info versions, and other features it supports.

There is no yt921x file under Documentation/networking/devlink/. Nothing
documents the asic.id info version or the ACLs, FDBs, FDBs/ucast,
FDBs/mcast, FDBs/static and meters resources. Could one be added?

Two things are not obvious from the resource names. The static child
overlaps ucast/mcast. The ucast/mcast occupancy mixes hardware learned
counts with software static counts.

Among the existing DSA drivers that use devlink, only mv88e6xxx has such
a file. The documented expectation still applies to new features.

[ ... ]

> +static const struct yt921x_devlink_resource yt921x_devlink_resources[] = {

[ ... ]

> +	{
> +		"ucast", yt921x_devlink_occ_get_fdb_ucast,
> +		0,
> +		YT921X_DEVLINK_RESOURCE_ID_FDB_UCAST,
> +		YT921X_DEVLINK_RESOURCE_ID_FDB,
> +	},
> +	{
> +		"mcast", yt921x_devlink_occ_get_fdb_mcast,
> +		0,
> +		YT921X_DEVLINK_RESOURCE_ID_FDB_MCAST,
> +		YT921X_DEVLINK_RESOURCE_ID_FDB,
> +	},
> +	{
> +		"static", yt921x_devlink_occ_get_fdb_static,
> +		0,
> +		YT921X_DEVLINK_RESOURCE_ID_FDB_STATIC,
> +		YT921X_DEVLINK_RESOURCE_ID_FDB,
> +	},

[Severity: Medium]
These three children are registered with size 0, and
yt921x_devlink_setup() passes r->size as both size_min and size_max.
Their occ_get callbacks can still return non-zero counts, up to
YT921X_FDB_NUM. So devlink resource show would print something like
"ucast size 0 occ 1200". Is that how sub-resources are meant to be used?

The devlink core treats children as partitions of the parent's size.
devlink_resource_validate_children() adds up the children's size_new and
checks the total against the parent:

	list_for_each_entry(child_resource, &resource->resource_list, list)
		parts_size += child_resource->size_new;

The example in Documentation/networking/devlink/devlink-resource.rst
also shows children with real sizes that partition the parent.

The children also overlap. yt921x_devlink_occ_get_fdb_ucast() and
yt921x_devlink_occ_get_fdb_mcast() already add fdb_static_ucast_cnt and
fdb_static_mcast_cnt. yt921x_devlink_occ_get_fdb_static() then returns:

	count = priv->fdb_static_ucast_cnt + priv->fdb_static_mcast_cnt;

so the children's occupancy adds up to HW_U + HW_M + 2S, while the
parent FDBs reports HW_U + HW_M + S. Should static be split out of
ucast/mcast, or removed as a child?

The /FDBs/ucast, /FDBs/mcast and /FDBs/static names are visible to
userspace and will be hard to change later. The commit message also
doesn't describe this layout. Could the hierarchy be reworked before it
lands?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261108094512.1285796-1-mmyangfl%40gmail.com
