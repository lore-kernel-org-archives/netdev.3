Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793378183;
	b=sYVH9h6Myewx0OPzb+xXyqahH5OTLzRUxO5KNrqfNuNNegCrlKqQlRV2PrPE6LUzvOyh
	 xw0Siz3HYSLEwfwjtndPTvKBD7NI634tyhHu6qcq0YABx5gytJxFfYSxa2ZnoXjX9EC8/
	 ZHAoje22Alm2nryz3AsqLaZtm0ikdIO1x0SdIrScm1JqQOLTpyoMn9vYuxxdPel2S+vMd
	 579P6vsWCmKXTzWkQDscBJGyUBIp7I7jiMEm2JSL7eBka2bZnmm/8npnPRFiqG9z5Ryu3
	 2F2u7TuscV5M2LEhMFRCWaUT43hx40MyrUSk6fovAxFc5oaXsk8UEge/2bO+eMH12YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793378183;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=+c/UpPQ8lIzjUQWEHV+QPehL75Pb7DAnccEvtSYWDtA=;
	b=qiKOCQj24C+1eO6e39zrbIOAx7fOp7rH6e7vyMjRttzX9o8bTgVwIBDrNXnYJpNWVASe
	 lNcOnAut9zAQtYW2HlmVfJ4bugPxWrSGMQjoN6xMF0GH9GqVdeYv/sk1gbYZrCTzT8e6t
	 pZhsEGxA7GvzAJ0F2JlC4zBaI+0HGF+9oA2fjVA+1q3ZtJz5VTzwKCLdgIDo/H7cosTcM
	 MObCjx9eq0h8uwCt86wDXdhMQtTgt/gqzB8526hVnp00hfW1l31Kt/3Zu1G9qDY0b9w4l
	 mj6lPGjXu1pPbqSZMV20o6bcDfzdp4hCIY0zd8+QxlSqeupYLhAct1n+mDdt09G/LWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VoVcooSa;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AIGvZVCI;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5660606A31C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 16:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5660606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VoVcooSa;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AIGvZVCI
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UF5ZX8434681
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 16:36:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+c/UpPQ8lIzjUQWEHV+QPehL75Pb7DAnccEvtSYWDtA=; b=VoVcooSauuH3ZIvW
	MnUUeS9nfb2YKp6TpMsm9xkqXgC3qodGf7c1XKf2dOQkSnl3abQUDb/eLakdNpSx
	v/LNQGxueAAco44eW50PKX8wN11U9cYnTF4Dlt2FTsN57sk/QW5DNZAIS20RYCDo
	xVu9dTCZv6Aue1eKeW3lwnSchlQZSfJbk00uhq4KdWUH6Inq49ijTeuVUEDihSD2
	bZciog2Kl1ddiXbU1c1w16o1xO3Vcim3r4OmdYUU1Y8KmohKtIIOUUaBQDmMWzf1
	o6vSEiyVJlnCB5ukn+Od29ULrBk3/74vPU9cGo9A3zSAQA2gA2Mb1T+2bZCQ7/HO
	s+0Inw==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6rm4qa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 16:36:21 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5eab0467c89so1180462e0c.2
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 09:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793378180; x=1793982980; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+c/UpPQ8lIzjUQWEHV+QPehL75Pb7DAnccEvtSYWDtA=;
        b=AIGvZVCI1KUtvZ7fgMso09itiLuAwNgs+jYoDYz1ak+H1KGZBBm/1rt5BAcM4aHG/k
         g+o30/gaUiibaGJhwSkH8xeDr2dXLYqpqGZBT912MPb+uCW8UUdErUl18YskOMsKG9VA
         BhsyMMXMw69EPgSIKThYGXIVchry2QrJKwCn8Y72xWizbq6fJMxgeLLHmk4zvq9rsoKC
         sJGBgMc8hRhTZkNIWNk+SUXXgrsIBD0W6JkG6357wCDBZatVH7sM8DkdP4+D3IIjNt1n
         iClZAYwoAUe+rZnMNNFG02yDROfCtBFYQkHqs7ZW2qjzGi2jeDUVUa5s4k9uZ4WDV5RU
         +gkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793378180; x=1793982980;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+c/UpPQ8lIzjUQWEHV+QPehL75Pb7DAnccEvtSYWDtA=;
        b=K0Lz5PFVAeiHr8xckvyENSlQAW7lRPN2cSfyemK8h6FmKVJj5wkenDDaUCxGeHnUe2
         +QPWJYrMFMzE6O59/7wU3qxceHFk9ZgYnGtfQFPd0OGecMQfhlaxNDD2+ZNOCnSuODC0
         wiEU7uJ0DN9QHarW7oJjqdpOd6IrLZY/D2kfWKNISFeYzhsk54FxYwZmf88zNpZ25eE0
         DbztkS9Vr4XVnX71hHo1QD41ie4jAMmQl7sYyGYZzqyZi+TDqma/ZNuuSf5GJ4Ev91Os
         zkouLQwQ++AkQxOes96pi7GQsBchDVs9SFwvhbqJl3YSKMuSxCuZ8xvFU1AVXXuJxlbq
         PnPg==
