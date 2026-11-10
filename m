Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319707;
	b=VrsCPc5dx1CjY9JYYl4pDizQLm4HEdmJbqoKoOKex+NAQNEEw+woPjU5Tv93pjfTjzuX
	 pUaSuftPK+VMYkrP9LoIfjd0CESRUMmKDiGfCHXGbKjMbhdCCWpJWb8GHe6PGdHqF7APr
	 bhZAeFkQydYie2fupTCcvQOKuXLowS1K4U6C8kCNUn1DHLAsPq6qEDRt/TVlx1D5Lr2SW
	 DmVQYbtNPIxNjgcq+J2vPRTQmA3AoeZYv4Dpb7EuheFaXxRC2fQuOTFPpf/s8doMxJjJh
	 hpS2o1Wi6aCvawccvTbwARB3n00Yh9mM9HCt3OLIONEBf4N32PD/120GpfiR/joy0nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319707;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=WutInSFEzjhzZ1mliUNmR4z+1sZXRiB4dByH0qWieGs=;
	b=kGjKjIlIP3mr/2U8oLmVhVlJgzN4JKmxrFVyAxuGGryWRpxMhXVgTebGBdplEFO7uA83
	 pw6Fjp22785jCKpqUU/tN6PEbGeyo7Y78DB6bm8Hdm9QBQ8dieoYKOOQLxmFjJLEToLJX
	 1dGTMSlbXHhYCuTY0vpFVe/MGq9+RrlKnyVh7tb9fpcHLF6FgaEeV9S6jHxwqYVO3q6gC
	 LOLPxNy3TRdM8s9rheQwZHgCMFQRZIVmt9t74Qn18KzCpFMo7DeragdeaULp8mL14YjsC
	 ml8P+13mZ1eG5LcPB8FL1w7HD04FvuvAs9JFKJC6YjFV/r1UcSUpblFRMsyo+MHRwKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eoaftSzo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775F6606A335;
	Tue, 10 Nov 2026 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eoaftSzo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC2C1F008A1;
	Tue, 10 Nov 2026 14:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794319707;
	bh=WutInSFEzjhzZ1mliUNmR4z+1sZXRiB4dByH0qWieGs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eoaftSzoU7HBiwGfusJazpPFleX1hnBwg5xpp9l9s5jh8cES3K/zT1GGUXGuBeqQo
	 djvYH7tSjQlitf6kdRNPGe9sG6URpIDFib3lmM3uRi6QWk6rM9wPpeO+FmG/gOj6A1
	 WyJhTI5In/bSABIPWV5uHmUKvlSv4GXouwQ2i7bkeuVDrdPTrALaQzJHgeysbj4KdF
	 xQF4NdiD7/ACbVyKXd8/AdRwu/rv4bx1OEJcuMHP0Mt2JJ1Tt4DS2g6fq3ZAZgZKld
	 /NkFFHRK5XR6/5mJYgtSrnqpa5Ju6JK5aJjmzPday3fia/PiMbUyP4dOE8htRqIfuz
	 n1tPbdHHTVmUQ==
Subject: Re: [PATCH net-next v01 4/4] Fixes: Ensure max_qps is always greater
 than or equal to num_qps
From: netdev-bot+sashiko@kernel.org
To: gongfan1@huawei.com
Cc: wudi234@huawei.com, tengpeisen@huawei.com, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, andrew+netdev@lunn.ch, ioana.ciornei@nxp.com,
 maxime.chevallier@bootlin.com, mohsin.bashr@gmail.com,
 dimitri.daskalakis1@gmail.com, hramamurthy@google.com,
 larysa.zaremba@intel.com, vadim.fedorenko@linux.dev,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 zhoushuai28@huawei.com, wulike1@huawei.com
Date: Tue, 10 Nov 2026 14:08:25 +0000
Message-ID: <179431970580.994134.13093509469738984604@kernel.org>
In-Reply-To: <4baa1668ede031c9a980e7dae711bbaef91c23e5.1793946318.git.gongfan1@huawei.com>
References: <4baa1668ede031c9a980e7dae711bbaef91c23e5.1793946318.git.gongfan1@huawei.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In hinic3_try_to_enable_rss()
  (drivers/net/ethernet/huawei/hinic3/hinic3_rss.c:309-314), the patch…
