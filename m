Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7834D3CBE8F
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 19:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486688; cv=none; b=scP9bqQaqDsOTQ1ARMm6kd4Ksr2mIb6q204AO3pZIWicEeFEa8HKvtc7gnVKYaeUwc5BX9X78tCSKf/tIZ4Jn7BuVU1lbnRf8qq4cYbFk1bbBLk0x1rCV85UHkMDVCiQMQUAthVenkDflf2z7c/I9oT0lnds01G0/Bg5tuPk4F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486688; c=relaxed/simple;
	bh=NykIrWd2AdW8Yh66jl/kLhWwWN/LxKTYIMH1WlGPx5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o7pIuHGjl1ni80wQ4YsmVSiz+A5opOnXItQOFt9d44+hocZpUJhiQY/gu8l13caFfdyde7H/4S5vnDbpJymcGcpQKjsZUDd0XRU11JkHEGakv2mX9kzZki5VCsYeY1wnVV90e0ft1gH+CqTTSv/P01ws6ABPAEeQB9IMxQCxft0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=aJEQBS/z; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="aJEQBS/z"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc1d57602e8so1590087a12.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 12:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1791486684; x=1792091484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SRsY0YEhwi4khCIfQ4VbXvpst8B4Uox65hBINmu+18I=;
        b=aJEQBS/zJqZuvSqE2jLVQ/FgsTKj8mgElBY4hk7vQrdCyY390UDUMLyOviwgVTWqu/
         ddDWb2yl2D9SQ3JFVCMva+OLvFJ5Q5WhPxLyoMFHxLMAAReCB3RFUHv/t/nPoE7zSY0Q
         01R2bODUzkS52fBscTFmLhlIWNbd6Hr0cDoZ51GDfeBLxeUkBP0I/Fz41ghKzhU/T3VD
         pQCM8364GZ1rZa9mMyLNMyd6K/+QKNYXJhkml+yeSQA5zSRlOxrsR/EhZatPMWIjADN+
         yxS7Vf/CEib/tRdNfzHdwURpWlRHiLSKBKWrNqgx4aEYIMMqD+yecofd/Kw39yi9PHZ7
         h41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791486684; x=1792091484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SRsY0YEhwi4khCIfQ4VbXvpst8B4Uox65hBINmu+18I=;
        b=XUDDVVpYGzAw7JBr67veAONgvQSih7ei04yTZXSZagKEIGQhX52MeF0/BZBQZ5etnR
         QJtqXJzM+o+qytBMcnPyiBG37GLX9yzOfHWds0iRgx6oCJY9YRi9ik9PYdFVuZRIUaka
         4r/EkybenledynWaBIXqgAMy4ZgaihamCYZ4UdI/FS+25yd92PBwlSfzJHQy1moMobJ6
         VPzRsDnPT2UHX4GM56kC5DOA9TjDsO7RwiS9ZaR7B6ZXuIYGtIS5N63rHxklDGJatWJM
         0VFt4SStCJFEkzQS1HqRleKAKcjFHdlarIzE2/iw8C5N2jPv2TQZTvwGuaBLxexJyS/j
         XSKA==
X-Gm-Message-State: AFq9FYJhZ8rXAmHl5H6sAvpEqHMglYB0zMl98igeyF61gM6XN7whFMcg
	x8DW1/RdTv36rs/fuO8nYsD2yvLbaEO+IBSmjg1jt0ptg2tSwERHxWeKTZKcGsktHzaj5qsELKE
	10Q9t
X-Gm-Gg: AYBFou0ZWhkP2ZmfU75vvjgcMMx1mkZ3VJeYW+jODh/PFIqK93U8kR3eT1QAFxROz+O
	OqqYvTBi6XY+gT4aOr5mOATwQ+2auxXqTxCPp6QT2msyQmHKCuHMeOyblaDRS4ArS3goFVGYJmA
	TTR4eTHjtvBiHhOB7IJ7GnXdYcXH4NYFJ26QNSNPhiP4O1rz0TZm4GW7T0n5VflUDe5gnkxuTfv
	pH/DhLME6HCSa/s/oQrmjgH5D4mriCYd5JMUNR/43+Koe94/DFemm4iMm+1m+ZKTYi9LBbpRa6Z
	jKtoLmjx5V0H3SglQX/0LfV8L1l3F1rCRaEtqMVsufcqn8jaQDybXhhwCjgCXOnQlVjAL34wJbn
	L5YBkmAT3T/XiTzzXKeVt77tExsuP9gCu7GxRejFELz8OCbpv5B+as6cO9hC6kcUzPDJUiymRAx
	+6S6qJI3hqdst19H9CKLjgGEbguQTcRFLOf0SAcNXl4wVP9uKS5Fd930SXySmwvOwPCNbdN70Ea
	l2KPo+hNBNihnbO4gai4F8=
X-Received: by 2002:a17:90b:164d:b0:3ab:413:49b6 with SMTP id 98e67ed59e1d1-3ab04135113mr2199094a91.41.1791486684425;
        Thu, 08 Oct 2026 12:11:24 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:58::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36de3678sm36899a91.17.2026.10.08.12.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 12:11:23 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH net 0/2] bnxt_en: Fix SW USO padding
Date: Thu,  8 Oct 2026 12:11:10 -0700
Message-ID: <20261008191114.3736826-1-joe@dama.to>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

As a followup to Eric's fix a51d233ccd48 ("bnxt_en: fix DMA mapping length
for padded small packets") which fixes padding for normal TX, this series
fixes padding for SW USO.

There are two cases I try to address:

  1. The last segment could be shorter than BNXT_MIN_PKT_SIZE. So, add an
     extra BD if needed to pad to that minimum.
  2. The gso_size is so small that every segment would be shorter than
     BNXT_MIN_PKT_SIZE (under 10 bytes with IPv4). This seems exceedingly
     unlikely, but just in case, it is handled by clearing the GSO features
     for these skbs so the stack segments them.

Patch 1 is a small refactor to move code into a helper that patch 2 uses to
avoid duplicating code.

I ran this on a bnxt machine and re-ran the uso.py test and it passed, but
the existing uso.py test doesn't test this specific case, so running the
test was more of a regression test.

Thanks,
Joe

Joe Damato (2):
  bnxt_en: Add helper to fill SW USO payload BDs
  bnxt_en: Pad short SW USO segments to BNXT_MIN_PKT_SIZE

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 12 ++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c | 56 ++++++++++++++-----
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h | 15 +++++
 3 files changed, 70 insertions(+), 13 deletions(-)


base-commit: 6d25ffca055a77787c21a36b66c253f76239411b
-- 
2.53.0-Meta

