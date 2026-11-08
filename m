Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794143916;
	b=kuDNvx4pIcbucwekFBFHnMkMHz4AxcH870+2sumKDUW/V0KSwAXM51AdXxCTbwPnEK9s
	 pMnwUkEFZu5ttFUtsmRTaz2YIqDfbkMsNWBn9vWgqJKSwHX3j6SUgmE6/E4K4X9HcTeMk
	 VeUWCqkrDxiqSwQ6EloLuhbJAhUxo9vUXm+H/4l5zF+BSS1L/wQasj8piLh4MdUgaesV7
	 bqhuGWo3vZlslz+KzzZDa+HSdAOjEcAuu790TSb323+h49lEyCJOjUxTUPILz6cWoG9MT
	 9wQa3Bb0XJS+YkXNzUWxnB03fXZdycreYEaeoVMFRDboxU0QwpiDqzGbzA7ZvQgwXsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794143916;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=7Y04tqt6QoAZDnmim+FnFs7Mh/95J1U07zdy+ADsQEA=;
	b=WAR9aDFAYDjjoIsAq+9/xxdyIsuMv0EbQ2RTIWkLZY6NphH0BZhyw/9WuFGMdecmq6hr
	 iuav51yiq6aCDvBI2neT1Y0XBoUtlpcJa12hJOFP6HaANzf02fEuhd77zstAEPFhcZH6r
	 1yqRVMXTaCw1jl0GPz5zsk8MDQc1jNXHpnuuTB/SqVCq+Ne+mz+0sE4FJ0EdZ/yJ/WtUX
	 cpFxn2KQvgiLWkWxReZhXSonF6b2KsVisYmS0c3QJy0D9E4GZPwRzF8fF8PSv3qvTakn6
	 p87Qihl+iStJaDibaahVsYXPzpraKzCPykmE9h0CjwT5iWUCIBN9ai8GAZxvRLLdTeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=INCH0h+q;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EcwhhSsr;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E760606A322
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 13:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E760606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=INCH0h+q;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EcwhhSsr
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A8Ah5QC285109
	for <netdev@vger.kernel.org>; Sun, 8 Nov 2026 13:18:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=7Y04tqt6QoAZDnmim+FnFs
	7Mh/95J1U07zdy+ADsQEA=; b=INCH0h+qeF4laeKeCp+7aqaVhTBbw0X0nK58Ur
	K8NEIPlATJ4/CqP8cDSXlcZxQA2pNptLgDq4tey47fOiiUln6pYTDvp4rJFjbROa
	U8/V/mOnol2EWaMQ4QbxsgiLsPOo+XZo+zVExUj1xdOe6lv9ENyB1vP0g4yyg8US
	tEPGNul/H+4FnoKWN/tqDE3dccJHVa1XDX2dZWgZvjjfuv0HJVTkIZLRExmg1yeW
	reaw1u8sANtVTznavSFLH2M50DHFtLe38nPkwuatpUmu4E/wM7laehVyu1FeHp0k
	xtORaPeJjgiXHfqNSVG9qutqqIKTqC2d24J+5DxWZuHn33BQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsw99jsta-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 13:18:34 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30bcb065bfdso217942eec.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 05:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794143914; x=1794748714; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7Y04tqt6QoAZDnmim+FnFs7Mh/95J1U07zdy+ADsQEA=;
        b=EcwhhSsr2cyu720msVU44f1//T0TOwAuIuYm8V0vDNUBinACSsAQP0BHuNwNVSxi9g
         90LZmzaYpf2ypismWhKOOxS+T3JfpjB692BsA4Sv2w6do9WK3VRKx8s9S6j/fPWYPIgX
         wC1cKypyZz9Y7N8mrkjL+QAJh8wJpaV01HYPcwI/4h68TG5QEknCcC4eH+M+6YSzGvhR
         C5r72BhZQb1vbe0e5ZGz8jqTqBo6bL67tgiCmq2tiRxk0pQ0oe8NWMXJxJteiqa6xYrO
         n0kHrahB44DZQ2Aql+W9aojRx2BbifcY4UfiCm5nJqSHFfQC4H9fQJBRpXCdW/c/JY5w
         JRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794143914; x=1794748714;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7Y04tqt6QoAZDnmim+FnFs7Mh/95J1U07zdy+ADsQEA=;
        b=j6B7oNi7oqw1mytv87zmohtkQzjzrs928zzZGVbrH++SNjSs6c3NQv74ElrYiXPoms
         3Evyx8gWtkS5JiVKItlMgoGEY0DuDtFyohKqNmy3nRfsfPw2BhWZKTk69ygYYQ1y2z5b
         sJX2V2yRFMdG/iSD8FS5lXuAzF7krSAijOsmZi8FlhOPYqk5lkm+prFxIjJmtuVy0H31
         pJFkFg48OE/fgb5H5E5qO19k9i2g6KAe9tpJsxKOakVKodR3QuO7+IEX1jlVVd/nfCb8
         yEhU3LcNSng2GqMwaMDiwxdPrUFqYuil7lUObPh+JdKKe3QwCErB2fb86MdyEjhd1a+e
         cfww==
