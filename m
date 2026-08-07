Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075C6384CD5
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 07:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786088503; cv=pass; b=quleudLCR0wil+OjB64NbKyy7bSROeJROLyeW8qlQTOoLE4WZHrcFx/64XgtRSltxNEDBkV2EULdHyOyMQXKAvySAy65xNpBfOUovOXPj5iSZkZvXNyy7lBmRmpwQdEGTwfsYQM+Rzax6D03gRnytyZ76ZJKRJAA9fV6TWWuH0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786088503; c=relaxed/simple;
	bh=5Plns2Jbn5OXeNckqjSXdij6t5RJl7xrBeCtrPo6anI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b0xAfgloWh6UZt6xssidpX8jqMkZ2haF01bkw9PaTw1gL1I5UDbev5ou6Inj5hyhAO86RJMmily28d0Jvuq4I+xoqo1pmnL12uPKyYGkjsILUvKK3nOy85M1EthwC3Xbr00nOV3jrmCu2DqyCYSESgZo+FDhhsuMU1dMiTLL+v8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OIb78wXD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZKrtYMVN; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OIb78wXD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZKrtYMVN"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6777Lb293176986
	for <netdev@vger.kernel.org>; Fri, 7 Aug 2026 07:41:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T/BgbG9+UF8c8tgPOwvq4ZdqnX6fF0WI43EkAjZ6ggQ=; b=OIb78wXDz0sJ9VI/
	gggHtDoRAbsq7Ecu0iUnbcGvpUEtsPcuzCqTnp5xPgx49v2XcEgNm0TxbqdgGLGs
	HRTKnrh9/Jm2jhmlSSzEB0G4zQlKODLufx4mi9ZvVhWQgCw0e4/s4FlrrYCYv6E2
	fnwcxvyD+XyPrwDaEKuIwZCERa4XsAPu6BhbbMEFdHDXj6//DMBCM01yvFQUV8XR
	HiEMMhRCyG/rJJLFCbJefDMZxs18TUjiKzzK+CQPHOVQJx4HS4SrCaUopwd1XQuL
	gdefkfrmymCRc+a/FdhU6LEEMTbzQO/VSOQV2uaBw5LEbs0fn0NyujdhAqyerCuR
	LoOn5w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6jjsas-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 07:41:41 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e538afe65so368972585a.3
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 00:41:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786088500; cv=none;
        d=google.com; s=arc-20260327;
        b=UkagxHquyD6YgWuGLuaYJbOsylW68BFXHNrH5G0QBcnMe19CvsR2teBy+9+SRvxf/O
         TfSw3JUTJxunqlL9Nyw/T+uAfSlo0snvJZz88NjGya2HX7+HUaD7CkN8rY24NiUVW1BK
         7d4NmGra2fSgDaOPxeqPdyWuvXZ3A9lY2LQXtNNANCFjQ47c/yV3WYzMmN8uy7ymkl2Z
         n4aOD58dtJgwlJMZJAYB+stV6fCyi/fHUZi+/BBRVdHxUz5aqU0iSrhEos4mQFjfFAni
         GSpp9bCTVzlWHVjhk64rCe3C7n6BFypsMV9LuNXGP6KAOBUpj7ekXrgv3adcMh31OSHz
         toMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T/BgbG9+UF8c8tgPOwvq4ZdqnX6fF0WI43EkAjZ6ggQ=;
        fh=LOwhjXL/ika9vR6NlSyy0vVSTSa1pyXG5q+MjAkKD4A=;
        b=n2l5PmIV99oVpE4oCt9zulFeH9U9M9VH99vDVCW76z4aB31KVjivvqQb6Cyr1vwC5L
         K8e6+aGvy+wGFRcHVow9Ynu+kXDARvfTFspBQMJ5xvbwPFHhGMt1uupwbmVH66GJ+9mv
         lPu2+LwcwquLZge9ocDWpR8V3sm9IO9EuBVCLXJCA6kU2bhGR3CThpenLggsIlcTOE6O
         u+3COg3f4UpqekZqs8SHzITrLB+g1YeP/81qEXweAfCWWKLIvAW6nl0upcOKnVTPX+xX
         u9EjsuQBXXL5tZL/ksN69kenr3mXxFCgR4OhsM2t8zwrsEZ5n2KhNeYa+lqTzamUelAr
         fKOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786088500; x=1786693300; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T/BgbG9+UF8c8tgPOwvq4ZdqnX6fF0WI43EkAjZ6ggQ=;
        b=ZKrtYMVNVjlcr2yfqs49t+GBld3N2W09QDPfLqbBLn2tnM7QIe5IFEHLLgZvIU5awk
         dmvBTby1iKcG/Die5JOZFvsZsxZSp8iOONNt+rteQPEWgmNCAVNjlqfPxzPK+VRpPrnM
         RgGebjpqgeUt01vzvPyXPRDFXVDlKPvqoI+WJeMNu+nJ2TxyQsPX/fF2OF1D66mj7S1e
         G/TMY1FLgI2BczRf3hx3oirCWmfXIfhAAmh/CZceepamWfwYJJtOpwPyrenePJKT1reF
         EUZISUzz68YiwexKfTeRTBiQCsFdjwZ7FiMnddRR9PJK6xFN50l9CtdZ0nJVg1scN53p
         +vpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786088500; x=1786693300;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T/BgbG9+UF8c8tgPOwvq4ZdqnX6fF0WI43EkAjZ6ggQ=;
        b=FCo7WOX3u1RpUpeWpL19ZnqOWxVQnuyY6DvOVKqN/2jns5lWMI5T5rvEvA1KogI9ti
         U7fE/7gVfIXUxAB6SuZur+FxpugHqNjuaKwRQ3LpokhD2cz+/FgGNMN/FbWUAfyZ8ePt
         kuk0KtMrNDwjAAN9l+k7DQBJ/al0EdFngirbm/mwjW3T3pjXvtLHTim3qLoupITX+efG
         /RRfW7KJeE6stoiCuHhX2n9r0jAcC1BHmsmYU0QNzBhVgm2BnFtVTirYecQ3/xCBsFsr
         waXUL2o31z5FG529jyRa6/Yfbki9dd9rbSlGib0FFu+e9yZs7RCf3pNK+pQIWJaw70iG
         yf1Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr2ynaxmb2NoqyPMy+PtnkdPGQsNRP01VoEb2Bov7+fbYz+8Q3k/hxQ1Xczn3zF6QSs0aVxli8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqO0ozKgm+JCDoSyzEQYxm07K6nrkB17ajyWmxiIyF+wFpLUmg
	8yxKGQp4Ljso1//yEo4fUCrRHhDv+YAQ7MIVnPhHBESmN7PCFReUMpjnW5HTWJDAvU42DWAedtl
	5mDwvnDwOLU3HkF1r2n1CuJ8qH4fK/ywvExfqjqaVZ8bJqNjCcj5ifp06dEvIEvDPk+KA1EY+5u
	+/2TaPpDCJJMiUiXn7fLl/IkdgKNj0V3MVzQ==
