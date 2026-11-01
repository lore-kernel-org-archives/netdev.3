Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793572403;
	b=pL9E9wV/ddp5rqeh0hxICmYpYoQw9Vw2A/UQ9PZZ0HyJjCFkmvFwd9OcUovd7KWZt+AG
	 JRAVFRCQ7pkbgJVa+0eyLK6houyPh3YtR1UtaGsXY/OkIEOpR5lyboguO8mQojoqBQcnU
	 OPJ6yfD6aDPn4vnmiGCqku1s9+wBXLDfkzX4VTrHsj/V7La5zRAjqcAqX6JNlqMchHixC
	 qpwVxIutrOmFi+sLmgeZ24z1JpjdmJ+8sknTyKXj+P+LCQG5FqJuG+yBKh3pSoVoH9CyM
	 qR8lzgAMgxsQRW7htqbAeYJVJ0d7qczWMCBD1qr5PvZBBm5TvkDByDhx5CO7QaR2Vfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793572403;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=bQbGJsEYW8iXsl0+kCZL1dGXuwjzjSLy2vX3HpzFOEg=;
	b=xpQWjFudTDkSHu9AhDXKM/kedmJFxeTuTU/pWXVCwme73hwygxgqiu4LgnBVwIRE3dmN
	 NtQgTwjCg4A6bMh3fbN4fEWnpli7nFEbNBCv9AZJnGM1i9GOgUFdmQ8g3lSwLDq+2SOe+
	 XX+htrah3782Uv03o/tFIc7OOD6Ms/B0DRDiyXoFI/9jmf7g4QlsMxgdtOSHzxwl8v6Su
	 OQ6uFUDThBBkGpGQR8NN2rLTJtDwv5OZ1RuOQbMKQYy8ShxVwlMFg8yg8rBIsX1qHM0kN
	 PAKMLk9GfVsPY8TyHiMCau+eGDA+x5dP1Tkllhw7U0FEDdQrdLfaQdHicct4oW8VPQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WeZ0h2O7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA4860A2621
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 22:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WeZ0h2O7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1C91F000C1;
	Sun,  1 Nov 2026 22:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793572402;
	bh=bQbGJsEYW8iXsl0+kCZL1dGXuwjzjSLy2vX3HpzFOEg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WeZ0h2O7XYkfPAKZ9rSKoMKl1bJlctn2MVXAfG2m4H7HiQ9hnroCgoQjScjuRoaKb
	 6SXsoQ2xPcABhODRJlMAO5xeEiwLct5hxffwAEApTawX54sumpFGlK3NWGOvysINl2
	 aSQiGmP33RM/McbTEzwn6aPsynro59atYJuhJhc7MciV2kNsI8HB30+sf86r5e7jss
	 2Wn+b0gRQdu8SqAAUVyOA4muvnormMgm23FOGeQnFx8JeippWSmBghgGaIsG2YryP6
	 j3VinIGw0NOtzRBKk6dGdU2ytRCfvusI9la6AKWxBcIE/CYJNULoEL2V3v64PKF3Rw
	 YwkpRyVjUEMhA==
Subject: Re: [net PATCH 12/13] fbnic: Wait for the outbound flush to complete
 on mailbox teardown
From: netdev-bot+sashiko@kernel.org
To: alexander.duyck@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, kernel-team@meta.com, kuba@kernel.org,
 pabeni@redhat.com
Date: Sun, 01 Nov 2026 22:33:21 +0000
Message-ID: <179357240198.3131.13031185806045724220@kernel.org>
In-Reply-To:
 <179322344904.40667.15350816992837956463.stgit@ahduyck-xeon-server.home.arpa>
References:
 <179322344904.40667.15350816992837956463.stgit@ahduyck-xeon-server.home.arpa>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit makes the new flush-done poll in fbnic_mbx_clean()
  (drivers/net/ethernet/meta/fbnic/fbnic_fw.c:204-209) wait for the…
- [Low] The commit message says fbnic_mbx_reset_desc_ring 'drops bus
  mastering and arms the outbound read and write flush in a single…

--

fbnic: Wait for the outbound flush to complete on mailbox teardown

