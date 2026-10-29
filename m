Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793269062;
	b=PZC95H82pD0fYsHe9XBn2rrI7+UDrL7KrjzRtOvSZW3E2bti9kCG+eVa1mlOm5GhURq1
	 EPmuT4ooQvegkT+nnKL/x8v6TZsu1o1U0d5FXWLga0iuR0ldiPq+2lOKa8xM4uAqdV6nc
	 BZnsrjNAI0Qve9BxEMQSWLfLISmFqnTRJHfTcEEqqTrYr8Wxy/w7r5qxWpWMBI34BnRsp
	 zsuEaqi67EFeepw06lGQhqOiV+66utNq1/MWOFYo0mcZ/mfOcwpQYt5iqrkNrY/T4y4JS
	 ATvqSsgPth1WD57yn3Rs0S8abMSzeEXQTQmv6CsYoIfvvMPIbDW7RdpeVsXAiq3ZRcA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269062;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=adbKXnkrj/Zj0MFQsrgS7CP9R8qw1nrS1ry1AUvfysk=;
	b=phTOv0Xa3+AUW7stdhbTgjtzRO0Zk7+oPLazUAojq5rfiVdFnduaWOlm87xwAnHYaUHO
	 Mf53M9cX/To+p2qij8R/cWLozR1kC54V8YnQKWfTy2J6Am01lAvi/c54d/nc99rWMHK4v
	 Ik2stCapda3TrxA9UDeeim5O4cD4ydoFLqdMBSg1yvD8rNXdAaSTC3zJVMPyuobTqRwGs
	 fc4VTVf1S0XzGeX646bJxEXOBapgcOfVnfUgQXzeyITc7yga6M1cCWoS+eqZ8HZXuVMjf
	 4WRDtUc8KbgBOXSq2lDIa0u8h9kptd1RfZZZc/IRlPA9v3nXWccaCI7ylnoRk1raNBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HGKgjvO3;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N1fpzKNl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40A5606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D40A5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HGKgjvO3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N1fpzKNl
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T8vBB92725114
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	adbKXnkrj/Zj0MFQsrgS7CP9R8qw1nrS1ry1AUvfysk=; b=HGKgjvO3Mmul6mYm
	HXsndv9hvZ0Zx7kg2j9MQNzkelbImXc6UzBdBrI9yoyICak/R9oxwqfxch2oPpl3
	kGSfDlwKb6YCMsjrvFyAcTk2kpu49mcjYlQnNZxxVvEaIBZpgTGN1xcPXxKMhCar
	nHkkJu8UnM9QtHFfTOHVDU6E+dL+iNaamDLII2QF55NFVEjPX8A/A/0BYtp/86L2
	xBXof97Tv6BPKwySquobaRqiSBITjy+5PUwNhtx643IQ3u8+5ahHyDMNfOYTPKFJ
	bqUYfgrHbkY2OX3CDMkFfJGoa4rLovyk2cxPRi085aQfBfTaPYFLXNfDJ6rjNjfh
	9N6CBg==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hky5s9736-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:17:40 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-6798c43a3bfso3535726d50.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 03:17:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793269060; cv=none;
        d=google.com; s=arc-20260327;
        b=oHnP16wRmnaKPCJ5mrz50UsCSeoxyf3fP0Cd4SZNCSzA2W6gegT684WNU8ttEKEcmt
         xShMdXYPPQ9/7ARmoVI8fpLtM4xcFqW4mZnptG3N5r5O1xhSkHC+s4b2YD5/KQHWDRPY
         AwupVUo0V2Ot0TWS6wsaTgZ08SMC/2kM/DO1UR2spQqz2RXAvsxxspJXx0IEBKyaNkHE
         UXBJKygH+q4G1wuvRpNFK6yUsXHQ9xEYMxNmyrfZKW5jWmjL9ZM1UB9h9fZv1rx9yMlp
         g3897ZK1DZDwM6pOe/W+1Op9+BWH6RJKxucmkQT1m/8cICPmNKVAk+Drylw74VzwHzC8
         +F7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=adbKXnkrj/Zj0MFQsrgS7CP9R8qw1nrS1ry1AUvfysk=;
        fh=iPj/QxOKmYUbjH17nr3BzMCxDa14ZMf1bBhCF06IXZg=;
        b=jLn9Wb/XjirOCmauhBlLW1KubcPSBR0zRZBxRfrTgYvwttvInjfWoyBrz9ix8weEhv
         s4EqquyDyevjSsr648/8D2eNOCGLXixEJDFSroC65XQhSfnLvh79FUOIlaN0Ga28RmYT
         g8BW16LYN4jYgwJUtE9QY0c++EWiCz+Smz+Iox+7Ls0gTPjqpZRC68PvGqpDozOc8HjI
         4AgA2dS2b+Yjpd2Uq5oAZUfAjkHKINuXc9/+S7so2hRGJJWaJar5CYi/49ZSFMv4IKEG
         26k33PredaQqJcL/uO3MZ6YacfpzXgwWMmXrHWUQyAjZ7tY8JoiyWQac91Ce01BN3L/t
         vtZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793269060; x=1793873860; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=adbKXnkrj/Zj0MFQsrgS7CP9R8qw1nrS1ry1AUvfysk=;
        b=N1fpzKNl7vJKDYtFaQbbnn9QCb9ycrn3a06eCemsTzmwR1BOyWkoxBwF+jKNPELFYK
         uD8g5bTBFUsqyVivQFV5UiSsa6OP7Uoz2gQYmbc7wFW9G0nvruNJElM5jAkedtDW8Ezw
         lKqX3CHiza86WeqNADnz4C3cFVSqNVaWqRZrdJXlTIGGqqbgsw2hIocBgNeS/TyerJsO
         F59/OK4o0IAAsif4XOlwf5jsZHqgeHMbX9EiihZzPE4LxyZtR6vSmUARIO+xTHxIyNW1
         PaAUHGZwscxhezdSbhMo1764o1evdroD7EJ4Csj71SADcqVE8kpi+3TTGyWE/ZBB3wQe
         8EVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793269060; x=1793873860;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=adbKXnkrj/Zj0MFQsrgS7CP9R8qw1nrS1ry1AUvfysk=;
        b=LXpLtcfKafSsSHQ2UtaQLH82E6JptHd1H0NQnfNqTvV9UaZrulcQvZ8BT75p64o3/I
         AoUTfnEha3VwwTZmhLhJlP82eyf7WtlMqTX/S++SvaEt6I/J88ko/WmWsEl/m3EIcPBH
         Ja5DHIKYkNYu1S5BsL3ER1W3BhZhIwedMUA8VxBucKMNRlNvQXG/nsigNm4KWnfVhntJ
         nfBlb6nW21ay+vzlaypGVdPqk56ROHlm9cWYrz2AXZ95rAXVp6vnA8IZXoK9iJEARJmB
         BBpYNDqkmIUixKEgM0DCdMNqsEpb866tS7O/Ko1h5b3P/QTC5PJSeumiiCyx3ZtNGXEj
         jMOQ==
