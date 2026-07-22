Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBC81FA859
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 09:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784713879; cv=pass; b=H4OXklOeQquSoK6IbmW3nvq2nJ5pLaKzNQruVk4H+f2bOsifsnMgEL5hss6xEfx5U0Z0UHv8SGMGGLvjTqCQq8uuPlC9JAecxPSPou1i+5FGYhEf1o6bocsuyaIjnVr7aazlwogCIO5nFcis6Bgkz4UMh1iLD/T7/Yin7NZ56lU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784713879; c=relaxed/simple;
	bh=JMAKzW6lh3W7yhSLJw4MXios8xY/AsVkhtsKaseXa6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QWiybZbZEdmONavGEL+6becPztyyfW+lfP8/FgYUhDSJqcpeiG14Fw4VIP/FHyI76qLH4XFwMPnAYvd/nrfreoUuWencX0xJWsr22Gc+xJc3rooex7MYSu8zCBeYCublPQ6gu8oQTpWYvvCQ3HGxzTCkI0qR3u2d++cI7lrGoDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=msLQ0Xz/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G0Ht/0rl; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="msLQ0Xz/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G0Ht/0rl"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M8xGOC384364
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 09:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gso2U2cxHkj5k87+09daA+x8D43g6xOSS5Frb1llvTo=; b=msLQ0Xz/SEygGol4
	V2a9/36YMFgdsZ4vmFvla5ffrWqQPaEfPp0i7WUtvBrpwzDo+oWan7sREY75GfP7
	fo7iABSJrlVI/hDhAgf/TccD/Lr+33Z50LgdrKxfwqbg3N75iimItxjPr/yKHc14
	GZhXboofKJKXbf+4KN9jWdco+63GJMr30aupPPS/GH7j4FXXYU6LCB9C+ICSjHoX
	MXuxjE1rt0XWAc5fIRqQ5wdj/N/ktaVhfCg3l/IfZd/ArQXdo79TBkPtj8XuG4SQ
	FH6/JCKicNvfsmv/stKYxoZd8q3BvpiN/FHLI/ypqI16z3EGUZjtrSwBos2OwVgq
	t6WB3w==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjs928pd5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 09:51:09 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8ef8249f871so235223806d6.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 02:51:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784713868; cv=none;
        d=google.com; s=arc-20260327;
        b=oSctH9dk4KjapqSANnB3HDooORbjS4oZF68oASIvFXBt+xIn6Nta+93rugKaMZhfnr
         CoM1lolVkFuUTaOfnzBIl+FOK7slGZZNxfAPcP6zcHFXlEijxahOQ+esXWu5k+9NsG8D
         sI0eqvumyPnvB/kZokbp+4o5TI19ygBVOs7xRKNx7hiTQ7ZvtE9H0WBDjU6M1xGqDFYr
         aFrgOzLRnylyKK1ZJlveba9wVLi5ijzDB1AmhyZBryTTvwU7Oo02/tohuKLqEyeJ77CR
         qc6Gr5nZtvTEGeIjSP/VVQflVpGZUH04+vBWXPyiBbHF95ovC1AJS2zn2/7Hxrr9izXJ
         T/0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gso2U2cxHkj5k87+09daA+x8D43g6xOSS5Frb1llvTo=;
        fh=Sdz6ByufM2IXkllCoVFXWj6RQqS5qyd1S7G5kIxdvRQ=;
        b=bY0rkQY0cjLyjNudQS4rRjwWt+QOSV+FT5kYJdzjxjBu8s/wLfGyA0QKrjffYbKiar
         lNhq4uWWQV81Hkbt2YPTIo0Zvot8OMG2d9MGyk7k80JpDc/ObTE7IzUTpLdFcVjeHHUT
         QS2SI/81hUbADsdHjfGuXBTLc0fA47bGbiKYvPOMfXdBvsv49gskNPIyhZntZbHjVFtH
         NYpXR0E+2Lb5zA9Q1u+4Jyp5tmtYC6k4JRvFj6qaj+Jm9ceurHmHSWRbBouphrjPIYfU
         5S0a4qRbFW5GOmwKhSatOljckW59A2BD7e+smRUHTxi8z2jcDpINBGRjCgtm8ujIybLR
         IZjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784713868; x=1785318668; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gso2U2cxHkj5k87+09daA+x8D43g6xOSS5Frb1llvTo=;
        b=G0Ht/0rl5BeZyZU2GY271fvi0ohlh+dvR68HMbgEddS7oQXytLzLyyNR7xSjCHyr08
         Z/sAV7VxaLn9YfyegeG2r7BxG11nbmeWc8eP8IjUc0bLM4s6kHjeo+Vm9TR5H34v0/6C
         IlpTpJW2uJKbiN9PzZcj0NZIbk1palhTOkMAUL8dF0uWWoOVwg56ONxRPdtWt3CkIKbp
         zotmaRIGrH2TC2C1ycHS5INcyWhT7wlOk2la7g5L29Tppd+6VY/252KoHwicj2KcjRVV
         mVh+NhcfY2c/IQbxMi9G2LlNzyPCknPqUQB7kfYJh8Xzc4idcykyNkyumwiebv3/C9rf
         FqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784713868; x=1785318668;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gso2U2cxHkj5k87+09daA+x8D43g6xOSS5Frb1llvTo=;
        b=H3H+Ki+VLYjoHcMZwsoa9D1U9RnMYw49WXSIpjOZDhPABkwiAWllxPd0FgrB6bypmB
         B1d1qpnRPOKT3cEVNed5VxeM3+f7KQQ8pjV5PrtM3UVczThALsEuaFGydU0gZ7zSuDos
         hsHn/4jt83cPSrmGRKd8J7EQiO4EVV1JzdIOENAXvGFnLVzIjW6V6A4uKq8nb8Y/M5xX
         +hUERBMzldC3Eds77BeimOtWR+cE9APDHLjb2Hnthc7J5T8VSPQsTlnz0ysehEFQGjFl
         dtpY5Xf6T3gUIF593b/DryGGn/y8lNMWMBTptx8wPxS92hsOMZejFVgaGlp8TJaohC8h
         7FIA==
