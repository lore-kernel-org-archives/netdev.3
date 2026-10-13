Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036404E0B6E
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 23:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791935018; cv=none; b=KATX14ENO2A7hj/tXgSPT8pn02PqevhTyGWTapLx5LwFyjhv7S5gBjO/hR8hSulitHtTFHMsYXJnWPCZnmprxBrSi/05A1+9Mk3gSPEVJ/gTt8e3wLBkW1hUFN68eAY5FzzrT+aZ8grG1xhr7HlQY9RLYVULFWPnT29enGJgyGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791935018; c=relaxed/simple;
	bh=dqO1KoTG+cN4rbZgc+8clOi2ZF1INtWv/8DoiIEYBv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TbMK7MJ+TK/3izdI3qCsLcxLuWxQuFHws/vOAK5nbfXUVFe/jEr1Hw09Rk6f2Uvwc6wOb8cMc86NvdBS2I4eKnbqvcbQCSREuo5CrhaBwXH5nOinsbun5j7VFAcjPf6ZGwAh6LQZcNrnwAChf1IlngMMF4+IK0j+IPuFR17MJWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2Gcsz3r; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2Gcsz3r"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a172eb31f0so28447805e9.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 16:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791935015; x=1792539815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FKc8EN/Xnp3SFNhdyz9H6QSdt3ci10wKpCCFTnH3SAE=;
        b=Q2Gcsz3rQAEBnFQlgpu0NYmH5rAgsjk8npUN0koXrmo0qliOQ9g+nSCCP4k9l9Syn2
         UVxUwndHMKOuT1TNC7GtywzFlXWEqwEP3+qVuaxnXJcpj2y/p2ndCGgi5o91qimpA+FC
         sUifupVz8pOc9S0CDAM3A7fYYxKczx1pQFhjV4fzMtNtOmsmVsT9CVgGluSRb36Lx5DY
         yrrpEG1tLPHOj6smODB36INxO0sUEg4uWqKuZNKegUtObfO5JXqg4aOYdYkzpsYZQytt
         XCeaFh5hkJwFWVdlJWpne+wwBi3efBHB0gYBFH+PaSyrP8l38/bDVASetzEBYIL9o94z
         wMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791935015; x=1792539815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FKc8EN/Xnp3SFNhdyz9H6QSdt3ci10wKpCCFTnH3SAE=;
        b=1EcrCOOgCVk4CHNAHxydwv1OWSFwFlX6CEZeZjU4Z3sWzc+Eh5ZbJ2yzP5q5NtYcI8
         +9CVbz4sx/879hBRsSAqHO+7iaJ2cCLAYY9sZrw/XcmrQADOomTdS+/WCJxA56jC8zn+
         RZ193tCUWBrY4GCECADkuJs3kZqyddU5U0zherhIRK+Z8rIErfR+SxeQMohn28kZWKx5
         LDbzZ4KW9nY/Pbi2YeLrsBOEAg2b8y2ZRbdk036IJet/AoRcZeGqHlPrQQ15nS8OzdfI
         gPuheCrzsd1vMADj8oo02BkHxbbyTz0UhIkqI8h4rkKe8IZNvqNMc8hJC0++5fAcLQS+
         hgHw==
X-Forwarded-Encrypted: i=1; AKwUvBzLuqd1FKAJTS09jPv52ZwEvQqHE8pmlCm2oSH5vuq5hvtiDPbls2bsXwHo1gAYzSPLD6km2GU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKiWtNh6chMs+J2Bn6wpXUypoXJQ3DblZ1VUnl/unT932b18E07
	sDPGEHhv0tVNZluhNg9Q0EujCXV6vmsF1MxGxftUOIuIb94Sfn2hSqw=
X-Gm-Gg: AYBFou3FCcvUy/xcpTJvKJ6b0CIc4WV7grkgZtT2RTCv5McUsJGNZg4toiiFtajT1zH
	8PXlFIpO3aR3BnhCFVxJ+orQEzIPqpS2QaiCfJksz0KnyqcbyibhHseZu4X1DUjm66twPOup+El
	yG5O/Bj3hJGugQXwaUGEokrNWlCBTK370dxb4vOysRQHFFUza8GXNhNywbOdYt8bdZdB2pfFmH7
	VXqsgTMQOQCWMTjpq6hiA6CDnrasIENRKnVMPA3MGmft2RlqqdDVpxHF8sYANiVIbWL2AOl2Nz7
	5/Ba7dMqfSYL7lsqeZNNuLUOZyuUuDPi/KLw1OPgEJAt0R7ae3GeoOlB4BG3TAxKBvNf7vkNeFU
	z0XOhzhpBo+fABXihSv7nTtsyH0Cz3Exo7R1sQZ+PdGlGPbZ8QTDsno7RccVunadVVMk+w/vIAz
	lfXffbJJ1rfLTOnurMgv8tERAsIz5hRpjEnpOBdao=
X-Received: by 2002:a05:600d:1b:b0:4a1:9661:14b7 with SMTP id 5b1f17b1804b1-4a196611b9amr183410535e9.32.1791935015066;
        Tue, 13 Oct 2026 16:43:35 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf35930sm390372155e9.13.2026.10.13.16.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 16:43:31 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: Phil Sutter <phil@nwl.cc>,
	Christian Brauner <brauner@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH nf 0/5] netfilter: pin file with get_file_rcu() before reading f_cred
Date: Tue, 13 Oct 2026 23:43:23 +0000
Message-ID: <20261013234329.2797868-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

Since commit 0ede61d8589cc ("file: convert to SLAB_TYPESAFE_BY_RCU"),
struct file objects can have their slab slot reused while RCU readers
still hold pointers to them.

Five netfilter locations read file->f_cred through a stored sock->file
pointer under RCU without pinning the file. If the slab slot is
reused between the pointer read and the credential dereference, the
check operates on stale or unrelated credential data.

Pin the file with get_file_rcu() and release with fput() on all paths.

Tristan Madani (5):
  netfilter: xt_owner: pin file with get_file_rcu() before reading
    f_cred
  netfilter: nft_meta: pin file with get_file_rcu() before reading
    f_cred
  netfilter: nfnetlink_log: pin file with get_file_rcu() before reading
    f_cred
  netfilter: nfnetlink_queue: pin file with get_file_rcu() before
    reading f_cred
  netfilter: nf_log_syslog: pin file with get_file_rcu() before reading
    f_cred

 net/netfilter/nf_log_syslog.c   | 19 ++++++++++++-------
 net/netfilter/nfnetlink_log.c   | 17 +++++++++++------
 net/netfilter/nfnetlink_queue.c | 17 +++++++++++------
 net/netfilter/nft_meta.c        | 19 ++++++++++++-------
 net/netfilter/xt_owner.c        | 27 +++++++++++++++---------
 5 files changed, 64 insertions(+), 35 deletions(-)

-- 
2.47.3
