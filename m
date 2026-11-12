Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794507920;
	b=dUbKP24AKm4kjgwmHzA0EfBlOoaTHN45w0EdjJtx4rND/9RFme61Enl82Eh17hwl5qoO
	 fh6USBU7Abe4Q4pqr2NSootXyBoPTDgD6YJeghpP+pfdU3Pf/KjRv7UYTksFdMQ0tpR7r
	 qYsWEpWJI04Ayk8HjSTT1Cssw1r8pDg3VzFGp1w6k4rICIfo19/IaiagYYuHdAFTk0YvM
	 tcdwS6Q+QAsbBPrq2dA5ug9usBzCsid1boh91lcP+OX+XeF6HHCUnwzh3Y6U6K+721JX0
	 G1duJSmMGSn5oZZfW0e/ae56lQjUl5DxNijTSqeR0XSw1rbgghpfqOcBGYcJIx/toSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794507920;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:Thread-Index:
	 Content-Language:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=mVvldvpyxAhIq+ppmRm7JhIT/5XgL424hW+SaFUm69I=;
	b=5Y6BOQf1J1X+rY1zvxkkgVY5SDCxkGXXGPfTH7/gS96lWa/rcztuMT/Dmip+xb7C6wkm
	 q+RncuNZyS8kz5uRVsi2QIZB/CaSsrj+MJKGCh0Rb2stFQRQkA2G7rqLowY52ngKVSzff
	 kGEeSC7f718SVKrleQsg3GirVQwGIja+8nSgLFIAdr8u93U4PTf7fh5ALpzMOL0ZNWZXc
	 OJutYEPnyVkqkXluBKYSsbbe+RYCdgEQWVZ/9UZdUKRvfuRRFETAYBXdJ8btAKVicwYj6
	 76lARCQ4ZVZ/l9x39x6VubhgaEMO5TCPIQgt6yFWNCoj2UMHIJAXJiVnvrFs+WttFog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XJ0kl1r4;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BnxGa1wt;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BB4606A321
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 18:25:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55BB4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XJ0kl1r4;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BnxGa1wt
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACFZbYU657088
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 18:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mVvldvpyxAhIq+ppmRm7JhIT/5XgL424hW+SaFUm69I=; b=XJ0kl1r4PmpOxrHL
	SxXklADFwad1BhX9bdWXs5UdELiENRzSfpxO8XWD37sH/LuLfyKKgUbg3jciLRSD
	BgaN9g5GTYq3DLvS0kA9SFeruSRvsOjqw+gBJk/4wsMPL6EzGo2RxgSrff6q6vkr
	qVy1YPYOPEUTmeXg8oCqsOH9M/9UIXUQ/XCQO8oRIIEHLOVyPVh1Rjnrzd89Mfcc
	7/FMf14NXnkHf3unZsXRqFNHBKQZBUS8lhs0Ik3h1yn68R2mXQkjmmD6dFYrvJzS
	VNqpXd86ga17ihZtQEVpaC1XAeqNMj73cpFwOftHhH7vqUcRmQIU/ckRdhr/O+vo
	ch+gNQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw6yujx89-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 18:25:19 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-139b62317d0so42822c88.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 10:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794507919; x=1795112719; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mVvldvpyxAhIq+ppmRm7JhIT/5XgL424hW+SaFUm69I=;
        b=BnxGa1wtpCEa0essbLR0R/MxXeR49k9FVUypTpMGDWBLwGr/JlQlj8eUYCw4Zc+HwV
         NmACMj8+lbm2h9FXcCyxJQoW3ikoW62or34zPzrEk9CmMWaB7j9aTskSqS55w77LisJ+
         0v9ezu1RN+hP1PHT4B+rzejtNBUXo4Y0g0vb7Widd9rg2HGNO/8vKBY7N70XOm/gXE+l
         eBA1Q+mxcUT+2Q3C+6Vrz30L4hfnmW+unn/t+NawPipsaU2WLBLYkJS8tEGlqDjdKZXl
         YgbRrooxzYd+B83oZcStKM394JvgdcHYFwhZajeJPTTHdyrGqIMyKEfJeBDF08y/Rp/6
         t1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794507919; x=1795112719;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mVvldvpyxAhIq+ppmRm7JhIT/5XgL424hW+SaFUm69I=;
        b=QhAj/3tr5PC1YjY33QCXFWxrp7PLUR69bndTC62B3khbzNBH37vOi9P52ClbX7FcBs
         oe8KY8Z53QGtP1fsYfPb1XMUTE2Pq1bDVwU1m3WZRsq0uMVXUq8yobu3UPU7bDTY000Y
         pq5pisOc4SZD9Sxhg5QsexPFkA8MhTJK5lM30+FHERpAkMjckIob6RrTMZJ3Z4SSnNLv
         k6UqEdMPMSiqaf3t+Q1sYw4kA4Y3tnBWKT03hoSh+/DTAM8n2WL1JB1eGa5UQBcyKIli
         EmfgNm2izkzd98lXa2wGmgWkXL4tGCiqDeSf6xGuKvxWOWvRL0jDl7Gf1J9CD0MxF1WD
         sAzQ==
