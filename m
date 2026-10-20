Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792491319;
	b=PoKeflwbN8KdZf+lpWHylamWCLbxiS3VYOfdmJtJEOO+WaIYL8XWriCtw6IAY30Wktm/
	 Gnx9v0e7ZyzSEeVFUxJNJ2eUR/6/lDywxCFyNBkHljXC6bH/p8e9azMO0ccwsNBRtOrNP
	 45EsXFUHst6CnRXYkdcK9gG4mLFyo+08QcixjIcH5/Cz5kzkmay29XTXKbeINF0mutVb7
	 JAy2mUl87UOiputnAc7Sm9kJpdKWeEOKaVyjldWzauxT7T5WOflIujmQ3ssER/z8E5sV6
	 zAcSyX0KJlAWBdvxm+YU3tdjXvQjup1fGWW1H9SxptSK1yFpK2MaQuA/fEnUZ43RvPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491319;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=USzUAeXmvNCRnE9FctU6fubUlHkhva9uo5i/eKw0KrI=;
	b=pZUP0Xc5S44ZvFid//K2mP1JmrMLdK3ttejsjG93/HRXViQYa0ca5hOWokMpN/YlE5KS
	 /L7ORBaLO9dQh9Dqpf2KX9LZTtTfsTT7zE2l5zADBLg6jUopaZUPsfYdvi6t5NiqONt9B
	 2+4RsgODjz9KVeiSCu7/DMSRvD98IUf3Zie4WjcSklHn1/hBM3euSJvA7hq8WBa31aXRn
	 WUlGaSvlweBXts12pWa/4VMYK/wQdy8WzG9+YlEjIvPvD2mAVl9oVZAupxkfCiiRRiYEW
	 EiVJfNvTBhWnzB+q8JPvJBYbq+yYl7twkYRpRS65r8T7uLHzeIF7AwM48ozWhqXsb6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UKkTd88o;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ulz5B1US;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB6D606A31F
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 10:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FB6D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UKkTd88o;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ulz5B1US
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69K8NL6d2877952
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 10:15:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	USzUAeXmvNCRnE9FctU6fubUlHkhva9uo5i/eKw0KrI=; b=UKkTd88oLwZdCd/+
	YCxYihHaOby/yPYVVziRpjuEbPJJKmoW5Qq1EKX8mhlUbr+UNA4Rp9aBTauxsV7U
	q+QAdtBVdkXyAs4ui/EUUREDU0dSc7H1CbD2lMHucZGIBbY69/eUavQu1/ttygVB
	L5uf0QCUd2auv1Yox8L0OviRJMJf6rPA5CvPAvX2ReTBCM7TDtqFKGI7FI8r7NrV
	IpxKEll8pVtkdc5GZVr7wmMW8doXKpFi92V/jknOgtIEYOTXntihyQnCG8I0pov3
	pgmn2yo7SFv8/4wS6oFvnSdXuSW7mkoHv1Zr23dALiHXYlKdpsU8VGBRIVqkEdXy
	uNy3ng==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5pt1f1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 10:15:18 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93e92aad34aso625280985a.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 03:15:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792491317; cv=none;
        d=google.com; s=arc-20260327;
        b=fZA0dcpy50lYSVfDPLW6PbpIYviJyEGUDqdH56oGwCnYiw6bgfD3tH1ZwBrrqXrwxe
         s/hhYMljZpyt4FSHdNMabn4cyPZyQKdjC/+8ec1UpU2+4xKRcaULDcGtNoo7u0Lcv+j8
         XDTFRMT0XFfzRpmCHhReXFAm2+EO2+9zsqO3h9cgDLZHAZ9hu1wV0s18B1mQkJXeIPet
         SQD8gbnzhjD1F/r64aNJCvjOwH7FpkQqKM8Izi6zM5M/z3v1LqWdqfqpAlnwIZkmekWM
         /V4sSpQX5MQbW7JlRDbY4ObXlw7LxEy1/CbyMQCjerKRY6gC0qnXY+0ap7m1YKcWArc2
         YUbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=USzUAeXmvNCRnE9FctU6fubUlHkhva9uo5i/eKw0KrI=;
        fh=HKIvvVQCAW/kNBWTv10AyLy4kANfoZkJyzYM4nlELWk=;
        b=Bv8BY5eUt8oQdQ0crwRD8w3pUGT6g1nnJ7rjPiufSyf6hixsh1DyIbqt1FrCWRVYg6
         Lv+/nOvPVhhZtc4bAE1FdKqiKBrGfCaIjc0smdFGbFcCEXxDqJlihvPVzrJn1fHLuSni
         djIk+C0ZUxagdQjWCWL8Wo7Yftmt5WGeALOzONxhX4Pii8zhuVS6x5FkjDQJgin1dEFc
         +sRloCp5jfkIBkBCU11TaL7ZINTktT3DM3aJS4RNUWkyWWv4jiUTaBM3mKSQZ0V7l/ES
         aJgxf7m9S3zqJgyLUAXnXv+TGFFFGJ+AAbc/nEuA7u+jxNN4gXj9YrGdbNotg6zNXkwj
         +KTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792491317; x=1793096117; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=USzUAeXmvNCRnE9FctU6fubUlHkhva9uo5i/eKw0KrI=;
        b=Ulz5B1US1WxZAdUJUv8EZC/hYQ5/YRkEuT3q80ZV8FVNrib6/z9JF0vCH2Fo4zoeNV
         9n4k19tTy8OcPQjscNIB6/X5Re549QL/XhXFQbqwumqKebdiM/G5YaS64HMeWDkP/k9l
         wRg6bQX+5Yuku3yyg1GKUY++JNirktoDdaYOAJMlmrJmnUBnj6/JBCU2UeOMCeYNJ12O
         8zo9UVcC5Lq3uk7ZGIdDe0SvJwUoaRXMyFiHCgyUEU8iVGPtW9HmH6r8qyPcLVdegRbn
         qAoFzICDUseH18WfbiSht9kS0m4xDQuNn0LyfWfdnITVE8xf6vWTXCB2lAAYAFQ9komP
         AXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792491317; x=1793096117;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=USzUAeXmvNCRnE9FctU6fubUlHkhva9uo5i/eKw0KrI=;
        b=PO1T2zTJgl60Y2Y1uB/MzQVhZN71a1MN2M7twLG602eTO6489q1kXpt9NBEtY23YB8
         EpvqsLmfHcv6mYC6eW9arYJX9tJefzVZcl1qat9E9nfPz4xRXchPOY1I93MyOpYZUfTI
         ow1XtZAPAADsOhxVSOqHkBZgKAlAc4AkOaSjMp8w3kBYzyuYMS7MuQR8vHJGbb/28+VS
         AIg/ScllWdMpeNE3YJ0yU+pfu7UmKLFTZT9C6Be05MIHnLSWARxsH2tTLgjMnBSM84o5
         nIT4EzRVK9hrZqvq/se6bxj3LygpVpta54QNdEgQYbJGmGyRHJejJpqq3Y+YT5MKIOXR
         YC/w==
