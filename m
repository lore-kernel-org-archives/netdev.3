Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792752043;
	b=1HkO5L+QyHozLzS1Vu7hci21NoqI7ye8UwSQuRAL1vqA7tHfQHFkUBOwz2wCtmHv3vr9
	 Wq6hzFUjIyET6yPqOBfS3UdOU9/wXArKIoJnWnA4jGlEtF2Z9yEMAVama8Eq6dc5tfSy2
	 KHL+kkt9LVKdeG5o5w80QUQja5d4TwOB6eFkIS60zVQvO67qrxaSh5yLUKk3xuzNEiDa8
	 0ujl3Xis80n+0jD5PmrIzN1y3Afc4vhx3mk0SdNNdFHBIqmB4dhmcBW8WYslig45GdJqg
	 TJIo2gc/4WK6dkJj5hy2v263bNRWhr6OaYbnjozkRnE9ZE5D3Tdyy9sTYZ09fnPCpEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792752043;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3fn/qeSOMh17ArAGKi+SkWfmCErKg3ju5QLNHCwzqmI=;
	b=VSDXCiWK85OASbm6X2UOX30rCFrG2A/np43iVxmQSKktqAddvPmGCF/WHgWM1LdrvjDd
	 cLG4MwBh4GoNKLUJumxAiSXXFlq5POO/udDB5AbuJ39PDBsut4MxkGB3dZ4eHTKk3S0Mi
	 +1AWfVaqxiPtnivKVD7pT1nEsrqUHY+p4/E2NQnvvmH4MwgP8+w8q6O9jNE5AGxF9Tch1
	 T+g1Yyh81EIItIvwUzPEFsNmuD7oG5Ycb+CUi1bfSYkJ8tZ/kfRLWcE8t77fTDCyIA/vr
	 cRq93/7/j1e/aAitTO2j6HPl9ReKVhiyKoPqs/1UJChfTuMMPj5CGZJjzOXNbEmcAXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N6s2C5Vu;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C2B606A31E
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 10:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3C2B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N6s2C5Vu
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so429339a91.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 03:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792752042; x=1793356842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3fn/qeSOMh17ArAGKi+SkWfmCErKg3ju5QLNHCwzqmI=;
        b=N6s2C5VuIa6TtEuPqdllmx/G8ra3m0faGDWBnZw+fj5k3NmLUHlKGpmIL+QIo5BHXN
         kgokd0TzFnYZ2jnTj+4ee1OPSRoEpOIiiz7VgqNG6pg1z90cMaU8QaNEe2IIwIVV1RCp
         z4kvIUFCc++Aq1QYnEDvIVpNJHdygjE5QS9f8yzm0K1t4p9XrMvZuVVw/VVKBQgMoQB7
         nBBaxWeuG0wMQyw1hROWVHjQf+SLTD1wL4GD4+GqNRrpG39oxp73f3XCVrN1hQYhP7Jv
         5K0x/GIBnJDf11j10qYrzExDKCYROoLMtUakyXZBsr3Z7sIZby6j3p2zOaQ+NqZq0n0H
         gXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792752042; x=1793356842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3fn/qeSOMh17ArAGKi+SkWfmCErKg3ju5QLNHCwzqmI=;
        b=2MDAzuNonv/m3TVCElOqFjYGzIvoN1UF53IK2HP7xIm4MXoQiZSk0kg2OiGpKmvMYX
         2R0PFRW3khZ5qUFwltuZwYZLbLSjS3bcSFY5UyeqfRPE9rco23HTvLIrOO4h7WBZxTS4
         uo5un+Xk5LfF7K7X+Q9rRNE39Ni4VqCchwA3f7xWm1KdmwexCI34UvKXIoLvwCWC/hQ9
         yRyLFNGkGaFdX6qcSkHcztfHWGTm44Mq0H+FDafrqgJl83m0bxNmXRSn+G/xSDGRHBlX
         AJ9Vax4+B2VLde+Y0RrS/uQEYKJaO/eYQgEMjShd73gJFlfRl7lfDYmCGdtqE+9Xv/sk
         0gEA==