X-Forwarded-Encrypted: i=1; AL+hErF8PF+COjvo9yzp70JlzSFX4N+S6w6viRq9uHKXPeOgKNpt8fhJCu76vwKunVBZsKvGjVkbwIM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+cH6SXlw659UxWwOfJ88roh8vX2/DTzwRi2HcDYdtu8VbSQoM2
	SJHF6G4U4Ml98Ps6ElQ8eTqAZMhtM5iETIrVFxTs5be79QWwOGC2AJ6WNfxy7EevB4BP7fE7D3D
	uM9qlF8EDV1wdCKTH1mltA3RJmEH+fwMEEe4ixgRGAXRP4bJAqMKUcLIHryU=
X-Gm-Gg: AYBFou0XuaDfi2g8TByt6ReIxH+G7lGacATSULgr5Scj9l9XiNr7I//3AqzlpMjZW7G
	yBfKhoXZjtnw43lKmXEtlDkc7GF2PxPm/crckOmV96DE1lpdW7AHmsx9hqSLGAyRZi5u4Ov8J63
	Cjza3dauJ14arS8zx2QyS4fRTfKgikKby410n8nhgu1tJGipvbiajlgwNBwrPHz/3T9tJGYC/bx
	fo7PLa5krKvhlLVw3IesQHhkqaBAPk7qhks3V2ndTJpg8WrHJzV6PpUiiKCginiHqWBpOd8mNw7
	UvK/4/YjXxYhctdudQE01JlEHEmqoQKbGl4kbj32DIL68xC1F4GT/lp0ld+Req/CEPQUpJ0uIE5
	pL7Z1Bac8aVkGJsUWWF6FxKKkSIUpQCnar179ERRE+loc37wIT4PV7XEJQmkYIDHyUPx++WrG/c
	nx23RtorU+gF9iOkSKIq/cLBFIFoDUB4FIQmfOEv5NlA==
X-Received: by 2002:a05:7022:b045:20b0:190:d0d9:3110 with SMTP id a92af1059eb24-1b50319306fmr310204c88.45.1794507918813;
        Thu, 12 Nov 2026 10:25:18 -0800 (PST)
X-Received: by 2002:a05:7022:b045:20b0:190:d0d9:3110 with SMTP id a92af1059eb24-1b50319306fmr310171c88.45.1794507918224;
        Thu, 12 Nov 2026 10:25:18 -0800 (PST)
