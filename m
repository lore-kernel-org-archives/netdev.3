Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436877;
	b=31/oaM4vuMhgB5iWWxEQNW7NZK6FsL4gUCs4PLy27oiyRrrKGgwx62DLVFZMsoOhBgI2
	 IvuAlqElPC9Ag2mU2+QjasHofnKNZQpNzU2m83o36K2ZHl2VutjT6eBvQ5yfpd2XxClR+
	 +FbUiiWi5b1k4FN6LEKRHjWc+tCzDW1degdMnMFM1ihBSTVoY5PWWS0/eE2Rqh3vtLchw
	 aV1pGHKQPXgYmdqRMPijXvgpH42AvHjbOx5CQ4fvKn82nlsssIYRHOXkRfd+lsryFQ5Si
	 5uhv625wdggatBdPaBdSlcsT0VlWu1nnmphr2CtmeSa/CvbzChUD2E/xhIFXH8v1nxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436877;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=fNpwkiEqQmN6x4FYIRfh/xeiUHgO/3NO/lcsso0d+RY=;
	b=POZQfO+YIpU5Q3r2sB8SKsWxTaDuq3QEppGNLY4E7Y4fAmbIUmsd+lPVxZx0WfRk+Fhx
	 wOXGuWjA6LME9CJD9+1xokXah8qfD+b0vJSwsGET32O/jJJFDbkh3M9JU1tp8lM8pxzOA
	 /ldT1xCOT76sW7MQbvMHOris/r8iml5y5lEVFczAc4T6Hd+faIhEsSWWm3k8E9h5YyL0R
	 oT+7Bw4NUnTEpeG/5oQcpTNvxAsAcAF1gCltX2sA75taUW8MZi1ojy4NqGzgsB8lL2XWu
	 wc4rHtdCdQs6quFbshNw9Mntj9SlmBhrjwTYTfPCuMKiw/tQ6c7YEjXZeAgK4fDAZwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JLdOoqX+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483EC606A33B;
	Wed, 11 Nov 2026 22:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JLdOoqX+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254601F00A05;
	Wed, 11 Nov 2026 22:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794436876;
	bh=fNpwkiEqQmN6x4FYIRfh/xeiUHgO/3NO/lcsso0d+RY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JLdOoqX+3ncc6QAkGC8k4uno2sCx3sE7Ec3bvGNHmZ60O3vaSnwWJLTz5y5u2xFpe
	 ZSiVkmtgy0YaoCkH05o9MmxNB5NEdOPSpR3VQzSMJ9K9FhNlbAyAs2u8+4+9c6PQ3S
	 E+Tlxof3+bT4V+zBWaOHibMg5rW+XE1w0g/IEQ+kvXafBmqAxo1dcoyzdgKxQDRxUI
	 aldCiZ67by1HeCyu8BNc70x49zrU4n8sDE6jzehQ6EAmcAJQ/V+wN121FFgmN3DTWs
	 9sXZVzX+aRiU9hdcGgfmI0jtcyLKd2up8RLp4C7scY1iLZ6BikpEb5xT8x5J2pEI88
	 TBIqgMn4VeZHQ==
Subject: Re: [PATCH net-next v3 2/2] net: dsa: motorcomm: Add devlink info and
 resources
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Wed, 11 Nov 2026 22:41:15 +0000
Message-ID: <179443687573.2199510.8331335701739368292@kernel.org>
In-Reply-To: <20261109163117.1792478-3-mmyangfl@gmail.com>
References: <20261109163117.1792478-3-mmyangfl@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The FDB occupancy that yt921x_devlink_occ_get_fdb()
  (drivers/net/dsa/motorcomm/devlink.c) reports for the "FDB" devlink…
- [Low] The patch adds devlink info (DEVLINK_INFO_VERSION_GENERIC_ASIC_ID
  from yt921x_dsa_devlink_info_get()) and three driver-specific devlink…
- [Low] The commit message says only "Expose the ASIC model via devlink
  info (ASIC_ID), and register devlink resources for ACLs, FDB and…

--

net: dsa: motorcomm: Add devlink info and resources

This commit adds devlink info to the yt921x DSA driver, reporting the ASIC
model as ASIC_ID. It also registers devlink resources for the ACL, FDB and
meter tables. To compute FDB occupancy it adds a software counter of
static FDB entries.

> Expose the ASIC model via devlink info (ASIC_ID), and register devlink
> resources for ACLs, FDB and meters.

[Severity: Low]
Could the commit message also describe the changes to the FDB programming
paths?

The patch adds priv->fdb_static_cnt and updates it in yt921x_fdb_add(),
yt921x_fdb_join() and yt921x_fdb_leave(). These run for every bridge
fdb/mdb add and delete.

