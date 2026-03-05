Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6E5157487
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 03:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772680785; cv=none; b=KGx8ZTEmPNoyq5sV01hquURDVX0gNmpfEMltAcjFoMj582H3Civ0AELvaYO6uaoiY7h4RKezE4CuGlV4yO8br+3LmeVA/fhAp39R/qUawNaVjc7lebDYwVFHXZg0SpiYshQiXN6kbVBZg/xE3g0Jl2vh4vidsG7RrLVG9ioSVDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772680785; c=relaxed/simple;
	bh=iXVNil9lhA8BRve59fLzwWwcEcmQ5YILcDjORubOVek=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TXXnW8hiYBuu7hKL1F19ow5uUUQO3I2zLx/V30L0FfMBfLEBzHhG5IkEtOnOYzEOBDPteZpAr0Evao9PT0mz71W+V3KjSRcZJg54/icboW8i7Zyc1zf/h+jAb6LQ/qtPQhLecJJJ1I9DCXGxz3bRt9abxaYOnqrimWM/IEqdgmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GAIactjJ; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GAIactjJ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772680780; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=DzFgXw5HhWpfqyHOZsCbD7JSI6XSBVRoEXJXcdjAQH4=;
	b=GAIactjJyI4PXYFnaT/b4M5EfRh5yzcqppMRRyIOed1nGaq8Q2SlmJ/lrLRT8C4len0xbpOkwaNzWb3TrvBKdAdHQyCqX9dEGH4KgquudjJDd7SKejOnpkfmNVbK+dt95HoZHW0Z4Tc1RrA7Ff0679QRN+AaMwYreuUeiwT6VaI=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X-GtwK7_1772680778 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Mar 2026 11:19:39 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net v8 0/2] virtio-net: fix for VIRTIO_NET_F_GUEST_HDRLEN
Date: Thu,  5 Mar 2026 11:19:36 +0800
Message-Id: <20260305031938.24518-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: aa36ef004473
Content-Transfer-Encoding: 8bit

v8:
  1. move changes of virtio_net_hdr_from_skb for udp tunnel to #2
  2. remove change for num_sg

v7:
  1. fix bug reported by robot
  2. Still splitting into two commits, as the issues fixed originate from
     different commits. This separation makes it easier to selectively revert to
     previous versions.

v6:
  1. rename to guest_hdrlen
  2. introduce a function virtio_net_set_hdrlen to set the hdrlen

The commit be50da3e9d4a ("net: virtio_net: implement exact header length
guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
feature in virtio-net.

This feature requires virtio-net to set hdr_len to the actual header
length of the packet when transmitting, the number of
bytes from the start of the packet to the beginning of the
transport-layer payload.

However, in practice, hdr_len was being set using skb_headlen(skb),
which is clearly incorrect. This path set fixes that issue.

As discussed in [0], this version checks the VIRTIO_NET_F_GUEST_HDRLEN is
negotiated.


[0]: http://lore.kernel.org/all/20251029030913.20423-1-xuanzhuo@linux.alibaba.com




Xuan Zhuo (2):
  virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
  virtio-net: correct hdr_len handling for tunnel gso

 drivers/net/tun_vnet.h     |  2 +-
 drivers/net/virtio_net.c   |  6 ++-
 include/linux/virtio_net.h | 75 ++++++++++++++++++++++++++++++--------
 3 files changed, 66 insertions(+), 17 deletions(-)

--
2.32.0.3.g01195cf9f