X-Forwarded-Encrypted: i=1; AKwUvBwKdA7SV1fFwJJhOfqdf5gXiUY8of0F22NEsn+KvuVaUTm2zsuIndOSBJxuJb8veCHAhNY50nw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKooLPcVquZmAE1uTZ9rYj5DTqJQ5NFqd3Mcy60jx87gs54hXnk
	+bwFlWDjGAfYAAlEmKcSn6rHg4lCUvy6bs2j9B4j9YW8KZcz89Wx/P6GYvt5+eHm3ulNNxmAIC2
	hVWpo7c+Fhd5Wy++lrQv/I2dxyDx4a+GGnRucV1M/5kRxzir+GeDSj4wHVLJ7j2PUR0RWiADziJ
	DSuwrUlm9907GZztDYvezE4y9NwZJGuQjuqChr3zqTkQ==
X-Gm-Gg: AYBFou3sHqTvFUg27bMKLsy9u1DFomEZ/I4pMBqCGSA+l0H/aVfhiR44PhqpvdEeuhP
	mOA9AKMmpnSnjL6BESmnXFojRpoXwdhLLskN89T4I/HTfuoWsC0QV0y2SMbdEPwEPjlk5cx4JPo
	gJHW6BHWfg9ZU+a5eWd/b/wvI42ZHvgzwc7m7UaDehNoWdRrq1C4t7uvix8e33XwDIzgJVsHKrw
	MWY6fuGbOmRDFGlgtCLx8FwWcPLXIiqvKzBNa2CyZtT3YZHEJQ1DFl8T1X0bo9u/52L77urW98=
X-Received: by 2002:a05:620a:c4e:b0:93f:1f22:96a4 with SMTP id af79cd13be357-93f29cefa8cmr1720593785a.29.1792491317451;
        Tue, 20 Oct 2026 03:15:17 -0700 (PDT)
X-Received: by 2002:a05:620a:c4e:b0:93f:1f22:96a4 with SMTP id
 af79cd13be357-93f29cefa8cmr1720589785a.29.1792491316829; Tue, 20 Oct 2026
 03:15:16 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020094254.4017726-1-liuc63@xiaopeng.com>
