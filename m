Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E5132E743
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 05:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787029392; cv=none; b=QqoZGAfpAMxyz8zHx4lQ2wul7MzMO5DzcGFw6XX/AggQN6W7MKzw++OQgiGwA+8AcZutxZ+PgkeEZXlEhwIEXa/QxUvTDSUsTqzjbQXqMgHrySwezopTYQKnX2wXsV3EtccBuCxeRkmG2ew78Uqe2BT6Euy+xUGJzT3mU7zYDPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787029392; c=relaxed/simple;
	bh=zIsxOf2W76FHiDrSPNWiehPoFgsf+wBLveoE5AIM+vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHzG0CI3i5WmTVgTeSv7IRTB0GxKhM/zrGE32UMQZj9mWWjs2USQ85DP6hFUT9kkcXsh7nngAhY/PuX51FMvRF8/0uGiw/En6Z3zTpCWhd4lev9mQ+uoaVMXU5DnhLIv77yKCLK0r0WK06/S8NX0H2O7CgXJgPSsFCybX9APimg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cFk9JOev; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cVUur9qT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cFk9JOev";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cVUur9qT"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I12WrU297868
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 05:03:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Lk3kYnjvSJgDQ5vPgnZxa9e3E35X4pqPerDxw7hqB1A=; b=cFk9JOev29rXrDdF
	X5YXl3PCw1BL2/F3d0lzdmc0lvMDhJvedNT+bIf9/mX+r1x35DYQ7TdcK/fw4X8G
	RaHS/OzS0YiSaKxcuv+i+kbfAH1WbWpODiwg7ZWlSqj7GMCp4ITDU76g4hcIKiXl
	aF9GZwzD5OTlqcJ6kaKqT79UffFu/n3hDk4W2M57IReVx8sFfnBgIR225AwXrXTb
	F35v3tGCOG9LU/40z7F8xo3725uE1/fv74oogLAZcFrGYXt/+BFeafQzwnL8uzt0
	vh7ZTJIPtJWrJvb79dldUX5n1l53oLwBehecDKUQww4OjtCWjjPUJPtGPLgW9Sii
	IvY1vA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4dcn0u04-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 05:03:09 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f57e31b6eso3942185a91.1
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 22:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787029389; x=1787634189; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lk3kYnjvSJgDQ5vPgnZxa9e3E35X4pqPerDxw7hqB1A=;
        b=cVUur9qT04ePbxE01HnZ7gpjVH6V1PmK/IB3bZ+ZPbfFRBdNKFiud9fYzFfl+aEc1J
         9QjnbUy26zKaJ8e2ofLwQYOMS8aucThQtMStxk4IfGDKJM/uJO9UgYpAH4bxE2WSrvj4
         3JMiTy3MdwsouMzgHlPpYuY9dm1ay824nLjYVr6Zs7aTGD0YAwKyRF2tqxRioRIHOmo6
         XHjZcJo1RbU0v2CUqDqnKXKwpx7fJGuNYZbivRy/uWVQbjw5aUQ/MzZqGmmGt/43A+oM
         Zd2v2p+VVDahdU2BQVHwfYZv4Yg9UIhc6+rx2yxMsc19I0yPVlrm1Msv/mtuVMhitXEU
         TNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787029389; x=1787634189;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lk3kYnjvSJgDQ5vPgnZxa9e3E35X4pqPerDxw7hqB1A=;
        b=NHtbyuqeQLUbbn4b8yKnShulIq2iGwhFiA7T4RoLg1SJlcKzL3lGmQt69DhAdh5lcE
         x9434fJuadSvDSnlsIwCUiT3LXURHAaSy2gokBVHjDD+MTUkNMuVSegwoLh19TCsqCOH
         aRf56Oee0M8tcoecxa7srK/pmXSDsRXTUmTb1hqc9vpxYRs+RNFljjVxzbctAvC+Gocx
         b9CJsYYOlPhhiQL2/v4mjxXRwKY03+2sOVOMCUPQ6IF0T5PkY+lOh3CU2GAF/3M/AVrB
         uwbnbDcZPZBY16CvPNNWnZSmGOM/6a4o7RWwQKu/JiWUOJ+xLjC8V1ZdNv1Cun4QD8Ik
         YUwg==
