Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAE64562BA
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 23:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785540329; cv=none; b=NeuUfPTbsamGVonLLgyH5naMLyNK9znYvAOxerRtCAKNkgFlAmPQS/qJaEyZEFMr6wF2+wj2ft8n8ptvEK/9vqeD3/31GPzLFCt0SeWk2esT8xQ+MsrBt8d147hncB8XTjG0otClDvAKx/sKcNs44VvD9gTHfmsuPFdMhlwOOuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785540329; c=relaxed/simple;
	bh=sfPRiBtyHFMBTeeNxOWUQo9luUB+U1Jina3Imhlh0Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8Fbel7IrSZlVNrOeyoz3dnvjXvoiXh5P7tke7ifXmjSLiVo9j9YMKwE/HetPtGkLyRWwo5uJSz7StRy5H4I7WzJAl2czxJd+uSPpMekvlpoHX+0tSHkWGNiUugNB8E9aZ1uMwG/msuMVl4xsj29zSNmD0Xk3GWHj/3xBaQcXdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EmBNT3wF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hfkupkmx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EmBNT3wF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hfkupkmx"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VM0HlF1090573
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 23:25:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=L3P6WaXsgAY6gWBzoSO5hWBP
	20Fu7HbsfL4AwofoV5A=; b=EmBNT3wFITF0WNesExgrcaS6ZmHA4ntXk82Jr4y5
	MCXcqBRS5uTQ41DSgPRJCYepLey6XY0ONY6kLyp9O8QHABVxlByJ0ywEvxXD0aTk
	Qkvnm/9O9SsV6OmPtmGhSVkFikRCp4mvdX0cBz1WiLKwcVUMG6DE+wI8tk3NP18Z
	pNB+YPfYsgN0RsOQvhQj2PVQUL+NsR2q5U43NNJ6nenPt3ldIndvJqUHEiPR6ci0
	QxXFSyZADcO8AUw/5xnOngyQISDE45+3vAcNqAyaBac8A5KlmniBWJ6G24ZUrgKU
	TN6+SXwwQRksdR0d8+L3f+zXWWT6fmUuY1sx+yOYrgjiXA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru5djxhb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 23:25:25 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ce7dff6253so20626685ad.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 16:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785540325; x=1786145125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L3P6WaXsgAY6gWBzoSO5hWBP20Fu7HbsfL4AwofoV5A=;
        b=Hfkupkmx0z6AqkI/KHb5IPJce0kXU0+VYjOS/eK0Pxla72VGVpwTb5uKyUv/trSPM3
         eSDvdFaCdSRaPbayT58RKuvvBfSql3UYBY7NLPwY5xPTRLF+LfF7XZjNpHe2cWVsq25n
         LyPtZDXvjtQXw/PV1lF3qhEy3MyHLt9aKSEHE3yVzgp9H22j0FinNvs4RzWQwSAm1qaU
         w20lq4mKvweniruckfS3eQBaIr2w/oO4So/0NMgWJYssx+0ricw1z22tKYLADAsATBfD
         2yPCguYZ9JcQl3VyMsF2qEnsjxkYYT3kWcFOOocBGV9zHEvaitR6NCqMFrbGx2AiT5gc
         lfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785540325; x=1786145125;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L3P6WaXsgAY6gWBzoSO5hWBP20Fu7HbsfL4AwofoV5A=;
        b=qj6xbWSExHryl9eoM8jIO8zf0q0xuwxXSFqjt2OyfKkunr3ZS4KK5973hwT9zXvu3N
         1Fw9etpYqQF5Ag0vxNS+Pd9SfMX4j1Ub8ZYTK53zWBVzmSR8DosKVVSzAxjau4rv738o
         A+zsA+KROROX89xCpRchvLjiabPt4/UDBDZ+Drv2k2tNiZJ/kDa1FPgfczo74gQxhXKA
         g++kc0fKb3noCCCu9eQQO+bg6669D81a89lRwkOsPobRuxYiBlv21FpvZdRYkAUY4YZC
         aittAmeLoLNRh5Qll3GCN6UJj3Ucz2/fMwQrj8rDCyOV7e1/vycID/+x7mytbbQswluo
         +D2g==
X-Forwarded-Encrypted: i=1; AHgh+Rra6Z6glDJDAEUOPQVlm1N6n71gPTEJ8A5uCztpteDhSqIhlVKelBQtQnQbfQoZ9GuNCOU18n4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7QOnvsx3b36pE7C8apFZ4hyD7E2O5pN/AEFnfddmwB6D89WAq
	7kNrCpmYWG+FS3yfM271d4cn4Y3OSBzWFuB+vTzDCCrgCtbExfyskCJVmzHLFTrP3XcBcB3WNza
	6aL0WcvkgIg4a04rBd/XNNMiVVQ0d/WKwF+ST6rFQukMrDlrgq9KHPA2Hxpk=
