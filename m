Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794214208;
	b=Bq75tZQvqnwbjfYruuJRtHUc90+xthebAJYRkCEqcNvqGtL51zn1nnsOQLx1Ir/KusIe
	 PMdsWcFd2grSMWHrSsrIUyGe+Th7SWJ+do4hR7I85a/v97ZRik8iEwbpEs2SPIygdmfX0
	 NrBbe7a6XxZW+RcS81f9H/Of+odcclwGNwbNv544H36Jj2lC5SxGDPxTaeA/PBjGrZNlT
	 mRE6YDR39e/aCqBcNfSZexrsiosGRYe52oAq7bRZrCstD3H0tx4hf/LZ8tVV1JD/hl7Ox
	 Mupqc9ess2b0D4/HZB3LqNlaBfbSzoFIGQ/kRPlPT7bBHzeGxJ2fQ3Yg5sTx7O8GnAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214208;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=DeANruJ67tcK1i2NjImgpuPLAyqp2ow3pBUPvp4p0h0=;
	b=FLpNlgnB0KTt/YLgwx4G3cu5kyGpb5/LpVv0vz7+WPMlkv7JzPfhl4wRpGCKoDvdQTNr
	 iBU0BXz2245+RpU/2cevsPxBcamFbCj+OMPvl+1EACaotMVD6trHc08Bm7HdvS4feQavU
	 QGKHcqkv8ijaONJGdbJew1gb64bmTHJEx9k+dLlWvdy/Zr8lql1ak85e1pQPOjyvN1aSx
	 EAIVS4vXQ1N2Ubm1TsEoVF8Q0KxxY9qerSDefL3rsNiWEbCMNt+pzBglF0NhdQwGNu/VM
	 t5AVk5O4qGV8PEya7kymHJY+qQag79rkrenUEO1oQ1FxD6/CLoFcbLiisbKKCHqgkiw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CG9OE5kW;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=doDoc+Nv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EB360A6F5E
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 08:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94EB360A6F5E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CG9OE5kW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=doDoc+Nv
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A96AgA8066512
	for <netdev@vger.kernel.org>; Mon, 9 Nov 2026 08:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DeANruJ67tcK1i2NjImgpuPLAyqp2ow3pBUPvp4p0h0=; b=CG9OE5kW/7MuKcxj
	yZICS46QXDIo/e5a7OKRHgOYpIsLdfjmbb8i6NkMdmptVabkAOfT83fyvsHPEZ0q
	VRThHoqrMQb5zBPh66tqjgC6TPYYYjEqtrVEQHJMxC7aneOCAYqcV0raF7gfwYT+
	XWnmpematdrP3ZzqUtHIGWdGnbXu6lD/qRZD+dNC2HcO59d0HmP7oajU9ztPR94U
	lKzFOlHIbuMFWnaFUPI05UCqCM8C84173+RHpQwJ7k16hDJJ+gQ6Rab2ekzV9CDt
	00cRIdZi3yCqaF+tbzQ2b24mQ/tARKq8rwW8EJronvuik5KBmD5fOAngo/3iy3qz
	kmA+Zw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsujxdk17-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 08:50:06 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-945c60b470dso96575085a.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 00:50:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794214206; cv=none;
        d=google.com; s=arc-20260327;
        b=S4TWzkBNNvIJWwqG+zjlg5OGOmEFt59z1ES1CnNK/tIN+3iO/c6ZCyAUQt3ynTof1b
         Jv17LmpnqD3kpmQHH8I1q8FJjSIMNKzX3xqyvxoF9MaNLxcLrIhBkmpj2rsvbHkoJhvi
         4A0DaK/2Rp2yRXsHYh0cs2YhVek+oNNDnnFx41+CgcdUwalDVXzGL23PvHw8vkdHtUmV
         ndiU+vFbIKLvPcVjJRue69bt9mtp5LCQ3xtGovsWlcrY9jSqg8Tfsu4A1W68+FOgwnm4
         Y4L+JOBF/HtCj65GfhGXrA3jqjJ7AuzdrQbqM4Sf5TtdXp4ObRTmiUUEO900Jy2xV9Iw
         PFcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DeANruJ67tcK1i2NjImgpuPLAyqp2ow3pBUPvp4p0h0=;
        fh=k4CdGbrWNOHNBMXpcdtJEReNUM7Izyj1ODhCiIPgksw=;
        b=TIo1mUlfbMKeQMCBXUPzXBz16mL1AGVwhVCpnB/kUWrypYODRn+taumVpiv6eN2xKG
         R+gPZ7jQn7jp40Np96MOUvCDT2vPCAfKFwo8tkpOJw7K4E336aB65WdyaBbmKD5msNak
         rQMXkwQg8FPGwCV4vFDalzmJQIgLXJom7zNLac19acbpQOzftaa4n/PzTEdo+Mv/+M6a
         wE/6Hvkg8qlDxRlFqBqWsGi+RKIaYVlp1SMk3jzFj/AhzItj7aiFaXSasTgD6+qy5Bb/
         vjF05vUpsujajpWYtkpnnHESJftEf8bdCJjlHARyBAEuf6emWGy0dHHd+oFR+8wDbDOV
         b9SQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794214206; x=1794819006; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DeANruJ67tcK1i2NjImgpuPLAyqp2ow3pBUPvp4p0h0=;
        b=doDoc+NvZ0gwYXx9sHVWbvpMAyXaJsW8y3m6D2XgAkrAi+A+VcNB3W4bOKQI4CLAtV
         MUTPfoJtn9IYddx7JDZO35KvUbned+E+tpeWNJrMMsE+s/fYx3u6erfKjV5qWSLZ8qy2
         8jc1PbQJpb/jIgwtYxM47MuFNldu+3ZqXKSGi1RQM/ZR/pX4k9IRmnGnImacaENp0qcB
         isGH7q5aBviaLv6DNZjlzatdz9ugxETRzoPg+glQvoGMXbW1ff0hBPt/Ti/mc4bWIXD/
         +Ef8eGb54rKps3RSofXoAq1B8lTZ+inCZ6v+j0YQBOk5qqaFHKLpbUGj4H4llikjYveW
         TXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794214206; x=1794819006;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DeANruJ67tcK1i2NjImgpuPLAyqp2ow3pBUPvp4p0h0=;
        b=EsJz07+2+gvyIYJyegHi3iVQbaVuJOEvGcqERLhXNqO1ZvlO9GC1zKWRqrmWjIptd6
         xHue8X29zHfzoOYUCgWbuwdf60L4JOvMv6yuCX6e9xmv7uJeiGxWrbAuumG0HEM2IZso
         nKXy+3TRAqbLBd2R1qwEyEr7/z4V/SJJ4zF2nlkExtn47hi9f/DNeK33MjY1MRPqyHlI
         s97Ep9QcqK9FU71LhsIUi/jtW0s3itFGEk5yHBngJr036acYMBHEhzKQFXt5iaggtnFO
         YBKrh8bbjU4qmciYb4VUJimoMKf65zGuFEvLZ81HAtOUl14x5cwzhnHUH6j7dX93mf7i
         t7eA==