X-Forwarded-Encrypted: i=1; AHgh+Rqm/1LzXEuxooz8/qyJrjq2/stqAcrBIKuNxIv4x3JuAbbgUkKLCh4t5FUJrVsR8um23KdzNCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW2gUXlFKOcxMikJVSp4A0Uq/MNbf8q4z5O3CxzjQOCZzMLCox
	W/jgBh9izw5V+D7qu8dalg3yV5l+9dFYMqu+6eS+LLb72Z7e/SFZPVK3L+jQ9QZSM+zOQ4izBPX
	iebE4rTRMqHJri8+XsM7xE+iM58giIashcdorqoFM5h/U4vs7wI1XXE0RxJk=
X-Gm-Gg: AR+sD11k1cAhS3fXphIdqlFQPauR46SPdMctKLfkXY9ZVcAicMnEBKi2Z4Qc+WhM7gx
	XFwmVUm8Opj7ZV7WKyw2wlPKoe2jFaDrHflzFC8Z5WsyxyWJPIjtlqbjXYexgmRHmepThxQFp6t
	dYPwUHxvyPs2eJ1rKDqFPtfvsOw8DnoHbBh36NLFjt+h+c6VQhk3G0rXueli1SU7OOZIhJtlCBh
	DO1mbqd6sdPgpuvmyfebHdqA6u82QWqB1C/jmBOhcU5pQYAZZoL/4G39xj3WL6Ahpsi4KwqIeUY
	EwmVvn6PpeRC8JRd7oxCyWoCYcASVsYxy1wGaj3qNgcZZ/UCNBLpLcn+GeA20ca0L4Ib2gN+wz4
	hkkO04oGdL2SZV2QGl+xfAQIhZZC0cI0O+xwSVw==
X-Received: by 2002:a17:90b:33c2:b0:38f:bbc:6a0f with SMTP id 98e67ed59e1d1-3933bd0c033mr27387876a91.1.1787029388448;
        Mon, 17 Aug 2026 22:03:08 -0700 (PDT)
X-Received: by 2002:a17:90b:33c2:b0:38f:bbc:6a0f with SMTP id 98e67ed59e1d1-3933bd0c033mr27387773a91.1.1787029387719;
        Mon, 17 Aug 2026 22:03:07 -0700 (PDT)
Received: from [10.217.238.175] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3954d3b4383sm4518837a91.15.2026.08.17.22.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 22:03:07 -0700 (PDT)
Message-ID: <ca9c56cb-4714-4f80-b993-0c990091ee1a@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 10:32:51 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: qrtr: Send HELLO message on endpoint register
To: Jakub Kicinski <kuba@kernel.org>
Cc: mani@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, horms@kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        christopher.lew@oss.qualcomm.com, deepak.singh@oss.qualcomm.com
References: <20260807-qrtr-hello-on-ep-register-v2-1-a7f265a42f7e@oss.qualcomm.com>
 <20260813013213.2315080-1-kuba@kernel.org>
