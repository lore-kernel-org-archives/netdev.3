Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793967023;
	b=ZoDhVbMHGJcDeibIQ7tdUL7T9TafQIYB1c6AihX2Y1GaWcnCldiqwOVW+adNNE/zupJO
	 f4v+dRqc98weB2omSXuVO0Emu/kHH8/SjOxOyJ9CitvK7AhleWRcnrUQNnJ4uID0Bzbej
	 ZSY2/zh4aD7JAiaFg0Kdt1CSmbY1bK+5CEaqlATcSM+TEHlcBaFNseyR5qgn2za3MUbCo
	 GbnQc1vxj6//z2mY4N3Bw+OEAq43OuyRqOAsz44kQyctLq6Av2kMw+kQMUgMTS7v9kagZ
	 twrUwZwQXH/VmYHIXtwKRN5q5MGV8+wuBswYq2ioHlHwWSlLCOruRbviutHVq4XRMOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793967023;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Scanned-By;
	bh=1SnvqQraxsws2oD2RJ2+rSb1NqZ1L9KnGIj6EOlaZ80=;
	b=EJaXOpcWGLHehf1bGZYPk5rQCZSj8qvCy+cbGNyulR1FVYwkQZMXpmOrBFmn/4NJVVrD
	 gXZ73Ye7Vb5Bp5Rz2Z86EQXVWDnYF5Su1ju4Rpj1hCy2pFuhGDQLbI7d4uX7msHK4UbTo
	 azUnVSRxIjrAvMMEWFKE0PJldXRsgpXWhfPknNVoBXvlTxE2jfAnZqhuEjWq8IMXv297M
	 zT/gzIy9N0v/EWVQY8Xr3ia7hg/rtyvm3SyTINxP9QKJ5xxaXJDFAI08yXjKzwp4Svwji
	 /JI7D6q8/7MVzLFMCp5ZRU1mUxUPnElL1DbmVQbo+7YHtR0VxgOA6+/mINokypq1pxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B6uNR71H;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22661606D819
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 12:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22661606D819
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B6uNR71H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793967022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1SnvqQraxsws2oD2RJ2+rSb1NqZ1L9KnGIj6EOlaZ80=;
	b=B6uNR71HmMQwSMuThLvEGq1B2gxbDT+U5FPEvLflr0LYK7Lv5PxTlJUQyibxMg3tmQmLfl
	jX7sppCRbk/UTH4ak+8edjcdjAf+yBvhekuo4EavSldduU8ZMNIJrZ3obNwIj6k3aWC660
	GIYm+KWukCINl5Mufl7pwB+gIKZ8FkM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-xMNlk3AOMYWJEFraLRt9tA-1; Fri,
 06 Nov 2026 07:10:17 -0500
X-MC-Unique: xMNlk3AOMYWJEFraLRt9tA-1
X-Mimecast-MFC-AGG-ID: xMNlk3AOMYWJEFraLRt9tA_1793967014
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF7741800676;
	Fri,  6 Nov 2026 12:10:13 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1469E18004D2;
	Fri,  6 Nov 2026 12:10:06 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Min Li <min.li@microchip.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next 00/10] dpll: do not serialize driver callbacks under global dpll_lock
Date: Fri,  6 Nov 2026 13:09:55 +0100
Message-ID: <20261106121005.1327603-1-ivecera@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

dpll_lock protects topology and object lifetime, but it also serializes
all driver callbacks in the system, so one slow device stalls every other
DPLL device, whichever driver it belongs to. mlx5 callbacks issue firmware
commands with a 60 s default timeout, and zl3073x callbacks can wait
seconds on a driver lock held across ToD writes and phase steps.

Make dpll_lock an rwsem for topology and lifetime and add a mutex per
domain for callbacks. A domain is all objects created with one (module,
clock_id), in practice one chip or card, so channels of one chip stay
serialized as drivers expect, and they still block each other. Device
callbacks run under the domain of the device, pin callbacks under the
domain of the pin, whichever driver registered them. Only one domain lock
is ever held, so domains have no lock order. A lock per device would not
work, because pins are N:M with devices and callbacks notify sibling
channels.

The driver API does not change, but a callback can now notify only
objects of its own domain. Patch 1 changes the one in-tree callback that
does not follow this.

Registrations across domains exist in the tree only on E825, where ice
registers fwnode pins of an external DPLL with its TXC and TSPLL DPLLs.
These callbacks are no longer serialized with TXC and TSPLL, they rely on
pf->dplls.lock, and requests about these pins wait while the external
DPLL is busy. Intel folks, please check that this is fine.

Each complex of a dual complex E825 has its own DSN and so its own
domain, but both use the CGU of complex 0. Patch 2 adds a lock for the
registers they share. Without it a test lost updates of them.

Patch 5 is the only patch that lets callbacks run concurrently. Patch 6
adds KUnit tests. I also tested each commit with a mock driver and YNL in
QEMU, with lockdep and KASAN, and the tip with lockdep on two systems:

- A board with ZL30732A: every notification the driver sends from a
  callback, concurrent traffic with PTP, driver reload and rebind.
- GNR-D with dual complex E825 and zl3073x: callbacks of the pins shared
  by both drivers, TX clock switches, RCLK pins of both complexes, a port
  going down and up, and both drivers unloaded and loaded in either order
  under load.

mlx5 is build tested only.

On GNR-D, with ToD writes running on the zl3073x and requests waiting for
them, requests to an ice DPLL took 1448 ms in median and 3.9 s at most
before this series, 0.2 ms and 0.3 ms with it, the same as when idle.
Requests about the pins shared by both drivers still wait for the zl3073x.

Ivan Vecera (10):
  ice: dpll: notify TSPLL lock status from the periodic work only
  ice: dpll: serialize changes of the SyncE CGU registers
  dpll: add domain object
  dpll: take domain locks around driver callbacks
  dpll: convert dpll_lock to rwsem
  dpll: add KUnit tests for core locking
  dpll: reject measured_freq_get for foreign and on-pin registrations
  dpll: zl3073x: update locking comments
  ice: dpll: update locking comments
  dpll: document locking rules

 Documentation/driver-api/dpll.rst            |   44 +
 drivers/dpll/.kunitconfig                    |    5 +
 drivers/dpll/Kconfig                         |   13 +
 drivers/dpll/Makefile                        |    1 +
 drivers/dpll/dpll_core.c                     |  187 ++-
 drivers/dpll/dpll_core.h                     |   34 +-
 drivers/dpll/dpll_core_kunit.c               | 1573 ++++++++++++++++++
 drivers/dpll/dpll_netlink.c                  |  117 +-
 drivers/dpll/zl3073x/dpll.c                  |    9 +-
 drivers/net/ethernet/intel/ice/ice_adapter.c |    2 +
 drivers/net/ethernet/intel/ice/ice_adapter.h |    4 +
 drivers/net/ethernet/intel/ice/ice_dpll.c    |   29 +-
 drivers/net/ethernet/intel/ice/ice_dpll.h    |    7 +
 drivers/net/ethernet/intel/ice/ice_ptp.c     |    2 +
 drivers/net/ethernet/intel/ice/ice_tspll.c   |    4 +-
 15 files changed, 1915 insertions(+), 116 deletions(-)
 create mode 100644 drivers/dpll/.kunitconfig
 create mode 100644 drivers/dpll/dpll_core_kunit.c


base-commit: 6584acd42820478910a771efb28a355a707e9cb0
-- 
2.56.0

