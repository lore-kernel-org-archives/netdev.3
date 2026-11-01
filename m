Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.37.86.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793541391;
	b=FVnWexaCPAT3aZUcHJh9yH24n0OXkB1+FsWHDfH16R0M+66Hnmg5KHGw49jIGRC2T3Tg
	 kR73qBY+PenKFUq9w/5tmqGv6AQcoVshGo2UJU4nvmIY23r0muNdAErDJo8nLWXirmTAr
	 PVhC43MlqhXy8Wf1bH5yBwZmO2daHhLHh5p6PAYHAWXrIXIOyIrhwZ2qTroOIvJ68S9W9
	 /4hpxKsZZ/PqpyhQXLtJ0vLKW98JLaDpwRlwMB31pt6be/K1V1bId3xGuUCbpQncojHX3
	 9c4swu1yZIsZyRt/Rwp/kDwzeJHnHh9YyoOeErnfrHaF92+NJQUJsCpXV50LtnmJYbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793541391;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IPAS-Result:IronPort-Data:IronPort-HdrOrdr:X-Talos-CUID:
	 X-Talos-MUID:X-IronPort-Anti-Spam-Filtered:X-IronPort-AV:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Outbound-Client-TLS:X-Outbound-SMTP-Client:X-Outbound-Node;
	bh=XVyrLBiiV1csLSSF54wJLuMu+zNIwoQj7h/h5vPnodI=;
	b=h+TXdgKZjIeO1lH3ZTBxTRNL7RlPsWmdaYjYET2IMo24f5nWRi42R8wstZ1KPfmEIKLX
	 2JP9P6Ht7oYrIEYujAUwQr0b00jTbt9Ez7vSqi3CzP3rSk3rOmhPNgE6+gOGGOW/TA7nN
	 sxVaRM7eqV7uM09PewJ0PpVGPuhqecKvDZBumfSA1j3GCctXi/42H7bZ5H5BAVJR1kWrv
	 MMyXrjOM+8VP7gOkwkJSeqO2UbbSrVqxU3IjOeyUy8/4UDRDs3OaX8rc7ClvUVE066HB6
	 YsSE3myspLPURyW1/H+jYQsYqj3CShT7BsGYA1QMT1wJke5vgVMRYCcWQDTwEX0Y4Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cisco.com;
	spf=pass smtp.mailfrom=cisco.com;
	dkim=pass header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=aLyHM+zz;
	arc=none smtp.remote-ip=173.37.86.74
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BA1606A324
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 13:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8BA1606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=aLyHM+zz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1492; q=dns/txt;
  s=iport01; t=1793541389; x=1794750989;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XVyrLBiiV1csLSSF54wJLuMu+zNIwoQj7h/h5vPnodI=;
  b=aLyHM+zzdDJaIgnm5qEBjV2b7+cNkse4vqscp8j+tDf/C2pXX+f3RVt2
   Yuqj0d67BgHenidxmtjzOUZdSyzC9seuxH9QOIreqnvdUpGis0So8QL1z
   SBR40/zC7YyNUxw7EBHQH67OjFz9N7PLkTPo09MnfN3XjzOrKemKKHkuI
   ZAcpaLleKcRp1TdYRyDWnHjmLcq7fRRaUzhNCRymtDkdVSPUWLkvs9xZm
   Et3chAZXXsNA2UaZ1ag3Exp4BUwSiPW4rK5wK9aWxbfCqfyibEdLAicWa
   wuHgwnQ1jowxL1dCaC8zv5d6O0SeTLvLqXpezFdtFTQDIS62XEvp6f2fs
   w==;
X-CSE-ConnectionGUID: stvnNJqZRXe6m8vRSjK64Q==
X-CSE-MsgGUID: 0pyyt64eT668c3gVz6Hq5w==
X-IPAS-Result: =?us-ascii?q?A0BfAwABQ+dq/4z/Ja1aHgEBCxIMggULhCxDhSCRdJ4iF?=
 =?us-ascii?q?IFqDwEBAQ9RBAEBghKCcwKOHAImNAkOAQIEAwIDAQEBAQEBAQEBAQEBCgEBB?=
 =?us-ascii?q?QEBAQIBBwWBDhOGXJATAgEDIw8BQQUQCxoCJgICVoMbgnUDunF6gTKBAd5Jg?=
 =?us-ascii?q?XQVgQouhXKCbQGFA3aEfScbgUlEgRWDKz6EKmaDD4JqBIIigQyXC0gKeBwDW?=
 =?us-ascii?q?SwBVRMNCgsHBYElQwM1EioVI0sFLR2BIyEdFxEeWBsGBRIgKkFDW4EZgQddg?=
 =?us-ascii?q?SspYAECH0YtFYF2AoJRgSNdAgFJQQ4HRVMJJUMSRyQiCBIJARMaLAuBGjU8C?=
 =?us-ascii?q?SZBFQxkCAMaBRomAiAIAgsCDHYoERATHSAmMAUdJh0YDUgRLDcVGQQ9AW4Hl?=
 =?us-ascii?q?B8BD1sIgQMwgSApUDuTDJJIgTWKQ5UXhCmBZ592GjOqcJkIpA4QPYRpgWg8g?=
 =?us-ascii?q?VkzGggbFYMjUhkP4H8mcQcCBw8CkXMEgXoBAQ?=
