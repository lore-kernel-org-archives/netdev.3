Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793177496;
	b=cWrIfJyqu3N+IEzq28EqKgRaHDqLzbIU0FTSm82N2NJAQWeHSe4S8BxEBBaKrHwqkmyr
	 MFQlr2XmQdPQ02GXerwrg1xD3NZXPYU2Ty3826/3SO5biHqQaWqFDunHUZCLExq3/kiPh
	 5Z/HATEKHvHFexFkPMbOAmaxwuYoiwvOkyTZJ9Mw9g5dTFMZC/Wql3xTNWvYqsHGa9BMO
	 YGEy4iUAJivyGYtWhl2XSrAPMg0IrQiPHyMfDjVWZkHZqHtjTtODD1Z5W4D22Nh6Vv9FE
	 SGCanvdJQUkXUXuFYxdacCMaPRBQVN4yZ7uAaAYzGOSxS60WYFSmfBod1K6cwd58L1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793177496;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=dtaLCG5DfHiNQ60mEm2A+W71f2WlufqY+/mbeyVW/yk=;
	b=zZPHfrVjHGEm7iq50GDe6C9TY/FzVywCxHHvkeFQUWr0BYMiu+w5zscbHoLThSfhwfdh
	 nl+W02hH6gqTZVOksx+GzWan522QDlCo1g2LB75PX8ADcFGvWWXsJBCG5aUStXrW5FKGa
	 FlqHb3v1fre4QQNvdfx/MDkgdkc8XQIJkWg0WOtn64d3wCSTjFiH/2rIszRp1ujLz2Iw3
	 HooeKoAGRhxZHPB5vMBYeY0Q/baAVpyeh+WIxN8ZOvOsRDH/Tsx3a1/g6oGVqvuDkqjLu
	 J3+/X2oy4BdbOybZcxZlQ3eyXICVrz8NXFsztXXN2Ndi9V21H5ioLxrjUSW5K23Pttg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DQ0SBYvN;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IGGA5y1W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE43606A31D
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 08:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CE43606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DQ0SBYvN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IGGA5y1W
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8KCNr1642992
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 08:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dtaLCG5DfHiNQ60mEm2A+W71f2WlufqY+/mbeyVW/yk=; b=DQ0SBYvNc/aXtTL5
	TSUsoM0rjgb0k4pGqQql6KcsnnkVgAi9bbYntJp7F14v7JAFIArMfr22V8XBt7wc
	P9JPKEXKaWmGV6bf1cmpQFe8vhsNhJidk3xwr3Q+HGAqGU4HEO2Z7ZUZ8MEGtVjl
	IdfkGoDW95nYuDT1xjQZiEFTkuO+LFMR23Dqf7Do/d0cLtz2ecuz86U2/mUJRrNo
	ZpKMcL14UjgJtGRuxDhadN0Ro/vpYdpfgvfgKToel+2bBCm+ZyJFt7N3eQYAeMFC
	QwFBUNdJlflvTsIISrxVY6GoMJ4jLGK74LO0X5FeaqArHdo/J03KZ3zFMgD/rjo5
	ANAXgQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjyjpu68a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 08:51:34 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5337b591609so11675161cf.3
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 01:51:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793177493; cv=none;
        d=google.com; s=arc-20260327;
        b=WH6B1A9An5NFDRzhIyfzvML59MzmvUTkEzTSoqk2e+S4KqwyhbufBqK9q4sqjnExQR
         bjtuMXaZ5Ors9qr0Wrg2nzX5SvtKqmk2faH3RUruFME+A7UuhDyCii8/9lyfb/sHgZO2
         LPNmOPmtjlS5VmjFvl0XSXN4+HMzDVBXmpWd6u6fUdgW6cvWJHr3Q7X/ysIkpXe+uH9J
         Es71y0XM9GYNZPDsiSoraSTgHw7PvHrZt1K3YmOUrDV37RV/KvZ3PZIetMmxsFItw3Zn
         eip/5Hqgb1JMbrGCbIINMa3aQnAcJHKYkKa5d0K3oEmk+J6LdaBio70JdZSXLeMBBHPG
         VhIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dtaLCG5DfHiNQ60mEm2A+W71f2WlufqY+/mbeyVW/yk=;
        fh=UiOTY4SZLIfgtq71rs+cRgNDeAq6GUmoZbS8bSJZ26I=;
        b=YB/XFFAeZR0mCDdW+yjSeukOknKbNPG0VPtz4OW6aU9mkIeI+ZOgwvUK/GySGOGbQN
         mpcPGPID12Fw3PLV8ruN3CSo3tawF7RpImW5+G0qPyjqajcaNflPa+RfAkMMtJzaZErN
         EZz3EhBsCm9lX5C3QrVFNIKpmR91KfFCrqh7pGw5vNr3BVasYR/azwwVm64QpaiemXTO
         Km8U3TCLayJPFoHYDB4PS3XAd9Ztu81ooPqdyubJkH6Di31uFTP7i2msrnSyTCgLAZxH
         3pDRhvclCf8nRj6j3pazpvhPnpf4SccKpoY0t9Rnj0FIF0HNVepz/RsCZf6vAhF4SccX
         eWrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793177493; x=1793782293; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dtaLCG5DfHiNQ60mEm2A+W71f2WlufqY+/mbeyVW/yk=;
        b=IGGA5y1WWStMTA//0BJ7KBsYvaAyHOdJthFY3eAJj05vH9P67RLvlO9sVnIFAqU0Kx
         6X/GjBMNnRENZP5taihp00zfQUUXpaisXfFJa9PrC3o2/Vv2oxKwUCKhLZZMMk/eSldr
         YzXct9ufFFuDXhBCPtywXVM13b4yxPt76pIKHsUKk4lD+o1yLvWSYdh0XOlYZlWBUycW
         KIifbpbZIcU5Jnfwf4vadZ68XSsJUIpnCaFiJSKsKeTFB2+Daw7fXG3TcX3IYfFO1dxx
         qr4uF1CD/aMt+lOnStwNuY7qKQVEl6pn/AjS/o4qzrXgR/TsGzM2bA86Ii94cYguxWNO
         hmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793177493; x=1793782293;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dtaLCG5DfHiNQ60mEm2A+W71f2WlufqY+/mbeyVW/yk=;
        b=fQO4eAXTpn3LY/vk5I1TkGi6+2biIrPs58HMsQPh9hadhX4mNMjr7Bifu6s8XfWHlg
         EeWzXeYkMa2PUto959wS2rsrP0nau/c73zoO8rP1K/qHtiVNGh8JPREiWHJOAhZFRd03
         cbKeV4pcH7lkCusgvyCCCDxX69CvWEtbGw972iYtJwoe7BzCm+vO1O7+qLqY577cD5Y5
         xC4qgkX/VJ/+9dQAtgYhATHEdvW8t/1vHKi3xKTOt4vNw9+qXD6YTVCKxJW+331zkH0d
         OxIQW90tzFe6sXtQiv+QAiGxLnap6H5VJ6M6THi9qm2Lj/QaxnBXiw2y//CmVDvf0va+
         tAJg==