Content-Language: en-US
From: Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>
In-Reply-To: <20260813013213.2315080-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: MwfJ9zyUcj-pIjA24NF1xRjWQySXP9Wl
X-Authority-Analysis: v=2.4 cv=Gs5yPE1C c=1 sm=1 tr=0 ts=6a83e78d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=aNK4TDJwnBqDbeh6N-8A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: MwfJ9zyUcj-pIjA24NF1xRjWQySXP9Wl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAzNSBTYWx0ZWRfX5cr5p98vhwti
 dTxSdLledsoDMBOMhqNutRbscsZDGMnWlQLSmaWDSP1MIaANfefCdmhj8NjzPrsv8wAJZbSuTxx
 m6Y+ocQPAfZoo6hvRQ5yfd+kSHrEDUjEy1V4m17HBWe1gRx8VimZXWXjJi/Njklq8+IM47XkYKH
 RtbZadZB2CNaiTo9vBVvF6RXUJs7pAPCN93Xh11ZQA2XUzlTrrVqYtURh6r/HsgPDcHCWoo2Mx7
 3IQ2/a7f02jYrQZhjs/QQT5TNXO4bbfg9Cr3Qd3vf0HlfSQWBrbKCuGkkQYleb1+9YAPbxNY/a7
 tVqI5PCtOAo/yLEVQpoLhS+pzZswBSjrVqxm7nB1FoOdkIg3h6pK2QBCX8AZ/iYSo1UyGIOOgzK
 HKKYEMJ+L+dVd4Fx+tRmYUws5eM80O/i1UzXAiQ+21TJBoM0rrPb2jgPQ36SllgOvOzzv/EljfR
 R4lsUxOD/BApu4IVygw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAzNSBTYWx0ZWRfX/A2QhB2UXzkm
 rTo5MD7riLW8V+/g8c5Py3ziwlLOs1rmz5QehMxaknDyb+f2n0cDCPsspy5RNr+x6ixZp3Hwka2
 vQEr8WmG2RAN3ST+WSEMh+oAHUWmRjc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180035

