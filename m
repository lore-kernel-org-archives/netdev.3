Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794283986;
	b=NrsqH1gA2ZYElz1jcPkWTB5Zh7K2Hbbu4AWiLSj4LhhXEFVeJYPTQbgf5cjIVrhSBkbz
	 PL2Q9LRDaSPnSCQhIO5kL0ihHU/FVyyZ0Hsfr0vC1v4Cwt/eGMBm5HjWHbR2PBgIUK7IN
	 o6Wm0sevzdvau6e1rR1Gs8KhkqsU+dplfOG/wywl4cFnWznn3DoD4xPXDZhJVu9eTAfbE
	 StrrOhDq9FiwTaSn6qxlmz7AIZbYoGmxhVlIPtUjckuzaC5rNRPOxUerMy7+BIzQYYhaU
	 gcD/quK0mkEWOULbCE+Fdwki9MwTfpbVthDmUCECgbHukBQnwcEC0hrvfXRqX1NykrQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283986;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=cCPtgOUClLidfslbB2P+0rQ+331P45eB5fyHHdLHlh4=;
	b=3i/sC8GClZUp4ytJUvZUm/IfTyeuiZdZJgfNQ3bt4BLQfaOvKrOSsPKl7xHx4yYjK5zn
	 bGEQsC/dIHYo10b+9Qin8oURpSgFuv7qlv961K9Mkg+KoNv14C4ea4ZspQdmlG1MKeTjQ
	 C/hr6baUKk3AXwr00Jz/h/7tJnN/b5u6mwy0gWrAGTixrPFHdXI0oTCfe3mwXDrKRcv06
	 sKoXA1/r0FqjvDXwP1lTnUch4bHBmWWGY/cRv0K6cy5eEiOIX0bLqmBft86rkMyNBxtmd
	 zll8zHaDQxkKYOxiglpoYwCn9joq7tUo5eGNuke4yUE6cBr+gL1Gf/Q6PWeUEPw1e9g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EBfqtfHb;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OskcvjNS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F46606A321
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 04:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72F46606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EBfqtfHb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OskcvjNS
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA4AEf42275648
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 04:13:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cCPtgOUClLidfslbB2P+0rQ+331P45eB5fyHHdLHlh4=; b=EBfqtfHbAgl7tAAY
	YgQqEoqqW4D2gW14J8UGOZ2ViRejdGVYjoDnKht5A3LKUHmrNOMfMIUpKVZxGr+q
	jJNSo0b7f7YPahJskLPcS7WrMP8nkSw07Utk1+szS1WQ5NUthbIofbWJbWfQ3fN1
	wyGRkzrQIf1SEeiYdnVINYb1XMntq2R7oidqbIf674BIoWo16C2IhLQ9gyDKD3Y7
	mYoaB2xSXLiqnjIfZVqcjTAB0NS/hcFDS+od475aU5oYRbWst3MqqkVs//doYG17
	WL6Cnip/rvHvReGtm89Y4IrQiwR6q2/qdk/TpVgcdXWBALu/g5g0PRlvLtTzpDTo
	kisDPw==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hudf5bd1f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 04:13:05 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-679f81d5d7bso2963907d50.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 20:13:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794283985; cv=none;
        d=google.com; s=arc-20260327;
        b=nVl0la5l3ft1NgfU9pBYgnDed52URGYNJk5/O0KegEy5KM/KtVtPqF9TqEoeZQb35l
         AXp4nh90NiIoIi0+1auyCeZ4ysqYIS6KsG6Hw5HqaOg0V6QRHaGDFvgdgTkVfp4+j0kJ
         hVudrIzXtFppAjpPvEvq5DivqM/x1XR5f5neJDMhf/K4e4ehhlJRzKhApXks4svxSBxm
         DQBEUuPpknuZ2xEZ1Aqa9OLoXugYcMbryzUG96JQPAB4snt/RtXdREgFSqaZ/9gkCOrg
         tRd36iMukmGE8aS+zD/z40k49PcVIUqFIBuH076hkfa047RjkeB3u9WpxkdKWJ7xegN5
         OoYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cCPtgOUClLidfslbB2P+0rQ+331P45eB5fyHHdLHlh4=;
        fh=Qr+eY0oEkrtumBNpwJDj6V43AVFp8d/f/eoP9Ure/SQ=;
        b=eArrxc9TkDNS3XRth0FSFFFH4h1v65yHaGU4ldhN5VQnw/5SoGLuDFnrjWHJYqKaDC
         L8rKO6ohLVIDweKO91T5FVbmfIpxowbXLOnrNUK2KFKu26qX7/jiyyiD9b7lXzUqI7CJ
         nG6RB2v2hQmikOP2YBKrgu4WLhXCyq91NPYN8wkHEvFtVsdnE2/tGsPE82vbHST4bQbn
         j/j+4/JBGssUFKCqqTNy6+nBALFeYeFS1Y167J0zpoF97w1x7UbzIzDaDjicGLWVZ52Q
         dgPRzTTpwve/xiuV+br7//8VBTDzCFeb4RrE7D6syjg5kfIz9niw53UqWShK8eNv5KsC
         SurQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794283985; x=1794888785; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cCPtgOUClLidfslbB2P+0rQ+331P45eB5fyHHdLHlh4=;
        b=OskcvjNSHi+7oFJRQzXHcZ1HPLV5J+R2LDTQDULTfkzbgxiNIEwAhWA7WZvbNSW36n
         2HFqrF1uU+CQ8HG03GLwi5ke7nxg5rlyL/xn6MiyD03C9dCPI1cCmor+QRwKR9BFAgYv
         6T2n4eIWmBZkBoMicVonvFHnQlfvJ9G94lh5VoIPnPAhFezc3VYkYf4YfqMc7oRXpjlB
         EigcI25vfF9QYOQ6aufkMQbfxqArN0ayTXVcU28jzeESsqLbb2x8L8ZYrImepP7/HjMR
         qsGt5Aj3E5UFxQt9h0V9ojLNSmo4RDTv9QxLlodXqARW1rv21LQeAUhvYkAixybbhnsf
         GceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283985; x=1794888785;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cCPtgOUClLidfslbB2P+0rQ+331P45eB5fyHHdLHlh4=;
        b=xB+jD5vtYMlRE6F26IlmMQSjtdp822b7eAjLBkXZTSVTOnStnOGHqCQgqO6ZaQ55k4
         6gTlATrM31qfQk8GvE8sJ3zcMHa4DFnJCVuUkMyCpfB4oVSvUOYuyfx6RdXPI6oqsFeC
         0G3YeNxU5JUX/T4CpvsC5JDO2sHHXrtoxAxX6Wd3ASR/SnruJQEz1blFsMQcQlfuANOZ
         GmN2vcd0GFejYvfE+kXXCRonhbULK1jqEbvssvqioaxghmugfQt48XOYBfuw8DTNDCBs
         GjGihYVS2UhgRJSM1942F31/3udaK3DzgaF1dZR5wo3kCgfBs67VKS05f2ewq2XnGaCe
         TR/Q==
