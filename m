Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9643750DB
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787326759; cv=none; b=RdkklXgNiy3ATKv3fHc2lGkEUUuDoPwJ013hhYDMXBKYS9KWLMK/sGhM23LCYNLnIeDoYf/MXb0pguwIbA57ur1xDQpDa+hx9+lIeYqGtu7aqxtmsuDyhfv4IXopdd/UAV2rSjMRspu2kfWg65vjmlxQARz3QcuJFvAZbh014j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787326759; c=relaxed/simple;
	bh=pG+a6jjAoKRihKXGupTX5Bh3usPZcUjebp1rhSIsNwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z0XTgWaiYzKtI5/zklBxFlFWSJGfyUr8wStnspFLas/eprUwaIYtc+u2YfpSqFkWl6M278kWYEG7ES5ziOkOhRE/RpYg1KjFzHEQQb1LOGC4+lGEUGVYSBKN2F4dB8dVG6s8+bxp8/FI4IUsQ+GZ7NoeNybnOFLTm8rS0lC7TFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=HAWXCv2b; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="HAWXCv2b"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c15d47266baso137250366b.3
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 08:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1787326754; x=1787931554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WL6hMMT7AmtWJM8Xr047L7dEPk5higpq6flz2hMINds=;
        b=HAWXCv2bf4r1sE/Qo5N2Fzve/GEGg6mGEEkL90UNuntpbOFtYg81H4bEtaO/FXQkQK
         oWp8ivZqY/dc2+fGKIBcdxRsB9f8VTI9nPeBfMK5xS2lIRBmW0l5i06NzFWDI2RaK3Z5
         r6uYyZ3hXGvHEz6F2MlabtMllbhsYTboEMwl8QkpB0FOLFzzL4PIkjRyuG6iRNHcPv3T
         6U4r+O5ycXfqH5vH/yXal5rQ1x2qB9pUYlCGif1BeN9ldYJJ955Dq4DJ6FubjQ9drY37
         Hd60vHvtreMkUtBynPN/m5WVcR2X4/9hZd54i/q+9oilAeLDXFoE+kf/3wz1A0N48V/k
         Npfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787326754; x=1787931554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WL6hMMT7AmtWJM8Xr047L7dEPk5higpq6flz2hMINds=;
        b=c2g32P7TJ4iQf8xTWirtVO19d5PUIuLq9v7BrlQchfwfIruCuhNNMdbcMfF5jILGbB
         Mw5RyvzVJwCXBBw6vwpvl1Z81RAJQZhz9ypKBjlrpmDYVN/LtBlB5CAYd2ADQIPDTDho
         sRjR9OI0j/ixvyFdu/L90LM6nYfajmhVA89Xr7l6G13Rj48WfvFgAjnoa4GBlA3j+TtS
         vTsZh9e0m18JUb/kHYNDAuOX8v9o5pSuFirTj8VrmD5AARAheqZmpipgv2kyOZrpM7+v
         0BlAFjjjh7Gk7TrR7JQ4bQRdzRUGOZOEFPSXMBm0/1UZY/DA+izISd+eEtADOAbhBFMg
         5W0g==
X-Gm-Message-State: AFuF++k89jyr7zbvL6WIbT2VqdEa78OZdSb1tP9IbTvdo9s6zut1IXmv
	ty2f3TObbfEFrwMry5/vZ+J0kf/PkAun6u+5tald32d2IcnTCBxkSiinOsy9ekVI5+jIW9ER1l7
	TYo72Ac9euQ==
X-Gm-Gg: AR+sD139gOPjqYzo0FahmGqj3J+fsX+SRyFiKz+X5Ddqc9s3rInR4ra6b2PlfBH+Ac5
	IJUn3+ZY/Ku4G/zIP/ypcuMA1SUqygGOcqB2kKYZDXcQVmf2UTgTxQMPw4vb7hB8sWhzB170a5Z
	KUgNeWiGihUUkQxw8vWGdGXKtW08U69zcCtZcGNJleiH4lXCjkrMTZIko/mKPYkboheTaRgLfse
	7MOXl04N0DOCyXPSUkCULuxpummHQT32qXmG6js1jwsCbH+xrpB1hgTD7s4yI4khlRsujLIXPXl
	Gol/7ahvuzrEFmTIyCWUxJnhmslzS64Lues4GMxZYlsaa2AQ94LJxwogD56sPWMrfQDAZoeMhmM
	Q35SeVP7sEBk/8Ft1CyjoO7hmVsalk7qSb+axp60cMU+mn68/8aziylnqeSRuQnYW6GXH3aWrkh
	EapQfRGLhu2Xzlolwz8D7oT+pQLDfvcq+iF1jJce5C0w+WYufvokNW64jrDeKiNLhJVSyjVngwY
	wXGbNxik4qKcZLejRQWREhzUoYdlVt2zW45wy3pK2aLN//ceeC/fWfrO/ECFQs=
X-Received: by 2002:a17:907:db03:b0:c12:74af:51f3 with SMTP id a640c23a62f3a-c246a33e291mr725930266b.6.1787326753472;
        Fri, 21 Aug 2026 08:39:13 -0700 (PDT)
Received: from localhost.localdomain (92-180-236-231.dynamic.orange.sk. [92.180.236.231])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feeca188sm7395734a12.6.2026.08.21.08.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 08:39:13 -0700 (PDT)
From: Rastislav Szabo <rastislav.szabo@isovalent.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	dima@arista.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 1/2] net/tcp: fix TCP-AO key deletion in VRFs
Date: Fri, 21 Aug 2026 17:38:22 +0200
Message-ID: <20260821153823.266343-1-rastislav.szabo@isovalent.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TCP-AO keys with TCP_AO_KEYF_IFINDEX store the VRF L3 interface index in
l3index. tcp_ao_del_cmd() validates the supplied ifindex, but does not
assign it to its local l3index before matching keys.

As a result, deleting a key scoped to a non-default VRF always fails with
ENOENT because it is matched against l3index 0.

Fixes: 248411b8cb89 ("net/tcp: Wire up l3index to TCP-AO")
Cc: stable@vger.kernel.org
Signed-off-by: Rastislav Szabo <rastislav.szabo@isovalent.com>
---
 net/ipv4/tcp_ao.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 5094267447ae..26864621e6de 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1834,6 +1834,9 @@ static int tcp_ao_del_cmd(struct sock *sk, unsigned short int family,
 	if (cmd.ifindex && !(cmd.keyflags & TCP_AO_KEYF_IFINDEX))
 		return -EINVAL;
 
+	if (cmd.keyflags & TCP_AO_KEYF_IFINDEX)
+		l3index = cmd.ifindex;
+
 	ao_info = setsockopt_ao_info(sk);
 	if (IS_ERR(ao_info))
 		return PTR_ERR(ao_info);

base-commit: 746fc0787f616da418ffc04a110296fe95d53491
-- 
2.43.0

