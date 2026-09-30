Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E084CC26B
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 22:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790807253; cv=none; b=Xowb/ksuCQ+RLgdvEh/fvhbr5JrhxHS2TgHbd2ueaM8brL4vOTuLQ++14iDTZxPGf0rTJ1TQyxQuv2fgEF2cRqJvyXLx+MJlV6WcH1e+cKmBPGd7Egwu3pDrAvODHgPMizlQbZs/J2zj9iTDoHQ1w4XARz8LIKz6LHPOglWMDlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790807253; c=relaxed/simple;
	bh=jju1N8zT9e2tyYTiQp3P1ITPo8JhtLK+vJE2fDFLE3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VH4u70kXM7qixjDJodiCnV0jnB1gx+oLfzEHkJLFGkW1E8cL/MJ+cduIixIiwYDv5GQOmDwqkAl88f9EjLaldkCd47i7byVHDRf+OsI4Hl11usGKb2zc9CK0HD6Lq/uaR6Gj4X6VVwle1jZ93NE4xYDq2Pv8nKXE1JgYFVR/6m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=DeA1gcsv; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="DeA1gcsv"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48b08452cafso126742f8f.3
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 15:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1790807249; x=1791412049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jju1N8zT9e2tyYTiQp3P1ITPo8JhtLK+vJE2fDFLE3w=;
        b=DeA1gcsvixRktiaPUgmMLMzjw5Y26CcIP3JCfsTxCzu/TV5PnQWcXGwUri3Rm5avmj
         r3EjAuPFfWFAnYVUnnK1+0jSirfIzJg1MFGJ07m248DTQfvuil1nMcVLbe86eMKop32f
         CTg9plt5hPV9jJM3i79sAxB/HtL4944TEXXA09R752yPY74W/CsSwRMHdPFlWU1sfznQ
         CtQfWC7gYoD5m+gLc98oE3saUfGIo+hFD2Uqr0gp9Rsw/4zzGMSGBnGYDMpX+uZTaXjA
         IxIiXZm2j8cjhWb/jctGeRoch1LxwVPiTRV7JL5Tw842fzohXD04DIeyMjmf2SsVdJWs
         o46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790807249; x=1791412049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jju1N8zT9e2tyYTiQp3P1ITPo8JhtLK+vJE2fDFLE3w=;
        b=MxV6HDk7MegzYjl1zQC4LD2vdauPaM7xlAvI59XJ3cMsDAPcAaatR8st6zhumDWm+M
         eJRnbl8lmYbQewDql10/pALQL/6JEP5soXWJPYBYxZg9489OFqdO6fVNq7+wd9T+z7Td
         pL5ymzTSWs9B8nIgKWUvDGjXz3+Y1+1USXBfwUkLNtpMG6tkphQ3ur0onbm3NmPgX3lM
         FYtNz/XnSqK8h/B9j8Ppnqx41TGEK9y8H+6sRpczV4QXT85TzuSqH5pJseK/JWplz8cY
         9jf46wYrUkCU1BaNe68lOd29AdiHcvTsTQOZNI3zzYl4o53FLNsXkY9rtFGhaSCeGMjb
         oJHg==
X-Forwarded-Encrypted: i=1; AKwUvBwlqG8ova3A0fDTeO6TwG6WllnIoJjrl54DATzCl57Ex+ut9eH7l7gq8/381LRihCsDdK7I6QE=@vger.kernel.org
X-Gm-Message-State: AFq9FYK2tZkGYHdbdlXRluUHDOaPboyCrxyju5xeFXNsWcX+Gu/b7Dd+
	VrK94NwijFeE6mdAkYKAw4y8YPp4RwhptwwJCZmH+m4quWmwts46pO0UZd12037VXjY=
X-Gm-Gg: AYBFou0x03ijc7XNwTxjNefLUQnf3KhSrfY64hc4JxTVw4Y+NslUH42OsN24ZgRQqbD
	3OQwYIaHd8r9xLzjCDeKOWWVT+BciPa8Ya3jBh7940OnLo/Zzcw5Ko/8dU8hbElqJ/71Wt6PoNC
	2gunwyNq6Pek0SH1LexdNDtWoXDER8U29DiaUAI9UnQKVXSy5Nkqoj6s99vnMlKIDNZjlUtZJds
	O/++8QMDgfITockuAny29m/hrmZEkqumWW8b4vpjqKAuwA9kYCjEdt+GgkkFzGTFCuXwkhDm92k
	0q5jR/eEg4XF17beimwfeib9H3BWnTYeDBUtIKsgeKAhAS1FDVJTCEVdn/RwH/L47XurGHH7x9D
	L78my2+//vF6brEAcy7LjnB1sxLTw3Q1wfcOoPlk6DxHRms0DFz4TK2qsaZdfHbso9XPB1Nz7DA
	5yOugIAqEuTEmTVxCdIjiPJWr2t7bec6MAnE1sbbuKE9KI15fsk9fRg88D1olrt2P2xLSeQV68u
	B1Zg9OCVXVlrcg+c6zUGAyrk6r8/hIyOfnT0A41rs1SPVZOUY8mzoaxNCB027dXeXq+TkoJ3dnd
	u6k8
X-Received: by 2002:a5d:5f92:0:b0:484:3314:eff6 with SMTP id ffacd0b85a97d-48b02525dc7mr5136306f8f.28.1790807248617;
        Wed, 30 Sep 2026 15:27:28 -0700 (PDT)
Received: from localhost.localdomain ([197.51.54.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b068ff891sm1997599f8f.9.2026.09.30.15.27.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Sep 2026 15:27:27 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: netdev-bot+sinfo@kernel.org
Cc: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] amt: do not offer software GSO on the amt device
Date: Thu,  1 Oct 2026 01:26:51 +0300
Message-ID: <20260930222700.45470-1-omar@blockcast.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <179061959167.31693.11895969550331516671@kernel.org>
References: <20260928181554.85766-1-omar@blockcast.net> <179061959167.31693.11895969550331516671@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Found by code inspection: an LLM-assisted review of drivers/net/amt.c
while I was working on an IPv6 outer transport for amt.

It has not been triggered. I have no reproducer, and I have not seen
it in production or in testing; it comes from reading the code. The
path is a GSO skb, for example from a UDP_SEGMENT sender or a GRO
merged UDP flow, that is routed to a relay's amt device: it reaches
amt_dev_xmit() unsegmented because the device offers
NETIF_F_GSO_SOFTWARE, and the outer UDP layer later segments each
per-tunnel copy at the inner gso_size.

Testing: W=1 build with CONFIG_IPV6=y and =n, and
tools/testing/selftests/net/amt.sh passes with the patch applied, but
amt.sh never sends a GSO skb, so nothing exercises the changed path.
