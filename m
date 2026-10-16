Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DF44B129D
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157243; cv=none; b=QrmNrwo7gc7MuIA3Jssd+pejPEgDn3iXR+D5/rXjE9ixbvA7TjXdPc929nows5N5EjXZo4x1LqwvUn3zAS7v4/DPholQSmwc05BFaWtueA7n0jMjWQoEyCqVioUa0bGGdv3lDNI1sDPNlrwAOlvH7ddFVRv/zOMjAeZYY7X0ZQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157243; c=relaxed/simple;
	bh=6494+ZvYu8FHV5Xw+CZy5G3PfZ+nMzT4PcwZU8DlDjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W3pjd6tbFaIXAM1Xq/f7B8qrDm3IR0SfP01FEvJ5lyH5VlbBPB65H8lzpiOD8k3opOx4iIVReU2AywPGPH6I1YUlJ8IQO/6AYvGji7wDpE/2YKIxzjPtdRfLK/lSEBA44cYYoQvGQt81zC4362w0UMgx0laNmtugTbTiG75xNOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oGcr0Fyy; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oGcr0Fyy"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49e73611928so6444555e9.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 06:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792157240; x=1792762040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ifcJs/P3/5U0EMJlqsFCLeJP9WV/BCVB8uVBDkA2xCw=;
        b=oGcr0FyypDKRrk4goPdjTXylt2pA89T0288SKfBD9bqxhnqR7rHZUinK8IDlJK3QJy
         WV/ZgBjtMgg+Dbq64FzDf2WE77W3e2KdcF7GGCehsnQDvgcQsDDY6+iGuHbgP7tW1MLQ
         AVOFJvkhno8DmTereMvuSsvdgKnVc6q9L6FMw0YeYsYHpnH7yjyy8122jTtUXjfWjTKR
         Z6NHHj+TYbXky6aRZI9loYHVercW/gPk6xT7RLRHVyrf3FJ3mz0Gr56H2LLWxyTWCZJH
         WIr90l6MKfn2cHIJ+7TsHzoto5cVRgSiUPD/WXtXdRFOzunVZeUB97iwxHtDJmBtYQcw
         zWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792157240; x=1792762040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ifcJs/P3/5U0EMJlqsFCLeJP9WV/BCVB8uVBDkA2xCw=;
        b=JhGct2Z78uQAhfKiImeYx4xXerBVTUdnrJldKqY7gl+6sgVCeNBG26sgXIWacF1FO/
         st1BCc5rmhuBQerHjpJs4yfB04aX6FgFQaPehBN2J9SxNOIg5QjF3beDNXHb9KNtvRH8
         qXKdjTB5v3t+H0q1M5D89MT15Fhir8v4TrKm/B7iLGYht0F8+fLi3+4LsaYeu1WCI1jD
         L9xVo+NrZ/XTXnPeYk+7zdf+C5/2h1nx1t2udJm1zkq4prX7PBJZ3KxuVNX99zycA8Ca
         ygfvbbYPmwjS3N0nQA6N254RWIuoNjbvz4JjIRaZsxwhlBefjV9U22ooWh2s36s3ru9O
         tW7g==
X-Gm-Message-State: AFq9FYKHerYeW637D8DGZQtTRu6omx5RPUxYcLh7llZQhycMHXiB4Bam
	4riOsLc5n/DFI+221tJAvuuZbOaSljixC0pOlIS2NC90ZSy7GDulOEkeN4BPkQ==
X-Gm-Gg: AYBFou0EETHv/qWY7UqAo/2WKxJGRboCoJ3sKRA+5J2mK3aFlSdaX4Bdoe+SHSVWiy7
	MkmtCSpXgrIjSjfvniy1JMPJIrAAkBewZzeD+4KUQrIHzGt4dJ67TV8hLAWTRJNhIDhJEcY4BxL
	ras9AE0uHgR2djaY2nquQ+M2Y7xoSHCimPhajKYe8i1OoM+bXHMoei88CI9S9s39gLW9J06QYY0
	2W3F+f3a6vR2bLdlyAeviUGpnqLbOC6Mbn0I/Q2cHhmZ/XYBSrYOZZwcKDMpUOxhROmTBLpMYmQ
	6ylKXACTU69TUCyI+qrejlYFwkY4Kx2BZbn1d7A37w0GiTeyeorYbSCHdVpB8wB7T+NbY9SwYrN
	NFLPnlGOx1u7iNkbhSMU6jVKOWlumt5vlle81wFsQDzEUUySKRJgeYAnX+HJDxM5XkIdszh+gq5
	XQT/QeIQ/JYoY2zyBjU9wgWKoYnVh2VAH0WxfOG7m4DEgKmdnn9+4Q9bp7ES4PEIT5br4EoAYsb
	kvJH4i5N0Z11TVxsif9seI951YQTNEuVpQT181DFsJWj1rAPJpH5TJRvmM=
X-Received: by 2002:a05:600c:1f86:b0:4a1:c27d:e1a8 with SMTP id 5b1f17b1804b1-4a1c6672f2emr64239555e9.10.1792157240153;
        Fri, 16 Oct 2026 06:27:20 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8de7230sm58114275e9.14.2026.10.16.06.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 06:27:19 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: sgarzare@redhat.com,
	bobbyeshleman@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net-next v3 0/3] vsock: SO_INQ for stream sockets
Date: Fri, 16 Oct 2026 14:27:13 +0100
Message-ID: <20261016132716.272018-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the follow-up announced in the receive queue hint series [1]:
SO_INQ and SCM_INQ for AF_VSOCK stream sockets, as AF_UNIX has.

Patch 1 moves the SOL_SOCKET option handling to a helper without
functional change, patch 2 adds SO_INQ and patch 3 covers it in
vsock_test.

The value is the one SIOCINQ returns, so on Hyper-V it covers the
current packet only. Accepted sockets inherit the flag from the
listener, and the sockmap receive path does not report it.

Tested over loopback with vsock_test and vsock_uring_test.

v3:
 - split the SOL_SOCKET refactor out of the SO_INQ patch (Stefano)
 - rename vsock_custom_sockopt() to vsock_sol_socket_custom() (Stefano)
 - parse the value in vsock_sol_socket_get_bool() after the per option
   checks, so SO_INQ on SOCK_SEQPACKET always fails with ENOPROTOOPT
   (Stefano)
 - reflow the comment to 80 columns (Stefano)
 - carry Reviewed-by and Acked-by on the test patch; Bobby's Acked-by
   on the v2 kernel patch is dropped since it was split and reworked
v2: https://lore.kernel.org/netdev/20261015154334.3217358-1-devnexen@gmail.com/
v1: https://lore.kernel.org/netdev/20261012235524.41468-1-devnexen@gmail.com/

[1] https://lore.kernel.org/netdev/20260923184008.153541-1-devnexen@gmail.com/

David Carlier (3):
  vsock: move SOL_SOCKET options to vsock_sol_socket_setsockopt()
  vsock: support SO_INQ on stream sockets
  vsock/test: cover SO_INQ

 include/net/af_vsock.h           |   1 +
 net/vmw_vsock/af_vsock.c         | 125 ++++++++++----
 tools/testing/vsock/vsock_test.c | 279 +++++++++++++++++++++++++++++++
 3 files changed, 377 insertions(+), 28 deletions(-)


base-commit: a4057f51efc2b74ddf46721e83f45e9efb13649d
-- 
2.55.0

