Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334912;
	b=QqSzHPThrqG1fTkRUnI8PPrqRqThk+TEb7bhYXKd9pimPQ9ZvMX0paXiK56EZrmgPV3r
	 cHxeFAFxO1H4dGBXwG0OX9+d4w4cj3zj/ytuoYTdy/pEeEVU6FILR6U+p7kWaNVLqMrlL
	 AVs9leiJgSC4leoO1eJjWSNADAi5xrVVaGiLSYZF6cJU7Z0s0xYf3OVQ2O1jro3MXKlgx
	 HzfqLoFqosfqhRS5aGSFl8fOIIMKn3CsuGM7+fcFzJblcBPxt0DTUpLJV3QaCje6cqR1c
	 pxz/pRdZJYRfL/+C2yn4JYupoiXSlVfiQzYz2fJzJxlQsEv4eqQXJpJL+eWkkBw2wgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334912;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0PkYgmZJJfNK/8KcuDT5iJGwkOjlJWHzg/w8kW8NVzI=;
	b=LwXuYWHZSLXTnNQ1mw9IqQVBw1y5WZDGMIqQ6/VNx110jGAREx2DnuBWnMBOtR5wvY3W
	 3H7hpc64ckIG/zgGN8W9T7iod0TbEfMCMdTIOmtSkhCMVC6OjPuIjUyHE2F2P5lvdWblF
	 AEliInH/D0dlZEXCC835V8lab7KklYTDdw30WlpZpGTMBjj54yYWFUtwTY8jnPunSMoMl
	 GhgrhUUZc+Z27nzZ/nRzxgM+i4JiVM1oQz1zgsdzzJy7aLA2kUSmI+CvWoThSOWKCMVal
	 rl4jQDCuFfsp/2tdp5MG3nPCQ0sMjXkKHlozRhnLqCbYmrL7BX/CpsC2TjPMGHTBcQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U8OcdVlu;
	arc=none smtp.remote-ip=74.125.227.139
Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6878606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 04:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6878606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U8OcdVlu
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-3adfd217146so53886a91.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793334911; x=1793939711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0PkYgmZJJfNK/8KcuDT5iJGwkOjlJWHzg/w8kW8NVzI=;
        b=U8OcdVlu9IRAgvFWuj2XLyEYqE2nZ6ehV3B3SIPC7N3rd0tyCl1W/M1tnVTOjEXr81
         pKeTCB73BvObX1R1hSnzGfCRfhrvUIEmht4+t/PMKBZ9Wz+uLTgStuODZBa5WfAQN7RW
         qAYMsvqCf9N+qX/eAbT0uS8O+ibX1NY2cB7ffyBEccJJPgo1lMSB5JNiUurjnMcvSr65
         n4f+ThFcv3p3jieHsB0JWnlGIoqLNuhkn26y+tavZDD7Xx7PGy0DP+X9fjNwGjtGY0ZO
         WOZ0VpAAg8IT1zMCazcTOZsqbp5wSFZcyk6kcKPBFctBbgq1371fBlR5oLcwbCjewghK
         b+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334911; x=1793939711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0PkYgmZJJfNK/8KcuDT5iJGwkOjlJWHzg/w8kW8NVzI=;
        b=cApbKAbex8R6PYf1ZQw093J1wLsrTjtm/FL9ZD+vqv9yWAcPQz4RomQhoD3BP6/oF7
         4nCYevn8HJm/uIGrelgEb8QYfwcbD5f9T1qxI78pf37DanjgQktqLqGjaiFbA5q6Wywb
         6YlM1mFuVZT95idurN1UwOUzrUtjuK7FCHaZGgWhsPXUikGmzeNYLyA0BLfzBbolDsOk
         JcCBOLwzyX9sHLXURQv0u0FgEjtp6fu2g+NMNFel7Yjt6J228ieRp4OV6tN6RPMRsmQi
         o8r7tzWWaZiK+nVo3WYXmyTZC+w6l5TaEdjQ0ZmlRPYDSn8os8K3Gk3roSrv2w6QADR/
         k6tw==
X-Forwarded-Encrypted: i=1; AKwUvBypCTCWQ+xn5zyuKmVWBQOOXH1YbGaU+hXpLTVfviYOtfUXgYd5BTC+01nljwmG0Oxsr0qncFY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIVmCG0wiZ5JUyKxBnWdeXPnfu5404UjrosXPY7NJseGkmB6Afd
	hSzgSNm6PcQ3iNteoJB2rYSab6UJ535a4OULzN+hGhfTbz+PIDgkYvvcc2QARZVz/B2i9A==