On 8/13/2026 7:02 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: qrtr: Send HELLO message on endpoint register
>
> This moves ownership of the QRTR HELLO handshake from the name server into
> the core layer by scheduling a work item at endpoint registration time.
> Non-HELLO packets are dropped until a HELLO has been transmitted, tracked by
> a new node->hello_sent flag under ep_lock, and the name server no longer
> sends a HELLO in reply to an inbound one.
>
> Link: https://lore.kernel.org/r/20260731-qrtr-hello-on-ep-register-v1-1-ddee5b1bfaec@oss.qualcomm.com
>
>> diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
>> index d02ef9a74c3c..7adc0a053125 100644
>> --- a/net/qrtr/af_qrtr.c
>> +++ b/net/qrtr/af_qrtr.c
> [ ... ]
>
>> @@ -341,6 +349,14 @@ static int qrtr_node_enqueue(struct qrtr_node *node, struct sk_buff *skb,
>>   	size_t len = skb->len;
>>   	int rc, confirm_rx;
>>   
>> +	mutex_lock(&node->ep_lock);
>> +	if (!node->hello_sent && type != QRTR_TYPE_HELLO) {
>> +		mutex_unlock(&node->ep_lock);
>> +		kfree_skb(skb);
>> +		return 0;
>> +	}
>> +	mutex_unlock(&node->ep_lock);
>> +
> [Severity: High]
> Should this gate return 0 after freeing the skb?  A few lines further down in
> the same function, the semantically identical "peer is gone" case reports an
> error instead:
>
> 	mutex_lock(&node->ep_lock);
> 	rc = -ENODEV;
> 	if (node->ep)
> 		rc = node->ep->xmit(node->ep, skb);
> 	else
> 		kfree_skb(skb);
>
> qrtr_sendmsg() then translates the new 0 into a full-length success:
>
> 	rc = enqueue_fn(node, skb, type, &ipc->us, addr);
> 	if (rc >= 0)
> 		rc = len;
>
> so userspace is told the payload went out while the skb was discarded, with
> no way to retry.  Would -EAGAIN or -ENETDOWN be more honest here?

Agreed, this will return -EAGAIN in the next version.

>
> The ns.c senders are affected the same way.  They only distinguish negative
> errnos (-ENODEV versus other), so NEW_SERVER/DEL_SERVER/BYE/DEL_CLIENT and
> the announce_servers() reply to an inbound HELLO are all recorded as
> delivered and never retried or logged.
>
> The case that looks least recoverable is QRTR_TYPE_RESUME_TX.  Inbound data
> does not depend on our own HELLO having been sent, so this path can run
> while hello_sent is still false:
>
> qrtr_recvmsg() -> qrtr_send_resume_tx() -> qrtr_node_enqueue(..., QRTR_TYPE_RESUME_TX, ...)
>
> The RESUME_TX is dropped and ret is 0.  Since the peer only clears its
> flow->pending when it receives a RESUME_TX, and there is no timeout or
> retransmission, does its transmitter stall permanently once it hits
> QRTR_TX_FLOW_HIGH?
>
> Note also that this drop path skips the qrtr_tx_flow_failed() compensation
> that the other drop paths in this function perform.

We are not exempting RESUME_TX from the gate. Doing so would let a
non-HELLO packet reach the wire before our own HELLO, which is exactly
the invariant this patch establishes, and would violate the protocol.
It also would not buy any real recovery: qrtr_recvmsg() already
discards qrtr_send_resume_tx()'s return value unconditionally, so the
RESUME_TX is dropped by the caller either way. For a peer to have hit
its own flow-control watermark against us, enough DATA must already
have flowed that our HELLO has almost certainly completed already; the
residual window is the same "transport is stuck" case we are already
treating as a bug elsewhere, so we would rather not special-case it
here.

>
>>   	confirm_rx = qrtr_tx_wait(node, to->sq_node, to->sq_port, type);
>>   	if (confirm_rx < 0) {
>>   		kfree_skb(skb);
> [ ... ]
>
>> @@ -372,6 +388,8 @@ static int qrtr_node_enqueue(struct qrtr_node *node, struct sk_buff *skb,
>>   			rc = node->ep->xmit(node->ep, skb);
>>   		else
>>   			kfree_skb(skb);
>> +		if (!rc && type == QRTR_TYPE_HELLO)
>> +			node->hello_sent = true;
>>   		mutex_unlock(&node->ep_lock);
>>   	}
> [Severity: Medium]
> Is rc == 0 from ep->xmit() strong enough to latch hello_sent?
>
> For MHI, qcom_mhi_qrtr_send() returning 0 only means mhi_queue_skb() placed
> the skb in the UL transfer ring.  Actual consumption is reported later via
> qcom_mhi_qrtr_ul_callback()/mhi_result->transaction_status, and a channel
> reset discards still-queued ring elements.
>
> hello_sent has exactly one initialiser (qrtr_endpoint_register()) and this
> one setter, so there is no way to re-arm it.  net/qrtr/mhi.c resets and
> re-prepares the channels across suspend/resume without unregistering the
> endpoint:
>
> qcom_mhi_qrtr_pm_suspend_late()
> 	mhi_unprepare_from_transfer(mhi_dev);
>
> qcom_mhi_qrtr_pm_resume_early()
> 	mhi_prepare_for_transfer(mhi_dev);
> 	qcom_mhi_qrtr_queue_dl_buffers(mhi_dev);
>
> The qrtr_node therefore survives a full channel reset with hello_sent still
> true and say_hello never rescheduled.  Does the freshly re-armed channel
> then never see a HELLO, leaving the peer in the same wait-for-HELLO state
> this patch exists to break?

We are not adding ul_xfer_cb/transaction_status-based confirmation.
rc == 0 from ep->xmit() is already treated as delivery for every QRTR
packet type, not just HELLO; giving HELLO a stronger guarantee than
DATA/CTRL traffic on the same channel would introduce an inconsistency
rather than fix one, since the same exposure would remain for those
other types.

>
>>   	/* Need to ensure that a subsequent message carries the otherwise lost
>> @@ -379,6 +397,9 @@ static int qrtr_node_enqueue(struct qrtr_node *node, struct sk_buff *skb,
>>   	if (rc && confirm_rx)
>>   		qrtr_tx_flow_failed(node, to->sq_node, to->sq_port);
>>   
>> +	if (rc && type == QRTR_TYPE_HELLO)
>> +		schedule_work(&node->say_hello);
>> +
> [Severity: High]
> Can this become a tight self-requeuing loop?  qrtr_hello_work() is itself
> the caller of this enqueue, and there is no delayed_work, no retry counter
> and no backoff:
>
> qrtr_hello_work()
> 	alloc_skb(GFP_KERNEL)
> 	qrtr_node_enqueue(node, skb, QRTR_TYPE_HELLO, ...)
> 		mutex_lock(&node->ep_lock)
> 		node->ep->xmit() fails
> 		schedule_work(&node->say_hello)   /* same work, zero delay */
>
> Persistent failures look reachable:
>
> drivers/bus/mhi/host/main.c:mhi_queue() {
> 	...
> 	if (unlikely(MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)))
> 		return -EIO;
> 	...
> }
>
> so a crashed or wedged modem link gives -EIO forever.  qcom_smd_qrtr_send()
> propagates rpmsg_send() errors, skb_put_padto() can return -ENOMEM, and
> after qrtr_endpoint_unregister() sets node->ep = NULL the enqueue returns
> -ENODEV for as long as a node reference is outstanding.
>
> qrtr_tx_wait() returns 0 immediately for non-DATA types, so nothing in the
> loop rate limits it.  Does this spin a worker on system_percpu_wq and hammer
> the skb allocator until the transport recovers or the last node reference
> drops and __qrtr_node_release() runs cancel_work_sync()?

In the next version, say_hello becomes a delayed_work, and
the retry fires only when ep->xmit() returns -EAGAIN, with a 100 ms
backoff. In-tree transport's xmit path, -EAGAIN is the only failure
any of them returns that is transient and self-clearing; -EIO, -ENODEV,
-EINVAL and allocation failure are all terminal there and will no
longer be requeued.

>
>>   	return rc;
>>   }
>>   
> [ ... ]
>
>> @@ -570,6 +591,35 @@ static struct sk_buff *qrtr_alloc_ctrl_packet(struct qrtr_ctrl_pkt **pkt,
>>   	return skb;
>>   }
>>   
>> +static void qrtr_hello_work(struct work_struct *work)
>> +{
>> +	struct sockaddr_qrtr from = {AF_QIPCRTR, 0, QRTR_PORT_CTRL};
>> +	struct sockaddr_qrtr to = {AF_QIPCRTR, 0, QRTR_PORT_CTRL};
>> +	struct qrtr_ctrl_pkt *pkt;
>> +	struct qrtr_node *node;
>> +	struct qrtr_sock *ctrl;
>> +	struct sk_buff *skb;
>> +
>> +	node = container_of(work, struct qrtr_node, say_hello);
>> +
>> +	/* NS must be bound before we can send */
>> +	ctrl = qrtr_port_lookup(QRTR_PORT_CTRL);
>> +	if (!ctrl)
>> +		return;
>> +
>> +	skb = qrtr_alloc_ctrl_packet(&pkt, GFP_KERNEL);
>> +	if (!skb) {
>> +		qrtr_port_put(ctrl);
>> +		return;
>> +	}
>> +
> [Severity: High]
> Do these two early returns abandon the handshake for good?
>
> The changelog says the work item sends a HELLO "once the name server is
> bound, retrying on failure", but the only retry is the schedule_work() in
> the rc-failure branch of qrtr_node_enqueue().  Neither of these returns
> reaches it, and neither leaves a pending work item, timer or wakeup.
> node->hello_sent stays false, and nothing else in the tree sets it.
>
> For the allocation case the trigger is just a failed GFP_KERNEL alloc_skb()
> under memory pressure:
>
> qrtr_endpoint_register()
> 	schedule_work(&node->say_hello)
> 		qrtr_hello_work()
> 			qrtr_alloc_ctrl_packet(&pkt, GFP_KERNEL) == NULL
> 			return    /* no re-arm */
>
>  From then on, does the new gate in qrtr_node_enqueue() free every
> DATA/RESUME_TX/BYE/DEL_CLIENT/NEW_SERVER packet for that node for the rest
> of its lifetime, even though the transport probe reported success?
>
> The name-server broadcast HELLO cannot rescue it either, because the same
> patch makes qrtr_bcast_enqueue() skip nodes with nid == QRTR_EP_NID_AUTO,
> which is the state of every freshly registered in-tree endpoint (mhi, smd
> and tun all pass QRTR_EP_NID_AUTO).
>
> The comment "NS must be bound before we can send" describes a wait that
> does not seem to be implemented - there is no retry or wakeup when the CTRL
> port later appears.  In-tree this is unlikely to fire because qrtr_ns_init()
> binds QRTR_PORT_CTRL from qrtr_proto_init() before any transport can
> register, but the consequence is the same as the allocation failure.

In the next version, both early-return paths reschedule
themselves (with the same 100 ms backoff) instead of abandoning the
handshake, so neither a transient allocation failure nor the NS not
yet being bound leaves hello_sent stuck at false.

>
>> +	pkt->cmd = cpu_to_le32(QRTR_TYPE_HELLO);
>> +	from.sq_node = qrtr_local_nid;
>> +	to.sq_node = node->nid;
>> +	qrtr_node_enqueue(node, skb, QRTR_TYPE_HELLO, &from, &to);
>> +	qrtr_port_put(ctrl);
>> +}
>> +
> [ ... ]
>
>> @@ -605,6 +658,9 @@ int qrtr_endpoint_register(struct qrtr_endpoint *ep, unsigned int nid)
>>   	mutex_unlock(&qrtr_node_lock);
>>   	ep->node = node;
>>   
>> +	/* Initiate HELLO handshake from the core layer */
>> +	schedule_work(&node->say_hello);
>> +
> [Severity: Medium]
> Is it safe for registration itself to trigger a hardware transmit before the
> registering transport driver has finished bringing its channels up?
>
> net/qrtr/mhi.c probes in this order:
>
> qcom_mhi_qrtr_probe()
> 	mhi_prepare_for_transfer(mhi_dev);
> 	rc = qrtr_endpoint_register(&qdev->ep, QRTR_EP_NID_AUTO);
> 	if (rc)
> 		goto err_unprepare;
> 	rc = qcom_mhi_qrtr_queue_dl_buffers(mhi_dev);
>
> The work runs on system_percpu_wq and can execute on another CPU
> concurrently with the rest of the probe, so qrtr_hello_work() ->
> qrtr_node_enqueue() -> qcom_mhi_qrtr_send() -> mhi_queue_skb() can ring the
> UL doorbell while the DL ring still holds zero host-posted, device-writable
> buffers.
>
> Can the modem's HELLO/control reply be lost in that window?  With the name
> server no longer replying to an inbound HELLO and hello_sent latched on the
> UL enqueue, there does not appear to be a way to recover from a lost reply.
> If qcom_mhi_qrtr_queue_dl_buffers() then fails, the probe unwinds with
> qrtr_endpoint_unregister() and mhi_unprepare_from_transfer() after a HELLO
> has already been put on the wire.

