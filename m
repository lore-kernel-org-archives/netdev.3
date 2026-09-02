Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4964E3E3141
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 23:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788390074; cv=none; b=TIcTB19zBhe6RI+tzr1fAW0dh5jWbJpm70jypRtRLSU3NSLfxLT0/lsAH+Us/4n6QrW9TLjIA3LqYjpZsqmFmKEyuEbN+s1pK1aZ6NA2iPq9AQZS9nxtoyiYI8L6P/QL0TO63fRaMk0wkTxyhjmBQ2RGGdnIwhOp0gd3XJhXOPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788390074; c=relaxed/simple;
	bh=S/34GgnpIisKNAJazB6aS6c0H4pLuTB5PSuj71c9luE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TTee+jfogEeKpHZp4nB05BbRiB00nEjwFoazAvap2iVMVQvbld/lifPwRr8oxhkkjbecYpwyXbZ3UxwCcrugbZLd26vKl8evvpcMcU3jdlbgRZILNWXJrcqQSx/vvjQrTRAIDQg712ZZspeXiURoFKoxAn2zZVafubooZEcL8sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgOBW8jj; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgOBW8jj"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-46adfc81112so909152fac.3
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 16:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788390067; x=1788994867; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2/4BUiYwhmx8BTSrnAZKpKB6tkHSRMMIf9FbGNEl8BU=;
        b=fgOBW8jjg76UuyelSrqyD4H08vG0+FQAbIjEB+fpjLGKwtJJ8/QQ4NQzwSqlDovnI/
         jtTiHh1sU4A6WTPsVcwaefFfQlHoK4kj6ycZYD9YN3m62JsHBYql+J4bQxlec1AY9ps1
         nyaQxMfmR+82JzhpcUUJXsWnD4siJLTQCZfAN6ZV5OzxKQkwMVWnGEyS9n7mDGWjJOzF
         8A4XSu26eJbe2WnU1hEdwwOK0TJJ9dyAxqmK8LUhGROCwukdpSnwEuiEWgr4d+MBCT1r
         N07j6g4KfJ7ap6MBfoUk7cnKmhE5cy66lOLZsDKW7dS4tHVKkoSbdnj3ACmlkxc3DDmm
         YNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788390067; x=1788994867;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2/4BUiYwhmx8BTSrnAZKpKB6tkHSRMMIf9FbGNEl8BU=;
        b=SEpB+5T/jPPtSxkzVvsESbAiqA/GXZnQps1rlrRQvV8X+lnh30fbZnPh9wmX9B29tD
         kUsHaktQhfmxCPN5mi0LPNmjWe7HCzVnF+31TD90A15jvKjPJQqBag6/3rPgD3ppUzgL
         b/mhyDKodTPP4ZhBqP3cpQ0jsFtgzqYhCLRjzGwihoDlOJEuGBsHAcFwwpo7drq8oZwD
         kkjD1hkSMmUwJ+ynB40ewrnBfPoPCttA3UIjXdCwu0g1FuSGPxVFKKnVJNaVMDfubSY2
         76xE2pJc98xWr+FRvWvHN06CbZNMXJTlZEVKXBYwpyaGSDafbzT3fe5uuuAa9ROwEr0m
         HKHA==
X-Forwarded-Encrypted: i=1; AKwUvByvLZnMt7NjUbjLgX9HSqSFYZFx4W3/amdAtt6tAOF8syUSFqw7sT6unQm6uWsxYLCyO4pqIVs=@vger.kernel.org
X-Gm-Message-State: AFuF++lSJOGIhGYVlJbLkajUelnTT+S8tiouLIIcCwmgZESMlvKSWXEX
	KNkwQOFfOxITF84lterlNP4J/firJHKU895tRWjtA31gGa6Q4Z7q+aBI
X-Gm-Gg: AYBFou1MQb1CZ2LECmGjF8Y6jo29KSHG+G5RzDuI0irpys7M5OkZBcH0d7AN4SpY3zq
	Ksy9ZeuZrW3vd/4bEOGr8458cZ0nWeXwDXQHR4PNz2JZJFh8QEe6VZukO+4ygxV0uMeY3N6yCzF
	+SJZws3rBhO2GAq5z2Xf81BIp4guw2HUWi0s/CGuEW2DXqCxzTAauM0Ab2JZcGky9fAo3eTjuuK
	SjiT0S8f4gSq1l7ncsuqqUTfl/II9SH4U7uMdetROQzXr6crXaH7ddbaLx6rzwJXF9UV6h+s3SI
	KcxRIJVVtbj/OtmVcF9qflUMcPtKILNYvAgPqYQJFPHlsgsfTu9vPDKLe5XWI42/Nhxd7Ueh1+A
	Bhc6gaVeL4H8K9rwwVL0WT5GF3PDVDtUw9X0DWWEs85XhWdAYU6hKcitxWCUn5jvMGKsRd3RADI
	XxgmpXzJZOpGh4qmFheFWSJNOzrx2uwSijqwELVfwzAIzdezMRXUo6KHyZ
