Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F11A4749F4
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 23:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785453490; cv=none; b=QCJ1DvghtEevrvZX5mvskSGV8qHdXnVFHO6wE4xSri/+EmOrF3jC3iIKzEMKPV3Rt+F8qSKixIrQTBX5xIBSZ6t4w17CitzTdL6CjvxX0telf2uOBOpdoQBVTBHOYMTbEUcKvErn87yf6A3CRBIUA54qit020o58TJVkIw42gSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785453490; c=relaxed/simple;
	bh=GvY9rZoHOiUCbKNFvWYXMjo3afjwi/WM8Y5LuZPREdY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=unBVeMVRQ7zS/Omg4cKrBcNDp8aHwkoZA2xHGj9oZBEtM4ZnqZFm+FePudoqq7GkyswWemOwrXbAkVXmvLbbrTOGJiytaXstjkq75DQ4H0MpkMAGDY6zy3pD8NhVXz7ConkTlYubfEHSXsGm3YpZzWfMRvH9eeodNYU11Fq+cOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XSrBuyt6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XSrBuyt6"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UNHdJJ2518090
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 23:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=z5mlX7S63bsfOaZjfyCDCtmpDkmO
	I8vi+fhEmS37zac=; b=XSrBuyt6O6Ugf1KaMsfBnTSWM8nXKIbQiDzsH9Cjudgh
	sXG93GDFka1tFaudAAkTNpQPALM9MQFHkFJC98+r/JnFn27GF8nWBAtmlqBdAfrZ
	l9gOumkxo24x+aYQlDQRNnO/z9yv3d7C7mduC+VCsCty349HJsREeVj8dhgrXcCe
	s35634Q8BAIbs1e510hhnxpmdbdcEHzSy9agchaPW5B0CuH8MNH40jI2GDdvzwPw
	qn25vI3cuEbd2ZnNgPEFcsbJS1yjwrOsw2spehD4V+CN5DozkORigqZ67cc9AUdX
	SCBCXG1OnGrh3MejisnuLg/cG6iPqpzix/HxVtQNMg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyct93j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 23:18:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UNBIri001006;
	Thu, 30 Jul 2026 23:18:03 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkdk5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 23:18:03 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UNI3W110093180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 23:18:03 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3944E58058;
	Thu, 30 Jul 2026 23:18:03 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B810B5805B;
	Thu, 30 Jul 2026 23:18:02 +0000 (GMT)
Received: from [9.61.247.54] (unknown [9.61.247.54])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 23:18:02 +0000 (GMT)
Message-ID: <2c6ddccb-0cf8-4aac-9e6d-243c051696c6@linux.ibm.com>
Date: Thu, 30 Jul 2026 16:18:02 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, zdai@linux.vnet.ibm.com
From: Pradeep Satyanarayana <pradeeps@linux.ibm.com>
Subject: [BUG] reason=TCP_ACK_UNSENT_DATA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 3vC15lBdxXymJMTgtUGjDsAUXc9dZgUc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE2NiBTYWx0ZWRfX3/OmZeo4EPxR
 iZQ1CamUXQrkwgrEaT+0LpE5EAObkmHIuV9n0/DFQ4zEmOWbooWUeAw7C+RDcBFelawOw/F55CW
 gv2fULi3C+pxo0EJQIt1symdnUYaDdG4PRbhSH9RO7P/BdK5vn3peiwK3HdyQoFZ+2Vqd6GfWUo
 JALEtQy7lXm5DbBRNkN1SDKADz8BSYxws2AV6SfyNQTJwK/c0TWJT6R2UcV4mO66hLjF6DAkLDQ
 YVqbe5IsWyOq2K34o/3KjbiLMU4EegdTAwSJxtDIUFpqgq/dY8JpdVcGanQYFr8zt+QKgRmUZrp
 IBSqVzh4iW5DvCEtKY4x4ipz11CZ3HcbsbynJYDtY4mNoWbYsI/77h/73W6gGi4ApHfpy9iAsSR
 vA+kkreohmeZklCzkWgvWecnqNIXE/8MNjSRTLXjpYeDy7FtIyMT9kqipEAwHYOLq3gOei2yYek
 t32yJv748uyNdSs6JoA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE2NiBTYWx0ZWRfXyELea6SxmZOD
 2LthPe1wDP2ASl6G6Aa2oKvosYr9frT5JjzjqBa/zQeX0zOIxdjLdy3uR33I1UCNwZJ0VpWR7Hz
 BDBpvVz7nE38EPKsgPDh6ZDllvmWUPI=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6bdbad cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=7V9UEB20Uande5cxrgQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: nm61VZ65dVIdO1pbpGWGe3_Dy3w_zsOz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300166

For one particular workload, under load TCP streams grind to a halt, 
throughput falls to zero and never recovers.

On Power 11 systems, two asymmetric interfaces are bonded in an 
Active-Backup configuration. The primary interface is used with IPsec 
offload. The secondary interface only does software encryption (using 
aes_gcm_p10_crypto).

We are using iperf for the tests, and when we fail-over to the backup 
interface, all the iperf threads grind to a halt.

Once we are in this state, on the iperf client, the Send-Q is full. The 
iperf server is sending ACKs, but it appears that TCP (on the iperf 
client) is dropping them. Here is an example:

