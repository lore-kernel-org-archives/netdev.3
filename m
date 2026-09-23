Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96A31D435F
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790175835; cv=pass; b=LA7b66ULNepu3mizeMgCZsxOtg3WQz/jc08+AfI7XWcM3RTIcNUkpvRyJ7xfuEpntx/FXCTMInEodO7sgi20huW53xia0Y6ZnCXwMuts2BT2Z4eq+eYWqDPvxrR364Q8kBaVG1Ksu0Ni8tyN+skQp/sOtCuzd2EHfk2Q6dEhsOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790175835; c=relaxed/simple;
	bh=QI54wB1ZRIPwwHHM35cUuk4h5p328r5xKjYJPlaPtMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q4WpXZ6+PWtvEN9tHez+TGtQweyGe7IYHY5v3iGbPsQhAOfGY9XB6p/THYUMp634VdIYKRRb55ELlHLZ+0lH8D7kN9KhhbjEWG9dK1Ep/eJXxnjcR4NKjBHDrs5WiUsuc00vpr1/pG3aQOwTQnL7ZeJpPQkr1L0GvP2gh9Zofzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DEl3D4b/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YBF7HmFL; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DEl3D4b/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YBF7HmFL"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NDKs8A2056327
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 15:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/PeU2gEC3LoYHxgoHpBg+aDS+BEleaPfi9f+JiK36Js=; b=DEl3D4b/MaQwai3J
	Rc+Ru+AqBDlYi16WsBv2QLOrZss1Lb1ZCPQaal+Sle+OwKskQ+snUYVyT+yNJ01A
	F0EN9a3fIwy+dh6RNxn0j0O97M3Ghajsv9xbNbmZIefIpu6tVOh518WaktBrsTao
	6oeuHsh2TUYpTtNu8TvZJ06p0huj0qVwZHVOIFqNXV2mYmroJ2YVyYD+mNDEY2PI
	WEpk+pNxxufNYo7Oc+PmbtPBI5IaQRShwKSfQVexsbeZpIm5nyFeain6juIhH9OA
	hY3neNnzwcAqrav+o2rbpDeQqiwC+IhDhfPEydTnYmOV0kgpTGZ/E/Bxmx4bY0uz
	XWNVLg==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfjv0ftg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 15:03:51 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-97e9e1dd7fbso856026241.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 08:03:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790175830; cv=none;
        d=google.com; s=arc-20260327;
        b=c9peKrYb5F5exikIGFTeeN1YOFjlv26poZyC3Bsl3ioBz/+FkJB6+YwEMfaW/9ntmh
         CgH8Oo/vITsfse1dN3z6989r0SxUDjH9SnDsAsVjytdTM9snjb2B89dzQ+kbFE48KFSe
         OhQtcKm+k1uvTpbM0A9fCJJ6hdSDx+sJWLQB/Y93zfFDSTeuFqXd/g6mMOhqG2JejhKV
         l18pMw1Ho2+TaBo+uUqtED8ccZB/L75ujQtUBRPEhKyWrvth8H5e/ez/mtR1QisNF1Ec
         iS1KQjC1OCpW6anPteHif77V/STqS+fiHggJpFRcy1zCyh5rELefFR4nNZ8wOE6DXw8Y
         aVpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/PeU2gEC3LoYHxgoHpBg+aDS+BEleaPfi9f+JiK36Js=;
        fh=ObMLMwJoPc+JTEK11YvqhafgKrh05lBrdII2zo8eN3U=;
        b=SqyL0wCSD+AflYwDPJBmuRK8nJtbAzw2PMtWLqU0M9CYYswM7Y1MTZJyB0/NCAla+o
         SaX1NcFPnco0TUzcCK03vZIztkAE+AqQLAkgc0hScijV75MunEZkrMDJEtMtpzpGDlRl
         mZJDneIfad6GN8F+LCNGTXwY1/T3TMidwJwm1Azh9a1RGi3/5njM/NHQaFRHRRIF7pSU
         nA7S8DpOxObwII5iTkGCwqqeGGheipRua+9MMHYo0Ux6DzxnBYY1dL2cBDBGjxrhCyeb
         s0VpK/W9/GUKkKf/BGqraPQyWEjr07RP7faFJk6Vonmg3E22YEpH3x7gqavbmGYYVVzT
         ia5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790175830; x=1790780630; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/PeU2gEC3LoYHxgoHpBg+aDS+BEleaPfi9f+JiK36Js=;
        b=YBF7HmFLoLt9wb9ovBAKGcbCe1sK6Inl2TvkMT4HFvH0FlMwe2g1WS9m1uwoJNUQpb
         BBobsGcKl1RF/WfZ34wdXzeIeE6pRDuzRXDaR2+dlGLbCzRCw2DO3ZycN547W59IrJ9I
         qknpHmnruLWrbs940qIT5sdcwnBywQ03JcoC28s0+j55ExG748/KhMBQ6QwetK6pZK/a
         TAt3JIS2u99z1vhqh9yZrPyFz+j5oHU9qilf5BqI0A+IFbeh0iz8oSjf/SwT/BEBmkJS
         RTHvcu4xLf+B9TSp0/MYSlgnXsI/VtI2ZaLSY9ZRpbR8CnEYuttp9oC1oj/hfCC8q7Kk
         z64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790175830; x=1790780630;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/PeU2gEC3LoYHxgoHpBg+aDS+BEleaPfi9f+JiK36Js=;
        b=NseA1dR7TWSCsxzdzGNkt44WXBn7G3Kx1CfTVvAwMUbguuirLassyGY6ogefzNVdE5
         H3wdaVLInHPMRT5t6bGwLCjGx3yqXUWG04fJZNvGBECtpS6q/8MC4+u8Kx4M7Q1TLYb3
         t8hJrDpykekj1Mj5umGw0pFLtI6p7fkyHKbENDUX7BZtJLaXpBQwZDeKM4dv3i58pcb3
         cbfVRJ0UKQ2JRW36JNmeCd+bzPB1baIUsVNJeaVw8tQeM0CUuaFNBgpBHeq14yloDtSj
         uOJUYtlGN31w0TIEFvly3wdgtc5fk68vRT5KvkQtXWcyXTrTmltp2hK+6KZDLGP5Zowf
         5kkQ==
