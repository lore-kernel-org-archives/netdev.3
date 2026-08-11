Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D7F339362;
	Tue, 11 Aug 2026 16:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464299; cv=none; b=VxPuIL0L2/5/+qb7gIRuwqGTPws8RssmYXkKqkiw94NTwUmV25YW1iFHqwNu4gkhEmCbmq3Z1oe3SqirjrcZRQmewsmFbw4F421GeXJwCyuV7K3r/4sE3U8ZafBfq8lyX+yqnPIMAQgNvuU+dmF074ESK6TObLcBLwqSINCk1hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464299; c=relaxed/simple;
	bh=JljBOVw864BFwfgqqlWCE/lpEniV62tOGWXA2kpOzEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l6R8gz5qmmkfvyLlFxg5r4sElRYQ3J/d9P1OGE0ttEf1BXTP/nnLT7xNHjAY2N7L+1XP+dU2ZC0TjxU9Sj7kyKXafe2bOF995+/q/j469IpYuiGiY3W301Z0uSJUnD8TJopmvmLHnZ5sOsqxTzDjHx/RbIgX4c2ONxUQLrF7p3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=pefMu8Zt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jW+qg83a; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="pefMu8Zt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jW+qg83a"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 230E514000E9;
	Tue, 11 Aug 2026 12:04:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 11 Aug 2026 12:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1786464296; x=1786550696; bh=AT
	j4T3yE5+F3FUxKTMyazvM2JrD8HdXZ9PpnkRumtMM=; b=pefMu8ZtysKr72ypeP
	Ae/uf+xxkp32dsJZYXZNp4Fb5TQvJNLs/wOjmlx8zZnTIkLoUREoCXQfA6v+01j6
	tRauRFdOMFdIG3MHu1Ygx03tooTblGvLPIduGDDpr8wRuEGHuUrumOEmdcACq1p4
	KpK7jHl9NX7swyZS97GoL60JAenhPjnDQU3tCFsNZENaMOybBNJ1Oo8BIun/XF4q
	5K4qeQPzvJU/ECRUOpfwANJlSdX2QvoPWU6X3uiDoRbDqm/X8i9IRMtOrAAvImfA
	ONZE1PUh/tF6vpcgFt8mFVWaAxPxw3ieTMLLN7IbbCsZoMi2WxoQmm2cxojyaK7d
	p7cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1786464296; x=1786550696; bh=ATj4T3yE5+F3FUxKTMyazvM2JrD8
	HdXZ9PpnkRumtMM=; b=jW+qg83aI1heBBiIkubPCUGbwRwLmyqCeiTX99lN23/s
	vQkwdcZzhe83nuPzsSr6wzxmA6SIh0z4cH32DDUZakJRyC4MWq/PJSHqYlfVYsHG
	/0ahq8a6Crv9wWsLrGQhfUk5nj5yr7sx/G5k9GqePx/t1QSEIaDvT+L0OgazbNg+
	DCt4YjEgBg3RCnedNnDigiMLbu2BMhUKr5E9Wth8PXXhaVTWT/5nhJ2VZoJx4VEM
	iEpF/HLuEpTfVukOYFiLko86nohFOSJG1wSg/yFTs1fGzSBbRf3PnTGh7+ArRqe7
	rFQiITXnPWxBK6GUosZhxMfLBfdOrybGNH9D5tTt0Q==
X-ME-Sender: <xms:J0h7aiA_POIabUUPhL7Tiv1Y9Azz3n1oAWhhPBeRGcC56J80HlIAjQ>
    <xme:J0h7alQ8BgNpycYBEtrH3n9dcn692jt-ubbqIrQ20VXZ8xA0STNGHC4bS6CskbamU
    5fZgzbJgcnAmrvcaXaFgtDc93RJ4z0FAlTkzKP3PVkd9OO4iTBInQ>
X-ME-Received: <xmr:J0h7akRH6qMajxwfHlJIWiTySMjexQ16WGCtUty75z0Mgh9z30NSaq8HC4ih7xdSYd0MVvnVc-o8znFPZJwjbS791dGo6EU>
X-ME-Proxy-Cause: dmFkZTGxdP+ZeqB3k56jriooycM+y3WkMVq0IdfQr1SLqdYHaQU8yYbqsJMgSKZsV7CP4g
    nEXDJqfAy0oqJQM5VR4mWCIxua1yHSekE5EJo5qR64uK6hzeY4yFD8+cqeEoFazS/7j8bI
    kWvL8HIZWMrf33UxxC3rXe0leKCybXoQMGInPqLLx6muUH9DyfDXMeAtYX9PO3qnnCs4h2
    HHgtPfzFNX8z9EVbmru8qs7N8MjU6KEcVc8NsC9PFcMdwHF65haWRQNKhQ5zKu+6I5ZoUE
    Z9yoSRY9YMjKqA+oJOjeSYlWjto5X3DmceEy77z0tU8I42YZT7WVMhO7BiHEhTVfTzuXDs
    DoMfAjH7Qe360uATIQupCY3ehkKhUxN4tDTFY2kboKywG0ZLZV/qqBJk64kyTLTEbwVugk
    863SiMCN9EUP2qQXvIwcFwTOBqURntAktbMYc/n1BGHCN2s3uirmS0mNKoL5RYZfJTCKSq
    /VjcDdJax61QJS2q0aBVg9jL9B7dZNhKVBEndn6awIgE24oWjxClvqNomaToUUh4cMg625
    BBovpVYLn4bqiNBOgHSBrHzLunK57Bx+rhgCeCyQ2hzv2rb0YipiW/nMXnX469BJ5lEMg9
    gl34fPvifUASiQcHIxR84V/Gh756ow3FtKslkeetu4gmaltsfbau/Mh0Tceg
