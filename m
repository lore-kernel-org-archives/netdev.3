Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319703;
	b=3nm61lbrob37tFkw7BCZH8PxOWpywL3VO/4sa6WckDzYS9/Gq+5BeRTryCGoReGfYscl
	 WH3zFkoxlv6JZgKMtIxT0EZ1GU8jJXha+PvKNkvqr0BAPF10YnR9wYu3aq/ak7QqQ6gy9
	 r8MhQ1IWA+gf/rMCdahm9Zv+qWumj7XnI+mgS67h4yGT3feqUw/hn9lHDodoEDBDOfk1c
	 loEiPY8fRJecSPN7b9WB5shnwkaSjQ2qTKkgD6ZXPVUIfCjA4JgXHkwFc3gta2MFMP1J/
	 7VpD4QEq87J7DB1bfPGCpGx7mjPm7gI7f5ULhebPXgl1amz9kRL3XW6QBF+1TkXYl/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319703;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=AMlP8MhWT0A44wY6Zfl/NC3suMHryx6lMzzXNAXNtAM=;
	b=E5ySbNCUdyH8HXHYNq6k/YsZA4jZ4fYwL9uxZLLn/SoWVDTKPbRrMJHiEllHdQQUaIJV
	 T/mZXQvtPGG7zm9PtBBKO8r+hKXCYnvOAa47KNOY1OVSTgPtgsV0ZD51MmPmw6AjFsjAS
	 62ZUcr8S8eCUKudgxRdZAGJqh8Bc/6JIvAHOMrClPSdKSl96niFcd5gZQagCc/ZT2mbUo
	 MJjSpWz6FaF+LVLURB6lMebCM3BSCW1/2ltH5EcQ4eTgMAMe5HajNttrEwTKC5xTpAQ8p
	 gXru+6wI6yF6drTnXYJjCiJHpl3otHviJB0tXSikYbNeMZM7JV4tZo/exRkbtXq2b8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LeynbQJL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78CB606A31C;
	Tue, 10 Nov 2026 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LeynbQJL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E8C1F0089F;
	Tue, 10 Nov 2026 14:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794319702;
	bh=AMlP8MhWT0A44wY6Zfl/NC3suMHryx6lMzzXNAXNtAM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LeynbQJLhX0P1z177u20dH7TR+BQEJxEAkdIcrK32MFm2zQ4NNxA/6OOHYPOHshSE
	 KRFUGTlvpx6sgu7ex7C86htJpvc5Y9jZAV7Kh7btiEI3ADjVRkIpYaldm3ZFPN2dsS
	 YPwhbUHnbGG9S3IAGueWh2WdqwVdRzh/hWxs1ZjY9LLaE05QMxOcpmXdcXo/nFQD/6
	 VpKWCP+cDLaHyA3rBuJqGIoVSuFgA/VpDDbdol+DXkD/3dJQ3eZLbYDjJPb5kIhuTn
	 Y+U3X3jEiJKrVn4JcyEaGSAwR0EUOjtHBnvdz4sQCP1N66IvmpJlfs5ceRA2rqXmrn
	 uVuSp91muGVdQ==
Subject: Re: [PATCH net-next v01 1/4] Fixes: Solve an LRO stall issue
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
Date: Tue, 10 Nov 2026 14:08:20 +0000
Message-ID: <179431970098.994134.1550238733009979837@kernel.org>
In-Reply-To: <6b3a98338e27fbfa923069686b7cd472f30f5033.1793946318.git.gongfan1@huawei.com>
References: <6b3a98338e27fbfa923069686b7cd472f30f5033.1793946318.git.gongfan1@huawei.com>
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

- [Medium] The commit message does not describe the change.
- [Low] The patch says it fixes a user-visible RX stall ("Solve an LRO
  stall issue") and the reviewer text it quotes asks for a Fixes: tag,…

--

Fixes: Solve an LRO stall issue

This patch changes hinic3_rx_poll() to return budget instead of nr_pkts
when the RX loop exits on the LRO replenish threshold. As a result,
hinic3_poll() stays in polling mode and does not complete NAPI or
re-enable the MSI-X vector.

> Fixes: Solve an LRO stall issue
>
> As noted in the subsequent review.
>
> This changes the return value when the loop exits on the LRO
> replenish threshold. It used to return nr_pkts and now returns budget.

[ ... ]

> This seems unrelated to statistics, and the commit message does not
> mention it. Was it intended? If it fixes an LRO stall, could it go in
> a separate patch with its own explanation and a Fixes: tag?

[Severity: Medium]
Could the commit message be rewritten so it describes this change on its
own?

The subject has no "hinic3:" prefix. It also starts with "Fixes:", and
tools that grep for Fixes: trailers can misread that.

"As noted in the subsequent review." points to a mailing list thread that
won't be in git history.

The rest of the body is the review text copied word for word. That
includes the questions "Was it intended?" and "could it go in a separate
patch with its own explanation and a Fixes: tag?", and they are left
unanswered.

The message doesn't say what stalls, when it stalls, or why returning
budget from hinic3_rx_poll() on the lro_replenish_thld exit fixes it. The
threshold defaults to HINIC3_LRO_REPLENISH_THLD, which is 256.

Is this the mechanism? Before the patch, the threshold break returned
nr_pkts < budget, so hinic3_poll() went on to run:

	if (likely(napi_complete_done(napi, work_done))) {
		hinic3_net_dim(nic_dev, irq_cfg);
		hinic3_set_msix_state(nic_dev->hwdev, irq_cfg->msix_entry_idx,
				      HINIC3_MSIX_ENABLE);

At that point, CQEs with RXDONE already set could still be in the ring.
If the device doesn't raise a new interrupt for CQEs it wrote before the
vector was re-enabled, those packets would stay there until more traffic
arrives.

Could the message say whether this device behaviour is what the patch
works around? The change was split out as the review asked, but the
explanation the review asked for seems to be missing.

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
> index 309ab59013797..9c4ab88998d47 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c

[ ... ]

> @@ -581,12 +582,14 @@ int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget)
>  
>  		rx_cqe->status = 0;
>  
> -		if (num_wqe >= nic_dev->lro_replenish_thld)
> +		if (num_wqe >= nic_dev->lro_replenish_thld) {
> +			poll_again = true;
>  			break;
> +		}
>  	}
>  
>  	if (rxq->delta >= HINIC3_RX_BUFFER_WRITE)
>  		hinic3_rx_fill_buffers(rxq);
>  
> -	return nr_pkts;
> +	return poll_again ? budget : nr_pkts;
>  }

[Severity: Low]
The patch is described as a fix for an RX stall, so should it carry a
Fixes: tag? The threshold early exit in hinic3_rx_poll(), and the
return nr_pkts it reaches, came in with:

Fixes: 17fcb3dc12bb ("hinic3: module initialization and tx/rx logic")

Without that tag and a net tree target, stable kernels that ship hinic3
won't pick up the fix.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793946318.git.gongfan1%40huawei.com
