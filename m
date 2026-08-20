Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79853D34B9
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 20:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787258392; cv=none; b=FjHJo53RhjDqh7H/rN7kdCzSQOa/OtsgJ1tygF1J2zk11/ECbmD5JitkXvuDmYNRU+8VraqXM5pbWNbsu7m2ahcCDDnWa6rCCoDfqWCTte0+CjHYmFp+eFsK1GvL2iOxp4WCoxjH4Q+Nwn6ftMKGcxkktVY2eP7vfOOiaNQmyeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787258392; c=relaxed/simple;
	bh=Rb18xzWjlOOOgIhse612OQG7MBiuJfJE5eJb/fa4E5I=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=u/bSJV68Z6ZLniaG+oa40ysigLm7PMU38i52xypXTQx84JAoBLZat6aZnHSFlZOOFxD9XpYbEOTkEeamn6MoW5uO3sEmXTVSaPlzR/c77Qj4SoFLkmEAB6qceHbmJBiAX47GvI/k3Jh9tk498tC1VGXvW64y0T4UddC/Nna+Whg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ANCMn34V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VaWGpXwO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ANCMn34V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VaWGpXwO"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KK7Ylg807251
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 20:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5CEjK1VNjS9j+Z+z5sRpQphYXVIWMmGeAXdPW2pRJcA=; b=ANCMn34VUQz1o3Nk
	QqUdSivLQFp/5FQrGlfO8GGphnvAU7l4ThgX9GdB5yqQQYxsZ7NvfaVqd0zkz04A
	myikX1fGEQHTLA9xxezMio51ulQZyEAxKpgyMsWOkGk0qvQiavgfdEq4rYlalsZ8
	jaXQdHAxcPlA2WqKxPQMkQAZFgiV3Ia07LDZssS2I/R9HOwuN9yn1ex53nhks/wV
	/W41t6DnGA8ggcoC7TXvcTkBJhAmZa79GgJEyMJkEPj8LTiBFWn4nUFV8HEzhvuP
	oFGnTx/5BTKWwXcn4WK05Cc5RwRAj50wmX9numOV7ieZzohEFBjKSrDsqzS0FAcu
	9PBpwA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xgcb5rt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 20:39:49 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbb92868263so209340a12.2
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 13:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787258389; x=1787863189; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5CEjK1VNjS9j+Z+z5sRpQphYXVIWMmGeAXdPW2pRJcA=;
        b=VaWGpXwOx4gyAlfpL7ZmiL+APnav5R4LsGDOYhw+1TOhE+QFUlx6ClsZAGvBVCqa+x
         spGjRbdDVLksTbtjqtdRGVjuLjFgpOEiQkzIZOmMGyVvcnRLZCq341I/pPSfRHZR6Big
         ByDHK6dih6KqdCWCUKVel/u3Y9l3plNzPPcyx5UTwKe7CiqDyEjqZjJTeMc250G5vdem
         wXpeiX+hixvDIQsdf3U/9oHsAJ9CcfKTmEfOpluA71l7D+APXLIUBxvVBTs/BZ1XimgJ
         KivFxuGyHXJzi8EFn7HrEWR2DcTf11pqIomkwYBtiWbqfaIgXETYLss52GgoIam8irt/
         J4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787258389; x=1787863189;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5CEjK1VNjS9j+Z+z5sRpQphYXVIWMmGeAXdPW2pRJcA=;
        b=rU/D3lI35RIs5MJEZxYyw70p4scZfb3zM3kOV6KnLnXwZ0wO9tW/PEpQtDOjuusdQo
         728vNPMCcgDRKvL6myW0zo3e6F8BEyb5/uas8jQ7roniALkTEyDPbLmE2RD9R+WSQRIq
         5yVITIzNh8VUOegN3HW2PI8YZEd64GNT1tD9zRd2djJiqaPfMfVihiiDR4Z5p7y7rN9y
         Y0UHAZX8ZAIWHnh/IoyCpyT58j758u5hNV/p1sAjkq4gcTj+YrmNbICqSVPTRbwd5sjb
         HfAfdgYiVkhtc9ymlANpc2GBDUDUmZ/lvIwFu1BVytFboJuNb/gyshmmWqjbnha/aGgN
         MlaQ==
X-Gm-Message-State: AFuF++nDcysg3sWEBlgkpkx6VwpQ5Jx1bdGzUcC9JD0UD0m18ggYkHj+
	a4xJtQcrgaBoS/e9fnpW2Lo3qFaJrVDQIZam7WJ3YfZJ1E0FA1iur1MWsbWOF5pkMEC3lbfCRoj
	vwSviIXVUvEuysMOl/aSrLbH5AwMM38xAK4m3c4JSdalJHcGYvKIBN7jlYjI=
