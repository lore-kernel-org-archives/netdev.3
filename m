Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3345424B28
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 09:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781861637; cv=none; b=KWzSA6OGNFfbvt7p6sHX0j0GbN5ALXYnByNvH+mh3LVzwLdzIG3VpMB+VvsHbxYed3sPmZM26TQBGTaD/EHmMIyE+RCIIQ+ALpRmqCwNPzL0yu0Fy41VEm3iVIW6XKB3fopGiejDjOMPsag04jywHx7yTprv0D2WCiD9wFHrqO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781861637; c=relaxed/simple;
	bh=FwuoAY6HzfJ0FzCdMdS9cZpeQAWJhJAkarN81wPyVJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IHF0D6TjlcwPSOv4VKVlLh5yiZWPS+g9IJbRbG04BHSjhcSWcpKetoKNVOsNhjdl/k+CkzyFcoqjWRUqw1BmcYRUjY+T/AKs7kdsLN69P8qwlIvBhOQXNEU70n5qum7MlueH1CeBFcvj8iSZxFI/Pm2m5Bb6iOEU/iQSMDew9Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=J8f8s31j; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="J8f8s31j"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-46214219a18so319266f8f.0
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 02:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1781861634; x=1782466434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=12xf/Szl0P/rXX8258BMfV9P+pbbiVTjxZs4H9XX4F0=;
        b=J8f8s31juJiJJDTTjeEts5pnKjEqxj90DhxsJfSu3kalsHHCkR3pBWepdUQ1hqi8Uk
         yTiAqzeiloypZXxq+iBlR4SqVXXgpjZeBb74Adns9BZv4pTS7B36e4TojywOafQMW/XV
         KFH0d2EnWEGLp8spRaUeLHyWbOe0V0/bwHGUI7zEPnoFBcfJlueLFbKoZS10nAV58609
         szV4cIW9vMgG95XobU49a/LBaEyn53vZ35KDquq4//ao+ePM/AOFZJqWyCzQoy42nCO8
         MtczupwCdLi0f7p6B/dq3Dh1q7xRmGBht4cpvJYW9VBfBt7pjmaS6fWP6sdzdXTbyJHG
         5zOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781861634; x=1782466434;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12xf/Szl0P/rXX8258BMfV9P+pbbiVTjxZs4H9XX4F0=;
        b=g+9R+YBluTOWhqgPjIrHSzPbMZvZ7hP0q9mvk92YRiwWWZUOMF4OSi7vQA6Pb+XGh8
         nsleRbrDdlDXWwTT9tizUChqpTor8EEDrfS3xeCFz+LBzk1PY/WViWUtZFrZemsmBirl
         XZsS0MWG3D3FaFXF3F5mYlgmawqJhuqpvIuy0yJQ9ZYxuwzP8Z51pSDVczt7eIy8/PZm
         uLY2N9bWg2LLTsXU9ULLoTwysvLLCzI1nVAHqqGG2nvgpg0SXAawK3s+vZsnvEh05n6W
         La7UFz9kuOXOPrIOqKIWyFSv9iVAn0B7rpQ423tV2MipD8cIpRdFFlMA0JImuH6BqQXm
         NR4g==
X-Forwarded-Encrypted: i=1; AFNElJ/mt5Gek4Aa/dDM6LHdIQKKIJrjkmUY7RoN9g9G389Ibr9xTea7pYi4+BRevRhM8M80jwqi93A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwORoJ4XTJcsUgK4XeNADJM+pvkja3iZKHx3Np/zcJs4cnmIXb5
	dCUj2AJu+Kk++OfPsA4IKWSnH9AD04TVZwmN/6FrK9hsQUX0N8bwR3cTkP7bIq0aL/A=
X-Gm-Gg: AfdE7cl/6909dCu8Dk1wOP4SscfwbMxzuy7SvWH7rsZDF7oslTKLOjaLJ/0/Un3fggZ
	IRQulf+C0jvG4nvnd40MeHT6y/KcIVNObSX6oT/cMYn/W+WhMtIe4TQqugf/Ul32eg4L83cNIOK
	H3MPOqHoDociE7Uzoza+/SVmChQgJob0yphAdLhKHQ4ZNnzEJo3zAXl9AbtWgUM+Z3/tb4c+/wA
	pkjrAu2mZHhNkQG0x5Rd4DUIjEwudRkPISnU+hS6YVBDn3iqIQFsIlLbcKdIaNTI6jQ4Z+VhAQZ
	lC2r4o2/pbH/UPyODpefhf06umfc/76dk+AErVPQvdsdFNEO0qj0x6lCLwsfO3tHCYxqIjhw6or
	rvYnPl2bM/9mtCKIncNbh29mEjUKZMnJc9d8l3kHtGlPbNP6XGfpzHKccjGpSgV6SzpDZOLZ5v6
	LEI+gFLkjum/SZAERjmcHNiiI3ZrgsIL0jFvvKWedBVsF4zNZUhGZIY2r5U94s1mXj0Q==
X-Received: by 2002:a05:6000:4691:b0:465:767a:39fd with SMTP id ffacd0b85a97d-465767a3b3cmr830884f8f.3.1781861634414;
        Fri, 19 Jun 2026 02:33:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46508a04c15sm6616227f8f.3.2026.06.19.02.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 02:33:54 -0700 (PDT)
Message-ID: <a195341a-4678-46d0-b84d-50c2365e01ef@6wind.com>
Date: Fri, 19 Jun 2026 11:33:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net 1/6] ipv6: fix error handling in disable_ipv6 sysctl
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: shemminger@vyatta.com, dforster@brocade.com, gospo@cumulusnetworks.com,
 ddutt@cumulusnetworks.com, brian.haley@hp.com, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, idosch@nvidia.com, dsahern@kernel.org
References: <20260618162225.4588-1-fmancera@suse.de>
 <20260618162225.4588-2-fmancera@suse.de>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260618162225.4588-2-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 18/06/2026 à 18:22, Fernando Fernandez Mancera a écrit :
> When writing to the disable_ipv6 sysctl, if proc_dointvec() fails to
> parse the input, it returns a negative error code. The current
> implementation is overwriting that error for write operations.
> 
> This results in a silent failure, it returns a successful write although
> the configuration was not modified at all. When modifying the "all"
> variant it can also modify the configuration of existing interfaces to
> the wrong value.
> 
> Fix this by checking the return value of proc_dointvec() and returning
> early on failure.
> 
> Fixes: 56d417b12e57 ("IPv6: Add 'autoconf' and 'disable_ipv6' module parameters")
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
