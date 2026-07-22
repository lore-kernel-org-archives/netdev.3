Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7E2388E61
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 09:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784713228; cv=none; b=l7NSZhLuGk+TWrP3tgWISnEo2dDTQA4qoKvmm4g6b7uFHc83UxfUes/qzDPD3dg96a2CpUnZ4w3eL+/DP8SL8oGdOuuEJDJ9foGF/L9elG4Octf4Lab8l2s/z9TwAoempTZbE1ogh4FClZcS6KvP1rOaBK89N2EXZbaBMJVxhac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784713228; c=relaxed/simple;
	bh=vhci1phfR/gQYv5BdXq+QvipfB5TklR24VhI4iF7TW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WNSjy+CQuHp1W6IIobYrs4E7WFbahw6RbhsFjiRMQLy7GT54XrpoV7E1fnFGChnZALIm1LnIYMfogeI/DHUhVjerWOXND1Wr1HOC2mgihxUYNDSclKC1ni4HX5NHGn+Xr5+VdeOODXH1mukgIPGfaNmI9v7Kez76rER6wm3+7Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=LwGqQnEB; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="LwGqQnEB"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4954d29264cso23056775e9.2
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 02:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1784713224; x=1785318024; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/L6NTVNwGfeSnnznXMeM0W98zdRXLB4Fnd/478hPd70=;
        b=LwGqQnEBs2pgLmXt1p1o9MEjLxTVeGg5quuIiyE9OmVMnjmzu6O4PR51QAUacVLMhv
         zt2jfYqyq3iEB7+7CbiUuPVlSeKNabMGufcoq/phrB/ZoGtlCUUSq8EuGyLtYupXfoRM
         Vis2QS3oCYpQB9N4WdqqMoRIzftVLYdj+UYs4JWaosliJrIWlWfjWckgulaxB3pmHdeO
         msiwAMfJ/c7xWo6KFhiEoRJ8oWDOe2ao3CndNKI7sSMO6E5WJcNGRAtR6stE6zzU6lKB
         PYwB9NwZBCBJo6lBsr6/pKN5dKWIjFSwyrTZIqA65QLhGDoj83q8JbjEOdJoy4i/IuFT
         gGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784713224; x=1785318024;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/L6NTVNwGfeSnnznXMeM0W98zdRXLB4Fnd/478hPd70=;
        b=YqgWmgLDEdyeonAKEbRCvUgKAne+ja/T1L5PD0PYjK8jbnvIj1aRhvCtO0Z87rBdhO
         6rDhdNjiy0ZAYixYchR4yGMCM3xk1RzlFIl+PymIeWUGdMceNtOeQh/ZbPX71AUAiq60
         XPYsLdL7Acc37gR91IPRG5R7QIemJL7bgc/IOwdHUYmxjg7VxaHqCgEgMYPZPhWamMTd
         33Y+u2KXU222+0ITK8I91F40/IKrs2Av0zQYlTvvaSilLejXbnNzs/HKZ6jfYSTpzKRa
         e+oLDyk084jrcP+g1hG2kJTIZjf7FFSH4hHHKRSN5ofAdyXM+8ygUN6aB2mk9U7Q7Hig
         NBHA==
X-Forwarded-Encrypted: i=1; AHgh+RqN54mQo0fLPDhJ6gar/93hHUWIbMBVsH6K+4rkmG1dSUqZ6sgy0Nf+NAqv2ij94p3YMQsqAmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGiYZeqCS3+NdtXjBEQme0b2Ct1YvZh4XlOJje1VM9xWs062Z7
	yW4ZYKGCCsl5qFiHFQnsVuvRo37jXcRuMW0RBipI8kbHIZAOYhr+sNgUZO3tZkxJxdI=
X-Gm-Gg: AR+sD11LkCHOFsZMpAZZKg1sQXL9bpWL3g6n4NdLS5HQp58cea0pGH1Dn0tNrMXMAFq
	eEKCAR9jlVr4WX2uo+H7nK5Vdi/Rnf8uUkn+ByN9xu4G1g/BQ96WFkq8AlyNqL1SNSpeJz7P+ni
	Za8PUvJa5hzurUQ6sdAtkyHs/fpuK9Wa4Z8BD20UkoACCelhENjK9DEwdsqw6z4itudpAJLemBB
	7bVguxzg7eg78W6HYh6wNaMh2hhwBz44ZDw3BBGFeIF3lHj3GQCJivCVufoo9yXSk+y2nYNnFj6
	GlB2NoFxFV8ClqlNelF76Sq8RLYIOiipzXmJRDT9M59AweCauvuXAZXzF6q3wn/uy8rRiXV9/ev
	7mbi/NkJTXilyAdTz+vQEoZXCqokHtix2CjkyG0rDda7MNQPUvcyRjAJp1Epcq5X5e90ZewGIci
	7dVtFEnHpI8oU2l0lUC2CTeXPihrGIui3x
X-Received: by 2002:a05:600c:5489:b0:495:6f6b:2520 with SMTP id 5b1f17b1804b1-4956f6b2525mr4900225e9.18.1784713223876;
        Wed, 22 Jul 2026 02:40:23 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956b03a93csm37801065e9.4.2026.07.22.02.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 02:40:23 -0700 (PDT)
Message-ID: <4c48f12f-abca-4917-a711-7975ea9df235@blackwall.org>
Date: Wed, 22 Jul 2026 12:40:22 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vxlan: mdb: Fix source list corruption on a failed
 replace
Content-Language: en-US, bg
To: James Raphael Tiovalen <jamestiotio@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
Cc: stable@vger.kernel.org, Kees Cook <kees@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, linux-kernel@vger.kernel.org
References: <20260720160428.249356-1-jamestiotio@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260720160428.249356-1-jamestiotio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/07/2026 19:04, James Raphael Tiovalen wrote:
> When replacing the source list of an MDB remote entry, all existing
> sources are first marked for deletion and vxlan_mdb_remote_srcs_add()
> is then called to add the new source list. Sources present in the new
> list have their deletion mark cleared, and any sources left marked
> afterwards are removed.
> 
> If vxlan_mdb_remote_srcs_add() fails partway through, its error path
> deletes all entries on the remote's source list. That rollback is only
> correct for its other caller, vxlan_mdb_remote_add(), where the remote
> was just allocated and the list contains solely entries added during
> the call. On the replace path the list also holds pre-existing sources,
> so a failed replace tears them down together with their (S, G)
> forwarding entries instead of leaving the entry unchanged.
> 
> This is reachable from an existing (*, G) remote. An EXCLUDE filter
> that loses sources starts forwarding traffic that should be blocked,
> while an INCLUDE filter that loses sources drops traffic that should be
> forwarded.
> 
> Mark entries created during the current pass with a new
> VXLAN_SGRP_F_NEW flag. On failure, delete only those entries and clear
> the deletion mark on the pre-existing ones, so a failed replace leaves
> the source list untouched. Retain the flag until the whole operation
> succeeds and then clear it. Also stop vxlan_mdb_remote_src_add() from
> deleting a pre-existing entry it only looked up when adding that
> entry's forwarding entry fails.
> 
> Fixes: a3a48de5eade ("vxlan: mdb: Add MDB control path support")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Raphael Tiovalen <jamestiotio@gmail.com>
> ---
>   drivers/net/vxlan/vxlan_mdb.c | 30 ++++++++++++++++++------------
>   1 file changed, 18 insertions(+), 12 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
