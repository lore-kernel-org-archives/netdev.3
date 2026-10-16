Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1933387596
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 03:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792121010; cv=none; b=iemFZOibBoahgWVpZ0Vn+WrhX5GtB59yzbDjm28Ek65ZKs4gLIHonqIBtHDHuLrRHl5+Zh+8wC4tm6PyvS6kP/7MakstCZWJPbRC0iZq9DF4bBLN4/efspdCBkmsWhNSqO6YYI6eqFGRa2R3HfFoNXS5jRQSUhD1kxV8xsiumfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792121010; c=relaxed/simple;
	bh=+72g8Yos05LYO8HWsgDlsz/pucFM/8kucr3tk/IGvdo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UWBXyrg5q0ir3jvc15YiRd3zAMSWmbdiqeWCk5/f6kHyW/qNMtyI4yNkN29/OXg3OVZ8k64OTYc34gAzaXzwHFvbPtyTEHkJlT34hNeESqpWKseoEFAWV5ccqOjIYJxK0qbl4uwezGz9TjqtDM60niiGALAmsT3WYwo7yPH3CUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bKh3N7Od; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GrsCZj9B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bKh3N7Od";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GrsCZj9B"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FNDSGn3492972
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 03:23:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Uox5aqWMuWw9seqGZoF8JU
	w/ExqPXaGm4ZCOZEU8nL8=; b=bKh3N7Od0hqu00Sy8By21vv7sYZOnwqQWiQsmH
	E39CM/OuA4E3n5aVbrtAMS8MjYaV+eDjzT+yaploW3pQnhXMHgdKDBnXIZfQrGWb
	gTusVILvzH6aFiyAOTnQ+HjmDQsfsaVKxeV0WLnAcffze5S/fSyFnGQ2P3EOwpn1
	YZuvvkhJc+2cDcOnMqJ0hgS8xwYeQdnNYLS+kI0QT3JzUS1VhH6qZR7TV55cgk0+
	EL1/X8yF2MocVjS9pKmFjCxRO8pMGgSON6ICIdsWuvtSYat8kYluvNpIBrotgMlj
	mDbDZIMStk5+k/pKmUi78ERWo3eS/oRD0mNFUKTRnQIj9elw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb21wt967-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 03:23:27 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1383723dfddso5229145c88.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 20:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792121006; x=1792725806; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Uox5aqWMuWw9seqGZoF8JUw/ExqPXaGm4ZCOZEU8nL8=;
        b=GrsCZj9B/rPSWiLr2TjBxVFatCG1k4htJ/hMESHD9d+YtTLiGKEAGN7+Kr0deY/3MQ
         Y3UHAKc7jZBA12sR8soShzlV35VdMsMMJLTQPzuVQfFBgJew9xbEiUr2gkQqzflaAzY8
         Bp5xg1cBkTcHniSfxmzEpyFOP2OQLPjIYBbesMB6fa65MLwuXQFFVY68KotwOU94Wzrl
         Bv75NTzGxpPjL3qQYz0b1uQkHq8waHJszP/aQ0A5kPHDPk+of9t+TPpJZ5G/Un4znpVC
         LB/6Mft+jKjcpqm89/+C5LwxcMN+C+LO01qV5N4whHPvUE75/2vJx5i8GVML99/noN4i
         PvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792121006; x=1792725806;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Uox5aqWMuWw9seqGZoF8JUw/ExqPXaGm4ZCOZEU8nL8=;
        b=oKcRB7BJegnIdoSq6TW85hN8Y1eG1nIyW/4GT3zjlSKLUGePRgIDx7TAl32IutVbcs
         4oHvo0s/4NqOavLmzYcXEgeLsJz6xsMo+8gtUSrGAc/1Tb90m2GzpVJRRqYW6t6mEAvJ
         c6Eo0bKg4f1K/Wv6Yah6PqZS/uG43BnV2i/r6RhQKPW++h0rXF+xHkZg1sE+qOM/Fzb6
         OYVzs63GwtrpvMqUESGMnL2JUrog9IETymYKO2wK3tOuUrrmm5bvyxVjUCCoJdvgP4Wr
         MvHv6dSGrPCKE9lN4hK6N1PnHfeoxQOvmPOWybs5gSAaBNUUjh+qvZwLF3rjw9n9p68u
         OcEg==
