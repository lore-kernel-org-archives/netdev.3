Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F2338AC83
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 20:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207777; cv=none; b=CdOei2BtjXSCsV4twDIDohk6xbchyNhLXmG07E89TXPgLQCMoITBIFwuJq/aQRM9Ty8gvB+LJ9FwSyKSFxzrdBcxI4wlh36OjHUE/tD0pL27gD95l5SpY5kjmkwB7THgEYeWfJFYe6HhWB6XDBQYgd01n2UWY1UOV1nx47Ksah8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207777; c=relaxed/simple;
	bh=edpo7zq4/+2hk0SciTYW5ScKODY3wlH7NhR4s2VSZlA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=uSccO2OLJ55rUhBodUv97DDbiV4sb/IEd8QEF5cGyVmbG2sNeJGrGWT+hMotj/4Ev0/Fjmw4O2b3VeX0U13/Jmpn7QCMNr/W3WSTh5zj42ELUZr/oMf2AC2SMc5qRuK5s6y8mUCGah4lMcTHdxg0RAjMDU9IGCcOXWBH8QAlGYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MbvFZYLq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NW2FyWFn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MbvFZYLq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NW2FyWFn"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VIY3133772720
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 20:22:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N1mlTl4w8l57DwPD8LgVJLWK61Uu+JocvF6j9FhaKYQ=; b=MbvFZYLqzIz5IAnL
	7vx1HrOlHi85oxJ/iu6g4wLl42W0acfKz3/3Za9KWxBwui248NEY7wQK8vEGWHIv
	MEnCgoEsnug4hltj7Pfn10vsh0/RezHoaO8yijGpF/Tf7QFl4yBk3vOKCkrdWjYm
	/su09YJrUjZtQKB8ZyAw9Bi89TyAY9rt+XHT01hbztU8W0ZzapvktW9B2yfaGlL6
	hGcHUdfV8rGN5f8ucUFwvhDYC487L9B30aWxgesS1YS067kL6jB5U9t40jBkQOBA
	zUo3XE+fautP9vjPw5BSELroa1Ie0aPySXeYk0HNMe6/by9/8kuSpoFohmG1m541
	nXY3Zg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6vcu1r9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 20:22:53 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-398d0010cfaso3468395a91.3
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 13:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788207773; x=1788812573; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N1mlTl4w8l57DwPD8LgVJLWK61Uu+JocvF6j9FhaKYQ=;
        b=NW2FyWFnJCgJLoPCb8iBBgqlZzltBp+XLnAvz9qyV1EhWHQ3VWYjHMGUfC3vBZ0diD
         0T5htnvoPsVGGmgIOxIO+/t8DLo5KLBR4Xn77ybvBT8KCrUWibAKNOtc+4PdpnUwQef/
         +TMMrfB3RoytrP3aS7jHVyTRQcTzS71NVyDAxJ/zwiS9ns4QKomJShY/hdvv3pOqO+sB
         hKPeSAt0/V0ShlaBZIDliFWqm3/WNDOspM6Rnc4dPsCmpSo/3Ts8pjld9O0wcaPVUjfK
         fj105lCo2uNbYmdRbH1T3m4n9A8y2LYgH43T/0PRUUcHI6w3O4MvrmUNlhsEkHrSdI/R
         YnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788207773; x=1788812573;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N1mlTl4w8l57DwPD8LgVJLWK61Uu+JocvF6j9FhaKYQ=;
        b=R9qPEuFE0i4c6aPhlhBdoQpGdqi4AEyTOfRWWccACfTorO6B4gYavIM9wKi5P2x++/
         OI+DuI3lRbEUlaidpRCf/xQtzxr/wn1hXeZ6utURG7yEeZ2pla7iWPKID9yIc7+IuBI8
         AVBCrg78kSzf35rOVL3nrxwqFFH5CCGfXEmqiNJCCtZFUc3+jWYMb7/7tCId/WtULT39
         WlTPvUUkefv1rzuuaKaydWgzHH4m1ania5t/MaHj/SfgCa8vUt02mLPb76o3MnN3yF5f
         sU14PcsuvJpRXOy4KPzri2rsYXaqPZtjw3nF7bkM6fpVjimjeR/v/IwW45vScgV1KLbm
         pW1w==
