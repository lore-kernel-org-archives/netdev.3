Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146E05208B1
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068084; cv=none; b=RAxUgf+aVyp+C7WcUAjYw3XXbl9z9rwe50Z8tKEy9derP54IP4z0i1FAtStPV/QIVuJZimjU4nSYz/PjfrZ+TxUvW4IXG4LKqr775/vcR3oywb/3Ze7UIXzjTo5A6kCIQHv2qMSP0IaVz2FGZ392N0lTKdOAVIIx6mF+ZBNDYso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068084; c=relaxed/simple;
	bh=ULFAxBtXFUyYxoYoJoEfrtH9PizTTVRo0tYPLbXLjgo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UUAwY9zwydBaVP2LicUBY7Ij27AifZcEFZCP4NwSgpPM/DsNeQeNQOzYKkJKNasnp/evvI8zwTyOBgh3QiBvpG8vY8/hJ17Xo4vLpx3arzsxzCS9cgmJWOYLIezFlQa9W34CMXOj+0cx5GP8PTHf8gNV6BUbdTb+XHWEEZDOkg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dI6av1Kw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VFuj/0+T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dI6av1Kw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFuj/0+T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792068082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6+E5kAELX03rlqVLLUN+DuDipBZlXtEdhg/J6E2iFuo=;
	b=dI6av1KwSA+kMWPqAGtBJV1H/6aNa7vCZK8BbDU+7A5HD+LSahGio5Lfo7H4ij0LM8TPzD
	XIgsL4qf8Cn76GWrQNsTnbJ5aPdATyuCwT/pGBJoalT3bUDL56NXaNAZj7jqFt5ZpaRyl5
	D6fr+15iitgj1t+yngjoi8ObVZeNlUg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-epWrpvMFOnu2GS92xxiu9w-1; Thu, 15 Oct 2026 12:41:19 +0000
X-MC-Unique: epWrpvMFOnu2GS92xxiu9w-1
X-Mimecast-MFC-AGG-ID: epWrpvMFOnu2GS92xxiu9w_1792068078
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a1ad49096fso28914425e9.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 05:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792068078; x=1792672878; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6+E5kAELX03rlqVLLUN+DuDipBZlXtEdhg/J6E2iFuo=;
        b=VFuj/0+TNoubY4YJSUbVJLnVtto6Q/16T+7OucbffRaVuk/MZLpSW+7vJXt8kpsFt1
         BjGt6aau1dtLHOa8ri6FXEl10Mm1Ku3d5s+3Bsk5vNVo+Tu9h0KeVAlXygEtbiBhhAT1
         wuiePfUwC8/w2tbLa1FA60u5D0lsauizjUYe/QC6DHsDZQyGuxuGpDJU0GYP4pXDfPL0
         vTcl726quMaDEosSDLBY2k4G5QYJSLY2H6QXg8Tp6PndJ8kx5gEPZ/nY7EPcL23iL3iS
         83dfQY48IjeZpsgkb7fP1LbZv8NRubS7f6Q29AXJ1p3tU1xHU05N2B3VTX5rfidJzcXZ
         /ipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792068078; x=1792672878;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6+E5kAELX03rlqVLLUN+DuDipBZlXtEdhg/J6E2iFuo=;
        b=HZJeXevokBE9FxrNMLkowBVuKhe/X8jvvE+S6ir8zZ1xbW1VhA1b2pH0wlIzYoRYeb
         IVzDKj6lWKNHSMgp6GVNmnbWc8vf4g9IQBkDSHgU8aS5+FNz+ZzDY67NcUbFIm57eU4l
         ns8aA1wuRL+duWkvJMLUgKBk/ypXsUqru9npbACK2BuxJ3I7F3raRwiQVhdFbjdOeT6t
         4PHgU95IejPiA9jbL7vRMowrF5UMW3KwLfDUJGaHvhQ0ewIa5zskbQZF2dqyPIGjbEca
         V7ARQNplOuD/ciYae2dRxdK2XzaHmuxTiAGZ+VZvLIU75eo/0qshhIyiCQ8630AKKq+o
         RSxg==
X-Forwarded-Encrypted: i=1; AKwUvBwDvORNEwxhWhrUoW8z3SoFyJOi5ihtusAgGoQ6dMV5wyERaNxmwdbOXLviVdWek8GVpzAVEQ8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLK0axMaKgmg5qvfWop0wbfxcXzMpLc+C2FZjFY596thmEfCfub
	Nsqi2ZnF9/Um5XYqbOJ1Nwe/XcjiSn6cC8U/Xa7O8GAwAIfD6DfTCoMf2/3aqdm/ZnwKGM8M5cZ
	jT1oEGCWSFuV+iACD9zoPbxrZDlOfitOEg4GjWMMGthATfQwXO5XuWTsrAw==
