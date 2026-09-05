Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3405F36215D
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 20:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788640651; cv=none; b=faBfwPNzrPeye4eY528rbFy5X1u6xAMKO4TOuoIImzEArjP6JemsvGtjIVzAEdvAk9qvZ6ioOZk+b+1Ummh6jd9WamSOFxUSJ9xxuv5D/8MCpwTylTPabwK1pM3JFnGEFFYGQBohdci/pquS45yHAtagJlw6+PZyAMylnU6OC1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788640651; c=relaxed/simple;
	bh=e8NgjVcEo+EWvVsFbhVB/js4TVPuMGTXfIBIBG94nEc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RnRbTJjuGQ8PTXD80kNhHT/1ZU9mPKrJLkiOSk8SKnr/Rc0VObpuYUzfcW7VAToS3+WC091vs7pb9xzwOn0RkFOd1bkdeKSKFJaRCq72RnaqGqBQVsrgoSwMejFQ5YdqVxlP6qhHw0rSzjCNAeGIzAAgtEXpVUFzBN3EBoXgMto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImMAy6IB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImMAy6IB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F8E1F00A3D;
	Sat,  5 Sep 2026 20:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788640650;
	bh=0sqOJJ8yVZpk0ZxgbreLnharVJtuVCpL0eNGCdGyh+A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ImMAy6IBKunGIA56uVI+JJtGGyCO8PUxrXcCvCOOHy9occZiXGIxK4JtNAz5OkNhB
	 18p2+AklXSHaF4oppE5jupPBZa7cNfqwSwmdL498+5PP0Vqq7F6Hj2Q3PTNd8OCWH4
	 Pgz6tCLln3rKIbeBIIH2I+vQNZlJbRlaUbJKZYiuJmNS8ikb/2e5zrLJTceX0Pqabw
	 dNYd6BUd8SNFROerIlVGFafsBDQdzt0Ky+Dyo4/xQEizgpzx4Q0huMDyudhqI+vZLy
	 aSXXjybdwtjQh3r+3uPoExHLqtshGxWpKqm4yB52ioC1m//OR1Gb50DcimW6vH7m9M
	 jLMfrNlNrokCg==
Subject: Re: [net PATCH 2/4] fbnic: Set AW_FLUSH_MODE alongside AW_FLUSH when
 flushing the mailbox
From: netdev-bot+sashiko@kernel.org
To: alexander.duyck@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, kernel-team@meta.com,
 horms@kernel.org
Date: Sat, 05 Sep 2026 20:37:28 +0000
Message-ID: <178864064898.219967.11713724668852589822@kernel.org>
In-Reply-To:
 <178838831819.11136.3279654005346776816.stgit@ahduyck-xeon-server.home.arpa>
References:
 <178838831819.11136.3279654005346776816.stgit@ahduyck-xeon-server.home.arpa>
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

- [High] fbnic_mbx_reset_desc_ring()
  (drivers/net/ethernet/meta/fbnic/fbnic_fw.c:54-95) now arms the PUL…

--

fbnic: Set AW_FLUSH_MODE alongside AW_FLUSH when flushing the mailbox

This adds a FLUSH_MODE definition for FBNIC_PUL_OB_TLP_HDR_AW_CFG and sets
it together with FLUSH when tearing down the FW mailbox Rx ring, so the PUL
write pipeline forces the staged requests out instead of stalling behind the
halt that comes from clearing BME.  The read path is left alone.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
> index 64b958df7774..14af30e189d6 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
> @@ -974,6 +974,7 @@ enum {
>  /* PUL User Registers */
>  #define FBNIC_CSR_START_PUL_USER	0x31000	/* CSR section delimiter */
>  #define FBNIC_PUL_OB_TLP_HDR_AW_CFG	0x3103d		/* 0xc40f4 */
> +#define FBNIC_PUL_OB_TLP_HDR_AW_CFG_FLUSH_MODE	CSR_BIT(20)
>  #define FBNIC_PUL_OB_TLP_HDR_AW_CFG_FLUSH	CSR_BIT(19)
>  #define FBNIC_PUL_OB_TLP_HDR_AW_CFG_BME		CSR_BIT(18)
>  #define FBNIC_PUL_OB_TLP_HDR_AW_CFG_RDE_ATTR	CSR_GENMASK(17, 15)
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> index 283d25fae79e..ace6685df039 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> @@ -60,8 +60,14 @@ static void fbnic_mbx_reset_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
>  	 */
>  	switch (mbx_idx) {
>  	case FBNIC_IPC_MBX_RX_IDX:
> +		/* The write path only terminates outstanding requests when
> +		 * both FLUSH and FLUSH_MODE are set. With FLUSH alone the
> +		 * writes still obey the halt asserted by clearing BME, so
> +		 * nothing drains and AW_FLUSH_DONE never asserts.
> +		 */
>  		wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AW_CFG,
> -		     FBNIC_PUL_OB_TLP_HDR_AW_CFG_FLUSH);
> +		     FBNIC_PUL_OB_TLP_HDR_AW_CFG_FLUSH |
> +		     FBNIC_PUL_OB_TLP_HDR_AW_CFG_FLUSH_MODE);
>  		break;

