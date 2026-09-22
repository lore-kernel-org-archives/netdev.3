Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C91560AD5
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 15:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092389; cv=none; b=ks+MB6nACbVm+b4DFJM/CHX0TX4hmjDTXJikpAAKOJrXnRh+1OQL0Ql0ACwrpS/1cfBpf3C3PbuoVWCfLNzAhXm5+nbSCiTMVmudrF4U6ec7AAr+AHwskmuF9m12Tq646K/NLcih+8QgmUWGmWBBA+7iVa0fWXckMo+x5GSFF5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092389; c=relaxed/simple;
	bh=+0cvY03uJx1y1P2D/+4vHDG5Zh8Iu7Oql+aQLHLkJjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FmN+8piJEchqAKgly/4Qfa3eZSOcpwdgAmUKSU8EVDcdEz57IK2hT42d7HI7cyWU4GmztxBIgNfZelU3QUcJERSG6vZ6LonUUQwGiXpOrkEXLY9Vy877EVsAz0A0UJfCkvD3jw7DPZgjV1eZEW4Akd0gTMGHRn+ERjBQ3okhdAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eghf+xvy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TSvlnhpZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eghf+xvy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TSvlnhpZ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MEjGaB449451
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 15:53:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XE/iO7cZtAlOijfmvMM+VDRqjHxwnf6dpW+xiR5DDVg=; b=eghf+xvy//ZOFslf
	UpveaGSVcYErvpNTp5T2vvsCG2NizpveWEYt4+MVh1sZFUIW2iXMDf2koLfzGvxw
	Fpm69AfvdrlllS+wklhM0clBw+kQXpvQfbFtAvmsRVD1aNFxJWJ9qVWsxQyRtgSF
	BXGKQlyBgfpBKL+27SAXmqIVl8sfhVa61k0bcIwLQUIdY1BfPxh68UiWB3ECDcvo
	F0ilmftXrHMrJtzTwfS8kH2Gl7yavjz7AEzq2JZ7+zalAxWcEIekePOf6j9vx4Wq
	ikbaCulpsDs8oJ4QUgeWcwrNt7hFwyzK9Q8/Byr8KrL1EiYErSIv2+l2I0RY9ySQ
	WWcGMQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gunjyt6um-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 15:53:05 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2db3734d06dso73423345ad.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 08:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790092385; x=1790697185; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XE/iO7cZtAlOijfmvMM+VDRqjHxwnf6dpW+xiR5DDVg=;
        b=TSvlnhpZNvpLiAmxSknwQ/S3c7/tpkLASCvGwb+0T+oglp5UtuTwJlG+giP3r/IBRE
         HoWgzCIfKRbjmfq4x9TxFV+VMmCssVJTKtVyLl9E3raVk5Tcb5BKxw00+ffkVv7NwHQL
         psK4B9c/7VwwuKwiL8G4Hl7lonCnNpa9ezpZ3hxVWYXCA0yWNy6l8GEULXfiNdTpwON3
         +biuKym72kirTIOM09E7HdJQeEAxgmQVJBqurRE1f4ER+oUEki6ZPF9sqVP9s/VAR8eM
         yk6vC5Si7vT2ODBcm+8cGxfN8BKTAzbHgVLx7+JbvZJVE/fr075t8YEavSPYmr2T3+R3
         OnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790092385; x=1790697185;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XE/iO7cZtAlOijfmvMM+VDRqjHxwnf6dpW+xiR5DDVg=;
        b=rnzxi74heiKmUTvPwRQPBGsQ6s4H8mUP9beuQySmodKeIc2FmoUUas9rx41UivoBNx
         es4bd4H3Xv37MGBZcnvYe+/K+FI8AOy38eXLE2jMMKTVdwLEC/9xdj4oovU44fX2YAcI
         On1WdP2KKkGmtPZXiXsBp7BBH1Ao8SrlG4kMB+CWIZCgAzbPGXgXDCnxIR5Qf5MWktXk
         xgYBkTomI5DHfCVN9xdqmBKHQ0/lynixWzsjEWsjJ1PeSmoecv4zIg8mP6zaqlP3dvzv
         zOfMpHG3cMVL6+OEvawefqLbNi0u/5MywBWMUAdAtuTFhJdKfC44bjJH3J3OO7IjOToc
         S9qA==
X-Forwarded-Encrypted: i=1; AKwUvBxRlZRhNZ6mY3noCCIYZGReEYKAg6Q37k0hQHcR7KXfTQExmrYxMkOB/Y+TNDmVwVgX5yEjujI=@vger.kernel.org
X-Gm-Message-State: AFuF++nOIrbbNr6XjxJ5RtwkDRHW9/h4vsEFC+Lqc9wCDmzJfkYPFAAG
	2NXIv+ca0i0Kvy99Qy+LGZ2Ev4QGMHYqeBrmeM6y3XQjErhYDExCeh+54Bf5QzxEVWJXpuKsCMe
	hCu9TcFrUUMUs9KkFk4BETWaIsXW3qwSv9PHOZXG3t2JXs3+ZyFboOrmNplE=
