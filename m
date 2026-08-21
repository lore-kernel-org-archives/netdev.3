Received: from ofcsgdbm.dwd.de (ofcsgdbm.dwd.de [141.38.3.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6312469848
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 11:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.38.3.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787312922; cv=none; b=dJRk7PjzqL935qulpmAmbQfLNfsK4aaQDAzs6KVTv4skggPdi0qzJ2QafS1GkOhc6QOzwqpUTyxp/sN5avckgyWlrrgZ7n28AAvTQt0bWPlrf5p22ILktfPRsprx7/oJJOlfT2JUdqE92Pqggi7DBcOqMTdWPl/Qjyfg3ZnMmJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787312922; c=relaxed/simple;
	bh=SQj60MD6EU/5qzxwSNp4jGqJ3d+ZzQhSprb/uF+Q8mE=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=iMi/1TE3AhVK1qKPF/V06mBv/E0mrFyc4oSPXlCUDW8/0/XR46Rxr7sPZi/V0CSuSxQrn1vL1xLmgVBbaN3tlwwDh2dij3jfhQ5tKGGY1+5ejxOCYIXHndB9aC7wwqIEtR0Db6B54j1VrwftldzDoSuLaGwHHPjp/Cd1rcnhvck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dwd.de; spf=pass smtp.mailfrom=dwd.de; dkim=pass (2048-bit key) header.d=dwd.de header.i=@dwd.de header.b=46kgup5E; arc=none smtp.client-ip=141.38.3.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dwd.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dwd.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dwd.de header.i=@dwd.de header.b="46kgup5E"
Received: from localhost (localhost [127.0.0.1])
	by ofcsg2dn1.dwd.de (Postfix) with ESMTP id 4hRJKd4sf8z3vZq
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 11:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dwd.de; h=
	content-type:content-type:mime-version:message-id:subject
	:subject:from:from:date:date:received:received:received:received
	:received:received:received:received; s=dwd-csg20210107; t=
	1787312469; x=1788522070; bh=SQj60MD6EU/5qzxwSNp4jGqJ3d+ZzQhSprb
	/uF+Q8mE=; b=46kgup5EH+XkFM74SaOAEx0DPXD0yqVsgA6qgazQdXCiZLq56Ta
	+Fou47Z85VU2PrWPnGrd/BlG7J8cMXknDXLTbYjTMDRP3QmmbJLd/catUWpg1jIS
	E3tfHkD0J4V9pTpnCPJIzy9/5dR2IT247euY9OnC0U2frLITVkJv9FO+DveFca2R
	j567hTU3HcHce+w7ychUeC9zG+CfvezGZKIXIa4umHgEjYQXkRRb/K3RD5wubKcU
	sy3m5nu+3sj3i7WjUKAvKPb4ER2MhcJZijJVE61RCwtloA3MExpBECybaBrFz8vw
	JpQBiCeNLb/0dNoLOa8lT4do247kh7iyXsQ==
X-Virus-Scanned: by amavisd-new at csg.dwd.de
Received: from ofcsg2cteh1.dwd.de ([172.30.232.65])
 by localhost (ofcsg2dn1.dwd.de [172.30.232.24]) (amavis, port 10024)
 with ESMTP id zA2qsQmp96fc for <netdev@vger.kernel.org>;
 Fri, 21 Aug 2026 11:41:09 +0000 (UTC)
Received: from ofcsg2cteh1.dwd.de (unknown [127.0.0.1])
	by DDEI (Postfix) with ESMTP id 5905CC903ED8
	for <root@ofcsg2dn1.dwd.de>; Fri, 21 Aug 2026 11:41:09 +0000 (UTC)
Received: from ofcsg2cteh1.dwd.de (unknown [127.0.0.1])
	by DDEI (Postfix) with ESMTP id 4D732C903EC6
	for <root@ofcsg2dn1.dwd.de>; Fri, 21 Aug 2026 11:41:09 +0000 (UTC)
X-DDEI-TLS-USAGE: Unused
Received: from ofcsgdbm.dwd.de (unknown [172.30.232.24])
	by ofcsg2cteh1.dwd.de (Postfix) with ESMTP
	for <root@ofcsg2dn1.dwd.de>; Fri, 21 Aug 2026 11:41:09 +0000 (UTC)
Received: from ofcsgdbm.dwd.de by localhost (Postfix XFORWARD proxy);
 Fri, 21 Aug 2026 11:41:09 -0000
Received: from ofcsg2dvf1.dwd.de (unknown [172.30.232.10])
	by ofcsg2dn1.dwd.de (Postfix) with ESMTPS id 4hRJKd1t1fz3vZq
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 11:41:09 +0000 (UTC)
Received: from ofmailhub.dwd.de (ofldap.dwd.de [141.38.39.208])
	by ofcsg2dvf1.dwd.de  with ESMTP id 67LBf9n7017373-67LBf9n8017373;
	Fri, 21 Aug 2026 11:41:09 GMT
Received: from praktifix.dwd.de (praktifix.dwd.de [141.38.44.46])
	by ofmailhub.dwd.de (Postfix) with ESMTP id 17027453F0;
	Fri, 21 Aug 2026 11:41:09 +0000 (UTC)
Date: Fri, 21 Aug 2026 13:41:09 +0200 (CEST)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
To: netdev@vger.kernel.org
cc: regressions@lists.linux.dev, michael.chan@broadcom.com, 
    pavan.chebbi@broadcom.com, ajit.khaparde@broadcom.com, 
    somnath.kotur@broadcom.com
Subject: REGRESSION: bnxt_en fails to initialize with errno -22 in
 page_pool_create_percpu on 6.18.45
Message-ID: <6175537d-934d-41b3-904a-faf3b784973@praktifix.dwd.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-FEAS-Client-IP: 141.38.39.208
X-FE-Last-Public-Client-IP: 141.38.39.208
X-FE-Policy-ID: 2:2:1:SYSTEM
X-TMASE-Version: DDEI-5.1-9.2.1011-30146.007
X-TMASE-Result: 10--10.907000-10.000000
X-TMASE-MatchedRID: wKsxJH6V8qhZ+tOQmIGhEp0UyaWO1QCnXpSxZKDDzFi6bTVuVfzSizt5
	yG5DhcrCnS2WqF7uW7LNQtxthBjc0GFoHMr65PsOp/bXyF3gpaCUiGLkY8AZ4717sDx9NtCBFIB
	UXk42eksLW3uKfnk+E38u0eTlN5i+qCSeJKqSmf4HNShWtYdI6fyCLOLHMRsgVc6oxg15iGYRLj
	qoJJt/9UUdYURJDw6V6cJ/6QfST1xxg7svMtapLrAdecdWQCzFy4offpx2osgmwT3YhI4Newaid
	F5t0NSxPLj1PGgTk/RL68RHQnAOXWZp4lxb8EVn
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;

Hello,

with 6.18.45 my network cards fail to come up. When NetworkManager
wants to bring up the interfaces the following is shown in the
logs:

   kernel: page_pool_create_percpu() gave up with errno -22
   kernel: bnxt_en 0000:02:00.0 ens1f0np0: bnxt_alloc_mem err: ffffffea
   NetworkManager[2377]: <warn>  [1787169889.4135] platform-linux: do-change-link[2]: failure 22 (Invalid argument)
   kernel: page_pool_create_percpu() gave up with errno -22
   kernel: bnxt_en 0000:02:00.1 ens1f1np1: bnxt_alloc_mem err: ffffffea
   NetworkManager[2377]: <warn>  [1787169889.4504] platform-linux: do-change-link[3]: failure 22 (Invalid argument)

On a working 6.18.44 kernel ethtool -g shows:
   ethtool -g ens1f0np0
   Ring parameters for ens1f0np0:
   Pre-set maximums:
   RX:			2047
   RX Mini:		n/a
   RX Jumbo:		8191
   TX:			2047
   TX push buff len:	n/a
   HDS thresh:		1023
   Current hardware settings:
   RX:			511
   RX Mini:		n/a
   RX Jumbo:		2044
   TX:			511
   RX Buf Len:		n/a
   CQE Size:		n/a
   TX Push:		off
   RX Push:		off
   TX push buff len:	n/a
   TCP data split:	on
   HDS thresh:		640

Hardware / Driver Info:
- NIC: Broadcom BCM57416 NetXtreme-E
- Firmware-version: 238.1.138.6/pkg 38.11.38.06
- Driver: bnxt_en (in-tree)

If more information is needed I will be happy to provide it.

Reverting back to 6.18.44 solves the issue.

Regards,
Holger
