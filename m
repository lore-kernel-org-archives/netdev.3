Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792682932;
	b=J9F30EjEHTaeLDtqYxxwZinxbOfSrMt+89aIfAG/CmhXzmzFX2nGMrZgtWTfLMjOcEj3
	 mFuVNzLgY1iXJGdZryES/JYhfXYSPVokNVFnFSUW0ydOAT0aNYP1jr0FO6NOud2Ypyb65
	 tbQTd45PyaqxCUDElPw7z8TUlkXMml8czLQjPssFlSKCinvzkuWSdWuaSwWZ5haxqyja4
	 Yg8UCbgp+lXTHc8B3hiWQmm37xnYq1ETglQ1d2lj5Np9PIzGGrFyIV8pLq8Ej9Nshk7ws
	 JF2IE6EVrLPm4AClzLmgIaGWFkfNtx5rhLcNRpJkW+9KD7Xdi6gmHytHy5PBt/qd4MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682932;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Lsz624Ujxn422+uNKztX7nvwtm9VclLrvyV7Bq0I5Gw=;
	b=HViGoq8ZeoSN5icpMWjZvDhb8BAq4Cbc8xHKsGyP/dJT9iMqFMLf0AbWwgsgFShdGr2v
	 XBHhj3kIhV9aaYVxuEQjzNSpM1/df/Ka3vN+6AYWHd/558YR2rnsLslAJihHWJpV43g85
	 dUmIe51YRZwNLdmV4otrZno5RuX8suiA72US3vQWKR+OnlxmJD1oYOqOMLXxYSggL7B1b
	 sHLoOkfTLF8g3tZt57ESOCX/TCeOJY67kJEhoi+YnAZ5d7tp3hlDSgB+ciCXDMkxEh2iT
	 r9sIAYfVy4a8VSdP/iEJbnVPsrNEha6UOQJTEPLsKAQZTtxuKbVdU2rjCcz05TL+mpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sbDDSkfM;
	arc=none smtp.remote-ip=209.85.222.41
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4682606A31D
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4682606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sbDDSkfM
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-9906c85122cso1133241.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 08:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792682931; x=1793287731; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Lsz624Ujxn422+uNKztX7nvwtm9VclLrvyV7Bq0I5Gw=;
        b=sbDDSkfMPFjewAjCkKKGsasX77WXa6zLs2wfWZ+Nwehy6pHqJCxC3Vmdlyb7SuaFrg
         I8ynLjFmdgvJpodRwepBu1/bZEl1xHZZpqsiEFuOtG+EYFXLGFC9JZRRE+99dWy8HP9F
         LmvOpVVZR8RmRMqrXTzT9Y3nc35TlAlYH5DBUPB6T/Z8kZA8TMDBLbB+shXAJrKZhAjM
         T5RkazZfrMNwI4LwN9fPBTMbSvPa+0LA4N5VAEBT+gHZrDNyWkw0v3nm1Yhym0I9aeVK
         2liYb3DfH1m7r8EyrpMVX6nKwMp9jqAhNYIVHX5KFh6bFdCPnMNsGeh4NYqqhv5gp2zm
         TWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792682931; x=1793287731;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lsz624Ujxn422+uNKztX7nvwtm9VclLrvyV7Bq0I5Gw=;
        b=wt8tsnXrXrYO60QansCnm74oPlgc4V4Z6JmKIbSvf0puipL+1KVItihYjO8nAAqhAu
         ceYjI00/a9QTPnqyeHyR00Q+DLZhGDlnyKOew1aPWqpp7ZpWfXpqEfFEVNWFWZ0dwCCK
         vMHwEstODFH8QAQa3S49YXct5DVFd329OjJ3WyLrRCDgVWGlLfnr/uWiYzbwi2zyR9jS
         27R9bKg11aURuqrVB49dpq7ZmaDO8cNGwJIzJphFufW2DHl2rTJc+N0LvX31nv5eK7Ec
         4E37fSLp9bWmqZdm/pS+37Ijp0l0yWJvy2jXuLBlivuZamsqY8Waa4Xv5vleFJqp6rs4
         HTng==
