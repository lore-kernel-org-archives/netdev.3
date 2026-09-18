Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5C62EACEF
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 03:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789700668; cv=none; b=fljxOl54HALln7LibrzyB/AC54KVbdlKIzHZO3oswDUcgeKWn8R11fd7rsTZVeEb87GUZ9kBWLTLzz6Cgk3VJwGFxy3t7p12yYbLhE7XFVvI+EkEFPhHVpiDDu7bmBFLmJDvbIOtJnH2ydNVVIIHfR1NAlGe7h01seE94uQAEgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789700668; c=relaxed/simple;
	bh=oOmHV5W5Mg1t+bJPrTNMhWaddeyhD4BA8QWZbwPBh8c=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=CpDc5uSMAjOIaXm2Hom9jvMOt0IsuB+BvyWc9oGZJLKyZk28R4p2tuOq8VWuOI4eBf67GLSBpsyhxyExfjtll2f2H7RxsHLqEbWfOzIM4xhfjQTuv73u1SM7p4Pumb5ein65hlk5s2ZhkRyJ0gs6koFuyYJ5+ayPF05okLaqjYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lkFpGdZE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zj7EVS8z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lkFpGdZE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zj7EVS8z"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I2VHYq3947606
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 03:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pZzoyqak6dRekqwGzfZGzciKQDbhiBhx9cmS2obR3HQ=; b=lkFpGdZEVmwgv7cd
	DdZ8G8pO6QDFB+cDUAy3K1U361OCYNU7RnS2hTFfV/h7sOCt8DvmvVf+LqPyXIJw
	MGqAgoe6NS/GHRWWYh+gTJnWTeGLX5UYOn9136R5B1/dWtlj32+1Mvh+up4cBS+R
	QX+P0j9v753wFDhVuYp4WsWyJscFiATWfn0qw3VNpv5rTDNhDPcTbr9ZxlOKS6nt
	WiGaaV7Zd+UywZOkABGjIfcYlpbg9GeJ6g/eYsQB+0YtDtzzCIkufyRaJXYBlugQ
	/UUZflAdfSPvtlcOWharhsjkxGw/vpEyNZkIr9bTMGVF3jQh0hGkX7s7POGNSwKj
	i/tM7A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grfppkt48-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 03:04:22 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39533bb224cso636779a91.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 20:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789700661; x=1790305461; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pZzoyqak6dRekqwGzfZGzciKQDbhiBhx9cmS2obR3HQ=;
        b=Zj7EVS8zGj4GbhR8u+R99tOaEy9+FRVlJdF/VmThiiU5aR/j8RCqhMP7yeK7ALz2yE
         +KAJmy5bpGCOsR22xLeiF7WKedIyixOr4zSSQzPA9TXNHMo45bH5MdW/g8/Lpa5nwa5s
         RPak5/HpQheHVM4OaTtPjwWOYXz2nC9FFVEd3IviJ/PMto8e/9sp57FrggAwuKnrTIcT
         2EqI22bO0TuWY2LEua2zSW9S40IMFQEnaxwHswGXG8EZGiyaGouc8+mLwF7PDeI3DH4G
         pm6ogcVe3hfSe6YkQ+K8WL73MTqBbA8W06/vlsq8TMuq1bmNCnYwdfZ2l35NCN4FBmAP
         vaeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789700661; x=1790305461;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pZzoyqak6dRekqwGzfZGzciKQDbhiBhx9cmS2obR3HQ=;
        b=ssAW7pSFF5OTk6llk5p8/LL3kpgAauOG3F88DBOfJxgH/hp2kAMw3oi7Csb7etPKMo
         wNY9kGzhRzaMVVE1V480lbaJCbIjPSyYGcgFQZ6m1n/r3vldfS3xuBeM2DPlYhHtj8SQ
         0T/6YE8NVvEgCxovf/T5/QvhKy+dMHj2U6QeDl9ZoVlfao59Uc89+pcM+PHEu4KwrYw8
         4BjFk9ROVuvcfEhMBXwW7QoamjQUYMObu9IpfZP6+DcXNY9mK7suEUy45dkrTsuqkpkO
         X/0xdDebzH9f+PxCsvYffGpvIwssbDBbvzqS55wb4fQY4snaebjhhoqYGB5Cfl3tknui
         6qUw==
X-Forwarded-Encrypted: i=1; AKwUvBy7dKwBh1oZM/X+tvR0/IRb2wXBipae+hJTkB1AfixHD489Q5t5xr3u/VM7rju1E1e7fWmRwVw=@vger.kernel.org
X-Gm-Message-State: AFuF++l3uGmM0XW25k3Rw7Sq156c8Md7clEjzZ0xP6vWM+emMiE1Am/r
	gkwXjg+bJBfcFOWgstPzzVU6WAQkjselnFvZ0NeNUmSi0YXpzWqAisRiKrs0DJhp9EN/VCLzlzo
	Oi5VTOC56VHw7Fu9QL0irtwPzf4zPscML3TTr19awNiQK/xRuTZuXYU/TDg4=