The UL and DL channels are independent; an inbound reply arriving before
qcom_mhi_qrtr_queue_dl_buffers() populates the DL ring would be lost
regardless of packet type, and regardless of whether HELLO is sent
from the core layer or the previous NS-driven path. This is a
pre-existing window in qcom_mhi_qrtr_probe()'s ordering, not something
introduced by this patch.

>
>>   	return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(qrtr_endpoint_register);
>> @@ -879,6 +935,11 @@ static int qrtr_bcast_enqueue(struct qrtr_node *node, struct sk_buff *skb,
>>   
>>   	mutex_lock(&qrtr_node_lock);
>>   	list_for_each_entry(node, &qrtr_all_nodes, item) {
>> +		/* Skip nodes whose node ID is not yet known; they cannot
>> +		 * receive broadcast packets before the HELLO handshake.
>> +		 */
>> +		if (node->nid == QRTR_EP_NID_AUTO)
>> +			continue;
> [Severity: Low]
> The comment talks about the HELLO handshake, but the test is on node->nid
> rather than the new node->hello_sent flag.  The two are independent.
>
> node->nid only leaves QRTR_EP_NID_AUTO in qrtr_node_assign(), i.e. from a
> driver-supplied nid (mhi, smd and tun all pass QRTR_EP_NID_AUTO) or from the
> src_node of a received packet.  hello_sent is set after a successful HELLO
> xmit.
>
> So a node can have hello_sent == true with nid still QRTR_EP_NID_AUTO (we
> greeted it but it has not sent us anything yet) and be excluded from every
> broadcast (NEW_SERVER/DEL_SERVER/BYE/DEL_CLIENT and the ns.c HELLO)
> indefinitely, even though the handshake the comment refers to completed.
>
> Conversely, a node with a known nid but hello_sent == false passes this
> filter and is then dropped by the gate in qrtr_node_enqueue().  Could the
> comment be reworded to describe the nid condition it actually implements?
>
> [Severity: Low]
> Should this read of node->nid be annotated?  It is written under a
> spinlock:
>
> qrtr_node_assign() {
> 	spin_lock_irqsave(&qrtr_nodes_lock, flags);
> 	radix_tree_insert(&qrtr_nodes, nid, node);
> 	if (node->nid == QRTR_EP_NID_AUTO)
> 		node->nid = nid;
> 	spin_unlock_irqrestore(&qrtr_nodes_lock, flags);
> }
>
> but the new readers hold only qrtr_node_lock here, and no lock at all in
> qrtr_hello_work() ("to.sq_node = node->nid;"), so the lockset intersection
> for node->nid is empty.
>
> This turns a racy value into a control-flow decision: qrtr_endpoint_post()
> -> qrtr_node_assign() on another CPU can give the node a valid nid right
> after the check, and the broadcast is then silently skipped for that node
> with no retransmission.  qrtr_hello_work() may likewise build the HELLO with
> a stale QRTR_EP_NID_AUTO destination.  Taking qrtr_nodes_lock would not
> close the check/act window, so would a READ_ONCE() plus a note about the
> race be the intent here?

Agreed, both will be fixed in the next version. The comment will be
reworded to describe the check it actually performs (node ID
availability, needed to build the packet header) rather than implying
it tracks the HELLO handshake, which is the separate hello_sent flag.
The reads of node->nid in qrtr_bcast_enqueue() and qrtr_hello_work()
will be wrapped in READ_ONCE().

>
>>   		skbn = pskb_copy(skb, GFP_KERNEL);
>>   		if (!skbn)
>>   			break;
>> diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
>> index b3f9bbcf9ab9..14262623d2dd 100644
>> --- a/net/qrtr/ns.c
>> +++ b/net/qrtr/ns.c
> [ ... ]
>
>> @@ -349,15 +350,8 @@ static int say_hello(struct sockaddr_qrtr *dest)
>>   	return ret;
>>   }
>>   
>> -/* Announce the list of servers registered on the local node */
>>   static int ctrl_cmd_hello(struct sockaddr_qrtr *sq)
>>   {
>> -	int ret;
>> -
>> -	ret = say_hello(sq);
>> -	if (ret < 0)
>> -		return ret;
>> -
>>   	return announce_servers(sq);
>>   }
> [Severity: Medium]
> With this removal, is there anything left in the kernel that emits a HELLO
> in response to an inbound HELLO?  say_hello() now has qrtr_ns_init() as its
> only caller, and qrtr_endpoint_post() has no HELLO handling of its own - it
> just forwards control packets to the NS socket.
>
> The core layer sends exactly one HELLO per endpoint registration and latches
> node->hello_sent = true as soon as ep->xmit() returns 0.  If that single
> HELLO is accepted by the transport but not consumed by the remote QRTR
> stack, no further HELLO is generated, not even when the remote later sends
> its own.  Is that not the same stall class the patch sets out to fix?
>
> While hello_sent is still false, an inbound HELLO cannot bootstrap the link
> either, since the announce_servers() reply is discarded by the new gate in
> qrtr_node_enqueue().
>
> The changelog describes this hunk as pure de-duplication:
>
>      - Remove say_hello() from the name server's ctrl_cmd_hello() handler;
>        the core layer is now the sole sender of the outbound HELLO.
>
> Could it also mention that the reply-on-receive recovery behaviour is being
> removed?

The only source of the outbound HELLO is now the single schedule_delayed_work() call in
qrtr_endpoint_register(), retried solely on -EAGAIN from the transport.
Also, will update the change log.

Thanks,
Pranav