X-Forwarded-Encrypted: i=1; AHgh+Ronz9qJTlJG9vxjqWzommEzh3/V5l3sY/VVG6gn1HuHhjKwTP7sf08cTQJa8T1yrnhTJgmGJP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSrhZaNbuhNDOd54dLqsbCUwnixVHnt4H+zRb2igC0y64ErNpG
	fafBQqmKyk3Ot8SuZzXD4FK/hqmkHPCuzVWe7xSIbW7Pgbh0CVQxswM+e30HWOs50S2o1zGDyyN
	+z+JZI6hYdmLfTURkWK/S8ia0Jzrrj36+Pbwe3ngx3m3hz7PRgTE1VPOSIjAiQnCsHhTViFXNjG
	mwwIs2Y11xAix37PS2KlkCbLvkI558cQVFtQ==
X-Gm-Gg: AR+sD11tDfvGyg1zmWUGMpLuMPlv6Xs1GQLVrxsNsTZPer4Iu07XgO/fUdP6/mAlzK1
	snYOqr+lgjylni5C5wL84j/D/Q9xZZLVFJCOYxgJKByr5j5k9HtXelitqKlPQaqAAcKiTiTPqwl
	W94J4Qr8Ts/vBtjMCOBq7s6syVHn7Re4iM+puCgsMNnG0dGoQA/BW015kb88OSK1uq3KyIvMkS5
	nDYfQGpAEQiOxNxzQKQaVSUcceL7qYHqkM1erXdSaDVY2i8tG5e/O6BezQ0NaLeKJ/i58z2pMM=
X-Received: by 2002:a05:620a:458a:b0:92e:874f:d929 with SMTP id af79cd13be357-930b3e9c338mr2210954385a.19.1784713868560;
        Wed, 22 Jul 2026 02:51:08 -0700 (PDT)
X-Received: by 2002:a05:620a:458a:b0:92e:874f:d929 with SMTP id
 af79cd13be357-930b3e9c338mr2210952285a.19.1784713868088; Wed, 22 Jul 2026
 02:51:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722090931.2637025-1-dnlplm@gmail.com> <20260722090931.2637025-2-dnlplm@gmail.com>