X-Forwarded-Encrypted: i=1; AKwUvBwDholAq3Pu8W8T9CHYXuF8lrS5AobAfyMeQshKLoKmVJMDisA7OySR6NnLv/qR6xyAAf1pNM0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLCDyfXCjO628AbfizkqAAOOgtM5RWawzoj7O3K7ypLC0d8iiNk
	kgcS1kV1mOiLgEItQ/U5z/mm3XK6vbZOms49cZ24Fh7IfJIjq6TtAb8v8wTLd1zysRqxhfzgObL
	1QQZdd5INl9fqwiboPVM38yFjxK7SoEI8Atgor7JkGaRKpFk6SL7b9GVbQJvkTwHdVDpUog==
X-Gm-Gg: AYBFou0JMvNAmZJK3+ZOWJlac3zPm6AGeX5ZJ90tXEksQ1Xp/z0NHagoKMyt5Z1TWLS
	S4l41shRekhReKB7gm98AmP2EWEre4zMw0e6D1q/4ZJQPiH5x9qQJm+6zCEwgpFmyqE+zBqwJxO
	AlTk0O4aQMXVl0V8e+lKpAdOfXdobO+URLDHWlx03mojdQO5OSJjYLU9pwStTzntjlB2o7pZWG3
	vMofQ6iEjZtAgLUu8ruBPVL4y8zTiFCLJrpwbvucNuYy3Y5pDbubp40hItFqrkqRMf4Am3Pybrd
	ZGDkJTism0LEYWZu7sd8NK4OQeCtrFJ64FPXFwsOSmlLTE1aTUlZj1Z288N95y0TaTC7H9mC5uV
	KZrrijfo1YZ9gG6um9YGLahWi5zgoceHDU0/Q0mPSKu03sF84t/lSo5ctakPGaYWwMYJtlf7BK0
	SfP4hM1fwwQYgZlwbws+UGfXo=
X-Received: by 2002:a05:6122:398b:b0:5ea:e052:2ef0 with SMTP id 71dfb90a1353d-5ec68976f9emr1574311e0c.9.1793378180589;
        Fri, 30 Oct 2026 09:36:20 -0700 (PDT)
X-Received: by 2002:a05:6820:1612:b0:6fa:ddda:4234 with SMTP id 006d021491bc7-714f24b9ba5mr1696887eaf.1.1793378168856;
        Fri, 30 Oct 2026 09:36:08 -0700 (PDT)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f30600f0sm2249728eaf.12.2026.10.30.09.36.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 09:36:08 -0700 (PDT)
