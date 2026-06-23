Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EA7369D71
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 09:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782208563; cv=none; b=Yu7gzVKflVGDo8h6KOv6CI26cD+eQeHNkL4EhWS/+PfIWx1qX1VdXqoaocRG2rybJUxGpD+kbP5VBlZSdXiZuWOP9GBtXQsn0ZoZiBPQeYt2CkpDctkTcuy4qjMg2kNbyq7yCsNCtzyUvLCxkRjSSD097fJeBDdNVU3QIbWmQ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782208563; c=relaxed/simple;
	bh=TuuVh5rWDQJNKeCix9U0TUROxQoIHHTcGQZRv4sVMRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hsIdQiEIo/5XxhRa3LyQRDCrrZnx03qFJC0PNBX4SFTEbN92DsjeZdnDQNI4lyhGZYxuagbBRlVWl1XXLR057NEjdvT5/QCo+208QQLVYM9urjTkqtEr2GsjWdO0+qNi502cdHX5xrL6sxM+nJQ8+0Bi6pxGt0rzqTzXiuv9gzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hy9+CsQ1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DT5ACLIn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hy9+CsQ1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DT5ACLIn"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N6caDq3646633
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 09:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oQg1GucAyJTsYEyGewOcBVX2rr60LtF1mzWX1fFcj/8=; b=Hy9+CsQ1WtvXWdVT
	cTv26O88rGKF2e5vnsuAkoW9mBSoWzMtuF+0LVpShZzLYyxpc/LTvO8YhzmHvics
	SaW5wK/MfzoQBl3V3mbWnlvnhQWNhn5yEWdFAyISEJu+6mPjG5RJV+LAwkrtfWjI
	4PzCe2sbjgmJOaCkPcjA+YKBGwuZ+4KhW9tejZdzOGwv+AeHUT94RDlb0j79/B3Y
	Fio9GYRFl57e8NHG/AX4rvRU9XGF1XbhkS+uBVXwz2KVt4vQoRfCxWfO+6HH0Q2Q
	42I4pM9Eqi8VEfr0UlMh/EWAKHT+tQgSWfRvMRGbHfn/tGq7qSr6rpQV+ZWxW01Q
	LfVSVg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey6tmuvfb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 09:56:00 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51a19f736a1so54550451cf.2
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 02:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782208560; x=1782813360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oQg1GucAyJTsYEyGewOcBVX2rr60LtF1mzWX1fFcj/8=;
        b=DT5ACLIn0c6+QKM5AhapbSQrqqfgKMMcsql+F+sFCkAhFagDPf+9ppU9BWprhSwbE8
         HHW/ABIbeh4mGeS+3m4k8muZWWChTdjcYffZhrOv+OM0DMwMlxqEKXKK52jbKej5991L
         MCVDyXSGc8byanMzhyuO383pYYxKOHZGeV3hpFjGkF+djDyxw/Q3jiB7snw3C3ls3opV
         AxQ3Y5WzNVjBaCYISUCTRlsXABP4q9KvbI5qRv6QB8RE8unWy/bWrNfNwJnOyi07fwv5
         WNalVybOF507WBVWaNH/hFa7joNOBJ086ieo0jnsdgEJpFni2hpmFhEiYwDvzWcVuu6r
         o0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782208560; x=1782813360;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oQg1GucAyJTsYEyGewOcBVX2rr60LtF1mzWX1fFcj/8=;
        b=Dqc6SGXIygaYwtWvm6YhnWqU05birsUNGFBeLu5LkYPMNFXKEXo9pvRXmqtsm2RHnL
         uv9yLoCFtDM0ldagbvtWGDB8KDUG5Sxz8TySVvS6A/NW69RxzSO5HpFdcSyHLD7M560u
         PhdyMEbTdedK3g/ctHwr1OGGvqtzblf9fHHW4KpqQzG5JjkejOAgHTMIh+zDL258o0j7
         ddwqxGYjeOET0dxLgYz3A+QdAl+9MhXz0Ail20dd0NqClkTtmMy9JoBRecyv9WMlT7fR
         u3rArJnv6snoyEXNq/WBo2Jl+h8vmZWQB/ofdRwWp+Hvnt/o0rLv65Ev2SFOUXmfRAc+
         Ec9w==
X-Forwarded-Encrypted: i=1; AFNElJ/OqMYzRTEIdHa2Ly+mdrR1YqmeWpVOmMBipQbiSD5LOQlaVjaH0QRtslMfKaBSEEfy4pP4pJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkuiIXkkDAegAWJ7+SXHbUAY1C4Qq+ezyLz7tKtLDzPkYtbVdT
	acE1+HULEBucv2PvNJepe5M/xonBUwoUqzqkLv8jL1/yiLOhhiltqP93Pgyvf6xicHdKF6rNciO
	f6MmuTjSgvGVkatCjivRIENcTmQZe0wm7NoEEou6ZSXHBCvoJUCR26VW06P8=
