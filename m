Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792491713;
	b=wm3+cYfvlLM070MGVNQ1MqUUi2GueqDRAc7bt8OwizXUtHnSSoebnvA8ml9HOfSHtPvY
	 0p/4dIC0qBiBnziEG8GwcvzBXd0JSLRfy5aIujF5vHl8mgNLIB+sIBDEXTWiPxuJ7QFHp
	 hA7pD3jj880/aRvi75iukxZEpjwh1+0LWTsg5OM0HOOzFqjD92qDZAI40moQKsRxZBb8K
	 /WrHVDdWNljCsIaI5SzlxTMmpB1RQkUHBKSwrNDFU+ffF1Q8qsu72fdTI5WuoP+7sDPYC
	 AuT9xATxeRhbKQaX4rDEyVc9OOBKW7GsRWlcG0lnZJPvTLKvjeXEJb7asx6G2BM7rqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491713;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=zmzEU/pYlWp69Fnmfb5E7Xfs+qaL+26qFfmEOpd/OvA=;
	b=MCDpa9+0GeFxHHcLYh2lYM8vbC3dBIYyN3MpifGRGmu5Tq1lJfR/Sql+pOSQaK/br/vl
	 bkUVweOCBs+T+TLNv4wco9LfpngDoYJs5kg/TkWUvDbK0Hyx43yihd22T29NN1KaJvV2v
	 paDpNiWgxwpS9nm5EZ1Khf6VZ1yBeoM7b95IH5WXQ4KJBeMAhYypXFEObKzJg15aDZ6lp
	 CnmP5C/S/iWa6s3vHhwGsVpCtWhizqV/NLIVIT10X4z43GAm/nRK3F2g/LZ9OsDDlTpug
	 PI9Bhkbi5omLqo2DO5ISS3DKRut7DcwZ/3HXUa4A38xPgx6GYLyKgTK5mQMkrN2uFig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Lh0j/ICX";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EU4V8c7d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E06606A322
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 10:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45E06606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Lh0j/ICX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EU4V8c7d
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69K8ChjX186498
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 10:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zmzEU/pYlWp69Fnmfb5E7Xfs+qaL+26qFfmEOpd/OvA=; b=Lh0j/ICXD9F9bypK
	pUpAeSGdmK8ensVnmGZogRd77GWqLFCHY2yGj8cB1NSyL4EjnnrNLUM8p0kDH7tu
	GTvF2SosRxf5P33qoBdOsgES+AgTE8BqJM6W9J5imYDBPaz+oAIC0k9v9GKo2+eC
	0TJFy0VoN93QfyFHTt1YGPQcqmvWPBOS5QByjRdvJKXlWXTuJwxW4b8ajh7qYOVm
	w+RgxZE7+aWAlbuiMtLnIxsGBdZvP6BP99ZAWLT5539fY3FezqJViTRHaZy+EVru
	z+YBWcc27GBKfTdwRIXvkvQHMdoIk/6vj3+BmjYw7AHua1EKjbXm0OFHYjNU+oEu
	fpCvPQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5nt1vt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 10:21:52 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-939c30aa9a0so341255485a.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 03:21:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792491711; cv=none;
        d=google.com; s=arc-20260327;
        b=Fhv2cJTB7DH7DTp1+0Dq/silKIzbGoyLut7q0VKCKBj8bmgt87wYWuVZ8+L9Mg+5Hv
         x+Gm/E3tkNdyS+8YbN9Hu9lfej5m6i3zFKBcYu7bAIG05d5XVoh2tTQyjVBgtcUUNLcY
         nsTjH+e2RPXpd0XSV9pUKqikYVN6qVh2VKRnqB7X2R7VzyMjWUYF3vGdaNRVgQDfosS6
         epWe3vZ0mw5SzfYaIv1IOBzhKu4VBgwqpzEpLOhXZVXr4hnZYDum4715V+gVmB2L9kpI
         ps5/qHlfvCFtya3f2M7EgvWu3ZeYdtWre5TFZYjOTKlLFkueXZEcUevBuMpL1c2A6Glc
         tK5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zmzEU/pYlWp69Fnmfb5E7Xfs+qaL+26qFfmEOpd/OvA=;
        fh=TpHqrGxkCTHyt5juKCdXOljaNSTmtfRvqhBSZv8gjxI=;
        b=h/44ydbyeLU6MaULRIUGhaDX/PCJbGhD3l5QA1f+uvoEX17kM3OTrVbVtR2P4YYiqq
         KSw6V4VJqbQ2MA8+gL0Urd63grqC1x+lTeL/OzqLDdquW19QUBrMavlVyhlGlzY3XrlW
         59j0Mhb7M+6jWguqJBc9iQWMGkKU4k+AvtklLaxpn6rQQeoqO9EVrRVaT02Y9yXL/lN7
         XgvRGdDe+C0NweHgl4SVDMGmBHl5NHxxMRUl6OJNondirp9O3qjj5qR3682NtgFt2YRR
         8K2e50wdhZUZi4CcRpxGPWPNpWgLbWhGjS20pi12d3rK4kuUljvY3WqTdQ4cMnuMgi21
         48gQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792491711; x=1793096511; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zmzEU/pYlWp69Fnmfb5E7Xfs+qaL+26qFfmEOpd/OvA=;
        b=EU4V8c7dwPEcZ51zzG9IvdAHykYk0uA0MUUMiLLbMkTzZ6o+INI2aUc4iSeOj8BjHc
         yuIOYr1G+ge6AAQheGgRH5q6LqCc+FLqBFIs631p4MfDBYtNZRMJlPAvUzTYseFBUInh
         zw1rFj5moKxwxugWvU1/gIlQOSrD9QNz+7/EyNLq+PVCkuPBU0Avk0E0ACstqQnf7vmj
         rvkOwhrQFMpSV/THubJ+TcqRVbZXr+t/1+Z98r/NKzlgtzfnnPCKd0ITluZZDyIk1aVg
         pM+7FhXqBXyzFgjbCwlM1QH3hx1ubANYU8UgtpGSk2be0HKSwyR77SVtu81iPMNA5af0
         7Q0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792491711; x=1793096511;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zmzEU/pYlWp69Fnmfb5E7Xfs+qaL+26qFfmEOpd/OvA=;
        b=ydEUJVk3pMr3oALaUdkXpXkydVD+5sOSf7+VTdlLABokbFMsyTfbIlIMFXhKi4VsIq
         B/Ky9+n7zLI7qM3tQI5qjHPo0t5VE209UhtgMD3OckNXow+QgW+ObyXtn2B0inW/dihy
         GmLcAzR8xJ7t+L7ZztpCRKC7buAv0OTikBGBX4lnm4NJ42MQCXw/RCgl/PxGnlhzl4KZ
         maTVUKWYZ+CQ96g/GRSsgps43mbWBHPieINyjuM2m+kLhK4IUTMpvUeAUzVz4oXHO0iP
         qA6w9Hx8tHHBI6au33dsK0vz1DO0h9IhkmJMjhKhcV+Et2pkci0fy6VI/eQq7wUWlBZy
         gKjQ==
