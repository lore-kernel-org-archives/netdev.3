Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792572940;
	b=OXUELyYwhJSZ4N9TOUE/RtM4Qov/vCL61td+tqWp4fhJ+XBYgStae4OmvdywhnXm7YtH
	 7+EbTd5wo+C2MR2PUg4mXt2qxvUhW1LZH8dbmM+8drpxA/1M3scKlyzTQwf36EBPdT1Py
	 YVHjaDXgydy+rl4HfahyDI9eQHyhDvegx7E0yIN8+rzPuB03iElWDsSv230d5HmZJuycf
	 pc1fk1ZrcSAnI6xBlSbGT9heULG7QHlx2ljaMsjSHpunjkwKpKOVTgtBwfP23L+LMXZSb
	 8db23pqcnr+ABL3EQ8NytWR+6k3EIaWp5iShnPkcbmFgLXLL7Ph1QUxxjwZQcNnDr/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792572940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZlzMMtlOMt0j7sxnZGkr7qkygcFA8MGAgcH9bAVX7Kk=;
	b=Vi5/BeBjUgIEWK03rPhISaZ/3tTOMjsnkOwoZUJ4a1wV/1CIwC1LVlwiKoSoTcSLLJot
	 g2wQM3s6etAbW1ugxjyVIzlK0ZmJOFpYZJZ1Zc7c/7JMGJoItCbopAvxClXzY7Wl7GEWl
	 MT8NerttlsojYbtaoU+Abe6IUxUuutCcLzX8p0zxXFeNXrRcN1tC0S/Pih+s2v/E94yhw
	 IGTm1tUl0OKTzTZu79/oA6iD5arfckZhd+3d3r6w8GLrrgJJ+2czK+BiV+MU5CvSXKnrx
	 oPzvZLt7DKLluYuSVefrYbjPNIOy8LNGO8ZhYhAK/Vbwtq4CxrO26/7FXlQprdTo7Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Q63ZWMYw;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89200606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 08:55:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89200606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Q63ZWMYw
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso305142a91.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 01:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792572939; x=1793177739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZlzMMtlOMt0j7sxnZGkr7qkygcFA8MGAgcH9bAVX7Kk=;
        b=Q63ZWMYwY2xiEcGgxNT+yzrIlSaw9gGr5WmMgDxgjgm7sxXVG3yzck52PqI5GprMdC
         0YqC8fY/9VYDsWb6Mw+YnkSo0Q5zzMuwZTqwk99O1vHcqh4zIyKbb13+fHmmKwH2O1bT
         TjC06GLD1Bf2MvZiPAj0Yb4RkP468nRt4HZtclmCnhYNMF/XcJXxaC/d3cGHUvx3U1Uf
         phMYsUrcDAVSoLAs5Yp2Av74cYiwVpLJzASoz3MHKVTzRKP+5wqpnvI4sAPOGZRpzV/z
         ZBdICmaDUU+/c0Wx8a+ojZ9sm+P+Z5cjrFzRe9YC726WzvQgEIgmpAPgKlO+mvbbj7Qt
         2UjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792572939; x=1793177739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZlzMMtlOMt0j7sxnZGkr7qkygcFA8MGAgcH9bAVX7Kk=;
        b=Pjg4FQRQ78ccayqwDEyaIrHsnjgkaLUYpPB2LJ0swvLKz9vDYlKuWtIL3FxH03E7l7
         OTX9Y7Vshr6btsHZT9hP2vPv83eELFSHdD7narhu4jWiixPuASX27d4QoVnPfCk18Prl
         yRo7TE5Azo0p/1/2AP54dyL1l9Kg/YAOWJCDU/f1Lx81YAjPsVAIi36gCogKCvsTIbXv
         H0VdYac2KYVx0S97ccuG1yULOk2J4jywipMEv2TFKHkByjCHG03r99pQUhGzvmbfoY5J
         7eBbko8E/XlL4PFkzyhfClPgQs3HVPHPsQl2MrG58MiaIzyZukenGw58g0WuNgKQy0yW
         i3Hw==