X-Forwarded-Encrypted: i=1; AL+hErHgwB8lyoyhqblTUtzZkY50Wb14zB3AtDToCvYM7J6zfwDCWH5mSrslNG2DPAib20b76QcgfiM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9eJzNfmiu8mviDPspm4Zdx72HiPch9OuotieaJTYDIwDKTTkun
	TC7XGlTdVJYkkwOZ5FXoHGSUlwzsxwTw446+Eu5Pgdh7b4nXyGMU2eUF59YINHsxIf5u68z1eQ2
	B58ZnjF0geMCy+0XP/cQMS9ht5V6nOaMNPkqr0ntpvzsgAOx6dpOir3ywB2kacPRqgaG984ZlQc
	2CAzTNqcEkWW9xjVVmeauza3c7tzqgZDhZ1A==
X-Gm-Gg: AYBFou38HhhzEWJV3uWcOIIgTHU2GIqweMjzS5bKDEoo3SCQ9pION3nwknDzzL+rMYY
	yl7XzmdwEUq928Wm9yQySEViTQmp+vV4FiDPPNrMAlylVg5owQuxZduxdlsxtnUcTAqXOglGn/8
	3g+WYMNwwXpgJTYdPhQHngTYrtdaW3wtqQTrSrISXAGtQgT8POaZ8AYL3DvM4V+EIjoE8KDjUIR
	yjcTcNwBk+UvZjrrCcfvJ1r9EkcZG4e5DJNcjidOCvhqDjP7bgL3yEeq5up0r8qK2SGkPn0wqc=
