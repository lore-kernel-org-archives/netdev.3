Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0D039D6DD
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 18:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790966425; cv=none; b=tUptxRVcO38BL7EBA+2tvw9QPGJCEJtbFJkHDsUsRJEOVmEXCESFcuPkwQ6d2mFPegSHWlAfoqp23fe3J0cPPFkay5T1czC+qxAosx84xsaTswmwPcJvrAw5y+90ZU5DM4+5sX2odlqkLWmYi0gFxizuf6Roz8BtYi9Bb09Hjrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790966425; c=relaxed/simple;
	bh=B4QCi8SM1E6HBMBo4DshVMCnb6Z/I0iVnzwIIrgKkHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jzYR6y1U8sWNnLWkEcZwMFOI2Ne2A0tzpM5cdMKk3P+rIPcFgpoVDnJvtX57MWrwjFFCEXNryK+zhNKAwgRP8bvsAKvHIzDG55ew/f/uDkOk4WuSODcPo9wvWrOTmT6TTVkKwrE3YptAnXxegiQ/7Fv1bmyuIce6s0JJc/gQzxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pcEZEJ2s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hHMuiGXF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pcEZEJ2s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hHMuiGXF"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692H6ZM02357676
	for <netdev@vger.kernel.org>; Fri, 2 Oct 2026 18:40:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B4QCi8SM1E6HBMBo4DshVMCnb6Z/I0iVnzwIIrgKkHQ=; b=pcEZEJ2sS9XR/64T
	1gmJDPOBtXhzhujZYM+wZI8eoM9W7Y7KijDKiCanKNgI8flWiL1u1y9971QMhXgE
	Vm51JcX6b6wWXmVsmweoP4+f9UWAQqDwN3TQQ8RZC0GI7JdbrYFiAGerUFo4BMNu
	W5oAkn4Wp8+fD77+d93QWE4k0LvEZdhw6Q0tKuVrtBi68JTVGYt0jdk0GhyaXz36
	Kvi7LbFiLDpocsAaPpQQj0q/fp985ol2y4YVi7+2T8XVpAhPafqnDEsZPTevgfOv
	v245w7rNPDXpa3y72ifOEetTU+UiRXzJkGWlkjrnzTB6lkr6tgMT9UUGb2oDFObP
	bi62iw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h20sh3ry3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 18:40:22 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1438719cc1eso9452123c88.0
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 11:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790966422; x=1791571222; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B4QCi8SM1E6HBMBo4DshVMCnb6Z/I0iVnzwIIrgKkHQ=;
        b=hHMuiGXFGBdBk8ZmUWO2NORZC6+JSv8L1J7MZX0YbahBgQ7N/ONNhKe/SuwfnWD4Vj
         k8kY3Q3b5EB68ukir2eevQzjJas4a7Dd7rutwvIgLK9RoIPZYgLStl5iMIoB9RVAwPDR
         H5QMGcy8e3uWPd+JDHYZPL61+iIzPymyfyoRswpDN5YrSzckqUPZ9wdK58MoocxnC7Nu
         xUu341NpK9oybuJ8zGIXuEVc+0axVZPzW4zakfoThlqBmevXX0G9SaZUWB070/Bb9mX2
         kFp0rowXo71iN7nv9vbnzz+C3ISB4sPM9aCkdKfKwkowEDivb4uFluRWone7a3R/61FT
         dEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790966422; x=1791571222;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B4QCi8SM1E6HBMBo4DshVMCnb6Z/I0iVnzwIIrgKkHQ=;
        b=mTxAcFrrXac6YF+KIFqbE8Ib5c1C5vfd2g1beunbgeGXCV/yf/7TgkSzV0I2kGw4A2
         eR6A/NkNkwGlDIKD7QiJqL86r9TA6Lnuv3nE4eK9Ww0xaTL/KoXgaS5oOJk5YDKGrtyC
         c/LffCwuLv0tE5ZtXvYJuX4O0NJRIai9OT+we5Y1OOXbGI8k1rk/azBnAeTwIvjmWR1Q
         ZfGkYrBOGIDRjoGVUeeTc7/IWu4DP+2cJ4xiHd00Co3lMfsc/1txJ9kUC/73Y33au9y+
         1NBuQUS7hRaXQv8XT8dVQSBcFw3gIyWQGVtWegTBwC8rpOfY9mKtH8dX9/KMejr5pO9h
         Xwxw==
X-Forwarded-Encrypted: i=1; AKwUvBwq4g8QQD08eBNwJdycspbsRh1xXGgG37BmQvV/DCFMKlWk5RogrWFtwLTX4B0xDj/6aXqMf6I=@vger.kernel.org
X-Gm-Message-State: AFuF++mYxdsay2CQFPCKIdrcW43ejuTpsZr8cFN5T5zzVhasNlfBzPjR
	/dtZnxn1+3ceMrnxhgHo2uvkLBkweX3hzL566i/xA0uTUjkvvcRYmfwrObSyOya/3vDx9p4OQMC
	3B/a6F/U8mgDrjaLbHixupxwAOvkZHAvNHJSm/kDp0urJAmoYH03frzLfM8w=
