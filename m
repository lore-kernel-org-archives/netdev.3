Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6F7188CC9
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 00:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786409026; cv=none; b=N3FR7XmcycTMDZiog9G1rQryJ3HIPX2AjUVrmzCMIxWIYS8L/Sf4fpzpNidRPmLt2PCnTLBPz6x4Nv70KmrOqej7oQ1m0r6LH/D42L5T0rnvv6VSMtSQu2UOT/VegRc6OKqXRkozIri5NOtoI9OFUXTkExBSyKHpWS391xPikaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786409026; c=relaxed/simple;
	bh=m9teEkOYL07/MrN8rozfLG4mzvc0S6Y6kfKQkdxg7nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYan5wCrGYlsHiQO4HNydSm2yelEMiUn3/3ErKXJw4rss3MvI+v4x+6TdCvV4QNAHv3tHGh/s6rmf1lQyVmWFWGX8lI7M8GCV2bTD3WFTKPcY6Pk6t4jaW+JucYgUvhYLrSxV7ErVk+2UOmEWV+qBsTUV9ymDtlnzJ1b164uIB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZWBULfv; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZWBULfv"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84847482584so335275b3a.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 17:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786409025; x=1787013825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WrNRObEeDTVY+FFBiTLb2qyobZv01j9eyLE5NI7gMx8=;
        b=JZWBULfvtlZU2WE3dJj862ctoTUc14PyEeMMmQ0m0sA4qgwKpNZ2WDSnwMtvvkm1ac
         20Q67GR7EZLYaxAL5MDt3LLd3+0TdzCCPaCjNWyzu6I5jDWPtS/xFwtM3BCf80/V4L+E
         TTA/1s60e9i1gOGmmyPhwjlUrBk1wp800pbkM3VZUPlsE+THELB0XRX4B+Xvm5/Y1h6A
         O8WEN8RvXuFldyFBacYaHNFOHxfkQW6zl0dmx0wZvNDupogCPS0HUGJMAren9jD/1W6z
         hokHj6L2yldZhQEnjagu4OjtmIKgktiV193VL8rvk0DvoGwXbjM09ex1kZDxUoOyddmT
         DnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786409025; x=1787013825;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WrNRObEeDTVY+FFBiTLb2qyobZv01j9eyLE5NI7gMx8=;
        b=YhO1T2J8CW90OrKU6hDxFOcgVgLmRMJkRkgLm8LjxfgWVFrYvHaD1Q3319QGDnd/o/
         KqGwd5x7E+vaI2TYu6m8yJGs1K/E1cZRk6oMYXDSlnU+yGW/qtn0q82pd/CVAQWTjYOM
         9Woal03DqiNxGWDrHg52avdOeScmjXrRU6v2fcpNP6ntfKUpcaMFTgD6FO/8eWzU8L26
         vQjzId776k/dv7oykI2UNTAzO3wLTjU8QKaxR0tnoP2hZB8IhzfGfy7NaU7mz45YS51u
         FO2wVF6NhMPbEyQXmNIqlrIArnYNb717uqV59NorsZxBrhM5GaSzDvdDCbPOsfcUss/x
         IgCg==
X-Forwarded-Encrypted: i=1; AHgh+Rq1lYVVoLvfGSVuxNFr8O7cPO5FHaj5sogRvNlRsPcomWdKmxzxNJhjhm1vNelXnlQabKB0nKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvre33AiUyqMTJ8io0lDxamf7eV/ltO2/KSkJuRKo3Jt+dByqI
	XmFrc1h2RlVl2TqzUqT+rgr0rRU4KPp6wF/slQqRumxAbZKmKseJtWIQ
X-Gm-Gg: AR+sD134FFghvzPCNKTOUg9+3rU/ZXaCmVvM1wYnm3lj6GeJPWYqHDuani6kjgR3fsf
	GoQzwECs/BaBHkSF8X0pT1lwf54DdboDcyKqJI4zyoDngG3rM5votHGZayS6jpHGbO0A3b69k2k
	nRaoO0jLHdsI2I+XjfR4S/kkFC8AlbWrk7apRRGXfdsEYKbqLoIZsw287/v9KHKti4aBKzbvMb1
	lGbnb+9ae/7kcMysJDRXH6C1leGsa1v7HQLAlMo4A+mjfCj70aW08rYaHZa5JelI9HnKDJuLi14
	lfsaBllm7yQoBlWMRl31XiTPhHHWrGMTjYtybVdIVrxyxeVyikNqnz/3RybFtDQ8h2NJWlORzBm
	H7bx+greqhPTrDZRevq01gTlkcyPTphDET9LsvBS5lMyBHmOOUeFZYsvKJpEQEd0JMYQOXp2wjl
	Ql1XOFzy2aFZGpB0AwmEK0+8685pLQi8c/Y/XKtJZWtkYJOKaw3MtBZRPddqpNheM8TN00THEv4
	XNlxWg=
X-Received: by 2002:a05:6a00:1382:b0:842:63f5:d097 with SMTP id d2e1a72fcca58-84fa17a23f7mr2545543b3a.3.1786409024704;
        Mon, 10 Aug 2026 17:43:44 -0700 (PDT)
Received: from fedora ([216.236.36.152])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbed8e9f7f1sm22282a12.28.2026.08.10.17.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 17:43:43 -0700 (PDT)
Date: Tue, 11 Aug 2026 08:43:36 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	jv@jvosburgh.net, shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: bonding: disable DAD for IPv6
 addresses
Message-ID: <anpwOGpAmEhWY-60@fedora>
References: <20260808162345.2442594-1-kuba@kernel.org>
 <ankxIiVLu3qY5jw5@fedora>
 <20260810111450.176b34d6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810111450.176b34d6@kernel.org>

On Mon, Aug 10, 2026 at 11:14:50AM -0700, Jakub Kicinski wrote:
> > In this case, how about add nodad to all IPv6 address setting on bonding
> > tests, e.g. bond_options.sh, bond_macvlan_ipvlan.sh.
> > 
> > After that, we may event remove the sleep time in bond_macvlan_ipvlan.sh.
> > In my local testing all the macvlan/ipvlan test passed with nodad set.
> 
> Can you do that as a follow up, please?
> 
> bond_options.sh is the worst offender for flakiness right now.
> I would like to squash these flakes ASAP.

Sure, and in this case

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
