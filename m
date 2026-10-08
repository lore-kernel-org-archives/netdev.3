Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E2126ED4F
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 01:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791422596; cv=none; b=k2SGZcZlir2TDKRhxtNeR8yIB6Aqkyo8i8t4yWYyPRrPHSZh1/JiH1jEabx31MivE/DlBHD0Wx0KBtZIrg2KYw5gZobEP9Ng25KOi7pGTrgnhGLVfkbkbn61NmHE/FAthKhb3Jaguro2d0wRU12er4IDv+A2AlL7vPd0rZuCsZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791422596; c=relaxed/simple;
	bh=Y8rdUhJtNv+lemmpSnXA/4ojm70xPc3itzkj1+R66X4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etejfxg5dBAH+1ynN4qPfTNNKlEMMwwYkBa3Zbv4qVJAbjyDrrnrHZku20lGxUWqkNOIOIZ8ncLbErETMzDDedgrNUfONi4mBVUBt5ccCzoR+/feFZBFyRBZuNiWshIxh4VgSpwaXfdnx126Hv6RNqFDJKnzpuABe/oOz6gaTzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=NCJ8ea64; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="NCJ8ea64"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6cfed5dd071so1658585eaf.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 18:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791422594; x=1792027394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3gdEfELDQOn2l6TNFqzsXxFT3tZf6RoNraBFM8rA2Fg=;
        b=NCJ8ea647BvqnQ+tubQ8RvtxaaNBLAjeusgJPGAnoNzYvxfnO9d1EXLTZZbhpDvz6Z
         dWLl3MCnov30cKeCFBwxKy9MAqMW6qiDOAfHKf47BJ8iR1TQOdpMYb5brbNVnc9RrxTt
         UgYc2WkaUdCtFDygPz8xJEVnrF5caOXSKfiC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791422594; x=1792027394;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3gdEfELDQOn2l6TNFqzsXxFT3tZf6RoNraBFM8rA2Fg=;
        b=qzTJMMySUwUQO9rwu3B2iiY5a+85/5QtQHswGtZ2pwjhpVmGp9UU03Em/dTjrKfdMK
         sN4YtMPTahY+SlC9XDdVj+T0bIdF0ALIxzLwP4HaoPpx3TL1o8Iscrsm0YssgytBDuS/
         Ka0lmqDeVz4CrDI1GDuMkSqgh76wf46QZXfzpnUpoCeasr0W0ETE8A0M2smM3rhBN4hV
         p+nfBQ176jc6SCXvQ3sZ6sdL3UUWo6efD/ObPNQSq7ft+QLxRFfN38FwpC4O3tUDM7uZ
         3x4ql/3QU447zdyvSwR6PTd7zvBXU4UGprbfJzC9kK7xlqurNVNxo2NjH57EHGXhha1M
         kbWw==
X-Gm-Message-State: AFuF++mRFURH1GRHk4enkjNbu3FcBbnvJx/qiLiYcZ7jMW3NETeBPdY8
	ur2zl41BO+JGFtzTtl5/4fNdJ5wIjMiTbCwDyMBRQ1Qia2fuCQe5lmVJAx8yZfr8sVw=
X-Gm-Gg: AYBFou0ZjOgrf7CJRoP0KoByjxlEL09/O1N39Vpb2zJMCFlJVPPV4WECdIJlsA9l8v3
	E8vilLqjQ5pFtQy02rLyLICogdR76mHxy89OxN9DZH7XgRlasfbm/sv40zWC29Ov8dxOzt1JNqM
	9yMfoL+Oi8lqDKiXUQvk3hTT8qX++QqwJqsK/BhULGOYEiZrm+3fpJAf4KrOs9sjs7bY2U5Oivp
	GqH6oGrXn+2R033JY45r221UwwtiPIdb2s4eqKGvB7HrQ+4+1RsSmFGegL12ULD/iCJZX1vlHXA
	5wwuigiFOEI9mMHiK5WL4+FERemxx3LHvL8CKBJ4RM43BROD5cFzaYNYs/4btJLE5FfrvYMX3DN
	ZGw+lIayDUdYquU6xc52iDHPd2Eh9PIUUzgqdB4onOCMBy50a0NqOYLCSJ3YFFINchtr8G933wt
	lKQclH427O3DAf5pkdcgqEd4oqyw1XazcrqXqfyX6EOXNDayMRQIJn478PXgIET5owe1VfBergX
	ZlDxrEEUhRE8pyY6uEVWbc3n/r7KlmroBoa/yL9a7eYbsryewlcxxMcHy8U0sYW
X-Received: by 2002:a05:6820:1694:b0:6e0:fb60:d5c1 with SMTP id 006d021491bc7-6e7a4b20318mr3832032eaf.11.1791422593892;
        Wed, 07 Oct 2026 18:23:13 -0700 (PDT)
Received: from com-75606 ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a274b7ca62sm1945452fac.9.2026.10.07.18.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 18:23:13 -0700 (PDT)
Date: Wed, 7 Oct 2026 18:23:10 -0700
From: Kyle Zeng <kylebot@openai.com>
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, outbounddisclosures@openai.com
Subject: Re: [PATCH net v2] netlink: avoid hashing the network namespace
 pointer
Message-ID: <asbwfr5yXmeOQ-hT@com-75606>
References: <20261008011359.63727-2-kylebot@openai.com>
 <179142234633.2527009.9314976849845433713@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179142234633.2527009.9314976849845433713@kernel.org>

On Thu, Oct 08, 2026 at 01:19:06AM +0000, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

I have a PoC for this issue, the symptom of the issue is kernel
information leak.

Best,
Kyle
