Received: from mail-wr2-f19.google.com (mail-wr2-f19.google.com [74.125.225.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9844A9D4D
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 08:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719633; cv=none; b=tzGqdtjX1KqO9Q31UwCFZdhDHp9tYAGMi9LcR7YyoVQ9RXGHL9KdMxtxGf5KScRcpCvksJHiabYUXqSOhNwlGpJg5yKSKshTaBxcjD+E7pFWQu44W8wzRKk9OFUg6FJvxId6aBIjna02iGR2OyhIPX7ZZNe3NJdXFl0fO7+/njo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719633; c=relaxed/simple;
	bh=kLk/qXepwU+Sdk80TMQeIbWMJ2U8WIHPfybN4YV+JME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jp2bLE5hRngpSG9y4xb4sYAURgtWMW55X/hMFaoXvujHyDxR6QlgqFhfPA3wR40SmPWsYjV+5eNS7OA+gsdkFvrMWjLtn2o++fuKfprXL++Z0G0kfepupe67W1RdlGK4HJqjWQRl12u2N/0osUPQHnawsXfpNZZHCBIpTB/hMlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=GfZhkueG; arc=none smtp.client-ip=74.125.225.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="GfZhkueG"
Received: by mail-wr2-f19.google.com with SMTP id ffacd0b85a97d-48583cc7ab1so190942f8f.2
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 01:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1789719629; x=1790324429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kLk/qXepwU+Sdk80TMQeIbWMJ2U8WIHPfybN4YV+JME=;
        b=GfZhkueG67ji7CUb0Rfltx208ZVE+73rhV67eFSK58cn0I5oYNQ4nXdy+WeM25JB9X
         3pIItIIWfGqLRQCJulU9NCd8I/lgoAFp45CVR+5kET/WhYB8SQiuhbJWqzGL9/6TfAxn
         JM1iSHyIILuMVYKwjDYmRqhyRNJMwhtX4zt6pF51fySAdlcx8BiPK5lxiIzvffiq/m7E
         4ZZ4lVLBBjAEyZDWEefLquUF8rgAuZ4SPSyeTKpoPwJEJIY+jOujjfJeg9XzPXRJyzLy
         lFjzK7YrO02G4TuvrQa8jZQaIlJRHkrrNvtUSRSCmpt+NfxU7U1K8pkWFzz42EQstIun
         F9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789719629; x=1790324429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kLk/qXepwU+Sdk80TMQeIbWMJ2U8WIHPfybN4YV+JME=;
        b=LEIbJwVRCXsQyjZGN8EMb4GpM1RJS1A7Jc4b95xBSVSBZyF1WJ9vSqybnAjUiuOOjZ
         DsRIdL8ujSBg9BQY8q5WnlUexILqGXGkaCse1l9Ajj6B+278+bnnrGAvdhbyKw62ffVj
         ++pgxvd6v8TV856QTyq48N62DyDys9QiTzQwooVSsqDDRP0WtB7246iuJUBFNyatAo6H
         NjEobUKJXafOYI6cNqgUql88brJEa98xp2+rkz2gdWmeOnoO0WqJ10njpC338PAq9B8o
         b921GrkOjSov52tC+rdKR5dCtN3xAn+QXxyv9A96Rbfbv3J6N+sZHKLHxFQcW6WlYpC6
         cPLw==
X-Gm-Message-State: AFuF++nt8dOuzHNSpwNnRl8CK5dgGJ46EQ3n0dA/Y+9pWhueUJ3a0S7p
	hqc+9cyTtd0WhPQncdWe2c+r6MmIjtMQS+SmxnRM9Ksp3iwd8HgTz7pbq3txvcMgXv4=
X-Gm-Gg: AYBFou0K7bD47X+et728JArAnysflFz+Vw+/1gwpg3jDzSJfWF6PsKZ0B32ouo4o1HI
	Bp7yw2cU4suRqv67u69FXxQ6ywahgGp7uSk5DX+lkKWMT/pEYaxoiVdULUKXcRlLOMV9AWUb5P5
	h+cLLdyFiSFOOGlYXq53/gIAThZZ35tKp1f5nxC7rTwBq8OD0+DkqsPbnpg4EpqIBv6ngdVbrFB
	1lnRcO19j/6qcLk9KPQPIB4T8QgsVenEK26HFWLG8AAU9b+bvdIRGzA9Smtzgnb2kfhgnO8MNJ7
	eKGmg0cpj+9fBVJMNKE2OmS549kufUDbYo7e0E900faSjbiM1LuxLntA5uMAngiqsAGpBR+ajoj
	A3SxGrEOeImPhd21dntcNVFnkL150jrjVgM2seC/t9+JcBv0wYNhhPzGe3mqhxgRkKI8PqXq86N
	Qb1szr5Xjv6Jq/18EENyqTpnh2Cd9Rk74oYkqpZ+EVDZQwv5E0og==
X-Received: by 2002:a05:6000:603:b0:487:41c:515b with SMTP id ffacd0b85a97d-4871e25e2a9mr2371051f8f.30.1789719629172;
        Fri, 18 Sep 2026 01:20:29 -0700 (PDT)
Received: from remote-01 ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4871ff56905sm2152472f8f.20.2026.09.18.01.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 01:20:28 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: andrew@lunn.ch
Cc: netdev@vger.kernel.org,
	chester.a.unal@arinc9.com,
	daniel@makrotopia.org,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	gerg@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v2 1/2] net: dsa: mt7530: fix NULL dereference on unbind of MT7531 and MT7621
Date: Fri, 18 Sep 2026 11:20:23 +0300
Message-ID: <20260918082024.2697569-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <857a7395-4741-4d2c-abb0-b806e8f9bd78@lunn.ch>
References: <20260918015020.2518315-1-f@lex.la> <20260918015020.2518315-2-f@lex.la> <857a7395-4741-4d2c-abb0-b806e8f9bd78@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Did you consider using devm_regulator_get_enable()?

No. Looking at it now, it is the better shape, but not for this patch.

Two things stop it from being a swap. The driver sets the voltages before
it enables, 1.0 V on core and 3.3 V on io, and get_enable returns an int,
so no handle is left for regulator_set_voltage(). On the BPI-R2, which is
also the example in the binding, both supplies are MT6323 regulators with
a range, vpa 0.5 to 3.65 V and vemc3v3 3.0 to 3.3 V, so those calls are
not decoration. The other is placement: the get is in probe and the enable
is in mt7530_setup(), which DSA calls much later and which resets the chip
on the next lines, so get_enable would bring the rails up at a different
point.

It is still worth doing, for a reason this patch deliberately leaves
alone. mt7530_remove() disables the supplies before
mt7530_remove_common() calls dsa_unregister_switch(), which still writes
switch registers over MDIO, so on a board where those rails really drop
the teardown is talking to a switch that is already off. A devres disable
runs after .remove returns and would fix that too.

So I would keep this one as the NULL check with a Fixes tag, and send the
conversion to net-next, where the voltage handling and the power-up
ordering can be argued on their own.
