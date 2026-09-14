Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0BC37F01B
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 05:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789365287; cv=none; b=EmiET25Ykn9UfXnSuC52JhVTzU/WCv0lU9xDG4ZGOPd/SATAKrmGfBpGelp3ZQsyxy9EOrgd0+JQC0JrLUWfMY8KE23xUE2mo2PbHxvGqQvLo6Q+LprAC26h3eW25R3EBO1PlyLHNO6CfcRNWCv+4752wAzt4VhmyfMG/C9otuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789365287; c=relaxed/simple;
	bh=hev/gaIcNmVVQdTqrnIpXpJ3bvgyjIUCvBYSMoksKQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tDBQk53cj80D5GMRbZbRLj3bDbBvVQfDmQTnctQT2LZONPESiK41qyDrOZl51u+9OVSqfgQDapRckorRFWGei07j1qi8hsx6NAkEf4mdWUXQOw7st0AMLYr7mxzfiZPTmyyp59Ar0yDS67ihTTg3zovB0DDNv0EO/6sCjQJTAJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jOYvHKgU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D/Gfdp+5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jOYvHKgU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D/Gfdp+5"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E5jSrP237673
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 05:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IkBzPASuS/MD3LwoWVXItQXmkZXEaLorVetDamfkIag=; b=jOYvHKgUPRonVH/i
	sZHT0MPD6VhSq1JYRMcCdgUN1DKZmt0fhMD/KqVwNMxEX6cw1rcV7uVg9ZofoNsy
	6X/zJr0bjW0/AEGLSoD0s+0/m4tVbKNZdT46vVgZlEUKiUMpgBFwX8CXwYUPMkmZ
	7frFVSObd+o0Z74bz/UO3zmgiiPXUMa0nYZbzz2cNxURzqPLiCEQ77kyUDJ5sooO
	tfI2pxNlEvFgYWD6ZByQrAcCytcb38xm/DkIofUYarX7hKm07W6VGM+QT24Q1EuA
	EOEA70uCw39zndJDp8CpR//yFQ6/Hc5Ek1AaeB2hXKfWR86zVECk+TQTfUgL0vby
	omn9Uw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dn869-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 05:54:39 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-854f274dd69so3461043b3a.1
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 22:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789365278; x=1789970078; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IkBzPASuS/MD3LwoWVXItQXmkZXEaLorVetDamfkIag=;
        b=D/Gfdp+5/WXbzJdonIyiTjTboA7WRirWu/H3DXiEOv3LeGVii5td86z2pVmHNohODn
         iPBWQcxvO5oALD8/2Xebk5w46x+ewevr8rMUb9wNtRQd4xWwFxMaCndO2aEE13sg8d7b
         GieeNyNgqGwTxokg2ZHmWqDiX2Y86K6/8TsxIhLvmYExWaSCFYvVdQyKVU48GukkcYFA
         NSefcTlaCqL1NLnzE9yP0y4wmKHn6W1iddXYhg4CsUMFIqo9um1K/5+T42aW6Ra9rp88
         DqWJViHKWDd/kes+8cYB8lptS000PfWb6IqQRVu51r2KIXja2bdfRYHH0zyXZ7Qnh8t8
         XDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789365278; x=1789970078;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IkBzPASuS/MD3LwoWVXItQXmkZXEaLorVetDamfkIag=;
        b=oXCtFmjavD/OHahx00djx8R+eHHQb6CFmdxF6X+NchJ8glr5BPJpvlp0z6Q1mGnKhT
         YMHGEnQbVcGVNQuJHh6UhdwxAtDKR/z52IWXnAkxi9CH9EDYIqXt0NHQBZkTComMYYDM
         tLVQo1YyD8Dq0l8w5V7b8BatuNFL7g/y8q3rA8gnsQpa9TUNBMt92dqY68G48vwA8cai
         A1cnS48OFesk7bOfMlWjQFxiEuUv6OxIwHVkQzJ6XFFzAwIWi8IsJqzfdh+dks9ufcDl
         i9gwSFkHiEYfdA9yXhOXLOjm92mimDb2mtYeE1MQiXp9ZU7mIIyPjAigNBK8F9tNZygg
         FdAA==
X-Gm-Message-State: AFuF++nqGVR+oXHty8zP3fPEv2F+Z47eSN7QepEKX7O4diGavvIgXbRS
	9dXAcK+SYww5ZQa0OMjbxZ1IQQ+Zq/W56P0E0KcmXKvcdMjDKPgVfG1ZyL9H5wC8YD+lxj8v57a
	txh4+R4+hGAjhFBSfZqkF6V6v/oCg/BuEGmfhHTEWjd5XBcVMrvbY0KQ4q/FHi9mCGK9rsw==
X-Gm-Gg: AYBFou3+aXBBUSq+tD0QnHR8j/a7OmL32D/E2XumjZEWyNQK2HjmmFQoJLzO4XTPB5g
	r5dY+pn9qgweChy3iUmARq1T/cWHTi04voWKAEjO6d+kLaFWWOTMaFtBST/Ui9bjbOWkYCKOOxv
	vAn/hagu75OjwgqzfMmZggMO+ujkeSycPrOm+3IyWRP6HN4xb0XbPuYGgXWm0YObaUNbRsGJeQh
	1fgz6Hu+WoMcQQ6PJW9xkUgmi+GHmhCU99NjGZ5XbgT4VTPwF+1eKe1hjPd2sYZwxEn2ulTp2Ip
	zhqLtF1OY/H6a8N9hGHPQTYn/cT6CkSD0kXqPoe2GuiDwaI0e9LArDsiTmrWrf71qUWHF6F4iOq
	ed9iMK9+osDzMQudy9MCxxyOSV9IVET8us84WU+Hki6/r7NPc65DtnYeVXmHaDPB1CA==