X-Gm-Message-State: AFq9FYKptDjG/YkFz7auGEtrOCbmRHyWRbXcVNtWFLaIucI0tSeF3b2H
	99444S0U7T00JGJZ0c7TY+XiVwpgIFr9g5fY7Pp+cULbY5rvg3rZfSWGlwBSpizN2NrZxKtgN76
	+C1c3j46MnLeh6g+tVGvNqHuZs1bof2gel2WjCvJQlH+eRhAfFow0Uno1/mM=
X-Gm-Gg: AYBFou2kbvGk3egLwK+Wqvuf3tOdLJ5EXpeqXxcX4AZX6wofRMte5W33U4pU5CIj+FU
	JNdzii7qLUpGfFJ6KvCOoDgvjxPdyRRO4XbuFUvm8CPUfvR/ylFgFm4+N+c1yJ0erT2j96ZXUZz
	CquLnnG27Knd2Q8TUdMpdocYTykGtapWkW0ZvTPs8CcozgthkhwmUh9jYH1I3ETYe/0PjT2/of8
	tfGphb6qs6qaFe/YUYmV/wRkPCcsscDSIMiWMprduhjA3cdWx+w/48Japzi+nPfPTBi4xghH2D5
	kwn2PSqnJbW/AOLXzZ3bQ+VPnY4imo6S4aqzWV+wcoN3D3Rmts6AB0Zw53D05Hl54fkepw8N+QT
	FrdqUZfEwXBE05U61n17llP3eDEsJo+ggO6R+KJkPZQeKKHSwxRl4n7aCxBc=
X-Received: by 2002:a05:7022:f503:b0:16a:f5cd:365 with SMTP id a92af1059eb24-16af5cd03a3mr28581631c88.5.1792121006396;
        Thu, 15 Oct 2026 20:23:26 -0700 (PDT)
X-Received: by 2002:a05:7022:f503:b0:16a:f5cd:365 with SMTP id a92af1059eb24-16af5cd03a3mr28581610c88.5.1792121005848;
        Thu, 15 Oct 2026 20:23:25 -0700 (PDT)
Received: from alfred-sh01-lnx.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831bd28789sm1674445c88.19.2026.10.15.20.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 20:23:25 -0700 (PDT)
From: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Subject: [PATCH net-next v3 0/2] net: phy: aquantia: fix PMA capability
 reporting and EEE discovery
Date: Fri, 16 Oct 2026 11:23:17 +0800
Message-Id: <20261016-net-phy-aqr113c-fix-pma-capability-v3-0-0bbb1b84035d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKWY0WoC/42OOQ6DMBBFrxK5ziAvBHCq3CNKYRsTHLHaBoEQd
 4+BJkUKmpG+Zv57syCnrdEO3S8Lsno0zrRNCOx6QaoUzVuDyUNGFNMEc5JCoz105Qyit4QwBYW
 ZoKsFKNEJaSrjZ8jTHGdKKp6lHAVQZ3W42iVPtPUbPXn0OjZukB+t/ObYbkvjfGvn/Z+R7I1DT
 dkZ9UiAQMxTduOM4AInj9a5qB9Epdq6jsLYvSP9JcenyDSQKZc4oRmTuGB/yOu6fgH4GokLUQE
 AAA==
X-Change-ID: 20260917-net-phy-aqr113c-fix-pma-capability-d7d08cbc9879
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hongmei Xu <hongmei.xu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792121003; l=1684;
 i=hongmei.xu@oss.qualcomm.com; s=20260917; h=from:subject:message-id;
 bh=+72g8Yos05LYO8HWsgDlsz/pucFM/8kucr3tk/IGvdo=;
 b=DsKoeIFonMVl3p+M3JTDTTpckSQRNh2JRv2oCTPmCfu4FxSW7SMXcKSDFYH87aCMYMPzbSQCi
 oolvCeWKSEKAdYzcBrv2ZafkjZ2mxxGH5je16x5j4KA9HYeS5j0iRJg
