Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC17034E766
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784907347; cv=pass; b=rOJazUgpnxiAK1mdxrGfcQsbbsGQMp8ora9onPUauRb2TV64UEo6K3ALyVf+aXeCBnJotA9ZKuNzj4ky08DDZsryJdpb7KqXSIP3nuG2ysabsksBzqsafgVfTwoH/yDfNIURhq2ZJORMCwJJ388bB6tdVHNu8vzqwUx9sugufJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784907347; c=relaxed/simple;
	bh=0AxRvCjS4SeGauYtGrq3Gxj0CFvSuzE9MU+SB8VxZqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RWSPFlIUZ5DKkFsvjEmeUr78E7PiAWuxb328gZe11qtYg/8KSeo8uE1cDopbkhFHL8rXN4NZu0JUVsjE3Imv6Z/pQTpAwMgNF7jDBqBGXGGEGqUmCPzxYJ9XMcoNPBcJoUnaVmXndHHi0mJvT5No8slvCql1wIzN/8IHVEBlK9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U0UZBLpm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SVitZbLB; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U0UZBLpm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SVitZbLB"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODbJ0t3178258
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 15:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0AxRvCjS4SeGauYtGrq3Gxj0CFvSuzE9MU+SB8VxZqM=; b=U0UZBLpmLfPDvk4s
	5VVXy1GRsf9VjasKo9AZa15zarTyGa1QjJqnsNNIcbBeIhq1YHNQb+NLdvyNnDBN
	7R2Qp6iSbQ65AuK6J6JrFFQ1KCQdPr2+h/xLiVb0Y/MG478NDq04DnEdkLa8RE0C
	q+9xAuEvlxgPwplct6yAF7BlP/BSC51W0qX4xC1wqPCC2kNiVj4k938GrWe9if+u
	71b3BDT2ouTx0lPbmDcd2jAvWSKlChEuLO3YlNrfAItJPh+7d33op3mu57wYkF5k
	m5xvoz86F6mTz6U79nCSLiaxF3eZb68e4/ZCxZPnHU/bjNLEQ39PFmoJr1mgXWyD
	Gn0Tzg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm5yah6xx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 15:35:44 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51ebdfceddcso9078551cf.3
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 08:35:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784907344; cv=none;
        d=google.com; s=arc-20260327;
        b=fvjxeCRxyMJpZPkOCMMn5Vx4i+QnXVdjZnpiGORBYcs04A0a8muryz6YESA9hCrzL0
         TJbLc+FJyr1LIUbKOZw6n23TCh6+nuDQfujG3936irWItroCyfBZ68BZTioq7vaopfvh
         HjaVpUvPnvHSwnaYhPfmmr+B0m9fh5NBYdbtkTDQsZQPis/yOId0PyohePfsqRZ+v+YJ
         2jWamGm1lWXe459Kja3D+ZzwfXQC4vLeTtdYw/kDmavjKnV8X58eGbU2xE5tJsG7EXsc
         K09RzEijifKb1BOo8c50aaWtOjBZBW2LR314alblNbQPTx4mo8JhqevL8kxmzTDukbCF
         GfXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0AxRvCjS4SeGauYtGrq3Gxj0CFvSuzE9MU+SB8VxZqM=;
        fh=Uvx0+FcXnpPTzTIa++Vn4sK0sawGZMrJVDOc24lacD4=;
        b=EEwsTWK571lzOr2ruATjGYFX52K5/RYg0p+aK5bPPh3jDzonq8+LTpj9XIF1t+dQK+
         sXxDKtlWmoaDgiR62LXXFQ91vdEtpJboijO8fXCXdrC/lAbr3rPjs7kKVADOLfRaMYjp
         nbV8CrxWnSZMcirF0Gvd3ihIyUfQbwDKF1FiLYstwr5qkSZ2BrX/vW76qlb71oPH0Jfq
         N1XHe64GD4PUPqyN89Jq10mwa95ZmaiaMOlw4uWF8ESXnZGdw18ArS5Xdo3ZRTfHfOKk
         FBh1K4/Fb88OXlEO3T/EBgKkfc7ECv4glRXfMI1wogcHPPwHy+d6oaJLh989r0ucxU/j
         qCfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784907344; x=1785512144; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0AxRvCjS4SeGauYtGrq3Gxj0CFvSuzE9MU+SB8VxZqM=;
        b=SVitZbLBEQeqhXDYttKqcffl1bS8srPij46robugKSWL9bw3tuZrUUnPKAYt5pApKd
         tCBNmFfDUHtXQJAl73/hW25Eyn+edSA6L2iRFurPwLFpHJOpMd2oDiUtU1bfM8eyesCX
         GuOQOamdO7slnkWhiK5z2X2slT4JH7LANGzFtPnonmH2oQCU0tBOkw2W9pmfXYjMJDR3
         A4CSzAWZ2mfMacNxnuGzXYmaydr2aDKe2avf9dm+T6HvPdDZ95Wph9wfSJOiP0ZEAjvD
         vpeyuD9ls10BdyB63miOd4BGoIyQbGSe6it3/AVvHhHoFFdTyL7FhzRYem1esx6oS/jN
         vscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784907344; x=1785512144;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0AxRvCjS4SeGauYtGrq3Gxj0CFvSuzE9MU+SB8VxZqM=;
        b=muj17Ltc0BUaokeTBWWO4UjIFRGXsai7dAERMk/lX5KF3C/aliT1ogxCYuZX1GZwkT
         FuSVJ5NkjwL7c37w0Jdtu2eF2q8HzRN0y1nL95BxvcjfnagMELs4lEPRucUFHN1cgHGh
         hz++PZxSfKYRvErKFjKW3CvNCRzedLG5+JLiHTXR1HWn77W8wRw3o8M6BmBhdhqeCV33
         2AK18k35dUPQuoGjwwV6PFPLWoLU7qULMkhbbt2zrYhd9dPjJmP29EFPtg5kx9Byq4rn
         rsOhhut4yyDWyi5TigJ2qmMs/CLIbt8nyBvnuzB7sEL6EWPR4lDtLLtZswjDuxOwYH3w
         8Aog==