X-Gm-Gg: AYBFou3RH7QP2sBqH323MDVyFR4EyHHnunQQH0xyIdJjoqLq/m5lCDMx4hgtqQaWRz3
	fTYMYHA6AaSd2iLRnpJEknMTIsDSOxqWPzVMIIddoMuSBAOt/eZkEuRD94minhrwGicZ6X3lSkA
	wXIIfyGEhNTpPAqf8Gcoobny178RDRPGq1B69vbtsuxhDoQKyLdwgC+wiHdJvUFsfTvBvS7rqz/
	IZysjtOSKKqpawjsxsfoPN+Mp1h2iKy714W3JAp11lKoSb+OzZH2toOoRiQG13Ty8tED0bhzjFo
	ctGBrTSQVeVB47UD4R2tg2DkSDGLyMkHs1ntmqX/HAawzWKmPi6iTCi6XqnWG7wIgbjhefNRRRR
	BQl3DCDwI0/u+HHcHFlLsfYToZAJjA6O9Z6tqeRUuyVRBW5DVvfjVOwKpW8tUGxwA
X-Received: by 2002:a05:701b:458e:20b0:147:5149:d12d with SMTP id a92af1059eb24-151c32d9a9fmr334590c88.18.1790966421513;
        Fri, 02 Oct 2026 11:40:21 -0700 (PDT)
X-Received: by 2002:a05:701b:458e:20b0:147:5149:d12d with SMTP id a92af1059eb24-151c32d9a9fmr334554c88.18.1790966420900;
        Fri, 02 Oct 2026 11:40:20 -0700 (PDT)
Received: from [10.71.40.138] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f46da52aesm6468818c88.10.2026.10.02.11.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 11:40:20 -0700 (PDT)
Message-ID: <1d814431-c01d-4730-ac22-c41f47f93b0e@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 11:40:19 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/3] net/stmmac/dwxgmac: Extend MTL/DMA
 support to 16 queues
To: Jakub Raczynski <j.raczynski@samsung.com>, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
        k.domagalski@samsung.com, k.tegowski@samsung.com,
        cs0617.lee@samsung.com,
        Abhishek Chauhan <abhishek.chauhan@oss.qualcomm.com>
References: <20260601162537.553512-1-j.raczynski@samsung.com>
 <CGME20260601162618eucas1p14be36902c4948647448160da08aaebc5@eucas1p1.samsung.com>
 <20260601162537.553512-3-j.raczynski@samsung.com>
Content-Language: en-US
From: Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
In-Reply-To: <20260601162537.553512-3-j.raczynski@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA3NCBTYWx0ZWRfX49yJaZuzOUTR
 r0dXD8AyYj1dpyuhyRo8ywSNV2PrroA5iEwseWcUi1WnNO6HM4+FReQAf1oIoKU7D75dYzOv6Mp
 e2aPt7SJndwn9x+/Mrnge4KZ5GPNVCE=
X-Authority-Analysis: v=2.4 cv=IpmL47/g c=1 sm=1 tr=0 ts=6abffa96 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=o24aB88WmS8rWKrxVysA:9 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA3NCBTYWx0ZWRfX8/NXLcTug693
 fSum9hp9bhGwYQqOBCcJSknxL3F1O6KKoMZLUc31i65BmS8Y23AbJ8ehRRFH6k3wvJyyTEAKcIS
 ElVH1FfsK51OYaqzpxh9u0XS+wMdflKazb4pXYlM4Zc+QNYQ1PMGoImL5/D1dP5XKZvA4oB6yFi
 V1ZleA9F+LzYP4N+BiYaXMaXpOKssqnnhET7huxpv3NkDy0+gnehXqYpEimbXhXBktXNKCaX4qR
 jFhVj7PZ8geetcZnhLEzYjs/6EH0kEgLBC28FTqzRTuFdb3xDBm0BafjlAp7ziH4ASPR8aukaQf
 qJgUycYFqUdhSuLOYp8gQKvHFoqg91mjx68jVHeSLJksT89yMR+eZosQKWIJup32ryueOPzk81r
 BKbF/v6bkFuZ/iGIjoKWj7nXICJuK+lVx21rLE3mDUv6xVfwkj0o44MjuC2KcErOA9vE72tYb/L
 NUUX8e1OjxyBHIM+A6w==
X-Proofpoint-GUID: pQJu-t-8RJIV2ofupEu4QDFGulmGfPrM
X-Proofpoint-ORIG-GUID: pQJu-t-8RJIV2ofupEu4QDFGulmGfPrM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_05,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020074


On 6/1/2026 9:25 AM, Jakub Raczynski wrote:
> New datasheets for XGMAC (3.20a and 3.40a, depending on product) support up to
> 16 MTL/DMA queues. Before we increase max amount through macro,
> prepare dwxgmac functions to handle that.

Hi Jakub,

We are interested in this change as well. We carry an equivalent
change downstream for a Qualcomm XGMAC-based controller that
implements 12 MTL/DMA queues (MAP0..MAP2), and would be glad to see
this land upstream.

Could you share what the next steps are for this series? Is a v3
planned?

Thanks,
Sagar

