Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D3338C42E
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684223; cv=none; b=TgfJYkQtYD+a5GPfNeJ5W0PjHBByLHDiTvL2+OFhpmD2ugUaqFiZugDyb3Dod/DF+XaIzc5yjGQclyQxBvGiq05Gu1JXxwLRP1us4rZo6waExtCNnrdS/GEVLctnl8mkxWAk/r0lxqPw55bIqkdqqmZexfoacRfLYsycD9VIltg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684223; c=relaxed/simple;
	bh=BOmOQLJZOoczUeErJCxBT0UHxOdh++eEoqzOuXP5OCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=htVFE9bFds10spmE3QQY3jdv2G9LG+0IXd8VaZAwKd/yPq9Mfy3Iwku8Tvq854dbPSIyqpqZj3PhbSNEAWdpr0yHin6pQ9xvSb0FfaCmjkmrfJ064L1UDVdpQ8xi14P5mV8WlMHs8cZ/JwSMGn2cA8J8GYvj3NmpBxNHwzuuY8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b6DxRDeR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6DxRDeR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778684221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dNbsehtQ4cFH5TLmnCDvRd2q0muKxl+j65WT/CUe9OA=;
	b=b6DxRDeR4MZ3aSkdxiDTpszTlicM0MaPd9BP1j/2idYjmVVqPLq4yY1nC663rBVn0FqE+d
	2Qj2SaXYWXNes7TXodjXc7ED2pRqNNHUV14X/Q2fDbAjJfllcEtHplHdsiFm8IyKeFMWZE
	Y9gxrBm/f7zsyx+80A/ORgLAqlHBVYs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-iKePG4wJOTaOjDXTX0hpqw-1; Wed,
 13 May 2026 10:56:54 -0400
X-MC-Unique: iKePG4wJOTaOjDXTX0hpqw-1
X-Mimecast-MFC-AGG-ID: iKePG4wJOTaOjDXTX0hpqw_1778684212
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 22BED195608F;
	Wed, 13 May 2026 14:56:52 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.20])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 620E719560A2;
	Wed, 13 May 2026 14:56:47 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Michal Schmidt <mschmidt@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pasi Vaananen <pvaanane@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] dpll: add NCO pin type and zl3073x support
Date: Wed, 13 May 2026 16:56:43 +0200
Message-ID: <20260513145645.175451-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add a new DPLL_PIN_TYPE_INT_NCO pin type for virtual pins representing
the NCO mode of a DPLL and implement support for it in the zl3073x driver.

Patch 1 adds the new pin type to the DPLL netlink spec and UAPI header.

Patch 2 adds a virtual NCO input pin to the zl3073x driver that allows
userspace to switch a DPLL channel into NCO mode. The pin reports
connected/active state when the channel is in NCO mode and handles
the hardware-specific details of mode transitions including automatic
df_offset capture and 1PPS phase preservation.

Ivan Vecera (2):
  dpll: add DPLL_PIN_TYPE_INT_NCO pin type
  dpll: zl3073x: add NCO virtual input pin

 Documentation/netlink/specs/dpll.yaml |  12 ++
 drivers/dpll/dpll_nl.c                |   2 +-
 drivers/dpll/zl3073x/chan.c           |  14 +-
 drivers/dpll/zl3073x/chan.h           |  24 +++
 drivers/dpll/zl3073x/core.c           |   7 +
 drivers/dpll/zl3073x/dpll.c           | 259 ++++++++++++++++++++++----
 drivers/dpll/zl3073x/dpll.h           |   2 +
 drivers/dpll/zl3073x/regs.h           |   7 +
 include/uapi/linux/dpll.h             |   4 +
 9 files changed, 291 insertions(+), 40 deletions(-)

-- 
2.53.0