X-Forwarded-Encrypted: i=1; AKwUvBzQHnuJ9EMDr4YetrEaDKfbZcol5CfR8lutVdtvcdl2nh4y7DSOb1kCmcfk4ilY5PbbZCR0LUI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKItefjL1uvo9Buo89Q4oKPlsxgaTLqhqoAHf7JNM2gczrxMIMw
	hVKPwMKkM9uzeUdM/jhaSUVO5PIF5mHZQqBdkXLQVqx9x9R3gVT2MRNw
X-Gm-Gg: AYBFou0mFH2xCqaWZjKKtQhQa+CSRbtwb2IchEOljO1dxTDSa0hh2M944E0GOkeXgYx
	OUhG5KcEFnLItC0kUs7gds+oN4ZmOxnbW7KwoutdzGBFFKEYBu9WNeeDM3+b6bCRdNIpUtliyUI
	dNQuyOHKeDrq7Y+WEYmkW7gU6TmMJZ8LAtJREKp4r+S52gol5n6s5VgPa0BcvjsueppiAYd5P0o
	mEnhWgZqjyJ7WxwE3IDlgBHS56qgZ5s772XbpLbrMlDHGCLZDr//ZlIA4imIbzXdumeDZewB7IO
	qGil9iVAyLsmY11QfvEBOrsYE+K3vNHrp/XQzubeHcoVBkF7aW9rJKTaxXViOHgTUM8pZ68o5Gl
	2QsgLW0EtAFFPVADffBm/as0AJ8G27AU/cP63a0VFCdCJ+bpW3OHn8tG4cSQ0AthiFk89R0/CVG
	7j5LiJQSvc021QhNZUAuPaQl/qRhOHxNlXnVxjMhosk3Ks4lPeUdotMm1eFvCEO+Y1qd7Jdtp6K
	g4l6wKPn84PLplIyhx7bFh0ZtOCkjNO4Kv+2t6w8ethI0VEG6fB8no=
X-Received: by 2002:a17:90b:2f8b:b0:3ad:6781:da66 with SMTP id 98e67ed59e1d1-3ad86c79915mr1116703a91.23.1792572938794;
        Wed, 21 Oct 2026 01:55:38 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad85f56b03sm1398207a91.3.2026.10.21.01.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 01:55:38 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vhost-scsi: fix page reference leak in misaligned I/O fallback
Date: Wed, 21 Oct 2026 16:54:58 +0800
Message-Id: <20261021085458.196742-1-physicalmtea@gmail.com>
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
Content-Transfer-Encoding: 8bit

iov_iter_get_pages2() returns a byte count that excludes the offset
into the first page, but also returns a reference to that page in
pages[].

On the misaligned-I/O fallback,
vhost_scsi_revert_map_iov_to_sgl() puts pages already added to the SG
list.  The cleanup loop starts at pages[npages], but accounts for its
first page as PAGE_SIZE bytes rather than PAGE_SIZE - offset.  If the
remaining data starts at a non-zero offset, it can finish one page
early and leave a page reference behind.

Use PAGE_SIZE - offset for the first remaining page and clear offset
for later pages, as in the mapping loop.  Without this, each affected
request leaks one page reference.

Fixes: bca939d5bcd0 ("vhost-scsi: Dynamically allocate scatterlists")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
Testing:

- Four fileio vhost-scsi test instances repeatedly issued affected
  writes using recycled backing pages.  After about 1.33 million
  requests, MemAvailable fell from 5.3 GB to 13 MB and swap was nearly
  exhausted.

The affected fallback is reachable from guest-issued virtio-scsi I/O.

 drivers/vhost/scsi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 4f8c0260bc9e..b7e41c0a91d4 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -883,11 +883,16 @@ vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
 	vhost_scsi_revert_map_iov_to_sgl(iter, *sgl, sg);
 
 	iov_iter_revert(iter, bytes);
+	/*
+	 * pages[npages] is the first page not added to the SG list.  The
+	 * remaining data starts at offset in that page.
+	 */
 	while (bytes) {
-		n = min_t(unsigned int, PAGE_SIZE, bytes);
+		n = min_t(unsigned int, PAGE_SIZE - offset, bytes);
 
 		put_page(pages[npages++]);
 		bytes -= n;
+		offset = 0;
 	}
 
 	return -EINVAL;
-- 
2.47.0