- [Medium] The subject 'Ensure max_qps is always greater than or equal to
  num_qps' describes an invariant that already held in the baseline…
- [Medium] The commit message justifies the change with an out-of-bounds
  read through netdev_nl_stats_by_netdev() -> netdev_stat_queue_sum() ->…
- [Low] The subject uses 'Fixes:' as a prefix instead of a subsystem
  prefix such as 'net: hinic3:', and there is no `Fixes: <12+ char sha>…

--

Fixes: Ensure max_qps is always greater than or equal to num_qps

This patch changes hinic3_try_to_enable_rss() in two ways. First, max_qps
is now forced to 1 only when the function reports max_qps <= 1 or lacks
RSS support, and stays at hinic3_func_max_qnum() when RSS resource
allocation or hardware configuration fails. Second, every error path now
sets q_params.num_qps to 1. The patch also reflows the signatures of
hinic3_alloc_channel_resources() and hinic3_free_channel_resources() and
renames their trxq_params argument to q_params.

> Fixes: Ensure max_qps is always greater than or equal to num_qps

[Severity: Medium]
Is this subject accurate? Before this patch, hinic3_try_to_enable_rss()
already kept num_qps <= max_qps on every exit. The error label did:

err_reset_q_params:
	clear_bit(HINIC3_RSS_ENABLE, &nic_dev->flags);
	nic_dev->q_params.num_qps = nic_dev->max_qps;

The success path goes through decide_num_qps():

	nic_dev->q_params.num_qps = min(dev_cpus, nic_dev->max_qps);

At open, hinic3_config_num_qps() only lowers num_qps further.

The problem the body describes is a different one: the per-queue arrays
sized by max_qps can be smaller than netdev->real_num_*_queues.

The message also leaves out the behaviour changes this patch makes:

- On multi-queue hardware without HINIC3_NIC_F_RSS, max_qps changes from
  hinic3_func_max_qnum() to 1. That shrinks txqs, rxqs, intr_coalesce and
  qps_msix_entries, and lowers the hinic3_get_stats64() loop bounds.
- When alloc_rss_resource() or hinic3_set_hw_rss_parameters() fails,
  max_qps now stays at hinic3_func_max_qnum() instead of 1.
- err_reset_q_params now hard-codes q_params.num_qps = 1.

Could the message describe these changes, especially the one on the
non-RSS path?

> As noted in the subsequent review.
>
> After that, hinic3_sw_init()->hinic3_try_to_enable_rss() can shrink
> max_qps to 1 when alloc_rss_resource() or hinic3_set_hw_rss_parameters()
> fails:

[ ... ]

> Would this read past the end of the rxqs and txqs slab objects and return
> those values to user space? NETDEV_CMD_QSTATS_GET does not require
> GENL_ADMIN_PERM, so any local user can issue it.
> The same applies to nic_dev->txqs[i] in hinic3_get_queue_stats_tx().
> Before this patch hinic3 had no stat_ops, and hinic3_get_stats64() bounds
> its loops by max_qps.

[Severity: Medium]
Does the code path described here exist in this tree? There is no
hinic3_get_queue_stats_rx(), hinic3_get_queue_stats_tx() or stat_ops
anywhere under drivers/net/ethernet/huawei/hinic3/. The only per-queue
stats consumer is hinic3_get_stats64(), and it is bounded by max_qps:

	for (i = 0; i < nic_dev->max_qps; i++) {
		txq = &nic_dev->txqs[i];

"Before this patch hinic3 had no stat_ops" looks like it refers to a
different, unmerged patch. If so, should this change be folded into the
patch that adds stat_ops? As a standalone fix, its rationale depends on
code that isn't in the tree.

The message also opens with "As noted in the subsequent review." and
pastes the reviewer's question ("Would this read past the end...?")
verbatim. Could it say what was wrong and how this patch fixes it
instead?

> This patch also solve some defects reported by checkpatch.

[Severity: Low]
This isn't a bug, but the subject uses "Fixes:" as its prefix instead of
a subsystem prefix such as "net: hinic3:". There is also no
Fixes: <sha> ("subject") trailer, so backport tooling can't tell which
commit this fixes.

The checkpatch cleanup in hinic3_netdev_ops.c only reflows the signatures
of hinic3_alloc_channel_resources() and hinic3_free_channel_resources()
and renames trxq_params to q_params. It has nothing to do with max_qps.
Could it go in a separate patch?

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
> index 25db74d8c7ddb..4aa725339e604 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
> @@ -308,14 +308,14 @@ void hinic3_try_to_enable_rss(struct net_device *netdev)
>  
>  	nic_dev->max_qps = hinic3_func_max_qnum(hwdev);
>  	if (nic_dev->max_qps <= 1 ||
> -	    !hinic3_test_support(nic_dev, HINIC3_NIC_F_RSS))
> +	    !hinic3_test_support(nic_dev, HINIC3_NIC_F_RSS)) {
> +		nic_dev->max_qps = 1;

[Severity: High]
Doesn't this recreate the mismatch the commit message says it closes,
and now on the normal probe path? Take a function whose firmware reports
max_sqs > 1 but doesn't advertise HINIC3_NIC_F_RSS:

hinic3_nic_probe()
    max_qps = hinic3_func_max_qnum(hwdev);
    netdev = alloc_etherdev_mq(sizeof(*nic_dev), max_qps);
    -> real_num_{tx,rx}_queues start at func_max_qnum
hinic3_sw_init()
    hinic3_try_to_enable_rss()
        nic_dev->max_qps = 1;

hinic3_alloc_txqs() and hinic3_alloc_rxqs() then size nic_dev->txqs[]
and nic_dev->rxqs[] by max_qps:

    u16 q_id, num_txqs = nic_dev->max_qps;
    ...
    u16 num_rxqs = nic_dev->max_qps;

hinic3_init_intr_coalesce() and the qps_msix_entries allocation also use
max_qps, so each of these arrays ends up with one entry.

Only hinic3_vport_up() lowers real_num_*_queues, and only on a
successful open:

	err = netif_set_real_num_queues(netdev, nic_dev->q_params.num_qps,
					nic_dev->q_params.num_qps);

Before this patch, this branch left max_qps at func_max_qnum, so the
arrays matched the netdev queue count.

The stat_ops consumer the commit message describes walks
real_num_*_queues:

netdev_nl_stats_by_netdev()->netdev_stat_queue_sum()->
    hinic3_get_queue_stats_rx()/hinic3_get_queue_stats_tx()

Once that is added, wouldn't nic_dev->rxqs[i] and nic_dev->txqs[i] read
past the one-entry slab objects on every non-RSS multi-queue function?
Any local user could trigger this via NETDEV_CMD_QSTATS_GET, which
doesn't require GENL_ADMIN_PERM.

At this revision the read can't happen yet:

- hinic3_xmit_frame() is bounded by q_params.num_qps.
- hinic3_get_stats64() is bounded by max_qps.
- There are no per-queue ethtool or stat_ops callbacks.

The bug class the message claims to fix is still there, though, and it
now hits the common no-RSS probe path rather than rare allocation or
firmware failures.

Is the new assignment needed at all? hinic3_config_num_qps() already
forces num_qps to 1 at open when RSS is off:

	if (!test_bit(HINIC3_RSS_ENABLE, &nic_dev->flags))
		q_params->num_qps = 1;

On this path, the only effect of the assignment seems to be shrinking
the arrays.

Would it be more consistent to keep max_qps = hinic3_func_max_qnum() in
every branch and set only q_params.num_qps to 1? Other options would be
to size the netdev from the same value as the arrays, or to call
netif_set_real_num_queues() during probe.

> +		goto err_reset_q_params;
> +	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793946318.git.gongfan1%40huawei.com