X-Gm-Gg: AR+sD10113ifad126ivENB7OTL6H3jTJ4n4YXE9jLazZGRKigwoOBRrQbFduZMLtRcG
	LrdPb2kyTwFO8WOlxDMFfgs1++zC3braD7qokEzsAYrxS2s88uZ5kBTsaX+FOZxrTVOZte7jp83
	oAS6etJ+nB5kObbiCmfaT3Zu8SM+DXLhl0ivUsZOUWXgpSMyOpoiIWh+c/vkzugBvlPfAOZZt2u
	NwWy6Bx00z0Hp9RGL++BivVKTB2HYoj+9D+UtlpeeBxtG3ZCFWBtedJgXePHm9TLv3+puEAf3Aq
	LZ0LrhQySt/wJafDFFlNZBrd7rj681q5bQFzYsDNdMRqDOfB5fy7KlLaDHcz1q0q+g47+il+AJq
	CFS2/XozaEIHChvm2U+GcVaCfd4b82xDSgGPxNqfEQFt84u8MdpgDNiWtaPP8hREOTYMc5tj/
X-Received: by 2002:a17:90b:4a81:b0:37d:f206:a2ac with SMTP id 98e67ed59e1d1-395c33ec558mr1691468a91.7.1787258389083;
        Thu, 20 Aug 2026 13:39:49 -0700 (PDT)
X-Received: by 2002:a17:90b:4a81:b0:37d:f206:a2ac with SMTP id 98e67ed59e1d1-395c33ec558mr1691416a91.7.1787258388604;
        Thu, 20 Aug 2026 13:39:48 -0700 (PDT)