X-Gm-Gg: AYBFou1XiTmkKXYFPBKCOzHfHsOcTkD/U4em4gJvBDULW1VGOFyW0JQQon1+xaPLjK8
	LEUK6E0FDt3KgngpC9JJTTPZ/jgYuUwXuxyz0b8xr1bVeqJ1xE8jP6zBIgif7Nl6c5zbWru32nw
	wQXG4mFeGcdTBc6rhPhb5DfMq9k7vRDiRYDrZAHsPV8vK9uxeqymO0cKF3TUx1b+/T+jRIusAUV
	RryI9YqQhwryy+AtTm+T7OdQV9pqgCHrSwqldDuX2B7yDYRvYwdjoiKYmfiMEBdCrE2MUANOBPz
	kAZFvyM5ZQR/Gax80/uar3YKvGaOp7dEmuodN1+fG92Wdgf/jiagc4Ejd26nh4kPsYwGfQ==
X-Received: by 2002:a05:600c:a011:b0:49e:6581:7baf with SMTP id 5b1f17b1804b1-4a18e447d8bmr371386845e9.2.1792068076511;
        Thu, 15 Oct 2026 05:41:16 -0700 (PDT)
X-Received: by 2002:a05:600c:a011:b0:49e:6581:7baf with SMTP id 5b1f17b1804b1-4a18e447d8bmr371386275e9.2.1792068075878;
        Thu, 15 Oct 2026 05:41:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bdc036a4sm78912855e9.11.2026.10.15.05.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:41:15 -0700 (PDT)
Date: Thu, 15 Oct 2026 08:41:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Rusty Russell <rusty@rustcorp.com.au>,
	Max Krasnyansky <maxk@qualcomm.com>
Subject: [PATCH net-next v2 0/7] more virtio-net csum hardening
Message-ID: <cover.1792067836.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent


As reported first by Paulos Yibelo <habte.yibelo@gmail.com> (after which
others, credited below, found more ways the bug can affect users):

allowing untrusted hardware to specify csum start/offset for
CHECKSUM_PARTIAL was not a good idea, because, if it edits the packet
outside the actual checksum, and depending on the setup, the networking
stack could be looking at the packet both before and after the edit, and
seeing different results.

Previously, commit 6785011f8b16 ("ipv4: validate checksum_start before
completing checksum") validated all known instances where this
causes the most grief, but the real fix is to make sure
that either only actual checksum fields are ever edited,
or the checksum is completed before the net stack looks at it,
so it is always consistent.


This basically goes back to
what we did before f43798c27684 ("tun: Allow GSO using virtio_net_hdr"),
except in a narrow list of specified known good cases.


Summary of the patchset:
  net: account for ingress-resolved virtio net hdr state
	- accounting, not the fix itself, dependency of the next one
  net: resolve uncommon partial checksums at ingress
	- fix itself
  net: add a sysctl to opt out of virtio net hdr checksum validation
	- reducing risk of the fix by adding a sysctl to disable it
  net: add ip4_parse()
  virtio_net: cleanup protocol calculation
	- cleanup resulting code duplication
	 (kept separate to simplify backporting)

Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")

Changes since v1:
	- reorder patches to fix bisectability, addressing
	  a comment by Björn Töpel.
	- code refactoring, different patch splitup,
	  a sysctl knob to disable as suggested by Willem de Bruijn.
	- fix a bunch of minor issues spotted by LLMs


Michael S. Tsirkin (7):
  net: account for ingress-resolved virtio net hdr state
  um: vector: honor virtio net hdr conversion failures
  um: vector: trim skbs before verifying the header
  net: resolve uncommon partial checksums at ingress
  net: add a sysctl to opt out of virtio net hdr checksum validation
  net: add ip4_parse()
  virtio_net: cleanup protocol calculation

 Documentation/admin-guide/sysctl/net.rst |  15 ++
 arch/um/drivers/vector_kern.c            |   6 +-
 arch/um/drivers/vector_transports.c      |   4 +-
 drivers/net/tap.c                        |   4 +-
 drivers/net/tun.c                        |  41 +++-
 drivers/net/virtio_net.c                 |   2 +-
 include/linux/ip.h                       |  24 +++
 include/linux/virtio_net.h               | 249 ++++++++++++++++++++++-
 include/net/netns/core.h                 |   1 +
 net/bridge/br_netfilter_hooks.c          |  15 +-
 net/core/dev.c                           |   6 +
 net/core/net_namespace.c                 |   1 +
 net/core/sysctl_net_core.c               |  54 +++++
 net/ipv4/ip_input.c                      |  13 +-
 net/ipv4/netfilter/nf_reject_ipv4.c      |  13 +-
 net/packet/af_packet.c                   |   4 +-
 16 files changed, 404 insertions(+), 48 deletions(-)

-- 
MST