X-Forwarded-Encrypted: i=1; AKwUvBylkXkz6SCWIRELD9liCRC2mEVR90nsQpCqbBW9qRJeBfbqYpw1fU68nBC13Ve+9EybL7Z+KIU=@vger.kernel.org
X-Gm-Message-State: AFq9FYK+hhAPXYex7pR55auoNwHlTka3b5x1Rj9X+vpQ7zBpLc5Butzk
	cxHQvD37gY64TCB9vZsL4kLd9mwdeznFfpHtxQMV3ORLGL2FvbZOtxBou7s0PuEbPc4h4R3gcvF
	nxlFmbqDv4mzhwpFI9NEdbLetbmKe1i4zlEzoFM3/hLmXiKPF5zkmeolWIckgE3qjgIbTQV5q2e
	mltRxQIJibpeEWvBSV6tXvqEW45MEtO6Do0w==
X-Gm-Gg: AYBFou2MDGnoVUnp1y5niz6ANdFuLTmkzq4u664DKmxYaD3ClOXHiuBljeNtmWpZcCd
	EpP8b/OGIGDfMUMm7TQW9Bj1IM6HfvvmVfEkPWaoEvCWcdRLOyFWF356O5+YsIg/kh1eNEUZ39V
	8nLOBpBlujip+rrOagSwVJSpQPTdNVdTK1V9reby8LpnBS6dRZcZ68Qp/LTw==
X-Received: by 2002:a53:ef8a:0:b0:679:3b0e:3e11 with SMTP id 956f58d0204a3-67a7bcfb0aemr2293240d50.109.1793269060131;
        Thu, 29 Oct 2026 03:17:40 -0700 (PDT)
