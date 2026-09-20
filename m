Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B4D2EC083;
	Sun, 20 Sep 2026 22:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789944450; cv=none; b=IdIInYz1QUZIGKrqkVGsu0vHw3c49JrLG6/q1ec7v0w0/ydevtBXb27dLiODHQ5TlkYqr1GiKX5Yp0IPLT90nPdwvB+svyFDmG9mxzgfoaDUrJvFAkqsqICDzGEfqlocKvPvmTXk9xCDo4OrCx5WuReGqyIH3gaz8oZWtmuH22w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789944450; c=relaxed/simple;
	bh=9SfBD1SANEKHEWQ1VFc+j5tLf/4hxx+fZYreQfVsUcE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JM/kEtVJdg094V/LfB28QXtnz7EXamxyectbCW/tkykqIs36cmRkTe0Xg6Osb8CurQcjZutvmGyutLUK39E34T7jF0OeWTgma/LLm3gn6r/ZswGOhQK6Y9JdQo7bcDDUpAzCTtzlMvzHOMO4dehsP9EJC9yRoo1luAzNbtsnvaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDpsU0/n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDpsU0/n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047E91F000FF;
	Sun, 20 Sep 2026 22:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789944448;
	bh=9SCmMq7tBsLCup+PMyIowEeF9eOcA42daX2Stx8+Z98=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UDpsU0/nWa2qMfdXRDYClSdF7XjbfIxSZeP/25wA24hTrNJE6TSk1MC79GVnX3CjS
	 oafOx7L2Kg84Wi/cteKoTh4LhHOeG8IqJyWrFqhY4AMk2BYz21SFCyWj+o5r1FYGkJ
	 iTcR94TjmzP8SAYsCnUopV1MoBXqydglRNdneEbrhOMLciNBDD/1zYwU/wUr5CHsxg
	 UVEZMLPTVxCB0oTU+yoTsOs50lhce3C47Iw6EVKejOfVVVfF1/y1sTYxkLL8FlSIeX
	 hA1Jdi8nwRLzWEzyjbsyBAXCE5OPXsYeJafd2G585DlJbaeETujyfhB0ltaLDSagXm
	 PNMBVSFKIOP3w==
Subject:
 Re: [PATCHv2 net-next] net: fec_mpc52xx: remove dead resource size check
From: netdev-bot+sashiko@kernel.org
To: rosenp@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Sun, 20 Sep 2026 22:47:27 +0000
Message-ID: <178994444750.2160803.15737331291670911275@kernel.org>
In-Reply-To: <20260916223228.271815-1-rosenp@gmail.com>
References: <20260916223228.271815-1-rosenp@gmail.com>
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

- [Medium] drivers/net/ethernet/freescale/fec_mpc52xx.c: the patch
  deletes the only runtime validation of the firmware-supplied register…

--

net: fec_mpc52xx: remove dead resource size check

This removes the minimum size test on the FEC register resource in
mpc52xx_fec_probe(), on the grounds that every in-tree device tree
describes the FEC node as a 0x400 byte region and the stale error message
referenced a file deleted in 2008.

> diff --git a/drivers/net/ethernet/freescale/fec_mpc52xx.c b/drivers/net/ethernet/freescale/fec_mpc52xx.c
> index 5188551add0b7..14ad03d75598c 100644
> --- a/drivers/net/ethernet/freescale/fec_mpc52xx.c
> +++ b/drivers/net/ethernet/freescale/fec_mpc52xx.c
> @@ -834,13 +834,6 @@ static int mpc52xx_fec_probe(struct platform_device *op)
>  		pr_err("Error while parsing device node resource\n");
>  		goto err_netdev;
>  	}
> -	if (resource_size(&mem) < sizeof(struct mpc52xx_fec)) {
> -		pr_err("invalid resource size (%lx < %x), check mpc52xx_devices.c\n",
> -		       (unsigned long)resource_size(&mem),
> -		       sizeof(struct mpc52xx_fec));
> -		rv = -EINVAL;
> -		goto err_netdev;
> -	}
>  
>  	if (!request_mem_region(mem.start, sizeof(struct mpc52xx_fec),
>  				DRIVER_NAME)) {

[Severity: Medium]
Is the "can never be true" reasoning in the changelog accurate?

The changelog says:

  "but every in-tree device tree describes the FEC node as a 0x400 byte
   region, which is exactly the size of the struct, so the condition can
   never be true."

The in-tree DTs (charon.dts, lite5200.dts, mpc5200b.dtsi, tqm5200.dts) do
all use reg = <0x3000 0x400>, but the device tree is firmware-supplied, so
the blob is not restricted to the in-tree copies. Bootloader-generated DTBs,
out-of-tree board files and overlays can supply a shorter reg.

Does anything else reject a short reg? of_address_to_resource() only checks
representability and add-overflow:

drivers/of/address.c:__of_address_resource_bounds() {
	if (overflows_type(start, r->start))
		return -EOVERFLOW;

	r->start = start;

	if (!size)
		r->end = wrapping_sub(typeof(r->end), r->start, 1);
	else if (size && check_add_overflow(r->start, size - 1, &r->end))
		return -EOVERFLOW;
}

So reg = <0x3000 0x100> translates fine and reaches the code below.

Also, Documentation/devicetree/bindings/powerpc/fsl/mpc5200.txt does not
state a length requirement for the fec node's reg, so with the check gone
the 0x400 assumption is neither validated in code nor documented in the
binding.

[Severity: Medium]
After this hunk, does mpc52xx_fec_probe() consult resource_size(&mem) at
all? Both the reservation and the mapping use the hard-coded struct size:

	if (!request_mem_region(mem.start, sizeof(struct mpc52xx_fec),
				DRIVER_NAME)) {
	...
	priv->fec = ioremap(mem.start, sizeof(struct mpc52xx_fec));

__request_region() validates against the global resource tree, not against
mem.end, so a short reg is silently over-claimed rather than rejected. The
declared length then has no effect on the driver at all.

For a truncated reg, probe now proceeds and touches registers past the
described window during hardware setup:

drivers/net/ethernet/freescale/fec_mpc52xx.c:mpc52xx_fec_hw_init() {
	...
	out_be32(&fec->rfifo_alarm, 0x0000030c);
	out_be32(&fec->tfifo_alarm, 0x00000100);
	...
}

drivers/net/ethernet/freescale/fec_mpc52xx.c:mpc52xx_fec_reset_stats() {
	...
	memset_io(&fec->rmon_t_drop, 0,
		   offsetof(struct mpc52xx_fec, reserved10) -
		   offsetof(struct mpc52xx_fec, rmon_t_drop));
	...
}

Previously the same input returned -EINVAL with a diagnostic. If the
over-claimed range overlaps a neighbouring reservation, the failure now
surfaces as -EBUSY from request_mem_region() instead.

Would it make sense to either honour resource_size(&mem) here (for example
via devm_platform_ioremap_resource() or of_iomap()), or keep the minimum
size check and just fix the message? The stale mpc52xx_devices.c reference
and the %x versus size_t format mismatch look like the only genuinely dead
parts of the removed block.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916223228.271815-1-rosenp%40gmail.com
