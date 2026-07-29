Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538A246AEFA
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785351549; cv=none; b=rUoxozFzye29uuUDIKa92Nw7C4cvC68AmlZUVCgURons+p6l4kNFxnLZuVhNsmjdtdE/sepXyKcFRlXC2Vuv5cTOnjI/yt2ZrevcuIHtJUfHS+DFOn5AcUgFt+0B6T4qgZq+yfPCM8LWwiPrHA1r2mLKZMABqv69DTbeuOiwHAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785351549; c=relaxed/simple;
	bh=6OQPemUbrtEvn35mHWX6wGaAzq7fYLjqo+G0OX7yMJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GaSu/2/dYo1sXeZDbw+I2Udk9Mw7zsJfWUsUvBNlIzdqtsf9aNdSJW3UttyaA8Ab+7UDTbCRIf0WG5/INiQGPM246iywXZZE2fLq7pvvgSJG/NFq05gFb0WqfxdUBGOnmzAgQcYZd397/Okb7pNge6lQOwQyZ6hv47LUPIJpfvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qGEUikAx; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qGEUikAx"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ca957432c7fso978044a12.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 11:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785351547; x=1785956347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SCI3GixEP2KXXtfpULqWtW8LurdBltars+anz7Y6MWw=;
        b=qGEUikAx3ZPCvNiZ9YoJerKvYjbWQzgtQyR13iIh4thtXE0DkII9Aiqy7GYcyXlDph
         TTWpSB321t4+KrWUEpfpp8B685mtBDUAsHIEUJM0biWAHFEp9eJoVUgetYy+7Z1GIKmk
         6Ej94LMh6BN8F+SKxZVr+fWNi3qt4lq+56z3Ox5mNwg+eI6yda/FhiYAMjz8YxdASo3M
         1Ue743G5EdCOWo0LLuT24CTjWSKyGAUG/UZi+FBJv0sJPco469k7lArObCuNH7HusZLX
         oHQzqqDDjwtrU8/YmBz34w+XQ+De9+9lz+R9g8Gjpoo2OVl7ObTQ5wiFSH3UCdPch4Dr
         XXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785351547; x=1785956347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SCI3GixEP2KXXtfpULqWtW8LurdBltars+anz7Y6MWw=;
        b=awEW51/py50zLNjnBMFlaqcKmyxldVybq/UKyiF7tNe97t7BOToIvHtjK97exIaKP5
         +nE9HY1rP7F0I4dHF5LU8wlTRqZ3PG5oM5iyHW8NuZQYyCwMwolJvRbM0dEG2l0rM7do
         aSeCM4MRe1HNTrxhHDILaG8Da24sySQ5L6ywI+JYvg3uTh/ZC0aTIlIe9Vm3HeqjjRgV
         BSunTPuEPqo2UJp+9ftBtKugIn/iDMa+XMiAKIzvszcZa0GeBa/bNcTMH+KCKu9I6NhD
         ia47ppLCIATrbOlaf4eAjaZk3W++goyMNMDWlFqqvBuHoz5EDgDGNHPhDEokUjFY97+w
         RVyA==
X-Forwarded-Encrypted: i=1; AHgh+RqrcPlooxQo4oTHmIRU0HWdNo2yLhVbjJJIY+yN5sV4A4fiJfcpf6cyfyRhVGmVjGe2Dv1dX5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdsq+l0qma0EjV5bMxRISb1vuYSgZhixzWmzjEx6b+b/bCwl9H
	NPbpC3iCbYHpBCmGwD5yiAHKKMHcpOk3HfK7BZmzmqnh6OZUeK47JfW/
X-Gm-Gg: AR+sD13/WJt+FpSwBSGemaPdVtZPXPF2lQn5dsyZ2d0QODbpjd1Mhsd+HQT6tiIZpc+
	Picc+zjDBd32Cf7y0EF858dDQrzrjuR7/OMBSnYr9iRr30RgGD1/FGrftgWpYo8uXN+61f4+kBE
	cEhOC7m9+eFZjTrgEQqamIrCmKdKRoFQFE1F7tYGpjtpT0ku2auT7xEw/qdu1yOQwkAbOe889m9
	7q9LOojQXUd8YlzIZzEs6bBZpQLo2MZ1ZRE4jAiK1xQ5g/myTPe1p8o2Ktp5P3Pgd/thMKmLYW1
	7+z2lMbn2b/NtPgj92y1JLd4KGg0gru5Fx8WToSRbG5XW7EeUr9f7mmgxInzkceJwh18/iTiksD
	mujGgdiVXlilPczV82Wx8+X7Zf1dLd8mUr3JHUzQuOIfQmcmPsn4/IY8q4PD/zDWGS+RPnJnOi5
	35/acGFU5+sIkHYkpYpuihQCGg+6uK53BF2fMKByPaoc05kZsnF/eXmoUAk2IyFEy72HVE8Lqqm
	Ajyqg0=
X-Received: by 2002:a05:6a21:730c:b0:3c0:9c19:6586 with SMTP id adf61e73a8af0-3c8ba5daf6dmr9429868637.64.1785351546675;
        Wed, 29 Jul 2026 11:59:06 -0700 (PDT)
Received: from bogon ([2408:8207:1832:1b44::c6b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdba447107sm1237829a12.21.2026.07.29.11.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 11:59:05 -0700 (PDT)
Sender: Weiming Shi <thebestswings@gmail.com>
From: Weiming Shi <bestswngs@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: [PATCH v2 0/2] vsock/virtio: fix worker access after virtqueue teardown
Date: Wed, 29 Jul 2026 11:58:26 -0700
Message-ID: <20260729185831.3247971-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Virtio-vsock workers can remain queued while freeze deletes the
virtqueues.  This series prevents workers delayed across freeze and
restore from retaining pointers to deleted queues, and prevents the RX
worker from refilling its queue after teardown.

Changes in v2:
- Split the worker pointer changes from the RX refill fix because they
  fix different commits.
- Use bd50c5dc182b as the Fixes tag for the worker pointer changes.
- Keep b917507e5ad9 as the Fixes tag for the RX refill fix.
- Use the suggested out_nofill label when rx_run is clear.

Weiming Shi (2):
  vsock/virtio: read virtqueues under worker locks
  vsock/virtio: avoid refilling the RX queue after teardown

 net/vmw_vsock/virtio_transport.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)


base-commit: 51b093a7ba27476e1f639455f005e8d2e75390e4
-- 
2.55.0
