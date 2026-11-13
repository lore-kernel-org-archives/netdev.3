Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794595629;
	b=GfRMAdd8T+EUID8Xc/go21t8Xde9JHZc5tt0EEYWDLEGS48KLOxn5GdzVw7R4OWCEw0g
	 TaKK15AAVUhJIHuoCA+Aulgn7VySSR4495AwotbqCElceOViDGM4vRxqMuHmEFv0Qcof9
	 rziY1ykX9pFfy1nWpXskxd2Vo9SKJr1ps1Sws7s7a/0oKHNnYGxfgYh+rcs7MEZ2TWTU1
	 4PZvfJXpWQY7INpnFC/c1PnykqtHx1LmcXg30iG78kvE4luGMYwP+yte7QHFD/Wd5PhyU
	 Eqf67sgq4QNdCFQyRK//EOs5Ml11P43hDHTm0/04ixhYbNWEi7GDM+RA9Dkagre0/+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794595629;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Jal0E2Mnv0Z77Uatas4UWnyPfvwf7BXhd0FfO5WpX90=;
	b=I5GD1ii/vR4ndfqsiihfy/UdjlPXPof3uym6cPd/bgEgXBOVNQXW7A1Hic20zVDIhpCb
	 bpRxllrr5nHjpvhBqMWkPU2QNwAiI6wd8DNtbhXhj8OrCvoVnUuMZuDveBZJFsFMBvW6q
	 B4tx2BnSy8ZUFe1+juET6kODNjvdmpyH1PZLhSjlpJIGgYdJXOAWrqja/yN29vFWvOq32
	 cj/PgVzHrfyrePlQL+YUGTYvobsWOg9y+NAgKAsjUUlTNnGuJKmuolnheyd6lTx8VOMzZ
	 8yZB7oncAfydV90OU0c8rDSg+pkE0aq2ywThVb+hQtlWp0aK2Qsxtw4xVyP7jvwkMmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tVYioc1K;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EC8606A64B
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 18:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75EC8606A64B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tVYioc1K
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFicZS2229943;
	Fri, 13 Nov 2026 18:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Jal0E2
	Mnv0Z77Uatas4UWnyPfvwf7BXhd0FfO5WpX90=; b=tVYioc1KGR9qNbcZtKHrj0
	SaKq2oA8BFIEehQEreXeF/kevJZZ+shfB04BlDi+X8GKj1WlOnf48Sz/A4vD2iVD
	tLKiw+xtm+yQTCwUwL3CCfLenMmmLIRBxOTKMSCi6tsZQQSOY8Dox1tJ/IaOedZ4
	twTD1tvpSkZ9uAc7fvtQKnMaj/AHqu+2DnxXT8/hI5EHzMRZtHRRvyyeMZ+frsK7
	jFPQwlgbQ0tpf6xbS07Z9ut8aXicICxyHTPSzHDCucMngNJMwQormYT1QVk8k4Mk
	EQMYitca1UlsQjaVOtrXUBgHK2NlfSdE3XNrEsgmukoliI0RtD7+WqStUNPb188A
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdgm1y4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 18:46:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFYxLA2453165;
	Fri, 13 Nov 2026 18:46:49 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hwegfd3sw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 18:46:49 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ADIkQQg26936022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 18:46:26 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4919158017;
	Fri, 13 Nov 2026 18:46:26 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34E0558028;
	Fri, 13 Nov 2026 18:46:23 +0000 (GMT)
