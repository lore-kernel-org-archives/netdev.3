Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660740;
	b=P6AI2lx4hZlEIOe+gb9zDjTl7Z+fk0XnuZygd0mbHrdUI4m8P0knL6UqvTgwc+oSoecV
	 tnVn3e1e8svy4VOD2B1yS3Zfht8aLqwQbfgElm3Y7yCtAUU8vZyqsZebuTrlA0gVCU4jV
	 0v2PdVdgArNR+yMgKe+40Mo3GP/jrzgdWzt3fB65L9SO1xo0TgR8rDD9s7yE3NDM8XYHG
	 78g5FLAbz4Y62b7+CfO68r4YOCIT+RnqWOzSJTLfu/VVBi1y7Xuy3HqC9ybYZ9JBCi33V
	 T/S41/k5oUBPn8tBDQ6ggfso4JVTDDwmBXmEZ0NtUd1JYnA62YZtSoXlTn27fxNh6Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660740;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+3+RimD4u8oBrFVN6CFkCZt6Ny3U/0D/dKYnMLBj9z0=;
	b=yO5c5Ly/J4QfemJn7dcoAw9JlJ3sdcnM2mta4PzmHry2cU4/Nt5cMiAWGd2oVpzyDY54
	 vVHs7Nvfva2l0Zko2VMCPXbQQLZII5w5NdL8xLoH7a0NMfpKpwFlk7BCYUyDabLd12SrM
	 SuAh00ygBPkM2poQaennRkdbaHg1aQzrmwdyKLMuSOla8Y88qP44qOng842lOZf24Z5S6
	 J0o3r+DZ7zgEfMAhpx+vcNDnHJvQDXsjnSdai0CUs5o6VyiYNST2HGaxapq6k7Q1bVCnJ
	 cqJHhYTzooIv2PAM2OsXYUZ4uZvBCby0LMLfYDO8qQBwZYid+BdHv1w8Fr04PN/yCTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e1FUsMFr;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA22606A326
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDA22606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e1FUsMFr
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-16079d54c17so3058168c88.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660738; x=1793265538; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+3+RimD4u8oBrFVN6CFkCZt6Ny3U/0D/dKYnMLBj9z0=;
        b=e1FUsMFrTAW6QUpswIa27YiiEcGG5ijLLfxGR6RmpqWQsR4NH+jWQrxhV4Cd+WZeqY
         SilvJXZEpx8dcyIkaaG3dqf/oi7lQCdZL+hVZunr6sh4Xz9x5EkYUgclVMFHIEoFcMqR
         WqjZl8Cd1Grb3KGpm5TB3loCliDh2wioVKem9bzi8huMz+rIPBvWX4cJnJ0k659DA7Xc
         y5M61fbbg/QUgdxQdy5EkaEHvmYzS+AJBOM3weQgQR0F6yzcdhkdN6S25ZJY8SSkNGeh
         LVESuY1D4biD13sEGWrOUFQsr+/HnjxyVx0rlOXU2oXSzxWSKgm+Q6/OsvgJEdaxt2C3
         xorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660738; x=1793265538;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+3+RimD4u8oBrFVN6CFkCZt6Ny3U/0D/dKYnMLBj9z0=;
        b=D2R0T8/xQRKGMPw6zv46Hhj5P0YYMFBNHYeA6NuRiulwLL6ykO2kK3+XH7Rh2hqihc
         VSoxNBaxJnnXeTNdJj7qt5QbSM0yoVjHZxHbJh1PbdvpFt6h4ZM1EcsBnkp3Xw+ytOAA
         ZPu4gxjGFtOxMlgirn/niVpv7SnRWQHKPX1x/bewMCiPgDuYVm+AvIccSLxPew3DsemC
         lArGPGqSc2P8rwZAzu8lKBzQva0k8AVtzwH62OtcPKNoSKGQQWY+5pGaWMv7Yw2A3QLM
         8Mpv/YYyXw0sv+ZNDgS6F7jANBxF9HTwFIHZo3VniQotCsQpqJYC71dzDE+L3FWeiN1x
         4aUg==
