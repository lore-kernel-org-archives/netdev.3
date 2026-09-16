Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D73445AF2
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 20:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789590641; cv=none; b=OHCR8MMcdKvbAQu0c4nd9nXvJf4sWkhyJ0bX06dA+rrTejKoRrgV9uydJmTmzW+7WQyQwioQwVHZ0RzZpJmHurTbMuXrdZEAh4EOBLvPuP9dmlW/G8HLR/vlPWUN1rfYLiLfkPbn7QLHIk0cNptiRHtM6L1A351EhGzyDWNkaHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789590641; c=relaxed/simple;
	bh=JAKUUqJd2qHCPRvww3fZ2YL79BWIF2sO/qrKX5j4WIE=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=u/0amTQNDJiow4PV0B6KXE9Vc1xa/ehhQOfdE9MEpVVQtBC6u4MdCYG569Whidm+WYyFgfI6btxZftug7WZ4ioub+XD9upNgQWtDVmDkZWs7scb+12X4Fz0ErODxuTWVKADbyUEdaWpPbytsV9UWY0ZYueNGqvuQ1I15+MVV7BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bVsQOyjJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=clmnN0yc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bVsQOyjJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="clmnN0yc"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GFeKWf3107258
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 20:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9PLBICahvbn3jQdn0qzJ9oGFNdxzqRaRW4Cw/G+Dtcs=; b=bVsQOyjJYoYNfilh
	d+hJaNzjoDRU3gMtPuArw5HX7tFra+JelivMQB4q/nGiRKdNErNSWQQJXfQ/6WZl
	1d8z+RR2bjJYxf13jMOKCQGrfB65rTdHvc17WWAsRxmm3Eyq5q2WsjrPW3ZnkQvh
	F6+vcO9w7uE5RVs2B0wKgIZ5JGxg9/cEm8GltjouZo89rSjCvFNwPSQxp79HtkNV
	6eOdbVW4iColfHnv7GbjNAwMJkP+DmI3ic2F8X3RllYiyEbvD+ARlNSBfpIs+aOa
	NXO78+6ciM/xclFyW/IuJECFPKrPCa/BnxItkUn36gM9rBHObJwvACo5WpTF9z5c
	4ZvKBQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gquw2sx02-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 20:30:30 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39de4e72b33so159440a91.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 13:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789590629; x=1790195429; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9PLBICahvbn3jQdn0qzJ9oGFNdxzqRaRW4Cw/G+Dtcs=;
        b=clmnN0yc47lm8C1BsWu62PkKbUosuB41iTngwHOVAu5UiiDrZsv/s62DJ4I4x52RbM
         2Pmh7wlOOLRSpy1Y5BNToHBJbgJ911TU6tiSeWWnzTD+DhY4Q8ONcBYRJaRrjScZXM9y
         D+bngPB/LZJ5JKdroJ9R072YKN5CJUeAwMn1Ksh0Z5eCZylyUgZelx5I7lRZWz2XLtcN
         0EOoUBC0OcD3x98OWTsM//WZIdBRlqG7n4Vi9Sh4+z2eLj6Vik9xHhaOWX/bBhcvgaWU
         OQnr3Rlncelyo4kEuwznQqSjlHmqoFr7RBvgdGIq4KCPyZqIemu0d5ONQA7IDQyeDFQp
         Z9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789590629; x=1790195429;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9PLBICahvbn3jQdn0qzJ9oGFNdxzqRaRW4Cw/G+Dtcs=;
        b=vdifCLGVlq74qZASpqmskQkp8M8pJcXiPnm8N4BM/++nBUzuJDfMiWA0MMXEkYq/iU
         n1z9edi6+C2iVshqNsQD0WTI6QS2p/szIPgPZrJiSA77oFMEkdvz/YiBZ6APS1gy9stl
         4NtAtgMlMaLi6bZ/ARq5chY6kdMr2XrF5ZL7Ug3/03f5YVjc4qbazUwXZBg6ticLh2DR
         rAuwWzhbqKEe3Vs2cu9sptf1npiEL+i6eV5uGXw/YqhK/kSfF3HFJzOCOxb/KNSRRhvf
         5ymM7ODeffhUcgbsO0rDmLSXGL+r2IU9gS78lVhQFgvf5uNqtDlp+GkWAF6bZHX/PMv/
         HyQQ==
