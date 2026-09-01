Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E1B48CD61
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788285136; cv=none; b=TlQSRdi7tsuBoKdSI+2fdZyViauvqHaXwNvDKZ9QlUMlFcVMx5YjtH6L0Nsqm7ufXjyOUhQjfJTBunEjcRG0BcEqs6Yg876CuLuW2ZjyTZDWey5MWjf86nb4u892DZbtiHZW2PrjEgaglquTGreIA/fDdGpHnOy8wEkd686TECE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788285136; c=relaxed/simple;
	bh=5Ljoy05eM2hvOQIEt/wowa0X9gdsi6+0oEQN07gEYGc=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=TY/EYgfXNU1FcKt78uROg0VvNIg0Mw2fMc0yd8ArtgY/pOAICWSNqRssmW1qszZ/9FNF03MG/cN+db5f241u5kP5xKIFpQpnTGr+8EsNHhfBmmFKRD58Xt9b4eWgTfEjvrcqdkAsE5o/fbFEHzllm45PH89FfGuwGjK67UCFqAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SpFRfMy4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GyAf6l0R; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SpFRfMy4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GyAf6l0R"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681Hgcte3980260
	for <netdev@vger.kernel.org>; Tue, 1 Sep 2026 17:52:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cGSjmkq62N7lfw1591YZQUCHweLAEMoRxMNz1OD8vjY=; b=SpFRfMy4AZW6zBae
	H5G8wTgDGfQCN0Kjn7+fOrBxF3d7RNIxQqrABEBiIlZERvV0UUTUCtDTDIH8H5TW
	8eR1nQK4jN3lj7bqHHi4uWh1O1n1tuijdyTtq+Ht7MlxZ6Zik+aNS5mQAz2+HbRg
	ACHZgk8RuPk8Rlg1qjGyG2C4oxyjHoJuv3vctogfEkVqhWWGg3CEpJ3GV4BtwtWT
	YrKf9FMHmVV0CUEtW25NXtOsF9A3PB2+3wNVwZ2zN1EPMGnRHhMmVJd7rPlmpZYD
	2JEaZFUYvtkQsYuOK7zzjAxqQ1upOv2T3rJZ7S6LEOVTYlJ37j542f+atvgxxjiu
	RKF3eA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdy9nhjh4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 17:52:13 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d94a158dc8so842505ad.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 10:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788285133; x=1788889933; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cGSjmkq62N7lfw1591YZQUCHweLAEMoRxMNz1OD8vjY=;
        b=GyAf6l0RiblIGLStJmH7k7px8YbaG8sJ9Nn3Bc+bwyrF43WW9BnBRaLvxtyPNjopwG
         x4yd3ePEaWoGa77QTe2UKjQdwHboxQkf9IzdQqFvUnuiWMhDJlRRa/HSpgciBGuIdtwP
         E9Y+C3+oyPvttLe3WJb5gl6fGtGYnCNCoeXz5c2bm2Fp3jeDbAzi817ljNhyl85/QLQ4
         nodLnK1kpiYfNkjriaLKBdIlWnn8J0mw4DbMbW/XZxqrGvXRj2WP9xYgkGsBeuB8xQNM
         PTOWiNj2MybaCvdW75zAAu289rR301eiPzPO2ETaA80idcqSuuRxB0uuN93HZULAyMAV
         cPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788285133; x=1788889933;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cGSjmkq62N7lfw1591YZQUCHweLAEMoRxMNz1OD8vjY=;
        b=ZWH0iqaSpd1ArkLMFmXBtvoBW3/8QJrU8wJeygyWEwYqhU/KC5WRZ+pju22p4CYFH8
         lTIOOSGefMmMZh50McBoxyNYZaYmwLc4VFlPFZtnUM6w6rit1o0LNrjNl1VpjOu+wXD7
         63Vm+kZKyyJ14PXWZFeTp0ZVIktzVNKQJUYgcUErkiyAusvFulHy/5fpToz9rXKuY3aT
         miFwFo4t34Pa8J2QprEfwvV5jRkv7XlMSDDwhFgZxI4NPX1Kyjel8Ikk3Hx0eRgEGvvs
         xipN2SZjlNWq8kHe4l327TkNE4h+/gdh/SyINZLpptnIZulwlxuosAtdZ8lI/SiOr9aE
         dwWg==
