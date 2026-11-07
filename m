Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794057657;
	b=vEZ/1gFbWqbxn9Wb7Q3nxMjoqOTI8gjWte+eLwy6xkujP99UmgddOHhOF5JP0zkn3sdK
	 jwzapGA6SClpINycGqHXfkAfXwHNoU9tU69KuRF878rp2heel0OUSDSRsSU+I/CnfV9tl
	 WfylW+1U1qamTi+jOxD9SkSBp8q63uvkQiCpsmZdEgdz3zLEC2mL4q2X5dSaeMs7KUPry
	 i6xuS0WTmnzVpFLE8zsUnW6+t8Qn/efJ9Rwiw0yLzALJD2W0PhYMO30ItgC5Fhsn9jI4N
	 3g4tUBER7weLs/4/MLeFq1sPP/M25HZtZMLsUa/HgEdY8pO1l19W+idOCAJWivH5GIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794057657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=cYIhhXqp9c56w/QOvuXU6MeBpa7zv3rMnSX9cjjGbLc=;
	b=F7ESnYpPHLdR/pQTm26n0F+ygBtLmApkHdz/8zdcHeaq8zHJAmLxLl04fKlTS5H8Azks
	 bf6wYvYl9RNFh3//bka6KxLfJ/0kqmUVzr1idLuGPdrYCF9ncvTKAS+BAKzhVA83Y7Hmy
	 UlNX3S3yaMMjU4ib28jJ/TCe0ongOj8rN2cHX46wswFfQG83JOcHLKsXqcKmOEXa41dH+
	 qghE0ncuc6W1WlL5w8uFmm8y9QBQENHK/qsJB6JVkzNXioHVPzg9vH7ajdCBodDDuIgNJ
	 3ldFwOA4n4rekTJixedfyHunao2JxSWHz+8VbGlzLSET0L1wroydIEm8dqGYlQjIYmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=alvI6v5Y;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5B5606A32C
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 13:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA5B5606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=alvI6v5Y
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so847178a91.1
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 05:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794057656; x=1794662456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cYIhhXqp9c56w/QOvuXU6MeBpa7zv3rMnSX9cjjGbLc=;
        b=alvI6v5YK+3e3DeMiM9lp1AmmnoVQ5r7ZoZodCRBp4C6E0K78JLc1v1zUfM5PJnl7O
         yJT8TypjpMT3P/VyZ3JwDFB9FMOmDXE9X/5F/XTW8q0C0y9Jp5K6UqH89+U7AlyosAHN
         04o2ErN352FOCYnD6WKJQhjKhBoUGyhRCM/+raJSv+/renLjZnGNOlZPxwbcUrNvJXim
         e7dqrxnNlZAtysXL8gCdCbpi6vwM7XhRicS+dK5s/FdN9V+tu67FDpB21HtZgSCZIORX
         vk/GM0jNkabjHxez0xWf8QKU+Bi08xWRvOyYykJr7xhZLwHgN+bsNYo1Et9I0wSq5YcW
         vvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794057656; x=1794662456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cYIhhXqp9c56w/QOvuXU6MeBpa7zv3rMnSX9cjjGbLc=;
        b=Cs/ZDnn+ZSWYDkzX0u+bm6KkRWxuBVqy13nJhWztFWR7pVaKVxt3576cN/67kIy4iO
         JRzp86cfm93DjnMs80iP/Svo69NapPOOYVJF8l51gxZFD9cGJ8puii/bQHw/EL84ZATM
         xzWCFWLvoXHkSJWBKSTczlEaRKzdYsaF58wV7wyCqVrHTsKaXtVGRWCYaXbzCCkc+JoZ
         CG8qVST+lqtuEw2ryhioXckWFHiE16A4uJXqey/viTBI9fPYvOx7JYyalNPA2Hn0BJST
         P8yWpfbF3758n2citeRuucT+24oZXSW2wAUC9A79kSc/SbmqaQMzsPSK987FJWY6D4Wo
         CiZQ==
X-Gm-Message-State: APuU4Z8koBgqIRFAB34u0MDC34DeJVtxAutAgbQgHXr5dYdmkMxxYYRJ
	HEZWYH5dHcbnt4rpPrdB0KoQqP4ZYlOBrDy3OzFh9P1fb8yqgM6UmmIoAO+mkA==
X-Gm-Gg: AYBFou3Q3UO5GAA5+olGw865C917qzy+oQXvHSkShp8VKLV5V8Q1Kd4HhEx0LMImIOz
	grBGrUX7vfUsDByFQfSed0HrDP3nct4JSAN+HDAkn2RSgZ1s4RWT3pgDxLh3shTrPVTvtBkBkCH
	oWEvFBmg0vXKOhEXE9WxArKnKx8VyArcmHnsebbNS16vXG4dp/0fClJySCJFhacuXyB5kkvAa9k
	IuxTpYaOIH6OrOzZqqClDfS2K2hGH2e1x7SQpt8Tf6Cs+rI3SjGAEx/k2XdIByQxfWqZ/bYWsUZ
	zgREKEdANqp8ytOlRBTqBUqFRDueIPPF3dX0icP9vtJLMwY4cBslTisCPbazGmC6YCJZ0Cjz8+w
	abLvPYO0MmAt4ySXLWqFAlvlIn2eaVBAuLNARjiFpk6ZffVCtDzZgnMz00mhrJDnOL7NTevBnc4
	2PDxzQce6W/a5QExKALf5TaNN5OBVrOg89cSXQbGfnwxKC+T0O7/05zzGhAhINnUYF4qKdyUvId
	ecVPKaRpPzmZ5Sx6eei3FhPHlvsyWj5A5ejrZDnivXGOu3xBpaIk+qDa4IiSTUtL23MAQbBnG9h
	/xxTqDd3H8RcYs1xBtDtWLntnTQxGylpqaqprg+ExE4zLRdV9+zBYg==
X-Received: by 2002:a17:90a:d88f:b0:3b0:a970:caad with SMTP id 98e67ed59e1d1-3b0db6e5e5emr5621942a91.28.1794057656176;
        Sat, 07 Nov 2026 05:20:56 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b101d3d0e8sm1626521a91.3.2026.11.07.05.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 05:20:55 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/4] net: dsa: motorcomm: MIB fixup
Date: Sat,  7 Nov 2026 21:20:32 +0800
Message-ID: <20261107132040.1066996-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Various MIB defects reported by LLM.  While they do actually "fix"
something, the odds are extremely low and all depend on very specified
transient conditions. Since MIBs are not control path related and nearly
nobody would notice them, target them to net-next.

David Yang (4):
  net: dsa: motorcomm: Fix stats64 error counter mapping
  net: dsa: motorcomm: Fix RMON fragments stat
  net: dsa: motorcomm: Use safe 64-bit counter reader
  net: dsa: motorcomm: Prevent rx_bytes/tx_bytes underflow

 drivers/net/dsa/motorcomm/mib.c | 62 ++++++++++++++++++---------------
 drivers/net/dsa/motorcomm/mib.h |  2 ++
 drivers/net/dsa/motorcomm/smi.c | 35 +++++++++++++++++++
 drivers/net/dsa/motorcomm/smi.h |  2 ++
 4 files changed, 73 insertions(+), 28 deletions(-)

-- 
2.53.0

