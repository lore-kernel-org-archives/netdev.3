Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794188682;
	b=TEklhta9PRFF7SOoP7+1h7UsPJ/jR0XH7/N2MYeRWN1LQv55iMIJqkPDtzJYuZ6ZgF+2
	 ptKgADeq+wTru/kiMLggfE0Eczt+Yc7bc31UoN43MqHHDwSKalh/fnuH03to3mwGqpfUj
	 kkVe65ezCybWVckRONw++3X+NdekfB9VvPZoIJdjHjKFN152LXDmbDAfvdoNPxfvDXfuT
	 UoyvmOwCsKeh47ttWPGvlF8PEorGaknPYgYwDU9fYrtLCVHOpaGQVGZkg5HfVQ57zaN4T
	 2gMJiz2DXvMTOvX0V9ilLBnYKMjEQz9XjItCbR8bqMQTp6gXG3/boDw42Oj+TnPdxVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794188682;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Bby9HqZMeUEl9Nn1jT+qhLJUTGxmdH/6xK9tGSiBg60=;
	b=Czekyp+MJP44NVq+xejGvasVopM0u+A2eqJ7sLTlvSxbK7WmduebOCOioTsQLW8n3u66
	 NRGihxgyREXaJRdEAVNRUo96hCSXRo5hfi8N588LwnxqjYa5WnRpafFLTghHbvDoexf4W
	 UKaC/eEAuSo4bBfBze/+eyDbHtFSFASZxB+3w39Y/j84xXwiNbWokuVA+yW4lh6HB6wgU
	 Xz/UWYTZ+w48Ir244QtYXav9GWboDNxWzChdRZldbXvIWQuue0CuTS5o/EGpoYtAV8GFs
	 PkTxp0Op5pI0sLNeFKiwIMeadVR2ldoPHOyijEeQYzatpTke88csBDGlqWrj+twK4iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gMJJVw7W;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EAD606D812
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 01:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63EAD606D812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gMJJVw7W
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ed11653a91so1487335ad.2
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 17:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794188682; x=1794793482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bby9HqZMeUEl9Nn1jT+qhLJUTGxmdH/6xK9tGSiBg60=;
        b=gMJJVw7Wkp0TW2i4f6uRPL3/BtNdK+FWzcFWFeGjg5XHK+HoNvzQfZaN0OlCqrNOoF
         Ru6BX/MNkrcRUeNFLZWn3PPp5TuzVuVlEuMl8Cynvo7L+5nxsBKPHVTx+AT2XlfBgQmG
         V4DLpc4cwTkDlqsgTLYgTskTH3D30bcBYBSbfQGENgIBSysmZ+8JLReC+bOwsWX+t8xe
         hza4pOnr88CJSJo5rkfTKr0u9TWajAmvyOhzvhHuNfGPJwTs0gWoqbnISsfxJbpTksPg
         /gsP48vYQpxQBA8KTGYoMzNHLuVKV2EtblcpOKUkEeloeqiov2Zy7DW0YvKebnn3TXAc
         ISTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794188682; x=1794793482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bby9HqZMeUEl9Nn1jT+qhLJUTGxmdH/6xK9tGSiBg60=;
        b=sxR3nFr6UGmmn+EkN2SfuS5z5jki0HwlAbGdUMCkzh5hX+dVMjY7rXqmbQcVu+8BoE
         90ZnF0wl3VGAfqcbN5ORtBRK9iITFU2zshaD+avT4ohu4vQ8tNzLmJZW+WtMYtE3JOc0
         OfuFPpVjsAlJbf+qmNxaB4ml+X0AN01hv2SMorJJtGjJz4NOs8rQGAKM/qcpFPUbSKW8
         9b6acNJUtyg7zZcpF4wKjFc7wve7Jt88yUgwz5+nnxJkBDFqtlJT6pQHqEmbvyevGnA4
         QaTvEWDtn6nSqMvajBsLWpSB2cHNjgYvfpnyNCN5lwJ8NTbIuzIvSEiK7bSgfYad8GJ2
         g0Iw==