In-Reply-To: <20260722090931.2637025-2-dnlplm@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 11:50:57 +0200
X-Gm-Features: AUfX_mwUh2lUWHyUK4w4YrHf1RZCgRHfJHwiNImm-KPf2Ypn_poB1maeKpZSgUQ
Message-ID: <CAFEp6-1BbCLSWTZEhOiwNqnq2A-3c4SYzsVt7tUiKfnEJrM2zg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] net: wwan: add minimalistic IOCTls
 support also to QCDM port
To: Daniele Palmas <dnlplm@gmail.com>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA5MyBTYWx0ZWRfX6EWgSa4NGlD+
 DBNSbuB1VxV9C9kKPd9xfT9toeKfiq14fFdzN7Im5LdrpmCoYwFSaIXtlDlEY3Zoj5enRq5gjvP
 UYq+igBt0oZFfIdc9I27MhCOvxPta84=
X-Proofpoint-ORIG-GUID: xdUHc8P7tpkHDBha36gLwvW5r8byNQIj
X-Proofpoint-GUID: xdUHc8P7tpkHDBha36gLwvW5r8byNQIj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA5MyBTYWx0ZWRfXxoFF6/+8LNXA
 24A/xPLpLZWYzDFetjmS/Zx3OeP8kBRz3kzjx6DHd1NsMrSSZX5Ku+GqVpJKvg+eM6k/qzBAOYH
 4HZW0yJiEd5/BCs9QOhoDRW4b98ihw29hEvBig9CfyPBAWaQ9l7CnMA4f9HpKdTKEJ67+SKiA4h
 yFUoyUdKPYpuXE8wOOygtbgpm5UFbz60019znBwTtjH3h8L/q90KI0epby++EXDSwykQYKoC7p4
 4+CogXjgen22PvMtrgNJLV6k2R01fEdbu1YVVDe2rcqj+qWReFQXQX0ee4GQBWzBvlSZS3wPCY/
 ly7OVpP19nIdzwRlpMEsU3yBhk/mFQnk7VGPy7OPULjAY7vsD01PWhnIlBat8NXA1pR1dbM96dV
 /cDJyKp9Y80vFCxITkUvGJt1oSWSTCnzGYZLCMCgzB1be6Ep3V755MjPuuDZIjcHBuwbUg7TPNl
 /bQNAzsmR8/Q7SgjsAw==
X-Authority-Analysis: v=2.4 cv=QahWeMbv c=1 sm=1 tr=0 ts=6a60928d cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=laIMyccDeTmSpVvBuxYA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220093

On Wed, Jul 22, 2026 at 11:10=E2=80=AFAM Daniele Palmas <dnlplm@gmail.com> =
wrote:
>
> Upstream libqcdm requires IOCTLs support to work, so add the current
> AT minimalistic support also to the QCDM port.
>
> Signed-off-by: Daniele Palmas <dnlplm@gmail.com>

I wonder whether it would be better to introduce a dedicated flag
(e.g. WWAN_PORT_TTY_EMU) instead of checking the port type each time.
This could scale better if the list of special cases grows. That said,
for now this looks good to me.

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  drivers/net/wwan/wwan_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
> index ccce2ad74128..8168239e52c3 100644
> --- a/drivers/net/wwan/wwan_core.c
> +++ b/drivers/net/wwan/wwan_core.c
> @@ -1046,7 +1046,8 @@ static long wwan_port_fops_ioctl(struct file *filp,=
 unsigned int cmd,
>         struct wwan_port *port =3D filp->private_data;
>         int res;
>
> -       if (port->type =3D=3D WWAN_PORT_AT) {       /* AT port specific I=
OCTLs */
> +       if (port->type =3D=3D WWAN_PORT_AT || port->type =3D=3D WWAN_PORT=
_QCDM) {
> +               /* AT and QCDM port specific IOCTLs */
>                 res =3D wwan_port_fops_at_ioctl(port, cmd, arg);
>                 if (res !=3D -ENOIOCTLCMD)
>                         return res;
> --
> 2.43.0
>
