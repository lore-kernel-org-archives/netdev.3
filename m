Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE183BCD17
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 12:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390791; cv=none; b=TCpQyRyJCltQzmKSxFZ7qshnqMl9GZY+Z91MrzPm/0kT9RoQTbOpe7adcPecLvdmIc9CObvCibqJoP2kr7fTDcolCWXDBoBGtQ+NNEXUZmVBFEGHue7iHbXnibCkcaW0n+Q9hjcdEUZ8tED8ddN1qnKuZHOdDQstHK3k5VgQmjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390791; c=relaxed/simple;
	bh=zRGOZLwME3uVs3/LSukmzMmM709P9OpJ9sZ/msp4w6Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=t3LJeSDQ1DjDFflWDlFZBCVrWYxrFTAi5B0cFXrNO3wqIK4yyRTc3KJhP0JYi6QU67IMPj/jn+CoTe/QFctjZG+Tvi3iOvsyigk0xbQwZTfHxGTt9JSOUK1h9EHOo9FrYCREGvVkt+5J8tQIxuDsFXFwC5xpvC6YkY7suE3bhmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvRs+4um; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvRs+4um"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910cc46c8so134773785a.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 05:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789390789; x=1789995589; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zRGOZLwME3uVs3/LSukmzMmM709P9OpJ9sZ/msp4w6Q=;
        b=FvRs+4um54LzYMPhqvJ96gPoPWkHMh9QpGTc2EtxKK3jt7eURJSzbXTjLuXTc/oGWx
         NC+KAVfC/bVFNxssMX9aFBLBV91pAiKyckYmlaypELAstWEMTQ9iCzt78U26TXH/yjC7
         X/gBS6yP2xMGyVkQz041u9nmmJ8c83Mu2+nr+FrXJTYUZ+wsmHWGhXycg3ty5WuOcSpV
         kxOCGulXAdLY+DBFjNsCzr1PVWN7U0aDKpNb9iN7ljGQEitNactNv7RrjxO91cUD6jhU
         jih1o0e+bBEBt+ccSQC92Hu9N76F6n1A+iZFLJeoyYZIdaNemePrgrkhxhP1v+madxw8
         Atfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789390789; x=1789995589;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zRGOZLwME3uVs3/LSukmzMmM709P9OpJ9sZ/msp4w6Q=;
        b=okTeMMckRaaOKOBAZRIZ+d6tdZjqDUT7nzgEfIIt+nspYJKEajE/kPHA/bxB20V56x
         4D76N/BAIMsaoukMYd6yMyXoPaoQs5cxHfsv3vTnBpTQtJ67wUcNUZvV7j9C8GuasjTG
         Jb9D1bmkZBafCiwD2/odoBQZrIpEb6/hOzd7ilnx1zMcrbdZpNTuaR66nErNjYaLmMgf
         zYRiwmr6E8wOaq+xopmviOCgkE1KA6qCk+F3I7b9A4iFffrq1bhDXNB+f63yWPkuaMRV
         Lk3eQ5ehTP0hNXcixWN4J/Q0R/BXOKtFW7sNIU9gEB0RaOxhzgBEd5cBKRZEXJxHppWC
         Ffdw==
X-Gm-Message-State: AFuF++lqjvJ+Om+rXD6bH8zGXoL6ohEjCnZPIdkNwrSdmglggEQxx614
	yIJcMtJ5SGLmP2aAq7z48TaLUBHwKAYGDHOhqCs+NwMiKuGSZTXpzOt/
X-Gm-Gg: AYBFou0vWRiAFRGF+A6knEPGZpwBIio4ea74xFy/1gMcfm69nmboU8pgkcVDc9Lc8Y/
	H3DoKyDfXKQv5qjsXS5N4ynvKp5t9iTCCs8qST2XX3FRcrmHqhmU6FG7tOwnj28TsyUCNHw8xOx
	sH1UW+OHaiVWFuiJo+yn0+YWXcWAnXhD/h6EyqfvwoapwCOvpwljxPinURWXzM+opY5D1s1Pxf/
	wR6x0Qd/npraOHjrpuhQnuP0mWrbVhOJOMAfgZxKkYUL7lJ3AXEefkWryLxoRR5nj7795uP6scy
	3Tjkj/KMo44upyGCANLEaY6/koH/AOF4PAn+sMngktqy0wTtuP2+WWxpQU9Il7DlhhVce0XrxxP
	Y5SvXFhczcNSKulcdIcDKdnsJ8VeJXY72DRzMImKIQ5g+/MLJvShSc4YZj837wvJBWS8EixoHKA
	GBsPuMD90XQBvOjX9zgX5f8PhKofMVKqPgHzurFqgeoNlkrq/SMt7hFI9kk3X3WLbiIkdxTi2iB
	e/X
X-Received: by 2002:a05:620a:170a:b0:939:1864:343e with SMTP id af79cd13be357-93a29a92de9mr317219085a.40.1789390788770;
        Mon, 14 Sep 2026 05:59:48 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939fc4a9455sm776097085a.31.2026.09.14.05.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 05:59:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 08:59:47 -0400
Message-Id: <DLF23FHH1IS2.50ZFYP7679BL@gmail.com>
Cc: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <daniel.zahka@gmail.com>,
 <willemdebruijn.kernel@gmail.com>, <donald.hunter@gmail.com>,
 <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 5/6] selftests: drv-net: psp: factor out
 creating a netkit in the test netns
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Jakub Kicinski" <kuba@kernel.org>, <davem@davemloft.net>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20260912200426.121025-1-kuba@kernel.org>
 <20260912200426.121025-6-kuba@kernel.org>
In-Reply-To: <20260912200426.121025-6-kuba@kernel.org>

On Sat Sep 12, 2026 at 4:04 PM EDT, Jakub Kicinski wrote:
> The netkit removal test builds a disposable netkit pair and moves its
> peer into the test namespace. The next commit needs a second associated
> device there, so move that to a helper. No functional change, other
> than looking the new peer up among all netkit devices rather than the
> two the environment created, which is what makes it reusable.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
