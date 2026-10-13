Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7E94E1C75
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791889121; cv=none; b=PGELEqMM0f2tsaS5LhlUpRpM6GRzTlOiLrdixt2Eq72LCFUXDK3Q/2oofCx3uTCRa+nsoIzWUb7pEpBOPGDiWkvSi7+nBv3xLDXhGLMqkUJ2t7fCmiKolwJWopDh11Hv02tGEt8k/erX+57Xf+1hTnlCj9qY+7NXxKHQsZNrRn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791889121; c=relaxed/simple;
	bh=TaE9Ly6M6reX40WUzo4n5oZ5FLX4vQyvLdUI7s12ZkU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HGB9y/MfRs9Rq7kgeB6ybxek5FUMYYLUgiai+uWXvRjn6FPiStUAQFx2gWSyesBE9kAPaMngoqG1sgDmUe3XETr9TZBOlNksHWn+rMfCQCJsMEPfOw5bhBgmhCx9NW9puGkJ0SslitH+02IS4hq9shQEczEhZuWuof7T26zJ1yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PHjlXyf6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LQEHY4sT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHjlXyf6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQEHY4sT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791889113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=YIXLaYbJVEJiIPKxdajUtKwRlZKZGxRdqRquRKPiCJk=;
	b=PHjlXyf6CDXfmkyArGvW6ZhzKtTlNaykgpCKM+gv6bF+GN44Yl2b6Ehng0NWYgZtEz+tIU
	8XNRiPOTPgltdSPs3EKG3gpi3CpMQqN1WUgtkMsdvqmHS3cU5Ti5us95n8ZYRLrELFssAE
	Q0OVwyLHF5Nxds/E8hurh5bcjqGbV5g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-wZHuca4DNS2xZ5r_2nX6kg-1; Tue, 13 Oct 2026 10:58:30 +0000
X-MC-Unique: wZHuca4DNS2xZ5r_2nX6kg-1
X-Mimecast-MFC-AGG-ID: wZHuca4DNS2xZ5r_2nX6kg_1791889109
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-487038bc9b8so2236494f8f.2
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 03:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791889109; x=1792493909; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YIXLaYbJVEJiIPKxdajUtKwRlZKZGxRdqRquRKPiCJk=;
        b=LQEHY4sT0JuwfdjUu9rcTh82YrbRuj9uL6CzJc94xsU+ho6HuaUK9iyDliyBgd18H7
         cIVpEzw86B8PWPhJYpvZplULgTOQIksk+Ghw42uZMHb/I6cuHeri25d/YyECbHaI3Ql5
         wp0BTX/PeyvhljmePufuwfDoO5pX2bILxWlX2Zd8d9Alz6FZmlYFIoV8iMV0UEau/0LT
         78iEhHqCA2j7jAV3gXztjsvbxgrdp/rY8jikt2fH1Z1qEMBRkWc/gwe4aIvVQoLfK0/v
         KYMlQM/7GoQ688Go7qWoWyRfpcrOYnNlSckTy6sUeMPjTfoXazxeHh4BdLxKIoJZZwwn
         WbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791889109; x=1792493909;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YIXLaYbJVEJiIPKxdajUtKwRlZKZGxRdqRquRKPiCJk=;
        b=pYYRWXP7sHeLhbPSyyMlYdtwtLeMcu89ndhEyWqwXmmnv8YxL6RrPOeZtFIpCkwS4E
         TPj8roEMp+v8nptSkFCYrzDffbUorQvFitHdRyG6928hju4g174pMoLz5YHNmGbst3kB
         pdEZPH6ackEHWq91WJEq6gNaS5PQEHPhnRyE2nm++cWlGtBexF+CQbUvCk2OwLrcEoKr
         KTHrIMF2RJcpKOgNFNH5fGNY1LCTrclqLZBCF8BiRi24Rr2JoHAJjI2VHIcsM28sX1G7
         M4rB6InhOFK/5cHmKwIdHhCOpIStT/w8xJ1nW577OjKQMRCoGC4F+UlNp+zlmOidPxaz
         86ww==
X-Forwarded-Encrypted: i=1; AKwUvBzUmMtTlM/NljjM8VVMLg8H/aKSRDiqm1OSpzqKN3fiB1+CKQxSALhhhGqtbKuk+gMkND2VUVE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ32qJdcnluDtc0WU1RrcDcEnv35VNs61ceA0RmNZ+oq215Cn/o
	oZ4+NznZbfxz6KXL+u2MqWnx2b+sqCIht7Eyhp0v/VUOjDVOS7APO+UVWFGJisJGFkRG0DCTPp+
	x5/o3bkmicUCnYCV+hogi8IVPUbmAlCe6b6isHKAuHGzHHMejYelMeRRqZg==
X-Gm-Gg: AYBFou2BrfYkCPV9d4rX17KWDkzUJSRSNvIur2kZI/6lFwJBHjt272Y2ngwdfTHmsIY
	Hhz+tvLSG0m56836qTBsx1depc4098svVNmZYp82kwjrVzZGY5vfnIqOOzFzlt6bAb4RNlB5RVo
	X2O2qcqjJhjjRav6e66pLrsjwCXNOUkf0SwMjzGStZtD3qgP7WdPQLN+neINaBAV9tQJDnBz5EH
	SJUvQmjFzc4V9qy1IeFx0EPotQutpNOwvzKAYSwMqrE3+cBhubXR1Lg/rn2f7SUwv/jCIVF/ufc
	1Tr1eucPBMecnySYjkPW0TrFc7pKJvfcCRVaCNpM0yQ7oE5AHOhLTlS002NELH1BYnU5vA==
X-Received: by 2002:a05:600c:3541:b0:4a0:2488:71cc with SMTP id 5b1f17b1804b1-4a18e4e9ee8mr222632585e9.32.1791889109040;
        Tue, 13 Oct 2026 03:58:29 -0700 (PDT)
X-Received: by 2002:a05:600c:3541:b0:4a0:2488:71cc with SMTP id 5b1f17b1804b1-4a18e4e9ee8mr222632035e9.32.1791889108394;
        Tue, 13 Oct 2026 03:58:28 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc6b82sm4518508f8f.51.2026.10.13.03.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 03:58:27 -0700 (PDT)
Date: Tue, 13 Oct 2026 06:58:25 -0400
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
	Max Krasnyansky <maxk@qualcomm.com>
Subject: [PATCH net-next 0/4] more virtio-net csum hardening
Message-ID: <cover.1791887415.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent

Allowing untrusted hardware to specify csum start/offset for
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

This basically does this: checksum at ingress, except in a narrow list
of specified known good cases.

Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")

Michael S. Tsirkin (4):
  net: add ip4_parse()
  net: use ip4_parse() in receive validation
  net: resolve uncommon partial checksums at ingress
  net: account for ingress-resolved virtio net hdr state

 drivers/net/tap.c                   |   4 +-
 drivers/net/tun.c                   |  44 +++++++-
 drivers/net/virtio_net.c            |   2 +-
 include/linux/ip.h                  |  24 +++++
 include/linux/virtio_net.h          | 161 ++++++++++++++++++++++++----
 net/bridge/br_netfilter_hooks.c     |  15 +--
 net/ipv4/ip_input.c                 |  13 +--
 net/ipv4/netfilter/nf_reject_ipv4.c |  13 +--
 net/packet/af_packet.c              |   4 +-
 9 files changed, 228 insertions(+), 52 deletions(-)

-- 
MST