Received: from QCOMk1gASIiYhG (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b503191a43sm614392c88.10.2026.11.12.10.25.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2026 10:25:17 -0800 (PST)
From: <subash.a.kasiviswanathan@oss.qualcomm.com>
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <sean.tranchetti@oss.qualcomm.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20261108075727.2031331-1-subash.a.kasiviswanathan@oss.qualcomm.com> <20261112083311.641a2216@kernel.org>
In-Reply-To: <20261112083311.641a2216@kernel.org>
Subject: RE: [PATCH net v4] net: qualcomm: rmnet: Update MTU handling during format changes
Date: Thu, 12 Nov 2026 11:25:16 -0700
Message-ID: <000001dd72d3$2b06ba30$81142e90$@oss.qualcomm.com>
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
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFkeIhnkKVssrYvBGDElDQ/wtA9kAHp7JEquA1kPmA=
Content-Language: en-us
X-Proofpoint-GUID: 6Rceq854ogjw9Hr8AtojbSIbpZlZ-k8B
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA3MyBTYWx0ZWRfXyXQF+ts2ChNo
 E5pIPyYg6x4pOQgda0e4PEzO1ABSQkHwsbCICH+LZhFHstSa/CCOYyuXstNzfmdDGHwkJb3iyE7
 tKvM4afV3Lwh2rVtbK0YTStVQj1jgPQ=
X-Proofpoint-ORIG-GUID: 6Rceq854ogjw9Hr8AtojbSIbpZlZ-k8B
X-Authority-Analysis: v=2.4 cv=d49gWhjE c=1 sm=1 tr=0 ts=6af6048f cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=J1Y8HTJGAAAA:8 a=20KFwNOVAAAA:8
 a=mXP6K7Sk1cvqIwA962kA:9 a=CjuIK1q_8ugA:10 a=vr4QvYf-bLy2KjpDp97w:22
 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA3MyBTYWx0ZWRfX5LpPH9EiCdzz
 2ZjL5Mmc23PUqsNaFXRK4cs9My2Fm9K7M6QWMwlqQoVpQCmnI3OPabzw89SJkIvoDuDlofuXQbN
 S+KlhNx5mwNjPWXTAIurJLsKzs0688AYFNoQ44UaN0ik54rlSaVGeJauRlEr7X6TZVFgsnpA9i6
 F8Y+4Wt7Qg5sE3XgIQMRjlO8myIjeZFRy93d0F2fdGL4gX8Avp/btgM+vkCz92NN4rmRzrNo3m2
 bjf5fMuaFu+x6hsIYhLesRtj65MzulyRt8au2XGRdt+xy8P1MVKGrgORkBfEotqIwXv6vUHH6rB
 qk1v7qTgXy5rR+J2tlDD0cngYPgKAG0dwDrXzedBHm7fK6j4hrGY3XsxSFx1C04iBp/FpJr+rbi
 wTsJRPK2GMtS6W8hN7dWpz8VPZPlrAWj3vqViXh13GWLe8/b7vZljo9oOZzR4j4t+J5RCakr07s
 GDBRHMnwJN9pwv/jfUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120073

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Thursday, November 12, 2026 9:33 AM
> To: Subash Abhinov Kasiviswanathan
> <subash.a.kasiviswanathan@oss.qualcomm.com>
> Cc: sean.tranchetti@oss.qualcomm.com; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@kernel.org; pabeni@redhat.com;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH net v4] net: qualcomm: rmnet: Update MTU handling
> during format changes
> 
> On Sat,  7 Nov 2026 23:57:27 -0800 Subash Abhinov Kasiviswanathan wrote:
> > rmnet derives the MTU of its devices from the real device MTU minus
> > the headroom needed by the egress data format. Several problems exist
> > in how this is handled when the data format is set or changed:
> >
> > - The headroom only accounts for the V4 egress checksum header and
> >   ignores the V5 one, so devices using V5 checksum offload get an MTU
> >   that is too large for the real device.
> > - rmnet_newlink() sizes the first device from the port's data format
> >   before the requested IFLA_RMNET_FLAGS have been applied, so the MTU
> >   does not match the format that ends up being used.
> > - A real device MTU smaller than the headroom underflows the unsigned
> >   subtraction, and a real device with a jumbo MTU makes the creation of
> >   the first device fail while resizing an existing one clamps it.
> > - Existing endpoints are shrunk by writing dev->mtu directly. No MTU
> >   notifiers run and userspace gets no link notification. The helper
> >   also returns -1, and changelink flattens every failure into -EINVAL.
> > - rmnet_changelink() publishes the new data format before resizing the
> >   endpoints and reverts it on failure, so the datapath can observe a
> >   format whose headers do not fit the MTUs. A failed resize can also
> >   leave some endpoints shrunk, and a mux_id change requested in the
> >   same call is kept even though the call returned an error.
> >
> > Fix these by calculating the headroom from the requested data format,
> 
> These should probably be 5 separate fixes in a patch series?

Sure, I'll split the patch and send it as a series.