[Severity: High]

Once the flush actually starts terminating the outstanding writes, does
anything wait for it to finish before the mailbox pages go away?

The only thing after this store in fbnic_mbx_reset_desc_ring() is wrfl(),
which is just a dummy CSR read:

drivers/net/ethernet/meta/fbnic/fbnic.h:
	static inline void fbnic_wrfl(struct fbnic_dev *fbd)
	{
		fbnic_rd32(fbd, FBNIC_MASTER_SPARE_0);
	}

That pushes the posted register write out, but it doesn't say anything about
whether the AW pipeline has drained.  The caller then goes straight to the
unmap and free:

drivers/net/ethernet/meta/fbnic/fbnic_fw.c:fbnic_mbx_clean_desc_ring() {
	fbnic_mbx_reset_desc_ring(fbd, mbx_idx);

	for (i = FBNIC_IPC_MBX_DESC_LEN; i--;)
		fbnic_mbx_unmap_and_free_msg(fbd, mbx_idx, i);
}

drivers/net/ethernet/meta/fbnic/fbnic_fw.c:fbnic_mbx_unmap_and_free_msg() {
	dma_unmap_single(fbd->dev, mbx->buf_info[desc_idx].addr,
			 PAGE_SIZE, direction);

	free_page((unsigned long)mbx->buf_info[desc_idx].msg);
}

Can a write that the now-effective flush is in the middle of forcing out
land after dma_unmap_single() and free_page()?  With an IOMMU that would be
a translation fault; without one it would be a device write into a page the
allocator has already handed to someone else.

This path is reached on ordinary teardown, via
fbnic_fw_disable_mbx() -> fbnic_mbx_flush_tx() -> fbnic_mbx_clean() ->
fbnic_mbx_clean_desc_ring(), so unbind/remove, PM suspend and PCIe error
recovery all go through it, as does the clean_mbx error label in
fbnic_mbx_poll_tx_ready().

Would a bounded poll for flush completion between the AW_CFG store and
fbnic_mbx_unmap_and_free_msg() be appropriate here?  The driver already
uses read_poll_timeout_atomic() for drain confirmation in fbnic_txrx.c, and
an fbnic_fw_present() style escape would cover surprise removal.

>  	case FBNIC_IPC_MBX_TX_IDX:
>  		wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AR_CFG,

[Severity: Low]

On the comment wording itself: AW_FLUSH_DONE doesn't appear anywhere in the
tree except in this new comment.  A grep over drivers/net/ethernet/meta/fbnic
turns up only FBNIC_PUL_OB_TLP_HDR_AW_CFG_FLUSH, the newly added
FBNIC_PUL_OB_TLP_HDR_AW_CFG_FLUSH_MODE and FBNIC_PUL_OB_TLP_HDR_AR_CFG_FLUSH,
and this hunk adds no status bit to the AW_CFG bit list.

Since no FLUSH_DONE bit is defined and no code reads one, could the comment
and the commit message text "nothing drains and the flush never completes"
be reworded to describe something the driver can actually observe?  As
written a reader will go looking for the completion check.

Could the commit message also say what the user-visible symptom is, given
the Fixes: tag makes this a stable candidate?

This behaviour is unchanged at the end of the series (6798d6588c7d): no
later patch adds a flush completion wait or a FLUSH_DONE definition.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/178838795612.11136.15512516427273655916.stgit%40ahduyck-xeon-server.home.arpa
