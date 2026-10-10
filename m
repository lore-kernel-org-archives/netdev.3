Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDB53AFCF7
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 03:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791602468; cv=pass; b=Nomy37DhOwFFB8kcGUA5kP4AUgRQeY0WvTygOKFgtD1rHkdq/wCZN1zRzrYV7jk6sWyELxi0a9V/TW8pFntVWdO+KdwREdl/AGWe3M2MW33ARZBU7Tw0BFSvjsKlg9ybfzvdkT6ggOXSSBqmXJWamSbmiW7lbdUnPjZoDWT/AIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791602468; c=relaxed/simple;
	bh=cdvvrG7WPkbcrZGPB7ALjUAe17n+SbUghC1wB+UaIFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0x6CmaLtjb9WEYs4l7/VpWJS3jvW1epUFXAgs/53kz7sS/moqJE9n7dt1HgLTVSbR2/N78rdltdOJnsKasptVdA9VSxLpFxq6qiORJmHHgd+RpjexAnmd8zevpPq6t6IeQXLqqc6Ar+BeOOYBKSda66J5oxdy6npag3tDcfFfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W2DttC4+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jyt73DkL; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W2DttC4+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jyt73DkL"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69A2eQsN3597978
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 03:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kVFIzf6qKFdgBMbvBDNXwTubrxO8VTgmNkIEL5po9tQ=; b=W2DttC4+Bg/B+3ws
	bSXUDzF6IG5mn9xU5D6JiM7lZw3pUWzTMJL1e/ExEgPQoXH5O8xy5Z/6MAlhQY77
	VlOQUJG4NT2GfODiAHiTZZxrNjPI6WXgLhWaO2lUsjaQcYlTSKIY6xKybzBWjfTy
	HgWWh+E9E6YxKxW0WvBoapNv5ZeI7VSwPQ31kjh1faetbS7ZBhqjyvYPVzf7YDBC
	ogYA36T8Bm5eLxDYCSSw44cMmzsFpwWxc0Slc48GXkscp/JK/Y/wFsVDDXxl2FCp
	+VHbzZQ2lbLTaxlT6N/y19/pPAukUr08miotAn8OGlJgQzu5I0zu5XFR+JFHyi99
	M/eBxg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t89khg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 03:21:06 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc11b5dd54dso630052a12.3
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 20:21:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791602464; cv=none;
        d=google.com; s=arc-20260327;
        b=Hp7XKJ6JsVvLpyW4Wi7F6pLgT2z76dtBQE3Aa1B/+pbxFixEMHjhQ2TjXcUEmlQ92h
         0rUvL/4ZGkCRiD693AaLbnG/9eH4VeAFxMpxJoZe5U+CRyDPtpr3Q3I0CwPYTtq7ARmV
         gtCfCNytVH5XZj/PNL0x0uWZi8yEozX0gEKQComSJoh8gIwcXAcyaimcaOxiXyh3sayn
         439EJYIFS8mZzz9yXIytMsbJ5TJM0igQXtOIVWUYNlZxhrGajKcI/bQ/08SFl5DoK3Em
         w+i5s4SfWmRfUvf+dG7SE8+wFLPeUlIEHzuILX62TvsUhQZOVLv+zUY/ecdUrWVpiK92
         FO5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kVFIzf6qKFdgBMbvBDNXwTubrxO8VTgmNkIEL5po9tQ=;
        fh=PCWTFhCw+HWBKtBNVYibevWLyHUF8o0lW4MaAg2xHuw=;
        b=VpE70zYt9F3cbvwRxe0WVL6S74HDD0AGO5Hs4OIR/kxPYt3PGMNI97GjepTINhDqFc
         61MpIi6UeHWcR2/+npiJIoDbkL2e6+keIf62YHoxfKYE+9z2EBEOHcshuNUs3KWXJUlb
         NNH7AnMkqWX3ZD3Iyu2Y/nBjQBjl1WLTdgWWTTzxnpiXipyP2dvWtVJC+asFK/35LbNp
         Wx1WCRDhpmpwAjj0HuR8MvgVR2wP8JoxTqLjYU5XtIOaxMFSSRygjCTmgCsskVtMrPDq
         lF3NI269TCjTy4LI5BsOcVk2KxE/Qiro9Rj92sHkH8nYx2rU9O85DKsKIRWpzbPc+jun
         hLUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791602464; x=1792207264; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kVFIzf6qKFdgBMbvBDNXwTubrxO8VTgmNkIEL5po9tQ=;
        b=Jyt73DkLTatuTsVIVLD2LQQFfe3oBS+Tz8jj3DZvXt1Oc+MP+YXKcgZqwZrdPbv/91
         8MWfMDlGdI7YGi7+F9+UNX6TU+O41E0GbO2U2t4k0UdsZxts5m+UD/Gbv1dsJKhzpKmM
         boUnqHlYmdhxPeZ572I/NPC0F2l6whiw4TXFa4paOqxowSHqDXlnegurkVteFhZxL7qR
         rm9ida8lIK/7nq/m0eZqR7FipQzIQg8c41RYlGUp14VILh500hULPS9II4yTwca4o22H
         BDSKiLOlYTj/jUZVC9O66wcb9UR2TYZd20V9GIQUKNGGTnDVw6oemhRFl917bHA0q3pH
         a76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791602464; x=1792207264;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kVFIzf6qKFdgBMbvBDNXwTubrxO8VTgmNkIEL5po9tQ=;
        b=o5oZo2i5ke3RluXBm7CjMLp4HxTUse0a2TQ1wtImIvSOjDXGYnthJEytmFEu3LWQj0
         K1+k1YztqOjlvC0AACIv7MgyHw9TDJd3w05R92lS0pxcNRNO4cXmlsORJioT9bQQpadm
         zpx+4lXg28IvQHpqQ9PbjF1xPEBNcdp59M3/Wg2u4oV/8BIMyvaPuCQo/HapPpW0uFgj
         oYgEG5FLJv7vvw9Q1FBSxcMnASEYVYAsmRd+DOVIMJZ+wLomXscEQN9/8ZQGw2sBorHs
         Am/DQ20u7e5amH34NpQQENK8/8A6fLL0mPUqw8JZv3v0vc1lN4tg7WHJsC1mTBKSjDcn
         KDiw==
