Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E242BF002
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782899199; cv=none; b=VyUsJFsQJ/6Q3TxnbO7gSHZi3liuKryN2t0AmTvYoYx0QLpiXA/XPzuEUqztRUPxeZmOQdIO81wydfH01Eoc+HJd9T6A0h3JFUlLLGUvQmf39Y/Lj8tWg3XAIjnM3CnRziunICCB+sp/flCopchQNvLObAk/gFJuwaCmYh8Yrrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782899199; c=relaxed/simple;
	bh=vCoOznSWPURg4yd28otHJD5Hejut/G7m2STloIQAukw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=jRahvhvSiMc27xvhdrEBwPR2GbeO0+A5LI+p+CwNOm7CGuqsvWcPwB7+NrCNuYpGMRMDrheOdXa/y8tVnqpGPivgf/3STgbmfctcNPLGnuRHZhNKOuWqEvO1p2n0eDnQJMXt8OBaxCooMWmCJSlToJlPv/Wfoudi7snyX6a8C+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlCLvuCY; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlCLvuCY"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-471eeac43bfso332524f8f.3
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 02:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782899195; x=1783503995; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bED0bR0Txi9RX1bhktE9AX/5A+umXJPx22u+Dfhnmr0=;
        b=JlCLvuCYi8e7iAxv9dnQd92j/7RoD9UDR+/2s66r3GZFUdseiGrFYNBhY1BMlaEFAN
         cthidkY0nwANt5SGH0pZR4U54EbLPJVGwkYeZzHVcQ5OkSv9MfYaLidcUOQA8cs0XFid
         tdeUzT6roVfVrbzoVYfcWnIUKPbr0ZFUHVFjYjG3nw6Wf1K3VAIzVwDdsf0R5brmfUuU
         nzsTw2dCocIELUmafh3GfJ9Dptw53A0ojpZ5Lg5IZDWzH5ef8a6rLwOQQSh4kMEazmc8
         CzoXDv53dQhHtPkG7mqvaU5rR1OV8QrKsXlb0ItJERUuHvgu04Ow5Qmv4/XjXDGedGHo
         TELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782899195; x=1783503995;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bED0bR0Txi9RX1bhktE9AX/5A+umXJPx22u+Dfhnmr0=;
        b=nRvN9be3g+39LSuUpUBMAoxqTZgfLvsNUiRetRF5vMWvnyW5szR1Ii5R2lSdMaywp7
         0J6b8kva3BRci7HqNvvWQzePCrHZeS0eYlO86JulC3PBCjbAjstAE/IgdpckQxEJzKCW
         CQxqYVrN38BGB+UsXeDn/VY87TGX8fQMfbKMd8adJKxfhlQeSoithrilPIz5+7aCqPdj
         WiDcq0bg/n+uI8xdItiHOKlUXjcAHA5RqvfAxVC3lWHswIs5oqljerd08JfuwV6QfeuQ
         /AwYW1pWm/AiLnp7+yUdVmt/UfcKQGCcNHCDZhk8sPMJ5ZgBC8awIgEvXcZkCxP7FQ3p
         6vtA==
X-Forwarded-Encrypted: i=1; AHgh+RqqFnwOCgV2LA42ft5GAlC7zVbchuCTBzSPw3kCsFaY9EtH/gCwnGxLxaumxRPoH3vfDioHLcs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yythm+CjJCOQJnfwKvaj+Ji2bCMwMhAthlaJ+qMmFjv2XItX8/Z
	C3oirVcIYInFv0bPK/U1DX5H5N2nL3cOWUdHgtHmpes/q2M6yaGOQvLg
X-Gm-Gg: AfdE7cn4/2t55oE3Ms/FxOyDcdbRPMK5qZ90McVcu/y24TNRSGa0qpbVap8xk8hmP7b
	Xec2+TlnicCPWv99ofe5qRqTTvbC9Iwhi0qBVcNqY6WZvtqhPHOQoeuu57Ye+EpgC++jHAQuBrL
	8iBFGQiEtseoXdd2huKzGAbwY/8PU3reU4NbxC+6kEM8buz/h+DjFI9S6vNnj3bop7clqw4LjFx
	0RDM6GUDpLmVNuGnDQY39fKE5Ddmc9CYQC69LUhk6tL3dZ7uP3XGX4aQrvrlpVHQHlmwxxSd7VV
	gNEMLW0z1P7M8453nviJqVaZaG58FQy4PzrGFsXZPBOX1tZnGpCRSk4KqUxp8Sh9oG6rXM/+mxm
	KgafZVzRpKsmDBoYKleffADExtz69V+Ko9xi4WbKscHg5SBBwrkWZBV9CR0dgUwQ1KCdkGWc8Zt
	SW8I2MUuEA4i2FIPbgCsQuCQE=
X-Received: by 2002:a05:6000:2406:b0:45e:f684:7347 with SMTP id ffacd0b85a97d-47757e577f6mr1700597f8f.12.1782899194992;
        Wed, 01 Jul 2026 02:46:34 -0700 (PDT)
Received: from imac ([145.224.90.186])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756636cf1asm16937437f8f.18.2026.07.01.02.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 02:46:34 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  sdf@fomichev.me,  gal@nvidia.com,  jstancek@redhat.com,  ast@fiberby.net
Subject: Re: [PATCH net-next v2 2/2] tools: ynl: pyynl: pull the --family
 resolution logic into the lib
In-Reply-To: <20260701021751.3234681-3-kuba@kernel.org>
Date: Wed, 01 Jul 2026 10:46:27 +0100
Message-ID: <m27bnfcaa4.fsf@gmail.com>
References: <20260701021751.3234681-1-kuba@kernel.org>
	<20260701021751.3234681-3-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> When packaging YNL as a system level utility we added a --family
> argument which auto-resolves the full spec path from a well known
> path in /usr/share. Spelling out full YAML spec files is at this
> point only done in-tree, for example in the selftests which need
> the very latest YAML. But the selftests have their own wrapping
> classes for each family so test authors aren't really bothered
> by having to spell the paths out.
>
> Afford the same ease of use to the Python library users.
> Move the path resolution from the CLI code to the library.
> This simplifies the pyynl use by a lot:
>
>   from pyynl import YnlFamily
>
>   ynl = YnlFamily(family="netdev")
>
> Unless I'm missing a trick, resolving the /usr/share path
> is hard enough for most users to lean towards shelling out
> to ynl CLI with --output-json, which is sad.
>
> The ethtool script can now use family= instead of
> resolving the path (the helpers are removed from cli.py
> so this isn't just a cleanup).
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
