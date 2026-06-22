Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D12C37882E
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 22:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782167299; cv=none; b=S7j7XgB4V/a2MfUpYB9G7XiLcxu2d1YbBEW+5kl9xmuDVpRNRKshOLIWnbZ58/z5PATJn25MIVdAQOgo4uBpQk148Rs5NwCXU6lYH+PSeUoKsR97oUL4K6oNMWwJE2LvxN0PpGI440PJXPPXYmlYaF+/VVvCg+wrXKh1DqfvXgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782167299; c=relaxed/simple;
	bh=SihlRBBTVD9/sumreJgofJm7EYPORk4CoiN8TCjcnAY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mZTHxe2LkWWGATPcqxZ7DajK3CEs21NDVlUP4CMOh7UztFMDam38wFgZUKYTt5VhxVLHbI0KsldZxtx/Wd9HB6/RO6BU2gGu8vQ/noVN46kHSJ09d/PIXBFfxFjRT+4raaOVjWoLB3GwKYFHHJd9zGxuHOfbKsvl26oup2rU9u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ofcV7gf7; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ofcV7gf7"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84540c1fff4so6993266b3a.1
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 15:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782167297; x=1782772097; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fVIN0Q4+496+/EZ2BPsuqq3VkPJBQAckK67gmjBeUzE=;
        b=ofcV7gf71kW1NyH7+rbpeYkcSQal/D4xrCi5c+kv5gT6wDLu8Pgj8AFXj4cavAUZ/G
         ZpzX+PheBICFBZpNSg3yiUWj58pZW+e9MX4gvBOYrY47oZbhHnkDxGSY9v31xoknKGmt
         m+H4OlyORp7vvJXM50gpnWc+TRxsHTqqob88uFPeJpCD1mHs/t6HvQXmX/yIZJOvBu9I
         /q/5EDu1IawSRqoHG0v8ovGOpF+vIQGircMo4e0e6k/OaMwuh5IXucuUGG2G1BB0OcNy
         LEcYRQO6iaYsoIxzNdRnFyU3+Q63sjxs4T8KHrcONJEzBnRbw1MS7/AkIxeApgnF7GQW
         LQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782167297; x=1782772097;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fVIN0Q4+496+/EZ2BPsuqq3VkPJBQAckK67gmjBeUzE=;
        b=XD7S8T6OWkxomBiY+JnRE4rTJOAHsAb56skYJi1iwiZ2oOaRlfEg7BjuMXy550np87
         ba50fzqYSk+/hZzzTpGf4gylHAGa1OCzbVpIVitlyp5I6Tw28jFqAGV7i5BqYqVBq0Z/
         rcZEa+Xl7M0dFjG5ZnPISGnBzzo9tj/CYeY8z4tKIo019NTITQVl7zBEBgyw+Z1FEt78
         s8CUaS4r9fWQf4EJsEUAkjntLNsy58sP0bT0LLw++j00BYcHE7q1a7a6zesyMcCA4r5u
         NkV1HTGac0NVyDsB/Q7+37o3jSv5EPu4Ktpdh+94C78eXUrsVAyE9Ss9GTNA4BlOA01C
         McfA==
X-Gm-Message-State: AOJu0Yx8scjQSFEyTJ5yrSRf9T18xs7hDFRnNP9CTFBg2ioIIJ1breyO
	UfFm1xWX1DT1NYdIMF5wwu1qQpEKqVtna0y6a3dpImckUnYkG2zs0NXA5Ln43wZkKSEkt/V7NYL
	kGqpJXcshA5NxI3DP4wiuHMaTS+0x7onCZBhOMSB7sjAJpFjumDL/pXDQig+Ew8+JSSXWfJEQiE
	ocHG2MUeGRsiCOhCCbu6F53gJPANjUWwk=
X-Received: from pfmb6.prod.google.com ([2002:a05:6a00:1146:b0:842:8ec2:ef16])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4004:b0:845:4c76:e46a
 with SMTP id d2e1a72fcca58-845952108a1mr266932b3a.3.1782167296263; Mon, 22
 Jun 2026 15:28:16 -0700 (PDT)
Date: Mon, 22 Jun 2026 22:27:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260622222757.2130402-1-tavip@google.com>
Subject: [PATCH net v3 0/2] vsock/virtio: fix msg_iter desync on transmission failure
From: Octavian Purdila <tavip@google.com>
To: netdev@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>, 
	kvm@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Jens Axboe <axboe@kernel.dk>, Octavian Purdila <tavip@google.com>
Content-Type: text/plain; charset="UTF-8"

This series fixes a msg_iter desync issue in the virtio vsock transport
that can lead to warnings and eventual -ENOMEM under specific failure
scenarios (e.g. partial GUP failure during MSG_ZEROCOPY transmission).

To fix this, we need to restore the msg_iter state on transmission failure.
However, since virtio vsock transport can be built as a module, we first
need to export iov_iter_restore.

Patch 1 exports iov_iter_restore.
Patch 2 implements the msg_iter restoration in virtio vsock.

Changes in v3:
- Use EXPORT_SYMBOL_GPL (Jens)

Changes in v2:
- Use iov_iter_savestate()/iov_iter_restore() (Stefano)
- Use a single restore point (Stefano)
- Reverse xmas tree (Stefano)
- Added comments in the code (Stefano)

v2: https://lore.kernel.org/all/20260613000953.467473-1-tavip@google.com/
v1: https://lore.kernel.org/all/20260609004809.1285028-1-tavip@google.com/

Octavian Purdila (2):
  iov_iter: export iov_iter_restore
  vsock/virtio: restore msg_iter on transmission failure

 lib/iov_iter.c                          |  1 +
 net/vmw_vsock/virtio_transport_common.c | 13 +++++++++++++
 2 files changed, 14 insertions(+)

-- 
2.55.0.rc0.799.gd6f94ed593-goog

