Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEE04CDA12
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 11:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792408393; cv=none; b=kSC+VnsQdyUhSHGlnToWaJNFhTNQIHLI7WHQaxFrUmPypj+l7DYzv01xZ9KfL0XDLPB9S4m1CojEJwBkKl6hkzC9XTlgAkm76DYySx+KXEVsKHoofgISJ4ZJaGG3W06K0g7vWAJIcxhQr52+rnfJl4RFEEgde+XUMv98U31Z4DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792408393; c=relaxed/simple;
	bh=36eUkGmRXYxap1bERqmr/vE5FGGwQMd9qbYovbe9Irk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=a2hF6kVSipZYhNrI6xyseZEONiZml8OTtD8LjEGs9yNKaBuA+lOTJzXY9on0C02fY8st9Io8zojksmSTeQDpEXs9M1uTg+plN/mZHHo+aF+fnjPPK55ruMQyI14l73KV2MVzT9wUcLpCIFezG7HK0ufWf5HxkD3mozI4i+HDiA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H2AorjXP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EJOhzXkN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H2AorjXP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EJOhzXkN"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8P9gi1666883
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 11:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TlR52ADOonRtbtSebcO0TM
	M6uvs5Fomcnb17yypt3k0=; b=H2AorjXPR4i5+V6vjUhVDvfucimDnkCoZ128F8
	aIT/iViFIK1okOqIM3aHSDRLrMWsq3liL+d5unAby16qYX4a8OsX35tipIZxEF5s
	liVri0e91/7WYcjZqGZI9K2CjgUyJGGNEfHwMO3u/zwRPbtxot0GNgvdA8jkLEsn
	gISpNCGAwa7UxkXVyPdPmc/rmDoJ0NrIZaDl/AxtduuBJHhAmRgmcRRlXOOVBJyE
	YZOi4xKmImJshfesCzpuddC+kC/hm6iaTyZ7b6vsloic9rC7A/+4CyHYvonItnfF
	vUZ9NkYGROt9No3YmuFdf2bP9/kGZnuatwhgwnXHYHjMskrw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3n0s2g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 11:13:10 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-934956beec8so430028685a.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 04:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792408389; x=1793013189; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TlR52ADOonRtbtSebcO0TMM6uvs5Fomcnb17yypt3k0=;
        b=EJOhzXkNzG47Y4Ywn/ziuDwMlzR0vkLlmMUUuatUPGEHi4OmQrHfQYKJgHBG/vn7tn
         u8P5GaWRRjaxUhO1mA5sUzWVCXcQWkBEXAdr4RHeJENjA+XUGKb/DISIR6Av1Vuh6Zbx
         eUOwwjEBPvi78Qjz8drjNPzc9ldfz83o1ceExMtwav2i6Rb62IZgF3Bsk/ParrawDBVH
         +LFE4nkIAghXK97KkPHhEqWPnzEE/ZcoIaPCfIt+YvaTWwYR5z3C2OpWK2599iim/ZJG
         X3DHj8uiXeEBq/SiuYLd5m8+sujR+ICx7pDLjyHHJw9cwH5Lot1LiCH83WFO51l6Y3V9
         V3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792408389; x=1793013189;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TlR52ADOonRtbtSebcO0TMM6uvs5Fomcnb17yypt3k0=;
        b=JI9Fjl8mbVVNr+yqlT6WzoXYDIcB9uaUlkL0tbmF7Cfal5A3t+yRDQtiOhueefhHC1
         fBPBPD606rd7/8yCumUONab/dOtG8Cw1D4g0x+IuI6D4Y42g4Wq6W+eiU8isZXaAaJmN
         CCMe4Ct43O4ztoWu48tuCidizWLy0/YZhJpeyyffFCQwJZsGa0X4iYW2SnTcfLP29cwH
         tihGqZUKzEMYrjTdPU/94NbqNAkl5Lr4IFdUS7a23Il8X6DfHcmiFyAHH7ubs/jiABWB
         ZtR3bLMkHAhTQgOR9Gg283HtIE+csL6kehkG92ThArgT9J384XVjZBSVXi/8EP3i2GdX
         kHQg==
