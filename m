Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1269F44AB95
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 08:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791792953; cv=none; b=MVdxnBCa9E2DQIcduylr0uEmamDCg+H76Qm9/WV0t428apdAr4UEdLou8+G+wgu5cC8/Ph3+mSwNlyPzF9AAb/Fme3t5HDcEftyXbx1JFgX+ckIgmTq59rYX1iP5ZZmv0e3fFqgdKUNN4YiygjxSGPK49FkhIshrflEHb2HTGoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791792953; c=relaxed/simple;
	bh=ElYUggeh4S0aOVDROsbGLtvpr63iV/7x3ZP6Z1kkTMc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j1yjf5S7A99q8R64mZ3kuhq+Jr0I4hPEg99SFvsxAI8zn34+Se3S2np8U/e0ESdGLmy9TLONSee+/rozDWrePchYPDpLgdHGIHz+LxTazmiKfmM+eskNE1kheGDASsHgjnYzH/HGpQwLZvd3QhgiWU/KWyIWFj6nofwKvq622Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3QqY5vf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3QqY5vf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D631F0089C;
	Mon, 12 Oct 2026 08:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791792951;
	bh=4pPk1ouWAUwePu8xGjsuldobGtH/1bk57llpUOu6BEo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=X3QqY5vfRKCV8wGyBfWOgaBCl4vpKCc3Qnr+TE80NXulNj3/098Bmnqc3Lj+WwGj3
	 qc1uzqJ6Oixiyw0myV7x08GijCobqvUo1/PLmRexFIYOQSyoFl7A8EFwcCA+/WDhxk
	 KD3cB2pRvz755ofwiYYC7qc7cv2dfJDDIkZbXQMnwVYNJTdqGJ6OGoSef/JSqYWaHl
	 gsWSt52OQOGtNWY0ojhlMCjRfUWrFAamZD4+sshbszL1BbsXRuOb5rQh2g1iz65977
	 0btTHBKCr6tdjXS3MZzHQZwS+jOb7FYjZq8TmElS5zyCP963E7nLIIGJpmuavfXnAQ
	 Ad3kaYOj/ytDQ==
Subject: Re: [PATCH net-next 1/4] net/sched/sch_cake: serialize
 reconfiguration with the datapath
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, toke@toke.dk, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, victor@mojatatu.com, cake@lists.bufferbloat.net
Date: Mon, 12 Oct 2026 08:15:50 +0000
Message-ID: <179179295072.434549.14420097203687581555@kernel.org>
In-Reply-To: <QDISC-5RTM.v1.20261007130704-2@mojatatu.com>
References: <QDISC-5RTM.v1.20261007130704-2@mojatatu.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit fixes a real, user-visible lost update but has no
  Fixes: tag.
- [Low] The reproduction section contradicts itself, and its KCSAN recipe
  does not trigger the lost update the message describes.

--

net/sched/sch_cake: serialize reconfiguration with the datapath

This patch moves the cake_config_change() commit in cake_change() under
sch_tree_lock(), so it no longer races with the autorate-ingress rate
update in cake_enqueue(). It also converts cake_sched_config.rate_bps to
atomic64_t so that 64-bit rate stores are atomic on 32-bit machines.

Link: https://sashiko.dev/#/patchset/20260816012109.2865223-1-ooonea@gmail.com
Link: https://lore.kernel.org/netdev/20260816012109.2865223-1-ooonea@gmail.com/

> This is a follow-up to commit 7cbfb180945c ("net/sched: sch_cake: fix
> autorate reconfiguration throttling").  That change only stored
> last_reconfig_time; it did not address the concurrency between the
> autorate rate update in cake_enqueue() and the netlink reconfiguration
> path, which the original review flagged.

[ ... ]

> Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260816012109.2865223-1-ooonea@gmail.com
> Link: https://lore.kernel.org/netdev/20260816012109.2865223-1-ooonea@gmail.com/
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

[Severity: Low]
Should this have a Fixes: tag?

Before this patch, cake_change() called cake_config_change() with only
RTNL held. The sch_tree_lock() covered only cake_reconfigure(). The
autorate store in cake_enqueue() runs under the qdisc root lock:

    q->config->rate_bps = (q->avg_peak_bandwidth * 15) >> 4;

Commit 7cbfb180945c only added the last_reconfig_time store and did not
introduce the race. Both racing writers go back to 7298de9cd725, and
7cbfb180945c lists that same commit in its own Fixes: tag.

Without a tag, stable selection may miss this fix. Would something like
this be appropriate?

    Fixes: 7298de9cd725 ("sch_cake: Add ingress mode")

> Conditions to recreate the bug: build with CONFIG_KCSAN=y (the race is
> otherwise not observable on 64-bit), put cake in autorate-ingress on a
> device, drive bursty traffic with gaps so the 250ms autorate
> reconfiguration fires, and concurrently loop 'tc qdisc change dev ...
> cake bandwidth <N>kbit autorate-ingress'.  The lost update of the
> installed rate is reproducible without a sanitizer by running bursty
> senders while repeatedly changing an autorate qdisc to a fixed
> 'bandwidth X' and reading the installed rate back.

[Severity: Low]
Do these two recipes describe the same bug?

The KCSAN loop passes autorate-ingress, so cake_config_change() keeps
CAKE_FLAG_AUTORATE_INGRESS set:

    if (tb[TCA_CAKE_AUTORATE]) {
        if (!!nla_get_u32(tb[TCA_CAKE_AUTORATE])) {
            ...
            rate_flags |= CAKE_FLAG_AUTORATE_INGRESS;
        } else {
            rate_flags &= ~CAKE_FLAG_AUTORATE_INGRESS;
        }
    }

With autorate still enabled, the next estimate is supposed to replace N.
That loop would produce a KCSAN data-race report on rate_bps. It would
not show the lost configured rate from the race diagram, which needs a
change that clears autorate ('bandwidth X' without autorate-ingress).

Also, "the race is otherwise not observable on 64-bit" seems to
contradict the next sentence. The lost update does not depend on a torn
store, so it happens on 64-bit too. Only the torn 64-bit store is
specific to 32-bit.

Could the reproduction section keep the two effects separate and give a
recipe that matches the race diagram?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-5RTM.v1.20261007130704%40mojatatu.com
