Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DA748FF7B
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 21:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679533; cv=none; b=Opt67nCyQVLxQyICdu3yqOf98GdhvnDKijWTaSMLh6ZZ1FPSyjq0Rk4K3yYMel87ZYT6R5Hd+E1mhqB0muLyQzNgN8eOOl/XiM42L9Iso02xxo1ZjOReSzM2NFQ9u6Z8MxVp9HmV1mEdEiJMuYV0pV0LvRIZzNF7M1tlCQnLEfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679533; c=relaxed/simple;
	bh=LCQn6DIPZcRdgWAF3j5Kn7+k9NaMwZRQoqHXCPHVg28=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=miYXZNPwuXCeIRCCK+HXQ26sqEZqR2cuj40Dc2MqoCWivRboOoCNtAK6CGkKFdDCHmILBJqNvSoSSIrjVTJ/dfAFGtnVUtuyv8m8tWX2/jPTJM/dxrU2XamGkFu20oPL7VTIIx5N5bAQTOgBybuCcAGSAEkR4pBbZ8fPk0/KahU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoN1CAmq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoN1CAmq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20951F000FF;
	Thu, 17 Sep 2026 21:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679531;
	bh=fpAosnCh4Fwq0azPPyrDclIBLJu1ap9y4/nhgF4wjFY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NoN1CAmq24ZBGS5tNxkU5F0vH5s+3VgWEL9nOFIcSsEB1NPZn5WkJ4IgnjLI31NvL
	 9J1AbiPRnBEWO7/Aeq2cWGKNKqjl52mAQG4YXEtA6S3uc8xU5R3dCjldcsMdd81jos
	 viTb6DJQeGNk0/vbjLholiNFfPODly52lDNo3lap11S/F0KMnv+FeW0tzIiV3Ttp80
	 ZqE1UBNvs2LfLmJEF9n75WQdA7pU+TQdQksWGl3c515U7vg+gL/P1MX+Reu1tp/HcA
	 KaA9kMvSqbG+hs70+L/DLIWmGL5GMhgz7bTFbSPsDeXyuZILHMwQc47xEDGxgOBOGu
	 JZ/6yQhm9eUwg==
Subject: Re: [net PATCH v2 6/6] eth: fbnic: Handle FW mailbox completions
 flagged with an error
From: netdev-bot+sashiko@kernel.org
To: alexander.duyck@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, kernel-team@meta.com,
 horms@kernel.org
Date: Thu, 17 Sep 2026 21:12:10 +0000
Message-ID: <178967953049.22033.7278929297475041564@kernel.org>
In-Reply-To:
 <178942023343.7700.9423398932961964439.stgit@ahduyck-xeon-server.home.arpa>
References:
 <178942023343.7700.9423398932961964439.stgit@ahduyck-xeon-server.home.arpa>
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

- [Medium] FW_ERR handling does not release the outstanding-request
  bookkeeping: when the firmware completes a Tx descriptor with…

--

eth: fbnic: Handle FW mailbox completions flagged with an error

