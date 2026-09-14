Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B1821ADC7
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 00:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789346736; cv=none; b=JGkzgL20zVB4hw7eKrGJ9FsLlGzdgtQAcBcidTovj61Qbnl5XIR+/k/nZRXOgmtGhLCZynieM32MAtVtBRF2b5lLvdhkiwbJwOTjA/xCKJnGADWp8y5dJpgZD82DuzmcU3WhB7iHyksqDhQj+MU9EK5wYambZrf+MgKJq5uuo5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789346736; c=relaxed/simple;
	bh=3vx2QJQpErdCZPn9W1iKN6aBTLz8fQDAQbthjqOGb6s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qQqA/3CSDfU7N0CmmAmN2Ars3sKXo/JTAV7xiNw8dh8hvUyOngiTm2POMv1sM8klArGkF8gSjxWVqLndaSmJxpuRJ8aUwxgIoZDdOyGjipoM8L2JlUaVZ1EH3ASQs3Squ3InJf/R9UaOUdHeOpB7FZROOFTAVpEF1Y/37F/i0Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gs.ncku.edu.tw; spf=pass smtp.mailfrom=gs.ncku.edu.tw; dkim=pass (2048-bit key) header.d=gs-ncku-edu-tw.20251104.gappssmtp.com header.i=@gs-ncku-edu-tw.20251104.gappssmtp.com header.b=PTeC7Voy; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gs.ncku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gs.ncku.edu.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gs-ncku-edu-tw.20251104.gappssmtp.com header.i=@gs-ncku-edu-tw.20251104.gappssmtp.com header.b="PTeC7Voy"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso27770205ad.3
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 17:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gs-ncku-edu-tw.20251104.gappssmtp.com; s=20251104; t=1789346733; x=1789951533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f7RGlnM7RppRSNr2XCcE2fndgqMIXT9hQ8em3W/TKFM=;
        b=PTeC7VoyRQIrWYZYDqoHJulVJ7fFlwSWdtSz/u/FH7uU/I4H5z5LWtgmcnQO57xKFV
         z+doOy/pPjJbfEMEfcrrc1YkNm+OtBOYJfCrp3L8o7gczqRUOj84im4+Q7+ZevDkI9Hd
         6p9TspWD/S1NSjDz5LlEhmiXQ6uWtg/8qhxR6pV7YKgoqIznOzg+JcyFm++ltMfwsbsD
         oCQtAft6I5ZIKnzjNjN6Bf5wCbVC2aB0wpdkKhmTBZigyWKu2nTjuXJTf2mxr94NIhez
         /i19NyyqyiCC+sbn3eY6PUPCIlrNPBK+jfYIJksHUQOQUGhPlfYjhw7tqaeiuipIN+ft
         byUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789346733; x=1789951533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f7RGlnM7RppRSNr2XCcE2fndgqMIXT9hQ8em3W/TKFM=;
        b=sF03Gf7CdYDkRUHRTWNaueCrx2wCRWxIpzllRLjbiIfGNRbf/uY/1UmROwQnjViylI
         KmR7pNmOwql9W2+gb7TYBz1QLZuCJnsRxgP5WY1Ohx39BWZEEl/6whS+ZH13/7RldcJL
         PCNYwDzImg/lI2i7ZrPb2XCQwbloQdy6o1Xetg3/r6neJ3knCtQMTXZrUaDWq8LHPjdG
         z2OBMKX31azsELOdfAouoLer+40QlKwJJvac5hLdOIubfa5vNdORNFJ1n1VZA2xsZeXp
         oQ15Axhud+M9kA0itOe/r9pjJh80QTAZH+63wbI3fzzhOhTNw4sIDKZuJk8TggLYb0t+
         Hx5A==