probe__tcp_rcv_established_L179    12 21012.316236112    19162 
kworker/12:2         __probe_ip=0xc0000000011b39f0, snd_una=0x535b271, 
snd_nxt=0x535b7f7, ack_seq=0x536420d, write_seq=0x57526df
         [c0000000011b39f0] tcp_rcv_established+0x3d0 ([kernel.kallsyms])
         [c0000000011b39f0] tcp_rcv_established+0x3d0 ([kernel.kallsyms])
         [c0000000011ca69c] tcp_v4_do_rcv+0x1ec ([kernel.kallsyms])
         [c0000000011cc9f0] tcp_v4_rcv+0xc30 ([kernel.kallsyms])
         [c000000001180ef0] ip_protocol_deliver_rcu+0x60 ([kernel.kallsyms])
         [c0000000011811d4] ip_local_deliver_finish+0xb4 ([kernel.kallsyms])
         [c000000001181338] ip_local_deliver+0x88 ([kernel.kallsyms])
         [c0000000011809d8] ip_sublist_rcv_finish+0x98 ([kernel.kallsyms])
         [c000000001180c0c] ip_sublist_rcv+0x1fc ([kernel.kallsyms])
         [c00000000118170c] ip_list_rcv+0x16c ([kernel.kallsyms])
         [c000000001068164] __netif_receive_skb_list_core+0x244 
([kernel.kallsyms])
         [c000000001068a88] netif_receive_skb_list_internal+0x248 
([kernel.kallsyms])
         [c000000001068eac] napi_complete_done+0x9c ([kernel.kallsyms])
         [c0000000010f940c] gro_cell_poll+0xcc ([kernel.kallsyms])
         [c0000000010690e0] __napi_poll+0x60 ([kernel.kallsyms])
         [c00000000106974c] net_rx_action+0x39c ([kernel.kallsyms])
         [c000000000241b68] handle_softirqs+0x158 ([kernel.kallsyms])
         [c000000000018998] do_softirq_own_stack+0x38 ([kernel.kallsyms])
         [c000000000242958] do_softirq+0x78 ([kernel.kallsyms])
         [c000000000242a44] __local_bh_enable_ip+0xc4 ([kernel.kallsyms])
         [c00800000a1c0bd0]
         [c00800000a1c07f4]
         [c000000000268a14] process_one_work+0x1e4 ([kernel.kallsyms])
         [c0000000002697ec] worker_thread+0x1ec ([kernel.kallsyms])
         [c0000000002762c4] kthread+0x194 ([kernel.kallsyms])
         [c00000000000ded8] start_kernel_thread+0x14 ([kernel.kallsyms])

skb__kfree_skb          12 21012.316237054    19162 kworker/12:2 
skbaddr=13835058059510742784, location=13835058055300675500, 
rx_sk=13835058058125504512, protocol=2048, reason=TCP_ACK_UNSENT_DATA
         [c0000000010d9924] __traceiter_kfree_skb+0x74 ([kernel.kallsyms])
         [0]
         [c0000000010372f4] sk_skb_reason_drop+0xf4 ([kernel.kallsyms])
         [c0000000011a77ac] tcp_drop_reason+0x6c ([kernel.kallsyms])
         [c0000000011ca69c] tcp_v4_do_rcv+0x1ec ([kernel.kallsyms])
         [c0000000011cc9f0] tcp_v4_rcv+0xc30 ([kernel.kallsyms])
         [c000000001180ef0] ip_protocol_deliver_rcu+0x60 ([kernel.kallsyms])
         [c0000000011811d4] ip_local_deliver_finish+0xb4 ([kernel.kallsyms])
         [c000000001181338] ip_local_deliver+0x88 ([kernel.kallsyms])
         [c0000000011809d8] ip_sublist_rcv_finish+0x98 ([kernel.kallsyms])
         [c000000001180c0c] ip_sublist_rcv+0x1fc ([kernel.kallsyms])
         [c00000000118170c] ip_list_rcv+0x16c ([kernel.kallsyms])
         [c000000001068164] __netif_receive_skb_list_core+0x244 
([kernel.kallsyms])
         [c000000001068a88] netif_receive_skb_list_internal+0x248 
([kernel.kallsyms])
         [c000000001068eac] napi_complete_done+0x9c ([kernel.kallsyms])
         [c0000000010f940c] gro_cell_poll+0xcc ([kernel.kallsyms])
         [c0000000010690e0] __napi_poll+0x60 ([kernel.kallsyms])
         [c00000000106974c] net_rx_action+0x39c ([kernel.kallsyms])
         [c000000000241b68] handle_softirqs+0x158 ([kernel.kallsyms])
         [c000000000018998] do_softirq_own_stack+0x38 ([kernel.kallsyms])
         [c000000000242958] do_softirq+0x78 ([kernel.kallsyms])
         [c000000000242a44] __local_bh_enable_ip+0xc4 ([kernel.kallsyms])
         [c00800000a1c0bd0]
         [c00800000a1c07f4]
         [c000000000268a14] process_one_work+0x1e4 ([kernel.kallsyms])
         [c0000000002697ec] worker_thread+0x1ec ([kernel.kallsyms])
         [c0000000002762c4] kthread+0x194 ([kernel.kallsyms])
         [c00000000000ded8] start_kernel_thread+0x14 ([kernel.kallsyms])

This has been recreated with kernel 7.2-rc5. This kernel does have the 
patch in:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=0c9de092ef8c50a7ee9612811566f0aa81d8d7b6

We tried turning off TSO as an experiment, but that didn't help.

This is quite easy to recreate (on Power 11), but it does appear that we 
do need specific combinations like a 100G crypto offload on the primary, 
and aes_gcm_p10_crypto for software encryption on the backup device. We 
require moderate to heavy traffic in both directions.

Bonding two interfaces, both using aes_gcm_p10_crypto and failing over 
between them doesn't recreate the problem.

Pradeep