The patch adds a check for FBNIC_IPC_MBX_DESC_FW_ERR on both the Tx and
Rx firmware mailboxes, counts the occurrences per mailbox in
fbnic_fw_mbx.resp_error (also exported via debugfs), emits a rate limited
warning, and drops the Rx page instead of parsing it. It also re-issues
the bring-up capabilities request in fbnic_mbx_poll_tx_ready() when
either resp_error counter advances.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
> index 14af30e189d6c..baba3471bf5a4 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
> @@ -1216,6 +1216,10 @@ enum {
>  #define FBNIC_IPC_MBX_DESC_LEN_MASK	DESC_GENMASK(63, 48)
>  #define FBNIC_IPC_MBX_DESC_EOM		DESC_BIT(46)
>  #define FBNIC_IPC_MBX_DESC_ADDR_MASK	DESC_GENMASK(45, 3)
> +/* Set with FW_CMPL when the FW completed a descriptor without successfully
> + * processing it (e.g. a mailbox DMA error); the completion has no valid data.
> + */
> +#define FBNIC_IPC_MBX_DESC_FW_ERR	DESC_BIT(2)
>  #define FBNIC_IPC_MBX_DESC_FW_CMPL	DESC_BIT(1)
>  #define FBNIC_IPC_MBX_DESC_HOST_CMPL	DESC_BIT(0)
>  

[ ... ]

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> index 59aa879798b9f..6d7eb8479edf4 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> @@ -292,6 +292,12 @@ static void fbnic_mbx_process_tx_msgs(struct fbnic_dev *fbd)
>  		if (!(desc & FBNIC_IPC_MBX_DESC_FW_CMPL))
>  			break;
>  
> +		if (desc & FBNIC_IPC_MBX_DESC_FW_ERR) {
> +			tx_mbx->resp_error++;
> +			dev_warn_ratelimited(fbd->dev,
> +					     "FW completed a Tx mailbox request with an error\n");
> +		}
> +
>  		fbnic_mbx_unmap_and_free_msg(fbd, FBNIC_IPC_MBX_TX_IDX, head);

[Severity: Medium]
Should this path also release the completion registered for the request
that the firmware just abandoned?

The new comment in fbnic_csr.h says the FW_ERR completion "has no valid
data", so no response TLV will follow. Requests submitted through
fbnic_mbx_map_req_w_cmpl() leave a struct fbnic_fw_completion installed in
fbd->cmpl_data[], and fbnic_mbx_process_tx_msgs() here only bumps
resp_error and frees the page, so that slot stays armed.

For example, with a TSENE read flagged FW_ERR on the Tx descriptor:

  fbnic_mac_get_sensor_asic()
    ...
	if (!wait_for_completion_timeout(&fw_cmpl->done, 10 * HZ)) {
		dev_err(fbd->dev, "Timed out waiting for TSENE read\n");

Does the hwmon reader then block for the full 10 seconds even though the
driver already knows at FW_ERR time that no answer is coming?

There is a second effect while that stale waiter is pending. In
fbnic_mbx_set_cmpl_slot():

	for (i = 0; i < FBNIC_MBX_CMPL_SLOTS; i++) {
		if (!fbd->cmpl_data[i])
			free = i;
		else if (fbd->cmpl_data[i]->msg_type == cmpl_data->msg_type)
			return -EEXIST;
	}

so a second request of the same msg_type in that window is rejected with
-EEXIST until the first waiter times out and clears its slot.

The driver already has a way to say "no response will arrive":

	static void __fbnic_fw_evict_cmpl(struct fbnic_fw_completion *cmpl_data)
	{
		cmpl_data->result = -EPIPE;
		complete(&cmpl_data->done);
	}

but that is only reached from fbnic_mbx_evict_all_cmpl() in
fbnic_mbx_flush_tx() during mailbox teardown, never from the new
per-descriptor FW_ERR handling. Could the FW_ERR path look up the
matching completion (the TLV, and therefore its msg type, is still in
tx_mbx->buf_info[head].msg at this point) and complete it with an error?

> @@ -1673,6 +1679,13 @@ static void fbnic_mbx_process_rx_msgs(struct fbnic_dev *fbd)
>  		if (!(desc & FBNIC_IPC_MBX_DESC_FW_CMPL))
>  			break;
>  
> +		if (desc & FBNIC_IPC_MBX_DESC_FW_ERR) {
> +			rx_mbx->resp_error++;
> +			dev_warn_ratelimited(fbd->dev,
> +					     "FW reported an error on an Rx mailbox message; dropping\n");
> +			goto next_page;
> +		}
> +
>  		dma_sync_single_for_cpu(fbd->dev, rx_mbx->buf_info[head].addr,
>  					FBNIC_RX_PAGE_SIZE, DMA_FROM_DEVICE);
>  

[Severity: Medium]
The same question applies on the Rx side: when the dropped descriptor was
the response to a request with a completion installed, nothing wakes the
waiter either, so callers such as fbnic_flash_start():

	if (fbnic_mbx_wait_for_cmpl(cmpl))
		err = cmpl->result;
	else
		err = -ETIMEDOUT;

burn the full FBNIC_MBX_RX_TO_SEC wait and report -ETIMEDOUT rather than
an error.

The retry added in fbnic_mbx_poll_tx_ready() covers the bring-up
capabilities exchange, but the QSFP EEPROM read, coredump info/read and
the FW upgrade start/write/finish requests all run after bring-up and are
not covered. Is that intentional for this patch, or should the completion
bookkeeping be released for those too?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/178941996343.7700.9376081102002673062.stgit%40ahduyck-xeon-server.home.arpa