X-Received: by 2002:a05:620a:1999:b0:93e:c12c:43fe with SMTP id af79cd13be357-9478490d6efmr441774585a.75.1794214205659;
        Mon, 09 Nov 2026 00:50:05 -0800 (PST)
X-Received: by 2002:a05:620a:1999:b0:93e:c12c:43fe with SMTP id
 af79cd13be357-9478490d6efmr441770485a.75.1794214204964; Mon, 09 Nov 2026
 00:50:04 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-qcom-bam-dmux-vmid-ext-v5-0-5c7903385b4b@oss.qualcomm.com>
 <20261105-qcom-bam-dmux-vmid-ext-v5-2-5c7903385b4b@oss.qualcomm.com>
 <CAFEp6-3rt8yvTd-mMA6y5SqmzmF0zvrvO_Dc_w7G3QSv7oZWng@mail.gmail.com>
 <187f3c63-5550-4a42-892e-ea660247edc9@oss.qualcomm.com> <CAFEp6-2nSM6zgyrgxwP=qrE3K7aXk9cSZmhdY2F9N4Zq8SV4Kw@mail.gmail.com>
 <294563dc-1db3-43d0-8173-7941633bc659@oss.qualcomm.com>
In-Reply-To: <294563dc-1db3-43d0-8173-7941633bc659@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 09:49:51 +0100
X-Gm-Features: AclHuK8d7U60JHFX2WPQBgobgNeEmG2I6oVdvjvAApI2hLqbyPzNogR0RSlhgW0
Message-ID: <CAFEp6-2HpEAABdJLEs+yaGyyPmKvqcFPm0v7FbFoW+grw4iYyQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 2/2] net: wwan: qcom_bam_dmux: Assign
 restricted DMA pool to remote processor
To: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Cc: Stephan Gerhold <stephan@gerhold.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Eric Dumazet <edumazet@kernel.org>, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: EmOSxnosQoIXz5sOX1I5RmpNI5WUPXUY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzNSBTYWx0ZWRfX/KKQtGiYrg/D
 FqaIqSvosQC/tRjMmo+ySe/weuFzx/FgZvp3pyd/Lq9f2VN5Z/NvnDdoC1/m+RmTDUoI/CqhsNl
 Kcrd5U22fYfyWmUzJI2oGRHQSlOOlNfRqDU3ZsMJgDZdju6X6kSxq0J4oc9YOQKw2s6s/Rd0Z41
 v3Oyx+qubiEqKvcQXBpvN3MIiZgD+ovlnqZLhB+OE0hu2jaaa3EGpoFekrBjz52dbqTpkCwKAd2
 V8qv4F2psifihlRiZg6YMvNquxnjdJAtztYdxqMkQOAy3oWfz5gr8B7B75PKDUII4Q8uubvgM9/
 NUgb+h4n4jZNFoSwlbP6SLbC7C7re6IE3RRKJrk6ajOiSnxd9pWt3EWLMaVzHej+KzhgTCRqTIo
 PGr0Dyd8wX+L5pJrT6FW66ogtyXe9J71qoEKRm+Cpbd8aWivqDQg/glAYD6xD6b8D08S5hqwOaU
 SvdW3Qn4ywGWBfq6fMg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzNSBTYWx0ZWRfX1QhGptsHJUxw
 +78GB4TWdAuiC1kfQpQVMMhQ0gXcbdB0aRKcXMAFHcRB5w3TFP02E+Qp/K8W172uxGZXGs5wA8C
 l/Shp5DSdqGawcEzuRsdWc0txRtNSXE=