X-Received: by 2002:a05:6871:368b:b0:456:4c3f:7e03 with SMTP id 586e51a60fabf-46f87b8e5c6mr7802048fac.18.1788390067079;
        Wed, 02 Sep 2026 16:01:07 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-46f32f87146sm5619656fac.13.2026.09.02.16.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 16:01:06 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next 0/6] vsock: assign the guest vsock device to a
 network namespace
Date: Wed, 02 Sep 2026 16:00:46 -0700
Message-Id: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKGqmGoC/x3MQQqDMBAF0KsMf+1AYtu05Cqli2BGGwpjyUQRx
 LsLvgO8HSa1iCHSjiprsTIrIvmOMHyTTsIlIxJ61wf3unlebR5+PC1ijdU4u5DG+8PnFJ7oCP8
 qY9mu8A2Vxipbw+c4TlagUtRqAAAA
X-Change-ID: 20260831-vsock-guest-ns-d06af451da67
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, sargun@sargun.me, 
 jlinbox@meta.com, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

vsock network namespaces let a host put each VM in a namespace of its
own. A guest has no equivalent yet. It has a single G2H device that
cannot be assigned to a network namespace.

This series lets a guest move that device into a network namespace. A
new ioctl on /dev/vsock, IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS, assigns the
device to the namespace of the calling process. The namespace's existing
ns_mode then decides who may use it: a "global" namespace shares the
device with every other global namespace, and a "local" namespace keeps
the host connection to itself. The device starts out in the initial
namespace, so until the ioctl is issued nothing has moved and no mode
has changed. There is no explicit unassign as assigning the device back
to the initial namespace is equivalent.

The ioctl requires CAP_NET_ADMIN in the initial user namespace.

Connections that can no longer reach the device after a move are reset,
so that a namespace which has lost access cannot keep using a socket it
opened while it still had access. Following netdevs, the device returns
to the initial namespace when the namespace it was moved to is deleted.

Transports opt in through a new netns_assign_allow callback. Only
virtio-vsock implements it here.

Patch 1 is just a const cleanup that patch 2 needs. The remaining
patches are actual implementation and tests.

Based off of Stefano's original series:
https://lore.kernel.org/all/20200116172428.311437-1-sgarzare@redhat.com/

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Link: https://lore.kernel.org/all/20200427142518.uwssa6dtasrp3bfc@steredhat/

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Bobby Eshleman (6):
      vsock: constify the transport in vsock_for_each_connected_socket()
      vsock: add IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS
      vsock/virtio: support guest device network namespace
      selftests/vsock: add a helper to assign the g2h device to a netns
      selftests/vsock: test the guest vsock device network namespace
      selftests/vsock: test the assign ioctl privilege checks

 Documentation/admin-guide/sysctl/net.rst           |  18 +
 include/linux/virtio_vsock.h                       |   2 +
 include/net/af_vsock.h                             |   9 +-
 include/uapi/linux/vm_sockets.h                    |   6 +
 net/vmw_vsock/af_vsock.c                           | 200 ++++++++-
 net/vmw_vsock/virtio_transport.c                   |  28 +-
 net/vmw_vsock/virtio_transport_common.c            |  28 +-
 tools/testing/selftests/vsock/.gitignore           |   1 +
 tools/testing/selftests/vsock/Makefile             |   3 +-
 tools/testing/selftests/vsock/config               |   1 +
 tools/testing/selftests/vsock/vmtest.sh            | 461 ++++++++++++++++++++-
 .../selftests/vsock/vsock_assign_g2h_netns.c       |  45 ++
 12 files changed, 774 insertions(+), 28 deletions(-)
---
base-commit: d0ec95a8a4e79f2fd6063fc8932415db8c227689
change-id: 20260831-vsock-guest-ns-d06af451da67

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

