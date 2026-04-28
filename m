Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE18F2DFA3A;
	Tue, 28 Apr 2026 02:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777341694; cv=none; b=maw4LBA2vnzVJ6/GWPg24ObVDdXc9EeOwXEBUWrSr78O9aJC8Skcu7bHeEB14jmqXjvyI/1pFfiA6yX1DG7NBjenOIQKrSBwPr+82UHQ+g2YtZ9QyVAJIUShMoUcVbefPrXGD/khg1weDyftf9tRIbiUc5RtW9B5sv8Mj4xTgP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777341694; c=relaxed/simple;
	bh=pQMwDjX/CP8mtKyi6UN+8l18aMO5e8eGqIhZnzfd6aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHY7iDpr96LBkCZrCL5PkCahiTbpdDqpmFCeiAq3fJyrLxDrnySHgdTXXNSiPIzOZm1fsPlGm6ZMMVu20lGPZjhxZqsvaEh1+DAfNSwwvcLyNWKw5a247mfh0+aHmZo6SXEvCNCclopCcHF58YSX9i6o5eRW3GdrhHGBvnr5xjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5p9cNV6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5p9cNV6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6F5C19425;
	Tue, 28 Apr 2026 02:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777341694;
	bh=pQMwDjX/CP8mtKyi6UN+8l18aMO5e8eGqIhZnzfd6aU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R5p9cNV6UNfqffwM4YZf9gQUGMQKexIxyu7JZ5wXlJxRhVthKjK/BXKezthmkHMbu
	 aN2HBzTmDVEn1Tnu7Vhob0qVVKoyp0f7CYpITSc0TisYlJIJX/DD19VEhUxkijZa8I
	 ujok4c35d8zQNmh0QFzJ1uhWioaB14sVvPUfowYf5bpZ9GNeen7GtkfeEz3q6hnyiH
	 BDFtLDhNlzgymCjXIBcSiyKOMD18J7zmFLCEJyBk+SMlxA53htj1qO5wDWb3zHQEZl
	 XhwBMBiXVcOinWUb5MAAhdAuDZG7ElFsgFxNcU11tNtrx8g1YRfcVKL29tTkE+g1Sq
	 Q/35oc6eum7Zw==
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
	ansuelsmth@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v3] net: dsa: mt7530: fix .get_stats64 sleeping in atomic context
Date: Mon, 27 Apr 2026 18:59:44 -0700
Message-ID: <20260428015943.774891-2-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <8c407b36d8a597c1449ff9335dfdc250d76311c3.1777034225.git.daniel@makrotopia.org>
References: <8c407b36d8a597c1449ff9335dfdc250d76311c3.1777034225.git.daniel@makrotopia.org>
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
net: dsa: mt7530: fix .get_stats64 sleeping in atomic context

This change converts MDIO-connected mt7530 switches to poll MIB counters
via a delayed workqueue and have .get_stats64 return cached values under
a spinlock, avoiding a sleeping-in-atomic-context issue.  MMIO-connected
variants continue to read directly.

> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index b9423389c2ef..9733ff9fc322 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c

[ ... ]

> +static void mt7530_stats_poll(struct work_struct *work)
> +{
> +	struct mt7530_priv *priv = container_of(work, struct mt7530_priv,
> +						stats_work.work);
> +	struct rtnl_link_stats64 stats = {};
> +	struct dsa_port *dp;
> +	int port;
> +
> +	dsa_switch_for_each_user_port(dp, priv->ds) {
> +		port = dp->index;
> +
> +		mt7530_read_port_stats64(priv, port, &stats);
> +
> +		spin_lock_bh(&priv->stats_lock);
> +		priv->ports[port].stats = stats;
> +		priv->stats_last = jiffies;
> +		spin_unlock_bh(&priv->stats_lock);
> +	}
> +
> +	schedule_delayed_work(&priv->stats_work,
> +			      MT7530_STATS_POLL_INTERVAL);
> +}
> +
> +static void mt7530_get_stats64(struct dsa_switch *ds, int port,
> +			       struct rtnl_link_stats64 *storage)
> +{
> +	struct mt7530_priv *priv = ds->priv;
> +	bool refresh;
> +
> +	if (priv->bus) {
> +		spin_lock_bh(&priv->stats_lock);
> +		*storage = priv->ports[port].stats;
> +		refresh = time_after(jiffies, priv->stats_last +
> +					      MT7530_STATS_RATE_LIMIT);
> +		spin_unlock_bh(&priv->stats_lock);
> +		if (refresh)
> +			mod_delayed_work(system_wq, &priv->stats_work, 0);
             ^^^^^^^^^

Is the target workqueue here intentional?  The re-arm path at the end of
mt7530_stats_poll() and the initial arming in mt753x_setup() both go
through schedule_delayed_work(), which expands to:

    queue_delayed_work(system_percpu_wq, dwork, delay)

whereas this site passes system_wq.  Those are two distinct workqueue
allocations in kernel/workqueue.c, so each on-demand refresh moves the
delayed_work between the two queues.

include/linux/workqueue.h also marks system_wq as deprecated:

    /* Please use system_percpu_wq, this will be removed */
    extern struct workqueue_struct *system_wq;

Should this call use system_percpu_wq (or mod_delayed_work on the same
queue that schedule_delayed_work() targets) to keep the work on a single
workqueue and avoid the deprecated symbol?

> +	} else {
> +		mt7530_read_port_stats64(priv, port, storage);
> +	}
> +}
> +

[ ... ]

> @@ -3137,9 +3181,24 @@ mt753x_setup(struct dsa_switch *ds)
>  	if (ret && priv->irq_domain)
>  		mt7530_free_mdio_irq(priv);
>  
> +	if (!ret && priv->bus) {
> +		spin_lock_init(&priv->stats_lock);
> +		INIT_DELAYED_WORK(&priv->stats_work, mt7530_stats_poll);
> +		schedule_delayed_work(&priv->stats_work,
> +				      MT7530_STATS_POLL_INTERVAL);
> +	}
> +
>  	return ret;
>  }

How does .get_stats64 behave during the first MT7530_STATS_POLL_INTERVAL
(1 * HZ) after setup?

priv->ports[port].stats and priv->stats_last come from the devm_kzalloc
allocation in mt7530_probe_common(), so both are zero.  The first poll
is scheduled with a delay of MT7530_STATS_POLL_INTERVAL, so any reader
during that first second sees:

    spin_lock_bh(&priv->stats_lock);
    *storage = priv->ports[port].stats;   /* all zero */
    refresh = time_after(jiffies, priv->stats_last +
                                  MT7530_STATS_RATE_LIMIT);
    spin_unlock_bh(&priv->stats_lock);

Can the on-demand refresh path help here?  time_after() is defined as:

    #define time_after(a,b)         \
        (typecheck(unsigned long, a) && \
         typecheck(unsigned long, b) && \
         ((long)((b) - (a)) < 0))

On 32-bit, jiffies starts at INITIAL_JIFFIES = (unsigned long)(unsigned
int)(-300*HZ), which is close to ULONG_MAX.  With stats_last == 0, the
signed difference check can evaluate to false for a long time, so the
mod_delayed_work() refresh is suppressed until the first scheduled poll
updates stats_last.

Would seeding priv->stats_last = jiffies at init, and either populating
the cache synchronously in mt753x_setup() or scheduling the first poll
with delay 0, avoid returning zeroed counters and the suppressed
on-demand refresh during the initial window?
-- 
pw-bot: cr