X-Received: by 2002:a05:6a00:950b:b0:869:8620:26d2 with SMTP id d2e1a72fcca58-86f82f51c34mr2620075b3a.1.1789365278279;
        Sun, 13 Sep 2026 22:54:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:950b:b0:869:8620:26d2 with SMTP id d2e1a72fcca58-86f82f51c34mr2620038b3a.1.1789365277762;
        Sun, 13 Sep 2026 22:54:37 -0700 (PDT)
Received: from [10.133.33.206] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b2a3bc011sm3957346b3a.57.2026.09.13.22.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Sep 2026 22:54:37 -0700 (PDT)
Message-ID: <76f93dfb-b5c0-45af-8358-8ddb7f2f560c@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 13:54:34 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PPE driver: are qdisc or flowtable offloads planned?
To: Julius Bairaktaris <julius@bairaktaris.de>
Cc: netdev@vger.kernel.org, robimarko@gmail.com
References: <CAC1t37+=keDdX7=G+zyPhBx2LgRNEuoB2tonHF5itrN+Lyx2+g@mail.gmail.com>
Content-Language: en-US
From: Jie Luo <jie.luo@oss.qualcomm.com>
In-Reply-To: <CAC1t37+=keDdX7=G+zyPhBx2LgRNEuoB2tonHF5itrN+Lyx2+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: n6BNSoIld278ynnc48yZ0pGr3q0opMyO
X-Proofpoint-ORIG-GUID: n6BNSoIld278ynnc48yZ0pGr3q0opMyO
X-Authority-Analysis: v=2.4 cv=NelzRGD4 c=1 sm=1 tr=0 ts=6aa78c1f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=NEAV23lmAAAA:8 a=-f1nm1HtdSCZhZjsSm8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDA4MSBTYWx0ZWRfX29rDUWDtcyLz
 j00i0Hn43+RsPt4bHasfhirAQCXAoMLtwdu4YVPPnv2RvWn6p70dwscT9TlIpMCW77vQ9dCweFE
 yn3pMDW6+xTSJZvk3PwuwvW4w+buFk4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDA4MSBTYWx0ZWRfX7exGqvq8LxSo
 Q8eIEgzs4lgNIAQbWnSUiUoTWRZPdzA5i0GYtB9PUPSTqCUUBkfMHq+HWZEwHNaVMra2NqjJQlO
 3kUPjxUvrGLrkGKGx7lylaGzl/Q4SJQDwFkFh94IxboPNEYbWsP87uc8GqO6vLzJ0vdugeG30NG
 auQOHv/mNNLv7kCApcl0TsYcm76TLgqHGqIpLMdA/a4DB0OF3FivfRJmuedU8EsAxBhPZ8WNYrA
 dR+rS5QkAGOksi7RNBUk+d7tp3XWsMfyEmJxiTpcZiczesUO0pOfI/OIyKrcYEv66rgCmgWVR2r
 sEL4eIRvjeItgsbHDziXQmWUvCKGVefrrP4OCpr2Rd0YuL7W6UbYvA2misD31C0lb6pvUVbyCwb
 PMyBJ3EVBJfFObWQDUD2y2xHhyI9G5hmLYicz0bd4Smhm+okCBwVj3Y3qkHUmrux+ZQR88Mh514
 uy70nmE/jpXOnnpcamQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_02,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140081



On 9/10/2026 6:11 AM, Julius Bairaktaris wrote:
> Hi Jie,
> 
> I am building a PPE flow-offload driver for IPQ8074 in OpenWrt
> (https://github.com/openwrt/openwrt/pull/24806/) with a DSA switch driver,
> PPE flow tables, port shapers and queue classifiers.
> 
> It needs two kernel patches that have no in-tree user, so they are stuck:
> 
> "net/sched: sch_tbf: carry the queue limit into the offload" adds q->limit
> to the tbf offload params, so a driver knows how deep the queue behind the
> shaper may get. Not posted yet.
> 
> "net: dsa: offer a flowtable to the switch before the conduit" offers
> TC_SETUP_FT to the switch first, so a switch that owns its own flow engine
> is offered the flowtable instead of the conduit netdev. Posted and rejected
> for not having an in-tree user.
> 
> Is a tc/qdisc or flowtable offload planned for the upstream PPE driver, and
> on what timescale? If yes it would be wonderful if we could align, so the
> two patches could go in with it.
> 
> I read the three-part plan (PPE init, phylink, EDMA + netdev) but did not find
> an answer to my question.
> 
> Julius

Hi Julius,

The PPE functions you mentioned are advanced/enhanced features of the
IPQ PPE. Support for them will be added once the three components
mentioned above (PPE init, PHYLINK, and EDMA + netdev) are accepted
upstream. These enhanced features aren't available internally within
Qualcomm yet either — we'll discuss this internally and work on adding
them.

Thanks.