X-Forwarded-Encrypted: i=1; AKwUvByWDOmkC5+BNVUj2xv0wZLLl9XfKw8+5ygKiy7D4MLEWhgpKJ1oJWQCvKvlDqjgSCFPQRCT4GI=@vger.kernel.org
X-Gm-Message-State: AFq9FYK2GhJUUfH/IkuQtC8utA8qTeAmjEVKlkb1Q/zexa+ipizmix9u
	1KoTH9Z2xqlYGD+j1Q5fGZseabh2lT8kW8YQrzatME/lkcRo4r3n3FAYe5be0xqF9sQI533j8RY
	mprruKYlmEIbcMZec4oV8rgvg2wb76jahsSvK83QaHVfhkkkpvNiYC+iV8BMsrXLU4fIVbztRsH
	40LxYZphvppQUEQMmau6w3tSfb6iSDKQOKWg==
X-Gm-Gg: AYBFou3l87vItD5DCniXgBI7XKfUdCWCx7l9wIBzEAkl068pbVvaV1w94pPitYb90+D
	9tGgM+HUWggk0LnPKt++WQGqiL/5mQqOqKbrGCcFLXzwT9K7WnoQNo/33vS1TfcTtU5PvZRSiHH
	nW6KvysI2XlAYv5pdnZuGj7LI9MtqLLnDJQlfBSOYf4xgxaOx6mPJfQb3nPUWb4mtgJ5v65EMVT
	JZ0v/YWGFLPc80gaQxWbRe9c3RcZ9lLntp9vi6lE/6lpadmqilM1knVmoNPET50JxZLfxFfDCI=
X-Received: by 2002:a05:620a:2948:b0:93f:228c:52fc with SMTP id af79cd13be357-93f29d7b1admr1754524985a.58.1792491711347;
        Tue, 20 Oct 2026 03:21:51 -0700 (PDT)
X-Received: by 2002:a05:620a:2948:b0:93f:228c:52fc with SMTP id
 af79cd13be357-93f29d7b1admr1754521585a.58.1792491710779; Tue, 20 Oct 2026
 03:21:50 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020101150.16967-1-liuc63@xiaopeng.com>
