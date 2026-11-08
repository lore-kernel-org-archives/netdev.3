Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794123382;
	b=vhCFzKUKaboF/mMdKaw+/a+8xp5Ob4Or78OwBtq5CFUxpqnRBBahUyiohxHuyvwZUc73
	 El8R2fVG+4xbgs5BTyKV+KVIvdn/REVHqBJrug6b2weZS/EbbvlJPwAZRhxuyrnUtQLSQ
	 cDRHZT4WoMvrcx6F+8fNUgOtFrZYQGh7wIbh2IxDaKgSY1W6NNT5aMY7SxwD9Wg4E3UOp
	 +iCLoDETVPMGHOvWQfy6q6hiJ0lNDo7y0xYAtEK043+tu/l3MjjL9bp+jNpEmqa7BjWZr
	 N5FzsSRK+lk5XRNfaDonDzaZs26Fm36q77hXNfFdf2Yg1VsO5TuMRnJn/4SKoobC72A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794123382;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:To:Cc:References:In-Reply-To:
	 Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:Thread-Index:Content-Language:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=2n+UGKuuNYXc6rxjwiFZUbX5+lAllqeXmuw10kG/+ks=;
	b=RrCX8wiNMA1l5WnopuCFX52jcDZuknGBk5QD5vCf4oltKIHpdVecXf0I3iMXpaZB09UR
	 Mec7dz/mHPPxnbyMKG0IeUgFB7mZdicuTLQGJPKOLfzaNn+PDw7kIuxYlNnQUbYLDvE7f
	 0dRZdhpdfkr1PBmvG2bCYp/uy6Wy4IBLKoY8LJL+Ngt/+AXHYJW74Ba8gg2GTZCI5Qlf/
	 10M2JC0cbgyFkCVDqYDmXJmz9rivRZXbXvMW4uzP+TyZtx/3Ldn9+zsJ55+vt6b5jbJcs
	 DXbwNmE4lvB+PRRSi2bkyezFVN9FzLvos74B++U0ZCBJjlSeQhTNZRw/f0pDEloxCBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ekQHlie4;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="BaJTkE/u";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28286606A320
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 07:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28286606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ekQHlie4;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BaJTkE/u
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A84KJwu3062510
	for <netdev@vger.kernel.org>; Sun, 8 Nov 2026 07:36:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2n+UGKuuNYXc6rxjwiFZUbX5+lAllqeXmuw10kG/+ks=; b=ekQHlie45SBXLwQ4
	Tzm2HcRuAecMksHtkmMyocRQ4VhTa6Opsw0ziH/ZKyQ9Gq71nUB9FZrgFhVqGAm2
	CLu2+PqogaM6Ah6rwawi/kQtKWwEJsXuK90MdD7ICEGxRztiBzu1vQwg86x+Ve+s
	ws1xpIxbtHz/XG9nwc74SWUZUtLJRtPbIw79RGvGdSbvamvM7wUQrvUcsqxSLv35
	JDKe6v0mUwkh+eCodXW3TRtQmTWNdnuSrPT43I7ZELi+9iompXOXL836sA9iP9nn
	ymhYhvG0ycyN3b6Sr6Ygfd8WkkAj+1E/TkFGt58AzSFn06OIcRb8J7uFznZGeEws
	JQXNAQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsw5k2b5h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 07:36:20 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30bcb065bfdso668251eec.0
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 23:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794123379; x=1794728179; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2n+UGKuuNYXc6rxjwiFZUbX5+lAllqeXmuw10kG/+ks=;
        b=BaJTkE/uaNrJrAxuFGyLUJHx7v8XAr6Y/LAr8yxiDkYKalklF86lLCbem7DfqaTvJ2
         uX6w2ve/d/VSSTU+vrk3qtnGA7HPCl6R8tVMr7nZ6P8mcFYdxJMZ56y+qcnT3ii3neTQ
         /Lpwt7NorfIgUcTQBxtgjbuNReshCRJXPUIREgSdlSGl9EWMrVG3k/v8zE5h7B6S48f+
         aRcpd0vS3VJx/18cXY0LwcVS+HXoJ+r+wyh0JWVs70x6gBSfW6YgjlwEASpGRL8Q/MWU
         Z8pOQTwPq0Bf0vEAs2D72bk55HeIs6ApRxRI+s3+dsEDweDr5zVdFWWRHfnXdtvU6WX4
         KOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794123379; x=1794728179;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2n+UGKuuNYXc6rxjwiFZUbX5+lAllqeXmuw10kG/+ks=;
        b=CujtnShaCpFR7AMm2rNcE8m5fDDKQgUsKYh/3tMOc5iq9oeCEYR5PcNKZ+7bO/N1fC
         yYR93cyBKzKseG5QHdLOnHJEvntbr+/nqiRqykrS+0+I1RQcwtjENq8QVNiEHIe0AR3n
         4m7tZVLr2j3yn4ZFBp1lfsxZO2TuBgrMzPECGYmOJt226eVLQxpbJdQL6meIeMnW7VeQ
         AAVjhzVQlPOrgB1feWYmcc0xB5pJj6Z5ga+u79PmayEOePZBoyOzL+a2lgmUOYTGkABY
         VWb0waHRO/67Wk5VELZw0H5D2/TD1RF+k5RePoF9lDCNOUCWl61hkZt2r862C9mHKcGA
         0MaA==
