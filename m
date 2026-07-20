Received: from mx0a-00115406.pphosted.com (mx0a-00115406.pphosted.com [205.220.166.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921433DC4B6
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 18:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.166.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784572150; cv=pass; b=r6ofxgZ4aEUc7CK+C4Q2AwzXuk/5a3acP09I2nvfqs0d1q+3D0ddvb9TQwGTvlCYesobuy52AGmkuJN+EQU2iMTv5RNI/Zp25HAK1FtRdryOr2tJcgCRPEwyqpO4H5MqIRcfFtGcJRuxQ606NRyIVhfgGQgYW9Kno6CQZZIiN4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784572150; c=relaxed/simple;
	bh=EG5t7PLuMoW2RfGYmkwkRW5j/SlTbnDSYc8i2yCzOOE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=BZt6Itgp8KssT0IZUaFt65Yw6cd07ZVpJm2iMpqYnT2aqJR3hHBhkr0xHiFTq64P2CNrMs77UQd/8TGyXCztvUKw8DJtBDJEG8DTAPK4LbvO/KjuIavEV1nEBzyE+hvPuo+etNtNktYJJqoZIlTfyKKM/Dv+8q4J2FvEHKPymjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dish.com; spf=pass smtp.mailfrom=dish.com; dkim=pass (2048-bit key) header.d=dish.com header.i=@dish.com header.b=PUCgVc/S; arc=pass smtp.client-ip=205.220.166.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dish.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dish.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dish.com header.i=@dish.com header.b="PUCgVc/S"
Received: from pps.filterd (m0495101.ppops.net [127.0.0.1])
	by mx0a-00115406.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KH8F562874052
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 18:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dish.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	ppt1; bh=iNqz+wQB2OzT+eDKPICij04wlFTU6hyrtE75fNgz+fM=; b=PUCgVc/
	ScKYf0Zm15LL901z6hFB/LFWL6177UJgE/DBkQqK2ek+80CQZ0cUxAh82FuLTNx8
	v5DEepmfxSy5AEtsuVdCZ7fonJztfMvQtxyZ7grBnh8hM0ROcwAfCHFsE4OiSyz2
	2OZaQcumDzsmJf1WpSh6K7MV6AMqOJbvz3lY0o7gX4HXUqyi6vMwy/bWRZZzlD6o
	IX9Cuuoi8R7daW6suWnCv1/5MxFsPNLRDFhoJcMrQTG+4DW5fYcwyXnzRfMTN/Nv
	hFClxWUMASpB94n/Y4p7fp+Tcsumq02CIIyfolLkyztlnwlpCf8RGhNyY1Dr1Iqk
	1LB0frBUlxcT6ow==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-00115406.pphosted.com (PPS) with ESMTPS id 4fgmgka3t9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 18:16:38 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-81f0e988059so31526107b3.1
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 11:16:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784571397; cv=none;
        d=google.com; s=arc-20260327;
        b=W1lC+ceYf/Wr7NmUuYfxPiosP+0UW4Wwl9CxxXOot4DUOtAXfwnVGWp9EvTI9SCSeR
         zfOS0nFDoNYt6ROia5cLUAw5S6tQq6Zm17F2jvf+ytBh5rHy8G7GLQWGJCdUS6iwTAqt
         noWtExc3AhTGT63ebduXD5TvKNvWeix6jZv7yC8xlAjKlNiiI8FKW7Mrd5VR0OAWltae
         EiV6hKpLVt2u3ocZjFBlRB+2xpaZdjgw8gYStet1wS3wt9PWc/Ej7S/Ea4L0PIhCjM21
         iSBSqB1YOCJZG2D6C/qRXabGTE0UVXSUSuNEpgttXg59yTa5HlP1u9AsLBGS3oilZ4TL
         Zlzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version;
        bh=iNqz+wQB2OzT+eDKPICij04wlFTU6hyrtE75fNgz+fM=;
        fh=aLXdqiAAOC8NHOU6jiCvJE8hg/p+dQ6ipJkYgqKk9BY=;
        b=a2X3ppt7XZriaq+wTHmJI+le4isT5YyQES92zWzZtInRlt8P5Mm2c8kUBHRWJDAkPO
         pY7IxFxLIT5ZJ4VYqWQmzqvq3e6wpMBQWMf8wdbQ3SAgZTIJOw9JsAkgJiGZqv8WyzPD
         Soc+Qlqpf2rO4gD58yGThOQd8sP1A8RVod5D8bhWjuK06VqyHOoi4WIAlrj8BXSDGaAk
         wM3N0fCsPnmeGtYa8EqfyUrYfQ/giHb9T+uQ3oZGMSP7fbhnDyxBhiR4JdC/MEuQZ55j
         o/N6cHMYrRdHP4NJtAYRNMmEHsdFW6Tb3X/n1QlwNhMsF21zHOd81elcokfNRw9x19kG
         wOoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784571397; x=1785176197;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iNqz+wQB2OzT+eDKPICij04wlFTU6hyrtE75fNgz+fM=;
        b=fLZtUCgi0jLR4YNcaWYgJc5CNthokG1oilNiwaDNV3tF80Ey8LTWORCuMfE9J+GB3s
         lt76JMiMoG5Hach9Tj8dDsWDXSl7IiT/mFdOIPxoyEuEjQV/FVNHfBTGpnyM0AIlo8W8
         r1KKML/OWpkFhommOoHVNjVCzJU3EsJt9ZNv3mRK5gXPbkZkAvzvxkVU1LspaDE3SFDS
         KBXpFwBEsGVxaUrzUKCV//ho6XuKKHwYxL4u5ZzSIQltYF3RqfZTmCwYqKBT96bUoMZI
         l08b3P0miwFkpMR5Zq1oLX+tkv1WzoTSjtChfxCnfNAiEp1WphEq64iMav3EJ9FfIcyA
         OeKQ==
X-Gm-Message-State: AOJu0YyAGA59LWCXQ0lKFp/IGiklMDT0xkSI+4efbxlrQmfQ2+TIOfR+
	zviS7+41xzGYe4HSjZDTrM6IDbvmRRrVDCsi7VkJs8gn9nEiRTP6yM7DY0NDs00px4UnU0bdFz5
	zrjldC/RwKWL3f/segE3RFidjPl1gDhgwCoZrbZlomBZMb8LBLWDorMuLH9YuVov/4dF8YWQsa+
	Xm1E4uVrr1Nnsfo7+vlsfCmbIPLy1zOECVIQ==
X-Gm-Gg: AR+sD136kS12LT6tAfP8xSj4KCJ8BYxJUIHpQs5FO3ozzmGeR7Z4fRg5odL/BHCtONW
	Q9e9btA+yRLoVFcUa8TZjK7P8Cf9x2YRPadCG+JhjGkuMVhQj10f13/8WZRLTx3ntl7p8XnNzMY
	m0tNeh9gpQG/cK8aPzDwgNa8s=
X-Received: by 2002:a05:690c:368f:b0:7f4:fad5:2087 with SMTP id 00721157ae682-81ef25e0e38mr52736787b3.38.1784571395321;
        Mon, 20 Jul 2026 11:16:35 -0700 (PDT)
X-Received: by 2002:a05:690c:368f:b0:7f4:fad5:2087 with SMTP id
 00721157ae682-81ef25e0e38mr52736617b3.38.1784571394722; Mon, 20 Jul 2026
 11:16:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tim Wong <kanman.wong@dish.com>
Date: Mon, 20 Jul 2026 12:16:23 -0600
X-Gm-Features: AUfX_mxRa7xYuyAqdP2E_WDJeaA6fnH3C-P4iCaTEKterBtyicJTS7D7tOnWCyA
Message-ID: <CAPT8rhu_NGbLd54RFWRxO+=7BHhJ0pS5yeOgo5kNmq4qtQ=t8w@mail.gmail.com>
Subject: [PATCH net-next 1/2] ipv4: devinet: list global scope addresses
 before link scope addresses
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: y5CRtNSgxBEKV9EfBfb-8yZaLlq3DxOM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIwMCBTYWx0ZWRfX7FyyADbKSmsB
 wV6VPUmh5rI/WbPkPsPglea/xPHwFQ5YGKSlvsdv/VTAZUzKAdV6Yh7D2Qfp35yc+k6CpgSie9H
 BaDhiBm99v/z35+CT+BGON77Xbqpe8B6I/MmvtARsDtKyp9qiBDX
X-Proofpoint-ORIG-GUID: y5CRtNSgxBEKV9EfBfb-8yZaLlq3DxOM
X-Authority-Analysis: v=2.4 cv=O/oJeh9W c=1 sm=1 tr=0 ts=6a5e6606 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=XolNvlvVfU_khZ2SZc-R:22 a=TaL_dSXU1PTOyx9Cv6-x:22
 a=BZdJCGVvAAAA:8 a=awgMdvYvGB436_RLXSwA:9 a=QEXdDO2ut3YA:10
 a=kLokIza1BN8a-hAJ3hfR:22 a=U3TbxMjcxCISFbQIaatt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIwMCBTYWx0ZWRfX+fknpVgDCmIM
 k4MuHvJVB6WEbdjCTofWEowEr3Tm9WoW3HZe3jJaLaRCt16az83DLRzk19wqrlsNi/gNn/TbPcG
 Q/VKA4XoPV6s86jRUt5r4fM6QwArc//bkAruvlOV7zUEjyIoSbHgqOYkYfLFd9fhd8ArcfBVJyn
 nCGdEIFEbuhgzColCZGtjq+6hVt6gM6imT2ClBomDk99CIjQOQ0kunm4i0eVa/MOZeVJJqZUD/I
 iOm1W8TOeUcaqqRYEkk/MxztXTZnIBixeWJof3Ar65ep95fUBOviFtLFGH3zMkkEoPafu8tzQ3t
 IlFG8qBcXxiOOAsgwAvK6tUTY1N70HPg2pWFbQHXsoUMWBegI4LanHB9GhWfxqY7XtPxLAgjE1G
 9FdYLXrY0abSKvGKFKKgjwTR1CNDcJencaQhwzmPvrOe991WEleBeUy6pqrtYZToUgBrV9SH23C
 n1gIWkxCyGSfYub4gmw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200200

__inet_insert_ifa() inserts a new primary address by advancing an
insertion pointer past every existing primary address whose scope
is >= the new address's scope. Because IPv4 scope values are
numerically smaller for wider scopes (RT_SCOPE_UNIVERSE < ... <
RT_SCOPE_LINK < RT_SCOPE_HOST), the comparison

    ifa->ifa_scope <= ifa1->ifa_scope

is true for a global-scope new address against essentially every
existing entry, so the new address is pushed all the way to the
tail of the primary address list, ending up *after* any link-scope
addresses that were configured earlier.

On an interface carrying a mix of global- and link-scope IPv4
addresses (e.g. a routable address alongside an RFC 3927
169.254.0.0/16 address, or any address explicitly assigned link
scope), this makes the resulting order in in_dev->ifa_list -- and
therefore the order addresses are reported via netlink
(RTM_GETADDR), ioctl (SIOCGIFCONF), and /proc/net -- depend on
configuration order rather than scope. Userspace consumers that
pick the first address returned for an interface (e.g. via
getifaddrs()) can end up preferring a link-scope address over a
global one.

IPv6 already avoids this: ipv6_add_addr() keeps idev->addr_list
ordered so global-scope addresses precede link-local ones
regardless of configuration order.

Fix the comparison so the insertion pointer only advances past
addresses that are at least as global as the new one:

    ifa->ifa_scope >= ifa1->ifa_scope

This groups global-scope primary addresses ahead of link-scope
primary addresses in in_dev->ifa_list, preserving insertion order
within each scope group, and brings IPv4 address enumeration order
in line with existing IPv6 behavior.

Signed-off-by: kanman.wong <kanman.wong@dish.com>
---
 net/ipv4/devinet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index a35b72662e43..056f2169c6a3 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -510,7 +510,7 @@ static int __inet_insert_ifa(struct in_ifaddr
*ifa, struct nlmsghdr *nlh,

  while (ifa1) {
  if (!(ifa1->ifa_flags & IFA_F_SECONDARY) &&
-     ifa->ifa_scope <= ifa1->ifa_scope)
+     ifa->ifa_scope >= ifa1->ifa_scope)
  last_primary = &ifa1->ifa_next;
  if (ifa1->ifa_mask == ifa->ifa_mask &&
      inet_ifa_match(ifa1->ifa_address, ifa)) {

base-commit: ce6b4d3216b63f902bb8e9695ee6c10c83415f65
-- 
2.51.0
