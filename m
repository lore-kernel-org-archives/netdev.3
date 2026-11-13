Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592622;
	b=ds7GRs4lSQAD/Le86v5AcHpwATvH0xnsOdHhA8h5yNsg8l7OP/edP8RXpkRsPKGpSf6K
	 4MH9UY1KjqjVPm2QyZ2y6djBF4d2zV6qlguSajx6zUmO33ONMhmmtF+1H9sAuWRXDcqUF
	 K0JhK3B4uGP2fxRKhFCMKYs+M78h9yT+7WxWuEizaKSDDXr9t9Hc6JCWfCPmnqJU4BzOk
	 vsogUeH1taQ69SOIAz18hSooJKGQCJ6FBDqYVQiFRyjo/q7eHfq97C7TJAouf48WzD1Xn
	 qOAPLk6pLbxPJufQ05+0eQOFQM7cnaC3sW/lMZyu39U3piSfPUuqCijGavs+X7XukPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592622;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Fmd2nLf0haoA7oj6MYXU0Aj+BE1OMnK66p9tj6naNLk=;
	b=mG7auinGuvrmAuI9Oey2PZgW+gqlLqxEgNTChCkhOVCFoJhugYi5u/j0BnbxZ983EqWq
	 mxEHYAPA1+EBvIUYeEM4OupuaxpU3tF5i8unAcn5BQdsKUkt1Q9cbsl4uSBb9FONSAB7o
	 6Y6WMEMOiAb3b9/MclcbYt3fkhhY/VMlcpW6cfsQ1RgSouvayofUtopLRtLKzJHg/qvG/
	 Y0FTh63ys67VOqpiVUh4ifusUmuw5LMtgVA3fPjFuQhDM3DRHfBOJ1o8YhBfPdBITsOLJ
	 mFECBzIg6UCW9DqnmTRO9TYnF8dgmCgt7b4v4nm3BcpfgzVqojCIM78YzQhOp4ykpLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V9eK6vLR;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=camPbo+v;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B2B606B213
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 17:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83B2B606B213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V9eK6vLR;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=camPbo+v
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADGXQZR2808851
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 17:57:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Fmd2nLf0haoA7oj6MYXU0Aj+BE1OMnK66p9tj6naNLk=; b=V9eK6vLRMDxX19xu
	zh6dkBNlmB0VfENHBMWLEszHKvX9eri9Gla26kaKQCnZF7TV8NsH+ktWsWeaa81P
	JqQstJD676vyyiC5LAqgy16Lfvf2JrqQWeTxXAEwSSNrtYXaiDn9nZmAT59piAl9
	v8KJWWwHMjjaxxMOISTeorSRAshUrE1tvG7XRrNZyXFxoHAZUlbeFIPdBv4mASvT
	waHKsmBj55YHJw4Una/nap7+lnifacWLjA4k3Q075k3ncuWhPjQJHQ3UfpLiklGW
	pXxLbhccY3S2QKnzZzRZtXO5ZocAZF7ZaA+25j71/m2fYOYCaRq9+DhVoYRxC1gk
	uPOk2Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hx662r996-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 17:57:00 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso1842059eec.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 09:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794592619; x=1795197419; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fmd2nLf0haoA7oj6MYXU0Aj+BE1OMnK66p9tj6naNLk=;
        b=camPbo+vJG2et5uBLcuuw5829BDupha2RQCWmAQEO0thjZKOr/jTEkDEbH2EL2cn7l
         dwkSdaZPehhCUoylK469ppt9BG0CNgtoEMfk9+4rou7IzbGjutAZ4Oia2JdCyaaxLjW/
         Cs0z349075ajV+yrwUsnz8CN36CyOMN10A/4aAyQAvIfWqaOcFxAbjoW7iZdISHNFm9v
         8+l2gYrfGGeUyrrAWIJhGOU5Q5dJJWbVjHTypfz0kolhLYQonip8rKkmd9lFHPKdmUZc
         wda7FhbQLYyu571RdGnUlOUtvWqgZtDsRR7SbVhEotz3Uk9m+j4qluEz7JMGQg4Kc1xR
         uIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794592619; x=1795197419;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fmd2nLf0haoA7oj6MYXU0Aj+BE1OMnK66p9tj6naNLk=;
        b=1iy4qQTHANmhAzaGoRUC0iJzZqkgi4n6MY3iXz0WBarXg1quMBT5ikRAFPkuj8uiBF
         zF2ugr8xcDUn0oVdMB0t7SgRFjcVencUYYxghbNPGuvTzM2TlAofBV7c8JBw+1n3xxHB
         BU+6nqEWIYv/IXGfjtImJZodujMY2/aJZqVJ0abYSdzCB6vkABjHIihL6Ut+1ogJT8nb
         9cM66XpIYqVMqE+Ya4WGU+56UFUVRTu54uP19X1YDhmoSJh0EKmaM0+borfD1YXNN54Q
         MKTryTgQ+brha7sw3Rj+cjUmnONARwq7085Lj8Vo6i6Dk5jd7dmCnyvPeV/KSSv9yyS9
         7xaw==