Message-ID: <3f9982c9-6ec9-49b8-ba17-f7fe2616aa73@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 10:36:06 -0600
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
Subject: Re: [PATCH v2 0/3] Extend drm_ras for qaic telemetry
To: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
        dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
        riana.tauro@intel.com, aravind.iddamsetty@linux.intel.com,
        rodrigo.vivi@intel.com, raag.jadav@intel.com, simona.vetter@ffwll.ch,
        airlied@gmail.com, kuba@kernel.org, ogabbay@kernel.org,
        lizhi.hou@amd.com, karol.wachowski@linux.intel.com
Cc: carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com,
        youssef.abdulrahman@oss.qualcomm.com
References: <20261029203000.1763447-1-zachary.mckevitt@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20261029203000.1763447-1-zachary.mckevitt@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: rhDORGHvcScvYH8QIVUZMAJ375z2-enD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2NiBTYWx0ZWRfX0y4NDxoFndzV
 Lr6sQrkX9fKTeNow5rrJradrpaXR7Ao/0VkAjv9yvzJ0h0WQZjKd7QQW6iPfQA/R8CNoIkEiqEl
 m52PQyhICJl/8Xv5gYcatAPdG6TcjaI=
X-Authority-Analysis: v=2.4 cv=PIqaavqC c=1 sm=1 tr=0 ts=6ae4c785 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=Dd6cMgYstlSlERSeLNcA:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2NiBTYWx0ZWRfXxyfks/OVR0r7
 /VBbij0Ecy7ihQUPlh8Jwc0vDFvrK+4EWwIs+8WPgRDcv7/8b68qoKTuP186lFAzF5gjRZHZNEy
 QWa8Qeow+X01GV90C7Fe3Lr8R2FDfojG5Ifpi/o/l0+5MH/Y0+wK27QS+RDqwsr/uoefAytsrKW
 x8GwHz5zPxgToYOgTCSRKwKmqzFzcXOpZh9YHcv0v1FpYLt+7vUg09XJ/DRAnUOuihla5Jl867R
 McNxAVykO5eQJgFmQ2LFlpyXKdmm8pFglmwUHmP5V9R0gOnaao5B+d45VqKcHUvc9HMn+CDmovb
 inp/m9wNsCPcow2eY/A4GFtIlIm66m+zWQz9sdqwKEpIqCzPpmyAmgFBvq8MweVRTH4foWXgGbS
 Qup57yc5ATDLYv3LMDmzTTP1yqYqvXa/cg4krHbWhshJvgIGXjJIuyEFctIQmgcSwboYonf60UN
 GJyxX4y6my28z7AKxVQ==
X-Proofpoint-GUID: rhDORGHvcScvYH8QIVUZMAJ375z2-enD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300066

On 10/29/2026 2:29 PM, Zack McKevitt wrote:
> This patch series extends the drm_ras netlink interface to include a new
> node type for telemetry nodes. Telemetry nodes support two operations,
> getting and setting, and drivers may specify an optional predoit function
> to validate each operation.
> 
> Telemetry get operations take the drm_ras node id and telemetry field to
> be read and return the field's value and any status reported by the driver.
> Telemetry set operations take the node id, telemetry field, and value,
> and return only the status reported by the driver.
> 
> This extension removes the admin requirement on the list-nodes operation.
> This allows drm_ras nodes to be discovered by userspace programs for
> drivers that do not necessarily require admin privileges, like qaic.
> 
> The new drm_ras telemetry interface is implemented by the qaic driver,
> which exposes the telemetry fields to userspace and enforces filesystem-
> esque permission checks on telemetry operations in its telemetry_pre
> callback.

Rodrigo,

We are not quite to merging this yet I think, but thinking forward since 
things seem to be moving in a positive direction I don't see a drm_ras 
entry in maintainers.  I seem to recall that initially going through an 
Intel tree, but I'm guessing that it should be ok for me to take this 
series via drm-misc-next.  Hopefully that is ok with you.


