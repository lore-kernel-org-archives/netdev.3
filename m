Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B7C3AC0EC;
	Mon, 22 Jun 2026 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782135350; cv=none; b=qkv70XTQQ89ZfFRjLdVC9w+U//TRZh0zdVXqEYN+Ilzt4bfJ2S4JdxZI3l/W3VouqFGkqy2KlKDGC6tb4q6iLJS1Egk343CHeqjRvLGxq68ufep5rW2Czihluq/l5PujxCILh4tguKkWn6WU+GX37Wco1CwGGji9Pim/rHB0Bp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782135350; c=relaxed/simple;
	bh=79GrnNmccOWEnTcWsWeS1nETBKc4S2/rQl047Me7XZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2Lb066AYxZhShtDrLcfkrlc+pFqkN0i6Wz5ecrVrN3arJs5rUnNrBTl1CO+XDCjUp+ph2bKHFeA8IwJqLlM2YetpLkXbhSWZ5K0V7xReyc9GTCOOSXoyVWg+DoYZqKTjvxv7mrkRONbwLDq8yG2b19NcYSrNDOiXErag0f2yzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFXni578; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFXni578"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760521F000E9;
	Mon, 22 Jun 2026 13:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782135348;
	bh=1Fh81ithYkoGIp0Hgtq9CaMm1HVH3MBQhaSNQwHHFbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YFXni578peR0ZKlOn9yOiZ7p47SFlU3xPWWtYEPmY7U7icOQjPwA++Pppbelh2x0z
	 bjzjl7ZP7AMOmqTv23aAokB2DRAt7F5YmeTHxE51lB6hW5u3WzkXunzK59CLKPxKyo
	 TdMl9CYIHXOLewuNsSzNjpAkK8gKM7wcFy36VD/qwP+hSBrFGLs/3yoAolhJlaJPYj
	 Yqjq2vPk1EAM1Oiq7zDRS1RGS5W+DJtKM00m+c+vi67Gu34hGHSYZRNaXZh2B6mie5
	 hH4xNescEM02xU9LRMHJSCHei+KfqAz+HO/We/5W3MiZia9zjpfvOXWHG3kIqNs7ux
	 zWS/zYAoJgddA==
From: Simon Horman <horms@kernel.org>
To: hrushirajg23@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+6c25f4750230faf70be9@syzkaller.appspotmail.com
Subject: Re: [PATCH] netdevsim: fix use-after-free in __nsim_dev_port_del
Date: Mon, 22 Jun 2026 14:35:13 +0100
Message-ID: <20260622133513.1025185-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260620064937.16301-1-hrushirajg23@gmail.com>
References: <20260620064937.16301-1-hrushirajg23@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
Subject: netdevsim: fix use-after-free in __nsim_dev_port_del

The patch removes the per-port debugfs directory in nsim_destroy()
before free_netdev() so that debugfs files referencing fields inside
the netdevsim struct cannot be reached after the slab is released.

Link: https://syzkaller.appspot.com/bug?extid=6c25f4750230faf70be9

> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> index 27e5f109f933..08136e7990cb 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -1214,6 +1214,13 @@ void nsim_destroy(struct netdevsim *ns)
>  		ns->page = NULL;
>  	}
>  
> +	/*
> +	 * Remove per-port debugfs files before free_netdev() releases the
> +	 * netdevsim struct to prevent use-after-free in concurrent readers.
> +	 */
> +	debugfs_remove_recursive(ns->nsim_dev_port->ddir);
> +	ns->nsim_dev_port->ddir = NULL;
> +
>  	free_netdev(dev);
>  }

[High]
Does the same use-after-free window remain on the nsim_create() error
path?

nsim_create() unconditionally calls nsim_ethtool_init(ns) before the
init step that can fail:

    SET_NETDEV_DEVLINK_PORT(dev, &nsim_dev_port->devlink_port);
    nsim_ethtool_init(ns);
    if (nsim_dev_port_is_pf(nsim_dev_port))
        err = nsim_init_netdevsim(ns);
    else
        err = nsim_init_netdevsim_vf(ns);
    if (err)
        goto err_free_netdev;
    ...
err_free_netdev:
    free_netdev(dev);
    return ERR_PTR(err);

nsim_ethtool_init() populates files under nsim_dev_port->ddir whose
data pointers reference fields inside ns, for example:

    ethtool = debugfs_create_dir("ethtool", ns->nsim_dev_port->ddir);
    debugfs_create_u32("get_err", 0600, ethtool, &ns->ethtool.get_err);
    debugfs_create_u32("set_err", 0600, ethtool, &ns->ethtool.set_err);
    ...
    dir = debugfs_create_dir("ring", ethtool);
    debugfs_create_u32("rx_max_pending", 0600, dir,
                      &ns->ethtool.ring.rx_max_pending);

If nsim_init_netdevsim() (or nsim_init_netdevsim_vf()) fails, the
err_free_netdev label runs free_netdev(dev) directly and returns
ERR_PTR(err). The caller then calls nsim_dev_port_debugfs_exit() to
tear down ddir, but in the meantime the netdevsim slab has already
been freed while these debugfs files are still live with data pointers
into it.

Should the same debugfs_remove_recursive(nsim_dev_port->ddir) be done
on the err_free_netdev path before free_netdev(dev), or should the
debugfs file creation be moved past the point of no return so the
fuzzer-reachable failure paths (alloc pressure on mock_phc_create,
register_netdevice, nsim_psp_init, etc.) cannot leave dangling
debugfs entries?

The Fixes: tag e05b2d141fef appears to cover this path as well.