X-Forwarded-Encrypted: i=1; AKwUvBxm+eThIdwu1GRSQIywS8iamvjb9ZkvskK71yYjEuePO2wOR4TYtdtfxcH8kVZGwPb5X4SlZcs=@vger.kernel.org
X-Gm-Message-State: AFuF++n1St11Ji9ObZmnS7NG6HpRTjJxlURdHdkZHeyl92QiG9SwVRnp
	SgX14SSzv0NxgcKRU8mDU+AIQg6c8xDpsUtbtpA44secjzkZscN8ZAkfOPNf6dfdjMJIVwteBcd
	8h4KqE3yueBt2368fmvbanWlYr+eq0pyLnXEQwvPbeSBEDBQ8ihgQK/JE74t9g0eJotwtnyJcEI
	Epx+yzXAbIGtbSDNX7sIWcVVD29bG7Fs8YeQ==
X-Gm-Gg: AYBFou1kjpz9Qm/9e80jhBaa8mOPPjx5xCxFllAI3DLQ5+XXuzt5F0FPKjS1vwhyHoU
	O6W2QK+nuCGSfU3eJDF/1eIGHiKjQdtZ42x3uot2nD6ZRrX0z5HPJQV0jas7lDPYFnrZBvhMH6w
	f1wZ/5NCN+GCK8tfLPwdQd5zm3J4Td9SGauq5z6AEgtHLo5SXmpRw8q+9dFQ==
X-Received: by 2002:a05:6102:5488:b0:7a5:e455:182f with SMTP id ada2fe7eead31-7ac1cfb78f8mr2788541137.26.1790175830202;
        Wed, 23 Sep 2026 08:03:50 -0700 (PDT)
X-Received: by 2002:a05:6102:5488:b0:7a5:e455:182f with SMTP id
 ada2fe7eead31-7ac1cfb78f8mr2788466137.26.1790175829576; Wed, 23 Sep 2026
 08:03:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-qrtr-multi-ep-v2-0-27dd80d841a0@oss.qualcomm.com>
 <20260921-qrtr-multi-ep-v2-2-27dd80d841a0@oss.qualcomm.com>
 <a16d507e-17f7-4074-8817-4b8da3a71c3b@oss.qualcomm.com> <8ed398ba-2ebe-488a-a213-8ca7ecbe861d@app.fastmail.com>