X-Forwarded-Encrypted: i=1; AKwUvByLbAxdYZxk7iiiJcSv3MY/sGnTi95TxObFEpXFbPMoDhbXoe9ToVBxAwiZcUEFTYj0krDqlYM=@vger.kernel.org
X-Gm-Message-State: AFq9FYL5ZrTl/VJ8AZiZYTHOzk991dshY9mH48oEE2vmguKH9SscAmqH
	rE4/Q2Ne9j4V2mDrBUNOaQynoRsv1fHnRtBkmicdb38SMJKMg/t0p+QktO6G9cD3jOmHC/mYHp+
	kamGjBMq/aB6JRhJeNoIpAWeIGRtQRXIMEcKf0+QBgsTDY3tqA0TV4EJjYRySJD43Vi5Z10gKxB
	lpPgX3p5ZyOvTtZ3gRk+B1NnIgEJDT8A7AsA==
X-Gm-Gg: AYBFou3cCbPVojqXySaGHCYFMzCswv7w4Ds5qqj0mLi8vT3UlrMckctIC0kDvXXvQQD
	qpU0rnrVh8vvbvcJ9Y7L3+E+K8UC13LlWKMMhJTvFiWq3vT70yukga24t/iRZp6m39E7urzppCk
	fyS42Q3IS0r9hO515b11jY60JIv/IZkFJ9c0YTG8SwjJ7oAN2USZ53/PziUQ==
X-Received: by 2002:a17:90b:4d86:b0:3a8:6571:b43f with SMTP id 98e67ed59e1d1-3ab3a9f7f28mr3326746a91.29.1791602464020;
        Fri, 09 Oct 2026 20:21:04 -0700 (PDT)
