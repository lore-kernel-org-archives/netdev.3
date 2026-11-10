Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794353212;
	b=5XeVdkXecG+tThPsROJR6hyDcvPumPW1CELKXs0X/dQqjsxNTDua6BE2YO4Dij/XdsB9
	 dLCfFyozH9SnXu7ID8D31aizKq/LbkOgrD7dmLZh2YEZUxDeHW+J4AjA3GXUpSzy/pwNs
	 1l5fA2k6qgddhGjvXi0Q3d+tIt731Jpg/uDqzQVad8VjDG56zJmkgmxZXCKcM6RNm3QEm
	 4bmm7RID2IuTNqLwj3RqvMIv38YlUlqSQ13d4RTLKD9Xrnu+lyyOrngnGFDHjhPM06LJk
	 5J8LtGsslyYTkTTSOxrU+8cKC9TNNm9Z0Ln+aARB+K70BsbylqqoFVxDLftcCLl5jcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794353212;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lMj4a7oYX77ytSW8zRltuh8urPoD0FH8TLMIqcfibW8=;
	b=dd8lXgUdhJNIOrGUo/FTiYtbuqJu0sehEC3w7ujFp4jRgol15WLyj1fLo8BiOhvvsFaz
	 EQkkVQgagMa+sAI0tNsrAufjHQgL8PUS8oa22/MiaQNbK3uPgDi+bY6LWYSo2vmN0Our1
	 ceF+tJ6c5s6dn+XfX/if23FseI33E/WkqriVgki3Ifwni/vWSRwdAtSm7BKurXlEjJpzo
	 Ar4+1yyuqsPTT1pgoTE0iH8U3bJVU5+1qARAF0VL18Ho/AJjCEnYBsDa3YyXCrKQokoq7
	 sWM0jcUfG2Kbd1yIITDZSHM4CiZPVamiL3z+KOicT23mj9iw5OIUN61JCXZnAtTyDxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="f/D0VP0v";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C90606A320;
	Tue, 10 Nov 2026 23:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f/D0VP0v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681071F0093C;
	Tue, 10 Nov 2026 23:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794353211;
	bh=lMj4a7oYX77ytSW8zRltuh8urPoD0FH8TLMIqcfibW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f/D0VP0v7e4f5IJkFoR8bQ4PFQS2jqzLCqiSasy8MKeSy13rFPavF/G35vwM9S7oa
	 W4mU0Bei7NM/0t2MStHGjzTaEPuR5Cj1jyGdQpFQ78+coJ4n5+8RMzkmnndo+YQT4O
	 GJ50dz+f1UrO/J1oVXrPqj7lZ5e9C9rwNYkP2k/pjV0tGZDMhnXj1zy17tCuNf1F4r
	 UpCUxoteRkrf4EPQSe3d8Ot30O902bVSXxzm6NsPiYhMfOg60hVbFJo4AqDBZljsvB
	 fCMV/XwHTtXbrGrgZYlSDHr3QQIkGQJsO4jp8zUJ0kr0sPJePmu8ifqtHOr0mB/9EM
	 6lkVmV7sbXmcA==
From: Jakub Kicinski <kuba@kernel.org>
To: kyle.switch@motor-comm.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mmyangfl@gmail.com,
	horms@kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com,
	jianmin.wang@motor-comm.com,
	wei.zhang@gl-inet.com,
	sijia.huang@gl-inet.com
Subject: Re: [PATCH net-next v17 1/5] net: dsa: motorcomm: initialize dsa_switch based on chipid
Date: Tue, 10 Nov 2026 15:26:50 -0800
Message-ID: <20261110232650.2437095-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105031442.4164960-2-kyle.switch@motor-comm.com>
References: <20261105031442.4164960-2-kyle.switch@motor-comm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c
> @@ -2574,6 +2574,67 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
>  	.setup			= yt921x_dsa_setup,
>  };
>  
> +static const struct yt92xx_series yt92xx_series_table[] = {
> +	[YT92XX_MODE_YT921X] = {
> +		.name = "YT921x",
> +		.max_ports = YT921X_PORT_NUM,
> +		.num_lag_ids = YT921X_LAG_NUM,
> +		.ageing_time_min = 1 * 5000,
> +		.ageing_time_max = U16_MAX * 5000,
> +		.dscp_prio_mapping_is_global = true,
> +		.assisted_learning_on_cpu_port = true,
> +		.switch_ops = &yt921x_dsa_switch_ops,
> +		.mac_ops = &yt921x_phylink_mac_ops
> +	},
> +};
> +
> +static const struct yt92xx_series *yt92xx_series_lookup(u32 major)
> +{
> +	if (major == YT9215_MAJOR || major == YT9218_MAJOR)
> +		return &yt92xx_series_table[YT92XX_MODE_YT921X];
> +	else
> +		return NULL;
> +}
> +
> +static int yt92xx_register_switch(struct dsa_switch *ds)
> +{
> +	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
> +	struct device *dev = yt921x_priv_to_device(priv);
> +	const struct yt92xx_series *series;
> +	u32 chipid;
> +	u32 major;
> +	int res;
> +
> +	mutex_lock(&priv->reg_lock);
> +	res = yt921x_reg_read(priv, YT921X_CHIP_ID, &chipid);
> +	mutex_unlock(&priv->reg_lock);
> +	if (res) {
> +		dev_err(dev, "Unexpected chipid 0x%x\n", chipid);
> +		return res;
> +	}
> +
> +	major = FIELD_GET(YT921X_CHIP_ID_MAJOR, chipid);
> +	series = yt92xx_series_lookup(major);
> +	if (!series) {
> +		dev_err(dev, "Undefined series info for the corresponding major\n");
> +		return -ENODEV;
> +	}
> +	priv->series = series;
> +
> +	ds->assisted_learning_on_cpu_port =
> +		priv->series->assisted_learning_on_cpu_port;
> +	ds->dscp_prio_mapping_is_global =
> +		priv->series->dscp_prio_mapping_is_global;
> +	ds->ageing_time_min = priv->series->ageing_time_min;
> +	ds->ageing_time_max = priv->series->ageing_time_max;
> +	ds->num_lag_ids = priv->series->num_lag_ids;
> +	ds->num_ports = priv->series->max_ports;
> +	ds->ops = priv->series->switch_ops;
> +	ds->phylink_mac_ops = priv->series->mac_ops;
> +
> +	return 0;
> +}
> +
>  static void yt921x_mdio_shutdown(struct mdio_device *mdiodev)
>  {
>  	struct yt921x_priv *priv = mdiodev_get_drvdata(mdiodev);

[Severity: Medium]
If yt921x_reg_read() fails, yt921x_reg_mdio_read() returns before
it writes *valp. That leaves chipid as uninitialized stack data when
it is passed to dev_err() here.

The message is also misleading. On this path the read failed and the
chip ID was never obtained, so "Unexpected chipid" followed by a
random value is no help to someone debugging a broken MDIO bus. KMSAN
would also report it as an uninit-value use.

Could you print the error code from res here instead? The chip ID can
be reported in the !series branch, where it has actually been read
and is the value that is unexpected.

The YT922x patch later in the series already moves the message there.
Please fold that change into this patch so each commit stands on its
own and the series stays bisectable.
-- 
pw-bot: cr