In-Reply-To: <8ed398ba-2ebe-488a-a213-8ca7ecbe861d@app.fastmail.com>
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 16:03:38 +0100
X-Gm-Features: AcwNN1Ug9EBugFkjb8PX3BJuksaN57IKAVy35yQBrKwT5dMg_Iz0UHaPN9Wobrw
Message-ID: <CANyhwx0hZJC6xXaSC2g4GFgUOp5n_KN4tdXksW+s8Mk_+7xEAA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] net: qrtr: Assign unique node id for MHI endpoints
To: Juha-Matti Tilli <juha-matti.tilli@iki.fi>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, Bjorn Andersson <andersson@kernel.org>,
        Chris Lew <christopher.lew@oss.qualcomm.com>,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>,
        Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1OSBTYWx0ZWRfX6uSB55MWlhCX
 jELSj6bKk2tLugvZkN3xub9DcWHI0I6VzXGY/Px30M4SBnsK+vN27m/4L6f3xBeAJSyZTQp6Rq8
 7PsDEZsKpsg6ZxC9xhUD4dksMlXEsRfpEuKb7B20EbfAuyUd1Et3SWaxT7j6ILRr9bQuGKe/KON
 UMTHLRrzKR8639+ubjynjXM/YUwwDERZgX/emADt43dHXCeOZmLlztdHiPtw0Cv9tTfQHeqw433
 JfIjp3Ww5rqur31BIxppxDFADu3HLp9G5PDlvOlJEEivcpqzcONHN4qmydlDxuGDLg3RK3NV9R3
 ZPsW60yRoiZArgA8KVS3zlNTqkWELiL5krZyQXGum/zauGeZiyLVUeV+ydS12Mp3lOhF/DKCSWv
 pYO/E4OD/pMH7McIK25CKNwVBti4OAbYBGmYG6iboLVTd3rtHbe/ZLYD3wZdagYLXafsfNtZhS4
 AwtGZrjkbuzxdBZn2BQ==
X-Authority-Analysis: v=2.4 cv=aIxlOr9m c=1 sm=1 tr=0 ts=6ab3ea57 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=astPFzNtX3-rckHXrNEA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: AbQXGVOksuBRZ9Vj9jmgaeF-XA3oDDCF
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1OSBTYWx0ZWRfXwxnIwTqZxza6
 Yl4WU7OvH4dupor7V3HnI2HrN63bjvKUMojS0zKU1S4go5ScS4fzXyyehcBQAHHM/zLl3rzwtXn
 1TAVDD6979Sy3gOnTZWKPk2zZTyKG2w=
X-Proofpoint-ORIG-GUID: AbQXGVOksuBRZ9Vj9jmgaeF-XA3oDDCF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230059

On Tue, Sep 22, 2026 at 6:24=E2=80=AFPM Juha-Matti Tilli
<juha-matti.tilli@iki.fi> wrote:
>
> On Tue, Sep 22, 2026, at 20:14, Youssef Samir wrote:
> > On 9/21/2026 12:23 PM, Manivannan Sadhasivam via B4 Relay wrote:
> > > +
> > > +/* The offset is chosen carefully to not collide with the node ids a=
llocated by
> > > + * the remote nodes. All the remote nodes use node ids in range 0 to=
 0xffff.
> > This assumption does not hold up for QRTR V1 headers where the node ids=
 are 32bit.
> > QAIC devices use BHI_SERIALNUM as the node ID, and it is definitely lar=
ger than
> > 0xFFFF.> + */
>
> Does that mean we have to go back to my endpoint id patchset?  It's an
> option, but a quite complex one.
I'm not sure. Last time I tested the endpoint ID series was its v5 and it w=
as
functionally acceptable, and other than switching to sendmsg(2) instead of
send(2) and sendto(2), it did not require much changing on the user-space
side. But as you mentioned, it was/is complex compared to this one.
>
> However, what is the likelihood that serial number would clash with
> these host node id values? Maybe just adjusting the comment could be
> acceptable.
The chance of collision is slim, but still not impossible.
I think a solution would be to treat qrtr_host_node_id(idx) as the
preferred id, not
the one that will actually be assigned to the node. And before
assigning the nid,
we check it against the radix tree, and if it exists, we try to probe
the next available
id (so an IDA). This will also require exposing the nid to the user in
sysfs (i.e. /sys/bus/mhi/devices/mhix/mhix_IPCR/nid).

Thanks,
Youssef