IronPort-Data: A9a23:souiK608FuwdDaSzCfbD5RBwkn2cJEfYwER7XKvMYLTBsI5bp2EAm
 DBOWzyAOKuMN2ChL4okYISw90lTvpOAmoJnSwBp3Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ5yEzmE4Ej9atANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXX5
 rsen+WFYAX7gmcsazpOg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauF8Au6gS
 u/f+6qy92Xf8g1FIovNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ajs7XAMEhhXJ/0F1lqTzeJ
 OJl7vRcQS9xVkHFdX90vxNwS0mSNoUekFPLzOTWXcG7lyX7n3XQL/pGF10oO6s649RNMWwQ8
 KwGEgsPTU7fvrfjqF67YrEEasULNsLnOsYb/3pn1zycVa1gSpHYSKKM7thdtNsyrpkRRrCFO
 IxDNGcpNUiYC/FMEg9/5JYWh+60h2L/cD1wo1OOrq1x6G/WpOB0+OWxa4GFJYPSH625mG7Av
 nPX4zqlDy1EaoyUkjW74CyMn7LQyHaTtIU6UefQGuRRqFGa2GEWIBEfS1a+pf63lgi4Vs43A
 0EY5y8nv6Uu3E+mVN/wW1u/unHslh0BUdN4EOAg7gyJjK3O7G6xAGUYQjNfLdYhqIwtTCcq1
 1yOt9DkHzpitPuSU3313r6SoSm/JmsTIHMOaDEsSRYD5Z/ooOkblhvFQ9BiOLS4gt38BXf7x
 DXihC4zm7kek+YV2Kihu1PKmTShot7OVAFd2+nMdniu4gU8YMuuYJalrACAq/1BN42eCFKGu
 RDohvSj0QzHNrnV/ATlfQnHNOvBCyqtWNEEvWNSIg==
IronPort-HdrOrdr: A9a23:/I1ZJaHMbDjHE4yQpLqEzseALOsnbusQ8zAXPo5KJSC9Ffbo8P
 xG/c5rsSMc5wx+ZJhNo7q90ey7MBDhHP1OkOws1NWZPTUO0VHAROpfBMnZsl/d8kbFmdK1u5
 0MT0EHMr3NJGk/q9rm6w+lFNtl6tyG/Ke0wdr69R5WPGdXg2UK1XYANu5deXcGPTV7OQ==
X-Talos-CUID: 9a23:F83mnm3QkQdgY/5xkHXLs7xfAdw7dFv/1UXqE0LmDDZ3coaXagHMwfYx
X-Talos-MUID: 9a23:obaTvQVkSp682Bzq/Gf0lSB+aptl3/rwWEtWnqsU5emdaDMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,190,1787011200"; 
   d="scan'208";a="543387702"
Received: from rcdn-l-core-03.cisco.com ([173.37.255.140])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 01 Nov 2026 13:56:22 +0000
Received: from satishkh-l-mj0bbv6x.cisco.com (unknown [10.25.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-03.cisco.com (Postfix) with ESMTPS id 04F53180001CD;
	Sun,  1 Nov 2026 13:56:21 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org,
	sebaddel@cisco.com,
	aradhana@cisco.com,
	rfaucett@cisco.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net v3 1/2] enic: retain admin-channel DMA until queues stop
Date: Sun,  1 Nov 2026 05:55:45 -0800
Message-ID: <20261101135545.2566825-1-satishkh@cisco.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179340002556.3131.229561522947370936@kernel.org>
References: <20261027-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v3-1-ba237ed71241@cisco.com> <179340002556.3131.229561522947370936@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.129.52];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.129.52, [10.25.129.52]
X-Outbound-Node: rcdn-l-core-03.cisco.com

Thanks for the review.

I agree that vf_registered can become true from a late REGISTER_REPLY even
when the sender subsequently reports a timeout. V4 will clear
vf_registered after closing the admin channel on both re-registration
failure paths.

I also agree that removal holds RTNL longer than necessary. V4 will hold RTNL
only while detaching the netdev. The VF unregister handshake and admin-channel
close will run after releasing RTNL. The detach, the
netif_device_present() checks, and synchronous cancellation of the reset and
MTU workers prevent the datapath from being reopened while removal continues.

The failed reset/reopen case is also valid, but it predates this series and
concerns the generic datapath software lifecycle rather than admin DMA
ownership. After a successful stop followed by a failed reopen, a later
ndo_stop can repeat NAPI and IRQ teardown.

I do not want to add a partial datapath workaround to this admin-channel
series. I will address that separately with a consistent fix that makes
datapath cleanup safe to repeat. I will test the separate fix by forcing
failures at the major enic_open() stages and then bringing the interface down
and unbinding the device, verifying that NAPI, IRQs and other datapath
resources are cleaned exactly once.

V4 will retain the check that prevents the admin channel from being reopened
after datapath reopen fails, and will contain the two series-specific fixes
described above.

pw-bot: cr
