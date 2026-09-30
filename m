Received: from mail-pj2-f37.google.com (mail-pj2-f37.google.com [74.125.227.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C2646D570
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 20:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798497; cv=none; b=LrhDd0D2rQT6Um+ZtLj80BFAJbuqg3vs54+bf6umvlEBmTF0KYGhuL4HVWnfT3NAo+JZKlV0dbVQfjTqeKeDL4hsVGkLjpDJ8MFxgb55Px9SRdCC+r8/wrNZCEOrkKwyqMvJDaovmbqRSeQfKtZC+dJ7ZA+VaymvG96ko+4NI4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798497; c=relaxed/simple;
	bh=dfmbAABZOBNzKBzZGaNTByGahqCTy+OziV7PoeK5W7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PthxKA9iLmncalXcO/mJg0XqOewVOwl5eW55UWnGmWl3cLw4wiL7zNzDHXlMCkeXZptJp5Fu2jr2Qc2ifiQHtGsQA6QYv3lMMMrgHk7OAXKw88Jcg2mJjHiGz2K+ie+6/asDn71UYshnYIk5HQ5ez/Sl3CQv7PO4VkWf4M3jSyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=Nu+5xh1n; arc=none smtp.client-ip=74.125.227.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="Nu+5xh1n"
Received: by mail-pj2-f37.google.com with SMTP id d9443c01a7336-2e300fa47a5so928645ad.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 13:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1790798495; x=1791403295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dfmbAABZOBNzKBzZGaNTByGahqCTy+OziV7PoeK5W7U=;
        b=Nu+5xh1nNEd8lMVfFu62Cr3LPm5A+bg0oZZDTs2UVyvG8wnZgPjcFk3WU4rXlsQ43z
         H3c1+Hq6cWVkrPD2PedMd/F9zbXdXTHKchgL/wevRDCSNtRdQ6DyVDfSBLO0M4FKFR7q
         /rX9En961diAkyZL+qkUR/YeYW83qpTfZ+oBLzoKk/Uv+pxTJ4BaD6m/jHQewKODhzTx
         PKv45wjHT21QzoSmCfzCSbbUXz/6mNI1JsYTSFsPyCowSJwYbb2BDvQrk/xr/wxRD9Y+
         NOm9pfMNz/Yj+Bj2Jb9+4tk4eXP6gp8/jji9YatFc03x1gmhRfQBD8kDDIhBccnR0p/5
         A/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790798495; x=1791403295;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dfmbAABZOBNzKBzZGaNTByGahqCTy+OziV7PoeK5W7U=;
        b=edhQWcuwKI9UHx9vgD08fkWRAYwGI5lpAA+ZmuqwkwLI5Hq+r3yOAGdfcJFCbs4VI5
         1kiGGeuzsmMs54zdnylJiUc5mJBH1SH4SM1RYSDOeUpPMfSxhVCuJZ4y1+0oNXR8SGxM
         +9aOmAhf0Y+vWfjvsc/eS1rNoYg4hD6QYuwq9/VnTAZ4Fuwx5BwrhJLgD5vMzy4i8RuV
         u2555beug/TedUf0NU1P7j7ZtLeSak/4Jl1zKygBugbz5kHZO3+ket/WfLbUhdBlgbEE
         okMFQVgsAvbrPmDlVUHYy6q+X6Wz/kmXjFkDuVyLEDoCyq52pJ2Dp8acfGVbBh7xb3lv
         qXHg==
X-Gm-Message-State: AFq9FYK4Huity0LQ+lzIW66IwoVoXPVXMNQrhvKRtcmqBONZX2ggC6To
	FZWlQ1Ty0YpJt51QZnfg3Vtf0KnO3fOcFQ/xyxHhm1NDO+JAidLYSjal3oSyxtbw5Zs=
X-Gm-Gg: AYBFou3xla5MRmEE+ajzuaJoJLbuNpsTvj1PIeMDFYPNSirWxsItxd0U0+58leUpJHh
	Lao1Hl3N0Xwfn83a/JcBAToAnOMm5TPONjmBeOSzmoSIMTpwqNMBrx1jDxVeeWSk/W/OWB3CmHN
	IphMk5Qz7Xb3bQH7JYnnZhhwM96ClGnipP+3loOOolqpz0TiogQP4RebnARwq+1yx8Zlm/WwK+p
	tRjURanNFlk6RWXMU0645RP5KDA+2mAjuVvB5LGl7riILk8GfCUYvtBZyzZZqBSrDgeZD7nhMTS
	7UhA1gIPQDgcevi0eqPJ9ItEAOxGs9XyFexrwyCObQmG8szDsgdrDWbUSz1VnqPIizbaxEK881U
	EpnTatd0V2YjtRH/q6u0MwIyjheeDeKF4GmzTO3Ygfn/c1yXtDb2yn0eV5D3v/RYD1fP6ShZCJk
	MeJ0mF15Q9PRShiBGGpK9wZvd7eVtgRtxK5cfdHfA6U7GYMdfEnG4k85A5SZ3e/AX5g3xu9gY03
	iRexFFx/YTJpo/MRPCPPRA=
X-Received: by 2002:a17:902:f78e:b0:2dd:ad74:ac2c with SMTP id d9443c01a7336-2e2e4a24efemr20316165ad.30.1790798495635;
        Wed, 30 Sep 2026 13:01:35 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e300b6f9d3sm1812355ad.75.2026.09.30.13.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 13:01:34 -0700 (PDT)
Date: Wed, 30 Sep 2026 13:01:33 -0700
From: Joe Damato <joe@dama.to>
To: Zhang Yunfei <zhangyunfei1@kylinos.cn>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, aleksandr.loktionov@intel.com,
	u.kleine-koenig@baylibre.com, weirongguang@kylinos.cn,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	leitao@debian.org
Subject: Re: [PATCH net v3 0/2] net: ngbe: fix error handling in resume and
 open paths
Message-ID: <ar1qnabXsHMZQBVk@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Zhang Yunfei <zhangyunfei1@kylinos.cn>, netdev@vger.kernel.org,
	jiawenwu@trustnetic.com, mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, aleksandr.loktionov@intel.com,
	u.kleine-koenig@baylibre.com, weirongguang@kylinos.cn,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	leitao@debian.org
References: <20260930094748.1198085-1-zhangyunfei1@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930094748.1198085-1-zhangyunfei1@kylinos.cn>

On Wed, Sep 30, 2026 at 05:47:46PM +0800, Zhang Yunfei wrote:
> Two error-handling fixes for the ngbe PM/open paths.

[...]

whole series feels very AI-y but from my reading of the proposed patches they
seem reasonable, hence my tags.

idk if these failure modes are real enough to be fixes or not though.
