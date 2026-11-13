Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794558051;
	b=bWNKz0qITm+Cd/KJbkKO196w+sLqQ4xXmE2xrhk8yoCvckYoYOF3XeASb/Px8Q0JlILT
	 OIiHyCmsHJraAMIIRyWERXvbQKI3Yf3JVKpH6mxDEzRtC7xs+3YhZK+xO8P0lJ2mFrpE6
	 nMlRyC2SG/8uAKKWbq5LH7LYmyZUZODksJ2QvgNMI45TVw/Z8yGkSdzcHokjM9oJ/L3EX
	 6/rKlG7lOY5bYr9bGRYC9N1nuiw+kcPAGJTU2o/is/XctrlCgMywdPz37RaUSUeRVcF5W
	 vrI6aIeNoI8f1A9EZcfkCx9nDiLpGKGffYzF4qjo2cJcp+2zhbDlQduqv4reiOURhmg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794558051;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=XFYXmBM3beK01ZGcVGJ0do2CSzGN1dZpDVgbJR1vAH4=;
	b=y8sIh1kQHKuf398/56Q6GUmOWRV2Ms/5OSe/vhhvhRfRmHVT+yiQB5H1Za0EmUgD+ist
	 Lw+fktVl9sGvmyVDCYPC55AVhAVdh1u7J3sqat7UL43aGDe32e6Duahvyu1KE047pi3jo
	 OIy5W6mnF/nUhfWMQpKAf0B9qU8b8CEUlD74tqXIR63vqsjgJVpRJfQOlPmVVMf0lqyDY
	 A2wp6ZYTBkjSCVTJGOgRdtxiy8BjYGpSKDgBRi7SohHVSvdtWJvJBsaXFw50Rh568Syw+
	 7pZNtIKE0fLNw5dMNMMjb0TjdxXLT+ZO0gPOMxxzNMIaLMItbqMKxT0zwbNDPpYLC/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SQyGzo3d;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CkkDEjcb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EDA606A887
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 08:20:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10EDA606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SQyGzo3d;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CkkDEjcb
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD57F853120089
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 08:20:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XFYXmBM3beK01ZGcVGJ0do2CSzGN1dZpDVgbJR1vAH4=; b=SQyGzo3dFe+5zfog
	nN8OwwEbdkrzvoq46W7XpgwAL0bsXYvS65f7zMociduf17yGOxhIeiOzPrWsPMot
	X8dH+P704PuMZfFthXM5ba+tTp2hcmgq0v2e6UJdYCyltXfNqpl1egj2ns8rJS+0
	u4g4FR6X72+uHanZkPzv4dus8WaIAZuDuwS41hXQE1UbhLwMh+OMFy6TqQGb2+Rw
	orNcPgrwbz9zDr8WcAx9NRUfxEmFqxMJg8Zg61nN5Mn/UWny9ujQ8iVuB+BqztOp
	dPw7tDqQaJwsOcaMTVfKFtwJ8UoYiOmMpXNMtPJATEppmjO3xEjMbgJGmbnGtuoo
	uxhFzg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwkgwa5ph-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 08:20:49 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f6f4fe531so124157185a.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 00:20:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794558049; cv=none;
        d=google.com; s=arc-20260327;
        b=b90pZ0EjPoMsP16YmycTRSEncwHPtqeFzyW7MUJ0wzGKPmGBmqryAi1Wg7wuqlKVc5
         IaUK+VRg+/uXjhwKfPSE11iKMOVDN72IySh00rDaWIu2HnBmxPP9TTVyzVPm8CsFwzmu
         vcBNG83JoPcspydp3Xvsyoj7cHNaPn+XMSSvSlzrB9SEZX38yXnNGuAIx3RVRi6x72OE
         LVDW4oPxEVCo+s6LhjFJU1OFer+fshpybJYHdBXBYcc7rRwWkXthJbGG6xRnUeETRTyT
         +atUq8GSwz8dhY2h6G1ae3Z2ka/5yDDx3AYCfLXid9423G6UVPg19O+8i6ud+UzC8Uw+
         +8gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XFYXmBM3beK01ZGcVGJ0do2CSzGN1dZpDVgbJR1vAH4=;
        fh=T71BVySU0RFMGwUNw4d1f2kAb3+AyJeqKnhqhCrvpag=;
        b=dWKeZqarcowPzEqpE+zD3zNHzBVbHrZGCpw0r94V/wr1g/ZfFC9tDcedqUaerFomB4
         U7rexqjdalpMatH6HM+AkX6XvpDMg7IkdTWO2zlrTSixs6utzwmwIdWbdDm5A7ozElJM
         HxD43w6VsBCHDJ0FmIjf4TUPtbVPCGz1K8IwkI2gvKa06fKfjF6M6gD1xu9Y1yansvTs
         CXexRimXWj93Nzjd3MQdVjJrKyLYGsJ2jYUtil89X+K7OqrWynS8JNTiydacVYzGPuUh
         mGh2JmPcvp04NsT/Q0Gp1Hjad81hE98QG7XqN1x7R8I2fE+elXrnyRCH+VbbAi26rLub
         pCjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794558049; x=1795162849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XFYXmBM3beK01ZGcVGJ0do2CSzGN1dZpDVgbJR1vAH4=;
        b=CkkDEjcbFzfOPn48T29E4XMUIGKvORKWucj04n6LZ43yvI+eScN2a88NLP08iS8MmL
         a31u4+2+/WFESSLgyn5EgJbQGtX1UFXPXzv8leAPkypkT8aDZz/O008Yo93LgQPZBlZ1
         M8kqMWkiGKXNOKmeMiJAMuyhmKFZIfFNV1LlBfsQl4uvirX3uvW+1+ZC38pRmvvpx+6c
         3rHpduFkKnCL/ANKcdqad4rnOE9bnJF3iZ88Q1XNPRd7SaCrGn/4T8ivsQwlV7rovGsq
         wGicfsabvmj3nFr4ZgRndT3kTld/XeEFUAp6AAWMTZhX4HhHlJt/4GOCckOva7zkGNdZ
         58YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794558049; x=1795162849;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XFYXmBM3beK01ZGcVGJ0do2CSzGN1dZpDVgbJR1vAH4=;
        b=WUP/eKqF07UMLzPyuVkH6VLIpdSUwRH+CBFDP2AgLwhUdmmSAzIP2jphib+CBMyHlz
         O/hZr3LCOhzYlq8fZzynxsDdbpBPswwVKjaCDHBoiDb9ExFZqhy2OkbrS8YrsQ/QoMb4
         b0iSxcR0wBfa5T27NZ82TwYA21LXGN4yn1Cu59tjmWvWiQHMUNeYPgTCsRGFTa4Ctrq7
         Kar09G5nb/BSgc3slTZZyhOdX92cz2g5PdumW9tqIpGPcUdNsJB/JSlnp+tdXWOEBcsj
         YjmoWEQatysJP8fWrfXfXJbGLb/kIL/IIiZ6CsNbhLqmgTBH2Yvb6Tcuyhu/6UT2wyLG
         0YIQ==