X-Forwarded-Encrypted: i=1; AL+hErGxiYJJ9gh2OcIha9pBHxGXb5ccg3LwvIrfXDVB2tAyAsGwWag4uI8IGagIurC8CQJX+16xlq8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ZWe9qmkSXs5OeAxDodcjBhp8ww/yNVP31OCnonjuzps40cp9B
	LXog8NwPxqjVnGs+GQHgvKD66uP+b8DFIF7yON6d7dhT8H6TJ2Eyo+bX3h/DtmwKVeZ+LpBQ5fY
	Hc9kpZAVG6BIV3ckid3SKjajcPi8hdykZJH1nKSTeHwgHr+SO0INywFDilJ4=
X-Gm-Gg: AYBFou0zKdkGj1ccaxPQAeIBM6nlzIR5PaZsYQxku9dbk8MeW6vuxEjBmQ7AonzPLhb
	fcB0G2G6AtckRxMVmWL9bTSE6vHzGGBVKbTyexrjLofBaZWcYTSuwhQ/oC5PBqRISOUsy7hORKe
	G5+e/FOsmq7fPTz9OaFtKSHbWkDTwSoeVU/6NhhLa19vEU9bkVorR+tt54MWYXQta+8Os34ZTWk
	2xi3Qbgdcye2tyjbwxVvSvYuWaD6Yw/QUxOxnx27gFJ7V+JIeGjZT6Ih9erDtzmCSPxexQ/rJca
	WWi3+u2VL6fZoVmf1M6Pb+OvktKUeydUhHkT37w6M2l/7mYgKC+MzOgoWhXpwuHxjNtAKB563jz
	Mk5IL5Z2Rt++JJgphwoP7A4Epi+UjNgE2d4m0VhA8Tqbsk4s/UM63iGr5ptmZr3smZIvbvuIgrT
	VB4vU=
X-Received: by 2002:a05:701b:2214:b0:1b2:611a:89fd with SMTP id a92af1059eb24-1b39feda27cmr1957813c88.45.1794143913274;
        Sun, 08 Nov 2026 05:18:33 -0800 (PST)
X-Received: by 2002:a05:701b:2214:b0:1b2:611a:89fd with SMTP id a92af1059eb24-1b39feda27cmr1957781c88.45.1794143912612;
        Sun, 08 Nov 2026 05:18:32 -0800 (PST)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3757214cbsm5336980c88.13.2026.11.08.05.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 05:18:32 -0800 (PST)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Subject: [PATCH v2 00/10] Add support for Qualcomm TSCSS hardware
Date: Sun, 08 Nov 2026 18:48:21 +0530
Message-Id: <20261108-tscss-v2-0-d5f575010427@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAJ528GoC/0XO3YrDIBCG4VsJHq/FMRqzOep9LCWoM2mFbU01C
 buU3vtOf2BPhE+Gh/cmKpVEVQzNTRTaUk35wkN/NCKe/OVIMiFvoZXulFNWLjXWKo0B7I2JQOQ
 E386FpvTzdL4OvE+pLrn8PtkNHr9vQbu3sIFUMhAhGHLagtrnWnfX1X/HfD7v+BGH+0sudF05b
 Hnx/12cySaAcvIY45h0HNke6zrPuSyyM963VmMbAAeOYCz4SvLhp2VoECeyEJRXk8X4SQZsjDr
 2HnsM4GyrEY3uAnfc/wA0kiO4KAEAAA==
