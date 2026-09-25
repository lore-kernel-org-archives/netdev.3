Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866743DDDD9
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790343550; cv=pass; b=sQpPJtA6TTfcXGddpGv7PHnAhkrC5UDF/QTvBHNzp+JtWTWUh0wkLzIvhU6M/hMoMgrk8l31RmaHIsmesYRIGSmHMm+v9WLb6ttevtbQFbhiw3ty4Rz1Iwxn/2FQizOBqkDWjALSSO7IaF6bgNNFm6RrgjAUTydbdAby0NJFR+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790343550; c=relaxed/simple;
	bh=kqdNlwg778/987rRPFcemtjB5R0/alDQShoyszIUXi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=phpqgK41DesahSMExYzl2zGFVT1OerWlPvy0oxa/0ivKeR8fqg2sE62J968elZFRERr/U5FZUSLo59PnWKWKcLd3PRFHVN+dwTkw60YcsFX/n8ZDn1cl6om3McfGo8JvnZYp1NqLLw+OFUTDSpW+xG3G6stXhvEyC/oTXi9NIOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CiFirrNM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OjLnN41T; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CiFirrNM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OjLnN41T"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PD4g0i208403
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 13:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kDqgsZ4XGZtl4jjOzkJ5PS9aFgMs5r1UIrTA9EsegCY=; b=CiFirrNMJE46vkez
	ab/ALVoKzVYq3KdM+wurlRbp1B6pozl0+xZlajKqHYhciUozzuBY7HlW4B9bEgeq
	01aTayxTFbLZjXcK2kUyA4C5CGDxayVgrjT12DPiulgqZp8+24MXVbQFUBKalGN5
	p9GwIgBIhMFeCrnL/r+4yFxTmyyyZcUvwHKtmgVueHEfPC1dTHXv2IcCvaA5pY9E
	bXsatblJpbCU9xw3/A1vAwABdtqMVYDxHNRpOtBokCQv+9P5D3KSurkRHYF8jsvl
	7RxWADkv+Ho9B8J+D3C4m7HNizpmI3Gz6NL7dRH63YIWrYea4jFZFF+zLX2j8bQ9
	XChfMQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw898upgy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 13:39:08 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-530e5b709b1so19505871cf.0
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 06:39:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790343548; cv=none;
        d=google.com; s=arc-20260327;
        b=Umgcpl3TpoABy5gVj46N+vPAEYNLw80s/zySiN1T3F9xhgyHDj5qMYxTeWwtxVDRAb
         DzGavW80o/FRwbkxiOv2V1bvWTucXAWp0a3oOELZ/EZ+fkBglc66CP6s3zqSPPKs0F+n
         6WEZHVSUCr9oLBd409RjwrLKTnhh31E1r9sb1du9EcEkUdVKpfz1/+BJjIiutSFEqnIf
         yvgvtLVv5RINhSvMY7Kyq0MN4YneWDgQaXfH3LH+g0Hzb4CEAEQXTaKfsGVJkencgX7G
         38pR9kt15rGkCzmnNCiEIkFfYmcNrJjt8hB8spSFjqKk22LOtTKFbH2QM7mS3DQTAic4
         MYXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kDqgsZ4XGZtl4jjOzkJ5PS9aFgMs5r1UIrTA9EsegCY=;
        fh=cU0/5Hhj3wK6fZ8Co/Z2lWHSFd8fizlIKqn85n/PUlU=;
        b=E3/oE8bKHhVDCRpHsA3Kx7LLYpv9eVVLxqI19ttotDf/oplZXiV5MXLQAHsEJErusq
         1zLPHPzb+jB8PBvQ6CJprNxoUWf3YPZa15vFSPK5IVU3ulEQcBZG/kL30Ene8XfCnlre
         rwUbPjbZVPT/ZHaKeloudyC/mou0czr85fM2l1Euresw2Iz7Ss2iUUAcsZO/FiR739lc
         uC2bzCVLP1uuNRGuAlBw9iRbqtaNtghnmyj8Q5w6Onr50Ou2ImJ1QIXVXPV6/FK0t46c
         guG/Uvz5mdUls3cmikVWyVuFmZADo/VwthS45ghdzTz6/YVREL0GbKvFqhYmbUIjOusi
         MBqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790343548; x=1790948348; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kDqgsZ4XGZtl4jjOzkJ5PS9aFgMs5r1UIrTA9EsegCY=;
        b=OjLnN41TvHXUGa7MBrf9fj+CrpaWlDp6jgP20kUZ79RYwBnqHsD2K/ZHsBfxJr0C6X
         5bLg4kK6XWXCGlWpS4+g8GmhWc5sivFMkZ6UPcPR0PfTiZKGAXGfrZJAn1JrUrO9v3pL
         +o/3NTphHMc1pEr1w9tuiniwaSWa84DJXKLHsZJBOqqauXJKVeciIGSFjrUGEe+xevFE
         0tu5GV/o/wBP/LDnwxL4ckGIva0g4Fy9erhgynszry1UC2kIN6hUmqZne6dnMQMW7GsT
         RLoI9Iw1mSzZIhFcCnl5EDBJRUTgLvqYhyFIIEVyfYO8DPzOfGwQ8Vznq6kgHkRZsrq9
         XTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790343548; x=1790948348;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kDqgsZ4XGZtl4jjOzkJ5PS9aFgMs5r1UIrTA9EsegCY=;
        b=zdsn+EC66dE1LvHtemYI3+Z1ZW1CyDl/BPRIZcMHdumdhMJmKnAhTg/yUVBHhodmnE
         YUxNdh/3QjuVkaW7DCdBdIb0S94S5clsnb1V80FH6RS1owPXIf7WH6WdNPAwJakF4U2q
         znWveOhcdEXBGx/qvrZ4lWGbINO5LTgh24dATTygGY1JcxvHYNf18YoCDh1TYU83IdVx
         JLWOjYpn1InslDLDgq0on6QDEUtqMIRDuxe79qnmZ1DxRmS6RNxhZmvELXiohk4hUAnQ
         NcIaoNACTbiUw4yzM87Gbj52BRXWuhI19HW5nMhDrM82WkLxOyPpefQ9r1OShCcj02Jt
         aYJQ==