X-Gm-Message-State: AFuF++nUWS3god9oIq8kPpiqWXrRp8lVrCPCx3hniPqAUXGhDe3uK4qt
	CyggCTisoi5R7ZNPAKeHGVGLz0PcqrTWRT8OgLh+5OKpy7VZsG2z7XTUPsenkg+Ir1cRiBoW3o5
	TP24AVRrxouxt2ZysJYcvqzpxv1PHrmhHls1MnEOu5uzeLQMuWDkhZfuEV10=
X-Gm-Gg: AYBFou0uHAGZzjvoNP8EP1LpoeUOxg0OixomdLP+TX6Uap926AKPit0swJF+OXLGVh/
	Bo1JvvPzQrfx9Bx5WnAbuaI2hqJiN0YFV3lBRRQNlI+iVFjRCuRzYBNuEY38KBwATd8eKCo3Ud8
	Wet45g+l98J2lbQjAWwOvDEhRfZIApvXp1w7EKeJLXDww1Dqr17qqvmwVASNt2yvaS1HIxJwrAt
	678qxT/bh7d5jsqEDJXpYlLGWrkELlLHcqAjkt+rIftunlvcSWDhBAfHIDUgv7XlgAxFlsl+WER
	7gUE8NQUgwOrZOtWNc9UIMn5q/GPEuPi6gk+ZfYdKrGuEZWzCfFis3UN15BIkn1VuokIlim0Yrs
	RCe8sXisQxDIO6FLzNiArGVNLpWD2Rk568og5+/WbuIhqOBMKrjLyTa5T7ArNXhhbP7UGiqDmgl
	mY0WfCKJDq
X-Received: by 2002:a17:903:458f:b0:2d6:e074:9cad with SMTP id d9443c01a7336-2dae5e17e23mr202945ad.6.1788285133125;
        Tue, 01 Sep 2026 10:52:13 -0700 (PDT)
X-Received: by 2002:a17:903:458f:b0:2d6:e074:9cad with SMTP id d9443c01a7336-2dae5e17e23mr202475ad.6.1788285132633;
        Tue, 01 Sep 2026 10:52:12 -0700 (PDT)
