Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792625496;
	b=wZ23fOPx16tXmpzy4ZfTskEGGk+1WQVSo/FZl7xt16HzhiQhWH9q/AYC4xTbe2VIfFjY
	 nAzdsYK/TIRdEW6M9v/Sju7ROqELbDA42Dmh501BKiboFKWFA7fYb5pQpNcyqrKSNvrUi
	 2lvrGjfS48CF1GC5RJZH839ufKdAtUXogfh3h6FlC6EZEwQFIVgQ8NBDhrc+7dusvXMe5
	 lsnxsmQGOiAUKL0Zw4WLMKxhw1p2hhPkmKPZXA1lnIivLdeCcTX7I8kYZVOTue0/Fa8XT
	 BKyQy10xNVWF7eS6DGsYbGRzsjU7DfvBoMDnODb/V/31tOs28oAr08YIOuFPAmDJQVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792625496;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=gubuEfC9JrzapkKE3aUtTaIp1VZ+4CaTKPQp6ZYOx5c=;
	b=IMfRffNKEH3uJISPEQiSd/HLG/NmpcOsnPc3tUDnVR2vJSaZnnDOBphpzTccSVZL7I3e
	 XNhCsZjvtQvEBZhRgCX+/I+WzuCz3u7F+wboDyQEbi5268kegFbaggEeqYsAIv4I4rbSy
	 zpOVwY4F8Jilbe96SzIVFSHc+gnUmlmBMpkDqux50YGkg92Mh3IA+adYz+rf+86ONRi2c
	 LGpN96goh6J8l0luH0MTCVPCA2a/xIij6I6lfK49Q+iyQgZH/PM2EJ9IKAaWwdrmZPzIT
	 5UWVhrA1JMowfalNRTshIHQx8EFEviD4ZGg6WLHvP6VmSPpPl9k8iGtZTurBPOTMC/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o3b1VjgQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C98A606A319;
	Wed, 21 Oct 2026 23:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o3b1VjgQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5301F000C1;
	Wed, 21 Oct 2026 23:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792625495;
	bh=gubuEfC9JrzapkKE3aUtTaIp1VZ+4CaTKPQp6ZYOx5c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=o3b1VjgQL/Jp7P7fyxjOMoMPX2DJQVIZKZ1Qm7b+Gbyz0gDgkTKaBq9L4OcffYGug
	 T6D/tBPIZRQLga1skI8SGMEsrsmn5rwFjGw33sEQCaV9FrIRW54QhKN13vQvCx2u8C
	 tI1Ne9KaOSwFtTprgHCB8Vw+DbHFZf/jfaencH4xgWf8u3Rh8bpQ8NPoZxwFyKExWr
	 y2la8+py1f17DcRerJjSCKH1TYKglUb9Hek0SoQaSOVAhcQ+Tx+Sm4OVrMAHOu6/Sp
	 34SLMSwACixU9xqkUevWlcsQrefQ97al474xC9oAubE1tHYO5a6SOuyaU6wwfsX+aj
	 LJyHn2l97hvJg==
Subject:
 Re: [PATCH] team: fix promisc/allmulti leak in team_port_add error path
From: netdev-bot+sashiko@kernel.org
To: lirongqing@baidu.com
Cc: jiri@resnulli.us, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, liuhangbin@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 21 Oct 2026 23:31:34 +0000
Message-ID: <179262549484.3135.4170374888758470741@kernel.org>
In-Reply-To: <20261019083122.1841-1-lirongqing@baidu.com>
References: <20261019083122.1841-1-lirongqing@baidu.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch has the wrong Fixes: tag.

--

team: fix promisc/allmulti leak in team_port_add error path

This commit undoes the port's promiscuity and allmulti increments on the
err_set_dev_type path of team_port_add() in drivers/net/team/team_core.c.
Before this change, that path left both increments in place when
team_dev_type_check_change() failed.

> Fixes: 43c2adb9df7d ("team: set slave to promisc if team is already in promisc mode")

[Severity: Medium]
Is this the right commit for the Fixes: tag?

Before commit 0ae9cfc454ea ("team: Move team device type change at the
end of team_port_add"), team_port_add() called
team_dev_type_check_change() near the top of the function. That was
before the port was allocated or promisc/allmulti was raised, and a
failure there just did a plain return err. So in trees from 43c2adb9df7d
up to 0ae9cfc454ea, no increment exists yet when the type check fails.

Commit 0ae9cfc454ea moved the call below the promisc/allmulti block and
added the err_set_dev_type label. That label falls straight through to
the other labels:

    err = team_dev_type_check_change(dev, port_dev);
    if (err)
        goto err_set_dev_type;
    ...
err_set_dev_type:
err_set_slave_allmulti:
err_set_slave_promisc:
    __team_option_inst_del_port(team, port);

This sentence in the commit message is therefore only true from
0ae9cfc454ea onward:

> team_port_add() increments the port's promiscuity and allmulti
> counts before calling team_dev_type_check_change().

Trees that have 43c2adb9df7d but not 0ae9cfc454ea have no
err_set_dev_type label, so a stable backport based on the current tag
would not apply there.

Should the tag be the following instead?

Fixes: 0ae9cfc454ea ("team: Move team device type change at the end of team_port_add")

The code change itself looks correct. It matches the cleanup in
team_port_del().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019083122.1841-1-lirongqing%40baidu.com