X-Forwarded-Encrypted: i=1; AKwUvBz1+5tMKjMbTqim73cxGkc2imczViwCzcRArhWda0/I0X6u3DSTQxKMn1RnlTmS6DBuwIRGlw0=@vger.kernel.org
X-Gm-Message-State: AFuF++klDm5PYNaK8qtuRckWQZOy5hzRrLvw4g001Q0cDra9oNLn52RZ
	MpS4orgmIMk6VYl6XgxfWPxp5+M1+86QYz9xkReENr2E/lyWlxZ26cLtj9mz3j1V71et/7nQltn
	NegLdDGjSql4V98cnQ+9TT8VjzX78hk4kt/mkMfeZ2BwksRQWHZ1aw2r2p7tzUaW/I+D31vH8Gw
	QRpkZ3QaypvTTHUTZr+PW4Hww2w7nDR9hqiQ==
X-Gm-Gg: AYBFou1kj+s2W3JS4sQ1k456EpgQHTTLwMYZfrci0cKUykAMOZy8dL7XQw3mPHKDeTa
	SDha6rZvQGuY2ZAJDWZYasAcyQtp4e1OwPU18j1VcLHb0toaoAX45Rq6ndq/0hd5tR2mqcKHAQ8
	U+GjV7JBfaRw5n78KuJpnVd1QnAs9785m3vEu4cchpf4RWnOU9UdFcevCVA+sE9GJVEJqwvGcrU
	rxxyU3LDGUmvMhR8YhuMwsBHFoQ99a82kgBprn6NCfZ1jNNExRkVo4Xs1gSBoD3Ssx4F3ITJps=
X-Received: by 2002:a05:620a:4588:b0:93b:fbf0:8791 with SMTP id af79cd13be357-93c43bf1ff2mr431888285a.29.1790343547617;
        Fri, 25 Sep 2026 06:39:07 -0700 (PDT)