X-Gm-Message-State: APuU4Z+se6lsxnyg3OQmgrNe62DLbAPaZyQ8QUhqVPAAMw29x0dt5eKZ
	awWjkubnUxdUakt5dXL5kNHVoR345vukPDllfubeam282SiVZR84g3WpwGLGoOlc1CiCY8qWC5e
	9tCp/yZ1T3Oo2MEt++vqdiU3U+7Pvw0O1rWw16zofuvDExmnsMGm03whvcnM=
X-Gm-Gg: AYBFou0b5IJuGcsZA6GqZ0k1IEEzO7iovff2KPkuNP4vLYmVR/iKj1PcJESZUqpMi6a
	ir6qWPSvNNp3vTZ9hmagUnSyjACc3svWoAv0ieK6cfU0Ilhny/WnT4Exqw7KQF8sz1HGY0h+jpJ
	HapE/oft1xH1xeVsIyyCOUiwC4Xp4ps6JTuin397S0Q+/7zO6LPK9UhWh2bBaynO21enIj8TBzc
	cifcyzwzChmsvHZlwLQOOTUS3TxQwYt5ztG0gyEm346LaJLlaPweU1oENJN6BhodXYSPzCYSgP2
	bCmOm1KlocQTz/pSD5q31VKUIQVjzkK6tA1oY2/YCbfonWk0D1U09uAEh0ZGNZXRL5du+cLtf/6
	9T0pdCSjrWlv8k9i6sq9AbSQFw3yNoOF4azv3Z4CUoyFJCY0l6dnqSxM0RCw0hZoP2v7mX/HjGS
	DpZb5OzAWlUoGmY462CXMnuFB8f+s1+nlkndV+QdjCnzjGEz9lbhVmaQiJ
X-Received: by 2002:a05:701b:2903:b0:16c:ff3a:d72e with SMTP id a92af1059eb24-1b39fe987b6mr1231197c88.20.1794123379498;
        Sat, 07 Nov 2026 23:36:19 -0800 (PST)
X-Received: by 2002:a05:701b:2903:b0:16c:ff3a:d72e with SMTP id a92af1059eb24-1b39fe987b6mr1231170c88.20.1794123378880;
        Sat, 07 Nov 2026 23:36:18 -0800 (PST)
