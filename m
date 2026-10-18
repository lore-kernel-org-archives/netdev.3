Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD924ACC6A;
	Sun, 18 Oct 2026 13:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792328868; cv=none; b=QyRMa4Rb3Z8Pq3oYWSbbfEZkEErzlsxKlnyGLXkoclV7H6kZHqPYRbnI+H8LYeZ2+9eA8y1EIBP3NoPn3KC95PFd+PW3jL2H6YDlLtphsaDCVSZY3d/JdiFphHm5NTu49mWbnlwcfemhrroI7P5Gt/1A4rMSlV4Al9EvSBivAMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792328868; c=relaxed/simple;
	bh=8fvsV3EdUe4o9S9dwFPakZAm+8DuUBd0HU9GdQZt398=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IS6LJkro3292sPmBY/6NPzITd6BOOFxM7zWic0nQBJw+T9OszU3jexqakrLDAmlV/0WZYHqNQl7lh/51JH8DtOGZY76ccPveAa5bK1ZinlUwi3G26YULEoiIoE4w3ABec1BNHUeuMcCd6u6LogMtJVR3VeUzv5M39Xo1cRAQFks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fNVwazYx; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fNVwazYx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=+Gzpq1l6pKCs17WMz6bfBuoemMm27hA7D/+U5mMg/A0=;
	b=fNVwazYxeJEJD/IOwoHxmWI3o0B3s8NsJ525CLmDDsK9weKZxu+71EgSh1cECL
	9wM3XsqVpK+kYxaRL5zcgzO6Inq+RaI1/IUH9O0Kh+khx7f8Yqkh2ZWklMEcVUx0
	YPHMfd8sN17dgNTk7dQZMhPXqxG+/RKMrhEY/6WmTaT7Y=
Received: from 4CV529F122.company.local (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgC33z4TxNRq1VFhAg--.9618S2;
	Sun, 18 Oct 2026 21:05:38 +0800 (CST)
From: Ding Hui <dinghui1111@163.com>
To: maxime.chevallier@bootlin.com
Cc: alexandre.torgue@foss.st.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	dinghui1111@163.com,
	dinghui@lixiang.com,
	edumazet@google.com,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	liuxuanjun@lixiang.com,
	mcoquelin.stm32@gmail.com,
	netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	xiasanbo@lixiang.com,
	yangchen11@lixiang.com
Subject: Re:Re: [PATCH net v5] net: stmmac: fix error path cleanup in DMA descriptor ring allocation
Date: Sun, 18 Oct 2026 21:05:23 +0800
Message-Id: <20261018130523.1935638-1-dinghui1111@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <12b18559-3e8e-4a09-94a1-0d303ad7c2c6@bootlin.com>
References: <12b18559-3e8e-4a09-94a1-0d303ad7c2c6@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgC33z4TxNRq1VFhAg--.9618S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF15try5Jr17ZFWfCw1rWFg_yoWrCr4xpr
	WfKws8KrWDXryxAr4DXa18W3WfC3ySkr45Wr4fKr17ursxZFySgF9IyrW5WFW8CrWvya1Y
	9rZ8ua4xAF4DAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_Xo7JUUUUU=
X-CM-SenderInfo: pglqwx1xlriiqr6rljoofrz/xtbC0QIJNWrUxCJK5gAA3b

Hi,
Thanks for the review.

At 2026-10-16 22:44:35, "Maxime Chevallier" <maxime.chevallier@bootlin.com> wrote:
>Hi,
>
>On 10/12/26 16:24, Ding Hui wrote:
>> From: Ding Hui <dinghui@lixiang.com>
>> 
>> __alloc_dma_rx_desc_resources() and __alloc_dma_tx_desc_resources()
>> allocate resources in multiple steps but return early on failure
>> without cleaning up what they have already allocated. The outer
>> error paths then call the free helpers on partially-initialized
>> queues, which dereference pointers that were never allocated:
>> 
>>   - dma_free_rx_skbufs() and dma_free_rx_xskbufs() dereference
>>     rx_q->buf_pool[i] via stmmac_free_rx_buffer(), but buf_pool
>>     may be NULL if its kzalloc_objs() failed.
>> 
>>   - dma_free_tx_skbufs() dereferences tx_q->tx_skbuff_dma[i] via
>>     stmmac_free_tx_buffer(), but tx_skbuff_dma may be NULL if its
>>     kzalloc_objs() failed.
>> 
>>   - stmmac_free_tx_buffer() dereferences tx_q->xdpf[i] and
>>     tx_q->tx_skbuff[i] (aliased through a union), but tx_skbuff
>>     may be NULL if its allocation failed while tx_skbuff_dma
>>     succeeded.
>> 
>> Fix this by making each allocation function responsible for undoing
>> its own allocations on error, following the standard kernel error
>> handling pattern of cleaning up in reverse order. Also add NULL
>> checks in the free helpers as a defensive measure, since they may
>> be called on partially-initialized queues.
>> Additionally, make __free_dma_rx_desc_resources() and
>> __free_dma_tx_desc_resources() clear the pointers they free, so that
>> the NULL guards in the free helpers hold reliably when the long-lived
>> priv->dma_conf is reused across XDP open/release cycles.
>> Free the RX resources in alloc_dma_desc_resources() when the TX
>> allocation fails, as the callers only free dma_conf itself on
>> that path.
>> After __stmmac_open() copies a temporary dma_conf into priv->dma_conf,
>> release the descriptor resources through priv->dma_conf on an open
>> failure. This keeps the long-lived configuration consistent with the
>> resource cleanup while callers only free the temporary container.
>> Finally, hold RTNL while descriptors_status inspects the descriptor
>> rings. This serializes the debugfs reader with control-plane resource
>> teardown paths and allows it to safely report queues whose descriptor
>> rings are not allocated. Skip queues whose descriptor rings are not
>> allocated in stmmac_rings_status_show() to avoid dereferencing a NULL
>> pointer.
>> 
>> Signed-off-by: Ding Hui <dinghui@lixiang.com>
>
>In V1 Andrew requested that this targets net-next yet this series kept
>targetting the "net" tree since then.
>
>I think this is an omission on your side as you replied to the bots that
>you removed the Fixes: tag on purpose :) You need to have "net-next" in
>the patch topic : [PATCH net-next v5]
>
The "net" prefix is indeed an omission on my side. Andrew asked for
net-next targeting back in v1, and I kept the wrong subject prefix
when respinning. The next revision will be sent as [PATCH net-next v6].

>This is starting to look good, but as you need to respin, is it possible
>that you split that patch down into simpler patches ? There are multiple
>classes of problems being addressed here :
> - Error paths being reworked
> - Null checks being added
> - Some pointers being Nulled
>
>It would make it easier to digest during review.
>
Agreed. Here is the plan — 4 patches, ordered as follows:

  1/4: add NULL guards in the free helpers and clear the pointers
       they free, so that a NULL pointer reliably means "not
       allocated";

  2/4: rework the allocation error paths, making
       __alloc_dma_rx_desc_resources() and
       __alloc_dma_tx_desc_resources() undo their own allocations on
       error, and free the RX resources when the TX allocation
       fails;

  3/4: release the descriptor resources through priv->dma_conf when
       __stmmac_open() fails after copying the temporary dma_conf,
       adjusting the callers accordingly;

  4/4: hold RTNL while the descriptors_status debugfs entry inspects
       the rings, and skip queues whose rings are not allocated.

Does this split and ordering look reasonable? If so, I'll
send v6 shortly.

Best regards,
Ding Hui