X-Forwarded-Encrypted: i=1; AKwUvBzUPpgxJPCqwxgLXHySKSPs6MAYZcHXOWXrPhbMhdap4XixMmHJZOcSD9iCLJHSQdpLmeynRlQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZ7B8M/l+2n6QVEjlMiR2hDIdrpRRc+xp5+y/d/qdWKPsKzBy/
	lKXTkIVE1c0go1bzzGv3esAlYJ/HdWra/MH81lGXwnkM/ytUUbk+4czZ
X-Gm-Gg: AYBFou1UNQrner171RzTgTLv1BtgAu1VIQNWJ362ieMNIE855gPDYsgIwBL/9Lxbh4X
	i4HINCC068Z4B2Jlfm8h3l0/fBx/cWvjwXAtudNGsh60xm4vRDyEv4q68wFb/8GETzQzhOebCyV
	w6LWHmI1MlRTJeGhF4gSxFJ30/Q8FkJe1SMxNukDbjTTtocwBcSXaL8jBqDG6XD5kylDtuNCKQV
	Nep8T+iBQ1VL71Km4iJcGrkMFUwjF3tlOUtUir7VgJLAgTU0pfof3xbmiSdKOldJfWf1EM99c8k
	CijJZhc4yAks1ms382AqgpHgfpM+6Yp2NzMIr6GXiK9Vv6+wbrUoaNNkJL35SbM73ou2yyOLhF/
	nxEoFPauSfxdCRPl1alR20HoJRfQLejnmX1w/cP9yE6+SWaxwpwOAQ5SbNXBTBoNQpBQt/WLwcC
	QiZ/yr9P04iZZhDc9uZRLuI2HG9si7OGFTB+8JyVTAc9f+FTuWR6h3b9qklSu13q2He9Hyn1W/z
	qqtmY/gfUpWH0XkQNyci7o5h/cFfmPYPxXH1sdwzzddGvADRof2fnwJwX1oMv0Y0LHKWd46E1Au
	jnreI7kY2MuhN1xsBAJMkLSiNM0yV47EI6ceyvEI
X-Received: by 2002:a05:7022:ea57:b0:144:f089:b189 with SMTP id a92af1059eb24-190a74775b8mr5453836c88.36.1792660736253;
        Thu, 22 Oct 2026 02:18:56 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19035926035sm11607230c88.1.2026.10.22.02.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:18:55 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Eugenio Perez <eperezma@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] net: tun: zero-copy path can expose uninitialized packet data
Date: Thu, 22 Oct 2026 02:18:47 -0700
Message-Id: <20261022091847.3654028-1-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Hi all,

The experimental vhost-net TX zero-copy path can hand TUN a user buffer
whose effective vhost virtio header size is smaller than the TUN
device's configured vnet_hdr_sz.  TUN computes an skb copylen that
remains larger than the bytes actually available after stripping its
configured header, publishes skb->len from that copylen, and
zerocopy_sg_from_iter() initializes only the real payload.

The resulting frame contains an uninitialized tail.  The tail can be
read by userspace from the TAP peer through normal forwarding.

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1, with:

  init_on_alloc=0
  vhost_net.experimental_zcopytx=1
  TAP vnet_hdr_sz=200
  vhost TX total length=256
  real payload length=56
  TUN copylen / skb len=128

The exact control with vnet_hdr_sz=10 delivered the expected 246-byte
frame.  The corrected trigger delivered 128 bytes after submitting only
56 payload bytes.

Sixteen of sixteen corrected triggers produced the overlong skb.
Eleven of sixteen had nonzero bytes in the 72-byte uninitialized tail.
Several contained recognizable stale kernel allocation content from
previous skbuff_small_head users, including fragments of environment
entries.  Those bytes were never supplied in the virtio TX buffer.

This is a userspace-observable kernel-memory disclosure on a
network-forwarding path.  It is configuration-gated by experimental
zero-copy and an enlarged TAP vnet header, but the overlong skb occurs
regardless of init_on_alloc; init_on_alloc=0 is needed to observe the
stale tail in this test build.

This is distinct from candidate BR-023/BR-025, which exercise
IFF_NAPI_FRAGS.  This reproducer uses the non-frags tun_alloc_skb() /
zerocopy_sg_from_iter() branch.

I found no direct upstream fix or CVE.

The vhost ring reproducer and complete program/console logs are
available on request.

This was found with a multi-agent workflow; the
information disclosure was reproduced in QEMU/KVM.

Thanks,
Cheng Yongkang