X-Change-ID: 20260705-tscss-441d844c1ee7
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Eric Dumazet <edumazet@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Eric Dumazet <edumazet@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Imran Shaik <imran.shaik@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: ZlcJOWlnpYkl6Ae9dStZ1dyO5O_K25dm
X-Proofpoint-GUID: ZlcJOWlnpYkl6Ae9dStZ1dyO5O_K25dm
X-Authority-Analysis: v=2.4 cv=CMq/zhrD c=1 sm=1 tr=0 ts=6af076aa cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8
 a=20KFwNOVAAAA:8 a=CLs3rlwnB2RECI_rIAYA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDA1MiBTYWx0ZWRfX3KNoWhZWruJP
 a9cQXP0VbrpYWrLohG9HfwvAXuG2ASsga3zhAlsKi9vxUjIkoYD0grtooHnFZr6miIcy0DGQN+p
 t30TUerr9xeGfVAK/l5EBI8et1LC0nY7dcTAM5R0qesxEWD91UvqXZZMFvH24GNvOa80ppL6Hd6
 jXkVWExQl1TRvmQTuAkdlN90DPWiTHI3v+1B2QMQlTGUNPSqFg0wQXhOlmXsNDH89oY8ziweHkk
 E2LfOVvAYtJLK08X+KJL4lyJPs/Q/nWr4lmTvFtpAEIS1nGE0HR8hEvzXYUprSNSGjvWTx3Sq3T
 xJC0awjUvYRQGLvXgkp38Ane8awuOztsQigipt3TvluHH1jiYVMb3p/bkJA45aRCLF9AZjfAgJM
 NGLrkFY5xbpIUElWipC1C6qmEVn0MBjniwpKBaneO+0NokX3Xg3IyL09omyYRd74qb5zdA9b7a7
 AmO6IxReyV2vltEw4jA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA4MDA1MiBTYWx0ZWRfX9of5El/T+PK2
 Kj+4LDj3rPLypjZKAxfy/7nSy8tcvW8LTd4x5ZjrHFZl7xwD0+EDCQ3eeDFKa8mHU45LaNWBlh+
 0M7ijlofSbA+qjrKTtxDpuuytxTux3U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-08_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611080052

This series introduces support for the Qualcomm Timestamp Counter Subsystem
(TSCSS) hardware, a time synchronization subsystem present on Qualcomm
Lemans, Monaco and QDU1000 SoCs.

TSCSS is composed of two main hardware blocks:
 - Timestamp Counter (TSC): a free-running hardware counter that provides
   continuous timekeeping for the SoC, and is functional with a GCC TSC AHB
   config clock and a global counter clock. The TSC counter resolution and
   supported functionalities vary across SoC variants.

 - Event Timestamp Unit (ETU): It captures TSC counter timestamps against
   external hardware events. Each ETU slice binds a slice identifier to
   an external event selector, and the ETU additionally requires its own
   clock, pinctrl along with either a per-slice interrupt (QDU1000) or
   a single summary interrupt across all ETU slices (Lemans and Monaco).

 +------------------------------------------------+  +------------------+
 | Global clock controller - TSC AHB/CNTR/ETU CLK |  |  EVENT_IN[0:15]  |
 +------------------------------------------------+  +------------------+
                          |                                  |
                          v                                  v
 +----------------------------------------------------------------------+
 |               Timestamp Counter Subsystem (TSCSS)                    |
 |                                                                      |
 |                   +----------------------------------------------+   |
 |  +------------+   |         Event Timestamp Unit (ETU)           |   |
 |  | Timestamp  |   |           0x01C90000-0x01C9FFFF              |   |
 |  |  Counter   |   | +------------------------------------------+ |   |
 |  |   (TSC)    |   | |               ETU Slices                 | |   |
 |  |            |   | | [Slice 0]  [Slice 1]   [...]  [Slice 15] | |   |
 |  | 0x1C80000  |   | | 0x1C90000  0x1C91000          0x1C9F000  | |   |
 |  +------------+   | |                                          | |   |
 |                   | +-----------+------------------------------+ |   |
 |                   +-------------|--------------------+-----------+   |
 |                                 |                    |               |
 +---------------------------------|--------------------|---------------+
                                   |                    |
                                   v                    v
                         +----------------------------------------+
                         |    per-slice IRQ  (OR)  summary IRQ    |
                         |      (QDU1000)            (Lemans)     |
                         +----------------------------------------+
                                             |
                                             v
                              +-----------------------------+
                              |   Interrupt Controller      |
                              +-----------------------------+