X-Gm-Message-State: AFq9FYJjLnMZNqU+pWTLrlAfO+7StYC+oMN7kCeR0ejgZ+Phf3CeUT2p
	QJR7TTEGbbc+QkobL2SSUd9Pqtk0ZvpFfA9hTkeAmKsEPFqGp7pl1PYnxOHOsXqNeRoBtv9lB5C
	GmfW+m9Jf/4QHyJ7o/+M36G4aWe8zihmEEHbsBkfVBq5Eq1oN3GYlAE432cHRK/p6r6i4G9hbZv
	1tyGujRnYYL47mxgZBcVSftWN9uu6ldPIWWw==
X-Gm-Gg: AYBFou3pG1NDrOfwFbX6l/nO092fU7u6sY5+Y1JwqM6U0fVhAchRl/j7eaFOnZpwq+w
	UalgoImjH117ZZOzOiEs+3WxCgUWIelBCMUlHGJ7vtzsziqtwqsgtp9NIoB6/tr1pQY9jv6u+gI
	8koYBb0IEHS+w/UVEIMH5KbDHvAyM54KokDsopbLu3YrqmdrdQ82Y+SDrEcnB0k0dwlX5BQu0qd
	wFgDU38+Qpb9bNBNhpHhjj9Er+V4c7/hPpIkDzw/x6K0NzOIjwDTpKx/l4a7zEWAv5pJ1H/ahU=
X-Received: by 2002:a05:622a:489:b0:535:c88:8f1 with SMTP id d75a77b69052e-53fcbce2f2amr29596331cf.41.1793177493373;
        Wed, 28 Oct 2026 01:51:33 -0700 (PDT)
X-Received: by 2002:a05:622a:489:b0:535:c88:8f1 with SMTP id
 d75a77b69052e-53fcbce2f2amr29596061cf.41.1793177492903; Wed, 28 Oct 2026
 01:51:32 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027171055.1796482-1-peter.hunt@opengear.com>
In-Reply-To: <20261027171055.1796482-1-peter.hunt@opengear.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 09:51:22 +0100
X-Gm-Features: AclHuK_7Qt0TADKGY1nMybB1djOqh4oQ5S7n5wDRc9mHEYJzanegY_rRJPAb_Us
Message-ID: <CAFEp6-2GiTaDb3GVE8BCSmQuONOVmiTvY=tv+Ji_keXcFZWPhA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: wwan: mhi_wwan_ctrl: send a DTR drop before
 it can be coalesced