X-Authority-Analysis: v=2.4 cv=TeIDJhQh c=1 sm=1 tr=0 ts=6af1893e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=ra3N8ZK0SJvzCLkdQ28A:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: EmOSxnosQoIXz5sOX1I5RmpNI5WUPXUY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090035

On Mon, Nov 9, 2026 at 9:11=E2=80=AFAM Vishnu Santhosh
<vishnu.santhosh@oss.qualcomm.com> wrote:
>
>
> On 06-11-2026 01:59 pm, Loic Poulain wrote:
> > On Fri, Nov 6, 2026 at 5:36=E2=80=AFAM Vishnu Santhosh
> > <vishnu.santhosh@oss.qualcomm.com> wrote:
> >>
> >> On 05-11-2026 07:51 pm, Loic Poulain wrote:
> >>> On Thu, Nov 5, 2026 at 11:42=E2=80=AFAM Vishnu Santhosh
> >>> <vishnu.santhosh@oss.qualcomm.com> wrote:
> >>>> Some Qualcomm SoCs, such as Shikra, run the modem in a separate secu=
rity
> >>>> domain with restricted access to system memory. BAM-DMUX DMA mapping=
s
> >>>> and BAM descriptor FIFOs must therefore be constrained to a designat=
ed
> >>>> memory region that can be shared with the modem. Accesses outside th=
at
> >>>> region can trigger an XPU violation.
> >>>>
> >>>> When qcom,vmid is present, require a restricted DMA pool and assign =
the
> >>>> entire pool to both the local and remote execution environments befo=
re
> >>>> requesting the DMA channels.
> >>>>
> >>>> This ensures that BAM-DMUX mappings are within the assigned region. =
When
> >>>> the BAM DMA controller references the same pool, its descriptor FIFO=
s
> >>>> are covered by the assignment as well.
> >>>>
> >>>> Track the assigned execution environments explicitly and reclaim the
> >>>> pool for the local environment after DMA channels and mappings are
> >>>> released during remove or probe error cleanup. Skip the reclaim and
> >>>> leave the pool assigned if the remote side still holds its power vot=
e,
> >>>> since it may still access the pool.
> >>>>
> >>>> Fail probing when restricted DMA pool support is unavailable, when t=
he
> >>>> VMID property is malformed, when memory-region is missing, or when t=
he
> >>>> restricted DMA pool is not attached to the device.
> >>>>
> >>>> Co-developed-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
> >>>> Signed-off-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
> >>>> Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
> >>>> ---
> >>>>    drivers/net/wwan/Kconfig         |   1 +
> >>>>    drivers/net/wwan/qcom_bam_dmux.c | 108 ++++++++++++++++++++++++++=
++++++++++++-
> >>>>    2 files changed, 107 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/net/wwan/Kconfig b/drivers/net/wwan/Kconfig
> >>>> index 958dbc7347fa84ee869439bf8b503037faab8bef..1b133c56231615269698=
140187ca3141dfe48dbf 100644
> >>>> --- a/drivers/net/wwan/Kconfig
> >>>> +++ b/drivers/net/wwan/Kconfig
> >>>> @@ -65,6 +65,7 @@ config MHI_WWAN_MBIM
> >>>>    config QCOM_BAM_DMUX
> >>>>           tristate "Qualcomm BAM-DMUX WWAN network driver"
> >>>>           depends on (DMA_ENGINE && PM && QCOM_SMEM_STATE) || COMPIL=
E_TEST
> >>>> +       select QCOM_SCM
> >>>>           help
> >>>>             The BAM Data Multiplexer provides access to the network =
data channels
> >>>>             of modems integrated into many older Qualcomm SoCs, e.g.=
 Qualcomm