X-Forwarded-Encrypted: i=1; AKwUvBxjaxEgv3KGrTD1D0RtubsjLG+qQ4CdT/KTgnjei3f7bVWYbp11cw2cko3JnnYMmDh/uPpBalQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mFfBDjDvSViPkdZjUXi01nuWiB2aRoAZscoTvftkt6kPqu67Yg
	INGO9v8nuF5t5mP4pSerz3GHCaEppXt9WptB1PsVnyjizCxvHkB60qoFbqLeB4MWux+oi9GHQNO
	J8EwAgDUbc6bc2TVLzc2Q6V478xJAwwzS65QSwyvQtZK6iGofIsoYr+6gR2M=
X-Gm-Gg: AYBFou1vGFdAQ44Ex3NTtVyyW9HjdJqyxGklJf22L1BS+XpS7pMfNEh+3s1y67EFKcr
	V5lH5FH9s3VDs+D5BM4mcsZ+OOeJBiov76YcS3UhcwFzAR9Lafi1J+k4vwzp5t3uod7M0Qa/eHW
	RglQKaUWMPr09StxWP6OM/f+scXuc/FErWMrxbH5L9tBh7S/CKjlhD2JLyoYL5VostDxu6DEhQI
	xFVR9DRKsbfuxPo+l8/B6SYCM0p9KJO3TIb6xscNCDpXK37EJKWfvdFTmgk02T6+bFFcjQXWwpX
	0vWrdcN8v23oW9MLjKXYHe8ndvI9AhYqC/2bDi1QunHG7CjSgGLtoj1jB09XECY5Ndq64EWdMNF
	FLMJ2aYlDU2KO/NF4DK7n/I5/uoUO9ZBsLK4qw98dVa5PmRPjjo6GSfFktgEHDCflllL2roQB
X-Received: by 2002:a17:90b:3941:b0:39d:f2a1:3a with SMTP id 98e67ed59e1d1-39e1e43cfecmr9182320a91.15.1789590629329;
        Wed, 16 Sep 2026 13:30:29 -0700 (PDT)
X-Received: by 2002:a17:90b:3941:b0:39d:f2a1:3a with SMTP id 98e67ed59e1d1-39e1e43cfecmr9182262a91.15.1789590628798;
        Wed, 16 Sep 2026 13:30:28 -0700 (PDT)