Received: from QCOMk1gASIiYhG (66-33-8-210.colorado.intrepidfiber.us. [66.33.8.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f784857sm38886128eec.3.2026.09.01.10.52.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Sep 2026 10:52:09 -0700 (PDT)
From: <subash.a.kasiviswanathan@oss.qualcomm.com>
To: "'Abdifatah Suruur'" <suruurism@gmail.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sean.tranchetti@oss.qualcomm.com>, <horms@kernel.org>,
        <stable@vger.kernel.org>
References: <20260901081441.632-1-suruurism@gmail.com>
In-Reply-To: <20260901081441.632-1-suruurism@gmail.com>
Subject: RE: [PATCH net v4] net: qualcomm: rmnet: require CAP_NET_ADMIN in the real device netns for config ops
Date: Tue, 1 Sep 2026 11:52:07 -0600
Message-ID: <001701dd3a3a$9c0f8580$d42e9080$@oss.qualcomm.com>
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
Thread-Index: AQGwzwKGUDaVs3KPTjfRVyDxc6JAIbcS1wVg
Content-Language: en-us
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1OCBTYWx0ZWRfX759bCF6odch3
 U9BZ24GUfJXCU4Fvddq5VbRTOZBksfHjOox11sb+wXQFBACu5DiITLeU/KZxoWXToNjLlDdr7Eb
 TZhy9kcZiZsdcDhlBcQhhOULf7asxLk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1OCBTYWx0ZWRfX7ULH2NeIB/fQ
 8R80ZuWjHxteYp1xaOrQt8w7YwHbzzY86IUjq8vC7uaO7AaBKb/YpamXdmIMbfJ21GLxjVYkBKm
 R9176yzhLG1e3xk+g9w69rCX33G9xFgeytScHexMrlCxmbP6X6vOeXde0Wjt7r8++xBcqYJbmAo
 MwKaf2wt1umSx58O24LBS+gAUzMy++awOd3TXoHHD/YqZRXh9a+rWgM+xeooohKTbDcDmOV3nyw
 hdhik0ORjYmRBGIY0UG/2TBHvHSFt7qWbM8j41VXMG2xT/+MGID+fXjyox8Nb0feWekuhuIHhsE
 x7li6DBzXx/xSmefEEcaP/R8397gwxDchhEt0h9lTRl3vFcnOwnjh6kDadFru3ZOn6CqRoUMTAq
 U9xL4uBlN6rgvSQCs3tb5mLOLoYHW7W3P4PAGVZtvclgjgUQ4L0iSdTlsbDU5uk1buGqOt/EOlR
 zGL+o6iNlYQM42uJP+A==
X-Authority-Analysis: v=2.4 cv=e/02j6p/ c=1 sm=1 tr=0 ts=6a9710cd cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=OltkOWFNRHEXGe+8VJKHzA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=cXkr8SbK9_hmXVLBwXUA:9
 a=CjuIK1q_8ugA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: gUhL73WVJhCOy9HYXgRMe-a_CEcsaLtO
X-Proofpoint-GUID: gUhL73WVJhCOy9HYXgRMe-a_CEcsaLtO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010158

> -----Original Message-----
> From: Abdifatah Suruur <suruurism@gmail.com>
> Sent: Tuesday, September 1, 2026 2:15 AM
> To: subash.a.kasiviswanathan@oss.qualcomm.com
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> sean.tranchetti@oss.qualcomm.com; horms@kernel.org; Abdifatah Suruur
> <suruurism@gmail.com>; stable@vger.kernel.org
> Subject: [PATCH net v4] net: qualcomm: rmnet: require CAP_NET_ADMIN in
> the real device netns for config ops
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
> v4:
> - use the netdev comment style, per Subash Abhinav Kasiviswanathan
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
>  .../ethernet/qualcomm/rmnet/rmnet_config.c    | 27
> ++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> index 78d4df55740a1..73bd5419cb136 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> @@ -312,6 +312,13 @@ static int rmnet_changelink(struct net_device *dev,
> struct nlattr *tb[],
>  	if (!rmnet_is_real_dev_registered(real_dev))
>  		return -ENODEV;
> 
> +	/* The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
> +	 * but the port state mutated below is attached to real_dev, which
> +	 * may live in a different netns.
> +	 */
> +	if (!rtnl_dev_link_net_capable(dev, dev_net(real_dev)))
> +		return -EPERM;
> +
>  	port = rmnet_get_port_rtnl(real_dev);
> 
>  	if (data[IFLA_RMNET_MUX_ID]) {
> @@ -440,6 +447,13 @@ int rmnet_add_bridge(struct net_device
> *rmnet_dev,
>  	struct rmnet_port *port, *slave_port;
>  	int err;
> 
> +	/* The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
> +	 * but the port state mutated below is attached to real_dev, which
> +	 * may live in a different netns.
> +	 */
> +	if (!rtnl_dev_link_net_capable(rmnet_dev, dev_net(real_dev)))
> +		return -EPERM;
> +
>  	port = rmnet_get_port_rtnl(real_dev);
> 
>  	/* If there is more than one rmnet dev attached, its probably being
> @@ -488,7 +502,18 @@ int rmnet_add_bridge(struct net_device
> *rmnet_dev,  int rmnet_del_bridge(struct net_device *rmnet_dev,
>  		     struct net_device *slave_dev)
>  {
> -	struct rmnet_port *port = rmnet_get_port_rtnl(slave_dev);
> +	struct rmnet_priv *priv = netdev_priv(rmnet_dev);
> +	struct net_device *real_dev = priv->real_dev;
> +	struct rmnet_port *port;
> +
> +	/* The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
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

Reviewed-by: Subash Abhinov Kasiviswanathan
<subash.a.kasiviswanathan@oss.qualcomm.com>

