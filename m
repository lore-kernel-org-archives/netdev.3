Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D565F51C071
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790874307; cv=none; b=HFwOcJe2Ykysi92DOH7u0GrcgH+SrrqZUSv9kGcBVLJKTEyLnmVp6SDkBzsWxTVWU/wD6E9t+Lh+271Jle7Gj7ebKCzikXUQRvSTCJ57gQ0TSlfIrDlA9R5c2Cmk/+OyC1+ro66YWKLUhhlfDyZHtY9cwm/3JZk9oswPf+8t1Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790874307; c=relaxed/simple;
	bh=YcQDuTEhiIHLPGehWyOnNgYb4N2LsAYjJvT2wrN5O+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IysCjubTGeQYIlcTI1NY0bBSOl/DjCUZ28yUgZL9sMR6BuMb/H0bMs6jWHvl2dDHtlffgTkawRFySb1wPRGVUwcHmSG2qlx7zxlwvx4kG6dwC9m2dqje/WRoNyEFS9xteJLnKz4G8DX4LwybYh1YBhMkINebwu13iaQaH/mu/P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oK36QDXw; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oK36QDXw"
Received: by mail-pj2-f11.google.com with SMTP id d9443c01a7336-2df834eb96fso36390355ad.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 10:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790874299; x=1791479099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=stLdMF1HFFKlJP7EW7qqWefqncCa7xTHqwJgtpV2KKY=;
        b=oK36QDXwlyYFp3GbVh4y8K3gebagaXmINoLaZQ3FWKrfZ+gk4OFlMB7lqqqa7dAz3D
         yT7EVtHcIfWZtb0cMoz6eVm5u/Hs4mzIQboiprjSEMGflLbrFqwxqeTNMvHRKFVZBZLz
         L/+QcVf43Kcth4wZ5bL3Uk5pvKKt+CskaL8ObhU0xv3x0Nb7A0hk8cqgMnHff40hncaz
         Za+tlVKn53xZ02LcfuACUgq3urwZnWi0CeoQJ0UV3RQvrTwULja2laXKbwb8iX9EIgHS
         +9ROdi5/P/OXl+c7qcR+ujBgQVx6Lnxnfi+43o+CGho+6WPDADWbRqTmtTUb6JzrTWz2
         u4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790874299; x=1791479099;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=stLdMF1HFFKlJP7EW7qqWefqncCa7xTHqwJgtpV2KKY=;
        b=R7o1L688jeZSPT2OcVwVsu0QXPVKv/boV+z82W1r1DjZbCgpHDn4JamnfhrB6xTmXc
         RDok4LhRw0nnJ3Ng8qDjGYFa6vzvqaJq/U0NqCdmkXx9UD8BDkYn6iqInJJNyv9xu5aU
         /3cFidX02pLimLYEtXlv3gZH7fAglS/BW4aJb4mM5gTuFmIK5XQv6atSEw+l4BJXObRJ
         +lTyr3sZrBJCPC/qJwaSixKk8QyVf43pyFJDDKx7vhtTct6plvtDlF5MkASlQvat4xkf
         LpJ2nwzZLZiHMLck27mAD8TTTyDzNEDu9uqg6zUJXhdWO5GRJ7b0yTfvfTFbIGTffBMF
         xFRw==
X-Forwarded-Encrypted: i=1; AKwUvBwX9xBlkojQUVxauuIN3p8CEB+EF+6CaisJqCny7S86mq9L0sJEOmg0ksCIVzNlKHbv81kLMxc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJrs7KzUoviXsg7fYBj7HWgRABNavQnHpkK/d9LkGsOI3Pg7pit
	iXpAtqjhEZE//l5d5iB23Fi1Ll8MjWuRdvUNkpDp4BNWM3VaIcQOOwZt
X-Gm-Gg: AYBFou0HTDAKvzsdfhoY7a2L6GJUz/QQLgvE3bsQeJpO610jBaZnLjyFvFeu0rAj+Aa
	gvCC+4XDox1Il/jh5gh2N4aAKqKEF1bfjyI8HlqIQyR7G7g2+9c1MPded3/QL45beo730JFYeoF
	+aHJlKIUO/It+r94cUCDDo8gfRTXg0omvYoajXi9R9V2KMXeuBGGeZyPEviWz0RQ5zHnHT6TW5r
	eAS8ljfTP2xqUq5FVRVLjq/332JRsI0kTlcaskVXtwQQyLoID7fsAEKOItU1IyCQ0j0aYppHU5X
	dXtdwVQnIxoR0nIWBb7xYoQcJUjEN6vVSVgr484G0h628XQArxkzP7C+2c0CGei7xYxf8uqSUAC
	NN0QKjEBPC2sk+XnAqgRGKC/hl2PeBdkKldjkZvpyZMzyJVzONdceOSn8CABdHjKfbSd0zlDj15
	VuJCyk5Jrurc6g5yeWXHDaRjdYgxYuFF3/H9GBv1AZk7p4oKzOPlgaF4k4+6auZCThxl3JX5Kce
	Q==
X-Received: by 2002:a17:902:da87:b0:2df:7fe1:72b8 with SMTP id d9443c01a7336-2e49b64e34bmr641665ad.16.1790874298566;
        Thu, 01 Oct 2026 10:04:58 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e300b06afasm13879785ad.49.2026.10.01.10.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 10:04:58 -0700 (PDT)
Date: Thu, 1 Oct 2026 10:04:53 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, ap420073@gmail.com, 
	bpf@vger.kernel.org
Subject: Re: [PATCH net] net: make dev_xdp_sb_prog_count() see programs
 attached through a link
Message-ID: <ar6SryEPDgA25zKA@devvm7509.cco0.facebook.com>
References: <20261001012559.297751-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261001012559.297751-1-kuba@kernel.org>

On 09/30, Jakub Kicinski wrote:
> ethtool refuses to enable tcp-data-split on a device running
> a single-buffer XDP program (which can't deal with the payload
> landing in a separate buffer). dev_xdp_sb_prog_count() only looks
> at xdp_state[].prog though, ignoring bpf_link integration.
> Get the prog pointer from dev_xdp_prog(), which will consult both.
> 
> bpf_xdp_link_update() needs a bit of a touch-up, too, since
> ethtool calls dev_xdp_sb_prog_count() with just the instance
> lock (for ops-locked devices) - we now have to make sure the
> link updates happen under that lock.
> 
> Spotted by AI while reviewing the XDP propagation series,
> verified and tested on netdevsim with a C test along these lines:
> 
>   link = bpf_program__attach_xdp(prog, ifindex);
>   system("ethtool -G eth0 tcp-data-split on")
> 
> Fixes: 197258f0ef68 ("net: ethtool: add hds_config member in ethtool_netdev_state")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
