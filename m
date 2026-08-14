Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B0F416841
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786692557; cv=none; b=tiY984fIzUVr2WY8iUjUxswcl9tug/y69YJ6zxYLQcROWPY6CREXiHIYxf1lepFApO+FpGsB663LxEFnSGhDgRKqaDJ44ka5j/dbpAfm89EMbAyDSwmQZFnLK5Q3wFh8U0TB1cK18je8Q6hnAISD322j223lCFlMJ6xPrzQrYdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786692557; c=relaxed/simple;
	bh=AwI8bMlXLv3wxhinvie/tZxTYnyJT1R3jenyE5i/EFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lYrcTjajmazxU8U64XXJlpZNNX5EHpykIPcthd3yI8+9fFH1CbcCRDMwpyAUepzO6RtEjaYtqvTTRPEJxUXkIFS640/5pzTVnd5wHil3S8OxPwclR7e1QSXng38eGaNhU2xATQ1niM79k3HwVzIM9abYfxdNU34fKMNbovzOCqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aosRokne; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aosRokne"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e347638adso834737a91.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 00:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786692550; x=1787297350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IQpd4eRSV0dJsL+ykEn9cs9mcA6G8jtpyBsR3LcTcRs=;
        b=aosRokneBbLDZJaXTppHRL0W8ZAlRnBTofddC6iOTonlImsLKtve5NZkxXmztKSvQg
         Fan4sEi4BBSoWE4RwccLcvFhnbuq9wFvxYuKhUDadqRcvuagZw/q6sajePO+YU96aOR1
         VLQ8cPqirSocsBQw5j/dJjbIopCKJzTc9SG02Ftz3UpT11Ldkz+NriGo95QfzrCZABbk
         MQ1P5qNu1TbYQCNj6qy5WmsdIWAS4r6DeDAdcpb+4R4G880iBH7DEVnfuimMadjnyOog
         Kd3bFHGxhC3mA9z8sx/I3YTCSO2QqlpldmOM3VGnbOSce4vZAgCWPv69z8+3gO+gKfbS
         ZT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786692550; x=1787297350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IQpd4eRSV0dJsL+ykEn9cs9mcA6G8jtpyBsR3LcTcRs=;
        b=VowGM+mgERE2BiPAxFKY4z96Asx+8V/ttBGBudSoz1SOTwxeIQ5knWv4skZJgcLEuB
         5IWSfjr8J/aVxtIZr2PC0KRpI8k+IINEBQz2zjtmYkJpldeTpxWokmxkrXi30S1g6ngV
         Pc710LOAFyVLUSfd7uNfpjiwwHoh0fpZChA/61ehoN0CvtzK+xpvVjeLHhE8xruqzMcl
         Uv+KhxNLgF06uQyzrvGCpLfJCF98ZCCjKlnr2uLbpk3pyifecwN9vvhBd8gPpFMEO8xH
         N4yY4IlFLTVaa95vjGyphskOS6+v+TBwBvkPMOuvsoFqeylh6amQuxpOtGLaK4hx30ga
         RkxQ==
X-Forwarded-Encrypted: i=1; AHgh+RrbKjoP9Id3wibbITm5Ezx2BZZPCnggu7F+ocBy8YIwqRKRGymQ3mQI/3cwtszXl4N9tQWgOi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjuEVxuifp4EDxVMZeflum1iebaeqCcxg9NGu/2j1oFe2hi80I
	khCwV8gGVVBLpJWSxkcVXQlyxkYXmnSS0Qr4iwrHoyjXTtG8z5hcNuCV
X-Gm-Gg: AR+sD12aWqzWnIvEsfAXEHZjBlIv6RvLI9kEDwljhKCmWIC1RDthIfGhpZrTk/5unpZ
	sjBfDQswscyOkdCfKYwyZd93Bh1X9SO4IRjrLyLje6XX480Pd6+xAHIHaQ4oZBZJx90qCa+6Txv
	bwzMrWEiG7RMUAZF6r++7HoyZ2HOUCuq3bY6tdgvV8i7eGhsc7EQxjrXMM8QjYwriYkbssdS1n4
	cV0purmkVn189mE8el0j4uaAIY8Z7SZAzNMzPJwAXA6WDJYJTmDmufbHLmXXeax3N8/sZs7es1T
	3zVyOi6WUeutebkESuApfeLlNNuwqsk9apUgUMNpD6gT12hRwT4dfumEGFkGr+zX6/AQjX3EqoL
	vtuaF+r0KI4bxpTxoELHVQ4BA7vbETQo5XZa6G2XiyqbJ9OGhL780UtqpBCFvE5dPJ45v6WkX8N
	0igGoMI+Ech0V3EKfCzs9eEbP21LDTGd/iI//CbwUdhhdmOXOdHEU2seH/mN+1fhqBmTsW264wA
	80=
X-Received: by 2002:a17:90b:3c02:b0:38d:dfd1:7a8 with SMTP id 98e67ed59e1d1-3933b6e9788mr4544657a91.2.1786692550314;
        Fri, 14 Aug 2026 00:29:10 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394eb752fd7sm1483477a91.13.2026.08.14.00.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 00:29:09 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] vhost/vsock: fix device IOTLB feature lifecycle
Date: Fri, 14 Aug 2026 15:29:00 +0800
Message-Id: <20260814072903.124991-1-physicalmtea@gmail.com>
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

Patch 1 adds a common vhost helper that detaches the device IOTLB from
all virtqueues, clears their metadata caches, drops queued IOTLB miss
messages, and frees the old table after all virtqueues have released
their pointers.

Patch 2 uses the helper when vhost-vsock clears ACCESS_PLATFORM. The
acked_features update remains in the vhost-vsock-specific loop.

Patch 3 avoids replacing an existing IOTLB when ACCESS_PLATFORM remains
enabled across a feature update.

Changes since v3:
- move the IOTLB teardown helper from vhost-vsock into common vhost code
- keep acked_features updates in the backend-specific loop
- add the common helper as a separate first patch

Jia Jia (3):
  vhost: add helper to clear device IOTLB
  vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
  vhost/vsock: keep IOTLB across feature updates

 drivers/vhost/vhost.c | 24 ++++++++++++++++++++++++
 drivers/vhost/vhost.h |  1 +
 drivers/vhost/vsock.c |  7 ++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

-- 
2.34.1
