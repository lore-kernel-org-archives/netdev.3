Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793609956;
	b=GGy4E+9um1QsadA37/RupRsXPC3v/0cocxnYWzucQ/spKQ/+sIe34oilfRyvlHuvn37M
	 gnjb4UAMFoPdV80oQcWbKRLHjtMbr2pB0SB6LVTHjyKh0ZhXHCdCXZ7CtlkPcANopekwP
	 gs2yQYg4y19zAssQ/ty6ZkVUDCo5UImFoO6ces/SvKEEZkIVnr7s7Ideaz72hTfJPOZ9/
	 jXFua5jIw7K3Jx7QgGZsb+BWugeHWa5tsCReclP8W8RDYGROdrsDPrkkf9kPgJKzkeIjl
	 DhhDTs6Uw0VoH3C+ceIBt17LoCxSjm1JkKXCd+b2W05JmWRKp2GsUHgDf2OlUInyduA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793609956;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=wH0pYginndFNXKmHWtZ9RkHg4TaTelF4VIgtZlMHbgE=;
	b=fOomIbdFYV0OSvX5ZDJ/MJAACjvrUdSJIQXrr6fQnrlPAwYKgTNgHnG3vLxRng1jLMIV
	 byMlIdQaLd8GeHVf6pWmUD+T/cxttSHvXz+5PuLuLfo/wrbCp/Yx7Alga5TnimZAdOcD3
	 6F5DSEh9+KCnE0nGiJxxWuMliAKwf8IjbzRvnTyWrZo3g+4TV8Y3e/fztvoz3aS/A5R7I
	 10JZQ4Y8kC55E413IkFt51MlR8yrO8QZ9WJyeIdQ9tp+bvOONneo8HLbqucPYhykBhgRA
	 1QgJHX1knn0C22rZEouJt7oFSTYMhIdyMbT0sai37GvBGv9Vzm9edFFdaOdmdsKZHfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Sc9Xoyrj;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kk52tOc3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155AE606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 08:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 155AE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Sc9Xoyrj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kk52tOc3
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A26pgjQ3121054
	for <netdev@vger.kernel.org>; Mon, 2 Nov 2026 08:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wH0pYginndFNXKmHWtZ9RkHg4TaTelF4VIgtZlMHbgE=; b=Sc9Xoyrjm/M2Hzci
	KWUdEyuJd+F5CrlengSQ0+5xWNpiH74flcMumwoJDyM96aSc+onN+U0LHlTDJo+w
	pVKahq9ZLo9nyfgPV3jGqlW3Hsj9zYMVHRGnU68bSdxTPLc1ZGj+QEBDXX+CgFMB
	tNDWOVteg/OatLrnIrq6Wjsi45ABRKt3juUpKl6KadxmQg1FB4h+gI6DPQdcMlRZ
	1JCT1sLrPAa3iSPJRJZ7fQRf9SsVseLdzhedxYq7SsVdccZGXLEyswP6BVHOUH+y
	TY2mEKJYMIvsUhgH8iTRHisbaZzwKLEJTLokoY82dyxgCfoX7QLAAjqIw0nCFcEx
	isi7cw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpnmerfn1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 08:59:14 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f32050e72so237941885a.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 00:59:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793609950; cv=none;
        d=google.com; s=arc-20260327;
        b=dYoQYC1VVfuX/JLhJuNHru60wpFUK94DCYPsDJdJMcPWQT3zc+9z0XquVo8zWQX0Ux
         F6Cs9y0jQZQhbInIKpfgsY/L2KhrcSdE5Cpexi1CfHvgKWGkBlAc7NkHPfIlAsJvLQOZ
         XUWijFnpIu3KpdV/oW5eXSqJlAP2z1k/mqwS8hbpBO/OFg5KX07K6JVyM3BriLeQdt3N
         2Fc/doFCG/qGn/Ue6cAyTOdnB2FZgcRFYIjoYwBLgWqsQbc7Dl24mUhqfugcVvMMBeas
         Wcb6dg96ZFgY6HXD9JIahNKX6TjKHGszz2zkTu8X61Fpi8BNqlw5MvB0e6apsmvKwW2Y
         rwNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wH0pYginndFNXKmHWtZ9RkHg4TaTelF4VIgtZlMHbgE=;
        fh=XLWXBwGvzcAxAUCcR5eZHv6ClyC83HAYRpRe5zDog1Q=;
        b=aWSCNF78/KE/+LTY3sTAEvkY1bbATw1x2lBg+XLy9ZpjwlCn0EVLTUglr2X6EP/EGQ
         ZV/K6KProDzM7QTwzPOH41zVQlxBZYTbJ3LHZ7EpB1hWtHx8b8Tf7PM8HEEHN5UiYYnS
         HTe8VoBZnkamO7JNdBMcBz7QJlOyVqqRf1KA6/qVf+5fFSOHO3A65WFHlbE+ttFzk7hG
         oYH1xqOFEkSvCTLkzaG2yyuoIAu4RUpiSnvrG3C/YH4e/FRmB1Qt9VNJG2Po5spd/nSm
         GLasd9aVO19HV6r5l6VbVgCQAGQnu02PccFhCagdIk7DTnGSFsKfTtp1WFZyqZi7rZYK
         iyMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793609950; x=1794214750; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wH0pYginndFNXKmHWtZ9RkHg4TaTelF4VIgtZlMHbgE=;
        b=kk52tOc3BapLxezU4CtQuPsz+s1kr6x4Z+J0UjG237B6UGwmitkG6jC6C8Cw2/uZxz
         c8bKvMdltv8F+Zw4sqU4yKp9r1i7vbDLOQ2IhAUTIWee60Xgwxbo1S9b1Nr644RwC8Qo
         Rvm7QJLoFEzR8rYHScBLxKb5JaLqZLsxT1Lp/c//VpLCJ1jJYMGOuCXQyiPwdNIizISI
         y5r9Or+iJPzccsGY5Wy8ZHCjmY93EXHOLauCx0bhKNM6I0kFdS4DyU/6k97ESpYHJiJt
         68zhiwi6O9CWvNh5XcbxALAljfGgGwgR46kAanBVsu+icJW5YCYGpzc6r9EMHI0PEDS4
         b0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793609950; x=1794214750;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wH0pYginndFNXKmHWtZ9RkHg4TaTelF4VIgtZlMHbgE=;
        b=b1YdmwiPE9MXwJToyxPE4aeHGswfM96nVkAY96iaRiU8CDcSgGmtz8rXg9J0hktfSI
         xEcH8li+ZF04WuHp7F/wHa/PgT/fMD1F/adZZJvGxgr6VqGgViLf+KmdKxh9VTAOSBwY
         aZrZ2PVHbJNOn0cv+ZA/k7VahPrxjE21R6osTHWy6KHnmTBWRtN0jcuf+ieEjyf/YVC3
         9Lj598POVIrfDvf0EWWMIKq9j1TmrOEl4oPrdDo+vi2B6V5yxr3vKVMtYCOakmVRd5Jy
         r8bKZeqyl7Osi3dUIvvZx8u/GJ9mqwYW7TN9KIwQoWiwNCg564IT+9eZ7KBLfyRDdNet
         R5PQ==
