Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225A52517AF
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 02:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773195474; cv=none; b=aaptcfjEwf5c5Wfr/lewKKtZlaFLkAelwy6GUsG2IBUa1Ef8gjDkUXYt9LDB/4BBov6qPegL36OvXaWNh7xsGdZZOz3B5+HkycGPj7uc0ujiZq/jD/Vqs0ZMpEHodV0+UvrcReChrceNjf1YSHTyUWG4PcPKT8TdoB8OAsKux4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773195474; c=relaxed/simple;
	bh=CZeHveheAeadX0UEZpxNLvWqoeKOmWKP6TM+p1mI3Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YosOrIUdysWIf5VeGedMcq1TrpvmMjzNanj86yekOtBcbP7onbE25JuKi17rFp8UwLODz84+VqML6AeIy7wjEXZHjM/nglZ/ig1zy4lQvJFyxc+0LmFmP1x9lhK4w3YhH1hlKr7sSE0tzfSPvhytoZ/62wQ67SNBLAQWHeL6xYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmuO4hWA; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmuO4hWA"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2aaed195901so62335955ad.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 19:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773195472; x=1773800272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lNIznmqrMaqnx+se5M0cKItTRTQ1UgUfNOmgMa/FK0s=;
        b=LmuO4hWAcwfWz8/Ktov1da9O3Ya+6U9EQUsMYjaLZbcftzmZ0C2yeACA3SNKAYHgto
         /m/TmJ05ibgidsAVEEPJuVsofhSGwCTgCX362SBMYD+0U6CbpFpN5I21G44HVFW0O+cy
         jQe1fD5ezd260luhEy3qi3KqfaWgCvBZCCWUhKtfi7+mSPgVweU23x7i+Uok64aIn8WQ
         G0aHN1gKcJkd919eN7w+zcdSu28Ur4RW7jnVBBBw5DWludwDvtsqkAzCOhiJZvOwF2tH
         wDEydBoq5ezMt8lSaMInz+E1OZjaTjvWdiswznoyxOATGDxEMUhF9H9YPqIA4aYQeKOQ
         Qw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773195472; x=1773800272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNIznmqrMaqnx+se5M0cKItTRTQ1UgUfNOmgMa/FK0s=;
        b=r56p8e6spKzmRFsBeR9yund3jcNkDjckrIanNu3/Py+wthq35NtUtseYcXMXrP1HzD
         rHWckvqoBX9rgo0ASGhBA4RXHJuebdbw+CtBreHLlWuOxwTWnSj4vCKHNcPyalKu9C/R
         Rcz+dseUXuFaJqqUlmsVQ+NboBOVqLlE0Py1YxgojOiINqhMDH7LLxb90fkTujR/McgQ
         xMkNPxcQjC/2b+EursyGlGxAuqM8N8bVhDpp5lhopeBiSw/01kBX8o9tQpHwHHzo0A//
         9t3eWJlRQ2MAJOzY0fhMwrok6JxaQGWF/NoZx4LYtxY+mpkDem4CAkb6O/lmtMbWedbw
         qnhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr/xq5QQdjBR4f8VXhHP8hbmxmNSMVOKSMv9GdwvWiqzJwLo4RGjgIt7UAjtoDEZHSt/+XJG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVmStKhiSiOhmSCtGpsQKyBm9WdnllFMzfHEOR2f5yy83gKCbC
	SpeLslIsTJjw+trSBciSnbMxWmAoLXwxdI3GviKDcVvMjODKTGd1YIhc
X-Gm-Gg: ATEYQzwRLlMVcan/vxHKFqmYaxAsoCsq4ZabTQVjpW9Kf/x/U7+0zBh2ed4xydgvqvd
	OuEbkNmnaqT98v2V+iKLGG//YZUdA8cGVT/1pP1uYzfl0b3l276FI5Z5RHBMNixoLA424uu6354
	NsupGLE7Nnp4Ix3VSIsl6lIqWelZETLS0UMeaISE2oHaSaQraZJW6HLOwjsynZQskgwP+RQhjtO
	PgtMag3siG2GVs+u1X/FXRBW4SBY82XcObLEVv42HOz4IomeOEWefjW1h31jyIuniO7zyyEV7ha
	etEFk6ziq1gHMI0goByfwRsOGAdRFWQUMb24IpL7TQrhW4zJ/AsX5d43n8BAYOV7AK4UD9HS8aR
	19E4RM9h9m4/EpcLkWsJ3Z1LuAr8BPzqyvPP/trPa9CIWc4FohxtKayzCGFbKh0HZXg7hxwH4Z8
	LRsokFW3LyQOAndQXFJP5CFe5G8L8=
X-Received: by 2002:a17:903:3887:b0:2ae:69d3:5b9f with SMTP id d9443c01a7336-2aeae928e9dmr10936355ad.52.1773195472364;
        Tue, 10 Mar 2026 19:17:52 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae34dff2sm5892155ad.57.2026.03.10.19.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 19:17:51 -0700 (PDT)
Date: Wed, 11 Mar 2026 02:17:46 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, Brendan Jackman <jackmanb@google.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCHv3] selftests: Use ktap helpers for runner.sh
Message-ID: <abDQyvRGhRIsRGaU@fedora>
References: <20260225010833.11301-1-liuhangbin@gmail.com>
 <DGO2DAIFY07Y.367VMZA7XGT4U@google.com>
 <aajisr9n2pInS7jm@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aajisr9n2pInS7jm@fedora>

On Thu, Mar 05, 2026 at 01:56:09AM +0000, Hangbin Liu wrote:
> Hi Shuah,
> 
> Is there anything else I need to do to move this patch forward?

ping

Hangbin