X-Forwarded-Encrypted: i=1; AL+hErFVd4Fp8hN/6eSKDPayQzsb+tel6SfDU4VfWYVFBPfjagL6ii0OLwAStQD8l1mKSvjHuB4zz3I=@vger.kernel.org
X-Gm-Message-State: APuU4Z9h+8dKERy6vQp7x2VJuDk/s8OcZQNXCgJLCQklD6VxEk7ZVNPi
	m5uc2acXQxnkUr0OaRxBtTTI1lckDqgUuuSPf+Qq14qsTn64/7wTEmIYcpWNKIr50M7QUryd2g1
	lKMtcTguqbW3xNBvgju21DY+RSZWo1bcnvKdgYAsHIGNIzK8bkIFw1PF9kCA=
X-Gm-Gg: AYBFou2rkXg7dX+alxNCELN4lDZkUXuZ0Qf2wgG7Dp7ratb2JPozCjrFa94Jr2kUqsO
	2uu3CG47u7Gw/8wX9dxhywHsUSBbkTA8bkZKTBsMPB5gsQ7cbhxmtq/s3f9tYA65HhMmf+Yrc/w
	pGUQQ7djn1H+cJ2qCnsrBcmSZQdgF1sc6Sc3EHtSdufhGkOOiJ7jm5RjBed9kNol3XIs3lZGyMR
	6wBWfaimAoxr4zcgxFccfc3NU1mPUiMzG8jAi1ep3FFuBhYX2s62Pzs3zvSOvYEMU4zMmqCtiKY
	FGpln6Aalv8q1kGa56NUyfQtniRZPpe3jck7ByD5CrrssdAooOjVbiT5xeBN6UuL/QqHtG8jKTI
	IVWyU//jea0KOy8bSDQFfMCjHbHyLZk9jO7jGpasZUast1IO7WMYTyInVDax7tDcFleDqg+qm1E
	FaDzRiJjE7Ewjj8n986ZOXOAk=
X-Received: by 2002:a05:7022:ec86:b0:16a:c6f2:60c2 with SMTP id a92af1059eb24-1b5030d709amr3499643c88.12.1794592619195;
        Fri, 13 Nov 2026 09:56:59 -0800 (PST)
X-Received: by 2002:a05:7022:ec86:b0:16a:c6f2:60c2 with SMTP id a92af1059eb24-1b5030d709amr3499614c88.12.1794592618530;
        Fri, 13 Nov 2026 09:56:58 -0800 (PST)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bb0919sm8891447eec.29.2026.11.13.09.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 09:56:57 -0800 (PST)
Message-ID: <df3a9511-a17b-45d6-b048-9cceaffe6a8b@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 10:56:56 -0700
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] accel/qaic: Add callbacks for DRM RAS netlink
 telemetry
To: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
        dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
        riana.tauro@intel.com, aravind.iddamsetty@linux.intel.com,
        rodrigo.vivi@intel.com, raag.jadav@intel.com, simona.vetter@ffwll.ch,
        airlied@gmail.com, kuba@kernel.org, ogabbay@kernel.org,
        lizhi.hou@amd.com, karol.wachowski@linux.intel.com
Cc: carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com,
        youssef.abdulrahman@oss.qualcomm.com
References: <20261106181225.3333260-1-zachary.mckevitt@oss.qualcomm.com>
 <20261106181225.3333260-4-zachary.mckevitt@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20261106181225.3333260-4-zachary.mckevitt@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: QA8eleCqfvV64wGKjuJD8e3i-gJsPK-e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3MSBTYWx0ZWRfX5K8t2yv3ApkP
 /6QF3XaRf3uuBGSPEvN76qjfa8DOk4+4gx9zPvbIW+Y1kQ1B9PXZ6zgeOrGC5Ei+b5opePEzM0n
 mLahqFCPcqSY6v0rGRIVShWqvEUadpHWm6zw1uxgQ8T9Go6kVYnqUYgFXz7lpUCLpyUc3rYTLKl
 qNnaABqUk4v9RT7+EREH56TzTLlj9DLUPaCd7EpMqpDojr8Ci1fU5fsA9PLuhMA9rHWNceaMT6l
 Ug6UPmM9D51VgCw28Rn55Z/XmUpGR4bQFpbf3pXqZI70NX4RbUQoyFoy/KVA3MVrj9EBZNF3KwM
 vN9EioEo8vx1fDlLvlE7OPn5AeJIu/sF1GOp0xXpFYnhdOezilduLQxX2JSiK4qHrlKI+YFxiaq
 0VNOwWaUC+TltgV6lnxeJ1lUCP2lLEioSsI+8voSRPGZuEcrokP/QeGySbpE9kEEur6cN+GWwEk
 Qa1arX7rUphF+IsWHZw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3MSBTYWx0ZWRfXyxsCEyi1cFfD
 CbMkAbW2JUPcXwKMw3uy8sVQfYwcpTdBqZwlGijCyIJwBQJiJKG5iARuqKsFKZ4eCszUMVs+lYE
 16S/t4BlL6LlNYdcFPDP/d7PBwdHP0w=
X-Proofpoint-GUID: QA8eleCqfvV64wGKjuJD8e3i-gJsPK-e
X-Authority-Analysis: v=2.4 cv=M/nYuCws c=1 sm=1 tr=0 ts=6af74f6c cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=CNMjiE_s7LF6lbcXpzMA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130071

On 11/6/2026 11:12 AM, Zack McKevitt wrote:
> Use the DRM RAS netlink infrastructure to perform device telemetry.
> During PCI probe, create a DRM RAS node with DRM_RAS_NODE_TYPE_TELEMETRY
> type and add callbacks to telemetry_request for read and write operations.
> 
> Co-developed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
> Signed-off-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
> Signed-off-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
