Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4205761FCE
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 05:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788758413; cv=none; b=Nr614T2P6Djw/QGkXFVpRIkbKZvr/Z9/L4aKtbvnrbPYmGsCNKbos98F3a2HeLlsz6xDaQgZzsHJ/yztZX3MeuWUWufTscvh4V4OgzEP0WUBXAFZo6ZoDriU9cWa9P2aiOCRHzNhrQEiHD+IJn45cyPjLSE550aXN2nasPGdbAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788758413; c=relaxed/simple;
	bh=9e8zMNwKQPywcX20xHomI4Dt0Rmj69h/j8EkcNf7Wmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dUgSXaLn99zOkBLpqwBiBMocVz7sma4WE5pu2TcoEv9FdBN1ilrhmcXG0+Pan9snVtLQRA/eQecVEU/MeB7P1srmVXkqM8nE/S6YBHcBmq2W3GFaa4q08z0oaqyZBWwZk4/5++llTUEiMD3umqJs5T//1ipBbrRLG9BrOZ0VIs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JlKnGXAH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JlKnGXAH"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68741duS660612;
	Mon, 7 Sep 2026 05:20:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=y9TSp5
	OAribAFjFpi9/yQab9oGaC16fEU026VfmKlOs=; b=JlKnGXAHYnUbGGZXtgAjkc
	dG3fELyLaavENiQIbvOTbf5YIec9BRlMbl5g8bJz9Z3AegDcAJkainR4BzoYp4qs
	+e89ZQWxejlh68db8HSEYnhpRugqNtt0iS7J9aYCvEAsC9tSQEaLhORYBHQxC5Ov
	ve/6ureXkKuOoPVVyhPnfRvEWSHQvqBNVBAC5g0Xd1l78zvxCPDt02EaOVXD+QId
	lZzS2eNn2e1478aPhvrfd4hhuzKNSgxYHgolV+pX4kO/qI0U13P3WU12yNAwgEZ+
	dTN1dge3MCapcKTxt8DjbLEI3NsW8cLx3Aupp88A3k2CUbzFlSNFfcjyfSM7dhSw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbj7xkqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 05:20:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6875BFCe009332;
	Mon, 7 Sep 2026 05:20:03 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggwdq47sb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 05:20:03 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6875K3wb12124678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Sep 2026 05:20:03 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E0D358058;
	Mon,  7 Sep 2026 05:20:03 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4903C58059;
	Mon,  7 Sep 2026 05:20:01 +0000 (GMT)
Received: from [9.67.116.210] (unknown [9.67.116.210])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Sep 2026 05:20:01 +0000 (GMT)
Message-ID: <e7060ffa-df20-4e29-b0da-184f763cdf14@linux.ibm.com>
Date: Sun, 6 Sep 2026 22:20:00 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/10] ibmveth: do not assume mac header is set
 in ibmveth_start_xmit()
To: Eric Dumazet <edumazet@google.com>,
        "David S . Miller"
 <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260902003344.1931843-1-edumazet@google.com>
 <20260902003344.1931843-4-edumazet@google.com>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260902003344.1931843-4-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: hyHercNDXMZ4POvZzWFKiZ2l64BXGA63
X-Proofpoint-ORIG-GUID: 8IJbK8w02nLZcRskIyeiVUj05JOKewEE
X-Authority-Analysis: v=2.4 cv=RNCD2Yi+ c=1 sm=1 tr=0 ts=6a9e4985 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=Ce1zqaQdqSYPqaR0MvgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA1MSBTYWx0ZWRfX5feKiQPbQ95R
 YBnQRbGbe8QCQC/CvGrFrkYsEYFR0HWGYt7ghUmWGcCsSTBNH+mVrUJ8H3RWlGu3pbS2EJ5vSHO
 T6OTey820eFrkmkR8hVqVwEQxsTaA/I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA1MSBTYWx0ZWRfX2Gj+syHfVsH5
 ZUIwMTMTb47/6Oz36EHy2utZSfd5cLl567rRqT8uHrtfzbZbo2LmBrabBPAys/yRZ0RhO9GZuaF
 zuBiHSRKJyCEZ5vHVlYruDp7YD9FggYYQV5S/hhHGF2P4L9rxRJw3h+VGpek+5yuq4z+abZgZWP
 4As0B63LwDQxWNWgtvaUkhurqwTiSpmY1OjqAGju1txnVz41dNuIZuGgGgGB9dNUt6/n17MfcBG
 Eq9oVke66GRuBdgOzOAZyG0foN8DofpMHyIGCwzfuI1AjnO66Eww6SJjgmhSb+lWNPTfeOyQCvF
 JlZB7WENIhjYDBUw05ELoYyD1et/OQ5b5gNy47+K0Y9UPI5+JHhMk62EXKtiWNZ7wHOOk1kmiZU
 itUZUVFHw8yzSwSF147LswBMNoaV4DiCkXDNY/xvUutQWzuClx5Wd5gkhdoIlZoA/ht0oMhJyY6
 3V2lIthd0xspKjnEpBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070051


On 9/1/26 5:33 PM, Eric Dumazet wrote:
> We should not assume mac header is set in output path.
>
> Use skb_eth_hdr() instead of eth_hdr() to fix the issue.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   drivers/net/ethernet/ibm/ibmveth.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 73e051d26b9d8887cfed1c4168684ae199bd3108..88e8bdfbcd11293d2cc0a36ebea6dfffa50bcedd 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -1218,7 +1218,7 @@ static int ibmveth_is_packet_unsupported(struct sk_buff *skb,
>   	struct ethhdr *ether_header;
>   	int ret = 0;
>   
> -	ether_header = eth_hdr(skb);
> +	ether_header = skb_eth_hdr(skb);
>   
>   	if (ether_addr_equal(ether_header->h_dest, netdev->dev_addr)) {
>   		netdev_dbg(netdev, "veth doesn't support loopback packets, dropping packet.\n");
Correct. mac_header is not guaranteed to be set on entry to
ndo_start_xmit; skb->data is the stable anchor in the TX path.

The RX poll path already reads the IP header check through skb->data
after eth_type_trans(), so no parallel fix is needed there.

ibmvnic has a similar issue in its TX path: build_hdr_descs_arr(),
called from ibmvnic_xmit(), passes skb_mac_header(skb) to
create_hdr_descs(). Is that covered in a later batch, or shall I
send a fix?

Reviewed-by: Mingming Cao <mmc@linux.ibm.com>
