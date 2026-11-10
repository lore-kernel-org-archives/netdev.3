Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794303846;
	b=nz1CzA09/QEdTscqcCICMmfLFYvBOyxI0LfWPL/KZY/HLca99wUaFKLI1tcmrchTvbPc
	 K4eanMhbIvB4oVCgtmGi262DN+SnsYTZY9LNZd6wX1wttg2l52Xnnwerm6NWsgZUelD+w
	 BxSN00MQtAITcGIO3/0EjnxaZtkejQ29g4wg/4M31gyN6+D1A0kkiNV14YcCmdnVGtRQa
	 UOcHnKC/GJ8FxWd91d32dEKaFs/i4k9f9vs5UJpS7cczfa9xtZnLY6b4a8tg3ETx/bUmz
	 Afx7gEMuDchg3z03qwXku1mL6EgylVD5OwIqxWRnq5tOywses3WLlkeEhbEL3a/f2rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794303846;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Scanned-By;
	bh=hdK+pDEbjtxXIas5PTih8G25EZ5jkuMrar1Qn0ux3aM=;
	b=tsmlRni4yvSmRvHdhsGB9Dgj7z3a4XWZzOfvJmaSmzTPmUwAH/c5jwnBCZPYtJipzKut
	 /0WWL98sa5mXtszZNo0zv0jydO98blmyRsmAeQ6UoZHGWV8Mgt4qDZBa7wXqkXIRqoya5
	 E37/y8BXKqsTrQcfqvYmy5/J3u1x1MOnIka6h79ZkvRGYso1mJNIiOJLofCqhw4oUPPZU
	 UpHjkaiJ4LAX8xrpPtnxLBeR0t5AMZIWewJBrL8Jason/0yMjfubIKzoM1qZb9vy+Y2dn
	 CKk7p1FH8oxgdHUZWN4NCD5RGIt17nrff6YAIpKsf6h5dDFKsL4oiyzwShLVZzLeEng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K+k3EGdw;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B30F607695E
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 09:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B30F607695E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K+k3EGdw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794303844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hdK+pDEbjtxXIas5PTih8G25EZ5jkuMrar1Qn0ux3aM=;
	b=K+k3EGdwaAVthiYDKi5o+Q+F4CChGikGhB6QYZDMxsOFbSsKOHBa1OWmIcK9+4n5TnN1gI
	ajDvDIdcXuknnfwQ6LbEWossbpQ+J6WpeI1EPFK/Bbb03/PorUvumy7PEe3noZubKS3gA/
	4mMzjO1BySewNMiG5EKE90Tvb65mw/I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-q5guI-8xOCuxhWOGmMLpKA-1; Tue,
 10 Nov 2026 04:43:58 -0500
X-MC-Unique: q5guI-8xOCuxhWOGmMLpKA-1
X-Mimecast-MFC-AGG-ID: q5guI-8xOCuxhWOGmMLpKA_1794303836
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 662071956047;
	Tue, 10 Nov 2026 09:43:56 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9277D39203;
	Tue, 10 Nov 2026 09:43:51 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Petr Oros <poros@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Jakub Ramaseuski <jramaseu@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] ice: dpll: fix updates of the SyncE CGU registers on E825
Date: Tue, 10 Nov 2026 10:43:48 +0100
Message-ID: <20261110094350.184185-1-ivecera@redhat.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

All E825C PFs share the CGU registers R10 and R11, which hold the mux and
the divider of the two recovered clock outputs. Both patches fix how a link
change updates them, both found in review:

- Patch 1 adds a lock shared by all PFs around the read-modify-write
  sequences of these registers. A link change on one PF could undo an RCLK
  pin change made by another PF.
- Patch 2 lets a link change set the divider of an output only when its
  port drives that output. Every port set it from its own link speed,
  which is wrong when ports run at different speeds.

Both were tested on GNR-D with dual complex E825, details are in the commit
messages.

Patch 1 was also patch 2 of the net-next series "dpll: do not serialize
driver callbacks under global dpll_lock" [1], which needs it. v2 of that
series will drop it.

[1] https://lore.kernel.org/netdev/20261106121005.1327603-1-ivecera@redhat.com/

Ivan Vecera (2):
  ice: dpll: serialize changes of the SyncE CGU registers
  ice: dpll: set the SyncE divider only for the port driving the output

 drivers/net/ethernet/intel/ice/ice_adapter.c |  2 ++
 drivers/net/ethernet/intel/ice/ice_adapter.h |  4 ++++
 drivers/net/ethernet/intel/ice/ice_dpll.c    | 11 ++++++-----
 drivers/net/ethernet/intel/ice/ice_dpll.h    |  4 ++++
 drivers/net/ethernet/intel/ice/ice_ptp.c     |  8 +++++++-
 drivers/net/ethernet/intel/ice/ice_tspll.c   |  8 ++++----
 6 files changed, 27 insertions(+), 10 deletions(-)


base-commit: 1d5e2c57e9ffc134e14b3f837c8d7c53b508bd22
-- 
2.56.0

