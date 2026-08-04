Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E500941D20C;
	Tue,  4 Aug 2026 08:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833072; cv=none; b=V+/Ho2BqkpP7nqUGfQUQ5nTZYpEEr5RJHExdl2AcEq3LMqZR8fTm8IRj2biWblUHZEf54bzdb7ZhdPj1tNcJrh1B4kTBP7hOYBWchUqDwObTvjcZNV/HkTCaBbHZbGvykutIkXMthyz4726j6jLyNbAGYdPVFryqSDvQbjuBZvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833072; c=relaxed/simple;
	bh=OT3+foCGo7aKyCUQZURjG8OogfJ5e5a51HxQO/NFW5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3pfwx5nMmGxoJBAxNWE7XS83HviHd+yjeIW+OI7Y6p+KAnzCFnvc+MWO1npP8ZdlAaunM3npmmzyKu1H9RBg+7+N8keeB2sKtLqa2pXs8xFiSIPnFp3y3khxnRNP6qxM+p7unV/DL30G7E1aqJepfgltHzP0LykfwXnwJn21o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oj09pSEn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oj09pSEn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930F51F000E9;
	Tue,  4 Aug 2026 08:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785833070;
	bh=eWvmrmCJDGo1lxE60w8dVMIzmS5KyDLB9bo2sNqG5Ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oj09pSEn2XCHi/UftM5Ok1TWmx0Jv4cXkt2c2IjvkzHEyaxfSxK8UJRCFSUpsqoRb
	 t9iR70UOz1n/DVt0uZjKHygTNSED5Rpe527CDPL4t0AHiZ6HQwK28SWfw5d+2Qhyg9
	 fVhQTtqETVuDD5DmMoJA+1bS5NUIhMehrGpSP1XbcakVStpvI77KFcExaIJQqaobVv
	 e4CTRCN9BV853t50S8FWraRuHQvBcljoSPvlyNKwnuZkMsV8ZvHhG3cW7srLW8DfAC
	 x6TqQO0wBpr1jXvmp1aaufIIPU0aM+zGcugmzm7A3VycxmjUrzGoV+dAVEDb75Wo02
	 bt9QY8xxjDPMA==
Date: Tue, 4 Aug 2026 09:44:11 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	dave.hansen@linux.intel.com, Liam.Howlett@oracle.com, david@redhat.com, willy@infradead.org, 
	shakeel.butt@linux.dev, jannh@google.com, aliceryhl@google.com, arve@android.com, 
	cmllamas@google.com, christian@brauner.io, tkjos@android.com, dsahern@kernel.org, 
	davem@davemloft.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 3/5] mm: Add RCU-based VMA lookup helper that waits
 for writers
Message-ID: <anGmUrVVabSqWZq7@lucifer>
References: <20260802215459.2769283-1-surenb@google.com>
 <20260802215459.2769283-4-surenb@google.com>
 <152ee467-b5e4-470c-ad95-c638aa9986bc@kernel.org>
 <anCst8u7ybHf39n8@lucifer>
 <9c301dd5-76cc-40dc-bbab-a79559d6db1a@kernel.org>
 <anDBVu0PIzy7dks-@lucifer>
 <CAJuCfpEYFs94heKZn3hikYuCJU3CEHr2u1SSxXMyFQwHHAcjDg@mail.gmail.com>
 <6af71dfd-37b0-4489-8b7a-63478c8fdd4c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6af71dfd-37b0-4489-8b7a-63478c8fdd4c@kernel.org>

On Tue, Aug 04, 2026 at 09:59:26AM +0200, Vlastimil Babka (SUSE) wrote:
> On 8/3/26 21:13, Suren Baghdasaryan wrote:
> > On Mon, Aug 3, 2026 at 9:44 AM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> >> Agree this is worth spelling out in the comment (I raised similarly).
> >>
> >> Maybe something like:
> >>
> >>         If a VMA exists which spans @address, return that VMA, read-locked.
> >>
> >>         If no VMA is mapped there or, very unlikely, a reference count overflow
> >>         occurred, return NULL.
> >>
> >>         Nothing prevents VMAs being unmapped/mapped before or after the VMA is
> >>         looked up, if a stronger guarantee is required, take an mmap lock.
> >
> > This last statement is true only if the function returns NULL, so I
> > think it should be in the same paragraph as the "If no VMA is
> > mapped..." sentence and prepended with "In this case...". So:
> >
> >        If no VMA is mapped there or, very unlikely, a reference count overflow
> >        occurred, return NULL. In this case, nothing prevents VMAs
> > being unmapped/
> >        mapped before or after the VMA is looked up, if a stronger guarantee is
> >        required, take an mmap lock.
> >
> > Does that sounds good?
>
> Yeah, thanks both!

Agreed thanks!

>
>

--
Cheers, Lorenzo
