Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF344E4331
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789660801; cv=none; b=GjGiWovA4Hw+8yMH79NRssyuNDpVtE9geIcc0fUz6iMcNA+8sZAOXZf8gTGTZvnRBVXRXNwszcJuksSCaN8xCK0IiM6bQRGT3M7r3ZzOo6fXrw8Wz07CFdRHsIbvI4ll38F0E5QCN6bQlk9KDLYUJ4gNLxp/7s/QiKDR4b3Fi68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789660801; c=relaxed/simple;
	bh=tLgpMuWrxTdgXlfCAJ5LB4GG/gQYXb67tbrzvgKcf4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bonSYPU/FRRjDVQ26rzYb3oh5O5CRo2tsQI2fhH14/rBotJcFMEZPHwQevFyhC6yA5v4r6VSG0B/LO0FkUVkXZb+EHhTTGSaJOdgRhDI/YC3qyeYIT+Kyv4Ldvri8TZ7u7kqGVOXEpwOVEcku3BmH6cCMEy2gmn4Tf7972P1shI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dSLvNvIv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Md0iuP7x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dSLvNvIv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Md0iuP7x"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HF9n9j2024427
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=x5j5s4nhgiam0hCBqrzwVhfK
	OSCVilYXlPifgN6u1u0=; b=dSLvNvIvtkEatE5f4mYWs/QhOF7wzzHzrTMINGF+
	AVKikYcx0OD88td9JSldjKXhoW7Vs0qRPYgtxT3KquVGkZp9/gppAt3Un+7ZRGYh
	mQe7qztcQKuXS+tx4y8D7QUxmscr+TiZSTt7dArM7gZ43WZLFs2AepAPsZdlyRbJ
	eWquYluM0p9VH29lnmQzff13G0pwV0bZxskajQFoPSs8wvC1RLTcqrM9NV5xWH3l
	R09SvhvsLgvIy3qNg0NW6P6zV0r3FW2zwhpnh7pOt/irmqTW7ecvFE8KDh/auChW
	PeT/kFTisxHW/BlvwnRx6a33qBo+jtZTKqEjdi6tH7R0tQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grjkt07ba-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:59:58 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2dd188e16a2so13568965ad.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 08:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789660797; x=1790265597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x5j5s4nhgiam0hCBqrzwVhfKOSCVilYXlPifgN6u1u0=;
        b=Md0iuP7xj6BLRr+Z5b8pEsoUHoZCNP0PCIAnMqSvEVSSF4ESP8gpUe0P8rQOyeZJT/
         EQaEIQB/uWDCSWP3CBGXvqPNZ8AAMpwP5HDec/R9kRwhvdnwZYfO26o/9vEh4vKmJ9i7
         h48SDrbXty2zhK6+r8cYIYo5UXGKLuwB1y7uxR6pouoYRwSDDa2bnzsl5KtYwcRgn+BN
         YCFu70MrPQYXDYqzE3Hd4Hf2P5jfeLIt797ETsxqH5jbeaexY97oHX26sYv/CDRbGc8R
         PudcHTXo4pyNRvcymOptyViO2gd5FsuSdfBpeOUtIhB0cjuJxmGWVF6yAfiL4GK5xzXY
         8+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789660797; x=1790265597;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x5j5s4nhgiam0hCBqrzwVhfKOSCVilYXlPifgN6u1u0=;
        b=bCPPCvcIosbBc91DQVAzeTSy9+m/IsdZQFIAj+Aqkrqgz+GqK42cWW49/wrAPgzlzW
         NJH3PjxEMe8xi3sLsYifTm0xSh7j6CduYykxPf7Fzu+Rm8IKwagWcMILvBZHAAsrH5YX
         /exRDE/MjN3Dja38s8G31ekQ9/2trMU/8hQfglt/347lxO54YRlqybbKkCPHacYodYqv
         MwWR4Wn1eoqqDw2+NdcQkA9fW4Vr+e+1rOfYHTCWj0B9Q2e1JJ2oV0otiZen22i6wM+K
         c6Jcjjh08FxTXNRtR14W7rPVxdIl3KUN/3iP8MWW/TJ1NzqYK9tvxAz43DTTa/U0bgcs
         Io4A==
X-Forwarded-Encrypted: i=1; AKwUvBxkE1+kyvxzgS99BwWNDtI432G3sETBd60gNbj65OSaAD/MpiNv2U7G3fgJ8KmLvF9QTZoKZ6g=@vger.kernel.org
X-Gm-Message-State: AFuF++kdgRwvJxLzGuE2capKmKlpeaI7EVGIOzCrcfBZg6e0N+00l2pm
	zxaiwyvThJiO3XbhMMYphlO7CmR/Mrout+4vlUEZwzDW7ZwaB9XXWBeLZd1k4J/1j315utDBvDT
	I9vpCAALY7f94lXl4SWs8gehb5qM0L9mZAXObly3wAyCfHZb3UEYq7dAkoQI=