X-Gm-Gg: AR+sD1351AdYTLnVP86Nt4BXM+uvrAFYf80YBliqu4c6kYG6mioihz2w1fuA3wmhJwz
	TjLSVcJcMrJgIR1mPf0pguhbqGAe/ODmqlopjdSBQzWdMAlIBAKXObf3HD2kMSwIzKbWWI3IAyg
	J9dvZ8ZUPFp4kvMIMFOtGbjwpR9FhcrZ9zEjMz0J+LEQmCqfiU8jP1qzxuq4wWCRA9DxZBMTtd3
	6tB6FEOpgEL9XPxCNmK7wsufnmhbCeFgYxN0i2RH6T7MMK40UWpcDgnra2JRvcccPx8fDCdAJyv
X-Received: by 2002:a05:620a:2727:b0:92b:45e1:b04f with SMTP id af79cd13be357-936491044dbmr2232183785a.5.1786088500245;
        Fri, 07 Aug 2026 00:41:40 -0700 (PDT)
X-Received: by 2002:a05:620a:2727:b0:92b:45e1:b04f with SMTP id
 af79cd13be357-936491044dbmr2232178185a.5.1786088499249; Fri, 07 Aug 2026
 00:41:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806155253.3378294-1-peter.hunt@opengear.com> <20260806155253.3378294-2-peter.hunt@opengear.com>
In-Reply-To: <20260806155253.3378294-2-peter.hunt@opengear.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 09:41:28 +0200
X-Gm-Features: AUfX_mxCtqkSFWdj7GM9fR_-pQUhQERKWaj5Jiidgbbl_nueqlv0AhnjQRgWYWs
Message-ID: <CAFEp6-3UaCMkW4jSmV0ezHBUwisj8zgTTbisuFHR39KJ9Gi5iQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/3] net: wwan: core: propagate modem control
 signals to port drivers
To: Peter Hunt <peter.hunt@opengear.com>
Cc: mani@kernel.org, ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
        netdev@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA1NiBTYWx0ZWRfXxOulp2Yt0eGb
 HND8bna6ms87gIHVxxtAyh1mjTAgqllpyDEpg3KCrmeVfLVg9k5r4eMLyfN9VAIE38sU7wwWlwT
 GCH3JA8wUs7SYE9KHeR/0gYPxvVrOZyT0O1RGWK4RAZyeqp2+iKT8mn1FKuVY9FazYTi5Ca9Y5Z
 7eNu7ML6wNCeLB+RDZhYDO/yyUVULP6yppb3mFVoS/pmxVaSskY5J/pZDvTA7UPXIfnvKGKQHKl
 Qs8O/s8M4A5rPG1mzhhrviZcFMN0F8J+dOlup89MdfTxJAKunAA8GJl41POa70LB8TlelwyoseF
 mcs8nv5t66prfDniXYM/u6Wmg+XTF8xfPRg7Ly317gRPBFDTifmkkGbIl/OSdDa40WYTswGD1eT
 efTJftxxN4znNw/sMtioY4kSLpA+vhWdJ8HDzthjmP19CAiYiYtNaxTeW/57qPtpy3BMzGXj1ON
 1z5UC0N24S2bIyv3B6w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA1NiBTYWx0ZWRfX73jTkIe/GEl3
 kPF/ybwiE6DK8N/Pdj3kqWIUGbwSBDt1azYpXrcuDXxAH4nLVzT5Tchk4vSvLegykn1qY0LWWrj
 Fwsu9LfVdZEwP9fDR4YwBpR7shM+HTU=
