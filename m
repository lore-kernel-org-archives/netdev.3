Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362CC34107F
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862652; cv=none; b=gRA3ydYBkaMAqUBgGNl+1T7b8rGcgBZQyShUZLL43JVdtNrhm8z5CKeKZcaGfD/q71Uf0r9z5O8UXuSecL/42eHXAlClzbFZmujEl4F9ps9llhn51LZJckfQ+nAsIJ+eLBLUwfrFRRW/zv38rloJQrNVWVQ/3V5aqM10riFyLLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862652; c=relaxed/simple;
	bh=B8krKMqFF6Ri+E/1KL9+tNHijN33Or3878nr7vqFROo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=g/l5qYt1AOiO2d8A5fRyBM+ZpVmoMycE5m9zGtrn/T5TgWFv5jSOo4ao0nzmVNJS+ChUUgai3P11rlwucjnzzJJp2C5tAEPW+ZwhJmyKmSJhSDaenHD9thNIkNkPxSaeI7CtAavA26QwDQsoRDNKTQGyS8I7DNMuVuHLKlVRhhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cgdrg/rW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cPEBOnWj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cgdrg/rW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cPEBOnWj"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DjiB72570901
	for <netdev@vger.kernel.org>; Thu, 1 Oct 2026 13:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=K0O6Qs45TDus0yIJUBi/JI
	tW2VAUBzgWzJ2m1CkHKx8=; b=cgdrg/rWYZK5huQ+s29oen/YVZPZv+ok6ITNj9
	JIiAP+eMGqQfHm+kjiBSWWGGKYQnf/0LkZAIo/ztO5Lr9Sk1ZWXGdHmyxuwv7DOF
	cC78E60rKIuuUpRwFb8d81u3YbCyAiHeDdSn1O+RCJlrCM2M7uJQGYUHS/YUZkZF
	fgz8aQmwYtiUux2I9W89NAkVQJS4HlaCbpntWOS3nzR9ueL2nqFLf7kWxbX2oWcg
	diQ7MilYPqi2VowbyJ6vtVKpwB5x3KMvGOZJet8kcekK33KUf1lBPL3HsO8cctnX
	tx0o3GVVQPgR/JQ6zRDxRgSTwBT/6TY+3p0qFlp2rrfeMQ9g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h167pn2nw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 13:50:49 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a0312937eso877157685a.1
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 06:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790862649; x=1791467449; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=K0O6Qs45TDus0yIJUBi/JItW2VAUBzgWzJ2m1CkHKx8=;
        b=cPEBOnWj60uflNDjX4ckdtuPbODGTY3lSmwwT0906fMAPqMmCsJxqldQviHHRcFLei
         YIWjN95DUwLd16HtTdmSDjW9HJlwWRx1dqyIfp3ssJN6o3p+o/iBs47Z7unjVWEsARpn
         c92F8ELUVk+7I8NWA2qVGPi1HdjuH5bZfwKtGJ9X4N2oP3QpnOZSqIlzbFEiBSwCrPTF
         hNH7SR0+zsMbWh8Oo3x0jTQYFkx/+SHaLaQhKfe+arsOX4T4iO0nk7WHE4uDlxEA46/0
         GUCsJ2jFCq1nm6yB92KqJjWuAtM5aNa96T6U2QuofeZUPA3MH4y0+bC3n6UffuScYSVL
         cnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790862649; x=1791467449;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=K0O6Qs45TDus0yIJUBi/JItW2VAUBzgWzJ2m1CkHKx8=;
        b=AD1Gbwx1TlwdfIBZd84oP2CN7W7CoVKhT/m0Hx82fFeCHSb3gKfujHZxpZsf2fQun9
         EIzxELUNhLVrXvBLqpjY/wIxwuNI62FkTDiOapVf71us3YkBu2r25EE7KLFr+P0U/i7k
         Su9bc+ws7ACNm+251RuWYvKhzTYhMBPu78X8KCHIFzNzsivXh+cpLwimCXRTVL7Yb5+m
         FBZP/sdyZqr4Vs16/d3nSILxwEL1ywun1956R1bB8kEE99lmLUCT/UphgKiw2qJ/ojgN
         0EUxYdbb6DeLQQKHsyDdfcjEtMGqmLP4Sy+XBv/XRWIElGDBxgkvCGwWLJwBTMdoFFfp
         ClZQ==