X-Received: by 2002:a17:90b:4d86:b0:3a8:6571:b43f with SMTP id
 98e67ed59e1d1-3ab3a9f7f28mr3326738a91.29.1791602463627; Fri, 09 Oct 2026
 20:21:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923-qcom_xpcs_nord_emac-v1-0-4b1c682af70f@oss.qualcomm.com>
 <20260923084921.3942100-1-zhangfei.gao@oss.qualcomm.com> <asmbVX7U4cgm7XNB@QCOM-aGQu4IUr3Y>
In-Reply-To: <asmbVX7U4cgm7XNB@QCOM-aGQu4IUr3Y>
From: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
Date: Sat, 10 Oct 2026 11:20:52 +0800
X-Gm-Features: AclHuK8rsVvfZj_k56Q5QKzcsjlIbLPicr-jBYfM5wSUQDytqGrRVpofZv9SSgg
Message-ID: <CAFkd8huTuFii5PPYrZ85LKkoECbb8JD7eX=jWC+G4ac6QOBr6w@mail.gmail.com>
Subject: Re: [PATCH 0/3] Nord ethernet followup
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: bartosz.golaszewski@oss.qualcomm.com, mohd.anwar@oss.qualcomm.com,
        maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEwMDAxMiBTYWx0ZWRfX3WUplI/pd+Ye
 EpzNn2DdLhy1VP4l55+SlsnVKyRTjKbaqgLqg/rE7CG21lJ/R69g5R8ShIFpMqaaEqCiJNFqQGc
 nuVkeDVfe3aK9aAOkD5dYLkKQJqvlvs=
X-Proofpoint-ORIG-GUID: 66H8MZBFstCwL12r3OVDK7-MdmAhMlVv
X-Authority-Analysis: v=2.4 cv=D9jSufRj c=1 sm=1 tr=0 ts=6ac9af22 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=YagQt7tFpqKSyC3IlFAA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: 66H8MZBFstCwL12r3OVDK7-MdmAhMlVv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEwMDAxMiBTYWx0ZWRfX+W3u7af1ueWu
 o3In9WSDQjogPeMqtqAlMn5aQTVuxlNC+KoN2Kpopb895VlBmxQ2uG3KUmDCQqON3665LQN3VzE
 cHcxY+bkkRCzxqpUIVuKLSvHk15SFglin06xMFZcgObETLXnO3ROvIVzoamYkE9o3HmTgDphevN
 QKIOw2m2ue4Vd3/IzgQtIHy71R7KRxNZMLGgjALPcYXbHq66ncqQ8FnSjWGcSHpktil/xKZuIqj
 4V8yEVHSouxkYUhy+J1+bVv3meg7l6rAOH6eghQ8IAJEytxLuFkL9DSnilYyaLb68L9u6SXPaSV
 yStqnQEsHL2mQowT3yWaVN+gbne2L0wy8J0MHXU0YMTHKNeoxi7PNMV2wluBgydlmq8oP5h3zYl
 ufy/FXUBehBZsuyArj5M95O+L8PC3hVGvn45tEU7RP5KF8c79UTjc/kyC30PKFHz5pmKVmD+599
 pjf+2LZ4m78ljO0Mp1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-10_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610100012

On Sat, Oct 10, 2026 at 9:56=E2=80=AFAM Shawn Guo
<shengchao.guo@oss.qualcomm.com> wrote:
>
> On Wed, Sep 23, 2026 at 04:49:18PM +0800, Zhangfei Gao wrote:
> > This series verifies Mohd Ayaan Anwar's patch set:
> >
> >   net: introduce Qualcomm XPCS support and add Nord Ethernet plumbing [=
1]
> >
> > Tested on both IQ10 RRD and Ride
> >
> > The full test branch is available at:
> >
> >   https://github.com/zhangfei-gao/kernel-topics/tree/next-9.23
> >
> >
> > [1] https://lore.kernel.org/linux-arm-msm/?q=3Dqcom_xpcs_nord_emac
>
> Please do not post a patch series in reply to another. It makes life
> harder for thread viewer and b4 tool.

OK, got it, my bad.

Thanks