X-Gm-Message-State: APuU4Z8O7K8Hb9mN+2Sqz+rUbZh6nCUB2nxTmTsBe/1v25bHBJm2HBcg
	m2XXeB3zXEh/BqMw12JMdv5ZtGQ4UZM9mepllpQWvfJJ7cGY+hMxeQHZpCOb13KWntBjBQoWh2b
	cSWNL9Kxt2q+iSL9Qh24DqAVP8E7jmGmnp/WqW5OrY3wipfNQroBXEF2zWwLV1o9lVD2Z7nXmmQ
	NfPFDLpj7yNSm6EHZKMYvCp04KcI95geS13A==
X-Gm-Gg: AYBFou2Icwe0GkP7iWSOD1Yq1leI8GcMgwWkwB8ymBt+zvMf/dZ1I+qf7Sw3UPbtNE3
	Erxb9Te5D9ab8xut2p5Y9neo8UgLjq2fxwlvaAitnkuVs9ImBHjbNFOT9ayD1TlVp3Q/+XMNOT3
	0SIWsErbJsf4b4mM1HqdePRX0S60cGkugfXucKMcWyLBpokiM9979RHFWhr6YFADxfShk+/olya
	kZYCR673WGrtCnE+bpBqmCXmOt4k2M35Nq2Jq7KcRbvCmTz5WK6rZGMu/AcZYP/KQbc1CdB4M5D