The address offsets shown in the diagram above are specific to Qualcomm
Lemans SoC.

The Qualcomm Nord SoC additionally has a timer register region used to
generate a periodic pulse in sync with the TSC counter.

This series currently covers only the TSC block driver functionality; ETU
driver support will follow in a later series.

Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
---
Changes in v2:
- Fixed SoC names, and updated bindings as per review comments on v1 [Krzysztof]
- Added ARCH_QCOM in Kconfig, fixed the probe() and remove() order, and
  used dev_err_probe [Krzysztof]
- Dropped the unnecessary "inline" keyword [Jakub]
- Added support for Nord and Shikra SoCs, which support continuous dynamic
  dynamic drift correction.
- Updated the clocks handling.
- Link to v1: https://lore.kernel.org/r/20260727-tscss-v1-0-beed14e72510@oss.qualcomm.com

To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Richard Cochran <richardcochran@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
To: Abel Vesa <abelvesa@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>
Cc: Imran Shaik <imran.shaik@oss.qualcomm.com>
Cc: Taniya Das <taniya.das@oss.qualcomm.com>
Cc: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org

---
Imran Shaik (10):
      dt-bindings: ptp: Document the TSCSS on Qualcomm SA8775P and QCS8300 SoCs
      dt-bindings: ptp: Document TSCSS hardware on Qualcomm QDU1000 SoC
      dt-bindings: ptp: Document TSCSS hardware on Qualcomm Nord and Shikra SoCs
      ptp: qcom: Add PTP driver for the Qualcomm TSC hardware
      arm64: defconfig: Enable Qualcomm TSC driver
      arm64: dts: qcom: lemans: Add support for TSCSS node
      arm64: dts: qcom: monaco: Add support for TSCSS node
      arm64: dts: qcom: qdu1000: Add support for TSCSS node
      arm64: dts: qcom: shikra: Add support for TSCSS node
      arm64: dts: qcom: nord: Add support for TSCSS node

 .../devicetree/bindings/ptp/qcom,nord-tscss.yaml   | 186 +++++++
 .../bindings/ptp/qcom,qdu1000-tscss.yaml           | 170 ++++++
 .../bindings/ptp/qcom,sa8775p-tscss.yaml           | 169 ++++++
 arch/arm64/boot/dts/qcom/lemans.dtsi               |  12 +
 arch/arm64/boot/dts/qcom/monaco.dtsi               |  12 +
 arch/arm64/boot/dts/qcom/nord-embedded.dtsi        |  14 +
 arch/arm64/boot/dts/qcom/qdu1000.dtsi              |  13 +
 arch/arm64/boot/dts/qcom/shikra.dtsi               |  12 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/ptp/Kconfig                                |  11 +
 drivers/ptp/Makefile                               |   1 +
 drivers/ptp/ptp_qcom_tsc.c                         | 598 +++++++++++++++++++++
 12 files changed, 1199 insertions(+)
---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
change-id: 20260705-tscss-441d844c1ee7
prerequisite-change-id: 20261107-gcc_i2c_tsc_support-64aa352d3b1d:v1
prerequisite-patch-id: 8c93973348ea4b80f1dfcd445a8a3afb8a530d21
prerequisite-patch-id: 5a3418fa67b14fd6b67e00f8c21ee699fedb320d

Best regards,
--  
Imran Shaik <imran.shaik@oss.qualcomm.com>

