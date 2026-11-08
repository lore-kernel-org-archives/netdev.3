Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794125521;
	b=cLZ0WCqMjXDt4O0kg/mKKOe/j7lAJi7m987nn3GC78zX2INNYnO5O6NSKSZkA1AAKeYK
	 rZmEb6eAM0mKb2+Gj/qvt/Zz/G03Xwiu14tEIBccg2Q6Gtpeb25I7dOv4H+JxyS3ViY7Y
	 g85BRTkZfg7sNnTclO4V5gs/jnoYw8Pkun79/vEseYpAQGd8ZDdQsJUkLNnks8vAA0fy5
	 yVplXYSqiccam6P3dvC2WJCiaPX6ODqn16kOf7dDjHaYTyIBWn3b8FmilaVv6Djj3F2i1
	 97SjK/BHRo5RyFJyeMsPCO6hjAX/awMWRY6mWvAP/n0lHVVA9xEth8rRYFqH6NeIviA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794125521;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:Thread-Index:
	 Content-Language:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=t4Tk+3qyBOYcDqmgeM112wYSFWr5RQ3gj21yV0GzGTI=;
	b=thkC4ITolpeJswS8CM3NVieYG25ceknB/Xkg/R6Fpbk3gT+FEKbug59WAz1bdQPV7uSF
	 3EJ0mwFPVkrVYaLl245VmwR+eGWldZhZtXywKcxg1uUq45isq9I8MpsS20XjkEQYknpqN
	 ye9sPdf47IKTQvm7O7b4qjvm51m5W6hnxC4wbU3pJDs4y4rQxPF0+GeQShdCB7PMRZI1C
	 DVX0Igx9pVgn6FbJGckEaUVsy/2g8NFugVjYHR1BEo9NCnqAGHwXOrc/7PToSvXtHq/7H
	 9spr9/yX5IFSnk57xOXOhx3u3QUw/1GVYaNu/tAYN9NB9DZyCkwISpY/wJiMQPlcivQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cVkezBiW;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="HZdEch/h";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798C4606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 08:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 798C4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cVkezBiW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HZdEch/h
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A87f8V43460703
	for <netdev@vger.kernel.org>; Sun, 8 Nov 2026 08:12:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t4Tk+3qyBOYcDqmgeM112wYSFWr5RQ3gj21yV0GzGTI=; b=cVkezBiWftf1cluh
	VJEQbYJRJgJrEC7IG1GxqX72McbwB8R9IvIHtflpsWK35UBAVdZMDXQhnMzU3NCt
	xKMWA88spKzsgT4t5kSPf3RhJlgeloLzj6jVbOJ1jCgP1ki51qPPTx4bN1KvTDQC
	pYmtKYNW5NHKU7ZBH3rGm4UHv15wWty3wxIm+6pSBgIjAWVKA04G4IJf7rGL5oTU
	FB+O6pDg31ZbkOZDeUFcakoc99DE58RsRLm8r4C++PAu25Zj7I45WHidzHjA0lAG
	nlCpYz1MFCRzSWUYi29fwboOIZ8Oc5ZLtZWULbIoNoAUlymalfwfq2pEOQd0NXZ6
	/eHpUQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsw5k2cr6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 08:12:00 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-154e9d2d94fso412059c88.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 00:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794125520; x=1794730320; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t4Tk+3qyBOYcDqmgeM112wYSFWr5RQ3gj21yV0GzGTI=;
        b=HZdEch/hw3oCCuUNg0u5aXBzw8M0KwCsbjgSaQN2knjgiMx+bN1K3z1wSccou2eppG
         r0PCkyapDuXy35O+GPZ1CWRbSo8g0UJ/PgOYThGHPVHXrs5Jux+JU4Wgp6j2eTHYjOIC
         J5K2grFFRZ2Zn2T8mzES3K/KsgQpuIbf7T9tRoFw0AmPnt/Zvdfvt1/Ql/5Niw9XVIRp
         5768qxp52HVGDdije+9IFhCUgfJqXwXSTV67/GFdu2iKvZE3vdwbU97aQUOs27QtH3kA
         +bcT+TxTmI2Asu+DKIz+NyBQbbljkDlfHgO39BVCZhDRM4ZsQL/j3/vilNjCdbYzISvU
         tZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794125520; x=1794730320;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t4Tk+3qyBOYcDqmgeM112wYSFWr5RQ3gj21yV0GzGTI=;
        b=el23aFQW8nncVRnKsYcDldHhoDo8ShqGNgS2kehbnB97xGSvemAgynNxMduzd+xnel
         E3l5L/PoCpTl1sJ2iieG0lUEOZhZzZBMFXZmiwUAC3HB2hcZx06MYdJV/yWW56qBra97
         5N2EnPjNkzWmYWskNIB9F7L8ZKX98C6aGvfu0MH7YEL7q5bO5tGx9vJiQLg9ql9dus+8
         k/cM5UZr4VmonJdJzh+7KCDkvbBSOZ8c01P52qfIZuxrIpx5SVgMUXlRn8g0vFxe/n5m
         3X4M+Bpo0we8ozthEOEgvaKjf92u0kUSPWLn1hQriSJmp05mvRcMvAozA+35OFwnQjKk
         DIUA==