X-Received: by 2002:a05:620a:84c9:b0:93f:38c7:70f9 with SMTP id af79cd13be357-9494baf1d7cmr282457385a.14.1794558049076;
        Fri, 13 Nov 2026 00:20:49 -0800 (PST)
X-Received: by 2002:a05:620a:84c9:b0:93f:38c7:70f9 with SMTP id
 af79cd13be357-9494baf1d7cmr282454985a.14.1794558048627; Fri, 13 Nov 2026
 00:20:48 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112172216.31216-1-peter.hunt@opengear.com>
In-Reply-To: <20261112172216.31216-1-peter.hunt@opengear.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 09:20:37 +0100
X-Gm-Features: AclHuK_VsT7MGcrjPSVsxGRM89wc3nUaQBJGo9bMnXSTTDtbrrI2RFJv_8YmQ3Q
Message-ID: <CAFEp6-1-CY=fwfR6bcg51Yp_LQS61Ugr2B1yik4s1=vpQvVO6w@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: wwan: mhi_wwan_ctrl: say the DTR drop
 flush is best effort
To: Peter Hunt <peter.hunt@opengear.com>
Cc: netdev@vger.kernel.org, ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
        dnlplm@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=DNgacCNb c=1 sm=1 tr=0 ts=6af6c861 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=t2vznHeBAAAA:8 a=EUspDBNiAAAA:8
 a=jPX6BhtYR5YRs8dJ7DcA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=V_BghkRpYkFyHJIZkSH6:22
X-Proofpoint-ORIG-GUID: xqJ0C0yEUVwnpYkefuK_bAQabq4P5mBT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzMyBTYWx0ZWRfX5uc7jiGN+a9N
 hqLoXHnlg+aIOjlDZxE1Emn37TPn1J9iegie820LGiN71CDBmXrbMe0W6Snt2LnnC2PCvocxg0w
 8KELhJCme/O2Ar0I+FMi0Z2TmjgjecvdOGSIjWx127Bip+8I7B1niHOjYWpW2YkMCShVFB7iHBj
 L5ZoIA4pp1MHgvaRncA+OWdnGe85XseorRcJLsHHu6JEvdFK5rIBf0rH4YykK/c9x2qT9Dawr2I
 ogZwiZ0CJwgtF38uuNJO90PNyNjLSrThOgm++nBgAVV7bXePlupdcULQSsNkLvzgIibj6Pu3M2k
 ZhwvvRVzdpO7hO1RTy7hFsoiceRBVt3XAZI7wbQWCNvW9LblMA19Hdu2f2KLX/8T5y756t61Rzt
 Ss3mRVIhnKXa5xrii5Wj8c8UGo0nFBFM0MgPD+E1anRzUmiDLDk2W8QqCy5tGDk+Mhyd90Id6Xn
 uVawCjppIVLhQK2xbKg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzMyBTYWx0ZWRfXwQ56i8B7Ny0b
 IynFJu6xF3hwmM2q8JChDaev2oEc4xUDHj0Q2Pxwu3RL8X/9UKrx6NJ5VaIBUQ8yMK7q791r1xY
 C70rj2tQ5OAgEN2AsJ8Mx1VLGyOZszw=
X-Proofpoint-GUID: xqJ0C0yEUVwnpYkefuK_bAQabq4P5mBT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130033