X-Forwarded-Encrypted: i=1; AKwUvBy6eGqhqcZXslex92+fDHd8VK5dt+B3viDCjT1loUSZ2og1spuVy2UbN69yILSEkxW2D0J1LJk=@vger.kernel.org
X-Gm-Message-State: AFuF++keb6fzritjyCKeAMTFjsP+1L6Wx+HVPgGmFMKqpmEkHJCZhcUa
	vNCxKFtIjs4DzZj5t1KpBlzj0X1V9IKUIBOcD0H0hk09Z47bUtk1xRJK/irPMtE0LdgTbdvo3vz
	EboApFqVeI2lgrSS5tIn27MDw4itvEMz1aQD7ZZxW8k1CK0NZ3XTtAvHseh8=
X-Gm-Gg: AYBFou0Dq/EghDljPyV3JZgHO9EPFHN0nzYcGE5sPqEmrh07u5x8UiGHgTUrOWq54Pg
	DLyuJm9zW1fQP9my7k4a8rmVD8X/brNfBwQycFjNRK8OHK0zMY5bcDF+23dCvgJlowlStzeg5sx
	cxQiqCnxINwKngMmc0PM3dXc/bpaMyR5wRkcvF6VLMmjFiR034z5LDTiqdFFJDB9zsjj/keCm0b
	KPFuHTiuEPK+9n6bGY/5bkGKRQ2Tj4hTFk+dPhibHlsI0/AeCFfItFbDCmXCgOXfYNrmJxI9fyA
	RT7aIo0KbCc1s1TKre34nt1quYFJsQnnnB+773W1okWhxzXYmVnMVaecy2sLqb5Ag0dzY5dG2Pf
	wx8Cj+fAn2zoakQ==
X-Received: by 2002:a05:620a:2709:b0:93b:d7a2:dd32 with SMTP id af79cd13be357-93ca97e6dafmr964493985a.66.1790862648461;
        Thu, 01 Oct 2026 06:50:48 -0700 (PDT)
X-Received: by 2002:a05:620a:2709:b0:93b:d7a2:dd32 with SMTP id af79cd13be357-93ca97e6dafmr964470485a.66.1790862646085;
        Thu, 01 Oct 2026 06:50:46 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b0691c4c4sm7352068f8f.22.2026.10.01.06.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 06:50:44 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH net-next v4 0/3] net: stmmac: Introduce hw queue priority
 offload
Date: Thu, 01 Oct 2026 15:50:17 +0200
Message-Id: <20261001-stmmac-mqprio-prio-offload-v4-0-a74610d7f1e5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OTQrCMBAF4KuUrB1p0tZGV95DXORnRgOm0aQWR
 Xp3Q1YutLh58Bj43rxYwugwsV31YhEnl1wYcmlXFTNnNZwQnM2diVps6i2XkEbvlQF/u0YXoEQ
 gugRlobFSWNlTr41kGbhGJPco+IENOMKAj5Ed8+Xs0hjis6xOvNz/GZg4cOgaIXnXk9Gd3IeU1
 re7upjg/TpH0SfxIYp2URRQA1kr9WaLZAz9EJtPcfnHJotKa+SSU1eL9os4z/Mbyz4iGXkBAAA
 =
