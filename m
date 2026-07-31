Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0831635C690;
	Fri, 31 Jul 2026 20:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528082; cv=none; b=OEOIqHP1e4Tp91GYSRtmrROigyiaCpmJNjriUVgU20AG8JOpFLaCyqxg+TheQebmmWqyZemK/UTzn+vCH9ApmevOGQk/ym5XZUuAf79iriwQJ+PdH8kWosNbfIl6MsPVnLyREemgkUUecqNASYWhyLo5e2TTc0kIVRvVNHubgdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528082; c=relaxed/simple;
	bh=sMuAgIOaH9axm1bMH1nWyO32x+0M2aym0nOEFyF4Fgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3aBMYDlfOnFv4ESJ1+hFhMt4EXjiGmiN2HOcgn35/ZS1hSEJhe0UKDVc0h4YqgSjMTCS7m0xdcp1qoddg3cPrTdUY/AwUAcRZz3Gdk+ld9e+DM6J5dZsxbp0aQipNK4thz/zj3L9hE7+VLPWTf32ZHV0eG3DZYPqUuPPVXamso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=f9+obYuI; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="f9+obYuI"
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VIljkX1114334;
	Fri, 31 Jul 2026 20:00:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=9bEyVBkkI9Vosri7qlgzxDggin
	PJsRrNNNmIgIR/brA=; b=f9+obYuItvq/QKSOU+Gef6Ta0b2JkkfAgnEGPXe8jn
	K77ncFrobvXl1NrKx+9CuiCnlLbxpcaZxO7enbp4dDPukMgk4IQdsGPh0xTe2pO0
	axKJLl+PlpVL8/lgzgQ91by3p4eIR4ATtYqV1uZyQjGutQNnZNuVBdGRmTENFYXy
	mRamWv5abCJJPOg2av0KJ28CTYIBpaZtdIIlNeN7IoZfnB1QMiE39rYrnvjtZvMd
	gQVFgNygPiPOy7+ma3o5pbOgfUQcSdEaV6+Maj+z6THKylr66FPmC6HPjb+U0oAx
	Zg2ZmoepHrtJH/QRkVu6gsU+eWXv1iK/bnvYMzjbu1gQ==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4frwqx68jb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 20:00:59 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 6F5C4147B9;
	Fri, 31 Jul 2026 20:00:58 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 65AB9806B07;
	Fri, 31 Jul 2026 20:00:56 +0000 (UTC)
Date: Fri, 31 Jul 2026 15:00:54 -0500
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
Subject: Re: [PATCH 2/2] misc: sgi-gru: Remove SGI GRU driver
Message-ID: <amz-9te3n-rNnYJv@swahl-home.5wahls.com>
References: <amywpyZgGWyhzBjZ@hpe.com>
 <amyzGw1-MVLpNH-d@hpe.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amyzGw1-MVLpNH-d@hpe.com>
X-Proofpoint-GUID: CcXEtKZt9q0BY4zQy3bioDKABmAcn2rg
X-Proofpoint-ORIG-GUID: CcXEtKZt9q0BY4zQy3bioDKABmAcn2rg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDE1MiBTYWx0ZWRfX4WTcnILFv+/u
 tZeJjQc5zeOEfK3v+IRApgUhtFaiI2m1KOHdGTXwb0VcEWb3hrXr8OQ1Lohl6QtuK7bnxo6zeRM
 0EiCds9gFyZXxZK+ruIbI9sxdaojNHY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDE1MiBTYWx0ZWRfX1Ioe5SO2otf2
 G9VKfgmp7TG+2J77k8NgsJH4z9XEQkfol6bmDu65Uo02sXzh8tJCaNM5T5oyHCUmLyzMK5TtB5+
 EkX7zdonMUN+sGAVLu8xQ2q4s8Ct+8r+ze1vsfFrd+qOPneAyY6Pq6mgH7s0pk4Fc5pWCX4QvCu
 nlX6XP2jQ5259mP4cHN7U0qziDnr6XHnK7jOSLmBXK7VvPA4OSElU8wcAEy5GJL5BI9HDK9zCp2
 743Y1EbZy9a3SLOrcuiwiaykgRM0FH3Qo4eQOzgifSKs3jlYThTVn0loLBzndWmHX6+MOW0EtJi
 yx2SlzcTO7K2lxH/tweyxrRZvnESkMhXKzSVAABFo+B4igArE/o7LQ5NF97hTrfBCv92qm36s7k
 xMRC+jN/f0QWosiVCktsq8gLgg2RW3qouQh5Sc3TJAAiLlbDxmfqiXD665ewgc9mxYRNxL1Sc45
 /BA0bQ5ubh/T5GAlpkw==
X-Authority-Analysis: v=2.4 cv=WNxPmHsR c=1 sm=1 tr=0 ts=6a6cfefb cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gQcMVamqm3wCPoSYhaRC:22 a=NCWKwCw8Xy9Og0ibBRsL:22 a=MvuuwTCpAAAA:8
 a=MayyRcN15a_V5d1QKLwA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1011 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310152

On Fri, Jul 31, 2026 at 09:37:15AM -0500, Dimitri Sivanich wrote:
> Due to security concerns, remove the SGI GRU driver, which cannot be used
> on anything newer than the long time unsupported UV2 platform.
> 
> Signed-off-by: Dimitri Sivanich <sivanich@hpe.com>

Acked-by: Steve	Wahl <steve.wahl@hpe.com>

-- 
Steve Wahl, Hewlett Packard Enterprise