X-Forwarded-Encrypted: i=1; AHgh+RpKT8Y76r8saHcfeCIZb3fQwbaBtgeoEt2vbIrJIpkLToN5A74XadxLol2VFGCUJK4vLeZUe+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/DWfxr5t0nXOEVPiVi2QCEhjceoqm5h7ozlQeUSij5Q4ldCrX
	xfsfvhkUlZSsVFwoMyjvleioaEa4Rz5arJ6wU1OTxcMeKYTu+3AqZ5VGrbe8wcZrPUVFRUedyHB
	uYgzh4sByV+1NqeTSShvFIn/zl92kOe/+AOLxCG6VQkT3jwdBoO4o4Dm0dZYOY3+HOBxSqesSCv
	tgKdfzbWz1icsgw4//Q56bBkj8CyqP2PU//w==
X-Gm-Gg: AR+sD134XkvOmbV/YL4maiaXpcvI4jQjFEN6LN2mIsoJ1ZZ7zvZ1m5r8qoJifDCZSsn
	9eaHJYVMKe0xTpwgVjFDh7snnWnWA1bFwSZH8SawHphDATEQ8q+ah5fTz4yvuxl57GRRAI3HpIo
	z7dlViuUnNjGBNDtWMk568q2y2Eu9R9Xh6tqGHLItwUOpAKydAIMYBbMIrzA==
X-Received: by 2002:a05:622a:228a:b0:51c:1241:3b09 with SMTP id d75a77b69052e-5283de54e1fmr76891551cf.39.1784907343614;
        Fri, 24 Jul 2026 08:35:43 -0700 (PDT)
X-Received: by 2002:a05:622a:228a:b0:51c:1241:3b09 with SMTP id
 d75a77b69052e-5283de54e1fmr76890551cf.39.1784907342860; Fri, 24 Jul 2026
 08:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com> <3d954cdd-6dde-4be6-84c9-2f2f7d008f5b@kernel.org>