X-Gm-Gg: AR+sD10Xz9BlcFgDNS9gVKrTWCUnhmikO8JLQ9BXfKZcwnMuerthYAdhY+ZV3bQppHs
	C9LW2/YUS6VNRDKTzvUO89bvYoIDeEilgIbqwmidK6DtliK1iZsXwGjbpW2vzGXUfbxsPmuA8dy
	sT5JWyKABxY4Ur5XppfLogZ/2EXoNrt5IaJecmhxuGZaCn+bXxarFMi+NMp92Q1j8zZE4aRlhRY
	a4yxvwEJC2ELTPcAR+31G53eaHW4yM1uIwrhbB4qZNrYWZtvEnP7G7PT0NgmJzze/Hf1mjfRlTV
	w5twac+bzR78SF1cFYdMjURznqXvpWM1bNNtzTWKcZizAOsONBmrFmcZH/y8Xm/3xAROdTDFr8V
	oLOlqO6kzRlF6P6uxA1fcjaq2PDCvkZ+KDcp/yIw=
X-Received: by 2002:a17:902:f64c:b0:2ca:f417:396b with SMTP id d9443c01a7336-2d047d1ea9bmr33082165ad.3.1785540324720;
        Fri, 31 Jul 2026 16:25:24 -0700 (PDT)
X-Received: by 2002:a17:902:f64c:b0:2ca:f417:396b with SMTP id d9443c01a7336-2d047d1ea9bmr33081915ad.3.1785540324249;
        Fri, 31 Jul 2026 16:25:24 -0700 (PDT)