X-Received: by 2002:a53:ef8a:0:b0:679:3b0e:3e11 with SMTP id
 956f58d0204a3-67a7bcfb0aemr2293227d50.109.1793269059583; Thu, 29 Oct 2026
 03:17:39 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260923-aquantia-support-5gbaser-v2-1-4d789dc21418@oss.qualcomm.com>
 <179027194602.2160803.1483822531995612133@kernel.org>
In-Reply-To: <179027194602.2160803.1483822531995612133@kernel.org>
From: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 18:17:27 +0800
X-Gm-Features: AclHuK8qA7sT9aXyMK9MadwT18kA_k0cGovoEZRIA8-V0lCOv1JHPksIROlbU5U
Message-ID: <CAPTcHHS7fckRfGzT-_n-GShsbaG7D1nV5=r8XgRbfV8vg7KK8Q@mail.gmail.com>
Subject: Re: [PATCH v2] net: phy: aquantia: Add support for 5GbaseR
To: netdev-bot+sashiko@kernel.org
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAzOSBTYWx0ZWRfX/7Fsn3bazSKB
 SXrfflesMfHQuvrbbLCO/JHWMHEw6L9YRS+caLLXN/8dWrDaIvHxSw1v2dxQpxHaYghqdwud6Tn
 rg2JVDHi/8rQX2W8IwoyoKZcPonmxzQKZghmgoosO8uLj8z55AEujN1LH6pgYO3Ff6gO9o17ckB
 sx4al13fKCiggcBvYBMlcJk124t1Ollt6/9YWFvVlgrTG3DJ84Mcr2q3ihrEvjC4zR0C6YmXXb8
 C2uQT2ycYavk9zLOgI96JjuoIfQXHZSmgvX/G4dqfMOvQdW4FapTp2D6NxBO0qqQkOajNBXYl13
 PM5m1euvlSKbqwAuaWExaHYKQAThel0qep0S/hbz9ONUNNW+uGqORXrlOE9la+fVT1+QwjBpzdz
 QOHxlug9AgHnMZe/ThLWiS38lZC0JA0xmkcu3C5KhEGP8XAqs/OYhw1dZd0XzLIwbpo1hoTpRKl
 QTZ1e4HS669htO4hsEw==
X-Proofpoint-ORIG-GUID: WAgDEc0S5eNYo9Y5FYirF3vx6sVwvpmh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAzOSBTYWx0ZWRfX5cDj/dakk+Bw
 KEtYfvAZnQZYP3oYUQGz4BcE/Qu91nJ6Yto7X6hL79Fmokr5jUZkAnLhB3MHyFAnb0iEiZiiGM7
 D9tQdJ8eoGv802NeKmIcbQAcqy3K4ng=
X-Proofpoint-GUID: WAgDEc0S5eNYo9Y5FYirF3vx6sVwvpmh
X-Authority-Analysis: v=2.4 cv=f/vdl+yM c=1 sm=1 tr=0 ts=6ae31d44 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=TrX7sf6gzCYKm8an2WsA:9 a=QEXdDO2ut3YA:10 a=nd2WpGr1bMy9NW-iytEl:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290039

On Fri, Sep 25, 2026 at 1:45=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The commit message does not mention a behaviour change in
>   aqr_gen2_get_rate_matching()=E2=80=A6
> - [Low] The submission is incomplete.
>
> --
>
> net: phy: aquantia: Add support for 5GbaseR
>
> This patch decodes PHYXS interface status code 12 as 5GBASER in
> aqr_gen1_read_status(). It also makes aqr_gen1_config_init() accept
> 5GBASER, and makes aqr_gen2_get_rate_matching() report pause rate
> matching for 5GBASER.
>
> > Add support for 5GbaseR within Aquantia phy driver.
> >
> > Signed-off-by: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
> >
> > ---
> > Changes in v2:
> > - EDITME: describe what is new in this series revision.
> > - EDITME: use bulletpoints and terse descriptions.
> > - Link to v1: https://patch.msgid.link/20260923-aquantia-support-5gbase=
r-v1-1-537d39bb8c35@oss.qualcomm.com
>
> [Severity: Low]
> This isn't a bug, but the v2 changelog is still the unedited b4 template.
> That makes it hard to tell what changed since v1.
>
This is a careless, it is fixed in new version now.

> The commit body is also a single line. Could it describe the three
> separate changes in the patch?
>
Yes, will privide more accurate commit message for it.