In-Reply-To: <3d954cdd-6dde-4be6-84c9-2f2f7d008f5b@kernel.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 17:35:31 +0200
X-Gm-Features: AUfX_mwd1WNIZvdvXqoWeMIN9Hp4kEAy8VC-hn59NszviBxEKOIP4_juVgFnXVE
Message-ID: <CAPx+jO8-9YSJtXNfnTrUX_JiCyddXHn=wHek9=c99+fNp22Zog@mail.gmail.com>
Subject: Re: [PATCH v8 0/9] Support for block device NVMEM providers
To: Srinivas Kandagatla <srini@kernel.org>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzOSBTYWx0ZWRfXxWRBL3wHKRLJ
 pkJWTUzd/zbWW85HFs8B2a3tmTVscTviGdzcyrHtvIJhXgK45omYxvu/wX7qzT+0sshS3ab4aD6
 08oqEwSUerkLjq3Tp1YDi3npfjGO5mw=
X-Authority-Analysis: v=2.4 cv=Rtz16imK c=1 sm=1 tr=0 ts=6a638650 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=VT4XjZGOAAAA:8 a=EUspDBNiAAAA:8
 a=XoVDlNqzt-XzKL8N3f0A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-GUID: RwNAezRDPOI1orrovMKsBn0laTAk4xVG
X-Proofpoint-ORIG-GUID: RwNAezRDPOI1orrovMKsBn0laTAk4xVG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzOSBTYWx0ZWRfX26nyfuOOdb7v
 azf7MTw855Yir2aVtIQlSgApejSiXyjZjnwE+rZWhxNA1qW9eRgcVDN5L++XgSDP9W1cTX3fJfW
 Gt6+sFaq7J3Box9pKqACzPQqHmBLZGvnwLI5kR6JOU1V0peQO2PZTn56LpLWBbzbpmtNA9j1OuP
 vi/uRJUvGpgT7IozgWW7zAfJn9cm5zgSG5lPEBdX79INqzIjLb+l9jO7aPJADz5cdlccaW3Ze90
 H7WhMe4leA905zdpWTkM51sLHsKlgZjvpsRU8JwZPdU0kfCF8+30YMj5+cyHrYwMrEKiBYU2LQL
 PszMfKufZROrIUu60/p8oqB7aacfOcHvDr83XMOjBjG/CgB+FAgycijgNqb6OAfk52RwGkkD7X5
 f0fNrXsRqBNIfKlQLUJK0dEL8XMIzVV/X9dkGqhmKft6t2giRh8JEr6Y9XON+TW770Oo85dnlto
 CMkcRwKRq8LRlXrjZNA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240139

On Wed, Jul 22, 2026 at 3:56=E2=80=AFPM Srinivas Kandagatla <srini@kernel.o=
rg> wrote:
>
>
>
> On 7/3/26 2:45 PM, Loic Poulain wrote:
> > On embedded devices, it is common for factory provisioning to store
> > device-specific information, such as Ethernet or WiFi MAC addresses,
> > in a dedicated area of an eMMC partition. This avoids the need for
> > and additional EEPROM/OTP and leverages the persistence of eMMC.
> >
> > One example is the Arduino UNO-Q, where the WiFi MAC address and the
> > Bluetooth Device address are stored in the eMMC Boot1 partition.
> >
> > Until now, accessing this information required a custom bootloader
> > to read the data and inject it into the Device Tree before handing
> > control over to the kernel. This approach is fragile and leads to
> > device-specific workarounds.
> >
> > Rather than adding a new NVMEM provider specifically to the eMMC
> > subsystem, the new support operates at the block layer, allowing any
> > block device to behave like other non-volatile memories such as EEPROM
> > or OTP.
> >
> > This series builds on earlier work by Daniel Golle that enables block
> > devices to act as NVMEM providers:
> > https://lore.kernel.org/all/6061aa4201030b9bb2f8d03ef32a564fdb786ed1.17=
09667858.git.daniel@makrotopia.org/
> >
> > It also introduces an NVMEM layout description for the Arduino UNO-Q,
> > allowing device-specific data stored in the eMMC Boot1 partition to
> > be accessed in a standard way.
> >
> > WiFi and Ethernet already support retrieving MAC addresses from NVMEM.
> > Bluetooth requires similar support, which is also addressed.
> >
> > Note that this is currently limited to MMC-backed block devices, as
> > only the MMC core associates a firmware node with the block device
> > (add_disk_fwnode). This can be easily extended in the future to
> > support additional block drivers.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>
> What is the merge strategy here, Am happy to take it via nvmem tree if
> all the non nvmem patches are acked or reviewed-by.

I am planning to pick up patch1 (dt), but waiting until all the
complete series is ready to go.

[...]

Kind regards
Uffe
