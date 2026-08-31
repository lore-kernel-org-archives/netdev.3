Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859BC3AE1AD
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 18:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200684; cv=none; b=elX05AglFI3VzaRIcAqTjQKqm0imUHpTGn/lCjnd3J/40ZfHOkdQGEEswhy1hqOPLU2DFonYZF+RWQIFEXppJ8+aP/hZtLzMGwHgNrM6cz84Npgz9zGHCt+k1E/hn68/Uq7epbQo7SCkyiyNXd3DvnEeJJC3r2ApmRmiZhxLpc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200684; c=relaxed/simple;
	bh=wJXYuz8pZYpy1N+AJm5qhLU3sjZuY+JX0N1z+/b5Yn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lvhp4gBRjRYK/P7bvA7rVbUwXktEyLhubcMfNSg1JyBD2H/DSs14SMjJ7ntKhpilE1dXSo0rs5odB0WaZCaM1GvuDjOnJGWK3En4E+zXMulrkw2tKer1Ol7qAY4df6LNejbdOCsHyT3b1P71qjJq3p+QetqjhXSukCPpayivSm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D+GeE2Av; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D+GeE2Av"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VG1fVL2800418;
	Mon, 31 Aug 2026 18:24:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ggjaES
	5+uaiqpYxsf90wbj4OJDLR0AP3J+eeWLmFNxw=; b=D+GeE2Av7wunbQveOe6+2U
	vkzRgDFhgEOaLsl7wvRAYrIZW42pjgaOdACiag270wfEsQdOiPbiCsI/FtCcRavn
	ro0qt1gYW83QJyZL3d8esuVjWxrobmhO3vGMb4fOxqfBzoPFiw73bkH2gC7y5l0r
	Fw3JoSWq2RpKcCJJIgnRl2PUGGOms1CJWdiQhuT2wchyT+6/WX0JP32o/YCzapsv
	O4YSrnAQ0wmCJoauKU6ozvgctJbas8pSFcc0Qwa0QK4HcuNCORliuGnYAIwhezWs
	KSAcKsM02PZG7bPREGG4MkP+F+oNW5iApPyv4LY4L3UUKn9S3buHddmcv4Udcd1A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2t2w6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 18:24:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VHuMN7023388;
	Mon, 31 Aug 2026 18:24:24 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gccexy723-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 18:24:24 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VIOMAK26804786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 18:24:22 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8C2C5805A;
	Mon, 31 Aug 2026 18:24:22 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEC615805C;
	Mon, 31 Aug 2026 18:24:19 +0000 (GMT)
Received: from [9.67.102.143] (unknown [9.67.102.143])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 18:24:19 +0000 (GMT)
Message-ID: <aa8f471d-e5e7-4cb5-8afd-b23418f062ee@linux.ibm.com>
Date: Mon, 31 Aug 2026 11:24:18 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 05/15] ibmveth: Refactor RX interrupt control
 for MQ RX queues
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
References: <20260814073642.24630-6-mmc@linux.ibm.com>
 <20260818014722.3854051-1-kuba@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260818014722.3854051-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a95c6da cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=SFU1uJ_REAyA1rKbdW0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE1NiBTYWx0ZWRfXybaxFI7m8DQK
 SJIUQhCYo3N2azqL+stZTWywPA1UCmsqP0jAzXeSAMS0qeI1wquWT4O/cRWlx4tr2oItJ0L4Kjj
 y/XHxrIdwqoORT+27BOqTD3BJkkrMZA=
X-Proofpoint-ORIG-GUID: H1-tlKJw8JcUhA1vzma3iAUN1E-d7x3X
X-Proofpoint-GUID: q6WwOVxVG05ayJ5HYKc3b3yQfxw4tXw6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE1NiBTYWx0ZWRfX2sjqjqUu+zrm
 W8TQeETZkwzzml0YCq8MHdcZjqV0rCIs6/LToJU8FQOroCJdQ6Pbx3Nfr+EMkJv7dq5EuBKBWl9
 TjpuY+e94oKTtK//cxi/1zM5YpHcnA7dwEhBOWcnbaCsfFN91tFpVe80s3ebpI5i9scb8ODeB6F
 Gr5o3qDaqHkXoxr+2qxcSqZY+GCG5XTeeBXzphi/UjszC7UpaT2NN+Gjey2wpk1gDC+xyO9v8lK
 a7unydPWi5SYrZOE1rA0htZVYl4/qigdMRExNie86NK70oo6RrvbXdNSjvFBl5ymsYAopX9Se6N
 GraZwUhHG/hZJXOKZs+C9d7jwiijwjcBvK6uwjuO10utwGoKBE/Vf2Rq2eEQyeMgVPFnzmj1F1v
 aAK99j45sIv3vW+diE4oTLmsiNOnH72G+PGYoerhRd+x6gh3pUFnOGHmDZ82S82FSHRzQ8SpyCG
 NEs1eSOTSHoiVdcQwsQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310156