X-Forwarded-Encrypted: i=1; AKwUvBzyEHrjh/tVh9BsCHs3SHoEICrRmWu185NfRNpGglEX/0ETd7Cw92TV3QnpbH980ralNIGbTOM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6zgO5hbwd6CG1R4RCgU5G4juDvzNTIxk1kKBC75XyeipkrMsu
	nOO0BqOdLLNvuYaYRH7FRuXTqSW15HkYFdIUCmHTJdCVGIMbMM3adBtzZy1+YE98oCGJv+iIhEb
	VP6oqrLFn7L3gTT/ipYVGKVt4uwHeEOtg/bo3F0gqHVI85IynNPz+lj43kITx/tL9qUZl78lGeJ
	wzSZ7FlrSWcf0J91M9bPhWci7dRd8vcV+xMQ==
X-Gm-Gg: AYBFou2/v7cW+QEHudtF34H79ry9UtGbFlPcuyoo5kXBiC+5W2yd7hgCNUHivD+G+PV
	bqkYKQyJKIVFjSf7lmG5r+965EJVWKmz6oFZ2N18OWkAAnuMAINGuakl9XmI9jFwWCEVokkOxBS
	d13nEdEQN1oxiXZN6JodbpgJWsCEle54eNz5rcsKzRAVgkhzFVx9mZUC5cfcWjV+Diu8RA+i08W
	Tmq5dJpvdd65X1Hbf5Yae2mOKkvxDEE5FMgl10E6sYJEy7e2rjPFDNf7vLjeDbKqga1dk31vQo=
X-Received: by 2002:a05:620a:4153:b0:93e:f9ba:690f with SMTP id af79cd13be357-94421737147mr1533812185a.73.1793609950248;
        Mon, 02 Nov 2026 00:59:10 -0800 (PST)
