Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580253E5A35
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 08:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792224742; cv=none; b=dk7q57nuP6uLemRFWJWNkA+8XBAXPQZSDrQV0vDShLsXsaJTTrRhF5sX/hX8hhcRqAJLtXdICkOHbl5fCRPohwPhRwfi9FDezRT5T2fErqnhQy4BoSHV1oUC9D5jYd45Kpqick+R53YDdVSwFDw3IpuLPCRXNydwax4KhhF5QrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792224742; c=relaxed/simple;
	bh=khBE5gCLlHDnx/hehXcl92gZyzTRmZ7UB26qS9fKfiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DymoeM+ztrqNq2fzf3dh3UoF//8FnM9ksrSR4sUUfO0ZX7QwpOzncaOgv7qxtLPUjWx7MRPpLzCuV0kDdOG3S2tgzcQp27yhUOTo6Xl732cvk2QHIhc0lQGTPr2dO/x2WzXa5lMBmY7Pxo2EFX1dwm9imSeF8vVFTJnAIT2HQiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zma5IAPA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L9xySSyl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zma5IAPA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L9xySSyl"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69H6oc5s1403708
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 08:12:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=z1bHXN9EBW1qn2KGDBVGxGLF
	4ixZx98AkY9JtEtX9RQ=; b=Zma5IAPA8Rx+ZZuYiDPwW8YTWIOjTYyoGvPY7LU+
	daREA0USMJraf5joe/13BpEP7bugKb/QCtj3TCpjMdmJJwo8coivvHommIxSFjW6
	k17af+tDAjvb0JtsKQrmwbV2iBtR8jRPI1FdyrjVyZKKt7uTHo3B38SDNxBRMNSb
	hGc2vj/g7kyazMGJT67EccmrgP401ER67wW4GCc/LEgXDU0IXOh/mu9l2q32wCdz
	/pwuuQgE4dgdj0e301Co6uI2DRb3xtBZ3eZgmUYbT87XuTsn6PaicgYyCJ4iBDI0
	WXW9Vbbh7+ly4w5EX23s21YM7hnZR8pnEOKaz16zTnh45g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbyys0mkq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 08:12:16 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3580c07911eso1784469eec.0
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 01:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792224736; x=1792829536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z1bHXN9EBW1qn2KGDBVGxGLF4ixZx98AkY9JtEtX9RQ=;
        b=L9xySSyl0kJXIPIBKF/uWuy8bwzwdeR8BhTNV3z55FN7jCf5tns1azmhJVMRbWIPc0
         4VvXBN9MqCdPzHbIzL5+4osEOs3i+5tZpYxxDyaanROn9vL6nAZ3Nvz4/pK4yufORsuQ
         JKHKJZEzuZSfGheDxM7dlG6U2KAIPVQ9M9Y9o+WwV/XfQBIxd+bhLKTWehi2y/WEPio/
         63LAqr4uOZvbAUUWCHIEKB9lkSe2HYWE8FaT8XEzbeHl/29BXhqZkGsVktls31APzeGD
         ZgSxvtOK7r0+8vonaKsWnR8ZC43kpsLuqJLHQm922gn6HnrgXC2CAT+iDn8TREUfDHIf
         uYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792224736; x=1792829536;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z1bHXN9EBW1qn2KGDBVGxGLF4ixZx98AkY9JtEtX9RQ=;
        b=KOa6lhCT5W3QziaXzfmZxyYUOdpln7EHwbTB7QWPV4PbLr8IfYm6PcQBseD+GY83o1
         A+YOwN7VleDatOIJ9X971PiDRZBrjlUhPYfY4y6VdK3aWzcA5TiRdvMdT9+cwD+Q8umP
         Z43DrUq5mWAGRfg931uLEM5j+CjpL0mUpPXI9x9PcP1qIoNWQCYWRvilKoNJDBOv1knq
         G6ic50bgxNYMvwhi4lyl9AYg6bzBM9WvXB7m7o8fnYgtJOjfLjHpDpqzQp6CtiniJr2G
         izkbVnEFMRtzDqieVU9vqfiSMzY0o1GgHbKR3hQP8iV89CITq5nYhyG1JJVaXfR0GuRq
         cXfQ==
X-Forwarded-Encrypted: i=1; AKwUvBzuThDyWi/c8jo2sXPn5/Q/P5RNXHbd1ktuwcawLr8UpYAqKmB7UcNWsk5LG0USe5C2BvJY/ck=@vger.kernel.org
X-Gm-Message-State: AFq9FYK0zb9U6A819tpEoBeMb9NpD8LwKR505RQ9bhJVF66YBLFH/J1t
	6ZMK+bTWgjYZsm/HUe80EUQRd4KmQL1RwnR79dvJUuI6zBk68Q0KvUS/4q8Ena48pETXTa2s+tR
	FBQtZ/hP3+ZEiPBGZH1hJFsPoLZDsBXZc1qQ1OY/tG96dtOZmblQqq7AhgTY=
X-Gm-Gg: AYBFou1eSidQ3T+UHIz3YXjS1sz0OlU21Ul32oD9DyviFD/Fg781FO9nGdDs8qt3DRV
	c2nQRCeS5C1Rk70GH2bUy7Q933XT3LvAWN/6B8eCHdlOjVo4i2yTHWW4mniiu8rf+L77DjpbrTl
	Tpy4k/+jNqa3bKSOdXi3HvQVr6KqUCMm60ahNeNz3VlmumpW+crNSpjoNTVS2VJu14s4d1QR7/W
	e6RiiJkWtPVCpZPvb3Ec8NNdqivaLTSvYYi2qm83J71HWPzGAvkDB0xhPJjFBV3CerzZt8UZYql
	cBnRpYbrkjLi55ovCU2nJFD+9ysUfGLagSHljISy9h7OWLfiZmJM4PWzMQCHENBNdGWVDxd1j+8
	2mnycEfkxg0ia
