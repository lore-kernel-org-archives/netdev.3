Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C612E1D9A5F
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 17:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787507981; cv=none; b=M6Sfj+E0ztWfUo+85fxkZpf0kt/XHG9NB//F2e3jZzBfhbzv+vrZmwyZy7IB6FC08nxP1YEQ4Z/hTh1RbynMule9cLmbj1osfJOhRrqwJKTh9DT+HOUEz/vGVMprrv5hCgZNVwfPB9OoTpC4SqrNPlhKozHWGqaoCQtNMqzqFmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787507981; c=relaxed/simple;
	bh=j+GvspEPFMJKw6+StUj0ft/LLbZU8zbHTx8oX1MMKJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VVsmuLy/kQmD52TfTKFLK34UssxO/CEVY+HMwK8irvJ8H4rb4ygIZaUDkwSvojXDQqkHzv4dMF1509xH7m30pMkcxUq0dnRdgJCLYm0Jz4uD6KrgWtKfjQoSlpAGSiBsFuIJHQd66xPch/PguLD9bwceT5rS8pRwlzCK6Vzx5Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4oRtADo; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4oRtADo"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so1924999a91.2
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 10:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787507978; x=1788112778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oSG6MK2qQTE9wpGTHa2F4jMVfX6350zfMS2a14Bvdsw=;
        b=f4oRtADoEr14b5rw/5GmI7QM6w8Gw6/ITb4Jd3bc/sYrjzHflzu55LtZE8O00WFNoF
         NbjGGk/37VnUCCs8SI1FS+5H+YBPL2JzqMFm/oEq1KK/ynyWb6Ji14HVhvazcLThq099
         azdtDa9V/iIp0RZAettYkrXgaZxWgDjXZbUySBLg80vsUNi6KfQsJNHMRUJH7JlOPm94
         8DI/BP/QmAX6e/EBxZmyfsoPgHiCx9fa84mDfPvaABF5Kv/XIaOqvUdQiYpVvneGEXu0
         B20LBI5LmOQ98aEGEvh3l5zQTWlGOY9ojEsxFrym5fPqsqKKZm0GMn7E7i7fmt9EbyuQ
         Bh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787507978; x=1788112778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oSG6MK2qQTE9wpGTHa2F4jMVfX6350zfMS2a14Bvdsw=;
        b=E56H6YNP46A3iJ3LrxONywncIsho7jyLemY6Y/61nlHkwAbGDOhGvNzE6fejrXU1yL
         Nc5AX3+gP05uXj7kq57hUpzvR3lXD05zN3pvUtChHTq1dvRQTB202MC0hDZF/8JoxWXG
         D8w1Xs+wqytE1kqZuTREAO73hInANQmwhqlvShGYC9k7MNFrsZirlePUN5frvzQTQETN
         yTRpYOrhJzXBAuu8QDpm/oAt88R6LACEF1i8Y9YmlkBqELYPhZGDBbMCij9WCzi/NYjg
         dmEpt1knOBoqa/9o22XHRwlOjdeTBkemV2GZYnPxPDQibjM3a/Z6zJjHEO9LiwLiKrPv
         zxoQ==
X-Gm-Message-State: AFuF++m1g72zvx1GzuVdjkC8qv3e2yvdpfh0leI+L/mKN6MAh5wYvMUs
	1D1YKn/Ln8p19yvDqMd64u5T/7syYl3/YIdeSszX5yUM0zYbvZyYlyDQb1QqNYsxVm17Xg==
X-Gm-Gg: AR+sD10/J4l/d+i5d45u6WQ71G2tHY8epIms8s+EoCvdZMrOBoUXTqoUPs1FfAYzGEP
	tlfIIFY5ogkKvladWBKMoRg1oXh6ochISF02uJpEem90kwfMRWkchS73U+0vURUzQ0Kh+YaQY3e
	LnA0sTq9POYc6WIXrAyKVAYcuJgXGCbmDec5k+W7tFD1i9UUTdmHcceFTRYwMu0m6qCMdJkudH4
	nEyFu9prSYQLGVza350GfLP4OJ6oIeJHA8oV5fcZEi9iUh4blQZccIeMbxfEZQQhUbUhxevhoHk
	UjdJRz4BqOBFdAZQlDAB4ftdL/pXuI4zsWpb/+WB0zPm0jT9+jGh6/kgtSL5YPBOO6DieveRjwA
	xpmOrWVfs2o+1Lksa1xbHc67aiXDljxaTK86M+6MASZkUHyyEYOE/Th7T8dvBAtpR6XnGtT4JTh
	aZDpe3irT8iFYpfbiy3OVLqBRZDOWyHuuPqhzm9uEORnEn+m3TAJbZOxOWBZKjXsSEmASeoVsz
X-Received: by 2002:a17:90b:4a0d:b0:38e:5b59:c2ff with SMTP id 98e67ed59e1d1-395c3376963mr33466205a91.3.1787507977903;
        Sun, 23 Aug 2026 10:59:37 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c8fd34d9sm3722818a91.1.2026.08.23.10.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 10:59:37 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: netdev@vger.kernel.org
Cc: sgarzare@redhat.com,
	stefanha@redhat.com,
	bobbyeshleman@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	mst@redhat.com,
	jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 0/2] vsock: validate packet sources after bound lookup fallback
Date: Mon, 24 Aug 2026 02:58:56 +0900
Message-ID: <20260823175858.351431-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both virtio and VMCI look up connected sockets by the full tuple before
falling back to a destination-only bound lookup. The fallback can select a
non-listening socket without validating the packet source.

V2 covered only the virtio path. Following Stefano's review, this series
moves the source and transport validation into a documented AF_VSOCK helper
and uses it for both virtio and VMCI. The VMCI patch checks both its
bottom-half and deferred workqueue receive paths.

The combined series was tested on x86_64 KASAN kernels. The original
cross-UID virtio injection remained blocked in three boots, CID_LOCAL and
CID_HOST loopback aliases passed, selected VSOCK selftests passed, and VMCI
accepted a matched RST while rejecting a mismatched-context RST in three
boots. All changed objects built without warnings under allmodconfig and
allyesconfig with W=1.

The current-tree guest-CID vhost probe could not be rerun because the test
user lacks access to /dev/vhost-vsock.

Changes in v3:
- Move transport and source validation into vsock_check_source().
- Trust the internally generated source CID for the local transport.
- Add VMCI validation in the bottom-half and workqueue receive paths.
- Send the related virtio and VMCI fixes in one series.
- Do not carry Bobby's v2 Reviewed-by because the helper and loopback logic
  changed; renewed review is requested.

v2: https://lore.kernel.org/netdev/20260820001517.2148196-1-4ncienth@gmail.com/
v1: https://lore.kernel.org/netdev/20260813121236.2328599-1-4ncienth@gmail.com/

Daehyeon Ko (2):
  vsock/virtio: validate packet source for connected sockets
  vsock/vmci: validate packet source for connected sockets

 include/net/af_vsock.h                  |  3 +++
 net/vmw_vsock/af_vsock.c                | 32 +++++++++++++++++++++++++
 net/vmw_vsock/virtio_transport_common.c |  3 ++-
 net/vmw_vsock/vmci_transport.c          | 29 +++++++++++++++++-----
 4 files changed, 60 insertions(+), 7 deletions(-)


base-commit: 7cbfb180945ce529608e4d4e24a6d483699fab1e
-- 
2.54.0
