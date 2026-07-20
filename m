Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CF0416CE1
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 12:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550442; cv=none; b=nfB3u+ox1LUq4fPjDRT3A2S2dJ7LTCUzlMvhRTt0qwOBH6ZANv64a0UNlYuCQYKDKy/8diDISlUVnHQwMIpAHxuxaFf+GwclsOBQxQT6oG4Kgv/CUqETqAaMvcbZvWWe6bjEhQbyjTWtz7Jmb08GJdKD3Xe9CfOtRj4P/UREGWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550442; c=relaxed/simple;
	bh=v3tJvKkJthwak2BkhKDVB81AH3BOOglPt9PAUrPRntc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qa4nLUnZwvwu4wgw7Yqi+UOcEQcIUr+dwz72lUs7uMBxDLQAimtorr+DnqRFVk2Iar41wO+Ui7povw7XKjFle0VYZFOQOL6MOTZ8bhFj0LRFHAowqK1QHK81ZczJtQG9C5FIoBk9+t0mnKqDPrXEO+N/ehycU7KWDAuSgjqvI6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=eDCNbu58; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="eDCNbu58"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8423f236418so5066828b3a.1
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 05:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1784550441; x=1785155241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3J4hG7VnONQhJVuSgvWFS6/62B2ydGt3SfUgT2oulUw=;
        b=eDCNbu5859MKskl5UV157UxdNZ7VsB91rxnc+vnha7oS4/j3gCnKi8LiNia7exN0VY
         2YnuIs+WfOX0p4rDpLX0v1/oeyT5ZxMAhnPEBz/iaXnhuA8qb5X4wjTDg12rcI/W/a07
         ELxitmzEZmwaYxV0QDgpNvknbiYGoZiSBI4Rig43fY/zbuOJblV6cHBMvscHzUbpsnag
         TCyiKfhFcsJ2Jl4kzK8b8NGTwiWTSpmMg6vAdYbgF1yq2IJt91W2Hy1NUY+VPWg/AYuf
         HWq8nOTqsnxJzR50AUq0RgBQY7ExkG13Y5HgDlLP/RAM0C+ccNy7qqpElkyQUP8WIw1N
         nvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784550441; x=1785155241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3J4hG7VnONQhJVuSgvWFS6/62B2ydGt3SfUgT2oulUw=;
        b=VhBFkKBD3oBF3ZaD59PBMHz+qZ/2yHKiYkm8tVVFT0CWqT+gHj8upHG3dPbqxrWgId
         5cVsj9cP4SuQCAHOtxWB3INN94sC1zniUZOo5KQia7p5iScbG9w0PneWyp5pUK0h3j+3
         IdyTCbdty1qkF4iZjJDxUSIj3MY+d5tggw4FDy/IeFu7kIhvvrasAs4qkwbTUHfDk/Dz
         jAM2C/SQR6Gwxi1COk+mTqb9k6rg5oYQ03lDop3Uf1ZsEz/9AxXJOUx319rH++DOoIRB
         riSOlFa8j4VB0FZaQ54nU2jyTkubnyp6eQt/4xoCB8gkiHs+deKWEJRS4Zy2y6r5FLNZ
         4png==
X-Gm-Message-State: AOJu0YzJGWKesKZfsA9yFxOnuEkrmmo25qiOkatWpX+jIdG0cRUFdQUx
	Ybk7q7mTgfD4vF0h0tiz8gpHPWKPaAd6diZwWvq2QcDWRaukC60BppcNw6CMistMC25JUeftFnh
	Cn/cAS32bfQ==
X-Gm-Gg: AfdE7ckTwEpd8OfKQMV3OaI/wfiZmiLNeUvMvCrjzBBmd8QkoyVmg2GQ6HVtzWDHRhy
	ODwDqcRFJpxayQMy1xO90vEswAaidlFR42Lmy/4Aobo9yNzKiAVllQU7xddux2mAQEvqgn4M661
	0lhE/OFItpj6CwKiFxzZ3R7+2oiJr6fAhSc9ppPDiHMkiK56w4g/DfTIoNnielVtnOXNA+Ng6S9
	Gy8pKaK2acp1OSI2hCRgxD8AGeybTAuRHe6oO3o8tuLgIUYetU89o/szEbPLDlyajQ2YiKypZLp
	MSqEm3EshAfiheNR+SYedLJNxBKRonFXNA4RnIzrU4EgDVpxC6Cz2tugR09uKre8yG71Bihbhyh
	ziz3SXInzKmrRYo0UgonHjCuBhHorqi1UviH2n1BstHwSItTlhDzbWndVZXw=
X-Received: by 2002:a05:6a00:2383:b0:842:6004:3fd5 with SMTP id d2e1a72fcca58-84c292a8e7emr13349601b3a.25.1784550440736;
        Mon, 20 Jul 2026 05:27:20 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:44::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2afae3afsm5562632b3a.60.2026.07.20.05.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 05:27:20 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	Joe Damato <joe@dama.to>
Subject: [PATCH net-next v3 0/3] Extend packet socket selftests
Date: Mon, 20 Jul 2026 05:27:09 -0700
Message-ID: <20260720122714.759175-1-joe@dama.to>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

I was looking around the packet socket code and noticed there were a few
features that could be tested by extending the existing packet socket
tests.

I extended the test to test stats, drops, and auxdata and re-ran the tests.
The existing and new tests passed.

Thanks,
Joe

v3:
  - Patch 3 updated to prevent combining test_auxdata and test_drops.
  - Patch 3 updated to include an aligned(8) for the cmsg to ensure (1) buffer
    alignment for cmsg struct fields and (2) aligned payload access.

v2: https://lore.kernel.org/netdev/20260403233240.178948-1-joe@dama.to/
  - patch 2: remove argument from do_tx and use global instead
  - patch 3: add argument to do_rx to specify if the socket is a packet
    socket. factored out the aux data check into its own function for
    readability.


Joe Damato (3):
  selftests/net: Test PACKET_STATISTICS
  selftests/net: Test PACKET_STATISTICS drops
  selftests/net: Test PACKET_AUXDATA

 tools/testing/selftests/net/psock_snd.c  | 140 +++++++++++++++++++++--
 tools/testing/selftests/net/psock_snd.sh |  10 ++
 2 files changed, 142 insertions(+), 8 deletions(-)


base-commit: 298bb2b8903323f6ef2eab4819a2e477765f0ff1
-- 
2.53.0-Meta