X-Gm-Message-State: AFuF++nRnYw/LFYdsFmE5k5DySyOAi+8Tv0O6fq3OwwuF3A6H6P+o3os
	dYCh+9VZPRY5HpC4jdTKnay7SvtqMgSyj2Kio7EdPfFJvBIGvIv0J1cO4xdzhqb+GBFHqYbD2ES
	luaLQ0j2VhZuEQrtZLEmq0FpoGr2TTId8tI78TA1czXhw5H1xZpBYtUfjpNUpCJUnnurzw25ETX
	BUH6hihIQkFg4oEceal4JXN7yY+9xucvs2PdpfpwTAGz0mAvvCOA==
X-Gm-Gg: AYBFou2LDVlOkbDj9N5adqRFgk0vuU0T0VBv1q32iycweVG4BADdwgingtp4G1FU2fp
	ogOSTDF7FFKC453lWYZcDMFYDnLxtia30fWQbKrWBqcJ5wOp8blxCdJJhZcbGxC7pqsDTaXBgkv
	TpUDlpHmDSEq1UcjVm5udej1sHdHSpZCHz5zbuAvb3Z7D0yBpvCqIMQS1AR6hhPWVtVVhmzXh75
	ADAIP93CuoIzkVVJ/oNqirtV5Oib/eyQEUJY8YLivb2eU9YwVRcgrqLJ5BM6sb288X5y1Wjmhng
	67I/S4L8eI0bQQIl09dcHShdmn4aDhRxgaKc2aCODEeHSPk2B4VnQZ77XzxVMDoxcD0wDm7r+QE
	9fFCC3uViDzGILGbtsfVLG0Jccv0vOKt0rRh7wFJjczwbuYKC4QTt3160mGkZc1apt6g/s9Pex5
	9spGDNC2evUPV0tyFra0AXsm+YpJii46nBJajuoCODFMa64KueEu3UEkdbIbrkAc9sEjD+lb8c5
	wHC9shqBF8uvrruDEKLDCdRFDTZvCWCXls82pG9gMu5vbFzIIpTV4E7pw==
X-Received: by 2002:a17:902:f644:b0:2d9:3636:d01a with SMTP id d9443c01a7336-2dd6c725048mr6751595ad.15.1789346733164;
        Sun, 13 Sep 2026 17:45:33 -0700 (PDT)
Received: from localhost.localdomain (111-240-141-218.dynamic-ip.hinet.net. [111.240.141.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd3f0faf19sm32604465ad.12.2026.09.13.17.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 17:45:32 -0700 (PDT)
From: shuo huang <f64116045@gs.ncku.edu.tw>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	jiayuan.chen@linux.dev,
	f64116045@gs.ncku.edu.tw
Subject: [PATCH net-next v3 0/2] selftests: net: Exercise TCP payload verification
Date: Mon, 14 Sep 2026 08:45:23 +0800
Message-Id: <20260914004525.46597-1-f64116045@gs.ncku.edu.tw>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds TCP payload verification to udpgso_bench_rx and
exercises it from udpgso_bench.sh for both IPv4 and IPv6. The test
checks the receiver's exit status so that verification errors are
reported as test failures.

Changes since v2:
- Wrap the receiver command in patch 2 to stay within 80 columns.

v2: https://lore.kernel.org/r/20260911160649.51863-1-f64116045@gs.ncku.edu.tw

Changes since v1:
- Add patch 2 to exercise the TCP verifier from udpgso_bench.sh,
  addressing Jakub's feedback.

v1: https://lore.kernel.org/r/20260906145643.219609-1-f64116045@gs.ncku.edu.tw

Testing (v2):
- udpgso_bench.sh: PASS=22 SKIP=0 FAIL=0.

No full kernel build or boot of a patched net-next kernel was performed.

shuo huang (2):
  selftests: net: Add TCP payload verification to udpgso_bench_rx
  selftests: net: Exercise TCP payload verification in udpgso_bench.sh

 tools/testing/selftests/net/udpgso_bench.sh   | 35 +++++++++++++
 tools/testing/selftests/net/udpgso_bench_rx.c | 51 +++++++++++++++----
 2 files changed, 77 insertions(+), 9 deletions(-)


base-commit: 08dbfad3f5040f5bdb6c529da20d6d4e81fefd72
-- 
2.34.1
