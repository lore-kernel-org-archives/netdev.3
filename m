Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EBE1AA1F4
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 19:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499776; cv=none; b=V4WHa+DVAb27mFJW4Q0lctDMsOfcNei5HYX1TMMEnmFSga83l/KfmbFt+nj9gBWnHC934JX2WC91B4T/+2Qpoif0TP7Ep8kxB9zSE/nb3vP+DjkrmAJBtOY4Gu3Z6q3M5E2+3VDEcnxFiKRUC7v8LGc9tWv3jq7EQC5whlK8/qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499776; c=relaxed/simple;
	bh=AGk4y8oFpNibhByHKIxcRS7KnQx6z20Q8VC6dFl1tNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NmvhFL/XHfHxTdIcfHYHEnvIEe36EomyMID1cicsVVydYj22dD/rtmPDZy9qUEt2Zk318Y6YIsYOJQnuq48+s9eSztwgY0+mq3QKIm6oKkhp6nstnTRaOhIuaxw2Jy5ajnX2u+lw2lUzHLUaZZlPICFEBnJaVHObRQUOHmwqGC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=b5z68MKH; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b5z68MKH"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b74e0c2e4dso143462e87.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789499771; x=1790104571; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XFFk9jJtDswBQpA8QWIooO6lLG4HdlvPT/LqykRjG+U=;
        b=b5z68MKHW6JZHxl/3IWnaBLsKTEVj7k7Z7nWzPI5kykGCFMStWoq+8w6tDXqDIcaSc
         J4Syp44C0/oJ1ObVd6GGqaN91GwgWv3nw0HqKEjsmWrEh7/5RltgG4jfmTc549qGfEoK
         G4hshk2B7LoblKRh3x0PXrlwbOHjYPwXtBAYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789499771; x=1790104571;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XFFk9jJtDswBQpA8QWIooO6lLG4HdlvPT/LqykRjG+U=;
        b=mz6HyWCUxitCT64PmS6l6k973RAXGh2pimvls6uV3MxliEArgEs3Gvu8ax9SP+tW5C
         Vwwv4YFjWrSQzRWnXebF+MfDpRItfupxFN0psPwucQGh1jzduQIEP29MZ1ezyScJiuIe
         g+joBNXr9iKXi28iMA25e0VF5TAyb36awFSfmyWVZxCO/E2dUk9sM7L/Wj8KA4ciBxsP
         YKvojffHGfhuBAixKLddLn3h7s0eWFDQwJZYYRD+VcRvHfHWm5KAtD21hBPseQ8moMPT
         LYnfgy9dKxb8YcD1eQNPp9gN04CXbG9E3eOK4bXoD8FXAd7hatdEylMljoL2uIoFvlW0
         6LEw==
X-Forwarded-Encrypted: i=1; AKwUvBxdx7o64niRiKsQMVlBBBArNYjet86+mBEWBwGxpD9a9cN3wkz7Od8x9l613qJCyp2KkAxoORQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kE4nI2IwLz7vEn8uuEF1HCyo1uHaF3W4eakBsVWkF8o1n7JRHo
	LmXkXjm4ssUwEIj/nkF+M341jk8xNnf/ZrSsHoDuX883MmyM2AG9cCmOOss89t85AfTWLXDyfwj
	m22BRMXtJhnxh
X-Gm-Gg: AYBFou0K7Rqhe3axOU8l3+d9d2cipV0uZBk63AOv4mL3OEA8ervr4lYuoDygI1QcW2/
	3+REWoeHM2p/fozG2G/ls0O/41uTYaRwVl13BrQLBM1wnO2Q9Liv1QRB8CiHOLiPZKsLVTxsY8L
	ms/NTksbkIb0nVcngcRhFZmDAvi9ETr7w0uy65lB+kHd2BVoC0A/xWG4SjPIDxOBk2jolYAWS9G
	yCO6TcbV0GV+5id/x7CcykpUEqnYRHONfwnvhOlf/GHIzYh7mvZGAD7Q+LTqcGRNUilDa5S4rcy
	c2QfrCB0tFbHx4/Xot8kGIoo22wwSajalOxwhdc86fUfjX6LdBpMiee1qHrUId5LopQsmYndpj/
	J/STiBVUu8eLhH05uhd/GlH46/UV4wFSVGXpNowsLdUsp/E7MN8uR/pE+ExtaAIdDX0LT1dMckw
	o+GHoESPZvwXIRrzn+puNxXK9eA5ybden57hM3kCKJTTx8JPIH8MLcl516oBHg/YEFulFd7lJEd
	0IbzSuJR4ct7dpfse2MP6K+kC6ErHBy6LmfFq+cXl1IB7gwDB8juU0krE4G
X-Received: by 2002:a05:6512:3052:b0:5b1:58d6:4542 with SMTP id 2adb3069b0e04-5b8ae6982e4mr4309884e87.14.1789499770644;
        Tue, 15 Sep 2026 12:16:10 -0700 (PDT)
Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com. [74.125.229.204])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8b57e0eacsm166031e87.61.2026.09.15.12.16.10
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 12:16:10 -0700 (PDT)
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f15b7aso108254e87.3
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:16:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxstCMtYEm4NwDHRgcwo43b8k/yor1dPk29TxFQUXn+ZGtNpxvteKJlRFIQzao5O3mW2ZWfpXQ=@vger.kernel.org
X-Received: by 2002:a17:906:7309:b0:c25:47a4:fedc with SMTP id
 a640c23a62f3a-c29b839a057mr1176039766b.2.1789499355710; Tue, 15 Sep 2026
 12:09:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
In-Reply-To: <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 12:08:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
X-Gm-Features: AcwNN1VCm0LMG7z3Jned014oJh6WBcf4uOx0OBk98_hrtHKbrhcQiMMJ_A-fmB0
Message-ID: <CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, 
	David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Sept 2026 at 10:52, Jann Horn <jannh@google.com> wrote:
>
> Is this mainly about stuff like "we installed a file descriptor and
> then the following put_user() failed"? Because if so, I think a nicer
> fix would be to have a policy of "if userspace provides unwritable
> memory to a syscall, just keep going and pretend the access worked",
> and maybe have a sysctl that kills the process when this happens to
> emphasize that userspace should not be doing this.

We've done that before, where we just ignore put_user() errors and the
user gets whatever the user gets.

It is maybe not optimal, but it's fine. You can find quite a lot of
unchecked put_user() calls with a pattern like

        git grep '^[[:space:]]*put_user(.*);'

and some of them are in core code - see the two in kernel/fork.c, for example.

One of them says "if userspace has not set up a proper pointer then
tough luck". The other one doesn't even bother with a comment.

The scheduler has two cases too, although one of them is admittedly
for another error case.

So yes, saying "if you pass bogus arguments, you get what you get" is
a valid model. It's perhaps not the *preferred* model, but it's not
wrong.

It *would* be wrong to take code that already has error handling and
remove the error handling, though.

                  Linus