To: Peter Hunt <peter.hunt@opengear.com>
Cc: netdev@vger.kernel.org, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Daniele Palmas <dnlplm@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAzNSBTYWx0ZWRfX+2ZVxa+zZxaO
 w3ykyeZ3T68YeiNFBLwgEct125oJOFMDrCDJlH/MLXw5uySCmhNSh6HUTjXFV42vRbLmPy/Zs+b
 fADLsutmJadTmLE37Pg1jW+fI/Rfm1hN1nC7pKwjSt9CqshpwM+0A4nBmmjIEFZL1uo/trPphkU
 Om0AXcbR7zE9k8FDzlF8E1u84lqqaM4QcASeJkGhB1j26JAPQv8P8LoypUb/Ky2KkEtZDX8WG/B
 DM7fRy2phQTg/11BKUMJWw22bf3o25JMSqFG3TWga/7wxrixmtNW/O/KRUEmZP1fxV2WWW/ib7g
 cztvof22DdzxpZ5ccatE2xHC6aOLdSLXurgQ13KYWo3g5fIwkxYKeutxcGktjelf4GacDhJBINl
 Iu2qTgzF9La67Pj5ZmZuI6TV7h1cixl+mTmKVMGZxVU8taV/b/bXONzaJTImI/ucKYhEUZwHKhe
 EcJqhaV97+6gCFzQYJQ==
X-Proofpoint-ORIG-GUID: gvqOXbu2EP_AOFDykWygo_3JHY6cZ3lp
X-Proofpoint-GUID: gvqOXbu2EP_AOFDykWygo_3JHY6cZ3lp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAzNSBTYWx0ZWRfX6vaLDxTfYZL5
 tOt9WEqHzxqHvA2G6TCg/oZVaE962V3AVr/gfuq/ciGCyObLYeqHUNTKfCoTm4ajMxg0sLZ6cJI
 MBveSP3QGeY9r64xxBkPEH3LvmwVL9Q=
X-Authority-Analysis: v=2.4 cv=JodkP84C c=1 sm=1 tr=0 ts=6ae1b796 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=6MsIef5sYUtYhJpA:21 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=t2vznHeBAAAA:8 a=EUspDBNiAAAA:8 a=ziOM4HdDeOLMJrtgq5cA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=V_BghkRpYkFyHJIZkSH6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280035

On Tue, Oct 27, 2026 at 6:11=E2=80=AFPM Peter Hunt <peter.hunt@opengear.com=
> wrote:
>
> DTR/RTS changes are sent from a work item that only sends the latest
> state, so a drop followed quickly by a raise, for example TIOCMBIC then
> TIOCMBIS or a quick close and reopen, can reach the modem as just the
> raise. A drop matters on its own, a modem set to AT&D2 hangs up on it.
>
> Flush the work when DTR goes low so the drop is sent before ->dtr_rts()
> returns, and flush it in stop() so any pending state is sent before the
> channel is stopped. A drop that hits a full UL ring is still retried
> with whatever state is latest by then.
>
> Fixes: d509edf90bc6 ("net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_=
CTRL channel")
> Suggested-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Peter Hunt <peter.hunt@opengear.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
> v2: Only handle the DTR drop, by flushing the work when DTR goes low,
>     and flush it in stop() as well (Loic Poulain). Drop the port list
>     and resend on a late IP_CTRL bind, which is only reachable by
>     unbinding and rebinding mhi_wwan_dtr through sysfs.
> v1: https://lore.kernel.org/all/20261023174113.2388353-1-peter.hunt@openg=
ear.com/
>
> Tested on a Sierra EM9291 (CM8100): back-to-back DTR drop+raise and
> close+reopen now always send the drop, bursts of 10,000 DTR changes,
> HUPCL, teardown and lock stress tests.
>
>  drivers/net/wwan/mhi_wwan_ctrl.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan=
_ctrl.c
> index e3c207588956..772319927867 100644
> --- a/drivers/net/wwan/mhi_wwan_ctrl.c
> +++ b/drivers/net/wwan/mhi_wwan_ctrl.c
> @@ -209,9 +209,17 @@ static void mhi_wwan_ctrl_dtr_work(struct work_struc=
t *work)
>  static void mhi_wwan_ctrl_dtr_rts(struct wwan_port *port, unsigned int m=
dmbits)
>  {
>         struct mhi_wwan_dev *mhiwwan =3D wwan_port_get_drvdata(port);
> +       bool drop =3D (READ_ONCE(mhiwwan->dtr_mdmbits) & TIOCM_DTR) &&
> +                   !(mdmbits & TIOCM_DTR);
>
>         WRITE_ONCE(mhiwwan->dtr_mdmbits, mdmbits);
>         schedule_delayed_work(&mhiwwan->dtr_work, 0);
> +
> +       /* A DTR drop matters on its own, e.g. to hang up a modem set to =
AT&D2,
> +        * so send it now rather than let a following raise coalesce it a=
way
> +        */
> +       if (drop)
> +               flush_delayed_work(&mhiwwan->dtr_work);
>  }
>
>  static int mhi_wwan_ctrl_start(struct wwan_port *port)
> @@ -246,6 +254,9 @@ static void mhi_wwan_ctrl_stop(struct wwan_port *port=
)
>
>         cancel_work_sync(&mhiwwan->rx_refill);
>
> +       /* Send any pending DTR/RTS state before the channel stops */
> +       flush_delayed_work(&mhiwwan->dtr_work);
> +
>         mhi_unprepare_from_transfer(mhiwwan->mhi_dev);
>  }
>
> --
> 2.43.0
>
