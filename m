Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBF951E42E
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788956732; cv=none; b=iELlglb2Tdk5Cyed2MXmbsQVfDG1Sq1BmjJQttGbo1u+/489IWyEZCyvLO71y8gtDsd4c/mkAIr8iE0FDD24khApW3MCJds3C96alc3FignIoMJprdNT4DEFMO1d3dM8vZ1TsRnEnCNt1bbG2Mc4xRRTHB/jk30bWYvAQ8f4jMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788956732; c=relaxed/simple;
	bh=n3naVrMZf1eMBMz6krzSP4NdQDwTMp3k1GlYTRlxlc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r5IilVBuN6364jhoGi70tBNuGnilLGgI9e+1Ro7oSma2W/fpGixaFCtekcFP8MmQuMMkz2tgL/3TtztawnvIBED8O5AMqLpe3Qomcwc21J9f5ebZyJ0SgP1wI1qlFCG9IMGXtF6dudZU48cbY5uq+9AMEtigQwjACBtYMNlOULQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDdp5vG8; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDdp5vG8"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-53031a57d7fso58846871cf.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 05:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788956730; x=1789561530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/v8AsEvq2mhutOPqz3uIGlqkQlGqCqlg/Ykqh+aUxLI=;
        b=mDdp5vG8OdmW/KJ5e0dG7aBiB5Gtut7tsNuIWgZ2kZzf8JNKh9SBSZPiQBDSfbscDW
         iogMFyE/31AgQrW6lSJuX5NZfAPc4HSRjbe/Snjqm2vopI9lIA5mwWoPnKqx7pBF+X2x
         7ZxYX8VTFZqZaRzN23lRKWIBBCG+ZB2F/RV+iCgxShrjU12KrgIjRrNTMRDZcf8kLdKv
         RYqQGdCUBKARJdPGQrRlZJnguUuYNOluQkjHHPMAC4N+0j4mX1SzeXgSn+c47IR0UHJd
         jY/RGG77mdbSjDwYoYkO/D9qpg95PndXHZF5pTTiaNiJd4uBHqHP7jt1tZu4jxjImPba
         kNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788956730; x=1789561530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/v8AsEvq2mhutOPqz3uIGlqkQlGqCqlg/Ykqh+aUxLI=;
        b=XBAUCYEuS40uGkNzZpv5yU3VMN3eiO/QhpQmFTK2onafm5u5EPAMDUnIltIM0Mhm5z
         w1SC0KQuPRnP7pYgT1pXc8SKdD+6RhrWAg6DxzR8oInoDmQ1ECjtaoX/Emep51ny+UEr
         17KhL32JYHPFEQXv7e8kFh/eJ2Xpju36I5rapwh7ddHBf6+Ljsviq7bfnIH0YoUqf76F
         mIGuQUh0q3bGHJ/yImCXEzXe0zpAGfQvWOHoQItlO9REubY8oh+xfpPCGm3b1vtJ01ev
         zHYIUxd2Hi51wTXqMlfSUF1n731p8UVXU+M4w9V1AHIfwbUQ6/EpOWh5Wha1uHpUNhOR
         +j3w==
X-Gm-Message-State: AFuF++lBfKbKXaQNuhcKbap7v+/O1NsqaWc0Wvo8d5kdjmoEOwKRXxFT
	IYVxqpSyehiO0MiX5JIrrqsBPCUTs2804VOdbNit2uq9ZP/3thFxJUl5Ua8VdN1a
X-Gm-Gg: AYBFou3GTuLz4ZvfUYQcaRE5QGxnX7LFMNvQUmogBQVfxNdI3X6qwbifeYlFqORbRfr
	Bb1twkGsr5HYMFK9j6io6Da6XOrxxbdNFEZi8MIfP/FsnYqjnOAuwQpNMTtdSwJ1cSxPljASxsZ
	93DkIfjWe8iZZ6XZcm3mtO0kgNYPGYYJwjgK4jIAwHamhzZup3udHykjksr+/kAG7N+u40ItXLw
	zWx9CUuOscRpjVKB+c9bkwnoDHvrS7fb2n0gSIGXi7kA68tf9iMc1eB/bpWnRiOp4DiYTtB1Pw0
	IGONDqfGI5L5nwrA3QBJOQ2hYQ8iFxC3ZDdCWdNPBOJUAlPuU2iI6C1VF8guZYEz4NWIl5C8JpO
	sgW5c3QpzqBuV76EIqSo2fTTNsxBqHl+hqn69jaRPJB5xeoGqYiUK5utN8ANaRiyUp/9QUqFP3Z
	mXeY4QfzbQqWDclJNwKMwTbXiLVAKgFM0onT0Fh/mnzAu+llDfGM6q94nvWV/9pznzyQ==
X-Received: by 2002:a05:622a:144b:b0:530:430e:8f10 with SMTP id d75a77b69052e-53054a34eb9mr379865441cf.47.1788956730010;
        Wed, 09 Sep 2026 05:25:30 -0700 (PDT)
Received: from houminxi ([163.123.141.225])
        by smtp.googlemail.com with ESMTPSA id d75a77b69052e-5308d8d3eddsm61037541cf.0.2026.09.09.05.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 05:25:29 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next v4 0/2] selftests/net/openvswitch: SCTP tests
Date: Wed,  9 Sep 2026 08:25:19 -0400
Message-ID: <20260909122521.2687193-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series extends the Open vSwitch SCTP selftests: patch 1 adds the
IPv6 flow-key test (mirroring the merged IPv4 test), and patch 2 adds an
SCTP NAT test exercising port translation across conntrack.

v3 -> v4:
- test_sctp_connect_v6 now also asserts that installing a keyless
  ipv6(proto=132) flow is refused with EINVAL, pinning the reject side
  of the match_validate() sctp() key requirement (pointed out in
  review: only the accept side was exercised, so a regression dropping
  the requirement would have passed unnoticed). The refusal is checked
  to be errno 22 specifically, not a flow-string parse error.
- Wrap a few over-80-column lines in the NAT test; checkpatch strict
  is now clean for the series.
- Rebased onto 548b86839f7f.

Signed-off-by: Minxi Hou <houminxi@gmail.com>

Minxi Hou (2):
  selftests/net/openvswitch: add SCTP flow key test over IPv6
  selftests/net/openvswitch: add SCTP NAT test with port translation

 .../testing/selftests/net/openvswitch/config  |   1 +
 .../selftests/net/openvswitch/openvswitch.sh  | 201 ++++++++++++++++++
 2 files changed, 202 insertions(+)


base-commit: 548b86839f7fb819a4d6c83b71c73ec378d24275
-- 
2.55.0