In-Reply-To: <20261020101150.16967-1-liuc63@xiaopeng.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:21:39 +0200
X-Gm-Features: AclHuK_litW1CsHp-p-GfN5m3qzJOLKXldulgV3ixEju9BrCrj64dCZjrQIAVEk
Message-ID: <CAFEp6-341f_TjYw_rz75h3N9Ph56N05MowosmKJh-UobS+SdTg@mail.gmail.com>
Subject: Re: [PATCH] net: wwan: iosm: fix NULL skb deref in ul_td_process
To: liuc63 <liuc63@xiaopeng.com>
Cc: M Chetan Kumar <m.chetan.kumar@intel.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Guanglei Zhu <zhugl3@xiaopeng.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: ewcavhLY2ySTUpJP8icImDfCQVxkoksw
X-Authority-Analysis: v=2.4 cv=DZOCOftW c=1 sm=1 tr=0 ts=6ad740c0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EgahoUkMAAAA:8 a=VwQbUJbxAAAA:8
 a=5kY9qsDIvHh0I-ch4TEA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=D2SkTF70-_n5gOfERQdM:22
X-Proofpoint-ORIG-GUID: ewcavhLY2ySTUpJP8icImDfCQVxkoksw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA0MSBTYWx0ZWRfX1Q9b4l+G0wZy
 YmVuvTch4P6H7JuJNlqASDtD+wMOyI7/qGz8upxHto/X7ybZZSxgRFsCsCJoHHReha5hgbxk1Vb
 axyv0Ag0JuFPvxTP+yujnGkHudx3YnoQ1IH08LrFwasIQPYNNQFkLHiOaJcJpFvUPKVGwHzSEF+
 opE+oUHb6IudhN/QRB1Xyl+Zd8VMViwNq/cljoyVvSW7lVjiART1l9yu3tXO8kZIXKNpXZ5QBAK
 MZ9QfO5XiN9wIKhyUA0TGhjRazEoqFj4kzbJ3WQ/Lqn9M+GijwgbC1kQpkIeo39Ohd0wr5yWJ4H
 SMFqjxu6HLPYNm8of7HR2inVvW+dh2PDASktnoFSUBd+06DMtsYN7DvWewFsPyAhGznodeo+j5s
 /ZL8VJpyT2iNY8qyFJ8i/blQ/QvttSVG4iAUsd9JmUzH4n/YQwX5Ft+fkDH7Wo/LfX6j4Q67QEI
 A3b4cn6Ycba7S4b1I5A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA0MSBTYWx0ZWRfX7FddJULU7X3o
 oZ5P/mo7yQGH13xZ+ow2IYfPfaqRGjaIgEb0jR/puKAYlwl9PRaq+5FbXz6au41YAFCpcH16ak6
 D0v3m8sRy0l10Bo4ovD8gbgHSjGnuW8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200041

On Tue, Oct 20, 2026 at 12:11=E2=80=AFPM liuc63 <liuc63@xiaopeng.com> wrote=
:
>
> From: Liu Chao <liuc63@xiaopeng.com>
>
> ipc_protocol_ul_td_process() fetches the skb for the current tail
> entry and then dereferences IPC_CB(skb) when comparing the TD buffer
> address against the skb DMA mapping. If the skb slot is NULL (e.g.
> the entry was never populated or was already consumed), this results
> in a NULL pointer dereference.
>
> Validate skb before dereferencing it, mirroring the existing check on
> p_td->buffer.address. Return NULL and log the error when the skb is
> missing so the caller can handle the malformed descriptor.
>
> Fixes: 64516f633bfd ("net: iosm: protocol operations")
> Cc: stable@vger.kernel.org
> Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
> ---
>  drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c b/drivers/net/=
wwan/iosm/iosm_ipc_protocol_ops.c
> index f2f86f41fd10..dee2e6607f77 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c
> +++ b/drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c
> @@ -302,6 +302,11 @@ struct sk_buff *ipc_protocol_ul_td_process(struct io=
sm_protocol *ipc_protocol,
>         if (pipe->old_tail >=3D pipe->nr_of_entries)
>                 pipe->old_tail =3D 0;
>
> +       if (!skb) {
> +               dev_err(ipc_protocol->dev, "skb is null");
> +               return NULL;

Look like the caller(s) already check/report for null skb, so instead
of adding another print here, maybe it would be simpler to check for
skb in the condition where IPC_CB(skb) is used:
`if (skb && p_td->buffer.address !=3D IPC_CB(skb)->mapping)`

> +
>         if (!p_td->buffer.address) {
>                 dev_err(ipc_protocol->dev, "Td buffer address is NULL");
>                 return NULL;
> --
> 2.50.1
>
