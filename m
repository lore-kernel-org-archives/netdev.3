Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195D23AA4F2
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 10:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814312; cv=none; b=lQxakrz0XdjicEzYwDM5M5btNq5lbfS9119HlwnW9b9EsHYUa2khWm6TqoRNSuMlNF921AHh+ekPVUlbzhxwpOomQGRmCiCykxgAYb0ZIKAlh2ZTsajjBY1DBpwYejrovF2wVg2YuCpN53bYvKWCv7GRsDSHfs5UVJJCWa0x2nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814312; c=relaxed/simple;
	bh=5dora6WCFzNxRZBdHG0qmpjH0itXr5sk7Eu1UjtSJ0A=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=tEf6ac5DG/va1ll2cluqoVZMGdqBvuAS20mU16hJfDF9Yrs8C61h3/mlLpS/St18KOpTF/kOJ/TxGWp3lPdnYa4OFHAbL+h3d7QQb46G8sTflbo2fQEOx5WQspY5JTD66cDgTBIVAylE+sicCy5kRjZTM2Uuk5w6ZdrI7NOjJKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hY9sLC4q; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hY9sLC4q"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6986287534eso3449488a12.3
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 03:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782814309; x=1783419109; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3IGOu/ScQ2NxC7ajyT6AZFfssZtwcd4FkydoQ//jhUI=;
        b=hY9sLC4qW1S86yFyz0HKAw8YosbqjoIl16/2Bq/raK2rA4ntKnN4PVlujea7ZdxvnG
         uuk/bFuHrBI+I3ElppN4bJtuzXGGmrFMbitBoq0Odk51nyBpu4+xikWzAJoVuSDk0B5Z
         Lz+fewtjLGGSBaQn+sr4PwG4Qpl68njyAHxBGmvCThF7qPJ9fo/FAO6wVl5hFzbcRxVA
         GJFJ51/Ljg/vhSs3WK8ZRUIOWh2f/QAmQvALqP78WZrfpkFxIzsKKFVSQJngSE7/tvlE
         //FiooWHPkZq3PuXdnGmH7h4ecj8YgnR5cx5FwJUgkDtuMFqMq7RtR0jDtUrTwFvI21q
         zXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782814309; x=1783419109;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3IGOu/ScQ2NxC7ajyT6AZFfssZtwcd4FkydoQ//jhUI=;
        b=H6m9qML13JQjQxlxyZFiyc+3Vp6iNJkFai/j12hsu85fV27dS1g/UP8stMDY5pWND5
         lVbEUnLf3qKsScVC401bTgFj3wJ5iUA9hCZ3QBcXTpQLeQxIQ3YWlpRFiFTIcB35yf/S
         Mc82nwiO70AIVpsZfMnkZ8cZXxRCVoSOonfDI18uCVuUXZcso7Lal2n7WiCMmi7vgk3q
         AHL9EIW+9Xrlx5jtecxsVeX2hkIyZ32R0Xj5IlK+albZknYjQe8ArdZxhqKbwjTqsqqP
         NMnHV94zU2XkVk9l1wfXwyuWbRlqmOCxGdgTfQ+jZijHkONvO52547plTmyWR0xIxQet
         dTWA==
X-Forwarded-Encrypted: i=1; AHgh+RphF1f6MrjsBDpxtj7K+yZ2Q+DnNHYiruVBDcVfpehsRvdszgewZ7qM9xTYPh11r4AdHuy+I/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3dH/EA/rwqYd1jRMc751oW2jXqRVAkOw5aXaA4ptfKepUXxne
	nLZ8jVVUIEAmeeLGybYfVCKosgqPzS4ZFP97usvwKX71yc4jpWe+Tv8r
X-Gm-Gg: AfdE7cmBZR+DVC2tNSCFz532yb78PCRzg0p2F6/dmgR6cRIN85M0w/quqRIM+2nwluh
	PqdmvU8L9RrFwPjLqczt3CqDiXOHC4w/oPgdtJLTSbnLVZtcOP02MZrjuZ6s/iGFsrd61osX3kJ
	mcF4RsNoGNX/mZ7dWv4ifUwi5UswjjutaJwgRoaVvaTuFziEWv8eefx0IlEMH4xoA2JlJpjQfVP
	gW4xK3qv7bhXdtaTteT0zfGiZhFS9fhRQfs/r3DRUsAbBqsP4NnC7ysBOWMt/UX0iVQq61YejiF
	FQ9SqC3evY/+Ie8BT5LQwfCDS2hQI7+zw6YDRhSHBZ7jHdaN2O35TYkaJnrJZRBkawwnrBdmnCu
	PY9U68G2xYVlffgKRd7VUiuPUqqhxOJeOiRxmSZ3Pc6u2M6JT/XFWA6xf4B0GBisrSuSzm+CdXB
	oBJXrw+Q6nU1SWKO3AMe90toE=
X-Received: by 2002:a17:907:fd89:b0:c12:6632:e7f2 with SMTP id a640c23a62f3a-c12872cd673mr139661866b.42.1782814309129;
        Tue, 30 Jun 2026 03:11:49 -0700 (PDT)
Received: from imac ([145.224.90.186])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1289176ee2sm98664266b.58.2026.06.30.03.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 03:11:48 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  sdf@fomichev.me,  gal@nvidia.com,  jstancek@redhat.com,  ast@fiberby.net
Subject: Re: [PATCH net-next 1/2] tools: ynl: pyynl: re-export the library
 API from the package root
In-Reply-To: <20260630001432.2204298-2-kuba@kernel.org>
Date: Tue, 30 Jun 2026 09:38:17 +0100
Message-ID: <m2o6gsctja.fsf@gmail.com>
References: <20260630001432.2204298-1-kuba@kernel.org>
	<20260630001432.2204298-2-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> The public classes live in pyynl.lib, so users had to spell out
>
>   from pyynl.lib import YnlFamily
>
> which I forget at least once a month. Re-export lib's API from
> the package __init__ so that
>
>   from pyynl import YnlFamily
>
> works as well. I don't think there was a real reason not to do
> this?
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