X-Forwarded-Encrypted: i=1; AKwUvBxRHlP/B69iKZyWTaYHcNM0JWq9sNIFOVkvhRy0I1tHO7eD7/2T5/WUUj7vGDC/dpU7KMvWTe8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKDYSuve1jS/bVM7XYPyh4Yg3LuzXcKM0oBtjbXZ4ISioZ/esh/
	X2OEUFX59QTlfyIq+MVnroGnB+DdIr2kJCUyODlojdriG2fVTlxcjTrp
X-Gm-Gg: AYBFou3t1C1XnFYd8za4eKFwJzwv3UvCpseVXLy3J4M/NAxhg1FTn1Y7tlL5OfpcrK6
	8F29vL0iZMPAyfIh/wldnve6J21C0LA5SaJEvvDBgwCl/LHboANBxyMYo9j/K3wULge1zipw/Ie
	6ymkifktbgWw3K1ep5EjOWwuqLoATfw2NFuSPJF5yaXpf/tPz+WcAK7rn8F4AGlpLWg+M7LtiHw
	hxZHgtRTwQ2hSS4PvufH1vrJNbSvrSViTKURo5F660RvFRybfQTPTkDkbiXywlDqTSIQHn56NrP
	bBa/DXiYXm/EN0oabWxaVrugwPgY+SHRSd27AWN56e61s7ALJX9sVAbxXdoXZAPFJJjQVAZPss/
	qJHIeVDl4KdgWfV5QKIEYUe5x+VO34tes0vp3FGlODSYDgUuZkEcIehry/OzFhCjPyIQc+N5xdB
	/9YcHawBH2GUISe46689/fJLnSvNhoTHK9TOagCbMM+8lHTld+SlHPsPwzCH1YbOloL5L81RyLV
	gN8W263LTb2nD3B+SoHIuULBSnjX9Nq+MIUlgNOMANrCkWSgXyapKO458ARW4RUfP3Gb3XTWJf9
	cp3+wTcwgX9HqOgxTCtNbcrT5bJbJ7CdVJgqnl3BwZ/cPrVyNca8lv1e1lDiURfMUidH3PMYTZ9
	U//aomW/NHCgkKcy0aLk=
X-Received: by 2002:a05:6102:c8f:b0:779:5049:87b2 with SMTP id ada2fe7eead31-7cc9224c48cmr1822423137.0.1792682930603;
        Thu, 22 Oct 2026 08:28:50 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7ccc1e79eb4sm3164137.1.2026.10.22.08.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:28:49 -0700 (PDT)
Date: Thu, 22 Oct 2026 11:28:49 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>
Cc: "security@kernel.org" <security@kernel.org>, 
 "maintainer:NETWORKING [GENERAL" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 "open list:NETWORKING [GENERAL" <netdev@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>
Message-ID: <willemdebruijn.kernel.178cac71d218b@gmail.com>
In-Reply-To: <CAL4WiipTihtytPEPj5cSY+=t9NwRwRTfUQ_efCSWPT7nQ=0K0Q@mail.gmail.com>
References: <BYAPR01MB3830CECF5D0871064C59BA0280662@BYAPR01MB3830.prod.exchangelabs.com>
 <CAL4WiipTihtytPEPj5cSY+=t9NwRwRTfUQ_efCSWPT7nQ=0K0Q@mail.gmail.com>
Subject: Re: ZDI-CAN-33367: New Vulnerability Report
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet wrote:
> Le mer. 21 oct. 2026 =C3=A0 23:47, zdi-disclosures@trendmicro.com
> <zdi-disclosures@trendmicro.com> a =C3=A9crit :
> >
> > ZDI-CAN-33367: Linux Kernel skbuff skb_zerocopy Improper Ownership Ma=
nagement Local Privilege Escalation Vulnerability
> >
> > -- CVSS -----------------------------------------
> >
> > 7.8: AV:L/AC:L/PR:L/UI:N/S:U/C:H/I:H/A:H
> >
> > -- ABSTRACT -------------------------------------
> >
> > Trend Micro's Zero Day Initiative has identified a vulnerability affe=
cting the following products:
> > Linux - Kernel
> >
> > -- VULNERABILITY DETAILS ------------------------
> > * Version Tested:7.3-rc1
> > * Platform Tested:debian trixie
> >
> =

> I had to cut this report. Way too long, I could not see a patch in it.

Right. For future reports: please review the documentation on how to
share such findings:

https://docs.kernel.org/process/security-bugs.html

> We were fortunate to receive a report with a patch from another source
> one week ago. Patch will be available soon.