On Thu, Nov 12, 2026 at 6:22=E2=80=AFPM Peter Hunt <peter.hunt@opengear.com=
> wrote:
>
> Four comments around the DTR/RTS work don't match the code since
> commit 10f51f4fb99d ("net: wwan: mhi_wwan_ctrl: send a DTR drop before
> it can be coalesced"):
>
> - the ->dtr_rts() comment says the drop is sent now, but a drop that
>   hits a full UL ring or a failed allocation is retried with whatever
>   state is latest by then,
> - the stop() comment says pending state is sent before the channel
>   stops, but the flush there makes one attempt as well, and a retry
>   goes out from dtr_work after the channel has stopped,
> - the dtr_mdmbits comment only describes coalescing,
> - the remove() comment says the removal drop gets one attempt, but the
>   drop and stop() paths now flush the work as well.
>
> Update them. No functional change.
>
> Link: https://lore.kernel.org/all/179340002701.3131.15535297427661129303@=
kernel.org/
> Signed-off-by: Peter Hunt <peter.hunt@opengear.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
> Changes in v2:
> - Also update the stop() comment, its flush makes one attempt too.
> - Name a failed allocation as well as a full UL ring as a retry cause.
> - v1: https://lore.kernel.org/all/20261109185731.182990-1-peter.hunt@open=
gear.com/
>
>  drivers/net/wwan/mhi_wwan_ctrl.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan=
_ctrl.c
> index 772319927867..387ab1bb0c41 100644
> --- a/drivers/net/wwan/mhi_wwan_ctrl.c
> +++ b/drivers/net/wwan/mhi_wwan_ctrl.c
> @@ -68,7 +68,8 @@ struct mhi_wwan_dev {
>         unsigned int rx_budget;
>
>         /* Latest DTR/RTS state for the modem, sent from dtr_work so a bu=
rst of
> -        * changes is coalesced and only the final state has to get throu=
gh
> +        * changes is coalesced and only the final state has to get throu=
gh.
> +        * A DTR drop is flushed out on its own, see mhi_wwan_ctrl_dtr_rt=
s().
>          */
>         unsigned int dtr_mdmbits;
>         struct delayed_work dtr_work;
> @@ -216,7 +217,9 @@ static void mhi_wwan_ctrl_dtr_rts(struct wwan_port *p=
ort, unsigned int mdmbits)
>         schedule_delayed_work(&mhiwwan->dtr_work, 0);
>
>         /* A DTR drop matters on its own, e.g. to hang up a modem set to =
AT&D2,
> -        * so send it now rather than let a following raise coalesce it a=
way
> +        * so try to send it now rather than let a following raise coales=
ce it
> +        * away. This is best effort, a drop that hits a full UL ring or =
a failed
> +        * allocation is retried with whatever state is latest by then.
>          */
>         if (drop)
>                 flush_delayed_work(&mhiwwan->dtr_work);
> @@ -254,7 +257,10 @@ static void mhi_wwan_ctrl_stop(struct wwan_port *por=
t)
>
>         cancel_work_sync(&mhiwwan->rx_refill);
>
> -       /* Send any pending DTR/RTS state before the channel stops */
> +       /* Try to send any pending DTR/RTS state before the channel stops=
. This
> +        * is best effort too, a send that has to be retried goes out fro=
m
> +        * dtr_work after the channel has stopped.
> +        */
>         flush_delayed_work(&mhiwwan->dtr_work);
>
>         mhi_unprepare_from_transfer(mhiwwan->mhi_dev);
> @@ -376,7 +382,7 @@ static void mhi_wwan_ctrl_remove(struct mhi_device *m=
hi_dev)
>         struct mhi_wwan_dev *mhiwwan =3D dev_get_drvdata(&mhi_dev->dev);
>
>         wwan_remove_port(mhiwwan->wwan_port);
> -       /* Give the DTR/RTS drop from removal one attempt, then stop the =
work */
> +       /* Give any pending DTR/RTS state a last attempt, then stop the w=
ork */
>         flush_delayed_work(&mhiwwan->dtr_work);
>         disable_delayed_work_sync(&mhiwwan->dtr_work);
>         kfree(mhiwwan);
> --
> 2.43.0
>
