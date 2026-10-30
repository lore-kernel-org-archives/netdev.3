Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793378234;
	b=M6WdRqbn4o73Qdh4Dydcr6UCV+w0GcS3i+Cl/EwJ4vAFvey2hqA9U8tcoEtLfom2+Q/r
	 YqoeOEvDTk1XEzQhKa4/Fjld6tzvceEh3cA/FinNKMCIJ8cOOVlYIQ3NXeQpRq98jfuiJ
	 fVt/cg1nXI/bTHwsSv+lopDTNQ702z57AOoQD5XeuFKikg6rtbN8v83Q6sKsWkDq0FmRb
	 0dGe6FPQAdDYohzTK5b3kW2vQNYMW0EhIthfDJcYrzBBAee14YwrWV9f5nk8gC5zM+tRn
	 RV64NrbaFuuz2+Os6FAdtkDc8QtCV+hxbDLjWCgdgLlbvXQnnixqnjjTmksOAiD7RFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793378234;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=CjbJSOWFP4xYzP7X1bUN4tGaG64TBbEqFOZGqIKWWHs=;
	b=T2N98eKPYwc43M5D2FGSDJzfqSkrfSPOarJaxFYktd5bpBQT1jZO8FFsZmIUy6jW7Bp7
	 IDGnVBWJpvdy9oJVxfy+zhx9NXDx8jiBLwWuCqfWNCRmjxg2TRKEhYPbG+RZ4HyvsjkHE
	 +hLr5GPQ6wRXK2JR3Ktxe7e0HUlewOc0txbBFyt7Rxmr3ltfCEwBmEy0Oa1AgKbwNKoer
	 G0iH2ApNu1hqfYHfDE+IhYIBLKZnIbvX/opzSxSnYN5GPiWjuKu8Y40t0IQCKiDRmbKYF
	 J1fzMWBcNH/R5zdOJ7rlpBOULyJR/SpeLcFqH1BYxxTMLhBhU+BWdtIc7oI6jnppNsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="nYAGL/yJ";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h5AhCWyV;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4B6606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 16:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D4B6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nYAGL/yJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h5AhCWyV
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UERC6v4141517
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 16:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CjbJSOWFP4xYzP7X1bUN4tGaG64TBbEqFOZGqIKWWHs=; b=nYAGL/yJntypMrfh
	f5q04ZCHq8xC4PQJ5c4omUG3V0lfmXzMwQ4NPAXypGk27zULzQnz9pysSzJ+1h/5
	xrUIxUhrLjy2wyMM34RhybRi1FHmjZOxQN8xKtgl3luCRBkzgBGqg63Jsvf6iG+n
	Tsh5dmutYXpnYQ5QLCg/dTnTFFYz5yL0ZdkDLNWP2FWiOWfWxJJikUOQyKH7AjAz
	9NyVdSaT2fbPqiZUmdvf/GCX+RryMzFbguv20BOtHRVCJTd2seJnu1imSD/Ouk+g
	1hWxjy63mHwhBTTA3zEFXjWarSSYuocJM+PClpM5+B6Rk4QfXMfoBNgksIwy8F5F
	dlMdTQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6quyvy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 16:37:12 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7cc1bb97ff8so198371137.2
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 09:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793378232; x=1793983032; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CjbJSOWFP4xYzP7X1bUN4tGaG64TBbEqFOZGqIKWWHs=;
        b=h5AhCWyVXwiVidkVijUQhxqZ9CMdlsF4UW1Ne2MtQ1e4pApH/5rAcOGz0NVj8z3U4/
         b7MbPRsEK8/a2M74GxecDnhggXtE/lx/e2+mRBczlXo8ydKVQTlAo23dndeo+g1Tqtii
         ZZY5S7pmLQ5cpfzD5xvz3w8skf/VJAMti39HmA4ZfZh94l3TnfFAlCyyShTlQ7B5JXVq
         iA9ffpL/4ScDb+y3LD8lCeptbydcdki1+or5i3WQn998rFbkOnAHN8f9qvL8GZVPdx3f
         w946N4slIpxxxdXqr96HDrXc9sywVpP6Ug4gltTdoCB9zTC5Wp+EaoBZ/H4jmOSch6m5
         T1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793378232; x=1793983032;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CjbJSOWFP4xYzP7X1bUN4tGaG64TBbEqFOZGqIKWWHs=;
        b=SThyx3mgtis+3EftwNHYcspdHI6IzYnXTyY4geYL3JVCowN/Wsdza2BGW0Hy/Bq3hF
         AOzPOtjYOgQuaRUm2mrFyOa0eyW2KcM+xP6xHxFRB8AfTCEzUoN4F5XVBkTYgogY1Anz
         NuJ5ChGmu9fC3IRyXbzcT3vbxN8BdShGA7LABN0BuGKVeZ1FpaeWGG5ho2zAtdaiRIP9
         hERGVTIKd58y4FR0kCZwYCmXiGDtBlfDe88DkO/ZopZno2rEMw6HewDtsjsVUB1WssVe
         XyhJUe1XxQsVWCT4jSp7PKr6Fcavs83xDkfOHvPQsyFB+Yla3x3/pxvZyBlBOmJwuJdD
         MsuQ==
X-Forwarded-Encrypted: i=1; AKwUvBzj8wnEqSQarIbHvAe/P0YzAitD6SJFj09KGBJmy2fRl+3aj7/QN82QcN4Du70FHwjJOfqN78A=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZb5ZqnIQjeMx/1XUYP8EvhqKF6BaKjG+ehCgm+Dku3I2z5IOy
	+BthhUMS4TCLNRB30CxjGoxKYiTujc8b+j0Ka70N4pVOtc/ZK1bx8A8SRBzW72xA7GGjZauy/6g
	Xqjf2YqkmPSk87DCNBTttOTzgENY0i7cDsTNZBhuJfkg6TyWfel5jVR3UvNw=
