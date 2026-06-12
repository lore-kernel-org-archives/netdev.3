Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F3437E2E4
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 18:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781287957; cv=none; b=ViSHWy0iOGugpKGK87W62dM0+WeOySMIMlmGV41kEyxdWpLcIL+lzC5yXzTTXKlzVV1GAFHKE9ZdKNUM2r86ZTsWfE6Zk4y6q5cRe6fNC3ouSeChIaPsp/hdMSvOP/I60ocWADCigZMIGajAQBXg8kvFJqNUlBrIBFE8ss+34Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781287957; c=relaxed/simple;
	bh=xsKHGFzTmUa7CrdAiyWqZLLJnKuuUSFv59b4DgwLtO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtCmzANv4/SustIUwbTe+CqfarT6jQ0TW3z0pP2EfRObVpy3ubDeVT5CuUNhWHvc/UbUHgCXvk+W6N9n+bT8R951tSN3be6Vjp/xA3hH9TcUyi6UgowCv0zWKS6SH9A8LXK3V/oMfYq8QnqDcJGuF6Epbrxg96jOrBUP8PfO5+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io; spf=pass smtp.mailfrom=multikernel.io; dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b=AuZiA2Q/; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=multikernel.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b="AuZiA2Q/"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30749947917so3836975eec.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 11:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=multikernel-io.20251104.gappssmtp.com; s=20251104; t=1781287955; x=1781892755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vCqXknT90WE+KHAm0buCIQ/4ggUnZYZuMIR/rS3y26E=;
        b=AuZiA2Q/uj3Y1K0kVA2F8ueXGZJDebff3H0NLldihOdT3DT+p6GGhkdTx7hUfyhndC
         wgM8rJdBDinOFqsXnd0LIyBZWLIjfdhqPsbtZqibq5KShiwENgxpg/oo+nT8T2tW2SD2
         2X22T83wy3HgVD6d0aRByzferuwZbaq9mlU0wswmuV0ng8+lEPyc2rJeD4l2nctaR7FA
         EuNzCS+TlII99P5vsIA4BEzvse/qsTmUMIRTTLtRk3a45a8ZZ4CXWJ6fStWmoY5pRHzQ
         kdy7OvHjtE5suNDNP4WNdbKTdeI6Tbo7b0RHxEdkuqsCcOEqAtHDruTx6WYHCs7GtN5F
         nDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781287955; x=1781892755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vCqXknT90WE+KHAm0buCIQ/4ggUnZYZuMIR/rS3y26E=;
        b=ofVF8fCE0N1w8hIfpyRrYIWHS4ua5RB7P6UG3QHHRVFs6U8JAMpEyC6sr9agwGsySg
         dnHmxGLRdOu7/etQNhAapKV7ITucHOnDQe7QWwD5kNh9mXW6e09908L7zfHrGT9hNyuu
         fipEZcfmAokapp7AbBVN1Aj3ym65BkOryhnZ0R3+Cn5/EWIuJZ4bfwtfRTDP7ei8X1uK
         ucP6r+tWcY83EAucUkFfMi7DF7LPvPOL8zhEGUPFIZh9G1r71OvC9mpdp5ZxCSTUedot
         mXyjsheXLOcBQcRKeTKmJgVHUwH+K7k7CUnup9pV/kawUXLnPbg3d4ILjY6klxfQAfGA
         c5Rg==
X-Forwarded-Encrypted: i=1; AFNElJ8q0PlikHxttFuZo/v3hpjsUIE6hf4PILzv4eHn2EFbubI/wBKNOgE1/7/aflCtldvSmSBNp9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0l38lVQeVW9eW1BMKHLGxXu/Sq7B05Hmmw7OBZUvfGXWGeMo8
	3rqfsb04jgOmUKHEzu1B2EwP1HlQfl4+nB7XrFr3v5oXTstnvHULx9A1wsDWOIRAOQE=
X-Gm-Gg: Acq92OG6JUjTOG0SYQyjq5FXN+aDXnwxWtkE3H3fftivM1udMlwHKP4z736g1hI92zX
	41YroAUTIRIuO6m744XkUDiIBm/5gen+cnHELB7jkbUdPE8p8eXzu6cRUm4c4c07rmluHMVV6Xm
	lgyHhC5NBtogH2/ruVViAVHg/hh3x96sy3+F8X2rcWINGs5jO/PVZazMv1KT+4iHVrnBtf3VPHC
	09s7q47BFSNfPgb4uNYypf+YLJTe63mgvyhoWOm1FXCYcINAj0gJzIISXpM20rgUa2uOay6F/3/
	z1qkDP+UtsjmFDeHUTdYIDBgFmA8uEmVYT/8oC0/8UhRnb5wi1GJ3kF4+7I+GPjUMssHDeO3siA
	1ai1mML2FlV5ek8iw0urRv+4unPKqZcim8ahcMG769kd2ziz44SPN25FiEZeurWJFkfmdwdFOiB
	Ic+byGWChucXRZScBD3HhPG0FktUQTOFkWgadj/rnqP0u+3I43LNOxbQ==
X-Received: by 2002:a05:7300:3b2b:b0:304:e2a5:689a with SMTP id 5a478bee46e88-3093ec3e358mr457749eec.21.1781287954932;
        Fri, 12 Jun 2026 11:12:34 -0700 (PDT)
Received: from localhost ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e91f878sm4289832eec.17.2026.06.12.11.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 11:12:34 -0700 (PDT)
Date: Fri, 12 Jun 2026 11:12:33 -0700
From: Cong Wang <cwang@multikernel.io>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Hemanth Malla <hemanthmalla@gmail.com>, zijianzhang@bytedance.com
Subject: Re: [RFC PATCH bpf-next 0/5] tcp: opportunistic loopback splice for
 BPF-paired sockets
Message-ID: <aixMETjhANSYBZP_@pop-os.localdomain>
References: <20260612011452.134466-1-xiyou.wangcong@gmail.com>
 <CAADnVQ+KTNKkf_Tc-RZR-g8wEfJU4qWcOPnjDbA2=PEtZsYnYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+KTNKkf_Tc-RZR-g8wEfJU4qWcOPnjDbA2=PEtZsYnYg@mail.gmail.com>

On Fri, Jun 12, 2026 at 09:01:43AM -0700, Alexei Starovoitov wrote:
> Just saying that the code is free nowadays, so whether it's 1k lines
> or 10 lines is irrelevant for the discussion.
> 
> As far as the idea goes, I think, it would be interesting in pre-AI era,
> but today splice and friends are a prime target for bugs and more bugs.
> skmsg and tcp_bpf are reeling from unfixed bugs too,
> so my take is that we should not add any new features to skmsg
> and instead deprecate what is already there.

I guess maybe the name misleads you, it has nothing related to splice()
syscall. Its ring buffer was developed on top of include/linux/circ_buf.h
which again has nothing related to splice()/vmsplice()/pipe().

In case it is not obvious, this patchset does not add any new user-space
interface, only a kfunc which is visible to only sockmap eBPF programs
which already require CAP_BPF privilege.

If you have a better name on your mind, I am happy to change it.

Thanks.