X-Gm-Gg: AYBFou3x6oybQz58aFXrl6WdpU/ByF1Nmz/QcA2xAF4HoAZONv+injArCCc7ZIfyqA6
	ARr5O6Dy4CPkw/qjqXsACwKolEH11UGA4ouzhYB2XhY5d9OhuTAQxaWSe0KDJ/reUsbEbdGVIeZ
	og7xYiYV8dh1n/uPAgr/i8YeO+mgbKGqeeq3qqrV6fuV3Db9um/1fWmMIChJ9xjesLd479BnN6s
	NTEk9k4Ha158pgZQQuN+72sy7iBmM+tNhgZaLPHpC4sS8Qp9E/wkMvBrHq1/3gOw/kacheoSnMS
	irlGK1/18iPUeGpkKJNUQ4GCoJbAtO4sfb9WM6NdY3vbmP8PBsInpOimkv77Su5NRDU3lQZ92cJ
	E3HrG0Q7oUcVcrw==
X-Received: by 2002:a17:902:ce81:b0:2db:479a:5127 with SMTP id d9443c01a7336-2dd8e632d7bmr152292765ad.19.1789660797174;
        Thu, 17 Sep 2026 08:59:57 -0700 (PDT)
X-Received: by 2002:a17:902:ce81:b0:2db:479a:5127 with SMTP id d9443c01a7336-2dd8e632d7bmr152292465ad.19.1789660796619;
        Thu, 17 Sep 2026 08:59:56 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f244c9sm29158325ad.76.2026.09.17.08.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 08:59:56 -0700 (PDT)
Date: Thu, 17 Sep 2026 21:29:49 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Thomas Karpiniec <tom.karpiniec@outlook.com>,
        Coia Prant <coiaprant@gmail.com>, netdev@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Choong Yong Liang <yong.liang.choong@linux.intel.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: stmmac: qcom-ethqos: advertise supported
 SerDes interfaces
Message-ID: <aqwOdSqxHDscsbIN@oss.qualcomm.com>
References: <CH3PR11MB8413FCBA598F7FABC04ADCFEE4B92@CH3PR11MB8413.namprd11.prod.outlook.com>
 <CH3PR11MB841353E5708DDD7C5E2EA1D5E4B92@CH3PR11MB8413.namprd11.prod.outlook.com>
 <aqqI9wOnradk9d7K@oss.qualcomm.com>
 <97924d2f-45f9-44d5-b482-97fcbb70abdc@bootlin.com>
 <CH3PR11MB8413131D50175690DF9FDAB0E4B82@CH3PR11MB8413.namprd11.prod.outlook.com>
 <3bdf2ecc-9dd1-428c-8841-36b1f19916e7@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bdf2ecc-9dd1-428c-8841-36b1f19916e7@bootlin.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDIyNyBTYWx0ZWRfX+98jA/ePMqXc
 X/5kpq+uH3k4cLsQgqE9Y/58Wzmhx/L8oxK8IQYntMkooKfeCZsyDqH4NqPPqj5bPZPeTv2bp9Y
 J5W9TlpD0WkqTxaB1QFXcsv+knsSVUtYHWi1RWr0ndUQhWTRo+F1PdEI/P9G7emgsj+padHBoBN
 57U3RWl2DN6pwtwiWO7A099SBn/PWXuWnXWTvcFQzmWEUTE4tUUemxGJ/aQEcOvLnI+bmOJqVXN
 21/bv5y6jdHnu3NY3qseTxE1SUgiQ1J3FWhPtx2K+eqOKq0yg6hJczHj+LVGdHpKKOmALXNzV0Z
 ONKocf6lYK4yL6z4Lg2qT80MV1CMFeJH0RyHThvVn6ZGtDI8l1ooZ/kYQGXyGSwonEC3yTFB6jU
 T0w3wSw8GgsrH6DDIPoikAw8oo0Q8vSDqpXBt0z6KZhERhY8wptgp/Xmy7CRJe8aN0DEVwfZrMv
 yagA/JX8Orv+wtmFtUg==
X-Proofpoint-GUID: iWO_eWzzA4ymsFs9JixxLL4bRzV4kpwi
X-Proofpoint-ORIG-GUID: iWO_eWzzA4ymsFs9JixxLL4bRzV4kpwi
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDIyNyBTYWx0ZWRfXxVN/6dk6LqFx
 UktCc7uc//foYWmNe5Cf3wq7HxtvWo/MkEhcEcz4voPXZT8P2O1rZilSc5pZGK9QjffJzINadLx
 Tc1Ur7Pk4HYJTR2ZBbqyRa6gb0HcENI=
X-Authority-Analysis: v=2.4 cv=Y/VtIReN c=1 sm=1 tr=0 ts=6aac0e7e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=aHOOhSd_e6fbb9z57_EA:9 a=CjuIK1q_8ugA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170227

On Thu, Sep 17, 2026 at 07:36:42AM +0200, Maxime Chevallier wrote:
> On 9/17/26 06:29, Thomas Karpiniec wrote:
> > This POC did show that STMMAC_FLAG_SERDES_SUPPORTS_2500M enabled phylink to configure the integrated PCS for 2500BASE-X and a 2.5 Gbps link came up with no apparent issues.
> 
> Maybe the blind spot is inband aneg. Mohd, you were quite involved in
> this, do you remember where we stand on that front ?
> 

That sounds about right. Let me go through the older emails and the logs
I had captured at the time to jog my memory.

Thomas, it would be useful to know if switching between 1G and 2.5G
causes any PCS instability. I remember that particular test case causing
a lot of SerDes link flapping.

Note that I was testing the QCS9100 board which has the AQR115C PHY (and
due to its rate matching capabilities, phylink presents all speeds by
default, unlike QCA8081).

In parallel, I will try to test out boards with both of these PHYs as
well.

	Ayaan