X-Forwarded-Encrypted: i=1; AL+hErHeltUeQ2enlnNPuvbmE3TygmnRVWTgpgr5jYFygSXuWf7DkXawKeW3cXpva5L3fKa9/UDgjHw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/aGIN4IfiLciTUnuajfrafNOaEdqWjbLtZ3DdE9vKMBKvHq/tX
	YeJihB/N+CP/bGXxhEvmMXiMq2gH0bnnFRUntfVPqMEst9DeuPGjAxfPaOSZWJtafqcXfHMLGxW
	SF1cMwC3Pd628A3/TWDEevQGv9hfyqXm3MKN363AyOU6DG2b2Sb3taFAjsFN0+EOuvau0qf9tKm
	5SO2fcuHNEEf/QMFiy88D/S/nfbXlqQZk0CKka4PxE02p5
X-Gm-Gg: AYBFou0y15xUQz/Q94VFrrbX5xS6M7JrY3hRT7e7/lkzIVxN7e3eTVPwnmyS3oglePl
	e+Qaj+lLa//34l26pohYSrTYOm74+LH11InzJtwRmVeRR6lmxJiHgUnpVW6x1ozHwTXebPgYI2t
	CAjQjhRGvlQ8UmcUpC9REgbL+ZJHwH87F/sH4NeXukR8aUB3K4x3zBqCDeNA==