X-Gm-Gg: AYBFou0sKFxRixgVzD2RbPqB2l8+H8ojINJpHspWh2K7X+KhGdWEquQy9rzoq8nWQHj
	QiCHqrifwFuZ5phXj6Ue+Idmy5vJvz+WkYiqA/c9rYDCLyM1N/D4HfYilg/a7MDK87M/rXjMDP5
	evbfR6r1HIQlvIURvur7+2Dy3izvr5Km8lBB5fRo5r3/wFttKdXJh2ajkcryUeVAskbd8ICq6a5
	fktyYKRKuGVgu4VqkHWt2VmIv5zeYd8jRqz5+MS0y0VEpBydr0YJyt6hSyQF1wTnpBrMkWK4YDE
	NNNLHkpFs4sngS77tywbCplc0/FoXWzWtU/t00o8SkANr6wbN1sLvo54/fU6lQ0WW22lbjmzck+
	I8XZV7rSf7ZpHLwzNvPQCWmcQ86kJ
X-Received: by 2002:a17:902:ce8a:b0:2df:3b08:a30d with SMTP id d9443c01a7336-2df60b60b5bmr20251395ad.43.1790092384950;
        Tue, 22 Sep 2026 08:53:04 -0700 (PDT)
X-Received: by 2002:a17:902:ce8a:b0:2df:3b08:a30d with SMTP id d9443c01a7336-2df60b60b5bmr20250935ad.43.1790092384329;
        Tue, 22 Sep 2026 08:53:04 -0700 (PDT)
Received: from [192.168.29.33] ([49.37.212.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5d02f7e1sm13009205ad.39.2026.09.22.08.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 08:53:03 -0700 (PDT)
Message-ID: <f8f231b6-a4fb-4f19-9ec2-949668bfd5b7@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 21:22:55 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] wifi: ath12k: Connect to the QMI server belonging
 to the device owned by this driver
To: manivannan.sadhasivam@oss.qualcomm.com,
        Manivannan Sadhasivam <mani@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Lew <christopher.lew@oss.qualcomm.com>,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>,
        Juha-Matti Tilli <juha-matti.tilli@iki.fi>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
References: <20260922-qrtr-multi-ep-v3-0-c00831e88957@oss.qualcomm.com>
 <20260922-qrtr-multi-ep-v3-4-c00831e88957@oss.qualcomm.com>
Content-Language: en-US
From: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
In-Reply-To: <20260922-qrtr-multi-ep-v3-4-c00831e88957@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Y2iVkSqmP9SiP062BYuPfO0lkPUPaBwv
X-Authority-Analysis: v=2.4 cv=KqHYSmWN c=1 sm=1 tr=0 ts=6ab2a462 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fVbWt6ZMyMsyUNhTwytWAg==:17
 a=bQg6oyjaoxrshYPP:21 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=R4z_reooDQMcG2LTbH8A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDIzMSBTYWx0ZWRfX1TqTLPEleQJq
 wcjbtttwz+4cEhyjupmwPhqm/estIHOulldCbeHA4MLnP/MAP9Rc7LKSjw6BgIhBPz649bkGOm/
 wsQ4UKgRwStcOPbWDutXNJvlDvj7+1xtDk2JD2EoFqTqYrZB53nFoRLZOOcIb36mb/kldxIf90+
 u00MtDbVMhrgv9ia6LHfs+qJ/VcisfXnn3veqCYodD8qPT6hdyvhCFpufl1wOo3pTSJ5eErKp7n
 TdKqhm0w5dJtM4mgskoV+yA0ORZVyYlhtQYvl7FL+c+TVdH4vNcWDYnM+15yctgMUWaApDz0Lgi
 FMpmXOv3BWkNLN8YtdJW10bE8go94wrXj1bAYXieT/kUOHKaJuTg348URVJVtgFKk7SHW6va+Ua
 CjQMzY9XOtbHJKetLM4T4gmuPyroA14vSQhRQWWnGhHMhdYiD36kaMuN7qVky2OWGRCvmP5PCKn
 WDvoPjD5sk2HbbljaXg==
X-Proofpoint-ORIG-GUID: Y2iVkSqmP9SiP062BYuPfO0lkPUPaBwv
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDIzMSBTYWx0ZWRfX4qxuBUolBMJi
 +/fU2mXyVCEXW8XKMcl4yzTRBs0fYBb8v8x7v8pHsHMTImghYUI16GDG61DlDZZGJIwjZmVyo/H
 nzb6nfVlsb2+7eGnAWug5WMbz+Kk1DU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 suspectscore=0 clxscore=1011 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220231

On 22-09-2026 19:11, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam<manivannan.sadhasivam@oss.qualcomm.com>
> 
> When two identical ath12k PCIe devices are connected to the same host, both
> advertise the WLFW service with the same service and instance id. The QMI
> lookup reports both servers to each device, so a device may connect to the
> firmware running on the other device.
> 
> But now, QRTR provides each MHI endpoint a unique node id which is
> different from the node id announced by the device. So use the same id to
> pick the correct server. Add a get_qrtr_node_id() HIF callback that returns
> the node id derived from the MHI controller index and zero for transports
> that do not assign one. In the new_server callback, skip any service whose
> node id does not match. A node id of zero disables the check, so transports
> that do not assign one keep their current behavior.
> 
> Tested-on: 2x WCN7850 hw2.0 WLAN.IOE_HMT.1.1-00018-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
> Tested-on: 1x WCN6855 ath11k + 1x WCN7850 ath12k
> 
> Tested-by: Juha-Matti Tilli<juha-matti.tilli@iki.fi>
> Reviewed-by: Vasanthakumar Thiagarajan<vasanthakumar.thiagarajan@oss.qualcomm.com>
> Signed-off-by: Manivannan Sadhasivam<manivannan.sadhasivam@oss.qualcomm.com>

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
Tested-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>

Validated in ipq9574-rdp433 with three QCN9274 PCIe devices.
