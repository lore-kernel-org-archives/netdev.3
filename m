Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEC1486418
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791053176; cv=none; b=CNU5BuEbYS1O1DrfA6KuAzAcBPgGC7FBwHPTmSOiYsa2QBUq+HsfULowiSEbmEnOHGwnBSUPfejQ+XN3pyz29WJvyU2RdzcM1j3qkRlt5NchiPtV/K/wFd6aKBxs/x8pex41KouH+rr9Wrs6FbGRe6ghKcotTCOtuNNpDDzIYAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791053176; c=relaxed/simple;
	bh=TdeI1jHcz/DZ9T+ALMJwppGoXJd/Ogxs8TYiyl0iTj0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Lo1CeX633u6nnBSIw3nNVWx8BSElfo9q5VdyK/8ushxEbF5ItJ5kgasFFMxd/ADshjoePdpF7lhFSYtA3qDMcTZ6t9hWJbH8RPzu8H1L1C/rPun6R3tsWBhekAIbLIcBy+5Fovs3HvRvANvUpw8TFIJN9gzg3BcsuaOXFxb5Z1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8FqYQtP; arc=none smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8FqYQtP"
Received: by mail-yx2-f41.google.com with SMTP id 00721157ae682-8ab4b4f3d6eso1261707b3.0
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 11:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791053172; x=1791657972; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SmgR42DPnVIlj/6LSiKR4eARyjhZD+RPX65Tis5OYFM=;
        b=l8FqYQtPoKGQnJ42n4SfqeqDzCLartnvCxYMCPDTwNeB9wleFJ0s8FTboXDltfB0/S
         rL5LupXEbpA/BFh/+ElCxM9oUoClay5b+ZCRL3avgGQF5+nYvfqAdv0jVrnxMCEIwPSD
         yR8rB8fy9F6aSCvKrZvdm7eHx1Mj3GKt/bSWoOZCA/bDiKxua8rBgWAlAnjF1eOnfcyl
         pBYpnOzmSFLl9gvgnpHCbrCcaulj6MLR4EjV0URaJUsCiiJ7pEayAXMY8q5rjgj2pd2K
         AeRalynnQf9hML4Sdr8I6nbaODJ960ffFD/Aa2LTEOqJIKs99Mb++dQBoni/m47iaSue
         VUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791053172; x=1791657972;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SmgR42DPnVIlj/6LSiKR4eARyjhZD+RPX65Tis5OYFM=;
        b=p87yTjyDA2XrGMYoDrLBpxbneETttCoeVZmkmI41Mh5QVXsV4yQQMqtuhuv4WhC/L1
         JZKVPhb2p72KT/N6gnkTb1ytPeHZqSiwEyH5mzlzbkhgFyGb9naOtqmdv1qao8qHOQfT
         9K6L+mO288UhfrSj/p4tvW5Z9uw4LNlbn6xPYwyDqNwb1xatfJ13e8jMEPDZZU0t6Ysr
         FwKOCXQD4bZlH4VEdH8brlTPq15RkVgWvTUJiiVd32gn1XLslseZsozuPk6Ra/9Yc8fL
         a9kckvaRqd3dxjUymge24A//wKjTgbxARAS+rYzvtuGsdz31qAdZ3Kc3tD/IzhjuppYN
         /WPg==
X-Forwarded-Encrypted: i=1; AKwUvBy6EN7OCpws/Ae1j5ovh9ll8fQfC7w4glqBbn4A/RLCSJhSxlN7BSmtYtln6W7hmrWc4Yzx7kU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJJiOvDPzk5YKi35hWszYMqyPYJ+dEouzoLRrZem8tzjS+hEXcd
	zoU6kxLZsV48vCNHQneIPqb1lBSV1iiivJi6699JHTmnPTRe04/yEgMS
X-Gm-Gg: AYBFou2elc/nbHDpFU1+Hz/4tqveAB0LXwEdxwb9H63bH+8ljvaKOtY2Hp+aRKN3IoU
	VBCcWs9cK8hhOdCzDPJhhJR9lGZOP6FDCXZPTbiTONAU8ch/XGPeoZnQ28ocsd40jM4aiCXAcck
	qVOdJjmbXkZpqRY8PTqsnEJU9qEjUkkOh63PjTHUvUrgpztJcqOpAAW//r7sPmaFpTV65ie35p1
	kgsZ/TinmIEFS9VCQCGuNJlcbdY1xM5GAv7G6KwVpiN9FAhRhM7OUUSfaSJsyYhiiqjpvHWkKop
	mS329OlvU0cM2tVOUxBFcteNxI9vL2RIOvy9akYBnzeqoK2O4mfxaOjrWkGQAebp0EJxmE8dShT
	stIAvrul7m6kb1j6nSo8P5CkWJP2aGU15DTtpGlz4XTlNwgWdeQAxxd4Pghv6k1VcyBz3QDLVLB
	n8CgkjjuPy4tWqHKYbBoz0Di7ZKbqNLgrM+TMLYmEv4fkCjWj6U17VxHdcy1aZRhwpcPxAZhtcz
	sy86fIEYKMZmSCbDBF/EAMw+V2Cey9zepNOBWqEvAcrLHSUSw7z
X-Received: by 2002:a05:690c:9c0f:b0:8ab:36db:e30e with SMTP id 00721157ae682-8ae3a00e851mr27795997b3.18.1791053171761;
        Sat, 03 Oct 2026 11:46:11 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae321fa8a4sm22737027b3.8.2026.10.03.11.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 11:46:11 -0700 (PDT)
Date: Sat, 03 Oct 2026 14:46:10 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Rongguang Wei <clementwei90@163.com>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 jasowangio@gmail.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 Rongguang Wei <weirongguang@kylinos.cn>
Message-ID: <willemdebruijn.kernel.5a6a2141bfd9@gmail.com>
In-Reply-To: <20261003063859.136895-3-clementwei90@163.com>
References: <20261003063859.136895-1-clementwei90@163.com>
 <20261003063859.136895-3-clementwei90@163.com>
Subject: Re: [PATCH net v4 2/2] selftests: net: add TAP socket filter attach
 tests
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Rongguang Wei wrote:
> From: Rongguang Wei <weirongguang@kylinos.cn>
> 
> reattach_filter_without_user_buffer() attaches a filter, makes the buffer
> the program was copied from unreadable, detaches the queue and attaches it
> again. It then attaches a second queue from a fresh socket, which starts
> without a filter of its own, so a clear IFF_NOFILTER shows that the filter
> was installed again from the kernel copy.
> 
> attach_filter_bad_len_keeps_program() checks that a rejected
> TUNATTACHFILTER leaves the installed program and the filter state that
> TUNGETIFF reports alone, and that a queue attached afterwards still gets
> the filter.
> 
> attach_filter_nofilter_flag() and detach_filter_clears_reattach() cover the
> ways to attach a queue without a filter.
> 
> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>

Reviewed-by: Willem de Bruijn <willemb@google.com>
