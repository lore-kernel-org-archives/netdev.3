Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF9430DD2F;
	Wed, 30 Sep 2026 03:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790738380; cv=none; b=VBPqM9ZNItQrJ8Up8tXugyqmjmFIleqfU00Rf8ad1p5kfxjiJkYg5lW1IVANYoxHR2yL3gmoX6HzbOOQnZb8bB0Bk7zPiS8OKcXE9DMKKkgXLrHgZ4Sd91ZKNWRpKDQbpJyMb/5QGlkBYfTJ4ny7x+PuFM3f0HQ+lVP5JK/M2ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790738380; c=relaxed/simple;
	bh=07Lnac7NloUDwkzGmRE2h44PillUh4mIH0xyUvof/XU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AKHRqxOkJv5BwDNcj0s9IwHb5wY9OZyR8m1V2ZWM66n9QRAO80pQ/1TDiMTO/Qhyjl6kdnCADAgL/V/W4nhhm7J5Lpn2R6VkmE40sdBe+P9Tt2K36iMCAa5g0nF8Wc7oruqHSZB2wPFYjaJPy58f5YXPyKlvxjBu5NTK00RJfdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6SEZL+1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6SEZL+1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800851F00893;
	Wed, 30 Sep 2026 03:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790738379;
	bh=TF8Wvl9XYpoubaEd2TyKf7G96qPB9UtRTPH2re8V3/Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=b6SEZL+1n9PmPFtsDbpy6USJZPrcuY87TuuoSnabWfLN+rbqDfunLGAZdjoxWi/j/
	 yqJSkjoS8BLViFf6uWgapochQdhmrIjve8UdPBQJ1Q+cMs4FjptU9XfJsU4xoil2Y1
	 f1dX/ZZymE2dSDhvlzeVrnxMDWiBxxLdoHV3TSPjiEYzqK2mVItycJnEAvutnWaNtJ
	 FFvbkOqVswUP4KoR5OrkPT1LqW40sWW0nnhpJgl5p1RzVMUAH2j0A2v4u6kz2eeHwF
	 G+dOT7+Rxhh/0IekRMIPKtOKED69cwCZECrta5FuQmOa1nqtZIdWLIitv+RmkZJqAq
	 pJx8SKAE/gr9A==
Subject: Re: [PATCH net-next 3/6] net: dsa: motorcomm: Enable ACL on demand
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Wed, 30 Sep 2026 03:19:38 +0000
Message-ID: <179073837810.434549.17458326293756171392@kernel.org>
In-Reply-To: <20260926211813.935723-4-mmyangfl@gmail.com>
References: <20260926211813.935723-4-mmyangfl@gmail.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In yt921x_acl_add() (drivers/net/dsa/motorcomm/tc.c), ACL
  lookup is switched on in hardware for every source port whose acl_cnt…

--

net: dsa: motorcomm: Enable ACL on demand

This patch adds a per-port acl_cnt field to struct yt921x_port to count
ACL rules. YT921X_ACL_PORT is now initialised to 0 in
yt921x_chip_setup_acl(). yt921x_acl_add() and yt921x_acl_del() then turn
the per-port enable bits on and off based on those counts.

> diff --git a/drivers/net/dsa/motorcomm/tc.c b/drivers/net/dsa/motorcomm/tc.c
> index 7717f1e179235..0f6d7a4675fcd 100644
> --- a/drivers/net/dsa/motorcomm/tc.c
> +++ b/drivers/net/dsa/motorcomm/tc.c

[ ... ]

> @@ -1274,6 +1309,18 @@ yt921x_acl_add(struct yt921x_priv *priv,
>  		}
>  	}
>  
> +	ctrl = 0;
> +	m = FIELD_GET(YT921X_ACL_KEYb_SPORTS_M, ruleext->r.entries[0].key[1]);
> +	for_each_set_bit(o, &m, YT921X_PORT_NUM)
> +		if (!priv->ports[o].acl_cnt)
> +			ctrl |= YT921X_ACL_PORT_PORTn(o);
> +	if (ctrl) {
> +		ctrl |= yt921x_acl_activated_ports(priv);
> +		res = yt921x_reg_write(priv, YT921X_ACL_PORT, ctrl);
> +		if (res)
> +			return res;
> +	}

[Severity: Medium]

If yt921x_acl_add() fails after this write, can the switch and the driver
end up disagreeing about YT921X_ACL_PORT?

The register is written before several steps that can still fail.
However, acl_cnt is only incremented after yt921x_acl_commit() succeeds.
None of the later failure paths write YT921X_ACL_PORT again:

	aclblk = kvzalloc_obj(*aclblk);
	if (!aclblk)
		return -ENOMEM;
	...
	aclrule = kvmemdup(...);
	if (!aclrule) {
		res = -ENOMEM;
		goto err;
	}
	...
	res = yt921x_acl_commit(priv, entid, aclrule->mask);
	if (res) {
		aclblk->rules[binid] = NULL;
		kvfree(aclrule);
		goto err;
	}

On any of these paths, the newly enabled port bits stay set in the switch.
Meanwhile, yt921x_acl_activated_ports() still reports those ports as
inactive.

Deleting a rule on the same port can't clear the stale bit, because the
failed rule was never recorded. The bit is only cleared if a later
yt921x_acl_del() drops some other port's acl_cnt to zero, sets
refresh_en, and rewrites the register from the counts.

A later patch in the series, "net: dsa: motorcomm: Add limited ACL flow
statistics support", adds two more direct-return failure points after
this write: the YT921X_FLOWSTATn_CTRL write and the YT921X_FLOWSTATn_STAT
reg64 write. That makes the window wider.

Would it work to write YT921X_ACL_PORT only after yt921x_acl_commit()
succeeds? Another option is to write yt921x_acl_activated_ports(priv)
back on each error path after this point. That value is still the one
from before the add, because acl_cnt hasn't changed yet.

>  	/* Prepare acl block ctrlblk */
>  	blkid = entid / YT921X_ACL_ENT_PER_BLK;
>  	binid = entid % YT921X_ACL_ENT_PER_BLK;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260926211813.935723-1-mmyangfl%40gmail.com