X-ME-Proxy: <xmx:J0h7ajIHklNm_5yATbOl-9gHmmE58Z5I5S8Ty9ce6I7uS5JWppe5fg>
    <xmx:J0h7arG7cmHu-o4VVx3dTAeDJ8oqhv50rc6MyEnVEiGtvt6XGNxC2Q>
    <xmx:J0h7agSnnRtHdGVUP7GWOdKz9E0-UBVplk6YwjVCeiTC-YPxkNDLuw>
    <xmx:J0h7akW-g-vApvjiMYtdkh1u5ddB6gWWR91Y4wOBtqJ9sR8HBGn2fA>
    <xmx:KEh7ajYUsZK-A5Yq_lHuGZ3GlTa6Uxr_h3jq2_CexggRzVB_cP8zIZIV>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 12:04:55 -0400 (EDT)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"DavidS. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Sergey Shtylyov <sergei.shtylyov@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH net-next v2 00/10] ravb: Add gPTP support for Gen4
Date: Tue, 11 Aug 2026 18:01:50 +0200
Message-ID: <20260811160200.2049987-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

This series is the second part cleaning up how PTP timer support is
implemented on R-Car Gen4. Currently there is partial support for it in
some of the Ethernet devices that can use it, but not all.

On Gen2 and Gen3 each RAVB instance have it's own private PTP clock as
part of the RAVB register space. For this reason the PTP functionally
was implemented directly in the RAVB driver. For Gen4 however there is a
system-wide PTP clock shared by all RAVB instances, and on some Gen4
platforms with other Ethernet devices.

The RAVB Gen4 driver currently advertise PTP support to user-space, but
the support is in fact completely broken. It tries to use RAVB private
PTP clock, which do not exist on Gen4.

Further more the PTP clock behaved slightly different on Gen2 and Gen3.
These decencies have been handled by adding platform specific flags
inside the driver.

The usage of these flags have grown organically and been extended all
over the driver as it gained new features. Adding a new third set of
flags for Gen4 would be messy and add to the confusion.

Therefore patches 1/10 thru 8/10 refactors the usage of the PTP flags 
into optional callbacks and untangles the usage. This allows adding Gen4
support easy as it can just implement it's own set of Gen4 specific
callbacks without altering the driver logic.

Patch 9/10 is a small DT binding addition adding an optional phandle to
link a RAVB device to the external PTP clock. Ideally this property
should be mandatory, but for backward comp ability is is made optional.
If the phandle is not set, or the PTP clock not enabled, the RAVB driver
will continue to faction as before, but no longer advertise PTP support
to user space.

Finally patch 10/10 adds the Gen4 specific PTP callbacks which allows 
the driver to use the external PTP clock.

For part one of this work see [1]. The two series are independent of
each other but both are needed before a third series liking the RAVB to
the PTP clock in the platforms device tree. I will hold posting the
third series until all dependencies are merged. For this reason there is
no user of the new renesas,gptp device tree property added in this
series.

The work is tested on both Gen3 and Gen4 R-Car devices (with [1] and
appropriate DTS). I do however not have access to any Gen2 device where
the RAVB IP is wired to a MAC, so the small rework of the flags for Gen2
to callbacks have only been compiled tested. If anybody have a RZ device
where RAVB is wired and uses the Gen2 method of starting/stopping the
PTP timer together with the DMAC please test this.

Biggest change compared to v1 is adding one more patch (5/10) to address 
a previous issue pointed out by Sashiko.

1.  https://lore.kernel.org/all/20260803095232.3527111-1-niklas.soderlund+renesas@ragnatech.se/

Niklas Söderlund (10):
  net: ethernet: ravb: Remove gPTP control from WoL setup and restore
  net: ethernet: ravb: Move programming of gPTP timer interval
  net: ethernet: ravb: Simplify gPTP start and stop
  net: ethernet: ravb: Remove redundant argument to ravb_ptp_init()
  net: ethernet: ravb: Propagate error from ptp_clock_register()
  net: ethernet: ravb: Replace gPTP flags with callbacks
  net: ethernet: ravb: Add callback for gPTP probe
  net: ethernet: ravb: Add callback for gPTP clock index
  dt-bindings: net: renesas,etheravb: Add optional gPTP phandle for Gen4
  net: ethernet: ravb: Add gPTP support for Gen4

 .../bindings/net/renesas,etheravb.yaml        |  11 +
 drivers/net/ethernet/renesas/ravb.h           |  34 ++-
 drivers/net/ethernet/renesas/ravb_main.c      | 250 ++++++++++++------
 drivers/net/ethernet/renesas/ravb_ptp.c       |  26 +-
 4 files changed, 228 insertions(+), 93 deletions(-)

-- 
2.55.0