X-Gm-Gg: AYBFou2X9pqJ8ETDawwxFdY8ei2jPNB3WLj+74OCNgWOVbmZMqr1hNHKLtURwCHa5KI
	WLpZuw2LC3V8NNP2cc+7HG0py4UMSJQSen1UHzwjJsehQebYxNQMrF41xRGSPWW6OP1UJ7JvNWe
	o+wfEKWbisyT7csHwNaF0n41NaqaHZF+Y4M4RKWZTQjWU6M3h3xZPKUizcEoVDOyidD7PnU4sjO
	Cu5zqFQo1Fc045dnUPAhvpZIJx73itffbWI+0ctvjeoTuU8U0Euza4vAP6EXroU8odLE3aiU8MZ
	VmZYiwEHWcs4J5n6hm9u848a/1oJFlgqxTaNPS3A1SeL7l5D6RIgeonkqITsDP8NMV9FiCaGCKB
	rlrLBekUDwSSpe7vFh7AKZbQJu59ws4c4AP5Zbk/rHHH4RSXlUmxOUsfFCMkclczk9cjzYIVjk6
	fpT3sL4JXu
X-Received: by 2002:a17:90b:3d8e:b0:39e:2065:5f60 with SMTP id 98e67ed59e1d1-39e54f9d37bmr2570181a91.18.1789700661023;
        Thu, 17 Sep 2026 20:04:21 -0700 (PDT)
X-Received: by 2002:a17:90b:3d8e:b0:39e:2065:5f60 with SMTP id 98e67ed59e1d1-39e54f9d37bmr2570154a91.18.1789700660556;
        Thu, 17 Sep 2026 20:04:20 -0700 (PDT)