X-Gm-Gg: AfdE7cmnWqGQg46mOfthjT5V3Oq4oKjeEweD0lzt7jYemvVz4h0oNjNRHqMOtN36wks
	hLGs0ILuZskj90rePTsBE1tvhn8Y8Ezw3x88e5SjTXewhR2bV3TTwul4/rqqtwiGHlhUOpCtrMP
	1d1Q/VXITZMpLKvjqgU9t1+EDB84G6TZOJadjoIDNGSENrYfwViQLDvRRXjaJ/q7Xv8AFyS18gp
	4f/ONO9le5iRnuGwlAMgXLYvwz8Lv13JuTncmJmrx41/VdHg/Wix4JFCPTCTUXfWzjWzF6zBv1G
	JPKhM18vprx4pIfWncJoWWdjWdgZ4005rqrwdJwYog2Wz9wB97ZaZGi2hu+Oq081oxzd/gXfnvn
	u+uWFwpeAEyHXgTObm+FIt/MzR2OoasDGrqgEdQhW
X-Received: by 2002:ac8:5dcd:0:b0:517:82bd:46ff with SMTP id d75a77b69052e-51a547fdaa1mr31502921cf.26.1782208560103;
        Tue, 23 Jun 2026 02:56:00 -0700 (PDT)
X-Received: by 2002:ac8:5dcd:0:b0:517:82bd:46ff with SMTP id d75a77b69052e-51a547fdaa1mr31502551cf.26.1782208559652;
        Tue, 23 Jun 2026 02:55:59 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.218.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666c579dfsm34473542f8f.31.2026.06.23.02.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 02:55:58 -0700 (PDT)
Message-ID: <f8441903-c768-46a1-8f95-b1b25d420a2c@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 11:55:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: qualcomm: ppe: Demote from supported
 and fix maintainer addresses
To: Jie Luo <jie.luo@oss.qualcomm.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Lei Wei <quic_leiwei@quicinc.com>,
        Suruchi Agarwal <quic_suruchia@quicinc.com>,
        Pavithra R <quic_pavir@quicinc.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org
References: <20260623073307.36483-2-krzysztof.kozlowski@oss.qualcomm.com>
 <0247dfba-1c14-4fea-aab3-5489a36f35f6@lunn.ch>
 <8b0560ae-af5c-4d54-be02-d186be1d799c@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8b0560ae-af5c-4d54-be02-d186be1d799c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA4MCBTYWx0ZWRfX/ZreK9pQmcR8
 so7eZHTpBAumHMQJvfwKPUGFEB2rarmBhg55GBRODlCs4chnuHOzOGo9xefpkfIOQ8OFBddPhi4
 UUy+Q7PvDtY6T8Cd6EfP7T7ldVtG3PM=
X-Proofpoint-GUID: _rASnpAcwrg2XBto_vkDhdA5ibd7994k
X-Proofpoint-ORIG-GUID: _rASnpAcwrg2XBto_vkDhdA5ibd7994k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA4MCBTYWx0ZWRfX/IM28Pc6aVrZ
 MJy5L4hp2Jp4L6JW/IDrXMvkI1TXB4Wre42H1OKKSITuv1pTOWyxKGN8WAfNOooU9RZr+7FaAmN
 5OIrVmkFBqqoS/fbLALxPHaJ5veJ902Nl5byf0lk1/HFan5t+zIOPMdzt0cPpl5rz4M0rwGqBJb
 EsaCrTSR6BHwfBesOHpw7S1/z/Q+lRrCc/d623899tx0LWcQMk6ldmiwogtaCFvi4DpxyPDZY0P
 Kp5maA7BN1/vR8HFqjGu1oSf3/VozxO+nIa4YY7nwEUnxFexhBI9PRHikWFeGkSLlRy/zRas8J2
 I9LRaUV+l3Ye1rT7U6kM3mezqZbo13YqtHoHMGS66PR197kT8ac26PtjpkPNemw/SuyVDCvOFS0
 pMGEjIg8OGEH1QMlM4jAM68Qu89hVBh8otMJGcIwmp3lrowJnc4Bk7bwdggdbjgWkqx+ePusDLn
 b5pdNrVu57aLvc48g1A==
X-Authority-Analysis: v=2.4 cv=H4HrBeYi c=1 sm=1 tr=0 ts=6a3a5830 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=qMZSjPy+XpteAuilWfML4g==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=UHseL_0MqL1Ls2T-heYA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1011 phishscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230080

On 23/06/2026 11:42, Jie Luo wrote:
> 
> 
> On 6/23/2026 4:10 PM, Andrew Lunn wrote:
>>> Driver is not supported - in terms of how netdev understands supported
>>> commitment - if maintainer does not care to receive the patches for its
>>> code, so demote it to "maintained" to reflect true status.
>>
>> Maybe "Orphan" would be better, if the listed Maintainer is not doing
>> any Maintainer work?
>>
>> 	   Andrew	   
> 
> Hello Andrew, Krzysztof,
> I will continue to maintain the listed drivers, so their status can
> remain Supported.

Do you understand the commitment/meaning of supported in networking
subsystem? Do you commit to the time frames netdev is asking, including
running the tests and reporting results TWICE per day (minimum frequency
is ever 12 hours)?

If address did not work for half a year, I really doubt that you commit
to above.

Best regards,
Krzysztof
