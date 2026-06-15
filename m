Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EB5370AE5;
	Mon, 15 Jun 2026 23:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781567823; cv=none; b=KxfxAw2qfgqr7qjZa3LdDLWsYFSkNVNMQvI6U+AbOcmLjT32g2m6xHxlGHIZRb6kAlBpYOMQbQ7huMcbxGkJuh9ytAm5jaU+yByDXE7NeBUq5+vPJfRnTUu4hgRBFtpmHOq2LqxfczGqEHv7QewPTjThAc3cwNjgsiR33rIb+f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781567823; c=relaxed/simple;
	bh=6W3iFF7uq/VmMJh7J+I+z087+QDQ2TP8HrDD6bam5xU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXd9AiSZaqASXsctjpMwE5tnALTmGAJvvjUzwxh8mfWmHFh0UI4ejM0mWN86/5oUw3llTxpvzuZBmOy7zFdrjrqvobsT3HdLYznKsSzY7V1oqQoQuVL7UC0vd1gMr8p4klZsuXezcr4rJzQqZxd6bGxFlDZjTQSifvddgb1EKb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlTm9La1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlTm9La1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D791F00A3A;
	Mon, 15 Jun 2026 23:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781567821;
	bh=fDHskcalX1Eyf5uU4t/aR1BqkGPnh3W34m8qlSr4iSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mlTm9La1e0PbaoG/565k376Z7ZCfCgpox1mynJ7RroJibim8k/kSsGsiaEZ8gTNKa
	 Lt1aOHaq8+DYXADx1lL51u2FfCCYRjSDaOSUi8hg88zbBEEXpfZKDsImEiLv29pw8y
	 u0LAB5GO6wxDuwN4ycTFKeALNH2IJYOhdlVX2hKmh9q5jmfVSqqyKV8OBAxmZwd8+n
	 mtCX+Er52/f/SzKn4UofoIwWpvSwBEZh9QwYhBawPgG7kr4VBahNHGUubXoAC+pD43
	 2+ZmEJwoDTZDovIX46ufp5e47L4GDnT1teBNxFDs/NPdxfgxnWbkDdhUelGfRSWGGI
	 SUkw8h4sS5xJw==
From: Jakub Kicinski <kuba@kernel.org>
To: daniel@makrotopia.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	chester.a.unal@arinc9.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2 8/8] net: dsa: mt7530: implement port_change_conduit op
Date: Mon, 15 Jun 2026 16:57:00 -0700
Message-ID: <20260615235700.1060843-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <8dd8cfe32bc8e38b92c49e30a6255090fb0998fb.1781312667.git.daniel@makrotopia.org>
References: <8dd8cfe32bc8e38b92c49e30a6255090fb0998fb.1781312667.git.daniel@makrotopia.org>
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
net: dsa: mt7530: implement port_change_conduit op

Implements the port_change_conduit operation for the mt7530 driver,
updating the port matrix to forward to a new CPU port. The op is
restricted to MT7531 because MT7530/MT7621 cannot honour per-port CPU
affinity for trapped frames and the MT7988/EN7581/AN7583 switches have
only a single CPU port.

> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index c96420c291d5..2f3e734b9f53 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -3206,6 +3206,34 @@ static int mt753x_set_mac_eee(struct dsa_switch *ds, int port,
>  	return 0;
>  }
>  
> +static int
> +mt753x_port_change_conduit(struct dsa_switch *ds, int port,
> +			   struct net_device *conduit,
> +			   struct netlink_ext_ack *extack)
> +{
> +	struct dsa_port *new_cpu_dp = conduit->dsa_ptr;
> +	struct dsa_port *dp = dsa_to_port(ds, port);
> +	struct mt7530_priv *priv = ds->priv;
> +
> +	if (priv->id != ID_MT7531)
> +		return -EOPNOTSUPP;

[Low]
Should this branch populate the supplied extack with NL_SET_ERR_MSG_MOD()
before returning -EOPNOTSUPP?

Because port_change_conduit is registered in the shared mt7530_switch_ops
table, the DSA core's fallback message in dsa_user_change_conduit() ("Driver
does not support changing DSA conduit") is bypassed; that branch only runs
when ds->ops->port_change_conduit is NULL. Neither dsa_port_change_conduit()
nor __dsa_port_change_conduit() in net/dsa/port.c synthesize an extack on
callback failure either.

The result is that on MT7530, MT7621, MT7988, EN7581 and AN7583, userspace
invoking IFLA_DSA_CONDUIT receives EOPNOTSUPP with an empty extack, with
none of the per-chip context that the commit message itself spells out
(single CPU port; MT7530 MFC CPU_PORT trapping limitation). Would a short
NL_SET_ERR_MSG_MOD() naming the reason be appropriate here?

> +
> +	mutex_lock(&priv->reg_mutex);
> +
> +	/* dp->cpu_dp still points to the old CPU port */
> +	priv->ports[port].pm &= ~PCR_MATRIX(BIT(dp->cpu_dp->index));
> +	priv->ports[port].pm |= PCR_MATRIX(BIT(new_cpu_dp->index));
> +	if (priv->ports[port].enable)
> +		regmap_update_bits(priv->regmap, MT7530_PCR_P(port),
> +				   PCR_MATRIX_MASK, priv->ports[port].pm);
> +
> +	mutex_unlock(&priv->reg_mutex);
> +
> +	mt7530_port_fast_age(ds, port);
> +
> +	return 0;
> +}
