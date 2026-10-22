Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660447;
	b=iPRivtShVLMPgqJZVdpS5wnMXoq8KopenC05yMgv20Fv+z7UT/wjQns+/ppWAva8w2be
	 VwLZc0I0Jg1j/7/d//iotE7tSGumvk/CJ1mk+GFXs3JdbYeY1IZfwn4/eF/CPorEoJD53
	 t2XmkZ2QfTaCSBrL7kCMVkkLsHa7aq/S3edmnT/4tnBYiXtOdXQM3wD0V994PLh51CrNK
	 MlwXu2VXANbTiLqzif9dVqkbI/ntbPlJrckzL+s2Pf7ivNP6Uc/neBem+SNBfrmQ7/07O
	 QdjwlHHRvNQKt9215Opgv1PC5IfO3LRDBpkM6HJWXm3MrEfDEYbYwuliQKO07pLROAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660447;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+9oT4imqO89h7CVLXvxpremnNC03kOCP6LBQBAbm8aQ=;
	b=JtNlVGDgVcbBxhzet39GbiEi2c798YB9tzhPHNPyJBLN6+UkvDbpk5/Pa3aUupOI7U8l
	 tTmiMq7N4VWFtNXQ7nML0mkHq7O2LJBbYnySg9v27LMD34ASTMJShNUtw6UYpCW/r8rzK
	 G4KiHZV9pK6tia0INZ9Zf9CHrSlATqskRBdTC1uX9Gra9IDJLKSWCf6KhUAUr+4ccam1A
	 UI0mSOhCfNRsxW7n0DM11D5Gv07XryUWZ59dSit3G4LxNOmjXv6Ij6BYma37hcub8l22+
	 lTbf+P+3nSvzVRJfEhOwq8vQ7bVIDijrR3cymABzMveI8DSxxQFdmAEOMTresAkokZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CbS8nk9f;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DF9606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33DF9606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CbS8nk9f
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35f1f76ea84so2359521eec.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660446; x=1793265246; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+9oT4imqO89h7CVLXvxpremnNC03kOCP6LBQBAbm8aQ=;
        b=CbS8nk9fkQttCIGca4DgbM3jNHnogueW7r8s22CgeBshvtIgS8J3/0zXYw2a2XRJem
         g2aDx72b/vDDre35lOA1+TwKVoJRtP531DHwhNl/UqNLZKoZJp7L2oR8QMbZZ8RAmecc
         9J0z+0Mk5bgDyK7hm6+Fye2lnOBIYTa20yfUe3yV/vc6yGm6yZvCyFcvh3y1+PBgHFEN
         UmThTWLK96bgkLScd/z2yAJm0EEHv6XyrKZnqFvvOjrE7K0ziDahnV6ijp+cXwl3aJMS
         gYGZwZVHLM5EUQ2YLpI3P6XciI9ktWelTHeUyLYZ2Ty4Xkm28X2mwQKI3YX2QjJ16A8h
         hLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660446; x=1793265246;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+9oT4imqO89h7CVLXvxpremnNC03kOCP6LBQBAbm8aQ=;
        b=gAOukkHdL3Hglvyt05oWQZtwbO53WK2/qseSRBp/D+FerJvA/Eqanf8/eMl2eEzN32
         XB5cgMTecse1Le3h+KbTZM+6j/cYDuw183SHct8WD0iudzCF5Cnp258kafeD6RqABwTr
         Uv6Fqdmme9uJOIgj0SaIvTwKx8p7jSLtskF0U7PPRwdMQL4B1dduMK8QHyjlfX9SNamX
         QB+YzhFMdJsxdqdB+VEo4+KCgkRbJvTlnFEFj5Pi/ABq64V1sLdD+R8f7QTK9gcjWEnn
         PqqLMKW8BrP2ta8Tlw6Kz5AuEu0aYAoNIwTG+t9aasJ/FLvhGkMU+84mBdp33nnPoYFO
         Gc8A==