This patch adds a poll on the PUL link reset status register at the end
of fbnic_mbx_clean(). The poll waits for the outbound read and write
flushes armed during mailbox teardown to report done before returning.
It has a 1ms timeout and logs a warning if the flush does not complete.

> The fbnic_mbx_reset_desc_ring function drops bus mastering and arms the
> outbound read and write flush in a single register write, but nothing
> waits for that flush to finish.

[Severity: Low]
Is this description accurate? In fbnic_mbx_reset_desc_ring(), two
separate writes to two different registers arm the write flush and the
read flush. mbx_idx selects which one runs:

    case FBNIC_IPC_MBX_RX_IDX:
        wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AW_CFG,
             FBNIC_PUL_OB_TLP_HDR_AW_CFG_FLUSH |
             FBNIC_PUL_OB_TLP_HDR_AW_CFG_FLUSH_MODE);
        break;
    case FBNIC_IPC_MBX_TX_IDX:
        wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AR_CFG,
             FBNIC_PUL_OB_TLP_HDR_AR_CFG_FLUSH);
        break;

fbnic_mbx_clean() calls it once per ring, and the RX buffers are freed
in between. So the AW flush is armed before the AR flush, and no single
write arms both directions.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> index 09d03274be08c..32a18cb8990cb 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c

[ ... ]

> @@ -187,10 +188,25 @@ static void fbnic_mbx_clean_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
>  
>  void fbnic_mbx_clean(struct fbnic_dev *fbd)
>  {
> +	u32 flush_done = FBNIC_PUL_USER_IP_LINK_RST_STATUS_AR_FLUSH_DONE |
> +			 FBNIC_PUL_USER_IP_LINK_RST_STATUS_AW_FLUSH_DONE;
> +	u32 val;
>  	int i;
>  
>  	for (i = 0; i < FBNIC_IPC_MBX_INDICES; i++)
>  		fbnic_mbx_clean_desc_ring(fbd, i);
> +
> +	/* Arming the flush above only starts it. Wait for the outbound path
> +	 * to retire the requests it still owns so none of them can complete
> +	 * after the reset that follows. A lost link reads back as all ones,
> +	 * which ends the poll on the first pass.
> +	 */
> +	if (read_poll_timeout_atomic(fbnic_rd32, val,
> +				     (val & flush_done) == flush_done, 2, 1000,
> +				     false, fbd,
> +				     FBNIC_PUL_USER_IP_LINK_RST_STATUS))
> +		dev_warn(fbd->dev, "Outbound flush did not complete: %08x\n",
> +			 val);
>  }

[Severity: Medium]
Does this wait come too late to protect the TX mailbox pages?

By the time the poll runs, fbnic_mbx_clean_desc_ring() has already
unmapped and freed every buffer on both rings:

fbnic_mbx_clean()
  fbnic_mbx_clean_desc_ring(fbd, FBNIC_IPC_MBX_TX_IDX)
    fbnic_mbx_reset_desc_ring()
      wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AR_CFG, ..._AR_CFG_FLUSH);
    fbnic_mbx_unmap_and_free_msg()
      dma_unmap_single(...);
      free_page(...);
  read_poll_timeout_atomic(...)

The new comment says arming the flush "only starts it" and that the
outbound path still owns requests at that point. If so, could a device
read of a TX page still be outstanding after dma_unmap_single() and
free_page() have run? With an IOMMU, it could also target an IOVA that
has already been unmapped or reused.

TX pages can still be on the ring at clean time if firmware has not set
FW_CMPL. One case is fbnic_mbx_flush_tx() timing out in
fbnic_fw_disable_mbx(). Another is the clean_mbx error path in
fbnic_mbx_poll_tx_ready() after the cap request has been posted.

The RX side sets FLUSH_MODE so parked writes do not land on the host.
The AR side has no equivalent before the pages are freed.

Would it be better to poll for the flush to complete in
fbnic_mbx_clean_desc_ring(), between fbnic_mbx_reset_desc_ring() and
the unmap/free loop?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179322311834.40667.5383039334126572422.stgit%40ahduyck-xeon-server.home.arpa