X-Change-ID: 20260918-stmmac-mqprio-prio-offload-3d82d87f7bc8
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vladimir Oltean <olteanv@gmail.com>, Furong Xu <0x1207@gmail.com>
Cc: Daniel Thompson <daniel@riscstar.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
        Davide Caratti <dcaratti@redhat.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: 8upZpmDHUhDQ1fUid-UOA40J_BB54mat
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1NSBTYWx0ZWRfX5hiPbwaAq4Cv
 4wVWCZ+gwFJ0OTa+Z0mJ1d78QEn9SP2HHothB9OzWshTtmFHTQs/Vmes9l2dWMHiOwXjPpg1aNS
 U78ptclC8KOdk0xF7tpOM9mHxCea0AI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1NSBTYWx0ZWRfX+cDnN507bouE
 MXgFXl77qU1QSZcalYsQ8rFpojuqmKaQqu1Dqzw7pXgVsHPgDs3bWVX4g3MU0hKq1/tDxQYQwXQ
 KUacqWibnkyLczB3Bcoc6y8DXx8m18DbnUbjktk3FNMzOaWBL7hsN5NW4Aw6DVr+st/tLOSGw+B
 RS3ppWWgkCoZt7/iMjedNv5SHQ5lrUi+kxAaQOfq/otdHNBXe+5F29MW6aBTUXazLFy0ShHRl1o
 FgIbW3HraXwb4iXBR4XNRLyKSlP/3quCBZHddjiqnqTmB1nIIhCUgVhRSsMy5BJfep5MiovSDzr
 AmoKSWnXIB6aKhdoBxe4lUkVFI4Iw/IrqgPxOyoq7BDJGUB5JAlqmPTdG59WOFxbHPZysqMmtjs
 JV7JzNOhlcU5blpRnbQ+iN55S2bFe9hkqGuilYEnqImDMEn8AoygfO88r+Lbf6wyQIQxVTJdpOg
 uVSMunJhz5NGDKIw3DA==
X-Proofpoint-GUID: 8upZpmDHUhDQ1fUid-UOA40J_BB54mat
X-Authority-Analysis: v=2.4 cv=WpC+otfv c=1 sm=1 tr=0 ts=6abe6539 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=kCoPmbC7odpt6DihikQA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010055

Implement the offload of the tc mqprio hw queue priority in the stmmac
driver. This feature requires the mqprio to be configured in channel
mode.
Do not overwrite real_num_tx_queues configured by the qdisc in
stmmac_hw_setup().

The misbehaviour has been reported by Shashank and the patch has been
tested on a Qualcomm RB3-Gen2 board.

---
Changes in v4:
- Move real_num_tx_queues fix before mqprio offload patch in order to
  allow easy backporting.
- Add patch 'net: stmmac: set real_num_tx_queues from max(offset +
  count)' to fix the real_num_tx_queues configuration.
- Link to v3: https://lore.kernel.org/r/20260928-stmmac-mqprio-prio-offload-v3-0-abbe181f5024@oss.qualcomm.com

Changes in v3:
- Fix cbs overwriting removing mqprio qdisc configured in dcb mode.
- Return an error in stmmac_reinit_queues() if configured number of tx
  queues is lower than xmit_qdisc.num_tx_queues and mqprio offloading is
  enabled.
- Link to v2: https://lore.kernel.org/r/20260924-stmmac-mqprio-prio-offload-v2-0-fdd8b69efccf@oss.qualcomm.com

Changes in v2:
- Forbid cbs queue offload if mqprio is already enabled.
- SP requires 1:1 TC to TXQ map.
- Fix the real_num_tx_queue overwrite during device open.
- Require the qdisc to be configured in channel mode to enable hw queue
  priority offload in order to not introduce any regression in the
  previous driver behaviour.
- Link to v1: https://lore.kernel.org/r/20260918-stmmac-mqprio-prio-offload-v1-1-5328157fcb58@oss.qualcomm.com

---
Lorenzo Bianconi (3):
      net: stmmac: set real_num_tx_queues to max(offset + count)
      net: stmmac: align real_num_tx_queues to mqprio configuration
      net: stmmac: add tc mqprio hw queue priority offload

 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   9 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c  |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  37 ++++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 147 ++++++++++++++++++++--
 4 files changed, 172 insertions(+), 23 deletions(-)
---
base-commit: eb0c18404c8943356f4aa164e5db9067b79ea93c
change-id: 20260918-stmmac-mqprio-prio-offload-3d82d87f7bc8

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