X-Forwarded-Encrypted: i=1; AKwUvByDyjyRL6BtC8pcXALSHUdCSFShBMfCSk2rDvOfggWEJGr/oIqgpi/O+DMp6W3zo0p6ZJo8dcA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLXqqUPzyWsX/JQyKoyHyNNz3vCoC1Y0Bs0I6BRIMsifJQCSOCm
	YZrup6gdzBWAjBGQQZqfNt+HCDzstFQysSLPW55Jn05Q2yxPsI5lQay5IUCojTmrYVUXCY9GFJ6
	kggZEKn05gHDRXtIufaYS/ZR5xTVbq/EKnU5iE4l9kLYzL1rf87W5Xl/3qRUM7M/+1Kg=
X-Gm-Gg: AYBFou3z0LO9PBMITtNeTE5ypitUS2PeeRTsZf1Sdi8UK/C+cuOXh50+i3SexgEL7B1
	QTjXl5rdM2E7VHGOIUk3m4ET+i6CiL812jbJmYk3Ggdmn+Ajh5G7wEZTOtHPzuqXW4Vubnl9ruE
	f6kGbYtvUY0nma0ANGAqL0Y06Oh6dGntq0k24eIHFWbN1UAAp47W9RM6mkGYJXfbRrwl1XIWR0V
	o8RKiUb5l5JJodEQkbEz0pHLArUoNt809+aspkFVhb2eGFjFOsMRiYQze+9I8Zc1vK3YDHOToWU
	VOzfP4dMdWIKedU2vWhVZyueR6q5oCQ6Mb89fF/GW2Ha+gD/mCs0vBbQ4FkaLSVHOJ6VqXolJqT
	n6k469Hbvfpt/nwRjYcPik7A6EZ/UNyO+8CR/plL63o+R
X-Received: by 2002:a05:620a:a0cd:20b0:93f:2e7e:c818 with SMTP id af79cd13be357-93f2e7ed0abmr614908885a.59.1792408389003;
        Mon, 19 Oct 2026 04:13:09 -0700 (PDT)
X-Received: by 2002:a05:620a:a0cd:20b0:93f:2e7e:c818 with SMTP id af79cd13be357-93f2e7ed0abmr614905785a.59.1792408388516;
        Mon, 19 Oct 2026 04:13:08 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4256c790adsm211472266b.31.2026.10.19.04.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 04:13:07 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: [PATCH 0/2] net: qrtr: don't lose name server packets behind the
 HELLO gate
Date: Mon, 19 Oct 2026 13:12:00 +0200
Message-Id: <20261019-upstream-qrtr-hello-gate-fix_b4-v1-0-bd420aec171b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNUQrCMBCE4auUfXYhCaVYryIiaZy0K7Wtm1SE0
 rsb9fFj4J+NElSQ6FRtpHhJknkqsIeKwuCnHiy3YnLGNdbYltclZYV/8FOz8oBxnLn3GRzlfe1
 qDg7H4GIdW9NQqSyKsvwezpe/09rdEfI3S/v+ASFANPuDAAAA
X-Change-ID: 20261019-upstream-qrtr-hello-gate-fix_b4-c2e8c2f4f906
To: Manivannan Sadhasivam <mani@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>,
        Chris Lew <christopher.lew@oss.qualcomm.com>,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NCBTYWx0ZWRfXxgYouaEnWyaN
 SL0d1rYELXd65WIqXKDQTQEGnVf9ofRwRjSdn7UYmwJoRAO9qzABS30EuwU5l24zt5tcAyKzqHi
 r2QwViiw2onQSWNds9wPYWrBBx3lil8=