X-Proofpoint-ORIG-GUID: VD8D7XXqZhAkGq6-_f5-A5M9TaZeoZmu
X-Proofpoint-GUID: VD8D7XXqZhAkGq6-_f5-A5M9TaZeoZmu
X-Authority-Analysis: v=2.4 cv=e5Y2j6p/ c=1 sm=1 tr=0 ts=6a758c35 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=t2vznHeBAAAA:8 a=rCPLLavBaKGQfHEBtq0A:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=V_BghkRpYkFyHJIZkSH6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070056

On Thu, Aug 6, 2026 at 5:54=E2=80=AFPM Peter Hunt <peter.hunt@opengear.com>=
 wrote:
>
> The WWAN character device emulates the TTY modem-control ioctls
> (TIOCMGET/TIOCMSET/TIOCMBIC/TIOCMBIS) for AT and QCDM ports, but the
> result is only stored in port->at_data.mdmbits and never reaches the port
> driver. A driver therefore cannot act on the host raising or dropping
> DTR/RTS, even though some modems depend on it (e.g. they withhold
> unsolicited AT result codes until the host asserts DTR).
>
> Add optional ->tiocmget/->tiocmset operations to struct wwan_port_ops and
> call them from the AT/QCDM ioctl path. ->tiocmset is passed the resolved
> TIOCM_* bitmask after BIC/BIS/SET has been applied; ->tiocmget, when
> provided, refreshes the cached bits from the device. Drivers that do not
> implement them keep the previous store-only behaviour.
>
> Signed-off-by: Peter Hunt <peter.hunt@opengear.com>
> ---
>  drivers/net/wwan/wwan_core.c | 12 +++++++++++-
>  include/linux/wwan.h         |  4 ++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
> index ffbcf11e4e68..bf83eb5790fe 100644
> --- a/drivers/net/wwan/wwan_core.c
> +++ b/drivers/net/wwan/wwan_core.c
> @@ -1018,7 +1018,15 @@ static long wwan_port_fops_at_ioctl(struct wwan_po=
rt *port, unsigned int cmd,
>  #endif
>
>         case TIOCMGET:
> -               ret =3D put_user(port->at_data.mdmbits, (int __user *)arg=
);
> +               if (port->ops->tiocmget) {
> +                       ret =3D port->ops->tiocmget(port);
> +                       if (ret >=3D 0) {
> +                               port->at_data.mdmbits =3D ret;
> +                               ret =3D 0;
> +                       }
> +               }
> +               if (!ret)
> +                       ret =3D put_user(port->at_data.mdmbits, (int __us=
er *)arg);
>                 break;
>
>         case TIOCMSET:
> @@ -1036,6 +1044,8 @@ static long wwan_port_fops_at_ioctl(struct wwan_por=
t *port, unsigned int cmd,
>                         port->at_data.mdmbits |=3D mdmbits;
>                 else
>                         port->at_data.mdmbits =3D mdmbits;
> +               if (port->ops->tiocmset)
> +                       ret =3D port->ops->tiocmset(port, port->at_data.m=
dmbits);
>                 break;
>         }
>
> diff --git a/include/linux/wwan.h b/include/linux/wwan.h
> index 1e0e2cb53579..bac02521e274 100644
> --- a/include/linux/wwan.h
> +++ b/include/linux/wwan.h
> @@ -57,6 +57,8 @@ struct wwan_port;
>   * @tx_blocking: Optional blocking routine that sends WWAN port protocol=
 data
>   *               to the device.
>   * @tx_poll: Optional routine that sets additional TX poll flags.
> + * @tiocmget: Optional routine that reads the modem control lines.
> + * @tiocmset: Optional routine that sets the modem control lines.
>   *
>   * The wwan_port_ops structure contains a list of low-level operations
>   * that control a WWAN port device. All functions are mandatory unless s=
pecified.
> @@ -70,6 +72,8 @@ struct wwan_port_ops {
>         int (*tx_blocking)(struct wwan_port *port, struct sk_buff *skb);
>         __poll_t (*tx_poll)(struct wwan_port *port, struct file *filp,
>                             poll_table *wait);
> +       int (*tiocmget)(struct wwan_port *port);

You don't use it in this series, so please drop.

> +       int (*tiocmset)(struct wwan_port *port, unsigned int mdmbits);

TBH, I would prefer a dtr_rts(port, on/off) callback like
tty_port_operations. the tiocmset/get generic handling can stay in the
WWAN core.

>  };
>
>  /** struct wwan_port_caps - The WWAN port capbilities
> --
> 2.43.0
>