Received: from QCOMk1gASIiYhG (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf596e20esm10212755eec.3.2026.09.16.13.30.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2026 13:30:28 -0700 (PDT)
From: <subash.a.kasiviswanathan@oss.qualcomm.com>
To: "'Abdifatah Suruur'" <suruurism@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Cc: <sean.tranchetti@oss.qualcomm.com>, <horms@kernel.org>, <kuba@kernel.org>
References: <20260915195642.1912-1-suruurism@gmail.com>
In-Reply-To: <20260915195642.1912-1-suruurism@gmail.com>
Subject: RE: [PATCH net-next v8] net: qualcomm: rmnet: require CAP_NET_ADMIN in the real device netns for config ops
Date: Wed, 16 Sep 2026 14:30:26 -0600
Message-ID: <000101dd461a$3616c9a0$a2445ce0$@oss.qualcomm.com>
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
Thread-Index: AQI1rpEYjj6H3zoZieRzGESYrbZHhbYgbgLA
Content-Language: en-us
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDI4NCBTYWx0ZWRfX5U0dBcSoAOBR
 T7YEsoFaEg872em2ELYFF/fRy9PCzUxMAfcVKOtQGqUCBWqNeR6Goz7t+SBoheAJpCTSgHfMomy
 ZIr94Tx1uHaN+Q1P+YfVyRUf99ueP/s=
X-Proofpoint-GUID: hHmfu4t-iWlXkkZG53s9lATlJO3708Bq
X-Authority-Analysis: v=2.4 cv=N4m8hG9B c=1 sm=1 tr=0 ts=6aaafc66 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=hSzng9yqXL38V1c8vrAA:9
 a=CjuIK1q_8ugA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: hHmfu4t-iWlXkkZG53s9lATlJO3708Bq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDI4NCBTYWx0ZWRfXwWx5LucTTg7N
 65osZM4irQLcP0MkdemMD9rUjokxhvpCiM3DGXYRjFDCDncaSgPDbpYXVM4MFvkpMrzK7OeHDSg
 2mRQe8PqjRVfFkzvFmsx8A6ejX6jmha4SVlXz1qBAh7/a98fIs9CvE7Dzv9+EW9vnNgugQdm1vJ
 pILKcee4RMrI1bdyUMOnHT8eZvulsyHejWTO+zvT8jVlOIKqy6ootHFAaNKZK8JtTLSD7i2OaE9
 aF72zPY87SZzuS4wCypqseuwy5ALMs8hyJfR246RpAepqulOojd0jV1MSkEDrZCQg2i8sV6XhCH
 O4qsumoTvIz3h5QOGQ+2eaIL1WaXfvt9aloxQIyYdgzHnHioEwSDNozaVaaTFI7MtS54rVMuoOA
 bwToDBISrlPy8ZGnPfR/udZs72WN9Ip8V80EEilLwrltkkOPF27foZf3o3yKFLWFKVw+MB9q/q1
 SqtQoraabRL1x5EHT6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160284

> -----Original Message-----
> From: Abdifatah Suruur <suruurism@gmail.com>
> Sent: Tuesday, September 15, 2026 1:57 PM
> To: netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: subash.a.kasiviswanathan@oss.qualcomm.com;
> sean.tranchetti@oss.qualcomm.com; horms@kernel.org; kuba@kernel.org;
> Abdifatah Suruur <suruurism@gmail.com>
> Subject: [PATCH net-next v8] net: qualcomm: rmnet: require
> CAP_NET_ADMIN in the real device netns for config ops
> 
> An rmnet device may be created with its real device in a different netns
than
> the rmnet device itself (rmnet_newlink() resolves it in link_net), and the
config
> paths below only check CAP_NET_ADMIN against dev_net(dev), while
> mutating rmnet port state attached to the real
> device:
> 
> - rmnet_changelink() rewrites the endpoint mux table and
>   port->data_format and, via rmnet_vnd_update_dev_mtu(), can shrink the
>   MTU of the rmnet endpoint netdevs.
> - rmnet_add_bridge() and rmnet_del_bridge(), reachable via
>   ndo_add_slave/ndo_del_slave through RTM_SETLINK IFLA_MASTER, flip
>   port->rmnet_mode and port->bridge_ep on the real device's port; with
>   bridge_ep pointing at a caller-owned device, rmnet_rx_handler() then
>   forwards real-device ingress frames to it.
> - rmnet_set_coalesce() rewrites the port aggregation parameters via
>   ETHTOOL_SCOALESCE (ioctl) or ETHTOOL_MSG_COALESCE_SET (netlink),
>   whose capability checks likewise only cover dev's netns.
> 
> A caller privileged only in the rmnet device's netns can therefore rewrite
the
> shared cellular data-path state owned by another netns, and steer its
ingress
> traffic.
> 
> Gate the rtnl paths with rtnl_dev_link_net_capable(), matching the
"require
> CAP_NET_ADMIN in the device netns for changelink" series (vxlan/geneve,
> CVE-2026-68432), and gate the ethtool setter with
> ns_capable() in the real device netns, mirroring the check dev_ethtool()
> already applies to dev's netns.  Report the new rejections through extack
> where one is available.
> 
> The gates cover the configuration paths only.  Teardown (RTM_DELLINK
> reaching rmnet_dellink(), and rmnet_config_notify_cb() unregistering the
> bridge when the slave device is deleted) is intentionally left
> ungated: link deletion is normal netdev lifecycle behaviour, and the
changelink
> series this matches (vxlan/geneve, CVE-2026-68432) gated only the
> configuration paths.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
> 
> ---
> v8:
> - drop the Fixes and stable tags, per Jakub Kicinski
> - drop the explanatory comments added next to the gates, per Jakub
>   Kicinski
> - shorten the extack messages to "request modifies device in another
>   netns", per Jakub Kicinski
> v7:
> - state explicitly in the commit message that the dellink and notifier
>   teardown paths are out of scope, per the Sashiko review
> - drop the master-moved-into-the-real-device-netns rationale from the
>   rmnet_add_bridge() comment: on the add path do_set_master() resolves
>   the master in the slave's netns, so the rationale only applies to
>   rmnet_del_bridge(), where the master comes from
>   netdev_master_upper_dev_get()
> - use the netdev comment style in rmnet_set_coalesce(), per the
>   Sashiko review
> v6:
> - gate rmnet_add_bridge() and rmnet_del_bridge() on slave_dev, the
>   RTM_SETLINK target the caller was actually authorized against,
>   instead of rmnet_dev: a master moved into the real device's netns
>   short-circuits rtnl_dev_link_net_capable() through the net_eq()
>   check, so a caller only privileged in the slave's netns could
>   otherwise attach or clear the bridge state of the real device's
>   port
> - add the Fixes tag for the commit that introduced rmnet_set_coalesce()
> v5:
> - also gate rmnet_set_coalesce(), the ethtool setter that rewrites the
>   port aggregation parameters of the real device's port, per the
>   Sashiko review
> - report the new capability rejections through extack where available
> v4:
> - use the netdev comment style, per Subash Abhinov Kasiviswanathan
> v3:
> - cover rmnet_add_bridge() and rmnet_del_bridge() with the same gate;
>   they mutate the same real-device port state via ndo_add_slave/
>   ndo_del_slave and have no capability check of their own
> - correct the impact wording: rmnet_vnd_update_dev_mtu() only reads
>   real_dev->mtu; the MTU store lands on the rmnet endpoint netdevs via
>   rmnet_vnd_change_mtu(), not on the real device
> v2:
> - drop Reported-by: (implied for the author), per Jakub Kicinski
> ---
>  .../ethernet/qualcomm/rmnet/rmnet_config.c    | 21
> ++++++++++++++++++-
>  .../net/ethernet/qualcomm/rmnet/rmnet_vnd.c   | 11 +++++++++-
>  2 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> index bed6f63facf25..8bf385ab44a90 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> @@ -312,6 +312,12 @@ static int rmnet_changelink(struct net_device *dev,
> struct nlattr *tb[],
>  	if (!rmnet_is_real_dev_registered(real_dev))
>  		return -ENODEV;
> 
> +	if (!rtnl_dev_link_net_capable(dev, dev_net(real_dev))) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "request modifies device in another
netns");
> +		return -EPERM;
> +	}
> +
>  	port = rmnet_get_port_rtnl(real_dev);
> 
>  	if (data[IFLA_RMNET_MUX_ID]) {
> @@ -441,6 +447,12 @@ int rmnet_add_bridge(struct net_device
> *rmnet_dev,
>  	struct rmnet_port *port, *slave_port;
>  	int err;
> 
> +	if (!rtnl_dev_link_net_capable(slave_dev, dev_net(real_dev))) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "request modifies device in another
netns");
> +		return -EPERM;
> +	}
> +
>  	port = rmnet_get_port_rtnl(real_dev);
> 
>  	/* If there is more than one rmnet dev attached, its probably being
> @@ -489,7 +501,14 @@ int rmnet_add_bridge(struct net_device
> *rmnet_dev,  int rmnet_del_bridge(struct net_device *rmnet_dev,
>  		     struct net_device *slave_dev)
>  {
> -	struct rmnet_port *port = rmnet_get_port_rtnl(slave_dev);
> +	struct rmnet_priv *priv = netdev_priv(rmnet_dev);
> +	struct net_device *real_dev = priv->real_dev;
> +	struct rmnet_port *port;
> +
> +	if (!rtnl_dev_link_net_capable(slave_dev, dev_net(real_dev)))
> +		return -EPERM;
> +
> +	port = rmnet_get_port_rtnl(slave_dev);
> 
>  	rmnet_unregister_bridge(port);
> 
> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
> b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
> index 4f0ddcedfa979..53802b485a813 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
> @@ -4,9 +4,11 @@
>   * RMNET Data virtual network driver
>   */
> 
> +#include <linux/capability.h>
>  #include <linux/etherdevice.h>
>  #include <linux/ethtool.h>
>  #include <linux/if_arp.h>
> +#include <linux/netlink.h>
>  #include <net/pkt_sched.h>
>  #include "rmnet_config.h"
>  #include "rmnet_handlers.h"
> @@ -240,9 +242,16 @@ static int rmnet_set_coalesce(struct net_device
> *dev,
>  			      struct netlink_ext_ack *extack)  {
>  	struct rmnet_priv *priv = netdev_priv(dev);
> +	struct net_device *real_dev = priv->real_dev;
>  	struct rmnet_port *port;
> 
> -	port = rmnet_get_port_rtnl(priv->real_dev);
> +	if (!ns_capable(dev_net(real_dev)->user_ns, CAP_NET_ADMIN)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "request modifies device in another
netns");
> +		return -EPERM;
> +	}
> +
> +	port = rmnet_get_port_rtnl(real_dev);
> 
>  	if (kernel_coal->tx_aggr_max_frames < 1 || kernel_coal-
> >tx_aggr_max_frames > 64)
>  		return -EINVAL;
> --
> 2.53.0

Reviewed-by: Subash Abhinov Kasiviswanathan
<subash.a.kasiviswanathan@oss.qualcomm.com>

