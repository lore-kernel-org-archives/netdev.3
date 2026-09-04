Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04823AC0EF;
	Fri,  4 Sep 2026 07:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788506817; cv=none; b=CpwytNV9ImIfO9rmaWJsUZB6w+BlYKQih9i5lSzSKqb0hdt+iulwxko31qpdsg3Pv8XbK7xhgKVmA9TTIj0/1ttZ2FxsGPb7bBRXI3Ti6i19bpbL25RSCxCHTa+J35IrsKIzK/rLG/vA55gnZctl51ksV9BXhMm8/0R/FjJw+vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788506817; c=relaxed/simple;
	bh=ErAYV0ZWq0RVPUMqz03LkXDhTb+BI414vLKZuSSPEqA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DbeYWaHn6+bt9iJblg3v5lZFaj16hl28Zig/KwvrP05qu9x4g0mir50ExPbzEcZD/+dz9ESQHBjybu3FVLnHJlP8Cn3tYow0RJwWafvIz5lP/pL8xfR396NFcpAEO5sg2a/oUdMpKCPpoN9fuplP3WScVNJasawCitgMdcpOJBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEdTqcDn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEdTqcDn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828B61F00A3D;
	Fri,  4 Sep 2026 07:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788506816;
	bh=HWz5T3Qtnmox58M0IrzkSBid/Anz7vep3cV0Ye5yiGo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gEdTqcDn3fhUXppopfdHrsMjfEeHvJqjsJpbI3u2Cr4C+ewyhNScufZli6JinvZeJ
	 4DYGUK9l4DlQ90GDLDENNTe2W/9i9KuDZ9nchaMpYRwVStyoNJfSK5Jj6g0GVRKhCX
	 5fuPJNnsBOdwJzpCkca6+XW19Hb3sV60keasYSs550Kd1yh+0dVaqGJU9P8dKacnEw
	 01SUD6OQkTG6USY77M15Q23lUfhA+nYe9z/8k8Gyl8+p9pHKhg6EfvI4GQFYHObRt5
	 7JOKFwiOLnQzSDM1MhlZWXeP6O5Pmk/9y1XY0bvHqxKazg58l7C0gHMry3W26rsOWc
	 r01yKHn85kfow==
Subject: Re: [PATCH net-next] octeontx2-af: Show DMAC filter drop count
From: netdev-bot+sashiko@kernel.org
To: nshettyj@marvell.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hkelam@marvell.com,
 sgoutham@marvell.com, rkannoth@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com
Date: Fri, 04 Sep 2026 07:26:55 +0000
Message-ID: <178850681504.4131868.11162674186264836607@kernel.org>
In-Reply-To: <20260901042503.1182121-1-nshettyj@marvell.com>
References: <20260901042503.1182121-1-nshettyj@marvell.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] New debugfs label contradicts the driver's own name for the
  same CGX register.

--

octeontx2-af: Show DMAC filter drop count

This adds a new mac_ops callback, get_dmacflt_dropped_pktcnt, implemented
for CGX (reading CGXX_CMRX_RX_STAT4) and RPM/RPM2 (reading RX_STAT2), and
prints the value in the mac_filter debugfs entry.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> index f5fd6138c352f..3696bec7a8fc1 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> @@ -752,6 +752,16 @@ u64 cgx_features_get(void *cgxd)
>  	return ((struct cgx *)cgxd)->hw_features;
>  }
>  
> +u64 cgx_get_dmacflt_dropped_pktcnt(void *cgxd, int lmac_id)
> +{
> +	struct cgx *cgx = cgxd;
> +
> +	if (!is_lmac_valid(cgx, lmac_id))
> +		return 0;
> +
> +	return cgx_read(cgx, lmac_id, CGXX_CMRX_RX_STAT4);
> +}
> +

[Severity: Medium]
Is CGXX_CMRX_RX_STAT4 really the DMAC filter drop counter?  This driver
already exposes that same register under a different name.

cgx_get_rx_stats() reads:

	*rx_stat =  cgx_read(cgx, lmac_id, CGXX_CMRX_RX_STAT0 + (idx * 8));

For idx == 4 that is 0x070 + 32 == 0x090, i.e. the newly added
CGXX_CMRX_RX_STAT4.  The name printed for it in the cgx_stat debugfs file
is:

drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c:
	[CGX_STAT4]	= "Filtered DMAC0 (NIX-bound) packets",
	[CGX_STAT5]	= "Filtered DMAC0 (NIX-bound) octets",
	[CGX_STAT6]	= "Packets dropped due to RX FIFO full",
	[CGX_STAT7]	= "Octets dropped due to RX FIFO full",
	...
	[CGX_STAT11]	= "NCSI-bound packets dropped",

That table uses "dropped" wording for STAT6/7 and STAT11/12, and the
"Filtered DMAC<n> (<channel>-bound)" wording for STAT4/5 and STAT9/10,
which reads as packets that passed the DMAC filter towards NIX rather than
packets discarded by it.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
> index 8411a75dd723f..cd8858c4e41ce 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
> @@ -39,6 +39,7 @@
>  #define CGXX_CMRX_INT_ENA_W1S		0x058
>  #define CGXX_CMRX_RX_ID_MAP		0x060
>  #define CGXX_CMRX_RX_STAT0		0x070
> +#define CGXX_CMRX_RX_STAT4		0x090
>  #define CGXX_CMRX_RX_LOGL_XON		0x100

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> index 22ee996768796..f6320d6b959f0 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> @@ -3003,6 +3005,12 @@ static int cgx_print_dmac_flt(struct seq_file *s, int lmac_id)
>  		}
>  	}
>  
> +	mac_ops = get_mac_ops(cgxd);
> +	if (mac_ops && mac_ops->get_dmacflt_dropped_pktcnt) {
> +		drop_cnt = rvu_cgx_get_dmacflt_dropped_pktcnt(cgxd, lmac_id);
> +		seq_printf(s, "\nDMAC filter drop count: %llu\n", drop_cnt);
> +	}
> +

[Severity: Medium]
After this change, the same CGX register is presented to users with two
opposite meanings in two debugfs files of the same driver:
cgx_print_stats() prints it via cgx_rx_stats_fields[CGX_STAT4] as
"Filtered DMAC0 (NIX-bound) packets", while cgx_print_dmac_flt() prints it
as "DMAC filter drop count".

One of the two descriptions has to be wrong.  If the existing table is the
correct one, then any interface passing traffic will show a large and
continuously growing "DMAC filter drop count" that is really the accepted
packet count.

Could the two labels be reconciled, i.e. either correct
cgx_rx_stats_fields[CGX_STAT4] or use a different register for the drop
count here?

The commit message says:

    CGX uses RX_STAT4 for this counter, while RPM/RPM2 use RX_STAT2.

Can a reference to the CGX/RPM register descriptions be added so it is
clear which of the two in-tree descriptions of RX_STAT4 matches the
hardware?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260901042503.1182121-1-nshettyj%40marvell.com