Received: from [9.67.72.137] (unknown [9.67.72.137])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 18:46:23 +0000 (GMT)
Message-ID: <e4ebac16-58e6-49cd-9ead-20506f562380@linux.ibm.com>
Date: Fri, 13 Nov 2026 10:46:22 -0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 05/15] ibmveth: Refactor RX interrupt control
 for MQ RX queues
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
References: <20261109235556.60604-6-mmc@linux.ibm.com>
 <179452782074.2199510.13462227035463955143@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <179452782074.2199510.13462227035463955143@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af75b1a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=-iyn0Ag8WSiOA7Qd_NoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3MyBTYWx0ZWRfX5oyqXXKTmPNp
 XxLk2N+n3VWCE3aYyLKCGcocp0qSLHKwj2ircjT0tEilUU6g3xbyWkb9UdAJdQKM7RKx0Ru1Wmx
 ytQq63shqi7rqhdTz2VpMthB3QTiwmeSZjVkBR9kjQlNLXUtyEuIt1xcYZiNYXwQJAQPbhmicf4
 KshXFa1SoRtpilmZdTwcpvvpcPjUX3CEyqwl9X6UMbcKPP4bP+nBjPVsekEfOe/dsg4DfqPagGp
 nujRwpr3C4Pe++hfiV1PsUcRjKEUNHz1YbepVFJw2WCH/WWypn4/U9U6mbxh3ImRqWqlfImEBCL
 CBmi17PgZIiQU6vxlo0w2OQHzjG2bod9svPa14X3F8CGdCLsb95goOCUtJRHel4kpMeNMlsMPLa
 5l+atm4BHuS4RHnz4j25zW2pPIiiP0g/Ca3qSdG9HOTWJM336B2wa7AOewohL/i+dTud165j5Ec
 j4/SZAmZjDiZqk1TR3g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3MyBTYWx0ZWRfX8Dukv8Mrw5H7
 WeGKGZ+Dx8nj96X+0/V5E+CLpL8eZp/Ny91ooLL4GOpvJ1d9H1/PEsKvHCtRQHHnhqPZ2JelmKA
 54tEY6hlv9ISuGpxcfOpDq3ZLXi4iN4=
X-Proofpoint-GUID: -rADtgCQYTUDKWFSRry3bXqcOAEPGRdL
X-Proofpoint-ORIG-GUID: l7Wa3GyWDJkIswvdVmTOVrqpWhxGI8M2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130073


