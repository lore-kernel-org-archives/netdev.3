Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265D8365A10
	for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 00:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774140667; cv=none; b=HXZZDuQrLZR7CTUgImAGUYPy/ojsMIhJsEZwLMvMINLmBLbMJzvrdEdvNXU6kIBsFctogEQ8uMyrGG5Y8MmqbfrIr/8ko5sIkmPmvJCzj82SIWS9hCqaFOKdi6KlyTF5Za5O0Fkoobbh0gWRWCZX1pf1WGdEp+UmkkP8k3oxHZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774140667; c=relaxed/simple;
	bh=rKswbqZiaB34+mPSs6FIFDqforhntNswebmMjm54ZTY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=my9xsQy12iNwIZfsMgAke6/rRv6CiV4JKlhiAk0/iBXc60qac52eMjs0518FrS1gkEDYBITPsmnLhgFfZvdqjU/71FEMhXRnOPZ2y4o/4RSXnZLMxCv8RdK1p574l1FxCb2pZmeGwLlX4FDxY89Eh12O2Mra7AEtvliRfRW2t4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from localhost.localdomain ([160.80.103.126])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 62M0oi8B021661;
	Sun, 22 Mar 2026 01:50:50 +0100
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels@cisco.com>,
        Justin Iurman <justin.iurman@6wind.com>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [RFC PATCH iproute2-next 0/4] seg6: add SRv6 End.DT2U and srl2 support
Date: Sun, 22 Mar 2026 01:50:17 +0100
Message-Id: <20260322005021.12770-1-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

Hi all,

this series adds iproute2 support for SRv6 L2 VPN functionality based
on the End.DT2U behavior and the srl2 link type.

The goal is to expose in userspace the pieces needed to support SRv6
L2 service delivery through an internal SRv6 L2 endpoint, similarly
to the model already used by VXLAN.

Today, Linux supports SRv6 L2 decapsulation only through the End.DX2
behavior, i.e., by forwarding the exposed Ethernet frame to a
configured egress netdevice. This supports L2 decapsulation toward an
output interface, but does not provide a native internal netdevice
representing the SRv6 L2 service endpoint. On the encapsulation side,
the existing H.L2.Encaps lwtunnel mode cannot encapsulate non-IP
protocols such as ARP, since they never enter the routing path.

The companion kernel series addresses that limitation by adding the
End.DT2U seg6local behavior and introducing the srl2 device. This
iproute2 series provides the corresponding userspace support: parsing
and printing of End.DT2U with the l2dev attribute, creation and
configuration of srl2 links, and man page documentation for both.

The series is structured as follows:

 Patch: 1/4 adds iproute2 support for the SRv6 End.DT2U behavior,
        including parsing and printing of the l2dev attribute;

 Patch: 2/4 adds support for the srl2 link type and its segs parameter,
        used to configure the SRv6 segment list for L2 encapsulation;

 Patch: 3/4 documents End.DT2U in the ip-route man page;

 Patch: 4/4 documents the srl2 link type in the ip-link man page.


Example usage:

  ip link add srl2-0 type srl2 segs fc00::a,fc00::b
  ip link set srl2-0 master br0

  ip -6 route add fc00::100/128 encap seg6local action End.DT2U \
      l2dev srl2-0 dev dum0

  # encapsulating traffic from veth-hs into srl2-0
  ip link set veth-hs master br0


This series depends on the companion kernel RFC:

  [RFC PATCH net-next 0/3] seg6: SRv6 L2 VPN with End.DT2U and srl2 device

Comments are welcome!

Thanks,
Andrea and Stefano


Andrea Mayer (4):
  seg6: add support for SRv6 End.DT2U behavior
  seg6: add srl2 link type support
  seg6: man: document End.DT2U behavior in ip-route man page
  seg6: man: document srl2 link type in ip-link man page

 include/uapi/linux/seg6_local.h |   3 +
 include/uapi/linux/srl2.h       |  20 ++++
 ip/Makefile                     |   2 +-
 ip/iplink_srl2.c                | 176 ++++++++++++++++++++++++++++++++
 ip/iproute.c                    |   7 +-
 ip/iproute_lwtunnel.c           |  20 +++-
 man/man8/ip-link.8.in           |  23 +++++
 man/man8/ip-route.8.in          |  21 ++++
 8 files changed, 267 insertions(+), 5 deletions(-)
 create mode 100644 include/uapi/linux/srl2.h
 create mode 100644 ip/iplink_srl2.c

-- 
2.20.1

