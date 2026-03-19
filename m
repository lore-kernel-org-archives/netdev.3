Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E327A3164BA
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 13:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773927448; cv=none; b=Z24ay8DiQzoW6QwJdr5+f5SFjcZxcp/HzxNb9UpxVa0aO1HG+p4Yzx5upcS9ntfgdfVQY/AdlSrYbdM8I9QstwraWD5aok7Mf9bG86YEb1QTTarSAzjNedXXxskUySEu9bKBCKQdgU6wK3d+2KknX3SGsxRG9HTmnsmCYGXZg9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773927448; c=relaxed/simple;
	bh=cPdIohDR0Q7zRJ6m55ii7YN9S5ciaGmg0kfLHizWxtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LsjEmVgsaNtmTUNs7xwxTQ/7AYlAWSm4/VDxqT5rJWQ3gB28Dme3YPHD/x8qiPgHprqfUl0WGZy0cKumKem4OmISTcardvaWWPp7cMJeE5ZLRzOBg+443d1W3nr7Cs7UrtGSW8vXRVBQd3xlpZZNHv7lKTe2c+i0/oatqfEmY1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZGU7vnk; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZGU7vnk"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8299f1ca894so621598b3a.2
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 06:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773927447; x=1774532247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mj7czIw3HDieWJuIXocUwtMNw0GcfpyRJfd1mQTzkxo=;
        b=RZGU7vnkbnAHvvxzz0bifOPWRQjGVMrY9E6r1nwvQjLa3H5YAVlW60aCimRHzWKUre
         zhuRxFhoFAg54MPLqbDieJZcLPHVO1FZIg1tz8Ei0xV0608Jh7GWwjHL9yzO+3tI37IL
         Bp+fzBpvkfCARARAvaJz5ff1gKD9xALq3xE0aZs7KD8Ma/ngwFaD5rbhx0HQ+cxw2MEb
         I2z/oErTmqKZ27j6vKFdf4x2VU3gs8kOGHWsaxUQ8vwfgC/o09YKWMAGNVybBd2fv4OI
         0OFNlq3BptDpokY2oJxXBlGRDRVad76jjQLYkMGsb73LK68Wqnx4MBrTNQI1d5cEF0NH
         Y3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773927447; x=1774532247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mj7czIw3HDieWJuIXocUwtMNw0GcfpyRJfd1mQTzkxo=;
        b=SU/FLJPH9Fn4AUOVTreKkEeUPreEkCeHLUtdH/zibhVymjiGRZGuUjoa2qCIcKZoqb
         OD7+KfTIO/ODtxTmG1uDmkfdmxExi1qJmmD4JP8pyUn2g27zheKCduLwBTpf1n4C41Gl
         PnARCJ8tmm/2AoSuX1eOr2eyfP6HSzNs0dLKYR0G/D+eZliJSmqde+Fq8bmt/tJ94bN5
         W4nAdzqUyXZq2pvFdBIgELvcjnEVRec2avXcPfhj0CgOfRTudJfwiiOyR1rbQNZGApM2
         iUk2W18K7NNc4rheV9Sf9HKrixuuSc5h4aFc90boXWxNlACd6PQ3A0/luAGjAofbjcPx
         9fqw==
X-Forwarded-Encrypted: i=1; AJvYcCXX6WPgPSJcTtIvtpVU0bqkI6Sfu5uFXGdnBzkDMf6dlUr9CgoRXLz4WEzw1dm3jwd3LVJXMHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ7zLLMajakQHuwtRC5s6mEUlt4Lydsn77yPReJkOGDQ5Ls9Nk
	EloiFY4OuZZLGmKdYrCtATtig8VC0Ma8IibZnvPuvhZ5FxpwcA5fJpOt
X-Gm-Gg: ATEYQzwOQoWIrwwZRkb4O6QO7lKa2KvYNAC4vI+hVEycqEMFAvW7I/6iTgLD0dIkshX
	jS2BR8XS33bVKLFjm88QxpcgwnzoZ+e69bVmJI+XLDaBSRz4RvrPWB5OFin7TkAQOlJZoiEGi2e
	Bkfk4tAeTAsFsNJNyg82qzegQxN3XQ2RqbzJSUlxgHNfKykZO03jsep8m9H3/+QZ5bLyaeSCDKo
	Q3ExAhIqw5Ne3tR9Bn+FlJfMkH9Ix7X7gJkRV2k4KSvxOKfQXGf1RxlVbuDsO7uxX2QrwVwDjvH
	S1TUb+dvMYg+Ouo2cPGHaZ1fmkxacbANsqhtMop5PyZYiUkT3TBCxug6+c9NT+N9TtPXCuvE7Es
	UUQ4Z6eRbhFELDXgpQwsyXsGRIEsOsZ+hAcui0ErtWPOAbwmRo5egU7rq0yU/A4TZhjq36ZlPy2
	Kv5a0AgbLWVHX5gAHBogc1DlgbXOU=
X-Received: by 2002:a05:6a00:4fce:b0:7fb:f87d:a0aa with SMTP id d2e1a72fcca58-82a6ae4b089mr7143017b3a.52.1773927447104;
        Thu, 19 Mar 2026 06:37:27 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbe1af0sm6590376b3a.41.2026.03.19.06.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 06:37:26 -0700 (PDT)
Date: Thu, 19 Mar 2026 13:37:17 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev
Subject: Re: [PATCH net-next v3 0/5] net: centralize master device offload
 feature computation
Message-ID: <abv8DXkR0RtnZJ8P@fedora>
References: <20260316-offload_compute-v3-0-a5d4a07d86d3@gmail.com>
 <337a938c-8a03-43f8-8402-745020185b37@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <337a938c-8a03-43f8-8402-745020185b37@redhat.com>

On Thu, Mar 19, 2026 at 10:52:34AM +0100, Paolo Abeni wrote:
> I'm sorry for the late feedback, but I think the driver cleanup and
> simplification is not worthy the core complexity and the new NDO added.
> 
> The AI reported issue would probably need very non trivial changes to
> both team and bond driver to be addressed.
> 
> Most of the cleanups belong to netdev_compute_master_upper_features()
> introduction in the failover driver. Factoring out that single change
> would be IMHO a better option, if possible.
> 
> The new ndo looks controversial. We already have 2 different ndo at
> __netdev_update_features() time, with slightly different semantic.
> Adding another one feels like a design issue.

Thanks, I will check if we can call netdev_compute_master_upper_features()
in failover driver directly.

Hangbin