On 11/12/26 3:57 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [Medium] This is speculative and latent.
> - [Low] For subordinate queues, ibmveth_toggle_irq()
>    (drivers/net/ethernet/ibm/ibmveth.c) treats an H_PARAMETER return from…
>
> --
>
> ibmveth: Refactor RX interrupt control for MQ RX queues
>
> This adds queue-indexed RX interrupt helpers that use h_vio_signal() for
> queue 0 and H_VIOCTL for subordinate queues. It wires them into
> open/close/poll/interrupt and the process-context RX kick sites. Runtime
> stays single-queue (num_rx_queues is still 1).
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 31fad7713dc70..62e6c9a9f5e91 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>
>> @@ -347,6 +349,325 @@ ibmveth_cleanup_rx_resources(struct ibmveth_adapter *adapter)
> [ ... ]
>
>> +static int
>> +ibmveth_toggle_irq(struct ibmveth_adapter *adapter, int queue_index,
>> +		   bool enable)
>> +{
>> +	unsigned long h_rc;
>> +	unsigned long irq = adapter->queue_irq[queue_index];
>> +	const char *action = enable ? "enable" : "disable";
>> +
>> +	if (queue_index == 0) {
>> +		/* Primary queue: use h_vio_signal() */
>> +		h_rc = h_vio_signal(adapter->vdev->unit_address,
>> +				    enable ? VIO_IRQ_ENABLE : VIO_IRQ_DISABLE);
>> +	} else {
>> +		/* Subordinate queues: use H_VIOCTL with hardware IRQ */
>> +		struct irq_data *irq_data = irq_get_irq_data(irq);
>> +		irq_hw_number_t hwirq;
>> +		u64 vioctl_cmd = enable ? H_ENABLE_VIO_INTERRUPT :
>> +			H_DISABLE_VIO_INTERRUPT;
>> +
> [ ... ]
>
>> +		hwirq = irqd_to_hwirq(irq_data);
>> +		h_rc = plpar_hcall_norets(H_VIOCTL,
>> +					  adapter->vdev->unit_address,
>> +					  vioctl_cmd,
>> +					  hwirq, 0, 0);
> [Severity: Medium]
> This one is speculative. Do subordinate queues need the post-migration
> EOI that ibmvnic issues for the same kind of H_VIOCTL-controlled queue
> interrupt?
>
> drivers/net/ethernet/ibm/ibmvnic.c:
>
> /* Due to a firmware bug, the hypervisor can send an interrupt to a
>   * transmit or receive queue just prior to a partition migration.
>   * Force an EOI after migration.
>   */
> static void ibmvnic_clear_pending_interrupt(struct device *dev,
> 					    struct ibmvnic_sub_crq_queue *scrq)
> {
> 	if (!xive_enabled())
> 		ibmvnic_xics_eoi(dev, scrq);
> }
>
> ibmveth_toggle_irq() is the only place that re-arms subordinate queues.
> At the end of the series, ibmveth.c has no H_EOI or xive_enabled()
> handling anywhere.
>
> Suppose ibmveth subordinate RX queues have the same firmware behaviour.
> On XICS, an interrupt pending across LPM would then never get an EOI.
> That queue would stop taking interrupts: NAPI idle, PHYP enabled, RX
> stalled on that queue.

Not reachable for now: the HMC blocks LPM while ILLAN multi-queue is
active, so a partition can't migrate with subordinate queues live.
ibmveth also doesn't get a firmware migration event like ibmvnic does,
so there's nowhere it could issue that EOI today.

On the Power11 LPAR I tested, XIVE is the default, but XICS is still
possible with xive=off, and the ibmvnic workaround is XICS-only. Once
PHYP and the HMC allow LPM with ILLAN multi-queue, I'll check whether
the same firmware issue applies to the subordinate RX queues and add
the post-migration H_EOI if it does.

Thanks,
Mingming

> Nothing would start recovery either. After LPM, ibmveth only schedules a
> reset if the MQ buffer hcalls return H_FUNCTION.
>
> Queue 0 has migrated over XICS for years without this EOI. It is
> controlled by h_vio_signal() rather than H_VIOCTL, though, so that does
> not answer the question for subordinate queues.
>
> This path is latent until the later "ibmveth: Enable multi-queue RX
> receive path" commit. Could it be checked against PAPR/PHYP behaviour
> before multi-queue is enabled?
>
>> +
>> +		/*
>> +		 * Fold H_PARAMETER only on disable (idempotent mask). On
>> +		 * enable it is not already-enabled: a trivial enable
>> +		 * returns success. H_PARAMETER means the interrupt
>> +		 * number was not in the valid range for that unit
>> +		 * address. Keep that an error so a missed LISN stays
>> +		 * visible to poll/resize recovery.
>> +		 */
>> +		if (h_rc == H_PARAMETER && !enable) {
>> +			dev_warn_ratelimited(&adapter->netdev->dev,
>> +					     "H_VIOCTL %s IRQ returned H_PARAMETER for queue %d (hwirq=%lu)\n",
>> +					     action, queue_index, hwirq);
>> +			return 0;
>> +		}
> [Severity: Low]
> Does the comment above this fold actually support it? It says a trivial
> enable already returns success, and that H_PARAMETER means the interrupt
> number was not in the valid range for the unit address.
>
> That describes a bad hwirq argument, not an interrupt that is already
> masked. The same reading would seem to apply to H_DISABLE_VIO_INTERRUPT.
> The commit message calls this an "idempotent mask".
>
> ibmvnic makes the same hcall and treats any non-zero rc as a failure:
>
> drivers/net/ethernet/ibm/ibmvnic.c:disable_scrq_irq() {
>      ...
> 	rc = plpar_hcall_norets(H_VIOCTL, adapter->vdev->unit_address,
> 				H_DISABLE_VIO_INTERRUPT, scrq->hw_irq, 0, 0);
> 	if (rc)
> 		dev_err(dev, "Couldn't disable scrq irq 0x%lx. rc=%ld\n",
> 			scrq->hw_irq, rc);
> 	return rc;
> }
>
> Two teardown paths rely on the mask actually taking effect:
> ibmveth_cleanup_rx_interrupts() and the err_disable_napi rollback in
> ibmveth_setup_rx_interrupts(). Both run mask, synchronize_irq(),
> napi_disable(), synchronize_net(), remask, then free_irq(). With the
> fold, a disable that PHYP rejected looks like a successful mask there.
>
> No subordinate-queue caller of ibmveth_disable_irq() checks the return
> value. So today the visible effect is only the log level (dev_warn
> instead of dev_err) and the self-contradicting comment. The path is also
> only reachable once num_rx_queues > 1, after the later "ibmveth: Enable
> multi-queue RX receive path" commit. The fold is still there at the end
> of the series.
>
> Should H_PARAMETER on disable stay an error, as it does on enable?
> Alternatively, the comment and commit message could explain why disable
> is treated differently.
>
> [ ... ]
>