X-Gm-Message-State: APuU4Z+mUDZMSIFeRXHWCcZvqyrMM3vMNV15mkg8pYW8QhiFmPLNFA1e
	izAuZbaW0+n6l0y7pqe0buzOu4cLc1K6ToVc1HakSV200QeWpqMdso443mVbGRG5MjDWtqGXB/F
	kvx6GuXU=
X-Gm-Gg: AYBFou3WbdFHUEBUpG/iB3PI1pe75J+u9CiJrCfBmxz93dvoWfalut9N3R1xjDmqHnD
	BrIN4qw9/L8sltlh0xxxHDJSGyMHHZsJpDhwhE12n7hP5u8G8P98webxd8HlCOkfADO0SnMOrht
	WAFaO3eYcUT4rVSEfRHddNtCyPZk0I8qFfHX7N4iRWLj8Jig56lL8vLkGBWc/N3umxnH6i1KaEu
	ik1XCRnLYnRXq9PtVjm4XOetMyTM+aZ/mriRB/OlczBYaoiiZz5ofyGhwPHwgY9jPspTGvOlWhS
	lgOF+ff3sirIHCvPV2cXxbOcNtcCWP/1fguPuVSUIbWnZ8zJI/ux2epNBWQ0SAiqEnc6j/erAgr
	5519PwDvOukZqQK5WgA+yznOPSKFPGygcGx06x+Ojtw+xLplSFdLDxnHubSKkhPN0XAlv4RvK1B
	CEi8zmN2oEN7iLub9PpM+dG/UbTLZbPhSakrU3rfdxZdiSb4mfXKhJBswDAkArFmAxWDqlA7Q0N
	jGRwrGPXIZPSr4bAxEi/jFmvx8PcRqN2X6lywZlrIVDm5K+IEutJgaQL4U7BZ0Do4bvuperSRc/
	Bn5fnQmK72H39A9v7a25Kx9QbyIV1LLQU0s2GXSzCzHIaFH9lxVUcgArxpgwK+/N4sCyRs0=
X-Received: by 2002:a17:90b:254e:b0:3ab:9c73:130 with SMTP id 98e67ed59e1d1-3b12d355381mr2442289a91.33.1794188681713;
        Sun, 08 Nov 2026 17:44:41 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0fc1bc1e6sm5641735a91.0.2026.11.08.17.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 17:44:41 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 5/5] libnetlink: do not read past datagram when recording dump
Date: Sun,  8 Nov 2026 17:44:02 -0800
Message-ID: <20261109014434.115922-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109014434.115922-1-stephen@networkplumber.org>
References: <20261109014434.115922-1-stephen@networkplumber.org>
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

With a dump file (ss -D), rtnl_dump_filter_l() wrote NLMSG_ALIGN(status)
bytes, reading up to 3 bytes past the received data, and past the
buffer when the datagram is larger than 32K.

Write the datagram, then explicit zero padding, since rtnl_from_file()
expects padded messages.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/libnetlink.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/libnetlink.c b/lib/libnetlink.c
index de0681ac..f67f2b48 100644
--- a/lib/libnetlink.c
+++ b/lib/libnetlink.c
@@ -928,8 +928,13 @@ static int rtnl_dump_filter_l(struct rtnl_handle *rth,
 		if (status < 0)
 			return status;
 
-		if (rth->dump_fp)
-			fwrite(buf, 1, NLMSG_ALIGN(status), rth->dump_fp);
+		if (rth->dump_fp) {
+			static const char pad[NLMSG_ALIGNTO];
+
+			/* rtnl_from_file() expects padded messages */
+			fwrite(buf, 1, status, rth->dump_fp);
+			fwrite(pad, 1, NLMSG_ALIGN(status) - status, rth->dump_fp);
+		}
 
 		for (a = arg; a->filter; a++) {
 			struct nlmsghdr *h = (struct nlmsghdr *)buf;
-- 
2.53.0

