Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F1F41B8E4
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786809628; cv=none; b=ujSL8GhinPmFDiUIYikgXkJ0CiEkesNojgvrHiXWnKEKZYlkWBPhPQt9wVwbk0K0XI6jik5B5oAnK+touNrI9nNrRDDwCueLoWni1veCiM3GTqoN3jC90O9zDCqHiz5XP9jZnOzALJhJOrWes6yBVVDj/p7qLE4p9gVo5vBXn30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786809628; c=relaxed/simple;
	bh=v/wN7+yK+iPwm/Jfc94PX5pdS4KGMJ5DRX5kYPJt/g0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uVM2/uVB6IrFQ/+S0SWK/jlewFPQjjacBxK53c1c1VS2iDdpcAgsbLqPW8jFPx79OZPWa/kS59mEoBx2RrTHgBn7T4H88K6bvJk9D8p6Wayk48gkCxj+wm4mR2ZXG5tn3pLPR4MqeQmokr3sBrL6q6GO7Yt4KmpQ1XUHQ3uzY1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=bvFRIYXB; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="bvFRIYXB"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so1844622a12.3
        for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 09:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786809626; x=1787414426; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ftPaSkxbWLD6kvx+10Quyg00s27EPnOA14RjV/TlzK8=;
        b=bvFRIYXBcb0h+8UJCf52qfKZHoy6sGG8Z/wL8lTttcLQloVCi4v3UT1DqttokItWmb
         91vymMNmrvPpeU93N/arUsZHMALrGSSrF3SXQaINvzGUYXckn8mS0PHRRiaCvF2d95gH
         kibsyyajPV2XRw5eJxBiWnKb3fHbSqFpj06poa0KMUj7/V2YUQ8HZv1S2JBSSD6tKm9y
         01UIMMu7eyXnGlIf0k8cQrqIgr5COG09utUjb0lsFhOVAoI5eegdFKKw7oaHkHc/FWxN
         hHyOJnos+t6ZkzT/tpUEDFSb6XTmSP0FztdlnbxJ75TKX6DKCuQzJ0H3aCuveSebJqMg
         v6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786809626; x=1787414426;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ftPaSkxbWLD6kvx+10Quyg00s27EPnOA14RjV/TlzK8=;
        b=kRquPDEGHWboX1JpWvytoTWRIsYbJRBFQc6oTPz8LTrWDqc3TzXtmvj1U1dFEvGOFO
         E5CsL5XBElTWEI6fzXsgV/T0foCAUrxP3N7PgpN41VHOFl6SiqE8bGzMaVdSHiewQeAm
         yrNsaYh6eyafS22LmjNBz9jT2cU1iX1YWlaNC/GC932XoY34axnJCEV6iFPJ6dzHefle
         CBwA3hj7WbDT2nzpDSG3YGPb2rZM+KHOuoGkoJhz3kXgEIfmO4A1nkTwsrMQi45a/TsG
         9ChxxeU5bCrC9XfLXFrzOOETrpekGM46w05YdH/lfY0lUgMFZkYLsVF7VdZ5B0dZLTmp
         yhTA==
X-Gm-Message-State: AOJu0YyALdFXhvUxd/vK4ksm7vhMY9HQoVfXY7wGDimd3LX2dATMD2VV
	FBPOZ2VQHDv2rNyFTme0USb8zAJt6m6l0cQpF7/yFll8XrMHOFiuSnIcILtdXbSa3Wk=
X-Gm-Gg: AR+sD11rdPiZQKVXTrMorf6xl9IYHPr2VRqghR6EVgkKVV8mTjdf1iPUBYalUDR8LnO
	k/oNMF5lhXwrcuY3LjeYQKqo3QykAPvtyeV3lQY/0R52673TBi1jS53UxpEP13GzIRrA81BeLVS
	Q3YuLjkQwuvl5zFsT/JUjd5J4I3SkiyqNTWcOEqsEA39kDrJWPHypcNc2IzA87w7r0zsbQVQQGP
	i0LhatGCdTQhtkwEzC3W4ByI/4DKDZwMmohlI+5pnsyleAhRkIiWmaSZoe/hYBJq52DShxF8/WG
	8Sc2I3drn0Tp7lTy62sZUoopg+mYV48dVChwDgB/cF351ogHHn336weEf/jl+ZkbDh/MisPS5Ku
	qL1Hw8q/JThFjOqG+Uf3V0k+8HWOEqlxIMpnRon/JDy7iKwm0xH+YtIY9KLQhkEj6dGRR1+5o/F
	N8D/kE8ftlnPI/GumHZyOJYAkjCk7CmmsVHxg50VhW6n5m0rkq8FWVK3BXRtcMLN1xe9sizj1Iz
	gh2ibmul8X/ATuwFRuen0zCuC/W4w==
X-Received: by 2002:a05:6a20:7d9f:b0:3cc:3d08:da39 with SMTP id adf61e73a8af0-3cc714e62bbmr16342898637.0.1786809626082;
        Sat, 15 Aug 2026 09:00:26 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320e9df03f9sm16934751eec.19.2026.08.15.09.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 09:00:25 -0700 (PDT)
Date: Sat, 15 Aug 2026 09:00:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Jay Vosburgh
 <jv@jvosburgh.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jiale Yao <yaojiale02@163.com>
Subject: Re: [PATCH net] net: do not bond/team netdevices which use ml_priv
Message-ID: <20260815090015.4a518a54@phoenix.local>
In-Reply-To: <20260815153938.187073-1-socketcan@hartkopp.net>
References: <20260815153938.187073-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Aug 2026 17:39:38 +0200
Oliver Hartkopp <socketcan@hartkopp.net> wrote:

> +static inline bool netdev_has_ml_priv(struct net_device *dev)
> +{
> +	return (dev->ml_priv != NULL);
> +}
> +

Minor suggestion: use const and drop unneeded parens

static inline bool netdev_has_ml_priv(const struct net_device *dev)
{
	return dev->ml_priv != NULL;
}