Received: from QCOMk1gASIiYhG (66-33-8-210.colorado.intrepidfiber.us. [66.33.8.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c287be968sm415452eec.26.2026.09.17.20.04.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2026 20:04:19 -0700 (PDT)
From: <subash.a.kasiviswanathan@oss.qualcomm.com>
To: "'Eric Dumazet'" <edumazet@google.com>,
        "'David S . Miller'" <davem@davemloft.net>,
        "'Jakub Kicinski'" <kuba@kernel.org>,
        "'Paolo Abeni'" <pabeni@redhat.com>
Cc: "'Simon Horman'" <horms@kernel.org>,
        "'Kuniyuki Iwashima'" <kuniyu@google.com>,
        "'Andrew Lunn'" <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
        <eric.dumazet@gmail.com>,
        "'Sean Tranchetti'" <sean.tranchetti@oss.qualcomm.com>
References: <20260916132231.1780091-1-edumazet@google.com>
In-Reply-To: <20260916132231.1780091-1-edumazet@google.com>
Subject: RE: [PATCH net-next 0/3] net: rmnet: lockless rmnet_fill_info()
Date: Thu, 17 Sep 2026 21:04:18 -0600
Message-ID: <000101dd471a$661ad820$32508860$@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEEHsjaapFBvZbqB3mwS59lg6R0LLiF9v/Q
Content-Language: en-us
X-Proofpoint-GUID: nnb7pUKwJFNeXEdNC9sFbL8FLFDO8bcl
X-Authority-Analysis: v=2.4 cv=YcYodARf c=1 sm=1 tr=0 ts=6aacaa36 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=OltkOWFNRHEXGe+8VJKHzA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=1XWaLZrsAAAA:8 a=J1Y8HTJGAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=rSLy-HuSy9LtjwZSASsA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-ORIG-GUID: nnb7pUKwJFNeXEdNC9sFbL8FLFDO8bcl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDAzNyBTYWx0ZWRfX7nD1xvoIrVzO
 YbXdqvfxRyTyZt48RNbCZ+KA6MxKVDZEQbs+z2HpY1DfR60KfMito7ZFxd8nyhNkSTKVuEEwGvK
 zDSPl7gvGBemrCucKqMUPM8v558ctxRpwAXew/viS8lvKuZNYQYAXRem4RbcddgXQA1R5rbgdzc
 G6qD/Nwj61hlWGwxBeiI/NcebPA0qUPsAJ1LltJWiKXhfuaL7WgBtOcLq30jvA7lD0tR6ffZtFL
 4RgoqxQrSnyG3Ah7xWYiNgbSSV4xnBwUxJcpLS7vayVZ85UJvfCSpCSEmwnpzsmi2JTYZAr+qus
 h3xJoCHclu4yt5dwFJzjVFVTY8lQrfvRXrN4f/FDX/xktfZ7bVXROOCrsISy7VsDu44FiEmsjKK
 yzseBRvEWYvSTVGOkARi7K5UmHhB5sNqYEyrEMYoYopybCYSiENBU7+RJWsYmIjc3V8KfG/iGNW
 mV0xYqTPL/SEOkBUasg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDAzNyBTYWx0ZWRfXxFFIkHsqYmGH
 TrqKXqz/4J2hLQaOZVXy0NCyuBWef0MLm/Tt8MmSteIPs/0/F9XbqLVPW4WmVNytAgbWYUFqk8/
 8nVBDqJaAvZGOseNG8GuCjXbxAgX9pE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180037

> -----Original Message-----
> From: Eric Dumazet <edumazet@google.com>
> Sent: Wednesday, September 16, 2026 7:22 AM
> To: David S . Miller <davem@davemloft.net>; Jakub Kicinski
> <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>; Kuniyuki Iwashima
> <kuniyu@google.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> netdev@vger.kernel.org; eric.dumazet@gmail.com; Eric Dumazet
> <edumazet@google.com>; Subash Abhinov Kasiviswanathan
> <subash.a.kasiviswanathan@oss.qualcomm.com>; Sean Tranchetti
> <sean.tranchetti@oss.qualcomm.com>
> Subject: [PATCH net-next 0/3] net: rmnet: lockless rmnet_fill_info()
>=20
> rmnet_fill_info() currently relies on RTNL being held, because it uses
> rmnet_get_port_rtnl() to reach the rmnet_port attached to the =
underlying real
> device.
>=20
> While auditing the fields exposed there, it appears that both
> priv->mux_id and port->data_format are written under RTNL but read
> from the data path without any lock. Note that rmnet_newlink() can =
update
> port->data_format of an already active port, and that
> rmnet_changelink() can change both fields while traffic is flowing.
>=20
> - Patch 1 annotates the data-races around port->data_format. It also
>   samples the field only once per packet and passes the value down,
>   so that both ends of a packet transformation agree on the format
>   (TX used to size the MAP headroom and set MAP_NEXT_HEADER_FLAG
>   from two separate reads), and prevents rmnet_changelink() from
>   publishing an intermediate value to the data path.
>=20
> - Patch 2 annotates the data-races around priv->mux_id and
>   ep->mux_id. It also publishes ep->mux_id before the endpoint is
>   inserted into its new bucket, so that a concurrent lookup walking
>   that bucket can no longer miss it and drop the packet.
>=20
> - Patch 3 converts rmnet_fill_info() to RCU. rmnet_get_port_rcu()
>   was only called from the data path and thus used
>   rcu_dereference_bh(); its lockdep condition is relaxed so that it
>   can also be called from process context.
>=20
> The lockless lookup is safe because rmnet_get_port_rcu() checks =
real_dev-
> >rx_handler before returning rx_handler_data, while
> rmnet_unregister_real_device() clears rx_handler and waits for a grace =
period
> (in netdev_rx_handler_unregister()) before freeing the port.
>=20
> This is part of a larger effort to remove the RTNL dependency from
> rtnl_link_ops->fill_info().
>=20
> Assisted-by: LLM
> Cc: Subash Abhinov Kasiviswanathan
> <subash.a.kasiviswanathan@oss.qualcomm.com>
> Cc: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
>=20
> Eric Dumazet (3):
>   net: rmnet: annotate data-races around port->data_format
>   net: rmnet: annotate data-races around mux_id
>   net: rmnet: no longer rely on RTNL in rmnet_fill_info()
>=20
>  .../ethernet/qualcomm/rmnet/rmnet_config.c    | 54 =
+++++++++----------
>  .../ethernet/qualcomm/rmnet/rmnet_config.h    |  2 +-
>  .../ethernet/qualcomm/rmnet/rmnet_handlers.c  | 34 +++++++-----
>  .../net/ethernet/qualcomm/rmnet/rmnet_map.h   |  9 ++--
>  .../qualcomm/rmnet/rmnet_map_command.c        |  9 ++--
>  .../ethernet/qualcomm/rmnet/rmnet_map_data.c  | 14 ++---
>  .../net/ethernet/qualcomm/rmnet/rmnet_vnd.c   |  2 +-
>  7 files changed, 65 insertions(+), 59 deletions(-)
>=20
> --
> 2.55.0.1032.g73a4cd73de-goog

No concerns from our side. For the series -=20

Reviewed-by: Subash Abhinov Kasiviswanathan =
<subash.a.kasiviswanathan@oss.qualcomm.com>

