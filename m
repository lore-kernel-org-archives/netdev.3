Received: from mail-pz2-f25.google.com (mail-pz2-f25.google.com [74.125.228.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4332E49E5D0
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789143234; cv=none; b=Q63ys73h6/yU/LTORDhIBtCps0pE1N1O4XIp4AMk37TK6MgX/gOn2tvLx2q3oWdbcD07XJFqcxYsPNVwuuFlud6T6ZBCOvXtJEChOE2tHrsmPmtpJjOZGv+lg8NG1xBr43N+seFjKM0/j0Gl1R0tLSKqfX8qpu5iSiAwWOc4/7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789143234; c=relaxed/simple;
	bh=bmYaliVJ6Mt6CLyYZbjzfxCm1ptbiVVTw8opHMA46Qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFfdD7LxWDwQ5lLKJQLCUcfjz4G6PMO3fatrGJ6XGQ5G0xSaJET1fwpbboMyeiDUxk+3541UBbjz7eZkFr/tpQFvbw77lk3bWjozfHvaB4jMISI9NAClv3Gn3cH9+oxiOMVt7VFJwjmlrAw9BYEdEfgqgPiZ3quNqrD2AfcPWFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFs2KJYQ; arc=none smtp.client-ip=74.125.228.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFs2KJYQ"
Received: by mail-pz2-f25.google.com with SMTP id 41be03b00d2f7-cc1cebad4aeso125803a12.2
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 09:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789143232; x=1789748032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bmYaliVJ6Mt6CLyYZbjzfxCm1ptbiVVTw8opHMA46Qw=;
        b=dFs2KJYQEuQ9xcS47fQrts0IDhTPYRGAK7dcX/fk86TxlWWWomeVl3zP+RKafRr1AM
         iv6P2+lEYnUFUdbNswoj9AaBVRhSR/ij5J6MAD7vF2kY2/+fvR72UJuz3SGbQJdAHRE2
         bL5gAtbfyA6fyd5DH0KkaS2CkYGlqeNMLW+W03FalbLN41mkmtOUmjOSqxXoKSUZu0zo
         IhOUsPmHwvjqZiE2AqfX1FEkC4cS6I4TVRDpvv4NSSVALO6oPo6Zv0m2oar4pIMdU/+O
         eukPbd3Dt9DB+8n+2aaPdhHvh2FW6H9HzG4jGPCz67dXHIbroCzI/5poy0hl5lVtRDnd
         9Nuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789143232; x=1789748032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bmYaliVJ6Mt6CLyYZbjzfxCm1ptbiVVTw8opHMA46Qw=;
        b=qOaeWynBrUGLL1syRrC4Cg0z6s6DEwvrXMPka0Ndr+VRhhQ2Nf2o+KMjFwSdROoT6S
         e0GfD7c9lNebikDqn2ksa9B9Hm/K+JYhkaz32TuxICEylw2Z4vVPGhqy3JHSYuxIwHl+
         2yqEbNFNtQX4J0Y8om3R/8igC+py9ehrViJ83d/acQ0fOwku6wmAETLONM3CWvHDlL37
         HgPvT//T7AkDJZJypdUrH0LNq+AxCB/Hzeybsw7GbEeRhKwz6YRAtkLMx5PQWgrtPzIE
         wZe7msALWKSlCcxZcc5jeUG3TimUTZ6VSk5PxKY6zRsXUjTq03JtR5HWF0nVaYhYMPQ/
         ADEw==
X-Gm-Message-State: AFuF++lGaM+lsPliJ82LvEW7ljbRS4jb3kFHL9ax1c8MkvNVu38dc3m0
	gB8c3m84GeCHiqoLWXgUHpIxtWwvwsDFDqjNup5qktlruHjLWsZe98qw
X-Gm-Gg: AYBFou0BTabiefB5/7nS/cNYK4Sa0QBapq99wDLo+Y5VZDC+paUAETSekH2kkBPV3A3
	stbu3Ng4DXxqxx6xNX3gcKu9707BAtO0msbqwg29vJYchFg6pzfHmUHiOfwv/ZeHyM1dmFQpQ9t
	DmheAvNZC8MLP71WLyxlIhPFvj+YE8hVFocYrFP/rz+svYlaOT35UPonFj5ens/4SB/7Yg4islD
	bAQbnw4sLaMmZYpODaOwgST1hdCLc56z3WjnU3jK9BGBXV8ImzM+Zk2avyjT0rFGZXs64+RmQ1t
	rB0+dpFk7mVXej/ze4bCW6uuqHzrmwOiyZNBoX2QM9VLXR+FP1emaqMgpDKtrWcCrpgjAonz52V
	o+kRfs1ZSHPM3Pa06OB53/+3uZTZQPG49oVT+wvNuBiuNw0Ijv7ApvfCvwo0I0iCvx47YyRFY3X
	DXt7umfEYWGIm2cpH4R+iVgyXOjC44EUTUL5cv36xX/uJayr87YIrqTrzA23JNG+VpgiN3yvx2a
	t4=
X-Received: by 2002:a05:6a20:d807:b0:3a0:bc61:62e6 with SMTP id adf61e73a8af0-3daed15f5b6mr10192696637.8.1789143232189;
        Fri, 11 Sep 2026 09:13:52 -0700 (PDT)
Received: from bloom.localdomain ([2604:3d09:178e:e100::3820])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c6528fb9sm1408473a12.10.2026.09.11.09.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 09:13:51 -0700 (PDT)
From: Ivy Lopez <skunkolee@gmail.com>
To: edumazet@google.com
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	achender@kernel.org,
	rds-devel@oss.oracle.com,
	Ivy Lopez <skunkolee@gmail.com>
Subject: Re: [PATCH net] net: skbuff: do not leave stale header offsets after pskb_carve()
Date: Fri, 11 Sep 2026 10:13:42 -0600
Message-ID: <20260911161342.26629-1-skunkolee@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911114922.621937-1-edumazet@google.com>
References: <20260911114922.621937-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LGTM.

Reviewed-by: Ivy Lopez <skunkolee@gmail.com>
