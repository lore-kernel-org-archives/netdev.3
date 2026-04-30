Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7CC46AF16
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 16:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566341; cv=none; b=lTEIpHUXPZYv2GbqK0IxYLk9Z3jaT66VKUxpaGPvXf2XY2VPzIdWJBvbyCadFrs4IB7rGGF3TjFCb76AcCCMubxVweryqQOvr+jBdDBItekGcvIVBzL9M6KmW/pDM4T5Hbk5erjc6eeDNkx9dDh2gQCvbTeRmVean8rFFbFdCvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566341; c=relaxed/simple;
	bh=8PUZzr9WoqYVnOdEOehfl992GyTKDX4gQB+f2aatRuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rocerPtM2/Ku8YLVLSxtmZeh/rO908hX4bEdlPQ4V9xn/EJtUOd2BB9DART9fuka+p9OXOy62O3CD4RB6QyCTXUPfcWynNbiJ1Ss25hbpPTd898WYJATY0egCzHmURc+HbPjzFj4UvfNukdPUTGwORO3bOU4iAmsKrhLuM7Q9L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=MTnC6gsm; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="MTnC6gsm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Type:Cc:To:Subject:Message-ID:Date:
	From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8PUZzr9WoqYVnOdEOehfl992GyTKDX4gQB+f2aatRuE=; t=1777566339; x=1778430339; 
	b=MTnC6gsm9DVmnDo5EXWTwA99XepVfOkStM5FqCXJD/jbKOSMZmVPPidH4wUm+rfavceO0amz/FY
	5TRbAnmLmY1hFhdhwJtvCXTxwhQmfH8YsmuEZO+rYpq0hmOXuLFdyaM6l6rYjAMr6Z8QBAVxrJd1T
	tWIy0mRnN9YAJ1hUydbYn4NTZMo0LAlgUjmutLhjcuu91kPbpKFWJKBWP4QE6x46jnkFz7IIMvdyu
	xsuGbzZaWujuED5Gg0/r56UlUUDpIMrN8SV0cXlWoY1NasQoRwmuUei8EYynPHdVDBzPw44Sntlqk
	pDUE9YL3d3u8ig0mfxayK2K2IhPmtPDGC15Q==;
Received: from mail-pf1-f172.google.com ([209.85.210.172]:54737)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1wIUCj-00024s-49
	for netdev@vger.kernel.org; Thu, 30 Apr 2026 09:25:33 -0700
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82fbf5d4dc2so846757b3a.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 09:25:33 -0700 (PDT)
X-Gm-Message-State: AOJu0YxIKRK/fLp+xuwtZsky/MIHxDeRvcF7Y6f0bRT18DLR5kEprOzk
	WvCq4UK8+LLoBMnCUZQUJ/vOwfixIrddcWyTmKxzApXAFToCfiWJo7yF4fZ/P9f7qKT90AgfATe
	nsOKguyhTIuNDvl1VJBn29EhWSEHi8Kg=
X-Received: by 2002:a05:6a00:2d1a:b0:829:86aa:e163 with SMTP id
 d2e1a72fcca58-834fdb34fb8mr4072480b3a.13.1777566332797; Thu, 30 Apr 2026
 09:25:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428231520.1857-1-ouster@cs.stanford.edu>
In-Reply-To: <20260428231520.1857-1-ouster@cs.stanford.edu>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Thu, 30 Apr 2026 09:24:56 -0700
X-Gmail-Original-Message-ID: <CAGXJAmwuqj1YFSgwMwBfdjofEzC8nU2X_zv3mzq6by2K7mGufQ@mail.gmail.com>
X-Gm-Features: AVHnY4JZL0Ei6SKDw1V2s212upPsYlXN-0n3L3XvCO3BXvIeWXKU8REN0kCd-38
Message-ID: <CAGXJAmwuqj1YFSgwMwBfdjofEzC8nU2X_zv3mzq6by2K7mGufQ@mail.gmail.com>
Subject: Re: [PATCH net-next v19 00/15] Begin upstreaming Homa transport protocol
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com, edumazet@google.com, horms@kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Score: -1.1
X-Scan-Signature: 946122a1693bfdbb49d371411bb557d1

The sashiki-gemini review has found a bunch of issues, which look
super-helpful (and a little sobering at how many there are :-(). I
will of course address all of these, but I'm wondering if there is a
recommended way for me to respond to these "on the record" (analogous
to responding to emails sent by humans)? In particular, there are a
couple that are false alarms, so I'd like to do something to keep
these from reappearing in future AI reviews. Any suggestions?

-John-