X-Forwarded-Encrypted: i=1; AL+hErHwTG3360w2kKMcMBGZeblNz7xaXE9aDZu0oKa6hgwDT0FT2ql+9HU/TW8ADz1Wg2JAjJWxvy8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9vOHfKFYzXFTtqZ/KCblgmBad3TIh8kl/IB2X1RtYk2yHrlwHZ
	MEwlAjVH/ytIBprp7r86OPuvOshaeC7h70/KZQpg9ndrc4HMEXwgMGSPbBB4I0mD9Gj27HdQEq0
	L2bzdIHea28Qtyjy04IWuS4u2Otu6TgUU8Z0xHMfoClcgaC3Wocg/2RKYkwo=
X-Gm-Gg: AYBFou25/hXM8MMNiw5iZsPHFCP59c8u9zC2KEBkMqqXWyGg2s7Bz65Ep7NPQzp9WPS
	cNdHB453iU38zZlU8ArK822m3K+IZHSegpchwxPFGKiMcRVM0FVuaWjOprL0stXMzFzR0ZTd60R
	cQZuonpFMQKA6Sm5uGjyP+Hfnc+yh3JHbO2TqtdUnHwsSu1ynEg3YEdiG7kcX3UOLv3LGrFSSaJ
	fsjBXmJVGsDUlfMs8aJhQ6QeFe3ULN5TcPAsqqQHTZ0zicR5ZwSzb1ec8NofK4+Bo1OWIV1RVGE
	90UiYPNOEqZHyhGdsdpUFBeAtO3PMSJFnQMHdeibYE6HdFRiFvyyUzoYBkFbVUM5pVjqYD5j7s5
	JK0NarzvIQYcJevGRuohwftAY3WyFjoOpv8Is22GgGuRzzV57/G/iiwnrbjX7DBWt+/u1A36giP
	nIYwHuNcYSNaP6ZeoK98AajEiMZOtEZYaiN42bQnmKWpfb67/XNgn1vSuO
X-Received: by 2002:a05:7023:a44:b0:16c:4eef:a526 with SMTP id a92af1059eb24-1b39fece490mr1414844c88.15.1794125519996;
        Sun, 08 Nov 2026 00:11:59 -0800 (PST)
X-Received: by 2002:a05:7023:a44:b0:16c:4eef:a526 with SMTP id a92af1059eb24-1b39fece490mr1414794c88.15.1794125519334;
        Sun, 08 Nov 2026 00:11:59 -0800 (PST)
