Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B5E220F38
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 22:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769378902; cv=none; b=lmFxBxMJBgvZsSH5JtwsOOKqKBJ5azWKijo4zQJS6Gjv6qU7Cd75VsBZDor/lH1YxLKXoNTXV+8Ga4y5NfzI7Da5xpkBZG4MGi40j9ibGVMOaUolM+DoFlY5L7EnxU7E0GbRm3XIjStqyUVXplL1AuU8czPQprV6ogLcruvTNvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769378902; c=relaxed/simple;
	bh=gcbr7yWBkCbH9/vvmK4B/Z6ZeS0WiX8ypGkdau2WxR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oZDKIYIIMzqaBzaf6UBH/bV5rKfKUcAH1/9nlRplHazsm54Z6AIzwcSNEt+2nwn7+tC4/TBZIf4cKo/dyw8QKXlv6j+IUgRSvEbxm6ChLj3LAbVES81WwrRAS0Yp5svdzzMMOjf3U1e37lvpTXt+cZkXmwoyT/+Vye5kp+1FWo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxScqxdQ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxScqxdQ"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82311f4070cso1601604b3a.0
        for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 14:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769378900; x=1769983700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VQp1vg/dwnKFw/zJMPorPtvt9hOFL1J7rm5VUN3ow1Y=;
        b=cxScqxdQGcABGq5KI4N+M3WYaQKnUdW7nvVlq6YXIHsU++Qzi/olQkz8q3zuI+XQL2
         4mnVvbNiD5CVXbV6GG1OTKl7cRL5Y2AnzG+9XH02NriAFx8+6dns+c29AINle9YdBtws
         zkmAjrcv/F4Bj7pjaG+ImZRmBW06wgda8O9zzdyE+eM+S1Rn6zB1/ecAQQPd5pNgYnfE
         afkKHuka/Rc36R0TZLggK7ZvkIRH6LBZkej7Y49QlB51BAlw7WO3aR3Zh3A/J1hyW554
         avdRUVwXrLx4JJfsaBs7fJJFkTJBmQfeEHAonrjp/bgfiXy4MnDG/bn1Yk6+KPf8LhSl
         PLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769378900; x=1769983700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQp1vg/dwnKFw/zJMPorPtvt9hOFL1J7rm5VUN3ow1Y=;
        b=fm3VDSJRcg8PztF+BfRH+Nna7gPxk0v/n/B8fbADiRhK5biKNu5TnTBU1kR/aCFSE1
         B0Zkh1bvkjug2QRXJ+DNPqeBs05DLG3EXUr3rvLTJTk3AmO7AZ+1VqVTusr9sT2BpkUM
         Qnm4s5P1MA2Z8/NzPWqUcPMCExlvdyPzKm8HL/9524LDK9bL92vZ1l0DYrRE36jR/czu
         xpCYgFVzxeTp7MHAR/WhS+0lFYTGFz4PiQGAq1pe91PK2Y7Wy2Pcn3KwUDyPUCE3awzr
         OK2JdCH1gdBJOp5uB429IXDOss5oASgZYIPuV4iPv8jX1zGo86mQFT7eZOu454D/f+fv
         huSA==
X-Gm-Message-State: AOJu0YwrSaK9nJBhR331UY6Zl211VogUezcyHXKZiwrgKouVsMUk6J6v
	toDBq9F7DJ2DM1zuzpc8hEIj+qQfWwH+XhIxuFF78EmolpTUgwVdorUepIcnlQ==
X-Gm-Gg: AZuq6aJfreWQ1Djbr5o1R7W0D2K22sSkHdbxJYG0EYG7Wi534Lj2xFIiQTmhvNVi+ZH
	sTjRrynNXUZ75aogoOIVgRlO6unVNnYTPIR7/LyEP8dLN7eE89J8ckAGYSGWKSYEvfFnBn+ZNa2
	FuEwj2Dg16zLWAhDfk5jhGavJK2+n/eFK7KdCRGACgART2FCpyIiI4+JNN4TcJvqj3VQqzHb2AO
	MJgyBJuE4OWZVekPiMjF2hg+OhIlLqU8upIboJwSu7MNbBXX2w49s94PW1RbwaEC/Dj2wsygk5x
	izqKoobNNf0Ly9fOlBUobWzH7Pv03CpkjzGcbIz4U5mvlvokuWlwu/NWzSLXM/lG+nDOOvkbOI4
	iOVvq71zNXyItH/b6n6N2tAhbpRs9+Nrzwcjn5Jmq9jo+YQOq1EUXZEH5Kb+zJJvFLLDIZHPa6G
	JAey1DIZbWpWdyiLrCB3lGEMX8KHFs1jiUX0yFSfXRQEPF+NO7LvTKVgwp6xEd
X-Received: by 2002:a05:6a00:2e10:b0:7f0:61d:d092 with SMTP id d2e1a72fcca58-82341275fa8mr2266896b3a.21.1769378900326;
        Sun, 25 Jan 2026 14:08:20 -0800 (PST)
Received: from d.home.mmyangfl.tk ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231873e60fsm7651286b3a.48.2026.01.25.14.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 14:08:19 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] net: airoha: Use u64_stats_t with u64_stats_sync properly
Date: Mon, 26 Jan 2026 06:07:48 +0800
Message-ID: <20260125220753.3984326-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/r/20260122185255.2761568-1-mmyangfl@gmail.com
  - fix u64_stats_add()

David Yang (2):
  u64_stats: Allow u64_stats_add() to accept s64
  net: airoha: Use u64_stats_t with u64_stats_sync properly

 drivers/net/ethernet/airoha/airoha_eth.c | 153 +++++++++++++----------
 drivers/net/ethernet/airoha/airoha_eth.h |  34 ++---
 include/linux/u64_stats_sync.h           |   4 +-
 3 files changed, 104 insertions(+), 87 deletions(-)

-- 
2.51.0

