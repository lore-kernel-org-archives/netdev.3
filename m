Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1507433BA0;
	Tue, 21 Jul 2026 08:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620854; cv=none; b=YNn66yKLWgouqtig1lPhYYTmY4PC2pnahjROJtgSfflZYbBNsY3PbPFoOaUHh7NuDbKPlz7nxwtB76eHB2xbVCEnIhLbWMgKjDYu6HqKCP2oIKfov44mYtxlVWTYYFE1rh+AFRskPvxD64myvPY169ecuavDnGFmpMxVDUuEt2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620854; c=relaxed/simple;
	bh=l2+3Z59K7rs0B4voVQfZ8oKjbgwcqcdsh95JdI1evE4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCSeFdrFZYA06BqbxkDDMlROKE/IcI2oZti4Sb9BwJpYXTo68WZLadt90CQHJF4ItnBYZeqLeJLPH9kjwRM2S5j84dLYV0seKq9ZWa7MLOHc/eEpPspWPIjfeKJZ4NEx14zpobIPB0r3ct7ozy5JSM2MgayTlKAJ8wtjldtMeCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=E7qklUkf; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="E7qklUkf"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNcjFr3015275;
	Tue, 21 Jul 2026 01:00:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=l2+3Z59K7rs0B4voVQfZ8oKjb
	gwcqcdsh95JdI1evE4=; b=E7qklUkfjAxE8vXCXUlBOF9y6XTwbGBSrXabEJ/+W
	uNL7hiDyBvjkQsK08N/N/ciQriTN6fyyG2q/uxhKx5WHG5fcD0JHHvK7NMws7i3n
	KI8RHl9ft5eM1Kt7pQ+OmSEhn1SzEDKft+ZB4criS1duaDX5kq0GEjBphpH8piUS
	NosGepAD+zIJpUsQDyOrbkT3Gv8FFB/DCRTOLby3wOamKrehrzlPP52yEJW1P2XA
	lPyqp0Y5tETwk7jnlDb5cv9N7HztQP2ztCmcUHnAUtfMkVfJbM7+bOySHInQdS1j
	XYmv6TJ1v2s0qs3HmwlXrTyo5oZKWb+a1uhRmpndrZrEQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fhhevks27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 01:00:43 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 21 Jul 2026 01:00:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 21 Jul 2026 01:00:42 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 0097D3F7093;
	Tue, 21 Jul 2026 01:00:39 -0700 (PDT)
Date: Tue, 21 Jul 2026 13:30:38 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v3 net-next 0/9] Switch support
Message-ID: <al8nJp6w57kVZCd9@rkannoth-OptiPlex-7090>
References: <20260714015331.1801922-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260714015331.1801922-1-rkannoth@marvell.com>
X-Proofpoint-GUID: 5Y-XPZTuqrflmF4dxN_FTMCYZ4zZdEuf
X-Proofpoint-ORIG-GUID: 5Y-XPZTuqrflmF4dxN_FTMCYZ4zZdEuf
X-Authority-Analysis: v=2.4 cv=PN0/P/qC c=1 sm=1 tr=0 ts=6a5f272b cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=c92rfblmAAAA:8
 a=M5GUcnROAAAA:8 a=rmKE_tzFG4I4O5f6_9QA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA4MyBTYWx0ZWRfX3NaDp/Wu8LX5
 hgxboE6NVHi1vKxNGTu2vFwsOw8oa00owev5rIXj7palTN+LTVty1bdIDyOB3jbBmCIL3iGHr9U
 1K3S854jsrB387wk13Z1TqE13Juvly/AzyOdrA8LPdTXku6NYc1YogB0zmbtY+krDj2CRyJbbu3
 IiqqP+kuIyJoBgUNS0BlRPuysJD21MHDdFfhMy6mAor5KwPf39r2sA/tE8BU3ZnJKgEg7LD1Z0m
 dVo/XZHT/KO0B/HZRpVuwjVckx/lGUXcuKAk+yFQ+dkil2+Cm8mRV/pYRwYir3hv+w8vphd1IOe
 UDmy22azrGyuCLX6jPT5s9JEEVVV3IufpLYnv+AyD9R7BiyAUE497kEMguH+hr1eie1ChLpkL/A
 mVD4zeadTbGKx2G/YV5OS/+9jj8q1A14YKSwPXpC4m52wn8IUSmuDpUTO1s35mKWnnOQZHvYT0p
 2szewTzpkVuxQst1HXg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA4MyBTYWx0ZWRfX2/7i6YwGq7Ay
 uHBS9dyJjTNJ8Dg/fPZyD0qOjsrMF+2nLM6G4ymbajQXbUSGv6+8Ewm0ytiUIKkW2NQwCoAF4zr
 HfEY1+uElGK1gtbs3/b+Tqvc4biSjVw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01

On 2026-07-14 at 07:23:22, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Marvell OcteonTX2 switch hardware is capable of accelerating L2, L3, and
> flow. When representors are enabled through devlink, a logical port is
> created in switch hardware for each representor device.
>

Critical comments reported by sashiko (https://sashiko.dev/#/patchset/20260714015331.1801922-1-rkannoth%40marvell.com)
Will address in v4.

pw-bot: changes-requested
