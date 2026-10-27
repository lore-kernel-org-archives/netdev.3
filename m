Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108939;
	b=Ta8hOG5nIx18yl8kn3U3QkhvRb/UTI7YuFYf+SP3stJrvn6GomqIDrHvJ5oPrO2RweGq
	 QLDUXZkD+G8tLISKCtSLgOJsD1k1HlCBnXooDVPekeQ20d1vwDKRcR35zUvkAOd0MyC2b
	 ODc3CJk/NjrPzGFbsZQyBZNj1KLKGILu71nhkZA5hIlUOf/T4ogUjn2CF1XpYXD3TTodJ
	 xk99DqBLQWw66/TonkCL+x/XUehHTpFsrXS9Cpin5HTEqiwBWxoSH708z/FdX4juLRnch
	 quo9y53WDUDdDCUFkUrnvf6EjCD6vPYdd+lGT0yCy2B9Uj/otViqg5wtzqDOO/nlV9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108939;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=gogy6K4mHkApebhkUBNBSa8MX+km/CbZiAD1dzn6BOk=;
	b=OKqMbz5HdqziU/JkZmp1E0m1OjjNGTwDfo4+UM2U/JF3Tr1XhnY+41xzS8hlgIv0ioVx
	 YH3HFOd4X/5fTzEzBvrDVd3xuWq1Vbw45zfiJ5W5ZRa6yI9VvETgOZ4J31kqrWv41bsiq
	 zMb6YDSxDTicQiVF6NJUQjbyXPBaLq06BBnruae9z8Dy+ajuAdY0OEWaDxm68EY4W22v/
	 szApFWyHSE1H6N3s61FbSUvYMHtGBqFO6Zw233CAmGTognUJzcGGJx5bR4AnJ0+q9Zk1u
	 uJ2FeJgD9lC6F4Wgg0gzsN7zs6FaFw+Fhwb+tp8a3ViKE0Dz8Cd8h9P/IlPV0S2t4EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kendgb81;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QM3n1G7W;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98E5606A31D
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B98E5606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kendgb81;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QM3n1G7W
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RAdwSe1614533
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=gogy6K4mHkApebhkUBNBSa
	8MX+km/CbZiAD1dzn6BOk=; b=kendgb81mmep/bYskIEz2TaH/+8gari5zUDnUM
	l4OzLDP1YMi6b7/oECUovafhPY44oIAqGpo1CKoOs67WAJOmwDBBdEZr5nS0nXTO
	eNFnjOjCJeMF8ZfmP0bb1vr6NTO2eqDthyejVB44FFpZOmvWcbTdAx9RzX5jL7Yt
	ylPs0o6naSYjurrf/qN9TgiyMqheefsrnXdtg0TuzjEDKW+x/qhqijQgU93hEkr6
	ctgdJVmWHJ6CevI91z9q17KIbT5bsCUHg/ZXnWOChLoRvkhOMKFArWycBlEfjp1J
	7yovPzFx+2MNL8e7fziPZlsa+tNo1QFNl581PJjQST2Epi0w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjqf5sg14-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:48:57 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cb7f9bb86so829141085a.2
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 06:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793108937; x=1793713737; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gogy6K4mHkApebhkUBNBSa8MX+km/CbZiAD1dzn6BOk=;
        b=QM3n1G7Wnk9cxTMv19mswNr2gmEet/0GAbI4im6QSVSRe05637BsEem0E+Dql+/1qM
         klZ5jz6gIMIsLaZbNiieOGTRpDB9sp8fgJ8gCbPMjetOblqTgbVMfMTc00F+Eeh2M0No
         TxcjbIpPejx9btbJ4roo03Dkcn7Uko1pmFGpWDjZGrNXjhUXV8ZQIdy+wkirGNPABHuW
         v7TlFmMFwAIaYlJ2kHS4JWB1HiBqdRVwmSLjQbZEVjfPxTJTe3+Aw0PEwbT6c66F9i66
         KWRYG592nt+79U1ghnCEe7u/9jp5XQmrnWW7/ByqRfARttrtKzlLgMY+HAH01LRv3HMH
         PDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793108937; x=1793713737;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gogy6K4mHkApebhkUBNBSa8MX+km/CbZiAD1dzn6BOk=;
        b=mm99WnsuryHKguRRtNJz15vxcjd7F+xzgFzeY19CZ0KfoRdb75Brpz/Adb0Qlf0wsz
         jrk3o7OiGcvd0L8UfGTqtIaPdSdtqBEbywo7Iv8a6F7YKphvZaEDBmUpi43584QjC0Nr
         9fsr0RFLLCdwWgo0g66AuFAXY8jvCL4cJgjBZyVHU3xXTCVRrV52yVk1Mu+Mzca4Xng8
         XR4tsWZTZAChCkioS4Qw46CTE3qYKI+MqlxUC/iolRp4MNkJNKddohqA1mbyzzpvFcI7
         aUYX0xQGifVe6jEWE/+5yIio0YaiPbKiOTheHPsKT2WNYQ8EyfXNdYBwIADZg8SPfh5E
         oTkQ==
X-Gm-Message-State: AFq9FYLPLkrEKYypmhDipg58R70XFtcBtCLYSwAx9WYzysRr9Ur9q4/Y
	acpZ5/rL5qd96/XnPL4G8OkgSGqleJDIG2fwxTM0tL9z71dqRifLIDnF6Z6ZLMN0KXlwUuLLyIK
	iOWlkBgN2coTrTCugFBUqtJhy+XCe7QJFAHRR1F/G4i5f5AUgxYRYStJcha8=