X-Proofpoint-ORIG-GUID: csHBhafXWoxolJ8Wz4OaXSS30HLMbTYW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NCBTYWx0ZWRfX4nMyPcQ2Vnt+
 Z3BdFXa2EsgfkJ2vHe3BmYFrYARSl54xRslHV1bivymvLZ8OuELJY3tAISb3+tYWfjmlCHtrAC2
 HqRriWgM4B80vq/vKBvVhwpJRK1AgzlH+8GA1WHzy7Hn4zvEIzRnjQXweIddVIootf7ct9m7gEx
 ZZMK98VmhfANwiTJpnzCm3uu+ZsMhzeeWF8MxXp3gKLc5nw3aPTZ4rIClsWgAAWpQl+VXCI0RTB
 oPyjXGIqlqeOtn4pba01cBPW6p6c5YsVO0RdWt2x/CweN93h+Dj2DvkrUp1K0LARqkWo2aDzGMR
 6jjK7c3YV2r+gmZmJiF0JTbj56FfJ75gecak/5J/tphcbUn87aZqZa4WL/xu+ZccoCJjr3QFoM2
 eVD3Jx0l/Ac6X6rGEvhMRkaH42jyzdFlsVKszhsdGIB5n2F9zQDC30P0mkFIP23n3n8o2H6MtIc
 4Q++tq/+YT4uFPyqZ4w==
X-Proofpoint-GUID: csHBhafXWoxolJ8Wz4OaXSS30HLMbTYW
X-Authority-Analysis: v=2.4 cv=Zf2IpcVA c=1 sm=1 tr=0 ts=6ad5fb46 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=iOzWpaUfyYFiVLkFVAIA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190044

Since commit 544d85de4dc2 ("net: qrtr: Send HELLO message on endpoint
register") the core refuses every non-HELLO packet to a node until the
HELLO to it has been sent, and retries a HELLO that cannot be sent yet
100 ms later. A freshly booted remoteproc has no glink rx intents, so
the first HELLO fails, and the name server's announcements in that
window (the replies to the remote's HELLO and the NEW_SERVER broadcasts
of local servers) are dropped for good. The name server then also skips
the lookup notifications for a server whose broadcast failed.

On QCM2290 (Arduino UNO Q) this stalls the modem in about one boot in
five: it waits for the RMTFS service, which rmtfs registers in the same
instant the modem starts, until its watchdog fires 40 s later; WiFi,
whose firmware runs on the modem, comes up a minute late.

Patch 1 makes the name server carry on after a failed send (announce
the remaining servers, notify the pending lookups). Patch 2 holds
control packets for a node behind its HELLO and sends them right after
it, instead of dropping them; data packets are still refused before the
HELLO, so flow control is unchanged.

Initially tested on the Arduino UNO Q (QRB2210) with v7.3-rc6 plus the board
support it needs: 10 fresh boots and 10 modem stop/start cycles, no
"failed to announce new service", no modem watchdog, WLAN firmware up
6.4-8.2 s after boot every time; unpatched, 2/10 boots and 1/18 restarts
stalled. Built with W=1 on net/main; applies to next-20261016.

I'm not deeply familiar with QRTR; an alternative would be to have the
core trigger announce_servers() for the node once its HELLO is sent.
Happy to rework it that way if preferred.

Cc: Chris Lew <christopher.lew@oss.qualcomm.com>

---
Igor Opaniuk (2):
      net: qrtr: ns: keep going when an announcement cannot be sent
      net: qrtr: hold control packets behind the HELLO gate instead of dropping them

 net/qrtr/af_qrtr.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++-------
 net/qrtr/ns.c      | 10 +++++----
 2 files changed, 58 insertions(+), 11 deletions(-)
---
base-commit: 07bd391eb9572e74f073c49acef327611234f9bb
change-id: 20261019-upstream-qrtr-hello-gate-fix_b4-c2e8c2f4f906

Best regards,
--  
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