X-Received: by 2002:a05:690e:80b:10b0:67b:edf1:7294 with SMTP id 956f58d0204a3-67c567840d5mr549807d50.79.1794283984475;
        Mon, 09 Nov 2026 20:13:04 -0800 (PST)
X-Received: by 2002:a05:690e:80b:10b0:67b:edf1:7294 with SMTP id
 956f58d0204a3-67c567840d5mr549804d50.79.1794283983988; Mon, 09 Nov 2026
 20:13:03 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-aquantia-poll-global-status-register-v1-1-808089824a3d@oss.qualcomm.com>
 <179326624025.3327.5471427454050749790@kernel.org>
In-Reply-To: <179326624025.3327.5471427454050749790@kernel.org>
From: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 12:12:53 +0800
X-Gm-Features: AclHuK-34PzkdjjV2B8UNP3izxEprRgMKp68GqqvuOTJfXarQQYQmDgBJr59fVQ
Message-ID: <CAPTcHHQrL0HBVEmfqS=x+uOX6p2f7pbTe4j3-DqLs=jVm32dzQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: phy: aquantia: Poll global status register
 for provision ID
To: netdev-bot+sinfo@kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: vPSNmyQk2Kcvjv6p81W39uHhsDd6kbWe
X-Proofpoint-GUID: vPSNmyQk2Kcvjv6p81W39uHhsDd6kbWe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxNiBTYWx0ZWRfX3eg3VmIbbaCJ
 uDxnUpCsw7xRZ7/WyZ2I7+arxWSVi/oF56cSDtqsrGAIaAGnYe1Eordrwcdi+BNz0/RJSHisyxu
 Bu6z5GxX9jFu7qaj6XXyXmEmsdsbLr8=
X-Authority-Analysis: v=2.4 cv=bar+w+PB c=1 sm=1 tr=0 ts=6af299d1 cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=khBgtfIvKfM5PKhOzWoA:9
 a=QEXdDO2ut3YA:10 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxNiBTYWx0ZWRfXxG4OW3ThUIuN
 /7BOvTVEpfFO2o0PCy5+VBxU1E+ohIvh41jbLxYQxBuVSwkbeHnTTqzXSd9V3EhBDE8sajkGFYC
 4Rvrq98r3xGRysf8vEIHkxGNFj0+uw3gC8dddEyPi1IYdXNGL+reC4K94edQNuHUCbi5yon8jN/
 HzLD02gNi2GVkDXb0lfoBf4SriunLQxGKRXi3eHp4CkDMTrMceOR0XzoT0oitITCk2whpXtlfmO
 FG/UUcXwUu+t0qIYQnQXjerxvn/ljBQYW/necnM5xuJq7yLm3wYPV/f/Y/OKINfsMOux/CXBrna
 WJmf8Wf7B/+vrxKrbKagauDGipoXL34GpXpxdQ4mq6gK5EAudAMVC6aaK0E30pQFecf4ltsemmv
 Z/2MN7aDjqz7T4mJA91brJ52j5FzZll6r6VLLWE1YzE4y0tY8InGyZXzcS40H5JlZyqAYA2HQ5T
 bSgZpQHxh8XAvzySTUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100016

On Thu, Oct 29, 2026 at 5:30=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
Yes, agree, will share the details in new version.

>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>
Yes, agree, will share the details in new version.

> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

pw-bot: cr

Regards,
Hongmei Xu
