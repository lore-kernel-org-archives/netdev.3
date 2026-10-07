Received: from mx0b-00617f01.pphosted.com (mx0b-00617f01.pphosted.com [205.220.177.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D11640F8EB
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 07:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791358896; cv=none; b=q55TgjK2bi4EUZu4gnSRVE+i6Ds+ZJ7MsWIctsOkkNkf5kh/MiMFBubfv+mfzklxtcouS8BdPoxOJapXAeSfM0QSqO+YgFGeO5v1GO3XfWmGA8RYhezr13/LeTbjfUVPGlPFSShgDfrx2Hc/ktQOnqsCA3DHPrdoLGr28DY6ZXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791358896; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OhNBoAlQ2ar9XC0rItgbWu2eEh60jGU52TJYsb0m5UeIM/QiGchNLR3Z7xFauH70u9nl86N2fxIsP2Lpym897mtYCK/Ncibj1FFQ6slBPiDCL1cHX07go6YsiK46uNhWFlwc0wQ10EyNgDxAv1OWkVXaupFjeyiqfOSM45VOI2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=psmicorp.com; spf=pass smtp.mailfrom=psmicorp.com; arc=none smtp.client-ip=205.220.177.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=psmicorp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=psmicorp.com
Received: from pps.filterd (m0247528.ppops.net [127.0.0.1])
	by mx0a-00617f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6977dM3m3928278
	for <netdev@vger.kernel.org>; Wed, 7 Oct 2026 03:41:32 -0400
Received: from egc-exch2.psmicorp.com (webmail.psmicorp.com [38.142.134.66] (may be forged))
	by mx0a-00617f01.pphosted.com (PPS) with ESMTPS id 4h5c9y0hcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 03:41:30 -0400 (EDT)
Received: from EGC-EXCH2.psmicorp.com (10.1.1.111) by EGC-EXCH2.psmicorp.com
 (10.1.1.111) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Wed, 7 Oct
 2026 03:28:21 -0400
Received: from psmicorp.com (10.1.1.107) by EGC-EXCH2.psmicorp.com
 (10.1.1.111) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.2507.61 via Frontend
 Transport; Wed, 7 Oct 2026 03:28:14 -0400
Reply-To: <greg@gospelmusicuniversity.com>
From: Evans Thomas <_us@psmicorp.com>
To: <netdev@vger.kernel.org>
Subject: fund transfer opportunity,Reply)
Date: Wed, 7 Oct 2026 09:28:11 +0200
Message-ID: <20261007092811.27BD729281EA74DA@psmicorp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzMCBTYWx0ZWRfXwASrZLMvgDI+
 abzuuaVdiPBLmfROat2uKfzWepEKPxrrhZK+5Y2+TkK6ERFaWQXfruLAEhwmx3vxlglebJ3Z8cW
 DcGlG3pPmjsIMm48A5VZnsUjteoZcbza0Bu5YJwq/G9x3EQLNdId
X-Proofpoint-ORIG-GUID: 5eHgBZ3j5MGfijWVMPJRlMVsPXlVZ_8b
X-Proofpoint-GUID: 5eHgBZ3j5MGfijWVMPJRlMVsPXlVZ_8b
X-Authority-Analysis: v=2.4 cv=BLomP1QG c=1 sm=1 tr=0 ts=6ac5f7aa cx=c_pps
 a=sNj4pI0fii9qGHoVqNzRVg==:117 a=sNj4pI0fii9qGHoVqNzRVg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=ZHGAjPH774soz-f4Le74:22
 a=FHnH0SYMNjvGwZk24hmG:22 a=tclcd6dtLQvEqt9_mmAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzMCBTYWx0ZWRfX0TZmUZ5FyE9V
 nYGuSoz6WP08JC19T/PRnYuy1WO6sHSHMcFvdz/+hk6yRY68O+1nAnA0LOgL3aeA32w6fTLoMxq
 YxE+72KyrWOZt1Kz80m3u/EqUWfHb6gmEgd7alX8MAfDku5OMtR66T4bxSKmtrkSLs666IoL4/P
 4dlI0poLji+PID7ZFZzhzBWnlY4PQZ67xWxgNuIocCH8ZTWmySiArVyQrXJGHzJRRrORl6XNWLf
 dTvn9n14T4KUpWcNJAnMp7NDqI7Wpn4Olpx/q8p31ir0u9/GvtYrx9ImIspD7rDu6eyVaF/ywLd
 nhwUgiAUtR9b/JylABKau5OGanMCyVp7y1UNGSh24Ch00g6XYGDFMRn7ywDeprUNKcNhtoiptTR
 UWVVfzKlSK5PFTqqaSb1pquYzVm1QJiMOmIFwcUycIB6oWNO5sgnnNB5iIGUur4aMeHnTT75Cmb
 lX2Kc9CgX5n6WDYfCkw==
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610070030

