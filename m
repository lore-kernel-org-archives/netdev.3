Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C1A369D5E;
	Fri, 31 Jul 2026 20:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528082; cv=none; b=YQPKT78gfguvLopV+5k5IvLXBNpwJR3fWYgw3dcOs5JCiLUtOrJgmscT4aigadnkkPAGSgFT+goYQJOrD/AteF/IX1nIZLy4z5HBSD/xt5znz6OOqg4AesNKjo32q3pC6c+2mpDo0Mu/jDvVUahWDcOSECNEtsntVKBUyV4pPxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528082; c=relaxed/simple;
	bh=6PWCqamSO/ml/ObIbx3glIpLoRQLu/kR9sKvgkBozlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSUswQAsL0dSVDUN3An96CsaOEiBwVwtB8hzcqHNvY63dlJAUg1gtoHY1hnJiTZcBLY93kT8bqydTkBDkt8JKuRtPJubMlTIqnq6uw2Tah7Iy7Nk4SudmY+Ds4tSeua3t3bnVSJtBpmMtrhnMiwnB7cfIOgK3/85UQLwapR5od8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=SMkXE4IM; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="SMkXE4IM"
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VIlwM93578733;
	Fri, 31 Jul 2026 20:00:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=x5Hc7EQIItgd7Zzrmun9tbr/rt
	hYRot+g6mzyKJMVhA=; b=SMkXE4IMCvo78CoSGFcmNV7Xhnopk2i2NGEkrUOr7t
	mVM0knN0HTDwVQcNzcXN9ERvNXLD5kBX6atE93UiR/dnI0vBjZccG1++/a85MyHK
	tqn+qxn2ugVn6Lgi2da/8+AwZ02rXY10MT0WXV2Q+eJjp10fjD6Lhg6i7XE3pF0/
	enc63QsVhh/Wd4yG/Eze/rTul2gUcMrZm6F4QLEaNxQvbtVaivAXLTMavxuUwdUV
	FmfEJg+ljz0pBx2l2DTUsTW3k62PbwTaiee90cG5e5A/u70Tys1RkWmqvFTTHqVw
	hvWe93q/Ms8uIrAzNe2yYI8xYpWSuzEPPlQC+EAB4dEg==
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4frxwccef6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 20:00:37 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 346051306C;
	Fri, 31 Jul 2026 20:00:37 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id C856680BC71;
	Fri, 31 Jul 2026 20:00:34 +0000 (UTC)
Date: Fri, 31 Jul 2026 15:00:32 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Dimitri Sivanich <sivanich@hpe.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steve Wahl <steve.wahl@hpe.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        Robin Holt <robinmholt@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <kees@kernel.org>, Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David Hildenbrand (Arm)" <david@kernel.org>,
        "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
        Muhammad Usama Anjum <usama.anjum@arm.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] misc: sgi-xp: Remove SGI XP drivers
Message-ID: <amz-4AY7wy2e_F2a@swahl-home.5wahls.com>
References: <amywpyZgGWyhzBjZ@hpe.com>
 <amyxgPYeowzWt_8W@hpe.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amyxgPYeowzWt_8W@hpe.com>
X-Authority-Analysis: v=2.4 cv=VM3tWdPX c=1 sm=1 tr=0 ts=6a6cfee5 cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gQcMVamqm3wCPoSYhaRC:22 a=RtSn8ETxjE2H05FtM2s8:22 a=MvuuwTCpAAAA:8
 a=Iq66eBpYg_as4mzG6f4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDE1MiBTYWx0ZWRfXxDh98uZxW+yL
 uMkKSsIWXJYvvrP2O9LYP4j6PwSQkHnih2r9Zc2P/mqMv1q4sa0KO9vmsE6Xn5hDKNiIdBTCN2E
 CQy+K+JWy8P+PKr1vqyHBHyfQYhR2ktUstkPGqcRYBWOcUNS4sTajTbknemOafRgal3SScKXf3i
 jDE48wMhv3Dnp5tz8xVXUQx3M5q97bwPyfhJc4955NwHy3SJjKPZY1wtMLY9cGlIrHcvrXrCkKi
 odofbB4UEVYWtZomekoJEFg/WQbNt7PNdNruQZwHq9isXbDkuYhB/ILqirMasu703UYJWRLiRKB
 OpV7IXy3TAlObwky2YKyMf7D1xWnpMnkMpBYl9NQSXWnSs5B9HtorzV+6Blu05E6MpOl9QOeq1y
 Lt2BeNykxKABBiAleLWw1a560boOuHtlQ7CQFz9BdC93TiRs0lQv+XS51ZpNotFqBP8rozBYoM3
 oKh+czStu+34nAt1CIw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDE1MiBTYWx0ZWRfX9QxiRPD+EACy
 hLtrg3fkiMSnoZjsnSeZ961D8vNAF14Y+j9FGZ37Is3slngubpKnXVlw8tfhd6aurJuS6N4iq6e
 Gvyq+JWu6CUoDHkmsiiZ1JmVHQQTnd0=
X-Proofpoint-ORIG-GUID: -gpYYpLS0wqFfCAtmWruSquJbFoB20I2
X-Proofpoint-GUID: -gpYYpLS0wqFfCAtmWruSquJbFoB20I2
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310152

On Fri, Jul 31, 2026 at 09:30:24AM -0500, Dimitri Sivanich wrote:
> Working XP drivers require the GRU driver.  The GRU driver is being
> removed, so remove XP as well.
> 
> Signed-off-by: Dimitri Sivanich <sivanich@hpe.com>

Acked-by: Steve Wahl <steve.wahl@hpe.com>

-- 
Steve Wahl, Hewlett Packard Enterprise