X-Received: by 2002:a05:620a:4588:b0:93b:fbf0:8791 with SMTP id
 af79cd13be357-93c43bf1ff2mr431882585a.29.1790343547133; Fri, 25 Sep 2026
 06:39:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-block-as-nvmem-v10-0-be598b2a5606@oss.qualcomm.com> <178998281449.889291.7893229102394463283.b4-ty@kernel.org>
In-Reply-To: <178998281449.889291.7893229102394463283.b4-ty@kernel.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 15:38:56 +0200
X-Gm-Features: AclHuK99T0Ubawi22EyQadvbidnQEmVlySi-fMkWCvta4a9Udx0OX1G_I0L1lvQ
Message-ID: <CAFEp6-2P14MdYJGuH6ygRL4ZKtLnJEj=PVMx2p+b9L1RuiX1dg@mail.gmail.com>
Subject: Re: (subset) [PATCH v10 00/10] Support for block device NVMEM providers
To: Jens Axboe <axboe@kernel.dk>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Srinivas Kandagatla <srini@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
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
        Christoph Hellwig <hch@lst.de>,
        Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfXyxYLg5/CdTdx
 N9sl2RUZcBt+71ln243vqjlYTR2efEBn5TsAPk0yff7H0h0eC78iN6J0WDvuqQ78Cm/BmlrDfof
 HN9/UgEfIWgwo1OsggzXcXEJ51rU7441MdLNjZB68RQCGnvNczKMKSmI+bVG6dWHfY0eg6lsEwG
 q40QNRsThq6+KbD70lPbwPzpk7Gw1xJ/B/ffXamUR8mF1vSrdyEatfifIDGhDoqnlvZ5Az5pul5
 s5z+S4OuoOdsv2EQ2cGTIxMfOWXh8A9+1ejbE1fWPYnBrheBuoTixuBuri2JSReBTD+j1s2m7K8
 gcDatILkzppO5RCWWPDVyb36W8a1pSzv0JPzrifX+bVS3mtZz/3J9IwDzvqvwl4XhfriF3/mXum
 klV3jUE35Kd83pjaj/Dggffii1D+DU3y3L5wqo5TVvKl4mpnWrVeYkzpvuvjmeq2RLKwh0Jzuy1
 6xWORjk41xKD5YCZCsg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfX1u5QDUYoxld1
 Y6Fxggn0lhKRXGvJiy/+ZTbL5Hu+KX75nKyyreF5it/GYbBwMFl3rfQKBjvnH8FXWfxi1kLhl/b
 EXAk7XzZzxGc4E8Udre8Q/n52FbTYW4=
X-Proofpoint-GUID: 6hwX-Sm1eBSoo_R5fnscnx8pBd_n22lG
X-Proofpoint-ORIG-GUID: 6hwX-Sm1eBSoo_R5fnscnx8pBd_n22lG
X-Authority-Analysis: v=2.4 cv=EJWTQFZC c=1 sm=1 tr=0 ts=6ab6797c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=MW6_J8xfeE2cRKj6bkYA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250054

Hi Jens, Luiz,

On Mon, Sep 21, 2026 at 11:27=E2=80=AFAM Srinivas Kandagatla <srini@kernel.=
org> wrote:
>
>
> On Thu, 06 Aug 2026 16:38:33 +0200, Loic Poulain wrote:
> > On embedded devices, it is common for factory provisioning to store
> > device-specific information, such as Ethernet or WiFi MAC addresses,
> > in a dedicated area of an eMMC partition. This avoids the need for
> > and additional EEPROM/OTP and leverages the persistence of eMMC.
> >
> > One example is the Arduino UNO-Q, where the WiFi MAC address and the
> > Bluetooth Device address are stored in the eMMC Boot1 partition.
> >
> > [...]
>
> Applied, thanks!
>
> [04/10] nvmem: layouts: Support fixed-layout as the nvmem device node its=
elf
>         commit: 9c6cab93dcd47c3075d896c777567b9d8f813d18

If you're happy with the current state, would you mind picking up the
block-related and Bluetooth-related patches in the respective trees?
They are independent.

Thanks,
Loic
