Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B2B4314A1
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 12:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785240243; cv=none; b=XMs1z7WQP3hnha51yDwdzfTyK5y+K8SSRMhDdMnSibQmSMf577pEizqcj6COt9DQP4b0NJcW+cXlmTD7yoe7xXfhplEcvm9zWX2mCuW0Aqfi7hbxWBSLaEaTXJoHxRLItlQ7jTJc6jqDTcPIHOnpARKpyECTVczmOvFOH3e95Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785240243; c=relaxed/simple;
	bh=g6/c+EKUL2SGHJ97wfaYzD9GPIjjBr/+l8/eHiAhzj4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dp7dBcLk2jKNhxrIeZPExnnVj4mHUcKwoH9pXloO2ksxqu/4Hr2qujvDXZZUXlUzcy+OlX/jovu+jFDV0lgyPzxA80Jpv6jTlQ76/cXrdEQZg/597UfFVw9ZK/+PBwvN6P5D0SSWi34+Vj43Cm5OtaOZaNbvHO4THgO/f9/bKpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pMxouaRv; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMxouaRv"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-81ed000b507so30090477b3.0
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 05:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785240241; x=1785845041; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CmfAUOdwLOmKw27VR0K4jf/V5QopWzuQt6dYD8ToR9A=;
        b=pMxouaRv0oN0LAiHdgDt8CikSfPdTbei+gBiHUcukKbB3gXLeh/cJtIcrfl0GZkKpL
         +p31Alne9UQrPvKTVk+/b5aTD3WDflANiKSVYM+G6IJA1K+0OYFd8EdGNfd9+jYtmaA8
         sdlgUXx+m3YkiB2+D82rrQVtdjrRzn+uf7pfdmEUUUUKNlGx3e3ZkD12vYf904RdhoIi
         Vv9W1lqVEnVV2kIGtIFuBh4RLQ43RZg62ezx4qWoZgJQyEwd/NZwLyZpZwBqoZvoj+Ui
         Xra53nhhjMKZWiqMi2RXqr6E+AkO////SVFD5syD/MEbW2fnKvzqXTIGlmIhKtzNDVH4
         lo8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785240241; x=1785845041;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CmfAUOdwLOmKw27VR0K4jf/V5QopWzuQt6dYD8ToR9A=;
        b=OIUPrW/nzFpD4rIxDlocjobizirD3/ExYv65qwxDjD6EoHgtLlo+K1kzl6dQAJY9EZ
         1CDcy/gUUQv8cs0yCPRGn9myjG5lc4WFeE5bPUYyQ2my54EZmbeIAmvvbTFeMkCbAAjL
         hmZ0yi9S59TcBSK50RXrD3guNRZ7hcXj/U103HvwI7ho5fRqtJUXAY4gN5xdKxsf14WC
         QYIWhBfY5SJ4u9xckJbqqvkVCczUNI6vBFPWKZHKZOMUQ9ixGqaduy1VryfwqmJ3dCW3
         wR2suHedbcUI0Rzr3mnoejC44g+0SugQa67m5YOl0wbJqJ4gcilhhd7o4Gv889JoR6bz
         GTiw==
X-Gm-Message-State: AOJu0YzX09GXL38uvGM/7lUPQf+cbmHTcxo2SXYtyxuBBDX97wqJWeND
	BjfYXxA9BRntligf5PKncWnNy4x6RCOsaYvhWPu5iM1U+zT7w5EvoNo+
X-Gm-Gg: AR+sD12iOlrv7heCB42bTAovo+XI1L2cn+aVy10EEztSznMS3maAJ7kf07rG96ByRNH
	emPqrzAzOgGdf8g57A/IK7xxusAR4p8jtluY9IVjAhH78ndEEwDZOb37yfg60WG2uXNnQMW12Kq
	CXpOxbhGcvJVq1sMWiUcxrMAw6jf6im96ejKzDAijLn+wnhmvoa0iD+Oy4fNCYVqG1S8wcUmY9D
	NpGhT62Y1cAsB0k+MmEiHsOU2uTctn6Xyl4vVwMHj3LSNcW+oqKoUDLDcaZ1efjBlp3NSO7/98a
	egsQ9jkazFsx2Zh4wGVEEFa3Wq2G3DeqZEoUDEmQLv2aNP20jKShy2Ja+T9tiUuVEtoAYBRqRuP
	gkvtP7+z9TrZEymlgVBW/v48NioWewIhbCHWdlHLEbJZaVXYvNgsx+u22CygOXs76pCf83MzOXP
	fQpCo3ENZagAJek+MrvLQlcxJTpgmTfy+1R00mHR1NHjIg9BNCVQ==
X-Received: by 2002:a05:690c:4883:b0:812:996f:176f with SMTP id 00721157ae682-81f9908e6afmr7486657b3.11.1785240240949;
        Tue, 28 Jul 2026 05:04:00 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f65770064sm44935227b3.10.2026.07.28.05.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 05:04:00 -0700 (PDT)
Date: Tue, 28 Jul 2026 08:03:59 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 andrew@lunn.ch, 
 mohsin.bashr@gmail.com, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.22b293f13e4ee@gmail.com>
In-Reply-To: <20260727165759.092b3bd6@kernel.org>
References: <20260726202902.760552-1-willemdebruijn.kernel@gmail.com>
 <20260727165759.092b3bd6@kernel.org>
Subject: Re: [PATCH net-next v3 0/7] hardware pacing offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Sun, 26 Jul 2026 16:28:44 -0400 Willem de Bruijn wrote:
> > Enable safe hardware pacing offload on a first device (idpf), plus support.
> > 
> > - Add ethtool support for admin control over the device feature
> > - Add device support to the idpf driver
> > 
> > Besides the main feature, also
> > 
> > - Small optimization to FQ offload: avoid unnecessary ktime_.._get().
> > - Expand so_txtime drv-net test with hw offload testcases.
> > - Expand pktgen with txtime feature.
> 
> I'm not gonna spam the list but Clashiko has a bunch of legit-looking
> comments.

Thanks. That's a long list. Will review and revise accordingly.