X-Received: by 2002:a05:7301:b13:b0:360:dfac:6817 with SMTP id 5a478bee46e88-361a18632fdmr2926437eec.18.1792224736009;
        Sat, 17 Oct 2026 01:12:16 -0700 (PDT)
X-Received: by 2002:a05:7301:b13:b0:360:dfac:6817 with SMTP id 5a478bee46e88-361a18632fdmr2926398eec.18.1792224735267;
        Sat, 17 Oct 2026 01:12:15 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360826875b3sm13566623eec.21.2026.10.17.01.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 01:12:14 -0700 (PDT)
Date: Sat, 17 Oct 2026 13:42:06 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alex Elder <elder@riscstar.com>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, hkallweit1@gmail.com,
        linux@armlinux.org.uk, Daniel Thompson <daniel@riscstar.com>,
        ansuelsmth@gmail.com, donggeunyoo.kernel@gmail.com,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: phy: qcom: qca808x: Add regulator
 management
Message-ID: <atMt1nbVPsZJFDz8@oss.qualcomm.com>
References: <20261015143849.483339-1-elder@riscstar.com>
 <20261015143849.483339-3-elder@riscstar.com>
 <atDz2hJ6xpA3p5y7@lore-desk>
 <4fc165eb-b57d-41f8-b7b9-c9fe433d866c@riscstar.com>
 <1af4e7a8-adb9-41bd-8841-61180b284470@lunn.ch>
 <atEBPbpMtlmG+Mxe@oss.qualcomm.com>
 <e489ed64-9319-44f1-a74f-f75165c189c5@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e489ed64-9319-44f1-a74f-f75165c189c5@lunn.ch>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAzMiBTYWx0ZWRfX2mZV10Ggqn9v
 PvXd6SDRURs4Cj68dwCCGtKk1NmrsGrVXZGJDxRmbXa2Og4fZJQbeWLFfCHOAH1RW74kLexMG+j
 E4j0hav3JxoZYLoP27/QycIGJYTLroCgLsGXDt7zybQWzvNtUvm8rG56iS14VkmVPnbt2dyxEvh
 eX7K+uN7gCJWU+9/0xSU1uqIdyFef9fY/De1Es8VZEI1ge0LyKKDm5MyluF7FdK4aLOe+j1v1MD
 EvKDnbdyloUZ+oBJFP70O0BcF4yq13+FvZPIWDnNJg+aEDFODYhktcVbKt1nt9nWZjnTg4WZ/l6
 /sQbyUfJaSXQpLRyybmnccoxOwjpLwenvDMJj072PewXGipBEzTs8eDTSjrwGMVqi5ICbD2B7+v
 Tf0JpWIab78HING4Bd/pAobRepD4EMSRWRVLwYiitEaQg9AyyidWVOQA8+cRn4bw2Ic3Biu1SmT
 7t9ra0XsL/4lblXmtUQ==
X-Authority-Analysis: v=2.4 cv=W4WtxhWk c=1 sm=1 tr=0 ts=6ad32de0 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=xcn7ZbKIuaFRTQb2Q6EA:9 a=CjuIK1q_8ugA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: 0MIFqxfY-GtctlbYj7A5x66us5NmJy9X
X-Proofpoint-GUID: 0MIFqxfY-GtctlbYj7A5x66us5NmJy9X
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAzMiBTYWx0ZWRfX34ww//bNJfPp
 0jWrUXyTSG3SU0FUCTIh2fC7UnxpzLprQl0L/eGejtqFRkwxZuXemmLPDiFwlFNxfhHZjcMAlvR
 09LEP1+zliy/DFtyie4q2ZzsP/PrUCE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610170032

On Fri, Oct 16, 2026 at 05:17:20PM +0200, Andrew Lunn wrote:
> > I was going to share a text version of the power-up diagram given in
> > this PHY's datasheet. This might help.
> > 
> > Power-Up Sequence
> > 
> > 1. DVDD asserted
> >    |
> >    |<-------- 10 ms -------->|   (required for external power)
> >    |
> > 2. DVDD18 / AVDD18 asserted
> > 
> > 3. VDD1P25 asserted
> >    |
> >    |<-------- 0.2 ms ------->|   (required for LDO to settle)
> >    |
> > 4. VDD_LDO asserted
> > 
> > 5. AVDD asserted
> >    |
> >    |<--------- 2 ms -------->|   (required for XTL to oscillate)
> >    |
> > 6. Crystal 50 MHz starts oscillating
> > 
> > 7. PAD reset deasserted
> >    |
> >    |<------- 10 ms --------->|   (deglitch time)
> > 
> 
> Are these supposed to be staggered? Or can you turn them all on at
> once.

Its a confusing diagram but from what I gather: there's no delay
required between 1., 3., and 5. They are shown as partially overlapping.
This might be a better representation of the diagram:


DVDD          ..../-------------------------------------------------
                  |<--------- 10 ms ----------->|
                  |    (external power)         |
DVDD18/AVDD18 ................................../-------------------

VDD1P25       ............../---------------------------------------
                            |<0.2 ms>|
                            | LDO settling
VDD_LDO       ......................../-----------------------------

AVDD          ......................../-----------------------------
                                                |< 2 ms >|
                                                | crystal startup
Crystal 50 MHz ........................................../\/\/\/\/\/

PAD reset     ..................................................../---
                                                          |<10 ms>|
                                                          deglitch

> 
> 23ms does seem like the worst case.
> 

Yes, I thought that 23ms would be a safe value after looking at the diagram.

	Ayaan
