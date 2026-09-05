Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D83B377ECA
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 10:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788604850; cv=none; b=tyXMWkL8Aa4JBajQNlq5fg/j0BA859lNQNAVWLto8Kl5UHPrT5mrnQBB+yZhxdcij7JKzUEy8NZRsZaFBSvgsgJVBH4uNqsExAPPFhEOa1DITRcggCh7Ekp3bH4zo8mBX2MbUML2IYatFa2EJGku67u5xESpR8eL8aVn1/Tq1Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788604850; c=relaxed/simple;
	bh=n8MTfmk5Bk8TVq5h3Z9+kGFuVYYk9uNwVRtMjpHyoJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hfaUq/1oKjW7UZBCJBFtWazvnZfekRqPwLeyEzqzC3jJj9GZneLGZ1d8qOGPFh+iQuF7/Dvnmf26O4u6aa68wK21TLhnPV4Y9vo6u0Hg0DmohfQtB41xe7r+RqVmh+ZW0udr2uc44p46CVxhng/jRR/A5ihaI+MtRsX1JH55U/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qSWSaThX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qSWSaThX"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d560775ca2so13969635ad.1
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 03:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788604839; x=1789209639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yVuDGeu2dCqMa2YzjKmQgs1Ad/SNgUGsVx/sRuRzCYI=;
        b=qSWSaThXjq0Cpo/rbmOXc2yuwovwO1tkCkjo7OXIrMytgvOsHjavlgyOgeIBlzANzI
         Mta6WZvDlyMVDdiJJw9WPeUFrY6ZBHowir3vy9RzrC2pbCQRUs84j+1IToJK5olefKci
         lIvXf0oX5mjcfEYDSieuWTco9boGiJ+6B1RfQrvyCkdzr1XTfcg1l7rL6hjOTH70Pobs
         9rhtwGfYY0MV+K8kHpz5L78GEDiteix+SjaSmWZT5zpoq8DOs/+9LsykNXfg83KuNLMK
         tu/cBIU+oiKtohJKlvnWUYAOzP9ncxs8FBw5+tlXaFA01A1uUcBh2Y5LfswEiydNJexB
         4MEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788604839; x=1789209639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yVuDGeu2dCqMa2YzjKmQgs1Ad/SNgUGsVx/sRuRzCYI=;
        b=HPW1tlSVfRezOTGq3K6XyGsb3ditKn1yGnw/0zz4coK9w6UM5l+w7PHJ2Dm3nYx9xz
         ffIRvzqAQdiOCE7WuJWbyIhAMNcWfTvUbhCwoDz29u28tlZEzJtOQs3G3jnDPZ+VXRN1
         e2uN5aR+FPgJMoG+nL+9nEXh/tCc12UmVf/I/4Fi10i2KW2gmp6mVzHyNRriRTLKqq0u
         JGD+h1co6CoP2U8Rsrb1SWQrfAmRRiw4LoGPYmCxEZM0vB1wX7B8NTbcRKRwyk/gAwGL
         j5MF2B+B//HyO61KOF0hbp/rvCi3xJkHcdg1EAEdQ8mIOfMkC1qp7keBnpmikwn7+XgA
         GmJg==
X-Gm-Message-State: AFuF++mx6/MaNBUf8sfN+Hvg6FqWQlOfI0ZcSUmOS57v6dWODs0y8SDP
	gOGcYQ7UaxeN7W/9ALQ/ueX+0iRLPDhTcYIzwiLsu45F9bBl3NKmcKXk7Xi01frzYlE=
X-Gm-Gg: AYBFou3xXM2C2dKeA+YAk5qji4ivc+8WeZLOEZ9DRx9UMnmw0tvuG6TSxRjpD8LxyKS
	IMAA03EFNSarlNkgfKKZWgyuWAmBZEXRARZ/L/IQKcN8NrFsFbAiIE+qRPjPA2+42R/nbPcL4Ze
	2M/yxqC0DXGwX5B+HpIwCebvQFAeChH47udf09cUOWbdHHURaHhByPEch2Em24pMb0VqsQJT7jy
	aPaQe85iy7aRhaTI4/5FrXAs6k/oUdWXVjIRX571XBy57YDPUDMVBmuT7XPmIwXjqW5uZg4PeoE
	Ls0cGCMpA1x/6G/ECJUYJBoybf2Lg8WbB8JVntM1ZthRgkT948qjJ/CxbiPaabcdsxLDa/bWO34
	Fdy7fojQkFRBBfMLzpok7wJENGjigGENJ1iUR89YeXY7MA+nTZc4Up5ubXoFjIcUp5IMajk4UBV
	fGjn4WwuZpA6ljJRjFid1xGAcLIafYApV7Be1DZ+mGjHLPearmVwQ1PLCpnNaDbEon
X-Received: by 2002:a17:90a:ec8d:b0:37d:f983:7b5 with SMTP id 98e67ed59e1d1-39b26101c08mr17247807a91.9.1788604838921;
        Sat, 05 Sep 2026 03:40:38 -0700 (PDT)
Received: from houminxi ([154.197.57.228])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b314cfcsm13559776eec.19.2026.09.05.03.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 03:40:38 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	davem@davemloft.net,
	dev@openvswitch.org,
	echaudro@redhat.com,
	edumazet@google.com,
	i.maximets@ovn.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	horms@kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next 0/4] selftests: openvswitch: pylint cleanup of ovs-dpctl.py
Date: Sat,  5 Sep 2026 06:40:22 -0400
Message-ID: <20260905104026.3776396-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up the ovs-dpctl.py selftest utility to pass pylint.  All
changes are mechanical style fixes with no behavior change; the full
openvswitch.sh selftest suite passes (17/17) on this tree.

The series fixes all pylint warnings except 10 remaining C0301
line-too-long warnings (81-89 columns) on f-string constructions
that match the surrounding style, bringing the score from 7.66/10
to 9.93/10:

  patch 1: convert %-formatting to f-strings (C0209)
  patch 2: fix miscellaneous warnings (unused imports/variables,
           bare except, superfluous parens, etc.)
  patch 3: add missing module/class/method docstrings
           (C0114/C0115/C0116)
  patch 4: suppress framework-inherent complexity warnings

Minxi Hou (4):
  selftests: openvswitch: convert %-formatting to f-strings
  selftests: openvswitch: fix misc pylint warnings in ovs-dpctl.py
  selftests: openvswitch: add missing docstrings in ovs-dpctl.py
  selftests: openvswitch: suppress pylint complexity warnings

 .../selftests/net/openvswitch/ovs-dpctl.py    | 425 ++++++++++--------
 1 file changed, 245 insertions(+), 180 deletions(-)


base-commit: 9eab111e765729e93087ff86a2ec9b2ae42d0fa5
-- 
2.55.0

