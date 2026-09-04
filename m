Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460C63E5595;
	Fri,  4 Sep 2026 10:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788517133; cv=none; b=ffhxqN2ItoF7mfIKdNcMkM+gaf468LsrJoKyH1xTP+y4GdiXt1Ut0bG3wFrWaFceEoVyb2SU51CxycqWsoTSgBnETdgP8H4/tKoP32B7zEWSRrE02bd/IoL3U2Vy6pb4mTLlAwZLWsDULC6CLoGANN6ENktRzReNVmHLFTCLFGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788517133; c=relaxed/simple;
	bh=zSj8+4tWcZqtl0X0Y45XwQFoIXQD5y9dXdwxBzgJhNM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CaJ0Bms4xZMTYbtuc4Eoa7EfOvwRmg+itQFw+U4a2R+miFSoVj/v2tr0XMBzeVv6HkC/fb+LjPtw2yrcjfIkhA/dM4qqItjY4UXqO0H+0Vtg0pIlNYcuEMw8TabLbnI08fsSQu9h9jCMykO58GHZyV9rNLekea7iFmCirnGnQ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zoew1ht1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zoew1ht1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556E61F00A3E;
	Fri,  4 Sep 2026 10:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788517130;
	bh=9q0qzKem9V1dKpSDFNIMd3r1Q7X+9irqM+EqdTqiRJw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Zoew1ht1l3CBhCFsbmS90y9U9a0LWitJXYgT4XvTJoKw1bgRPX+Kkfy0ptzNKrOG9
	 60L4giuiuOM57ymdL+eXKW7Cpiuwe5edSinj5ryqcxfdR7NoPkT7Vxv8kDmCG/iUUn
	 FBjw4Ro5sMBDOIUcqxYltRY4op8z2r0Ih6uQHfBj9Cl9S/DYTEe3j6kf4TuHIvTG50
	 ivYZGUreYyy3SSEetU2YiG97lZ9dCAcRCeuUHyI5fUuhUGnXvbO/A43I+Ep/Rmd4wk
	 lVMp/ySB/JlSvQ/3rumwwb/u1a2oPCwthjM0AnUf/BqS6q6n0C8ORQsSMcVL3YPPPR
	 n98ArYqbPGmgA==
Subject: Re: [PATCH net-next 4/7] bnge: Drop obsolete bn->bnapi NULL checks in
 open/close paths
From: netdev-bot+sashiko@kernel.org
To: bhargava.marreddy@broadcom.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com,
 rajashekar.hudumula@broadcom.com, dharmender.garg@broadcom.com
Date: Fri, 04 Sep 2026 10:18:48 +0000
Message-ID: <178851712888.4131868.14842103781611157090@kernel.org>
In-Reply-To: <20260901191728.643212-5-bhargava.marreddy@broadcom.com>
References: <20260901191728.643212-5-bhargava.marreddy@broadcom.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 0

- [High] NULL pointer dereference on a retried interface open after a
  failed open: bn->grp_info is now allocated once during probe…

--

bnge: Drop obsolete bn->bnapi NULL checks in open/close paths

This removes the "if (!bn->bnapi)" guards from bnge_free_ring_stats(),
bnge_clear_bnapi_queues(), bnge_disable_int() and bnge_hwrm_ring_free(),
on the grounds that bn->bnapi now lives from bnge_netdev_alloc() until
bnge_netdev_free().

One question below about the sibling allocation, bn->grp_info, which was
moved to probe lifetime by the same series but is still freed by the open
error path.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> index dcf04d391570b..dc3d51f31e5ef 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> @@ -85,9 +85,6 @@ static void bnge_free_ring_stats(struct bnge_net *bn)
>  	struct bnge_dev *bd = bn->bd;
>  	int i;
>  
> -	if (!bn->bnapi)
> -		return;
> -
>  	for (i = 0; i < bd->nq_nr_rings; i++) {
>  		struct bnge_napi *bnapi = bn->bnapi[i];
>  		struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;

[Severity: High]
The reasoning here applies equally to bn->grp_info, which the same series
moved to probe lifetime via bnge_init_ring_grps(bn, true) in
bnge_netdev_alloc(), with the matching free in bnge_netdev_free().  But the
open path still frees it on error.  Can a retried open dereference a NULL
bn->grp_info?

bnge_init_nic():

	bnge_init_ring_grps(bn, false);

	bnge_init_vnics(bn);

	rc = bnge_init_chip(bn);
	if (rc)
		goto err_free_ring_grps;
	return rc;

err_free_ring_grps:
	bnge_free_ring_grps(bn);
	bnge_free_rx_ring_pair_bufs(bn);
	return rc;

and bnge_free_ring_grps() drops the probe-time allocation entirely:

static void bnge_free_ring_grps(struct bnge_net *bn)
{
	kfree(bn->grp_info);
	bn->grp_info = NULL;
}

bnge_init_chip() can fail on any of its firmware calls
(bnge_hwrm_stat_ctx_alloc(), bnge_hwrm_ring_alloc(),
bnge_hwrm_vnic_alloc(), bnge_hwrm_set_vnic_filter(), ...), for example on a
busy or timing-out firmware.  bnge_open_core() then unwinds through
err_free_irq -> bnge_free_irq() -> bnge_del_napi() -> bnge_free_core() ->
bnge_hwrm_if_change(bd, false) and returns, with the netdev still
registered and bn->grp_info left NULL.

Is there anything that reallocates it before the next open?  The only
allocation site is bnge_init_ring_grps() under irq_re_init, and the open
path calls it with irq_re_init == false, so the loop writes through the
NULL pointer:

	if (irq_re_init) {
		bn->grp_info = kzalloc_objs(struct bnge_ring_grp_info,
					    bd->nq_nr_rings);
		if (!bn->grp_info)
			return -ENOMEM;
	}

	for (i = 0; i < bd->nq_nr_rings; i++) {
		bn->grp_info[i].fw_grp_id = INVALID_HW_RING_ID;

bd->nq_nr_rings is at least 1, so a second "ip link set <dev> up" after a
failed open looks like it oopses on bn->grp_info[0].fw_grp_id.

Should the err_free_ring_grps label in bnge_init_nic() simply stop freeing
grp_info now that its lifetime is probe to remove?

This also appears to still be the case at the end of the series (commit
c51d67eb0c2d), where bnge_free_nq0() dereferences bn->grp_info[0] during
teardown and would add a second crash path after such a failed open.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260901191728.643212-1-bhargava.marreddy%40broadcom.com