X-Developer-Key: i=hongmei.xu@oss.qualcomm.com; a=ed25519;
 pk=8J3IzbyuOOHSwLvktng8AEQIdStEQDAGNCSOlkASmk4=
X-Proofpoint-ORIG-GUID: usCfAsSKRQSwy4mqedPI2XI4futTKt5Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAxMiBTYWx0ZWRfX7sUoM6aNuhNe
 d8TdAmTihWbNzufWhSQc8RbOdfzqWCNfBJviaD9CRYQOLE1/z0sWaooueGbLo0ClKQjG8I6sT6V
 6Jb1HDxMWbyKc9lUz9H9BcBuV7x62T+x13ueGvh9hpUGU1MRgevlfUD1uoIOtHI00H/IkQdWd8x
 fvbyTqnr4amJUGqE8JXAaZ+W4IGbBvM8aQyR0yILnpVM3XeUw3eYddGhUmGcW4p+/wlfgO/XXF+
 Y4ceurRECuNEyL7yX5paKu+/vFwUI9DRVwTGrxY9NvkrRu3alW0MLRuYihMrAkwyzx26g3jg71G
 L3doctqahRfjyS7jMt0RisObLm0h03GaTsJ/CmOOYIcdcBbBi4Eu176zKV8fK74t1Fnl29lHMWr
 EEY2kas2ex/dAgPq619gDE9Hu32vOeQBdy/1D3ZoGexR+vbyofRGRf9+q3TPQ21ac+V2hhdOp3/
 1jMGRM0Z4f+eDzJ10rw==
X-Proofpoint-GUID: usCfAsSKRQSwy4mqedPI2XI4futTKt5Z
X-Authority-Analysis: v=2.4 cv=R5qWitRX c=1 sm=1 tr=0 ts=6ad198af cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=PHq6YzTAAAAA:8
 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=NrrBnyfBMENEQTkef28A:9 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=ZKzU8r6zoKMcqsNulkmm:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAxMiBTYWx0ZWRfX17JfQP2iQ5lL
 qa1FKm44arCCVQDT9zMEXuAtKoyIXOkgWNSmtLlkHVqA5yywiwdelGYrkDk2XnFuJmVXIN/en+K
 4Qwm9mhmLJeVjglqnbDamN8ba4NLJ7Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160012

This series fixes two related issues in the Aquantia PHY driver:
- Patch 1 restores EEE discovery for AQR111/114C/115C by replacing
  the manual linkmode_or() with genphy_c45_pma_read_abilities().
- Patch 2 adds get_features() for AQR113C to correctly report
  10G/5G/2.5G/1G PMA capabilities.

---
Changes in v3:
- Add patch 1 to fix EEE discovery regression in aqr115c_get_features()
  affecting AQR111, AQR114C and AQR115C
- Extend commit message to note AQR113 may have the same PMA issue
- Link to v2: https://patch.msgid.link/20260924-net-phy-aqr113c-fix-pma-capability-v2-1-29b06283b0f3@oss.qualcomm.com

Changes in v2:
- Fix subject prefix to [PATCH net-next]
- Limit scope to AQR113C only as AQR113 not tested
- Link to v1: https://patch.msgid.link/20260923-net-phy-aqr113c-fix-pma-capability-v1-1-497359310f06@oss.qualcomm.com

To: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
To: Russell King <linux@armlinux.org.uk>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Hongmei Xu (2):
      net: phy: aquantia: restore EEE discovery in get_features callbacks
      net: phy: aquantia: add get_features() for AQR113C

 drivers/net/phy/aquantia/aquantia_main.c | 40 ++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 10 deletions(-)
---
base-commit: 944ae66642b726bd6b25ae71b1e9ff88a0e0bdb0
change-id: 20260917-net-phy-aqr113c-fix-pma-capability-d7d08cbc9879

Best regards,
--  
Hongmei Xu <hongmei.xu@oss.qualcomm.com>