Received: from 058f6326d650 (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e06f0f9sm9472688eec.23.2026.07.31.16.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 16:25:23 -0700 (PDT)
Date: Fri, 31 Jul 2026 23:25:22 +0000
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
To: Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, chris.lew@oss.qualcomm.com,
        Chris Lew <christopher.lew@oss.qualcomm.com>,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Subject: Re: [PATCH] net: qrtr: Send HELLO message on endpoint register
Message-ID: <am0u4vGpLnQK4Yjx@058f6326d650>
References: <20260731-qrtr-hello-on-ep-register-v1-1-ddee5b1bfaec@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731-qrtr-hello-on-ep-register-v1-1-ddee5b1bfaec@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: zOMDO5GpuAGnVrWdWRSyczlgba6rAW6P
X-Proofpoint-GUID: zOMDO5GpuAGnVrWdWRSyczlgba6rAW6P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDE3NCBTYWx0ZWRfX/GjRt/nRRHpF
 ylvfL8nYcLb8O882/pQ9AoZZDVUL0jFda2jUjejRtfcMtOQik8NhON+TuTZMb4FryJ7kKxnzQlx
 3+4rtjxMAA1GhMwsHR7Up3e7GU/OnDK+QiF4DeXo1SsmJTrMdUeFDsjCE9BVFBiXk4842gL9oxa
 f3jjsyU3UWI1agstC1Tm3h/cqJCmbQpaPWouNxicLyW0+s+NTNRzaJ513h7UkFRnM35rhq5Mb46
 99eYEgJyi7KmlfwhlWbk5r6irATMTGMlSMZMVijlwZ6pdPX/BsFDUaNLUiZusvWPARSSf8orBRr
 kn9E3pWHKl2sFLT3vvqRgtmTr5Oi34MVpdmtzeKhAjRJ9Ws+1JJBr5wxCl8lyoOKkMqmw6Oamxb
 Aoi+QJRv0hjIPlvZ+0urgNQfsy2RwgQ0F5BGmGfBxz0xIYwhXysbh/TuCBvXL4qkd/6vIOJcIRA
 7DOyW+uTF4OdvYoSTgg==
X-Authority-Analysis: v=2.4 cv=SKZykuvH c=1 sm=1 tr=0 ts=6a6d2ee5 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8
 a=20KFwNOVAAAA:8 a=IXX6xhmyHek7Xcd_kM8A:9 a=CjuIK1q_8ugA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDE3NCBTYWx0ZWRfX/lLfEDh7Qrc8
 K4pXD22Ur4+veDr72uuOp7eDKvXVE8lGahYHqQ6o67rv3zueh5q4HWEvCGiXL/XX5TYG2J5MmTB
 QlJEq2tE7wZ80Os1oMLaS9qkQsvNELU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310174

On Fri, Jul 31, 2026 at 03:47:29PM +0530, Pranav Mahesh Phansalkar wrote:
> From: Chris Lew <christopher.lew@oss.qualcomm.com>
> 
> Hello message is currently sent only by the name server in response to
> a hello message received from a remote. When two endpoints operate in a
> slave model, neither sends the initial hello, stalling further
> communication.
> 
> Transfer ownership of the HELLO handshake to the core layer. On
> endpoint registration, schedule a work item that sends a HELLO packet
> to the new endpoint once the name server is bound. An atomic hello_sent
> flag prevents the name server from sending duplicate HELLOs once the
> core has successfully sent one. If the initial send fails, the work is
> rescheduled to retry.

Why would something queue more than a single HELLO?

If I read the code correctly, qrtr_endpoint_register() will schedule the
sending of a HELLO and then as we receive the first incoming HELLO we
forward that to the `ns` which will try to send another HELLO, which we
per our flags silently discard.

But why not throw out say_hello()?

Then qrtr_endpoint_register() would schedule the HELLO and
qrtr_node_enqueue() can reschedule the say_hello work for every HELLO
send that fails - no state left.

> 
> Prevent duplicate HELLO packets from reaching the name server by
> tracking received HELLOs with a hello_rcvd flag. Without this, each
> duplicate HELLO would trigger announce_servers() in the NS, causing
> unnecessary re-advertisement of all locally registered services to the
> remote and redundant lookup notifications to observing clients.
> 

Why sweep the problem under the rug? If the peer is misbehaving and send
multiple HELLO messages, wouldn't it be useful to put something in the
log?

If the concern is that ns will call announce_servers() multiple times,
wouldn't the right place to solve that be in the NS?

> Co-developed-by: Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>
> Signed-off-by: Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>
> Co-developed-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
> Signed-off-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
> Signed-off-by: Chris Lew <christopher.lew@oss.qualcomm.com>

This isn't right, Pranav. You're the sender of this email your name
should be last here, because you handled the patch last.

> ---
> To: Manivannan Sadhasivam <mani@kernel.org>
> To: David S. Miller <davem@davemloft.net>
> To: Eric Dumazet <edumazet@google.com>
> To: Jakub Kicinski <kuba@kernel.org>
> To: Paolo Abeni <pabeni@redhat.com>
> To: Simon Horman <horms@kernel.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Not sure what you did to b4, but this looks wrong.

> ---
>  net/qrtr/af_qrtr.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 78 insertions(+), 1 deletion(-)
> 
> diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
> index d02ef9a74c3ca..03234bd1fe54f 100644
> --- a/net/qrtr/af_qrtr.c
> +++ b/net/qrtr/af_qrtr.c
> @@ -9,6 +9,7 @@
>  #include <linux/termios.h>	/* For TIOCINQ/OUTQ */
>  #include <linux/spinlock.h>
>  #include <linux/wait.h>
> +#include <linux/workqueue.h>
>  
>  #include <net/sock.h>
>  
> @@ -120,8 +121,11 @@ static DEFINE_XARRAY_ALLOC(qrtr_ports);
>   * @nid: node id
>   * @qrtr_tx_flow: xarray of qrtr_tx_flow, keyed by node << 32 | port
>   * @qrtr_tx_lock: lock for qrtr_tx_flow inserts
> + * @hello_sent: hello packet sent to endpoint
> + * @hello_rcvd: hello packet received from endpoint
>   * @rx_queue: receive queue
>   * @item: list item for broadcast list
> + * @say_hello: scheduled work for initiating hello
>   */
>  struct qrtr_node {
>  	struct mutex ep_lock;
> @@ -132,8 +136,12 @@ struct qrtr_node {
>  	struct xarray qrtr_tx_flow;
>  	struct mutex qrtr_tx_lock; /* for qrtr_tx_flow */
>  
> +	atomic_t hello_sent;
> +	atomic_t hello_rcvd;
> +
>  	struct sk_buff_head rx_queue;
>  	struct list_head item;
> +	struct work_struct say_hello;
>  };
>  
>  /**
> @@ -187,6 +195,8 @@ static void __qrtr_node_release(struct kref *kref)
>  	list_del(&node->item);
>  	mutex_unlock(&qrtr_node_lock);
>  
> +	cancel_work_sync(&node->say_hello);
> +
>  	skb_queue_purge(&node->rx_queue);
>  
>  	/* Free tx flow counters */
> @@ -341,6 +351,12 @@ static int qrtr_node_enqueue(struct qrtr_node *node, struct sk_buff *skb,
>  	size_t len = skb->len;
>  	int rc, confirm_rx;
>  
> +	if (type == QRTR_TYPE_HELLO &&
> +	    atomic_cmpxchg(&node->hello_sent, 0, 1) != 0) {
> +		kfree_skb(skb);
> +		return 0;
> +	}
> +
>  	confirm_rx = qrtr_tx_wait(node, to->sq_node, to->sq_port, type);
>  	if (confirm_rx < 0) {
>  		kfree_skb(skb);
> @@ -379,6 +395,11 @@ static int qrtr_node_enqueue(struct qrtr_node *node, struct sk_buff *skb,
>  	if (rc && confirm_rx)
>  		qrtr_tx_flow_failed(node, to->sq_node, to->sq_port);
>  
> +	if (rc && type == QRTR_TYPE_HELLO) {
> +		atomic_set(&node->hello_sent, 0);
> +		schedule_work(&node->say_hello);
> +	}
> +
>  	return rc;
>  }
>  
> @@ -527,6 +548,13 @@ int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, size_t len)
>  		if (!ipc)
>  			goto err;
>  
> +		if (cb->type == QRTR_TYPE_HELLO &&
> +		    atomic_cmpxchg(&node->hello_rcvd, 0, 1) != 0) {
> +			qrtr_port_put(ipc);
> +			kfree_skb(skb);
> +			return 0;
> +		}
> +
>  		if (sock_queue_rcv_skb(&ipc->sk, skb)) {
>  			qrtr_port_put(ipc);
>  			goto err;
> @@ -570,6 +598,35 @@ static struct sk_buff *qrtr_alloc_ctrl_packet(struct qrtr_ctrl_pkt **pkt,
>  	return skb;
>  }
>  
> +static void qrtr_hello_work(struct work_struct *work)
> +{
> +	struct sockaddr_qrtr from = {AF_QIPCRTR, 0, QRTR_PORT_CTRL};
> +	struct sockaddr_qrtr to = {AF_QIPCRTR, 0, QRTR_PORT_CTRL};
> +	struct qrtr_ctrl_pkt *pkt;
> +	struct qrtr_node *node;
> +	struct qrtr_sock *ctrl;
> +	struct sk_buff *skb;
> +
> +	node = container_of(work, struct qrtr_node, say_hello);
> +
> +	/* NS must be bound before we can send */
> +	ctrl = qrtr_port_lookup(QRTR_PORT_CTRL);
> +	if (!ctrl)
> +		return;
> +
> +	skb = qrtr_alloc_ctrl_packet(&pkt, GFP_KERNEL);
> +	if (!skb) {
> +		qrtr_port_put(ctrl);
> +		return;
> +	}
> +
> +	pkt->cmd = cpu_to_le32(QRTR_TYPE_HELLO);
> +	from.sq_node = qrtr_local_nid;
> +	to.sq_node = node->nid;
> +	qrtr_node_enqueue(node, skb, QRTR_TYPE_HELLO, &from, &to);
> +	qrtr_port_put(ctrl);
> +}
> +
>  /**
>   * qrtr_endpoint_register() - register a new endpoint
>   * @ep: endpoint to register
> @@ -595,6 +652,10 @@ int qrtr_endpoint_register(struct qrtr_endpoint *ep, unsigned int nid)
>  	node->nid = QRTR_EP_NID_AUTO;
>  	node->ep = ep;
>  
> +	atomic_set(&node->hello_sent, 0);
> +	atomic_set(&node->hello_rcvd, 0);
> +	INIT_WORK(&node->say_hello, qrtr_hello_work);
> +
>  	xa_init(&node->qrtr_tx_flow);
>  	mutex_init(&node->qrtr_tx_lock);
>  
> @@ -605,6 +666,9 @@ int qrtr_endpoint_register(struct qrtr_endpoint *ep, unsigned int nid)
>  	mutex_unlock(&qrtr_node_lock);
>  	ep->node = node;
>  
> +	/* Initiate HELLO handshake from the core layer */
> +	schedule_work(&node->say_hello);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(qrtr_endpoint_register);
> @@ -796,8 +860,21 @@ static int __qrtr_bind(struct socket *sock,
>  	sock_reset_flag(sk, SOCK_ZAPPED);
>  
>  	/* Notify all open ports about the new controller */
> -	if (port == QRTR_PORT_CTRL)
> +	if (port == QRTR_PORT_CTRL) {
> +		struct qrtr_node *node;
> +
> +		/* Reset HELLO state on all nodes so the handshake can be
> +		 * re-established with the new NS instance.
> +		 */
> +		mutex_lock(&qrtr_node_lock);
> +		list_for_each_entry(node, &qrtr_all_nodes, item) {
> +			atomic_set(&node->hello_sent, 0);
> +			atomic_set(&node->hello_rcvd, 0);
> +		}
> +		mutex_unlock(&qrtr_node_lock);

This code existed to handle the case when the userspace qrtr-ns
restarted, but we will always register the in-kernel NS so that use case
doesn't exist anymore.

Do you really need to reset these things?

Regards,
Bjorn

> +
>  		qrtr_reset_ports();
> +	}
>  
>  	return 0;
>  }
> 
> ---
> base-commit: 502d801f0ab03e4f32f9a33d203154ce84887921
> change-id: 20260623-qrtr-hello-on-ep-register-7064b66ccd70
> 
> Best regards,
> -- 
> Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>
> 