X-Gm-Gg: AYBFou1UIwYAlvJ4/WggsSfEYNRCVS7tkYepwp+AgceEMyrgaeXulDb5441a30ebVjm
	Ftl26JNbGslzOnFZXZzWtN2VwuoYckuDhZMzr7Bt1lPHMW3UlLfj+CbCL/R9TSrRQsxfV8y/phl
	C+UR8GtyUh9TI926vmif2dZnubKOnWPyLSvLsTsQ7Hp//qS3rlR4axyQzPazimPX/tNxT0Er8op
	qb7R5Crll0kNQ77C26IV6oa0wVBCKqvGWueAKs/j7MTdcQQrF2uXRy3R7MiGkg/P1f6NAzucdVC
	/pl9Af+jvcPpgnWuF5FTs5Db19OTCig4PvMPVEBLjmvUyK//iS366X/EDzdYxOaXTDgSCBMgYBa
	VBMkry/G5DqQ=
X-Received: by 2002:a05:620a:4150:b0:939:4a44:5f99 with SMTP id af79cd13be357-940ef79eef6mr1574207185a.10.1793108936763;
        Tue, 27 Oct 2026 06:48:56 -0700 (PDT)
X-Received: by 2002:a05:620a:4150:b0:939:4a44:5f99 with SMTP id af79cd13be357-940ef79eef6mr1574201185a.10.1793108936217;
        Tue, 27 Oct 2026 06:48:56 -0700 (PDT)
Received: from localhost ([93.144.6.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd7981a7sm455880366b.72.2026.10.27.06.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:48:54 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH net v2 0/6] net: stmmac: XDP path fixes
Date: Tue, 27 Oct 2026 14:48:35 +0100
Message-Id: <20261027-stmmac-xdp-fixes-v2-0-10eae8a093a8@oss.qualcomm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQqDMBBEf0X23JUkYsWe+h/FQzSbGmgSm7ViE
 f+9IfdeBmYeM3MAU3LEcKsOSLQ5djFkoy4VTLMOT0Jnsgcl1FUK1SCv3usJd7OgdTsxCqG1ak3
 Xaysh15ZEBeTWAwKtMORwdrzG9C03myzo/+ImUSDZselI9rYdzT0y1++Pfk3R+zoLDOd5/gBnV
 dJLvAAAAA==
X-Change-ID: 20261023-stmmac-xdp-fixes-00aa25d79af1
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>,
        Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfX8mdJy5OV+J2r
 c4VNG7NjPXpCorNuPCEaWGbx78IKxo8Y2TxSKmevVE5xZeSyreIkE4fY13PFRJ7Yg0RGYoOKDaZ
 J9kik6aD0hI7KpQu6EqpERJHjcD1ca0=
X-Proofpoint-ORIG-GUID: 3rVK0rrJaYZJTmG0RQTJy8V7A9NJPjWf
X-Proofpoint-GUID: 3rVK0rrJaYZJTmG0RQTJy8V7A9NJPjWf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfX38D7dqkDIqff
 hZ9B8N/ScfeOh9aqgzOM+FF5V9+wnt6ESL8QPW+nyNJ4JdS92l0REm2mZoQlWpRbRM2ns3kZD75
 /5s4zDAzXgq+4K4tWfF7oDEBBIchH4WNTT+QvzVZiFj+K8JxqugNsBeJ3ghoN72s7Zm/D7/C98B
 jvngjz68+5ckxK98XRftO+16uDCAn4dPGJNEMKN6/ZfObr+a/Oy6qiZ4ixwKm2yUrpbG72XY2z9
 AwUGr3KFntSOxGNYeXJhF6ibrJGyzUqeNFP7yZ4YU0PWga9+NzLfKMgwzV0Gh8KIHyT0iYIKb8V
 Q8ST0mA8nLbjEVt2YFNEpPP2ZgkCUZjr3N/YlfJt6940fyazCgXzAPfQhs8pPGB7HKzj68wUYsX
 cw5kcfHSW0HD2/xCRymtlhdTTnWvStO0kAyw+pvNKZzuYcNja1D/OM37mOlnBNW/0L1VzIvi1MF
 Sfmavmq0LOXg41A0KCw==
X-Authority-Analysis: v=2.4 cv=UOFIjyfy c=1 sm=1 tr=0 ts=6ae0abc9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gDgEgTsMjVfdaljlQWwA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270054

This series adds some stmmac XDP preliminary fixes needed to introduce XDP
RX multi-buff support.

---
Changes in v2:
- Rebase on top of net main branch
- Fix commit messages
- In order to avoid possible dirty cache overwrites, sync the full page
  dropping the xdp_buff in stmmac_rx().
- Link to v1: https://lore.kernel.org/r/20261023-stmmac-xdp-fixes-v1-0-efb37e19f5bd@oss.qualcomm.com

---
James Hilliard (1):
      net: stmmac: take ownership of saved RX state at poll entry

Lorenzo Bianconi (5):
      net: stmmac: drop split frames on AF_XDP zero-copy RX
      net: stmmac: drop multi-buffer frames in XDP mode
      net: stmmac: copy XDP metadata in AF_XDP zero-copy RX
      net: stmmac: fix VLAN tag stripping on short and non-linear RX frames
      net: stmmac: fix XDP RX buffer DMA sync length

 drivers/net/ethernet/stmicro/stmmac/enh_desc.c    |   2 +-
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c   |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 194 ++++++++++++----------
 3 files changed, 112 insertions(+), 86 deletions(-)
---
base-commit: f75062536e2d45ee182828f0e47e0124be2fdc8d
change-id: 20261023-stmmac-xdp-fixes-00aa25d79af1

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