X-Forwarded-Encrypted: i=1; AKwUvBxb1MDZXqC7B2mgzNG4QfMYY0bBMA3s1/cyX7lWVyiV4QyydE5Kszsiaob4wH8DkJcDlLTKlA8=@vger.kernel.org
X-Gm-Message-State: AFuF++kgxW8K35Wk4ZZdA6LfMW7WCGn0R64SxUGnvthQCmsiCdTvkLQY
	H2z23Zl3YSREpuju81LL833k6lRjZz2WH64jQ/A4FUp11SvS7TPUlfiJ03DFR8lEUHNjIC2c0rb
	qWU7THwdR9XXOukiwdPiEiZqU0ilt6CvJiqR1rtl67+JbT/EHB8XEuG+D0YM=
X-Gm-Gg: AYBFou1TEqrb+6cp+HyevNdvXiUVKG2HgAB1zQl/dph3WP2grByF/OTkdJyJqqeR4A0
	3LSnDGokV1L5dcanbwac7N+l4Ht8mluk4kDE21Cv1zUmqFCtKddzIgZEqngReO9/ZVvhbAVcQej
	NCEyDCL4dHPP44UaNgmLQvrbYNykOLMPO1JyYOW68ptvmu5l3mMHFKxdrEq5EpKoWia406WD5k+
	7CpfFG7ENV0NTye0XYCbq+SnDbXgN9NhwkNA2jJyhI5XSHzN7qgTAkdidlPL4AJKk1IORFdgmQu
	pGnC2fMe9FS3zhDfbWu0Thons9lf5FcotGOBtUjpX9UBNUC8zyvHYs2chf/kJ7mmTDndPp7KPEL
	1i5/TMakGo3zUMwQmQuCHuMlekfcgycZMXptA+dKemDejOSH7/r9xDl+ZsAwELgAhhg47D7Tj
X-Received: by 2002:a17:90b:4a8a:b0:398:9be8:ea69 with SMTP id 98e67ed59e1d1-39907ec46b4mr3822959a91.22.1788207772583;
        Mon, 31 Aug 2026 13:22:52 -0700 (PDT)
X-Received: by 2002:a17:90b:4a8a:b0:398:9be8:ea69 with SMTP id 98e67ed59e1d1-39907ec46b4mr3822919a91.22.1788207772072;
        Mon, 31 Aug 2026 13:22:52 -0700 (PDT)