X-Gm-Gg: AYBFou3xB+muAxDYifxUkaZCtnMqLk2lGafn7RVtzAUaRvM6QY2dbs6KX8YApjXP1qP
	UvTZ5Bj61NZTWaPBJwfuNizYJFc2WcQQ7RSRluW9kBSc8btmR2oYfPisXAlgMjwOo7tvMYr/4Fa
	M3PJ+4eibV5/7l45jT1s1CXGZPKs9XGqE9MI9GkqNRV3VNdeLBXSOYAx8wsIybGfIVfSmYOZ0u8
	vvRC0yvr+O5iQ6KaA6KqlOf5aX073PKnfEkGSL8ijam3gZdkJEAZIHM6YrpGZ+79dcUrTPPeR7+
	vnOqyCTmuWn3/pFIeFEoYrrAZrZc17rqVIGGJzTLx3msWBJhd/EKVGadGknuC7iOuKhQ1vUVvCQ
	stvQoOX/38HH0TjhLzdSHt8K8p0KQWLXuScZNMbQ9exUHXwKdjkINau4iklJ6E0Z1ZgbV6L0S+n
	HJawQRZQO6PHPIxtNs/ypiWIxHZPbIHGhAgqai9digo4Yio5IZCvJqGxbN55qVZUb3G7AUCz37l
	42AXPJH/laowS8e+ScJ8DV4zYalTET6YJ1xq9aBNdBkYsORzBQvCMeUJgBhmbrbPKN1AWqNta32
	g4Vuwa5Ehhx5vpK0VLCak5eJf0Ux3gJc1HtTmA==
X-Received: by 2002:a17:90a:e7cf:b0:3ac:9a54:e3ce with SMTP id 98e67ed59e1d1-3ae8986e718mr931783a91.63.1793334911260;
        Thu, 29 Oct 2026 21:35:11 -0700 (PDT)
Received: from amax.cluster.local ([115.233.223.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae85f37e7esm934372a91.1.2026.10.29.21.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:35:10 -0700 (PDT)
From: l1za0.sec@gmail.com
To: kuba@kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haocheng Yu <l1za0.sec@gmail.com>
Subject: [BUG] WARNING in nsim_vlan_rx_add_vid
Date: Fri, 30 Oct 2026 12:34:47 +0800
Message-Id: <20261030043447.3557387-1-l1za0.sec@gmail.com>
X-Mailer: git-send-email 2.30.2
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

From: Haocheng Yu <l1za0.sec@gmail.com>

Hi,

We found a kernel warning in nsim_vlan_rx_add_vid() while fuzzing Linux
with a modified version of syzkaller. We couldn't find a report of the 
same issue on syzbot. We are investigating the root cause and trying to 
develop a fix. Could you let us know whether this issue warrants a fix?
 

The warning occurs on Linux 7.3.0-02415-g7be4bc52fd9e (#4,
PREEMPT(full)) at drivers/net/netdevsim/netdev.c:569. The kernel then
panics because panic_on_warn is set. The report also shows an existing
SOFTLOCKUP taint; the relationship to this warning is not yet established.

Relevant report excerpt:

  WARNING: drivers/net/netdevsim/netdev.c:569 at
  nsim_vlan_rx_add_vid+0xb5/0x120

Relevant stack trace (inline frames included):

  nsim_vlan_rx_add_vid (drivers/net/netdevsim/netdev.c:569)
  vlan_add_rx_filter_info (net/8021q/vlan_core.c:211)
  vlan_filter_push_vids (net/8021q/vlan_core.c:262)
  vlan_device_event (net/8021q/vlan.c:483)
  notifier_call_chain (kernel/notifier.c:85)
  call_netdevice_notifiers_info (net/core/dev.c:2260)
  __netdev_update_features (net/core/dev.c:11179)
  ethtool_set_features (net/ethtool/ioctl.c:155)
  dev_ethtool_locked (net/ethtool/ioctl.c:3488)
  dev_ethtool (net/ethtool/ioctl.c:3669)
  dev_ioctl (net/core/dev_ioctl.c:745)
  sock_do_ioctl (net/socket.c:1339)
  sock_ioctl (net/socket.c:1446)
  __x64_sys_ioctl (fs/ioctl.c:583)

The syzkaller reproducer opens CAN J1939 sockets and issues two
SIOCETHTOOL ioctls with ETHTOOL_SFEATURES requests for netdevsim0.
The warning is reached through the VLAN receive-filter update path
when network device features are updated. The root cause has not yet
been confirmed.

Full syzkaller reproducer:

# {Threaded:false Repeat:true RepeatTimes:0 Procs:1 Slowdown:1 Sandbox:none SandboxArg:0 Leak:false NetInjection:false NetDevices:true NetReset:false Cgroups:false BinfmtMisc:false CloseFDs:true KCSAN:false DevlinkPCI:false NicVF:false USB:false VhciInjection:false Wifi:false IEEE802154:false Sysctl:false Swap:false UseTmpDir:false HandleSegv:false Trace:false CallComments:true LegacyOptions:{Collide:false Fault:false FaultCall:0 FaultNth:0}}
r0 = socket$can_j1939(0x1d, 0x2, 0x7)
ioctl$sock_SIOCETHTOOL(r0, 0x8946, &(0x7f0000000080)={'netdevsim0\x00', &(0x7f0000000040)=@ethtool_sfeatures={0x3b, 0x2, [{0x25a, 0xfffffffd}, {0xffff8000, 0x2}]}})
socket$can_j1939(0x1d, 0x2, 0x7)
r1 = socket$can_j1939(0x1d, 0x2, 0x7)
ioctl$sock_SIOCETHTOOL(r1, 0x8946, &(0x7f0000000080)={'netdevsim0\x00', &(0x7f0000000040)=@ethtool_sfeatures={0x3b, 0x2, [{0x25a, 0x1}, {0xffff8000, 0xffffffff}]}})

Best regards,
Haocheng Yu