Received: from QCOMk1gASIiYhG (66-33-8-210.colorado.intrepidfiber.us. [66.33.8.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3773ea50asm3556452c88.23.2026.11.07.23.36.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Nov 2026 23:36:18 -0800 (PST)
From: <subash.a.kasiviswanathan@oss.qualcomm.com>
To: =?utf-8?Q?'J=C3=A9r=C3=A9my_Jean'?= <Jeremy.Jean@oss.cyber.gouv.fr>,
        "'Sean Tranchetti'" <sean.tranchetti@oss.qualcomm.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20261031221052.1642262-1-Jeremy.Jean@oss.cyber.gouv.fr> <20261031221052.1642262-2-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20261031221052.1642262-2-Jeremy.Jean@oss.cyber.gouv.fr>
Subject: RE: [PATCH net] net: qualcomm: rmnet: bound TX aggregates on byte-limit update
Date: Sun, 8 Nov 2026 00:36:17 -0700
Message-ID: <000301dd6f53$d7b931f0$872b95d0$@oss.qualcomm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIan9Ym6wgfeJXkm0ec/mIILiLtiwLTqZcCtpLKmjA=
Content-Language: en-us
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDAzMCBTYWx0ZWRfXww5ehNc7T/V3
 rS4kgE1adlts/pO+iBRMVPqONfzFCaVzPCrrel8EUSclSvt8JSidLsyjso6L/1p4YhxgX5ZHTUD
 dInxEULDyMXWjvVmCG1EFE1DONIopOAW2/19O32enrAUVMAPfSmSBsLyPL0WX96vsuxTu191ufy
 IGXA5bsQbePK8FibWWniIxZNHjvbZBPid0xYTaVYKHMYMsDBzr2YFjM61xyhiYfvoFN9UKr+OK2
 B4qiLpAqz5VXwr4zZdK9sFma63RZOHPo54ugguqq1Llw6YZM3AuqJOQR0d2QM0diugfESHDcjdu
 phra84UTYF7aa/+iPh9fZt5bAo5HqhNHXVBpYzdQWDZzgdAYq1sHqpzPNniqIdIAjys/phtbwWO
 GWhWIBzQI9kroRdvrWRgKKCiMmqVWBWreI8tN/Haeh833PGePQPueAOdvZFFv5UisrRnKYw20XU
 pyX0PE5pbL2CzK5e52A==
X-Proofpoint-ORIG-GUID: AusIvBtcAW_9ZURGSVqF-6eXSEvPjmpE
X-Proofpoint-GUID: AusIvBtcAW_9ZURGSVqF-6eXSEvPjmpE
X-Authority-Analysis: v=2.4 cv=G/aJgNk5 c=1 sm=1 tr=0 ts=6af02674 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=OltkOWFNRHEXGe+8VJKHzA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=fZt6mqSA75pAf0XC2eMA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA4MDAzMCBTYWx0ZWRfX+d6vDSmGZAF4
 LUSp9YuItDVghH4dUvvHg0CLwHCqZfCfsd6l4jznwl/ltJpfEjkBQNlh9lwlFpEayAc/Dz1YlOI
 qz9ZN0WGto+NCOXU2RngZTlTvb/iuY8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-08_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611080030

> -----Original Message-----
> From: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> Sent: Saturday, October 31, 2026 4:11 PM
> To: Subash Abhinov Kasiviswanathan
> <subash.a.kasiviswanathan@oss.qualcomm.com>; Sean Tranchetti
> <sean.tranchetti@oss.qualcomm.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; =
J=C3=A9r=C3=A9my Jean
> <Jeremy.Jean@oss.cyber.gouv.fr>; stable@vger.kernel.org
> Subject: [PATCH net] net: qualcomm: rmnet: bound TX aggregates on =
byte-
> limit update
>=20
> If userspace reduces the TX aggregation byte limit while a buffered =
skb is
> pending, subtracting the skb length from the new limit underflows.
> The later comparison with unsigned skb->len then lets the buffered skb =
grow
> past the limit.
>=20
> Check lengths before subtracting. Flush a buffered skb if it is =
already at or
> above the new byte limit.
>=20
> Fixes: 64b5d1f8f2d1 ("net: qualcomm: rmnet: add tx packets =
aggregation")
> Cc: stable@vger.kernel.org
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> ---
>  drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c | 12 ++++++-----
> -
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> index e6f48dc9fe64..205ac81f2c82 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> @@ -594,7 +594,7 @@ unsigned int rmnet_map_tx_aggregate(struct sk_buff
> *skb, struct rmnet_port *port
>  	struct timespec64 diff, last;
>  	unsigned int len =3D skb->len;
>  	struct sk_buff *agg_skb;
> -	int size;
> +	unsigned int size;
>=20
>  	spin_lock_bh(&port->agg_lock);
>  	memcpy(&last, &port->agg_last, sizeof(struct timespec64)); @@ -
> 606,13 +606,14 @@ unsigned int rmnet_map_tx_aggregate(struct sk_buff
> *skb, struct rmnet_port *port
>  		 */
>  new_packet:
>  		diff =3D timespec64_sub(port->agg_last, last);
> -		size =3D port->egress_agg_params.bytes - skb->len;
> +		size =3D port->egress_agg_params.bytes;
>=20
> -		if (size < 0) {
> +		if (skb->len > size) {
>  			/* dropped */
>  			spin_unlock_bh(&port->agg_lock);
>  			return 0;
>  		}
> +		size -=3D skb->len;
>=20
>  		if (diff.tv_sec > 0 || diff.tv_nsec >
> RMNET_AGG_BYPASS_TIME_NSEC ||
>  		    size =3D=3D 0)
> @@ -630,9 +631,8 @@ unsigned int rmnet_map_tx_aggregate(struct sk_buff
> *skb, struct rmnet_port *port
>  		goto schedule;
>  	}
>  	diff =3D timespec64_sub(port->agg_last, port->agg_time);
> -	size =3D port->egress_agg_params.bytes - port->skbagg_head->len;
> -
> -	if (skb->len > size) {
> +	if (port->skbagg_head->len >=3D port->egress_agg_params.bytes ||
> +	    skb->len > port->egress_agg_params.bytes - port->skbagg_head-
> >len)
> +{
>  		agg_skb =3D port->skbagg_head;
>  		reset_aggr_params(port);
>  		spin_unlock_bh(&port->agg_lock);
> --
> 2.47.3

Reviewed-by: Subash Abhinov Kasiviswanathan =
<subash.a.kasiviswanathan@oss.qualcomm.com>