X-Gm-Gg: AYBFou1QwhuM4LhMXwpXofZnNKWYQBvBj0DyPwymZykCLvPxv4bfARy9jisj3GpVkyT
	0aRJfulXtQeWpJeHedgcopjF6z7G6XIzlJfDXAH9brxOmfb8QyQbXdklyJYeKlaNHDqJrSZKPP4
	9YdSaWEZ3hIplOhOyF8EcJ4oFadS/ZAVFoVMH0/C7cM1A8Z70mlSCrZNP8wBHwF08ChlvuHXfUs
	H+38qWq35n1ed7myTgO7o/DbrvkgQtVPNyvXB3HzXHzTvQL7rBplltuig/8KfEHOsHMiGzQVIMY
	zcqvFRLKZLFKqfVDuDccgdW8bmCHkblhIEMYM3eyGCHMqxNd1p0Bd+y+RKtuEDFaHIiXhhuMhUg
	emlUV7IN4pp1J+lmu82oBWpK7fulJXkYBwZZPUwuq6IeMY9UtUW8VWYHl1rfY14V/uBLalPVJDe
	Z6CPQSNef5jv/kLJ4FFDUrQqU=
X-Received: by 2002:a05:6102:50a5:b0:7cc:25bc:3b20 with SMTP id ada2fe7eead31-7d072bb35d2mr1346713137.7.1793378231578;
        Fri, 30 Oct 2026 09:37:11 -0700 (PDT)
X-Received: by 2002:a05:6102:50a5:b0:7cc:25bc:3b20 with SMTP id ada2fe7eead31-7d072bb35d2mr1346703137.7.1793378231149;
        Fri, 30 Oct 2026 09:37:11 -0700 (PDT)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-992ee4e7453sm3074546241.11.2026.10.30.09.37.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 09:37:10 -0700 (PDT)
Message-ID: <722539b2-829a-43af-897a-c2524cc28fdb@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 10:37:08 -0600
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
Subject: Re: [PATCH v2 1/3] drm/drm_ras: Remove admin-perm flag from
 list-nodes operation
To: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
        dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
        riana.tauro@intel.com, aravind.iddamsetty@linux.intel.com,
        rodrigo.vivi@intel.com, raag.jadav@intel.com, simona.vetter@ffwll.ch,
        airlied@gmail.com, kuba@kernel.org, ogabbay@kernel.org,
        lizhi.hou@amd.com, karol.wachowski@linux.intel.com
Cc: carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com,
        youssef.abdulrahman@oss.qualcomm.com
References: <20261029203000.1763447-1-zachary.mckevitt@oss.qualcomm.com>
 <20261029203000.1763447-2-zachary.mckevitt@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20261029203000.1763447-2-zachary.mckevitt@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: soCatPbljxjtzGbeOaRTuDDuivs4mKG2
X-Proofpoint-ORIG-GUID: soCatPbljxjtzGbeOaRTuDDuivs4mKG2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2NiBTYWx0ZWRfX43ExsHu9l3kR
 uGxJqA23E9r1j6LK2YN4JTS/BUaqNR9mONWyHnnybt+0jTfwwzFZ9RPWc3VYLeF6AbbXC+tqObn
 ztSKeyFeJWTD8i2HtUuyuJizalKFKYPYLKQ75yeDgakfTuUNLkRuXYgcS6PtlALffuVUje3lQMg
 8FgvOx3ymyo97W2rf1dUmaCCnigBsTL2keH1PwM1ZTd97XWrJvqHqbDmPV2zHN3tVG4Yhcl5+HD
 LEpe2A/f16eb53tdIcEeilSw86WQAwRgqbQY9ev5vSfyEKkiWkHQDuV6Qf4qRWls+jAWa/k5v3V
 3D2PiP8FRtzJjbAzg2pyziKTEof8W/jj7ie8ZXm2kkckERM0Eg8U56v5FWA8OorYiBGfajr0YBb
 0qMlXr4XPZUikgXfDa2WTQ2p1oAkcPYv2BrDdQQbGmvoUS4+o4vxH/ERumzagIFhAaVSUTnycH2
 Q6AWYqVdRPH1NT0cWkA==
X-Authority-Analysis: v=2.4 cv=dPgzC+Zb c=1 sm=1 tr=0 ts=6ae4c7b8 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=rKidIdNGGuosbOtXPGgA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2NiBTYWx0ZWRfX3uwl6GU5zfZl
 dytPh0qLdYZw32ZaepITA1G2oSAnIclnj5j/8BaBn82MrhdLyBqz3T32zCM2RNxevCrXqMUJmm+
 nF24Nb3HFaPJfeju1Tmchl+jSfwU14w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300066

On 10/29/2026 2:29 PM, Zack McKevitt wrote:
> Drivers may want to avoid requiring CAP_NET_ADMIN for subsequent
> drm-ras operations. However, userspace must still be able to access
> the list of RAS nodes to determine the node IDs. So, drop the
> CAP_NET_ADMIN requirement for dumping RAS nodes so that drivers
> with different permission requirements are still able to use the
> interface.
> 
> Additionally, initialize the return value to zero in
> drm_ras_nl_list_nodes_dumpit to avoid leaking uninitialized kernel
> memory (especailly now that this function no longer requires admin
> permissions).
> 
> This prepares the interface to be used for telemetry by the qaic
> driver.
> 
> Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Signed-off-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