On 8/17/26 6:47 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ibmveth: Refactor RX interrupt control for MQ RX queues
>
> This patch introduces queue-indexed RX interrupt helpers (toggle/enable/
> disable, setup/cleanup, schedule) and wires them into open(), close(),
> poll() and the IRQ handler, with request_irq() now using &adapter->napi[i]
> as the per-queue cookie. Runtime behaviour stays single-queue.
>
> A few questions below.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 1a428ee60d58c..99eeb6ef51bf3 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>
>> @@ -331,6 +333,311 @@ ibmveth_cleanup_rx_resources(struct ibmveth_adapter *adapter)
> [ ... ]
>
>> +		/*
>> +		 * H_PARAMETER is ambiguous (already in requested state vs bad
>> +		 * args). Fold only on disable as an idempotent mask. On enable
>> +		 * keep it an error so a stuck-masked queue stays visible to
>> +		 * poll/resize recovery.
>> +		 */
>> +		if (h_rc == H_PARAMETER && !enable) {
>> +			dev_warn_ratelimited(&adapter->netdev->dev,
>> +					     "H_VIOCTL %s IRQ returned H_PARAMETER for queue %d (hwirq=%lu)\n",
>> +					     action, queue_index, hwirq);
>> +			return 0;
>> +		}
> [ ... ]
>
>> +	if (adapter->multi_queue && num > 1) {
>> +		for (i = 0; i < num; i++) {
>> +			rc = ibmveth_enable_irq(adapter, i);
>> +			if (rc) {
>> +				netdev_err(netdev,
>> +					   "Failed to enable IRQ for queue %d, rc=%d\n",
>> +					   i, rc);
>> +				while (--i >= 0) {
>> +					ibmveth_disable_irq(adapter, i);
>> +					synchronize_irq(adapter->queue_irq[i]);
>> +				}
>> +				rc = -EIO;
>> +				goto err_disable_napi;
>> +			}
>> +		}
>> +	}
> [ ... ]
>
>> +err_disable_napi:
>> +	/* PHYP unmask was rolled back above; disable NAPI before free_irq */
>> +	for (i = 0; i < num; i++)
>> +		napi_disable(&adapter->napi[i]);
>> +	for (i = 0; i < num; i++) {
>> +		if (adapter->queue_irq[i])
>> +			free_irq(adapter->queue_irq[i], &adapter->napi[i]);
>> +	}
> [Severity: Medium]
> In ibmveth_setup_rx_interrupts(), when ibmveth_enable_irq() fails for queue
> i the rollback loop begins with --i, so queue i itself is never masked, yet
> err_disable_napi then napi_disable()s and free_irq()s that same queue.
>
> Is queue i guaranteed to be masked at that point?  ibmveth_toggle_irq()
> folds H_PARAMETER to success only on disable, and its own comment says
> H_PARAMETER may mean "already in requested state":
>
> 	if (h_rc == H_PARAMETER && !enable) {
>
> so an enable can report an error for a queue PHYP has already unmasked.
>
> While napi_disable() sleeps, an interrupt on that still-unmasked queue
> reaches ibmveth_interrupt() -> ibmveth_schedule_rx_queue(), where
> napi_schedule_prep() fails and the helper deliberately does not mask:
>
> 	if (napi_schedule_prep(napi)) {
> 		rc = ibmveth_disable_irq(adapter, qindex);
> 		WARN_ON(rc);
> 		__napi_schedule(napi);
> 		return true;
> 	}
> 	return false;
>
> The handler still returns IRQ_HANDLED, so nothing quiets the source.  Can
> this leave the PHYP interrupt asserted and re-entering the handler for the
> duration of the napi_disable() wait, which is the opposite of the "mask
> PHYP and synchronize_irq before napi_disable" rule stated in the changelog?
>
> The multi_queue && num > 1 branch cannot run at this commit because
> multi_queue is hardcoded to 0, but it becomes live later in the series and
> the rollback loop is unchanged at the end of the series.
Not guaranteed, so yes it could storm. v6 remasks queues 0..i,
including the one that failed, then remasks and synchronize_irq()
after napi_disable before free_irq.
> [ ... ]
>
>> +/**
>> + * ibmveth_schedule_rx_queue - Mask PHYP IRQ and schedule NAPI for one RX queue
>> + * @adapter: ibmveth adapter structure
>> + * @qindex: RX queue index
>> + *
>> + * Shared by the IRQ handler and process-context kick sites (open, resume,
>> + * pool sysfs, poll_controller).
>> + *
>> + * Return: true if NAPI was scheduled (and PHYP masked), false if prep failed
>> + */
>> +static bool ibmveth_schedule_rx_queue(struct ibmveth_adapter *adapter,
>> +				      int qindex)
>> +{
>> +	struct napi_struct *napi = &adapter->napi[qindex];
>> +	int rc;
>> +
>> +	if (WARN_ON(qindex < 0 || qindex >= adapter->num_rx_queues))
>> +		return false;
> [Severity: Low]
> This isn't a bug, but the documented return contract does not match the
> code in two ways.
>
> The out-of-range WARN_ON branch also returns false, which is not a prep
> failure, so callers cannot distinguish the two cases.
>
> And "true ... (and PHYP masked)" is not established, since the return of
> ibmveth_disable_irq() is only passed to WARN_ON() and then discarded:
>
> 	if (napi_schedule_prep(napi)) {
> 		rc = ibmveth_disable_irq(adapter, qindex);
> 		WARN_ON(rc);
> 		__napi_schedule(napi);
> 		return true;
> 	}
>
> so when the mask hypercall fails the helper still reports true while the
> queue remains unmasked.  Should the kernel-doc be reworded, or should the
> mask failure be reflected in the return value for callers like open(),
> resume(), veth_pool_store() and the later ibmveth_restart_rx_queue()?
Reworded. true is "NAPI was scheduled and a mask was attempted".
WARN_ON(rc) is gone; a failed disable_irq() is logged and does not

change the return.

> [ ... ]
>
>> @@ -991,24 +1297,20 @@ static int ibmveth_open(struct net_device *netdev)
>>   	if (rc)
>>   		goto out_free_tx_ltb;
>>   
>> -	netdev_dbg(netdev, "registering irq 0x%x\n", netdev->irq);
>> -	rc = request_irq(netdev->irq, ibmveth_interrupt, 0, netdev->name,
>> -			 netdev);
>> -	if (rc != 0) {
>> -		netdev_err(netdev, "unable to request irq 0x%x, rc %d\n",
>> -			   netdev->irq, rc);
>> +	rc = ibmveth_setup_rx_interrupts(adapter);
>> +	if (rc) {
>>   		do {
>>   			lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
>>   		} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
>> -
>>   		goto out_free_buffer_pools;
>>   	}
> [Severity: High]
> This isn't a bug introduced by this patch, but the ordering here is worth a
> question now that close() gains an early return.
>
> ibmveth_open() registers the logical LAN before allocating buffer pools, and
> the pool allocation failure branch takes goto out_free_tx_ltb, which runs:
>
> out_free_tx_ltb:
> 	while (--i >= 0)
> 		ibmveth_free_tx_ltb(adapter, i);
> 	ibmveth_cleanup_rx_resources(adapter);
> out_free_filter_list:
> 	ibmveth_free_filter_list(adapter);
>
> That dma_unmaps buffer_list_dma[0], dma_free_coherent()s the RX ring and
> frees the filter list page without ever calling h_free_logical_lan().  Does
> this leave PHYP registered against the buffer list, filter list and RX
> descriptor ring after those pages have been unmapped and returned to the
> page allocator?
>
> The same ordering exists in the baseline at 4f93b12cf7b2, so the root
> problem predates this patch.  What changes here is that the new
> "if (!adapter->opened) return 0;" gate in ibmveth_close() also removes the
> accidental recovery a later ndo_stop used to provide by running the
> h_free_logical_lan() loop.
>
> For reference, this is resolved by the end of the series: open() there
> allocates the buffer pools before ibmveth_register_rx_queues(), and every
> post-registration error path funnels into ibmveth_free_all_queues(), which
> issues h_free_logical_lan() in a retry loop.

Yes. The gate removes that accidental recovery. Staging: patch 6
issues h_free_logical_lan() on the pool-fail path; patch 7 moves
pools ahead of register.

>> @@ -1032,27 +1333,32 @@ static int ibmveth_close(struct net_device *netdev)
>>   	long lpar_rc;
>>   	int i;
>>   
>> -	netdev_dbg(netdev, "close starting\n");
>> +	/* Gate on opened, not IFF_UP: pool_store/change_mtu close+open can
>> +	 * leave IFF_UP set after a failed reopen.
>> +	 */
>> +	if (!adapter->opened)
>> +		return 0;
>>   
>> -	napi_disable(&adapter->napi[0]);
>> +	adapter->opened = false;
> [Severity: Low]
> This is a pre-existing issue rather than something introduced here, but
> should this gate carry a Fixes: tag and a note in the changelog?
>
> In the baseline, ibmveth_close() unconditionally ran
> napi_disable(&adapter->napi[0]) and free_irq(netdev->irq, netdev).  After a
> failed reopen from veth_pool_store() or ibmveth_change_mtu() (both call
> close() then open() directly and leave IFF_UP set when open fails), a
> subsequent "ip link set down" re-entered ndo_stop with NAPI already
> disabled and no IRQ registered.  napi_disable_locked() leaves
> NAPIF_STATE_SCHED|NPSVC set, so the second napi_disable() spins in its
> usleep_range() loop while holding rtnl, and free_irq() splats "Trying to
> free already-free IRQ".
>
> The changelog describes the mechanism ("opened / rx_irq_setup gate whether
> cleanup walks IRQ/NAPI state") and the v5 notes below the --- describe the
> scenario, but the commit message itself never says a hang is being fixed
> and there is no Fixes: tag, so the fix is hard to identify for backports.
> It also cannot be applied on its own since it depends on the new helpers,
> flags and queue_irq[] array added here.
The hang is in the commit message. No Fixes: tag — as you said, it
depends on the helpers and flags added here.

>
> [Severity: Medium]
> Separately, can this early return skip TX long-term-buffer teardown?  At
> this commit ibmveth_set_channels() keys its allocation decision off IFF_UP:
>
> 	if (!(netdev->flags & IFF_UP))
> 		return netif_set_real_num_tx_queues(netdev, goal);
>
> so after a failed reopen (IFF_UP still set, adapter->opened false),
> "ethtool -L eth0 tx N" takes the allocating branch while the adapter is
> closed.  The next ndo_stop then returns early and never reaches:
>
> 	for (i = 0; i < netdev->real_num_tx_queues; i++)
> 		ibmveth_free_tx_ltb(adapter, i);
>
> and the next ibmveth_open() assigns tx_ltb_ptr[i]/tx_ltb_dma[i]
> unconditionally.  Does that leak the bounce buffer and its DMA mapping per
> TX queue?
>
> By the end of the series ibmveth_set_channels() gates on
> "if (!adapter->opened)" and only stashes queue counts, so no path allocates
> TX LTBs while the adapter is closed, which removes this window.
Yes, at this commit. The gate stays — it is what stops the hang.
Patch 14 switches set_channels() to opened; patch 15 does not
allocate while down.
>
> [ ... ]
>
>> @@ -1696,7 +2002,7 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>>   			container_of(napi, struct ibmveth_adapter, napi[0]);
>>   	struct net_device *netdev = adapter->netdev;
>>   	int frames_processed = 0;
>> -	unsigned long lpar_rc;
>> +	int rc;
>>   	u16 mss = 0;
>>   
>>   restart_poll:
> [ ... ]
>
>> @@ -1796,15 +2102,15 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>>   	/* We think we are done - reenable interrupts,
>>   	 * then check once more to make sure we are done.
>>   	 */
>> -	lpar_rc = h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_ENABLE);
>> -	if (WARN_ON(lpar_rc != H_SUCCESS)) {
>> +	rc = ibmveth_enable_irq(adapter, 0);
>> +	if (WARN_ON(rc)) {
>>   		schedule_work(&adapter->work);
>>   		goto out;
>>   	}
>>   
>>   	if (ibmveth_rxq_pending_buffer(adapter) && napi_schedule(napi)) {
>> -		lpar_rc = h_vio_signal(adapter->vdev->unit_address,
>> -				       VIO_IRQ_DISABLE);
>> +		rc = ibmveth_disable_irq(adapter, 0);
>> +		WARN_ON(rc);
>>   		goto restart_poll;
>>   	}
> [Severity: Low]
> This isn't a bug today, but the two halves of the new per-queue protocol
> disagree.  ibmveth_interrupt() now resolves the queue that fired:
>
> 	qindex = napi - adapter->napi;
> 	...
> 	ibmveth_schedule_rx_queue(adapter, qindex);
>
> while ibmveth_poll() still recovers the adapter through
> container_of(napi, struct ibmveth_adapter, napi[0]) and hardcodes queue 0
> in ibmveth_enable_irq(adapter, 0) / ibmveth_disable_irq(adapter, 0).  For a
> napi index above 0 that container_of would compute a wrong adapter pointer
> and the unmask would target queue 0 rather than the queue that fired.
>
> Since IBMVETH_MAX_RX_QUEUES is 1 and multi_queue is 0 at this commit only
> napi[0] can be registered, and later commits in the series ("ibmveth:
> Harden RX poll path with helpers" / "ibmveth: Enable multi-queue RX receive
> path") derive queue_index = napi - adapter->napi in poll() with a range
> check.  Would it be clearer to convert poll() in the same patch that
> introduces the queue-indexed handler, so the two sides never disagree?

