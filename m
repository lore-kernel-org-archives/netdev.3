Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C372FD69E
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 13:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786369261; cv=none; b=R5oe3PeVMJugV3obXA/gSfi/DXdRvuREgF8H9f/7qwquFAka5+BUN/3D6tZXol1foHzt7pkmMktLtrtREFLtRwNcoaC827K8eK19LZ1Ib+Dt/xjSD1Epc4b7JkRQniMZ0MwXbrW1r8hfhJUzxlehxipkMa44D86/jrvQ90vpx+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786369261; c=relaxed/simple;
	bh=AUbwQjIMvFKx3j6iyCHUmQeCfVu5WpUz9Qg7tHjkwWc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FC5No3eDXdVYZzNIukFPULeiP+bvlCR081SvTO8XFhxv7VbOJOmzDIRPOcQPlu84CjWOAGVnCG0S2pYatQzaVqWAKE/8vpspz20LtEsZ1DnBDeDG8mb00PCkIEFq92lQBKxANAC8heAmSv7tFPu39zTbZ7tIySkqKMQw6ETg6pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=plw+cpYr; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="plw+cpYr"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84e507b079dso1088518b3a.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 06:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786369259; x=1786974059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rN0NY1JfJxx/3rIRMWpYI9WN4m1+geIAl9racAyY7U0=;
        b=plw+cpYrYXm9BoZSdXeu3JQfMsv8d5lG8nFYBQOoQ8cVCj8f2JvKq9H4R49uUeVoTQ
         RX7cDvT9SWYpoNerZulWyJvCJ1vYA4/Y4Xsg+K5kshOCblHI/w73XG8xHbf2ZQuNEshs
         m621IqNH6/HMQqhtAtM+yLg2dflSQdlTr1gwAskrq7+VKqP5lSkaSv5mmoiwinaeDq1N
         P0kdS0BVNqgbWSqo/eLOYxCqYITBGc8ZaFYuZk6O1p7V7fiYGiupKQY9jDqOB6YwvyeI
         ct/EnAgEXrQLjVSQO2Zv6/U/zvEU6+pnjsQlr+8+FQGdd8fVvr8bPh1KEJf/614hUS3h
         lBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786369259; x=1786974059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rN0NY1JfJxx/3rIRMWpYI9WN4m1+geIAl9racAyY7U0=;
        b=i2kVWopAgIH6E5b1fkHbGQ4FeLHFrshfE96R6y7oCC2zP+0zhF5WUIpjKJs8F/sVVG
         Zi+0YV446hKK5BlT0daKC0fvMH8GKdJS8OGrYRGSWg8GK3cg9xjH+3aRZqgIAfz6XZ09
         diYQDQZVJSJ6FBnUoGheH0tL6O7vD4nN+mW9MLzJ8DNI6Hzg7CoD16xJ/YABA5n0dVwg
         FUVxW8QU295D0Kg3qoUAmgBXT2rtISNwe3ztrydSEvixpn+bf1W+3EQX2UMROdp4M4K0
         5ulxVXthzZnmeuu09vqyTmuYIXFDgrK2V0jCgyWiD5hL+GarKuIElvCps2IO8HOuPkaw
         W3kw==
X-Forwarded-Encrypted: i=1; AHgh+RqTljzeGVYNYwrEgwwOcpqLjiKVDXIkZ1ptIBNonjJZGs0Rs5g1FbcNXRf69xV2WpdoxIo/BlU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylg4zU9HYq8wkkZ/jXTq5KLsXFyPF4QaFTeMQvzUvMQSUrv0CW
	NbgE/6NgZW2k6ff9duIAl+lGGBv+qfc44lB/SPxRsEl4zzwu/fbERIB6
X-Gm-Gg: AR+sD10rcFkipILYL2BQg4QNHD0f5tCXfWyxReo3Y3StWUKSDOuJsrlNCeHssgOsExY
	Suz3ERyKdsH2Swy3WAjj8jLD2gFnrMrcRJlpCSkwGOTuTVAuLSG6rOcOo2hBGESpXrckuQbNGPN
	Rp5jSVnucMWu26Y2dloBJcRPA49ov8Beg1PoSHj3PgZShFLhndiHbGzFqS3IQQWNsly8FDqo5nv
	gIqQCLooWZ1j1dJHvx52+ylgnEftqjHkXQIxyCJ23D6fhDPxNfm05CgLBUSYLKjdLsSaqeKCTdf
	CBP5SysgJge8nR0vzVVygtxbmvL6lkmeAIGtVotpxWX+ckAOpSTHI8ijgVbXyaKKL5G4e+gcqXr
	M71+jMZ1Xl2Vz1oRBJvgXUIKwWtk1EBJ1ocO8mSTdWO+15ToSHzGsL5/UYkB2HZjzVi4slL7TT9
	OqnCQy++mi28q6yNHBXVd4N/MSQCEc1SV2Qs7gH8JDtsXUZsnhDbpwbGLMNY0h1is+kxSHsyU=
X-Received: by 2002:a05:6a00:982:b0:845:3d82:10fc with SMTP id d2e1a72fcca58-84f6926b235mr20673646b3a.0.1786369258800;
        Mon, 10 Aug 2026 06:40:58 -0700 (PDT)
Received: from gmail.com ([123.118.75.63])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a51f166sm4006236b3a.35.2026.08.10.06.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 06:40:58 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowangio@gmail.com
Cc: eperezma@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] vhost/vsock: fix device IOTLB feature lifecycle
Date: Mon, 10 Aug 2026 21:40:16 +0800
Message-Id: <20260810134018.143973-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost-vsock leaves the device IOTLB attached when userspace clears
VIRTIO_F_ACCESS_PLATFORM. It also replaces an existing IOTLB with an
empty one whenever a later feature update keeps ACCESS_PLATFORM enabled.

Patch 1 detaches and frees the old IOTLB when ACCESS_PLATFORM is
cleared. Each virtqueue drops its IOTLB pointer and metadata cache while
holding its own mutex. The old IOTLB remains alive until all virtqueues
have dropped their references. Queued IOTLB miss messages are then
cleared and blocked readers are woken.

Patch 2 keeps the current IOTLB when ACCESS_PLATFORM remains enabled,
so a runtime logging update does not discard valid translations.

Changes since v2:
- update each virtqueue under its own mutex instead of locking all
  virtqueues at once, as suggested by Michael S. Tsirkin
- keep the old IOTLB alive until all per-virtqueue references are gone
- clarify that the teardown drops queued IOTLB miss messages

Changes since v1:
- discard the existing IOTLB instead of returning -EBUSY
- split IOTLB teardown and preservation into separate patches
- clear queued IOTLB miss messages and wake blocked readers

Jia Jia (2):
  vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
  vhost/vsock: keep IOTLB across feature updates

 drivers/vhost/vsock.c | 42 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

-- 
2.34.1