Received: from QCOMk1gASIiYhG (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327c2a92406sm18377342eec.11.2026.08.20.13.39.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2026 13:39:47 -0700 (PDT)
From: <subash.a.kasiviswanathan@oss.qualcomm.com>
To: "'Xiang Mei'" <xmei5@asu.edu>,
        "'Sean Tranchetti'" <sean.tranchetti@oss.qualcomm.com>,
        "'Andrew Lunn'" <andrew+netdev@lunn.ch>,
        "'David S . Miller'" <davem@davemloft.net>,
        "'Eric Dumazet'" <edumazet@google.com>,
        "'Jakub Kicinski'" <kuba@kernel.org>,
        "'Paolo Abeni'" <pabeni@redhat.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <co+4638111fe2a12980@bugs.sh>
References: <20260820195240.1631458-1-xmei5@asu.edu>
In-Reply-To: <20260820195240.1631458-1-xmei5@asu.edu>
Subject: RE: [PATCH net v2] net: qualcomm: rmnet: restore skb->dev on deaggregated frames
Date: Thu, 20 Aug 2026 14:39:46 -0600
Message-ID: <000301dd30e4$0a7f8930$1f7e9b90$@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIO3oryQB+vyxo4VGtK/IfgpcTLmbZEBuhg
Content-Language: en-us
X-Authority-Analysis: v=2.4 cv=GPM41ONK c=1 sm=1 tr=0 ts=6a876615 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8
 a=20KFwNOVAAAA:8 a=WrrW62F5h9peuD0pGDYA:9 a=CjuIK1q_8ugA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-ORIG-GUID: _Lld-uTsZ4zPvYwqlAxFzVD-dOp3A9Fa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE1NSBTYWx0ZWRfX7S9HWJUFG5ZY
 DJlfaE9BjTSTVk/I4KN+ls1zeyyGERXmyoKF/Nhk7O6LBkm8O4iB9flrDChD4Z4fWHNVA7WsBEc
 Wv/kQG8Jq0SMEKWxwQ02ObOcY3Pd6JgkL95WeW7yWH40cgAdXKJZdj0arrNmbgkYS7W0UNyKfVd
 PrEJ92EOOA5LCklRph3SzwB9plWce2rLDh9mkrhlXBiWmhUIKc+zjMMTrEsXYA55LhL+7oMo37o
 NqYcUlaJc1uyZa7o2FZCeV5b0aRa/+0EiwzsZS8E66xYyLJHitRCTqBsmFesXdI3VNFAvmTjgu+
 j/ZEs92G3NB3SX2sXns5vyMxrN6AuqVpY2cNG3B0i+XIZ6bR52ec7RA57ektOHZgAeR+jkkPf0d
 SaKEudA3oKxFpmx2r59stsP77TBhotZOx0JYQxXMTWAiqX3IFK8D1zcvVsJPQukUAY48tEk07IW
 +JcwANH9xJSqJgy/1xw==
X-Proofpoint-GUID: _Lld-uTsZ4zPvYwqlAxFzVD-dOp3A9Fa
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE1NSBTYWx0ZWRfXwtwkn/G+/X4K
 nHnjJRdmLiTNf0SuJbkoih+zZ1nF2dshB8mLirwBMiniOnwwqPAYDo05xxPNXOVPmY1NgqSwEMB
 E63mnjk9Mf1dTsG2ssIFJhn/gVTp4V0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200155

> -----Original Message-----
> From: Xiang Mei <xmei5@asu.edu>
> Sent: Thursday, August 20, 2026 1:53 PM
> To: Subash Abhinov Kasiviswanathan
> <subash.a.kasiviswanathan@oss.qualcomm.com>; Sean Tranchetti
> <sean.tranchetti@oss.qualcomm.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S . Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> co+4638111fe2a12980@bugs.sh; Xiang Mei <xmei5@asu.edu>
> Subject: [PATCH net v2] net: qualcomm: rmnet: restore skb->dev on
> deaggregated frames
> 
> rmnet_map_deaggregate() allocates each sub-frame with alloc_skb() and
> leaves skb->dev NULL. __rmnet_map_ingress_handler() assigns
> skb->dev = ep->egress_dev only on the data path, but a MAP command frame
> is dispatched to rmnet_map_command() before that, so
> rmnet_map_send_ack() runs netif_tx_lock(skb->dev) on a NULL device. An
> unprivileged user reaches this by unsharing a user+net namespace, creating
an
> rmnet link over a tap device with INGRESS_DEAGGREGATION and
> INGRESS_MAP_COMMANDS, and writing an aggregated frame carrying a
> flow-control command to the tap fd.
> 
> Restore the assignment dropped by 378e25357ac7, so every skb leaving
> rmnet_map_deaggregate() has a valid device.
> 
>   BUG: KASAN: null-ptr-deref in _raw_spin_lock
> (kernel/locking/spinlock.c:158)
>   Write of size 4 at addr 00000000000004b4 by task exploit/144
>   Call Trace:
>    _raw_spin_lock (kernel/locking/spinlock.c:158)
>    netif_tx_lock (net/sched/sch_generic.c:497)
>    rmnet_map_command
> (drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c:67)
>    rmnet_rx_handler
> (drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c:125)
>    __netif_receive_skb_core.constprop.0 (net/core/dev.c:6103)
>    ...
>    __netif_receive_skb_one_core (net/core/dev.c:6214)
>    netif_receive_skb (net/core/dev.c:6474)
>    tun_get_user (drivers/net/tun.c:1966)
>    tun_chr_write_iter (drivers/net/tun.c:2012)
>    vfs_write (fs/read_write.c:687)
>    ksys_write (fs/read_write.c:739)
>    do_syscall_64 (arch/x86/entry/syscall_64.c:94)
>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>   Kernel panic - not syncing: Fatal exception in interrupt
> 
> Fixes: 378e25357ac7 ("net: qualcomm: rmnet: Remove unnecessary device
> assignment")
> Reported-by: co+4638111fe2a12980@bugs.sh
> Closes:
> https://lore.kernel.org/netdev/ijg79FFMfIvKJbivdJEKvTO90Q9dTvyBkJck@bu
> gs.sh/T/#u
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
> v2: assign in rmnet_map_deaggregate() instead of rmnet_map_command(),
>     thank @Eric Dumazet.
> 
>  drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> index 305ae15ae8f3..e6f48dc9fe64 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> @@ -394,6 +394,7 @@ struct sk_buff *rmnet_map_deaggregate(struct
> sk_buff *skb,
>  	if (!skbn)
>  		return NULL;
> 
> +	skbn->dev = skb->dev;
>  	skb_reserve(skbn, RMNET_MAP_DEAGGR_HEADROOM);
>  	skb_put(skbn, packet_len);
>  	memcpy(skbn->data, skb->data, packet_len);
> --
> 2.43.0

Reviewed-by: Subash Abhinov Kasiviswanathan
<subash.a.kasiviswanathan@oss.qualcomm.com>

A minor point here is that the skb->dev for data packets would be first set
to real_dev in rmnet_map_deaggregate() followed by the expected mux specific
rmnet dev in __rmnet_map_ingress_handler() with this patchset. The v1 patch
would be assigning the skb->dev for the command packets only which would
prevent the unnecessary reassignment of skb->dev in case of the data
packets. 

