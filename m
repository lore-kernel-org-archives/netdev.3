Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794162776;
	b=vAtQqSUnLHqp7p+eiQh1FL7vR7J3V62meFLAUQdCDBwTPBojdk0YjpFkmWIl1HiqpqpF
	 XuAwU/a0OXetJ8KXhxAxpBXXvo7YTpMd9s+VYBrjzmXmzbaqKTHSzrQN3ztpg/xBP0tXo
	 r68fY2MpgY+ND3FA8ljVH78crvNtImY0HXksuN7+1vmw5nVCc3SYVbMDI6sYFz3HCICdr
	 9s0D2WX8MFKEwayYHlVR8Dq+Yda0lpdm3d6ZWqqppxu5FypyBUS6FwsTAKoy9IugZANym
	 ckH6JeOROMHEUKiIBK1kCpUgjVUYGu9eQXDptZKpVbhhTQd3VJLKfVZ85hudD+QutHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794162776;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=XbTw2KZ+CVczFhGs+1OfQ66aDNm0cDRHtTrgoJUnv/U=;
	b=mO3tHE/p8XmGcImvYoKYT7JVAP7H7/WqPqTuBCncPycm3fOkWztzki3mvpnPRbIzXR5w
	 vf8DlcV9LutYqz9mUTL2gwLxwEfdiIKoddwr8ewHJAZy95fosTM+/mbS+t+FZOPcl0kuf
	 +/mDKLK6ecHWf544+wTx5pAlRTbymF6yJJnWeNbLG2K4W9b9Y0bZA2IK9bzz3ENGVLf03
	 xKS5zbhZ5bB6idDkbd8KGFhY+hKZpYHplTsYy/wgnzFQXkSYN2Q4LNXWWES7PW+9wHkgU
	 w89MScPOXd5A+zFSGToBNsv5+pP026839wxwPPom/4B3XFPKsT15LJ6Q0Ge/dJKcMJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJD2HyLo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D890C606D805
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 18:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJD2HyLo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6181F008A4;
	Sun,  8 Nov 2026 18:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794162775;
	bh=XbTw2KZ+CVczFhGs+1OfQ66aDNm0cDRHtTrgoJUnv/U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SJD2HyLozkcDlN7nrQ+bxbUEHVay9Y4aELkdNwZjl22dMIk3Rh3yH2cSz01GHhS0l
	 U6l6jd+MX25Me3vbI2Uy8zDjz81+BWKtdiCpP05zc4PePZR0+4wNg12TTUT5KlrdcC
	 YJYHbbWGAajKSj/W5ihkRZVNx7Kd/Aqtg5jurWIXu+QXSg5Z3FeX43ahqwp0DjQ0fJ
	 GuWOCD3UT9nt6zJAg+HQlrKyOwb1ond436/LaoGjlebZxJLw1XHVYi27c+AuV69oJu
	 Wyo2RZzOQHrDS0cOUyh03ijATPyLk/U78vQ4UDRQVWLTdeoaWFh9im6bhb/p0qzS4D
	 OO6aGqG22rcOg==
Subject: Re: [net PATCH 5/5] fbnic: Wait for the outbound flush to complete on
 mailbox teardown
From: netdev-bot+sashiko@kernel.org
To: alexander.duyck@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, kernel-team@meta.com, kuba@kernel.org,
 pabeni@redhat.com
Date: Sun, 08 Nov 2026 18:32:54 +0000
Message-ID: <179416277472.994134.4219031759590425185@kernel.org>
In-Reply-To: <179381517319.9644.1165591016149104577.stgit@ahduyck-xeon-server.home.arpa>
References: <179381517319.9644.1165591016149104577.stgit@ahduyck-xeon-server.home.arpa>
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

- [Medium] If the new poll times out, fbnic_mbx_clean_desc_ring()
  (drivers/net/ethernet/meta/fbnic/fbnic_fw.c) still frees the mailbox…

--

fbnic: Wait for the outbound flush to complete on mailbox teardown

After fbnic_mbx_reset_desc_ring() arms the flush, this patch polls the AW
or AR flush-done bit in FBNIC_PUL_USER_IP_LINK_RST_STATUS. The poll runs
before the mailbox ring buffers are unmapped and freed, and it gives up
after 1ms and warns.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> index 49b8813a35643..e00d626f64384 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c

[ ... ]

> @@ -176,10 +177,25 @@ static void fbnic_mbx_unmap_and_free_msg(struct fbnic_dev *fbd, int mbx_idx,
>  
>  static void fbnic_mbx_clean_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
>  {
> +	u32 flush_done, val;
>  	int i;
>  
>  	fbnic_mbx_reset_desc_ring(fbd, mbx_idx);
>  
> +	/* Arming the flush only starts it. Wait for the outbound path to
> +	 * retire the requests it still holds before the buffers they may
> +	 * target are unmapped and freed. A lost link reads back as all ones,
> +	 * which ends the poll on the first pass.
> +	 */
> +	flush_done = mbx_idx == FBNIC_IPC_MBX_RX_IDX ?
> +		     FBNIC_PUL_USER_IP_LINK_RST_STATUS_AW_FLUSH_DONE :
> +		     FBNIC_PUL_USER_IP_LINK_RST_STATUS_AR_FLUSH_DONE;
> +	if (read_poll_timeout_atomic(fbnic_rd32, val, val & flush_done, 2,
> +				     1000, false, fbd,
> +				     FBNIC_PUL_USER_IP_LINK_RST_STATUS))
> +		dev_warn(fbd->dev, "Outbound flush did not complete: %08x\n",
> +			 val);
> +
>  	for (i = FBNIC_IPC_MBX_DESC_LEN; i--;)
>  		fbnic_mbx_unmap_and_free_msg(fbd, mbx_idx, i);
>  }

[Severity: Medium]
If read_poll_timeout_atomic() returns -ETIMEDOUT, does the original
DMA-after-free problem still happen?

On timeout the code only calls dev_warn(). It then falls through to the
same loop as before, and fbnic_mbx_unmap_and_free_msg() does this for
every descriptor:

    dma_unmap_single(fbd->dev, mbx->buf_info[desc_idx].addr,
                     PAGE_SIZE, direction);

    free_page((unsigned long)mbx->buf_info[desc_idx].msg);

As the comment says, a lost link reads back as all ones, so that case
exits on the first read. That leaves a timeout to mean a live device whose
outbound path has not drained, which is the wedged-device case named in
the commit message.

In that case the page can still be freed and reused, or its IOVA unmapped,
while a Tx read or an Rx write is still pending against it. Both paths
reach this branch:

  fbnic_fw_disable_mbx()->fbnic_mbx_clean()->fbnic_mbx_clean_desc_ring()

  fbnic_mbx_poll_tx_ready() clean_mbx error path->fbnic_mbx_clean()

The Rx ring has one more case. fbnic_mbx_init_desc_ring() later sets BME
and clears FLUSH and FLUSH_MODE, and nothing checks that the earlier AW
flush finished:

    wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AW_CFG,
         FBNIC_PUL_OB_TLP_HDR_AW_CFG_BME |
         ...

Could writes still parked in the pipeline then land on freed or reused DMA
addresses?

On timeout, would it be safer to skip the unmap and free and leak the
mailbox pages, instead of giving them back to the page allocator?

Also, the 1ms limit doesn't seem to be based on the PCIe completion
timeout, and that timeout is allowed to be longer. Is 1ms enough for
outstanding reads to complete?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179381496288.9644.9775319757787890210.stgit%40ahduyck-xeon-server.home.arpa