>   - aqr_gen1_read_status() now decodes interface status code 12.
>   - aqr_gen1_config_init() now accepts 5GBASER for all gen1 and later
>     PHYs, including AQR105.
>   - aqr_gen2_get_rate_matching() now returns RATE_MATCH_PAUSE for
>     5GBASER on existing gen2 and later PHYs.
>
> Separately, the new define lines up its value with spaces:
>
>   #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_USX_5G   12
>
> The neighbouring MDIO_PHYXS_VEND_IF_STATUS_TYPE_* defines use tabs.
>
OK, will use tabs.

> > diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy=
/aquantia/aquantia_main.c
> > index e95d391a6dc23..0bcec88fcf727 100644
> > --- a/drivers/net/phy/aquantia/aquantia_main.c
> > +++ b/drivers/net/phy/aquantia/aquantia_main.c
>
> [ ... ]
>
> > @@ -1040,7 +1045,8 @@ static int aqr_gen2_get_rate_matching(struct phy_=
device *phydev,
> >                                     phy_interface_t iface)
> >  {
> >       if (iface =3D=3D PHY_INTERFACE_MODE_10GBASER ||
> > -         iface =3D=3D PHY_INTERFACE_MODE_2500BASEX)
> > +         iface =3D=3D PHY_INTERFACE_MODE_2500BASEX ||
> > +         iface =3D=3D PHY_INTERFACE_MODE_5GBASER)
> >               return RATE_MATCH_PAUSE;
>
> [Severity: Medium]
> Every PHY that uses aqr_gen2_get_rate_matching() now gets
> RATE_MATCH_PAUSE for 5GBASER instead of RATE_MATCH_NONE. That covers
> AQR107, AQCS109, AQR111/B0, AQR112, AQR412/C, AQR113/C, AQR114C,
> AQR115/C and AQR813. Does this hold for every firmware provisioning?
>
> aqr_gen2_read_global_syscfg() maps XFI5G to 5GBASER whatever the
> provisioned rate adaptation mode is:
>
> drivers/net/phy/aquantia/aquantia_main.c:aqr_gen2_read_global_syscfg() {
>     ...
>                 case VEND1_GLOBAL_CFG_SERDES_MODE_XFI5G:
>                         interface =3D PHY_INTERFACE_MODE_5GBASER;
>                         break;
>     ...
> }
>
> So 5GBASER can end up in possible_interfaces when firmware provisions
> XFI5G with RATE_ADAPT_NONE or RATE_ADAPT_USX.
>
> At runtime, aqr_gen2_read_status() still takes the provisioned value:
>
> drivers/net/phy/aquantia/aquantia_main.c:aqr_gen2_read_status() {
>     ...
>                 if (syscfg->rate_adapt =3D=3D AQR_RATE_ADAPT_PAUSE)
>                         phydev->rate_matching =3D RATE_MATCH_PAUSE;
>                 else
>                         phydev->rate_matching =3D RATE_MATCH_NONE;
>     ...
> }
>
> phylink validation, however, uses the fixed answer:
>
> phylink_validate_one()
>     tmp_state.rate_matching =3D phy_get_rate_matching(phy, interface);
>     ...
>     phylink_get_capabilities()
>
> When 5GBASER returns PAUSE, phylink_get_capabilities() adds every speed
> below 5G to the supported and advertised link modes over 5GBASE-R. The
> fallback path in phylink_validate_phy() also stops widening validation to
> all interfaces for c45 PHYs.
>
> The get_rate_matching kernel-doc in include/linux/phy.h says:
>
>   It is assumed that if a rate matching mode is supported on an
>   interface, then that interface's rate can be adapted to all slower
>   link speeds supported by the phy.
>
> Could phylink then advertise 10M to 2.5G over a 5GBASE-R host link that
> the PHY won't pause-adapt? A MAC that only supports 5GBASE-R is one
> example. Validation and runtime would then disagree about the same
> interface.
>
> The existing 10GBASER and 2500BASEX checks are just as unconditional, but
> the 5GBASER case is new in this patch. Would it make sense to check the
> provisioned rate_adapt in priv->global_cfg[] for the requested interface?
> The commit message also doesn't mention this change in behaviour.
>
> >       return RATE_MATCH_NONE;
> >  }
>
> --

this is  a pre-existing concern, not caused by my change, can consider
to address it
in separate patch, this patch only focus on 5GBaseR mode enablement.

pw-bot: cr


Regards,
Hongmei Xu