Received: from QCOMk1gASIiYhG (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32874498f9esm28854158eec.20.2026.08.31.13.22.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2026 13:22:51 -0700 (PDT)
From: <subash.a.kasiviswanathan@oss.qualcomm.com>
To: "'user.email'" <suruurism@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Cc: <sean.tranchetti@oss.qualcomm.com>, <horms@kernel.org>
References: <20260829170656.15548-1-suruurism@gmail.com>
In-Reply-To: <20260829170656.15548-1-suruurism@gmail.com>
Subject: RE: [PATCH net v3] net: qualcomm: rmnet: require CAP_NET_ADMIN in the real device netns for config ops
Date: Mon, 31 Aug 2026 14:22:50 -0600
Message-ID: <000101dd3986$7f498b30$7ddca190$@oss.qualcomm.com>
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
Thread-Index: AQKQ4MYU1OYF5H2fefnV2nbrvGeKVrVRSmKQ
Content-Language: en-us
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE3NiBTYWx0ZWRfX+fCc8/pfKYCe
 LJt1KgzH18SzLvRApDXfrhcd55o3vgPKwjDjXpQzvqYG/ircG9JpVZ88segxLhFPgBxGwEK+alj
 efF59LLgT8fyqBhk9gxr7Y0WG7mu5J2GIYbDLy47upr6e7Jj6QoM47g0AdJctyp8poKGvFSRJbA
 I/aUQFLZN6kGcWaY0jasTujsuzVdbXRN2bHzKOdCEYvNfPZ2VIlk693gAN1y8kjQ1GlJp+a/z6k
 2UcKyqmOgBjJfZthT9twLGrz69aC/oAb5fWK1d9X4yarVHAZh1K2oVMpuzSOHM/lkUcvaWr9szF
 QfSn2/OQGP7+QxQTjB38n7uQxPfX1CKzSQFbd5agIojEukx/92EKBTrx7QRnRFYNprTzm7lu34k
 ykXDzn1oPJSzNQQF7cp3RVeXbcP5d5b24loADmVInsTwLHaiYuoLb0Nsg6t4oG6L902iorzY257
 M19f8zUWS/zGcKli0xw==
X-Proofpoint-GUID: 8vusWdSKcWI6SLh9q7oUMn6zXuo83YZh
X-Proofpoint-ORIG-GUID: 8vusWdSKcWI6SLh9q7oUMn6zXuo83YZh
X-Authority-Analysis: v=2.4 cv=Eo7iaycA c=1 sm=1 tr=0 ts=6a95e29d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=hSzng9yqXL38V1c8vrAA:9
 a=CjuIK1q_8ugA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE3NiBTYWx0ZWRfX+ME6RLxK+sOd
 N/2LBzVEuX7HeXHh8Vpn+kDX2bk3WbrtjeXHJsr6I7nkvf73Ee4mZG7a4IiQrX1XdjA6zpa5K6h
 z+VCJuEOYV3ACISOnLeswZvajsGnHLw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310176

> -----Original Message-----
> From: user.email <suruurism@gmail.com>
> Sent: Saturday, August 29, 2026 11:07 AM
> To: netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: subash.a.kasiviswanathan@oss.qualcomm.com;
> sean.tranchetti@oss.qualcomm.com; horms@kernel.org
> Subject: [PATCH net v3] net: qualcomm: rmnet: require CAP_NET_ADMIN in
> the real device netns for config ops
> 
> From: Abdifatah Suruur <suruurism@gmail.com>
> 
> An rmnet device may be created with its real device in a different netns
than
> the rmnet device itself (rmnet_newlink() resolves it in link_net), and the
rtnl
> config paths below only check CAP_NET_ADMIN against dev_net(dev), while
> mutating rmnet port state attached to the real device:
> 
> - rmnet_changelink() rewrites the endpoint mux table and
>   port->data_format and, via rmnet_vnd_update_dev_mtu(), can shrink the
>   MTU of the rmnet endpoint netdevs.
> - rmnet_add_bridge() and rmnet_del_bridge(), reachable via
>   ndo_add_slave/ndo_del_slave through RTM_SETLINK IFLA_MASTER, flip
>   port->rmnet_mode and port->bridge_ep on the real device's port; with
>   bridge_ep pointing at a caller-owned device, rmnet_rx_handler() then
>   forwards real-device ingress frames to it.
> 
> A caller privileged only in the rmnet device's netns can therefore rewrite
the
> shared cellular data-path state owned by another netns, and steer its
ingress
> traffic.
> 
> Gate all three with rtnl_dev_link_net_capable(), matching the "require
> CAP_NET_ADMIN in the device netns for changelink" series (vxlan/geneve,
> CVE-2026-68432).
> 
> Fixes: 2abb5792387e ("net: qualcomm: rmnet: Allow configuration updates
> to existing devices")
> Fixes: 60d58f971c1077 ("net: qualcomm: rmnet: Implement bridge mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
> ---
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
>  .../ethernet/qualcomm/rmnet/rmnet_config.c    | 30
> ++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> index 78d4df55740a1..50c60e553d09f 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> @@ -312,6 +312,14 @@ static int rmnet_changelink(struct net_device *dev,
> struct nlattr *tb[],
>  	if (!rmnet_is_real_dev_registered(real_dev))
>  		return -ENODEV;
> 
> +	/*
> +	 * The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
> +	 * but the port state mutated below is attached to real_dev, which
> +	 * may live in a different netns.
> +	 */
> +	if (!rtnl_dev_link_net_capable(dev, dev_net(real_dev)))
> +		return -EPERM;
> +
>  	port = rmnet_get_port_rtnl(real_dev);
> 
>  	if (data[IFLA_RMNET_MUX_ID]) {
> @@ -440,6 +448,14 @@ int rmnet_add_bridge(struct net_device
> *rmnet_dev,
>  	struct rmnet_port *port, *slave_port;
>  	int err;
> 
> +	/*
> +	 * The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
> +	 * but the port state mutated below is attached to real_dev, which
> +	 * may live in a different netns.
> +	 */
> +	if (!rtnl_dev_link_net_capable(rmnet_dev, dev_net(real_dev)))
> +		return -EPERM;
> +
>  	port = rmnet_get_port_rtnl(real_dev);
> 
>  	/* If there is more than one rmnet dev attached, its probably being
> @@ -488,7 +504,19 @@ int rmnet_add_bridge(struct net_device
> *rmnet_dev,  int rmnet_del_bridge(struct net_device *rmnet_dev,
>  		     struct net_device *slave_dev)
>  {
> -	struct rmnet_port *port = rmnet_get_port_rtnl(slave_dev);
> +	struct rmnet_priv *priv = netdev_priv(rmnet_dev);
> +	struct net_device *real_dev = priv->real_dev;
> +	struct rmnet_port *port;
> +
> +	/*
> +	 * The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
> +	 * but rmnet_unregister_bridge() below clears the bridge state of
> +	 * the real device's port, which may live in a different netns.
> +	 */
> +	if (!rtnl_dev_link_net_capable(rmnet_dev, dev_net(real_dev)))
> +		return -EPERM;
> +
> +	port = rmnet_get_port_rtnl(slave_dev);
> 
>  	rmnet_unregister_bridge(port);
> 
> --
> 2.53.0

The change itself is fine though you might need to update the comment style
to match the networking convention
https://www.kernel.org/doc/html/v5.7/networking/netdev-FAQ.html#q-is-the-com
ment-style-convention-different-for-the-networking-content

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index bed6f63facf2..5d0a4a428e97 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -312,6 +312,13 @@ static int rmnet_changelink(struct net_device *dev,
struct nlattr *tb[],
        if (!rmnet_is_real_dev_registered(real_dev))
                return -ENODEV;
 
+       /* The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
+        * but the port state mutated below is attached to real_dev, which
+        * may live in a different netns.
+        */
+       if (!rtnl_dev_link_net_capable(dev, dev_net(real_dev)))
+               return -EPERM;
+
        port = rmnet_get_port_rtnl(real_dev);
 
        if (data[IFLA_RMNET_MUX_ID]) {
@@ -441,6 +448,13 @@ int rmnet_add_bridge(struct net_device *rmnet_dev,
        struct rmnet_port *port, *slave_port;
        int err;
 
+       /* The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
+        * but the port state mutated below is attached to real_dev, which
+        * may live in a different netns.
+        */
+       if (!rtnl_dev_link_net_capable(rmnet_dev, dev_net(real_dev)))
+               return -EPERM;
+
        port = rmnet_get_port_rtnl(real_dev);
 
        /* If there is more than one rmnet dev attached, its probably being
@@ -489,7 +503,18 @@ int rmnet_add_bridge(struct net_device *rmnet_dev,
 int rmnet_del_bridge(struct net_device *rmnet_dev,
                     struct net_device *slave_dev)
 {
-       struct rmnet_port *port = rmnet_get_port_rtnl(slave_dev);
+       struct rmnet_priv *priv = netdev_priv(rmnet_dev);
+       struct net_device *real_dev = priv->real_dev;
+       struct rmnet_port *port;
+
+       /* The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
+        * but rmnet_unregister_bridge() below clears the bridge state of
+        * the real device's port, which may live in a different netns.
+        */
+       if (!rtnl_dev_link_net_capable(rmnet_dev, dev_net(real_dev)))
+               return -EPERM;
+
+       port = rmnet_get_port_rtnl(slave_dev);
 
        rmnet_unregister_bridge(port);