X-Received: by 2002:a05:620a:4153:b0:93e:f9ba:690f with SMTP id
 af79cd13be357-94421737147mr1533810485a.73.1793609949729; Mon, 02 Nov 2026
 00:59:09 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102081920.50288-1-fangxy@xiaopeng.com>
In-Reply-To: <20261102081920.50288-1-fangxy@xiaopeng.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 09:58:58 +0100
X-Gm-Features: AclHuK-sllA9dS0XNIfV1bAcZUW7oqBp3VabvOVBggv578_nS6KaXfjT9KFUlYk
Message-ID: <CAFEp6-1JqRXuXQgaoCRDivHyu668d-5Sb-gY+rWbn1aEBqTV3w@mail.gmail.com>
Subject: Re: [PATCH] net: wwan: iosm: fix potential skb leak in MUX DL decode
To: Fang Xieyan <fangxy@xiaopeng.com>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        M Chetan Kumar <m.chetan.kumar@intel.com>,
        Guanglei Zhu <zhugl3@xiaopeng.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=KZ1HIgYD c=1 sm=1 tr=0 ts=6ae850e3 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EgahoUkMAAAA:8 a=JYyk8ZF4ti7sTYY4iAsA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=D2SkTF70-_n5gOfERQdM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzNSBTYWx0ZWRfXwIfm1w2s1YRI
 BEDmmKWUzYnXX7rTRc4PPyHUoGKy6ulAgRb9WE43ZkNlWCuvtDetpznfmKSF/ZixBXOTscHqgKT
 fjaVT5EfSkj8mlBgjYr/WA2XPRZX+xV7ro3ebVd9AdkopzzucntLgymqQPqbv574bZ6/M51RFpl
 cEcgWYGPUh9ptiJSAIkiHQxba0ktbbt9twr3pc1ifJiF9kn7YpfsUDKPFH1nSF2ZWEYqkxYcZvU
 wz2rz5T7+P6nQCkWjFWjX6MHtQSKgenLrCIjdnPBIQ/xAD2lt4IXEh8ExZe71bJp0y6lyMWcy9n
 IjQX0hrWUdj3GHCO/Xz/yTQvMV+3z1ZIGc4UpPgasUCbAt8yIWaMdTmw1/8uDPoqD7lkSLvZs9U
 O5Iar3hpx5iqZKOE0b2eaNiESLgd59zZ992IeeFbe7h2xE/fvj5GtWcHM+oYnkpUfltCDvRgVHV
 IWB07Cw6noSpfvCMPNQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzNSBTYWx0ZWRfX8ZspmsR+ZsL7
 z6Ap8AoIKNNRUO/Y09mTSvKX/lLUY5IYZVGW3kuf47F0VmHmt+2Ickv9t/pI9b3Xvz1AUugC9Le
 rS+jSstBmAztmRP9qoP0TG+jEPhD0eo=
X-Proofpoint-ORIG-GUID: 88SW5_6cdDqqkCKpO3Vtfixjt9t7vfMH
X-Proofpoint-GUID: 88SW5_6cdDqqkCKpO3Vtfixjt9t7vfMH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020035

Hi Fang,

On Mon, Nov 2, 2026 at 9:19=E2=80=AFAM Fang Xieyan <fangxy@xiaopeng.com> wr=
ote:
>
> ipc_mux_dl_decode() owns the received skb and frees it after
> decoding. However, the early return when skb->data is NULL
> bypasses the skb cleanup.
>
> Free the skb through ipc_pcie_kfree_skb() before returning
> to ensure that both the DMA mapping and skb are released.
>
> Fixes: 3670970dd8c6 ("net: iosm: shared memory IPC interface")
> Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
> ---
>  drivers/net/wwan/iosm/iosm_ipc_mux_codec.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwa=
n/iosm/iosm_ipc_mux_codec.c
> index 0bbd41263cc2..61700688eac9 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> +++ b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> @@ -693,8 +693,10 @@ void ipc_mux_dl_decode(struct iosm_mux *ipc_mux, str=
uct sk_buff *skb)
>  {
>         u32 signature;
>
> -       if (!skb->data)
> +       if (!skb->data) {

Can skb->data ever be NULL in the first place? This looks rather
unusual. If it can happen, please describe what leads to that
situation. Otherwise, the check should simply be removed.

> +               ipc_pcie_kfree_skb(ipc_mux->pcie, skb);
>                 return;
> +       }
>
>         /* Decode the MUX header type. */
>         signature =3D le32_to_cpup((__le32 *)skb->data);
> --
> 2.50.1
>
