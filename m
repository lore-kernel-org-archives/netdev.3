Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DAB477285
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 22:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788303595; cv=none; b=sN930Li/4XdeYJOod9F3h6yTLNBrW0sS6AMVcy7QtroDbtQ7OQTCCW+S/0A1YcfooMK8yzoDeUb60ZOb1jT8CQp15/1C/gxWW8FnVyLpmI4mscyNvjFIjEF6JXTfRQqhvxH6v1WFJHqVT1kxk+ILArUvCd9SlR8voVUlRZ5dHK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788303595; c=relaxed/simple;
	bh=c18F6yK9QQALIK8vJ9HFY7VBM32lgpTfpHbGKOYt99U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G3uCKotlWs63dXaT13HsKBLlhwXW9QYRyF1sWsk1f41rghSZkr8+ucTEPI3egfiTnL2PyUGlZh+GuJxhN1l6KRI4lAqANTOMCTF3OlWPajXEnaQxiGXzLsOtyI1FFWOx/KDgGagwScWY7A2cHioua2g/XvZPtnZRqwGQhDRu5pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUtB35LT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUtB35LT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509A91F00A3A;
	Tue,  1 Sep 2026 22:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788303594;
	bh=i9A5bcOobHTmbIMqYGFGYBa+fEB6nmE3jD+Uixfyvds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OUtB35LTUGDe6xuKexifpmmNt3ZGDlzMAbH7YxF6wiP7UJF78jNr32qBG3JCT00hj
	 8qSWt5/o8drSYnRkPNvr+ZyoEDLa6/fHCJ4W0bvAq51zXxetvHpV7/AG3IFFYScCPc
	 ipqPHbTroq/I8IkXV/kHB8c25w6QaLrxtOjpURn44c12TD/LUTuwwRroS9KM41lnhT
	 EMmpQe/I3QRKrg6ec0RqXdlCEVkhMqgF9eH4EG2m/9Ee77Kc6npZRjDLEPLcayBP7/
	 doZgbCOQTUIeISBLeFAGiN+qg3OfdyQzT24VZm55u9wthfn5HB7G+hVxvQM/hg8i64
	 VHbfWDEggfOFQ==
Date: Tue, 1 Sep 2026 15:59:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
 edumazet@google.com, jhs@mojatatu.com, jiri@resnulli.us, horms@kernel.org,
 vega@nebusec.ai, netdev@vger.kernel.org
Subject: Re: [PATCH net] net/sched: cls_route: free emptied bucket on filter
 move
Message-ID: <20260901155953.77160c65@kernel.org>
In-Reply-To: <CA+NMeC95jnvqA-m7zTyUX4qmuWqDL-w=Ftx4GaAmXig_2uPjxA@mail.gmail.com>
References: <20260829205422.854785-1-victor@mojatatu.com>
	<20260901095101.124563-1-pabeni@redhat.com>
	<CA+NMeC95jnvqA-m7zTyUX4qmuWqDL-w=Ftx4GaAmXig_2uPjxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Sep 2026 18:50:00 -0300 Victor Nogueira wrote:
> > Does that leave two filters carrying handle 0x10002 in the same chain?
> > [...]
> > The comparison itself predates this patch, but this patch is what turns the
> > renumbering/bucket-move path into a supported, leak-free operation, and it
> > adds code immediately after the faulty comparison.  Would
> > "fp->handle == nhandle && fp != fold", or rejecting the handle mismatch for
> > existing filters as well, belong in the same change?  
> 
> This is a pre-existing issue.
> It is a bug, but I think it's more orthogonal than Clashiko suggests.
> I see 2 separate issues:
> 
> - The leak (which this patch fixes)
> - Duplicate handles
> 
> I don't think this patch makes the example Clashiko described
> "supported", it just fixes the leak but leaves the duplicate handles
> issue unaddressed.
> I believe fixing both in the same patch would make it look confusing.

Let's fix it in the same series.