Received: from QCOMk1gASIiYhG (66-33-8-210.colorado.intrepidfiber.us. [66.33.8.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3771f0e0fsm5563265c88.20.2026.11.08.00.11.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2026 00:11:58 -0800 (PST)
From: <subash.a.kasiviswanathan@oss.qualcomm.com>
To: <netdev-bot+sinfo@kernel.org>
Cc: <sean.tranchetti@oss.qualcomm.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20261108075727.2031331-1-subash.a.kasiviswanathan@oss.qualcomm.com> <179412493254.488859.5909018726402609409@kernel.org>
In-Reply-To: <179412493254.488859.5909018726402609409@kernel.org>
Subject: RE: [PATCH net v4] net: qualcomm: rmnet: Update MTU handling during format changes
Date: Sun, 8 Nov 2026 01:11:58 -0700
Message-ID: <000801dd6f58$d38f1e00$7aad5a00$@oss.qualcomm.com>
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
Thread-Index: AQFkeIhnkKVssrYvBGDElDQ/wtA9kAKcck2AuADbBoA=
Content-Language: en-us
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDAzMiBTYWx0ZWRfX0Zcd+tp8LtL2
 2+ybsdgf9vuT9mbhxvhBrgVCFTvqymDee/ta8oVbzvccGK/oI1ww9pl9KUFZfnbr9qn6/zhQPPa
 ozNBahDZ6I40TddJqdni4Aa8VaoyNe7N3mJsoqclUGhFnkr4Qnj83NR4p83XGjipoRnSTu8r/fV
 Mrn3ilD8dJd2XrNgSNOv7dplY3YJW8gZgCa7i6Yd+Yx0pvFm4EHKP8Fz4URFhCN4Vs/PbTGNZuT
 vvKBbaQ7Rdz1q1yCpk3dekgcrtWnMcGovBP7FHAO/gkYXJ/GFrs87QafMQFKpsMdrvfXRgPQilT
 mpv85Ie9U/T+eMUbcgiH78lZvbeJQdy5Fw9XJxQ7XgHgU5xBhwWta2Op6ukuwkTqgO8y/03IKrY
 JLtwKffDgFcdJe2zAIJQeZrunhuPcVdznT+/46thKLbUGXiDMOWmnjqRXFxTNQBbne6hVa/5N6R
 /jWjMpWxfgdySfsUN0g==
X-Proofpoint-ORIG-GUID: 6p5ZSqyBcquyBcthP6KYFalOx-65Klsn
X-Proofpoint-GUID: 6p5ZSqyBcquyBcthP6KYFalOx-65Klsn
X-Authority-Analysis: v=2.4 cv=G/aJgNk5 c=1 sm=1 tr=0 ts=6af02ed0 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=OltkOWFNRHEXGe+8VJKHzA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=J1Y8HTJGAAAA:8 a=20KFwNOVAAAA:8
 a=wfrYX8O7EWgUh0Dss7UA:9 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA4MDAzMiBTYWx0ZWRfX5iC60C9zrorJ
 uc290v2SJkULDXBrdDCiNqlDzrhfLgrkHHflxyuJxEHpSSwnMaJ4HY24Oljr0MvK588t8yhIblX
 LmpDAmd4vjApPYtmezBP/l6HSSE3LiQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-08_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611080032

> -----Original Message-----
> From: netdev-bot+sinfo@kernel.org <netdev-bot+sinfo@kernel.org>
> Sent: Sunday, November 8, 2026 1:02 AM
> To: Subash Abhinov Kasiviswanathan
> <subash.a.kasiviswanathan@oss.qualcomm.com>
> Cc: sean.tranchetti@oss.qualcomm.com; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@kernel.org; kuba@kernel.org;
> pabeni@redhat.com; netdev@vger.kernel.org; =
linux-kernel@vger.kernel.org
> Subject: Re: [PATCH net v4] net: qualcomm: rmnet: Update MTU handling
> during format changes
>=20
> Hi!
>=20
> This is an automated message. This series looks like a fix, but its =
commit
> messages seem to be missing some information:
>=20
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>=20
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
>=20
> Please do not repost the series just to address the above. Instead, =
reply to this
> email with the missing information, so that reviewers can take it into =
account.
> If the series needs another revision for other reasons, please include =
the
> information in the commit messages then.
>=20
> The evaluation is done by an LLM so it may be wrong, if you think that =
is the
> case please reply and explain.

The changes in the patch are addressing the code review comments from =
Sashiko and not tested on real hardware.

