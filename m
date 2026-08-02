Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABBB327C08
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 18:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785696603; cv=none; b=sxieV4zLmL+TuGLJ+5Pit35ST24cQ9HRGo8uTXpy22bqwXJxSWOJ8AvKs/kUFW0rG/FzhxHv+39rG9x1JrT9Yr0GQ3HIcfsgxjjdpWMMXqP88T6Qtt9D5QiIQTa3ms9bPB0ptb6tGugYcNCVBsHrdB+q72N32nn4RBtGg3TmUqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785696603; c=relaxed/simple;
	bh=L0svd3D0foAbS1pofZ2kwhRgyX0xQSmgHu3dPZH+i4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDOQ582aS1nlUEAdzhoptfEvNzyB2dmWDjxZmkHhzAj/Cfi65/ltmN7Iv9H/Ezcg9pINCsCgw8Sl2v6wpE11tlPLEbg+mbdsacwXT+ZfhDzOQfjhEhVz5oGGB0zcmQQAfaRIkZLcYMsdj61JZg+inmQuWfYfvSHMQAl3ZYYbQdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZoQwcz27; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoQwcz27"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66892c81725so3451693d50.2
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 11:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785696601; x=1786301401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JCOGXAiY1okgWD9P7MgJLnCxWDi+bKHeP2QdjRB5Ehg=;
        b=ZoQwcz27h5BjI7NgFB8M4mPyMqp7hxnpgbn6h/Ian3SYRBW9T92qmsln5UaLXUgWR4
         Davj5R+ogiBvNa7w61t/Bh5agyeX4h4E9TMBA5XwpWrGEnsNekU+VhEiIqDX4osxx3th
         XNFp5gqWWADvP0JaWNizOtjFc5A9twdGboRfHxWQMHQ3aJLpV0VIs2RG7gKE2qNwdBNF
         jQnriCmJAXJQ1nFSNlmMWnfvPAh75sN6F5s0c0mM229nIy1pzOloGk40yQs5wQtx/L05
         oSRD+bnZgE41KHgs7UF/tZDN5N9vxaEez1Yai2X0Q+y2JJ3uzzemYaafWVtCThIgoL37
         RBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785696601; x=1786301401;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JCOGXAiY1okgWD9P7MgJLnCxWDi+bKHeP2QdjRB5Ehg=;
        b=PLkuo/FAbcvyV4g8KA/G9McwTud0bBErQfWWRuxtZ3VbeGekbcI9HIdAvSixHAZTm6
         +iSFLTPyhg3qA8sTs6jfOdy+fpLdDirxl8OkRn9T/EjS6/cDA5tSUQlU54A8ducprU/z
         cnE6l9kLTTUtZ6uBca20yqFnOslwlX4zkAT0nDQnPKIdgs4f9yjUsVxXY8TJWJ4+jtIZ
         O2ZOwFsjel7WnWhBEnFCfbxriU93+yAM5dLxoykIK2e0VBfvD6aFDImPYmfQamRkG6N7
         RfbcUsEvSLldHU7HYIBPKZS8IZWA4xLP7X6AuyO7ybFZ8mIVjQQDIkFGVE4vsUArsTNe
         Hvgg==
X-Gm-Message-State: AOJu0YyBH4INF1ISWcaKH5x7PvkWCKANI0N+iqTTQRzObcWDouwhFcOC
	AJTKtL+0FIaTG29NqaV7cFVNHM5UcMCI+Rt3LVJrRzm5uhXaUTAeIQOY
X-Gm-Gg: AR+sD11OS/Xywsg0BKszoP0jPy5IvCisboBjB0yO8X8aXs8mIR4nhI7Nz1t32+5P3Pm
	BfFWyyjUfPYZ9j64ebExMQSmmW6jqXFACm9KPK7xvvZHa2n8/MrO+A8gBJ/kIaLy68j/xN1x5j+
	OxOQQz2ZLYdBzoG6OU28WYv5pjmxPBjy+fwSVgx7UDRbLuXEvFZc1WPrvID9L500WB3PQ99nj95
	/1A/2tixf5a6zjin2fBSHaraNqVJ751B6E63MegW27tYg/53obYTlzJ51NO/oGB0J+zGIKfwUpU
	60Ozm3O+cl3C/ptRi+itfGIXqNlGrxpHipEs0Qyg9QCIs58MEjv5ZpqcOYgEJHVxBiEkFmxRljv
	/UyXNI8pYedWC0KpSe+ZyvPBTBSVSQqWnS/yXQnqqCObJf+nrnhEZL5XEWCHe47GdyqqVLdyydJ
	HGlISGmbtzMeudCxETVZwoOrlxMiwTlykfQFdotWqyd7fgnh/o/P13osIAFDi46d0nc+lcBRE/t
	X7igko=
X-Received: by 2002:a53:b711:0:b0:662:89c8:4a62 with SMTP id 956f58d0204a3-6694f095b5fmr6981875d50.18.1785696600981;
        Sun, 02 Aug 2026 11:50:00 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6e:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66948fcb3acsm4247511d50.10.2026.08.02.11.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 11:50:00 -0700 (PDT)
Date: Sun, 2 Aug 2026 11:49:57 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Deep Shah <deepshah146@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v3 2/2] selftests: ptp: add a regression test
 for the frequency adjustment overflow
Message-ID: <am-RVacT-dbrIiJ1@hoboy.vegasvil.org>
References: <20260801222923.39017-1-deepshah146@gmail.com>
 <20260801222923.39017-3-deepshah146@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801222923.39017-3-deepshah146@gmail.com>

On Sat, Aug 01, 2026 at 10:29:23PM +0000, Deep Shah wrote:
> testptp's -f option stores the requested adjustment as an int ppb and
> converts it to scaled ppm, so it cannot express the 64-bit scaled-ppm
> values needed to overflow scaled_ppm_to_ppb() and bypass the max_adj
> check enforced by ptp_clock_adjtime().
> 
> Add a small test that crafts struct timex.freq directly and verifies that
> an overflowing frequency adjustment is rejected with -ERANGE.  The test
> skips when no frequency-adjustable PTP device is available.
> 
> Signed-off-by: Deep Shah <deepshah146@gmail.com>

Acked-by: Richard Cochran <richardcochran@gmail.com>