yt921x_fdb_leave() is also restructured. YT921X_FDB_OUT1 is now read
before the DEL operation, not only on the rewrite path. A
WARN_ON(!priv->fdb_static_cnt) is also added on the delete path.

It would help to explain why FDB occupancy is computed as
LEARN_UCAST_CNT + LEARN_MCAST_CNT + a software static count. That formula
assumes the hardware counters only include learned entries.

> diff --git a/drivers/net/dsa/motorcomm/devlink.c b/drivers/net/dsa/motorcomm/devlink.c
> new file mode 100644
> index 0000000000000..529d2decc4036
> --- /dev/null
> +++ b/drivers/net/dsa/motorcomm/devlink.c

[ ... ]

> +static u64 yt921x_devlink_occ_get_fdb(void *ctx)
> +{
> +	struct yt921x_priv *priv = ctx;
> +	unsigned int count = 0;
> +	u32 val;
> +	int res;
> +
> +	mutex_lock(&priv->reg_lock);
> +
> +	res = yt921x_reg_read(priv, YT921X_LEARN_UCAST_CNT, &val);
> +	if (res)
> +		goto end;
> +	count += val;
> +
> +	res = yt921x_reg_read(priv, YT921X_LEARN_MCAST_CNT, &val);
> +	if (res)
> +		goto end;
> +	count += val;
> +
> +	count += priv->fdb_static_cnt;

[Severity: Medium]
Can this report more FDB occupancy than actually exists, possibly even
more than the advertised size of YT921X_FDB_NUM?

The new YT921X_LEARN_UCAST_CNT and YT921X_LEARN_MCAST_CNT definitions in
chip.h have no field mask. Neighbouring registers do, for example
YT921X_AGEING_INTERVAL_M. The full 32-bit value is added here, so any
reserved, limit or flag bits next to the count would end up in the
reported occupancy. Is the whole register the counter?

The sum also assumes the hardware learn counters and fdb_static_cnt never
overlap. In yt921x_fdb_join(), an existing hardware-learned entry is
rewritten as static with an index-mode ADD:

	ctrl1 = val1 & ~YT921X_FDB_IO1_STATUS_M;
	ctrl1 |= YT921X_FDB_IO1_STATUS_STATIC;
	...
	if (ctrl1 != val1)
		priv->fdb_static_cnt++;

Is that entry counted twice if the hardware learn counter does not drop
when the CPU rewrites the status?

The same could happen in yt921x_fdb_add():

1. yt921x_fdb_has() returns not found.
2. The learning engine then learns the same MAC/FID. reg_lock only
   serializes CPU access, not hardware learning.
3. The hash-mode ADD overwrites that entry, but fdb_static_cnt++ still
   runs.

MDB entries are also added as static through yt921x_fdb_join() from
port_mdb_add, so they are counted in fdb_static_cnt. Source MAC learning
never creates multicast entries. If LEARN_MCAST_CNT counts all multicast
table entries, would every MDB entry be counted twice?

> +
> +end:
> +	mutex_unlock(&priv->reg_lock);

[ ... ]

> +static const struct yt921x_devlink_resource yt921x_devlink_resources[] = {
> +	{
> +		"ACL", yt921x_devlink_occ_get_acl,
> +		YT921X_ACL_NUM,
> +		YT921X_DEVLINK_RESOURCE_ID_ACL,
> +		DEVLINK_RESOURCE_ID_PARENT_TOP,
> +	},
> +	{
> +		"FDB", yt921x_devlink_occ_get_fdb,
> +		YT921X_FDB_NUM,
> +		YT921X_DEVLINK_RESOURCE_ID_FDB,
> +		DEVLINK_RESOURCE_ID_PARENT_TOP,
> +	},
> +	{
> +		"meters", yt921x_devlink_occ_get_meter,
> +		YT921X_METER_NUM,
> +		YT921X_DEVLINK_RESOURCE_ID_METER,
> +		DEVLINK_RESOURCE_ID_PARENT_TOP,
> +	},
> +};

[Severity: Low]
Should this come with a driver page under Documentation/networking/devlink/?

Documentation/networking/devlink/index.rst says each driver that
implements devlink is expected to document what parameters, info
versions, and other features it supports.

There is no yt921x entry there yet. For comparison, mv88e6xxx.rst
documents the devlink features of another DSA driver.

The "ACL", "FDB" and "meters" resource names and the ASIC_ID info version
are new user-visible interfaces. For example, "FDB" also includes MDB
entries because the hardware table is shared.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109163117.1792478-1-mmyangfl%40gmail.com