X-Forwarded-Encrypted: i=1; AKwUvBz6ILFkJkLNKNVk4SvhCtXSW8B7qyOnKWzsP0BJls/93MThYzRpGDhAb8FnP1lHjhUvF7bhrF4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJs5lvpSnk4MESJO+Io0rSBLLe4FVnv3Ff9YSRYlnK10LXXIs6C
	yb9eWAZekqS3zfFHqxQ1UfxyirEWUmvzfXnSaLkXgepcw2LmR2jMAuiX
X-Gm-Gg: AYBFou1sK1IPQl0tSTDTisreqcDxO9Obv2W1z9XF17qYDSJjCk+hfCxOiMXVKxFek0+
	mQloQbi9pAAvuauf4OaehZ/milOX5ybSAKkwHsCnYB44379GiYTnrlwaWHneQkBtQbkoizqNpbz
	3VWTi89VRC2/Zh0+inlvQ1pjtthTK3ks8pYuUi4uK7zR2ApMt6IoavdF94WUv4Wo5RPiEeU+PaQ
	SHj8wpYPOoLV4kBDaLIGVVWR5sic7y7km1qWrEDPcBmqT4FX1lKg0wzAKybQMGGfwUj9P+9fAVk
	9cgTrPoMVB7+e5/mxhcMAdeZdFnobRjLR6OWA6P8zWyJK2L5Q2yLFC4DFzG54rUUmo/Z8lfwUtr
	BvCp/xfFqlEu5PGEbFdTOSYaaRtEvQLIAbypiZl1Otq64KBoAuNrCp6wrbmlcQsbCJsRQRSvV+o
	LOrtVEhccrFZjtdctL8ducQiiS47dXR2SLfw+eMwN3d7ykOS1MEi5RLgefGVd8cLUyN964SjvWQ
	A3JSJVSrysaHc+2kfyAyWrcvhySZNfThtg41ACehqxGaOt1pALW1+xrgg==
X-Received: by 2002:a17:90b:2543:b0:3ac:b08a:ed2c with SMTP id 98e67ed59e1d1-3adce08327fmr1475446a91.40.1792752041791;
        Fri, 23 Oct 2026 03:40:41 -0700 (PDT)
Received: from gmail.com ([185.220.236.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adcb1b133dsm3300636a91.7.2026.10.23.03.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 03:40:41 -0700 (PDT)
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
Subject: [PATCH v2] vhost-scsi: fix page reference leak in misaligned I/O fallback
Date: Fri, 23 Oct 2026 18:40:35 +0800
Message-Id: <20261023104035.6686-1-physicalmtea@gmail.com>
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

iov_iter_get_pages2() returns a byte count that excludes the offset into
the first page, but also returns a reference to that page in pages[].

On the misaligned-I/O fallback, vhost_scsi_revert_map_iov_to_sgl() puts
pages already added to the SG list. The cleanup loop starts at
pages[npages], but accounts for its first page as PAGE_SIZE bytes
rather than PAGE_SIZE - offset. If the remaining data starts at a
non-zero offset, it can finish one page early and leave a page reference
behind.

Use PAGE_SIZE - offset for the first remaining page and clear offset for
later pages, as in the mapping loop. Without this, each affected request
leaks one page reference.

Fixes: bca939d5bcd0 ("vhost-scsi: Dynamically allocate scatterlists")
Reviewed-by: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
Testing:

- Four fileio vhost-scsi test instances repeatedly issued affected writes
  using recycled backing pages. After about 1.33 million requests,
  MemAvailable fell from 5.3 GB to 13 MB and swap was nearly exhausted.

The affected fallback is reachable from guest-issued virtio-scsi I/O.

 drivers/vhost/scsi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 4f8c0260bc9e..b0a536fbc69a 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -883,11 +883,16 @@ vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
 	vhost_scsi_revert_map_iov_to_sgl(iter, *sgl, sg);
 
 	iov_iter_revert(iter, bytes);
+	/*
+	 * pages[npages] is the first page not added to the SG list.
+	 * The remaining data starts at offset in that page.
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
2.34.1