X-Forwarded-Encrypted: i=1; AKwUvByYAchdSV/Dn7URzoUSNl8XrKEzaq6MkMB2SpqsfHKyPtFSirXPrr6FwNjdDoRcsQW/9/zAa2o=@vger.kernel.org
X-Gm-Message-State: AFq9FYIoY+m3n+RtdcvcXsCmdS8987/lJYrrrNUpJsn03ABDIrSaECMA
	xDE61k/B/e10OI9tgHT9QCwsfPDyFSMF7yI/t2AV0BvKYHkupABXLQl/O6I+zXUZ
X-Gm-Gg: AYBFou3Ufns+Qs/bOM+7lxqTysgGZpsus+JhuLeNmIeRMOo+fAdRJv+Jk6vcEX3ICZA
	UHYJ3qosevcheYx6GhEGe9Q9vA+aSQLj5BQLVVwcGhtsOWFKN7yK2rxiReS2CKm55LvxgAeL+U6
	/KSYVv0JVoft64mu1SqJ0pPMaHrHIgh+9j1yfOztlmYC1HHRh2uqLkRcFf8ntj0vvU1pydf7QGv
	ZwrLMGJguoUB4ylCt3UbjJdmNvjLfofs24KiCsp9Wa45NFnZuc1Dd5r06tgS/TLZMXlqXHiGDy9
	aB2UNQQiHYKyLefElDqLf8jn37YNsnIHT23HT2wVweO2ldD9aEB340giOga5AuY1JmR6cdCVsQo
	QWTEA+tFOj04fJrDzNsDSMNrgm34cAVQTiVUKxpsmYAnXhnrxgtQ9BJoeWNJtrDPJeaCzKJakyv
	a5h1rIU3OagwkDHJIQpJTXX38Kdna3Jxv2L+JOAZS+uZ6ZBS/xZOGeHtODV/Derj3kqd/FbyEZj
	iIYgPFZv4t0PdpnCTZge5eGY/akavF/6VLk2jN5wWnTtJ/bNMd4WBGSahXaYAuo5pcXKhy5IyGE
	iM3Pk8zwWh8l/gOlLYg=
X-Received: by 2002:a05:7300:6c85:b0:35f:5591:e40c with SMTP id 5a478bee46e88-3674de4ca70mr9773380eec.22.1792660446301;
        Thu, 22 Oct 2026 02:14:06 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-368ca914bb8sm5375478eec.5.2026.10.22.02.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:14:05 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] net: tun: flow update can repopulate a purged detached queue
Date: Thu, 22 Oct 2026 02:13:58 -0700
Message-Id: <20261022091358.3649925-1-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

tun_get_user() checks !tfile->detached before entering its receive RCU
section, but calls tun_flow_update() after leaving that section.  Queue
detach can complete between those points.  Detach's synchronize_net()
does not cover the hash computation made before the RCU section or the
flow insertion made after RCU unlock.

The late write therefore installs a flow entry with the detached
queue's queue_index after detach has already purged flow entries for
that queue.  A matching TX can then steer to a detached or out-of-range
queue.

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1.  A two-stage GDB condition
observed both:

  detach completed its flow purge
  tfile->detached == tun
  tun_flow_update() still ran
  queue_index=2, numqueues=2

The later TX produced:

  tun0 selects TX queue 2, but real number of TX queues is 2

The condition was hit in two independent runs and is distinct from the
purge off-by-one in candidate BR-018/027: even a complete purge can be
followed by this stale insertion.

The detached state and the flow update need to be covered by the same
ordering rule.  One option is to perform the flow lookup/update while
the receive RCU protection still guarantees that detach cannot pass its
synchronize_net(), then avoid using a detached tfile after unlock.

I found no matching upstream fix.

The reproducer, GDB script, and full logs are available on request.

This was found with a multi-agent workflow; the TOCTOU
was observed under QEMU/KVM.

Thanks,
Cheng Yongkang