In-Reply-To: <20261020094254.4017726-1-liuc63@xiaopeng.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:15:06 +0200
X-Gm-Features: AclHuK9KNDkqLpjluDp4MS8p0mVyq6DiUSCMyPi7A_OSUeyRYLDop--oOo4-vxw
Message-ID: <CAFEp6-3dycfwn-2O3X6tMYmYuTMgDgoOgYrxGv1Qcg-F-YZ7Lg@mail.gmail.com>
Subject: Re: [PATCH] net: wwan: iosm: validate msg_head before indexing msg_ring
To: liuc63 <liuc63@xiaopeng.com>
Cc: M Chetan Kumar <m.chetan.kumar@intel.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Fang Xieyan <fangxy@xiaopeng.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=DrrDa2/+ c=1 sm=1 tr=0 ts=6ad73f36 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EgahoUkMAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=laIMyccDeTmSpVvBuxYA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=D2SkTF70-_n5gOfERQdM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA0MCBTYWx0ZWRfX3MVjE07tOfeX
 47RscNPh+IAkz88WpMPZGfY8eQcoVg1IGesYzgRugB92M7AIpWHfFe7coa1Ppu1ccHoEWJLVsN2
 PHMUUQG8RpKWfR0MnEKlPJC9xZY5kTSWSmaKvtVM3ohPAxx7xsXGxFJYk5wrHUrOht5eMe2gvzO
 BlEKxhQg6nIXkDnGUmKCbW2AyA/i7BszT+eOKxlbBqNX5/R59+/+Xv70C2BVubABBOurzphgdIh
 Eri6dMDi05HtgiBYXAR6VW0+oibRYolzbKMO4KKlWxzAhcEiUGAMIjALEh9bwd4CBNjiE6p8ZXX
 +AtLgjA/FMKg9s8rGYR3HpEpPurDAfYRqxZm3WwsWiYmNQRY82KVcolT8bOZwDCYW0o/hxaLW1s
 uI0/8DzIvEBPxwhagj00dkw5jkcFBQduTTvId55SdRjagHiymVrBODGD1fZxt9LQ1idWFhBuo0r
 VO90OvfEKC0H00wyH/g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA0MCBTYWx0ZWRfXwr/EslkGdJmo
 Isywz3r1JFTHt5QlW0bQqBqtYrBOBEu4+Z7woutrwq0aCremeSJGhgiJvPGEQjUlbeeA4VdhEAc
 4yDEvcjrE1sojgoira82jD9Jx6X0w6s=
X-Proofpoint-GUID: P-Xe0jCQdT1_TH8kLJV7rA93cIum6gKX
X-Proofpoint-ORIG-GUID: P-Xe0jCQdT1_TH8kLJV7rA93cIum6gKX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200040

On Tue, Oct 20, 2026 at 11:42=E2=80=AFAM liuc63 <liuc63@xiaopeng.com> wrote=
:
>
> From: Liu Chao <liuc63@xiaopeng.com>
>
> ipc_protocol_free_msg_get() reads msg_head from shared memory and
> uses it directly as an index into msg_ring[]. If the head is out
> of range, the subsequent memset() writes beyond the message ring.
>
> Validate head against IPC_MEM_MSG_ENTRIES before using it as an
> index. The ring is a circular buffer, so a value outside the valid
> range indicates a corrupted head pointer; report the error and fail
> the allocation instead of writing out of bounds.
>
> Fixes: 64516f633bfd ("net: iosm: protocol operations")
> Cc: stable@vger.kernel.org
> Reviewed-by: Fang Xieyan <fangxy@xiaopeng.com>
> Signed-off-by: Liu Chao <liuc63@xiaopeng.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c b/drivers/net/=
wwan/iosm/iosm_ipc_protocol_ops.c
> index f2f86f41fd10..004920068c45 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c
> +++ b/drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c
> @@ -14,6 +14,11 @@ ipc_protocol_free_msg_get(struct iosm_protocol *ipc_pr=
otocol, int *index)
>         u32 new_head =3D (head + 1) % IPC_MEM_MSG_ENTRIES;
>         union ipc_mem_msg_entry *msg;
>
> +       if (head >=3D IPC_MEM_MSG_ENTRIES) {
> +               dev_err(ipc_protocol->dev, "invalid message head %u", hea=
d);
> +               return NULL;
> +       }
> +
>         if (new_head =3D=3D le32_to_cpu(ipc_protocol->p_ap_shm->msg_tail)=
) {
>                 dev_err(ipc_protocol->dev, "message ring is full");
>                 return NULL;
> --
> 2.50.1
>