> >>>> diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qco=
m_bam_dmux.c
> >>>> index cc6ace8d64371eb8d00c638a39b234ee540b83c9..0e7ad62f8b4e059264e8=
9837f296ee13c0c31c9b 100644
> >>>> --- a/drivers/net/wwan/qcom_bam_dmux.c
> >>>> +++ b/drivers/net/wwan/qcom_bam_dmux.c
> >>>> @@ -9,14 +9,17 @@
> >>>>    #include <linux/completion.h>
> >>>>    #include <linux/dma-mapping.h>
> >>>>    #include <linux/dmaengine.h>
> >>>> +#include <linux/firmware/qcom/qcom_scm.h>
> >>>>    #include <linux/if_arp.h>
> >>>>    #include <linux/interrupt.h>
> >>>>    #include <linux/module.h>
> >>>>    #include <linux/netdevice.h>
> >>>> +#include <linux/of_reserved_mem.h>
> >>>>    #include <linux/platform_device.h>
> >>>>    #include <linux/pm_runtime.h>
> >>>>    #include <linux/soc/qcom/smem_state.h>
> >>>>    #include <linux/spinlock.h>
> >>>> +#include <linux/swiotlb.h>
> >>>>    #include <linux/wait.h>
> >>>>    #include <linux/workqueue.h>
> >>>>    #include <net/pkt_sched.h>
> >>>> @@ -75,6 +78,9 @@ struct bam_dmux {
> >>>>           struct completion pc_ack_completion;
> >>>>
> >>>>           struct dma_chan *rx, *tx;
> >>>> +       phys_addr_t dma_pool_base;
> >>>> +       size_t dma_pool_size;
> >>>> +       u64 dma_pool_perms;
> >>>>           struct bam_dmux_skb_dma rx_skbs[BAM_DMUX_NUM_SKB];
> >>>>           struct bam_dmux_skb_dma tx_skbs[BAM_DMUX_NUM_SKB];
> >>>>           spinlock_t tx_lock; /* Protect tx_skbs, tx_next_skb */
> >>>> @@ -762,6 +768,90 @@ static int __maybe_unused bam_dmux_runtime_resu=
me(struct device *dev)
> >>>>           return 0;
> >>>>    }
> >>>>
> >>>> +static int bam_dmux_assign_dma_pool(struct bam_dmux *dmux)
> >>>> +{
> >>>> +       struct device *dev =3D dmux->dev;
> >>>> +       struct device_node *rmem_np;
> >>>> +       struct reserved_mem *rmem;
> >>>> +       struct qcom_scm_vmperm dst[2];
> >>>> +       u64 src =3D BIT_ULL(QCOM_SCM_VMID_HLOS);
> >>>> +       u32 vmid;
> >>>> +       int ret;
> >>>> +
> >>>> +       if (!of_property_present(dev->of_node, "qcom,vmid"))
> >>>> +               return 0;
> >>>> +
> >>>> +       ret =3D of_property_read_u32(dev->of_node, "qcom,vmid", &vmi=
d);
> >>>> +       if (ret)
> >>>> +               return dev_err_probe(dev, ret, "Failed to read qcom,=
vmid\n");
> >>>> +       if (vmid =3D=3D QCOM_SCM_VMID_HLOS || vmid >=3D BITS_PER_TYP=
E(u64))
> >>>> +               return dev_err_probe(dev, -EINVAL, "Invalid qcom,vmi=
d %u\n", vmid);
> >>>> +
> >>>> +       if (!IS_ENABLED(CONFIG_DMA_RESTRICTED_POOL))
> >>>> +               return dev_err_probe(dev, -EOPNOTSUPP,
> >>>> +                                    "qcom,vmid requires DMA_RESTRIC=
TED_POOL\n");
> >>>> +
> >>>> +       rmem_np =3D of_parse_phandle(dev->of_node, "memory-region", =
0);
> >>>> +       if (!rmem_np)
> >>>> +               return dev_err_probe(dev, -EINVAL,
> >>>> +                                            "qcom,vmid requires mem=
ory-region\n");
> >>>> +
> >>>> +       rmem =3D of_reserved_mem_lookup(rmem_np);
> >>>> +       of_node_put(rmem_np);
> >>>> +       if (!rmem)
> >>>> +               return dev_err_probe(dev, -EINVAL,
> >>>> +                                            "Failed to look up rest=
ricted DMA pool\n");
> >>>> +
> >>>> +       if (!is_swiotlb_for_alloc(dev))
> >>>> +               return dev_err_probe(dev, -EINVAL,
> >>>> +                                    "Restricted DMA pool not attach=
ed\n");
> >>>> +
> >>>> +       if (!qcom_scm_is_available())
> >>>> +               return -EPROBE_DEFER;
> >>>> +
> >>>> +       dst[0].vmid =3D QCOM_SCM_VMID_HLOS;
> >>>> +       dst[0].perm =3D QCOM_SCM_PERM_RW;
> >>>> +       dst[1].vmid =3D vmid;
> >>>> +       dst[1].perm =3D QCOM_SCM_PERM_RW;
> >>>> +
> >>>> +       ret =3D qcom_scm_assign_mem(rmem->base, rmem->size, &src, ds=
t,
> >>>> +                                 ARRAY_SIZE(dst));
> >>>> +       if (ret)
> >>>> +               return dev_err_probe(dev, ret,
> >>>> +                                    "SCM assign restricted DMA pool=
 failed\n");
> >>>> +
> >>>> +       dmux->dma_pool_base =3D rmem->base;
> >>>> +       dmux->dma_pool_size =3D rmem->size;
> >>>> +       /* Track the destination VMIDs explicitly for the reclaim op=
eration. */
> >>>> +       dmux->dma_pool_perms =3D BIT_ULL(QCOM_SCM_VMID_HLOS) | BIT_U=
LL(vmid);
> >>>> +
> >>>> +       return 0;
> >>>> +}
> >>>> +
> >>>> +static void bam_dmux_reclaim_dma_pool(struct bam_dmux *dmux)
> >>>> +{
> >>>> +       struct qcom_scm_vmperm hlos =3D {
> >>>> +               .vmid =3D QCOM_SCM_VMID_HLOS,
> >>>> +               .perm =3D QCOM_SCM_PERM_RW,
> >>>> +       };
> >>>> +       u64 src =3D dmux->dma_pool_perms;
> >>>> +       int ret;
> >>>> +
> >>>> +       if (!dmux->dma_pool_perms)
> >>>> +               return;
> >>>> +
> >>>> +       ret =3D qcom_scm_assign_mem(dmux->dma_pool_base, dmux->dma_p=
ool_size, &src,
> >>>> +                                 &hlos, 1);
> >>>> +       if (ret) {
> >>>> +               dev_err(dmux->dev, "SCM reclaim restricted DMA pool =
failed: %d\n", ret);
> >>>> +               return;
> >>>> +       }
> >>>> +
> >>>> +       dmux->dma_pool_perms =3D 0;
> >>>> +}
> >>>> +
> >>>> +static void bam_dmux_remove(struct platform_device *pdev);
> >>>> +
> >>>>    static int bam_dmux_probe(struct platform_device *pdev)
> >>>>    {
> >>>>           struct device *dev =3D &pdev->dev;
> >>>> @@ -796,6 +886,10 @@ static int bam_dmux_probe(struct platform_devic=
e *pdev)
> >>>>                                        "Failed to get pc-ack state\n=
");
> >>>>           dmux->pc_ack_mask =3D BIT(bit);
> >>>>
> >>>> +       ret =3D bam_dmux_assign_dma_pool(dmux);
> >>>> +       if (ret)
> >>>> +               return ret;
> >>>> +
> >>>>           init_waitqueue_head(&dmux->pc_wait);
> >>>>           init_completion(&dmux->pc_ack_completion);
> >>>>           complete_all(&dmux->pc_ack_completion);
> >>>> @@ -829,8 +923,11 @@ static int bam_dmux_probe(struct platform_devic=
e *pdev)
> >>>>
> >>>>           ret =3D irq_get_irqchip_state(dmux->pc_irq, IRQCHIP_STATE_=
LINE_LEVEL,
> >>>>                                       &dmux->pc_state);
> >>>> -       if (ret)
> >>>> -               goto err_disable_pm;
> >>>> +       if (ret) {
> >>>> +               /* The PC IRQ may already have powered up the RX pat=
h */
> >>>> +               bam_dmux_remove(pdev);
> >>> it's still unclear in the comment and commit message why we can't go
> >>> with err_disable_pm?
> >> Agreed. I plan to update the comment in the next revision to:
> >>
> >> /*
> >>    * The PC IRQ is already enabled and may have powered up the RX
> >>    * path. Use the full remove() teardown so that RX DMA is stopped
> >>    * before the pool is reclaimed.
> >>    */
> >>
> >> and add to the commit message:
> >>
> >> If probe fails after the PC IRQ has been requested, clean up through
> >> bam_dmux_remove(), since the IRQ may already have powered up the RX
> >> path, which must be torn down before the pool is reclaimed.
> >>
> >> Does this look fine to you?
> > That looks good, yes. Also, could this be avoided by requesting the
> > IRQ with IRQF_NO_AUTOEN and only enabling it at the end of the probe
> > sequence?
>
> Yes, that is simpler. The PC IRQ then cannot run before probe enables
> it, so an irq_get_irqchip_state() failure can use err_disable_pm and
> the remove() call and its forward declaration go away.
>
> For v6:
>
> ret =3D devm_request_threaded_irq(dev, dmux->pc_irq, NULL,
>             bam_dmux_pc_irq,
>             IRQF_ONESHOT | IRQF_NO_AUTOEN,
>             NULL, dmux);
>
> if (ret)
>      goto err_disable_pm;
>
> [...]
>
> enable_irq(dmux->pc_irq);
>
> return 0;
>
> Does this look fine?

Yes.

Regards,
Loic

>
>
> Thanks,
> Vishnu
>
> >>>> +               return ret;
> >>>> +       }
> >>>>
> >>>>           /* Check if remote finished initialization before us */
> >>>>           if (dmux->pc_state) {
> >>>> @@ -845,6 +942,7 @@ static int bam_dmux_probe(struct platform_device=
 *pdev)
> >>>>    err_disable_pm:
> >>>>           pm_runtime_disable(dev);
> >>>>           pm_runtime_dont_use_autosuspend(dev);
> >>>> +       bam_dmux_reclaim_dma_pool(dmux);
> >>>>           return ret;
> >>>>    }
> >>>>
> >>>> @@ -879,6 +977,12 @@ static void bam_dmux_remove(struct platform_dev=
ice *pdev)
> >>>>           disable_irq(dmux->pc_irq);
> >>>>           bam_dmux_power_off(dmux);
> >>>>           bam_dmux_free_skbs(dmux->tx_skbs, DMA_TO_DEVICE);
> >>>> +
> >>>> +       /* The remote side may still access the pool if it holds its=
 power vote */
> >>>> +       if (!dmux->pc_state)
> >>>> +               bam_dmux_reclaim_dma_pool(dmux);
> >>>> +       else if (dmux->dma_pool_perms)
> >>>> +               dev_warn(dev, "Leaving restricted DMA pool assigned =
to remote\n");
> >>>>    }
> >>>>
> >>>>    static const struct dev_pm_ops bam_dmux_pm_ops =3D {
> >>>>
> >>>> --
> >>>> 2.34.1
> >>>>
